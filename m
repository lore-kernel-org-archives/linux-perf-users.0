Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621BE3B9613;
	Wed,  1 Apr 2026 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775031433; cv=none; b=SN1wJm8Fff/FqFTwJ45x9b6snqc49z4eNmX45MJWM1Ncn6vGxltrkys8T3GxwWIwWxryyXDOGxGf2JByryl3MoDVLAI7gfTqn+56O7hetxxQxNeMAtA3hAtWmF7EM37Oskri67g4fYMqQAAferLJecHvadzyxGBrmpQpZnFiTcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775031433; c=relaxed/simple;
	bh=3F/HDSZcCnZSSb6HobYbR1bRATfH7F7wsv8hmrY1YQQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DAo6gwfjS9Dx1dGwxKzqJlqlVNgRVSIi9jX7m36fFHbH32A0HvmIw96ReoxwD6Wwh57gxetxPjTKuABizkNTLGLibB+qlctREh3bEIhNny6SuB7tkwGj0ZIodjxxApPNinAKCQXmfJPf0S9pSEMDlenYcyeZZqxPQH6KhuxUY4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Y6CZyuS8; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Y6CZyuS8"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VLdRSx2040996;
	Wed, 1 Apr 2026 01:16:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Uuf+9iOrr2PFs0uaBDW/4qrtk
	wWYYjKgLpNdVX6GGnk=; b=Y6CZyuS8dWnI5QordgB/fsGPp/jZJSDfW4b5TUjoI
	pu4tXeHoW+13yyGKZjvbl5cAPBtnAxbCLhOnCLPhD54Dec2fobRHc9+8lq2wSxPF
	upp/TAYpMl2XWafUAFfZEWLyHJeMIXx36gS83xLVjL3lSO0lI6MGuE1jJ1nL6pfU
	PCEwPgjibWKfsy6u4UL/cXdRS8TSUtjyqbmGvlzcZnoUBQVn2JE4pXqYgOmC0b5B
	E17g7N1BCjPrEsMJxLl5ru/0Ale3L2YhxbD3zFNpEPV8GBevQWH2BtD50aucbbCn
	0c95SXRBTzpvn7adsl8Sc3T1E+fZwzK2a7ftVk3BXIDrw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4d8ck3uc8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 01:16:47 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 1 Apr 2026 01:16:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 1 Apr 2026 01:16:46 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 4DCAC3F7044;
	Wed,  1 Apr 2026 01:16:44 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <mark.rutland@arm.com>, <will@kernel.org>, <krzk+dt@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: perf: marvell: Document CN20K DDR PMU
Date: Wed, 1 Apr 2026 13:46:39 +0530
Message-ID: <20260401081640.23740-2-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260401081640.23740-1-gakula@marvell.com>
References: <20260401081640.23740-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: NSWZXFzHnWHkT1eOeehZBm1UWiMr5F9S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA3MyBTYWx0ZWRfXyV8fprhHkdSU
 vdTNaCE1DTTETde9W+X20lamsRxDFkcvDclatm5SQ2B9p2ehXqwp6UZCY/3A+6A77ZqWSqg0EBj
 zYUPL0StOT1uDt4WHswYeFsXEcFa236ppflUTlEYJiE8uR0ewxhw+a5HD2HBmQ1CwnDqmGp45qx
 6UWdYaADcYEeUYcqA/ZCmY2gKvd3if1VreaMS+8AvedSBU1vC+EDP8pejYEdTOZtrh+KNWjskX6
 i8p5TOkpEr2oPiMAJvM83V+JoAHKx+OSzILSf6d++wZ0HaPQCwpddVOOjmvBX5BXUaUvhUe3wya
 b9H0yHQFrOpuaUkb1qGNZm/K/gM5Xsyew7q37ipxaYtWPqLAySZliPptbfa9hQVUZMRv67UdSob
 EcEWNAal+VybKE61nkcG5BBjzV69QgN9hBEsSK8D0GfBSE9KtnchVf6fqDLAVKzm/6z3Nqp6r44
 MhlnA3IzvN7+avUVnIA==
X-Proofpoint-ORIG-GUID: NSWZXFzHnWHkT1eOeehZBm1UWiMr5F9S
X-Authority-Analysis: v=2.4 cv=EKMLElZC c=1 sm=1 tr=0 ts=69ccd46f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=gEfo2CItAAAA:8 a=M5GUcnROAAAA:8
 a=cxBr6QS3EhuSzrwsu80A:9 a=sptkURWiP4Gy88Gu7hUp:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-04-01_01,2025-10-01_01

Add a devicetree binding for the Marvell CN20K DDR performance
monitor block, including the marvell,cn20k-ddr-pmu compatible
string and the required MMIO reg region.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../bindings/perf/marvell-cn20k-ddr.yaml      | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn20k-ddr.yaml

diff --git a/Documentation/devicetree/bindings/perf/marvell-cn20k-ddr.yaml b/Documentation/devicetree/bindings/perf/marvell-cn20k-ddr.yaml
new file mode 100644
index 000000000000..fa757017d66e
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/marvell-cn20k-ddr.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/marvell-cn20k-ddr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell CN20K DDR performance monitor
+
+description:
+  Performance Monitoring Unit (PMU) for the DDR controller
+  in Marvell CN20K SoCs.
+
+maintainers:
+  - Geetha sowjanya <gakula@marvell.com>
+
+properties:
+  compatible:
+    const: marvell,cn20k-ddr-pmu
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        ddr-pmu@c200000000 {
+            compatible = "marvell,cn20k-ddr-pmu";
+            reg = <0xc200 0x00000000 0x0 0x100000>;
+        };
+    };
-- 
2.25.1

