Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08B7381BE;
	Wed, 15 May 2024 05:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715751892; cv=none; b=i4wBMA8ccJVTEzd8x742LIWmFn3o21Pescacy8Yr5xLRlgJ8YF+qXcishp3F3dIVhVXH6ZD02hPz5nf7UVbwAT8W4oaZs5SLp3zfvi8dpIJCoimjuuj8JVkJXHJAakn+PORro6eZmwGnvOagf0PQfHr7vDqVp1y1Vv3UydZ8HKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715751892; c=relaxed/simple;
	bh=7XoGMtxCAd7+ICLPMvPqSMwCn5yDi3ix+NfHiTn2bDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BIA1c3FzKg+fkRjH3qmfjer1ZVyUOIMDPC/mljNs2L2GqfdxIsP8SmttW5hWjsyfZ19wdEdEemtOB3XvH7V06CjQUHh6O6/E04ULYquuVQ/UHj5WBYbSfhaESYELFM2UqfUBLOlX59ROPdX+Vutwn40E7VlQwCnQZ+vPfhJvHO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D6mg7nqY; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D6mg7nqY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715751890; x=1747287890;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7XoGMtxCAd7+ICLPMvPqSMwCn5yDi3ix+NfHiTn2bDE=;
  b=D6mg7nqYnMel63UnfcEtTdyd/lIOZ2LiNAc8lGPGB0DzcsDT68ErhfQy
   tCowT09U9Za/rYe8wTCCPWirfdXyC5MTBygfKX20Xel3zZ/0DzK0kCZEU
   /bVjWqhIuXCpILybmKKhGzjB8MXNjKeCnXPRhaVtl1uBIpcF+hw40p2Lw
   0xj9Bje+Uj3QoHqaQYcCsyzhP45VIzcZWyfdM7Psdqb3Nva+vRKSC4VlX
   VQImA+Vcy/5kIpvJeDpP9RcvvBoLqECSPXcV42MixAWUna7KxRX8Sapzr
   FFneNh40/Mr8/aYm3rAP/5VramtNJmdbuCXcW8nsOysVq9DnOfHXJF4f/
   A==;
X-CSE-ConnectionGUID: TGXY5UxBQlaE2Kl+9hJCRA==
X-CSE-MsgGUID: i6qKeFsGQju2bdMPk/tmGA==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="29298017"
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="29298017"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 22:44:50 -0700
X-CSE-ConnectionGUID: EvhjijF5REODKp+fBKSY9A==
X-CSE-MsgGUID: xAuiHEzHQi+38SlyhFteYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="35469194"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa003.fm.intel.com with ESMTP; 14 May 2024 22:44:49 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v8 0/7] TPEBS counting mode support
Date: Wed, 15 May 2024 01:44:22 -0400
Message-ID: <20240515054443.2824147-1-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>


Changes in v8:
- In this revision, the code is updated to base on Ian's patch on R modifier
parser https://lore.kernel.org/lkml/20240428053616.1125891-3-irogers@google.com/
After this change, there is no special code required for R modifier in
metricgroup.c and metricgroup.h files.

Caveat of this change:
  Ideally, we will need to add special handling to skip counting events with R
modifier in evsel. Currently, this is not implemented so the event with :R will
be both counted and sampled. Usually, in a metric formula that uses retire_latency,
it would already require to count the event. As a result, we will endup count the
same event twice. This should be able to be handled properly when we finalize our
design on evsel R modifier support.

- Move TPEBS specific code out from main perf stat code to separate files in
util/intel-tpebs.c and util/intel-tpebs.h. [Namhyung]
- Use --control:fifo to ack perf stat from forked perf record instead of sleep(2) [Namhyung]
- Add introductions about TPEBS and R modifier in Documents. [Namhyung]


Changes in v7:
- Update code and comments for better code quality [Namhyung]
- Add a separate commit for perf data [Namhyung]
- Update retire latency print function to improve alignment [Namhyung]

Changes in v6:
- Update code and add comments for better code quality [Namhyung]
- Remove the added fd var and directly pass the opened fd to data.file.fd [Namhyung]
- Add kill() to stop perf record when perf stat exists early [Namhyung]
- Add command opt check to ensure only start perf record when -a/-C given [Namhyung]
- Squash commits [Namhyung]

Changes in v5:
- Update code and add comments for better code quality [Ian]

