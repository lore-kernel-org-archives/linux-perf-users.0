Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A9923E324;
	Mon, 23 Jun 2025 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750671012; cv=none; b=pWR98jYrsXFaWSDIYIydkLONaCkg9uA6z+pgu5l+KU96svIL9BeBhjd6nQzBuOOjObZ3Qn37Dho3ls+vec8Xebsk5x5/kOmhHPNoUujgQsh0APAz87HgDum13mFgxvoLkpX0o60aMWVtRopgrcW2pGfj8fNz+TF+cKsnKfN8sQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750671012; c=relaxed/simple;
	bh=C7EnqfKQQ5fQB9pf3iXHh9xmgRkHyNyUGfDlPdr64AQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JXTzVchCktEcPVc67rtchVjTnZ19bMpf4nn/bZqfJtJsKbTY9zIhwfWErlhEYJtO2CgNHl67YYtJ7OzvXERbTlzRzjnL+i6Iepdg7pBANj4ptPObwqetEBaof9vUetXo+RxUTpPC+kqNQW3BAVpjOQz7hV6ebq/CFQe4aNQASBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Z+2q4qKV; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Z+2q4qKV"
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N9ACnK010876;
	Mon, 23 Jun 2025 11:29:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	qLs/ihWxyBQGt91t9+rNI5uJsOv140RQYF6cNc+ahBI=; b=Z+2q4qKV4f0Z8LEW
	m4tCtpd19msC3UE1sCaRH7+UOcDnCAJE5ykaAVF1M8mC8hToHLPqcp4VCPtVhGqz
	lnBET+Scj9UquCsRusQn2PLbkzvB2a5MulzLsUMyY0QvSOGpQ/fKuJMStQAgb9Zw
	W+Yvk4xgWyWbVYyGbqbhnLZKCeglJqRDHBiQcHgLSg+xiBSbdvAPCOsirlCKL4uK
	0/hISR+Y6bJJ/qUiiF4BTmTZON7bshzt7i5rOxbCkKQfFQoEcE0v9fzw83w8oPGO
	EVQO1hZxBg44ggyVbzhRmPhcAf3ybjAaroSPf4BgV+JzADBgSfNFba57mcefpez2
	OJb4qA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47e6a6cjq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 11:29:52 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C789240058;
	Mon, 23 Jun 2025 11:28:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0C6135C3DEC;
	Mon, 23 Jun 2025 11:27:33 +0200 (CEST)
Received: from localhost (10.252.18.29) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:27:32 +0200
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Date: Mon, 23 Jun 2025 11:27:18 +0200
Subject: [PATCH 13/13] arm64: dts: st: support ddrperfm on stm32mp257f-ev1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250623-ddrperfm-upstream-v1-13-7dffff168090@foss.st.com>
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

Configure DDRPERFM node on stm32mp257f-ev1 board.
Disable the node as DDRPERFM will produce an error message if it's clock
(shared with the DDRCTRL on STM32MP25x) is secured by common bootloaders.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 2f561ad40665..a48fb7b33198 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -123,6 +123,11 @@ csi_source: endpoint {
 	};
 };
 
+&ddrperfm {
+	st,dram-type = <2>;
+	status = "disabled";
+};
+
 &dcmipp {
 	status = "okay";
 	port {

-- 
2.43.0

