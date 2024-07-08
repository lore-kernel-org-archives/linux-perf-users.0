Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C586822616;
	Mon,  8 Jul 2024 07:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424439; cv=none; b=BEyjtIFdnWzq2KsR8shxB0nxXEcdol6AXgmITuAuZo1RlW1wfJcrAG1kI1cKrUAhFsUCjLs1Kszm0oLXE70ZLF1NzRtT642jDFz8qNAqxVbclPttAE5HppLsqN0zLunrEyrLHqwCxOO8UU8YQGbNCNl1O0CXQaSVGjLU3VztLMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424439; c=relaxed/simple;
	bh=zSvI+p4Ny5m13sQ7qbhFPTOZZkOCzC7O2DHTDoL4nSU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tKn7lD2zyPC8ZjuFwEZmUnKgilmlFAx97vdS7IwM+Fs9oVx9DEC68L/Kb5a9dUR/7cKzaJaP4+khsxMpaGO4PYHEVkldnLG6nz4671PXB8+BBSkeg5pXxg7azLdEmwyYkWayHXIsWWLAVuQ2v7G8W/rHvZCKPTOhErCWJ2Rbeic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ebG30Ovx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ebG30Ovx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720424438; x=1751960438;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zSvI+p4Ny5m13sQ7qbhFPTOZZkOCzC7O2DHTDoL4nSU=;
  b=ebG30OvxS/3F8eeqefQKVMoF4xKKZZridyRwgNDNlrBGiAkz35uQsrmF
   M7wotYmjlFxrxL58lkG6S61SuXk2BjxxaB4e9V3P7/q5ZzHBmOkXK/9jS
   G16Y03SfaXB4F3tgI9cI5XSRZJPh7mCUdl+WGu25hxdyyJhQw88QEG/ZT
   c0P90lkz1fMRHg6HYO0HLMtyWXPManA0n93IGXtN6CahUVcSZkfTsPHXo
   DB0RLIC/akOF+/XPZgyF19HyIebtTzsYsBTkxAdZIbJgnNTpkf5xsnORW
   fqcCDjqZhrTZk/XtXaJ2PAVW2Oou9Bfm7bGfiGqu02drB+A0LVVN6/UyB
   A==;
X-CSE-ConnectionGUID: VEqAt8k+SiSybknAdCRNzA==
X-CSE-MsgGUID: 8mtccSmFRpSCYlxhmBSdfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="17819206"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="17819206"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 00:40:37 -0700
X-CSE-ConnectionGUID: pUdCrYU+QvaJwKKIYbVVFQ==
X-CSE-MsgGUID: +fzL/5rXQv2bPKvgpyZLCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="51774068"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa003.fm.intel.com with ESMTP; 08 Jul 2024 00:40:34 -0700
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
	Yongwei Ma <yongwei.ma@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v2 0/5] Bug fixes on topdown events reordering 
Date: Mon,  8 Jul 2024 14:41:59 +0000
Message-Id: <20240708144204.839486-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes:
v1 -> v2"
  * Use event/umask code instead of event name to indentify if an event
    is a topdown slots/metric event (patch 1/5).
  * Add perf tests to validate topdown events reordering including raw
    format topdown events (patch 5/5).
  * Drop the v1 patch 3/4 which doesn't move slots event if no topdown
    metrics event in group.

Currently whether an event is a topdown slots/metric event is only
identified by comparing event name. It's inaccurate since topdown events
can be assigned by raw format and the event name is null in this case,
e.g.

perf stat -e '{instructions,cpu/r400/,cpu/r8300/}' sleep 1

 Performance counter stats for 'sleep 1':

     <not counted>      instructions
     <not counted>      cpu/r400/
   <not supported>      cpu/r8300/

       1.002917796 seconds time elapsed

       0.002955000 seconds user
       0.000000000 seconds sys

In this case slots and topdown-be-bound events are assigned by raw
format (slots:r400, topdown-be-bound:r8300) and they are not reordered
correctly.

The reason of dropping the patch "don't move slots event if no topdown
metric events in group" is that no any function issues but a warning is
introduced, and the cost of fixing this issue is expensive.

History:
  v1: https://lore.kernel.org/all/20240702224037.343958-1-dapeng1.mi@linux.intel.com/

Dapeng Mi (5):
  perf x86/topdown: Complete topdown slots/metrics events check
  perf x86/topdown: Correct leader selection with sample_read enabled
  perf x86/topdown: Don't move topdown metrics events when sorting
    events
  perf tests: Add leader sampling test in record tests
  perf tests: Add topdown events counting and sampling tests

 tools/perf/arch/x86/util/evlist.c  |  9 ++---
 tools/perf/arch/x86/util/evsel.c   |  3 +-
 tools/perf/arch/x86/util/topdown.c | 57 ++++++++++++++++++++++++++++--
 tools/perf/arch/x86/util/topdown.h |  2 ++
 tools/perf/tests/shell/record.sh   | 34 ++++++++++++++++++
 tools/perf/tests/shell/stat.sh     |  6 ++++
 6 files changed, 101 insertions(+), 10 deletions(-)


base-commit: 73e931504f8e0d42978bfcda37b323dbbd1afc08
-- 
2.40.1

