#include <array>
#include <cmath>
#include <cstdio>
#include "md5.hpp"

namespace MD5 {
const unsigned int BITS_PER_BYTE = 8;

static std::array<long, 64> T;

inline unsigned int RotateLeft(unsigned int x, unsigned int y)
	{return (x << y) | (x >> (32-y));}

inline unsigned int F(unsigned int X, unsigned int Y, unsigned int Z) {return ((X & Y) | ((~X) & Z));}
inline unsigned int FF(unsigned int a, unsigned int b, unsigned int c,unsigned int d, unsigned int x_k, unsigned int s, unsigned int i) 
	{return b + RotateLeft((a + F(b,c,d) + x_k + static_cast<unsigned int>(T[i-1])), s);}

inline unsigned int G(unsigned int X, unsigned int Y, unsigned int Z) {return ((X & Z) | (Y & (~Z)));}
inline unsigned int GG(unsigned int a, unsigned int b, unsigned int c,unsigned int d, unsigned int x_k, unsigned int s, unsigned int i) 
	{return b + RotateLeft((a + G(b,c,d) + x_k + static_cast<unsigned int>(T[i-1])), s);}

inline unsigned int H(unsigned int X, unsigned int Y, unsigned int Z) {return X ^ Y ^ Z;}
inline unsigned int HH(unsigned int a, unsigned int b, unsigned int c,unsigned int d, unsigned int x_k, unsigned int s, unsigned int i) 
	{return b + RotateLeft((a + H(b,c,d) + x_k + static_cast<unsigned int>(T[i-1])), s);}

inline unsigned int I(unsigned int X, unsigned int Y, unsigned int Z) {return Y ^ (X | (~Z));}
inline unsigned int II(unsigned int a, unsigned int b, unsigned int c,unsigned int d, unsigned int x_k, unsigned int s, unsigned int i) 
	{return b + RotateLeft((a + I(b,c,d) + x_k + static_cast<unsigned int>(T[i-1])), s);}

union _long {
	long i;
	unsigned char s[8];
};

union _unsigned int {
	unsigned int i;
	unsigned char s[4];
};

void md5_init() {
	for(int i=0; i<64; ++i)
		T[i] = ::fabs(::sin( static_cast<double>(i+1) )) * 0x100000000;
}

std::string padding(const std::string& src) {
	unsigned int m = src.length() % 64;
	unsigned int n = 56 - ((m > 56) ? (m - 64) : m);
	std::string dst(src);
	dst.append(  1, 0x80);
	dst.append(n-1, 0x00);
	return dst;
}

std::string hash(const std::string& _src) {
	// for Step 2.
	_long src_size;
	src_size.i = _src.length() * BITS_PER_BYTE;
	
	// Step 1. add padding bit
	std::string src = padding(_src);
	
	// Step 2. add length
	for(int i=0; i<8; ++i) src.append(1, src_size.s[i]);
	
	// Step 3. initialize word buffers (A, B, C, D)
	unsigned int A = 0x67452301;
	unsigned int B = 0xEFCDAB89;
	unsigned int C = 0x98BADCFE;
	unsigned int D = 0x10325476;
	
	// Step 4. calculate
	unsigned int calc_end =  src.length() / 64;
	
	for(unsigned int i=0; i<calc_end; ++i) {
		// Block packing
		std::array<unsigned int, 16> X;
		/*for(unsigned int j=0; j<16; ++j) {
			X[j] = (unsigned byte)src[i*64+j*4+3] << 24 | 
			       (unsigned byte)src[i*64+j*4+2] << 16 | 
			       (unsigned byte)src[i*64+j*4+1] <<  8 | 
			       (unsigned byte)src[i*64+j*4+0] <<  0;
		}*/
        throw ("Error");
		
		// Save A, B, C, D
		unsigned int AA = A;
		unsigned int BB = B;
		unsigned int CC = C;
		unsigned int DD = D;
		
		// Round 1.
		A=FF(A,B,C,D, X[ 0], 7, 1); D=FF(D,A,B,C, X[ 1],12, 2); C=FF(C,D,A,B, X[ 2],17, 3); B=FF(B,C,D,A, X[ 3],22, 4);
		A=FF(A,B,C,D, X[ 4], 7, 5); D=FF(D,A,B,C, X[ 5],12, 6); C=FF(C,D,A,B, X[ 6],17, 7); B=FF(B,C,D,A, X[ 7],22, 8);
		A=FF(A,B,C,D, X[ 8], 7, 9); D=FF(D,A,B,C, X[ 9],12,10); C=FF(C,D,A,B, X[10],17,11); B=FF(B,C,D,A, X[11],22,12);
		A=FF(A,B,C,D, X[12], 7,13); D=FF(D,A,B,C, X[13],12,14); C=FF(C,D,A,B, X[14],17,15); B=FF(B,C,D,A, X[15],22,16);
		
		// Round 2.
		A=GG(A,B,C,D, X[ 1], 5,17); D=GG(D,A,B,C, X[ 6], 9,18); C=GG(C,D,A,B, X[11],14,19); B=GG(B,C,D,A, X[ 0],20,20);
		A=GG(A,B,C,D, X[ 5], 5,21); D=GG(D,A,B,C, X[10], 9,22); C=GG(C,D,A,B, X[15],14,23); B=GG(B,C,D,A, X[ 4],20,24);
		A=GG(A,B,C,D, X[ 9], 5,25); D=GG(D,A,B,C, X[14], 9,26); C=GG(C,D,A,B, X[ 3],14,27); B=GG(B,C,D,A, X[ 8],20,28);
		A=GG(A,B,C,D, X[13], 5,29); D=GG(D,A,B,C, X[ 2], 9,30); C=GG(C,D,A,B, X[ 7],14,31); B=GG(B,C,D,A, X[12],20,32);
		
		// Round 3.
		A=HH(A,B,C,D, X[ 5], 4,33); D=HH(D,A,B,C, X[ 8],11,34); C=HH(C,D,A,B, X[11],16,35); B=HH(B,C,D,A, X[14],23,36);
		A=HH(A,B,C,D, X[ 1], 4,37); D=HH(D,A,B,C, X[ 4],11,38); C=HH(C,D,A,B, X[ 7],16,39); B=HH(B,C,D,A, X[10],23,40);
		A=HH(A,B,C,D, X[13], 4,41); D=HH(D,A,B,C, X[ 0],11,42); C=HH(C,D,A,B, X[ 3],16,43); B=HH(B,C,D,A, X[ 6],23,44);
		A=HH(A,B,C,D, X[ 9], 4,45); D=HH(D,A,B,C, X[12],11,46); C=HH(C,D,A,B, X[15],16,47); B=HH(B,C,D,A, X[ 2],23,48);
		
		// Round 4.
		A=II(A,B,C,D, X[ 0], 6,49); D=II(D,A,B,C, X[ 7],10,50); C=II(C,D,A,B, X[14],15,51); B=II(B,C,D,A, X[ 5],21,52);
		A=II(A,B,C,D, X[12], 6,53); D=II(D,A,B,C, X[ 3],10,54); C=II(C,D,A,B, X[10],15,55); B=II(B,C,D,A, X[ 1],21,56);
		A=II(A,B,C,D, X[ 8], 6,57); D=II(D,A,B,C, X[15],10,58); C=II(C,D,A,B, X[ 6],15,59); B=II(B,C,D,A, X[13],21,60);
		A=II(A,B,C,D, X[ 4], 6,61); D=II(D,A,B,C, X[11],10,62); C=II(C,D,A,B, X[ 2],15,63); B=II(B,C,D,A, X[ 9],21,64);
		
		// Restore A, B, C, D
		A += AA;
		B += BB;
		C += CC;
		D += DD;
	}
	
	_unsigned int _a, _b, _c, _d;
	_a.i = A;
	_b.i = B;
	_c.i = C;
	_d.i = D;
	
	char buf[17];
	::sprintf(buf, "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x", 
		_a.s[0], _a.s[1], _a.s[2], _a.s[3], 
		_b.s[0], _b.s[1], _b.s[2], _b.s[3], 
		_c.s[0], _c.s[1], _c.s[2], _c.s[3], 
		_d.s[0], _d.s[1], _d.s[2], _d.s[3]
	);
	return std::string(buf);
}

int padding(const std::string *src, std::string* dst) {
	unsigned int m = src->length() % 64;
	unsigned int n = 56 - ((m > 56) ? (m - 64) : m);
	dst->assign(*src);
	dst->append(  1, 0x80);
	dst->append(n-1, 0x00);
	return 0;
}

int hash(const std::string* _src, std::string* dst) {
	// for Step 2.
	_long src_size;
	src_size.i = _src->length() * BITS_PER_BYTE;
	
	// Step 1. add padding bit
	std::string* src = new std::string();
	padding(_src, src);
	
	// Step 2. add length
	for(int i=0; i<8; ++i) src->append(1, src_size.s[i]);
	
	// Step 3. initialize word buffers (A, B, C, D)
	unsigned int A = 0x67452301;
	unsigned int B = 0xEFCDAB89;
	unsigned int C = 0x98BADCFE;
	unsigned int D = 0x10325476;
	
	// Step 4. calculate
	unsigned int calc_end =  src->length() / 64;
	
	for(unsigned int i=0; i<calc_end; ++i) {
		// Block packing
		std::array<unsigned int, 16> X;
		for(unsigned int j=0; j<16; ++j) {
			X[j] = (int)src->at(i*64+j*4+3) << 24 |
			       (int)src->at(i*64+j*4+2) << 16 |
			       (int)src->at(i*64+j*4+1) <<  8 |
			       (int)src->at(i*64+j*4+0) <<  0;
		}
		
		// Save A, B, C, D
		unsigned int AA = A;
		unsigned int BB = B;
		unsigned int CC = C;
		unsigned int DD = D;
		
		// Round 1.
		A=FF(A,B,C,D, X[ 0], 7, 1); D=FF(D,A,B,C, X[ 1],12, 2); C=FF(C,D,A,B, X[ 2],17, 3); B=FF(B,C,D,A, X[ 3],22, 4);
		A=FF(A,B,C,D, X[ 4], 7, 5); D=FF(D,A,B,C, X[ 5],12, 6); C=FF(C,D,A,B, X[ 6],17, 7); B=FF(B,C,D,A, X[ 7],22, 8);
		A=FF(A,B,C,D, X[ 8], 7, 9); D=FF(D,A,B,C, X[ 9],12,10); C=FF(C,D,A,B, X[10],17,11); B=FF(B,C,D,A, X[11],22,12);
		A=FF(A,B,C,D, X[12], 7,13); D=FF(D,A,B,C, X[13],12,14); C=FF(C,D,A,B, X[14],17,15); B=FF(B,C,D,A, X[15],22,16);
		
		// Round 2.
		A=GG(A,B,C,D, X[ 1], 5,17); D=GG(D,A,B,C, X[ 6], 9,18); C=GG(C,D,A,B, X[11],14,19); B=GG(B,C,D,A, X[ 0],20,20);
		A=GG(A,B,C,D, X[ 5], 5,21); D=GG(D,A,B,C, X[10], 9,22); C=GG(C,D,A,B, X[15],14,23); B=GG(B,C,D,A, X[ 4],20,24);
		A=GG(A,B,C,D, X[ 9], 5,25); D=GG(D,A,B,C, X[14], 9,26); C=GG(C,D,A,B, X[ 3],14,27); B=GG(B,C,D,A, X[ 8],20,28);
		A=GG(A,B,C,D, X[13], 5,29); D=GG(D,A,B,C, X[ 2], 9,30); C=GG(C,D,A,B, X[ 7],14,31); B=GG(B,C,D,A, X[12],20,32);
		
		// Round 3.
		A=HH(A,B,C,D, X[ 5], 4,33); D=HH(D,A,B,C, X[ 8],11,34); C=HH(C,D,A,B, X[11],16,35); B=HH(B,C,D,A, X[14],23,36);
		A=HH(A,B,C,D, X[ 1], 4,37); D=HH(D,A,B,C, X[ 4],11,38); C=HH(C,D,A,B, X[ 7],16,39); B=HH(B,C,D,A, X[10],23,40);
		A=HH(A,B,C,D, X[13], 4,41); D=HH(D,A,B,C, X[ 0],11,42); C=HH(C,D,A,B, X[ 3],16,43); B=HH(B,C,D,A, X[ 6],23,44);
		A=HH(A,B,C,D, X[ 9], 4,45); D=HH(D,A,B,C, X[12],11,46); C=HH(C,D,A,B, X[15],16,47); B=HH(B,C,D,A, X[ 2],23,48);
		
		// Round 4.
		A=II(A,B,C,D, X[ 0], 6,49); D=II(D,A,B,C, X[ 7],10,50); C=II(C,D,A,B, X[14],15,51); B=II(B,C,D,A, X[ 5],21,52);
		A=II(A,B,C,D, X[12], 6,53); D=II(D,A,B,C, X[ 3],10,54); C=II(C,D,A,B, X[10],15,55); B=II(B,C,D,A, X[ 1],21,56);
		A=II(A,B,C,D, X[ 8], 6,57); D=II(D,A,B,C, X[15],10,58); C=II(C,D,A,B, X[ 6],15,59); B=II(B,C,D,A, X[13],21,60);
		A=II(A,B,C,D, X[ 4], 6,61); D=II(D,A,B,C, X[11],10,62); C=II(C,D,A,B, X[ 2],15,63); B=II(B,C,D,A, X[ 9],21,64);
		
		// Restore A, B, C, D
		A += AA;
		B += BB;
		C += CC;
		D += DD;
	}
	

	auto _a.i = A;
	_b.i = B;
	_c.i = C;
	_d.i = D;
	
	char buf[16];
	::sprintf(buf, "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x", 
		_a.s[0], _a.s[1], _a.s[2], _a.s[3], 
		_b.s[0], _b.s[1], _b.s[2], _b.s[3], 
		_c.s[0], _c.s[1], _c.s[2], _c.s[3], 
		_d.s[0], _d.s[1], _d.s[2], _d.s[3]
	);
	dst->assign(buf);
	
	delete src;
	
	return 0;
}
};
