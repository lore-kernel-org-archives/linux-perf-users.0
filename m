Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794048547;
	b=22hrbWCpcG+lAasBd3+MO1luuUNHBltt2CIPutV4JJPBjajiW+ucMn1XP6x7IJjLP4OZ
	 WwMOzFNBBjctgl3VolF/9EXiJQpnuQ/QZk3qTNVlBYa4PjDxNesG5nJsxp/9GGt7F3tbw
	 O2Gzf7hgWxB6NiSKi0x3tbl0vxE+Co/CbRNiz93aSPK9EI4gVx2cgyoazvCkDh0CfORFp
	 A7CcyXv8n7HrR6UWrVTbOxks8Djx65Wm2kRFOHSSZ6hL6HUbXRt+mbzmDXBUKQ1SrYz4u
	 OJltDj2AWxmxXeI2g7sG0SkekyV5sy8eTuAtuUe8PubBZsROHyzHJxlRbxRyMfhfQcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048547;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=3PMCsQK05AlRim91/YY+Bi15JAZRNIaSE9DHKW3wYx0=;
	b=hQP6iCkskJkqWrrgHTUEqyWivmA/zEffh1UBZzw42QJ8pezn2qu9ToJngVlrtDAch3VV
	 OpdA60lzWVpWrPM3JbpvMO82LuDF/Ctc+WpNeTR52wrBUR8DqyD/LSkE+Lr/hAXgn+t9l
	 bPTGx+gRx++0ZtrtOsXzXjuPJzTonciqpOwEA4F78aq47PLSIot6UM+IApPpQhjGWvwK2
	 rc/pWstX/hJS5br1FxRjuNZv64FborBI99oKYvN6LmyRTrs5Rhwm8GjyEH4OjkvpnmzOX
	 icxS/5LHcli0AiF80dVjmTpLeuOXpNLCKxDdojKdtnDPjmjQRef3d2JEofRbA5OOerQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CmURGsCL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD525606A32E;
	Sat,  7 Nov 2026 10:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CmURGsCL
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794048546;
	b=uFicimo70ixX5Ihv/9xWwXF09LH2YG+Ge/VUmF4BZmX7PNZXFms7zQWlNrfTsXo0l8Z8
	 8AOakCWXiO2m917pqBaS+GW6DXZF+pnZ9T7AvwenL3tc8lpzDuR98tJHh++UaG+SC38G+
	 mii+YX11tJVWWoeZkKjTESl4GParZEI4zP/3AmSeZkR4e6s2ZCwNIWlT1pgfBvatpsuZe
	 /1DTkCh/FjRn3E34eFMWkcPlwp0be0XucLdfawpvhfNwWtCGoxIXYsBYZmS3vQCNTuxmE
	 oaPqKyc6jiEKp1oa3d3d+dhkjxAFYzhUjSLCbPQB7aOKSOpp8rAR8Y+5sr33+/dJjyw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794048546;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=3PMCsQK05AlRim91/YY+Bi15JAZRNIaSE9DHKW3wYx0=;
	b=KjQP1Coa52AiscimNmtLYYFX+2rZL9cvXRSzS0Ts+6xl/Ql+pQiG/D9vtYf9Z2XrD70O
	 euWrYrOBQ0NYm/W4ydTRrHV+yi7Dol70knKUTU0EHuUNsMjA0YbCVCTVNqxGahIUU+iGT
	 gmbHxPGYIKW/71Y7LZASqVIMH5Q0AcDv+EXgb/eIgus5QrJOmQ+Ol1j+yk8+HzNPUFE0Z
	 /iKpBMAnL/FTeQqZvp6BO//a1lnrC1Ucb+DWgvzNdXjgOn1gs3wcUk4AHEr2PTzwwcVfo
	 NfnFFGXmHcUltQfGx32uu7B4Ol7XoTIiW9n1Ev/MdzY1lU7Q6oRoykT+MqKOJe6izjg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 11D851F008A3;
	Sat,  7 Nov 2026 10:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048546;
	bh=3PMCsQK05AlRim91/YY+Bi15JAZRNIaSE9DHKW3wYx0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CmURGsCLpyJPrERxeo2NpAk4Wce+Sdc99iRQmrQbU+fbzTwMSY5n1V22IeX+C15YO
	 FzwLT9iVI5KEY0IhWweHS6+4R0OywCbagwE0LMnNZ8po8E8bhRDTgxGhO6IBWTanwv
	 SptVsFjPqLgJ/J7ZZ+9u+vdh2JuTK5FSu+cdutSLyLAwxhiksOKt+rf19Ab+IQIpp8
	 4fktSZHxQzPmebLZdSsgBJBJx53+qujKtJMBIs1pkY/E5sB8nHwy5leQJbKHtRkDjr
	 7RiIZk9WA8VsjEIYxyFZGrwQQwtaZug4YZMXwG70Pf3IpY866y8sRBfSAmDyyYdymQ
	 lfnk/j8vOlXmQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9773047B7A;
	Sat,  7 Nov 2026 10:49:04 +0000 (UTC)
