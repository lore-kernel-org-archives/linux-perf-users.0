Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AB734040C;
	Thu,  9 Jul 2026 22:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783635469; cv=none; b=G/A80m6SRaaLauJ7ztcxEJ16jXwhBPyKrHxiGPWfNLvGPvMpXEc6q8Pj6J8HggocLuqgFP3M2xg3CPonj4GBYmlcz3Xm72OYHv1STOyc5THT71kOBYsa92RU76EaHA3bwI138Yb5n67KXGIMWrHboZXJ9ssdO6l8jdmwGNkt5ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783635469; c=relaxed/simple;
	bh=cU0D0esuUWhL6exJPLNWrE9uBgStLdLn9qrVihyiWj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L9ZBhsbNZfh7paOgxHFabUfXxVo5OUkfcD9cFUiQqLO1yUeXDTGwnCZq7h+AtySH935gxNIHTZGLGbqwdgTPkbwUrPtVGL8Aq3J7Uapxd44Jz4Dw+hXOIiPbFJJpbuzZ1sdrACRX1Dg1VrZrUrC5IxZesMCw67CY2Aw3oyCBsXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mQLVhNAz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mQLVhNAz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783635468; x=1815171468;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cU0D0esuUWhL6exJPLNWrE9uBgStLdLn9qrVihyiWj4=;
  b=mQLVhNAzNRFiBYjEM/4LezpGsZth+wKbQ29xwYQ3TJstTzCu9nRerotu
   g7BWKytCwvkHbknBk4BJEtAqGZ/PBGnhNv5X5ryl7W3j2F+wNyGKDTXBh
   JPwhSHGAyHc6arTIJhV1ZY6j7XgcgVWT2hCruj/v3+by0TFuMs6UNIKpy
   rxa8+SlOI4RtxzA0x3c2WHiYGOqgmNoet5KIoDB/zBg25oA1B1AO6Eayc
   RZaISGkBIWIqFTe9xc4rXALvCvIIfzMKi0atuWyNQix6qPpeGAnffdwcU
   Ir8iSUH0utY+9bwyHDLxMWrnZ0q62c/fQ1t+2mjzCzYuyexjI7/neLLh/
   w==;
X-CSE-ConnectionGUID: QNlmnOU/RwKs1U1rJgiRSw==
X-CSE-MsgGUID: v85Me6wrSQGX6/+ZMc+8DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88163359"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88163359"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:17:47 -0700
X-CSE-ConnectionGUID: 4Bhcx5s5QFmE44eL9Sa5Tg==
X-CSE-MsgGUID: GmNoeHNETcOZU6gaDYRg4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259620875"
Received: from khuang2-desk.gar.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.223.97])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:17:45 -0700
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
Subject: [PATCH 0/6] perf: Add support for memory region/range reporting
Date: Thu,  9 Jul 2026 17:17:30 -0500
Message-ID: <20260709221736.33446-1-thomas.falcon@intel.com>
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
 tools/perf/util/env.h                         |  12 ++
 tools/perf/util/header.c                      | 187 ++++++++++++++++++
 tools/perf/util/header.h                      |   1 +
 tools/perf/util/mem-events.c                  |  75 ++++++-
 tools/perf/util/mem-events.h                  |   1 +
 .../scripting-engines/trace-event-python.c    |   4 +-
 13 files changed, 382 insertions(+), 10 deletions(-)

-- 
2.43.0

