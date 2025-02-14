Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CFE266EE4;
	Fri, 14 Feb 2025 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739543437; cv=none; b=mEtNyiYIaLGov0TL5YmkkFX2EX7HaTPIcC/wtLyHE5faPaOz/o8wwAgbViDrAFSTK9lkarokwvh0yLrwSmYiTWFfxml5buAtm6CZnMNZlb6BpS2Fg1KNXwSLx3tQ/9wMi5mIXhI1CJOR4HD62tYxT3xhbR0vxXXiTWPi7xpBUUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739543437; c=relaxed/simple;
	bh=8lUtIdaUZ74bJi6U5U+SM7syFrwG6QLTTZ/s/7A0PwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CDFRTG7VCfQ8DLGvN82DpSc7oLSh+MY1FxHudhu3IR7/M8bvYwNuf/HMkSYYaQLEkwAckGb3Z69GYexRf9I9HluOkMVb27bDsWDBo6+1EOrwPlAS8UzNHx8iBlyu+aEfWm0nVkeyPVM6dxHDVBFzd1sVSRq5St4Trbhy9+tJw+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eERrKO6G; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eERrKO6G"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f6a47d617so36840945ad.2;
        Fri, 14 Feb 2025 06:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739543435; x=1740148235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7l6OBjbdguvzVanhyg5QiPXwRgVYnvgdyH/pw82tHlU=;
        b=eERrKO6GdAdSgKLegOmxHJrdZpbpxzdxi3FSUXagCID6sxotn3trfAlkFU8p54tGxb
         ec2azjIQA2CVZxs7CG9L9+mMNXgCSA8KWxfpejVK3pKsSR7a2kuWRWB+hVU2Dpb0bmNa
         dAQ0oFpKXgwarojxiL7xO/IWb2OK5WSidisW61FS7T1qBxs8kyVoXfcy2YXwR2F+FGD3
         Vl3j40+XZgxACKYX6kcp85fjd1sAotYUhuCtIDZrcHR1nAgPRMmuSuoATAgx1FfpJ7lG
         kXtINwuSlO8HdKJCUt0Chs0gHs6dkvvdSQkXtqu75jPVT3twTkTrodtpZVNMYl/7QCYG
         EO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739543435; x=1740148235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7l6OBjbdguvzVanhyg5QiPXwRgVYnvgdyH/pw82tHlU=;
        b=Lw/2NoJ9Ivv328WoHunTTalAYI09aTIOOYysZpz3H8dHBCJujnf0Y1TaLmQdkq5GMy
         jHFLgXpZqtr7/6lt78maeYWeSYeoSRdMbP0GukySl5jONGcV2GeZ1McTfVWPwdgimUdK
         8MKpb4Kvz4Lk3lmTmsYiyUx3iDrPytCAsl6aoYfcixUVOPpXh13bwvGkvbTzvbriI+jD
         68lUcdVqYhPBgCnNUw/SoErw9IkOLmJvZLj3UbtrZYrTnjWbguBA/FeaNTYbXFrAiBsM
         /01lkTASIchBxYYpj4wDYJ4R4VYY2EsQNE8/bYpGY9CQSaxdtSxMIuO9Mb2pmtITITQJ
         0mdA==
X-Forwarded-Encrypted: i=1; AJvYcCUOYF3AJnjtkv3sQyL47gMJ3N7/vVAbAGZ7yUnU0vSFaCMnsdISExxmKH6EiEBJf2Ps0Nqq8ry9jTLYfpI1UHZXHg==@vger.kernel.org, AJvYcCVaManeDSsCtMoglX+s8Lse9vqw3yKqiSpmYFYtiajYO/3OJxbjAoL7Cjo8gnYPN2pVlkapFtyMNTog@vger.kernel.org, AJvYcCVnyhVJb7i1S4a8UvFrZQqdbW4fgmdM0F43l/87Ra753qd6ny5TyZl19xwQQu+jwGuZ3FmYG/h0W8zxuEuH@vger.kernel.org
X-Gm-Message-State: AOJu0YzVQgJDZKiBRMGVPJ0OAhlHeraQz1GBlKnwLlW1IoIdaPZHZcbD
	WUq/2lJEairzjCgnBB3+tb418hZqc6/C06Nw7/SCXzgSOid9xA3u
