Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B90215F5C;
	Thu, 26 Jun 2025 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750967454; cv=none; b=SoNojpYkupKzwxgLFbUFj03ljZcUdSSZCjGfYSgYEiFE3vtBBvGzFffsYlL/CciKekocjE3CZOLvbRVuMlyyihqMaO3xJxovOp3LDhIzPZkKe1QAHbjTHkwmRpHeancAHAWIKx1t1JonD5Wg8cirF0K0WpfUYMYmwE4WMUlFwkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750967454; c=relaxed/simple;
	bh=gVzWTXNd6NPxpJJE+oFcGZWlup1AntES9uY+KcHycwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JTyhmJLCMR350UUqqoteRC6J9L+sHYxN3Qs6dAngDSqg0307pyFBsxR5/gxGYNAcXUVevuzmIvfgdQD05jgT21jMl1s5VAubFOqgxL+zLX+nnIgqfziqDmXn2y6O0sdJURJahsGZMPZ9PbPkZXOUyef6oEJKcb88XFMwg822gc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=boAc6D7s; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="boAc6D7s"
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QGfQPr018806;
	Thu, 26 Jun 2025 21:50:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	NMik+GHj52uoVxxBe7t1QLzP2UFZJzC3gMfHq5L927E=; b=boAc6D7sDxuZgQo2
	kqHvwl2FEnBRRtz8JuPWC0AgNCXs3zC0y/wI2WgkfZcG01K/h6PxX6PuyEu8CwT4
	7E67jltvksEdz2EANewZAZMfXoCN0rYMRfoM5codEvzd9l70QnyIkJpn3URJGvjq
	o12ZPUunLE4AkE4L7B3aOCai5KV2qLLPIke9/v03XdDERJ3YvQKXO0WHKunsV/yu
	PSP2ZGeO/qe6QB+uM+PjTfg3ZoGRIqO4dSWH7jqX1/34PBJN2D0M7MhwsUjrLcMN
	A17UERgLzQTQTJnfr2J3GZiFSvjVEXrLEzFCztps9/2a1IsjUGgAjHjEg8Zvzz4R
	/fBSSw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47dj5p16jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 21:50:30 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8A66840046;
	Thu, 26 Jun 2025 21:49:32 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A7119BD23A3;
	Thu, 26 Jun 2025 21:48:44 +0200 (CEST)
Received: from localhost (10.252.1.90) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 21:48:43 +0200
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Date: Thu, 26 Jun 2025 21:48:34 +0200
Subject: [PATCH RFC 1/2] dt-bindings: memory: add jedec,ddr[3-4]-channel
 binding
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250626-ddr-bindings-v1-1-cae30933c54c@foss.st.com>
References: <20250626-ddr-bindings-v1-0-cae30933c54c@foss.st.com>
In-Reply-To: <20250626-ddr-bindings-v1-0-cae30933c54c@foss.st.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Mark
 Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
X-Mailer: b4 0.15-dev-c25d1
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_06,2025-06-26_05,2025-03-28_01

Introduce as per jdec,lpddrX-channel binding, jdec,ddr[3-4]-channel
binding.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
---
 .../memory-controllers/ddr/jedec,ddr-channel.yaml  | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr-channel.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr-channel.yaml
new file mode 100644
index 000000000000..5271b41279e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr-channel.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,ddr-channel.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DDR channel with chip/rank topology description
+
+description:
+  A DDR channel is a logical grouping of memory chips that are connected
+  to a host system. The main purpose of this node is to describe the
+  overall DDR topology of the system, including the amount of individual
+  DDR chips.
+
+maintainers:
+  - Clément Le Goffic <clement.legoffic@foss.st.com>
+
+properties:
+  compatible:
+    enum:
+      - jedec,ddr3-channel
+      - jedec,ddr4-channel
+
+  io-width:
+    description:
+      The number of DQ pins in the channel. If this number is different
+      from (a multiple of) the io-width of the DDR chip, that means that
+      multiple instances of that type of chip are wired in parallel on this
+      channel (with the channel's DQ pins split up between the different
+      chips, and the CA, CS, etc. pins of the different chips all shorted
+      together).  This means that the total physical memory controlled by a
+      channel is equal to the sum of the densities of each rank on the
+      connected DDR chip, times the io-width of the channel divided by
+      the io-width of the DDR chip.
+    enum:
+      - 8
+      - 16
+      - 32
+      - 64
+      - 128
+
+required:
+      - compatible
+      - io-width
+
+additionalProperties: false
+
+examples:
+  - |
+    ddr_channel: ddr3-channel@0 {
+        compatible = "jedec,ddr3-channel";
+        io-width = <16>;
+    };

-- 
2.43.0

