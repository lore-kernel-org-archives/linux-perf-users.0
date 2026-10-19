Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440792;
	b=X8/meJJnW/aN0VeSjCFMUM3q8lQp8P4MlhzQahMkpWQrLeKxDpdTPw/3i0gZNnLGK7LM
	 FbjGBwfipKM/7r3zZ3ZFV1eC+qd3s1/1WhPD+3JqCpDNjV/7q3m90LXM4QeqH/OGSLxy6
	 4T7ZeksV8WYms1zDhTnsIMqNKSXrDzwHqXD41k1DoN57rvOuk+qQVUD5/f9Y7FyuuZhDj
	 /2PWuq6VfVVGCudnrR5/HZV8RkhO0CJjcF/mtDwysJ0BpnUq7w1YGBiGOE91Wa6ohPlGh
	 8saZHkxY7nDH98bjeOg0r6G671LmDNIdP+7M9RLQ3It0WoxSrNqoojk907NtfYYlMdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440792;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=XlJfSKdFCH7ItGXZeKGbQccPhCIHUR7nxzGpcJ+bVqQ=;
	b=wBv6o+2eTPXGi7irLdw7aThd0DBnVafzBWnk6vLfLWdzfOUFgDbX6MGzQ7chqecQgEya
	 +3oZ8QXOgTb2sADS/wVSTNxeGqcjcLLeF0HUN209ycNWhi7jNCOt7ICSOU/lH5ftLYX0T
	 1uyL2lcxNehuDQlKAzQIZe3uPhecc83JnGnvt+G7FyUt2xKiQXM3M3lrrEnnh12jdorlN
	 w55i8zHfTLjLph7slrKuFczVIM09gYkFSb7rXfCEJ1qMvTu2czTjarw0f+bnW974YDOYk
	 ymHp9tqYP3eO6BWqHDPq6/aCpYWYj4oJblMD/bLgo79H6B8y7mujs7X9T/TTrqFrHrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="p/ObLeZK";
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6F5606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 20:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A6F5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=p/ObLeZK
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3510d0baf63so6328756eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 13:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792440791; x=1793045591; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XlJfSKdFCH7ItGXZeKGbQccPhCIHUR7nxzGpcJ+bVqQ=;
        b=p/ObLeZKrxYpbcjCuw6oY4lpLyO1VfsS82Amrk8RUGRcDcsrGb9JwCPT2ZpercWwGq
         otcYgZ99vPuy08pictjjQ/W934IA7Qj2e7FV7JE10z0w+o13PJLp8i+pnUEKX/aV2ABQ
         7q0Pfqn12Gs/ePndUpjCqNPdshzPbxxpk/+UBViV0pmLjA8uFsXHkAU1kqrhlSqeZAop
         Aan04UXzYS8P5xkg/Dw/wM/kj5GWcVR7WfY3MiLk3v+Zbue/VrdMGwnqLWyIp/HCbNsC
         cT3n4Tq6hInSjy7tq+2qLhdTx3vQab27MPMPSvduSGlWWrWRVag+34d+hgZVwuvnZpOu
         PNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792440791; x=1793045591;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XlJfSKdFCH7ItGXZeKGbQccPhCIHUR7nxzGpcJ+bVqQ=;
        b=Z9jdFC/VRks74+FYR+2RxIjGhRC8I7WF+boJqC0gifp+SUbuaALpThhdOWloPv/biP
         kqksLijWfmcr2BySQt1wk4OvfPACxa5oQ6WZRRJxgD81PrnkEOwBTP4xy6IaSZ0y+G0f
         yP0Eq703BlvzgI5CfVIVkQnHikbTKdi6OEvnHWhsJEpr/GoOjquAx4dehFt9CoRJ3sWR
         Pve30N4M1cEeUDefEtQRkHGsT7LWR7uHPW8lDUesxXo/mRXMgJH1VZvY2ClQNXdODT/M
         n3Mzv/zdH3dNA09hL6DeocnbmIjh39Ke8NXx5pfyP8b7FQhuSxcF/grd0ack+lRqBcNX
         jcaw==
