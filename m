Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BF81F4CAA;
	Mon, 11 Aug 2025 05:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754891812; cv=none; b=He2qhmFy1D2LNWRLqCvt5WJjcHHVocggh1fScsEQUD+w/h1SYpw9ZayNNN5Zc5aulfh8MwMS8HfIR6rmWVXjefS4Dfp75Br27QF4KX/JMjwl1i9Ocf13brtGt+5M5roqRLiAIbKk5zcSB14SdcLqXY5HYBSG1qXSDe2+wKjIOck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754891812; c=relaxed/simple;
	bh=uxkPtHmtI7hnC5SkZG/QwPECWHlZ6btQBDMb3fvZEwA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l0NJc5ifT+pKUvfzrbleQWGIeGPl/yc/ZNyWH1DtjMU/amtCAaxmMQSxOeaGSmGA+yMYA2gTsYAcjnKYJ6UxZKKbIWH2jMyzXGF87lQjLC1O008HRDnWSW88340awZFSN13tKU8GkCenMSdBsoFSEojRcJghCme95+yMkFcOK2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EvuPc6fn; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EvuPc6fn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754891811; x=1786427811;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uxkPtHmtI7hnC5SkZG/QwPECWHlZ6btQBDMb3fvZEwA=;
  b=EvuPc6fnrbb2jnRLi+5WlCUgYdaQhn2gLS3ZNwJlxdb7peU7EQvruBdJ
   z52VNjIjkkfcbOL4OMzPLEW+TyvXbVlm2bDQa2pQy2Q/0jdi9kTwPuPeR
   5bICtdgdkiEknZHF4YARykhKa481tHzzbJynHakS30Bs7eZaRUhUfNlJD
   SNjaQp3RJJ8JuWTLaY0F3jtWlD7DrDGYolxjV9oHn5xxCNC2a2iEO9qUg
   MYFtVwZZAYTvhfANJf7aWUrRxgCMFz2gNzf38EXv+/3FlzA8P8lP3mu9e
   KtrMzpgXn4t/x4ifbkK4zSNe+w67BrzMt0X55naDXgEAl+AYw+Ilkokh4
   w==;
X-CSE-ConnectionGUID: Ir5hVM25TrO7docqHPP1Xw==
X-CSE-MsgGUID: gFADZZ4nTQe+rOAko1JlHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57043599"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57043599"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2025 22:56:50 -0700
X-CSE-ConnectionGUID: 4gbd8VZfS6Om7u6lyQyKmw==
X-CSE-MsgGUID: KXBNuHbZTiuF3HT+92CZ5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="171183686"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa005.jf.intel.com with ESMTP; 10 Aug 2025 22:56:48 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v2 0/6] Perf kvm commands bug fix
Date: Mon, 11 Aug 2025 13:55:40 +0800
Message-Id: <20250811055546.296678-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

his patch-set fixes perf kvm commands issues, like missed memory
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
PEBS records can be really sampled. The patches 5-6/6 fix this issue by
using "cycles" event instead of PEBS event "cycles:P" to sample guest on
Intel platforms.

Changes:
  v1 -> v2:
  * Free memory allocated by strdup().
  * Check "--pfm-events" in kvm_add_default_arch_event() as well.
  * Opportunistically fix the missed memory allocation and free issue in
    builtin-kwork.
  * Comments refine. 


Tests:
  * Run command "perf kvm record -a && perf kvm report" and "perf kvm
    top" on Intel Sapphire Rapids platform, guest records can be
    captured successfully.
  * Since no powerpc platforms on hand, doesn't check the patches on
    powerpc. Any test on powerpc is appreciated.

Ref:
  [1] https://lore.kernel.org/all/20220411101946.20262-1-likexu@tencent.com/


Dapeng Mi (6):
  perf tools kvm: Add missed memory allocation check and free
  perf tools kwork: Add missed memory allocation check and free
  perf tools kvm: Fix the potential out of range memory access issue
  perf tools: Add helper x86__is_intel_cpu()
  perf tools kvm: Use "cycles" to sample guest for "kvm record" on Intel
  perf tools kvm: Use "cycles" to sample guest for "kvm top" on Intel

 tools/perf/arch/x86/util/kvm-stat.c |  51 +++++++++++
 tools/perf/builtin-kvm.c            | 130 ++++++++++++++++++++--------
 tools/perf/builtin-kwork.c          |  27 ++++--
 tools/perf/util/env.c               |  22 +++++
 tools/perf/util/env.h               |   2 +
 tools/perf/util/kvm-stat.h          |  10 +++
 6 files changed, 203 insertions(+), 39 deletions(-)


base-commit: 6235ce77749f45cac27f630337e2fdf04e8a6c73
-- 
2.34.1

