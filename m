Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D7334D384
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988690; cv=none; b=ELPwStOcdAM6dBnjTXlkdTbupJVn52FObukpwrPN7BynJMII+52p4hjnLe/DH4DDAWo7nDSxP1jtnJIhor8bQXVLpHW3EKWB8+jQ2NwOCQA4SwfEFONa6MLQ9uKIFXqgxKmHt+0EOo29/kvu5geZpOsbHmX4skXqFGJjhDSj/ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988690; c=relaxed/simple;
	bh=GEbwxw7PfrqcXKYl5oW/iB71cJY49weGjklHwoM3hyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s7H28oswUIUKHSIg2/jS+9jVs2OZQ5kDwzPfjEM8wglEZdm3iNbDiuRYE2uuwvpRcgzoMfUonzEgxwshcZEafg78KybVwC8iR5nXuVxDUc3bi4OZCAt6vUpdWaZBK/7CGRUAHxMcOrTSvAXKFEiIysLdT3pmAsahfhY8p6os1VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3C4fmFd; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3C4fmFd"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0fe77d141so40049175ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 08:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765988688; x=1766593488; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=baePLKadh5VeuMN7NIEHaBw4znqNJn9lrkTnuuN/n4Y=;
        b=L3C4fmFdp+5HNxtZYt3f58IjnXtepQUvA85tgHSn2fLk3CjagZfWI3Y1b5MEpkQvMj
         iDy+PzdeDTSZ12imaKTEA+wOW8PTfCP3DTv567hYC07eg6p5VdEhSBZlZnOrHEJBrXkY
         YvraHkFgwTkDSxuSwvGx00C/GKqUtgKPlDGb6HvOzpRVpW4T8wvyKYrJeAltSlEaKpy8
         CL2CxTc+a/qBM0h/nYPAtYVPdbFH5qCtx6ROUAMWjn0XQhldA7rrQI1DzYEFUcdDOBSg
         2BqTG+vj0EvGsOl7sXT087/JMpfT7oLJhzPvzBideyeaGqqxiGPSvf/mlAo7cLMT7LPe
         ux5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988688; x=1766593488;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=baePLKadh5VeuMN7NIEHaBw4znqNJn9lrkTnuuN/n4Y=;
        b=WHQcdExy+dLL/iqgCs2suC1BmKcqYz56m+y7zdB+wDlqFowW9hoilC9T8YRKhvwCg/
         rlAQMkh0b3kAQea+TftgzLFtMFx4oTPeL4xM+C9duMJj21vZSoIeUozwil7rUSvF4Q/G
         ev5WVQqeZ2O7mG5cJlOVhOhcc0loGzKqFLeDOUR5/sJ5h6rDpOwvgxoh9026JeS6meCM
         ep9HThAf485tUPwf+hCF6vsNfcNBpnGjOjGo5fOIVgkruartM+NUyft/75i/KfYDLYy/
         tYA5b+pk73ILdSbCLMEqvdqt9L5LSOrYHtFaBgoku1sl6q6eZMBr6KwjuM+WNhUZZoy1
         jXQw==
X-Forwarded-Encrypted: i=1; AJvYcCWDpzh6MxhGUiLJVQXhWXVOdABzojZQ5Pz6lwMD1Lr/rc0BRhfkG5Z0kc7Q3OINQsMffaLKcKuvk8DLJBWAPJP3@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrh4uI2r3lahXtKs6oL1PprDAI2LmLmFuH2lf0gBmANQnUTjmq
	spBPTj0pPCowRPdMb33JsWnULDqtMfSmyk5NRGNJxelZoJ5VyJD0GLfu
X-Gm-Gg: AY/fxX6PGz7hLVaocUC8qNXX33WN1QZJihDjsmtKbl2W2PO8m039iXnLCbtfMHW6OV/
	NjPDmavg0/8DcrYaS1jG65gTv9zTIHVR5GANESJVl6OG0y3bG/+c0JbeTc2Ii9wM9pd2X8kiBgO
	8lMi/aPKLew6BqS6F+PFTlAcRc9rKvCwuILYLPKaAf3Ax37e+vYXY/M9ArQHlKgcGOiVJ0eNpDu
	OnF205iBGUn73nl2MWuoTMX+LH4igvnewNHsvnXtAzz31yVbIe2Dtt9AtyMxJtxRFXQzegK/iQh
	LnrBST7wycaPkM/gUhIMaZZhqeL+VraDWepMOb2oTLO+UMwpxsYZNOxKjq+C95qWajksrGbtog/
	Kecry3LYAnhxQjOI+lqtW9kF4gUmEvgoK9jZEm8qSI7DUrhyiAmT9AduaU3rtu9EroxpNEJWaHy
	5b1rgyi5x0xE34
X-Google-Smtp-Source: AGHT+IFnI76IAZxZQYfdU0cvowu4POt/fXHKU7/xVVfniBzosjklThD5++ABZlM8rP8ORaLE2hP2Rw==
X-Received: by 2002:a17:902:d4c4:b0:2a0:b06d:1575 with SMTP id d9443c01a7336-2a0b06d1731mr114240415ad.51.1765988688494;
        Wed, 17 Dec 2025 08:24:48 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a0b0687c62sm122980415ad.88.2025.12.17.08.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:24:48 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 18 Dec 2025 00:23:16 +0800
