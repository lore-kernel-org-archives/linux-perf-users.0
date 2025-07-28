Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D4226F47D;
	Mon, 28 Jul 2025 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716793; cv=none; b=VHt/NVR4vU4V/OajvKwL7UCD104JAPix5yyTq0x5LClsu42VudvHF1p4Sug8GD6Aka9oamnLXLxrUsCet1gA0QJh9fZ0lvwD+iBYyEW2GBpO1FQjIV9LZ8YvonrISloAdUf2K/tLeP0CXSzGthLWYW4xzTyAQzcKX6psr9C6Jec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716793; c=relaxed/simple;
	bh=d5iWwZQBtscc9/XYMe8rkBSJD76rq7wf56xNPUB+T6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rTESiwDVps2k5rRFBKDdzoVNzfkVAadzQ1UkM10LgssjeDkn94/qUS8MSYc1RqSXyDAq2tWYeq5UCETtdR4GvorO5YIx2LsX7U7hyD4Es4Fpt6gVYFw/mBiwFJ3r+zlIQ7fmcQ6gpBddLIR/oElA5FnGIU93wJMncS+SIk0OT44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=5njpOx0c; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="5njpOx0c"
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SEiew9019399;
	Mon, 28 Jul 2025 17:32:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	/Ngm9p3NQD6arEx7d73G9n3PIlBqe76QEjiMrucBWPs=; b=5njpOx0cBMLpESJh
	M6RZkbEey0kVvyqDeDGcf+YNYHNBKGvYgS/KUSM9WIAxGIFUcRJ3rz73Iyolgdqw
	m0a3hW3PzMEVVogaixOiIyopiAOhswj4MzjRld47Q4955oMDE8P5rl2CN9FennO4
	L4OqyfYHugPA4OHgR3eyu/IKhTc/43JBJmgE/Zw/22ECJo5scNxOyL4AwEMqX/24
	RezpTT55A9vO3Sd58wcnH4naZ9wD0zOOJ4TGihRKAF8s1hTidq3rSnugurMsCraT
	+uR+xH7xFQWsw19zfQpeS8/UC2pLVtRYm9CC9STFkDXaY+oGeDgVG0jao9DNVk1m
	Tj6CnA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4858k4x9ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 17:32:52 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 43F2F40047;
	Mon, 28 Jul 2025 17:31:14 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 701B6787C38;
	Mon, 28 Jul 2025 17:29:53 +0200 (CEST)
Received: from localhost (10.252.23.100) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 17:29:53 +0200
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Date: Mon, 28 Jul 2025 17:29:35 +0200
Subject: [PATCH v5 04/20] arm64: dts: st: set rcc as an access-controller
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250728-ddrperfm-upstream-v5-4-03f1be8ad396@foss.st.com>
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

RCC now implements firewall access ops to check the access to
resources. Allow client nodes to query the RCC with one firewall ID.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index 8d87865850a7..0683c2d5cb6f 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -1153,6 +1153,7 @@ rcc: clock-controller@44200000 {
 			reg = <0x44200000 0x10000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+			#access-controller-cells = <1>;
 			clocks = <&scmi_clk CK_SCMI_HSE>,
 				<&scmi_clk CK_SCMI_HSI>,
 				<&scmi_clk CK_SCMI_MSI>,

-- 
2.43.0

