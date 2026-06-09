Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C77A33A70F;
	Tue,  9 Jun 2026 05:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780981678; cv=none; b=UNC8mZoixhenFo0fYy9UOwZLSmUtx34kzfj0Q2HxmIsi/tRiCJEfXJKgwdKGBzXUO8fG0/JrVU+EcDMS+FwuRd8duQij+s2PaDUDJR/N7Y/e3MgvKuq5B7Jj/SKySD9P4tMXHUcZp4T3IPmFeytn/8W8jsOsRGJoE9WQ6HcsETE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780981678; c=relaxed/simple;
	bh=nDHD6UjWUVeSYIOutoCFgsPSCHYKOhdzyOQFsCJ7aGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E5hZSx601cya45OvB/g4gzof06bCsLhFO04L79sQrFvsNGvsfObvqyZQa2ZYMW//uUkEVQX7tJOcoDQmMXl3rl93u7d9DwbAXqLW1aVpDUKTyvt7ARsTM9ps0WYRrXuaQbrQGyZiC+/PS8rccAguTvW0frP3kPPMVaSL+vDi9js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QCeALiQ5; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QCeALiQ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780981677; x=1812517677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nDHD6UjWUVeSYIOutoCFgsPSCHYKOhdzyOQFsCJ7aGM=;
  b=QCeALiQ5WMIAcP+ZAAkMSaVVYHtF/f4CwXEt6ar6PdYP/OJcY7R1ZjIs
   /UYhJmw1jxJ2J43QXbiTZtGdWQcwdW269c3nnZt9/pcLTzLD6vxQbt1El
   tCtpEvS2ueviE6OKZbqaK8w3k7zv9s37PvTy3pUbDUW+zGVDyGqP0270O
   /7Gbjc4zy6Qlv2urDPt366xzmqOh/+FOLA9LMA5UWNSxnqNw1S8wCamgU
   oi+QMyjHWsScC5XKPO4cf1F2I0xkwcLE5GeXH4DnGLwLYR7Ig559WTbuF
   ZdCzSB3Yro3sliMblhG1Qurk034rqVNObpvTaENyDT8fD71c9jISskLT1
   g==;
X-CSE-ConnectionGUID: UaRLD49JSUCIPKS7S1SPTg==
X-CSE-MsgGUID: Fu3B0TKKScmoAP+GuKpvPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81586168"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="81586168"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 22:07:57 -0700
X-CSE-ConnectionGUID: F/UbhwLiQJqSVLnf0KePIA==
X-CSE-MsgGUID: HXUgg7iETDKbNLCFPFbhuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="283838910"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa001.jf.intel.com with ESMTP; 08 Jun 2026 22:07:53 -0700
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
Subject: [Patch v2 4/9] perf/x86/intel: Fallback to sw branch type decoding if no hw decoding
Date: Tue,  9 Jun 2026 13:02:17 +0800
Message-Id: <20260609050222.2458129-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
References: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_pmu_lbr_filter() currently assumes Arch LBR provides hardware
branch-type decoding and skips software decoding on that path.

However, Arch LBR may not always expose branch-type information. In
that case, treating entries as hardware-decoded can misclassify sampled
branches (for example, defaulting to JCC), which breaks branch-type
filtering results.

Fix this by using software branch-type decoding when hardware
branch-type decoding is unavailable (that is, when x86_lbr_type is not
enabled). This keeps branch classification and filtering behavior
correct across Arch LBR configurations.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/lbr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 72f2adcda7c6..d4c0ed85e1fb 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1232,6 +1232,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 		 * OTHER_BRANCH branch type still rely on software decoding.
 		 */
 		if (static_cpu_has(X86_FEATURE_ARCH_LBR) &&
+		    static_branch_likely(&x86_lbr_type) &&
 		    type <= ARCH_LBR_BR_TYPE_KNOWN_MAX) {
 			to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
 			type = arch_lbr_br_type_map[type] | to_plm;
-- 
2.34.1

