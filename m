Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9BD2E88B6;
	Wed, 23 Jul 2025 13:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753276191; cv=none; b=t+uPCbO6HHelbuA1qGkcKtf2/eDUu7SpEsIvuQF0rr5776nWly2QIhv7PAJbAnkCu9vX2bvzU7Xj3LRPqkRo7PalZhnOxKmJtgpHWP86gOFeFDZiQAaOEzg4HhMjvKGsq6kfdFf3izDDFHQhbgeKvK7dHrWD8qZcHezWPar1wfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753276191; c=relaxed/simple;
	bh=p6/kdveeT+plI/0Dtsc/AlwljExz9cpevWGu/BpUGD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=aL/AP4q9C8l7jKVgs9S47QB36xpyGTjbMhgb1ylaTzvtNNCbER9jiKhIuD0dsp+dC6LwczpZIuzwXckMzQ3go9ap5fWmgAQDm6roEOVL6u5OF/fxlrX6j7mapnn5RIwSH3L9bCEbe0r3mCvNVa/YGGDDcHYoGlEZn1hhzHqicLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=B85fv+6J; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="B85fv+6J"
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NCdO5R011745;
	Wed, 23 Jul 2025 15:09:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	9SVEF8WXui/rvJlaHwlNLMXiePzshiHlU6XnxEDuFv0=; b=B85fv+6Jm3uAuFs+
	1XCFgeO84bxuO66g1O+aPvhMm3jdI1JdRdIaYVQeJBpwLmhs/Q3HYWRGUQVdj4+0
	3dacAbGfEz3sovc2DwXbNGJ/vmM3xIHYngc4A+GU4JBLrDkXWdqaT0YJIfowPxSq
	P0I3SS4uVsRwDw/Nm1saeAvQTxaAKhyTT2UNbdf7Bd3grPiZQK2+/BslfDwAeIaZ
	Zxv8gp4r2E5W2aeRAqjIgiFn6+dfJB2Xv/aijlqscC7Oly4cSnak9cHAWBYpAMqY
	bi2hBttUG1hrwos0n0jHtc6m3exSTL4jBZLuwtHiN8EN4NMgPHeSNi9auE2FdF5J
	w3pHpg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4800g8uva3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 15:09:35 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C29274004D;
	Wed, 23 Jul 2025 15:07:33 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B8B3879989B;
	Wed, 23 Jul 2025 15:06:09 +0200 (CEST)
Received: from localhost (10.48.86.185) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 15:06:09 +0200
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Date: Wed, 23 Jul 2025 15:05:53 +0200
Subject: [PATCH v4 09/20] dt-bindings: memory: SDRAM channel: standardise
 node name
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250723-ddrperfm-upstream-v4-9-1aa53ca319f4@foss.st.com>
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

Add a pattern for sdram channel node name.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
---
 .../bindings/memory-controllers/ddr/jedec,sdram-channel.yaml       | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
index 866af40b654d..5cdd8ef45100 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
@@ -17,6 +17,9 @@ maintainers:
   - Julius Werner <jwerner@chromium.org>
 
 properties:
+  $nodename:
+    pattern: "sdram-channel-[0-9]+$"
+
   compatible:
     enum:
       - jedec,ddr4-channel
@@ -118,7 +121,7 @@ additionalProperties: false
 
 examples:
   - |
-    lpddr-channel0 {
+    sdram-channel-0 {
       #address-cells = <1>;
       #size-cells = <0>;
       compatible = "jedec,lpddr3-channel";
@@ -133,7 +136,7 @@ examples:
       };
     };
 
-    lpddr-channel1 {
+    sdram-channel-1 {
       #address-cells = <1>;
       #size-cells = <0>;
       compatible = "jedec,lpddr4-channel";

-- 
2.43.0

