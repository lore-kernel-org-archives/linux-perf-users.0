Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C177B257AF1;
	Wed, 12 Feb 2025 17:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739380992; cv=none; b=UXv1OTp+s3xp07P/q/wOfRXUYKRV9Vj9PKh9u6uYW64QL0UX1l30JXsdNRqf0YFexasWr8Z+0EZVLu+PijGM91HDFfxh+NyFMkRqdq2VIL4I9SRGbibplTpinGeLEzgWu4WRW8UBnepzjRCNM1o8GTUpuSLfJxByTg94aVykOF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739380992; c=relaxed/simple;
	bh=L+Tl6yOf4IhDKUIycb3hLlpdWXpiiAGyKeFO2ADZTD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=juqVYw/UBP0t017vp3sEP6SI6Bzp2dhv34SEj1gWFlQQerat8ZAJrqwVLTpa2Z27i7BdDrYLeZnuJpQSF19P+m3i5XKyHKrJSflkH88XmJfmvN7YlK/2QZ9GXxUSqJ/GRhLWj4Y4ufAEP3eCT5RdhKCeIYzwHAvWUbcezg63dI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIl1sH9m; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIl1sH9m"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f3c119fe6so161842145ad.0;
        Wed, 12 Feb 2025 09:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739380989; x=1739985789; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=22Z1P7ZTqlUD6cQOv/Yl+YD77nH6S4zD9+2pfCgYfuk=;
        b=DIl1sH9mjhFR9AOuNKvntAKKEUqLKiMcXYbRRe9gypGwes03RhDmx6BcJswLM71pZF
         Dj7WkvHPEWFhZzD+OrHK8kiFmLbvuRr5fRhWKxC4Qt21hy4u5jR3qO8TyYr/ftCFaFiK
         mFOEcjug9amdJvqCLNG0r/V6V6RVReXypBnZmXSXB8RSZsvlmWpeK+AxXEByyE1fdnf5
         x3uvbj88P/HvnLX9IxTet69CR5um7vlgh/x1l+6vYay9l+foKBAQGMrU0ZNA1RfLvKB6
         tdBZimSoAZzWIQ8uT89xPkCBJd+NFWwkrRFhcWtpQV5g1hJK2EDEL6lM0KOmEDBUHmdI
         VCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739380989; x=1739985789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22Z1P7ZTqlUD6cQOv/Yl+YD77nH6S4zD9+2pfCgYfuk=;
        b=WESB3fVr4x/PzKPgUHTeblF1v4QhuHBaU8/8JKuWwIBq/NLIx7UkSGDj0NmDnHJIMf
         2s/h5crV4Ml01I8qLrJ0RxIGdKp6DHOsHTQPpSooktTdnZl72eTKWuzElbHpEF/xrR6/
         4wgVRcCDcbDCgfZzF4wZdroJoeHNKyK59fDClQFexYKUuvFb6A4uV8gQRRwQIEaV0rdT
         225dbPx4ZkGR/arAdrYuO2isY2Z1nGqo830l60auGxs6t1PbyMfnyib6IZJm5ChCBiqj
         VExWiUcwXqxX2SoEeVrDhBiI5DNTR8kl3rSgZZua6txC1jB5I4iNL1uZQ+5MxXRYjvVu
         +TDg==
X-Forwarded-Encrypted: i=1; AJvYcCUSfeN+9ck/B1Bj0t66hSOJus5ZLY9V2uMdiXRdfcGP3vWAjAy2a35GWB4Ikjnsv6KCP2rq0ty8bHJK@vger.kernel.org, AJvYcCV9xxFI0yVO4W0f0N/D6L/W5l5SMIpn+ZM8THMCs8o1gnHVXZLOtbKNiiM6V6aBjQZSCNKNh2qGIytBfvK/@vger.kernel.org, AJvYcCX2Stmcu4azJtzD2hjnq0lv68L26jn1W5+nFHFKCyFc4kaAtthFOzlm+CQF4GI7XH8F24wcawU9rEx/IdylJhJ5Kw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUM4hHbvpeq9Viit0uzhAQLjPlEcy4NueQLsHU15vfROaVNtdV
	aEhGEkOxYurtxqg+MTDCSYN68S1OZQUhgnOo6rjFa8H7x6OerUze0FvWoQ==
