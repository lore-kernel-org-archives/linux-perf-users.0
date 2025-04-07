Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9B0222591;
	Mon,  7 Apr 2025 04:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744001179; cv=none; b=baxo/xGg4/sMFKL4ZhA3QXcZQE0eDTx77u4RUUiFgSYs1+dRcKMlbz+lzaVd75dK+1WGGrKu0EuwZKspfre4cwhWIfgVcLa6VB2ixKb9927WALAJ1itBBERFrcu4DRjvRQWvZdJ4zbcB5SzYo3QIdFexUi1QNTk5TIh6h20Y6tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744001179; c=relaxed/simple;
	bh=BTD9OzZ4+bVdpzPnyX6mWog1RpRVl3h0ilCKcAXUUSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BRmZ0TcXIGZEdZC0MOSqXFp3PHmdPtxzxGRYKLyazFWAGLuSvRccG0M5uozvhgSkMLLEwvJEZjy1u2300St6WBLp+jWxk6z64r0NR+rHQ3qz3f8LcKUIWytutaKZNE8M2ZpSMms7FokfNn0iG2dFIstR+IcG6K873Ls4kA4a8Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVRVAiqc; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVRVAiqc"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-af9a7717163so3808239a12.2;
        Sun, 06 Apr 2025 21:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744001178; x=1744605978; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gry3bzp7sxRtt2sNra4Mhddxnl7ZGz7/lk3ev5LDghw=;
        b=HVRVAiqcOWRFg5ocHMW7+njJaw/ufXNOHTStCdCfg4rwqBM9gh1ggkKJvdBOdeC3Nc
         zQwwnYqkCbAjdBmFMpCE3p7zJ5y7MriuvxMy1uPygg1ukqmoZqwoM/FOX2wtZuFMnHgn
         0fMEH8mHBMM0OjIaeV5QJGUl4wPR/pXeSYdrOx4eWnZQ2yDnoZYkL5Slhx2FtAvhwAVG
         tZ/h4BgIQoNVJHL62UMta4ngF8Z5pZ7oRkZQ8+OllOl1IWV1KwyR26TI+JSabnYmWYFw
         gr0x7sH4CXxYQVJk4pClbF4KZkoc5qp1TnmnRsp8vd610zUA1zSS5jlVyMGrS+OJVjme
         DOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744001178; x=1744605978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gry3bzp7sxRtt2sNra4Mhddxnl7ZGz7/lk3ev5LDghw=;
        b=sT2iXBeWwEQQfwETiuD+BA6FNL+ZnBwiDsa31M4Ta+jNGBMryhWMlipTrkwDL/OYFd
         brhfdcqJaFzpSi8xl8h86QChGaCywpsHODYzdJ0NhTHab2sLGZVW3Y2dgEorKsulAo0v
         kfdqVKTnMQxuor8SqhaABKHFWAeO/ugq9ikd1SWDMT7sOmfRLOFn6qWp3hnNyg4dWabl
         P+XJJM10fRrd0oZJZ9MJ7bJOIBy4T88mtWBBKdix6hMPXtcWEx7d7H/RukCKfkWTvKsj
         7UcrscOoU4m/Hc5sCLyAupML3koXVDho9x9hcdEwwTpBXdIWkfqTTk6uVpG7xJWUpkl8
         HcRA==
X-Forwarded-Encrypted: i=1; AJvYcCUsBJ7esgIZI+rs5JezbtaHQnhiXmdQhAYAJm0d0pkeipsyDoBuaG2NUvWvuSL9nRpotjzrrrxswmWg@vger.kernel.org, AJvYcCXkUtCniQoSgyrBCiCZ/i8VNnfD1Mmcv+MfpVDVGl082p3HAg8V2+t6QzxYh+mj3yTE8kbVOhdJYur2aECoTYnQZA==@vger.kernel.org, AJvYcCXnF6dgl6g9UEAe3aN8UxHoaTwsWozQCeKBegyLlcsOf3U2LLgBUNULEMvCQbIDAMTMQtWDU93gZmoqSoqO@vger.kernel.org
X-Gm-Message-State: AOJu0YydvvNpy0mIPh8djH4KMdqq6RRAWkXmkots5YwDOxYUXeSyouTt
	Wzo5X1fOYal3YBLW0RGATbYBFQj7JH26sregGsIMXW6gCf3fVXmX
X-Gm-Gg: ASbGncvwkUIr0dizzoW1Tv8Fbf3R0ta74VwmK+Si7TrOlsYW8TNDJ0DtoqsOc/ZK5s1
	ZdHOsiebg2gjVVrGb4lXx2krcXoiCerx9V3Zw/02iV0W6K/xsNWX/h4MMpMS+MCTZAeseDC3aDY
	col8mLNBEMktz6En/6jIaVy2VTtbjAoho8OiS3oxBHSoZFgbsvN9ki/VXuDBMydKFb61emDQ0Sz
	7G41WZjCMX3+uHLKjbDB5Kl8vABO9MOShf8M/dnEm9VPQ6m7V31J7fgRTvpmq1VjQgZIu3PG8Z/
	Sf4qkALcW7tR9I6MNPeD2lRcdQ7/vbjvoixU26DrG6YiO3MYqV6GMnPqUw==
X-Google-Smtp-Source: AGHT+IGrn96k8IFooljFjwgzgf5cA5zXbc26sJl4BoYnJK07cZUWI2sv800GQNYeOpWRf4WuwWHOvg==
X-Received: by 2002:a17:90b:574c:b0:2ff:53ad:a0ec with SMTP id 98e67ed59e1d1-306af747edfmr9119148a91.21.1744001177647;
        Sun, 06 Apr 2025 21:46:17 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-305983b9954sm7765810a91.32.2025.04.06.21.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 21:46:17 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 07 Apr 2025 12:45:13 +0800
