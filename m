Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793700890;
	b=cTDxprK/zHg0gT4XwByJ3/heqkyZlWrW5HPU9jtoe0Q5YOXDRgg8R8mjEIOBIy4YKJIB
	 AEeJ35SufzYoD+30R1ZjdyqCY7/p8Irv/36v0Ti0xBoYwL2wnL5WRRC7jk1rvewq0MXFk
	 uyyq/sjc7WeT+Pz6+UccP+w4FR+I3tb5AhW8TC7/+50SX8AvJkRWmAVpf7CgerXwSFkTa
	 NqKxYfnnzth4ZOR4BPngtD00ed9i9qCT17+e0N+8knTy7Nqnpf6TSR3AOEY0LEEkLJgTD
	 NnHpHjZNzWkHI29itpWtDaOzUiaAfedbvOyz3VDqya4rd6CTCGZOFBYbHq5UpeQHbsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700890;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wv7X9OB+tJtQXcTYUXFNcZDRr8m7y6aVE6GgvdGF+ZQ=;
	b=GRSfRschoPfuFrxy8P1tyMfbYNWZ7vU05X2HQ0ACtZISJYBBM4ErErjV2TwCZL/uOEMY
	 xCdN/3H/QXwiRY+Va9/5tucWbB951zoVMIC2dTxnhz2cIGWtswQgewxkQ4lW0+AymDtvc
	 OVAT+HEuBi+AjhVPC4CxcBPOA1JPutYddXEsUxlBTrFr5TA9BLuX1DNLVvw3ApXfkMxgE
	 EuDCzaFMkuPkvO4TS3seDJcfigKAJwA4TY0om/ul33M8CGv3Fbpf1JsclQigtnEGIrLS0
	 v/k70MRlx+M8km1+/ETxzcQJOa1OFurVHnhltCeLvq/T6kWJG110+2rAa2vpyKJ4c7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nOlSHBU7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30CD606A80B;
	Tue,  3 Nov 2026 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nOlSHBU7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793700889;
	b=ZvjJEFjDr37oohekZF+QG9ONayjj0BXHydUdKEDFpWy7LaNUs1wAX1CaMfCzO2LfQX6P
	 /TI3Jbqn3iMARULDS0w7iQQe/zKbNaiwAjXAykR3GQbwpDv23vjPvcYdb1vS6rh+ym9GL
	 NO5aOqaVhfy3fNtQ+/FbCKBVOsB6KbfzIDhodnSor1HYLUwPjZzgfLI7gxltXo83PwcpA
	 pnONdFoALN0Y9X4UgUZl60/IYW5X0ofJYwjpcbij+mPM3C+dYTZPf/p4vv9e4pnvuno8h
	 MB579M5tb2RMkx8ClyONg3Ah3d9uXP1FHAlL8kOp7MfiTyYhD+bhfTrgEaYdYGiE6oA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793700889;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wv7X9OB+tJtQXcTYUXFNcZDRr8m7y6aVE6GgvdGF+ZQ=;
	b=XuAN4QuaNcFXEESj6ayRTLzncwjbLRC2mHRzv9kUJidanUlUl56vfgTpwJRYFxupCRss
	 D4vLHnoI7mLdCoRbD0ADtwA26LXbv3SYdvOlX2mWK1L3z8k7OqWYFVk//N7UXcIRYHfUu
	 eDaZzNvBPFDyaDxjkvnCBq5e+Fo0w8T0dg9PPkKukUsoiGEAc0W7578P1CKjm6K/q2tZ5
	 P4DCyjYOzpY9liODJDYTdj37byMbaWJeIj8y5g/WIMl6ZlyCkrL7cJq0gVJlxtayE54N1
	 kPz+Bw0c5m8s5FaZ6hhWfcw7ivW90HEZAo0duBU1jSd9FFJytT7l7xExFjKlt6r1Hbw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3A3251F01578;
	Tue,  3 Nov 2026 10:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700889;
	bh=wv7X9OB+tJtQXcTYUXFNcZDRr8m7y6aVE6GgvdGF+ZQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=nOlSHBU742xyNWfajOpLETV+HcZmLtld6IJ7r6n/aMK0Fw410VlKqicMHKJjsD9o0
	 ZyKVIBK1XZ6AcmUZ3veJcwOBxzFVFpaHAkbYco+cpQa7vwT3Ck4m1oZRYRK9sLNtax
	 g7mFsjUXdocWpdGFVjSgAUZ6YQMcb4+MoGjnNThuiziaZSJrTPL1Z7rntBUFxO5QRi
	 AJNPCyojwx+u97D3HeugVX7AUO76ayz8fGK44CHZBxiX9KNN58lfmXfRnDXsaiii5G
	 b666Rk6asykU0e3cUwFGcEUfRhrQda4x280TjijzlX70tlmAJUdKXEglQHxppjNDKc
	 MFlNxz5N9Fsww==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id ACFD7468A1;
	Tue,  3 Nov 2026 10:14:47 +0000 (UTC)
