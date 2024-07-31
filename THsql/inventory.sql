create database shop_inventory;

use shop_inventory;

-- 판매자 테이블
CREATE TABLE Seller (
    sellerid VARCHAR(50) PRIMARY KEY, -- 판매자 아이디 PK
    sellername VARCHAR(100) -- 판매자 이름
);

-- 상품 테이블
CREATE TABLE Product (
    productCode VARCHAR(20) PRIMARY KEY, -- 단품코드 PK
    productName VARCHAR(100) NOT NULL, -- 단품명
    majorCategory VARCHAR(50), -- 대분류
    middleCategory VARCHAR(50), -- 중분류
    smallCategory VARCHAR(50), -- 소분류
    initialRegistrationTime DATETIME NOT NULL, -- 최초등록시간
    sellerid VARCHAR(50) NOT NULL, -- 최초등록자아이디
    FOREIGN KEY (sellerid) REFERENCES Seller(sellerid)
);

-- 재고 현황 테이블
CREATE TABLE Inventory (
    No INT AUTO_INCREMENT PRIMARY KEY, -- 고유 식별자
    productName VARCHAR(20) NOT NULL, -- 단품명
    productCode VARCHAR(20) NOT NULL, -- 단품코드
    cost DECIMAL(10, 2) NOT NULL, -- 원가
    stock INT NOT NULL, -- 재고수량
    totalCost DECIMAL(10, 2) AS (cost * stock) STORED, -- 재고금액
    FOREIGN KEY (productCode) REFERENCES Product(productCode)
);


-- 판매 마감관리 테이블
CREATE TABLE SalesClosureManagement (
    No INT AUTO_INCREMENT PRIMARY KEY, -- 고유 식별자
    selectionSlot BOOLEAN NOT NULL, -- 선택 슬롯
    salesClosure DATE NOT NULL, -- 판매마감
    sellerid VARCHAR(20) NOT NULL, -- 최초등록자아이디
    initialRegistrationTime DATE NOT NULL, -- 최초등록시간
    modifierid VARCHAR(50), -- 최종수정자아이디
    modificationTime DATE, -- 최종수정시각
    FOREIGN KEY (sellerid) REFERENCES Seller(sellerid)
);


-- 월 마감관리 테이블 
CREATE TABLE MonthlyClosureManagement (
    No INT AUTO_INCREMENT PRIMARY KEY, -- 고유 식별자
    workDate DATE NOT NULL, -- 작업일자
    closingMonth DATE NOT NULL, -- 마감월
    closingStatus VARCHAR(50) NOT NULL, -- 마감상태
    sellerid VARCHAR(50) NOT NULL, -- 최초등록자아이디
    initialRegistrationTime DATE NOT NULL, -- 최초등록시간
    modifierid VARCHAR(50), -- 최종수정자아이디
    modificationTime DATE, -- 최종수정시각
    FOREIGN KEY (sellerid) REFERENCES Seller(sellerid)
);


-- 월 마감관리 상태 테이블
CREATE TABLE MonthlyClosureStatus (
    No INT AUTO_INCREMENT PRIMARY KEY, -- 고유 식별자
    closingMonth DATETIME NOT NULL, -- 마감월
    closingStatus VARCHAR(10) NOT NULL, -- 마감상태
    closingState VARCHAR(10) NOT NULL, -- 마감여부
    sellerid VARCHAR(20) NOT NULL, -- 최초등록자아이디
    initialRegistrationTime DATE NOT NULL, -- 최초등록시각
    modifierid VARCHAR(50), -- 최종수정자아이디
    modificationTime DATE, -- 최종수정시각
    FOREIGN KEY (sellerid) REFERENCES Seller(sellerid)
);

-- 코드 관리 테이블
CREATE TABLE MonthlyCostManagement (
    No INT AUTO_INCREMENT PRIMARY KEY, -- 고유 식별자
    selectionSlot CHAR(1) NOT NULL, -- 선택 슬롯
    productCode VARCHAR(20) NOT NULL, -- 단품코드
    workMonth VARCHAR(10) NOT NULL, -- 작업월
    productName VARCHAR(30) NOT NULL, -- 단품코드명
    cost DECIMAL(10, 2) NOT NULL, -- 원가
    status VARCHAR(50) NOT NULL, -- 상태
    memo VARCHAR(255), -- 메모
    sellerid VARCHAR(50) NOT NULL, -- 최초등록자아이디
    initialRegistrationTime DATE NOT NULL, -- 최초등록시각
    modifierid VARCHAR(50), -- 최종수정자아이디
    modificationTime DATE, -- 최종수정시각
    FOREIGN KEY (sellerid) REFERENCES Seller(sellerid),
    FOREIGN KEY (productCode) REFERENCES Product(productCode)
);


