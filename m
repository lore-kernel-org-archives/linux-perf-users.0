Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176B0238C09;
	Mon, 23 Jun 2025 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750671019; cv=none; b=hTIi2cX9zOXbqxNu6UO2xELtpmclPtMjFlGJ+3c5IF7V8bpSVESADwZ76WVyNx8XfvWq+nE8EyI1gbVF7cReZfOfXnULm0E44e2Bi2Vc1nwVFxYuBPOFPVbB9ZD90H7mIz3ZMTBCFHZ2J8jSidwpu5XJ14WeQKzmhEA3v7l5gZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750671019; c=relaxed/simple;
	bh=eC5DTlfNVMfG44OCEWsxiMdL6lZhTGPuEYkXHWK7M7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=T/mH+x6OEYwfZhxxfjsfRzn9fEOpPk8alEbZNAYF/lUzqJ11HtjMlWNaPPGoJuTKBmcF41r2c3vYFReZSYucMj3vrdPk8izKSYNqredD5bUyUfNl+Z81Ch82HHN/C2QP9el4agGhQioskmUsn4pwD6Uak9W4pNljxH/x7xXSq10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=TLmOwndv; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="TLmOwndv"
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N7hfSA011850;
	Mon, 23 Jun 2025 11:30:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	pTsJ/+q2VqHoq0n9xQoDMSflxAq/mEpvyBw7OSlMNVw=; b=TLmOwndvBslAgTa7
	TRp1M7ievNHL7EPTswHRzuAHl8ZKIZ+qVBhFC4noOmeYaRSsKV3dnqH4mh5iqOJC
	7grku4sOD0xJg0yqyOi52ypfCYt0jDzN9YCG1GlsZ09l9mwswuy5S97f/eiX3CFT
	VuXoFfNNNOcyKcrNN2DIMymw+UCZLapQ2Eh77M+XHihruAKV/MkSn0A+A++E0r5i
	y1CGuHWeZFRKNhoR4wM7k5HTZCgmcndjogKz1RamJkOiTCirWQI8pNqcf65qql50
	kdMwWL81GtlIO/a2iFSbNhwWjGBghmRa82teXLkp+tdYtNFAzYMLXKtAFhezZL/5
	QdVLOw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47dm3372rk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 11:30:03 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3113440057;
	Mon, 23 Jun 2025 11:28:38 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6856E5C2DF9;
	Mon, 23 Jun 2025 11:27:28 +0200 (CEST)
Received: from localhost (10.252.18.29) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:27:28 +0200
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Date: Mon, 23 Jun 2025 11:27:13 +0200
Subject: [PATCH 08/13] MAINTAINERS: add myself as STM32 DDR PMU maintainer
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250623-ddrperfm-upstream-v1-8-7dffff168090@foss.st.com>
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

Add Clément Le Goffic as STM32 DDR PMU maintainer.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c3f7fbd0d67a..4211133e731e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23451,6 +23451,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
 F:	drivers/power/supply/stc3117_fuel_gauge.c
 
+ST STM32 DDR PMU
+M:	Clément Le Goffic <clement.legoffic@foss.st.com>
+S:	Maintained
+F:	Documentation/admin-guide/perf/stm32-ddr-pmu.rst
+F:	Documentation/devicetree/bindings/perf/st,stm32-ddr-pmu.yaml
+F:	drivers/perf/stm32_ddr-pmu.c
+
 ST STM32 FIREWALL
 M:	Gatien Chevallier <gatien.chevallier@foss.st.com>
 S:	Maintained

-- 
2.43.0

