Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAFF23507D;
	Sat, 10 May 2025 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746889904; cv=none; b=LMOUN5X6Gy8Pi+WB+xlK1qX+Tagq9MRb0gc6bErUmkIXy+/AhdwMfqx3nr9fuogxF+/DTnf0v0mSDykIxbS2Z+17Y1d7Fhd4S3gIjy2haGEyTB/vA9tkAO20S2tFYAlyoKdURuECQudUeKSOVnvPzFmBWqhwy5YgS7woFXeQJHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746889904; c=relaxed/simple;
	bh=92neIFKGScRdX0M24usDNCsl0ZJtczDZfCVErT5yl+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V72LdViG6na4r/L2he0v2Gt279/wKAySzOJxiYtRX1zzEIjB5gX3bMxA5kyqFK/tsSckbh03L1MWClygD5TmQMfiBFwgj56edtC3tk8geSq/0cWKyjYVXzi7P7HbbaDVVHOsi2W0wcJUNAa3nPm5x0pYXlj9tu5a0lfMtEbiAWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUS994gH; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUS994gH"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b268e4bfd0dso548691a12.2;
        Sat, 10 May 2025 08:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746889902; x=1747494702; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RspcmdC6N9FCe5+5MFitUG7n/lZdN0nBTHTU7ItA6Ws=;
        b=mUS994gH0fKzdxNX64lvPR2OHESug/9U9hJfZDoPNBKQiqNuAsMgP7w/SRG9dwDQSE
         ei1JPER3wpFILTMqo/HAqxwVCUb4iT15tsbbQY/icPMB6W8i3WeGWifhQxGi0EnuumG4
         W/SWXg0Saanf2ODP1zpN+p2knc9pP3QuE3xuLKqs8+gdepc4Rn0ws65Ly+D060bOV4ip
         Sy2kEGMhKCTYctrxIqgtaRxFmoIUDgWXYqAN5bHmqFqOersLVNL2DtMxl5kJv4ZKJ8+R
         /8iZUqEjOeNSW1XwfGA2xM3uKifu0mffusVyKLEJgFpEv/AGqtYlDJqyJVl7a0pCsoeR
         tEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746889902; x=1747494702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RspcmdC6N9FCe5+5MFitUG7n/lZdN0nBTHTU7ItA6Ws=;
        b=Ln9gL1aVuJDr4xAwnNqx4Vw3yG3u3hrEn8dQmNUBkEXOLD6QC686dyNHjJTisoIHY3
         VafQwGylXR+BgXVGG/A3FnT9S+UtYUS4LU70w9opQezcqsVhHrJimMTCr/zIbz2L4FHO
         E0fSjwgxgPOX16sShi8aVND0aQbm84o+cmw8Sj6OuYgaZUMO3IlpSpkwci8WELg4xxk5
         XUTZmpu7RmzlCSBZuTADqurFxw3tlsPs9K4p4dYEeoeca3/I/DjUu0jnK8PwWJ1azUOW
         O1OPXNqrNQiCj++W5LKSIg9A2+2KY1Q3DJQBocjxYvzbE9LFPbE8kDHPP6i0pJb7ju/h
         yCmw==
X-Forwarded-Encrypted: i=1; AJvYcCU1kY+ozee6GbSJvC6l6jOYj1qT9y8NnAjlM9wn043k9eOgRZcGFzQpVeSxtX5Ht4hZ3XBNAMe/yZ2kFuWv@vger.kernel.org, AJvYcCVABiBmuZ6pypwW1KSK4hbg9i+SYK4XvHtvZPNYuz6WTVvweL1JBCsU8gwsk36XhgQDTcJd1a0rw7xQ@vger.kernel.org, AJvYcCVdJS0liTVRsO0LRAo6dmK6tORHwDnssyWvyMqNwzbDM4hqRM/Ngmzkf4qQCfdwZd7GTWozCX2MHQJo7+qtsxe0ag==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkOpuQaeCv50Vro2+wUmf9ZdYXktWJ4UdbyItPhtr1YhDJKgiQ
	ANxYdJHXtyvALsbqDvQVDMIuCqMQLErJDWwzuXUJcF6CH94kHbkX
