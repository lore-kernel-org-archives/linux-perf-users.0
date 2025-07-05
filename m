Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5271EA73;
	Sat,  5 Jul 2025 00:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751674021; cv=none; b=Kgbe1MbR0Z7Yi+ND13A424eehoTAnzMKKSf+DaVhtKJRu1pTOHGFtAr2q/OJbiiAZO0uNPi7zesBR0xdS1RU5ss6FxqTGRWNHUO75x4TlqQt/t/Aus+ABEohYzFfSSVl1DjJv570yGL8L3+HUhxbppxxdolyZa2ridqy9uRCY6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751674021; c=relaxed/simple;
	bh=nHhozjQMuQsDfHnwJXb0d+s58PTdmBZTEQbR3i2FFwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSBdXtR7eEJcL5/rdE88wXuXeM6pMFDiU9LITdG08K80ht/pzQyqKc/QV8ZKRIG5y8hYLEb9aqEMMuRvj6/I4F+CF+DqeZpTH6yWY5Nhwd8uQZtpJXv8JmIfEr8K4zbvByk9LwJoOKY6jGEj3RIeNXsGbRtiTRnE644K6J5eEMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ACpfRFrH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ACpfRFrH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751674020; x=1783210020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nHhozjQMuQsDfHnwJXb0d+s58PTdmBZTEQbR3i2FFwA=;
  b=ACpfRFrHXlda120Lca72yZDb/kCB+nBzxweErf/Y3EICTOaKvJUwjgdI
   oXywFzUsqXg48SmIWlYv2o0CJ3BY2G+ZfOVUjx9zcSwGi1xg12QxoKQJS
   qRtega6TADNrjYfZHoOQUDtlF9aQiqJ1iS78HaySqGjrOxU4X0vfd6NLm
   ZwWbbADy5+KrteNoc46rIN1OkSWdbpX5NDnvg8yUGBlTShsuOuhLkaGLk
   RkWauSI0taoVBdv3FR3rgc0scyhTIZCopxAD/Otbt+wUgRbYDIiAUFJQf
   zYmWxWun+Yi8jKuS8kq1zknXKVTrvx1poSEIlfc84I1WWei38LMbfJoNk
   g==;
X-CSE-ConnectionGUID: aKvCfEoLQWm/m/mQPBDXsw==
X-CSE-MsgGUID: qpi/MeopS56YLJbXI/1zVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11484"; a="53920113"
X-IronPort-AV: E=Sophos;i="6.16,288,1744095600"; 
   d="scan'208";a="53920113"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 17:06:59 -0700
X-CSE-ConnectionGUID: 11vq7LHOQgyN0dOTXdL6IQ==
X-CSE-MsgGUID: cTL/acvTScORHd4KBm5Puw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,288,1744095600"; 
   d="scan'208";a="159283660"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 04 Jul 2025 17:06:55 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXqQe-00049T-36;
	Sat, 05 Jul 2025 00:06:52 +0000
Date: Sat, 5 Jul 2025 08:05:54 +0800
From: kernel test robot <lkp@intel.com>
To: Ian Rogers <irogers@google.com>, Eric Biggers <ebiggers@google.com>,
	Yuzhuo Jing <yuzhuo@google.com>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v3 1/3] vdso: Switch get/put unaligned from packed struct
 to memcpy
Message-ID: <202507050736.b4hX0Xks-lkp@intel.com>
References: <20250626054826.433453-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626054826.433453-2-irogers@google.com>

