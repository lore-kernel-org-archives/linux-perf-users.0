Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5284F218858
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Jun 2025 05:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750916915; cv=none; b=BltFHkjzL2r2hSNkCxc4EFXt6d8WYy1nUuVpotg2DvbwU8fzsZDEC9p82x7gYs2uL7il1/EzCgwTDPnpMjlQ/Otaj7P3opLMRp5iWhIjzNMvz3a1K4siUobTVFVzJSzYMzZk3LO3QUCZ0eihABcNLUHU0+rx2B5sE7yeurbUZjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750916915; c=relaxed/simple;
	bh=NUQiHaB/oRFvduMBrU+FyUVv6t6Xgm9DuO0q9cjaySQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MCUYEI91t2ucCZA2LCHCz5EG7D73X+2f9Gar5omPW6HJNQCYzNMZjq123SPcQR6jTS25Wk23+7zMOs5/zqWLoTV03fWSLAm+stn9mF1f4oPzjJb2ltp+eH5er0t1+Ud3+wdfl8z2kUtz3xxsYs+S9WL7dOMUyLTD2Y30sZCd3IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sD7pKzYr; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sD7pKzYr"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311a6b43ed7so457995a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Jun 2025 22:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750916914; x=1751521714; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R1vSzONkvWVxKMWdZPze+udgL8T24sLZ921TIUfWjXQ=;
        b=sD7pKzYr4gCmmQyqLYn4JkEluNyEz5B0TZTFFjysiO/UZaeRR9UrsR0NiF+xUAkSKM
         jY9CAKRCOBQ5k7ysSvEmcbO8LYHZPDEnIlS4GjdZA8xonlb3ryOg2EoD3ib6sF5Ff0I6
         oPKG0UXIKUSyOI9Aqz1vvaP4Rtz5SbXeouzC3SJpP2yE9tMOLtynHK77R8/RgZCJW3/Z
         4rFerA7y7gwr/IMzNgouQxUFgVxKJXNf2DtW0JcLPW6vZI01DOQ9vYpfL4oA6S/8VtVV
         OUAKSqkuCBSfXoCEA54RcWVid4UEu3cuWi+MItb3Ejzi7OmQ2AuzU/psO3Be985iTUS3
         +HoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750916914; x=1751521714;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1vSzONkvWVxKMWdZPze+udgL8T24sLZ921TIUfWjXQ=;
        b=nSAk09slLLyF9pz+1L0KH5Yi8XMzfSrSZwsflu39saTIJtwzMSQTt1N2QV+sjZjxnw
         sGWQJj3wjEa5ZfcSXuBMvYwtnjfSVqQjHerKt43bNxc8C+wE9CaeiMYjxO0NUtqa+W6p
         YaJ0hX2fGppBOdQSnFw7HClU7Gqa8nuVIpkOLQgrNunMDxTt6D4TwlKJlq+XDvMV5fmR
         AwyirpPX93Qkbat0s1KOY6V7dq7aJseJr9u5PpBuL9/w3TIbh2zcOxCkHCmceeRQRvax
         kAnogQeFJPymcr11MbtJs1Euvp6NFQRngXqFqI+oxLNgQwEjB6cBbwa/HD9iSfe5jTeA
         /CXw==
X-Forwarded-Encrypted: i=1; AJvYcCUiJiO0S101XGa+iy0B7pLg+o0PLctLhZWGvowKs45QFeMtLjioW0L6YmywXbBMbFbtfap91mzTe/0Hl4W5oSzi@vger.kernel.org
X-Gm-Message-State: AOJu0YxFJ/rOXF3yuk8arsDT0hyYt/DjnAoFifvZ3Etz7onVE9BjdfZN
	AYwjQaogDq4ogIKgwx1pVdfJOfMYHjpoXtEX/0yatoblQLwHgQZLQXbxGmd5/1MXI0B3jf577kc
	uIJmUuxP2dg==
X-Google-Smtp-Source: AGHT+IEs8IO1q36YQk0nSSiSi5GU+GN5WZXfosdQGqxbw2barm/yUUYBYTVH1YWmhz9R0wChcSGLtxRfAZXS
X-Received: from pjbsv14.prod.google.com ([2002:a17:90b:538e:b0:312:fb53:41c0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f0c:b0:312:26d9:d5b4
 with SMTP id 98e67ed59e1d1-315f2674a05mr9030490a91.17.1750916913698; Wed, 25
 Jun 2025 22:48:33 -0700 (PDT)
Date: Wed, 25 Jun 2025 22:48:24 -0700
In-Reply-To: <20250626054826.433453-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250626054826.433453-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250626054826.433453-2-irogers@google.com>
Subject: [PATCH v3 1/3] vdso: Switch get/put unaligned from packed struct to memcpy
From: Ian Rogers <irogers@google.com>
To: Eric Biggers <ebiggers@google.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Type punning is necessary for get/put unaligned but the use of a
packed struct violates strict aliasing rules, requiring
-fno-strict-aliasing to be passed to the C compiler. Switch to using
memcpy so that -fno-strict-aliasing isn't necessary.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/vdso/unaligned.h | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/include/vdso/unaligned.h b/include/vdso/unaligned.h
index ff0c06b6513e..0ccbcc9aa493 100644
--- a/include/vdso/unaligned.h
+++ b/include/vdso/unaligned.h
@@ -2,14 +2,41 @@
 #ifndef __VDSO_UNALIGNED_H
 #define __VDSO_UNALIGNED_H
 
-#define __get_unaligned_t(type, ptr) ({							\
-	const struct { type x; } __packed * __get_pptr = (typeof(__get_pptr))(ptr);	\
-	__get_pptr->x;									\
+#include <linux/compiler_types.h>
+
+/**
+ * __get_unaligned_t - read an unaligned value from memory.
+ * @type:	the type to load from the pointer.
+ * @ptr:	the pointer to load from.
+ *
+ * Use memcpy to affect an unaligned type sized load avoiding undefined behavior
+ * from approaches like type punning that require -fno-strict-aliasing in order
+ * to be correct. As type may be const, use __unqual_scalar_typeof to map to a
+ * non-const type - you can't memcpy into a const type. The void* cast silences
+ * ubsan warnings.
+ */
+#define __get_unaligned_t(type, ptr) ({					\
+	type __get_unaligned_ctrl_type __always_unused;			\
+	__unqual_scalar_typeof(__get_unaligned_ctrl_type) __get_unaligned_val; \
+	__builtin_memcpy(&__get_unaligned_val, (void *)(ptr),		\
+			 sizeof(__get_unaligned_val));			\
+	__get_unaligned_val;						\
 })
 
-#define __put_unaligned_t(type, val, ptr) do {						\
-	struct { type x; } __packed * __put_pptr = (typeof(__put_pptr))(ptr);		\
-	__put_pptr->x = (val);								\
+/**
+ * __put_unaligned_t - write an unaligned value to memory.
+ * @type:	the type of the value to store.
+ * @val:	the value to store.
+ * @ptr:	the pointer to store to.
+ *
+ * Use memcpy to affect an unaligned type sized store avoiding undefined
+ * behavior from approaches like type punning that require -fno-strict-aliasing
+ * in order to be correct. The void* cast silences ubsan warnings.
+ */
+#define __put_unaligned_t(type, val, ptr) do {				\
+	type __put_unaligned_val = (val);				\
+	__builtin_memcpy((void *)(ptr), &__put_unaligned_val,		\
+			 sizeof(__put_unaligned_val));			\
 } while (0)
 
 #endif /* __VDSO_UNALIGNED_H */
-- 
2.50.0.727.gbf7dc18ff4-goog

