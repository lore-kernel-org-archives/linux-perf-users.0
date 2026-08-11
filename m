Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A057A3F99FA;
	Tue, 11 Aug 2026 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786469635; cv=none; b=J/6qPU46cSifRHbW0uBqPL7J3I7zlzLtEDHAiTIdm5zdYVI+De2NS3Zc70/H8+PAUkStIG6FXlON+zNb4qPT5jthMhQjKNk7P7kzf8KlFAt4CnEPxYBmMD5W4/8p2fKG/ZDlwvUOiiQ7xM7BTXrtiXd756dles/n+E8PRCpizMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786469635; c=relaxed/simple;
	bh=n9wSg/NaBsu5burPcOhfkcTeIum+EYsf9LDUzCBrJZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mlNMBQB9dXCMsEQidfTW++YxfR4gX9CHJpJ30czac7vGXkLi26IE0xOnWdE/hdou4jg3crPA/9MNR5ELPUqHDWqJ2WEk5DCsA1XjwHRCHyU/4CFnL+NkUetN8U23Z2MD9l5FW1mF0Gis95GkK8X+urWKxB1U5enZS+PeBr8T73w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QAYgoJsT; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QAYgoJsT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786469634; x=1818005634;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n9wSg/NaBsu5burPcOhfkcTeIum+EYsf9LDUzCBrJZE=;
  b=QAYgoJsTmoYxk4x3Hg76I83jENgOG1K8oNkw3Ey6bUEvyyjFDIhf60rv
   9ADts/w6qxCYoST+enjJeAAua/e95nQzY65qKyTtxuJogDY6J21GVsPlc
   bubZjY61xS2Oslb2YyMJdsRzckzQhn4M+0kPD7toLnwMXsnBegLrgOYEv
   NcI7JxbEtk09IfO8CTLZCJfaIqbb8OERHMMvf8mNDhhVlEaS8U1A3MtTd
   geD3e3jd17W5kw80tBh2YpAmwO4Ctn3C9cLrHeZj6Nn1OCzB/jkk8uSXf
   Lz3Yl97+iV8YH4xYeXIAQEwIWIyhy9PJ9Q23oztjbmvJudRZ4jEbsIqIh
   g==;
X-CSE-ConnectionGUID: hwkylbcJR0qhgl5GXlTBcw==
X-CSE-MsgGUID: 9+ZBVAyKQ22R18js1YKczA==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="86863208"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="86863208"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 10:33:53 -0700
X-CSE-ConnectionGUID: Rf/BttBaTXa0Xn2MIXOCaQ==
X-CSE-MsgGUID: zkRXtCtqQyikSgPGJbR3hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="261648009"
Received: from hanvin-mobl3.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.223.16])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 10:33:51 -0700
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
Subject: [PATCH v4 0/6] perf: Add support for memory region/range reporting
Date: Tue, 11 Aug 2026 12:33:34 -0500
Message-ID: <20260811173340.96013-1-thomas.falcon@intel.com>
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
 tools/perf/builtin-c2c.c                      | 123 ++++++++++-
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
 13 files changed, 449 insertions(+), 22 deletions(-)

-- 
2.55.0

