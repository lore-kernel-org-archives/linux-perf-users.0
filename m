Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0648242D72;
	Fri, 21 Aug 2026 00:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787271511; cv=none; b=cd3WmRpxF5qoijl4Nckqu91i3vw2JuUUSXY5yudCvUez2ry6JOTAGv/tMVx36ii7yNF3sraKndVX1uF9MGJafjDPQuRmDphWvHaO14juvuHj3QlU7JYazl3m7Zb2XhVZqeEBTHommk9tRPbNUHI+rmaPWe/hgTbptTUX0lcB4nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787271511; c=relaxed/simple;
	bh=ixz3RFzN6iPpYRLDgP8Ag6q2HxxE/eGtLJPHCanm6h0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kVZn3hSHcVQYsDIBRL0nlWziNuMuKMPlu+mZJePT93PjD6QTGkkVE8XjKqVfeVEideIo6rk7ATD68vDyp2AxfKuhIJTXlr78kX3wnmGVlAQZ4S9yVsoWbOdbQYLgBYA1w2CS+gqHQ7ar5R3SqVR31Rexzw7DSO2xBAUwd1bERwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VPsAaE5G; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VPsAaE5G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787271509; x=1818807509;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ixz3RFzN6iPpYRLDgP8Ag6q2HxxE/eGtLJPHCanm6h0=;
  b=VPsAaE5G6jNsbuE3xNcEhEeAeglc5yJkFe5nyhSgvC9CGGPxwayHJRTh
   wbm3yZuTrt3TgFCV5DgKU1w3wJroHS3ZyYfc7vSePTrsJ/37yhoy18X/D
   UA8GQWHQGoa0ZWymOG5GrKd5ZgiwsgLdYWxX5D0RBJ5qXQnPF4rutXox3
   dBvznDrb2jg2Dkij7/iEcfWeJFPtJeGTrNBuyZj6yPd2MS14ytobBoSeV
   nxEG5zWlUn+3fHeMJmeFH9iRhWH7xQmoxI8hO1ypB0/suE/uB4NSPbwHY
   Ia69cxEQxlnXdsRlTF4YDCsf9/CTWwBbYsvaRjHvuHGq3izSXBxJw+gfn
   A==;
X-CSE-ConnectionGUID: 1n+Wz/5ySw+tM/G4nYTx9g==
X-CSE-MsgGUID: r8E3opAZREGO4AE8+hjeyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87839461"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="87839461"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 17:18:29 -0700
X-CSE-ConnectionGUID: JGqBL1pjQPm1vat1nnuLNQ==
X-CSE-MsgGUID: UcvvZ0QNTauE/Vavlj0NkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="261914964"
Received: from rodrigoa-mobl1.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.221.152])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 17:18:28 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v5 0/6] perf: Add support for memory region/range reporting
Date: Thu, 20 Aug 2026 19:18:13 -0500
Message-ID: <20260821001819.162277-1-thomas.falcon@intel.com>
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
-- Removed redundant check for existance of memory range directory in
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
-- removed a line of code was removed from util/env.h but was added back in
   v1 due to bad rebase

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
 tools/perf/builtin-c2c.c                      | 125 ++++++++++-
 tools/perf/builtin-inject.c                   |   1 +
 tools/perf/builtin-script.c                   |  13 +-
 tools/perf/util/bpf-filter.l                  |   1 +
 tools/perf/util/env.c                         |   1 +
 tools/perf/util/env.h                         |  10 +
 tools/perf/util/header.c                      | 203 ++++++++++++++++++
 tools/perf/util/header.h                      |   1 +
 tools/perf/util/mem-events.c                  |  93 +++++++-
 tools/perf/util/mem-events.h                  |   5 +-
 .../scripting-engines/trace-event-python.c    |   5 +-
 13 files changed, 452 insertions(+), 21 deletions(-)

-- 
2.55.0

