Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493C822257C;
	Mon,  7 Apr 2025 04:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744001176; cv=none; b=SYIhnopfhWVz8DqQfn9cDvuzdJjdfcu1lj+uZF3NL4xkyNkSeuwXkB9e2bhzCA2S/XeKtSAHgZNLsHyaxhPI2bdewgrlkEFcaG4IxlSK95pNPsoWe7+ayjp3gZS+D5w2yEDr/xpN5P/fpiiz7fS5liv4s52OSnanSY7LzU5arrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744001176; c=relaxed/simple;
	bh=EJFsNO1IGYgWw/sW/3l8ohSThIK8Gp7CsvED/Dkp2Hc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H+c02DbgXkB4ylUUnzcCsiho0WXmmt4rymVR0NaBbqw4ZQV/OWTwg13jrcng0pjzVB7TSruFs5QWVNyEh1sk9RiqtOCJU8EWKrySxjFUVv6cJUCUJlh0UNJnsUuu3ByMAbw1ckl4pLCJorOudBwwZWIzTQdkIk3N1DSCijRNNm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kk7LtHBn; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kk7LtHBn"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-afc857702d1so1534545a12.3;
        Sun, 06 Apr 2025 21:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744001174; x=1744605974; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZCbl29XIT1I4WAOKH87d2lc5ACONSBDEpnw9mXpBPIs=;
        b=kk7LtHBnw2heR5w2pIi4SaBZkdYyiYV+pXFxOjRwIJdmSoY4DLg6revBeaNmJWm3Fp
         AbjZSIEhpccj91WdczBgdKs3MofiMPEng0COxlAc29xyig2aHWygj9nZI7LRcoD+Q7aF
         RQAANfiVBbtsEefooKMyKbiaah+7JQ6x9jIEXud+yERUubLwsDA4nN9dKrWAbAyQVwQ8
         ME7qm0hDi1v8J29vVGgMosWsrnsLcN7eijcn/WV6Fe8ybuJzq1IYAK9S21YV1Hij0BNi
         ELUOMh7dft3nP1m0Uz7iTfLKBBPlr6FzPKeQiOwtd6lO9sRUGAcYNKl5l7RxJwCSM0s8
         yPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744001174; x=1744605974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZCbl29XIT1I4WAOKH87d2lc5ACONSBDEpnw9mXpBPIs=;
        b=NWG4z85/A1/2qOhe0tEeSbxlIVaWj1d2oamCbOsobLZiSydqug9Oja54+tP4/DZAVm
         Z9Uz4Y7GB1uhV9k76sOPItHXgHdSCefHzX3xuUH1Vg4azmp/5q+1ld6F5cp5jgM99YzQ
         BsJURYRVD+b1l3DqWFBNQ6O5gttTsUtt9Fre0GyekOzp9xeMJp41/3Tj2bIxUcEqyqX0
         brBIUb3MgUV2t4SeJ213s5t0BbVJqPfcumUCkownWFD/+h0fp8KUkz3Ym6uSSLbrcUK9
         vQ2tZ3zuojHPU1d3JWGruMfiDbdU+FYOL/xfNCarMYL/bp4+dcu9MDSRGVG0tADUXkQN
         pw0A==
X-Forwarded-Encrypted: i=1; AJvYcCUhhyUnZvrxeyidlUPYsotWtznnp0I8CwYSZnLkYKIw1QTG7dUlzUQqzMrGD7qd5IKhpxVOtxySyiSD@vger.kernel.org, AJvYcCW3YNHWvy3yGHcm3zcG0IUEAyu7gCf6DqW4OGVRlItbZfUZG/MFMD7lYm9nYFX2iC625PpaElLhbI9mfpO7@vger.kernel.org, AJvYcCWbHjdvYMHKt6YD1uh4gToFAmQcM+QeoAFJ+hTCvNvpAVZoGprW+Yp0GUlwXRW+kkMYTtezpV89pqgNCmA1umia4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrqCR9MrDGD17qElLdmnfCpC5PGeR9Ctk74kFV2D9744Bm0iGA
	oPRhffOICrOHhrA194lL6J83qw4QcAqE1kck9ZxjdQLjeIHoUoK6
