Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EC2277CAB;
	Thu, 20 Nov 2025 05:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763617024; cv=none; b=bMmWbWVdqSzgJN4miLWCBnSrB9Kd3qwdt+6JuWauG9C+2NdTdUX8k6IgDTc6FO99oRByr7Kq6Yco1Dgj9tfOpkDQwIMAjNeMJjfwxqKWbrtv7YbG/4qGbdlh2qbjCwVEZ9LvBBRmxLM86c8YbKah9sBfA15d4YBjGgyvkTNio6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763617024; c=relaxed/simple;
	bh=MGC69O3DL8v6tTyun93EbVXiWU1Mh9kifaKsGqKJEFc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jz8oJcyh35U4p2FdYEOiLwzNAUJiLeIoITPzS4v2Q7dZEPR9HGxavnKGFJg/pPmong1KNWeMe9QWmHUBQjJcOj0VcEnLkBOxIvnqFFwhZFWfqs5hsZWLfN6goTrqWvVo54euR6gAwxFEtSpWWBrwkYI2TGopoR9P0iU18M2/RN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OuB9fqdi; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OuB9fqdi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763617022; x=1795153022;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MGC69O3DL8v6tTyun93EbVXiWU1Mh9kifaKsGqKJEFc=;
  b=OuB9fqdin6uUKF1g2ZKUS9RVn330abFD0zzLW8JGEzCi7kw3+P4mlSKA
   2B8RwEAHm2CDNo7k1d3RO9KBJ+pXHKCIPLsv+y7LuBleVomJtabTm/ktz
   zRGHROm2RMmSpBthqrVL9HIQblCnHnb1Cik/pJyoVVnDDJpXqVAGraI6q
   0H7lKVBKYRD/Ofw6BRrCfA4B19S0gvQmccDy7w/leY0Qkz7WvuZMVyRn5
   PBuxZm64EQbM6l75/+KuIYkihNwyymq1aVlGUEf/oo00qtPYrb9n00syU
   jAHdri0AOppBMTe1fykt9CBmrkt6ezxYZ1Eh1v1t6Mp2hBrGeksHdXnit
   A==;
X-CSE-ConnectionGUID: h22BP+uSSZ6gMONmGgl/fw==
X-CSE-MsgGUID: x/6boDOxSO2Tf7t0hnvoGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65710137"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="65710137"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 21:37:02 -0800
X-CSE-ConnectionGUID: YpqvTkDURfeq/B3H1VTsnA==
X-CSE-MsgGUID: JpFTK1C4QPOoA3l6HA6O1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="191055511"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 19 Nov 2025 21:36:58 -0800
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
Subject: [PATCH 0/7] Enable core PMU for DMR and NVL
Date: Thu, 20 Nov 2025 13:34:24 +0800
Message-Id: <20251120053431.491677-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch-set enables core PMU functionalities for Diamond Rapids (DMR)
and Nova Lake (NVL). 

Comparing with previous platforms, there are 3 main changes on core PMU
functionalities.

1. Introduce OFF-MODULE RESPONSE (OMR) facility to replace Off-Core
Response (OCR) facility

Legacy microarchitectures used the OCR facility to evaluate off-core and
multi-core off-module transactions. The properly renamed, OMR facility,
improves the OCR capability for scalable coverage of new memory systems
of multi-core module systems.

Along with the introduction of OMR, 4 equivalent MSRs (OFFMODULE_RSP_0 ~
OFFMODULE_RSP_3) are introduced to specify attributes of the off-module
transaction and the legacy 2 OFFCORE_RSP MSRs are retired.

For more details about OMR events and OFFMODULE_RSP_x MSRs, please refer
to the section 16.1 "OFF-MODULE RESPONSE (OMR) FACILITY" in latest ISE[1]
documentation.

2. New PEBS data source encoding layout

Diamond Rapids and Nova Lake include PEBS Load Latency and Store Latency
support similar to previous platforms but with a different data source
encoding layout.

