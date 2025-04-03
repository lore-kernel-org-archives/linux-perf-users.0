Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E1F17BB6;
	Thu,  3 Apr 2025 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743689322; cv=none; b=DWHY+FmL6wl47hYLOMWXCt7BqtBpN4KGL7GGZ4qm3touoz/BrCTHTNMVcNoex1LTRoOUwUUM9Gm1cgnuxM1kbF14UtiYSk5Dk61glzXzK8RDDjdCygFRNTRDYgwR+2BcyOl3bkfq1p3urgw/2Ab0JPHvI+yKqeE4u5a51JWN4JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743689322; c=relaxed/simple;
	bh=9dcfeCeE1zJuHl+VAQhSUpd8FuaX6Q5GQC5LBKig2kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Stjdv5ql0Pb+TuWXNT1CIxYXsFL2QQ3Dy8ehJWP5sdQBHLhouDDm7myjmzSSmgQtZHFvuU6N0BXFZTIMB24OJWd27ByKbvUySLMJj1aKB6LEbyAhhH/0aSHIPQsVFZ+faLZk+e6YlTtKGhKus81+LJQRtWwIAAmu3XMuoHQEzHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUl/77Zd; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUl/77Zd"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736dd9c4b40so1110953b3a.0;
        Thu, 03 Apr 2025 07:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743689319; x=1744294119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BfGO2uEq0sNbHAyaLZMcu3eXezuzk8aNgQwqdy8WsyA=;
        b=iUl/77ZdiCyBafiLuiJbWm2Z3L8GuAzC9Muny+H8kvxc9G8RuhDH3LyDYyt0lss675
         HpDeyHTUW7hkf+VFSquVKR6QSiWfNJC2cKlXRFFW6jCTd9X74kxr3IGcsJ8Q2YQZ2ISK
         B4RxUC9vdmUvrMlUb2GQSjbS5+34Qlwld7MYUt1OojycjIGimUOnxTuePzRhmaTCzfEZ
         popxbtdmdw2mfrn5kza79CCY+J7DpNXTJvauP7GZangQ/sMJwUV0QtmBrN7jVLNIvSdh
         +xnHneKBsshpYD5F9rlrA5Kx2WIfs9c2l0OVCq4ZXkdiwKB4xWEXHhzIf1s0MoFSV3TZ
         zk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743689319; x=1744294119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfGO2uEq0sNbHAyaLZMcu3eXezuzk8aNgQwqdy8WsyA=;
        b=KHuiycnBlqmB17Cuagkd7/pvoIzffUxK6RJ4yGEogUbJdfEfpwTnNeDk8raa8zyD2s
         tYb9TL0dXg3+IFkko45EXmW12gs68hLE/tX75nFcCJgez8fjJxOiRom2UdqrkKGYddaQ
         XgcbcsbIfODRNvH+3hfiMXyKscJuKTwGWMlRjCorVnDplbGM6OPMAasM9vJYafNNI0Li
         CL9nXevI+hybadmFF7PS0tBRT3JQKOgqAgRn4Su5TnbvYKD8XZe8yumN/OA2B8frpqwo
         0/MQ1TnfJfJwyS7J2sT8usLrj0Yn9kitoYwovCctwpiRhLPtlVD8RCDUtoTyjoAnI+5q
         LjIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdE4F/IBRgx/Kdw+L7PzAMOP7O+3BMXdegyJ1VSsVmRplY87juZsGXo3ytnbbxi5BhYwtQnEtPP6a+/m4=@vger.kernel.org, AJvYcCWs+kvxoYeAu2YoaY/e9u/RsSuY/5/mICm0zvOj/H7pM/hQwzZCHRLM9o8xeHU2/oA3FDEZobXVOXp2dBOjAIt2nA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyP4dazdaKRcBZD3SVpW+aRJOm2/dyizWvEY2pYeojdqR1z7Q+a
	y04R76m9kuC9P5YHdI5mc+J6piierJS7fTeTeVZXJ5Iz22Tl5laB
