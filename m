Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAC6184540
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Jun 2025 00:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750121888; cv=none; b=bGDNKvVQgkrc1OFF2XqigxQskCusMLLK5AvA60rYdlVUj1L6dYhrBxoaBlDzPs3rTgV/VBAop6Sjn8YNpAqVaAgwcFRcyiAmWr9Yja5Zocw6ZGuCG+zGRy6UvXesSMi0FFKHzPolVYHmdkJ61KtzuFuK2vDu2bfoxVwh5ZBDrwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750121888; c=relaxed/simple;
	bh=ezXQxffGUm/N21R31wGvxcP7sZsH798tuK9vM2l8yro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HXcFmr8GyIH3jZWLFMS1P9/ml5ZYbiv0E9ZsAHp9+586BUBHhgxDYp3hc6azqwXshHjXrNA0ydngr79Dv/hYKJlALwqCCJ5iveUz15S0XJaqL9Jj62H1Fhpk8wFxyCL8nWDXCcS2GVbbzH3Q3p2S/tsmAvW2BEVhLx+qONDpMtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vQqqUW//; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vQqqUW//"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2354ba59eb6so81545855ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Jun 2025 17:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750121886; x=1750726686; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CatSxviQnQQXcOPS7tCB3W+qCBU/OOQzo4LFBFnEc0A=;
        b=vQqqUW//sxEqet6UU4gVFVSqsQCyyzwBSjMFkvPTHUC7KepkctpkzhIjsMdRzj0/0O
         nqOvMgjJTjG5k5AN19caBB5ta8QIHuTicFBJZQpkpmviKCr2ZjVM002yEdUp6WEf2j+y
         1wdfdjWn15jxm0BLv2K1SBYkmNd33KHqM9aFN0AJnbjoah3kTUhiG+y7WItdT9EYb6zT
         NyWDbGl4wmLquLKXV2+aDyKxUgyDeQCYFVIGLgSNJXUjc+TmrIiRQWYZQcuWvhfh1BHj
         P753u2p/+2KV7Zyqjj9TbJiDlFBzwsdNqMN21FFTlVRm5zaZhdh/fOgRsdbCrYNg5ViZ
         9MbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750121886; x=1750726686;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CatSxviQnQQXcOPS7tCB3W+qCBU/OOQzo4LFBFnEc0A=;
        b=mD9QuqBKDsr9dmCI8sI8Ci58NxZDHoCuRrHXa73ALQCCq5lq/vynqCW2hAQQFBH38w
         Zie3cwpUzG/YpOXn3+WvbVr3apyYCfT8y6D+D3KDwoj+CoSnTb7a4FbpBYFXUk9sDXmP
         ChcSluFMmBLzzZ78vXjneKTEu1ZV2GBxxNZyfYhyVj/M/mnyDdYhkC2Cp4epwHOSTZ+P
         V6MOGCs7jpvUZqj3dj+JHXe3DlV0AHkEuFBi/Ahme+P8USh+kHgMIMuMlQVn+ZyBvyLT
         RZkg/R8IXldL9UaMQJm1y0ho6lxYLIce0s3IKbRu1HOsyZwAihl8YOxculojNgtj6VD6
         UZAw==
X-Forwarded-Encrypted: i=1; AJvYcCUpcnRIO8OOkVWpoWseOVdvz3CiD5rRfvlCwLRQJuo9sZBqwljIOpwz1x3nKbfQK9M51qkk760UT38+Ll772Tdb@vger.kernel.org
X-Gm-Message-State: AOJu0YzaJlvFD1WVD9d5FeAoyay/vUxyxDcJ/urbpIRclU7Eq3kECUqw
	hu//2Bmbivc8n2mYppzxKy+h07fWs3oOTMci/mIEdNzI9DCRlx2N5XV0xkNOwgrt6K2IWYYjSJl
	5QcryL0YecQ==
X-Google-Smtp-Source: AGHT+IFbpcQAzywdPhockdTCH+VSqCThNnYTbsXMPKAEf6imnJUbyOIqksxxc68EAKgOZSKmncNkFKrxq4mq
X-Received: from pjbsr4.prod.google.com ([2002:a17:90b:4e84:b0:313:2ad9:17ec])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f544:b0:235:a9b:21e0
 with SMTP id d9443c01a7336-2366aef565amr180617235ad.0.1750121885891; Mon, 16
 Jun 2025 17:58:05 -0700 (PDT)
Date: Mon, 16 Jun 2025 17:57:58 -0700
In-Reply-To: <20250617005800.1410112-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250617005800.1410112-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250617005800.1410112-2-irogers@google.com>
Subject: [PATCH v1 1/3] vdso: Switch get/put unaligned from packed struct to memcpy
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
 include/vdso/unaligned.h | 48 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/include/vdso/unaligned.h b/include/vdso/unaligned.h
index ff0c06b6513e..81f632e3c5eb 100644
--- a/include/vdso/unaligned.h
+++ b/include/vdso/unaligned.h
@@ -2,14 +2,50 @@
 #ifndef __VDSO_UNALIGNED_H
 #define __VDSO_UNALIGNED_H
 
-#define __get_unaligned_t(type, ptr) ({							\
-	const struct { type x; } __packed * __get_pptr = (typeof(__get_pptr))(ptr);	\
-	__get_pptr->x;									\
+#include <linux/string.h> // For memcpy.
+
+#define ____get_unaligned_type(type) type: (type)0
+/**
+ * __get_unaligned_t - read an unaligned value from memory.
+ * @ptr:	the pointer to load from.
+ * @type:	the type to load from the pointer.
+ *
+ * Use memcpy to affect an unaligned type sized load avoiding undefined behavior
+ * from approaches like type punning that require -fno-strict-aliasing in order
+ * to be correct. As type may be const, use _Generic to map to a non-const type
+ * - you can't memcpy into a const type. The void* cast silences ubsan warnings.
+ */
+#define __get_unaligned_t(type, ptr) ({					\
+	type __get_unaligned_map_ctrl = 0;				\
+	typeof(_Generic(__get_unaligned_map_ctrl,			\
+		____get_unaligned_type(short int),			\
+		____get_unaligned_type(unsigned short int),		\
+		____get_unaligned_type(int),				\
+		____get_unaligned_type(unsigned int),			\
+		____get_unaligned_type(long),				\
+		____get_unaligned_type(unsigned long),			\
+		____get_unaligned_type(long long),			\
+		____get_unaligned_type(unsigned long long),		\
+		default: (type)0					\
+		)) __get_unaligned_val;					\
+	(void)__get_unaligned_map_ctrl;					\
+	memcpy(&__get_unaligned_val, (void *)(ptr), sizeof(__get_unaligned_val)); \
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
+	memcpy((void *)(ptr), &__put_unaligned_val, sizeof(__put_unaligned_val)); \
 } while (0)
 
 #endif /* __VDSO_UNALIGNED_H */
-- 
2.50.0.rc2.692.g299adb8693-goog

