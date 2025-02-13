Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ED523A98C;
	Thu, 13 Feb 2025 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457394; cv=none; b=o/DuzTOqjULwIdXXToTHSVN040/t7phEywqfI7YiR2AU9nUyYXZZ3zt8km8dnCQUWjMiaN0B93tITkEv0hLpZpi3RHzynl9flchxFCIhC61TtWxWNSNps/ZfHlgYWAAXuHPlvU2Qt9RAObprm4m4A+1p/1l3+oITsbVzNF6+IS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457394; c=relaxed/simple;
	bh=MG7H09oJBroEMR2rLRIA2iE+Zt5xTdbc861bsPYOz8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZsJYNn6I+vmYxAZosLUxDQTQyMHsIGpNleQ0MFXuq14V00jPkmcQ30lKk+xPh2euXGcVD0a5WWIX88rbsKj9J4NKdtOOEprqpAx3KkQuJYeMktMDzuBoZohpkc0DWJUDXM/DQCsfkiQT7qF8NQG89C7Pq+IdS30gvSeMxtSu+Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j80jSecn; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j80jSecn"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fc261d4ec4so283290a91.1;
        Thu, 13 Feb 2025 06:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739457392; x=1740062192; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zfW03x8PctsFN6tD/weQNw1AxZpgTS9cl9FMFO0QxSU=;
        b=j80jSecnkvENMJpKAfF6waHk02kjsya4E3e2ihOJXZMCx78n7QAGATZNADM6niLowA
         O3hAlQEvQlbCdUP5LbSJqdXb48E5Vmz+6sNCzHaBxMo0E6OfEWc7AJxsnZSxF/pXKb4I
         HkuDdLYCHv/CH8llQKhtTMMs5/16mUjU34I3kQgsYxdvpheKjR/amvr95pMgqTbSqfLg
         iaKeedHm9irdf1+1/6NTvLZfUKhaJH3VFJFdg3VwAFvFQb5eilviIvxWJeXWmQXqlVZ3
         5YCMp58TeNSO7wOLnMRvZ3cZ9apiifxliUqNSZYsSQT499vA98LtuZJsQbmUdBbNfcS2
         SoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739457392; x=1740062192;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfW03x8PctsFN6tD/weQNw1AxZpgTS9cl9FMFO0QxSU=;
        b=JF1Sz6faDv+plIm12iyqOcpPebU2ZqWK0IzUkbs4d4XBU4fc2Fk2tTpJ7e/8CWxFaW
         h9H5zNit1st9zZiuZVKtyHXeAxC/39VrrZRsvsEb6tAUssmunE4HbuT6XF9ai0a2ti3o
         nZHtA3GJrE28gwb6mk/hYPnNsbgqeVySmt9SrKB+/Zz2kovmMP56APT2Rxb4xTAce/G9
         47+Ke3GNdk72xk8Jp3/fMZW0w8XBr4h4UBhUMSYTJ/Q6DjfjkuGBgke0ZJMhFC8lhhAf
         al1RhN/B15aBmJ/vrWeBc/INFjLYMV47NOclloSCXW9kHfsK0tYn6aJGrTZ5cL7pB1q/
         Rqqw==
X-Forwarded-Encrypted: i=1; AJvYcCU4FuaJpFMwRbMG3X+mLXUgcfsjvCRPJ2JoV60LrK/OGrkASiRHKuI49DsZn2ryMa8GZ61+iG8HrH3cyBqR@vger.kernel.org, AJvYcCUdhgU2a/w7luLsCri0UAHyKWfRtQDN3/yqeDN5EGMXrXV7z1bUmca28B6Mu+xQHN2d9J0mF0bOM7XS@vger.kernel.org, AJvYcCXkpkA7G74uN2WHsGr8yrK0lLD7tR7HaY8PhlfhJOvgEGDiVvmWUeVeKLRfwSuOwK1IvI4BN/mRV4h6rwqktoYp5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhNVVH+cKh6w6irUvY4Eu5HHwEf3yZ3JqFyPwgUKsweMhyDbkB
	v1XFpesmI0MP/YEjR/nx9gtWmbBoFQYA3w9J1U5mGuy8nYpTYIDS