X-Gm-Gg: ASbGncubVrP6UamJ02QjP1G82vkNNQ1rhLLEOvGNKsi68TAOnBRRVoNBCRyLHB3YSuC
	UnKFMjQKFJP1JrebZIsGdY3hDE9c5UUOLCw0pP2dT3ZMYBaAm3PKVu8rNrMCKSIHLcFErkpyFbr
	J1mUWPPmPISvnZRLtk2caw5YapgsCsp4KJGxCiO3IIKaGVsp1VwSW20OybgeqreSwqNZhEu5hpE
	Jgglc+AkujEiB27MjwD+idkU9Jqo/P3J3JaDW+bn94dxDRdMXOBYUQUAMGfzDnElYUDnturGEU2
	LMuDYKgsmLgnv+TTHA==
X-Google-Smtp-Source: AGHT+IGobLhMetJMQ0kqhmZbc2dvKpQgQcpToUx45wdgkBO1Lyl74VfMgW1vCxAWuj4T/AwvpbtnWA==
X-Received: by 2002:a05:6a00:3d46:b0:72d:9cbc:730d with SMTP id d2e1a72fcca58-7322c39d1dbmr6513556b3a.11.1739380989023;
        Wed, 12 Feb 2025 09:23:09 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-ad54f1691ddsm6001705a12.61.2025.02.12.09.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:23:08 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 13 Feb 2025 01:22:26 +0800
Subject: [PATCH v2 03/10] drivers/perf: apple_m1: Support a
 per-implementation number of counters
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-apple-cpmu-v2-3-87b361932e88@gmail.com>
References: <20250213-apple-cpmu-v2-0-87b361932e88@gmail.com>
In-Reply-To: <20250213-apple-cpmu-v2-0-87b361932e88@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4846; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=L+Tl6yOf4IhDKUIycb3hLlpdWXpiiAGyKeFO2ADZTD8=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnrNjvQb2YIK3BJQeW3xopIS5Ew3zALFGpnvRYn
 IQkSGbyED6JAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ6zY7wAKCRABygi3psUI
 JIjOD/9OCiE4HbMvImN9OaimhBddGmIgt3gG6W5YIr7qX3llWPpFg56YqftGDOhyj4ZtJmoLURj
 b7NVQztkcZkt/J1ev4P8PKOuIHvcxHCt3R9c0vzXSpwMlWU39lesxyT+DsoLmpz/qYPcaDNebsL
 qJK9yRjwfu1LTJZEJ9W5cfA9KoUusuqsJe8nduPipcGHiZpnFH/y1DkWqU79Mahy/nwvrmCBnbR
 tTWcC7/PyLCOF6UVmj5jE2yZIQS7uuExmkDKmaommXqiwydlysU1nBlCZAVAYJtQN9mrB87zkaJ
 shcKo7ym3R4Pr1ZFXXVx31H7q1w3RT7LFoUy082kH92JU40IG3wmu3ItTJfgLEKSC96L0jK/mBX
 35wdR72XMSn4uwB3sWMT1k/FIgJVubl6fbKSalgEUaLjGUtg5rFLweyoIdUnO5hacljubqBEo83
 NPD22hBOMzgWcUasj1VLd/G7RcogTFGHAw3oQo0SVdpiB6Zjub/2F2Em1HZ7gz4fCl8z9W5bxMQ
 9yJRT4JY27EMXei7B84Qu9I0wVb0f0OflupWc+ZX6QNOxftNyjWP9dssQvT/ysp5Szkm460pFWR
 1DkJ8GU96igRo3FrxC7/iuqkR6cANP9hmAWBgahmhVAKgNeOue+ASjXpbde2SwvpeS1pCDYKhTr
 mlfhgkc52ZK5/7g==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Support a per-implementation number of counters to allow adding support
for implementations with less counters.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 9b26d5f35d91b715e9ccb7524a3ca7b87a4d5265..14e6fd0c2653912a6bbbcc31e6f4c54ee2d062a1 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -19,6 +19,7 @@
 #include <asm/perf_event.h>
 
 #define M1_PMU_NR_COUNTERS		10
+#define APPLE_PMU_MAX_NR_COUNTERS	10
 
 #define M1_PMU_CFG_EVENT		GENMASK(7, 0)
 
