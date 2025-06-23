Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619DB19938D;
	Mon, 23 Jun 2025 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750671008; cv=none; b=KxeQV+qHvpVGk202Slv955vZlotF45gpt19GlyG6CUF2fnt0UzoO5lsgKegNiv8htbn7g5I8t3ZchZ4XRrGG5KKviJHQWkb+wKqRdw/eTRpbnec1DfvoNM/Iv8qWYRghoe0g0CIhyHeNBPwcmbrqZ0LRXJAf496raCyOJDRAXSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750671008; c=relaxed/simple;
	bh=2P5ny0jXq0Zka5S9YZS8xJq7IT9AiULqloVqfFuXhN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=o6zCcxUIHxwXAIaRaXGxqpru0/zBU6O/Y1e/C91D0bqFf1SsP3QAI4YwfTuWX54yxLAs4pW41m+arSCch+USeAbCSIVb4wUD347moprBVuHx2vX01BssjzIV2xSGnVeC3eJNU05bQo5kqS5iWo/bGoW2XIOx7nW2ebdZ4kKysi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=0WV19Me8; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="0WV19Me8"
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N8d1RM015478;
	Mon, 23 Jun 2025 11:29:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	JMNBycwcd7wyfwtdlkzqGW8/SiXBU1Q2CVVSljevQu8=; b=0WV19Me8R8tRuy65
	ebSb8qxl2wP57/f12O4bhW4vU3d457E251WWz6hAsSLq8h3gp6qR87WnSfO/ALfu
	av+RlCFPWzA0cRhu5cWDp0I2/li3Zht+I8Gteii1c3Zi5SnvQAHMakYdgoUqeid6
	uPlAJhVDCvB6vX/gwDus1PaHdyvo/8T8G7bINdSJnHl7vV/YEbjLkG/Z9kgSiw42
	WCILgGOmx2iYs6uu1wxjkIuXrnCBqkGEQqxi2YX4Vu+d8q0stYKpYnVsk2AkaY7E
	bIr+0wN59AuzsH8AGAOdFzgAYo7tAzAjDfkTabLtJRZdlaZLtoUsRC6olS8DiGtj
	tqOYuA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47dj5nfcb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 11:29:52 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D296A40059;
	Mon, 23 Jun 2025 11:28:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1D0E15C3DF8;
	Mon, 23 Jun 2025 11:27:32 +0200 (CEST)
Received: from localhost (10.252.18.29) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:27:31 +0200
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Date: Mon, 23 Jun 2025 11:27:17 +0200
Subject: [PATCH 12/13] arm64: dts: st: support ddrperfm on stm32mp257f-dk
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250623-ddrperfm-upstream-v1-12-7dffff168090@foss.st.com>
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

Configure DDRPERFM node on stm32mp257f-dk board.
Disable the node as DDRPERFM will produce an error message if it's clock
(shared with the DDRCTRL on STM32MP25x) is secured by common bootloaders.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
index a278a1e3ce03..e59ef18de7c3 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
@@ -77,6 +77,11 @@ &arm_wdt {
 	status = "okay";
 };
 
+&ddrperfm {
+	st,dram-type = <0>;
+	status = "disabled";
+};
+
 &scmi_regu {
 	scmi_vddio1: regulator@0 {
 		regulator-min-microvolt = <1800000>;

-- 
2.43.0

