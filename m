Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F304227C162;
	Mon, 28 Jul 2025 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716934; cv=none; b=fenOnfZTnvGBA6EzEvd8zPDsnTQIazauO1fqMyJxNvHV+SluCwHRvlLbF5cEDjFn0VrFFLd1KNS1sqwZVnlc3UQK0RPi2Xkm5hERLdN+fhnWxozfbjSeusaMpDYTN9NixBXli48ITOLShKZJP6qAdjXUIEk51iuwNzAdKPvEuIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716934; c=relaxed/simple;
	bh=c5RN1PJ2jWZpcD31tgu2dPIQqUIfEUl+l6dcon/cpoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=L0oPw2JfuWJT/7AWYdFqk5qQyemeFISdMQNGny93OicM5H1Emrfnn2c8SCHvxrDUT8GuYa7LJLFas1Ne8NufC5i3l2MML2GIvKisll8+kadayxx1LMHK5VRHd5LCOFmQ0FyNZpk4uoXj0w2S9DguLRycEo8UCfIOnIC7kB0yR/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=oApuPc79; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="oApuPc79"
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SCE6sR026923;
	Mon, 28 Jul 2025 17:35:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	eJrc2cACDhSOzVDLTaVrQsrujHpWGGs7dlhdmyDAAho=; b=oApuPc79eip//KOw
	wyvdk0iBp0R8FtiJrBLJmUDNQi5qMb2T9WZT0xRmmTu3VGO5svUgaCwhD6ubgyDe
	C/YMW97AYfDscRZ76/MR8KAciBqgDS4YatMLUASlWPu6KCpKIEXdhw6xkQ8CaQJD
	FEcXK+COmKrFzXXiO+4yc8pUD+zceQP241ADLVS+kfI7NXG+/Mq4kVO2cO072ZWB
	Goy+zoox1y2ydECaUoLQQKOovz/mJ2wo5zO6n9wSrHbOm3YZ2xwSOunQC13WG6wr
	rgJ/0//HCVnemyL2nF9MkCPzmtj2jT8aywr8aoFUuwjEBNe0SsqSn+DSo0s7Mtlh
	wGPedQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4858k4x9nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 17:35:17 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9517040054;
	Mon, 28 Jul 2025 17:33:49 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2CAA178C913;
	Mon, 28 Jul 2025 17:30:09 +0200 (CEST)
Received: from localhost (10.252.23.100) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 17:30:08 +0200
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Date: Mon, 28 Jul 2025 17:29:50 +0200
Subject: [PATCH v5 19/20] arm64: dts: st: support ddrperfm on
 stm32mp257f-dk
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250728-ddrperfm-upstream-v5-19-03f1be8ad396@foss.st.com>
References: <20250728-ddrperfm-upstream-v5-0-03f1be8ad396@foss.st.com>
In-Reply-To: <20250728-ddrperfm-upstream-v5-0-03f1be8ad396@foss.st.com>
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
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01

Configure DDRPERFM node on stm32mp257f-dk board.
Disable the node as DDRPERFM will produce an error message if it's clock
(shared with the DDRCTRL on STM32MP25x) is secured by common bootloaders.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
index 45ffa358c800..81b115280bd4 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
@@ -84,6 +84,11 @@ &arm_wdt {
 	status = "okay";
 };
 
+&ddrperfm {
+	memory-channel = <&lpddr_channel>;
+	status = "disabled";
+};
+
 &scmi_regu {
 	scmi_vddio1: regulator@0 {
 		regulator-min-microvolt = <1800000>;

-- 
2.43.0