From: Myria Sarvay via B4 Relay <devnull+myrialsarvay.gmail.com@kernel.org>
Date: Sat, 07 Nov 2026 21:48:50 +1100
Subject: [PATCH v2 03/15] drivers/perf: apple_m1: Support
 per-implementation event tables
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261107-m3-plus-pmu-events-v2-3-acf1e78da039@gmail.com>
References: <20261107-m3-plus-pmu-events-v2-0-acf1e78da039@gmail.com>
In-Reply-To: <20261107-m3-plus-pmu-events-v2-0-acf1e78da039@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, Yuvan Shen <yuvanshen09@gmail.com>, 
 Myria Sarvay <myrialsarvay@gmail.com>, Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8123;
 i=myrialsarvay@gmail.com; h=from:subject:message-id;
 bh=eMHUYqYykp/keWcDtxYjqK7aXWjY8rcp86183cAKPjA=;
 b=owJ4nJvAy8zAJRbk4iixYu2/l4yn1ZIYst4zSavXVIVyXZ9TVFm/ZWfMNZdKhhbmrb5dim2Kr
 jMO8UW2P+woZWEQ42KQFVNk0TdN057M1nCpdJnrFpg5rEwgQxi4OAVgIj8jGBlm3T7XuHfVxZ5J
 Dck633W0+uP8tS/JPXE+q3VKVmMpx0FDRoYbVYd9L7msqvCTdtSs7A09aMm6rreo+9/6LXWReTe
 mtXEAALBoRqQ=
X-Developer-Key: i=myrialsarvay@gmail.com; a=openpgp;
 fpr=2F35662B930680D275A645B452444118A8ADFEE9
X-Endpoint-Received: by B4 Relay for myrialsarvay@gmail.com/default with
 auth_id=1027
X-Original-From: Myria Sarvay <myrialsarvay@gmail.com>
Reply-To: myrialsarvay@gmail.com

From: Nick Chan <towinchenmi@gmail.com>

Use per-implementation event tables to allow supporting implementations
with a different list of events and event affinities.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
Co-developed-by: Myria Sarvay <myrialsarvay@gmail.com>
Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 113 ++++++++++++++++++++++++----------------
 1 file changed, 69 insertions(+), 44 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index de4026c63afd..2ff0c2e0b737 100644
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
@@ -167,7 +164,7 @@ static const u16 m1_pmu_event_affinity[M1_PMU_PERFCTR_LAST + 1] = {
 	[M1_PMU_PERFCTR_UNKNOWN_fd]				= ONLY_2_4_6,
 };
 
