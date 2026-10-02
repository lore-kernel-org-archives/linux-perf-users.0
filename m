Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F4A2AEEB;
	Fri,  2 Oct 2026 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936894; cv=none; b=umv7tpwi+w3zCc7fLDqf/uH7OvqU7xicRj46+1BeudHgmznxXAQDSvTideG542h/IcxQeovByktkeQ7c4kCpF82OnYNmPJrezFLQa+zBtHI8+G4FHPqM/u1hhBS7c3ZMQmy69EKUG62YtRe/f5Qo1QPylwNdXk3Nma1vfr6S+F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936894; c=relaxed/simple;
	bh=HvjQ+Rk40qOIm9mo8ia6lTFXzNLel1Ows72ZgD35JU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OEf3E4YpZbYW7b3N8wCWPo7MqW5RCZ8nLBYuuMcCX4tUEWNt/iAZJkuyuEG5WmSpVwFVt4b8AEYcMpFFuR4UMt3D4x8HWww5UUlFA0PwOBx03nBVE86MtXFpehWhUDyUIzzkjAoOIPuffXr4PQMdXJ503O0RjDB5g8T/wxtwP3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=GLEdxB+i; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="GLEdxB+i"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1790936892; x=1822472892;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=HvjQ+Rk40qOIm9mo8ia6lTFXzNLel1Ows72ZgD35JU0=;
  b=GLEdxB+iTAppnbv0KXV+QXOZ3J8lUozRycQMQpyxZEfrB+GX5XDoEcn6
   +BAwsMlyKgNLOOi8liQY0KI1uQLGqRWBvUvLcRvxjHRmNrg/uL5+uUfZ8
   rFK1n2A/E4xqdCtbr/+JuobvEP8PoaIVb9qBiTwoeaS6rTFLCoH21+J8J
   QMxAGmgVT7DJNonpl6rHYMR3uFu1/g9gVjCDE+MxfX/DlGeMGoEL1XDFS
   /7ZIJod6JnhuKrxkFPoStrY0dhU6Anpuq8fNFozXcl3Bey2MRvgp7adpv
   +jinjjlOrQOFogC6t0f/ie04K/Kt4U0pH5EFq9w2/JS5Y7L4lKpnHNBMd
   g==;
X-CSE-ConnectionGUID: lgiGaAHxT5eN4yKqQ1H8rg==
X-CSE-MsgGUID: m92ZEdr9TwOx9Fkdzs1q/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="256956430"
X-IronPort-AV: E=Sophos;i="6.27,136,1786978800"; 
   d="scan'208";a="256956430"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 19:28:03 +0900
Received: from az2nlsmgm4.fujitsu.com (unknown [10.150.26.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id B08391000347;
	Fri,  2 Oct 2026 10:28:03 +0000 (UTC)
Received: from az2nlsmom4.fujitsu.com (unknown [10.150.26.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm4.fujitsu.com (Postfix) with ESMTPS id 64E671004163;
	Fri,  2 Oct 2026 10:28:03 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.124.178.20])
	by az2nlsmom4.fujitsu.com (Postfix) with ESMTP id 540942018B2A;
	Fri,  2 Oct 2026 10:27:58 +0000 (UTC)
From: Tomohiro Misono <misono.tomohiro@fujitsu.com>
Date: Fri, 02 Oct 2026 19:26:49 +0900
Subject: [PATCH 1/4] arm64: cputype: Add FUJITSU MONAKA definition
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-monaka-fix-for-upstream-v1-1-4aec0b0cbe34@fujitsu.com>
References: <20261002-monaka-fix-for-upstream-v1-0-4aec0b0cbe34@fujitsu.com>
In-Reply-To: <20261002-monaka-fix-for-upstream-v1-0-4aec0b0cbe34@fujitsu.com>
To: Tomohiro Misono <misono.tomohiro@fujitsu.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Marc Zyngier <maz@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>
Cc: Kohei Enju <enju.kohei@fujitsu.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790936872; l=1256;
 i=misono.tomohiro@fujitsu.com; s=20261002; h=from:subject:message-id;
 bh=HvjQ+Rk40qOIm9mo8ia6lTFXzNLel1Ows72ZgD35JU0=;
 b=PT/2bczWTHPh+YbXoztDgvLhcaFSSU3/j9P+tSfd1xJariCWXTyjJxPMEI7KFfecJjOT4VorY
 wM4k8oN9UWSCD2z/KXUzlE1TAEFJXeuiK3IiNjg6dhZZYuLdzCZPZpH
X-Developer-Key: i=misono.tomohiro@fujitsu.com; a=ed25519;
 pk=VLRxj5y4GJrHLmj3e2NBg30fX2U//ydi7c2G2qiNo10=

Add cpu part definition for FUJITSU-MONAKA.

Signed-off-by: Tomohiro Misono <misono.tomohiro@fujitsu.com>
---
 arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 1fa29616e586..3f648cb10e61 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -138,6 +138,7 @@
 #define NVIDIA_CPU_PART_OLYMPUS		0x010
 
 #define FUJITSU_CPU_PART_A64FX		0x001
+#define FUJITSU_CPU_PART_MONAKA		0x003
 
 #define HISI_CPU_PART_TSV110		0xD01
 #define HISI_CPU_PART_HIP09			0xD02
@@ -235,6 +236,7 @@
 #define MIDR_NVIDIA_CARMEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_CARMEL)
 #define MIDR_NVIDIA_OLYMPUS MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_OLYMPUS)
 #define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
+#define MIDR_FUJITSU_MONAKA MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_MONAKA)
 #define MIDR_HISI_TSV110 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_TSV110)
 #define MIDR_HISI_HIP09 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_HIP09)
 #define MIDR_HISI_HIP12 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_HIP12)

-- 
2.43.0