From: Myria Sarvay via B4 Relay <devnull+myrialsarvay.gmail.com@kernel.org>
Date: Tue, 03 Nov 2026 21:14:39 +1100
Subject: [PATCH 04/13] drivers/perf: apple_m1: Support per-implementation
 event size
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-m3-plus-pmu-events-v1-4-a8eb6c1139fe@gmail.com>
References: <20261103-m3-plus-pmu-events-v1-0-a8eb6c1139fe@gmail.com>
In-Reply-To: <20261103-m3-plus-pmu-events-v1-0-a8eb6c1139fe@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, Yuvan Shen <yuvanshen09@gmail.com>, 
 Myria Sarvay <myrialsarvay@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7619;
 i=myrialsarvay@gmail.com; h=from:subject:message-id;
 bh=3VLwakg81b1QJKeUwL1GUzgfbLPqgWR7L2RWyZeVRzE=;
 b=owJ4nJvAy8zAJRbk4iixYu2/l4yn1ZIYsl5uEamNfrWpo08sK+px6Tll3s+Hns+99vWsE0N21
 Lx9+lzs97g7SlkYxLgYZMUUWfRN07QnszVcKl3mugVmDisTyBAGLk4BmEjXZEaGc3dXP5JJ/sP3
 fcf9SZmZzcUiBz4rfgief/OOws3Df98WeTEyNPyX1OpJd4rYez89a1/yh8MpjMIvshqv71d8mZ6
 +5Eo3EwAdZE5x
X-Developer-Key: i=myrialsarvay@gmail.com; a=openpgp;
 fpr=2F35662B930680D275A645B452444118A8ADFEE9
X-Endpoint-Received: by B4 Relay for myrialsarvay@gmail.com/default with
 auth_id=1027
X-Original-From: Myria Sarvay <myrialsarvay@gmail.com>
Reply-To: myrialsarvay@gmail.com
Content-Transfer-Encoding: 7bit

From: Myria Sarvay <myrialsarvay@gmail.com>

On M3 and later silicon, events are 16-bits instead of the 8-bits of
earlier implementations.

Co-developed-by: Yuvan Shen <yuvanshen09@gmail.com>
Signed-off-by: Yuvan Shen <yuvanshen09@gmail.com>
Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 54 ++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 2ff0c2e0b737..a14864263bf1 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -209,10 +209,13 @@ static const struct attribute_group m1_pmu_events_attr_group = {
 	.attrs = m1_pmu_event_attrs,
 };
 
-PMU_FORMAT_ATTR(event, "config:0-7");
+PMU_FORMAT_ATTR_SHOW(event_8b, "config:0-7");
+
+static struct device_attribute format_attr_event_8b =
+	__ATTR(event, 0444, event_8b_show, NULL);
 
 static struct attribute *m1_pmu_format_attrs[] = {
-	&format_attr_event.attr,
+	&format_attr_event_8b.attr,
 	NULL,
 };
 
@@ -373,7 +376,8 @@ static void __m1_pmu_configure_event_filter(unsigned int index, bool user,
 		sysreg_clear_set_s(SYS_IMP_APL_PMCR1_EL12, clear, set);
 }
 
