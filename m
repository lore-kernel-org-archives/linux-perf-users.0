Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C92255E34;
	Tue, 11 Feb 2025 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739290100; cv=none; b=EKYGosksBd0Jm2mV1SzoBrUoPMgVZoUgcvrCeS0911H06S83aid5ocyyyLS0rU7x6TTz+YfTSXfcWyLjmicCdReG4aq1T7aMceGruUv9L8zi1qXSqLaCxf/X6Fq38rHNg4jW7tXMwMhmEhoGNJ7NJcp3CaGuc9DCGjGgPIXhFV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739290100; c=relaxed/simple;
	bh=YQao7sB+3fLgHzETqufpNL42LDNNV6Hr1igoTgjUD9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lEDxu/A6tNfNxUegqK/slsmwVHaDrt9TavxglcaVaTLSi1NZlnchdd7QbFOYFdT6wzrvpnGx/x/ByTFemT6UBhju283pj+ZqchIbqSFUTGhx9Cs3AizbvqtR2YTfRpI9LlIYoq43K7+0VbBK7adwajfUtzLei8pzO10Yv5RFyd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+SB1QzR; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+SB1QzR"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f7f03d7c0so58992595ad.3;
        Tue, 11 Feb 2025 08:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739290098; x=1739894898; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nmvoan1YqE/yKtA+UIeo5+2Y3tZ+vsFg5mxf89/sp0U=;
        b=S+SB1QzRR1gezj3AHAGXeXHwOvW1dKLMr2z7rU7f0ttugzh+qtyJre/ESHzS0O4Wty
         RJpzzOn83Nx8Hut0RV2Gp3bSwUiCW3MFz9rMu4B812zNZmns1OT9OWnMHhFOgUgITPZi
         wdSfJxlXnPLrqpPaa+E2DfcLDbAhP/gZo/TH9pKL89PQ+CN/1yllgu92rsvpw3Cs4Z/A
         3K3tVKmsYJZfDdQVhYnATWeWiD0NuWzXUIhOKAKjHxpIHqZ/LMb49r8J3XAgGg2U+m4M
         deHbRf+rliaG6r1HjDobJVYnUAqR4BH7QQv67A5FPFvLqMd6L7WwuTM9YcvlUyIbcAuG
         ngAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739290098; x=1739894898;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmvoan1YqE/yKtA+UIeo5+2Y3tZ+vsFg5mxf89/sp0U=;
        b=gDzNCtnkrfFdj3sc12e6R2nLuUPczpp/PvKZmif6ox1jnB8GrcEv7oR+HLvg+oiQjm
         5/NTFAFq5+821Du3AKd92n9o1s857B5MD+GjnI7iCcfh4AUFP5WZDhzEMe4gVAJvIZeE
         Rw3tWrdjfHQxtew4GfptK9jQkxpjvk0hyY0nSJvPYnb48Sy/2XnrnCHAZFP6DHeJJUVA
         IHnAYQvychwKOd00ZCNhnPq3cAgCanjKyKUZmp9rd/ThggW67CeaVPw+G/q+B6dH6p7M
         rfc2aaJWicsTxvtnkoAskh2/auCmej2gn8PVYt8H4bq2qePWW+LY8J1TJ20vrwryXtZl
         gR+g==
X-Forwarded-Encrypted: i=1; AJvYcCUHFwq3pEIGL/XFBEfYdWzDtm5NHpSPSPVmczcQuCErK+WKfQVNfxTRjuQMGdxm7r2mkLughsoR+LJlHJLE@vger.kernel.org, AJvYcCUmHG1zQdJ5D6nDOuxfrKIrnL2gJvU15u5m2HcFCPjiwC3muTSoQRYiIztW8ucx09/Je/kZbP8zS3KS@vger.kernel.org, AJvYcCW6O3nbveMorqukwCmcLGuePsZJEa+iebJvGLXgMBBZkc/BJOrPBOIS9FU2t8wZxuq33Hb+inKwjrGZaPiICQQPpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKbC+GemZxSrgJ9ptJ2QcGIDAdab8WW+yD9xw0ny6/zB+JiGsj
	b/1rmUAO6nSEBpTn1NnLis7YJRovtqnMhyWMHb/qrtsIix8a3mg2
X-Gm-Gg: ASbGncsngVXeQ5cBw6W6Tl1RYkoGY0XicmQxQ3LHiqCvn/piMGqTYZMGg7JEMq5dj0L
	Yxx9HzU96KJIWvuAqtUiplOD8QdGjCCoaWWxFC4UTTjSV3VwXlfJzKyN3/IJ0MMUp+mqKnLiwPS
	63to3da3c2U+59gPoi6yP6c6U4vaz+PDmrcXYnu6/6YH8hbFqXMU7z9SJzCxk5TDsETrRI3rkOY
	b4rgfIdebAj21g5OivD4Tw53yYyvlgZKNZOJP3IpPXD7Ftt6H1KYQtHX3s9WWFy3yj4cPY7xBjM
	3EepIsECS/f7lxOHog==
