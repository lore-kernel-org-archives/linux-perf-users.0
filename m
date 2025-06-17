Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63E8285CA4
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Jun 2025 20:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750193693; cv=none; b=a+EMBtlCfOedi+hiENu65STzO6ntbq9GkH/6aIf2j7WhcQmvkatypN9O78eTIWraIWkbwy9IN+wrK+C/IuhvCNxrkoCE993YpDfAi01p/6GKY0Vrvzo3ojLuCWZj6fhoRMJWCB34rs0xcZb8NY+Fx/+XWfrAg6jXMyUhCJE607U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750193693; c=relaxed/simple;
	bh=ji2cHswmwo/z5ubhmd2npU+1NBNQjIr4s2B7VUnbXOQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=acowwPtjF6kDlAR2xh1XXBOWUNkAbxSABNYnRy0v2bXw4Axyhdaf7G9eGklU6sGCRc9IpMFKr0ZTAPwse5LBLutfQQqoqs/DhYl5sw8R8tMj0vcdroLPFkjZjDZrPTk/3BkC/aTfrvuwdHXrkj2rBIfM/T2yzNphRctfnzShs5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rEfWD4fE; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rEfWD4fE"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2e94cfbbbc1so1284549fac.3
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Jun 2025 13:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750193690; x=1750798490; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dbyQnd6426Fx1NsnFOkmoHrxj7lid9QiAbcIefxO5Cg=;
        b=rEfWD4fEQ3BotdNbBgz37YunHHKjAVVSrSHJtTeR/tWsS2C4Z+9/fUUac6HgiltT49
         h0JxLv8NAdN90xSYnheBFw73BISBwUm+C4vH2JyZ1Ij0PO5TT1UdgCfJHu7lMCbqUhEq
         h36uyoLe0OW8ERs6D+P5C3JhNJznJUQ22JlfueIi97l9g1isYo4K/RXhyziN2bPT8qv4
         Pzz0tBBIFRP5CIx1GJQT8pb731Fs/yu/BK+YL992S/yz01AGQ+5c+C4618e28jbQ37Ac
         mYHzqgCcNEhYYlFEL/oouok9DDwIgCNqleVk7cdzOiR1OyoYlgfOOVbpZLxKAdipgmgC
         w7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750193690; x=1750798490;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dbyQnd6426Fx1NsnFOkmoHrxj7lid9QiAbcIefxO5Cg=;
        b=NA3w9FSNNsznu2S0WKtnkxmkgVPA60Nal44Ki3JC7I5JjK9VYNHNJhENPAu+RsolJZ
         FunAYKvWHbP0RLfUnd2bEvTn+PoD7zXbJQwIP6vryFjcBbkIew7Bksk3VBXYduuASEyx
         4T5+x11dbJGftgrvGOXwmOx9/ME/sx18Wt0t+jVeOTEX+ls3DKhDTENB7xHk7Ex4zKkF
         jsAgVRuJ9SFzrO91Hj7xLTGJMP+OQTv/n2jsSzq03AcDKItAjbY8B8MTgZX+wyksrWN9
         ztqQN6Y4p/wkraT51Wvxd3zUs6Ow97S5BFja8c9AwVoe6vgMHHvjCw6e+aQXVMXP7vy/
         uVIw==
X-Forwarded-Encrypted: i=1; AJvYcCWpjULRWR4SjjlQwfIet/gBt8NTe1tTdLMzM1ZLAtGVVrrgZM8m4S9Qc1SgcfT3wyHoz3uHs/7YBiLCag3ce9pm@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc0Wj+fVvW2Lp1S8jQ7CXr7iWx6LLo9JQuygm+FL4hQsU4/23f
	NsuqBGvRqUa+Lqs3sawHTsSmWn6T+zwUSwFdSSlSZgTWZGF3pJJRIm9uSN7gGedbdKhlEX0fVBk
	iClm1PLQ1Iw==
X-Google-Smtp-Source: AGHT+IGO+lDFmIYK2w4ANnsn3rKPN7NvFKzlodTqOzVDtZl/njo/FT5AchdaGQP4Vk87djIL0Wjh2P0D9VgF
X-Received: from oacml3.prod.google.com ([2002:a05:6871:7243:b0:2c1:5f7a:eba8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:709c:b0:2d6:103e:e43d
 with SMTP id 586e51a60fabf-2eaf0b0bc51mr7182984fac.20.1750193689948; Tue, 17
 Jun 2025 13:54:49 -0700 (PDT)
Date: Tue, 17 Jun 2025 13:53:18 -0700
In-Reply-To: <20250617205320.1580946-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250617205320.1580946-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250617205320.1580946-2-irogers@google.com>
Subject: [PATCH v2 1/3] vdso: Switch get/put unaligned from packed struct to memcpy
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
index ff0c06b6513e..f33c1eefbf68 100644
--- a/include/vdso/unaligned.h
+++ b/include/vdso/unaligned.h
@@ -2,14 +2,50 @@
 #ifndef __VDSO_UNALIGNED_H
 #define __VDSO_UNALIGNED_H
 
-#define __get_unaligned_t(type, ptr) ({							\
-	const struct { type x; } __packed * __get_pptr = (typeof(__get_pptr))(ptr);	\
-	__get_pptr->x;									\
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
2.50.0.rc2.701.gf1e915cc24-goog

