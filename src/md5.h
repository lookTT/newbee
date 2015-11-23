/********************************************************************
 COPYRIGHT NOTICE
 Copyright (c) 2011
 All rights reserved.
 created:    2014/03/20   10:26
 filename:   md5

 author:
 brief:      md5
 notice:
 purpose:
 *********************************************************************/
#ifndef _MD5_H_
#define _MD5_H_

#include <cstring>
#include <iostream>

// a small class for calculating MD5 hashes of strings or byte arrays
// it is not meant to be fast or secure
//
// usage: 1) feed it blocks of uchars with update()
//      2) finalize()
//      3) get hexdigest() string
//      or
//      MD5(std::string).hexdigest()
//
// assumes that char is 8 bit and int is 32 bit
class MD5 {
public:
    typedef unsigned int size_type; // must be 32bit

    MD5();
    MD5(const std::string& text);
    void update(const unsigned char *buf, size_type length);
    void update(const char *buf, size_type length);
    MD5& finalize();
    std::string hexdigest() const;
    friend std::ostream& operator<<(std::ostream&, MD5 md5);

private:
    void init();
    typedef unsigned char uint8; //  8bit
    typedef unsigned int uint32; // 32bit
    enum {
        blocksize = 64
    }; // VC6 won't eat a const static int here

    void transform(const uint8 block[blocksize]);
    static void decode(uint32 output[], const uint8 input[], size_type len);
    static void encode(uint8 output[], const uint32 input[], size_type len);

    bool finalized;
    uint8 buffer[blocksize]; // bytes that didn't fit in last 64 byte chunk
    uint32 count[2]; // 64bit counter for number of bits (lo, hi)
    uint32 state[4]; // digest so far
    uint8 digest[16]; // the result

    // low level logic operations
    static inline uint32 F(uint32 x, uint32 y, uint32 z);
    static inline uint32 G(uint32 x, uint32 y, uint32 z);
    static inline uint32 H(uint32 x, uint32 y, uint32 z);
    static inline uint32 I(uint32 x, uint32 y, uint32 z);
    static inline uint32 rotate_left(uint32 x, int n);
    static inline void FF(uint32 &a, uint32 b, uint32 c, uint32 d, uint32 x, uint32 s, uint32 ac);
    static inline void GG(uint32 &a, uint32 b, uint32 c, uint32 d, uint32 x, uint32 s, uint32 ac);
    static inline void HH(uint32 &a, uint32 b, uint32 c, uint32 d, uint32 x, uint32 s, uint32 ac);
    static inline void II(uint32 &a, uint32 b, uint32 c, uint32 d, uint32 x, uint32 s, uint32 ac);
};

std::string md5(const std::string str);

#endif // _MD5_H_
