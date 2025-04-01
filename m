Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946BE20FA96
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Apr 2025 18:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531883; cv=none; b=EAHq5sKdhVUVaEJCE9GNtTUsmOFyIrzRw0cCPrwW/oJWDiZZmQGxVcvc0OmgzaVeoP5uvkPs9bhjMbLybbXIA+CrKBlEZLjvYlFLpe8z59K8ggSMawGGR3DubywFqwzamBqCfKaHk8T2GqQ1Zn8FJ6/W5MAwRmB2QfDP7EkPXB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531883; c=relaxed/simple;
	bh=pDEY6QUrKKu+6/w+/nx5MSD4U+mmn81kdmBZaMJfAFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=nZeZth0Q7UN15jpX8aOksULg53lSyNsTZSDhS0pHpCzZeOApQ8wSl+/oVhyfDjreujoxA6inTi+KRaXT+LJ8O9jF9RLhu0sCndxLBDnRZvEiYuzTlFizdhCMRwti7vkO6PfIe2rJ6yR90jlbj0Vw+e6EiOtMFUsFA+6Au1av1uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zRGcYc2f; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zRGcYc2f"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3055f2e1486so4310786a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Apr 2025 11:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531881; x=1744136681; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ejyIbF8uM4xzteCjzh4//KGHrg3ytk/YNXw3C8hPSCI=;
        b=zRGcYc2fA1xyaRkJux0dkHJYTC7ZksiscsUWLfh2o50zDOkq3H2NIvJIgbgIk7O5He
         1j5b70bARyUjRe3IFB3DDWAVyD6zxktpZyS7trvvg3snfiN3ylL5x7jz2XqTZJ3EYLjK
         BY3SLBlDMkXwz6oowKRx4bwz66cUvhpSzqqopaqUvGfJ1Gd+6bAkBonL7XT3XNqNMzNZ
         cviBtPGHD3w4qZ+OtDYArSD3/pHlTyVqLj/iYm6rQpk+CFtIe2v3/4dVi72d3SzjYBDA
         tdBakCcVfVtBX2VoZSeUJxka7VFM6raVkFK/pW9m7/WTwJPm2MwbL93/wxRKPV9g+LN7
         G8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531881; x=1744136681;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ejyIbF8uM4xzteCjzh4//KGHrg3ytk/YNXw3C8hPSCI=;
        b=wJg9I7hJFpxUij7DcTDMel61RgQnjD00mnh6WW94KMZEqwelwlObJoxhcC1V6STCO2
         51YvFzPAwYOXX6mW3SofnofXcgx8UWEz5DrqMfQ7FdqFRJDFIqp85lX5IDAhaVefVZFl
         sW4rkwWXmjDEuIJyE5hbHLDdNkdFbDJ82Da2C/Ijsb7NxnFVOtLIoVQlHm1OahD9wZ2H
         OVKri75bLRjwftoldJ+icJbZWFaq+6Qmc2pihpgOyIaEy6n2Lws7Io9qpevvyAwS6FVg
         lz81niaZo1NvxtUxhylWXpdT0LInhVelJ9e5H21SX9iCT5LT0QXRH9jmh5/T11vzIMDF
         SsRA==
X-Forwarded-Encrypted: i=1; AJvYcCXx+WKy0ExTV00+XA/G1eDM92omqD8voUTgjTO4S/qLv+Wi/lZCneNvRa5oboQYdRswmWTaVvZxDl30jvuZFoEw@vger.kernel.org
X-Gm-Message-State: AOJu0YxJRw6aaWjDDTKduuralsFxvuCmifiP+zOltBccIVE8Fdkk2vcO
	eakX0IZ/zgBOHuSklDsKBn8Sna1Xdq44rupJTJsOA5otb1i907uDMNZWEDm+OZNxGMZkZId+k/6
	XRwfC4Q==