X-Gm-Gg: ASbGncvndvjKLbStTaq6Gp5Ds0na+tGeQ0daEIZC1EAHZCei4aS8AGmPA+tCFr6FSpY
	0/fCAu+IU7rrXvhY+20d9bgp9GSD2FNEWWkkyjM36CvKbgGtcD6xGVeaaDTxizT3ecprhgD1BPd
	KkC/qb4Dn0/NnoyFTZVtDuNgfJnI1b2dFFoY/C3n9vcBYnut7oCFCi8HCbH6sYLLZF8H9fClAiU
	u7LaN7OupW7NTzKxZimpD7AXrB0Z4kvnko3M+rUHrGgbOXBIGAqj6OsXPcGaZc2u56s/MJV/R4+
	OXBoSCZELadwGHZmdCejp5BuCFmBebwYLXh9khv3XwQUT9bE7S97lbRX2A==
X-Google-Smtp-Source: AGHT+IG56QxhJ8o6lppK5g8KQzt2mjlnG2F6bF61e6G66zfYjuaC/cfZ+rAxlP2uwAeBQQjiL4eZyg==
X-Received: by 2002:a17:90b:498e:b0:301:1bce:c25a with SMTP id 98e67ed59e1d1-306af746caemr9540025a91.20.1744001174347;
        Sun, 06 Apr 2025 21:46:14 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-305983b9954sm7765810a91.32.2025.04.06.21.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 21:46:13 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 07 Apr 2025 12:45:12 +0800
Subject: [PATCH v6 03/21] drivers/perf: apple_m1: Support
 per-implementation event tables
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-apple-cpmu-v6-3-ae8c2f225c1f@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5785; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=EJFsNO1IGYgWw/sW/3l8ohSThIK8Gp7CsvED/Dkp2Hc=;
 b=owEBbAKT/ZANAwAIAQHKCLemxQgkAcsmYgBn81iGKE0zEYSiAoOBhSC+TnTK7fNCFMRTYvM7Y
 9EFozFfzcSJAjIEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ/NYhgAKCRABygi3psUI
 JOjAD/iZeh+v/hHQ9QkbyFUDYHTRNsZDJmI50M8KeuFjK+Y6Kiwxjd4JksnsOFWLiCPRTKEjW74
 LQv84yH6xcHNytk0Rr50N7Ic/kYHlM08/AnELmDso63nC+/M7WghEjXc4711G/WSFQS2CNdCEqQ
 52M4QbqSzPZhESod+ytQ1e6u3EBqcsyRX5RbywAvSSFli43aDjpyepPnQ049C1V2H8vu+dYPbCn
 vrR0W2oK0YMPvMiF7G/UpIcaUYjhu4nndMJZw8Bc77lCajsrEwvxUZ3Ta7UiGBxk2oY/lhgBU6p
 LRVoHMnuodVopxbkVgjqLZs1v1e/1zuwkH3m3NavJyu1nDCADhkD+PS/WxTYc21YJgwn7yJbcHn
 b9ti8RLpWHQhPrIDixgWmAgvFr0pKnw3QpLqJfRV3i4qv53nGEopgBxZcdEYnRjPfAVfjMqxyB0
 PzKYWZJrA7HIal+h1tmCUDlWzM+HNsd4EGP600bAfrwavtiDq16Ckap/VttgU42730Fjm/ikBE3
 Jtd/LQv32Ah4f9bVPmGUs0IL0w6pAiztFXzPMq/V3JqbwR3WeJD64tVX0kRwsejP/qfCXNtE6TA
 aljKH28PylFn4c5G8cdnvftd8pFVi96C1s9L7BIUZQD40ruC7u3FDTecGN3aJw8LSV5fphS8WEz
 UiBkOT9+dKfc3
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Use per-implementation event tables to allow supporting implementations
with a different list of events and event affinities.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 65 +++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index b800da3f7f61ffa972fcab5f24b42127f2c55ac6..d1bc850809993de044df8fd5d4dfc61341482ee7 100644
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
+				const u16 event_affinities[M1_PMU_CFG_EVENT])
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