Subject: [PATCH v9 03/21] drivers/perf: apple_m1: Support
 per-implementation event tables
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-apple-cpmu-v9-3-4deadbe65d03@gmail.com>
References: <20251218-apple-cpmu-v9-0-4deadbe65d03@gmail.com>
In-Reply-To: <20251218-apple-cpmu-v9-0-4deadbe65d03@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5769; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=GEbwxw7PfrqcXKYl5oW/iB71cJY49weGjklHwoM3hyk=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBpQtlA+kasIgm1d08qjNIxyta1PI/a/3sOaDdH7
 YA5jw2xb7mJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaULZQAAKCRABygi3psUI
 JDdwEACPnOcKvw3tvd0H4PzxLqD37zGgX4/vymjIZG3u0NXrwb5zOPTzw8WJKqkHmNqGfnO11Ib
 scXDgtoGbyWB9s8gBMerBXP4ThOrNXZbv5hR+KklI55lXDp6wD7Fm9uMbC2stuM2AyLDDT4FJQ6
 Kg1KdCqLc3pMjU3NY6G+AEI8FCxvU3/um9aRSUHW99YriLwj0JXjzu2LaNSTPdt1DB4JYb1ybe1
 5Ge2W4iv61OD7NhK2l+AyvyVMQ9hir4y9EQi4TpmgVIt6HnCAbscER8Ynu3mVSwONZQTC9bjrTo
 Xgiv2JyYMU6AqjdLKSgY9S2FumujMQuSXrelx8Au4uTtydMNq6/s9kkdq9TdPM6mMORZw88ZmSC
 Zrm1mXk15raFVffuG/Q+y1wvyH5CzVqqGDo7EiBMkoVIMv6ry1wDSd8ZOIEFf5XckNjkbT9SMLp
 A1Iu+CESQcJVexLbhZS5fj1trysT5xUjBEeMaPFVj9FZ/HFK8A+JdP/Umq/eDOTdwvqqklqY3Sk
 8SbZxkxPnaP3ojeFJCNDjxJfHkxSm8LaOYrFXAwVcFQrM85heU5PqBVGpqGw5I4ukbyJjDKrdWi
 bVvyyv6jU9dT2ShKSykzKE2E6lUZJPQ03n28lcgq4Ub8g5NP+CBjMOzqLET7BQLVGfjm6ACLC33
 YzBMTzWFhphvd4Q==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Use per-implementation event tables to allow supporting implementations
with a different list of events and event affinities.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 65 +++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index f3948528e28e0189efd0f17fde0d808930d936af..b4ab6a3e5df965b7ef450d7e533995f3cc8633fd 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -43,9 +43,6 @@
  * moment, we don't really need to distinguish between the two because we
  * know next to nothing about the events themselves, and we already have
  * per cpu-type PMU abstractions.
- *
- * If we eventually find out that the events are different across
- * implementations, we'll have to introduce per cpu-type tables.
  */
 enum m1_pmu_events {
 	M1_PMU_PERFCTR_RETIRE_UOP				= 0x1,
@@ -493,11 +490,12 @@ static void m1_pmu_write_counter(struct perf_event *event, u64 value)
 	isb();
 }
 
-static int m1_pmu_get_event_idx(struct pmu_hw_events *cpuc,
-				struct perf_event *event)
+static int apple_pmu_get_event_idx(struct pmu_hw_events *cpuc,
+				struct perf_event *event,
+				const u16 event_affinities[])
 {
 	unsigned long evtype = event->hw.config_base & M1_PMU_CFG_EVENT;
-	unsigned long affinity = m1_pmu_event_affinity[evtype];
+	unsigned long affinity = event_affinities[evtype];
 	int idx;
 
 	/*
@@ -516,6 +514,12 @@ static int m1_pmu_get_event_idx(struct pmu_hw_events *cpuc,
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
@@ -543,7 +547,8 @@ static void m1_pmu_stop(struct arm_pmu *cpu_pmu)
 	__m1_pmu_set_mode(PMCR0_IMODE_OFF);
 }
 
-static int m1_pmu_map_event(struct perf_event *event)
+static int apple_pmu_map_event_47(struct perf_event *event,
+				  const unsigned int (*perf_map)[])
 {
 	/*
 	 * Although the counters are 48bit wide, bit 47 is what
@@ -551,18 +556,29 @@ static int m1_pmu_map_event(struct perf_event *event)
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
 
 static int m1_pmu_map_pmuv3_event(unsigned int eventsel)
@@ -623,25 +639,16 @@ static int m1_pmu_set_event_filter(struct hw_perf_event *event,
 	return 0;
 }
 
-static int m1_pmu_init(struct arm_pmu *cpu_pmu, u32 flags)
+static int apple_pmu_init(struct arm_pmu *cpu_pmu)
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
 
@@ -660,25 +667,33 @@ static int m1_pmu_init(struct arm_pmu *cpu_pmu, u32 flags)
 static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_icestorm_pmu";
-	return m1_pmu_init(cpu_pmu, ARMPMU_EVT_47BIT);
+	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
+	cpu_pmu->map_event	  = m1_pmu_map_event;
+	return apple_pmu_init(cpu_pmu);
 }
 
 static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_firestorm_pmu";
-	return m1_pmu_init(cpu_pmu, ARMPMU_EVT_47BIT);
+	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
+	cpu_pmu->map_event	  = m1_pmu_map_event;
+	return apple_pmu_init(cpu_pmu);
 }
 
 static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_avalanche_pmu";
-	return m1_pmu_init(cpu_pmu, ARMPMU_EVT_63BIT);
+	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
+	cpu_pmu->map_event	  = m2_pmu_map_event;
+	return apple_pmu_init(cpu_pmu);
 }
 
 static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_blizzard_pmu";
-	return m1_pmu_init(cpu_pmu, ARMPMU_EVT_63BIT);
+	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
+	cpu_pmu->map_event	  = m2_pmu_map_event;
+	return apple_pmu_init(cpu_pmu);
 }
 
 static const struct of_device_id m1_pmu_of_device_ids[] = {

-- 
2.52.0

