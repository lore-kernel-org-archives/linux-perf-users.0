Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A862289344
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Jul 2025 21:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221489; cv=none; b=eKHuaZDEfeuwjjE0OcYWxm/8krjbEek9Eb5NchCdwvhv84TJeNQ+dtQj1hGIxujVho0XcYf+BbUdm/jM2QVg/0TAY9vr8YUQsg9ZDJ/ps5s7z7BiMk7tnrLKJr91xzx8EP0UMJQyghO2zhoz4nnwUBa1mCFpAt4XWOp/nSS0M7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221489; c=relaxed/simple;
	bh=rXMYeZ6nHjuavtHWLi92BzEDLvzM5iCtn0anCHdQWC0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ezWAuBXCFt5tmvI9YKq2wEDE2MswZ3jZxcl4PbPg5XeKScCm+XK2tULYq4gmlAwMJvjviPheNCZlxa3P3tnztT/Ig1nH8Zc1ktxQFCAsX3VYkDQX9r6LNrqm1qr/Zlu+SyBcOZ6c6jZOY09HQfrBePHi0hY0ET3nnjO92DXhcHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f4Krp/8a; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f4Krp/8a"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3138e65efe2so5368596a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Jul 2025 14:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753221487; x=1753826287; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gJRSNbAVtnnRSRtWxuuhl6QaFHCsA6vuAmX7FkDxBVU=;
        b=f4Krp/8a0YEsgK14Q505jSUp77XYNt9xulReTZFG3NmEw/b1KqXLz1cMtoSL65txVZ
         xP9KcWPGsYlLHRgH54FFp8uB68vvBsdkY1jhNudZ4iYF8NLjyQgkXfiW3ltZ2FWkQas/
         JkmyuXauCXy+z3nrkdKk2g1XYIBqpe1VLbEOeNz7EJ42RVeWoUi2Gj+oowTsWwB6/C+x
         4YTN4egkI3Zs+X89LsmCGtagHLqFOBFWT6cv3RN/+wrxZzswHHdLkvZjVWflAPdNDxoz
         ulUhyoZJJu9yGFkjJHnJ1VD86E+Osce+6oD4eKsxJHlAKxzD3ttH50YqCx40Q2poyIAT
         lmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753221487; x=1753826287;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gJRSNbAVtnnRSRtWxuuhl6QaFHCsA6vuAmX7FkDxBVU=;
        b=TzQKSFLhR5Bc0IZ/1qbfk1f9LHg0eLeRRTcwmHn1y16t7wQFW9hEeaxXKUX1ZDltMZ
         N/2G6M6kl7H57ZNOCQC1x3YmCDtZoOQ8ZJw01WwIcGR6B6pZM3aBKyrwjmFdPlEQrV0l
         yvVPf0/6pKj/vzxFFU6Zrw+6Jqa/yCwkq4UFnMYKvQDHnwqmxeQfbs5991qSFfBhKeQK
         3odliQosvNnKRPtvfiViTtYBREwGbgSLfSz/4++xnFbiNrOcXDwF1t5IAQzKlwo9+OxQ
         tl+RDjmjnVMsBf5trlw2oljdt2ic0l672G1U6YUwYR/L+TtmwOv+JCFazh5k4jCB5VZx
         /7QA==
X-Forwarded-Encrypted: i=1; AJvYcCUaZs3bxXQdbUSElwOC/4+fUlhllGMTzwkaOmQCaCET6r2q3/kO6HSzaVcI7kZ4IuSunWIN2eYkH8MXQCNMxy5k@vger.kernel.org
X-Gm-Message-State: AOJu0YwsqWXK3XxujfkfZt6UOELP42ZhpPQLoSFgdHUZFc5w0AQ9XSDN
	+Y1tDsfjW8SnlGJ0+64Ia0XyFPY3HwcCi4zvrMM0lqAuATqXX0coB2+5qNhWiHX5IbOp2V2cURx
	aipVpWkdZgQ==
X-Google-Smtp-Source: AGHT+IHdhqHoxMMDAXiufK5PlecdJ/IBjH5JHd18OWhrASaqpf5K8i3TM25fRL4P6wJuPv3uT7mpBTaWZ7Q4
X-Received: from pjbqx13.prod.google.com ([2002:a17:90b:3e4d:b0:312:1c59:43a6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4e83:b0:31c:15d9:8aa
 with SMTP id 98e67ed59e1d1-31e507fe866mr1144679a91.34.1753221487472; Tue, 22
 Jul 2025 14:58:07 -0700 (PDT)
Date: Tue, 22 Jul 2025 14:57:53 -0700
In-Reply-To: <20250722215754.672330-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722215754.672330-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722215754.672330-3-irogers@google.com>
Subject: [PATCH v4 2/3] tools headers: Update the linux/unaligned.h copy with
 the kernel sources
From: Ian Rogers <irogers@google.com>
To: Eric Biggers <ebiggers@google.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

To pick up the changes in:

  e5f39a57c4c5 vdso: Switch get/put unaligned from packed struct to memcpy

As the code is dependent on __unqual_scalar_typeof, update the tools
version of compiler_types.h to include this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/linux/compiler_types.h | 22 +++++++++++++++
 tools/include/vdso/unaligned.h       | 41 ++++++++++++++++++++++++----
 2 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/tools/include/linux/compiler_types.h b/tools/include/linux/compiler_types.h
index d09f9dc172a4..890982283a5e 100644
--- a/tools/include/linux/compiler_types.h
+++ b/tools/include/linux/compiler_types.h
@@ -40,4 +40,26 @@
 #define asm_goto_output(x...) asm goto(x)
 #endif
 
+/*
+ * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
+ *			       non-scalar types unchanged.
+ */
+/*
+ * Prefer C11 _Generic for better compile-times and simpler code. Note: 'char'
+ * is not type-compatible with 'signed char', and we define a separate case.
+ */
+#define __scalar_type_to_expr_cases(type)				\
+		unsigned type:	(unsigned type)0,			\
+		signed type:	(signed type)0
+
+#define __unqual_scalar_typeof(x) typeof(				\
+		_Generic((x),						\
+			 char:	(char)0,				\
+			 __scalar_type_to_expr_cases(char),		\
+			 __scalar_type_to_expr_cases(short),		\
+			 __scalar_type_to_expr_cases(int),		\
+			 __scalar_type_to_expr_cases(long),		\
+			 __scalar_type_to_expr_cases(long long),	\
+			 default: (x)))
+
 #endif /* __LINUX_COMPILER_TYPES_H */
diff --git a/tools/include/vdso/unaligned.h b/tools/include/vdso/unaligned.h
index ff0c06b6513e..9076483c9fbb 100644
--- a/tools/include/vdso/unaligned.h
+++ b/tools/include/vdso/unaligned.h
@@ -2,14 +2,43 @@
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
+ * non-const type - you can't memcpy into a const type. The
+ * __get_unaligned_ctrl_type gives __unqual_scalar_typeof its required
+ * expression rather than type, a pointer is used to avoid warnings about mixing
+ * the use of 0 and NULL. The void* cast silences ubsan warnings.
+ */
+#define __get_unaligned_t(type, ptr) ({					\
+	type *__get_unaligned_ctrl_type __always_unused = NULL;		\
+	__unqual_scalar_typeof(*__get_unaligned_ctrl_type) __get_unaligned_val; \
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