Subject: [PATCH v6 04/21] drivers/perf: apple_m1: Support a
 per-implementation number of counters
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-apple-cpmu-v6-4-ae8c2f225c1f@gmail.com>
References: <20250407-apple-cpmu-v6-0-ae8c2f225c1f@gmail.com>
In-Reply-To: <20250407-apple-cpmu-v6-0-ae8c2f225c1f@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Sven Peter <sven@svenpeter.dev>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4845; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=BTD9OzZ4+bVdpzPnyX6mWog1RpRVl3h0ilCKcAXUUSU=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBn81iGqhUUZt9nky98KDY3T1B1WYbpyDK+8m3Yx
 gUwHxgLQmiJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ/NYhgAKCRABygi3psUI
 JDKXD/4lIldbnqE1hTQRJKq40e4filHHMJC+4IZgtoHQV9zQvpGEB5y0InQPawHu8Tf2z8ghGrW
 rBHV/OrTcERXXaisZxR+bXTVybcA6IrSWR2xtyBbTlLv0e6p75USp3XfJ0oKhDY3ibrVizo6Hys
 w9Hmd5qCKxDTa0XtXAkg9/BNpxPDpvIwabca0KvcrKjtwX9s9R4/5GVu4qnSKpOprT1fphO1UyZ
 wld4wNY2RM/Zt4usnUnFKQkTSYgjKU6br3r84+0UPJWVzkR/6mNBZkFVJaKVvOjbhC/L8cPn5D8
 Zdy5vn4MDTE9QVufxf/38RkCD66qMLaPrCylqsz5pVPWIBrJXfHK4JYgEFwjnGxnzDl+xCPUHhw
 oPXbMpK9+bc+QbF9fDRPWlK6hiQwBue6RdGmpByoRLuqBT9ZENx4htJz0EzIB2rxcWyTS+I01M1
 z5mpVLKKeXDaGC58kG48Day4fJ3w6ielBMs3hnLwz/K9FHX7eG9N6KJHttopx90aIj1e7bbxrwF
 soGeVQeFJzQlZXuvncRaWzfuo6aGqiKbqvcMGtXi8kkp4c/Rjr1hxTRYIqzbNZgWVXfycklDUqh
 zsrgUbWygnAwU/kVcmZLGcEId7YrlqabgJaLzs9kaFcHJXzSXN2+FaapQKmEkSf1GaJWS1ZDrsw
 CTg+TUuCT8qrznw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Support a per-implementation number of counters to allow adding support
for implementations with less counters.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index d1bc850809993de044df8fd5d4dfc61341482ee7..c03eb7acbb66790e17967d570c71746f72e40867 100644
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
 
@@ -507,7 +508,7 @@ static int apple_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	 * counting on the PMU at any given time, and by placing the
 	 * most constraining events first.
 	 */
-	for_each_set_bit(idx, &affinity, M1_PMU_NR_COUNTERS) {
+	for_each_set_bit(idx, &affinity, APPLE_PMU_MAX_NR_COUNTERS) {
 		if (!test_and_set_bit(idx, cpuc->used_mask))
 			return idx;
 	}
@@ -602,13 +603,13 @@ static void m1_pmu_init_pmceid(struct arm_pmu *pmu)
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
@@ -617,6 +618,11 @@ static void m1_pmu_reset(void *info)
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
@@ -640,7 +646,7 @@ static int m1_pmu_set_event_filter(struct hw_perf_event *event,
 	return 0;
 }
 
-static int apple_pmu_init(struct arm_pmu *cpu_pmu)
+static int apple_pmu_init(struct arm_pmu *cpu_pmu, u32 counters)
 {
 	cpu_pmu->handle_irq	  = m1_pmu_handle_irq;
 	cpu_pmu->enable		  = m1_pmu_enable_event;
@@ -650,7 +656,6 @@ static int apple_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->clear_event_idx  = m1_pmu_clear_event_idx;
 	cpu_pmu->start		  = m1_pmu_start;
 	cpu_pmu->stop		  = m1_pmu_stop;
-	cpu_pmu->reset		  = m1_pmu_reset;
 	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;
 
 	if (is_hyp_mode_available()) {
@@ -658,7 +663,7 @@ static int apple_pmu_init(struct arm_pmu *cpu_pmu)
 		m1_pmu_init_pmceid(cpu_pmu);
 	}
 
-	bitmap_set(cpu_pmu->cntr_mask, 0, M1_PMU_NR_COUNTERS);
+	bitmap_set(cpu_pmu->cntr_mask, 0, counters);
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] = &m1_pmu_format_attr_group;
 	return 0;
@@ -670,7 +675,8 @@ static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name = "apple_icestorm_pmu";
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
-	return apple_pmu_init(cpu_pmu);
+	cpu_pmu->reset		  = m1_pmu_reset;
+	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
 static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
@@ -678,7 +684,8 @@ static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name = "apple_firestorm_pmu";
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
-	return apple_pmu_init(cpu_pmu);
+	cpu_pmu->reset		  = m1_pmu_reset;
+	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
 static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
@@ -686,7 +693,8 @@ static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name = "apple_avalanche_pmu";
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
-	return apple_pmu_init(cpu_pmu);
+	cpu_pmu->reset		  = m1_pmu_reset;
+	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
 static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
@@ -694,7 +702,8 @@ static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name = "apple_blizzard_pmu";
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
-	return apple_pmu_init(cpu_pmu);
+	cpu_pmu->reset		  = m1_pmu_reset;
+	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
 static const struct of_device_id m1_pmu_of_device_ids[] = {

-- 
2.49.0

