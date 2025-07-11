Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AED2EBBAB;
	Fri, 11 Jul 2025 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752245569; cv=none; b=PylhOmCmZYibLNaXgdCWDsIBilCwJ4YCy26TyULaTqNYWqy8WD/Di6kTwxLvZzo6OYq7yk/nj02akTXBZIQpq5v19rkqyK6ZsYW01lZ/1wMBhxOSU11G1lBQt0AP1nihSuao+WepmfFfVDnY6MZpwkyYcYsgKR6x9PxfZlKvaIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752245569; c=relaxed/simple;
	bh=2uEtFVwi+wdX8OeRQHgPRlqO3x1jsKN8u5e4kKD7Awk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LYbjTDr9+QgWilS6M6UR9pe2gCS2vsK9wxb+VS+PD1SOpAVmzmpvQ789pjCTK6eu/FE+J6nJn+LkjgQltnbX0ZpYABdvPa2Jk+7Wl6Cy4AZsEaB08C3kLteu0VPMPLBCMLuW4+3onBVP0ukwiiPWCZvGnc6BrecoaxGQ3GWxYBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=1ZURePmn; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="1ZURePmn"
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BEmNdp005606;
	Fri, 11 Jul 2025 16:52:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	W7lja2ibWXfiVo4eDJLx4tgeIggbs4JL9GjrFt29DoI=; b=1ZURePmnZeaZ54yK
	7qmrdu8IHz9Trtrfydl84qU/yad8TzwZo8Yu1i6zmBEN/lqgDxzUqdhHktrF2TOq
	g4IJ/U23sLhX829JkG/Fr01o2lG7OTSDCwXZSEkHzZSHijt0ajgjyyrA9ScArOss
	rpMRpWAKiTFhCh+xCIIV8E2nU8eLlMLVFw/VgOSnlQkxozgC1OTRCqR5UnlP7apb
	UgqYdmnwViGtsXNaHehCVbXxwIoPRbUmD9wZkalzde+fuVWLEZZj43Z9WjSwu5Z5
	4R44KDUC+kVd/Tkf2Nd8awLDK11jnA2Re/cXYB2C88sv8HWkuS+290MPCE6pQ1a3
	wMwbDA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47ptxjpx0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 16:52:34 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D01C940050;
	Fri, 11 Jul 2025 16:51:18 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7C16BB55584;
	Fri, 11 Jul 2025 16:49:21 +0200 (CEST)
Received: from localhost (10.252.16.187) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 16:49:21 +0200
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Date: Fri, 11 Jul 2025 16:49:02 +0200
Subject: [PATCH v2 10/16] Documentation: perf: stm32: add ddrperfm support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250711-ddrperfm-upstream-v2-10-cdece720348f@foss.st.com>
References: <20250711-ddrperfm-upstream-v2-0-cdece720348f@foss.st.com>
In-Reply-To: <20250711-ddrperfm-upstream-v2-0-cdece720348f@foss.st.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Gatien Chevallier
	<gatien.chevallier@foss.st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Gabriel Fernandez
	<gabriel.fernandez@foss.st.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Le
 Goffic <legoffic.clement@gmail.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
X-Mailer: b4 0.15-dev-7616d
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01

The DDRPERFM is the DDR Performance Monitor embedded in STM32MPU SoC.

This documentation introduces the DDRPERFM, the stm32-ddr-pmu driver
supporting it and how to use it with the perf tool.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
---
 Documentation/admin-guide/perf/index.rst         |  1 +
 Documentation/admin-guide/perf/stm32-ddr-pmu.rst | 86 ++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index 072b510385c4..33aedc4ee5c3 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -29,3 +29,4 @@ Performance monitor support
    cxl
    ampere_cspmu
    mrvl-pem-pmu
