Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D110256C71;
	Tue, 11 Feb 2025 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739290103; cv=none; b=ElHqbJ/XuZ9RlyggCYPJHq45Uie0wF/DD/D1VC/u1iP4Ff1mGl9AZ7zq96Y55FzYku6GvwPTDEsmWwyISnh4YEvOMlXgcOOREKeCefQj9lyxdyo4cnkWJYw8sgk3cLgcwCVGF79bGwP2OuRgS7/a8UBHlbS7oBua1Jp5YlBGz+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739290103; c=relaxed/simple;
	bh=tmdsy1Oiq7FNXqzIGpnSzLce1hbAiDf+aC6M6dPM320=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nPMcm2s8gXDG94Yn1DacK8T4d22OOTdhwazpoETtPIIQpCfdxJqfOJ2e93btFJmTSN0wI1SsIPJ1mf7oaZrl7vJxCR8Z7hCpVY09eYrzWwCSKtU/9zDgn07WQWPZEWblusfA4uqE27H1p3Ptl6cRrZFwChk2NdnW2IkO91Vpwh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InHcLD34; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InHcLD34"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fa1d9fb990so9145144a91.2;
        Tue, 11 Feb 2025 08:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739290101; x=1739894901; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfKkV7CWiRWo4A1sDx20Z/a947sDezwx25dWCKqppXg=;
        b=InHcLD34E9VQifx9o0SVrZN+Fo9DiKDBz4KHrNIeOBZhllFtZytZxztrQOGh2KToac
         FCzBtz15z5ay72+kFYEAIPOmP0o/EF0Xtzseln43cFQXGG1qn76LuKy9pdgEj6SY9ptG
         UdMjW9gMDecOPHTW2YhnBdsvxE/LkjllPFaVKu4QJmpsC2eA5zNC1rygKlAiOUo8213B
         +hTrJFyKIDx1Bd9oUFsywVq7Z9suBgbuA5ipiygor+3BioMBwX3B+eN5/gbXz+joCSOe
         2OTdj6ib8xwrlR47mJDBbS0JUFz8AX/Hj6GzWLFk9F2Ie+lEn/NRrXTHoYDTMehhuYZD
         aCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739290101; x=1739894901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfKkV7CWiRWo4A1sDx20Z/a947sDezwx25dWCKqppXg=;
        b=Oy5LiC/BpkKRPDmgpJAB1clGZYu6m2mr0E9PmFYDBGNjJgGgxC2tHKbqOhYVSApQ5N
         iQd5JPNXY71qoIx/RxXrpMAvsuROztfy8PJNysPjUSorn6lH+pfG/Y+Rc+2hqkvKASTt
         pHOb8c0wgRw/RHuSK6dsICRcbm6NdInRwJchmP0+BnIvw141par/df4VknNVHPqmKeN8
         zn5hMS2LMNXVxxXXjbx0D0smxnsoPIJ7FaHQrmksKpvSKViHczGyGfvgoZ7roxhAkNDS
         j38EYH3e9SKYETuwH1rAhYPlDTrqul8Xm3gajeERMHzTyKIMTlDLrNVeldyPD3Mf5oA8
         pgVA==
X-Forwarded-Encrypted: i=1; AJvYcCVnnru7txSuJ8IL4HFY+a+y2n7M0aas9Jagcgubl+7dy+NB2obJPCOtdc5ioXnx091lWwrskndvxOHpn2pH@vger.kernel.org, AJvYcCWL830pvWQ/OA+DyvMYj/v8lfaQdXYWfS2/Vr6sAEa3hVnjwqJ6JWFB6l7p2xdwwcrTiARzDpbyNvVf@vger.kernel.org, AJvYcCXHjERbo+L7yIYm4VuK7NEgCz6yS0Yui+/ewnsn1bp6U5K4V+xs4z/w1zG+ei62ddov0oF8rS1I785PShjD0JrQZg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7sDkutROM120lerffZJEIDFNls1TlsM9YLKAnCxvMprzp3Ofe
	eVf4fBvVpWgcWl+1DJV1+pXgukZ6MaPFowykUT3KawzYqpNjss4XkpxsMw==
X-Gm-Gg: ASbGncs31LxzaHynEqie3Jhf1jfpsiHUmPhZcu33icw1Jz7AIe/SMzhPMBsBWrEbZOY
	kI2XYA5GDJNIK6VnUhFXI3VX5TR69QcIT46IhC5EgRIc0GpyKdqQaZRRgUuB+LHUvPyo12ltoUz
	hUqKn2jKb1Tsw/Fk/jnyJjcD+2Pj7W+YcpVIAuv0L7hYLb6dukPwas/CI0Es9cHFTDktSpUdobA
	Z2UTrGk/Pmv81N8MqHIXznVSCHwFVboK9Qf+JFwb++C1agFfEaeAGZf4eOWI80ZVyYIq4OVG2dR
	l0ApKjeodnOLWCjZgw==