X-Google-Smtp-Source: AGHT+IHKgH1xWvHb6WqzhnDdwTyWnZi/5XdVRlBtY5wQp/4b0QnFXY8X8tmjidjtAADQw2pYukFdkyHd+gGs
X-Received: from pjbhl3.prod.google.com ([2002:a17:90b:1343:b0:2f4:4222:ebba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3909:b0:2ee:9b2c:3253
 with SMTP id 98e67ed59e1d1-30532177065mr17860323a91.30.1743531880957; Tue, 01
 Apr 2025 11:24:40 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:00 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-3-irogers@google.com>
Subject: [PATCH v1 02/48] tools headers: Silence -Wshorten-64-to-32 warnings
From: Ian Rogers <irogers@google.com>
To: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Kyle Meyer <kyle.meyer@hpe.com>, 
	Ben Gainey <ben.gainey@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	Eder Zulian <ezulian@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kuan-Wei Chiu <visitorckw@gmail.com>, He Zhe <zhe.he@windriver.com>, 
	Dirk Gouders <dirk@gouders.net>, Brian Geffon <bgeffon@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Howard Chu <howardchu95@gmail.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Jann Horn <jannh@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Yang Jihong <yangjihong@bytedance.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Hao Ge <gehao@kylinos.cn>, Tengda Wu <wutengda@huaweicloud.com>, 
	Gabriele Monaco <gmonaco@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Casey Chen <cachen@purestorage.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Andrew Kreimer <algonell@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

The clang warning -Wshorten-64-to-32 can be useful to catch
inadvertent truncation. In some instances this truncation can lead to
changing the sign of a result, for example, truncation to return an
int to fit a sort routine. Silence the warning by making the implicit
truncation explicit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/asm-generic/bitops/fls64.h | 2 +-
 tools/include/linux/bitfield.h           | 2 +-
 tools/include/linux/bitmap.h             | 2 +-
 tools/include/linux/err.h                | 2 +-
 tools/include/linux/hash.h               | 2 +-
 tools/include/linux/math64.h             | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/include/asm-generic/bitops/fls64.h b/tools/include/asm-generic/bitops/fls64.h
index 866f2b2304ff..9ad3ff12f454 100644
--- a/tools/include/asm-generic/bitops/fls64.h
+++ b/tools/include/asm-generic/bitops/fls64.h
@@ -21,7 +21,7 @@ static __always_inline int fls64(__u64 x)
 	__u32 h = x >> 32;
 	if (h)
 		return fls(h) + 32;
-	return fls(x);
+	return fls((__u32)x);
 }
 #elif BITS_PER_LONG == 64
 static __always_inline int fls64(__u64 x)
diff --git a/tools/include/linux/bitfield.h b/tools/include/linux/bitfield.h
index 6093fa6db260..aa0b8e52214f 100644
--- a/tools/include/linux/bitfield.h
+++ b/tools/include/linux/bitfield.h
@@ -146,7 +146,7 @@ static __always_inline __##type type##_encode_bits(base v, base field)	\
 {									\
 	if (__builtin_constant_p(v) && (v & ~field_mask(field)))	\
 		__field_overflow();					\
-	return to((v & field_mask(field)) * field_multiplier(field));	\
+	return to((__##type)((v & field_mask(field)) * field_multiplier(field))); \
 }									\
 static __always_inline __##type type##_replace_bits(__##type old,	\
 					base val, base field)		\
diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 2a7f260ef9dc..b7a7c752e4f2 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -63,7 +63,7 @@ static inline bool bitmap_full(const unsigned long *src, unsigned int nbits)
 	return find_first_zero_bit(src, nbits) == nbits;
 }
 
-static inline unsigned int bitmap_weight(const unsigned long *src, unsigned int nbits)
+static inline unsigned long bitmap_weight(const unsigned long *src, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return hweight_long(*src & BITMAP_LAST_WORD_MASK(nbits));
diff --git a/tools/include/linux/err.h b/tools/include/linux/err.h
index 332b983ead1e..9c1746e3696d 100644
--- a/tools/include/linux/err.h
+++ b/tools/include/linux/err.h
@@ -55,7 +55,7 @@ static inline bool __must_check IS_ERR_OR_NULL(__force const void *ptr)
 static inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
 {
 	if (IS_ERR(ptr))
-		return PTR_ERR(ptr);
+		return (int)PTR_ERR(ptr);
 	else
 		return 0;
 }
diff --git a/tools/include/linux/hash.h b/tools/include/linux/hash.h
index 38edaa08f862..ecc8296cb397 100644
--- a/tools/include/linux/hash.h
+++ b/tools/include/linux/hash.h
@@ -75,7 +75,7 @@ static __always_inline u32 hash_64_generic(u64 val, unsigned int bits)
 {
 #if BITS_PER_LONG == 64
 	/* 64x64-bit multiply is efficient on all 64-bit processors */
-	return val * GOLDEN_RATIO_64 >> (64 - bits);
+	return (u32)(val * GOLDEN_RATIO_64 >> (64 - bits));
 #else
 	/* Hash 64 bits using only 32x32-bit multiply. */
 	return hash_32((u32)val ^ __hash_32(val >> 32), bits);
diff --git a/tools/include/linux/math64.h b/tools/include/linux/math64.h
index 4ad45d5943dc..03d6c5220957 100644
--- a/tools/include/linux/math64.h
+++ b/tools/include/linux/math64.h
@@ -48,7 +48,7 @@ static inline u64 mul_u64_u32_shr(u64 a, u32 b, unsigned int shift)
 	u32 ah, al;
 	u64 ret;
 
-	al = a;
+	al = (u32)a;
 	ah = a >> 32;
 
 	ret = mul_u32_u32(al, b) >> shift;
-- 
2.49.0.504.g3bcea36a83-goog

