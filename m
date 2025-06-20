Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3304A22A1C5;
	Fri, 20 Jun 2025 07:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750404555; cv=none; b=rB8zlRDOfNOHR8u7tbHigVCVXr7LDEM4NkXP8CnCJ2pX9rlxwYUWaijJDfFyl/bBd+ipVfAF4Ip7Av2rOC6KdwQDnJs51M3zuwj0thxk7pqCMSqqNBUBiLFOLBTz8BEqvX8iV7U3zokvqc2EWmt7Tm3qasxpGot5jicfGDgaNfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750404555; c=relaxed/simple;
	bh=1FgyooF1UgSGPehol8a3BixQFNO/i+15be0OWZgITUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c4msQD4TiJYhPVVxuBpKR3806+lbriGafhOMyH8FcCKu5Xav/V2j4SJ5jItji594iTIKP+SMeKlOQrKkl3bDTwSBJkj+J5ijAZ9dmhzq2RvsMbWWHFzkZ7TDupbXhrmPTAbhMKWn2OkVKu+gNJaoaWi4dW4D9c/6b2dY+BdRwd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aPN49NNN; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aPN49NNN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750404554; x=1781940554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1FgyooF1UgSGPehol8a3BixQFNO/i+15be0OWZgITUo=;
  b=aPN49NNNmX4D0sVqo55k8nuq1lvQiPYkbN88GgkOmK2wdVkWWoL/hZcs
   HnXCWaJXxaVPYMpIlO0w8BxPXsZX0gv7I8Nfnd2NDxW6l5zrPRLW65m7w
   ZqG2/KfuFapY1HzEqB7FdcUqkMT0jeJolFl8GLHMk+j/nuAM+m7trkynl
   Sn9fqwUVGvA0bS/otVZI9N8RKo623ePINQ5q60TQBxpoXSl+/WXh3KqwI
   0BpUZt/e39MCTxXauIilZ7nt1leOp77YA1Q1niUkLeAswAGjR21VtHxaA
   LSGr4s00VONVPKVO93WszeLVgVh8PZuyxF6vkgY2AhYqdfXEye31fJDbE
   w==;
X-CSE-ConnectionGUID: QOYyyOePRd64p0476Yw1Vg==
X-CSE-MsgGUID: hvh5CMYMR52+rOJIx0HhRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="51887722"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="51887722"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 00:29:14 -0700
X-CSE-ConnectionGUID: LfVgU0yzRO2K+GpGPVxukg==
X-CSE-MsgGUID: esJBU56FS5eg51vjnHGmSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="156650955"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa005.jf.intel.com with ESMTP; 20 Jun 2025 00:29:11 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v4 02/13] perf/x86/intel: Correct large PEBS flag check
Date: Fri, 20 Jun 2025 10:38:58 +0000
Message-ID: <20250620103909.1586595-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
References: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current large PEBS flag check only checks if sample_regs_user contains
unsupported GPRs but doesn't check if sample_regs_intr contains
unsupported GPRs.

Of course, current PEBS HW supports to sample all perf supported GPRs,
so the missed check doesn't cause real issue. But this won't be true
after arch-PEBS supports SSP register sampling. So correct this issue.

Fixes: a47ba4d77e12 ("perf/x86: Enable free running PEBS for REGS_USER/INTR")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index fb6e5c2251a2..80c45c92d0da 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4032,7 +4032,9 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 	if (!event->attr.exclude_kernel)
 		flags &= ~PERF_SAMPLE_REGS_USER;
 	if (event->attr.sample_regs_user & ~PEBS_GP_REGS)
-		flags &= ~(PERF_SAMPLE_REGS_USER | PERF_SAMPLE_REGS_INTR);
+		flags &= ~PERF_SAMPLE_REGS_USER;
+	if (event->attr.sample_regs_intr & ~PEBS_GP_REGS)
+		flags &= ~PERF_SAMPLE_REGS_INTR;
 	return flags;
 }
 
-- 
2.43.0

