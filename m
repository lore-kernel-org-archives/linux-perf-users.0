Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5A3286408;
	Wed, 14 Jan 2026 01:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768353727; cv=none; b=TEHt9iSbxPTVb5fJHN6mydpbUEtZL46pe/ZDELkesBxWS+TuM3BujuH3nWZYzcs5weBYCTJ9biPimm38Oey+EfpHilrDkMmXxQGNSD6U6tnBIh3c7tIV75TK4hVlJlVltvn3CFmrB60eIqhNX9IUxHyf0CSLxhQb3JDXWWG0gaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768353727; c=relaxed/simple;
	bh=YeOEmCk4hHTNS3VtrNR3D2Eqq1vWTEr1jHmLwYRFwFE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U5g4WQzH3P99UD0jMY3VwmOM9BNwEyF3AHmZavVrDtzXSsXrR0cSpmeLKVx/TJCw8Hc3sY/2gxT+ob4VHJvRBUVpQRAUCdgQb9pBQYqAuFhBrCS4iD/gP5JWV5JPJcis/cPi0aaxLyADe3tQWLsYtQxbqMntbsqphvMeQ73XSGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WbjwVagi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WbjwVagi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768353725; x=1799889725;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YeOEmCk4hHTNS3VtrNR3D2Eqq1vWTEr1jHmLwYRFwFE=;
  b=WbjwVagi6LsYPS5F7Jc2MKA9k9RoCB0cdNdHGJX5ThbxExam4cVkxkNf
   cDCp3hY2IFDAWH18NSge7rLqXglBENgbKTyHcH5QLBnHKLaZ/LE2thD8b
   LViWLlg3wEtnH9MHjK7u35SmANQG8iDwlI5AcPsAt6Gq/4/Uhq00jxzch
   +6wH/Kp8RpwsIVHKXzms/RYQR4wE1eet0GOfsEqOkb00FmSGc1jNEUGIh
   tHTqsaX5XMwOJJM5uKbg+5MR4hsspqTq0jLgdL5n2M/AjllO4eJnwng8U
   6C5YwTZUcRdtuWXPcBHHsO0Wv/lSYoszwPVyfSoYdm7YrkrvyLt0xjbSx
   Q==;
X-CSE-ConnectionGUID: 9PLPK2a+Rjer/4z3DYbAiw==
X-CSE-MsgGUID: H4mSXMgXRSqK7Wo5tSbVTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="87231486"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="87231486"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 17:22:04 -0800
X-CSE-ConnectionGUID: XclFjTPmQNuDDx3d/si7wg==
X-CSE-MsgGUID: OL3Xl4T0TymwervlC1wIEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="204561187"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa007.jf.intel.com with ESMTP; 13 Jan 2026 17:21:59 -0800
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
Subject: [Patch v3 0/7] Enable core PMU for DMR and NVL 
Date: Wed, 14 Jan 2026 09:17:43 +0800
Message-Id: <20260114011750.350569-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes:
 v2 -> v3:
 * Refine intel_alt_er() to align with intel_fixup_er() (Peter).
 * Simplify DMR core PMU enabling code (Peter).
 * Add words to mention rdpmc is global on hybrid platforms (Ian).
 v1 -> v2:
 * Rebase to latest perf/core base (6.19-rc1 based).
 * Refine intel_fixup_er() helper (Zide).
 * Optimize commit message.

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

History:
v1: https://lore.kernel.org/all/20251120053431.491677-1-dapeng1.mi@linux.intel.com/
v2: https://lore.kernel.org/all/20260112051649.1113435-1-dapeng1.mi@linux.intel.com/

Dapeng Mi (7):
  perf/x86/intel: Support the 4 new OMR MSRs introduced in DMR and NVL
  perf/x86/intel: Add support for PEBS memory auxiliary info field in
    DMR
  perf/x86/intel: Add core PMU support for DMR
  perf/x86/intel: Add support for PEBS memory auxiliary info field in
    NVL
  perf/x86/intel: Add core PMU support for Novalake
  perf/x86: Use macros to replace magic numbers in attr_rdpmc
  perf/x86/intel: Add support for rdpmc user disable feature

 .../sysfs-bus-event_source-devices-rdpmc      |  44 +++
 arch/x86/events/core.c                        |  28 +-
 arch/x86/events/intel/core.c                  | 364 +++++++++++++++++-
 arch/x86/events/intel/ds.c                    | 261 +++++++++++++
 arch/x86/events/intel/p6.c                    |   2 +-
 arch/x86/events/perf_event.h                  |  26 ++
 arch/x86/include/asm/msr-index.h              |   5 +
 arch/x86/include/asm/perf_event.h             |   8 +-
 include/uapi/linux/perf_event.h               |  27 +-
 tools/include/uapi/linux/perf_event.h         |  27 +-
 10 files changed, 762 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-rdpmc


base-commit: 01122b89361e565b3c88b9fbebe92dc5c7420cb7
-- 
2.34.1

