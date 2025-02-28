Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356F01ADC6B;
	Fri, 28 Feb 2025 04:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740715936; cv=none; b=He7fkDQ6/NijXMMo+OaJ2VPCAaguHbkBt/vQ2+YDeMBcGnGQ5S0S7zGHeeTcNT9Jbjc5m78QX2gUvF0M7XPS+QQhuh9tcyf62Rtl/PfK8mAQbLlsE4XViAbChBdX4+sGYu/Zx0U7IcjBRaS8kvwprZvHYNkYdflEuUphpPDDeJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740715936; c=relaxed/simple;
	bh=MG7H09oJBroEMR2rLRIA2iE+Zt5xTdbc861bsPYOz8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qtdjtgQw0ITojhTxRFj/b/TUZ3PkEEUNdOHI4R3zdjxQujOJv3w6g0QMxdA8SEmR5oh1RfoRb+KHqbmqyyEt9tDohVQ7fnLLctFQqPurEYBW2jNgTpDJX5Ugf8ynls6qaHcvtPtMpWHFt9VEnlFc2jK6zitx7Y6eKHn2Cw3X8q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7d6s5z5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7d6s5z5"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22359001f1aso32270725ad.3;
        Thu, 27 Feb 2025 20:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740715934; x=1741320734; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zfW03x8PctsFN6tD/weQNw1AxZpgTS9cl9FMFO0QxSU=;
        b=m7d6s5z5Av31+obWOz6Ci8EUDLUTSxK0Gzh9Y2Z8ldoqvSR0wD3FIXbZhy1AKYPXVR
         gAdZAgnI+4gBz2+jkq8bT5uRlUvFlQMF2ZnFvR2VLJJdjBPNv8I4ePahYRx/OrSIWbcY
         BU36J0gU148ik2Sq1KgtKLm+8fdHtGfgHPdqfJHnX6keXKD/QXxZGhA/qAKefB7kwto4
         8uYALzKe0Sr25voBgQ6ZhBAhKjMUUJpZXKtU3tyYJjbPWM+VUyz0oPJ3jOE+r3UNQdQM
         20I6T3y2cxe4+PElMAXOZqWTZDS5gcIl95aB+usttLvEtIfC28UKkJw3YxAqi33naQTn
         m/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740715934; x=1741320734;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfW03x8PctsFN6tD/weQNw1AxZpgTS9cl9FMFO0QxSU=;
        b=ud044vmVtDfcOAg9WxU2x6yOzvx/9jP28lfXADe5yDPgyviuTTcVT/yvK6V7Jvn2WS
         x0zG6xiVWekSBCZIc2msgUqNgr4nZugKA4LN+pBbGMZ0UcpzeUoXRC/I5Dfky5AqvDW/
         p9R1Y0DK8COhRoyca+2dX4l69c+Z8dyWDk1DbVYBJHRv3jr95IGUwAN9rK6J29ImKmCs
         AfTTRnnytsP25rk9KTvaVNGK7IT0/TwBYx6iR8hLLxcIKNj7g98Zd512LTa6f8pm2O2W
         QL09sNMzeyG8YKeFTIJO+38ixBlWdedzeP3G45hIPTYPMm0Mo7PKta1O6Hj7QzLrFBOk
         km3g==
X-Forwarded-Encrypted: i=1; AJvYcCU8pWM0M79ebcQ7GliKGaXgwUx42AVP0oiJi6Lmg/nZYaBFm5fIiZ03T7MVTMZTJ14RdS6QxPz5L+vfwoVV@vger.kernel.org, AJvYcCV3833kpKX3hUiDkRVv0Vd/QYv7k8HfKFuenUl+tqNZH+ts2Ffv/vtGKyzgXP6MOqtvPTS52qWNmeIyvS2FDdONiA==@vger.kernel.org, AJvYcCXXWvRv/2ovuhTs/kufwk9LZ1m39M57BdWu+2bUgeZJ+tlX61TmDZFY45V4UG5kxfGGAXGZHPmLfAR6@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Hi8/M7qXhMKallIAo+nCQLk4IOIeVFtPTyPXyLHtfYLdCs3R
	9wedNhqf2jYUenQh1V1gbZLzfNjFkCDDBc3htrjQKVIwR6EWzMjO
