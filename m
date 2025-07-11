Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE142E9EBF;
	Fri, 11 Jul 2025 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752245504; cv=none; b=J5Roc5RGMjptM1ZHvzEVQlKWezPO/cH+71vXqqVD4/aA1LzePmgsFRPvgsmfm/IELx4217dxD/zVWOXUgSJp3RxhrwYwDvnUV8vBoNRL0tL6W1BfWEUw58z8ga47rvZ4vrllIm0kz9QvVAV57Kh6Fg3ScQexAu/XwNDmMnRCx+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752245504; c=relaxed/simple;
	bh=Dq2ykfq63wn8VObJtf2Dtv3Y1KpLFKfxnczqmYre38w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JOICdvCpRAjB9dedxhK/3t6mHCnLYl0LJ4stFIPjCMWO/6s17B97HT5x8kFDolZFSHPa/o9yUnivFvLp0qEWteQdgPRHYoY+EtEAI9u/sKzIA8UISV4SiC6M2uPLohoMKrDkvn8Fy2jT1ugQuXb51BS44kK1SS0Af2qIUCaHW1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=zEfrgD58; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="zEfrgD58"
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BEncdU022508;
	Fri, 11 Jul 2025 16:51:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	1S+/fxjBGM9OThOsnlJiBdnI+RCOnybmlz6yPJOrPUQ=; b=zEfrgD58iQjnGk67
	auh5vjzFlbLNa57MXCDGAFyM7/PNPv/3Csz7zEAB8Gsl/Ptj+d5ojbTylESZCvOg
	lP3Oq0EJt9H+0P22p7pQDbiPDpkMWJKhqiQJLu8V8vZ2BOPRQtO2ZAw/qmhlHKn1
	wK4A0DDZYA+H9YuHYj8ZKjLWWCIl+SM17Z5cyZ1rTMbSHaSotmpsnLDKi3ILkfFH
	0r9vdOZDwqXD58xDKKISIXGVSk6kFjDjLk1FiNrKP0MPd3IaHWekwSppS7BgSCu0
	Y6hv1RIDAr5UxQFUQIQB78dhijr+2si7MtgoMhQ6d9NgCWu89oU2B+NRgm7GTuFD
	U8IjPQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47qf0q4duu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 16:51:13 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C3E4C40052;
	Fri, 11 Jul 2025 16:49:54 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 18C93B4A8CD;
	Fri, 11 Jul 2025 16:49:13 +0200 (CEST)
Received: from localhost (10.252.16.187) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 16:49:12 +0200
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Date: Fri, 11 Jul 2025 16:48:53 +0200
Subject: [PATCH v2 01/16] bus: firewall: move stm32_firewall header file in
 include folder
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250711-ddrperfm-upstream-v2-1-cdece720348f@foss.st.com>
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

Other driver than rifsc and etzpc can implement firewall ops, such as
rcc.
In order for them to have access to the ops and type of this framework,
we need to get the `stm32_firewall.h` file in the include/ folder.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
---
 drivers/bus/stm32_etzpc.c                       | 3 +--
 drivers/bus/stm32_firewall.c                    | 3 +--
 drivers/bus/stm32_rifsc.c                       | 3 +--
 {drivers => include/linux}/bus/stm32_firewall.h | 0
 4 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/stm32_etzpc.c b/drivers/bus/stm32_etzpc.c
index 7fc0f16960be..4918a14e507e 100644
--- a/drivers/bus/stm32_etzpc.c
+++ b/drivers/bus/stm32_etzpc.c
@@ -5,6 +5,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/bus/stm32_firewall.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -16,8 +17,6 @@
 #include <linux/platform_device.h>
 #include <linux/types.h>
 
-#include "stm32_firewall.h"
-
 /*
  * ETZPC registers
  */
diff --git a/drivers/bus/stm32_firewall.c b/drivers/bus/stm32_firewall.c
index 2fc9761dadec..ef4988054b44 100644
--- a/drivers/bus/stm32_firewall.c
+++ b/drivers/bus/stm32_firewall.c
@@ -5,6 +5,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/bus/stm32_firewall.h>
 #include <linux/bus/stm32_firewall_device.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -18,8 +19,6 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 
-#include "stm32_firewall.h"
-
 /* Corresponds to STM32_FIREWALL_MAX_EXTRA_ARGS + firewall ID */
 #define STM32_FIREWALL_MAX_ARGS		(STM32_FIREWALL_MAX_EXTRA_ARGS + 1)
 
diff --git a/drivers/bus/stm32_rifsc.c b/drivers/bus/stm32_rifsc.c
index 4cf1b60014b7..643ddd0a5f54 100644
--- a/drivers/bus/stm32_rifsc.c
+++ b/drivers/bus/stm32_rifsc.c
@@ -5,6 +5,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/bus/stm32_firewall.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -16,8 +17,6 @@
 #include <linux/platform_device.h>
 #include <linux/types.h>
 
-#include "stm32_firewall.h"
-
 /*
  * RIFSC offset register
  */
diff --git a/drivers/bus/stm32_firewall.h b/include/linux/bus/stm32_firewall.h
similarity index 100%
rename from drivers/bus/stm32_firewall.h
rename to include/linux/bus/stm32_firewall.h

-- 
2.43.0

