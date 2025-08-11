Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE9021A457;
	Mon, 11 Aug 2025 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920542; cv=none; b=FCHYfaRfwuvkHtz7K2W2ZwxgJ+wUAWELv5wzYr/X1qyjphj4dxFfXq7pKcWdUbBiZoW30NvkjdafpcogmDzS7NgQguhYJh4OuqG9JR2FChEGv+52GL6hvDraJ9kt8SoxyM5QVd63IMPQ/cQCmG8S55FRrRGlMwWkLuee3DJcXVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920542; c=relaxed/simple;
	bh=QyfayPXBF0G8wGc13eGHybo/0TGaFMU6vqkkCqnR2wU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ipmj+mfJzdRfnz9zYI2/pe0W8qEeRCjCeQ95DPyBI/P9nTKySHEnVFgzapgyfgzNnWgOZlZsDuNMuen+4IJY9/SbzsgTCiY9bIP+78Myq9bMF455/8LPftWIOP08L0B0fFIe8cV6NQqGU6MisDxZt8NIoOWAzFzU5Imc5U+wj6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEaOgbws; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEaOgbws"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32128c5fc44so3455695a91.1;
        Mon, 11 Aug 2025 06:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920540; x=1755525340; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6HfG0x4eKTu65ucAx3SNv7y6476H+fkKTI8A1VI3a9Q=;
        b=VEaOgbwsG153DaXBmz3fcRu790R5l4L7J1cQAdarcX6I+hheKLVPGjxZ2X4205bmeW
         JZac9bkaKXLt+gzJw7Nfx2WVcfdgPFqWo/dcFS/6xaSc/Dp6o/ygL+x0CRkBCNtA/N1t
         LyEJoC/eD6BDe5k7NnHFSm//g9DfssPGK9W6BVRTcp4OkSD25SiGur+H6PWVVsG6/P7+
         Mh423v5gGAseenWB6ZDj1xJUL1wMGZwEgafufwZnDnZMmG6OBTSHs2ywlXHEuqUXhIEk
         VlG8IQJK2XomPCe1LJ6wGEaGtolnF/ijvk1Y5qo6MTYw9VrbqPc9hpK9V+jzINGEG6u0
         vfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920540; x=1755525340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HfG0x4eKTu65ucAx3SNv7y6476H+fkKTI8A1VI3a9Q=;
        b=NrMi0N3kV2GVy/WDLlARDg3uHn8LaZQp7bXksUX6w0G8p/hdDVkXMvRwQaKj3DHyz1
         QhNJIZYJ11AaRiaC9sYnlzl06ORXCQzIvMb9A/2Y0yb7W4zzdmh2yofYql6Poy3aVtDe
         Sf9Z23v57f0hHq/vWl1SCOtc2g/FJr7RXgZM+PiH0x0mLj5V5VFNOhabCG3o3luhqjYQ
         flf88+ZJDrjPXj5nNBDjyzzkuTn3UIlDrPiNk9OAvvWgwmHJb7VpjHHT90RqCp5PnUzB
         N9H+b0SUyyaBrNV3rQQfb2BYR2xTGmE8h30xgxxqOFwRvp7H9I40Gfmnlca3CfHHH6/V
         Wy4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEg8dSjzRKZcnNIZ2OGcfwgMy2nOEset+kvnY2OYPkfVzfajxip8fSlIA0ma0JHB1BO03N0IYGoFhd@vger.kernel.org, AJvYcCW4CniKUI5nz8LlmEQroSGc2Pn8oY1SXf+65Zx3u0FwKdA7qA5awGhA0CcJT2SCYVNXWdFLSyib65/VpzXx@vger.kernel.org, AJvYcCXPnTb1BlgqhzLL3WRMjMFL5bH1c0yhMHkWkcEwdlMYihA9e/6+Ve1nhHRldBkDrkq14uR12UKHeHI8cpuRxQuTnA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+o9tPuxtyw1EiiBf5laPYNdWpdF494q1Lxo1uB9ddKU78ePWG
	qkqS9hX6NQokKCL20I5xVnQuf5Fm02G3y+EbwegQaJECd+jDvdxcgc+p
