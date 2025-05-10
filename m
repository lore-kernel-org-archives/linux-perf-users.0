Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9631F235063;
	Sat, 10 May 2025 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746889901; cv=none; b=DhK4tC19Nk19APcS/MJ7WvZME5tMubZxBmD2fCflC7SWkzqbQwdQNEY48TvxW0/yemOwJFLPAd21GX6lceIZFFg9BKSjIht9PLq078Jp6/XlOaZMgwe3/MXza614KQ/ujgS/m+QAwM3WWB9FRkO57D2Mu4vkr0wulUB2NRcUZNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746889901; c=relaxed/simple;
	bh=40iBkshuT7rxTV03RILkcUaTWGCgn/IFCgnsDvO8O/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GryQWnEjopWDcMqzW6LUSakKUcSlz97uhUszkWXGHZdGekiYCp67xiWq4k/UtOU0Lwo1chbhyLesd3/SJUqWQhlQdRF/anJhbVn78w2+wxIaWWXRtKQDvg4Jsw0bTeC4/lqmZdyblBXPWhRDKeVtkqYABjxlH9maXaEQVxcZMA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZU7hDHJR; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZU7hDHJR"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30a9718de94so2980403a91.0;
        Sat, 10 May 2025 08:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746889899; x=1747494699; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gMIBDXt3IAT64Smd/QsEmSBW2Kr7RYH+ZBjKqzd3OdM=;
        b=ZU7hDHJR5WCn4Hh7BkJuF5NBF203J+fvVbN6J+XPAbCrM4WXLBequaDupJtvzWbkJp
         e5hxiS0js1wXGW9qYHl4C6zj9YaTfpM4ASiP+2PAqzK40Yvgn2v7RzN9hLGO+rzPiLO/
         9hu8eQ5o24AiOeRTo9lUdBrl8nezE08jODI5CaaQ2fUuIRXHpXOQ7DlMyqQWQRJmUWBJ
         v2rH69mO+EMPwG5zTlLfIWtVAICNmPhYSFrr/9vufA3XVpy0zt0y8be/TeU0IMKIF7sn
         b7KsJLoipM0bv7GtXqXl6mVpnUYMtOfuCvxkzwg1T5SUuBkkGKDwywoA4h6J599k8s+/
         Lk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746889899; x=1747494699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMIBDXt3IAT64Smd/QsEmSBW2Kr7RYH+ZBjKqzd3OdM=;
        b=W9HFoxHbcQkrXk4didFqVaB32pKF5YJjQ1bLiuq4ZWPX+unRfHN9MTClKFUgNhIhTm
         GmgTMR2iYny0xjx4exu7mY7/lNqHcj1XkcrzVLTBSw8byX7q3nxaWSqHC8eEDmo0gKx2
         L0NbPPZKLpVuNWc+475CbAtJSlAvRNcgBYtqFg2WaOEyGB0TCYkyNXTLAqyA6Zk8tFLx
         S0+BI24nTzT7Tgsb7EVpt5QW1vhA4c/NyNiQ9jaXku3CO05UqyyW+17rTCuQUUPwhT3W
         QtTLtCUwXkpkA98NZoy0wW3vtoNpFDgW5TMzca4CnG00FlzcRsFfJFANa7sP2PBDv75q
         vTeA==
X-Forwarded-Encrypted: i=1; AJvYcCVxUhvrlaZCYoSAy1Fj5WMoGrKsW9EdiJAzNRbpdJoJcgNA5d/Znnz3brYXJC07rsWhFLmaMhlqy2oPS6C/n+gvPA==@vger.kernel.org, AJvYcCXRyOcONi0huxyrRDVyyk+7sWmKvDixOE0pbZSKzg58lMNT+ZeuSqHvxF6e9MPvgXD5NmN5v/eNnltqqc6P@vger.kernel.org, AJvYcCXa6qlR+giNrV6Hr+KHNewGMlAHN6MqQEn6cQyO50/TEINxvpg+kByDMOAxFZasPVhkktcVdLiz+giV@vger.kernel.org
X-Gm-Message-State: AOJu0YzbiFNU92dm/VBoLmsj7vyDX841DSq9HFK+/eMmk/L8Mn6Gcna3
	6mhyI/mqXEoe1ZBlO59qJX0a3UTMPHHajzT3h5dVe5/ickNfH82v
X-Gm-Gg: ASbGncu+KN0USm/nDY6ST3Wgixwax33tUasnyKO//pWVxkyJMVkkvyuS+h5kpjI7uJ8
	UzdxEzpVRmXjT51jM8BiKofrKXGTQr2fTUXbX7kdxrR9tOe9Io4YTIECrTnh1HW9pXmMXkMeVcL
	Z94ex47x6lm6ZygKk/rLIkbGQL+XvUGlWcHF9wQg46W+ncNM27veTAP1DI8jhNCTXx3QUWhMwEN
	IcZllvxUECDBnKln2vrC82zv5v31z/A7IfSA1vo/toent8jtQclarGOAc7wXvNZ5eRPMWTwGvBP
	84y89D3K3w2MagMAdGx0ZsuNTkv3h1p9pm/SaqmRFchQpCjAinivKA==
