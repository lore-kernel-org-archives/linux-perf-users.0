Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208E5377579;
	Fri, 10 Jul 2026 06:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783666672; cv=none; b=q9Bd+rw/tgNlG0+57RaipcUljI0oGH522/IZdQLcmF6etBXkCULk+DnBcmIS25oZ96WCk/yONXy2N4RjdOnQBuUfgrLdlPNvaA6A0FfcdGXgVBzbIk50HWQ8OclJCkzf9ylSzmTiuVuElTsY9ax7pCaNNw9aFU7L2cVfAHAUe/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783666672; c=relaxed/simple;
	bh=0GQOnr+XgAKpP0JjbYtOvMs+2vVCUwT2mTyNwv0/AYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LswrqIGyYBGC0mfCuC9lOHakmKK91HF9Mq0MEOZ5sXMlo2wbO57zSCm5YiRL3frmNtMJtdrioqsBsY8MjNR+tmOFmU42oVYz6c73r7aPjOTZfPZEVgQqzGUodZRdnSEXidaX4Pp07cECxFcY0/g8m64aORnlGhuWGyTcPdZLrGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XFXgxVV+; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XFXgxVV+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783666669; x=1815202669;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0GQOnr+XgAKpP0JjbYtOvMs+2vVCUwT2mTyNwv0/AYE=;
  b=XFXgxVV+9KH/AVK4OUpGGrOE83celwTov5MXX9myHxgIBIz2oe1ACcTE
   PiHmvgwz6ia22cqnJdBOpVucLhZz1uV6mkVkqyX0JDH+QP+1OrY3ojOK8
   4ilEaBPK1gTX8RFeuuyXc6HLLSECDOx8WJG9xaws28UZb13UvufOnNDcp
   DTFiTf7Yc+XUYwCIU8b1HsxZNLKo/pWfOuo0XEiAmLPcOtUaL2RUVQa7H
   YGwr2HBrVjfqmI/91AznsegY9HzVo2Ht+lCWIrA0Tz20OMC8m+tMDUnbR
   nd6cCumWyj1d1WURSFCgfY3C7F1Vr6mVHdSy6hMFE8R9qPZ7yEcEIXfmG
   A==;
X-CSE-ConnectionGUID: 711LqNeuQXyqhC2nZSEx8Q==
X-CSE-MsgGUID: Kmx5JnZ4TautLBfEmPmGeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84554207"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84554207"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 23:57:47 -0700
X-CSE-ConnectionGUID: FD+jkEGOTimfMETg4zKc/g==
X-CSE-MsgGUID: Z00CkEJeQj6vLTR4D4QVNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="252159195"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 09 Jul 2026 23:57:39 -0700
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
Subject: [PATCH 3/7] perf/x86/intel: Clear cpuc->pmu on hybrid PMU init failure
Date: Fri, 10 Jul 2026 14:51:24 +0800
Message-Id: <20260710065128.1799838-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710065128.1799838-1-dapeng1.mi@linux.intel.com>
References: <20260710065128.1799838-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When init_hybrid_pmu() fails at check_hw_exists(), cpuc->pmu may still
point to the default static PMU.

The CPU hotplug rollback then runs intel_pmu_cpu_dead(). On hybrid
systems, that path may call hybrid_pmu(cpuc->pmu), which is not valid
for the static PMU pointer and can result in incorrect hybrid state
access.

Fix this by resetting cpuc->pmu to NULL on hybrid PMU init failure.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b39c6ce0efb5..9d4774278b50 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6329,8 +6329,10 @@ static bool init_hybrid_pmu(int cpu)
 
 	intel_pmu_check_hybrid_pmus(pmu);
 
-	if (!check_hw_exists(&pmu->pmu, pmu->cntr_mask, pmu->fixed_cntr_mask))
+	if (!check_hw_exists(&pmu->pmu, pmu->cntr_mask, pmu->fixed_cntr_mask)) {
+		cpuc->pmu = NULL;
 		return false;
+	}
 
 	pr_info("%s PMU driver: ", pmu->name);
 
-- 
2.34.1

