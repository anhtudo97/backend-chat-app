import {
  AuthUser as PrismaAuthUser,
  Badge as PrismaBadge,
  Block as PrismaBlock,
  Conversation as PrismaConversation,
  ConversationType as PrismaConversationType,
  DeliveryType as PrismaDeliveryType,
  Friend as PrismaFriend,
  Media as PrismaMedia,
  MediaType as PrismaMediaType,
  User as PrismaUser,
} from "@prisma/client";
import { AuthProviderUser } from "../src/features/auth/data/google-api";
import UserDataSource, {
  CreateUserArgs,
} from "../src/features/user/data/user-data-source";
import { Me, User } from "../src/features/user/graphql/types";
import {
  Friendship,
  FriendshipStatus,
} from "../src/features/friend/graphql/types";
import { ResizedPhotos } from "../src/shared/utils/file-utils";
import { BadgeName } from "../src/features/badge/graphql/types";
import { Block } from "../src/features/block/graphql/types";
import {
  FullPrismaConversation,
  FullPrismaMessage,
} from "../src/features/chat/data/chat-data-source";
import {
  Conversation,
  ConversationType,
  Media,
  MediaType,
  Message,
  Typing,
} from "../src/features/chat/graphql/types";

export const mockPrismaAuthUser: PrismaAuthUser = {
  id: "auth_user_id",
  email: "auth@gmail.com",
};

export const mockPrismaUser: PrismaUser = {
  username: "username",
  name: null,
  photoURLSource: "/storage/auth_user_id_pp_source.png",
  photoURLMedium: "/storage/auth_user_id_pp_medium.png",
  photoURLSmall: "/storage/auth_user_id_pp_small.png",
  authUserID: "auth_user_id",
  activeStatus: true,
  lastSeen: new Date(),
};

export const mockGraphQLUser: User = {
  id: mockPrismaUser.authUserID,
  username: mockPrismaUser.username,
  name: mockPrismaUser.name ?? undefined,
  photoURLSource: "/storage/auth_user_id_pp_source.png",
  photoURLMedium: "/storage/auth_user_id_pp_medium.png",
  photoURLSmall: "/storage/auth_user_id_pp_small.png",
};

export const mockMe: Me = {
  user: mockGraphQLUser,
  activeStatus: mockPrismaUser.activeStatus,
};

export const mockResizedPhotos: ResizedPhotos = {
  source: "source",
  medium: "medium",
  small: "small",
};

export const mockAuthProviderUser: AuthProviderUser = {
  email: "provider@email.com",
  displayName: "Provider User",
  photoURL: "https://provider.com/photo.png",
};
