Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CF418F2E4;
	Wed, 26 Jun 2024 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719424741; cv=none; b=ushaZqxLl4KgaWNIKydUXg9uq9KFBpk/7yDd3E2S8qEZYfRX0z5rQfgROcxqAolM+o36+vKzn0Q3Cp3ynzIuVzzxdQbwtit3yJNA6tQwBKg7KvY2+mGdKDdkZj1Y70e+C10cnkPz4Z96CYPfuVTqfVr1fVHp0gxHeM2+VgrNaSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719424741; c=relaxed/simple;
	bh=B1DB5gf2wDTvGZddMNS1YtrBBdcq/gHzPeeg//vV+Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dilqp/XXdm8uSDxuLjyQCW6Hy1tO2CC5w5Wb6JOb85y1U4QD16o2GP2/igQyz2P5CRrt6cCPwMFihvb0VQv2yLMXzEUfB8zXVOsY8DmYZGCJlZaZdLftsuaG3TFq2ooBSqXBSQVEBqatOgvFkjp1QHL45IncThz/7ut0xB05iiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgMvzfMw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgMvzfMw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54068C116B1;
	Wed, 26 Jun 2024 17:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719424740;
	bh=B1DB5gf2wDTvGZddMNS1YtrBBdcq/gHzPeeg//vV+Oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kgMvzfMwPj7P+pL0fjhvWXLCIvlHM2MLg3n2RGrUJ6l87GU0haJqEgH8MiGYqzkVR
	 BLtqI2VBzwWCGpU7VK/IP88jWfeJPnG7eWGE54olZQIhOTu4uSafLu2bjfKOY8H1tM
	 6aYhd79kfOZdFsilZ8PvUg+kN3NbBqP+SUoyaE/Yy0tWsOEwNAiqiJMxdv4T+8u+vi
	 b19pWRAprdl5rGmQW6y0QWOGEw4sMnx3lopDaAgLpbIjMiYDc/YMhbuLKc6sAtF7wl
	 WFAhMnIsPlBAaJgmkcsrFFonKV/SeOrbfPBGnUdbrGs5njDy2m4IZNynz5J+qSmFi+
	 AhatLj3MNFzQw==
Date: Wed, 26 Jun 2024 10:58:58 -0700
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
Subject: Re: [RFC PATCH v14 0/8] TPEBS counting mode support
Message-ID: <ZnxW4u_TB5agiFJT@google.com>
References: <20240624222026.229401-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240624222026.229401-1-weilin.wang@intel.com>

On Mon, Jun 24, 2024 at 06:20:16PM -0400, weilin.wang@intel.com wrote:
> From: Weilin Wang <weilin.wang@intel.com>
> 
> Changes in v14:
>  - Fix the python import test failure. We cannot support PYTHON_PERF because it
>  will trigger a chain of dependency issues if we add intel-tpebs.c to it. So,
>  only enable tpebs functions in evsel and evlist when PYTHON_PERF is not
>  defined.

I think it's easier if we have Ian's python build cleanup first.

  https://lore.kernel.org/linux-perf-users/20240625214117.953777-1-irogers@google.com

Let me take a look at it..

Thanks,
Namhyung


>  - Fix shellcheck warning for the tpebs test.
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
>  - Rebase code on top of perf-tools-next.
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
> Ian Rogers (1):
>   perf parse-events: Add a retirement latency modifier
> 
> Weilin Wang (7):
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
>  .../arch/x86/meteorlake/metricgroups.json     |  142 +
>  .../arch/x86/meteorlake/mtl-metrics.json      | 2535 +++++++++++++++++
>  .../perf/tests/shell/test_stat_intel_tpebs.sh |   18 +
>  tools/perf/util/Build                         |    1 +
>  tools/perf/util/data.c                        |    7 +-
>  tools/perf/util/evlist.c                      |    4 +
>  tools/perf/util/evsel.c                       |   91 +-
>  tools/perf/util/evsel.h                       |    6 +
>  tools/perf/util/intel-tpebs.c                 |  407 +++
>  tools/perf/util/intel-tpebs.h                 |   35 +
>  tools/perf/util/parse-events.c                |    2 +
>  tools/perf/util/parse-events.h                |    1 +
>  tools/perf/util/parse-events.l                |    3 +-
>  18 files changed, 3301 insertions(+), 4 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/metricgroups.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json
>  create mode 100755 tools/perf/tests/shell/test_stat_intel_tpebs.sh
>  create mode 100644 tools/perf/util/intel-tpebs.c
>  create mode 100644 tools/perf/util/intel-tpebs.h
> 
> --
> 2.43.0
> 
