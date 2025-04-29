Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B972741CE;
	Tue, 29 Apr 2025 03:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745898230; cv=none; b=B57scUh6TaHL+4IKQppq4bmg/Sjq0IESXWFtJhi6ZI5XNl2i5aIKL3mrCdaVXDnd+I5YrniYoeqIDYI8YewiqfI+EjAJnzyZsPhv6ApZ4gMrRY79yM6tK68nNjwWyRSp9JcnZzhlt85QR+X0IRAzcNkrVA3TnPjYagV0qsh6cFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745898230; c=relaxed/simple;
	bh=EJFsNO1IGYgWw/sW/3l8ohSThIK8Gp7CsvED/Dkp2Hc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LfemfNCklhkuJoEr7pE6hh+HbBPYJRuKN+oxSQUVRb7K/nUROkWrfdccWN4RA2PkvDueySnkYOpAaYkEA48DWlPKtkO+yEMWUDvkbGsNZLMWfUFew6gpjqP+1b6taKgyC7x7REq3ujtQPVWjymaDRGS7bBdyMENcggbGaVFa1Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8LskoSK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8LskoSK"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2279915e06eso62227255ad.1;
        Mon, 28 Apr 2025 20:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745898228; x=1746503028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZCbl29XIT1I4WAOKH87d2lc5ACONSBDEpnw9mXpBPIs=;
        b=d8LskoSKhgawBOLJN+iuL6zxz4okAcKLjyoN497Lh9iVLnsEQZidkc2Dub7yM4irn4
         Ob11kKBuiewpO1ck8H9MWNJCPGezRt+HMas+yQYFk61orNtmugebwGl2zjVIOkfSgLXs
         y3a0+apaI3Pp+bRpFnB5o2w2HTyRKM+1mrhv2GoTehfFiABpbl0UhXT8t9Xr2aB7C2sY
         rR19JtR17H7wvNXOWhUh1D1IT09bqnF1mzEXTgDyAdlkJOp9yye9u5mw5AGjmvtBGVXw
         cdrCDDb4+2GyMXSdxR8Vo6dyDALCCqnqDgODk4KmA4QnIE5ycvkgnduDQ4kdov0wpOVM
         GDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745898228; x=1746503028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZCbl29XIT1I4WAOKH87d2lc5ACONSBDEpnw9mXpBPIs=;
        b=B2vkdj7VNLZNGm2iUC3q2O0yh1G6DWwNqSF040zqMiHGBselo48UQevFsoKolXRPgY
         j6MYFOj8Z+8bIz6y1QNAqlSkVqoMuWPL2ca5n0a7ghvdqnzJbhBFdakoIu/fuSB4F5Wm
         lMJua5+PCASSHMuVQno6qVl5esA21/TqR2x24cKa9WZ26+VORTTyZc9gr93kAMhk0hJb
         Qgq6FHsUSNzRGeuFQPc0qE7QaCHMx+e5SEz7X1it9+iJIKPjt0VoZJL9xJ6L1QwEE7Zg
         1pLX35rlGG6d9Qx6SDQxXFJ5N2dMUDv5EDGafEYtsh5fWWffS2JokZ9Y+B91qHUTHb2c
         Tjtw==
X-Forwarded-Encrypted: i=1; AJvYcCUBacX9Eqk5AlJd41hfA64dNOxx5q1jgQ7rApNUXbQXakqq55tx09iokvDy/G3qq0wBnICbMlhg+zy1tZNwLRlwlg==@vger.kernel.org, AJvYcCV3xNQptuNsjiwSVbAT+1FH9C3zwawZwGBanDJUQEbvK1bDgpgyAsiFQwKlAEa4wu63ma468V07SzLwvzCR@vger.kernel.org, AJvYcCX6cxWY4rR/pFY5GUtOWYyccx+KKumpu2VXZgBCI1wmQ948Sw9N5/LyC+XcLP57wNxL5sgjgcQAvs2T@vger.kernel.org
X-Gm-Message-State: AOJu0YyErpJgedWQcAglXCi0fSmpUuNvSwjPxRPxR+SF02TIic0jDcoh
	aRw8zeno9Kv8JYeZ5GhIkNHZQmTuwrkVkehczlPe33NnvJBdVnkX
