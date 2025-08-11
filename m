Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC7521ABAD;
	Mon, 11 Aug 2025 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920540; cv=none; b=lk9XEVqvY6QEV7LTVrE1aKaXIzTIJn4p2349Llf/K4pj+Wn17Az/eOC79CKB3O1UXR9mykcy+qv+NjgxPWso7ogo3tgEhqJ4qcNe9G99icp3LUl6uyNDTmHV7C29sgweoBUA11q2B4b6ehyXCORlr7le6Xw7OAQDeYFzZnOBjk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920540; c=relaxed/simple;
	bh=L2YMsQakHXAovXEtkfkDoO7BcCisDs2noWQ8gSGB4P4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m127If5r8gBdPByv0WF2qNF464SH5wn32p1FovV5GllXPnOmzfWUJhYkAeRS57gxVDKuqdG0iGjmAcvkkxSZX2IpQ4VDcEwO7IZm1NQxJcMB1+bMXg48m05GrPrx6j3tpTzzYnQvU8BuvSoLtRr8XAnT4VjNLafE82+Qoum4KpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBM9tahT; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBM9tahT"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-31eb75f4ce1so3856736a91.3;
        Mon, 11 Aug 2025 06:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920535; x=1755525335; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bii5U19mzG3NLCbpWEGJVE2xyiZpHRsFsKgumtymqHE=;
        b=hBM9tahT1HOMBHxmmpbHOR7h7Y3MZdKMNbm9/Un4dvLCm4F08W2pu5NV5yFv/Ini1u
         1vEWtxCcy9m/VUFKwLuV5pUAm4MGeHLL6JdTqC4Hl3afiDkgLxYp1iIXLqWR/pHc0Val
         osEFQDyOyL1ix94x/i92mVlCbhwnhzMXw38tHWLrrWg0+nwHLqqhk1YPXA44hHuexpSv
         o+bX3gx50cZu4HhKctygI55IWh3weqsF/Tld+Fpx5MptfYTwLZLxUb97uLkD243UvSAt
         cGTfZ9gNuzaluzvdpl09KL0r8TcRfl6Ag99jUdyJ+DYkDWWFK90PahImQCEpK0Te1ZmQ
         lQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920535; x=1755525335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bii5U19mzG3NLCbpWEGJVE2xyiZpHRsFsKgumtymqHE=;
        b=m6sx5EA6ImJKHX+AQjhWc3jKMaB95PcIbtn47q490EUEIaMOqeKZnqXe466kUSZRV2
         btTs7byz2rlKoVz6hmWJ69r1X/Biav+uDRHIk2itCfOuRblR48nzKCC3avdKTQOLHgsN
         JY2NZ8frRLp024VFQESCRLwSyqErW0wsfQNwr9eXVnKQWgaPPL1aeMRCgrO2E71cr8Y+
         6AYCoxMxuq2e544D9u7lSt1lh14zWokDoqwb79Dp8Hb7EjaJHpwydLd6+87cybdLhse3
         7+qbou00bueG3l8Jwu/Yuxv5AavhckKU5hiaInA+Xlp+u7N3yrpjq/Oem51WTA6dwWAa
         dQkg==
X-Forwarded-Encrypted: i=1; AJvYcCU/0KLKrfbkJr7/Qu2h6uM8VROWox043rNBFcF4X5ZtvrWql/jqZ1mYoTUxA47L71wgmsAX5Xq2fu/8npLvpbqS5w==@vger.kernel.org, AJvYcCVwqWtmtgke96yi60Cy+IZq630K7H9zXN4I6x8xgqKLl7i4G6Ovw+G0ZofyQ1Qjm1+DCY0R2E8onC3GqOzt@vger.kernel.org, AJvYcCXmY0r+HDYH9y89P6jFa55yl4bLxf0OEjqwzGUT98VnMW/cUVcdLqPnAuAe8+1i33Mxdk4jFOw2Sj+w@vger.kernel.org
X-Gm-Message-State: AOJu0YwdDOcaQDMsJ7QB2fFkTK4q3jWRYSI8Qo9e/W9EqvXuZnSxn0EL
	Jm7HKRufXgrNFhXhgNcD8rkYTsn20bnWrrEvmK0agQN1fdgWRqvRpjwoyN+zPQ==
