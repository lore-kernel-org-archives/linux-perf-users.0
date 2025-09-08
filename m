Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BAC2F8BF5;
	Mon,  8 Sep 2025 10:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325663; cv=none; b=WWVn+fLhVDVBcumm/VXVxxzpn7dqwOoEWrbYeirgzBI+5r+b1zK+twylSyJvk2Y/Ml4BgvTYTx5pX4jiK6z6B8uBfAuoSiIMErUT89TFUEFzjNWleNhL/Ub/1IsYn1VNcTSsauTO0TO3KYpezCgrAtOZMXs4yNgCjFTWaqn/c3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325663; c=relaxed/simple;
	bh=e978bWoFjBQgsdNlqdWrRQsmNCkoajFMktc9t6zXMkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZQX0C3Q9esSOjdGEliXYDpOt4YGCfmwr2Z89yUAZ2JVQpLAsKopxmiPA7YnTddaZ41aEruWCLyl01JcRMoQDsgQvlF3dq9zZEY2lOJ6GU6jwm2jfDk43iPb3qBRyBvuYATGMMRmanhgCh9pRTUB92KLlHMpO2Xeg0eRJT+EyQ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tc0U66Uy; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tc0U66Uy"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-25669596955so8200175ad.0;
        Mon, 08 Sep 2025 03:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757325661; x=1757930461; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kSUQIaWycRWPeDhTmGOQryGYmMnqnnTORM1hSoq/o6g=;
        b=Tc0U66Uye0LBB3bWb2zbnT98+1T+IeLO965rGslkIho42MdCSHLSash+FCjIjZBsa9
         kUk6VLmf2pd6rLX1eg8kp1MdDbtH9JMkp8MBdHMKfQlgbVwb4y2l+xX7vAASUuTUQibs
         aAjxyvwPhp9k8d61eGUzPSOFPnrv7iixKJ5XcMWvIDnJB/M1OlaZrYz1qUnS1/FrTuVs
         M67gyqmNXRZeVqFMnFT7v2wbY8S1rlMZSG/oplTMGbpO959D8cBA3+kTUyniIBhvDaQs
         1Fxy6MqPvgxRl7bB/JeYka5E7LCnu2Zu7QuT26rjXAySGeEaSKeM2iZOm/3fPkPVJ1By
         X59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757325661; x=1757930461;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSUQIaWycRWPeDhTmGOQryGYmMnqnnTORM1hSoq/o6g=;
        b=oeJPat+GUPstQkplphSverlT2ILo9W7CHtvFLOM0p8eKB8s32dy6hgBGPg/coxQWP2
         V3G1ohgAbsMwh9LxL9gvTQ4VsPaCEfyLGKRDXhJRNjnbGegd+SVVVt2wjcgb9+cPLluV
         sSto+WSKZy+r/abA5O7lxLizDCE468XAeruo51SOlC58qGhSArMr9lZbPirgDxri1aT4
         D8aU2+jrTZH0nx/KeR9IDeCqwzjUUQgKuM9ZTK1CrNbnF98oRrIn0Uw2pyZu7qOLxK3q
         eY+Vqi4O8A1YH1FrGjRGvFOB9UT7CeQEQGhRg5i3Dc4WxsoKX/cf7+14cFq2iVpimjLr
         NUaA==
X-Forwarded-Encrypted: i=1; AJvYcCUC0PFWPRCDerX54fTWk9uHw3qMJEPvUCFwV7qLw8HQZff7+fnADcFmjIKpdN90QQr6DGsrlkY5m3UY@vger.kernel.org, AJvYcCVov8VT81kZA64la2IYjidBTJZ09AyVjISRlXeYS+9Ofe5+O+Wfx0Z4d2PNnPIVNR6Zh9tuEN7IjpzsBe+k@vger.kernel.org, AJvYcCXgDYGYE0tgKkAg/NhxWLuk/GTgQcjBCWw5OhKozhNP3Idd775l8m1Dpuw6bQUyIUj73iV3hakQIuymJJE8uExn2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxshwRyxAZxMrlwm84/L/5+SV2cGdrW5MxMs16v99zK6Vts6U+u
	KxfR7Gxu/MPUv4zC1l8euPfOmrd/zEa7phx5Lwzm3LgIhAHBlEU4JR0m
