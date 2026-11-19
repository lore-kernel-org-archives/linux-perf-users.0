Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114343;
	b=XrdGIL64GVkcpuFP3Bhk53dhGEhxfb3IZx+kNn87hkDIJrBPVfhocT5m7BR9bJLm7rYw
	 Ma8mdr8ktI+/7/5uWW2Oh0avU+Hg0lazqJUxJQuIMjyRMmZ8a78K4v63Ros+sicIfqh8e
	 yqJhFKersmIiKKvBryy9UTIOVM+Tfj+mRaHKQdyi12mEp4hNXSUKOX7IiYeQLXNpR/rZb
	 eQgon2hQAlk0mkZZlncz7ASDwf4/iUHU0g3r2+gTD4GpI244ovPFD1swOh7IzIUGAY5Wu
	 iaI/f0B9VyIvlzVRuztdAAyCgMXo1hRh68s0A1YYtCBgG0irpC9EUGbmg9mT+H6MLiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=B71Ljk+UIM1gXp9I8DKkVnuHdcZAuyllvZTiO1ZgbS8=;
	b=GXiHwORWlkwIjdo0dpqlUxXac9zS1Gkymz9qYuX72dakJQ1r6KS18yXdZKim70KvAbPP
	 N55YeR2lmPpsxzKE9GIuwNmQxfhbyjEjyR7HecLK5WOieDcPIzTAcCkomNgLSmWXu4L5v
	 KUfvOpH1u3FxXOmIPSUAPWjGhPgXhKVUghY1EGZG0XcD/Qfr0blb376gEC6PEU45T4Rls
	 oYAx5u9oSOmEaYb5BGWG6pVhuuH8GGW4JmYmi/z/5KK+Op5mPX3mBkvN1J7zkcI4zfl6k
	 RApvAaevIHLepgk8ubYCK+rAifXfKTRQGY1D8G2mk6SP/KaP2nNtYEgN76xYIrxmTiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JDc5VL2p;
	arc=none smtp.remote-ip=209.85.210.72
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1AD60A5BC4
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 18:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE1AD60A5BC4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JDc5VL2p
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-847e2926d94so279574a34.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 10:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795114342; x=1795719142; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B71Ljk+UIM1gXp9I8DKkVnuHdcZAuyllvZTiO1ZgbS8=;
        b=JDc5VL2p9dsiAaKT2+JRAfSnNDFqtxp7x+w85hCdhzC6Hj8ZGvpn2caPMkdVbuSRZe
         l9siPmf2jIiOVZee2G2K27qslsLC9fR92GXZ3Hbr+Z1s2yVH6JineUhaGOaf21kvbFeQ
         dCp31mY4/VG4eCWITkOV5Savzdw7dwucfGYxnB8Y2zv0EuqpzZNtR90Pt77nn1YTZBY0
         6JEjBKMIMOrSY9dGJHCx5zKDaWPOKEMZNDJZk8fKfVsL7PXHT5uOyYaQGAi9B5hwjTEx
         53sVe4Nlw8dV9RSs+R6AuEKvcLU4rA6vi+FgU0Riu1YUutTLnI9FALYnYx9p1rm/3j8p
         xM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795114342; x=1795719142;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B71Ljk+UIM1gXp9I8DKkVnuHdcZAuyllvZTiO1ZgbS8=;
        b=YtDZ2CThOxFRu9oaLwpg15nsu4qts6seB22xDs6nz8VuS9lanWRe/QMCLhj3Fwb+JX
         /9X3IAq7aUgUUzP1b487mVUm3AwwkJn5F0v5wskopLRadlGbTUP7biuw15Ripc0/Xl3w
         KzaJGVUiS2568YZXPRIJNIt6edRSf33XwtWDaWobud3a+j4/0LgaXI3GRwxjVTdKPLTT
         Q0i66UaULGz+/K4RkuYroZl4oJDa856urvDzkPg0pa55Qlq6MEJHeK6Yy+/7kqoEUcWN
         KWvrTBHHBvaH6Pzwgl3vw0WLT1sO66pXxh9IPkAZSqZGDTP2kPMMy6wsDHCAlPvGUgWF
         aduQ==
X-Forwarded-Encrypted: i=1; AL+hErEjVZ/pVx+RehkFrnmIYX5eljl623whzscyZblrdVhU3pbd8JD2wkKeZbPyNfBKtznHD2dK4wDu9+NdeElEqodL@vger.kernel.org
X-Gm-Message-State: APuU4Z/A3OcIE5NdfJvhvziDZ6eSJNePp7rnGBciDO/Zh5YSxuo2yErm
	uncg6+UPGZzZT3kZok3LQfUGwwMehEY7dVFJcHsFqgf2QKLoc8WUsxC4HG4Q0FDqYD2X9SkXAYu
	Q2IuNDjU8W1SdnhfM4Y9iy1kLCA==
