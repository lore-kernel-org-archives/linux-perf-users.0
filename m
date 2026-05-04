Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300B93DF01A
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 21:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777929516; cv=none; b=ONGPjVxi9xl2WYKueqUoVnfPz11VmYGFHbLFYKCJVEmelKORURY59QIsbElDt2h16Ycb1Xsn/r/2K3qaCAw+/nX2/qgRP7gHPVJBqIe2axlcUBqFdIAFBD1bUR/8t7LMtySazz0NmwRiNQVYVS1OqbMfB/XiQ/R52IwI8L2Fqw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777929516; c=relaxed/simple;
	bh=ueTqc2Ph7z17HXoEzMvMnAeIJNA23UDUjdS2CztRW2k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i8i7YKCtFOO0upgsOUvlGMiWiTqhELl999NQlTvClF37hsQ9crEpavCNNyvzkhdOyANmsoXHiftF5GzUTjEThKDAKc5lx0wHAGqB+LooI+zDff3nfnR6c9VueltzMPkQTTvNSOyFa9T9v55p22d/zihM0iowG31IAAHVRJDTEI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kDpKq3VW; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kDpKq3VW"
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-69491bd267fso9817693eaf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 04 May 2026 14:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777929513; x=1778534313; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=thCWuABQmlCLQCDjA65mDdmemz/sfk/Mfmpa4HEmTAo=;
        b=kDpKq3VWqY0kZ2SG8Coyapb//KD+KV5eLXxLz8i7Q3UMzdMcieiuc63hQ3FW399M2C
         rFDG9uw1fLn4O6pUSF9hxb1E+kYgYtli5lHuBwJRpuFsK7GMtlb3wteetiqAQQFPBkce
         WHs86taFK3SD6PmDd+WZIvesxEmBc1ec24egzpEqkjvlgzM5oOhpTkAgb5UepzYCw53I
         wy5pyxiZ9jZRQhdNShWI29UwsSivEABZ2HS4GjWbbjrUygWkT3zdAwZssv6kLID10ZoG
         oleVQQYS0qA63MXy53F8D37tdX15+F6W3/fpfAIlSWia/7f59wMlYzxZDZeKBS5WzjvU
         bJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777929513; x=1778534313;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thCWuABQmlCLQCDjA65mDdmemz/sfk/Mfmpa4HEmTAo=;
        b=S7dbGwxwKv1eS0wpnKFLfEHkOtaojoc+aZOpTLKJZmZ+SlAV75fehCsBSiJ7WafSDd
         FWBcaM8nGruHtQfqSrT/n6jPEP1oUKXC2GJxgk0Ctoe4LPHjzUCIJfsEpgKfjHzIOC+3
         qpfTeeMXwa3fQaUdAGa3qJ92ceegY8iIXmZhoS/Dx+ROsAAKan1ePLRIuoPa0beNSc5S
         yF9smWTCt2qr2YNAbU+3eElux6zgk9fUXJCPM6nlOOTProHrjcsUlPIGIuEfTNoEdigQ
         0WjnRVV6uK8Zu3o1WJwt6ljV6knhwhHtMf26BGo92VBYLSgo83tXavlNdacUaEZn3hA2
         xihg==
X-Forwarded-Encrypted: i=1; AFNElJ/C0geSz1CreNQz4mb5xpQtVJjozzeDMmhHynXu1xq5GR5akYqv9A94WvV4Hjp/pHpQXNZ7K6gYj6gG/JU6Zpc5@vger.kernel.org
X-Gm-Message-State: AOJu0YwpuJgTo/jHJZsnolEf9gy8RVEKcs0XfsEOUK6B7GFOOLMTA1Ln
	3hfL9mnEywTcHF2HCCLmMozbfFeH4pMARMj3kcrCJR7hsm0XR4v6KdvCskLy9WWtqwu1IZRLpbG
	9xEoEEehD+tgd0APqRLDaAriUpQ==
X-Received: from ilst10.prod.google.com ([2002:a05:6e02:60a:b0:4fc:39c6:a601])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:f08:b0:696:32ad:e894 with SMTP id 006d021491bc7-696979ec5c7mr5763143eaf.23.1777929512987;
 Mon, 04 May 2026 14:18:32 -0700 (PDT)
Date: Mon,  4 May 2026 21:17:57 +0000
In-Reply-To: <20260504211813.1804997-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504211813.1804997-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504211813.1804997-5-coltonlewis@google.com>
Subject: [PATCH v7 04/20] perf: arm_pmuv3: Generalize counter bitmasks
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Mingwei Zhang <mizhang@google.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, 
	James Clark <james.clark@linaro.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

The OVSR bitmasks are valid for enable and interrupt registers as well as
overflow registers. Generalize the names.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 drivers/perf/arm_pmuv3.c       |  4 ++--
 include/linux/perf/arm_pmuv3.h | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 8d3b832cd633a..1cceb1f614515 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -534,7 +534,7 @@ static void armv8pmu_pmcr_write(u64 val)
 
 static int armv8pmu_has_overflowed(u64 pmovsr)
 {
-	return !!(pmovsr & ARMV8_PMU_OVERFLOWED_MASK);
+	return !!(pmovsr & ARMV8_PMU_CNT_MASK_ALL);
 }
 
 static int armv8pmu_counter_has_overflowed(u64 pmnc, int idx)
@@ -770,7 +770,7 @@ static u64 armv8pmu_getreset_flags(void)
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
-- 
2.54.0.545.g6539524ca2-goog