X-Google-Smtp-Source: AGHT+IFGAQvSkp5FuP8s6Ekd05DHEU91mrsGXhbEbbmC5koqmXT9CbW191uBwo7jB2JIqA6kyeBvLQ==
X-Received: by 2002:a17:90b:1644:b0:2ff:4e90:3c55 with SMTP id 98e67ed59e1d1-30c3d62db0emr11513587a91.27.1746889898831;
        Sat, 10 May 2025 08:11:38 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b2350ddca3asm2990493a12.58.2025.05.10.08.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 08:11:38 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Sat, 10 May 2025 23:10:44 +0800
Subject: [PATCH v7 03/21] drivers/perf: apple_m1: Support
 per-implementation event tables
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-apple-cpmu-v7-3-bd505cb6c520@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5769; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=40iBkshuT7rxTV03RILkcUaTWGCgn/IFCgnsDvO8O/4=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoH2yayhIz5PCA9CQkhAbNeCgQ9GQexfDTqXWO0
 ctPUr1ixGmJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaB9smgAKCRABygi3psUI
 JCrnD/sEgdFU1NJujXIghWMxs8rHXtSyh92JAPQV7u0sEkfidYyYNdEBnU832xAgfr+6ZQsunR3
 rWcYGRX2GW+01RcwFsuLZL920aI4I/GYP7gxElY3gP0be6Q+yvzAdRxwkuvGwtCZPYS+tBEbyEK
 N7Yz0yOLPZ5PnzA0dalNlj5b7m5ANTN+7ET+RnIl2u/mQV2+PyBWTk4yiM3zYRSLHIxvML7WM8r
 Zpxn5CFnzYBtgme8YaJC3jn/ayayuoaCAC19ASVf3GLbRS0bUu3LrCd90VDKeD1VDU1Wkb5CVxd
 pBwFCDhk9fpg7XkQY3fBExa++uOWqfHkEsOfcqGY0zAEalO1U+GJoQkoPkBH5i+jyL1zlimpT8G
 1uQGwAKzgwZo4UIjme1mXlONbw5/5MeWQC9rumXb5KP/f9s7saX4geoAwtyZ1D+9Fy9zqMxGUym
 R1bewdXG8LVu3F80f+JOmgdkyo1vW9NjAkpPeMzhlH3GltCrZ5wphN2P1RSCRxFN4Ig9mMqjyfX
 tvyJmDwiPBicJycEOz83WDsZBxoYHnC0d+upLPcXviqnvGM2fKyhmy87/0yqSPTHmVyuVElIgNN
 xaLzn03uXyBlnp/Xdbo285lNd9cuI1T1pA/XUrxoDcc0qLud5cGBL9uvM0DehczF2dCQTqy0zMV
 fvPHQWZOd9njTVw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Use per-implementation event tables to allow supporting implementations
with a different list of events and event affinities.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 65 +++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index b800da3f7f61ffa972fcab5f24b42127f2c55ac6..c19a433ee6478876e4cf6667d7a85a193b6cb069 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -43,9 +43,6 @@
  * moment, we don't really need to distinguish between the two because we
  * know next to nothing about the events themselves, and we already have
  * per cpu-type PMU abstractions.
- *
- * If we eventually find out that the events are different across
- * implementations, we'll have to introduce per cpu-type tables.
  */
 enum m1_pmu_events {
 	M1_PMU_PERFCTR_RETIRE_UOP				= 0x1,
@@ -494,11 +491,12 @@ static void m1_pmu_write_counter(struct perf_event *event, u64 value)
 	isb();
 }
 
-static int m1_pmu_get_event_idx(struct pmu_hw_events *cpuc,
-				struct perf_event *event)
+static int apple_pmu_get_event_idx(struct pmu_hw_events *cpuc,
+				struct perf_event *event,
+				const u16 event_affinities[])
 {
 	unsigned long evtype = event->hw.config_base & M1_PMU_CFG_EVENT;
-	unsigned long affinity = m1_pmu_event_affinity[evtype];
+	unsigned long affinity = event_affinities[evtype];
 	int idx;
 
 	/*
@@ -517,6 +515,12 @@ static int m1_pmu_get_event_idx(struct pmu_hw_events *cpuc,
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
@@ -544,7 +548,8 @@ static void m1_pmu_stop(struct arm_pmu *cpu_pmu)
 	__m1_pmu_set_mode(PMCR0_IMODE_OFF);
 }
 
-static int m1_pmu_map_event(struct perf_event *event)
+static int apple_pmu_map_event_47(struct perf_event *event,
+				  const unsigned int (*perf_map)[])
 {
 	/*
 	 * Although the counters are 48bit wide, bit 47 is what
@@ -552,18 +557,29 @@ static int m1_pmu_map_event(struct perf_event *event)
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
 
 static int m1_pmu_map_pmuv3_event(unsigned int eventsel)
@@ -624,25 +640,16 @@ static int m1_pmu_set_event_filter(struct hw_perf_event *event,
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
 
@@ -661,25 +668,33 @@ static int m1_pmu_init(struct arm_pmu *cpu_pmu, u32 flags)
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
2.49.0