X-Gm-Gg: ASbGncuwWGzizQWya368tTrrRenNI75GFHKKTJMlLJJBLWZw38uvg8Ju1CbW/QKBxcL
	f5UkKbkCeYlMiq27jMV+svQYaiL54hnJzRkMjnygPfm+ZJshNsjsg3mFtNOgsCHmdtC1SYF2OXH
	DNX6cgapAAiGq1lpXid6oaXVgiYLt1eIT/jNfA2U9driqYmb5hTHP6bB2gzPmlZ0SVfrENs9LFd
	ZbJo+Ukwet/z7B8GaJOs95tO4mcvqncykOEQqvrbAXKZCPFlMeO+z9N68MnJBpGDpmi2N9KLcg6
	HjbtVMPLm9BCNdIXjg==
X-Google-Smtp-Source: AGHT+IG/bVbomX6ZL8o6cgIyCYELKgNnLgDTIIQLfhKHH2P1Nm6zYVwBqR15+gUOMU5DTLQtOl4QHg==
X-Received: by 2002:a17:903:2f8f:b0:220:e991:480a with SMTP id d9443c01a7336-220e991e31amr71970365ad.15.1739543434789;
        Fri, 14 Feb 2025 06:30:34 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-220d545c8d1sm29490315ad.113.2025.02.14.06.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 06:30:34 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Fri, 14 Feb 2025 22:28:28 +0800
Subject: [PATCH v4 02/11] drivers/perf: apple_m1: Support
 per-implementation event tables
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-apple-cpmu-v4-2-ffca0e45147e@gmail.com>
References: <20250214-apple-cpmu-v4-0-ffca0e45147e@gmail.com>
In-Reply-To: <20250214-apple-cpmu-v4-0-ffca0e45147e@gmail.com>
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
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnr1N/KjjlLGW1G/Qu5tuyuGcZie4elLqLg+YmX
 2T8QHqcdfaJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ69TfwAKCRABygi3psUI
 JFKREACwe+jV0g2vw8XAkjbC6c+oIJnGIRBrYdcOt3TfoV+rtn9faFUL5TEIdB444IFB4zWiERR
 DSzCT9Hdu/4mjo251rfhx55Blzze1QKW/3riaQUKfjg9/lY/1M64n4xfVQzLagAH71oiYNO8K1q
 l/V42F8xJIlIxG7n10pGc8ekOw/1zI8yyRrxpkQug4+/0bq5LAVQzTevxJC/EARux7v1yyS0APz
 gcFrnABtcqKiIJ5FR+5+/0N16UGGJTmBKbDnp4y689Vf9I8k6/XpTMh8mMxTEtuW+koR+YwI4vH
 CrYLkuZ23M65EJJ7GZyt0AtHMxFxRCtYTOnkLRKgjGYnRnXUzE83T9HQsom4vdfb3fnyDz0DhbB
 lC1N3Z5GmL0TCAWhnvXtTrUwHAa0v+DBnbOBx4gpordKhpk8CWoTKq4p2zoIyACYGPC8q2j+hhI
 JMOPIogrS4dM+99g8S2I9nxgrwkFoXIpLLdCUR8Q/dYo6ZUyVfKV8xxbO09/88t0zc9FRewoMJH
 cYNhpTbZ8/NgqoVrhyEOZ8NX3ZQZvDG1ie04xcZn8uQvxiaqYVwBifBSJD9FcNxXicfZ1f5AR7w
 UBafRRr751U+c+yMRgQNIqcCa32/+GCzYIt/+7oa1TZTzPpxKNcHeAusCKpSZ8Kx6JKqv0ImO3v
 cbqBxbcEMah8Ljg==
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