X-Google-Smtp-Source: AGHT+IFEV+8GtRr4zcR1axgnJ8X+fQckqOO5KYT71vYUJNwCtdK0cLMJYzMXIm72XlvyZN+zJANN6Q==
X-Received: by 2002:a17:90b:4a41:b0:2ee:b0b0:8e02 with SMTP id 98e67ed59e1d1-2fb7e8bb5e7mr437325a91.28.1739290097691;
        Tue, 11 Feb 2025 08:08:17 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2fa618e5e18sm6040478a91.41.2025.02.11.08.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 08:08:17 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Wed, 12 Feb 2025 00:07:23 +0800
Subject: [PATCH 02/10] drivers/perf: apple_m1: Support per-implementation
 event tables
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-apple-cpmu-v1-2-f8c7f2ac1743@gmail.com>
References: <20250212-apple-cpmu-v1-0-f8c7f2ac1743@gmail.com>
In-Reply-To: <20250212-apple-cpmu-v1-0-f8c7f2ac1743@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5883; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=YQao7sB+3fLgHzETqufpNL42LDNNV6Hr1igoTgjUD9U=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnq3XnXLndYLpfjny34FvZYPhDDrIyS03cHytYC
 w79sFECftuJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ6t15wAKCRABygi3psUI
 JHX7EAC1d8N+62+DY2PhhY4Q/8ox2U5uCGEglmpwkDWrE6t2mLPCYW/YW12eppFASRfvvYO6gtI
 lAVQruGvRRPrxs2QSEf9fgA4onFWwZrmsgMlWeS/y+l/k547j2mOMYwk5c777qbU3EgsYvqcE/u
 92nEdifj+nCj/grlNyT/Ru9rkUfGzCr+D7dhBJbjRYB5TIc/Z6lR5/E7bkODzQaa0w7hp8dyer2
 IihseH6TMaJvV9iOw66GvYwblU6JIDkaNfFpIncyXTo1ip6ZpbUyD6icClAYdRxOgEXTK+Tc7DR
 hhIcbqper4NrD6Ozi+h5fGdyNoHChvSIqpJ5T0N/PLBZVSuaepUyk68VNiAW9qBcq2C1h46fO+L
 o7LfJapMN37fyRRbj76ZW2puOvM9DylsWfyks6Te1MctNZ8vRcU3cE+0Jbc/Fw1Sui7sXUINwf0
 HQJzmFfYR2T2VMEJZZw/+FboENkklbPIKV3DEl38Hw8fqsIpHUbjglWimxqWSGP8PZcWmXCGEBx
 f7XXnB+9e+aH5KugMC1W23uCgTHuD7qqSmp/r1mKxFukELLlIUG5w4M52//nyeZiTnEGvoR5SMw
 Lv7jmJW032cZvbCyf/vtRnsDKKo6mPTOYygn4bi2GOoMol+UJUJrffVHOg+QnLCaGJiUZcApTFn
 /yLtwQl6DJvfb0A==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Use per-implementation event tables to allow supporting implementations
with a different list of events and event affinities.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 65 +++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 06fd317529fcbab0f1485228efe8470be565407c..1bf7ce5c09846c699d66bdfcca129f418a9dad9e 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -42,9 +42,6 @@
  * moment, we don't really need to distinguish between the two because we
  * know next to nothing about the events themselves, and we already have
  * per cpu-type PMU abstractions.
- *
- * If we eventually find out that the events are different across
- * implementations, we'll have to introduce per cpu-type tables.
  */
 enum m1_pmu_events {
 	M1_PMU_PERFCTR_RETIRE_UOP				= 0x1,
@@ -466,11 +463,12 @@ static void m1_pmu_write_counter(struct perf_event *event, u64 value)
 	isb();
 }
 
