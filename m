Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CBB2222D8;
	Thu, 13 Feb 2025 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457392; cv=none; b=eDOu5Jt20HMHlEsaDExC3hUFHU1TG6LPHdZUIqJOlflWkF1h7Kp7j+DObmHjnRdv2V9f2rD6YRaaLOQNmLTyoe2xuEPDaf1uD1reVpEWeN3Pi1zzj3DzPAAtxuZU7nWxr1Ntrs0wlNmp2iJFd/vjAmjI7JVkAur0iK2IYUNfrJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457392; c=relaxed/simple;
	bh=8lUtIdaUZ74bJi6U5U+SM7syFrwG6QLTTZ/s/7A0PwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T9TlVnsZukYSeP2FaOYW+FWK+ICGOutcvWghlHpaKCmG4qov1kA+aI8Brp3i+8/yBjUlnWJNzEfA6y8Q3nvnUMPwXd8UmdAC2b4MVT5KrVp1b5Q3OnFLd+22uq0Ft+1RTnvLy/Z0JI4+BI2wzRy6D0Td8NMpsX1C7gu+EGJIWfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERjo/Nr8; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERjo/Nr8"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fa8ada6662so1864299a91.1;
        Thu, 13 Feb 2025 06:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739457389; x=1740062189; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7l6OBjbdguvzVanhyg5QiPXwRgVYnvgdyH/pw82tHlU=;
        b=ERjo/Nr8Rh9pJJ405dGkY1sQtTZCo+gUmbMHIFpuVwtqYywQRPOKYgnvY2ofgrC6gy
         EYyoFsfO0dSkJEKaHUiikF+Q/T31eu2HM/1Y1qCq6sdu1cLVjuz9QRN4gP78OjFlcKha
         TlPjypc1cMA+89Q+ht9/wPFFe8kWS2L3tAyME+4JWw/CtfLYiWjN2byrhM4RmB/5zwKX
         N9Vx0CkLswGCdBwLBqxEO8bYNE1AC5BWwNgNf5AFgItuJGcnjVpPcyChWm3BpEyJY7HT
         DQJz2Dmv7oglVVnKCh340V1KdHHW9znsOt2os7Ps6ZN3pZQq4foOiYhZgrmRy/dCKX+i
         A1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739457389; x=1740062189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7l6OBjbdguvzVanhyg5QiPXwRgVYnvgdyH/pw82tHlU=;
        b=kFaa3IFtuv0TjTno5FKTzSjYZr2jWPH6pQEPeMeNO1mHr3NZDRf3Toz8lIHJYBJLec
         shzW/3U0eTpmdj9k91PZkNtYNqy/vUkgwtoTnR9dh8sJP+CErcnr7Fzl9lN9N4xc+Pgl
         gQLqSlOFZR5/dSuSnEa8lmFy5URZNPZC/N7xd/cmO5+qJbtv9CxFKLwk3tzj3v7zAg7i
         wVBMQNlqjxHgN98XHTTRSz5xWonBT8ZjeML0cJWrxTbMlcXoNhxnHpSwyWx3kOk+jAAe
         CbnoTifmmNqRiLhIUfFxOZFphAYbSTZxtYpoZ//HqT29J0NOUtxz9p76eb+2TNX1sNG4
         IA9w==
X-Forwarded-Encrypted: i=1; AJvYcCUMA+So9EHuZ6o5deWZw63GpM7VMkNdpJB0Y44GDpkiDFvUagn7kdxtikhXA3XVtUH/jb89w8fUWYHx@vger.kernel.org, AJvYcCV/7e+7dWTF9Y/TdHaI2UEolhLLiPKCkg4MiYrFF03wkx9N40Acun0lGlTpzDESJ6cJkLiiX8o2LTjG/kvgW4LjaA==@vger.kernel.org, AJvYcCW/Owefay7Cr6wARa1hs9o5gJA71MfceeQGC/pirFj5sRVgxhjJN/ukFEwVEPwQ2RPFjLfm0RyKnhz23OqW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2+EZGfenGhyGMtjAHcIEJz8hoUhgyTgG2VcX/8ykqT7AQUtUr
	K3x8oiDqaXJyJj6EKM6dmsjV2c1zzmqJ9YeDp3szitCb3c+HduT7
