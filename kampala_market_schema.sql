--
-- PostgreSQL database dump
--


-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: AuditLogs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AuditLogs" (
    "Id" uuid NOT NULL,
    "ActorUserId" uuid,
    "Action" text NOT NULL,
    "EntityType" text NOT NULL,
    "EntityId" uuid NOT NULL,
    "OldValues" text,
    "NewValues" text,
    "CreatedAt" timestamp with time zone NOT NULL,
    "UpdatedAt" timestamp with time zone NOT NULL,
    "DeletedAt" timestamp with time zone
);


ALTER TABLE public."AuditLogs" OWNER TO postgres;

--
-- Name: Categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Categories" (
    "Id" uuid NOT NULL,
    "Name" text NOT NULL,
    "Slug" text NOT NULL,
    "ParentId" uuid,
    "CreatedAt" timestamp with time zone NOT NULL,
    "UpdatedAt" timestamp with time zone NOT NULL,
    "DeletedAt" timestamp with time zone
);


ALTER TABLE public."Categories" OWNER TO postgres;

--
-- Name: Deliveries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Deliveries" (
    "Id" uuid NOT NULL,
    "OrderId" uuid NOT NULL,
    "DeliveryPartnerId" uuid,
    "Status" integer NOT NULL,
    "PickedUpAt" timestamp with time zone,
    "DeliveredAt" timestamp with time zone,
    "ProofPhotoUrl" text,
    "FailureReason" text,
    "CreatedAt" timestamp with time zone NOT NULL,
    "UpdatedAt" timestamp with time zone NOT NULL,
    "DeletedAt" timestamp with time zone
);


ALTER TABLE public."Deliveries" OWNER TO postgres;

--
-- Name: OrderItems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."OrderItems" (
    "Id" uuid NOT NULL,
    "OrderId" uuid NOT NULL,
    "ProductId" uuid NOT NULL,
    "ProductNameSnapshot" text NOT NULL,
    "UnitPriceUgx" bigint NOT NULL,
    "Quantity" integer NOT NULL,
    "LineTotalUgx" bigint NOT NULL,
    "CreatedAt" timestamp with time zone NOT NULL,
    "UpdatedAt" timestamp with time zone NOT NULL,
    "DeletedAt" timestamp with time zone
);


ALTER TABLE public."OrderItems" OWNER TO postgres;

--
-- Name: Orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Orders" (
    "Id" uuid NOT NULL,
    "CustomerId" uuid NOT NULL,
    "TraderId" uuid NOT NULL,
    "Status" integer NOT NULL,
    "DeliveryFeeUgx" bigint NOT NULL,
    "SubtotalUgx" bigint NOT NULL,
    "TotalUgx" bigint NOT NULL,
    "DeliveryAddress" text NOT NULL,
    "DeliveryParish" text NOT NULL,
    "DeliveryLat" double precision,
    "DeliveryLng" double precision,
    "Notes" text,
    "CreatedAt" timestamp with time zone NOT NULL,
    "UpdatedAt" timestamp with time zone NOT NULL,
    "DeletedAt" timestamp with time zone
);


ALTER TABLE public."Orders" OWNER TO postgres;

--
-- Name: Payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Payments" (
    "Id" uuid NOT NULL,
    "OrderId" uuid NOT NULL,
    "Provider" text NOT NULL,
    "ProviderTransactionId" text,
    "AmountUgx" bigint NOT NULL,
    "Currency" text NOT NULL,
    "Status" integer NOT NULL,
    "RawWebhook" text,
    "CreatedAt" timestamp with time zone NOT NULL,
    "UpdatedAt" timestamp with time zone NOT NULL,
    "DeletedAt" timestamp with time zone
);


ALTER TABLE public."Payments" OWNER TO postgres;

--
-- Name: Products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Products" (
    "Id" uuid NOT NULL,
    "TraderId" uuid NOT NULL,
    "CategoryId" uuid NOT NULL,
    "Name" text NOT NULL,
    "Description" text,
    "PriceUgx" bigint NOT NULL,
    "StockQuantity" integer NOT NULL,
    "IsActive" boolean NOT NULL,
    "Images" text NOT NULL,
    "CreatedAt" timestamp with time zone NOT NULL,
    "UpdatedAt" timestamp with time zone NOT NULL,
    "DeletedAt" timestamp with time zone
);


ALTER TABLE public."Products" OWNER TO postgres;

--
-- Name: RefreshTokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."RefreshTokens" (
    "Id" uuid NOT NULL,
    "UserId" uuid NOT NULL,
    "Token" text NOT NULL,
    "ExpiresAt" timestamp with time zone NOT NULL,
    "IsRevoked" boolean NOT NULL,
    "CreatedAt" timestamp with time zone NOT NULL,
    "UpdatedAt" timestamp with time zone NOT NULL,
    "DeletedAt" timestamp with time zone
);


