Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1EF57F753;
	Wed, 16 Sep 2026 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576318; cv=none; b=LWhsf+aQTpD2P5X6MRyK4taZr99DO8ny76DbV3U6H9frD1yqVvQMh/HjzN+A4bHV5mRRXnFJFVa+lCldsDmFgTw5pXXLCMjATgJDwHuvIvR0V0E52w3a3GT0+c3pR1TLIuA1/eU8abILHtTFoJ6XWuJI83l13PIAfDZQQ8lmyRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576318; c=relaxed/simple;
	bh=1M+Ox8VtHkAh42Jp52bV+LcKMtnkwVmnl/79hc4sTUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BgqPwuVzcxnLL9GQT+MTwXAwDvdVXzmdHLnN3CcWHSCDHcgIWUmPwcmxVZH2Q+wSzGC08jJIPTP42WFHhD3FGyVdWSgFhORIE6TPh/0t9pBpVfeO5Q+tEfppQjJYrjynC+bG9thd9SAp/4zZ5umHKQXLkWm4qGbiPulUmMuz+/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e2QLSTs0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e2QLSTs0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789576311; x=1821112311;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1M+Ox8VtHkAh42Jp52bV+LcKMtnkwVmnl/79hc4sTUw=;
  b=e2QLSTs0crqD4bkJ6gDR05sv2glAbCpG5IhxxLKQ0vLC2JIMOtJn2nQt
   JhhW/LuPiSjR8s5NlpvyN6pzModlvWb0XyNV8LKfvO+IfecJuOAByag9A
   rId4NzkuAfJNavLGZtDD5RwflUM98JgFKqwiVv0eTWw6rdY4RlI/XQEsk
   zDDiIcozAiaVEbp/whDsKZvJC1vOTxaAV0JSCzGZJlYM2uEXiOYmoPKsV
   LZaANbfPtwKWLnpIEUQRbZ7RWhc8Nxc4YN/qkcc5srCyiOftw5qeIIb/k
   k4/HASOQ1ENcEi+e12JLHtm8Bkw5Txuh/dyilGFuSkteZNXu/GjMQuEnh
   g==;
X-CSE-ConnectionGUID: OvC52FMkQHSatYMqyyJGjA==
X-CSE-MsgGUID: 3eVqJX/6SUiNrrWGkWKZWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90093389"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90093389"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 09:31:46 -0700
X-CSE-ConnectionGUID: Ukc1oRnPQq2aDyloVd3cJg==
X-CSE-MsgGUID: ar7V5XC+Sy2HvJOtnXLujA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="273363815"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.223.212])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 09:31:43 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v10 0/6] perf: Add support for memory region/range reporting
Date: Wed, 16 Sep 2026 11:31:21 -0500
Message-ID: <20260916163127.318885-1-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for two memory-related reporting features in the perf tool:

1. Memory region reporting in perf-c2c and perf-script subcommands.
2. Memory range data in perf.data file header and perf-c2c subcommand.

Memory region reporting was introduced as part of support for the
Off-module Response facility (OMR) [1], which provides a new data
source encoding supporting "up to 8 fine-grained memory regions in
addition to the cache region, offering more detailed insights into
memory access regions."

Memory Range support was introduced with the addition of the ACPI Memory
Range and Region Mapping (MRRM) [2] table. It provides a base address plus
a length value for each memory range, as well as NUMA node and local and
remote "region ID's" so that "platform firmware can indicate the type of
memory for each range."[3]

Include a change allowing PERF_MEM_LVLNUM_L0 to be printed in
perf-mem output as well.

[1]: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.intel.com/
[2]: https://lore.kernel.org/lkml/20250505173819.419271-1-tony.luck@intel.com/
[3]: MRRM definition allow for future expansion for the OS to assign
these region IDs.

v10:
-- perf-c2c: only update a cacheline's mem_region for real cache/memory
   regions, so region-less samples (N/A) no longer overwrite a valid
   region recorded by an earlier sample on the same cacheline (Sashiko)
