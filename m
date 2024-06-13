Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CF412F592;
	Thu, 13 Jun 2024 03:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718249797; cv=none; b=RCWOLG6C22ztPPDrrtrbfi/nNKBoS8Q/HpyBSRAatwI8THzYDt0NeAah3iwpWPh4AQCKFRJvHmqcftSJf8oUUUe35mWPUklkmJMtEtoEnAcXJ5ahed1X9lhZEoq1ycFOXk00Jat6DgwvWFQ+ksdPAOWwbypHVF25ilnzu8rxWoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718249797; c=relaxed/simple;
	bh=HfrdsSfV6rwUCz3r7qlZ9/oNNUkE+BXlxiT6cvn2ZDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BFh36Oc74lKxGWXE0SrDDGrJvRL7lUtg83Pd6iDbkyHdTtSaqcXnSx4PdmVmjhevjlH0HZj2lDJt0JVSkQtX0P7K55pnD+UkHcyFva/SdX8jlaf80oK5/j4ioKJUrqLLtOU+S9AyA2KIx64Cq6AAH/tEN+kleEqYmI57emnKcuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZtVvwzsG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZtVvwzsG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718249796; x=1749785796;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HfrdsSfV6rwUCz3r7qlZ9/oNNUkE+BXlxiT6cvn2ZDs=;
  b=ZtVvwzsGAa9Kgx9kSZ2lQkyuP1mFVDgGVxwZkSmB5CCJoRFKuhYD/vn7
   OulykqjzwCfOOqVzYA0w06m2DREcs+ZSIrs/lHIjqOQ6QiuoT+066F4cR
   50RgsoPblWXz61jydrB/5GxJlJBbouKk8a0bfKCyF1PkpTjA7xQWgdIAS
   q/NT9XPVuUYd2iFeHmqs2C+aBHRfWDq6d0AeLgQkZJrBqq5byBXGtBWWq
   mmiHrUFqhpQIOAvzEj7TYIVAadslCfCfdCiIG9RwrFFIjso3Xza/PGgna
   FMKv2jJy4XwvDDH+mpFUNIfVGMibOlzXtXg5XIFTds5zSpVCBlp60RTjk
   w==;
X-CSE-ConnectionGUID: NWnJuMhCQdiNq3f7QqTOqw==
X-CSE-MsgGUID: erEvxvGMSgav11zHstGBJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="12046696"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="12046696"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 20:36:35 -0700
X-CSE-ConnectionGUID: j34TDBVWR6uAbkSy6yOC3A==
X-CSE-MsgGUID: mMMNQzzFSzycyLpN9c4jsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="40100339"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa009.fm.intel.com with ESMTP; 12 Jun 2024 20:36:34 -0700
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
Subject: [RFC PATCH v13 0/9] TPEBS counting mode support
Date: Wed, 12 Jun 2024 23:36:20 -0400
Message-ID: <20240613033631.199800-1-weilin.wang@intel.com>
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

Changes in v13:
 - Add document for the command line option and fix build error in non-x86_64.
 - Update example with non-zero retire_latency value when tpebs recording is
 enabled.
 - Add tpebs_stop() back to tpebs_set_evsel() because in hybrid platform, when
 the forked perf record is not killed, the reader thread does not get any
 sampled data from the PIPE. As a result, tpebs_set_evesel() will always return
 zero on retire_latency values. This does not happen on my test GNR machine.
 Since -I is not supported yet, I think we should add tpebs_stop() to ensure
 correctness for now. More investigation is required here when we work on
 supporting -I mode.

Changes in v12:
 - Update MTL metric JSON file to include E-Core TMA3.6 changes.
 - Update comments and code for better code quality. Keep tpebs_start() and
 tpebs_delete() at evsel level for now and add comments on these functions with
 more details about potential future changes. Remove tpebs_stop() call from
 tpebs_set_evsel(). Simplify the tpebs_start() and tpebs_stop()/tpebs_delete()
 interfaces. Also fixed the bugs on not freed "new" pointer and the incorrect
 variable value assignment to val instead of counter->val.

Changes in v11:
 - Make retire_latency evsels not opened for counting. This works correctly now
 with the code Namhyung suggested that adjusting group read size when
 retire_latency evsels included in the group.
 - Update retire_latency value assignment using rint() to reduce precision loss
 while keeping code generic.
 - Fix the build error caused by not used variable in the test.

Other changes in v10:
 - Change perf record fork from perf stat to evsel. All the major operations
 like tpebs start, stop, read_evsel should directly work through evsel.
 - Make intel-tpebs x86_64 only. This change is cross-compiled to arm64.
 - Put tpebs code to intel-tepbs and simplify intel-tpebs APIs to minimum number
of functions and variables. Update funtion name and variable names to use
consistent prefix. Also improve error handling.
 - Integrate code patch from Ian for the :R parser.
 - Update MTL metrics to TMA 4.8.

V9: https://lore.kernel.org/all/20240521173952.3397644-1-weilin.wang@intel.com/

Changes in v9:
 - Update the retire_latency result print and metric calculation method. Plugin
the value to evsel so that no special code is required.
 - Update --control:fifo to use pipe instead of named pipe.
 - Add test for TPEBS counting mode.
 - Update Document with more details.

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




Ian Rogers (1):
  perf parse-events: Add a retirement latency modifier

Weilin Wang (8):
  Add fake testing metrics for GNR
  perf data: Allow to use given fd in data->file.fd
  perf stat: Fork and launch perf record when perf stat needs to get
    retire latency value for a metric.
  perf stat: Plugin retire_lat value from sampled data to evsel
  perf vendor events intel: Add MTL metric json files
  perf stat: Add command line option for enabling tpebs recording
  perf Document: Add TPEBS to Documents
  perf test: Add test for Intel TPEBS counting mode

 tools/perf/Documentation/perf-list.txt        |    1 +
 tools/perf/Documentation/perf-stat.txt        |    8 +
 tools/perf/Documentation/topdown.txt          |   30 +
 tools/perf/arch/x86/util/evlist.c             |    6 +
 tools/perf/builtin-stat.c                     |    8 +
 .../arch/x86/graniterapids/cache.json         |  686 +++++
 .../arch/x86/graniterapids/frontend.json      |  425 +++
 .../arch/x86/graniterapids/gnr-metrics.json   |  108 +
 .../arch/x86/graniterapids/memory.json        |  169 +-
 .../arch/x86/graniterapids/metricgroups.json  |  118 +
 .../arch/x86/graniterapids/pipeline.json      |  881 ++++++
 .../arch/x86/meteorlake/metricgroups.json     |  142 +
 .../arch/x86/meteorlake/mtl-metrics.json      | 2535 +++++++++++++++++
 .../perf/tests/shell/test_stat_intel_tpebs.sh |   18 +
 tools/perf/util/Build                         |    1 +
 tools/perf/util/data.c                        |    7 +-
 tools/perf/util/evlist.c                      |    2 +
 tools/perf/util/evsel.c                       |   81 +-
 tools/perf/util/evsel.h                       |    6 +
 tools/perf/util/intel-tpebs.c                 |  407 +++
 tools/perf/util/intel-tpebs.h                 |   35 +
 tools/perf/util/parse-events.c                |    2 +
 tools/perf/util/parse-events.h                |    1 +
 tools/perf/util/parse-events.l                |    3 +-
 24 files changed, 5619 insertions(+), 61 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/gnr-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json
 create mode 100755 tools/perf/tests/shell/test_stat_intel_tpebs.sh
 create mode 100644 tools/perf/util/intel-tpebs.c
 create mode 100644 tools/perf/util/intel-tpebs.h

--
2.43.0

