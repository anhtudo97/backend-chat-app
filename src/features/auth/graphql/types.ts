import { Field, InputType, ObjectType } from "type-graphql";

@ObjectType()
export class AuthUser {
  @Field({ nullable: true })
  displayName?: string;
  @Field({ nullable: true })
  photoURL?: string;
}

@ObjectType()
export class LoginResponse {
  @Field()
  accessToken!: string;
  @Field()
  authUser!: AuthUser;
}

@InputType()
export class LoginInput {
  @Field()
  token!: string;
}