+   stm32-ddr-pmu
diff --git a/Documentation/admin-guide/perf/stm32-ddr-pmu.rst b/Documentation/admin-guide/perf/stm32-ddr-pmu.rst
new file mode 100644
index 000000000000..5b02bf44dd7a
--- /dev/null
+++ b/Documentation/admin-guide/perf/stm32-ddr-pmu.rst
@@ -0,0 +1,86 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================================
+STM32 DDR Performance Monitor (DDRPERFM)
+========================================
+
+The DDRPERFM is the DDR Performance Monitor embedded in STM32MPU SoC.
+The DDR controller provides events to DDRPERFM, once selected they are counted in the DDRPERFM
+peripheral.
+
+In MP1 family, the DDRPERFM is able to count 4 different events at the same time.
+However, the 4 events must belong to the same set.
+One hardware counter is dedicated to the time counter, `time_cnt`.
+
+In MP2 family, the DDRPERFM is able to select between 44 different DDR events.
+As for MP1, there is a dedicated hardware counter for the time.
+It is incremented every 4 DDR clock cycles.
+All the other counters can be freely allocated to count any other DDR event.
+
+The stm32-ddr-pmu driver relies on the perf PMU framework to expose the counters via sysfs:
+
+On MP1:
+
+    .. code-block:: bash
+
+        $ ls /sys/bus/event_source/devices/stm32_ddr_pmu/events/
+        cactive_ddrc                 perf_lpr_req_with_no_credit  perf_op_is_wr
+        ctl_idle                     perf_lpr_xact_when_critical  perf_selfresh_mode
+        dfi_lp_req                   perf_op_is_activate          perf_wr_xact_when_critical
+        dfi_lp_req_cpy               perf_op_is_enter_powerdown   time_cnt
+        perf_hpr_req_with_no_credit  perf_op_is_rd
+        perf_hpr_xact_when_critical  perf_op_is_refresh
+
+On MP2:
+
+    .. code-block:: bash
+
+        $ ls /sys/bus/event_source/devices/stm32_ddr_pmu/events/
+        dfi_is_act       perf_hpr_req_with_nocredit   perf_op_is_spec_ref
+        dfi_is_mpc       perf_hpr_xact_when_critical  perf_op_is_wr
+        dfi_is_mrr       perf_lpr_req_with_nocredit   perf_op_is_zqcal
+        dfi_is_mrw       perf_lpr_xact_when_critical  perf_rank
+        dfi_is_mwr       perf_op_is_act               perf_raw_hazard
+        dfi_is_mwra      perf_op_is_crit_ref          perf_rdwr_transitions
+        dfi_is_preab     perf_op_is_enter_powdn       perf_read_bypass
+        dfi_is_prepb     perf_op_is_enter_selfref     perf_war_hazard
+        dfi_is_rd        perf_op_is_mwr               perf_waw_hazard
+        dfi_is_rda       perf_op_is_pre               perf_window_limit_reached_rd
+        dfi_is_refab     perf_op_is_pre_for_others    perf_window_limit_reached_wr
+        dfi_is_refpb     perf_op_is_pre_for_rdwr      perf_wr_xact_when_critical
+        dfi_is_wr        perf_op_is_rd                time_cnt
+        dfi_is_wra       perf_op_is_rd_activate
+        perf_act_bypass  perf_op_is_ref
+
+
+The perf PMU framework is usually invoked via the 'perf stat' tool.
+
+
+Example:
+
+    .. code-block:: bash
+
+        $ perf stat --timeout 60000 -e stm32_ddr_pmu/dfi_is_act/,\
+        > stm32_ddr_pmu/dfi_is_rd/,\
+        > stm32_ddr_pmu/dfi_is_wr/,\
+        > stm32_ddr_pmu/dfi_is_refab/,\
+        > stm32_ddr_pmu/dfi_is_mrw/,\
+        > stm32_ddr_pmu/dfi_is_rda/,\
+        > stm32_ddr_pmu/dfi_is_wra/,\
+        > stm32_ddr_pmu/dfi_is_mrr/,\
+        > stm32_ddr_pmu/time_cnt/ \
+        > -a sleep 5
+
+         Performance counter stats for 'system wide':
+
+                    481025      stm32_ddr_pmu/dfi_is_act/
+                    732166      stm32_ddr_pmu/dfi_is_rd/
+                    144926      stm32_ddr_pmu/dfi_is_wr/
+                    644154      stm32_ddr_pmu/dfi_is_refab/
+                         0      stm32_ddr_pmu/dfi_is_mrw/
+                         0      stm32_ddr_pmu/dfi_is_rda/
+                         0      stm32_ddr_pmu/dfi_is_wra/
+                         0      stm32_ddr_pmu/dfi_is_mrr/
+                 752347686      stm32_ddr_pmu/time_cnt/
+
+               5.014910750 seconds time elapsed

-- 
2.43.0

