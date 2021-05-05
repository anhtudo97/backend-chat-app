-- CreateEnum
CREATE TYPE "NotificationType" AS ENUM ('REQUEST_ACCEPTED', 'SYSTEM');

-- CreateEnum
CREATE TYPE "BadgeName" AS ENUM ('NOTIFICATIONS', 'FRIEND_REQUESTS');

-- CreateEnum
CREATE TYPE "ConversationType" AS ENUM ('ONE_TO_ONE', 'GROUP');

-- CreateEnum
CREATE TYPE "MediaType" AS ENUM ('IMAGE', 'VIDEO');

-- CreateEnum
CREATE TYPE "DeliveryType" AS ENUM ('DELIVERED', 'SEEN');

-- CreateTable
CREATE TABLE "auth_users" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users" (
    "username" TEXT NOT NULL,
    "name" TEXT,
    "photo_url_source" TEXT,
    "photo_url_medium" TEXT,
    "photo_url_small" TEXT,
    "activeStatus" BOOLEAN NOT NULL DEFAULT true,
    "last_seen" TIMESTAMP(3) NOT NULL,
    "auth_user" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "friends" (
    "id" SERIAL NOT NULL,
    "user1_id" TEXT NOT NULL,
    "user2_id" TEXT NOT NULL,
    "confirmed" BOOLEAN NOT NULL DEFAULT false,
    "date" TIMESTAMP(3) NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "blocks" (
    "id" SERIAL NOT NULL,
    "blocking_id" TEXT NOT NULL,
    "blocked_id" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "notifications" (
    "id" SERIAL NOT NULL,
    "ownerID" TEXT NOT NULL,
    "type" "NotificationType" NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "seen" BOOLEAN NOT NULL DEFAULT false,
    "friendID" TEXT,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "badges" (
    "userID" TEXT NOT NULL,
    "badgeName" "BadgeName" NOT NULL,
    "lastOpened" TIMESTAMP(3) NOT NULL
);

-- CreateTable
CREATE TABLE "conversations" (
    "id" SERIAL NOT NULL,
    "type" "ConversationType" NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "messages" (
    "id" SERIAL NOT NULL,
    "senderID" TEXT NOT NULL,
    "conversationID" INTEGER NOT NULL,
    "text" TEXT,
    "sentAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "medias" (
    "id" SERIAL NOT NULL,
    "messageID" INTEGER NOT NULL,
    "type" "MediaType" NOT NULL,
    "url" TEXT NOT NULL,
    "thumbUrl" TEXT,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "deliveries" (
    "messageID" INTEGER NOT NULL,
    "userID" TEXT NOT NULL,
    "type" "DeliveryType" NOT NULL,
    "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "_AuthUserToConversation" (
    "A" TEXT NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "auth_users.email_unique" ON "auth_users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "users.username_unique" ON "users"("username");

-- CreateIndex
CREATE UNIQUE INDEX "users.auth_user_unique" ON "users"("auth_user");

-- CreateIndex
CREATE UNIQUE INDEX "friends.user1_id_user2_id_unique" ON "friends"("user1_id", "user2_id");

-- CreateIndex
CREATE UNIQUE INDEX "blocks.blocking_id_blocked_id_unique" ON "blocks"("blocking_id", "blocked_id");

-- CreateIndex
CREATE UNIQUE INDEX "notifications.id_ownerID_unique" ON "notifications"("id", "ownerID");

-- CreateIndex
CREATE UNIQUE INDEX "badges.userID_badgeName_unique" ON "badges"("userID", "badgeName");

-- CreateIndex
CREATE UNIQUE INDEX "deliveries.messageID_userID_type_unique" ON "deliveries"("messageID", "userID", "type");

-- CreateIndex
CREATE UNIQUE INDEX "_AuthUserToConversation_AB_unique" ON "_AuthUserToConversation"("A", "B");

-- CreateIndex
CREATE INDEX "_AuthUserToConversation_B_index" ON "_AuthUserToConversation"("B");

-- AddForeignKey
ALTER TABLE "users" ADD FOREIGN KEY ("auth_user") REFERENCES "auth_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "friends" ADD FOREIGN KEY ("user1_id") REFERENCES "auth_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "friends" ADD FOREIGN KEY ("user2_id") REFERENCES "auth_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "blocks" ADD FOREIGN KEY ("blocking_id") REFERENCES "auth_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "blocks" ADD FOREIGN KEY ("blocked_id") REFERENCES "auth_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notifications" ADD FOREIGN KEY ("ownerID") REFERENCES "auth_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notifications" ADD FOREIGN KEY ("friendID") REFERENCES "auth_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "badges" ADD FOREIGN KEY ("userID") REFERENCES "auth_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "messages" ADD FOREIGN KEY ("senderID") REFERENCES "auth_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "messages" ADD FOREIGN KEY ("conversationID") REFERENCES "conversations"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "medias" ADD FOREIGN KEY ("messageID") REFERENCES "messages"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "deliveries" ADD FOREIGN KEY ("messageID") REFERENCES "messages"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "deliveries" ADD FOREIGN KEY ("userID") REFERENCES "auth_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AuthUserToConversation" ADD FOREIGN KEY ("A") REFERENCES "auth_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AuthUserToConversation" ADD FOREIGN KEY ("B") REFERENCES "conversations"("id") ON DELETE CASCADE ON UPDATE CASCADE;
