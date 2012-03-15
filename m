From: Namhyung Kim <namhyung.kim@lge.com>
Subject: Re: [PATCH] perf: Add a new sort order: SORT_INCLUSIVE (v4)
Date: Thu, 15 Mar 2012 10:02:23 +0900
Message-ID: <4F613F9F.6060700@lge.com>
References: <1331746607-6706-1-git-send-email-asharma@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE1Q.lge.com ([156.147.1.111]:50329 "EHLO
	LGEMRELSE1Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031445Ab2COBCa (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 14 Mar 2012 21:02:30 -0400
In-Reply-To: <1331746607-6706-1-git-send-email-asharma@fb.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <asharma@fb.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Arnaldo Carvalho de Melo <acme@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Mike Galbraith <efault@gmx.de>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Tom Zanussi <tzanussi@gmail.com>, linux-perf-users@vger.kernel.org

2012-03-15 2:36 AM, Arun Sharma wrote:
> Each entry that used to get added once to the histogram, now is added
> chain->nr times, each time with one less entry in the
> callchain.
>
> This will result in a non-leaf function that appears in a lot of
> samples to get a histogram entry with lots of hits.
>
> The user can then drill down into the callchains of functions that
> have high inclusive times.
>
> Sample command lines:
>
> $ perf record -ag -- sleep 1
> $ perf report -g graph,0.5,callee -n -s inclusive
>

Reviewed-by: Namhyung Kim <namhyung.kim@lge.com>

Thanks, looks good to me now - although I still prefer make it a switch to 
alter the behavior of the existing "symbol" sort order to do "inclusive" 
calculation of its periods, but I can live with this :).


> Signed-off-by: Arun Sharma <asharma@fb.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> CC: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Mike Galbraith <efault@gmx.de>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: Namhyung Kim <namhyung.kim@lge.com>
> Cc: Tom Zanussi <tzanussi@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-perf-users@vger.kernel.org
> ---
>   tools/perf/builtin-annotate.c |    2 +-
>   tools/perf/builtin-diff.c     |    2 +-
>   tools/perf/builtin-report.c   |   13 +++----
>   tools/perf/builtin-top.c      |    2 +-
>   tools/perf/util/callchain.c   |   15 ++++++++
>   tools/perf/util/callchain.h   |    4 ++
>   tools/perf/util/hist.c        |   80 +++++++++++++++++++++++++++++++++++++++-
>   tools/perf/util/hist.h        |    4 ++-
>   tools/perf/util/sort.c        |   14 +++++++
>   tools/perf/util/sort.h        |    4 ++
>   10 files changed, 126 insertions(+), 14 deletions(-)
>
