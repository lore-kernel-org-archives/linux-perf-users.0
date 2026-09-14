Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7342DC792;
	Mon, 14 Sep 2026 22:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426022; cv=none; b=tX5NEslV1NQavDqdaTJrheIp0cXuABaGYEStZCJ45+zy64fvtptK8D1N25MDWbmyRS4Xg7ZVafrpBZHdt7ialpI6Tc4HqVEZMgOqqU1jLf/pvaFFk1C2ORZ5rbFZPPR0qmy3KpygYOJbPNzAsY/LpH7qcDL22FxFFn8YvLugGxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426022; c=relaxed/simple;
	bh=kh+QQ6ry8vOKWEyv/eS4sTqcIET1KjfY0N6gpysN7fw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tTw9IASoO68J34TDgK2b1xjSKWcS1rmeurXbVqxGFpFr8qNiKnWNsYhnVFPtvF4YlcMXhiJUxKmnRmvgdTe3qGpUIAgOV6e65wugrxgMX5kIEAX91d4xLQKljRsnpFwaZf2gbiexrjXfUc2fAeI+2oBNla2jNxnQ/oTKo7BVYzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bDMf7vVo; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bDMf7vVo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789426021; x=1820962021;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kh+QQ6ry8vOKWEyv/eS4sTqcIET1KjfY0N6gpysN7fw=;
  b=bDMf7vVonuo7ag6oUAx2kSP5u7pi6HwE9Y+BuRuCYViDEHQDWOSk/hbk
   7r40Vk3yrueY7aUxhSX95VbxG28HwmACE0EPxK7cAdIhLQySUdgInYQO5
   lnwpZ3Z3FcPQF7qVTrW8BC6Ifvc3s8pfJNMlWQLEgBPrHEiH2e1em2QMw
   3fLkE+fMT+9lKRZjABs/8c64WZ9R8rsjIKVtHI5oAIqXXravLKzz7q/Fm
   lntQgU1BSOaoYV2EWRN2fCNb3f0xJy+G3X8vVAHVWPrMyeqo2DlXju0Va
   YsnJOn4abqZQFCdRrZ8xVRVM4Aa6PxwyWQXG7rV+P/MFcj8WgowfRaUcW
   g==;
X-CSE-ConnectionGUID: N1RMs8Y7R7yhbregWl+wyA==
X-CSE-MsgGUID: RTe3B2PfSam7E5Lh5cUsWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93483206"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93483206"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 15:47:00 -0700
X-CSE-ConnectionGUID: oPk1XuhSTgW6RgtzZF4wBw==
X-CSE-MsgGUID: Frnz3MZNQQGp9e3UTb3AfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="268480088"
Received: from khuang2-desk.gar.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.223.56])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 15:46:59 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH v9 0/6] perf: Add support for memory region/range reporting
Date: Mon, 14 Sep 2026 17:46:44 -0500
Message-ID: <20260914224650.52982-1-thomas.falcon@intel.com>
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
 tools/perf/builtin-c2c.c                      | 156 +++++++++++++-
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
 14 files changed, 482 insertions(+), 23 deletions(-)

-- 
2.55.0

