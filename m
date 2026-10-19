Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440794;
	b=MT2dJ1tRrrV0OyW8F14bu8J3lTFTvolM4yErvMUCXyRT2zsejIpRfZDPX95Pkx0pJ+xU
	 TVryfBcmLEifW5/4J/IxZ8T2ZpWmqrIvBn/uKg6/icVq2MNUnFcs8ExQfl4ArYMfilKBj
	 z3wRatEpdu9yLoSLsIvEZ+E+PlByXe6kg6DrYZA5Vtf0VVymJ/umWCnuR7+76uZF7XSCF
	 7s+lqQeDKbQSNcgYtZlGbUE4Ya7kyWllrni44XZaaTkgr6jHfCXPxaKyoTlpOEUiadXfj
	 A2HfxcaffHb2YnWRDfitgRloBl1rBsa05CKbuKrID61E7hkV5v/Lq1zC8VrzuQwhvbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=n6Cutn76HGVOvz/pUDurQ4xzloi5+zrfO4jU85m5dbQ=;
	b=eDUGKlEPlYIPNaj5lj/Irl6i1ppI1RJHLpRJpHJFAewEy6rP92V9+dUk/mgeUJAfK9BB
	 IfV8FnwfHp5UFgkXVyGSvD0eWpipaGAx53Nxhi7shBgmtlHAiENZlEf0vXw7X8UqtIOy9
	 +7p0uKE6AoHfr273iiqSJBP0LEN6GGwAqQz94fXTnbzIIKYaaGwkVnQyU3l0fPBy3KVqk
	 FMmqFi405x7MCnwLhOIvXlqA5nMJK46BWthTFgAvT6WxfRy9JR4N2voaYYbJFba+ogI4d
	 YX3SEwxdSSZuufT9UX3yeA+ugthdA0kHYDpnfB8ASwmpffD/M3AZfyjYOQ8ymwJFG9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="G/goLFy3";
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ECE606A31E
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 20:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60ECE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=G/goLFy3
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-155a75f91e1so32727c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 13:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792440793; x=1793045593; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n6Cutn76HGVOvz/pUDurQ4xzloi5+zrfO4jU85m5dbQ=;
        b=G/goLFy3N5fUF3FufCX34sm82wi1PoHTX/PxSwRJvkVyIuoO23I2KkXrx6SkY/UYX0
         hwspYa5jETSjYyi2wJ3J5EkJwoYa65HQ0odaAKg4k9Sr0rFWnkAFHjNBimUWsIkmdrcp
         sxub9f/OSQZPcfItd/NREM2+dXNkCS1LIXS4JGpvmJP22lVMNKN6xDN34yGR/lnhZoux
         KlwNXzkmVdyHQYXDmvpxssoLvWX6OeJ9XixqtUK+RQuqL+7oAqpPtY24OnYfIQ3ULZt8
         y448Z5ja916i9Pq4CuIpkLM6+7iDAQa/8y83iAKJfdQBoR2wfLTh2lYbXY7iARpweF6/
         lCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792440793; x=1793045593;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n6Cutn76HGVOvz/pUDurQ4xzloi5+zrfO4jU85m5dbQ=;
        b=rFysD7Zp/6TdGEU4qDpmSBbL0oBoagJUltJ2/gPM1MnhmpQlOolvUeI28zOucnzIIx
         Sp2qoElZ2/6VAvvTp0brR39tYiQsYM5cz7nIE3Ua02N7KMjCwEN7N9HbXZB6cEVCiq9j
         vbBmCriaMmt7v+fNflkI5Btp74lpM5q5AMjjhrrDY/8Egk8trsssG7QeRIb6ZzoXVtsW
         ytP6YaI5WDOk5OfnI0n7iYZ+Deyt92sF/LrJF1O4mUszfRWJZXXgbdaG91dkdrwDMhdA
         wzZ49O6Cxp+vEvBM6lqQpLb0nJHQhueEiyWTk8pNx08JRzL850Olhkd1giNoeiEJm4Kx
         tzzA==
X-Forwarded-Encrypted: i=1; AKwUvByG5xnDRq9p54iPROpJ/itZrMnjhPBsPuSoO2I9jNXEPSJ6Y+yxMW7WPQsesy402A5CmN34YaW18B1gLhZik2XT@vger.kernel.org
X-Gm-Message-State: AFq9FYKUZS0D5RqWE0OUegVZSHj42GKCFvZSIELLgG1JQmVNY0ZgXN4X
	Mte2UHWtjx+94U28hW2cHmRCYjCsEJOCMpTJmiybiIuIfLeLUAavzi7TFQkQAVFXuZ21AzI1ot1
	ZW1UZX9xXwA==
X-Received: from dlep19.prod.google.com ([2002:a05:701b:4593:b0:168:9e52:72b9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:130d:b0:182:c472:b123
 with SMTP id a92af1059eb24-18db853ba02mr237142c88.1.1792440792662; Mon, 19
 Oct 2026 13:13:12 -0700 (PDT)
Date: Mon, 19 Oct 2026 13:12:57 -0700
In-Reply-To: <20261019201257.3805356-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261019201257.3805356-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261019201257.3805356-2-irogers@google.com>
Subject: [PATCH v1 2/2] tools headers: Update the vdso/unaligned.h copy with
 the kernel sources
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

To pick up the changes in:

  vdso: Add VDSO_UNALIGNED_PACKED config option for ARMv5

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/vdso/unaligned.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/include/vdso/unaligned.h b/tools/include/vdso/unaligned.h
index 9076483c9fbb..726fd15efc82 100644
--- a/tools/include/vdso/unaligned.h
+++ b/tools/include/vdso/unaligned.h
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
-- 
2.56.0.212.g129ede20d9-goog

