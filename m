Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEA214EC4F;
	Fri,  7 Jun 2024 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717792160; cv=none; b=k0ndH9Q5syS4MBVTN/qssNzBKzHiw//PE7fBonbQAAXYaG3xRZZ9Q3mqJKv8SxsYbFT3jRx3762aS25IGQhvzv3DS9XCoRy9Ic6zrLWJM5UkZFSh+UxqUPw2lqdcKsIaBe9ZPi/aagakLZiC8/+hXwuZ9bJgxAaDD4q8+Dwxq+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717792160; c=relaxed/simple;
	bh=ROVFhE9e2h9zg6NaTFLlUVIUVyZWJX/ywoBMGJGZp9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l5Wg/i0XR4pIJcndjvoGyx6wYBefVGdw5xjNQ3Gi+cbis/MvNTLxtN9i7JbGG5+EdGfvGo6XHs7J+H/xPYaK6LxCRn77i8crXaBHGqo0iSkPnQPXA5NgFQytgQ7mIApty3nfTx/mb7gyG7I4frM3CaTixb0UzTUB3W3eaBfORBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwYJYGw5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwYJYGw5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5958DC2BBFC;
	Fri,  7 Jun 2024 20:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717792159;
	bh=ROVFhE9e2h9zg6NaTFLlUVIUVyZWJX/ywoBMGJGZp9c=;
	h=From:To:Cc:Subject:Date:From;
	b=OwYJYGw5Bvbr+ajOjl2yEy62cdHOedHa5C6nXI/kAMlxtbbaWZQKA6/zfo/VWxJHY
	 VD4X0erVMZqwjSBxQssnVkswbkVszEYcxnrKdmfP1pz8iv5NoJOfwLkpuZvJGAu72z
	 feEOeZponk2TzxzWxMTVFdA5wFt0d6lcqsbBG9ANsF59NQWlmTShtTciyilW95JzrJ
	 H4QDjMAWX0e0uaQ5vBUgPpI1gkQ9oMVHdI7CRIXbe5jNVMmfGFGGu1eKz0LcmVT5WG
	 +CNRtIzuR2JREigglszD939iBXtvNEV9n60toYqUX38CvipJVuFe5NsqBfaJxDM0SX
	 dNIRzahLg+pww==
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
Subject: [PATCH 0/4] perf report: Omit dummy events in the output (v3)
Date: Fri,  7 Jun 2024 13:29:14 -0700
Message-ID: <20240607202918.2357459-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
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

 v3 changes)
 * rename to struct hpp_fmt_value  (Arnaldo)
 * add Tested-by from Arnaldo
 
Sometimes users want to run perf report --group to show all recorded
events together but they are not interested in those dummy events.
This just wastes the precious screen space so we want to get rid of
them in the output.

perf report already has --skip-empty option to skip 0 result in the
stat output.  I think we can extend it to skip empty events that have
no samples.

Example output:

  $ sudo perf mem record -a sleep 1
  $ sudo perf report --group

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
2.45.2.505.gda0bf45e8d-goog

