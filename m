Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165602EB5D5;
	Tue, 22 Jul 2025 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193223; cv=none; b=XveQuBOFrtqyAs/vzU3MyX003ag29IUUgLweNYSnSZMeg+kxTW4FDAHvYbU3TH+KRHtlMVsl5OJiiwbN1YcQGxn1W4y9tTD2AN6cnh81Z7ube3ocTlnTR+QbO+XXLAPBskegMrH6Cm8g704QYI1nmmIMOOh36ASLVkJAgZqpkt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193223; c=relaxed/simple;
	bh=IJN+hzknQrvfMsfRdevhy9aScGLwuXIEUD6UONHUvTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FIHj3J6Fk4dAYQ1xImkyltkZgWUAlU1SRuyFkVfl7+d3eaG4B7/FnUOeKXjp5EkxpAVYLQq1dnhVl+9DhTaoe4NTBTTQaIUfOfi6kH5IeeUED9SJTlijOFPbkdEKChOmoCxWRUVAVwyW0CSDAHSk/dVMw4WMz+lV6KRKSk3Czj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=KGVgcXTr; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="KGVgcXTr"
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MDp9CT023321;
	Tue, 22 Jul 2025 16:06:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	Dzel1SQ7Aw9QbVnKaZahBU4awr4IRT5i98pBcRRcA0E=; b=KGVgcXTroxoci5yM
	4elqOr8q6WdZvV928qCfrE9xV5NjBiEE/LkA4TdiuEIpxhSz/cvhw/CZY22tMoBp
	+gG71HQw8zlrz1JvDb7Avg+UU66t6Ejo6o1jBROLFygqsrzCyWxnFHXVG/UJLzdW
	Qgi6e96r7BUJD3vOw0hOohbSCG7KrIxMuTaciHfQajb5avERAj7Ah3NlT4jhLst8
	NiAkeEQ4f9+geJvP8JAt2o3W5RgfP7TEQmsClx7zLWDKDNbRQmmxWSUh7jKmtqdA
	+8xlhqHlcPKjCd+Kq2G7299w54KP7JJX/i5J+hQwvkUBRUFmg7caBSKobMlTN8mc
	wooqPA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4802q26j67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 16:06:44 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1F8134004F;
	Tue, 22 Jul 2025 16:05:15 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A79077A31F8;
	Tue, 22 Jul 2025 16:03:57 +0200 (CEST)
Received: from localhost (10.48.86.185) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 16:03:57 +0200
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Date: Tue, 22 Jul 2025 16:03:28 +0200
Subject: [PATCH v3 11/19] dt-bindings: perf: stm32: introduce DDRPERFM
 dt-bindings
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250722-ddrperfm-upstream-v3-11-7b7a4f3dc8a0@foss.st.com>
References: <20250722-ddrperfm-upstream-v3-0-7b7a4f3dc8a0@foss.st.com>
In-Reply-To: <20250722-ddrperfm-upstream-v3-0-7b7a4f3dc8a0@foss.st.com>
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
 Goffic <legoffic.clement@gmail.com>,
        Julius Werner <jwerner@chromium.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
X-Mailer: b4 0.15-dev-8018a
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01

DDRPERFM is the DDR Performance Monitor embedded in STM32MPU SoC.
It allows to monitor DDR events that come from the DDR Controller
such as read or write events.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
---
 .../devicetree/bindings/perf/st,stm32-ddr-pmu.yaml | 94 ++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/Documentation/devicetree/bindings/perf/st,stm32-ddr-pmu.yaml b/Documentation/devicetree/bindings/perf/st,stm32-ddr-pmu.yaml
new file mode 100644
index 000000000000..34e1bba65f04
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/st,stm32-ddr-pmu.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/st,stm32-ddr-pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+maintainers:
+  - Clément Le Goffic <legoffic.clement@gmail.com>
+
+title: STMicroelectronics STM32 DDR Performance Monitor (DDRPERFM)
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: st,stm32mp131-ddr-pmu
+      - items:
+          - enum:
+              - st,stm32mp151-ddr-pmu
+          - const: st,stm32mp131-ddr-pmu
+      - items:
+          - const: st,stm32mp251-ddr-pmu
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  access-controllers:
+    minItems: 1
+    maxItems: 2
+
+  memory-channel:
+    description:
+      The memory channel this DDRPERFM is attached to.
+    $ref: /schemas/types.yaml#/definitions/phandle
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
+            const: st,stm32mp131-ddr-pmu
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
+        - memory-channel
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/stm32mp1-clks.h>
+    #include <dt-bindings/reset/stm32mp1-resets.h>
+
+    perf@5a007000 {
+        compatible = "st,stm32mp151-ddr-pmu", "st,stm32mp131-ddr-pmu";
+        reg = <0x5a007000 0x400>;
+        clocks = <&rcc DDRPERFM>;
+        resets = <&rcc DDRPERFM_R>;
+    };
+
+  - |
+    ddr_channel: ddr3-channel {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "jedec,ddr3-channel";
+        io-width = <16>;
+    };
+
+    perf@48041000 {
+      compatible = "st,stm32mp251-ddr-pmu";
+      reg = <0x48041000 0x400>;
+      access-controllers = <&rcc 104>;
+      memory-channel = <&ddr_channel>;
+    };

-- 
2.43.0

