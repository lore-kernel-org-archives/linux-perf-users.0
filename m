Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E07F3A4F51;
	Fri, 12 Jun 2026 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255212; cv=none; b=memyWU2VlIiFaVqza1bpd0F7niiAVDe9v7iNVCc0rBeIjWrUDStomrzISEnlG3f85jyXM8jyBFEjFJ14PmJyyKvwrFP19pw8M6Hf5loYSZogd3fhJ7Hkdbh+KkrU9IpDacNMVpAdm5wlkMBxfCJAj0ti9uuH93QGwbeqC8hEVyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255212; c=relaxed/simple;
	bh=TgcV4h+TDwdSYWgyL6ihk3QjrMclAphRz9ZqbKtA7G0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GezKZyJEgQlDhUAp84tdB+h15lgbPbKFwhu+WWcEUxC4jTBqlbmGqyyHIfD3bCUjpapyYlSLIdgLjgqfkUFOYW/RCkPvcnwFt2lAIDu9xd0LDfCo0GMvUIhsF8WTGtyUWhaYsMpstd7YcnOJtd/mbvBpjZRltRlVJ6DLOZ/yoTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gm1eA/Ns; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gm1eA/Ns"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781255203; x=1812791203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TgcV4h+TDwdSYWgyL6ihk3QjrMclAphRz9ZqbKtA7G0=;
  b=Gm1eA/NsBXNGkhKeeszpP9wk63gzmfBOZ12AMdSXrLTpvDJjIv9qcAOA
   gYzR7iHyr2PMbc9OPv65qAsE1qiB8+jHsechgW1LwUBLaFKUQFJm8Ps8O
   uJxHLXvMK8/JDYz3yLR/xfkjO9gFdFgbh0cLf7T9J+K+acmaK9wiUcxsU
   mZLYT6ivj5D47a9hR6/mQAV9/txKjS/AaF9q9efIw3Eevi1BpD6esUTbT
   JAdayozzZV3AszCbmkW2JMq+wxOKGaPL0QEOD55FeRqkY5QxGM11IgR6E
   cK1j/9hYLZJkyBga6qqF83SBQhFlhkVsjNTcH/qgzQr2l5nsiDxI9/v2l
   w==;
X-CSE-ConnectionGUID: sjfF8hojT5Gh5Xz1st+YVw==
X-CSE-MsgGUID: HtbE5gDMQcScBtF1r/CeZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85714446"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="85714446"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 02:06:42 -0700
X-CSE-ConnectionGUID: l+7uiYUtRsSsiws1OG8gOA==
X-CSE-MsgGUID: MYiA/v6tQ4m8F/JxtcDOLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="246838706"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa007.jf.intel.com with ESMTP; 12 Jun 2026 02:06:38 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v3 3/8] perf/x86/intel: Fallback to sw branch type decoding if no hw decoding
Date: Fri, 12 Jun 2026 17:01:09 +0800
Message-Id: <20260612090114.3188886-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612090114.3188886-1-dapeng1.mi@linux.intel.com>
References: <20260612090114.3188886-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_pmu_lbr_filter() currently assumes arch-LBR provides hardware
branch-type decoding and skips software decoding on that path.

However, arch-LBR may not always expose branch-type information. In
that case, treating entries as hardware-decoded can misclassify sampled
branches (for example, defaulting to JCC), which breaks branch-type
filtering results.

Fix this by using software branch-type decoding when hardware
branch-type decoding is unavailable (that is, when x86_lbr_type is not
enabled). This keeps branch classification and filtering behavior
correct across arch-LBR configurations.

Since x86_lbr_type is only set to true when arch-LBR is supported,
it's unnecessary to check if the CPU has the arch-LBR feature.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/lbr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 72f2adcda7c6..e2657f791e50 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1231,7 +1231,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 		 * Doesn't support OTHER_BRANCH decoding for now.
 		 * OTHER_BRANCH branch type still rely on software decoding.
 		 */
-		if (static_cpu_has(X86_FEATURE_ARCH_LBR) &&
+		if (static_branch_likely(&x86_lbr_type) &&
 		    type <= ARCH_LBR_BR_TYPE_KNOWN_MAX) {
 			to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
 			type = arch_lbr_br_type_map[type] | to_plm;
-- 
2.34.1

