Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DE219DF60;
	Fri, 28 Feb 2025 04:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740715932; cv=none; b=ANHGBuGRGSs7lGPGbLaJ1xniC3BPmRaGUm86qJuIpknRDIAGZd2PurEA+MC9nzKKMvd5eEb59Wv9owqXrd1wkwduj9xOkXr6ytSzqZ5baZOU45ATg4i59ZpEinA1Ib/KdRtLlWUaG48/FfSbtTwmh3aHQmOYkxuVQxLTYt2SiMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740715932; c=relaxed/simple;
	bh=8lUtIdaUZ74bJi6U5U+SM7syFrwG6QLTTZ/s/7A0PwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=agYkpa+Xk0xGdDFo2TQEIDhlz2H0ljJPVSFSTnFxb0EMA9lJ+Xbdgsepxq2ghbiOEytHZCA29uQ8mbMRWHV18otki+6g6dY4RA2X0z3dszk39WfaRDL4JPyrsug20IcWqZ/u+Kjs1u+/f45UpFMCJgywCnfHk502LX6I1rtB7Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrzF3iIb; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrzF3iIb"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220c8f38febso32775235ad.2;
        Thu, 27 Feb 2025 20:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740715929; x=1741320729; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7l6OBjbdguvzVanhyg5QiPXwRgVYnvgdyH/pw82tHlU=;
        b=TrzF3iIbygKUZEnk5dTolWKoXS4Y2emnZPvfV9uEbf5s5EqExfVyQcLJaP3YKT0CkS
         10je5gh5nTJos8+UhzuNP5t4iiO1Z6J2CgXFmE3LtDpa1WMAmf6GFjO55Z3tPtJt3ObV
         m5l3u2BzqLbT5QChTiJzpPh69NEkGwW8C/fTWYxcKnDmUF/126rD8VzytefcZGuicGOS
         J8bqwzvQXnly/i0hobE5SKEz7vqUJBZjswRWQHXYDuEOdoaYj2qc8isNQAkf8l8USpAa
         ojQ30/JSzEByT+UB/JSitD+N98b/FFJcK/FmHUBIki8dUWtSkx8J3HgfHzTYeKlxsKSU
         Hsjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740715929; x=1741320729;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7l6OBjbdguvzVanhyg5QiPXwRgVYnvgdyH/pw82tHlU=;
        b=ATHQA+BfFXcVEHAguC8EK7sHNcGh9+wdKiMsiRYRQUDptbukcoP5pHqC7MzmWKPB/a
         Bv1jy1EeWZTcbW/4vfmmvci0VVeE4tBi7YjJZ1YM7H0mvReb5kHnY0UQspHd2gNS6LCm
         YDGGzXHG1kCXmNiFTbhRJjh9OdkOdWSbs3PkdNZEskN2LITGIHIGVOwfyBswoJ2w7v7F
         rlz7UiZ7eA7uPmF+doO6xpjPvVri4q1x7xKIwS7kYjIv/fIxoCcCNya6ZMWKBVz4MBrm
         uZZgIw4qtbp7S2YqdvcqOT+Sguw4b/UzS9XF2jcn78idOxuyZ6rZ7/8cuxcLDWqM/gio
         Za5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVeJk86GuSYlNC45OVoWjOULdXynNpgmsSYj21hB45B4BCyTbbLHYuaVc8tcm6GOKjCDVkDrCIs7tdZLmEf@vger.kernel.org, AJvYcCWQ00ft+42Z71G3u9fZrZQ2mSIT+aoFmlI4npeCLbrnS492wWmVC6HYtOkGcXVnjfZ6nn3b6JWvpTfRt1ZvZetSWw==@vger.kernel.org, AJvYcCXXctTJmk2P2M5ssln/QSHQhiH1oKkiyxiEmdng3A1wt1vF26FeSr/N958Sd8xIm468Z6Z/x5+B1Me1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8tbXMwJ917Ah4lp7buuO4egPzR0FC4X+Qg/0iTbVlIbsifKRt
	cizFx41Qh6OP6p3AiIMEWjgTHU0jfwYCNTmGax7Rjna4yIf0OsbwV0dQyQ==
