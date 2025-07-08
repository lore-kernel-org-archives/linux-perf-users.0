Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFBB2D878B
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Jul 2025 10:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751971271; cv=none; b=kCvivQbnflGoSPyxJo2BiuGr53Hzj13o4H1lE7zUorbZp7eVjapo/glYgbS8vrGfOKvDLKFO3Kfs/+GG+U5tMZHJlRF9/TlNNJuMQG2WdT9TETUFeZ93ymjJ8+Mfjn/kl9PmfOMxDl/4PatKFAKCZClA+QksaHFFiKO2yrcsYBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751971271; c=relaxed/simple;
	bh=RFe77r1HbG6Q+MYMncVBBXCUapplAX1Lv3aK87B4hcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=q6WW8D/43brz3F3FBXZ/gqCQ9u96FH7iuQ9a2Z1aPC4nsQiMvfc41mWV4U+k8lbgfuNzQdmrM2Wm1BvyWBpd25qEhpJtvEJAeCl+HZDVqoiPoRloPCcT0XNZFQxcaH94wASe13yIRoGDNtVEp40yQmfNrhhFotXHkZL++lvMVU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GLUU/57I; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GLUU/57I"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250708104107epoutp02a36807b31af0c3cd2593dc63c3292a33~QQJXvaX2S0104701047epoutp02f
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Jul 2025 10:41:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250708104107epoutp02a36807b31af0c3cd2593dc63c3292a33~QQJXvaX2S0104701047epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751971267;
	bh=yQQif8BnhaNVq6Q/a8Q3DYVnyJXRWSFrD2QEhPIZrBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GLUU/57INvp0UdSWXgD8QlTtEdLD0TjLUPu8JbI9rizCHBq1n9I+dMkDfYpEgs/6F
	 ed7kAc/QMOUaYKYpQfuDDq+Ht+fiERdfqceW3FsLmrTP2Im6g19MirmSEm6S6fhGKO
	 y2gHSmvP0weVl2q9SCHbqnSJW8ua2TUTPxNTTHM4=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250708104106epcas5p4f80114851e1609d1f2f7ceb0c1fa7212~QQJWK9yyp3037230372epcas5p4b;
	Tue,  8 Jul 2025 10:41:06 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.182]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bbyM41ZZqz6B9m4; Tue,  8 Jul
	2025 10:41:04 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250708103243epcas5p2d8fd5bf02e64e104eca3def802813230~QQCCNA-B31542215422epcas5p2D;
	Tue,  8 Jul 2025 10:32:43 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250708103240epsmtip125db38a216aac73a68a1e95d29162d5e~QQB-mXXWQ2131121311epsmtip1o;
	Tue,  8 Jul 2025 10:32:40 +0000 (GMT)
From: Vivek Yadav <vivek.2311@samsung.com>
To: pankaj.dubey@samsung.com, ravi.patel@samsung.com, shradha.t@samsung.com,
	mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, krzk@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, will@kernel.org,
	mark.rutland@arm.com, s.nawrocki@samsung.com, cw00.choi@samsung.com,
	alim.akhtar@samsung.com, linux-fsd@tesla.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Vivek
	Yadav <vivek.2311@samsung.com>
Subject: [PATCH 5/6] arm64: dts: fsd: Add PPMU support for MFC block of FSD
 SoC
Date: Tue,  8 Jul 2025 16:02:07 +0530
Message-ID: <20250708103208.79444-6-vivek.2311@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708103208.79444-1-vivek.2311@samsung.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250708103243epcas5p2d8fd5bf02e64e104eca3def802813230
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250708103243epcas5p2d8fd5bf02e64e104eca3def802813230
References: <20250708103208.79444-1-vivek.2311@samsung.com>
	<CGME20250708103243epcas5p2d8fd5bf02e64e104eca3def802813230@epcas5p2.samsung.com>

Add device tree node for PPMU instances in MFC block and
enable the same for Tesla FSD platform.

Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
Signed-off-by: Vivek Yadav <vivek.2311@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd-evb.dts |  8 ++++++++
 arch/arm64/boot/dts/tesla/fsd.dtsi    | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
index 8d7794642900..f543c7dad7cc 100644
--- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
+++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
@@ -110,3 +110,11 @@ &serial_0 {
 &ufs {
 	status = "okay";
 };
+
+&ppmu0_mfc {
+	status = "okay";
+};
+
+&ppmu1_mfc {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index 690b4ed9c29b..7b6e7d81be10 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -970,6 +970,26 @@ timer@10040000 {
 			clock-names = "fin_pll", "mct";
 		};
 
+		ppmu0_mfc: ppmu@12840000 {
+			compatible = "samsung,ppmu-v2";
+			reg = <0x0 0x12840000 0x0 0x1000>;
+			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock_mfc MFC_PPMU_MFCD0_IPCLKPORT_ACLK>,
+				 <&clock_mfc MFC_PPMU_MFCD0_IPCLKPORT_PCLK>;
+			clock-names = "aclk", "pclk";
+		};
+
+		ppmu1_mfc: ppmu@12850000 {
+			compatible = "samsung,ppmu-v2";
+			reg = <0x0 0x12850000 0x0 0x1000>;
+			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock_mfc MFC_PPMU_MFCD1_IPCLKPORT_ACLK>,
+				 <&clock_mfc MFC_PPMU_MFCD1_IPCLKPORT_PCLK>;
+			clock-names = "aclk", "pclk";
+		};
+
 		mfc: mfc@12880000 {
 			compatible = "tesla,fsd-mfc";
 			reg = <0x0 0x12880000 0x0 0x10000>;
-- 
2.49.0