X-Google-Smtp-Source: AGHT+IGYIx9qHgSp+qZcb6/qvb2+gwFM/rh4dYNGwKpwPu7lcZcsAaPnt+SRsdlsmCSE8/iIZIKG+A==
X-Received: by 2002:a17:90b:3d85:b0:2ee:c4f2:a76d with SMTP id 98e67ed59e1d1-2fb63d33b30mr417216a91.21.1739290100762;
        Tue, 11 Feb 2025 08:08:20 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2fa618e5e18sm6040478a91.41.2025.02.11.08.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 08:08:20 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Wed, 12 Feb 2025 00:07:24 +0800
Subject: [PATCH 03/10] drivers/perf: apple_m1: Support a per-implementation
 number of counters
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-apple-cpmu-v1-3-f8c7f2ac1743@gmail.com>
References: <20250212-apple-cpmu-v1-0-f8c7f2ac1743@gmail.com>
In-Reply-To: <20250212-apple-cpmu-v1-0-f8c7f2ac1743@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5023; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=tmdsy1Oiq7FNXqzIGpnSzLce1hbAiDf+aC6M6dPM320=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnq3XnbAbnbjs0YuJEYMx1pG99Z7Cr2COlrwO3p
 sNCmoW2gYCJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ6t15wAKCRABygi3psUI
 JHV+EAC0De5KVfZwznUq4lQA29PrIK5zuWm90hiZxr7iiRwCDxlB99+q9Fsfsm2Xkb0ptgdCAl4
 76YdTWOWLzQJvcvPYpKimJQR3F7K64bLuUhM8UfYMWGVkMo0ZSKfj0aqVUbCgVBWaZ4Wt0lfZKH
 K7a/1m6Mmnw2qyCfDL76l2soBsDfZ5OpvnGRPDsflRcDCKkOl2bjryydrzFx1WGXF8l7Uq9/iUF
 6i1BjDsM2VqNz5KZnDf1EMjZImS/oBk9hUVwtJQzAWPYNjg12DrV+F33o4zdiVW+eyavODMvhgX
 U1kBKvQ79ncaYvSORpf6yEvk5EiXRKmzzlsF/L0WJP2iM20URftIMQte8fDUQqMO4obS4lAUIkW
 a00PAy3lHEa2iUSd5oPxu3QxhQ0+BO54dp8WpYZh/NfbwTUHXMGAA/CfEB6mXLv1aFCL3MqIeTT
 xLc82sYMOA4A7+mQtNLzgm1qay92AMtyEY7aBLmtQc06xRKweVaA7MuI1ciUKrK7o/ZdVFidfFk
 4RelnmYLXzRGmXfDZl+l3PECz0AsC85ALX+nEX8MwhZmRt4pXgy7RmzH5xuEJQDffYlQIAmENFu
 GQBFSj3RcWvfPdPQW8Za80km9v8iFdLfbTFrKAqRC+qhH+lzH49Qwx55nSQqx8C0/mKPQsm3fJq
 XXHUb2IVowrlcTQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Support a per-implementation number of counters to allow adding support
for implementations with less counters.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 1bf7ce5c09846c699d66bdfcca129f418a9dad9e..ae91848bcd828be197fc21bb2195f3e2460edc65 100644
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
 
-static int apple_pmu_init_common(struct arm_pmu *cpu_pmu, u32 flags)
+static int apple_pmu_init_common(struct arm_pmu *cpu_pmu, u32 flags, u32 counters)
 {
 	cpu_pmu->handle_irq	  = m1_pmu_handle_irq;
 	cpu_pmu->enable		  = m1_pmu_enable_event;
@@ -598,10 +604,9 @@ static int apple_pmu_init_common(struct arm_pmu *cpu_pmu, u32 flags)
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
-	return apple_pmu_init_common(cpu_pmu, ARMPMU_EVT_47BIT);
+	cpu_pmu->reset		  = m1_pmu_reset;
+	return apple_pmu_init_common(cpu_pmu, ARMPMU_EVT_47BIT, M1_PMU_NR_COUNTERS);
 }
 
 static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
@@ -621,7 +627,8 @@ static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name = "apple_firestorm_pmu";
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
-	return apple_pmu_init_common(cpu_pmu, ARMPMU_EVT_47BIT);
+	cpu_pmu->reset		  = m1_pmu_reset;
+	return apple_pmu_init_common(cpu_pmu, ARMPMU_EVT_47BIT, M1_PMU_NR_COUNTERS);
 }
 
 static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
@@ -629,7 +636,8 @@ static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name = "apple_avalanche_pmu";
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
-	return apple_pmu_init_common(cpu_pmu, ARMPMU_EVT_63BIT);
+	cpu_pmu->reset		  = m1_pmu_reset;
+	return apple_pmu_init_common(cpu_pmu, ARMPMU_EVT_63BIT, M1_PMU_NR_COUNTERS);
 }
 
 static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
@@ -637,7 +645,8 @@ static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name = "apple_blizzard_pmu";
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
-	return apple_pmu_init_common(cpu_pmu, ARMPMU_EVT_63BIT);
+	cpu_pmu->reset		  = m1_pmu_reset;
+	return apple_pmu_init_common(cpu_pmu, ARMPMU_EVT_63BIT, M1_PMU_NR_COUNTERS);
 }
 
 static const struct of_device_id m1_pmu_of_device_ids[] = {

-- 
2.48.1

