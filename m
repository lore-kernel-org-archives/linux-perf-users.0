Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429F42E7189;
	Wed, 23 Jul 2025 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753276149; cv=none; b=h4MOGJpi+oGegXvn3APBPJR4KVmCEmi1ac6YUOm3BRo5OTt1HonavjqjiN84FJ626vLiCipIASgLV5Cd+OSfagp9fI2VPB6nhAtv87TzxYM2NMJP8zfRB8Q8/j/VXNCxQ5JZ0ffdf82aWXn/EONS6eLrFHscgRWPWp/3nPlq1a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753276149; c=relaxed/simple;
	bh=Dq2ykfq63wn8VObJtf2Dtv3Y1KpLFKfxnczqmYre38w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fSZkZs/OL5P1QvOP7sa+j0zWPMNy2XMS7+fF04tbAhkYVX22w0fUJWq0449xEw1zE3oXnBjJxST/kLb5y2998nSAm6CSoAiQ4BPwsfJsmM37bDEGnNeOmQfbkM4z7hYSqGLgknt/AFSTgw1CKCcfjkN9eGTSBn6wn1z1La68RkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=dJLNOjol; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="dJLNOjol"
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NCBtaH029998;
	Wed, 23 Jul 2025 15:08:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	1S+/fxjBGM9OThOsnlJiBdnI+RCOnybmlz6yPJOrPUQ=; b=dJLNOjolwwDmlCBx
	gnkUS3FH/4+1cXbUqQswS2fg2KXlB9Ai9aJMvO++J76D/LviTJ4WGbZFf3NouS0S
	tubNqITNOUp6xAWaXExM3ZnuLFmQkkhXwjRe2VKlJONg+anQiuGtj9M3/z9twR4R
	hgkx+9BWX2K2WJ8nmeFnnGZm3XdXI3mI0FLltGkWDp9pa9FYNuqTREZL74IuVL8E
	J5SsvPK0wI7LZU0hNtlkGhqSY7sta1uCY4U2w5ekIXPTgsYi0t5GdMeJ89xtDE1x
	i6aaAnorWm+U36BPCEoOFMYknyeqArmWs1jXAmefAPVGgzfOCpKgYXSDxSIgTq1E
	uYO8jg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 480mx4s4gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 15:08:46 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4461940045;
	Wed, 23 Jul 2025 15:07:25 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BE9007961D8;
	Wed, 23 Jul 2025 15:06:03 +0200 (CEST)
Received: from localhost (10.48.86.185) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 15:06:03 +0200
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Date: Wed, 23 Jul 2025 15:05:45 +0200
Subject: [PATCH v4 01/20] bus: firewall: move stm32_firewall header file in
 include folder
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250723-ddrperfm-upstream-v4-1-1aa53ca319f4@foss.st.com>
References: <20250723-ddrperfm-upstream-v4-0-1aa53ca319f4@foss.st.com>
In-Reply-To: <20250723-ddrperfm-upstream-v4-0-1aa53ca319f4@foss.st.com>
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
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01

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

