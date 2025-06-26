Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAB21552FA;
	Thu, 26 Jun 2025 19:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750967453; cv=none; b=tjONUMYoH4kCbGSf7u077W33lADONZqWNHcbEJBNNxtTo5lb9/2VkOlk3LSjWDzCb1WgQX2KCBpPRjvK0intyLBrgqp5oMWTm/WMo8YCjmoekeQJjms9Hn4ZFOnL9HxWTUViBBdtI9mHmbG5XfHBohEs4Nx/OwntqbiMx8XSrHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750967453; c=relaxed/simple;
	bh=YViufr8wDcvR2AP3dS+wOtrVu/Rjl5g24coHgH/kfy4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Hipf4wXNV2Ttq4y75Q3tFpd2ZRYz5kqKDojmdyWlcokTKj7RaDfdT7tZ/98zBVASLe0tGJ98FHk8TfuaJgeqd9N0whNFvqkk8pRoZ9ZI61fs0FNVmgcKkS+BwbuycUc45uyXhQ4KunV07WpemHaFs23f39JA8FcFvRjIPbMTyAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=vwbBIqqE; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="vwbBIqqE"
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QFvBVk009049;
	Thu, 26 Jun 2025 21:50:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=0rlrS+BB1a4km1rs1/r4Dw
	n4U0O9ETz8kgdC8TDIbZQ=; b=vwbBIqqEhkvE27+fHaTNvB/Iz87u32du8q760f
	PLT5XZro5KM4JHJ0APaB2G7nR76CDXTW5zBdeAOwD4Rh41X8MaQR1ytK6a9iOM+p
	73eBWGv8UlOWZJEcxtC/QLmtbLBEpFXdCuqaC+GaLZsa0WQP/IFTqnaLQQC5Jecz
	HqvgUP0gxrqxuGaesLQHfR2cEoPrVyjy4ARKDsuwyKpgNXu6PkQ1edV9zfm2M8ZW
	qBjYQrhwjGE/6aGd76vLMO199DlmqyO4K1wDg9fnNGtNVc0tNlbHqhMXsKmWm//n
	6EOC7lsgouKMJaYMjbPoPoUlQk4TOeA3gRl7Yn7hbMocAkZQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47dm33ruyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 21:50:30 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id F3D7040044;
	Thu, 26 Jun 2025 21:49:31 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E0CE8BD23A2;
	Thu, 26 Jun 2025 21:48:41 +0200 (CEST)
Received: from localhost (10.252.1.90) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 21:48:40 +0200
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Subject: [PATCH RFC 0/2] Introduce ddr[3-4]-channel binding
Date: Thu, 26 Jun 2025 21:48:33 +0200
Message-ID: <20250626-ddr-bindings-v1-0-cae30933c54c@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABGkXWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMyMz3ZSUIt2kzLyUzLz0Yt2UpFQj46TktFQjS0sloJaCotS0zAqwcdF
 KQW7OSrG1tQDB4daQYwAAAA==
X-Change-ID: 20250626-ddr-bindings-dbe23bcfe299
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Mark
 Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
X-Mailer: b4 0.15-dev-c25d1
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_06,2025-06-26_05,2025-03-28_01

This series aims to request comments for the ddr-channel binding as I'll
need them for the stm32-ddr-pmu driver.
The V1 of the driver and a start of discussion can be found here:
https://lore.kernel.org/r/20250623-ddrperfm-upstream-v1-0-7dffff168090@foss.st.com

The first patch contains a base of binding, which I find sufficient for
my needs but perhaps you'll have suggestion for addition or rework as this is
mainly inspirate from lpddrX-channel binding.
As we can find the same property in the two channel binding maybe this can be
shared properties.

The second patch, that contains stm32-ddr-pmu binding, aims to provide an
example of usage of this ddr-channel bindings.
Note the "memory-channel" property which I mainly want to discuss about
and gather some feedbacks.

For your knowledge, the stm32-ddr-pmu driver (DDRPERFM peripheral) needs
the dram type information for its internal working with ddr events.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
---
Clément Le Goffic (2):
      dt-bindings: memory: add jedec,ddr[3-4]-channel binding
      dt-bindings: perf: stm32: introduce DDRPERFM dt-bindings

 .../memory-controllers/ddr/jedec,ddr-channel.yaml  | 53 +++++++++++++
 .../devicetree/bindings/perf/st,stm32-ddr-pmu.yaml | 90 ++++++++++++++++++++++
 2 files changed, 143 insertions(+)
---
base-commit: e34a79b96ab9d49ed8b605fee11099cf3efbb428
change-id: 20250626-ddr-bindings-dbe23bcfe299

Best regards,
-- 
Clément Le Goffic <clement.legoffic@foss.st.com>

