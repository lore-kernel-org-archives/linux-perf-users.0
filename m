Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB62EAC7;
	Tue, 14 Jul 2026 00:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783989851; cv=none; b=ogUn4mi8XFTO/xqIIeg9Subhx4QloyS8u2JqNdwZ5aUPhasy9dEBMfxZUT+i6O0MxXuovsZxRYKJ961/mOyhxMhrZGQorQ5pIiFJOWBxrGurR7iSpS04W05PxBJZ71Skt4flGCkTlkUY9pyLbVo2NuZkbVfvufiSeP7WO4HDDUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783989851; c=relaxed/simple;
	bh=d/qGCwMDDm+Vxfq0u4vcJ7IqB65HGM5iIxR+0vd+IH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SineFnb6jU3i7J64E4DwOz5W3xMnO6sD6JTRVkiqXgZkHEvhWpS7MzKnv56aSK3UmByIH1HAjH62T4+DcJbhbmQ5hHECkyOxSFVD5SjvugiuWeOkQnm0Ka3yDibSs0odrDRM/X3/V5L/9YHH4sIMZXby6AJJfAPxJg1sJ55MeYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f+07eVKx; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f+07eVKx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783989849; x=1815525849;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d/qGCwMDDm+Vxfq0u4vcJ7IqB65HGM5iIxR+0vd+IH0=;
  b=f+07eVKxN9mZ3aaTjZMC5/Qh3zQNGCsln7gX0sCPMefgqjQu/Zeh2dWJ
   W9bicPHN2V9Pb+LRkaaNy5zi3XCDiQi2/HcNvcQLIuBquMLDdWAo2iplQ
   MiIzjZBtZcqyBGCtwsfKwDCF172TbZ6xGMtf42Ej0lphbZ5VOz605okrL
   FMxKT/Yf3LhmtPzpn1iDemejZ28UVJqnzGTNI8GR935k7iLY9XyLFQOiP
   Sthwa3gYJhlguv5fdz9r8Mqkf0V/1tA73lMyf/9fUJbFqrOQRkNoPFKh/
   JkWDfPM4NBwvemwSN6VEzPi2Kl1gYRsEQqWU9gQnhnz/OJdWtTnkvslnV
   Q==;
X-CSE-ConnectionGUID: 6AIH7sVqSVScD4o2BcyPQA==
X-CSE-MsgGUID: Q6ErNtPNS+aMBraDnz9pmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="72130627"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="72130627"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 17:44:09 -0700
X-CSE-ConnectionGUID: ZC13QJBjQ/yJQCzGEIatow==
X-CSE-MsgGUID: KwJ6CK3/SLWwT0PrrxLv1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="260582103"
Received: from rodrigoa-mobl1.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.220.48])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 17:44:07 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v2 0/6] perf: Add support for memory region/range reporting
Date: Mon, 13 Jul 2026 19:43:53 -0500
Message-ID: <20260714004359.179451-1-thomas.falcon@intel.com>
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

Changes in v2: 
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
 tools/perf/builtin-c2c.c                      |  86 +++++++-
 tools/perf/builtin-inject.c                   |   1 +
 tools/perf/builtin-script.c                   |   8 +-
 tools/perf/util/bpf-filter.l                  |   1 +
 tools/perf/util/env.c                         |   1 +
 tools/perf/util/env.h                         |  10 +
 tools/perf/util/header.c                      | 195 ++++++++++++++++++
 tools/perf/util/header.h                      |   1 +
 tools/perf/util/mem-events.c                  |  75 ++++++-
 tools/perf/util/mem-events.h                  |   1 +
 .../scripting-engines/trace-event-python.c    |   4 +-
 13 files changed, 388 insertions(+), 10 deletions(-)

-- 
2.43.0