-static int m1_pmu_get_event_idx(struct pmu_hw_events *cpuc,
-				struct perf_event *event)
+static int apple_pmu_get_event_idx(struct pmu_hw_events *cpuc,
+				struct perf_event *event,
+				const u16 event_affinities[M1_PMU_CFG_EVENT])
 {
 	unsigned long evtype = event->hw.config_base & M1_PMU_CFG_EVENT;
-	unsigned long affinity = m1_pmu_event_affinity[evtype];
+	unsigned long affinity = event_affinities[evtype];
 	int idx;
 
 	/*
@@ -489,6 +487,12 @@ static int m1_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	return -EAGAIN;
 }
 
+static int m1_pmu_get_event_idx(struct pmu_hw_events *cpuc,
+				struct perf_event *event)
+{
+	return apple_pmu_get_event_idx(cpuc, event, m1_pmu_event_affinity);
+}
+
 static void m1_pmu_clear_event_idx(struct pmu_hw_events *cpuc,
 				   struct perf_event *event)
 {
@@ -516,7 +520,8 @@ static void m1_pmu_stop(struct arm_pmu *cpu_pmu)
 	__m1_pmu_set_mode(PMCR0_IMODE_OFF);
 }
 
-static int m1_pmu_map_event(struct perf_event *event)
+static int apple_pmu_map_event_47(struct perf_event *event,
+				  const unsigned int (*perf_map)[])
 {
 	/*
 	 * Although the counters are 48bit wide, bit 47 is what
@@ -524,18 +529,29 @@ static int m1_pmu_map_event(struct perf_event *event)
 	 * being 47bit wide to mimick the behaviour of the ARM PMU.
 	 */
 	event->hw.flags |= ARMPMU_EVT_47BIT;
-	return armpmu_map_event(event, &m1_pmu_perf_map, NULL, M1_PMU_CFG_EVENT);
+	return armpmu_map_event(event, perf_map, NULL, M1_PMU_CFG_EVENT);
 }
 
-static int m2_pmu_map_event(struct perf_event *event)
+static int apple_pmu_map_event_63(struct perf_event *event,
+				  const unsigned int (*perf_map)[])
 {
 	/*
-	 * Same deal as the above, except that M2 has 64bit counters.
+	 * Same deal as the above, except with 64bit counters.
 	 * Which, as far as we're concerned, actually means 63 bits.
 	 * Yes, this is getting awkward.
 	 */
 	event->hw.flags |= ARMPMU_EVT_63BIT;
-	return armpmu_map_event(event, &m1_pmu_perf_map, NULL, M1_PMU_CFG_EVENT);
+	return armpmu_map_event(event, perf_map, NULL, M1_PMU_CFG_EVENT);
+}
+
+static int m1_pmu_map_event(struct perf_event *event)
+{
+	return apple_pmu_map_event_47(event, &m1_pmu_perf_map);
+}
+
+static int m2_pmu_map_event(struct perf_event *event)
+{
+	return apple_pmu_map_event_63(event, &m1_pmu_perf_map);
 }
 
 static void m1_pmu_reset(void *info)
@@ -572,25 +588,16 @@ static int m1_pmu_set_event_filter(struct hw_perf_event *event,
 	return 0;
 }
 
-static int m1_pmu_init(struct arm_pmu *cpu_pmu, u32 flags)
+static int apple_pmu_init_common(struct arm_pmu *cpu_pmu, u32 flags)
 {
 	cpu_pmu->handle_irq	  = m1_pmu_handle_irq;
 	cpu_pmu->enable		  = m1_pmu_enable_event;
 	cpu_pmu->disable	  = m1_pmu_disable_event;
 	cpu_pmu->read_counter	  = m1_pmu_read_counter;
 	cpu_pmu->write_counter	  = m1_pmu_write_counter;
-	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->clear_event_idx  = m1_pmu_clear_event_idx;
 	cpu_pmu->start		  = m1_pmu_start;
 	cpu_pmu->stop		  = m1_pmu_stop;
-
-	if (flags & ARMPMU_EVT_47BIT)
-		cpu_pmu->map_event = m1_pmu_map_event;
-	else if (flags & ARMPMU_EVT_63BIT)
-		cpu_pmu->map_event = m2_pmu_map_event;
-	else
-		return WARN_ON(-EINVAL);
-
 	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;
 
@@ -604,25 +611,33 @@ static int m1_pmu_init(struct arm_pmu *cpu_pmu, u32 flags)
 static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_icestorm_pmu";
-	return m1_pmu_init(cpu_pmu, ARMPMU_EVT_47BIT);
+	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
+	cpu_pmu->map_event	  = m1_pmu_map_event;
+	return apple_pmu_init_common(cpu_pmu, ARMPMU_EVT_47BIT);
 }
 
 static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_firestorm_pmu";
-	return m1_pmu_init(cpu_pmu, ARMPMU_EVT_47BIT);
+	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
+	cpu_pmu->map_event	  = m1_pmu_map_event;
+	return apple_pmu_init_common(cpu_pmu, ARMPMU_EVT_47BIT);
 }
 
 static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_avalanche_pmu";
-	return m1_pmu_init(cpu_pmu, ARMPMU_EVT_63BIT);
+	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
+	cpu_pmu->map_event	  = m2_pmu_map_event;
+	return apple_pmu_init_common(cpu_pmu, ARMPMU_EVT_63BIT);
 }
 
 static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_blizzard_pmu";
-	return m1_pmu_init(cpu_pmu, ARMPMU_EVT_63BIT);
+	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
+	cpu_pmu->map_event	  = m2_pmu_map_event;
+	return apple_pmu_init_common(cpu_pmu, ARMPMU_EVT_63BIT);
 }
 
 static const struct of_device_id m1_pmu_of_device_ids[] = {

-- 
2.48.1

