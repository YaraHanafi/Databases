create database schema;

create TABLE `users` (
  `userId` INT NOT NULL AUTO_INCREMENT,
  `display_name` VARCHAR(50) NULL DEFAULT NULL,
  `pwd` VARCHAR(50) NULL DEFAULT NULL,
  `usertype` ENUM('end user', 'admin', 'customer rep') NULL DEFAULT 'end user',
  PRIMARY KEY (`userId`),
  UNIQUE INDEX `userId_UNIQUE` (`userId` ASC) VISIBLE,
  UNIQUE INDEX `display name_UNIQUE` (`display_name` ASC) VISIBLE);

CREATE TABLE`bids` (
  `secret_upper_lim` FLOAT NULL DEFAULT 0,
  `auctionId` INT NOT NULL,
  `userId` INT NOT NULL,
  `amnt` FLOAT NOT NULL,
  `bid` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`bid`),
  INDEX `uid_idx` (`uid` ASC) INVISIBLE,
  UNIQUE INDEX `bid_UNIQUE` (`bid` ASC) VISIBLE,
  CONSTRAINT `auctionId_bids`
    FOREIGN KEY (`auctionId`)
    REFERENCES `techauctionsitedb`.`auctions` (`auctionId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `userId_bids`
    FOREIGN KEY (`userId`)
    REFERENCES `techauctionsitedb`.`users` (`userId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
    
CREATE TABLE `vehicles` (
  `vehicleNumber` INT NOT NULL,
  `make` VARCHAR(50) NOT NULL,
  `color` VARCHAR(50) NOT NULL,
  `vehicleType` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`vehicleNumber`));
  
CREATE TABLE `auctions` (
  `auctionId` INT NOT NULL AUTO_INCREMENT,
  `startTime` DATETIME NULL,
  `closeTime` DATETIME NULL,
  `status` ENUM('open', 'closed') NULL,
  `initialPrice` FLOAT NULL,
  `bidInc` FLOAT NULL,
  `secretMinPrice` FLOAT NULL,
  `userId` INT NULL,
  `highestBidId` INT NULL,
  `vehicleNumber` INT NULL,
  INDEX `uid_auctions_idx` (`uid` ASC) VISIBLE,
  PRIMARY KEY (`auctionId`),
  UNIQUE INDEX `auctionId_UNIQUE` (`auctionId` ASC) VISIBLE,
  INDEX `bid_auctions_idx` (`highest_bid` ASC) VISIBLE,
  INDEX `part_number_actions_idx` (`vehicleNumber` ASC) VISIBLE,
  CONSTRAINT `userId_auctions`
    FOREIGN KEY (`userId`)
    REFERENCES `schema`.`users` (`userId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `bid_auctions`
    FOREIGN KEY (`highestBidId`)
    REFERENCES `schema`.`bids` (`bid`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `vehicleNumber_actions`
    FOREIGN KEY (`vehicleNumber`)
    REFERENCES `schema`.`vehicles` (`vehicleNumber`)
    ON DELETE SET NULL
    ON UPDATE CASCADE);

CREATE TABLE `cars` (
  `vehicleNumber` INT NOT NULL,
  `make` VARCHAR(45) NULL DEFAULT NULL,
  `color` VARCHAR(45) NOT NULL,
  `doorType` ENUM('two door', 'four door') NULL,
  INDEX `vehicleNumberCarIndex` (`vehicleNumber` ASC) VISIBLE,
  PRIMARY KEY (`vehicleNumber`),
  CONSTRAINT `vehicleNumberCars`
    FOREIGN KEY (`vehicleNumber`)
    REFERENCES `schema`.`vehicles` (`vehicleNumber`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE `trucks` (
  `vehicleNumber` INT NOT NULL,
  `cargoWeight` INT NOT NULL,
  `length` INT NOT NULL,
  INDEX `vehicleNumberTruckIndex` (`vehicleNumber` ASC) VISIBLE,
  PRIMARY KEY (`vehicleNumber`),
  CONSTRAINT `vehicleNumberTruck`
    FOREIGN KEY (`vehicleNumber`)
    REFERENCES `schema`.`vehicles` (`vehicleNumber`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE `motorcycles` (
  `vehicleNumber` INT NOT NULL,
  `maxSpeed` INT NOT NULL,
  `weight` INT NOT NULL,
  INDEX `vehicleNumberMotorcycleIndex` (`vehicleNumber` ASC) VISIBLE,
  PRIMARY KEY (`vehicleNumber`),
  CONSTRAINT `vehicleNumberMotorcycle`
    FOREIGN KEY (`vehicleNumber`)
    REFERENCES `schema`.`vehicles` (`vehicleNumber`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
    
CREATE TABLE `supporttickets` (
  `ticket_num` INT NOT NULL AUTO_INCREMENT,
  `user_uid` INT NOT NULL,
  `rep_uid` INT NOT NULL,
  `thread` VARCHAR(10000) NULL DEFAULT NULL,
  `status` ENUM('open', 'closed') NULL DEFAULT 'closed',
  PRIMARY KEY (`ticket_num`),
  UNIQUE INDEX `ticket_num_UNIQUE` (`ticket_num` ASC) VISIBLE,
  INDEX `user_uid_idx` (`user_uid` ASC) VISIBLE,
  INDEX `rep_uid_idx` (`rep_uid` ASC) VISIBLE,
  CONSTRAINT `rep_uid`
    FOREIGN KEY (`rep_uid`)
    REFERENCES `schema`.`users` (`userId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `user_uid`
    FOREIGN KEY (`user_uid`)
    REFERENCES `schema`.`users` (`userId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

