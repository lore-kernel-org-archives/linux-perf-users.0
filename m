Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25932FDC35;
	Tue, 12 Aug 2025 18:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022465; cv=none; b=qIeI5HlXknh7EA9ziKnaitoipcrTOcRQqkPkbVnDHWd7d515xfAoXoMuwINbzN+XK7X2CgVdgKX5bxppzftTyWw0E1m6XuOce2MNeFD1pCOsuu3Q9ScYaGcpdWGD6qgsclu+juYFiV9bFQBbhgMco5siehb9PoN2q4RnddfxbGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022465; c=relaxed/simple;
	bh=cbioamJT3IVDLAVzUrO/mAFSoEzHiRSuAKFCjOj6Q68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f1hXg7mceuqL+8moamCTFUoFC/cAJzZqyx09CuUxyZ5q6eqcTsULZUQuxjzL7/dN97gEEe+cS2xxTB1lgwRXvvlu+tbEBOTX/0Sf6TgAfmQ2/8L7oHW9IXI1kbzVHL8aHQeqMYBXsRpUnSFEpCs9g451jk/l+SgHhQvwdCx0Thc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=el8NBOBZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="el8NBOBZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FF7C4CEF0;
	Tue, 12 Aug 2025 18:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755022464;
	bh=cbioamJT3IVDLAVzUrO/mAFSoEzHiRSuAKFCjOj6Q68=;
	h=From:To:Cc:Subject:Date:From;
	b=el8NBOBZ5qUsm6x1GnjGe+Tz6n7q4AacW6lD4SzxnzA0emsLs8nRmHK3BR5hp0dkb
	 IU87dsNWPyHxr4d0Gqa0O1K5wZgjBzP4KcNttr7hrLxoDF2VTs3kT25csHusI1LTwl
	 +UQHV/YL5UExdDzQJBk5REsd4H76EiMQ6Wna9fEJzilTvbENXbSlhS7j7Dh7mg+uF3
	 Zm4cR4V8eM66HRvXvX5jIu+rAMXa8LuXdVMGVy/IUklkgViwR3OY24SD+3ezvTP86o
	 M/tuF95P/6zzUWx9s2S6Vm+T/PoNBjZhiNhLRDqe5dQoD2njFydoe6zKtVycOKE7id
	 CiNnRBBHJ+sfw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Tai Nguyen <ttnguyen@apm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: perf: Convert apm,xgene-pmu to DT schema
Date: Tue, 12 Aug 2025 13:14:20 -0500
Message-ID: <20250812181422.68286-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Applied Micro X-Gene PMU binding to DT schema format. It is
a straightforward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/perf/apm,xgene-pmu.yaml          | 142 ++++++++++++++++++
 .../bindings/perf/apm-xgene-pmu.txt           | 112 --------------
 2 files changed, 142 insertions(+), 112 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/perf/apm,xgene-pmu.yaml
 delete mode 100644 Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt

