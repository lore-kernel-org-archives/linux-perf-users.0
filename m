Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE5A2E7BC1;
	Wed, 23 Jul 2025 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753276165; cv=none; b=U8Fo/A57FLK7nmkLbRWkT8p4LKMCpBNgUsciNo01hyHv9lH3ZnG5nZvPY78PFu6aNbECtV0PLndSIhoifuZYA30G+S+/xEPIWkMxNsfMsYWAro4TDmWnQc/mo/KxrDAGmEGnP/C57KwnPnajM6yQ1mr6XAdFjfIrVGkSYV8047E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753276165; c=relaxed/simple;
	bh=qLp7x+1iOy6z4yKY1hzvF+ySO7F6MSeGwmvCeWH+WtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QoGs7R+LXJYeqU3MxwOhZzJHsxGE0Uz8zG0W+eqJ/K+qYd0o6znMvT5fJjnI5tZQ0H/VZ5em3K6fyFS14bYxksQqvT3R1ioA8PiQDxNF31Mj2S2NXglkCCwBAFn21XeXFF6ZdQjZhu78bxFsbkTffBmvIazhotRsXCdlw/jrTz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ftNEXCq7; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ftNEXCq7"
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NCUmt5029713;
	Wed, 23 Jul 2025 15:09:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	h2vbpD9Rb+pymb7cfqkvPDG01Wz47SdoEnVS+OH4IIM=; b=ftNEXCq73SmVFhKw
	LbhkRGU5I+mvxMMxdg8eHHu/8JgolmiTG9/ACynVxrPoHCVgrCezYIGVqpLmZ9ok
	ZH84vc0Kj8F2YLE5PQhDTeXdodWhFO50XhcvsIDp6z4z3InQcTenbKay6kY1bdfm
	7l2wjr8mmHkI7a8XVlpMa48M0xexiDRy8VAz1NtlfDsEdZM9wi5aAUOKudyp6cjW
	CYY1Oucq4w6S25XiUtGRsUPzWBeWRv8JePuJybqrbs083veW029TN8t/yCGf46Mu
	u/6ojd9mxtp6gJpsZ/Snp4PIfZUDFnlsc5fEs6NP2bhlzRzXu8dyXgXVhDLhLPZx
	/f5vxA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 480mx4s4j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 15:09:05 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 78DBF40047;
	Wed, 23 Jul 2025 15:07:29 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BC4DC799881;
	Wed, 23 Jul 2025 15:06:06 +0200 (CEST)
Received: from localhost (10.48.86.185) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 15:06:06 +0200
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Date: Wed, 23 Jul 2025 15:05:49 +0200
Subject: [PATCH v4 05/20] dt-bindings: memory: factorise LPDDR props into
 SDRAM props
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250723-ddrperfm-upstream-v4-5-1aa53ca319f4@foss.st.com>
References: <20250723-ddrperfm-upstream-v4-0-1aa53ca319f4@foss.st.com>
In-Reply-To: <20250723-ddrperfm-upstream-v4-0-1aa53ca319f4@foss.st.com>
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
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01

LPDDR and DDR bindings are SDRAM types and are likely to share the same
properties (at least for density, io-width and reg).
To avoid bindings duplication, factorise the properties.

The compatible description has been updated because the MR (Mode
registers) used to get manufacturer ID and revision ID are not present
in case of DDR.
Those information should be in a SPD (Serial Presence Detect) EEPROM in
case of DIMM module or are known in case of soldered memory chips as
they are in the datasheet of the memory chips.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
---
 .../memory-controllers/ddr/jedec,lpddr-props.yaml  | 74 -----------------
 .../memory-controllers/ddr/jedec,lpddr2.yaml       |  2 +-
 .../memory-controllers/ddr/jedec,lpddr3.yaml       |  2 +-
 .../memory-controllers/ddr/jedec,lpddr4.yaml       |  2 +-
 .../memory-controllers/ddr/jedec,lpddr5.yaml       |  2 +-
 .../memory-controllers/ddr/jedec,sdram-props.yaml  | 92 ++++++++++++++++++++++
 6 files changed, 96 insertions(+), 78 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