Hi Ian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on tip/timers/vdso v6.16-rc4 next-20250704]
[cannot apply to acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ian-Rogers/vdso-Switch-get-put-unaligned-from-packed-struct-to-memcpy/20250626-135005
base:   linus/master
patch link:    https://lore.kernel.org/r/20250626054826.433453-2-irogers%40google.com
patch subject: [PATCH v3 1/3] vdso: Switch get/put unaligned from packed struct to memcpy
config: s390-randconfig-002-20250705 (https://download.01.org/0day-ci/archive/20250705/202507050736.b4hX0Xks-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 61529d9e36fa86782a2458e6bdeedf7f376ef4b5)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250705/202507050736.b4hX0Xks-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507050736.b4hX0Xks-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/s390/boot/decompressor.c:48:
   In file included from arch/s390/include/uapi/../../../../lib/decompress_unlz4.c:10:
   In file included from arch/s390/include/uapi/../../../../lib/lz4/lz4_decompress.c:36:
>> arch/s390/include/uapi/../../../../lib/lz4/lz4defs.h:109:9: warning: default initialization of an object of type 'typeof (*((const U16 *)ptr))' (aka 'const unsigned short') leaves the object uninitialized [-Wdefault-const-init-var-unsafe]
     109 |         return get_unaligned((const U16 *)ptr);
         |                ^
   include/linux/unaligned.h:13:28: note: expanded from macro 'get_unaligned'
      13 | #define get_unaligned(ptr)      __get_unaligned_t(typeof(*(ptr)), (ptr))
         |                                 ^
   include/vdso/unaligned.h:19:7: note: expanded from macro '__get_unaligned_t'
      19 |         type __get_unaligned_ctrl_type __always_unused;                 \
         |              ^
   In file included from arch/s390/boot/decompressor.c:48:
   In file included from arch/s390/include/uapi/../../../../lib/decompress_unlz4.c:10:
   In file included from arch/s390/include/uapi/../../../../lib/lz4/lz4_decompress.c:36:
>> arch/s390/include/uapi/../../../../lib/lz4/lz4defs.h:114:9: warning: default initialization of an object of type 'typeof (*((const U32 *)ptr))' (aka 'const unsigned int') leaves the object uninitialized [-Wdefault-const-init-var-unsafe]
     114 |         return get_unaligned((const U32 *)ptr);
         |                ^
   include/linux/unaligned.h:13:28: note: expanded from macro 'get_unaligned'
      13 | #define get_unaligned(ptr)      __get_unaligned_t(typeof(*(ptr)), (ptr))
         |                                 ^
   include/vdso/unaligned.h:19:7: note: expanded from macro '__get_unaligned_t'
      19 |         type __get_unaligned_ctrl_type __always_unused;                 \
         |              ^
   In file included from arch/s390/boot/decompressor.c:48:
   In file included from arch/s390/include/uapi/../../../../lib/decompress_unlz4.c:10:
   In file included from arch/s390/include/uapi/../../../../lib/lz4/lz4_decompress.c:36:
>> arch/s390/include/uapi/../../../../lib/lz4/lz4defs.h:119:9: warning: default initialization of an object of type 'typeof (*((const size_t *)ptr))' (aka 'const unsigned long') leaves the object uninitialized [-Wdefault-const-init-var-unsafe]
     119 |         return get_unaligned((const size_t *)ptr);
         |                ^
   include/linux/unaligned.h:13:28: note: expanded from macro 'get_unaligned'
      13 | #define get_unaligned(ptr)      __get_unaligned_t(typeof(*(ptr)), (ptr))
         |                                 ^
   include/vdso/unaligned.h:19:7: note: expanded from macro '__get_unaligned_t'
      19 |         type __get_unaligned_ctrl_type __always_unused;                 \
         |              ^
   In file included from arch/s390/boot/decompressor.c:48:
   In file included from arch/s390/include/uapi/../../../../lib/decompress_unlz4.c:10:
   In file included from arch/s390/include/uapi/../../../../lib/lz4/lz4_decompress.c:36:
>> arch/s390/include/uapi/../../../../lib/lz4/lz4defs.h:156:10: warning: default initialization of an object of type 'typeof (*((const U64 *)src))' (aka 'const unsigned long long') leaves the object uninitialized [-Wdefault-const-init-var-unsafe]
     156 |         U64 a = get_unaligned((const U64 *)src);
         |                 ^
   include/linux/unaligned.h:13:28: note: expanded from macro 'get_unaligned'
      13 | #define get_unaligned(ptr)      __get_unaligned_t(typeof(*(ptr)), (ptr))
         |                                 ^
   include/vdso/unaligned.h:19:7: note: expanded from macro '__get_unaligned_t'
      19 |         type __get_unaligned_ctrl_type __always_unused;                 \
         |              ^
   In file included from arch/s390/boot/decompressor.c:48:
   arch/s390/include/uapi/../../../../lib/decompress_unlz4.c:160:29: warning: passing 'u8 *' (aka 'unsigned char *') to parameter of type 'const char *' converts between pointers to integer types where one is of the unique plain 'char' type and the other is not [-Wpointer-sign]
     160 |                 ret = LZ4_decompress_fast(inp, outp, dest_len);
         |                                           ^~~
   arch/s390/include/uapi/../../../../lib/lz4/lz4_decompress.c:477:37: note: passing argument to parameter 'source' here
     477 | int LZ4_decompress_fast(const char *source, char *dest, int originalSize)
         |                                     ^
   In file included from arch/s390/boot/decompressor.c:48:
   arch/s390/include/uapi/../../../../lib/decompress_unlz4.c:160:34: warning: passing 'u8 *' (aka 'unsigned char *') to parameter of type 'char *' converts between pointers to integer types where one is of the unique plain 'char' type and the other is not [-Wpointer-sign]
     160 |                 ret = LZ4_decompress_fast(inp, outp, dest_len);
         |                                                ^~~~
   arch/s390/include/uapi/../../../../lib/lz4/lz4_decompress.c:477:51: note: passing argument to parameter 'dest' here
     477 | int LZ4_decompress_fast(const char *source, char *dest, int originalSize)
         |                                                   ^
   6 warnings generated.


vim +109 arch/s390/include/uapi/../../../../lib/lz4/lz4defs.h

4e1a33b105ddf2 Sven Schmidt 2017-02-24  103  
4e1a33b105ddf2 Sven Schmidt 2017-02-24  104  /*-************************************
4e1a33b105ddf2 Sven Schmidt 2017-02-24  105   *	Reading and writing into memory
4e1a33b105ddf2 Sven Schmidt 2017-02-24  106   **************************************/
4e1a33b105ddf2 Sven Schmidt 2017-02-24  107  static FORCE_INLINE U16 LZ4_read16(const void *ptr)
4e1a33b105ddf2 Sven Schmidt 2017-02-24  108  {
4e1a33b105ddf2 Sven Schmidt 2017-02-24 @109  	return get_unaligned((const U16 *)ptr);
4e1a33b105ddf2 Sven Schmidt 2017-02-24  110  }
4e1a33b105ddf2 Sven Schmidt 2017-02-24  111  
4e1a33b105ddf2 Sven Schmidt 2017-02-24  112  static FORCE_INLINE U32 LZ4_read32(const void *ptr)
4e1a33b105ddf2 Sven Schmidt 2017-02-24  113  {
4e1a33b105ddf2 Sven Schmidt 2017-02-24 @114  	return get_unaligned((const U32 *)ptr);
4e1a33b105ddf2 Sven Schmidt 2017-02-24  115  }
4e1a33b105ddf2 Sven Schmidt 2017-02-24  116  
4e1a33b105ddf2 Sven Schmidt 2017-02-24  117  static FORCE_INLINE size_t LZ4_read_ARCH(const void *ptr)
4e1a33b105ddf2 Sven Schmidt 2017-02-24  118  {
4e1a33b105ddf2 Sven Schmidt 2017-02-24 @119  	return get_unaligned((const size_t *)ptr);
4e1a33b105ddf2 Sven Schmidt 2017-02-24  120  }
4e1a33b105ddf2 Sven Schmidt 2017-02-24  121  
4e1a33b105ddf2 Sven Schmidt 2017-02-24  122  static FORCE_INLINE void LZ4_write16(void *memPtr, U16 value)
4e1a33b105ddf2 Sven Schmidt 2017-02-24  123  {
4e1a33b105ddf2 Sven Schmidt 2017-02-24  124  	put_unaligned(value, (U16 *)memPtr);
4e1a33b105ddf2 Sven Schmidt 2017-02-24  125  }
4e1a33b105ddf2 Sven Schmidt 2017-02-24  126  
4e1a33b105ddf2 Sven Schmidt 2017-02-24  127  static FORCE_INLINE void LZ4_write32(void *memPtr, U32 value)
4e1a33b105ddf2 Sven Schmidt 2017-02-24  128  {
4e1a33b105ddf2 Sven Schmidt 2017-02-24  129  	put_unaligned(value, (U32 *)memPtr);
4e1a33b105ddf2 Sven Schmidt 2017-02-24  130  }
4e1a33b105ddf2 Sven Schmidt 2017-02-24  131  
4e1a33b105ddf2 Sven Schmidt 2017-02-24  132  static FORCE_INLINE U16 LZ4_readLE16(const void *memPtr)
4e1a33b105ddf2 Sven Schmidt 2017-02-24  133  {
4e1a33b105ddf2 Sven Schmidt 2017-02-24  134  	return get_unaligned_le16(memPtr);
4e1a33b105ddf2 Sven Schmidt 2017-02-24  135  }
4e1a33b105ddf2 Sven Schmidt 2017-02-24  136  
4e1a33b105ddf2 Sven Schmidt 2017-02-24  137  static FORCE_INLINE void LZ4_writeLE16(void *memPtr, U16 value)
4e1a33b105ddf2 Sven Schmidt 2017-02-24  138  {
4e1a33b105ddf2 Sven Schmidt 2017-02-24  139  	return put_unaligned_le16(value, memPtr);
4e1a33b105ddf2 Sven Schmidt 2017-02-24  140  }
4e1a33b105ddf2 Sven Schmidt 2017-02-24  141  
b1a3e75e466d96 Nick Terrell 2020-08-14  142  /*
b1a3e75e466d96 Nick Terrell 2020-08-14  143   * LZ4 relies on memcpy with a constant size being inlined. In freestanding
b1a3e75e466d96 Nick Terrell 2020-08-14  144   * environments, the compiler can't assume the implementation of memcpy() is
b1a3e75e466d96 Nick Terrell 2020-08-14  145   * standard compliant, so apply its specialized memcpy() inlining logic. When
b1a3e75e466d96 Nick Terrell 2020-08-14  146   * possible, use __builtin_memcpy() to tell the compiler to analyze memcpy()
b1a3e75e466d96 Nick Terrell 2020-08-14  147   * as-if it were standard compliant, so it can inline it in freestanding
b1a3e75e466d96 Nick Terrell 2020-08-14  148   * environments. This is needed when decompressing the Linux Kernel, for example.
b1a3e75e466d96 Nick Terrell 2020-08-14  149   */
b1a3e75e466d96 Nick Terrell 2020-08-14  150  #define LZ4_memcpy(dst, src, size) __builtin_memcpy(dst, src, size)
89b158635ad795 Gao Xiang    2020-12-15  151  #define LZ4_memmove(dst, src, size) __builtin_memmove(dst, src, size)
b1a3e75e466d96 Nick Terrell 2020-08-14  152  
4e1a33b105ddf2 Sven Schmidt 2017-02-24  153  static FORCE_INLINE void LZ4_copy8(void *dst, const void *src)
4e1a33b105ddf2 Sven Schmidt 2017-02-24  154  {
4e1a33b105ddf2 Sven Schmidt 2017-02-24  155  #if LZ4_ARCH64
4e1a33b105ddf2 Sven Schmidt 2017-02-24 @156  	U64 a = get_unaligned((const U64 *)src);
4e1a33b105ddf2 Sven Schmidt 2017-02-24  157  
4e1a33b105ddf2 Sven Schmidt 2017-02-24  158  	put_unaligned(a, (U64 *)dst);
c72ac7a1a926db Chanho Min   2013-07-08  159  #else
4e1a33b105ddf2 Sven Schmidt 2017-02-24  160  	U32 a = get_unaligned((const U32 *)src);
4e1a33b105ddf2 Sven Schmidt 2017-02-24  161  	U32 b = get_unaligned((const U32 *)src + 1);
4e1a33b105ddf2 Sven Schmidt 2017-02-24  162  
4e1a33b105ddf2 Sven Schmidt 2017-02-24  163  	put_unaligned(a, (U32 *)dst);
4e1a33b105ddf2 Sven Schmidt 2017-02-24  164  	put_unaligned(b, (U32 *)dst + 1);
c72ac7a1a926db Chanho Min   2013-07-08  165  #endif
4e1a33b105ddf2 Sven Schmidt 2017-02-24  166  }
cffb78b0e0b3a3 Kyungsik Lee 2013-07-08  167  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
