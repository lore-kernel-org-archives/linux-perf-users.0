Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5669D482D0;
	Tue, 21 May 2024 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716313199; cv=none; b=LCzo+LF2SHXmAEe9WcpnF9FX+Nnk6A1d38Bp9zkPTiLPkcAsiPj8bNhjHNIRgx0uIecnLUuAe7I/pZc0Pplz7dG0HRmZ8pleYo1y+pJ47qVezfYifHrsBdeboJPD97T2rxwx5FcUiKuHEfzwFl8DqG2lwwF7ae++/IlXda5rBSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716313199; c=relaxed/simple;
	bh=PNdzHnRn/PnOCUikfVwtfCpLWlvvqc78Sicg+9KqnGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mYZBebSIL4pwUlPw3OIFFaRQp0X/ZcSQk4SyD+R/5RzUv0PCU0RptKvp7Tp5CxnqBI3A1ui3xQIT8H1IORBQl8bx+k7s4CuQwlhyAKcvIULvuSBkkr0fUVLxwYXjyZlUJOnz2vfaQpPROWkXJ/4/FYqgMq3bpAChs1Wz1drb+MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZedaQEgu; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZedaQEgu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716313197; x=1747849197;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PNdzHnRn/PnOCUikfVwtfCpLWlvvqc78Sicg+9KqnGU=;
  b=ZedaQEguB03HA1B0pnRd+ABku7dWRZRJ2/wGqPdSP/bi/kjeuCQ2u0LU
   eANEjWyISrcZPPt7FRiZcuMFyhmUWVhVguE35lJQyVXpZdIPXUc6X7NuE
   /AbKFEZnVuu2LWUFfY8H+iKEW1iZo5B0kH2peEm/AGcwR/9oR6U2OHLQL
   kyMj5pO2QDjxCWXEDnkkNB326NOQcdNiy6LaqgCS34jlyk9vOqLkFRs7X
   M1If5nfGSjnmc6VjNHmQclyENznGmjXmoHypX80BoenOZLJzSyTy3KyhM
   sEqe27gYt9POJE5QsbV1TB9xlao/a/SoNUE5lU/RoOFYq40cmCwleAqjD
   w==;
X-CSE-ConnectionGUID: 62Rn0SE8TI+wonunbE/MRg==
X-CSE-MsgGUID: ebbGo4XYT+yrIsele8dYlQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12317637"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="12317637"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 10:39:56 -0700
X-CSE-ConnectionGUID: IJ1hew+nQpyzklvcWi+8Ng==
X-CSE-MsgGUID: KPjOfuo/SdisIsmtpGRA/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="32924933"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa007.fm.intel.com with ESMTP; 21 May 2024 10:39:56 -0700
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
Subject: [RFC PATCH v9 0/7] TPEBS counting mode support
Date: Tue, 21 May 2024 13:39:28 -0400
Message-ID: <20240521173952.3397644-1-weilin.wang@intel.com>
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


Weilin Wang (7):
  perf vendor events intel: Add MTL metric json files
  perf data: Allow to use given fd in data->file.fd
  perf stat: Fork and launch perf record when perf stat needs to get
    retire latency value for a metric.
  perf stat: Plugin retire_lat value from sampled data to evsel
  perf stat: Add command line option for enabling tpebs recording
  perf Document: Add TPEBS to Documents
  perf test: Add test for Intel TPEBS counting mode

 tools/perf/Documentation/perf-list.txt        |    1 +
 tools/perf/Documentation/topdown.txt          |   30 +
 tools/perf/arch/x86/util/evlist.c             |    6 +
 tools/perf/builtin-stat.c                     |   24 +
 .../arch/x86/meteorlake/metricgroups.json     |  127 +
 .../arch/x86/meteorlake/mtl-metrics.json      | 2551 +++++++++++++++++
 .../perf/tests/shell/test_stat_intel_tpebs.sh |   27 +
 tools/perf/util/Build                         |    1 +
 tools/perf/util/data.c                        |    7 +-
 tools/perf/util/evsel.c                       |   53 +
 tools/perf/util/evsel.h                       |    5 +
 tools/perf/util/intel-tpebs.c                 |  301 ++
 tools/perf/util/intel-tpebs.h                 |   30 +
 tools/perf/util/stat.h                        |    1 +
 14 files changed, 3163 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json
 create mode 100755 tools/perf/tests/shell/test_stat_intel_tpebs.sh
 create mode 100644 tools/perf/util/intel-tpebs.c
 create mode 100644 tools/perf/util/intel-tpebs.h

--
2.43.0

