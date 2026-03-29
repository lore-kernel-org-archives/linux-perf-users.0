Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8FE2367D9;
	Sun, 29 Mar 2026 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774797910; cv=none; b=eK9SjRjpKKmNcHFEJvCtDHmxbJO29wg8dVOUp/cg0HzxSRTK/b+4NHyAm6O7M0OnmHe88QS5/tsin5DDbCYw7ej62NSejM2tcst9lnlblY8SxBBTBmBwvholzRHn5tY69tTxEfbIMDwo3+Htdspk4qA4AJPGxAWRa180jTvDjGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774797910; c=relaxed/simple;
	bh=nmm4VslxqXI3wqv5WDfEliYsy8tjbJh0jnVAafj/7Vs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/5CnadO8C8EMb43n/CxZNQhbNKQlEnel7BvPHG5mr/K0BiQib3UBK9Bq2IyeB/wzCb9MvVjsDDjieAzA9L5NC/p+w4pgFQwoppOE0uvb51mrRAM5rsFNwgTukRC5YyLz8bnTR0uANH7yPZy0x0CZlVOaXhxThR5Sm93FLKV4HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PHoczkpm; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="PHoczkpm"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62TAfSEV1378075;
	Sun, 29 Mar 2026 08:24:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=0frzZsRp4geA//YkLJsFKvscu
	/wuys79Cml4PWw9at8=; b=PHoczkpm12eC8XjnksxBndGDOyolM5wy/I+5JQ7Wg
	/TTfVHHIZAkk0xy4m+yH4CnKyMx9/OeZk3E9gIoVXpQDfYxpwSdtOJevL6Qeqt1D
	1WRLXXty+OICYnUoS0OIKXE7epAVrmf/MuK15tWBgGlEBhL+63tE9Xlo+1HZzT5V
	PViXRoeIU/QgIAWQqqL7ZpWXqp1/W4BJHdoKilozCaOi6sPYctThA+sS2DqK2H0g
	p2byQSZF1l4MsEiXZq2o9+UH7H6z0XzH8JRd95qQOfwmL85cx5FuYv0lVn8+Zn4I
	QKDgSXj4qcbCusKXXwQ7l8tczu1bXXF4x3StCPk0NXaiw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4d6egghqbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Mar 2026 08:24:47 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 29 Mar 2026 08:24:46 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 29 Mar 2026 08:24:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 29 Mar 2026 08:24:45 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 0839F3F70A3;
	Sun, 29 Mar 2026 08:24:42 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <mark.rutland@arm.com>, <will@kernel.org>, <krzk+dt@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: perf: marvell: Document CN20K DDR PMU
Date: Sun, 29 Mar 2026 20:54:38 +0530
Message-ID: <20260329152439.10573-2-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260329152439.10573-1-gakula@marvell.com>
References: <20260329152439.10573-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=bfxmkePB c=1 sm=1 tr=0 ts=69c9443f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=gEfo2CItAAAA:8 a=M5GUcnROAAAA:8
 a=cxBr6QS3EhuSzrwsu80A:9 a=sptkURWiP4Gy88Gu7hUp:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: tb7vR8qxdi2mztV-MXqgls793zxXo8UH
X-Proofpoint-GUID: tb7vR8qxdi2mztV-MXqgls793zxXo8UH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI5MDExOSBTYWx0ZWRfX5P44iiAmwQaz
 ivRyhs/Bliq93ik0LWMM6tdYf7p4FraZ3jFHBFDz9C8Y8HN7Wf2dG4QD1dt29Ek95v35Eh/I3xu
 j9CMu2ewE/WbcA+5DDCDe7ExQwtdUqSinV/4WcQiKSv+q8Zjx38pgi5nm3rY7meeW+9B22PvmK0
 02KCsOv+q5soOJf4qtoo4Ogu0W7ZG3oerz9WPIkwMI2st+cc/F/0GSYiLvFZBF+nZcXEiWtaivB
 4qHpa9UW+vUR6rs6OqLgYkDqqmurmiSnW9hSBqtjOsyjYQv+jh5HFXOT+fUrM82rb37HZ2t6H2b
 lLTPzq7WwokaGDTINl0duiXVYevcf/RLWTsoo7QPbHzT7jyx08yJ28oxT9rPiC8795vRAEmwR1X
 aT/Gsaw0fgXJrpNJB/dwpGr8WDYYj8U3p/TWHhBixNI/PX0Dse2spo80iHtWYxZUy+2vGONb1Ru
 PxmjNcmqmMzKyM4gF7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_04,2026-03-28_01,2025-10-01_01

Add a devicetree binding for the Marvell CN20K DDR performance
monitor block, including the marvell,cn20k-ddr-pmu compatible
string and the required MMIO reg region.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---

Changes in v1:
- Added a description field to the binding.
- Simplified the compatible property using 'const' instead of 'items/enum'.
- Updated the example node name to include a unit-address matching the reg base.

 .../bindings/perf/marvell-cn20k-ddr.yaml      | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn20k-ddr.yaml

diff --git a/Documentation/devicetree/bindings/perf/marvell-cn20k-ddr.yaml b/Documentation/devicetree/bindings/perf/marvell-cn20k-ddr.yaml
new file mode 100644
index 000000000000..470eac0a53c4
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
+	ddr-pmu@c200000000 {
+            compatible = "marvell,cn20k-ddr-pmu";
+            reg = <0xc200 0x00000000 0x0 0x100000>;
+        };
+    };
-- 
2.25.1