@@ -431,7 +432,7 @@ static irqreturn_t m1_pmu_handle_irq(struct arm_pmu *cpu_pmu)
 
 	regs = get_irq_regs();
 
-	for_each_set_bit(idx, cpu_pmu->cntr_mask, M1_PMU_NR_COUNTERS) {
+	for_each_set_bit(idx, cpu_pmu->cntr_mask, APPLE_PMU_MAX_NR_COUNTERS) {
 		struct perf_event *event = cpuc->events[idx];
 		struct perf_sample_data data;
 
@@ -479,7 +480,7 @@ static int apple_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	 * counting on the PMU at any given time, and by placing the
 	 * most constraining events first.
 	 */
-	for_each_set_bit(idx, &affinity, M1_PMU_NR_COUNTERS) {
+	for_each_set_bit(idx, &affinity, APPLE_PMU_MAX_NR_COUNTERS) {
 		if (!test_and_set_bit(idx, cpuc->used_mask))
 			return idx;
 	}
@@ -554,13 +555,13 @@ static int m2_pmu_map_event(struct perf_event *event)
 	return apple_pmu_map_event_63(event, &m1_pmu_perf_map);
 }
 
-static void m1_pmu_reset(void *info)
+static void apple_pmu_reset_common(void *info, u32 counters)
 {
 	int i;
 
 	__m1_pmu_set_mode(PMCR0_IMODE_OFF);
 
-	for (i = 0; i < M1_PMU_NR_COUNTERS; i++) {
+	for (i = 0; i < counters; i++) {
 		m1_pmu_disable_counter(i);
 		m1_pmu_disable_counter_interrupt(i);
 		m1_pmu_write_hw_counter(0, i);
@@ -569,6 +570,11 @@ static void m1_pmu_reset(void *info)
 	isb();
 }
 
+static void m1_pmu_reset(void *info)
+{
+	apple_pmu_reset_common(info, M1_PMU_NR_COUNTERS);
+}
+
 static int m1_pmu_set_event_filter(struct hw_perf_event *event,
 				   struct perf_event_attr *attr)
 {
@@ -588,7 +594,7 @@ static int m1_pmu_set_event_filter(struct hw_perf_event *event,
 	return 0;
 }
 
-static int apple_pmu_init_common(struct arm_pmu *cpu_pmu)
+static int apple_pmu_init_common(struct arm_pmu *cpu_pmu, u32 counters)
 {
 	cpu_pmu->handle_irq	  = m1_pmu_handle_irq;
 	cpu_pmu->enable		  = m1_pmu_enable_event;
@@ -598,10 +604,9 @@ static int apple_pmu_init_common(struct arm_pmu *cpu_pmu)
 	cpu_pmu->clear_event_idx  = m1_pmu_clear_event_idx;
 	cpu_pmu->start		  = m1_pmu_start;
 	cpu_pmu->stop		  = m1_pmu_stop;
-	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;
 
-	bitmap_set(cpu_pmu->cntr_mask, 0, M1_PMU_NR_COUNTERS);
+	bitmap_set(cpu_pmu->cntr_mask, 0, counters);
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] = &m1_pmu_format_attr_group;
 	return 0;
@@ -613,7 +618,8 @@ static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name = "apple_icestorm_pmu";
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
-	return apple_pmu_init_common(cpu_pmu);
+	cpu_pmu->reset		  = m1_pmu_reset;
+	return apple_pmu_init_common(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
 static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
@@ -621,7 +627,8 @@ static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name = "apple_firestorm_pmu";
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
-	return apple_pmu_init_common(cpu_pmu);
+	cpu_pmu->reset		  = m1_pmu_reset;
+	return apple_pmu_init_common(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
 static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
@@ -629,7 +636,8 @@ static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name = "apple_avalanche_pmu";
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
-	return apple_pmu_init_common(cpu_pmu);
+	cpu_pmu->reset		  = m1_pmu_reset;
+	return apple_pmu_init_common(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
 static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
@@ -637,7 +645,8 @@ static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name = "apple_blizzard_pmu";
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
-	return apple_pmu_init_common(cpu_pmu);
+	cpu_pmu->reset		  = m1_pmu_reset;
+	return apple_pmu_init_common(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
 static const struct of_device_id m1_pmu_of_device_ids[] = {

-- 
2.48.1