X-Gm-Gg: ASbGncuDxf6w3ULPUV74FjzOPHF6M/+sN2kDO4TEHru8CFyJ5jhjphA2xB++lSrlW12
	4iKdjYQRGpJ/VYLtLVgSDFEiaRPiRzwA8cEVWFSknbnhgC+/d7iY9slPZPI3PcfdIa2kzGHlQ1H
	gzGeXAn0o+UwdU6yIF2+9Cr1+yyY4IrvmqUMg0ylTtVwrP1FCtLeRZdLQrRN/cL1MR/KmVbZWvE
	S9x9RFgDEr4vV2sysPaQIeZ4hMOMl8CPOUcOAcJX9K/1QHgDuMbok3oGIt9JW+5MWugqeHYRYtu
	Nc3Vf1n5RuV7zsHaj/38DpFiP7LaKwFXFksRTqykjAz9rUpiBmJokD5RaQ0TNurzqeMrJb9CJCr
	bfcId0P/8h/Yo9hCC0/VB1KLCs3PpdI4ntkhVLOMLr0FnH6o=
X-Google-Smtp-Source: AGHT+IFnVl8UL17RZBUa0BT0F/Rcmkalku9A4g8RHGTBDR8nQ5SSWKMfWiQxEunTch+bh2Al4PgqhQ==
X-Received: by 2002:a17:90b:2784:b0:315:9624:37db with SMTP id 98e67ed59e1d1-321843734ecmr16913945a91.3.1754920539694;
        Mon, 11 Aug 2025 06:55:39 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422bb1133fsm23585496a12.56.2025.08.11.06.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:55:39 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:54:36 +0800
Subject: [PATCH v8 04/21] drivers/perf: apple_m1: Support a
 per-implementation number of counters
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-apple-cpmu-v8-4-c560ebd9ca46@gmail.com>
References: <20250811-apple-cpmu-v8-0-c560ebd9ca46@gmail.com>
In-Reply-To: <20250811-apple-cpmu-v8-0-c560ebd9ca46@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4845; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=QyfayPXBF0G8wGc13eGHybo/0TGaFMU6vqkkCqnR2wU=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfZB/jzaufq4SFk1QWLQjOeskxIK4AYQnfCzk
 syEmMG9sFKJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn2QQAKCRABygi3psUI
 JJqLD/9LU2/IiF1sAyfa6B9PDwRmjRl8FIefRE3GDyob6PaDFikplWtJ3A5g+joTUCuAsjL9xof
 iS90qkQF1Vetl5TOX+qbG9OYuJi38KSoPvdOUTzxomPHTTrUSX70iMLozVc1EvUaqMDZL5ZtS8d
 gFKSNVewf/mvOQt68oix3jouYjll151v0TtvJ5ItPiGAPS1/a5Y9qgHNG/Ek/NlXJHnU+edFO5f
 XV2k2OZA5HIthSzBS617HUe2INnhXknobpRuSMFrVgb0wdsJlgse9kGdS6fQshmuPR1hEn0pXRA
 YuVfVwctdBf9xNPNaaPU7Jf0Gzn9qlaotZOS/UaJmUnyDz7GQOBz6WDdh3jVRZD9JBRCNL51Iz4
 10rkLdkxNKSxLSD6mnOKg3oFiYeTazkko9vVXOcsqRQ1z/5OW0Szf4Lyc7gGQypsQEZfc+RnQyC
 WB4TnQ3ArKQ1MZDwVUDYxe+ZWV9BF7rT1qKaUd+t6rxGh+EqwbqhCKvhhHtvTSMU667VsJhOyK5
 aA7qeI39ABiqwWJjQpOCsJVqyFSdl+IKdfdGRpoObyRSi9VAIHygITf8+lEWy3QXvK7C3wQtVok
 mNZcInVB4Ay2DOsRZ0+TXEIX6FmFDinhIeOYIXH7WRr/JZew+D0yu4zm6XXetwxntuHearUV/gL
 xyCJc3Lm39ti5qg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Support a per-implementation number of counters to allow adding support
for implementations with less counters.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index b4ab6a3e5df965b7ef450d7e533995f3cc8633fd..b5fe04ef186f04b4af32524fe433afb79979b791 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -20,6 +20,7 @@
 #include <asm/perf_event.h>
 
 #define M1_PMU_NR_COUNTERS		10
+#define APPLE_PMU_MAX_NR_COUNTERS	10
 
 #define M1_PMU_CFG_EVENT		GENMASK(7, 0)
 