X-Received: from ilpp13.prod.google.com ([2002:a92:d28d:0:b0:53b:ef4a:649b])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1b87:b0:576:217a:6740 with SMTP id 5614622812f47-57a0a60d756mr914272b6e.22.1795114341585;
 Thu, 19 Nov 2026 10:52:21 -0800 (PST)
Date: Thu, 19 Nov 2026 18:51:48 +0000
In-Reply-To: <20261119185215.632334-1-coltonlewis@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119185215.632334-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119185215.632334-7-coltonlewis@google.com>
Subject: [PATCH v10 06/33] perf: arm_pmuv3: Generalize counter bitmasks
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, James Clark <james.clark@linaro.org>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Mingwei Zhang <mizhang@google.com>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The OVSR bitmasks are valid for enable and interrupt registers as well as
overflow registers. Generalize the names.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 drivers/perf/arm_pmuv3.c       |  4 ++--
 include/linux/perf/arm_pmuv3.h | 14 +++++++-------
 tools/include/perf/arm_pmuv3.h | 12 +++++++-----
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index fbd631ec71a65..4a6c1f3bcea1f 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -535,7 +535,7 @@ static void armv8pmu_pmcr_write(u64 val)
 
 static int armv8pmu_has_overflowed(u64 pmovsr)
 {
-	return !!(pmovsr & ARMV8_PMU_OVERFLOWED_MASK);
+	return !!(pmovsr & ARMV8_PMU_CNT_MASK_ALL);
 }
 
 static int armv8pmu_counter_has_overflowed(u64 pmnc, int idx)
@@ -771,7 +771,7 @@ static u64 armv8pmu_getreset_flags(void)
 	value = read_pmovsclr();
 
 	/* Write to clear flags */
-	value &= ARMV8_PMU_OVERFLOWED_MASK;
+	value &= ARMV8_PMU_CNT_MASK_ALL;
 	write_pmovsclr(value);
 
 	return value;
diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
index d698efba28a27..fd2a34b4a64d1 100644
--- a/include/linux/perf/arm_pmuv3.h
+++ b/include/linux/perf/arm_pmuv3.h
@@ -224,14 +224,14 @@
 				 ARMV8_PMU_PMCR_LC | ARMV8_PMU_PMCR_LP)
 
 /*
- * PMOVSR: counters overflow flag status reg
+ * Counter bitmask layouts for overflow, enable, and interrupts
  */
-#define ARMV8_PMU_OVSR_P		GENMASK(30, 0)
-#define ARMV8_PMU_OVSR_C		BIT(31)
-#define ARMV8_PMU_OVSR_F		BIT_ULL(32) /* arm64 only */
-/* Mask for writable bits is both P and C fields */
-#define ARMV8_PMU_OVERFLOWED_MASK	(ARMV8_PMU_OVSR_P | ARMV8_PMU_OVSR_C | \
-					ARMV8_PMU_OVSR_F)
+#define ARMV8_PMU_CNT_MASK_P		GENMASK(30, 0)
+#define ARMV8_PMU_CNT_MASK_C		BIT(31)
+#define ARMV8_PMU_CNT_MASK_F		BIT_ULL(32) /* arm64 only */
+#define ARMV8_PMU_CNT_MASK_ALL		(ARMV8_PMU_CNT_MASK_P | \
+					 ARMV8_PMU_CNT_MASK_C | \
+					 ARMV8_PMU_CNT_MASK_F)
 
 /*
  * PMXEVTYPER: Event selection reg
diff --git a/tools/include/perf/arm_pmuv3.h b/tools/include/perf/arm_pmuv3.h
index 1e397d55384ed..d045b0f3b93fe 100644
--- a/tools/include/perf/arm_pmuv3.h
+++ b/tools/include/perf/arm_pmuv3.h
@@ -226,12 +226,14 @@
 				 ARMV8_PMU_PMCR_LC | ARMV8_PMU_PMCR_LP)
 
 /*
- * PMOVSR: counters overflow flag status reg
+ * Counter bitmask layouts for overflow, enable, and interrupts
  */
-#define ARMV8_PMU_OVSR_P		GENMASK(30, 0)
-#define ARMV8_PMU_OVSR_C		BIT(31)
-/* Mask for writable bits is both P and C fields */
-#define ARMV8_PMU_OVERFLOWED_MASK	(ARMV8_PMU_OVSR_P | ARMV8_PMU_OVSR_C)
+#define ARMV8_PMU_CNT_MASK_P		GENMASK(30, 0)
+#define ARMV8_PMU_CNT_MASK_C		BIT(31)
+#define ARMV8_PMU_CNT_MASK_F		BIT_ULL(32) /* arm64 only */
+#define ARMV8_PMU_CNT_MASK_ALL		(ARMV8_PMU_CNT_MASK_P | \
+					 ARMV8_PMU_CNT_MASK_C | \
+					 ARMV8_PMU_CNT_MASK_F)
 
 /*
  * PMXEVTYPER: Event selection reg
-- 
2.56.1.708.g77570a6a1d-goog