ALTER TABLE public."RefreshTokens" OWNER TO postgres;

--
-- Name: Traders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Traders" (
    "Id" uuid NOT NULL,
    "UserId" uuid NOT NULL,
    "ShopName" text NOT NULL,
    "Parish" text NOT NULL,
    "Division" text NOT NULL,
    "Phone" text NOT NULL,
    "Description" text,
    "Status" text NOT NULL,
    "AverageRating" numeric NOT NULL,
    "TotalReviews" integer NOT NULL,
    "CreatedAt" timestamp with time zone NOT NULL,
    "UpdatedAt" timestamp with time zone NOT NULL,
    "DeletedAt" timestamp with time zone
);


ALTER TABLE public."Traders" OWNER TO postgres;

--
-- Name: Users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Users" (
    "Id" uuid NOT NULL,
    "Phone" text NOT NULL,
    "PasswordHash" text,
    "FullName" text NOT NULL,
    "Role" integer NOT NULL,
    "Email" text,
    "PhoneVerified" boolean NOT NULL,
    "EmailVerified" boolean NOT NULL,
    "IsActive" boolean NOT NULL,
    "CreatedAt" timestamp with time zone NOT NULL,
    "UpdatedAt" timestamp with time zone NOT NULL,
    "DeletedAt" timestamp with time zone
);


ALTER TABLE public."Users" OWNER TO postgres;

--
-- Name: __EFMigrationsHistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL
);


ALTER TABLE public."__EFMigrationsHistory" OWNER TO postgres;

--
-- Name: AuditLogs PK_AuditLogs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AuditLogs"
    ADD CONSTRAINT "PK_AuditLogs" PRIMARY KEY ("Id");


--
-- Name: Categories PK_Categories; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "PK_Categories" PRIMARY KEY ("Id");


--
-- Name: Deliveries PK_Deliveries; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Deliveries"
    ADD CONSTRAINT "PK_Deliveries" PRIMARY KEY ("Id");


--
-- Name: OrderItems PK_OrderItems; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItems"
    ADD CONSTRAINT "PK_OrderItems" PRIMARY KEY ("Id");


--
-- Name: Orders PK_Orders; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Orders"
    ADD CONSTRAINT "PK_Orders" PRIMARY KEY ("Id");


--
-- Name: Payments PK_Payments; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Payments"
    ADD CONSTRAINT "PK_Payments" PRIMARY KEY ("Id");


--
-- Name: Products PK_Products; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Products"
    ADD CONSTRAINT "PK_Products" PRIMARY KEY ("Id");


--
-- Name: RefreshTokens PK_RefreshTokens; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RefreshTokens"
    ADD CONSTRAINT "PK_RefreshTokens" PRIMARY KEY ("Id");


--
-- Name: Traders PK_Traders; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Traders"
    ADD CONSTRAINT "PK_Traders" PRIMARY KEY ("Id");


--
-- Name: Users PK_Users; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "PK_Users" PRIMARY KEY ("Id");


--
-- Name: __EFMigrationsHistory PK___EFMigrationsHistory; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."__EFMigrationsHistory"
    ADD CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId");


--
-- Name: IX_AuditLogs_ActorUserId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AuditLogs_ActorUserId" ON public."AuditLogs" USING btree ("ActorUserId");


--
-- Name: IX_AuditLogs_CreatedAt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AuditLogs_CreatedAt" ON public."AuditLogs" USING btree ("CreatedAt");


--
-- Name: IX_AuditLogs_EntityType; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AuditLogs_EntityType" ON public."AuditLogs" USING btree ("EntityType");


--
-- Name: IX_Categories_ParentId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Categories_ParentId" ON public."Categories" USING btree ("ParentId");


--
-- Name: IX_Categories_Slug; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Categories_Slug" ON public."Categories" USING btree ("Slug");


--
-- Name: IX_Deliveries_DeliveryPartnerId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Deliveries_DeliveryPartnerId" ON public."Deliveries" USING btree ("DeliveryPartnerId");


--
-- Name: IX_Deliveries_OrderId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Deliveries_OrderId" ON public."Deliveries" USING btree ("OrderId");


--
-- Name: IX_Deliveries_Status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Deliveries_Status" ON public."Deliveries" USING btree ("Status");


--
-- Name: IX_OrderItems_OrderId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_OrderItems_OrderId" ON public."OrderItems" USING btree ("OrderId");


--
-- Name: IX_OrderItems_ProductId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_OrderItems_ProductId" ON public."OrderItems" USING btree ("ProductId");


--
-- Name: IX_Orders_CustomerId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Orders_CustomerId" ON public."Orders" USING btree ("CustomerId");


--
-- Name: IX_Orders_Status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Orders_Status" ON public."Orders" USING btree ("Status");