-- perf-script: replace #include "session.h" in mem-events.h with a
   forward declaration of struct perf_session, and add direct session.h
   includes to the .c files that use it (Sashiko)
-- perf header: add missing #include <fcntl.h> for open()/openat()/
   O_DIRECTORY to avoid build failures under strict libc such as musl
   (Sashiko)
-- perf-c2c: add missing #include <stdio.h> for asprintf() (Sashiko)
-- Fix some whitespace and comment formatting issues

v9:
-- Fixed incorrect developer tags and updated perf-c2c to include cache
   region reporting (Dapeng Mi)

v8:
-- Updated developer tags and commit messages with real example output
   from perf script and perf c2c (Dapeng Mi)

v7:
-- perf-c2c: fix output_str allocation error handling that introduces a
   memory leak (Sashiko)

v6: 
-- Rebase on 7.3-rc1

v5:
-- perf-c2c: make the cacheline header span and ui_quirks() width
   fixup depend on memory-region availability (Namhyung Kim)

v4:
-- perf-script: gate the Region field on the HEADER_MEMORY_RANGES feature
   bit via perf_session instead of a global flag, with a pipe-mode fallback
-- perf-c2c: fix output_str allocation error handling
-- perf header: Fix typo in region id bounds checking which made region 255
   invalid

v3:
-- included missing ff-size check in process_memory_ranges
-- make memory region reporting in perf c2c-and perf-script conditional
   on feature bit, requiring some patch reordering (Namhyung Kim)
-- used open/openat to read memory range sysfs files in memory_range__read()
   (Namhyung Kim)
-- Removed path name and file name buffers in memory_range__read(),
   instead pass path name from as a parameter from memory_range__parse()
   (Namhyung Kim)
-- use calloc instead of zalloc in memory_range__parse() and
   process_memory_ranges() (Namhyung Kim)
-- Removed redundant check for existence of memory range directory in
   memory_range__read() (Namhyung Kim)
-- Included output examples of memory ranges in perf header and perf-c2c
   in commit message (Namhyung Kim)

v2:
-- Added missing newline in WARN_ONCE message in c2c_he__set_mem_region()
-- increased buffers passed to perf_script__meminfo_scnprintf() from 150
   to 200 bytes to avoid silent truncation
-- Added check for NULL return of sysfs__mountpoint() when parsing
   memory ranges in sysfs
-- increased MAX_MEMORY_RANGES sanity check from 64 to 256 based on
   ACPI MRRM table implementation in Linux kernel
-- added comment for MAX_MEMORY_RANGES to clarify that it is a sanity check
   for malformed perf.data files
-- cleaned up some removed code that was added back by this patch series
   due to a bad rebase

Dapeng Mi (3):
  perf mem: Add support for printing PERF_MEM_LVLNUM_L0
  perf tools: Show memory region in perf-c2c subcommand
  perf tools: Show memory region in perf-script subcommand

Thomas Falcon (3):
  perf mem: Fix size tracking for mem_lvl's in
    perf_script__meminfo_scnprintf()
  perf header: Support memory ranges
  perf c2c: print memory region data with stdio output

 tools/perf/Documentation/perf-record.txt      |   2 +-
 .../Documentation/perf.data-file-format.txt   |  13 ++
 tools/perf/builtin-c2c.c                      | 158 +++++++++++++-
 tools/perf/builtin-inject.c                   |   1 +
 tools/perf/builtin-script.c                   |  13 +-
 tools/perf/util/bpf-filter.l                  |   1 +
 tools/perf/util/c2c.h                         |   1 +
 tools/perf/util/env.c                         |   1 +
 tools/perf/util/env.h                         |  10 +
 tools/perf/util/header.c                      | 205 ++++++++++++++++++
 tools/perf/util/header.h                      |   1 +
 tools/perf/util/mem-events.c                  |  94 +++++++-
 tools/perf/util/mem-events.h                  |   5 +-
 .../scripting-engines/trace-event-python.c    |   6 +-
 14 files changed, 488 insertions(+), 23 deletions(-)

-- 
2.43.0