-- 창고 수불 현황 테이블 생성
CREATE TABLE Warehouse_Status (
    warehouseID INT AUTO_INCREMENT PRIMARY KEY, -- 고유 식별자
    productCode VARCHAR(50) NOT NULL, -- 단품코드 (외래 키)
    inventoryManagement CHAR(1) NOT NULL, -- 재고 관리 여부 (Y or N)
    currentStockAmount INT NOT NULL, -- 현 재고 수량
    incomingQuantity INT NOT NULL, -- 입고 수량
    incomingValue DECIMAL(10, 2) NOT NULL, -- 입고 금액
    returnIncomingAmount INT, -- 입고 반품 수량
    returnIncomingPrice DECIMAL(10, 2), -- 입고 반품 금액
    transferIncomingAmount INT, -- 이동 입고 수량
    transferIncomingPrice DECIMAL(10, 2), -- 이동 입고 금액
    transferOutgoingAmount INT, -- 이동 출고 수량
    transferOutgoingPrice DECIMAL(10, 2), -- 이동 출고 금액
    outgoingAmount INT NOT NULL, -- 출고 수량
    outgoingPrice DECIMAL(10, 2) NOT NULL, -- 출고 금액
    returnOutgoingAmount INT, -- 출고 반품 수량
    returnOutgoingPrice DECIMAL(10, 2), -- 출고 반품 금액
    miscOutgoingAmount INT, -- 기타 출고 수량
    miscOutgoingPrice DECIMAL(10, 2), -- 기타 출고 금액
    miscOutgoingReturnAmount INT, -- 기타 출고 반품 수량
    miscOutgoingReturnValue DECIMAL(10, 2), -- 기타 출고 반품 금액
    lossAmount INT, -- Loss 수량
    lossPrice DECIMAL(10, 2), -- Loss 금액
    FOREIGN KEY (ProductCode) REFERENCES Product(ProductCode)
);

-- 매장수불현황
CREATE TABLE StoreStockStatus (
    storeID INT AUTO_INCREMENT PRIMARY KEY, 
    productCode VARCHAR(50) NOT NULL, -- 단품코드 (외래 키)
    inventoryManagement CHAR(1) NOT NULL, -- 재고 관리 여부 (Y or N)
    currentStockAmount INT NOT NULL, -- 현 재고 수량
    incomingQuantity INT NOT NULL, -- 입고 수량
    incomingValue DECIMAL(10, 2) NOT NULL, -- 입고 금액
    returnIncomingAmount INT, -- 입고 반품 수량
    returnIncomingPrice DECIMAL(10, 2), -- 입고 반품 금액
    transferIncomingAmount INT, -- 이동 입고 수량
    transferIncomingPrice DECIMAL(10, 2), -- 이동 입고 금액
    transferOutgoingAmount INT, -- 이동 출고 수량
    transferOutgoingPrice DECIMAL(10, 2), -- 이동 출고 금액
    outgoingAmount INT NOT NULL, -- 출고 수량
    outgoingPrice DECIMAL(10, 2) NOT NULL, -- 출고 금액
    returnOutgoingAmount INT, -- 출고 반품 수량
    returnOutgoingPrice DECIMAL(10, 2), -- 출고 반품 금액
    miscOutgoingAmount INT, -- 기타 출고 수량
    miscOutgoingPrice DECIMAL(10, 2), -- 기타 출고 금액
    miscOutgoingReturnAmount INT, -- 기타 출고 반품 수량
    miscOutgoingReturnValue DECIMAL(10, 2), -- 기타 출고 반품 금액
    lossAmount INT, -- Loss 수량
    lossPrice DECIMAL(10, 2), -- Loss 금액
    FOREIGN KEY (ProductCode) REFERENCES Product(ProductCode)
);