Changes in v4:
- Remove uncessary debug print and update code and comments for better
readability and quality [Namhyung]
- Update mtl metric json file with consistent TmaL1 and TopdownL1 metricgroup

Changes in v3:
- Remove ':' when event name has '@' [Ian]
- Use 'R' as the modifier instead of "retire_latency" [Ian]

Changes in v2:
- Add MTL metric file
- Add more descriptions and example to the patch [Arnaldo]

Here is an example of running perf stat to collect a metric that uses
retire_latency value of event MEM_INST_RETIRED.STLB_HIT_STORES on a MTL system.

In this simple example, there is no MEM_INST_RETIRED.STLB_HIT_STORES sample.
Therefore, the MEM_INST_RETIRED.STLB_HIT_STORES:p count and retire_latency value
are all 0.

./perf stat -M tma_dtlb_store -a -- sleep 1

[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.000 MB - ]

 Performance counter stats for 'system wide':

       181,047,168      cpu_core/TOPDOWN.SLOTS/          #      0.6 %  tma_dtlb_store
         3,195,608      cpu_core/topdown-retiring/
        40,156,649      cpu_core/topdown-mem-bound/
         3,550,925      cpu_core/topdown-bad-spec/
       117,571,818      cpu_core/topdown-fe-bound/
        57,118,087      cpu_core/topdown-be-bound/
            69,179      cpu_core/EXE_ACTIVITY.BOUND_ON_STORES/
             4,582      cpu_core/MEM_INST_RETIRED.STLB_HIT_STORES/
        30,183,104      cpu_core/CPU_CLK_UNHALTED.DISTRIBUTED/
        30,556,790      cpu_core/CPU_CLK_UNHALTED.THREAD/
           168,486      cpu_core/DTLB_STORE_MISSES.WALK_ACTIVE/
              0.00 MEM_INST_RETIRED.STLB_HIT_STORES:p       0        0

       1.003105924 seconds time elapsed

v1:
TPEBS is one of the features provided by the next generation of Intel PMU.
Please refer to Section 8.4.1 of "Intel® Architecture Instruction Set Extensions
Programming Reference" [1] for more details about this feature.

This set of patches supports TPEBS in counting mode. The code works in the
following way: it forks a perf record process from perf stat when retire_latency
of one or more events are used in a metric formula. Perf stat would send a
SIGTERM signal to perf record before it needs the retire latency value for
metric calculation. Perf stat will then process sample data to extract the
retire latency data for metric calculations. Currently, the code uses the
arithmetic average of retire latency values.

[1] https://www.intel.com/content/www/us/en/content-details/812218/intel-architecture-instruction-set-extensions-programming-reference.html?wapkw=future%20features

Weilin Wang (7):
  perf Document: Add TPEBS to Documents
  perf data: Allow to use given fd in data->file.fd
  perf stat: Fork and launch perf record when perf stat needs to get
    retire latency value for a metric.
  perf stat: Add retire latency values into the expr_parse_ctx to
    prepare for final metric calculation
  perf stat: Add retire latency print functions to print out at the very
    end of print out
  perf vendor events intel: Add MTL metric json files
  perf stat: Skip read retire_lat counters and plugin retire_lat data
    from sampled data

 tools/perf/Documentation/perf-list.txt        |    1 +
 tools/perf/Documentation/topdown.txt          |   18 +
 tools/perf/arch/x86/util/evlist.c             |    6 +
 tools/perf/builtin-stat.c                     |   19 +
 .../arch/x86/meteorlake/metricgroups.json     |  127 +
 .../arch/x86/meteorlake/mtl-metrics.json      | 2551 +++++++++++++++++
 tools/perf/util/Build                         |    1 +
 tools/perf/util/data.c                        |    7 +-
 tools/perf/util/evsel.h                       |    5 +
 tools/perf/util/intel-tpebs.c                 |  285 ++
 tools/perf/util/intel-tpebs.h                 |   29 +
 tools/perf/util/stat-display.c                |   74 +
 tools/perf/util/stat-shadow.c                 |   23 +
 tools/perf/util/stat.h                        |    3 +
 14 files changed, 3148 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json
 create mode 100644 tools/perf/util/intel-tpebs.c
 create mode 100644 tools/perf/util/intel-tpebs.h

--
2.43.0

