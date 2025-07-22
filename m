Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BD52877E5
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Jul 2025 21:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221487; cv=none; b=tcrZW14xKhl0bKcvxaQaDNiFGhBZW9awTMvMNIbHSyonc7EbGVNJgPIvt1/uxandt8DaPkrttj84SurwSoJe2nVs4LuyhHDSfiWF9+n/Qiu+dZSkhkchobZfYk3LLcldo8n1mQAzEkq7vQF5yprtxMq852yRMT9NmAHLrourL5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221487; c=relaxed/simple;
	bh=dPokapA0VT0ZnXYTCDP2a7rcIZaZMOL43bSgz1bdtMI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qD1QVta71htDQQjtvNW46rSQ+i0ddnrMRzbA6U/iRuB2jAwx6QVpd0oQwN1j8t0MwvIkikBfrApGbh/JsgadXr1pv/72aojGxCLfZ0qPrqv/D9rkVSO4T6kMlEpPXkRGaXMF3mDwRrM1yDar6qWvtouerD+4JedaqKqJQZlrUZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1fV7J+vD; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1fV7J+vD"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31202bbaafaso5122817a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Jul 2025 14:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753221485; x=1753826285; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ex2r39vcgr2S7UXWSrh8npW0q87ZA58tBDtcoAjsEk=;
        b=1fV7J+vDHTqUNZTUd+8ChLp8JZ3q4Wg9F9b7Y1jd1sJQCOjm8nwILHy3cHKeO2Bc7t
         y3A/ZaUm/D/cEoz9kYenKGYUW5iDBTc0ydcUr5DG+wyQ1n1hYOhymBwOyfKf5n80hX7n
         oRt4ZMMYLZumHGKqmA23Qbn3yYu+kU5tMDL8qzBVFxcxUAC7fFTp+2xPhZp9vOVtSjKK
         me695lBOfsvLhc616pbYLOeDvAWipS1hjPkQyXLQchTptBT9EMH1q2sNoHd+F6qodxxr
         NktkGCWwedFH3jw8yiAkJxd7Y+2/LjYUnfhtk0rdibTCkIZNBrXaRzwQZ4Wlm4D7tTCC
         D4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753221485; x=1753826285;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ex2r39vcgr2S7UXWSrh8npW0q87ZA58tBDtcoAjsEk=;
        b=RMnn7Xigxf5u532rQKCMdg23lEYQfnFeRC+wVxN85sncTzslEh3xHUBQx7IhZa1Evw
         luMocO9/mn6Sb9gpUCcGrjjYutMOJhpEewzULzLS7DWdJy1EAtYKnDr/dA5/B4FySxI7
         5wxSGxpsul6PJlhhtQWS8SSfA09Di+W3aaObgkaypXRGo2zWz1JKlCyqafpWV6JQcRvE
         KyCddvkuwCYLAB5q8rpUTdqu9Lu69AuUKe/SM3oIC7QXWUVNWc98tTTbiM7UmCNBOiSd
         JfPhatiXuQt0LCPS6Cn0j1BXRro5E4jCi0/EwzY6ZgJSlmHNLtHk1pnqyuWhzX/V8Kh5
         P5sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhJ32bZhkv+Eo7rJzVqw8K/pXOiI7NeEKxH0dOKmF4/AjAsNSeUKOuhZEulid8/XwRQZRB/hje3b8lXeIDJbFo@vger.kernel.org
X-Gm-Message-State: AOJu0YwUKoabw112dls8czZxyOlNSaH1f+Q9NfjOcmGRjagVN9KcsPIk
	yk0A/LdzGAuqPUy3eBvPlvTkGq2aNDV0W3iIoQUzuzNREZwps+hj7lTrAkOtxCKzh/s5TWeQb60
	VoaDXrK63Kg==
X-Google-Smtp-Source: AGHT+IFHjCyshWMiMylV9kR4oGPMWesB02y/L8dbpSt1huhYstubrB/LU+NNIVLFr/jyTqh/1k1ekykqex5b
X-Received: from pjp6.prod.google.com ([2002:a17:90b:55c6:b0:30e:5bd5:880d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4fc3:b0:311:9c1f:8524
 with SMTP id 98e67ed59e1d1-31e507cdde8mr1232496a91.15.1753221485505; Tue, 22
 Jul 2025 14:58:05 -0700 (PDT)
Date: Tue, 22 Jul 2025 14:57:52 -0700
In-Reply-To: <20250722215754.672330-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722215754.672330-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722215754.672330-2-irogers@google.com>
Subject: [PATCH v4 1/3] vdso: Switch get/put unaligned from packed struct to memcpy
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
 include/vdso/unaligned.h | 41 ++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/include/vdso/unaligned.h b/include/vdso/unaligned.h
index ff0c06b6513e..9076483c9fbb 100644
--- a/include/vdso/unaligned.h
+++ b/include/vdso/unaligned.h
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

