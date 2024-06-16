Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D72632;
	Sun, 16 Jun 2024 04:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718510490; cv=none; b=UFz8/3ArskvGHdz79+XHdtLTkVri48ng+yOg7yzkMrv+Gs9Bc5oWP1EGRQ18ozVZhGdy4t4ISTPeflqf7OmGl2URrBrrGuBXSgCyUGL8CvdHottgHT8vIwSoD/i3t4MrZk5uefr+topduzA9KOk6HCcjOcNpPzGG80TZmzdZRvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718510490; c=relaxed/simple;
	bh=lBuSW7rZlPyl5Qc+QRxu72EZtYkJS2fVX8bCXt0iQgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ty3zMt13wFEtzutLUMd2zS2d/1QnJe1IaSrwdZ08Ul1aNkrPkM+CTn6Ouck3VxRGHDaRe+eGZCUVlh3GBDRgudmSZrPVSZMawcKtdyq04F7Shci0eoDeWOmP8Dkt0WUUEH2kQ9tKQjIQpJt9/JHT7dgLc4//qqpDateH9Z2uBCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lI7k3PDy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lI7k3PDy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE39C2BBFC;
	Sun, 16 Jun 2024 04:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718510489;
	bh=lBuSW7rZlPyl5Qc+QRxu72EZtYkJS2fVX8bCXt0iQgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lI7k3PDyNasp6CW0rYMfpGRD7cUqnF4XpeYM3wCcOupHQhvTFCHgjde9hK6Ch9kqj
	 3jdka4fUF0EWXZhfO1G2WAtBSvENUUdVi2ZPOYQuPN/UZs3XFvEEwnJGUPXUEoK8Zw
	 MeemgnUeeR6k4GwVPXvWYZWmy6mM2mtt7YZ18tcQGZhl9GizW8xJKbxODiI6MG6nS6
	 2V16KBEKsTaCottbJaYyLZD1+sFB3dd/BXoKxpd7XH3bABROQF50U1dxUSbvAyN5mJ
	 9IOtWyd45FwbtVBEBUM8pvXZX/uN/s10IFDddqWfnh9FQqiIsch6WSfPgvhgLA5BwK
	 qTHKi5RtJkKwA==
Date: Sat, 15 Jun 2024 21:01:26 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: weilin.wang@intel.com
Cc: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: Re: [RFC PATCH v13 0/9] TPEBS counting mode support
Message-ID: <Zm5jllieoEJsooSl@google.com>
References: <20240613033631.199800-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240613033631.199800-1-weilin.wang@intel.com>

On Wed, Jun 12, 2024 at 11:36:20PM -0400, weilin.wang@intel.com wrote:
> From: Weilin Wang <weilin.wang@intel.com>
> 
> Changes in v13:
>  - Add document for the command line option and fix build error in non-x86_64.
>  - Update example with non-zero retire_latency value when tpebs recording is
>  enabled.
>  - Add tpebs_stop() back to tpebs_set_evsel() because in hybrid platform, when
>  the forked perf record is not killed, the reader thread does not get any
>  sampled data from the PIPE. As a result, tpebs_set_evesel() will always return
>  zero on retire_latency values. This does not happen on my test GNR machine.
>  Since -I is not supported yet, I think we should add tpebs_stop() to ensure
>  correctness for now. More investigation is required here when we work on
>  supporting -I mode.

The python import test failed too:

  $ ./perf test -v python
   17: 'import perf' in python:
  --- start ---
  test child forked, pid 3851973
  python usage test: "echo "import sys ; sys.path.insert(0, 'python'); import perf" | '/usr/bin/python3' "
  Traceback (most recent call last):
    File "<stdin>", line 1, in <module>
  ImportError: /home/namhyung/linux/tools/perf/python/perf.cpython-311-x86_64-linux-gnu.so: undefined symbol: tpebs_set_evsel
  ---- end(-1) ----
   17: 'import perf' in python                                         : FAILED!

Thanks,
Namhyung

