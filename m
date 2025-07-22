Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE072EE276;
	Tue, 22 Jul 2025 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193245; cv=none; b=ZC71PIgBvT2N2oU/UdhUPdtNCjSEujESU1O3mbscMCqYMNd7VupCyE9kBgC1wn79HSTY+YKF/iBcksqvO9lhF5Vl3RSWTqEhct6+fTD178SbllJQsaiKQFpxsil8PgWfa7XFIXDirAifAG/1L93sj0ndICO871nwpwdKaUiKSy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193245; c=relaxed/simple;
	bh=d5iWwZQBtscc9/XYMe8rkBSJD76rq7wf56xNPUB+T6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BM2cYIfVJUD99Wrbmfugm80A7zzDbZaYsmTAte6wQ7FyLiDy7PSPnhG6BHYeQl2fee+sTWKWI/6HyM4mpzxcePIpCGbWdfKqr057QWx/Drl7AthKQ2kHS+J2bLxUZ3w5lMGWj0Mse3PdTVoaCix9EyhFjzgDNZcQ5mOXFC7QN1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Cq6TbaU/; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Cq6TbaU/"
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MDNIa0009085;
	Tue, 22 Jul 2025 16:07:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	/Ngm9p3NQD6arEx7d73G9n3PIlBqe76QEjiMrucBWPs=; b=Cq6TbaU/eNiy/1cy
	rvjwhgRHiOcQ+p74Lg4lMRKKU88A7Fy6OZisRuziiVl8VMdue8cAsdZItsH9Vp0k
	UOBnTL3zlX0TKX0CTBUxZyDCvKZDWdHZ7fl8B/TUWpP6OoXAPPxTlR5XQXBQ3Dni
	dOATk/JCF7OzrcjoBJe8W2D+figfIql3I/xbaBeBdfpPeoZPA6RT6ZJ5QfHt3O0r
	6MhnSivAy6HsxgRNstMb+o2f+XgLM1VoTLYhvhSge923tpQ0zX0iY1yWUQd3lx62
	T9+aGviJ4MCnH+Wj+zIz+R7vwZ8USwI7jpPYkE3g4IYQ3ZStFIsvT7XuB0HCyW/C
	YiSD8A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4802q26j87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 16:07:05 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6E33B40059;
	Tue, 22 Jul 2025 16:05:11 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5922E7A2A44;
	Tue, 22 Jul 2025 16:03:52 +0200 (CEST)
Received: from localhost (10.48.86.185) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 16:03:52 +0200
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Date: Tue, 22 Jul 2025 16:03:21 +0200
Subject: [PATCH v3 04/19] arm64: dts: st: set rcc as an access-controller
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250722-ddrperfm-upstream-v3-4-7b7a4f3dc8a0@foss.st.com>
References: <20250722-ddrperfm-upstream-v3-0-7b7a4f3dc8a0@foss.st.com>
In-Reply-To: <20250722-ddrperfm-upstream-v3-0-7b7a4f3dc8a0@foss.st.com>
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
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01

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