@@ -459,7 +460,7 @@ static irqreturn_t m1_pmu_handle_irq(struct arm_pmu *cpu_pmu)
 
 	regs = get_irq_regs();
 
-	for_each_set_bit(idx, cpu_pmu->cntr_mask, M1_PMU_NR_COUNTERS) {
+	for_each_set_bit(idx, cpu_pmu->cntr_mask, APPLE_PMU_MAX_NR_COUNTERS) {
 		struct perf_event *event = cpuc->events[idx];
 		struct perf_sample_data data;
 
@@ -506,7 +507,7 @@ static int apple_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	 * counting on the PMU at any given time, and by placing the
 	 * most constraining events first.
 	 */
-	for_each_set_bit(idx, &affinity, M1_PMU_NR_COUNTERS) {
+	for_each_set_bit(idx, &affinity, APPLE_PMU_MAX_NR_COUNTERS) {
 		if (!test_and_set_bit(idx, cpuc->used_mask))
 			return idx;
 	}
@@ -601,13 +602,13 @@ static void m1_pmu_init_pmceid(struct arm_pmu *pmu)
 	}
 }
 
-static void m1_pmu_reset(void *info)
+static void apple_pmu_reset(void *info, u32 counters)
 {
 	int i;
 
 	__m1_pmu_set_mode(PMCR0_IMODE_OFF);
 
-	for (i = 0; i < M1_PMU_NR_COUNTERS; i++) {
+	for (i = 0; i < counters; i++) {
 		m1_pmu_disable_counter(i);
 		m1_pmu_disable_counter_interrupt(i);
 		m1_pmu_write_hw_counter(0, i);
@@ -616,6 +617,11 @@ static void m1_pmu_reset(void *info)
 	isb();
 }
 
+static void m1_pmu_reset(void *info)
+{
+	apple_pmu_reset(info, M1_PMU_NR_COUNTERS);
+}
+
 static int m1_pmu_set_event_filter(struct hw_perf_event *event,
 				   struct perf_event_attr *attr)
 {
@@ -639,7 +645,7 @@ static int m1_pmu_set_event_filter(struct hw_perf_event *event,
 	return 0;
 }
 
-static int apple_pmu_init(struct arm_pmu *cpu_pmu)
+static int apple_pmu_init(struct arm_pmu *cpu_pmu, u32 counters)
 {
 	cpu_pmu->handle_irq	  = m1_pmu_handle_irq;
 	cpu_pmu->enable		  = m1_pmu_enable_event;
@@ -649,7 +655,6 @@ static int apple_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->clear_event_idx  = m1_pmu_clear_event_idx;
 	cpu_pmu->start		  = m1_pmu_start;
 	cpu_pmu->stop		  = m1_pmu_stop;
-	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;
 
 	if (is_hyp_mode_available()) {
@@ -657,7 +662,7 @@ static int apple_pmu_init(struct arm_pmu *cpu_pmu)
 		m1_pmu_init_pmceid(cpu_pmu);
 	}
 
-	bitmap_set(cpu_pmu->cntr_mask, 0, M1_PMU_NR_COUNTERS);
+	bitmap_set(cpu_pmu->cntr_mask, 0, counters);
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] = &m1_pmu_format_attr_group;
 	return 0;
@@ -669,7 +674,8 @@ static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name = "apple_icestorm_pmu";
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
-	return apple_pmu_init(cpu_pmu);
+	cpu_pmu->reset		  = m1_pmu_reset;
+	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
 static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
@@ -677,7 +683,8 @@ static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name = "apple_firestorm_pmu";
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
-	return apple_pmu_init(cpu_pmu);
+	cpu_pmu->reset		  = m1_pmu_reset;
+	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
 static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
@@ -685,7 +692,8 @@ static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name = "apple_avalanche_pmu";
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
-	return apple_pmu_init(cpu_pmu);
+	cpu_pmu->reset		  = m1_pmu_reset;
+	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
 static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
@@ -693,7 +701,8 @@ static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name = "apple_blizzard_pmu";
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
-	return apple_pmu_init(cpu_pmu);
+	cpu_pmu->reset		  = m1_pmu_reset;
+	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
 static const struct of_device_id m1_pmu_of_device_ids[] = {

-- 
2.50.1

