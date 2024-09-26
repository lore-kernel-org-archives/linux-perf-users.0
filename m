Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDD32F5B;
	Thu, 26 Sep 2024 04:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727325525; cv=none; b=bPP8bmnOw52fyBcy3TaQFXISkF0meBUbX2dAIhq7toX0T4p8ICSt91MZ0eVnGhSDDKOg676Nt36E5MYsH4EdQivYlqQ3kVvux3Fmzv3oira9R2pjByZOK7BCKMKMOgFkBuElDYuInXwY+n5pykTsS1COlRzt23TWe2VgAVnR2iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727325525; c=relaxed/simple;
	bh=uwFO+zjOqlPYdaZQtKhRC8HZyLZBu4ICWKNnFgh6uUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIYnNB9XTpN7oaTWuCQzQdPkw2VhLXRW6KCEQWMx3DPOOP19Ra0oCWxXSotRI9QzgJ+T+3sFUKLkjPzDpqKXJ6tkqjKeoScsb2WvRzbVq55uqe+5lR9bBvDd9/hQlwUjMiUPPQqtC46DK4u6w157bEftdyswxV+gZ/57g5hJxKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBoem3oq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBoem3oq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5374DC4CEC5;
	Thu, 26 Sep 2024 04:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727325524;
	bh=uwFO+zjOqlPYdaZQtKhRC8HZyLZBu4ICWKNnFgh6uUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tBoem3oq81RMHgppA2uKIlOYAF5axCzFpoM0eg/b0qJT5pqtyG1WzyzBKSn6GV4G7
	 3tWDPBmvX3XB/BjDgH23yqha/lQOUtPyy2UhlxyUwnojDza+31em+l9MAYv4i8ojM/
	 E7BDul6m4W6Dzoy9Pz4E2W8zvEI1DF6xcraO6UGKLvw12iuxcsvP9EVaumv5TMSfmG
	 4t5/jj3KMgDJH4V3Xi82R+qfc9Duqm/coRp2YkKgsN8pbAAzr7EIYi0ojuOiq/8U96
	 ocbQ7a8/tnchqL6Lj9V/yF869hNesPJsfeP8/F2u4+ucTDnW7DyKY1kifn2xlbGIk6
	 Cdx5rKp1jE+bA==
Date: Wed, 25 Sep 2024 21:38:41 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org,
	kan.liang@linux.intel.com, ak@linux.intel.com,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Colin Ian King <colin.i.king@gmail.com>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Howard Chu <howardchu95@gmail.com>, Ze Gao <zegao2021@gmail.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/7] Event parsing fixes
Message-ID: <ZvTlUXJs2jVDDL0B@google.com>
References: <20240925141357.1033087-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240925141357.1033087-1-james.clark@linaro.org>

On Wed, Sep 25, 2024 at 03:13:38PM +0100, James Clark wrote:
> I rebased this one and made some other fixes so that I could test it,
> so I thought I'd repost it here in case it's helpful. I also added a
> new test.
> 
> But for the testing it all looks ok.
> 
> There is one small difference where it now hides _all_ default
> <not supported> events, when previously it would only hide some
> selected subset of events like "stalled-cycles-frontend". I think
> this is now more consistent across platforms because, for example,
> Apple M only has cycles and instructions, and the rest of the
> default events would always show as <not supported> there.
> 
> Tested on Raptor Lake, Kaby Lake, Juno, N1, Ampere (with the DSU
> cycles PMU) and I also faked an Apple M on Juno. 