X-Gm-Gg: ASbGncuSLlorI4wu1M6hI4kF2XqizZrpujsLjaIrVHXIMtNO5cYIyZ5aRJ8kQ+0mF1p
	UcksWFA0NIUTHSYq5VLft55brMUVMRmychYB32fUszgVPUA9EJSmtQ7Vbl6fqDw/Ks0CWAm/1Cu
	aFR/p4qt2zFUBY4IknR3xfm3+xipb3mxgHda61o0WjZpkb2sSioqKkaPAxAWX1iHJQGcacLMS/O
	cNBJQh0rXQf3W774hJPnL2HUPEedV6FHKKxjQXYRZPRSG/j96vC+Rcq9Bm23denF869Gf12FSwe
	izphmiGAuEH5zxfvHUSjXumGgNGvspwO6oI8M1DMXBgMVkoJ+Nsm6A==
X-Google-Smtp-Source: AGHT+IH6LOQJxyz6csgZLr0PJhoHpZeb4CPb2lTMFD5ePFD1IshoBGWDGCQdrqqAtaHGRZzB1c7pDg==
X-Received: by 2002:a05:6a20:3d81:b0:1f5:8a1d:3905 with SMTP id adf61e73a8af0-215abb54c9fmr12010580637.7.1746889902187;
        Sat, 10 May 2025 08:11:42 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b2350ddca3asm2990493a12.58.2025.05.10.08.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 08:11:41 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Sat, 10 May 2025 23:10:45 +0800
Subject: [PATCH v7 04/21] drivers/perf: apple_m1: Support a
 per-implementation number of counters
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-apple-cpmu-v7-4-bd505cb6c520@gmail.com>
References: <20250510-apple-cpmu-v7-0-bd505cb6c520@gmail.com>
In-Reply-To: <20250510-apple-cpmu-v7-0-bd505cb6c520@gmail.com>
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
 h=from:subject:message-id; bh=92neIFKGScRdX0M24usDNCsl0ZJtczDZfCVErT5yl+Y=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoH2ya13gcTy6b8qRQIOa1Rt2jH8B3xfc10cesY
 +t9h/brlf2JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaB9smgAKCRABygi3psUI
 JEwQD/4tGlSHmelrEbyAMqwr3JY9m9fL8G5QuPRBqxpH/HEK2SdBMAf4zpfWRhal2UOeIvwc1BF
 KtPrgrTQblsYBwirT7CF5qOxJarGpL4su/3RNQUaaTYaww+yjVIrz8dcZxC0lQpcA1L+s5hh5MX
 Kbwwe8kUeArHmk6lSioRZDQ8gk2N0CmdTvUl3P/6ANaekpxtRgKu1ZcnfzpI+dLV5Y4TI070H8j
 vk8KIYB1AMq8hGfyPJDhYDlQH8KXdCWRW99vWi6K4YNi6VwGT0bfTWoWMIObyvkn1d/XxUO/hnv
 blrqqCYLAvCjpMlnAFXT4hT/qYe64sMzNc7u8uPm76RcPAJkT69K5vE5Q3fnDCh2nLGAUo+S2lL
 7PAa2N3c0oOKm/PWuuyEgRX1V+E1ItNdjGpBBYkeYQvaT/3P5+/yb74JrMpVDuHg53j/hjV5KoL
 M7b79TeRhGibUqm3x0vbMtdFTBMJvtPl1wPQ2PuAjY2sr1sdI3yaX7atITysaDeRyrRl1pt+yTn
 h+lnmmYekfDGgSNkJ4ZlPpY64fU2frfiWCrxBhHXPjmNbyKc8U+ysUQC2TEDVyxDfGGbOduyQS/
 1KcMxZWZl4l3VidobhXR7vjn4WFSCrtFrw/nhlMkcw1kXPk8m7FSIR0Rxv2rvLLvg1Sv7shgupL
 Jt1xLBWw8vPDGRw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Support a per-implementation number of counters to allow adding support
for implementations with less counters.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index c19a433ee6478876e4cf6667d7a85a193b6cb069..35a34eca403384c4908c2bba2f8186ea854d63bf 100644
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

