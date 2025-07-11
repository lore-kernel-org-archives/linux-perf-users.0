Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BD418E750;
	Fri, 11 Jul 2025 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752247033; cv=none; b=hTNphh6HeqtO7gO3VES8JBYYsnYy1EXTBneqdlpEH8VGSuhxCBenBIfOEhh1oacG5avIzN0N0VIioQdYwpdCUKwvcZda3YrzIVWQvXOpVo/kFfp55l5OyR3JNKl62P0QFttYAvht0q33DMvwPIXacR/N7tjBj7XOGezv3OnvaZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752247033; c=relaxed/simple;
	bh=0tBuDJRr6ws7oI3s/5XtL5Gs+dqOdkD8ubSy6zGZnyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mDvF+pSUSFtrZjhsgNOWvLmp7q+clVXXyVewyDV/ibWMvZkkID6dGIKQb6eFbBIFaRK5Zd84pUCrqCss1DKboa4NgRyaGe29kpEjcfKf5CIrumjuOgOPvZQpOvfcxYiYPYSWBSHE0HXnRGaeYSrA/9nm/tZfslkmHjC3+MIA0VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=RDp44xPO; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="RDp44xPO"
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BCHMEO027003;
	Fri, 11 Jul 2025 16:51:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	EUpYSzydPpFuztaOxz5jpPB1qeEDE88vI+GDfXR2JDs=; b=RDp44xPOWxJZY40z
	xycNsFnCPzbrvds0kW9WNedRnbvjMu9DdMo7HZCA/Oe/2ZUB0ifhTB6KiNEKtu5y
	QgMOGjUzgKsMiaiMrOj9wHTiGH261jFmYznzez73rHJZj4kVSvaBuIe9laRuyact
	6C6ODWSg+Nvq4qXwhs+sn8iRp6MyAXT06QfQK6op+dEXqRGrI0nuetmuNQSd3m31
	UY4sZpJ6siIErRzz8xE0r1xQpJPKVDYQ/iPfGEBl3A7lW+GiHhuVWJbKhdo2GYPZ
	p7r0q53Vk4dhRqvNPXhgLG1bQGkpYGhlM6yXcfU+hyH/stzsfp10TSDISScdJ1+O
	PXQqhQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47psfmyt2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 16:51:13 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 22BCD40058;
	Fri, 11 Jul 2025 16:49:56 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C2E19B4BEA4;
	Fri, 11 Jul 2025 16:49:16 +0200 (CEST)
Received: from localhost (10.252.16.187) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 16:49:16 +0200
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Date: Fri, 11 Jul 2025 16:48:57 +0200
Subject: [PATCH v2 05/16] dt-bindings: memory: add jedec,ddr[3-4]-channel
 binding
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250711-ddrperfm-upstream-v2-5-cdece720348f@foss.st.com>
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

Introduce as per jedec,lpddrX-channel binding, jdec,ddr[3-4]-channel
binding.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
---
 .../memory-controllers/ddr/jedec,ddr-channel.yaml  | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr-channel.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr-channel.yaml
new file mode 100644
index 000000000000..31daa22bcd4a
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
+  - Clément Le Goffic <legoffic.clement@gmail.com>
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
+  - compatible
+  - io-width
+
+additionalProperties: false
+
+examples:
+  - |
+    ddr_channel: ddr3-channel {
+        compatible = "jedec,ddr3-channel";
+        io-width = <16>;
+    };

-- 
2.43.0