X-Gm-Gg: ASbGnctWi7TO1AdXZQubJgTxCP+iarmXthzvUmPsFbdseV2jYA/00PYr7QI0/6xfuv7
	RLTEX9fvM499+YSCK801JMvRf0UEknFwEMP1QwRtHugGYZo34x8d9LAeKtK5o2P8X+zkvhZgTlg
	o18f1AxU6D3QoXrcnOqRxxyHmVj8BGHCeaf07YEfsI4tKGlV+XE35EfU9BnSjpJAbOvEEbE5+tC
	jBv4+g/clx289YaOU0itwaYk36L7w09dVXq6Fj/WfUPQyc4JWfUmQBNe6FfFa5+R900aLMea41N
	X9ZObNnPW4Mutm+uBeO0r1oS3+Y=
X-Google-Smtp-Source: AGHT+IEwr4kr04bIVs7yxEwPvsivOao14b1Ljx0gKtW/fUtZRRHL8X5NReKqX7YpC1WASfZQ3srxiw==
X-Received: by 2002:a05:6a21:7109:b0:1ee:d8c8:4b7f with SMTP id adf61e73a8af0-1f2f4d22894mr3081917637.25.1740715934384;
        Thu, 27 Feb 2025 20:12:14 -0800 (PST)
Received: from [127.0.1.1] ([49.130.74.133])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-aee7dec4114sm2387856a12.57.2025.02.27.20.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 20:12:14 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Fri, 28 Feb 2025 12:06:43 +0800
Subject: [PATCH v5 03/11] drivers/perf: apple_m1: Support a
 per-implementation number of counters
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-apple-cpmu-v5-3-9e124cd28ed4@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4755; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=MG7H09oJBroEMR2rLRIA2iE+Zt5xTdbc861bsPYOz8o=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnwTeIOasDWrMTBSApTELuoEHQZSDxKS+Bp3qyw
 +E8oAk6D4CJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ8E3iAAKCRABygi3psUI
 JGf8D/9fu+FvT8c12d1HIjAx1p51DiBewXXuhvcmKT27E2Tvzx+XXFnCgVM++gG+uv9XqZBnX+U
 Yk9Hr3faLWv3ih7S4x42iw5SOa3grz96N3tE1mVdyIqa9mWcULt0X9vacp/ChIks4TBPbnTq85J
 XbZ1nRKD/zwDXTtBMjDnLaHYUHrOekDJeqwzNJY2PpAeiuEIPTpZOhl0ci8gjk9ZDlxtBjqpTYs
 GlhjRQIrhCMwlq1KPvPaaSLDkfAdO5kR4BB9+ccHienMvxIMv1bukPc075Gn79xK6iwrb0067mP
 6s6ALGGRlOb4sUErDu86xF8wyYzZugDv76G1gpyJ2nwKehQlxCn1SXEoVTghqveLb9/p5x3Btf2
 x6IqKyPlfA8H6NDPiscONQrXch0hJjT18YEPFBgZJVacqV56+s3sHj6IQnWzNJkgYHLY0c1lcQG
 q7rLBYSbp7AmwSkzQimlJgO/LyJShIw+aunLa83nNcNZUagWZaAXTdvv0FTMK46Hpn4d9C49HNe
 UaGabHlNGbIKddEyK8A+mjOcmG64hfIMX/c9EVVzSAnHdUxwItXciNABSYeJj+Fn5nMX3mPS2i/
 4RhWX0rcfxGanOuy4BGibH34eR8rer96v8XbYNfpHfqhTLKRrBDzp2UsWJ6Mlvg9fwW2eilQ/Aq
 JVNuIxu7gy7pGXA==
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

