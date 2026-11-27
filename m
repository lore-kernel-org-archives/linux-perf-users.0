Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.139.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795757846;
	b=fglVIAG+B5+VoEi6G6QypiO0fNdGqpLM1WeFf0SNclngakLRPJB0auc9lqIR+E0e9uio
	 Cgj3n9rWUh6YFjFPtgQ1FgnZq14/Rot3zqS4geo+TJn8JxK1qjpV748EQStiYYCmq9K3z
	 4MYJjOHLto54LYwl+n89egEWhNgFDNzjKEB7IxFAULUp4SM/fgVa/PTqpqDgK6WnvE3Ad
	 GKpjJCiCf+pmRwcf2UbO9Cp9V1e0M6thBVNr5juL9Oa/4T8F39lx6BO6uRSkUS2Kz8cs8
	 VEW/jDMm+j8A+b3p7ESGvZXfKBmZ0rEjycmBqK7FmdPto5+Nylcl8Ct73jnDldXpclA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795757846;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=tVnybqfQP+0SY9toa390RewPeBuG9wb3MHioOA0atLc=;
	b=iemrgyYbAqoI6GbSsKJnoodrfINi9KkEM0u4B7QQLoZ2LPj/XqkO/j8yJrKlxcExmgmr
	 HwnzCWSrZEU4+p4ai4L//yldkcfUoRWUFY31wF1DbB6XUU2xRs9rg9hpbm2pXN/Ftd0Ip
	 mzS/h7mxNXEe+P+WXam2rjhS+WrHt6cW2c5dV62skyh9fL09tZHxZxc67og4vmxzGlwF7
	 4ZVdwn9Gjqe1rqLDG2lZwJ2UuNCXn+oaObataZ8FOhN6mxrzu4EMrKnOMqvC96RP8uHu7
	 2Dx0wVB3hUg3mnIhuBZVsEO+H60oZz2KLtoTRuJhKs2jRxD7Z/YMizSENDLUO50NjxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fujitsu.com;
	spf=pass smtp.mailfrom=fujitsu.com;
	dkim=pass header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=DWSt6B3d;
	arc=none smtp.remote-ip=68.232.139.139
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A793606A321;
	Fri, 27 Nov 2026 05:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A793606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=DWSt6B3d
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1795757854; x=1827293854;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=t70F907DzW+0QdbW9r0saLortrOhZdjwwGxQU9dlVtE=;
  b=DWSt6B3dRzUL3QYlKn11chp/eWR0Udmw84e4LaU0r6Z3dxYEBgVk9nNs
   WnA88YhD9+2NV5w12ZmUw3F9TfJP1ig6BrsQeA/fMaLKpk6u5tvVFT4Uc
   7Me8NyBYkQd9/shZ5i3UmXXzs+3Rcs0Y/7ZGbNEXdgTtI6uPpuFUyLQov
   FC5U+JkkO4ljzorR26JAe/tqRKK+H2zY+JQ7h7SR2Ap0d7Qpy4Xir5uKj
   gIRc2SMTJpPhb/auhR3Fabir7noRBhI8NAgVXzsfGPEActd2s+C3g/9Lm
   VIlJTRrsvlCq/frAZgs70hWyOFrprEprs00BaoElJ3e803c5QbaGOrhT2
   w==;
X-CSE-ConnectionGUID: lb/5sm0qTdyYf6qGwErJgg==
X-CSE-MsgGUID: n8nL48JYRAam669t+3gZ3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="267417303"
X-IronPort-AV: E=Sophos;i="6.27,236,1786978800"; 
   d="scan'208";a="267417303"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 14:37:26 +0900
Received: from az2uksmgm4.o.css.fujitsu.com (unknown [10.151.22.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id 494C51002B91;
	Fri, 27 Nov 2026 05:37:18 +0000 (UTC)
Received: from az2uksmom4.o.css.fujitsu.com (unknown [10.151.22.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm4.o.css.fujitsu.com (Postfix) with ESMTPS id F3186140062C;
	Fri, 27 Nov 2026 05:37:17 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.124.178.20])
	by az2uksmom4.o.css.fujitsu.com (Postfix) with ESMTP id 7952E4045EE;
	Fri, 27 Nov 2026 05:37:10 +0000 (UTC)
From: Tomohiro Misono <misono.tomohiro@fujitsu.com>
Date: Fri, 27 Nov 2026 14:36:30 +0900
Subject: [PATCH v4 1/5] arm64: cputype: Add FUJITSU MONAKA definition
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-monaka-fix-for-upstream-v4-1-3395c415bbe4@fujitsu.com>
References: <20261127-monaka-fix-for-upstream-v4-0-3395c415bbe4@fujitsu.com>
In-Reply-To: <20261127-monaka-fix-for-upstream-v4-0-3395c415bbe4@fujitsu.com>
To: Tomohiro Misono <misono.tomohiro@fujitsu.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Marc Zyngier <maz@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Oliver Upton <oupton@kernel.org>, Fuad Tabba <fuad.tabba@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Kohei Enju <enju.kohei@fujitsu.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 kvmarm@lists.linux.dev
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795757822; l=1299;
 i=misono.tomohiro@fujitsu.com; s=20261002; h=from:subject:message-id;
 bh=t70F907DzW+0QdbW9r0saLortrOhZdjwwGxQU9dlVtE=;
 b=uo0E+IarAjICrItkUNTDd7YTIlhjU6ClHbTKnjkdDTYC46jtdai+Js7t6184fHECST/PbUykE
 3NjjP4RzVEJBpj6YuT6vkUmsuxQSty4FTJX+cRWdyn9/LvpiSBkC6aW
X-Developer-Key: i=misono.tomohiro@fujitsu.com; a=ed25519;
 pk=VLRxj5y4GJrHLmj3e2NBg30fX2U//ydi7c2G2qiNo10=

Add cpu part definition for FUJITSU-MONAKA.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Tomohiro Misono <misono.tomohiro@fujitsu.com>
---
 arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 6002d1d5f55f..fff0f460f43f 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -139,6 +139,7 @@
 #define NVIDIA_CPU_PART_RIGEL		0x011
 
 #define FUJITSU_CPU_PART_A64FX		0x001
+#define FUJITSU_CPU_PART_MONAKA		0x003
 
 #define HISI_CPU_PART_TSV110		0xD01
 #define HISI_CPU_PART_HIP09			0xD02
@@ -237,6 +238,7 @@
 #define MIDR_NVIDIA_OLYMPUS MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_OLYMPUS)
 #define MIDR_NVIDIA_RIGEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_RIGEL)
 #define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
+#define MIDR_FUJITSU_MONAKA MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_MONAKA)
 #define MIDR_HISI_TSV110 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_TSV110)
 #define MIDR_HISI_HIP09 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_HIP09)
 #define MIDR_HISI_HIP12 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_HIP12)

-- 
2.43.0