--
-- Name: IX_Orders_TraderId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Orders_TraderId" ON public."Orders" USING btree ("TraderId");


--
-- Name: IX_Payments_OrderId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Payments_OrderId" ON public."Payments" USING btree ("OrderId");


--
-- Name: IX_Payments_ProviderTransactionId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Payments_ProviderTransactionId" ON public."Payments" USING btree ("ProviderTransactionId");


--
-- Name: IX_Products_CategoryId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Products_CategoryId" ON public."Products" USING btree ("CategoryId");


--
-- Name: IX_Products_IsActive; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Products_IsActive" ON public."Products" USING btree ("IsActive");


--
-- Name: IX_Products_TraderId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Products_TraderId" ON public."Products" USING btree ("TraderId");


--
-- Name: IX_RefreshTokens_Token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_RefreshTokens_Token" ON public."RefreshTokens" USING btree ("Token");


--
-- Name: IX_RefreshTokens_UserId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_RefreshTokens_UserId" ON public."RefreshTokens" USING btree ("UserId");


--
-- Name: IX_Traders_Status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Traders_Status" ON public."Traders" USING btree ("Status");


--
-- Name: IX_Traders_UserId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Traders_UserId" ON public."Traders" USING btree ("UserId");


--
-- Name: IX_Users_Phone; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Users_Phone" ON public."Users" USING btree ("Phone");


--
-- Name: IX_Users_Role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Users_Role" ON public."Users" USING btree ("Role");


--
-- Name: AuditLogs FK_AuditLogs_Users_ActorUserId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AuditLogs"
    ADD CONSTRAINT "FK_AuditLogs_Users_ActorUserId" FOREIGN KEY ("ActorUserId") REFERENCES public."Users"("Id");


--
-- Name: Categories FK_Categories_Categories_ParentId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "FK_Categories_Categories_ParentId" FOREIGN KEY ("ParentId") REFERENCES public."Categories"("Id");


--
-- Name: Deliveries FK_Deliveries_Orders_OrderId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Deliveries"
    ADD CONSTRAINT "FK_Deliveries_Orders_OrderId" FOREIGN KEY ("OrderId") REFERENCES public."Orders"("Id") ON DELETE CASCADE;


--
-- Name: Deliveries FK_Deliveries_Users_DeliveryPartnerId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Deliveries"
    ADD CONSTRAINT "FK_Deliveries_Users_DeliveryPartnerId" FOREIGN KEY ("DeliveryPartnerId") REFERENCES public."Users"("Id");


--
-- Name: OrderItems FK_OrderItems_Orders_OrderId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItems"
    ADD CONSTRAINT "FK_OrderItems_Orders_OrderId" FOREIGN KEY ("OrderId") REFERENCES public."Orders"("Id") ON DELETE CASCADE;


--
-- Name: OrderItems FK_OrderItems_Products_ProductId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItems"
    ADD CONSTRAINT "FK_OrderItems_Products_ProductId" FOREIGN KEY ("ProductId") REFERENCES public."Products"("Id") ON DELETE CASCADE;


--
-- Name: Orders FK_Orders_Traders_TraderId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Orders"
    ADD CONSTRAINT "FK_Orders_Traders_TraderId" FOREIGN KEY ("TraderId") REFERENCES public."Traders"("Id") ON DELETE CASCADE;


--
-- Name: Orders FK_Orders_Users_CustomerId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Orders"
    ADD CONSTRAINT "FK_Orders_Users_CustomerId" FOREIGN KEY ("CustomerId") REFERENCES public."Users"("Id") ON DELETE CASCADE;


--
-- Name: Payments FK_Payments_Orders_OrderId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Payments"
    ADD CONSTRAINT "FK_Payments_Orders_OrderId" FOREIGN KEY ("OrderId") REFERENCES public."Orders"("Id") ON DELETE CASCADE;


--
-- Name: Products FK_Products_Categories_CategoryId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Products"
    ADD CONSTRAINT "FK_Products_Categories_CategoryId" FOREIGN KEY ("CategoryId") REFERENCES public."Categories"("Id") ON DELETE CASCADE;


--
-- Name: Products FK_Products_Traders_TraderId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Products"
    ADD CONSTRAINT "FK_Products_Traders_TraderId" FOREIGN KEY ("TraderId") REFERENCES public."Traders"("Id") ON DELETE CASCADE;


--
-- Name: RefreshTokens FK_RefreshTokens_Users_UserId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RefreshTokens"
    ADD CONSTRAINT "FK_RefreshTokens_Users_UserId" FOREIGN KEY ("UserId") REFERENCES public."Users"("Id") ON DELETE CASCADE;


--
-- Name: Traders FK_Traders_Users_UserId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Traders"
    ADD CONSTRAINT "FK_Traders_Users_UserId" FOREIGN KEY ("UserId") REFERENCES public."Users"("Id") ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--