X-Gm-Gg: ASbGnctH6LBLw/w5Xx3jBH0APH5QKgoAPcV3gcgfnzlG7mr02oLJ9SaEhbCMuKzqTfw
	/nG5Udou2Ig8HwvD7OgyHFgZyKw2gkFxNlrFX8+0/3AsDy3656Gsu7lw2rSO3bx6wkdqJ1AJRNN
	up3uCGH3a2Z2Xs7pOQ642U/KO9yAnV4AT6IFnQ2+cwb9VxYB8Ja4QZE1OgjWKwEU3s0vnxU7gqE
	zdAH13R3RXnVtqHq+7sxGf+7jNCPLp/zI0Tkq3QI77gTWGPFqi9NVJ5jOgGZTvlBDfJ0AxJAlQ7
	V6nUyojidWieZs7IoA==
X-Google-Smtp-Source: AGHT+IHaadyCxwFk79w959D2c6QKmfVmhWlGaOLfG6K6+k/tJ/QQlR9D08Ds+AKafHQJq4Hsvk4/RQ==
X-Received: by 2002:a17:90b:54c6:b0:2f6:be57:49d2 with SMTP id 98e67ed59e1d1-2fbf5c1cc87mr12523915a91.17.1739457392450;
        Thu, 13 Feb 2025 06:36:32 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2fbf999b5b4sm3655165a91.30.2025.02.13.06.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 06:36:32 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 13 Feb 2025 22:36:05 +0800
Subject: [PATCH v3 03/10] drivers/perf: apple_m1: Support a
 per-implementation number of counters
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-apple-cpmu-v3-3-be7f8aded81f@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4755; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=MG7H09oJBroEMR2rLRIA2iE+Zt5xTdbc861bsPYOz8o=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnrgNiUgPvCpFGhGTMyGdNU7wLWBKTezl49j80M
 QCYbF7PhyWJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ64DYgAKCRABygi3psUI
 JMemD/9JYfxAYOnpBp8Fk5eCumWdwJTLnto1PTYrT9O+bvtNzy18w9IUswqKPmpDc3WAt3oKpRV
 y/W2TeDQmTuHN/xdj87s+A8aLyJOliY7B/sF6JWTfzkS9I53A3AA5re0HxYkVCqgW8YxQOj6N9t
 kFdejqO39YNBuw0moG5v7IickGguOQ8JDfwPvIwSL2+/0RkbuvU1RAiuteDTqc5rPzOWxzFetm4
 IXTOcLX+pF3YjlV5kbtsDePGMHiQoBrarmPeuZ90iqHjIMbCPdGARWGwBNM5renVokOPQ2+TY6Z
 kCO6Evh+G1xS6wBXdXjeFzsyqhGweOHEnW75Iseuq4ndkQAxYEDfupaqarP/jvrzBJKNnhL86Ec
 GCp0YkbvP7Zu4d9B5EJ+fu02zSwpPu/y5+J2g7/FY1JIERcOjyVWzey8hpacMV56a8S/sJXc+48
 vIDarGgd3X9SasIs0TnCehg4PCn/5tL0FJOrSO5kPKPaWEtZCUF30AZ78NYLMv4YUYbHU6Nt6rV
 lKDQtZHMMxLE3dMFaRBIicIxjrGW3leaA06Ga6RqRFbKRlL3P/wFKsP57YBgTnCdUSEBaYN/CuQ
 c4HmSmVzS0HGRAa4IW+ysOCDnmEJUxZNOGwHpyBCHL9bGzMleBikZCC6BdX7heTmb5QrCF20hbM
 kEFlinkOOg5tDYQ==
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

