Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0F238DE8;
	Wed, 29 May 2024 06:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716965016; cv=none; b=M2t4WiN5wmxHq7TuJBxN+hbxrys0TpdrifZONojSnMj5rd1Fa01MgxV13fkcpfLv+TZw+44fpz4XK7QVnYPNornwCWy/sL0IL2fqfsNf5hxCUAVqEfFq1O1YMe3yg6dKkUCXrrP+BKr8hVrtre9pN4sJuBXnDDnAZoY7M01qV74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716965016; c=relaxed/simple;
	bh=9bMOYC/3TXNfLMxzK4TbkcsOU/3B9utGKd1/mu8n6Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eZMdIx19dnv7HJZrl98dD43uFGLnWF28N0fl0JU85MWssD27kVaL34aRIicz0rEdqaptIiYYaE1A0QVBcB/G6SOO9Va5+wb9NyQB4Jo+dzg1Jpr0t433ipysSvofO6IO3xgX8buCblqtpANlj+xdecS8jjB4iuH7lqZzCSA24Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OV31kIFV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OV31kIFV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716965015; x=1748501015;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9bMOYC/3TXNfLMxzK4TbkcsOU/3B9utGKd1/mu8n6Fo=;
  b=OV31kIFVzTgNM60g1qcUaQP8nK5hVF3MN+uKAO18CJ7OYOI+n1WSJIct
   ZHGNaTzvlnP0+KQWjQ5mRF0zcC2wjRs3L3Dbd/6Kf3+uRLdf5CZlKkUyi
   cchnVXePV9EKOzj6rQFzdT78v+Cpp118iyjbyoA93OEyhsUem0fvpHN8O
   mj1HoSXO8cRUJEzN75R/d4HL2ehg+p92t/CdXK53uFrj2GpOToXDGSx2z
   JvFB+uvM1hte9VEPOHfJr1fB/hjv2go99NyIhsK41GmOjsJP/SwYw51OZ
   P3LaFLmrD6sHql7c6W55yxkhd99EEqCHKaUT+HspEca9PQ1Sq2x3kxlIH
   g==;
X-CSE-ConnectionGUID: jWy2PBFlRGqEMXazorE11Q==
X-CSE-MsgGUID: Z75Bc+i1T9OHh9RDro3x9A==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="16297976"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="16297976"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 23:43:34 -0700
X-CSE-ConnectionGUID: Cmy0Gz79QaG+EQ9Vy6uIXw==
X-CSE-MsgGUID: kGlj2FVvSVq5mU4AAnH87Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="39759246"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa005.fm.intel.com with ESMTP; 28 May 2024 23:43:33 -0700
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
Subject: [RFC PATCH v10 0/8] TPEBS counting mode support
Date: Wed, 29 May 2024 02:43:16 -0400
Message-ID: <20240529064327.4080674-1-weilin.wang@intel.com>
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

I have tried not to count retire_latency events but did not succeed.
In particular, I tried the following methods:
 - Convert retire_latency event to dummy event in event parser.
 - Early bail out in evsel__open_cpu() and store_evsel_ids().

The first method fails and causes non-retire_latency events with the same event
name return 0 count.

The second method fails and causes all the events in the same group returning
"<not counted>" results.

Because of above, the retire_latency event will still run in counting mode.

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

Weilin Wang (7):
  perf data: Allow to use given fd in data->file.fd
  perf stat: Fork and launch perf record when perf stat needs to get
    retire latency value for a metric.
  perf stat: Plugin retire_lat value from sampled data to evsel
  perf vendor events intel: Add MTL metric json files
  perf stat: Add command line option for enabling tpebs recording
  perf Document: Add TPEBS to Documents
  perf test: Add test for Intel TPEBS counting mode

 tools/perf/Documentation/perf-list.txt        |    1 +
 tools/perf/Documentation/topdown.txt          |   30 +
 tools/perf/arch/x86/util/evlist.c             |    6 +
 tools/perf/builtin-stat.c                     |    8 +
 .../arch/x86/meteorlake/metricgroups.json     |  140 +
 .../arch/x86/meteorlake/mtl-metrics.json      | 2595 +++++++++++++++++
 .../perf/tests/shell/test_stat_intel_tpebs.sh |   19 +
 tools/perf/util/Build                         |    1 +
 tools/perf/util/data.c                        |    7 +-
 tools/perf/util/evsel.c                       |   26 +
 tools/perf/util/evsel.h                       |    6 +
 tools/perf/util/intel-tpebs.c                 |  397 +++
 tools/perf/util/intel-tpebs.h                 |   48 +
 tools/perf/util/parse-events.c                |    2 +
 tools/perf/util/parse-events.h                |    1 +
 tools/perf/util/parse-events.l                |    3 +-
 16 files changed, 3288 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json
 create mode 100755 tools/perf/tests/shell/test_stat_intel_tpebs.sh
 create mode 100644 tools/perf/util/intel-tpebs.c
 create mode 100644 tools/perf/util/intel-tpebs.h

--
2.43.0

