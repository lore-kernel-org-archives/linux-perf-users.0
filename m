Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3302EAB66;
	Fri, 11 Jul 2025 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752245578; cv=none; b=rABOa43yikRtq3j+S4B9BNJ6Vf4A6jm6VhwyybdS8lmJ25gGnCUqzzeh5bEDCDx8e4wUS+BCTNDP+nM6asfCvyHGaZ88FmfgrG7U5VmTj8HP96/AeJXMhZtogvThNgZ6RYWQ9fMim2VTmwbVI6YU1hIxsPRHNHSj8jncD36rKy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752245578; c=relaxed/simple;
	bh=bmfBpQxjkhv04INVjijdDWJKCT4N9bvLd3TgXWMCUPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OPQLefwZvwWAdwkh2PKmcffpYqhmnKuSb17Ybv7XoyL/SDDSM9f9UDh4bVcmns9lXHmol5owYqU8cntVdnBx/JBYJcoGcX2OVJ5wY5ZaZ2JVwHRa7QDrUfJIAyhwZ9FXE0V1I3KGrUQgLL5E0oIO8JY1rI/ZNugTOh9FWgbAacc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=hPMdaCB2; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="hPMdaCB2"
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BEZGn6031011;
	Fri, 11 Jul 2025 16:52:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	eWmIYjT8DzGwwh3O1kQbawehJSurPuvocYs+RzgumjY=; b=hPMdaCB2joT+Q0sv
	0aV9y4Fhe8EvtnqfFVl3ER4yAYOsUz2Q4rkIvoAKzPV+0m1nOPQQJqoBDMaKmn6N
	CkT/gB9Yxp8zqzGn/VGGLzpba2F5iu3NurxI8qQSMAQp7wyjdD41LUfVY9OFxx7N
	4u5q/9gIfEcEmmG+f3iZysdF8xggMnGj6oF/Awz6nMFux1FKcDU4hs5Uz3r2WDGj
	lFnnYjbiqGeqkjIjCwP7IJBslfNOkghxZyHQhIKeJ1uebKJjMEVoQ4UrLMt+gbuc
	/g8iDuiOsfAM+hFGtroI5w22VJY1DVC7E7aZCspxcETXPrLwytBknqjdwKi6EKGo
	e5IC1g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47ps6ay3f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 16:52:34 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D15B540045;
	Fri, 11 Jul 2025 16:51:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9F165B4BE8F;
	Fri, 11 Jul 2025 16:49:18 +0200 (CEST)
Received: from localhost (10.252.16.187) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 16:49:18 +0200
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Date: Fri, 11 Jul 2025 16:48:59 +0200
Subject: [PATCH v2 07/16] arm64: dts: st: add DDR channel to
 stm32mp257f-ev1 board
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250711-ddrperfm-upstream-v2-7-cdece720348f@foss.st.com>
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

Add 32bits DDR4 channel to the stm32mp257f-dk board.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 2f561ad40665..f987d86d350f 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -41,6 +41,11 @@ pad_clk: pad-clk {
 		};
 	};
 
+	ddr_channel: ddr4-channel {
+		compatible = "jedec,ddr4-channel";
+		io-width = <32>;
+	};
+
 	imx335_2v9: regulator-2v9 {
 		compatible = "regulator-fixed";
 		regulator-name = "imx335-avdd";

-- 
2.43.0

