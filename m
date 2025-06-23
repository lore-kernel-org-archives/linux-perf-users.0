Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD9F233722;
	Mon, 23 Jun 2025 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750671007; cv=none; b=aC2Zax5hq/AqYTaFMwLh23i7XjMH4iry9anJua36UBIOVFrAo+9/MKX3nYEPTyc8AohegFTbcZnlZcpC3/zPSSVZHp92LX+vwn/9LQQVv1dFnrHOJUMp8b38fuB1HTwU278NFkXPM4/D8cY9t7SB1vi0Z9e+7dMpte5x5uySy9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750671007; c=relaxed/simple;
	bh=3LnNlWutqRhBSK3TgebE+cPIHrDJlwHzxQajjnqK+bA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KHfx8WejLOOqXX/LJM1ltvo3TbSlqb0/7OnivbzHfND064UA86Llc26dt49g2d4emQCuwZNPyuxe2tZuGNSdkD3Xm1aCXsaKHRCoPY+frlNBc7RYOZ14YdqsSBqJvNLIvZ1/jOxooqB7L/bXAATGtdynNf3K0d+Tqw4CKYGo098=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Zh/vzDdM; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Zh/vzDdM"
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N91VaZ013223;
	Mon, 23 Jun 2025 11:29:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	HxYJdm+vIW2mkVXU2bP4ej7pG694JeHb3sv9IaD0GlM=; b=Zh/vzDdMFPiarDuj
	9VlLwmbUlKhvIXvJ+C5gC/Dqxg/moeDlyqc/tuzr4YUIT//o4Ad+SobW7iSqREDH
	GbBVMfwHtlMNNdqSj7tV4EH7fMsuuuhX7IroRoSA7RDhUqjO2gmNYNTPqRM+IaXx
	wknXBfoH7zwvb16Vamxfhboi5FzsCucqUlthwNWvAhD+n9gJAVMrXlcU+vlDVpIF
	4Sn7n8BfDx9nTF5lZ/rJn+1BgE4d/dt5jpbiJoqkYhaYbNbb7PjSMG+85LHb43kW
	Quq7hf1z9QR/cYjtOQ94g4949HSx0+oWLiDX8pkR85yxD+qt/B30ycXrqZPi4s5T
	ygTzIw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47dhvbevd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 11:29:52 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4420940047;
	Mon, 23 Jun 2025 11:28:34 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7D3AA5C3DD9;
	Mon, 23 Jun 2025 11:27:25 +0200 (CEST)
Received: from localhost (10.252.18.29) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:27:25 +0200
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Date: Mon, 23 Jun 2025 11:27:10 +0200
Subject: [PATCH 05/13] dt-bindings: perf: stm32: introduce DDRPERFM
 dt-bindings
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250623-ddrperfm-upstream-v1-5-7dffff168090@foss.st.com>
References: <20250623-ddrperfm-upstream-v1-0-7dffff168090@foss.st.com>
In-Reply-To: <20250623-ddrperfm-upstream-v1-0-7dffff168090@foss.st.com>
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
	<gabriel.fernandez@foss.st.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
X-Mailer: b4 0.15-dev-c25d1
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_02,2025-03-28_01

DDRPERFM is the DDR Performance Monitor embedded in STM32MPU SoC.
It allows to monitor DDR events that come from the DDR Controller
such as read or write events.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
---
 .../devicetree/bindings/perf/st,stm32-ddr-pmu.yaml | 93 ++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/Documentation/devicetree/bindings/perf/st,stm32-ddr-pmu.yaml b/Documentation/devicetree/bindings/perf/st,stm32-ddr-pmu.yaml
new file mode 100644
index 000000000000..35d34782865b
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/st,stm32-ddr-pmu.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/st,stm32-ddr-pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+maintainers:
+  - Clément Le Goffic <clement.legoffic@foss.st.com>
+
+title: STMicroelectronics STM32 DDR Performance Monitor (DDRPERFM)
+
+properties:
+  compatible:
+    enum:
+      - st,stm32mp131-ddr-pmu
+      - st,stm32mp151-ddr-pmu
+      - st,stm32mp251-ddr-pmu
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description: Reference clock for the DDR Performance Monitor
+    maxItems: 1
+
+  resets:
+    description: Reset control for the DDR Performance Monitor
+    maxItems: 1
+
+  access-controllers:
+    minItems: 1
+    maxItems: 2
+
+  st,dram-type:
+    description: |
+      This property is used to specify the type of DRAM memory connected to the
+      associated memory controller. It is required for the DDR Performance Monitor
+      to correctly interpret the performance data.
+      0 = LPDDR4,
+      1 = LPDDR3,
+      2 = DDR4,
+      3 = DDR3
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - st,stm32mp131-ddr-pmu
+              - st,stm32mp151-ddr-pmu
+    then:
+      required:
+        - clocks
+        - resets
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: st,stm32mp251-ddr-pmu
+    then:
+      required:
+        - access-controllers
+        - st,dram-type
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/stm32mp1-clks.h>
+    #include <dt-bindings/reset/stm32mp1-resets.h>
+
+    perf@5a007000 {
+        compatible = "st,stm32mp151-ddr-pmu";
+        reg = <0x5a007000 0x400>;
+        clocks = <&rcc DDRPERFM>;
+        resets = <&rcc DDRPERFM_R>;
+    };
+
+  - |
+    perf@48041000 {
+      compatible = "st,stm32mp251-ddr-pmu";
+      reg = <0x48041000 0x400>;
+      access-controllers = <&rcc 104>;
+      st,dram-type = <2>;
+    };

-- 
2.43.0