X-Gm-Gg: ASbGnctY1XzGjqyXjz2t2b7FamlzEr6iHCUOy5sTqxd1tCP2BHBIGHkl8XHutZt77NP
	aEYNA51pXI3MPJ9LJcklKqTmO2Nl4J1KNf2NEoJovCTN1YsSAcQGdGbYGUHrj5XwIujuB5q41dT
	vrj+UnJjbh22uQY+zVM67JRh03mKU+w712j8fMgKGc3by48JcJp6aO/YuUD3EbMaOw9qbXJ6CsW
	as/ElwwEhiP8viuqxP85D9KRlEX7QKFQnFtanIPEqRB6zdPRAE8qjmXtov3vI6DLi+PWQOpbXe5
	+T2ak9TtUlO4CtWo6gdur58KH98rkc2/9C3sJKpFq9C5O3m9cnETNm3L6F76EjTO16WzrnbalLm
	HwhzCSEsA59ePrauPLMBNoM5gCnlBTZTioGrdyjediQvh9Os=
X-Google-Smtp-Source: AGHT+IHc9I6hIyljcY7HJbTACaSv3ftbDSpYv2swxF233857uapz1SqkCZUNyhI2JqbdRS8fhwZLuQ==
X-Received: by 2002:a17:90b:558e:b0:311:ed2:b758 with SMTP id 98e67ed59e1d1-321839d9dfbmr18574178a91.3.1754920535058;
        Mon, 11 Aug 2025 06:55:35 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422bb1133fsm23585496a12.56.2025.08.11.06.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:55:34 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:54:35 +0800
Subject: [PATCH v8 03/21] drivers/perf: apple_m1: Support
 per-implementation event tables
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-apple-cpmu-v8-3-c560ebd9ca46@gmail.com>
References: <20250811-apple-cpmu-v8-0-c560ebd9ca46@gmail.com>
In-Reply-To: <20250811-apple-cpmu-v8-0-c560ebd9ca46@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5769; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=L2YMsQakHXAovXEtkfkDoO7BcCisDs2noWQ8gSGB4P4=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfZBqHdal0BAjjTgQbH52DWluytNz3S2xTEzC
 s+6fQn6qcWJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn2QQAKCRABygi3psUI
 JCgbD/kB5IrVKa5WSvD4j+qzCZ7IawmO0u+5y8zwKQrp3Qyl20OdNTRrtAbErhIf8BBRuDBafU5
 abcoH+dUwb5fmQDxo13ZdulVpVqNPxXKXYGhuvaeWyDieZgtp3SHYV/3mEcSHSZZSYwftYJ9Dxo
 vTtlKLK2JDHXr7R15AKZKeuB4I6c34p1Lpz+1mS5iXpFNFDha1R2/kuMjpLS6BeoTggUEfmJ8cs
 AHJviwFNEproj3Gff+DIx/AgroktT5t39QtvFBH9F/viiQbob26YBLvpX6UIvtl2ehZSHSG6r4Z
 BduXTZkZUldXe/lgJGVm21+46O1ma9s0kjJMwfODiFF9cQn0oNWIRk7f1nLGs1zNKkiObNH+2Bx
 OUD0etGDV7JNe/I+m6yUB7EM5Tj+EftkLtS5JIGpjDeYMnmV4LlgJJbe4jl+DGqsb1el9RrkC9r
 t+0Gfj7KJAGLqZmm9fxcf2O9bE1FJakg4C0GbWSh+hvI5OKHYhjUrGOp4qMkXABdXDtAr2pDKWx
 evpuRFx0ooXSvcvY9iocDHa7RFg/sd1nzCJsh562luG3BTWGl4CQwQwz+PJ0FlvZOlnahz1g7Jt
 7Q4WC5e0/IH8Se+4i/wqx5X6ozCiJ/2ElxFraD3muszE90l7Lc808eMPD5E9WJ0c/SinlQty6PI
 l1LUXwR9E9qJPEQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Use per-implementation event tables to allow supporting implementations
with a different list of events and event affinities.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 65 +++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index f3948528e28e0189efd0f17fde0d808930d936af..b4ab6a3e5df965b7ef450d7e533995f3cc8633fd 100644
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
@@ -493,11 +490,12 @@ static void m1_pmu_write_counter(struct perf_event *event, u64 value)
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
@@ -516,6 +514,12 @@ static int m1_pmu_get_event_idx(struct pmu_hw_events *cpuc,
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
@@ -543,7 +547,8 @@ static void m1_pmu_stop(struct arm_pmu *cpu_pmu)
 	__m1_pmu_set_mode(PMCR0_IMODE_OFF);
 }
 
-static int m1_pmu_map_event(struct perf_event *event)
+static int apple_pmu_map_event_47(struct perf_event *event,
+				  const unsigned int (*perf_map)[])
 {
 	/*
 	 * Although the counters are 48bit wide, bit 47 is what
@@ -551,18 +556,29 @@ static int m1_pmu_map_event(struct perf_event *event)
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
@@ -623,25 +639,16 @@ static int m1_pmu_set_event_filter(struct hw_perf_event *event,
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
 
@@ -660,25 +667,33 @@ static int m1_pmu_init(struct arm_pmu *cpu_pmu, u32 flags)
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
2.50.1

