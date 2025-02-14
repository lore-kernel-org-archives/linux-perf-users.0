Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09568266F02;
	Fri, 14 Feb 2025 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739543440; cv=none; b=BwLLePP93aDfV9AgbPHcaPnD/57cMvTAyp0WU++aOwzQwLFxhEwQ7tTXk7CnpcymywfAhj8MWJOLsYyPiFRIegwziTEEsllHYYkMBUSKqenkf87BmG4EEwb04MIKHK39f8WXu97ppVcqMpteKpJ0oVwrA3VOvKK2Oq0dd8nLZZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739543440; c=relaxed/simple;
	bh=MG7H09oJBroEMR2rLRIA2iE+Zt5xTdbc861bsPYOz8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PXNFBO5e8OA7yrJNs4bVZfW17nLoSVwHNZXps2de0W5bfv0sbUiz398duHykqTY7LHbdpGVzRFGBLhJaUJXf0ysehYK19f5q2suTxG8bypD2gcURU+HudNfgJvUnEF2hIyNPz3bkX/eHfy+KROvZbeWaa84NE3Z73zBMv9rTAH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NO8rCACg; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NO8rCACg"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-219f8263ae0so37000765ad.0;
        Fri, 14 Feb 2025 06:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739543438; x=1740148238; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zfW03x8PctsFN6tD/weQNw1AxZpgTS9cl9FMFO0QxSU=;
        b=NO8rCACgriZQfCF+oM+J72wXB+o+a7lGzJOcz4AYgzr2bCKNkj6GjODBt0B5VYlLSn
         Ca5AP+xAQysXqHrJ3zydCDnzfLBZw8CjWWsy77tjhu6tsS9nIYVSVl97oixNr7STYXf5
         qJyo+n9XE9FDgQtuvdzh1tQ2LRNg7+yL5Mirve8F0PovrOyFcq/DBObIq8tmh2u21k0S
         AHY1Cpf1BEi/FMUydBGDJ5RVJJqLW00u92uxhufbhOhd8pCALUL2j2V/ewuPShaiWfyA
         G2Xt3xmfRFsZ11JvTPlX9Q1OEEMh6i0Awq8u4X4aNWiIkwME/IIBqm2WBDhXj/uu5Ztp
         CUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739543438; x=1740148238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfW03x8PctsFN6tD/weQNw1AxZpgTS9cl9FMFO0QxSU=;
        b=Q1PQQJRF4I2RGGvaVx+xhsifDV8NOXl2xYVlzQIN3jqqAwER9J9rXlsLParnWVK094
         5rqGAk5lo6dv1f8Rp0kcHW05oOgHsQthzdpXrRHeAKn5W0L3rkzJ83FsJYaVaf664DR4
         R46+HPF7/gNK2b+c04cSncTEXBFydHPBhpL0qvkpVKQhJADpnuLUd5vOYL6Gfv9kjbJP
         JrhE0NBB+lzjTQpVzKJ1BsMuJhc4KqEFXJv6BqVyYV/Zbd/Hx/NJHq2y/HQ4ELj1+COV
         jI4ml7dO85UeKPuZhDYhK3EXfv8Tks2W6QfICytyNWea3TZaME4jIfi1tTkU45mbRmJi
         /osA==
X-Forwarded-Encrypted: i=1; AJvYcCVMHUW/R7c5i2uvsO/eEls2U/qegNRA4xx4WrB5KCCiJgBOqsndQrC6zpjx7ssbWMCFJC+xwD5JqGaJ@vger.kernel.org, AJvYcCWQfhx0OaW37hjCesAUP+eO5/o3Xg49CyvKRrU4xQ3kE3QnZQfiVLbAsW8HqWbFJf1nps6J1JH1JX8Bxeclf4eZ2g==@vger.kernel.org, AJvYcCXb83Oo54JYGCXzIHqICfy38wtNNdbOj8Tz1HfsVxxEsHzJc3JLpRpTlxbPThsYgegn4uhU8tOpHl9TM7sD@vger.kernel.org
X-Gm-Message-State: AOJu0YxqU47nSuMUTpPcYOHsNFCvRwZqM6jk5UrIGMjB+JD1ASMAflFO
	6ypYlZr+luaoujFYS1dl/vPwn6tzYd+GpN+Chbr4htLRaBrm8znK
X-Gm-Gg: ASbGncuVRiMM8KOZhY3E5Dp4iiEU5dfNfVUhTtFHkBcpYgaAoGhJmIYCBHdr/+4YbRE
	5sLbRzmEO4so3aFAXKltkdkRdBGVzsnBZG7n4KdXAj1F1njcyw5T0W6UKbsbGSiPhMPCgdehyyK
	femFybPKDULp2S1B650GkaSaZ+niwRnJM5yojH9v5RscUj6981R7f3OX9j1g9HDysZQneg1snOW
	QCn+FCC7l5HMimc7Am32z58zL3zIZjDNUyMskiIKEA+mwfcfXNekOaOCuXLy3mqcXwZii/mqLwS
	WnIflW4wBBEaSAeztg==
