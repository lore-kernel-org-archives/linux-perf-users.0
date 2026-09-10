Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7261E408623;
	Thu, 10 Sep 2026 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789069469; cv=none; b=SBzic2tjWT4aeQt1vRom2KjlryS9OCm0TYczOGmpXxe3BOEgByRGJKsXv7VCCWvec+C8lexJZwKuU4jkEY968+XlLYwgJUc32WKeNzjg+Gt+M5wvBDWN/yOw+bWsYG62oB5hwAPUIb/cEMo3YKTDfVqVcmK2Hy/Lf1KKtphA270=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789069469; c=relaxed/simple;
	bh=+iP8/3/Qrb/4ZF2oCBJGBY6cKRIOkqdpPusWQ1vgv7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hlEgb4QZ+fBIYk6Kp78x30+beTI42UNKKRjBii/RKAKIsV/e6VwuyYid9zY2fMj9e8csn3ME6mr/obYHhvAE54/6qTROH0cxz+K2lcLgoqKEGN+zakuL8VD9iqtln2w2G7+KLtPLc42/IlKJXoVprV5LDBU9t28p7F1RwJe+70g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ROdkSoX2; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ROdkSoX2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789069468; x=1820605468;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+iP8/3/Qrb/4ZF2oCBJGBY6cKRIOkqdpPusWQ1vgv7U=;
  b=ROdkSoX2gVQyfbXjOcGUXyVpF+GL5EKBGjDAjJtDRXclioWdFTdCCfSu
   qIPB3obxL8WoWEMm7mEAbUHWYruKqyjtNjVLrnywLt7npPxpbTu9hwCRV
   4tb/xY4AfOqaMNfzq7nFgvk1RrVzxKeXk9aUjU/8KJR/e+IHoppTVDuND
   r9tDEyz+OeE324Jgj7q/7XhuHxTJvAmYGX8NWs0pPXePmVddgMlJ98cTA
   7os2vE3C86OwjveQIYyJ5f6N2hIQwyn4G+IZB1/JUfMeu0wlOJZP/ZFOX
   MJwcDrjxhiRWLM16/ImbIaG9Ln9Z9RxJQZmevM5jeV93Q12uhcHHp7Ejq
   w==;
X-CSE-ConnectionGUID: CX/Y1vtYRMWJuayVnzAx/g==
X-CSE-MsgGUID: PJK+7ZfJSHC6vtkTkTETjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89402886"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="89402886"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 12:43:50 -0700
X-CSE-ConnectionGUID: enGd5jhbSgmbl5KKDF6Ktw==
X-CSE-MsgGUID: bSKM+8hLRmCA1asvmfkkYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="295206753"
Received: from vverma7-mobl3.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.222.113])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 12:43:47 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
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
	James Clark <james.clark@linaro.org>
Subject: [PATCH v8 0/6] perf: Add support for memory region/range reporting
Date: Thu, 10 Sep 2026 14:43:18 -0500
Message-ID: <20260910194324.98002-1-thomas.falcon@intel.com>
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

v8:
-- Updated developer tags and commit messages with real example output
   from perf script and perf c2c

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
 tools/perf/builtin-c2c.c                      | 128 ++++++++++-
 tools/perf/builtin-inject.c                   |   1 +
 tools/perf/builtin-script.c                   |  13 +-
 tools/perf/util/bpf-filter.l                  |   1 +
 tools/perf/util/c2c.h                         |   1 +
 tools/perf/util/env.c                         |   1 +
 tools/perf/util/env.h                         |  10 +
 tools/perf/util/header.c                      | 203 ++++++++++++++++++
 tools/perf/util/header.h                      |   1 +
 tools/perf/util/mem-events.c                  |  93 +++++++-
 tools/perf/util/mem-events.h                  |   5 +-
 .../scripting-engines/trace-event-python.c    |   5 +-
 14 files changed, 454 insertions(+), 23 deletions(-)

-- 
2.43.0

