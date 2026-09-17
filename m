Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458A137F002;
	Thu, 17 Sep 2026 01:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610380; cv=none; b=u6CGcoNOhYGgNGu+jGVBezBDnjBCpmOrUIIhLXIVuzVcDImbheZoBkS4b89MX2zxYrPeNKoFzgo1e9X1bd9v5XHXnlgqQwO/OU3ClT6w29mdKDPklgCJ4dI7YN89yQ4TPIVaDIXYzrm+On8VnegBl1dcBjVB45gWqNIBzKlzKcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610380; c=relaxed/simple;
	bh=2VrXQEM8vPAmtcfocG1nlF85piyJ7bLm8MT+F6WdEkc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t5s7CNz4X9oYSvnTMWahhado5sN9iqH1VPt42miArCp3ZYtSTrUA9GyoQtUvEqOul9uL7BwL64upohRyhxLjppD0K2rpmADrgrAlEOfzDTSj5HakDi9j9/v+54qX0gnqMpfSozcIju4tMx2Fio6iSxGv/0qK3ACr6WaFBPxgJ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hhuOxuO7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hhuOxuO7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789610378; x=1821146378;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2VrXQEM8vPAmtcfocG1nlF85piyJ7bLm8MT+F6WdEkc=;
  b=hhuOxuO7jRPI22XEs5EdVLXSYw1ArnSPIxaUH3ZZ5gwL9jk0jlaX207y
   uG4rRQvuQ/5q8S8p+SFgKX9mmZdRauAEjmPlB1ZH4I33b1QyZYjgaNoA7
   97C+QQKi6kzQdS174SKq50dINL+hLcCZ1JlP6dNt6NrPAQZPjLOouNfaC
   6pMW9t6K33TU5LwW0aGeOvWQufkvNRaBn7PcfAwZ6lR2E6iLZFstAMnwV
   Qbf4YgKVUM+n4j0hWkwI3p3N7MIqAfJeCa06AdVLeHu5JKUUpr/B0zL/E
   UyQMtQ8iaVWdWA5aY90zHjGvIZ7yVKyMWkJyHTHaWW/ImUd/OP3qFAHqI
   g==;
X-CSE-ConnectionGUID: AW9FpDnUQRyViEB3kAwgsA==
X-CSE-MsgGUID: 6NFHF1xzTBGr4lqMPlFgkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107498522"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107498522"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 18:59:37 -0700
X-CSE-ConnectionGUID: Ispg4ayTRai08EeH6rTnkg==
X-CSE-MsgGUID: f7NEaC6KQz27ABApBYqI7A==
X-ExtLoop1: 1
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa003.fm.intel.com with ESMTP; 16 Sep 2026 18:59:33 -0700
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
Subject: [PATCH 00/12] perf/x86/intel: PEBS data-source fixes and OMR updates
Date: Thu, 17 Sep 2026 09:52:22 +0800
Message-Id: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes several recently identified PEBS data-source issues on
both P-cores and E-cores.

On the P-core side, some memory events that can not provide valid PEBS
data-source information, like MEM_INST_RETIRED.STLB_MISS_LOADS, are
marked as data-source capable, which can lead to incorrect decoding
results.

On the E-core side, MEM_UOPS_RETIRED.STORE_LATENCY event isn't set the
STORE direction flag, causing store operations to be decoded as loads.

The last three patches add support for precise OMR events and rename the
DMR/NVL sysfs attribute from offcore_rsp to offmodule_rsp so the
interface matches the underlying OMR events and avoids user confusion.

Patch layout:
- Patches 01-04: Fix E-core memory operation decoding.
- Patches 05-06: Remove events without valid PEBS data-source support
  from the PEBS constraint tables.