Briefly speaking, the new data source encoding is determined by bit[8] of
memory auxiliary info field. The bit[8] indicates whether a L2 cache miss
occurs for a memory load or store instruction. If bit[8] is 0, it
signifies no L2 cache miss, and bits[7:0] specify the exact cache data
source (up to the L2 cache level). If bit[8] is 1, bits[7:0] represents
the OMR encoding, indicating the specific L3 cache or memory region
involved in the memory access.

A significant enhancement for OMR encoding is the ability to provide
up to 8 fine-grained memory regions in addition to the cache region,
offering more detailed insights into memory access regions.

For more details about the new data source layout, please refer to the
section 16.2 "PEBS LOAD LATENCY AND STORE LATENCY FACILITY" in latest
ISE documentation.

3. Support "rdpmc user disable" feature

Currently executing RDPMC when CPL > 0 is allowed if the CR4.PCE flag
(performance-monitoring counter enable) is set. This introduces a
security risk that any user space process can read the count of any PMU
counter even though the counter belongs to a system-wide event as long
as CR4.PCE = 1.

To mitigate this security risk, the rdpmc user disable feature is
introduced to provide per-counter rdpmc control.

'rdpmc user disable' introduces a new bit "RDPMC_USR_DISABLE" to manage
if the counter can be read in user space by leveraging rdpmc instruction
for each GP and fixed counter.

The details are
- New RDPMC_USR_DISABLE bit in each EVNTSELx[37] MSR to indicate counter
  can't be read by RDPMC in ring 3.
- New RDPMC_USR_DISABLE bits in bits 33,37,41,45,etc.,
  in IA32_FIXED_CTR_CTRL MSR for fixed counters 0-3, etc.
- On RDPMC for counter x, use select to choose the final counter value:
  If (!CPL0 && RDPMC_USR_DISABLE[x] == 1 ) ? 0 : counter_value
- RDPMC_USR_DISABLE is enumerated by CPUID.0x23.0.EBX[2].

For more details about "rdpmc user disable", please refer to chapter 15
"RDPMC USER DISABLE" in latest ISE.

This patch-set adds support for these 3 new changes or features. Besides
the DMR and NVL specific counter constraints are supported together.

Tests:

The below tests pass on DMR and NVL (both P-core and E-core).
 a) Perf counting tests pass.
 b) Perf sampling tests pass.
 c) Perf PEBS based sampling tests pass.
 d) "rdpmc user disable" functionality tests pass.

Ref:

ISE (version 60): https://www.intel.com/content/www/us/en/content-details/869288/intel-architecture-instruction-set-extensions-programming-reference.html 

Dapeng Mi (7):
  perf/x86/intel: Support newly introduced 4 OMR MSRs for DMR & NVL
  perf/x86/intel: Add support for PEBS memory auxiliary info field in
    DMR
  perf/x86/intel: Add core PMU support for DMR
  perf/x86/intel: Add support for PEBS memory auxiliary info field in
    NVL
  perf/x86/intel: Add core PMU support for Novalake
  perf/x86: Replace magic numbers with macros for attr_rdpmc
  perf/x86/intel: Add rdpmc-user-disable support

 .../sysfs-bus-event_source-devices-rdpmc      |  40 ++
 arch/x86/events/core.c                        |  28 +-
 arch/x86/events/intel/core.c                  | 352 +++++++++++++++++-
 arch/x86/events/intel/ds.c                    | 261 +++++++++++++
 arch/x86/events/intel/p6.c                    |   2 +-
 arch/x86/events/perf_event.h                  |  26 ++
 arch/x86/include/asm/msr-index.h              |   5 +
 arch/x86/include/asm/perf_event.h             |   8 +-
 include/uapi/linux/perf_event.h               |  27 +-
 tools/include/uapi/linux/perf_event.h         |  27 +-
 10 files changed, 751 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-rdpmc


base-commit: 9929dffce5ed7e2988e0274f4db98035508b16d9
-- 
2.34.1

