Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792559680;
	b=FD/rh8DGrHQBKi5mV4CFhN2SKU8x68TBA9eRVirrk3Jy7veSNrWnXbftGKV/+346YYXz
	 3MGLmyLWrC7olaMXliWNSTBzSMJqoOjxLkv6DAzxHsf4Wg5OLnwYj2zOzmB8Krxx0v0+6
	 daEqP40nk4kI9SBwp5kH+8joqWAkTkowrhoHtlJpefJyZD50bkoNsg8PZvImN/cs38JaC
	 Zzd4n5Ggjp44yTrcfQ3pEGTtDFwFB3n5RbcrsM0DYAgvSGlyV29m99QFzv6gP4akMm8Lp
	 JtmGCdZInO6lhRoO1f/C7vs+oldnPkJOkaZPTsh3ll70ZKmoq2lBTARrjQu2azmMpAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792559680;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sRxJJgbQ9OeJgYU/4XPFpyRrBhXe4A3xExtO82wV5Go=;
	b=KCHOYiqxd8EBDvfwIW4z+zqDyL/UjkldcT8X2FDoem3wALz21YDslwLOke/EZXjjqBZe
	 9VMeXHiPJi6C+KFaWisZ8UJxRGwR63GDro+6zkUDpsEL1JZiwt6kbR8HdLWdt9VaFPtTc
	 Eg9qiymPm+VmP8tVMaZy3K9v4PSFfWs1G60RuxjeXB6sEnSy3Psi6e5D5cXTmQh7bZHPW
	 cv84JJzQ4U2knuU1ss8fUPkQP5aCWlh1s4KQH2K8yNMjsMcJHArTrmKVAX+TGRvCz7/Eb
	 AoXw7G7MVn2Z1IYTi/0aRJ0ZSrYLdZWXRsHc/BwgbWsGGMXN9hWVfDNTcujQejo9GpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TbQJ0O4S;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ED7606A328;
	Wed, 21 Oct 2026 05:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63ED7606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TbQJ0O4S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792559681; x=1824095681;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/bkPznTSqcmE+Ex6XLZG5cAnqmia67qDAZAGmCMxsBY=;
  b=TbQJ0O4S3l2RD3w0CDD/i5z/PBA90xbWgm75J49iBDw15Gr5Du1+wSwt
   INJ/3vtMU3hhM/agqvgvctkppY0KQidMYX0qudssXi+tfoNm1o6txP4iz
   hptKmmSVNBFKB0lUtC/tjXR42sJv+n3bSlNvsKX3zcUnMVlAjuLpAJIlP
   aav0Bjj3qca3RU77bKX1VcbVOpSXj35bdOUYg23/GLIx2/HVMB2OZ0yov
   ODmvLE2DN/KCgcZjVzPO2inR/X7m61p/Eo289XxU8/fmmJ6gAcJ5eFpF2
   meU3Xq1q5eFPC2VbJo1nWMG+QVatE64kNb528qEJYS2ZbkSuYIV4KOmHo
   w==;
X-CSE-ConnectionGUID: 9PJOWCUXQ+qlyYT8I0GPVQ==
X-CSE-MsgGUID: Vrq53lDbQJ2hf0u3f7JmRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1149185"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1149185"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 22:14:41 -0700
X-CSE-ConnectionGUID: 8wmwMa0JRoq0QYQWsNaVvA==
X-CSE-MsgGUID: cnoRqmHyTu69qE4D3Xdm/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="2947665"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa005.jf.intel.com with ESMTP; 20 Oct 2026 22:14:37 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v4 3/5] perf/x86/intel/lbr: Reset the cached LBR stack in intel_pmu_lbr_reset()
Date: Wed, 21 Oct 2026 13:07:09 +0800
Message-Id: <20261021050711.4043703-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021050711.4043703-1-dapeng1.mi@linux.intel.com>
References: <20261021050711.4043703-1-dapeng1.mi@linux.intel.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reset the cached LBR stack in addition to the hardware LBR register file
when intel_pmu_lbr_reset() is called. This prevents stale LBR data from
being reused after a context switch or similar transition.

Also adjust intel_pmu_arch_lbr_read_xsave() to update the cached LBR
stack only when new hardware LBR data is present.

Fixes: c085fb877467 ("perf/x86/intel/lbr: Support XSAVES for arch LBR read")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/lbr.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 0b446d8912e4..c7e295db9410 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -193,6 +193,8 @@ void intel_pmu_lbr_reset(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
+	cpuc->lbr_stack.nr = 0;
+
 	if (!x86_pmu.lbr_nr)
 		return;
 
@@ -1012,7 +1014,10 @@ static void intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc)
 	}
 	xsaves(&xsave->xsave, XFEATURE_MASK_LBR);
 
-	intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
+	if (xsave->header.xfeatures & XFEATURE_MASK_LBR)
+		intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
+	else
+		cpuc->lbr_stack.nr = 0;
 }
 
 void intel_pmu_lbr_read(void)
-- 
2.34.1