-static const unsigned m1_pmu_perf_map[PERF_COUNT_HW_MAX] = {
+static const unsigned int m1_pmu_perf_map[PERF_COUNT_HW_MAX] = {
 	PERF_MAP_ALL_UNSUPPORTED,
 	[PERF_COUNT_HW_CPU_CYCLES]		= M1_PMU_PERFCTR_CORE_ACTIVE_CYCLE,
 	[PERF_COUNT_HW_INSTRUCTIONS]		= M1_PMU_PERFCTR_INST_ALL,
@@ -486,11 +483,12 @@ static void m1_pmu_write_counter(struct perf_event *event, u64 value)
 	isb();
 }
 
-static int m1_pmu_get_event_idx(struct pmu_hw_events *cpuc,
-				struct perf_event *event)
+static int apple_pmu_get_event_idx(struct pmu_hw_events *cpuc,
+				   struct perf_event *event,
+				   const u16 event_affinities[])
 {
 	unsigned long evtype = event->hw.config_base & M1_PMU_CFG_EVENT;
-	unsigned long affinity = m1_pmu_event_affinity[evtype];
+	unsigned long affinity = event_affinities[evtype];
 	int idx;
 
 	/*
@@ -509,6 +507,12 @@ static int m1_pmu_get_event_idx(struct pmu_hw_events *cpuc,
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
@@ -536,44 +540,52 @@ static void m1_pmu_stop(struct arm_pmu *cpu_pmu)
 	__m1_pmu_set_mode(PMCR0_IMODE_OFF);
 }
 
+static int apple_pmu_map_event(struct perf_event *event,
+			       const unsigned int (*perf_map)[],
+			       unsigned int flags)
+{
+	event->hw.flags |= flags;
+	return armpmu_map_event(event, perf_map, NULL, M1_PMU_CFG_EVENT);
+}
+
+/*
+ * Apple PMU counters have been observed to be either 48 or
+ * 64 bits wide, depending on the SoC. However, the MSB is
+ * what triggers an overflow interrupt, so we advertise the
+ * counters as being 1-bit smaller than hardware so as to
+ * mimick ARM PMU behaviour
+ */
 static int m1_pmu_map_event(struct perf_event *event)
 {
-	/*
-	 * Although the counters are 48bit wide, bit 47 is what
-	 * triggers the overflow interrupt. Advertise the counters
-	 * being 47bit wide to mimick the behaviour of the ARM PMU.
-	 */
-	event->hw.flags |= ARMPMU_EVT_47BIT;
-	return armpmu_map_event(event, &m1_pmu_perf_map, NULL, M1_PMU_CFG_EVENT);
+	return apple_pmu_map_event(event, &m1_pmu_perf_map, ARMPMU_EVT_47BIT);
 }
 
 static int m2_pmu_map_event(struct perf_event *event)
 {
-	/*
-	 * Same deal as the above, except that M2 has 64bit counters.
-	 * Which, as far as we're concerned, actually means 63 bits.
-	 * Yes, this is getting awkward.
-	 */
-	event->hw.flags |= ARMPMU_EVT_63BIT;
-	return armpmu_map_event(event, &m1_pmu_perf_map, NULL, M1_PMU_CFG_EVENT);
+	return apple_pmu_map_event(event, &m1_pmu_perf_map, ARMPMU_EVT_63BIT);
 }
 
-static int m1_pmu_map_pmuv3_event(unsigned int eventsel)
+static int apple_pmu_map_pmuv3_event(unsigned int eventsel, const u16 pmceid_map[])
 {
-	u16 m1_event = HW_OP_UNSUPPORTED;
+	u16 apple_event = HW_OP_UNSUPPORTED;
 
 	if (eventsel < ARMV8_PMUV3_MAX_COMMON_EVENTS)
-		m1_event = m1_pmu_pmceid_map[eventsel];
+		apple_event = pmceid_map[eventsel];
 
-	return m1_event == HW_OP_UNSUPPORTED ? -EOPNOTSUPP : m1_event;
+	return apple_event == HW_OP_UNSUPPORTED ? -EOPNOTSUPP : apple_event;
 }
 
-static void m1_pmu_init_pmceid(struct arm_pmu *pmu)
+static int m1_pmu_map_pmuv3_event(unsigned int eventsel)
+{
+	return apple_pmu_map_pmuv3_event(eventsel, m1_pmu_pmceid_map);
+}
+
+static void apple_pmu_init_pmceid(struct arm_pmu *pmu)
 {
 	unsigned int event;
 
 	for (event = 0; event < ARMV8_PMUV3_MAX_COMMON_EVENTS; event++) {
-		if (m1_pmu_map_pmuv3_event(event) >= 0)
+		if (pmu->map_pmuv3_event(event) >= 0)
 			set_bit(event, pmu->pmceid_bitmap);
 	}
 }
@@ -616,33 +628,22 @@ static int m1_pmu_set_event_filter(struct hw_perf_event *event,
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
 
-	cpu_pmu->map_pmuv3_event  = m1_pmu_map_pmuv3_event;
-	m1_pmu_init_pmceid(cpu_pmu);
+	apple_pmu_init_pmceid(cpu_pmu);
 
 	bitmap_set(cpu_pmu->cntr_mask, 0, M1_PMU_NR_COUNTERS);
-	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] = &m1_pmu_format_attr_group;
 	return 0;
 }
@@ -651,25 +652,49 @@ static int m1_pmu_init(struct arm_pmu *cpu_pmu, u32 flags)
 static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_icestorm_pmu";
-	return m1_pmu_init(cpu_pmu, ARMPMU_EVT_47BIT);
+	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
+	cpu_pmu->map_event	  = m1_pmu_map_event;
+
+	cpu_pmu->map_pmuv3_event  = m1_pmu_map_pmuv3_event;
+
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
+	return apple_pmu_init(cpu_pmu);
 }
 
 static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_firestorm_pmu";
-	return m1_pmu_init(cpu_pmu, ARMPMU_EVT_47BIT);
+	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
+	cpu_pmu->map_event	  = m1_pmu_map_event;
+
+	cpu_pmu->map_pmuv3_event  = m1_pmu_map_pmuv3_event;
+
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
+	return apple_pmu_init(cpu_pmu);
 }
 
 static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_avalanche_pmu";
-	return m1_pmu_init(cpu_pmu, ARMPMU_EVT_63BIT);
+	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
+	cpu_pmu->map_event	  = m2_pmu_map_event;
+
+	cpu_pmu->map_pmuv3_event  = m1_pmu_map_pmuv3_event;
+
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
+	return apple_pmu_init(cpu_pmu);
 }
 
 static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
 {
 	cpu_pmu->name = "apple_blizzard_pmu";
-	return m1_pmu_init(cpu_pmu, ARMPMU_EVT_63BIT);
+	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
+	cpu_pmu->map_event	  = m2_pmu_map_event;
+
+	cpu_pmu->map_pmuv3_event  = m1_pmu_map_pmuv3_event;
+
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = &m1_pmu_events_attr_group;
+	return apple_pmu_init(cpu_pmu);
 }
 
 static const struct of_device_id m1_pmu_of_device_ids[] = {

-- 
2.55.0


