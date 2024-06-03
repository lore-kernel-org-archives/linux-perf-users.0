Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053BC12E1C6;
	Mon,  3 Jun 2024 22:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454654; cv=none; b=aTQk3pTyYr5buzggrqT7XYPp5xLRDBh8Hpr0mLGkC0ogpJiBOeBcD5Y1GrnQZutM7sYS6TMMnDpRAuCRLf30fJKJDlGXv8nGlbB3/PsekbKk5NCTX1wkx/2sERRRHqf+ywX3V0iKAwQZRS7bs7ub1xCinC1txs5ZNG1bo8Sfp7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454654; c=relaxed/simple;
	bh=KeNKRmnEsHEhyQWOaULWi+zFVlIJi8zh3IOu+6a/p8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EsgXtgDJimDoE+SFz16g/d9VskzN7azq8RqPTsSzd6YxL8XrxHy5nUvj076BHbKOcqjOZqBUMPWEfKAFXO++bTEmK2htk5xoEXC0/Xpac7c+jl+7BCkaB/SDVhvcQO37MSe7xJ6HbyYr6/Q5WCM57bJTezy0SUNhhm4AqTysEdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjzF5cWC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjzF5cWC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825AEC2BD10;
	Mon,  3 Jun 2024 22:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717454653;
	bh=KeNKRmnEsHEhyQWOaULWi+zFVlIJi8zh3IOu+6a/p8w=;
	h=From:To:Cc:Subject:Date:From;
	b=QjzF5cWCgpAdqR0oHO1vV1gEvKijtRc4DZli7o0/fd3FfRFYTMBCoBkeTdpL2dMj/
	 J6TOOFVDap/qLTxAhmyDW2GPv4T0OJc2+il1ptIXrpYYIASG0H+LkJJ1S7JXU1qtkP
	 X+Z46gX+n4FFobbzpNBBlm2y9zd88oCrgibJI2UB/U63TI31ezOETLJ5kpvrCltaEY
	 rwQqRWvx94VcIElSwrdSvrBBhXY7fNq/clyNPTDaBgMRijJCJxCXSgjNhCnV+NczGL
	 ieD4oC4aI+1a5XTvM2ctMCmZBabNrywxAbt/Sul3r1Ag/wuIc1CUQIMg6JnMTW+AsP
	 +UbLCW7rV+uBw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 0/4] perf report: Omit dummy events in the output (v2)
Date: Mon,  3 Jun 2024 15:44:08 -0700
Message-ID: <20240603224412.1910049-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This work is to make the output compact by removing dummy events in
the output.  The dummy events are used to save side-band information
like task creation or memory address space change using mmap(2).  But
after collecting these, it's not used because it won't have any
samples.

 v2 changes)
 * just hide the (dummy) event instead of removing it from evlist

Sometimes users want to run perf report --group to show all recorded
events together but they are not interested in those dummy events.
This just wastes the precious screen space so we want to get rid of
them after use.

perf report already has --skip-empty option to skip 0 result in the
stat output.  I think we can extend it to skip empty events that have
no samples.

Example output:

Before)
  #
  # Samples: 232  of events 'cpu/mem-loads,ldlat=30/P, cpu/mem-stores/P, dummy:u'
  # Event count (approx.): 3089861
  #
  #                 Overhead  Command      Shared Object      Symbol                               
  # ........................  ...........  .................  .....................................
  #
       9.29%   0.00%   0.00%  swapper      [kernel.kallsyms]  [k] update_blocked_averages
       5.26%   0.15%   0.00%  swapper      [kernel.kallsyms]  [k] __update_load_avg_se
       4.15%   0.00%   0.00%  perf-exec    [kernel.kallsyms]  [k] slab_update_freelist.isra.0
       3.87%   0.00%   0.00%  perf-exec    [kernel.kallsyms]  [k] memcg_slab_post_alloc_hook
       3.79%   0.17%   0.00%  swapper      [kernel.kallsyms]  [k] enqueue_task_fair
       3.63%   0.00%   0.00%  sleep        [kernel.kallsyms]  [k] next_uptodate_page
       2.86%   0.00%   0.00%  swapper      [kernel.kallsyms]  [k] __update_load_avg_cfs_rq
       2.78%   0.00%   0.00%  swapper      [kernel.kallsyms]  [k] __schedule
       2.34%   0.00%   0.00%  swapper      [kernel.kallsyms]  [k] intel_idle
       2.32%   0.97%   0.00%  swapper      [kernel.kallsyms]  [k] psi_group_change

After)
  #
  # Samples: 232  of events 'cpu/mem-loads,ldlat=30/P, cpu/mem-stores/P'
  # Event count (approx.): 3089861
  #
  #         Overhead  Command      Shared Object      Symbol                               
  # ................  ...........  .................  .....................................
  #
       9.29%   0.00%  swapper      [kernel.kallsyms]  [k] update_blocked_averages
       5.26%   0.15%  swapper      [kernel.kallsyms]  [k] __update_load_avg_se
       4.15%   0.00%  perf-exec    [kernel.kallsyms]  [k] slab_update_freelist.isra.0
       3.87%   0.00%  perf-exec    [kernel.kallsyms]  [k] memcg_slab_post_alloc_hook
       3.79%   0.17%  swapper      [kernel.kallsyms]  [k] enqueue_task_fair
       3.63%   0.00%  sleep        [kernel.kallsyms]  [k] next_uptodate_page
       2.86%   0.00%  swapper      [kernel.kallsyms]  [k] __update_load_avg_cfs_rq
       2.78%   0.00%  swapper      [kernel.kallsyms]  [k] __schedule
       2.34%   0.00%  swapper      [kernel.kallsyms]  [k] intel_idle
       2.32%   0.97%  swapper      [kernel.kallsyms]  [k] psi_group_change

Now 'Overhead' column only has two values for mem-loads and mem-stores.

Thanks,
Namhyung


Namhyung Kim (4):
  perf hist: Factor out __hpp__fmt_print()
  perf hist: Simplify __hpp_fmt() using hpp_fmt_data
  perf hist: Add symbol_conf.skip_empty
  perf hist: Honor symbol_conf.skip_empty

 tools/perf/builtin-annotate.c  |   4 +-
 tools/perf/builtin-report.c    |  12 +--
 tools/perf/ui/hist.c           | 144 ++++++++++++++++-----------------
 tools/perf/ui/stdio/hist.c     |   5 +-
 tools/perf/util/events_stats.h |   3 +-
 tools/perf/util/evsel.c        |  13 ++-
 tools/perf/util/hist.c         |   6 +-
 tools/perf/util/hist.h         |   3 +-
 tools/perf/util/python.c       |   3 +
 tools/perf/util/session.c      |   5 +-
 tools/perf/util/session.h      |   3 +-
 tools/perf/util/symbol_conf.h  |   3 +-
 12 files changed, 105 insertions(+), 99 deletions(-)

-- 
2.45.1.288.g0e0cd299f1-goog