diff --git a/Documentation/devicetree/bindings/perf/apm,xgene-pmu.yaml b/Documentation/devicetree/bindings/perf/apm,xgene-pmu.yaml
new file mode 100644
index 000000000000..01f0373eac7d
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/apm,xgene-pmu.yaml
@@ -0,0 +1,142 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/apm,xgene-pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: APM X-Gene SoC PMU
+
+maintainers:
+  - Tai Nguyen <ttnguyen@apm.com>
+
+description: |
+  This is APM X-Gene SoC PMU (Performance Monitoring Unit) module.
+  The following PMU devices are supported:
+
+    L3C            - L3 cache controller
+    IOB            - IO bridge
+    MCB            - Memory controller bridge
+    MC             - Memory controller
+
+properties:
+  compatible:
+    enum:
+      - apm,xgene-pmu
+      - apm,xgene-pmu-v2
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+  ranges: true
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  regmap-csw:
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  regmap-mcba:
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  regmap-mcbb:
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - regmap-csw
+  - regmap-mcba
+  - regmap-mcbb
+  - reg
+  - interrupts
+
+additionalProperties:
+  type: object
+  additionalProperties: false
+
+  properties:
+    compatible:
+      enum:
+        - apm,xgene-pmu-l3c
+        - apm,xgene-pmu-iob
+        - apm,xgene-pmu-mcb
+        - apm,xgene-pmu-mc
+
+    reg:
+      maxItems: 1
+
+    enable-bit-index:
+      description:
+        Specifies which bit enables the associated resource in MCB or MC subnodes.
+      $ref: /schemas/types.yaml#/definitions/uint32
+      maximum: 31
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pmu@78810000 {
+            compatible = "apm,xgene-pmu-v2";
+            reg = <0x0 0x78810000 0x0 0x1000>;
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges;
+            regmap-csw = <&csw>;
+            regmap-mcba = <&mcba>;
+            regmap-mcbb = <&mcbb>;
+            interrupts = <0x0 0x22 0x4>;
+
+            pmul3c@7e610000 {
+                compatible = "apm,xgene-pmu-l3c";
+                reg = <0x0 0x7e610000 0x0 0x1000>;
+            };
+
+            pmuiob@7e940000 {
+                compatible = "apm,xgene-pmu-iob";
+                reg = <0x0 0x7e940000 0x0 0x1000>;
+            };
+
+            pmucmcb@7e710000 {
+                compatible = "apm,xgene-pmu-mcb";
+                reg = <0x0 0x7e710000 0x0 0x1000>;
+                enable-bit-index = <0>;
+            };
+
+            pmucmcb@7e730000 {
+                compatible = "apm,xgene-pmu-mcb";
+                reg = <0x0 0x7e730000 0x0 0x1000>;
+                enable-bit-index = <1>;
+            };
+
+            pmucmc@7e810000 {
+                compatible = "apm,xgene-pmu-mc";
+                reg = <0x0 0x7e810000 0x0 0x1000>;
+                enable-bit-index = <0>;
+            };
+
+            pmucmc@7e850000 {
+                compatible = "apm,xgene-pmu-mc";
+                reg = <0x0 0x7e850000 0x0 0x1000>;
+                enable-bit-index = <1>;
+            };
+
+            pmucmc@7e890000 {
+                compatible = "apm,xgene-pmu-mc";
+                reg = <0x0 0x7e890000 0x0 0x1000>;
+                enable-bit-index = <2>;
+            };
+
+            pmucmc@7e8d0000 {
+                compatible = "apm,xgene-pmu-mc";
+                reg = <0x0 0x7e8d0000 0x0 0x1000>;
+                enable-bit-index = <3>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt b/Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt
deleted file mode 100644
index afb11cf693c0..000000000000
--- a/Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt
+++ /dev/null
@@ -1,112 +0,0 @@
-* APM X-Gene SoC PMU bindings
-
-This is APM X-Gene SoC PMU (Performance Monitoring Unit) module.
-The following PMU devices are supported:
-
-  L3C			- L3 cache controller
-  IOB			- IO bridge
-  MCB			- Memory controller bridge
-  MC			- Memory controller
-
-The following section describes the SoC PMU DT node binding.
-
-Required properties:
-- compatible		: Shall be "apm,xgene-pmu" for revision 1 or
-                          "apm,xgene-pmu-v2" for revision 2.
-- regmap-csw		: Regmap of the CPU switch fabric (CSW) resource.
-- regmap-mcba		: Regmap of the MCB-A (memory bridge) resource.
-- regmap-mcbb		: Regmap of the MCB-B (memory bridge) resource.
-- reg			: First resource shall be the CPU bus PMU resource.
-- interrupts            : Interrupt-specifier for PMU IRQ.
-
-Required properties for L3C subnode:
-- compatible		: Shall be "apm,xgene-pmu-l3c".
-- reg			: First resource shall be the L3C PMU resource.
-
-Required properties for IOB subnode:
-- compatible		: Shall be "apm,xgene-pmu-iob".
-- reg			: First resource shall be the IOB PMU resource.
-
-Required properties for MCB subnode:
-- compatible		: Shall be "apm,xgene-pmu-mcb".
-- reg			: First resource shall be the MCB PMU resource.
-- enable-bit-index	: The bit indicates if the according MCB is enabled.
-
-Required properties for MC subnode:
-- compatible		: Shall be "apm,xgene-pmu-mc".
-- reg			: First resource shall be the MC PMU resource.
-- enable-bit-index	: The bit indicates if the according MC is enabled.
-
-Example:
-	csw: csw@7e200000 {
-		compatible = "apm,xgene-csw", "syscon";
-		reg = <0x0 0x7e200000 0x0 0x1000>;
-	};
-
-	mcba: mcba@7e700000 {
-		compatible = "apm,xgene-mcb", "syscon";
-		reg = <0x0 0x7e700000 0x0 0x1000>;
-	};
-
-	mcbb: mcbb@7e720000 {
-		compatible = "apm,xgene-mcb", "syscon";
-		reg = <0x0 0x7e720000 0x0 0x1000>;
-	};
-
-	pmu: pmu@78810000 {
-		compatible = "apm,xgene-pmu-v2";
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-		regmap-csw = <&csw>;
-		regmap-mcba = <&mcba>;
-		regmap-mcbb = <&mcbb>;
-		reg = <0x0 0x78810000 0x0 0x1000>;
-		interrupts = <0x0 0x22 0x4>;
-
-		pmul3c@7e610000 {
-			compatible = "apm,xgene-pmu-l3c";
-			reg = <0x0 0x7e610000 0x0 0x1000>;
-		};
-
-		pmuiob@7e940000 {
-			compatible = "apm,xgene-pmu-iob";
-			reg = <0x0 0x7e940000 0x0 0x1000>;
-		};
-
-		pmucmcb@7e710000 {
-			compatible = "apm,xgene-pmu-mcb";
-			reg = <0x0 0x7e710000 0x0 0x1000>;
-			enable-bit-index = <0>;
-		};
-
-		pmucmcb@7e730000 {
-			compatible = "apm,xgene-pmu-mcb";
-			reg = <0x0 0x7e730000 0x0 0x1000>;
-			enable-bit-index = <1>;
-		};
-
-		pmucmc@7e810000 {
-			compatible = "apm,xgene-pmu-mc";
-			reg = <0x0 0x7e810000 0x0 0x1000>;
-			enable-bit-index = <0>;
-		};
-
-		pmucmc@7e850000 {
-			compatible = "apm,xgene-pmu-mc";
-			reg = <0x0 0x7e850000 0x0 0x1000>;
-			enable-bit-index = <1>;
-		};
-
-		pmucmc@7e890000 {
-			compatible = "apm,xgene-pmu-mc";
-			reg = <0x0 0x7e890000 0x0 0x1000>;
-			enable-bit-index = <2>;
-		};
-
-		pmucmc@7e8d0000 {
-			compatible = "apm,xgene-pmu-mc";
-			reg = <0x0 0x7e8d0000 0x0 0x1000>;
-			enable-bit-index = <3>;
-		};
-	};
-- 
2.47.2

