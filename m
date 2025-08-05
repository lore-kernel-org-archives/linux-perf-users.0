Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB253FE7;
	Tue,  5 Aug 2025 00:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754354852; cv=none; b=aqdKyaslJATUkJtZVIqXzAMDhMynrIG/59bZuw6bfI3N+45rw4jAH+pmjgkIu2yVmhhaIMZO5+s4BznWsPvP0m0WhemYgAB9g5WDzy3KQ27UYWlLHE+sb2lxdv1/Hyw8zlxz+pXGoGCmjfbyg9tz1/WqFpPLvUCNvckohloLDkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754354852; c=relaxed/simple;
	bh=x4iiNb2I+DDZ0qghzp9LsVp8c2JrZhD6ftx2VJfpaK8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NbBpHVkYM61qd5+U4Iz6fhdNf0BQ7O842f7NUL4fwvd3ZwzU93MCIV2bCAjFWHM/D/yzxK0DasInSUtPbLa2acBD8BBYEP/KHHYRKST1zcrCJwQ3jaudvY8WqHZtVQBDujOcmY9YWWqfo6l88VgrN9VYS+T9DVPvH8tz4711xn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BER8Dp9Z; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BER8Dp9Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754354852; x=1785890852;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x4iiNb2I+DDZ0qghzp9LsVp8c2JrZhD6ftx2VJfpaK8=;
  b=BER8Dp9Z90c3zRKbsHaKsH3j99xKE/jgjObBebQlRWNBND3SFAaAA8n1
   VvoClwbwTkgdDzirA4ZW25QB2YdSHXo7JFyHfJ2i54P3kns2LyR3nnK+v
   v6RS/CC71OkfgJzVNoA2nCbymcAaBMzaNbN1JJR6ADWqJcKxzyProhTat
   fyPxiX+XvTCwrG0A0X3pua1LBIMU4hO6nBIsA+62MGCNXT89K/n2OksaF
   hdxpKJ22X2I0u9xa8WVxHz0ZT6k77hjftLMOTdj+LdT1iusDCy5Bp9DTi
   pSWMvXiZ2Lpj04mo+6o5nVYO9jlU/wYkuv+hry0oOf6ANYBjUJR3bx52g
   A==;
X-CSE-ConnectionGUID: zhD83O6yTTOOtnga9zsVuA==
X-CSE-MsgGUID: gg1R/KfPSLiSvDtlxWDukQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="56523820"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="56523820"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 17:47:31 -0700
X-CSE-ConnectionGUID: XEFyoU6HRfSW/TnKWl4VFA==
X-CSE-MsgGUID: El1VI5SRTX+zdt1/x4IXtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="169605418"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa004.fm.intel.com with ESMTP; 04 Aug 2025 17:47:28 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kevin Tian <kevin.tian@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 0/5] Perf kvm commands bug fix
Date: Tue,  5 Aug 2025 08:46:28 +0800
Message-Id: <20250805004633.135904-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch-set fixes perf kvm commands issues, like missed memory
allocation check/free, out of range memory access and especially the
issue that fails to sample guest with "perf kvm record/top" commands on
Intel platforms.

The commit 634d36f82517 ("perf record: Just use "cycles:P" as the
 default event") changes to use PEBS event to do sampling by default
including guest sampling. This breaks host to sample guest with commands
"perf kvm record/top" on Intel platforms.

Since the change "KVM: x86/pmu: Add basic support to enable guest PEBS
 via DS"[1] starts, host loses the capability to sample guest with PEBS
since all PEBS related MSRs are switched to guest value after vm-entry,
like IA32_DS_AREA MSR is switched to guest GVA at vm-entry. This leads
to PEBS events can't be used to sample guest by host, otherwise no guest
PEBS records can be really sampled. The patches 4-5/5 fix this issue by
using "cycles" event instead of PEBS event "cycles:P" to sample guest on
Intel platforms.

Tests:
  * Run command "perf kvm record -a && perf kvm report" and "perf kvm
    top" on Intel Sapphire Rapids platform, guest records can be
    captured successfully.
  * Since no powerpc platforms on hand, doesn't check the patches on
    powerpc. Any test on powerpc is appreciated.

Ref:
  [1] https://lore.kernel.org/all/20220411101946.20262-1-likexu@tencent.com/

Dapeng Mi (5):
  perf tools kvm: Add missed memory allocation check and free
  perf tools kvm: Fix the potential out of range memory access issue
  perf tools: Add helper x86__is_intel_cpu()
  perf tools kvm: Use "cycles" to sample guest for "kvm record" on Intel
  perf tools kvm: Use "cycles" to sample guest for "kvm top" on Intel

 tools/perf/arch/x86/util/kvm-stat.c | 46 ++++++++++++++++++
 tools/perf/builtin-kvm.c            | 73 ++++++++++++++++++++++++-----
 tools/perf/util/env.c               | 22 +++++++++
 tools/perf/util/env.h               |  2 +
 4 files changed, 131 insertions(+), 12 deletions(-)


base-commit: 6235ce77749f45cac27f630337e2fdf04e8a6c73
-- 
2.34.1