-static void __m1_pmu_configure_eventsel(unsigned int index, u8 event)
+static void __apple_pmu_configure_eventsel(unsigned int index, u16 event,
+					   unsigned int size, u64 mask)
 {
 	u64 clear = 0, set = 0;
 	int shift;
@@ -388,14 +392,14 @@ static void __m1_pmu_configure_eventsel(unsigned int index, u8 event)
 	case 0 ... 1:
 		break;
 	case 2 ... 5:
-		shift = (index - 2) * 8;
-		clear |= (u64)0xff << shift;
+		shift = (index - 2) * size;
+		clear |= mask << shift;
 		set |= (u64)event << shift;
 		sysreg_clear_set_s(SYS_IMP_APL_PMESR0_EL1, clear, set);
 		break;
 	case 6 ... 9:
-		shift = (index - 6) * 8;
-		clear |= (u64)0xff << shift;
+		shift = (index - 6) * size;
+		clear |= mask << shift;
 		set |= (u64)event << shift;
 		sysreg_clear_set_s(SYS_IMP_APL_PMESR1_EL1, clear, set);
 		break;
@@ -412,7 +416,7 @@ static void m1_pmu_configure_counter(unsigned int index, unsigned long config_ba
 
 	__m1_pmu_configure_event_filter(index, user && host, kernel && host, true);
 	__m1_pmu_configure_event_filter(index, user && guest, kernel && guest, false);
-	__m1_pmu_configure_eventsel(index, evt);
+	__apple_pmu_configure_eventsel(index, evt, 8, M1_PMU_CFG_EVENT);
 }
 
 /* arm_pmu backend */
@@ -485,10 +489,8 @@ static void m1_pmu_write_counter(struct perf_event *event, u64 value)
 
 static int apple_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 				   struct perf_event *event,
-				   const u16 event_affinities[])
+				   unsigned long affinity)
 {
-	unsigned long evtype = event->hw.config_base & M1_PMU_CFG_EVENT;
-	unsigned long affinity = event_affinities[evtype];
 	int idx;
 
 	/*
@@ -510,7 +512,10 @@ static int apple_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 static int m1_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 				struct perf_event *event)
 {
-	return apple_pmu_get_event_idx(cpuc, event, m1_pmu_event_affinity);
+	unsigned long evtype = event->hw.config_base & M1_PMU_CFG_EVENT;
+	unsigned long affinity = m1_pmu_event_affinity[evtype];
+
+	return apple_pmu_get_event_idx(cpuc, event, affinity);
 }
 
 static void m1_pmu_clear_event_idx(struct pmu_hw_events *cpuc,
@@ -542,10 +547,10 @@ static void m1_pmu_stop(struct arm_pmu *cpu_pmu)
 
 static int apple_pmu_map_event(struct perf_event *event,
 			       const unsigned int (*perf_map)[],
-			       unsigned int flags)
+			       unsigned int flags, u32 mask)
 {
 	event->hw.flags |= flags;
-	return armpmu_map_event(event, perf_map, NULL, M1_PMU_CFG_EVENT);
+	return armpmu_map_event(event, perf_map, NULL, mask);
 }
 
 /*
@@ -557,12 +562,14 @@ static int apple_pmu_map_event(struct perf_event *event,
  */
 static int m1_pmu_map_event(struct perf_event *event)
 {
-	return apple_pmu_map_event(event, &m1_pmu_perf_map, ARMPMU_EVT_47BIT);
+	return apple_pmu_map_event(event, &m1_pmu_perf_map, ARMPMU_EVT_47BIT,
+				   M1_PMU_CFG_EVENT);
 }
 
 static int m2_pmu_map_event(struct perf_event *event)
 {
-	return apple_pmu_map_event(event, &m1_pmu_perf_map, ARMPMU_EVT_63BIT);
+	return apple_pmu_map_event(event, &m1_pmu_perf_map, ARMPMU_EVT_63BIT,
+				   M1_PMU_CFG_EVENT);
 }
 
 static int apple_pmu_map_pmuv3_event(unsigned int eventsel, const u16 pmceid_map[])
@@ -631,7 +638,6 @@ static int m1_pmu_set_event_filter(struct hw_perf_event *event,
 static int apple_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->handle_irq	  = m1_pmu_handle_irq;
-	cpu_pmu->enable		  = m1_pmu_enable_event;
 	cpu_pmu->disable	  = m1_pmu_disable_event;
 	cpu_pmu->read_counter	  = m1_pmu_read_counter;
 	cpu_pmu->write_counter	  = m1_pmu_write_counter;
@@ -639,12 +645,10 @@ static int apple_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->start		  = m1_pmu_start;
 	cpu_pmu->stop		  = m1_pmu_stop;
 	cpu_pmu->reset		  = m1_pmu_reset;
-	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;
 
 	apple_pmu_init_pmceid(cpu_pmu);
 
 	bitmap_set(cpu_pmu->cntr_mask, 0, M1_PMU_NR_COUNTERS);
-	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] = &m1_pmu_format_attr_group;
 	return 0;
 }
 
@@ -652,48 +656,60 @@ static int apple_pmu_init(struct arm_pmu *cpu_pmu)
 static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_icestorm_pmu";
+	cpu_pmu->enable		  = m1_pmu_enable_event;
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
+	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;
 
 	cpu_pmu->map_pmuv3_event  = m1_pmu_map_pmuv3_event;
 
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] = &m1_pmu_format_attr_group;
 	return apple_pmu_init(cpu_pmu);
 }
 
 static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_firestorm_pmu";
+	cpu_pmu->enable		  = m1_pmu_enable_event;
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
+	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;
 
 	cpu_pmu->map_pmuv3_event  = m1_pmu_map_pmuv3_event;
 
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] = &m1_pmu_format_attr_group;
 	return apple_pmu_init(cpu_pmu);
 }
 
 static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_avalanche_pmu";
+	cpu_pmu->enable		  = m1_pmu_enable_event;
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
+	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;
 
 	cpu_pmu->map_pmuv3_event  = m1_pmu_map_pmuv3_event;
 
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] = &m1_pmu_format_attr_group;
 	return apple_pmu_init(cpu_pmu);
 }
 
 static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_blizzard_pmu";
+	cpu_pmu->enable		  = m1_pmu_enable_event;
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
+	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;
 
 	cpu_pmu->map_pmuv3_event  = m1_pmu_map_pmuv3_event;
 
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] = &m1_pmu_format_attr_group;
 	return apple_pmu_init(cpu_pmu);
 }
 

-- 
2.56.0