X-Gm-Gg: ASbGnct9fERSIjmto4ENTmG53Y2ysRPLFLvSjG485Xm0oxHmVgZ0QUvbO6C9LRuu+t3
	hJjfvPAcRu7r111POnRRQYJpDl3nWDkW8SloJxv/A3JI8WA9Y0Q0G+G6sAtoKy/yFkJCEyMDOmX
	PhtjEGUnzgMhPS039iFw0k85YUWqDRurtESIx7FcrSlsN6lo9PCB6bOPVuX8EI8VGJNyOW9Cv7k
	LIlr7nTT0Jd0boFG7ncpuH2AsFeAd5vUP5rVnNRkBCUka/IbE8cdLkOROi6QYlP1ImGX3SN5+Di
	eBUwNzPxuOI10cRAVbrM3fB3947LUT3oVTUPp3Ic4fkx
X-Google-Smtp-Source: AGHT+IESFH2BfJradcXyDEA6WsbY4YNZaHB7XbGRtTQE3cZsPLyZsGet5PS6i5piNyf/zmEAFWMv1g==
X-Received: by 2002:a05:6a00:179e:b0:725:41c4:dbc7 with SMTP id d2e1a72fcca58-739d636e2bamr5120001b3a.4.1743689319132;
        Thu, 03 Apr 2025 07:08:39 -0700 (PDT)