X-Gm-Gg: ASbGncuI5EQojzjax4kN2D7GKLcnlZQl8XdbvPx+hkRfSF2aJ78z5moYTrooBcGBnY/
	cKx6YRe1OuXM5faKmMw18wr8WHsZPT6dY6hy9jiYLsYf3W1IYtRKCIwUAAF8vmaJuRfquR2Tv3V
	8pyaxMoxdN2obqvez8ggevJ46c5EKWg0HhAEkRa/M0g+IWH54vatrKdC8MgS3Ut60zKkxbUdt0N
	ifxJ3EepSgqgq4+A5fiDraTWROySUdXLSlvPGBpzMglPDYhKDgMUcUHo4yWJolsx5R8RlmNkU5f
	vKcubPXGNcq0PqkEUYvARCeuKsQgi2mO41vaDGNrTbmalLN9+VMzEI3xJ50X8cFdszAYd9XqwWD
	kD8DlWf1siP6CkLS8nSvW22ffW84zsS/bIZLmpg==
X-Google-Smtp-Source: AGHT+IG11e5yGQ6mc6A+u6URsOan+E/sP/pcqh8w5VNsDhDKar9RrdRNruPHJgRVAnjqfyCyjH1Reg==
X-Received: by 2002:a17:902:e5c6:b0:250:bd52:4cdb with SMTP id d9443c01a7336-251736df0e2mr88144745ad.32.1757325661328;
        Mon, 08 Sep 2025 03:01:01 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24ccfc7f993sm107826545ad.63.2025.09.08.03.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 03:01:00 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 08 Sep 2025 17:58:28 +0800
Subject: [PATCH RESEND v8 04/21] drivers/perf: apple_m1: Support a
 per-implementation number of counters
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-apple-cpmu-v8-4-d83b4544dc14@gmail.com>
References: <20250908-apple-cpmu-v8-0-d83b4544dc14@gmail.com>
In-Reply-To: <20250908-apple-cpmu-v8-0-d83b4544dc14@gmail.com>
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
 h=from:subject:message-id; bh=e978bWoFjBQgsdNlqdWrRQsmNCkoajFMktc9t6zXMkE=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBovqlDf+O1g150hHA5Hs0I/aUaLmgR27sqVHJQs
 3djsJTRQ5eJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaL6pQwAKCRABygi3psUI
 JGxAD/9Q9nmhaDwo8/y7zqJCPr0t6UcR8TjZGcnNwQiqAW4DjwMh5R8o6Pra744BBIYH8GfubUD
 YDF7aXmWtHvBnVXTS4Hl9YpSV+4QpTuVPt141vLZ24paPzXJyVWg0tc/lzg7xn0T1ny+VKmrbDB
 Xy/EF/rZMNSSIzMEJ+bzdfbNlC1wlj/AnHv6Gj0vgqdJ4qPCOhym4ASBaptHHKfDfQ3Ogo56HVu
 na9AHhu6/ltmS1AtmFz1LKPAJUn+F3E6QRdnaWsyZdlD7FbCVzXogQ85wfdNs6bifQ3ha2P2TWa
 4d9RAc7Q4s8B3EQw8YbOU4JdFAwGCDhEKXXAee4zrjYDVrbt5hSqm1ShFeBQ5b4qwGxH0sZNjzz
 b+BZ8ww0RZGTakwCYBoM6lW7BgT/ZqBcfE8sA6DYjkDJM/U8012SmwUoX8T8MxBfRtA1OK5dCzT
 Mlvq/mlVGUYejU0ageOkLD+Oibs8W2qma+seYazE5dX6G3MOhZY4Dvk34PeR+2C4jTGvR8lYaW3
 Fi9O6ZcTXtd+zezlkAy46nu9sLthHQibo3ZuUZokE8k/BxZ712AiNkglf0BxfyBPoGhSfKFXcqi
 N6iG1guaDHzZt3K9I3UNzrfNLbdttqJARxjy+JHvG213JQx+KrL9K/gHKa1GlzmOsGgu6HZNsCB
 pmmMxHOH3bj2/mQ==
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
2.51.0