X-Google-Smtp-Source: AGHT+IGlV/clcQ7bA1VUVCHwnAC7Ksp+1PRaUPCafXfhp5XXwUagzP+nJKFR5X2c/1fpY3M5q5wCaw==
X-Received: by 2002:a17:902:f545:b0:216:393b:23d4 with SMTP id d9443c01a7336-220bbab0e0cmr199459515ad.11.1739543438299;
        Fri, 14 Feb 2025 06:30:38 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-220d545c8d1sm29490315ad.113.2025.02.14.06.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 06:30:37 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Fri, 14 Feb 2025 22:28:29 +0800
Subject: [PATCH v4 03/11] drivers/perf: apple_m1: Support a
 per-implementation number of counters
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-apple-cpmu-v4-3-ffca0e45147e@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4755; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=MG7H09oJBroEMR2rLRIA2iE+Zt5xTdbc861bsPYOz8o=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnr1OA1ESIhZerrZ84FjKBXZFleAZUOZNbSrprv
 Mym56PWKYqJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ69TgAAKCRABygi3psUI
 JDHbD/wKOIeNqAV2YNyWr/eU5L29ZU0+QQRvSVZBpqK2cU20vrZ6Z1LZNb+v267CjeeBhzFqwT8
 v0wrtmAQ7S45X0xPZpOg7HZXN1fa3PNT4YTF81fjLuYSj+zeb5qlpZIGgJbCsIX7vztqB4uc7JZ
 8VaKwJRHPLpw/0ZgEtVBafy+Ied345opGHA4rPZU/wyOHBL6T0F6Ym+y5+0Bbwg7nNH2XUonhfv
 b/Np36Ro0VebowdqZniRv5tU/M9igtPkX7gv/ctXesu9h5PM/GGXKuizGKb4iSrVf3/Rl8iSWrY
 B7VL6KQEajdCbjUHVySYmFS5sKEbI9POpZ8DAlxIhRbhDWmCs6xUBWXuAu+lL4fwRZTqS+fA5au
 00PAk9oD0j/xvBSDPwaeoU3crZ4sDkvCPDotGQTVYzvsbABs966qe61WJrQtHFEQ1ufdPH64NDL
 GsGIH592Y0F2/jNsH/UD8hqHLQyz9YkWUxqXCXbW/82fxwQhDlyBx9FJIfcFZVnA/CdVuHRdPWl
 X62NzTBNtyDxRBz4oaP5mRl5GvlJmmljIbyjr/7t8DUejNZU4Pucuy3G1ZpGQhc1GtsjudcgOIA
 8+iGYuXNVm8ZN++ev88u+LwYJp13Z3zqjJMFK8umo2BvMTjzhhfdLkNCij4ic8eOgKnWUqa3jed
 q/I7kG8paRK/Blg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Support a per-implementation number of counters to allow adding support
for implementations with less counters.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index dfd5d72ce9f3c5bebd990b5df6a6823fb7785cce..bf397fd81230007dcf52888f148e3158dc02e29d 100644
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
+static void apple_pmu_reset(void *info, u32 counters)
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
+	apple_pmu_reset(info, M1_PMU_NR_COUNTERS);
+}
+
 static int m1_pmu_set_event_filter(struct hw_perf_event *event,
 				   struct perf_event_attr *attr)
 {
@@ -588,7 +594,7 @@ static int m1_pmu_set_event_filter(struct hw_perf_event *event,
 	return 0;
 }
 
-static int apple_pmu_init(struct arm_pmu *cpu_pmu)
+static int apple_pmu_init(struct arm_pmu *cpu_pmu, u32 counters)
 {
 	cpu_pmu->handle_irq	  = m1_pmu_handle_irq;
 	cpu_pmu->enable		  = m1_pmu_enable_event;
@@ -598,10 +604,9 @@ static int apple_pmu_init(struct arm_pmu *cpu_pmu)
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
-	return apple_pmu_init(cpu_pmu);
+	cpu_pmu->reset		  = m1_pmu_reset;
+	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
 static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
@@ -621,7 +627,8 @@ static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name = "apple_firestorm_pmu";
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
-	return apple_pmu_init(cpu_pmu);
+	cpu_pmu->reset		  = m1_pmu_reset;
+	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
 static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
@@ -629,7 +636,8 @@ static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name = "apple_avalanche_pmu";
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
-	return apple_pmu_init(cpu_pmu);
+	cpu_pmu->reset		  = m1_pmu_reset;
+	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
 static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
@@ -637,7 +645,8 @@ static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name = "apple_blizzard_pmu";
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
-	return apple_pmu_init(cpu_pmu);
+	cpu_pmu->reset		  = m1_pmu_reset;
+	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
 static const struct of_device_id m1_pmu_of_device_ids[] = {

-- 
2.48.1