Received: from localhost ([216.228.125.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97d1a83sm1556086b3a.13.2025.04.03.07.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 07:08:38 -0700 (PDT)
Date: Thu, 3 Apr 2025 10:08:35 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Kyle Meyer <kyle.meyer@hpe.com>,
	Ben Gainey <ben.gainey@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Eder Zulian <ezulian@redhat.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kuan-Wei Chiu <visitorckw@gmail.com>, He Zhe <zhe.he@windriver.com>,
	Dirk Gouders <dirk@gouders.net>, Brian Geffon <bgeffon@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Howard Chu <howardchu95@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jann Horn <jannh@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Yang Jihong <yangjihong@bytedance.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	Graham Woodward <graham.woodward@arm.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Hao Ge <gehao@kylinos.cn>,
	Tengda Wu <wutengda@huaweicloud.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Casey Chen <cachen@purestorage.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Li Huafei <lihuafei1@huawei.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Levi Yun <yeoreum.yun@arm.com>, Weilin Wang <weilin.wang@intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Andrew Kreimer <algonell@gmail.com>,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Junhao He <hejunhao3@huawei.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Xu Yang <xu.yang_2@nxp.com>,
	Steve Clevenger <scclevenger@os.amperecomputing.com>,
	Zixian Cai <fzczx123@gmail.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Yujie Liu <yujie.liu@intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH v1 02/48] tools headers: Silence -Wshorten-64-to-32
 warnings
Message-ID: <Z-6WY4a6RV1bEbNU@thinkpad>
References: <20250401182347.3422199-1-irogers@google.com>
 <20250401182347.3422199-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401182347.3422199-3-irogers@google.com>

On Tue, Apr 01, 2025 at 11:23:00AM -0700, Ian Rogers wrote:
> The clang warning -Wshorten-64-to-32 can be useful to catch
> inadvertent truncation. In some instances this truncation can lead to
> changing the sign of a result, for example, truncation to return an
> int to fit a sort routine. Silence the warning by making the implicit
> truncation explicit.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/include/asm-generic/bitops/fls64.h | 2 +-
>  tools/include/linux/bitfield.h           | 2 +-
>  tools/include/linux/bitmap.h             | 2 +-
>  tools/include/linux/err.h                | 2 +-
>  tools/include/linux/hash.h               | 2 +-
>  tools/include/linux/math64.h             | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/include/asm-generic/bitops/fls64.h b/tools/include/asm-generic/bitops/fls64.h
> index 866f2b2304ff..9ad3ff12f454 100644
> --- a/tools/include/asm-generic/bitops/fls64.h
> +++ b/tools/include/asm-generic/bitops/fls64.h
> @@ -21,7 +21,7 @@ static __always_inline int fls64(__u64 x)
>  	__u32 h = x >> 32;
>  	if (h)
>  		return fls(h) + 32;
> -	return fls(x);
> +	return fls((__u32)x);

Can you keep kernel and tools sources synchronized?

>  }
>  #elif BITS_PER_LONG == 64
>  static __always_inline int fls64(__u64 x)
> diff --git a/tools/include/linux/bitfield.h b/tools/include/linux/bitfield.h
> index 6093fa6db260..aa0b8e52214f 100644
> --- a/tools/include/linux/bitfield.h
> +++ b/tools/include/linux/bitfield.h
> @@ -146,7 +146,7 @@ static __always_inline __##type type##_encode_bits(base v, base field)	\
>  {									\
>  	if (__builtin_constant_p(v) && (v & ~field_mask(field)))	\
>  		__field_overflow();					\
> -	return to((v & field_mask(field)) * field_multiplier(field));	\
> +	return to((__##type)((v & field_mask(field)) * field_multiplier(field))); \
>  }									\
>  static __always_inline __##type type##_replace_bits(__##type old,	\
>  					base val, base field)		\
> diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
> index 2a7f260ef9dc..b7a7c752e4f2 100644
> --- a/tools/include/linux/bitmap.h
> +++ b/tools/include/linux/bitmap.h
> @@ -63,7 +63,7 @@ static inline bool bitmap_full(const unsigned long *src, unsigned int nbits)
>  	return find_first_zero_bit(src, nbits) == nbits;
>  }
>  
> -static inline unsigned int bitmap_weight(const unsigned long *src, unsigned int nbits)
> +static inline unsigned long bitmap_weight(const unsigned long *src, unsigned int nbits)
>  {
>  	if (small_const_nbits(nbits))
>  		return hweight_long(*src & BITMAP_LAST_WORD_MASK(nbits));

Oh no... bitmap_weight() is used in printk(), and you'll get tons of
warnings because, say %x should be replaced with %lx. 

> diff --git a/tools/include/linux/err.h b/tools/include/linux/err.h
> index 332b983ead1e..9c1746e3696d 100644
> --- a/tools/include/linux/err.h
> +++ b/tools/include/linux/err.h

I don't maintain the this and the following subsystems. Can you make
it a separate patch?

> @@ -55,7 +55,7 @@ static inline bool __must_check IS_ERR_OR_NULL(__force const void *ptr)
>  static inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
>  {
>  	if (IS_ERR(ptr))
> -		return PTR_ERR(ptr);
> +		return (int)PTR_ERR(ptr);
>  	else
>  		return 0;
>  }
> diff --git a/tools/include/linux/hash.h b/tools/include/linux/hash.h
> index 38edaa08f862..ecc8296cb397 100644
> --- a/tools/include/linux/hash.h
> +++ b/tools/include/linux/hash.h
> @@ -75,7 +75,7 @@ static __always_inline u32 hash_64_generic(u64 val, unsigned int bits)
>  {
>  #if BITS_PER_LONG == 64
>  	/* 64x64-bit multiply is efficient on all 64-bit processors */
> -	return val * GOLDEN_RATIO_64 >> (64 - bits);
> +	return (u32)(val * GOLDEN_RATIO_64 >> (64 - bits));
>  #else
>  	/* Hash 64 bits using only 32x32-bit multiply. */
>  	return hash_32((u32)val ^ __hash_32(val >> 32), bits);
> diff --git a/tools/include/linux/math64.h b/tools/include/linux/math64.h
> index 4ad45d5943dc..03d6c5220957 100644
> --- a/tools/include/linux/math64.h
> +++ b/tools/include/linux/math64.h
> @@ -48,7 +48,7 @@ static inline u64 mul_u64_u32_shr(u64 a, u32 b, unsigned int shift)
>  	u32 ah, al;
>  	u64 ret;
>  
> -	al = a;
> +	al = (u32)a;
>  	ah = a >> 32;
>  
>  	ret = mul_u32_u32(al, b) >> shift;
> -- 
> 2.49.0.504.g3bcea36a83-goog
