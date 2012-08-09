From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf: Add a new sort order: SORT_INCLUSIVE (v6)
Date: Thu, 09 Aug 2012 09:33:35 +0900
Message-ID: <874noczyxs.fsf@sejong.aot.lge.com>
References: <1333172421-6775-2-git-send-email-asharma@fb.com>
	<4F769976.3070203@fb.com> <5022BB0E.8050706@fb.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5022BB0E.8050706@fb.com> (Arun Sharma's message of "Wed, 8 Aug
	2012 12:16:30 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Arun Sharma <asharma@fb.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Arnaldo Carvalho de Melo <acme@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Mike Galbraith <efault@gmx.de>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Namhyung Kim <namhyung.kim@lge.com>, Tom Zanussi <tzanussi@gmail.com>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Hi, Arun

On Wed, 8 Aug 2012 12:16:30 -0700, Arun Sharma wrote:
> On 3/30/12 10:43 PM, Arun Sharma wrote:
>> [ Meant to include v6 ChangeLog as well. Technical difficulties.. ]
>>
>> v6 ChangeLog:
>>
>> rebased to tip:perf/core and fixed a minor problem in computing
>> the total period in hists__remove_entry_filter(). Needed to
>> use period_self instead of period.
>
> This patch breaks perf top (symptom: percentages > 100%). Fixed by the
> following patch.
>
> Namhyung: if you're still working on forward porting this, please add
> this fix to your queue.
>
Will do, thanks.
Namhyung


>  -Arun
>
> commit 75a1c409a529c9741f8a2f493868d1fc7ce7e06d
> Author: Arun Sharma <asharma@fb.com>
> Date:   Wed Aug 8 11:47:02 2012 -0700
>
>    perf: update period_self as well on collapsing
>       When running perf top, we have a series of incoming samples,
>    which get aggregated in various user specified ways.
>       Suppose function "foo" had the following samples:
>    101, 103, 99, 105, ...
>       ->period for the corresponding entry looks as follows:
>    101, 204, 303, 408, ...
>       However, due to this bug, ->period_self contains:
>    101, 103, 99, 105, ...
>       and therefore breaks the invariant period == period_self
>    in the default mode (no sort inclusive).
>       Since total_period is computed by summing up period_self,
>       period/total_period can be > 100%
>       Fix the bug by updating period_self as well.
>       Signed-off-by: Arun Sharma <asharma@fb.com>
>
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index a2a8d91..adc891e 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -462,6 +462,7 @@ static bool hists__collapse_insert_entry(struct
> hists *hists,
>
> 		if (!cmp) {
> 			iter->period += he->period;
> +			iter->period_self += he->period_self;
> 			iter->nr_events += he->nr_events;
> 			if (symbol_conf.use_callchain) {
> 				callchain_cursor_reset(&hists->callchain_cursor);
