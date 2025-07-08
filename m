Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C982D8778
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Jul 2025 10:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751971265; cv=none; b=jV0v7P1WaXuMLjmwSJkWwBRWkCbLhZGGYAmtU0ZjCBnEZP0+kBG14zBFKalGoKzL1eEDpoLn6z2OrLtWSMlb9v9v9Kk0k+qZjDiFFvzDj4HGYHkOerQpW3CWefW/+Z0N7ZEuA0rZDGxM1vxZEsd56U2uFrDlCBD3RqdkqEQhoQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751971265; c=relaxed/simple;
	bh=/RQNQ/dtfaKGETOGG3j7ev7DvdiaASUa4WOAtBdY7i8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=AWcNavEsTLNG/vVLxcMQP/lArjl8pjIZh5Jya75x+YqPrd26BpHF2w7NOtSd/uJxBwwpU7RakxYuvyfNLV/NwOLe4J/cI8KLJd4xcq5g7fI5O+VQEGyYEsF3ihUBIVshAzf6Jy2T4x5AEeLXkajcHxCpRtlGJyDAqH4F96wJbmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EFHzxLOu; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EFHzxLOu"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250708104054epoutp01dcf800519086ceb760f64bc97f82b5c6~QQJLphwfb2791327913epoutp01x
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Jul 2025 10:40:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250708104054epoutp01dcf800519086ceb760f64bc97f82b5c6~QQJLphwfb2791327913epoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751971254;
	bh=NfJkRbmOTcr65lxFjeLJlMql9NikTl7suSZwH4Lbtaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EFHzxLOuBTdSuIov5DF5cUvKsT78IEQnI65z5yArW0VpOHTa8/RJcDiNpIKNq7HzG
	 QCDb1F0r/gCssG8Ql8Q4TIF0y8IucFXPn8h480iMNvhAGbH4VOiDpNvfSbVBkQ7BR5
	 uAKEbArChXFb6HcIbTK0Zm9rOuemFBOCkah+GZ7I=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250708104053epcas5p1dc5ef8f325ace2a1f6519b582ca1572f~QQJKvz5310327403274epcas5p1w;
	Tue,  8 Jul 2025 10:40:53 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.174]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bbyLq4gfxz2SSKn; Tue,  8 Jul
	2025 10:40:51 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250708103234epcas5p1a92b0b57315f6e81c906fedcc232c279~QQB5qA9nc0987209872epcas5p1H;
	Tue,  8 Jul 2025 10:32:34 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250708103231epsmtip1869c3d7d71f4a9e263c08b8ccd9b4dd6~QQB3BuOct2131121311epsmtip1l;
	Tue,  8 Jul 2025 10:32:31 +0000 (GMT)
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
Subject: [PATCH 2/6] clk: samsung: fsd: Use clock IDs for PPMU MFC block
Date: Tue,  8 Jul 2025 16:02:04 +0530
Message-ID: <20250708103208.79444-3-vivek.2311@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708103208.79444-1-vivek.2311@samsung.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250708103234epcas5p1a92b0b57315f6e81c906fedcc232c279
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250708103234epcas5p1a92b0b57315f6e81c906fedcc232c279
References: <20250708103208.79444-1-vivek.2311@samsung.com>
	<CGME20250708103234epcas5p1a92b0b57315f6e81c906fedcc232c279@epcas5p1.samsung.com>

Use PPMU clock ID macros for PPMU MFC gate clocks.

Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
Signed-off-by: Vivek Yadav <vivek.2311@samsung.com>
---
 drivers/clk/samsung/clk-fsd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/samsung/clk-fsd.c b/drivers/clk/samsung/clk-fsd.c
index 9a6006c298c2..f80d35feb3f7 100644
--- a/drivers/clk/samsung/clk-fsd.c
+++ b/drivers/clk/samsung/clk-fsd.c
@@ -88,7 +88,7 @@
 #define CLKS_NR_FSYS0		(FSYS0_DOUT_FSYS0_PERIBUS_GRP + 1)
 #define CLKS_NR_FSYS1		(PCIE_LINK1_IPCLKPORT_SLV_ACLK + 1)
 #define CLKS_NR_IMEM		(IMEM_TMU_GT_IPCLKPORT_I_CLK_TS + 1)
-#define CLKS_NR_MFC		(MFC_MFC_IPCLKPORT_ACLK + 1)
+#define CLKS_NR_MFC		(MFC_PPMU_MFCD1_IPCLKPORT_PCLK + 1)
 #define CLKS_NR_CAM_CSI		(CAM_CSI2_3_IPCLKPORT_I_ACLK + 1)
 
 static const unsigned long cmu_clk_regs[] __initconst = {
@@ -1519,13 +1519,13 @@ static const struct samsung_gate_clock mfc_gate_clks[] __initconst = {
 	     GAT_MFC_NS_BRDG_MFC_IPCLKPORT_CLK__PMFC__CLK_MFC_D, 21, CLK_IGNORE_UNUSED, 0),
 	GATE(0, "mfc_ns_brdg_mfc_ipclkport_clk__pmfc__clk_mfc_p", "mout_mfc_busp",
 	     GAT_MFC_NS_BRDG_MFC_IPCLKPORT_CLK__PMFC__CLK_MFC_P, 21, CLK_IGNORE_UNUSED, 0),
-	GATE(0, "mfc_ppmu_mfcd0_ipclkport_aclk", "mout_mfc_busd",
+	GATE(MFC_PPMU_MFCD0_IPCLKPORT_ACLK, "mfc_ppmu_mfcd0_ipclkport_aclk", "mout_mfc_busd",
 	     GAT_MFC_PPMU_MFCD0_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
-	GATE(0, "mfc_ppmu_mfcd0_ipclkport_pclk", "mout_mfc_busp",
+	GATE(MFC_PPMU_MFCD0_IPCLKPORT_PCLK, "mfc_ppmu_mfcd0_ipclkport_pclk", "mout_mfc_busp",
 	     GAT_MFC_PPMU_MFCD0_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
-	GATE(0, "mfc_ppmu_mfcd1_ipclkport_aclk", "mout_mfc_busd",
+	GATE(MFC_PPMU_MFCD1_IPCLKPORT_ACLK, "mfc_ppmu_mfcd1_ipclkport_aclk", "mout_mfc_busd",
 	     GAT_MFC_PPMU_MFCD1_IPCLKPORT_ACLK, 21, CLK_IGNORE_UNUSED, 0),
-	GATE(0, "mfc_ppmu_mfcd1_ipclkport_pclk", "mout_mfc_busp",
+	GATE(MFC_PPMU_MFCD1_IPCLKPORT_PCLK, "mfc_ppmu_mfcd1_ipclkport_pclk", "mout_mfc_busp",
 	     GAT_MFC_PPMU_MFCD1_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
 	GATE(0, "mfc_sysreg_mfc_ipclkport_pclk", "mout_mfc_busp",
 	     GAT_MFC_SYSREG_MFC_IPCLKPORT_PCLK, 21, CLK_IGNORE_UNUSED, 0),
-- 
2.49.0