deleted file mode 100644
index 30267ce70124..000000000000
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
+++ /dev/null
@@ -1,74 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,lpddr-props.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Common properties for LPDDR types
-
-description:
-  Different LPDDR types generally use the same properties and only differ in the
-  range of legal values for each. This file defines the common parts that can be
-  reused for each type. Nodes using this schema should generally be nested under
-  an LPDDR channel node.
-
-maintainers:
-  - Krzysztof Kozlowski <krzk@kernel.org>
-
-properties:
-  compatible:
-    description:
-      Compatible strings can be either explicit vendor names and part numbers
-      (e.g. elpida,ECB240ABACN), or generated strings of the form
-      lpddrX-YY,ZZZZ where X is the LPDDR version, YY is the manufacturer ID
-      (from MR5) and ZZZZ is the revision ID (from MR6 and MR7). Both IDs are
-      formatted in lower case hexadecimal representation with leading zeroes.
-      The latter form can be useful when LPDDR nodes are created at runtime by
-      boot firmware that doesn't have access to static part number information.
-
-  reg:
-    description:
-      The rank number of this LPDDR rank when used as a subnode to an LPDDR
-      channel.
-    minimum: 0
-    maximum: 3
-
-  revision-id:
-    $ref: /schemas/types.yaml#/definitions/uint32-array
-    description:
-      Revision IDs read from Mode Register 6 and 7. One byte per uint32 cell (i.e. <MR6 MR7>).
-    maxItems: 2
-    items:
-      minimum: 0
-      maximum: 255
-
-  density:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description:
-      Density in megabits of SDRAM chip. Decoded from Mode Register 8.
-    enum:
-      - 64
-      - 128
-      - 256
-      - 512
-      - 1024
-      - 2048
-      - 3072
-      - 4096
-      - 6144
-      - 8192
-      - 12288
-      - 16384
-      - 24576
-      - 32768
-
-  io-width:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description:
-      IO bus width in bits of SDRAM chip. Decoded from Mode Register 8.
-    enum:
-      - 8
-      - 16
-      - 32
-
-additionalProperties: true
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
index a237bc259273..704bbc562528 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
 
 allOf:
-  - $ref: jedec,lpddr-props.yaml#
+  - $ref: jedec,sdram-props.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
index e328a1195ba6..0d28df3d2bfa 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
 
 allOf:
-  - $ref: jedec,lpddr-props.yaml#
+  - $ref: jedec,sdram-props.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml
index a078892fecee..65aa07861453 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
 
 allOf:
-  - $ref: jedec,lpddr-props.yaml#
+  - $ref: jedec,sdram-props.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml
index e441dac5f154..cf5d5a8e94b3 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
 
 allOf:
-  - $ref: jedec,lpddr-props.yaml#
+  - $ref: jedec,sdram-props.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-props.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-props.yaml
new file mode 100644
index 000000000000..0838ee092255
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-props.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,sdram-props.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common properties for SDRAM types
+
+description:
+  Different SDRAM types generally use the same properties and only differ in the
+  range of legal values for each. This file defines the common parts that can be
+  reused for each type. Nodes using this schema should generally be nested under
+  a SDRAM channel node.
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+properties:
+  compatible:
+    description: |
+      Compatible strings can be either explicit vendor names and part numbers
+      (e.g. elpida,ECB240ABACN), or generated strings of the form
+      (lp)?ddrX-Y,Z where X, Y and Z are in lower case hexadecimal with leading
+      zeroes and :
+        - X is the SDRAM version (2, 3, 4, etc.)
+        - for LPDDR :
+          - Y is the manufacturer ID (from MR5), 2 bytes
+          - Z is the revision ID (from MR6 and MR7), 4 bytes
+        - for DDR4 with SPD, according to JEDEC SPD4.1.2.L-6 :
+          - Y is the manufacturer ID, 2 bytes, from bytes 320 and 321
+          - Z is the revision ID, 1 byte, from byte 349
+      The latter form can be useful when SDRAM nodes are created at runtime by
+      boot firmware that doesn't have access to static part number information.
+      The former form is useful when the SDRAM vendor and part number are
+      known, such as when the SDRAM is soldered on the board.
+
+  reg:
+    description:
+      The rank number of this memory rank when used as a subnode to an memory
+      channel.
+    minimum: 0
+    maximum: 3
+
+  revision-id:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      SDRAM revision ID:
+        - LPDDR SDRAM, decoded from Mode Register 6 and 7.
+        - DDR4 SDRAM, decoded from the SPD from bytes 349 according to
+          JEDEC SPD4.1.2.L-6.
+      One byte per uint32 cell (i.e. <MR6 MR7>).
+    maxItems: 2
+    items:
+      minimum: 0
+      maximum: 255
+
+  density:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Density of SDRAM chip in megabits:
+        - LPDDR SDRAM, decoded from Mode Register 8.
+        - DDR4 SDRAM, decoded from the SPD from bytes 322 to 325 according to
+          JEDEC SPD4.1.2.L-6.
+    enum:
+      - 64
+      - 128
+      - 256
+      - 512
+      - 1024
+      - 2048
+      - 3072
+      - 4096
+      - 6144
+      - 8192
+      - 12288
+      - 16384
+      - 24576
+      - 32768
+
+  io-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      IO bus width in bits of SDRAM chip:
+        - LPDDR SDRAM, decoded from Mode Register 8.
+        - DDR4 SDRAM with, decoded from the SPD from bits 2~0 of byte 12
+          according to JEDEC SPD4.1.2.L-6.
+    enum:
+      - 8
+      - 16
+      - 32
+
+additionalProperties: true

-- 
2.43.0

