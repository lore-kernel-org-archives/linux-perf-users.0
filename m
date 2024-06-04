Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2738CC13B;
	Tue,  4 Jun 2024 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717514670; cv=none; b=txnBd0216PKzyzEPSTnDLM3YoCzC/kxmpTvBm3KCRvqvpGsPu4dfIG7sDTEqYi3bUdtjOFQXO8n2O+cAqekki5VxqPTHGydkUqeMoCASy09r0hTIXjLYS2bWfm1m7RT7+hH64s2BvWRTG114HcATcvVu7P+YFIZ5xqmvP+SWwRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717514670; c=relaxed/simple;
	bh=fPxXmwRmBSzzn2QpXTh86PVX2W6adxq3m64bCXtO878=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIQThggbW1kuE7yVXqXx3q1LMqapQ9OQRVgfUSLSNbSjq8P5y7gAR5cbMRDU9Xb6qSyappDGWqD1PixmWXaBwtvu5oZ/pqHq+Ewy4msBDrEbexlC5VFjiG4SY3KipJ6ao7OZr+S1KPX6O/NwhwLnalZmDphfHKfli68rjEd5ofI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kK/9yCR6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kK/9yCR6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6357BC2BBFC;
	Tue,  4 Jun 2024 15:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717514669;
	bh=fPxXmwRmBSzzn2QpXTh86PVX2W6adxq3m64bCXtO878=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kK/9yCR6lOxEJpbsa5ZYbaAd4BLjbvoQkzChH+XqGvmUWiXh5KKwk0kv5TKZmM95u
	 Me7YSJ6neY3t7KbsM6xLV1Ji13tyJRutArDSHMflQJUaVaid7XQN6IuGUIrRG+6PJd
	 Xm4T8GJBH+i8WbGs/5Bq9HtJb+7YCw3iwPEdBEvlLk3VNwmlcCDcNk9u5Iap5afh/d
	 KOzKD5p5PZGEgGwYlXjo4N7n4ZOwv9QXJ1Q2Q6Najf4AnyYpQ8ygvLJ6XjrUD0OSlS
	 PiwmXgomMQTl56so06yhqbaMH8yZKbx2bcOhjepsSO+jBSHgvLG5aMGqno+sTyjiXS
	 7QCqkcsrQrrBQ==
Date: Tue, 4 Jun 2024 12:24:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/4] perf report: Omit dummy events in the output (v2)
Message-ID: <Zl8xq_p_5Vxnf6Pj@x1>
References: <20240603224412.1910049-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603224412.1910049-1-namhyung@kernel.org>

On Mon, Jun 03, 2024 at 03:44:08PM -0700, Namhyung Kim wrote:
> Hello,
> 
> This work is to make the output compact by removing dummy events in
> the output.  The dummy events are used to save side-band information
> like task creation or memory address space change using mmap(2).  But
> after collecting these, it's not used because it won't have any
> samples.
> 
>  v2 changes)
>  * just hide the (dummy) event instead of removing it from evlist
> 
> Sometimes users want to run perf report --group to show all recorded
> events together but they are not interested in those dummy events.
> This just wastes the precious screen space so we want to get rid of
> them after use.
> 
> perf report already has --skip-empty option to skip 0 result in the
> stat output.  I think we can extend it to skip empty events that have
> no samples.
> 
> Example output:

Would be interesting to have this as an example in the cset where this
becomes the norm, together with stating that the 'perf.data' file was
generated with 'perf mem record'.

Apart from that, nice feature:

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Before)
>   #
>   # Samples: 232  of events 'cpu/mem-loads,ldlat=30/P, cpu/mem-stores/P, dummy:u'
>   # Event count (approx.): 3089861
>   #
>   #                 Overhead  Command      Shared Object      Symbol                               
>   # ........................  ...........  .................  .....................................
>   #
>        9.29%   0.00%   0.00%  swapper      [kernel.kallsyms]  [k] update_blocked_averages
>        5.26%   0.15%   0.00%  swapper      [kernel.kallsyms]  [k] __update_load_avg_se
>        4.15%   0.00%   0.00%  perf-exec    [kernel.kallsyms]  [k] slab_update_freelist.isra.0
>        3.87%   0.00%   0.00%  perf-exec    [kernel.kallsyms]  [k] memcg_slab_post_alloc_hook
>        3.79%   0.17%   0.00%  swapper      [kernel.kallsyms]  [k] enqueue_task_fair
>        3.63%   0.00%   0.00%  sleep        [kernel.kallsyms]  [k] next_uptodate_page
>        2.86%   0.00%   0.00%  swapper      [kernel.kallsyms]  [k] __update_load_avg_cfs_rq
>        2.78%   0.00%   0.00%  swapper      [kernel.kallsyms]  [k] __schedule
>        2.34%   0.00%   0.00%  swapper      [kernel.kallsyms]  [k] intel_idle
>        2.32%   0.97%   0.00%  swapper      [kernel.kallsyms]  [k] psi_group_change
> 
> After)
>   #
>   # Samples: 232  of events 'cpu/mem-loads,ldlat=30/P, cpu/mem-stores/P'
>   # Event count (approx.): 3089861
>   #
>   #         Overhead  Command      Shared Object      Symbol                               
>   # ................  ...........  .................  .....................................
>   #
>        9.29%   0.00%  swapper      [kernel.kallsyms]  [k] update_blocked_averages
>        5.26%   0.15%  swapper      [kernel.kallsyms]  [k] __update_load_avg_se
>        4.15%   0.00%  perf-exec    [kernel.kallsyms]  [k] slab_update_freelist.isra.0
>        3.87%   0.00%  perf-exec    [kernel.kallsyms]  [k] memcg_slab_post_alloc_hook
>        3.79%   0.17%  swapper      [kernel.kallsyms]  [k] enqueue_task_fair
>        3.63%   0.00%  sleep        [kernel.kallsyms]  [k] next_uptodate_page
>        2.86%   0.00%  swapper      [kernel.kallsyms]  [k] __update_load_avg_cfs_rq
>        2.78%   0.00%  swapper      [kernel.kallsyms]  [k] __schedule
>        2.34%   0.00%  swapper      [kernel.kallsyms]  [k] intel_idle
>        2.32%   0.97%  swapper      [kernel.kallsyms]  [k] psi_group_change
> 
> Now 'Overhead' column only has two values for mem-loads and mem-stores.
> 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (4):
>   perf hist: Factor out __hpp__fmt_print()
>   perf hist: Simplify __hpp_fmt() using hpp_fmt_data
>   perf hist: Add symbol_conf.skip_empty
>   perf hist: Honor symbol_conf.skip_empty
> 
>  tools/perf/builtin-annotate.c  |   4 +-
>  tools/perf/builtin-report.c    |  12 +--
>  tools/perf/ui/hist.c           | 144 ++++++++++++++++-----------------
>  tools/perf/ui/stdio/hist.c     |   5 +-
>  tools/perf/util/events_stats.h |   3 +-
>  tools/perf/util/evsel.c        |  13 ++-
>  tools/perf/util/hist.c         |   6 +-
>  tools/perf/util/hist.h         |   3 +-
>  tools/perf/util/python.c       |   3 +
>  tools/perf/util/session.c      |   5 +-
>  tools/perf/util/session.h      |   3 +-
>  tools/perf/util/symbol_conf.h  |   3 +-
>  12 files changed, 105 insertions(+), 99 deletions(-)
> 
> -- 
> 2.45.1.288.g0e0cd299f1-goog