X-Forwarded-Encrypted: i=1; AKwUvBwtEfn534yy1fDiQ13lWDEHKTxaVJRvAmOAqfXt3JfHYXe5mdv4pJ3hClomqvH5SYkkcKveUaixwIkZqHC7cQnd@vger.kernel.org
X-Gm-Message-State: AFq9FYLitvKYdQAWRRfD250Qy+dqJBHq1fuSd4mr+nfUliYLezpfSTsC
	mixsSN76JV+4Ne0AVpqGf0eRMEaAunEOI7mOAOQ6zEoQy76HYtP+MQckI/dGdzvQUUy9Y3//nMw
	4jaBP9cHuZA==
X-Received: from dyrp21.prod.google.com ([2002:a05:693c:69d5:b0:35f:390d:248a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:87c2:10b0:34b:4b99:24ab
 with SMTP id 5a478bee46e88-361a1e501fbmr13784320eec.22.1792440790306; Mon, 19
 Oct 2026 13:13:10 -0700 (PDT)
Date: Mon, 19 Oct 2026 13:12:56 -0700
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261019201257.3805356-1-irogers@google.com>
Subject: [PATCH v1 1/2] vdso: Add VDSO_UNALIGNED_PACKED config option for ARMv5
From: Ian Rogers <irogers@google.com>
To: Thomas Gleixner <tglx@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Stefan Kerkmann <s.kerkmann@pengutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Christophe Leroy <chleroy@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Eric Biggers <ebiggers@google.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>, Ian Rogers <irogers@google.com>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit a339671db64b ("vdso: Switch get/put_unaligned() from packed struct
to memcpy()") switched __get_unaligned_t() and __put_unaligned_t() from
using a __packed struct to __builtin_memcpy() to avoid strict aliasing
undefined behavior.

On ARMv5 with GCC, __builtin_memcpy() may not be inlined and instead emit
a much slower out-of-line memcpy() call. Add CONFIG_VDSO_UNALIGNED_PACKED,
enabled on ARMv5 (CPU_32v5), to use the __packed struct implementation on
ARMv5 while keeping __builtin_memcpy() elsewhere.

Fixes: a339671db64b ("vdso: Switch get/put_unaligned() from packed struct to memcpy()")
Reported-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Closes: https://lore.kernel.org/lkml/47f8c30b-e326-4ff0-a2bc-5683209a9e2d@pengutronix.de/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/vdso/unaligned.h | 16 ++++++++++++++++
 lib/vdso/Kconfig         |  8 ++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/vdso/unaligned.h b/include/vdso/unaligned.h
index 9076483c9fbb..726fd15efc82 100644
--- a/include/vdso/unaligned.h
+++ b/include/vdso/unaligned.h
@@ -4,6 +4,20 @@
 
 #include <linux/compiler_types.h>
 
+#ifdef CONFIG_VDSO_UNALIGNED_PACKED
+
+#define __get_unaligned_t(type, ptr) ({							\
+	const struct { type x; } __packed * __get_pptr = (typeof(__get_pptr))(ptr);	\
+	__get_pptr->x;									\
+})
+
+#define __put_unaligned_t(type, val, ptr) do {						\
+	struct { type x; } __packed * __put_pptr = (typeof(__put_pptr))(ptr);		\
+	__put_pptr->x = (val);								\
+} while (0)
+
+#else /* !CONFIG_VDSO_UNALIGNED_PACKED */
+
 /**
  * __get_unaligned_t - read an unaligned value from memory.
  * @type:	the type to load from the pointer.
@@ -41,4 +55,6 @@
 			 sizeof(__put_unaligned_val));			\
 } while (0)
 
+#endif /* CONFIG_VDSO_UNALIGNED_PACKED */
+
 #endif /* __VDSO_UNALIGNED_H */
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index 597f5f0f9681..709eb193999f 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -23,3 +23,11 @@ config VDSO_GETRANDOM
 	select VDSO_DATASTORE
 	help
 	  Selected by architectures that support vDSO getrandom().
+
+config VDSO_UNALIGNED_PACKED
+	bool
+	default CPU_32v5
+	help
+	  Use packed structs rather than memcpy() in include/vdso/unaligned.h
+	  for unaligned memory accesses. Enabled on ARMv5 where GCC may emit
+	  out-of-line memcpy() calls instead of inlining byte accesses.
-- 
2.56.0.212.g129ede20d9-goog

