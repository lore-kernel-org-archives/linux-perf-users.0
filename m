Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FED19AD90
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Jun 2025 00:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750121890; cv=none; b=hd6LXXnwVHlODR3uXdmyd1kF9bdIgIn21AuLWZVZNtdYLcxfDlCakSAGDad6zG56BV0jE9IE3bNfLQu7gHC94CC3CdPfxObs1l6/CMxdaMMn8Toz0cXTovi68/o6gzzWAB5H8LpD80V1s/qLwQEIHFMPnLiFK+WDmHmBcGcgzFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750121890; c=relaxed/simple;
	bh=prYvWPkVZ0F18QrAw5Mvvac8Wh0ObRtIg/e1ntvsTZ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n2TUMtaeTWDUiktKyDNvJvkBsK2ZZq5f+Tab6aSLQbKkwR1WvsoApeynmhN8I8o5nj4FHm4isVS6KVExTDJOzteZ/6ltdKYwPBZhOGoiWFBcxVLbOGlDQeBYYD4J4B2bv11XHgqIWfxS2fldDSaaKVItfkFdf1ZqxSsoqzmFhQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r/2UZ3VS; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r/2UZ3VS"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23536f7c2d7so83414725ad.2
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Jun 2025 17:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750121888; x=1750726688; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dv+B5j2PyRBGCwIWMxMjAYLpyWcTKK1hPzxqpQMNSuE=;
        b=r/2UZ3VSMK66wo20h+W6fRLZ+s6CZwRhgtbpKxhAQLIjk8vPQQRp5abHnbzLRbXbON
         uIvOnVxUjlaaK4ZzkrqgANbCyZRkx1cTxup9EB5keRbURVd4ZL26lj+YGrILaUCPinlq
         wjBWPOugJAHt5WdH+5+krjpLD2cwGgqb/BCyaEUCGGvfqrZ82I4uGPXEwxtH4e0Y26by
         u8OmZ6OA9JJ855SERqyxHX1cGlPM6Qyn7qZ2ykqdubciINLghGxvQYUvgcn/mQdZrqck
         AGTGdO/WU/G/sASD9zBYEPBfEm33xaKiWoy6T9wwTkm6q1zF++OL8VD0md2nbNyXYFIv
         qHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750121888; x=1750726688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dv+B5j2PyRBGCwIWMxMjAYLpyWcTKK1hPzxqpQMNSuE=;
        b=CNYobVTsEVaTH8fzNfMr4M44v/6EYiu9FYE6GIAidbVwFgSDn2jnMqdgFKqxySzScX
         hz/doGBiPWnziAnj/VHYX2nPVwLQyo/1PwQE9BIgO6YOMfmE7HU/R+FZ/rjHa182M1WS
         TmehyHY9BD7oh6njrJSUTeE0XHWZIqRdnQO+rCqYn+Ti8v+iMSRl3NMSH8lSFzQcd/IY
         wzmpIRWMvOHXmdzit2ogxoPohicesuMQDN96N2E4HIXEsYCJwQpm+eZLWvGbTgOpJ/Nj
         oQY4mgQyhzE6a5PaHmNB47D0hbJBfMr3mo8UflBMyOFy2HtrYjGaC8UaYYqfJe8D2Mu9
         7y+w==
X-Forwarded-Encrypted: i=1; AJvYcCU2ruTeBV26qlGta8SZ/WDoitESmDq2y2dUh/BdeWeu04Vs1/jqp4bWJ0KPTlj7wIhYFT2ylfOgC35CIkoIrDn+@vger.kernel.org
X-Gm-Message-State: AOJu0YyQeFx0ogcLUJmgSjHXfF6n8lyVro6ZsIrXcmPdqv5GJW3Hu3pe
	f8EZO1K8l/sJuUwlY7nRchAME2bOiHcPtM3P8i+RuSa4vTwdLt0dq3wI/vVEeUY1Z3eaYsIt1VG
	ki3OCeD9S3Q==
X-Google-Smtp-Source: AGHT+IEAHw+4Qig3KGDlBgefnOGevCeuzUorxDrebXu5cgCekapQYh/SKUk3CKW1mqPftFrNTzTwFX/Yu9Kn
X-Received: from plbkm11.prod.google.com ([2002:a17:903:27cb:b0:234:a77d:48e8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec4:b0:235:e942:cb9d
 with SMTP id d9443c01a7336-2366b32a038mr154169005ad.17.1750121888063; Mon, 16
 Jun 2025 17:58:08 -0700 (PDT)
Date: Mon, 16 Jun 2025 17:57:59 -0700
In-Reply-To: <20250617005800.1410112-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250617005800.1410112-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250617005800.1410112-3-irogers@google.com>
Subject: [PATCH v1 2/3] tools headers: Update the linux/unaligned.h copy with
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

  fe9b2b7b3583 vdso: Switch get/put unaligned from packed struct to memcpy

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/vdso/unaligned.h | 48 +++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/tools/include/vdso/unaligned.h b/tools/include/vdso/unaligned.h
index ff0c06b6513e..81f632e3c5eb 100644
--- a/tools/include/vdso/unaligned.h
+++ b/tools/include/vdso/unaligned.h
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