- Patch 07: Fix two incorrect snoop-state decodings for Panther Cove.
- Patch 08: Remove dead code from NVL data-source initialization.
- Patch 09: Update Panther Cove event constraints.
- Patch 10: Add precise OMR event support for DMR/NVL.
- Patches 11-12: Rename the DMR/NVL offcore_rsp sysfs attribute to
  offmodule_rsp.

Tests:
- Run below commands on ARL and PTL, data source can be correctly
  parsed for both P-core and E-core.

  P-core:
  1. perf record -e cpu_core/MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4/p -d \
     	-c 1000 -a -- sleep 1 && perf script -F data_src 

     output:
     "10268100142 |OP LOAD|LVL L1 hit|SNP None|TLB L1 or L2 hit|LCK No|BLK  N/A"

  2. perf record -e cpu_core/MEM_TRANS_RETIRED.STORE_SAMPLE/p -d \
    	-c 1000 -a -- sleep 1 && perf script -F data_src

     output:
     "10268100144 |OP STORE|LVL L1 hit|SNP None|TLB L1 or L2 hit|LCK No|BLK  N/A"

  3. perf record -e cpu_core/MEM_INST_RETIRED.STLB_MISS_LOADS/p -d \
        -c 1000 -a -- sleep 1 && perf script -F data_src

     output:
     "1e05080021 |OP N/A|LVL N/A|SNP N/A|TLB N/A|LCK N/A|BLK  N/A"

  E-core:
  1. perf record -e \ 
      cpu_atom/event=0xd0,umask=0x5,ldlat=0x4,name=MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4/p \
      -d -c 1000 -a -- sleep 1 && perf script -F data_src

     output:
     "10268100142 |OP LOAD|LVL L1 hit|SNP None|TLB L1 or L2 hit|LCK No|BLK  N/A"

  2. perf record -e \
      cpu_atom/event=0xd0,umask=0x6,name=MEM_UOPS_RETIRED.STORE_LATENCY/p \
      -d -c 1000 -a -- sleep 1 && perf script -F data_src
  
     output:
     "10668080084 |OP STORE|LVL L3 miss|SNP N/A|TLB L1 or L2 hit|LCK No|BLK  N/A"
- Run below precise OMR events on PTL P-core, records can be captured
  successfully.

  1. perf record -e cpu_core/MEM_LOAD_L2_MISS_RETIRED.L3_HIT_SAME_CBB/p \
     	-c 1000 -a -- sleep 1

  2. perf record -e cpu_core/MEM_STORE_L2_MISS_RETIRED.L2_OTHER_MODULE.SAME_CBB.HITM.SNP_FWD/p \
        -c 1000 -a -- sleep 1
     

Dapeng Mi (12):
  perf/x86/intel: Fix GRT PEBS load/store direction for latency events
  perf/x86/intel: Fix CMT PEBS load/store direction for latency events
  perf/x86/intel: Fix DKT PEBS load/store direction for latency events
  perf/x86/intel: Update arw_latency_data() mem-op direction handling
  perf/x86/intel: Remove incorrect LionCove PEBS data-source constraints
  perf/x86/intel: Remove incorrect PantherCove PEBS data-source
    constraints
  perf/x86/intel: Correct Panther cove data source snoop states
  perf/x86/intel: Delete dead NVL PEBS data-source init call
  perf/x86/intel: Constrain PantherCove UOPS_DISPATCHED events
  perf/x86/intel: Add precise OMR event support for DMR/NVL
  perf/x86/intel: Rename DMR offcore_rsp attribute to offmodule_rsp
  perf/x86/intel: Rename NVL offcore_rsp attribute to offmodule_rsp

 arch/x86/events/intel/core.c | 55 ++++++++++++++++++++++++---
 arch/x86/events/intel/ds.c   | 74 +++++++++++++++++-------------------
 arch/x86/events/perf_event.h |  4 --
 3 files changed, 83 insertions(+), 50 deletions(-)


base-commit: 68aca309e49c589f1922f4c5af2370e4df093175
-- 
2.34.1

