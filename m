From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: perf top -z not working?
Date: Tue, 23 Oct 2012 15:04:01 +0900
Message-ID: <8762617mi6.fsf@sejong.aot.lge.com>
References: <507EA40D.60206@cs.utoronto.ca>
	<507EB776.9030304@core.kaist.ac.kr>
	<20121022014618.GA7924@ghostprotocols.net>
	<50853311.3040707@cs.utoronto.ca> <50854633.30206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE7Q.lge.com ([156.147.1.151]:60090 "EHLO
	LGEMRELSE7Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab2JWGEF (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 23 Oct 2012 02:04:05 -0400
In-Reply-To: <50854633.30206@gmail.com> (David Ahern's message of "Mon, 22 Oct
	2012 07:12:19 -0600")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Ryan Johnson <ryan.johnson@cs.utoronto.ca>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, Chulmin Kim <cmkim@core.kaist.ac.kr>, linux-perf-users@vger.kernel.org

On Mon, 22 Oct 2012 07:12:19 -0600, David Ahern wrote:
> On 10/22/12 5:50 AM, Ryan Johnson wrote:
>>>>> It seems that `perf top -z' does not behave as advertized, at
>>>>> least not on the 3.2.0-25 kernel (Ubuntu) that I'm running. The
>>>>> man page states that it should "zero history across display
>>>>> updates" but the counts still seem to accumulate (the total
>>>>> samples reported rises monotonically) and processes still show up
>>>>> in the display long after they have exited. Pressing `z' or `Z'
>>>>> seems to have no effect, either.
>>> Are you using the --tui or --stdio interface? Try with both and check if
>>> it works in one of them, I bet the problem is with --tui.
>> --stdio does the same, so I'll have to try updating my kernel like
>> Chulmin suggested (haven't had time to do that yet)
>
> The kernel has nothing to do with the feature. From builtin-top.c,
> this part is either not happening or more likely not happening
> correctly.
>
>     if (top->zero)
>         symbol__annotate_zero_histogram(symbol, top->sym_evsel->idx);
>     else
>         symbol__annotate_decay_histogram(symbol, top->sym_evsel->idx);

Why symbol__annotate_zero_histogram only?  AFAICS it only zeros sym_hist
not hist_entry so meaningful just for annotation, right?

Anyway, it's called iff top->sym_filter_entry is set.  Not sure what's
the intended behavior of the -z switch..

Thanks,
Namhyung
