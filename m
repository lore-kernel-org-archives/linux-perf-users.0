Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B522D8769
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Jul 2025 10:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751971263; cv=none; b=gPf8SQPgkUSxDqYEufOV1ToRhoslcJidedSQn5yKiqLuzfl3rCCWP04CfOFC+z//Vl9QvegTkY47XOKNxZXmbvzdhI32YcoglR7BrFG78kLkFT4jHbM1OH7lFsYobM/Mp47l7aI83zKi1NK0ncyzmZeYatnLDIPo35w40cmhFuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751971263; c=relaxed/simple;
	bh=1dTkMR7ivxCKPAG8IwLvcS5tHG1yew3jddWr45nGSSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=t/5PIYXKWha0wk5MiTbmPQArMQrUQeWMbxgK1PmxRPM3LC4tKgbrx+P2VcJFEMYZfARC+7/yWodwdVU4NOgqcnnBQ/Rbf4qzljSgFlUoOcIqTEZNOY75bZz9s2q7PzHNi3i+uQEwZLfiVc8o9dK7MSdsU72gLlQSsDnPjosKITc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Jsfx/fal; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Jsfx/fal"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250708104059epoutp021aa3585f1827441b7af45aed3496a07d~QQJQZaHKo3125031250epoutp02c
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Jul 2025 10:40:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250708104059epoutp021aa3585f1827441b7af45aed3496a07d~QQJQZaHKo3125031250epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751971259;
	bh=NYCyVQSEhyiNgRSZQjKeP4GdTZI8s/pFA0yDOkhv5d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jsfx/fallHOJRoEFYjX7BDKTtuakH/46HvCl6HlgiDIwz+1w3HH12cxX8zRYvkZZf
	 jxzVeqHx2MVBGGA4DxcZO1+8Otttm9mgxHPCd0izdGqo1UKUJT+2os47wNwmoB/+d6
	 pyNQt2yKpEm+osBqcnXQ5ZkVvPE0Qul2hiHLQ+ls=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250708104059epcas5p41d1793c5aeb434f28b17499ea46e9013~QQJP0qpLH1625116251epcas5p4r;
	Tue,  8 Jul 2025 10:40:59 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.175]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4bbyLx19t7z6B9m6; Tue,  8 Jul
	2025 10:40:57 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250708103237epcas5p1c4c5d7a5f43c0c88317e74d2f2458a1b~QQB8hGhe-2145121451epcas5p1G;
	Tue,  8 Jul 2025 10:32:37 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250708103234epsmtip1fd36b1a6f6019b1ba42e343ae39083bc~QQB54pvRQ1977519775epsmtip16;
	Tue,  8 Jul 2025 10:32:34 +0000 (GMT)
From: Vivek Yadav <vivek.2311@samsung.com>
To: pankaj.dubey@samsung.com, ravi.patel@samsung.com, shradha.t@samsung.com,
	mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, krzk@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, will@kernel.org,
	mark.rutland@arm.com, s.nawrocki@samsung.com, cw00.choi@samsung.com,
	alim.akhtar@samsung.com, linux-fsd@tesla.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Vivek
	Yadav <vivek.2311@samsung.com>
Subject: [PATCH 3/6] dt-bindings: perf: Add devicetree binding for custom
 PPMU
Date: Tue,  8 Jul 2025 16:02:05 +0530
Message-ID: <20250708103208.79444-4-vivek.2311@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708103208.79444-1-vivek.2311@samsung.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250708103237epcas5p1c4c5d7a5f43c0c88317e74d2f2458a1b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250708103237epcas5p1c4c5d7a5f43c0c88317e74d2f2458a1b
References: <20250708103208.79444-1-vivek.2311@samsung.com>
	<CGME20250708103237epcas5p1c4c5d7a5f43c0c88317e74d2f2458a1b@epcas5p1.samsung.com>

Add the dt-binding documentation for the Samsung specific
Platform Performance Monitoring Unit (PPMU) driver which provides
performance statistics for AXI bus masters such as MFC.

Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
Signed-off-by: Vivek Yadav <vivek.2311@samsung.com>
---
 .../bindings/perf/samsung,ppmu-v2.yaml        | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/samsung,ppmu-v2.yaml

diff --git a/Documentation/devicetree/bindings/perf/samsung,ppmu-v2.yaml b/Documentation/devicetree/bindings/perf/samsung,ppmu-v2.yaml
new file mode 100644
index 000000000000..d137d06b7034
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/samsung,ppmu-v2.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/samsung,ppmu-v2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung PPMU (Platform Performance Monitoring Unit)
+
+maintainers:
+  - Vivek Yadav <vivek.2311@samsung.com>
+  - Ravi Patel <ravi.patel@samsung.com>
+
+description:
+  PPMU (Platform Performance Monitoring Unit) provides performance statistics
+  such as bandwidth, read and write request, transactions count for AXI masters
+  like MFC.
+
+properties:
+  compatible:
+    const: samsung,ppmu-v2
+
+  reg:
+    maxItems: 1
+    description: Memory-mapped register address
+
+  clocks:
+    items:
+      - description: AXI bus clock
+      - description: Peripheral clock
+
+  clock-names:
+    items:
+      - const: aclk
+      - const: pclk
+
+  interrupts:
+    items:
+      - description: Overflow interrupt for Counters
+      - description: Conditional Interrupt Generation (CIG)
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/fsd-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    ppmu@12840000 {
+        compatible = "samsung,ppmu-v2";
+        reg = <0x12840000 0x1000>;
+        interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clock_mfc MFC_PPMU_MFCD0_IPCLKPORT_ACLK>,
+                 <&clock_mfc MFC_PPMU_MFCD0_IPCLKPORT_PCLK>;
+        clock-names = "aclk", "pclk";
+     };
-- 
2.49.0