X-Gm-Gg: ASbGncvyzUHrXo0JOgXpimyGDynO1ubiRMdRqZvW8EgpupOshaEETgLnuCrRxBAWhGG
	GO4KT2OA9lTay0u/qry/j7QONkh0CdlKeXi/IFzvYbGOXszH3zuJz1+wEhGemVpYJF93C3sRB50
	x5awFFbapOrGhWKY4GZ9CAaaA5T+uj11GjYsZwdHAW0tczEm/te6Cjk3Zl5TbCaX0ttQ9R2+9Ae
	qQwiKGvjBOLEhyJzwPWvsvlgkXXPEN+34eAM1NoL+kjzOI/qBjO/pB5sil/++Vt6Xd8yshaoE1v
	k62z3HjtpJOoNhv6/hIDlnf7cJg=
X-Google-Smtp-Source: AGHT+IEYDQXIbIUl2hA4mQuIhbcCAjga8Xha/YZWkkdwnPtEP1alrz7wepIj1Qzk+976osnHuTy2ww==
X-Received: by 2002:a05:6a00:84f:b0:728:e906:e45a with SMTP id d2e1a72fcca58-734ac42cf9amr3499439b3a.24.1740715929284;
        Thu, 27 Feb 2025 20:12:09 -0800 (PST)
Received: from [127.0.1.1] ([49.130.74.133])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-aee7dec4114sm2387856a12.57.2025.02.27.20.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 20:12:08 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Fri, 28 Feb 2025 12:06:42 +0800
Subject: [PATCH v5 02/11] drivers/perf: apple_m1: Support
 per-implementation event tables
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-apple-cpmu-v5-2-9e124cd28ed4@gmail.com>
References: <20250228-apple-cpmu-v5-0-9e124cd28ed4@gmail.com>
In-Reply-To: <20250228-apple-cpmu-v5-0-9e124cd28ed4@gmail.com>
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
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnwTeIlNpHaNLlhhgZedgrNR6t68Y3sydP5gJ5+
 ljYARuhnNmJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ8E3iAAKCRABygi3psUI
 JPGzD/wKgqCzV5ZnQ85NmEg/pVw1MVnRCA+PrdZeO37Pd5acoqcah8YEn2aWYYSSIlzWbJDocPg
 XMMjleWGaV5iHrCuV6W4NeDn3tuU0lv/9ENekmf0NrAbQOiFO6rvA+4zabdUS0tBk28CZuEIepR
 9RRO6CAqB3j+C5iVNc2LgxSlUyQeuLjx63ObExJrn8uz48sl9B6YjTo8nsXZGUBNH4m0tz0NFWS
 yHNhHD2TjGg4kzVeHN7UjkEx5RtyQjmIrN9kSRVesUdWHH75XWSyW4M9WfPPSv2uoSniPSYzmf6
 b3s6BfRHQBY7r8qxFzWujHarI50eADEDttFO/bsfKNoNvl2944xJNpT+aoxyemVfL8+fwC2+b0f
 N/t8F4m/IxS+BWrcM6p19NaQLoOdTZ27EjLvPm8y2A196sFAPzguEkKZY+rQ+QdMjk+xAxqINFF
 AIeeKNUOP//ubWc0ijZN+uq4WJSDUmGxFWaHB1uaNLgh10zk1j7acC3s1uMSsKFRiKWpCw8HLaF
 mfH+sB6tav8ZkEpJHE6wW1hfK9QeI7iRNmti844sjYHMv+6coFXS9n2MLWFqoDeW/mB0KLt6Wz9
 fsOrtC+cGKNWTQwYYpqYNkpMurIcc28Tky/6eni1+eBSf7sOkn/vTDSqaniJs4CA5DlLv5pncPb
 mIKs5zLkFno5Plw==
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