X-Gm-Gg: ASbGncu9BpaEGayY2Ll/q6AQN7HrdULaBD/J7R4cv2VuNniPvdfBAI1gPrLlklp7MQX
	ML1mRsbk9DKnzZkLX+FMZToYBm4WHE8V/mRKom75cz5THJsykh5I52qnHXMFR81q8BqXkTpJpdD
	haJnaXNzCT57IaVEKgMF6SRxinVzMO/Aewa1ZQsFtsj8U0QUeD9LTuReyTefcOrOUvt1dXmXWDl
	E69a0yZ/Tv6raQqdTGkna+w56PwFBYsf6E6FHdGjT33VBoT/qCPIy6D4DZonO9u9/JqSKsxCPAl
	2d60eCgQ7/FLgimw8Q==
X-Google-Smtp-Source: AGHT+IGqqiPjx/xvESUvDV6JJP7KHZMh5lbCYmIQOaYARolGu9SAVW0ae8w3Wzy8lFkcnMAfkDpaLQ==
X-Received: by 2002:a17:90b:2dc8:b0:2ee:ee77:2263 with SMTP id 98e67ed59e1d1-2fbf5bb1d1bmr11556616a91.7.1739457389372;
        Thu, 13 Feb 2025 06:36:29 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2fbf999b5b4sm3655165a91.30.2025.02.13.06.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 06:36:29 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 13 Feb 2025 22:36:04 +0800
Subject: [PATCH v3 02/10] drivers/perf: apple_m1: Support
 per-implementation event tables
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-apple-cpmu-v3-2-be7f8aded81f@gmail.com>
References: <20250213-apple-cpmu-v3-0-be7f8aded81f@gmail.com>
In-Reply-To: <20250213-apple-cpmu-v3-0-be7f8aded81f@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5765; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=8lUtIdaUZ74bJi6U5U+SM7syFrwG6QLTTZ/s/7A0PwQ=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnrgNiHtHdtlJEqZY86tRJY/Yt+POi1Wor9jrCS
 Ce3MhA2w0mJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ64DYgAKCRABygi3psUI
 JDubD/95vTRUzOF24IYySpgZ7RqMbgtInCO1tudyRQnMCGsmMQWWDDbZQqz97KbYY4joEXqa4Vq
 wxc5qTnq/0qSLtz/yxXf6iYRiQjCCsWODtIYs4lqxzBlqXy9PEIEG9AUQ5Ot/2Qbu9/nmM6XTdG
 UHIZZB3mxKl8vAnPPfUDtrUQ+ioKSUpObr4oot2VlgJG61K8tYgC7JYzIXdbeUBPX9olMsfmrpC
 1FkvsO13EhsUCsR+XpHuu9bjXx35OGyU16+4EgPZKUzTO+lxkNPtU01NkJRQkEpFoPBAi+L32+1
 mvy587EdAR0YCsKz1zsXdtPUL0iD1kJzNuIQII9Uctcxu6Ltqu0rfK13WqMSSJ64Z710HOnwV66
 4XVF7ZTdkkdJGCqTf32d9EOVYydymLmg8XVj4ZV/+eKOztKBf4R2KFzpukiDiCCF0MeCdwvBAG+
 9bce2ya2cg6Jf+Zj1/MUz8EetJpXAYfzhuEszjmA0N0XgLUULzhR9oOdkcvLZxU3oY2UkxH+be4
 oRUDw9tx83cy6FjB2TELZ/bxSGZNwB0CmGvDMGWN3EgJEa+hCMKktV/kYALvJbbU5toN+E9aBR9
 nbDz+p2+YP0GvJrN2UJJB4TAPOCkgGKO0E37TiXaNxUuseYfZdLkdawIvqA9uvr/NzUPl1aDYZ3
 380mztBSV6Dszzw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Use per-implementation event tables to allow supporting implementations
with a different list of events and event affinities.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 65 +++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 06fd317529fcbab0f1485228efe8470be565407c..dfd5d72ce9f3c5bebd990b5df6a6823fb7785cce 100644
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
 
@@ -604,25 +611,33 @@ static int m1_pmu_init(struct arm_pmu *cpu_pmu, u32 flags)
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
2.48.1

