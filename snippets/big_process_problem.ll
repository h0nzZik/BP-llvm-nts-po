%union.pthread_attr_t = type { i64, [48 x i8] }
@G1 = global i32 16;
@G2 = global i32 0;

define i8* @p1 ( i8* %x ) {
	; some local calculations
	store i32 42, i32* @G1;
	ret i8* null;
}

define i8* @p2 ( i8* ) {
	; some more local calculations
	store i32 14, i32* @G2;
	ret i8* null;
}

define void @main() {
	call i32 @pthread_create (
			i64*                   null,
			%union.pthread_attr_t* null,
			i8* (i8*)*             @p1,
			i8*                    null );

	call i32 @pthread_create (
			i64*                   null,
			%union.pthread_attr_t* null,
			i8* (i8*)*             @p2,
			i8*                    null );

	ret void;
}

; Function Attrs: nounwind
declare i32 @pthread_create(i64*, %union.pthread_attr_t*, i8* (i8*)*, i8*) #1