X-Gm-Gg: ASbGnctXskXrwjaPBoFAAekvo2VC5GnzOQRL6a/LpsdhnkT9koyzxWNWR0ktqmDdjvn
	QTd7vaKkVDNzX5FmXi1wCMoGOjuulLCgMfM+BYhkd46zKvqsyirzxd1exNOU5cDMtAAq4xZg0L0
	xlazBh97MbMHj/N5FH9IKrJqbqk6hAuI9HMGB0utWz0/28l3ETraq5cuz6oiajXyXs9uZJllVXP
	17WiQL66/JiIkLitvKBEUkCIemNjo5lG90J+gJo/BmbK5WPeKTOANFRpj1w7zR/uIFxG3rQdqg+
	dH3I2DgVCHmZKELvjjZUF7xicTF9kY5ZRFddgtqmzgU3Ixxf005qyQifOQ==
X-Google-Smtp-Source: AGHT+IHsCJrvrpLcRIffYAawzOscxmizCgBym+tlwYIHRq5y95ApU7+cc9L1FjrkqtQjqo6o37Lhcw==
X-Received: by 2002:a17:902:db12:b0:224:c7c:7146 with SMTP id d9443c01a7336-22dc69f5e01mr134266915ad.6.1745898228207;
        Mon, 28 Apr 2025 20:43:48 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-309ef03bb7fsm9953249a91.9.2025.04.28.20.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 20:43:47 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 29 Apr 2025 11:42:27 +0800
Subject: [PATCH RESEND v6 03/21] drivers/perf: apple_m1: Support
 per-implementation event tables
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-apple-cpmu-v6-3-ed21815f0c3f@gmail.com>
References: <20250429-apple-cpmu-v6-0-ed21815f0c3f@gmail.com>
In-Reply-To: <20250429-apple-cpmu-v6-0-ed21815f0c3f@gmail.com>
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
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoEErjTX35Fv0E0u7EqQ2vfEHXscywKJuACvG2/
 SL3nVvFSSCJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaBBK4wAKCRABygi3psUI
 JDZnD/0RjQRenoIjFQor8g0BlsVEW7CRgD5aDQlBaqF65QKmTqkAgwKBAzziC7Ixrjm9/+MOMNX
 doPjI3XBJ4whqE6O6LZ2888SGla7RDLsm8xYdHZsm3MmiOnxZb28SILzJaXPQ3ebJUs4S9Kfn/9
 T3y8lq6DBAtqOits0gDllR4v80bfZy4raL8nGN0rgF0dA09N0KWI478JlxRx6sndo1IdSQ8shJm
 iXXIePzVhYuzf5GJVPteq6CDxMD6lfvqtIunfSdZemIS2LOGz5+J/6MUP1hODEXGbt4qpEW8Ep7
 O2JMcOh6oPdndD+fI1MOcgdQ7EkNJkUHbyDeRlhIuqYdSMyoheR7VdIln5IeaiJ5lO2JrpIR2z7
 nW+Z1wzMv70BEEM2sYKqQMYa6gn+JpRrlICLrxhT9bpUt7JeR2thocEsHIvkxxd+pC9UDmdc8kS
 Xz6K5JnBKKIH4VwBrSSIQycAw+7jZFiq/z8aKTs3v4SZ5gZF0Mpxv06ASuUh41oYApUzm5wo7cG
 pU7CP29JGA2lb8zclJ6u7WGgsSYeE0KOnFrJSwo+Xt/iKODva4RAVAkkj2dLMAdSfDPc+UwbDyI
 lVYC0L3ok2AJr/FJqg61t2Rn6gcfXyk/78VRAK5uv6JTabxZX7e3F3R/qgG9QV3d5KWvdevelrF
 NaU4omtk+ZuCqGA==
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