> 
> Changes in v12:
>  - Update MTL metric JSON file to include E-Core TMA3.6 changes.
>  - Update comments and code for better code quality. Keep tpebs_start() and
>  tpebs_delete() at evsel level for now and add comments on these functions with
>  more details about potential future changes. Remove tpebs_stop() call from
>  tpebs_set_evsel(). Simplify the tpebs_start() and tpebs_stop()/tpebs_delete()
>  interfaces. Also fixed the bugs on not freed "new" pointer and the incorrect
>  variable value assignment to val instead of counter->val.
> 
> Changes in v11:
>  - Make retire_latency evsels not opened for counting. This works correctly now
>  with the code Namhyung suggested that adjusting group read size when
>  retire_latency evsels included in the group.
>  - Update retire_latency value assignment using rint() to reduce precision loss
>  while keeping code generic.
>  - Fix the build error caused by not used variable in the test.
> 
> Other changes in v10:
>  - Change perf record fork from perf stat to evsel. All the major operations
>  like tpebs start, stop, read_evsel should directly work through evsel.
>  - Make intel-tpebs x86_64 only. This change is cross-compiled to arm64.
>  - Put tpebs code to intel-tepbs and simplify intel-tpebs APIs to minimum number
> of functions and variables. Update funtion name and variable names to use
> consistent prefix. Also improve error handling.
>  - Integrate code patch from Ian for the :R parser.
>  - Update MTL metrics to TMA 4.8.
> 
> V9: https://lore.kernel.org/all/20240521173952.3397644-1-weilin.wang@intel.com/
> 
> Changes in v9:
>  - Update the retire_latency result print and metric calculation method. Plugin
> the value to evsel so that no special code is required.
>  - Update --control:fifo to use pipe instead of named pipe.
>  - Add test for TPEBS counting mode.
>  - Update Document with more details.
> 
> Changes in v8:
>  - In this revision, the code is updated to base on Ian's patch on R modifier
> parser https://lore.kernel.org/lkml/20240428053616.1125891-3-irogers@google.com/
> After this change, there is no special code required for R modifier in
> metricgroup.c and metricgroup.h files.
> 
> Caveat of this change:
>   Ideally, we will need to add special handling to skip counting events with R
> modifier in evsel. Currently, this is not implemented so the event with :R will
> be both counted and sampled. Usually, in a metric formula that uses retire_latency,
> it would already require to count the event. As a result, we will endup count the
> same event twice. This should be able to be handled properly when we finalize our
> design on evsel R modifier support.
> 
>  - Move TPEBS specific code out from main perf stat code to separate files in
> util/intel-tpebs.c and util/intel-tpebs.h. [Namhyung]
>  - Use --control:fifo to ack perf stat from forked perf record instead of sleep(2) [Namhyung]
>  - Add introductions about TPEBS and R modifier in Documents. [Namhyung]
> 
> 
> Changes in v7:
>  - Update code and comments for better code quality [Namhyung]
>  - Add a separate commit for perf data [Namhyung]
>  - Update retire latency print function to improve alignment [Namhyung]
> 
> Changes in v6:
>  - Update code and add comments for better code quality [Namhyung]
>  - Remove the added fd var and directly pass the opened fd to data.file.fd [Namhyung]
>  - Add kill() to stop perf record when perf stat exists early [Namhyung]
>  - Add command opt check to ensure only start perf record when -a/-C given [Namhyung]
>  - Squash commits [Namhyung]
> 
> Changes in v5:
>  - Update code and add comments for better code quality [Ian]
> 
> Changes in v4:
>  - Remove uncessary debug print and update code and comments for better
> readability and quality [Namhyung]
>  - Update mtl metric json file with consistent TmaL1 and TopdownL1 metricgroup
> 
> Changes in v3:
>  - Remove ':' when event name has '@' [Ian]
>  - Use 'R' as the modifier instead of "retire_latency" [Ian]
> 
> Changes in v2:
>  - Add MTL metric file
>  - Add more descriptions and example to the patch [Arnaldo]
> 
> Here is an example of running perf stat to collect a metric that uses
> retire_latency value of event MEM_INST_RETIRED.STLB_HIT_STORES on a MTL system.
> 
> In this simple example, there is no MEM_INST_RETIRED.STLB_HIT_STORES sample.
> Therefore, the MEM_INST_RETIRED.STLB_HIT_STORES:p count and retire_latency value
> are all 0.
> 
> ./perf stat -M tma_dtlb_store -a -- sleep 1
> 
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.000 MB - ]
> 
>  Performance counter stats for 'system wide':
> 
>        181,047,168      cpu_core/TOPDOWN.SLOTS/          #      0.6 %  tma_dtlb_store
>          3,195,608      cpu_core/topdown-retiring/
>         40,156,649      cpu_core/topdown-mem-bound/
>          3,550,925      cpu_core/topdown-bad-spec/
>        117,571,818      cpu_core/topdown-fe-bound/
>         57,118,087      cpu_core/topdown-be-bound/
>             69,179      cpu_core/EXE_ACTIVITY.BOUND_ON_STORES/
>              4,582      cpu_core/MEM_INST_RETIRED.STLB_HIT_STORES/
>         30,183,104      cpu_core/CPU_CLK_UNHALTED.DISTRIBUTED/
>         30,556,790      cpu_core/CPU_CLK_UNHALTED.THREAD/
>            168,486      cpu_core/DTLB_STORE_MISSES.WALK_ACTIVE/
>               0.00 MEM_INST_RETIRED.STLB_HIT_STORES:p       0        0
> 
>        1.003105924 seconds time elapsed
> 
> v1:
> TPEBS is one of the features provided by the next generation of Intel PMU.
> Please refer to Section 8.4.1 of "Intel® Architecture Instruction Set Extensions
> Programming Reference" [1] for more details about this feature.
> 
> This set of patches supports TPEBS in counting mode. The code works in the
> following way: it forks a perf record process from perf stat when retire_latency
> of one or more events are used in a metric formula. Perf stat would send a
> SIGTERM signal to perf record before it needs the retire latency value for
> metric calculation. Perf stat will then process sample data to extract the
> retire latency data for metric calculations. Currently, the code uses the
> arithmetic average of retire latency values.
> 
> [1] https://www.intel.com/content/www/us/en/content-details/812218/intel-architecture-instruction-set-extensions-programming-reference.html?wapkw=future%20features
> 
> 
> 
> 
> Ian Rogers (1):
>   perf parse-events: Add a retirement latency modifier
> 
> Weilin Wang (8):
>   Add fake testing metrics for GNR
>   perf data: Allow to use given fd in data->file.fd
>   perf stat: Fork and launch perf record when perf stat needs to get
>     retire latency value for a metric.
>   perf stat: Plugin retire_lat value from sampled data to evsel
>   perf vendor events intel: Add MTL metric json files
>   perf stat: Add command line option for enabling tpebs recording
>   perf Document: Add TPEBS to Documents
>   perf test: Add test for Intel TPEBS counting mode
> 
>  tools/perf/Documentation/perf-list.txt        |    1 +
>  tools/perf/Documentation/perf-stat.txt        |    8 +
>  tools/perf/Documentation/topdown.txt          |   30 +
>  tools/perf/arch/x86/util/evlist.c             |    6 +
>  tools/perf/builtin-stat.c                     |    8 +
>  .../arch/x86/graniterapids/cache.json         |  686 +++++
>  .../arch/x86/graniterapids/frontend.json      |  425 +++
>  .../arch/x86/graniterapids/gnr-metrics.json   |  108 +
>  .../arch/x86/graniterapids/memory.json        |  169 +-
>  .../arch/x86/graniterapids/metricgroups.json  |  118 +
>  .../arch/x86/graniterapids/pipeline.json      |  881 ++++++
>  .../arch/x86/meteorlake/metricgroups.json     |  142 +
>  .../arch/x86/meteorlake/mtl-metrics.json      | 2535 +++++++++++++++++
>  .../perf/tests/shell/test_stat_intel_tpebs.sh |   18 +
>  tools/perf/util/Build                         |    1 +
>  tools/perf/util/data.c                        |    7 +-
>  tools/perf/util/evlist.c                      |    2 +
>  tools/perf/util/evsel.c                       |   81 +-
>  tools/perf/util/evsel.h                       |    6 +
>  tools/perf/util/intel-tpebs.c                 |  407 +++
>  tools/perf/util/intel-tpebs.h                 |   35 +
>  tools/perf/util/parse-events.c                |    2 +
>  tools/perf/util/parse-events.h                |    1 +
>  tools/perf/util/parse-events.l                |    3 +-
>  24 files changed, 5619 insertions(+), 61 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/gnr-metrics.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json
>  create mode 100755 tools/perf/tests/shell/test_stat_intel_tpebs.sh
>  create mode 100644 tools/perf/util/intel-tpebs.c
>  create mode 100644 tools/perf/util/intel-tpebs.h
> 
> --
> 2.43.0
> 