Hmm.. I got a segfault with 'perf stat true' on my Zen2 box.

  $ gdb -q -args ./perf stat true
  Reading symbols from ./perf...
  (gdb) r
  Starting program: /home/namhyung/tmp/perf stat true
  [Thread debugging using libthread_db enabled]
  Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
  
  Program received signal SIGSEGV, Segmentation fault.
  0x00005555557e04b5 in perf_pmu__is_fake (pmu=0x0) at util/pmu.c:1173
  1173		return pmu->type == PERF_PMU_TYPE_FAKE;
  (gdb) bt
  #0  0x00005555557e04b5 in perf_pmu__is_fake (pmu=0x0) at util/pmu.c:1173
  #1  0x00005555558c1b8b in evsel__sys_has_perf_metrics (evsel=0x5555560cc4b0) at arch/x86/util/evsel.c:50
  #2  0x00005555558c1c33 in arch_evsel__must_be_in_group (evsel=0x5555560cc4b0) at arch/x86/util/evsel.c:64
  #3  0x00005555557773a4 in parse_events__sort_events_and_fix_groups (list=0x7fffffff9ad0) at util/parse-events.c:2098
  #4  0x0000555555777793 in __parse_events (evlist=0x5555560aa880, 
      str=0x5555558d6498 "context-switches,cpu-migrations,page-faults,instructions,cycles,stalled-cycles-frontend,stalled-cycles-backend,branches,branch-misses", pmu_filter=0x0, err=0x7fffffff9bd0, fake_pmu=false, warn_if_reordered=true, fake_tp=false) at util/parse-events.c:2186
  #5  0x00005555555c787f in parse_events (evlist=0x5555560aa880, 
      str=0x5555558d6498 "context-switches,cpu-migrations,page-faults,instructions,cycles,stalled-cycles-frontend,stalled-cycles-backend,branches,branch-misses", err=0x7fffffff9bd0) at util/parse-events.h:41
  #6  0x00005555555cce39 in add_default_events () at builtin-stat.c:1977
  #7  0x00005555555cf928 in cmd_stat (argc=1, argv=0x7fffffffd840) at builtin-stat.c:2724
  #8  0x000055555564cb81 in run_builtin (p=0x555556024548 <commands+360>, argc=2, argv=0x7fffffffd840) at perf.c:351
  #9  0x000055555564ce28 in handle_internal_command (argc=2, argv=0x7fffffffd840) at perf.c:404
  #10 0x000055555564cf81 in run_argv (argcp=0x7fffffffd63c, argv=0x7fffffffd630) at perf.c:448
  #11 0x000055555564d2cf in main (argc=2, argv=0x7fffffffd840) at perf.c:562

Thanks,
Namhyung

> 
> Changes since v7:
>   * Resolve conflicts and rebase onto perf-tools-next 1de5b5dcb835
>   * Fix build error by using the new perf_pmu__is_fake()
> 
> Changes since v6:
>   * Fix empty PMU name in perf report
>   * Rebase onto perf-tools-next 003265bb6f02
> 
> Changes since v5:
>   * Test on x86 non hybrid
>   * Assume 1 PMU in the test when no PMUs expose /cpus file
> 
> Changes since v4:
> 
>   * Hide all <not supported> default events when not verbose
>   * Remove previous note about <not supported> behavior from the cover
>     letter and replace it with a new note about the new behavior
>  
> Changes since v3:
> 
>   * Rebase onto perf-tools-next 6236ebe07
>   * Fix Intel TPEBS counting mode test
>   * Fix arm-spe build
>   * Add support for DT devices in stat test
>   * Add a new test for hybrid perf stat default arguments
> 
> Ian Rogers (5):
>   perf evsel: Add alternate_hw_config and use in evsel__match
>   perf stat: Uniquify event name improvements
>   perf stat: Remove evlist__add_default_attrs use strings
>   perf evsel x86: Make evsel__has_perf_metrics work for legacy events
>   perf evsel: Remove pmu_name
> 
> James Clark (2):
>   perf test: Make stat test work on DT devices
>   perf test: Add a test for default perf stat command
> 
>  tools/perf/arch/arm64/util/arm-spe.c          |   4 +-
>  tools/perf/arch/x86/util/evlist.c             |  74 +----
>  tools/perf/arch/x86/util/evsel.c              |  35 ++-
>  tools/perf/builtin-diff.c                     |   6 +-
>  tools/perf/builtin-stat.c                     | 291 +++++++-----------
>  tools/perf/tests/parse-events.c               |   2 +-
>  tools/perf/tests/shell/stat.sh                |  37 ++-
>  .../perf/tests/shell/test_stat_intel_tpebs.sh |  11 +-
>  tools/perf/util/evlist.c                      |  46 +--
>  tools/perf/util/evlist.h                      |  12 -
>  tools/perf/util/evsel.c                       |  28 +-
>  tools/perf/util/evsel.h                       |  22 +-
>  tools/perf/util/metricgroup.c                 |   4 +-
>  tools/perf/util/parse-events.c                |  60 ++--
>  tools/perf/util/parse-events.h                |   8 +-
>  tools/perf/util/parse-events.y                |   2 +-
>  tools/perf/util/pmu.c                         |   8 +-
>  tools/perf/util/pmu.h                         |   3 +-
>  tools/perf/util/stat-display.c                | 109 +++++--
>  tools/perf/util/stat-shadow.c                 |  14 +-
>  tools/perf/util/stat.c                        |   2 +-
>  21 files changed, 363 insertions(+), 415 deletions(-)
> 
> -- 
> 2.34.1
> 
