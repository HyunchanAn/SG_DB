# SG_DB: 세계화학공업(주) 데이터 자산 및 모델 가중치 저장소

![Status](https://img.shields.io/badge/Status-Data_Warehouse-blue) ![Database](https://img.shields.io/badge/Database-PostgreSQL-blue) ![Access](https://img.shields.io/badge/Access-Private_Data-red)

## 1. 개요
`SG_DB`는 SG_proj 파이프라인의 모든 시스템 모듈(001~015)에서 참조하는 마스터 데이터 웨어하우스(Data Warehouse)입니다. 
기존 `SG_proj_004` 모듈 내에 혼재되어 있던 원본 데이터(`raw_data`)와 데이터베이스 클러스터를 안전하게 보호하고 물리적으로 분리하기 위해 구축되었습니다.

> [!WARNING]
> 본 레포지토리는 Public으로 공개되지만, 보안 정책에 따라 실제 데이터가 담긴 `raw_data/` 폴더와 `postgres_data/` 바이너리 파일들은 `.gitignore`를 통해 업로드되지 않도록 차단되어 있습니다.
> 시스템을 처음 구축하는 개발자는 관리자에게 별도로 데이터 자산을 인계받아 이 폴더 내에 배치해야 합니다.

## 2. 데이터베이스 구성

본 저장소에 보관되는 메인 데이터베이스 엔진은 **PostgreSQL**입니다. 실제 바이너리 데이터 클러스터는 `postgres_data/` 폴더에 물리적으로 마운트되어 저장되며 영업/물성 기준 데이터와 인벤토리 정보가 정규화되어 담겨 있습니다. (기존 SQLite 파일은 안전을 위해 백업되었습니다.)

### 데이터베이스 ERD (Entity-Relationship Diagram)

아래는 `sg_proj_004.db` 내부 테이블 간의 스키마 구조 및 관계를 시각화한 ERD입니다.

```mermaid
erDiagram
    %% 개체 간의 관계 정의
    OUR_PRODUCT ||--o{ HOLDING_POWER_TEST : "유지력 테스트 이력"
    RAW_MATERIAL ||--o{ FTIR_SPECTRUM : "물질 분광 데이터"
    ADHEREND_PROPERTY ||--o{ ADHEREND_STOCK : "입고 재고 내역"

    %% 마스터: 상용 제품 및 원본 배합 (추가)
    OUR_PRODUCT {
        int id PK "제품 고유 ID"
        string product_name "제품명 (ex: SGV218ME)"
        string category "구분"
        float thickness_um "두께 (um)"
        string adhesion "점착력"
    }
    
    ADHESIVE_RECIPES {
        int id PK "배합 고유 ID"
        string record_date "기록 일자"
        json formula_data "모노머, 첨가제 및 목표 물성 JSON"
    }

    %% 마스터: 원재료
    RAW_MATERIAL {
        int id PK "원재료 고유 ID"
        string material_name "물질명 (단량체, 개시제 등)"
        string category "구분"
    }

    %% 마스터: 피착재 물성
    ADHEREND_PROPERTY {
        int id PK "피착재 고유 ID"
        string product_name "피착재 명칭 (BA, PCM 등)"
        float roughness_md "조도 MD"
        float surface_energy_md "표면 자유 에너지 MD"
    }

    %% 하위: 테스트 이미지
    HOLDING_POWER_TEST {
        int id PK
        int product_id FK "OUR_PRODUCT 참조"
        int time_min "경과 시간 (분)"
        string image_path "자산 파일 경로"
    }

    %% 하위: 측정치
    FTIR_SPECTRUM {
        int id PK
        int material_id FK "RAW_MATERIAL 참조"
        string file_path "TSV 데이터 경로"
        string image_path "PNG 데이터 경로"
    }

    %% 하위: 입고 내역
    ADHEREND_STOCK {
        int id PK
        int adherend_property_id FK "ADHEREND_PROPERTY 참조"
        string arrival_date "입고일자"
        int quantity "수량"
    }
```

## 3. 원본 데이터 세부 명세 (`raw_data`)

`raw_data/` 디렉토리에는 AI 모델 학습(001 모듈) 및 DB 구축(004 모듈)의 근간이 되는 수년 치의 비정형/정형 데이터가 총망라되어 보관되어 있습니다.

1. **핵심 실험 데이터베이스 (합성 및 도포 이력)**
   - `데이터베이스 기반 자료/`: 23년 9월부터 현재까지 누적된 반기별 실험 결과(Lab 합성, Lab 도포, 견본, 양산품) 엑셀 시트 23종.
   - `Lab 도포 총괄...csv` / `Lab 합성 총괄...csv`: 전체 기간의 실험 데이터를 평탄화(Flatten) 병합하여 머신러닝에 직접 투입 가능한 형태의 메타 데이터 셋.
   - `★점착제 조성 및 물성.xlsx`, `도포 계산(통합본).xlsx`: 점착제 배합비 및 물성 계산 시뮬레이션 원본 수식.

2. **상용 제품 및 판별 기준 (엑셀)**
   - `세계화학 제품분류_7.xlsx`: 자사 생산 제품의 스펙(두께, 점착력 등) 마스터.
   - `세계화학_제품분류_..._판별기준.xlsx`, `_피착제기준.xlsx`: 피착재 광택/조도 기준 레벨링 및 권장 점착 수준.

3. **재고 및 공정 이력 (엑셀/이미지)**
   - `피착제 입고 목록표 (AI용 정리본).xlsx`: 일자별 피착재 입고 스펙 및 수량 정보.
   - `assets/` : 유지력 테스트 결과 이미지, FT-IR 스펙트럼 등 자산 연동.
   - `작업지시서/`, `2026 합성지시서/`: 현장 공정 투입 시 발행된 지시서 원본 아카이브.

4. **원재료 물성 (비정형/측정치)**
   - `원재료 종류별 FT-IR 데이터` (.tsv 스펙트럼 수치 및 .png 분광학 그래프 이미지).

## 4. 데이터 정제 및 정규식(Regex) 활용 파이프라인

수년간 누적된 복잡한 엑셀 시트(다중 헤더, 빈 병합 셀, 단위 혼재 수치 등)를 머신러닝 및 RDBMS용으로 변환하기 위해, 데이터 파이프라인 스크립트(주로 `SG_proj_001`, `SG_proj_004` 소속)에서 Pandas와 정규표현식(Regex)을 조합하여 데이터를 추출 및 평탄화(Flattening)합니다.

* **수치/범위 데이터 파싱**: `10~20`과 같이 `~` 기호로 묶인 범위형 텍스트 데이터는 정규식 및 분리 로직을 통해 평균값(`15.0`)으로 변환하여 Float 타입 캐스팅을 강제합니다 (`safe_float` 함수).
* **특수문자 및 불순물 제거**: 엑셀 특성상 무작위로 들어간 공백, 줄바꿈 문자(`\n`), 그리고 `(um)` 등 불필요한 단위 표기는 치환 및 정규식 필터링을 통해 시스템 친화적인 텍스트로 정제됩니다.
* **결측치 및 유효 로우 추출**: Pandas의 `isna()`, `notna()` 필터와 병행하여 내용이 비어있거나 무의미한 텍스트만 든 행/열을 추출에서 제외해 데이터 무결성을 확보합니다.

이러한 정제 과정을 거치는 ETL 런타임 코드는 파이프라인 스크립트 단에서 관리되며, 본 `SG_DB` 모듈은 정제 완료된 최종 정형화 데이터베이스(Postgres)만을 보관합니다.

## 5. 모듈 연동 가이드

본 `SG_DB` 모듈은 자체적인 실행 코드를 갖지 않습니다. 데이터를 조회하고 시스템에 연동하기 위해서는 **`SG_proj_004` (API 게이트웨이) 모듈**을 실행해야 합니다.

- `SG_proj_004`를 Docker로 실행할 경우, `docker-compose.yml`에서 이 `SG_DB` 디렉토리를 볼륨 마운트(Volume Mount)하여 접근합니다.
- 로컬 개발 시에는 환경 변수 `DATABASE_URL`을 통해 이 저장소의 `.db` 파일을 바라보도록 설정됩니다.

---
*Last Updated: 2026-07-24 (Hybrid Environment & MSA Integration)*
