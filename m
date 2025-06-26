Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8541B2F3630
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Jun 2025 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750968363; cv=none; b=ulYOa5yAcKOqpJVAQM3NCd/6rzj/hLh4MafRTE2ZBV9EPjfYdXZjzD8lhI2uFU7rsk7Q5Mu0eDxKrTNwRU5M2uEiqTYlvKtP+dLEfUsOQUKQqcjElaEBPwWctMzCObZ8674CrToPFU5AuDYiXGPwH8OTlOsaUHhBVnkGWbG+ofc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750968363; c=relaxed/simple;
	bh=zDfO2v8ZbtcP2RnCvD+2EHC8b8R/WWM29bYxaxnNoHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YZsEbWNpWQta1hg1B+4BZr6Lbb+T/xqLU/jKx06ppOZEut5mgmBF7gqdFLsvL+JcWNcs3WAhj4L5bWj2OxUjpY9s0CBRWr73+g9/mfqEbKjODFpOefnhc0HGvx/IhlNljGHWXWOwb4b6IW2zm4tjj7xcXuINpR0Vt8ZK6ys5ZdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oTKmwFWT; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oTKmwFWT"
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-86f4e2434b6so154598739f.2
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Jun 2025 13:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750968358; x=1751573158; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mBWQmXlElKRqufKLx0IJBng3uEmJIOP/0SNzHgrfiOQ=;
        b=oTKmwFWTmEop0RSYQQ5GmV27f3skzFtQzPU4QqmSbkiqNMcTq77p/quyMhoJcWsCat
         vxPo557m74QVvIiMVJpJEY74DVV/bht2S+6URKbJBlmfILkDNfMUY3UJaGZ/V+7trcQt
         MUgLoDF0Kad2bvAtr3h5PzoRq+wL+ScqQEuAN7HenxLGzjJG003MWlGR53MWvgWstKMf
         fcpDiUBkswzVDJZwqwMCA2UW48zQentiOJLjbfIM9KIwmEb2U/nAPVY3t5Rwcwuh6kka
         aX4wMrWRxIuf9EmJVm6M0ZoxH9BfHfae3NN13SYuXF7F2a/v08BfvixAm62/X40W8rXl
         MqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750968358; x=1751573158;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mBWQmXlElKRqufKLx0IJBng3uEmJIOP/0SNzHgrfiOQ=;
        b=D4OwKUTgdUwYRxHKtM0j3QqQQyjC9aqtUTDQpO4m0gbFJUbTIz8i3hQnhGU2VS/n5i
         0spiLaU31Owb3RB50alzt1ROChT5Uy71iuBrcYMtFG0ro8US7DTtQheWA2F+SputAjWH
         FFiKexVViLFpJiVnVOBuh4M0Yrc8CfEPvPvDSeT8HP/QSLb22FCzkFAb0FlJDsB+TXKA
         vFkex/y1y6aQAJrryPWK1Kncg1lSJD8qEnJFGESlrNeMyeBsAHTPKMGb/d1nyTMbSsdi
         zUCr32SWFplJWgw+DDFubSPU+8+EghQIl2WI3BlfGXtu/HGCs/qPTPkyUE9RmixEh3Ri
         NuOg==
X-Forwarded-Encrypted: i=1; AJvYcCW+UDqdmFI3N67yB+2uSf9Js5HYXmjPwaYj14RXUd9K16fDfLUd1jz+/MfGcIcmqirvgpbqU61i+JjZ8oo21Nev@vger.kernel.org
X-Gm-Message-State: AOJu0YwAfoqP6BQTZ8zjMTD5Zmj7TR5Q3bpuxtI6JtZWWnwJ4vdd0WpS
	Huqtyg78CgatVBuXGD3vjybwQzBFsE9+TBeQW6il3wbYd1W9LfpyFsgQ1/epkDAAaDT1imcm7K/
	24pJ8x4qkgs8D3ksBTBDh9RIziA==
X-Google-Smtp-Source: AGHT+IGgfwcSnINywDElIvOUq/qNOGZjEQuNJ0HSkOlhtmSxQvzs3JhS67z89W+d6j0EUhWxDQaGOM9wiefkiUhZhQ==
X-Received: from ilbea18.prod.google.com ([2002:a05:6e02:4512:b0:3dd:bec6:9d56])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:2683:b0:3df:385d:50a8 with SMTP id e9e14a558f8ab-3df4ab62001mr10858775ab.6.1750968358575;
 Thu, 26 Jun 2025 13:05:58 -0700 (PDT)
Date: Thu, 26 Jun 2025 20:04:43 +0000
In-Reply-To: <20250626200459.1153955-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250626200459.1153955-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250626200459.1153955-8-coltonlewis@google.com>
Subject: [PATCH v3 07/22] perf: arm_pmuv3: Generalize counter bitmasks
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

The OVSR bitmasks are valid for enable and interrupt registers as well as
overflow registers. Generalize the names.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 drivers/perf/arm_pmuv3.c       |  4 ++--
 include/linux/perf/arm_pmuv3.h | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 6358de6c9fab..3bc016afea34 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -513,7 +513,7 @@ static u64 armv8pmu_pmcr_n_read(void)
 
 static int armv8pmu_has_overflowed(u64 pmovsr)
 {
-	return !!(pmovsr & ARMV8_PMU_OVERFLOWED_MASK);
+	return !!(pmovsr & ARMV8_PMU_CNT_MASK_ALL);
 }
 
 static int armv8pmu_counter_has_overflowed(u64 pmnc, int idx)
@@ -749,7 +749,7 @@ static u64 armv8pmu_getreset_flags(void)
 	value = read_pmovsclr();
 
 	/* Write to clear flags */
-	value &= ARMV8_PMU_OVERFLOWED_MASK;
+	value &= ARMV8_PMU_CNT_MASK_ALL;
 	write_pmovsclr(value);
 
 	return value;
diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
index d698efba28a2..fd2a34b4a64d 100644
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
2.50.0.727.gbf7dc18ff4-goog

