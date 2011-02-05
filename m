From: David Ahern <daahern@cisco.com>
Subject: Re: [RFC] --dump-sym-trace
Date: Fri, 04 Feb 2011 19:38:50 -0700
Message-ID: <4D4CB83A.2030400@cisco.com>
References: <AANLkTin3bp90ybuUDFQijspV0uBw=zTnczcPLBaZvO7p@mail.gmail.com>	<4D3F871B.3060906@cisco.com>	<AANLkTinik0+Zp7N54bkh5fBzF1hb2XoubRbuMXwBeYGZ@mail.gmail.com>	<4D433811.7020904@cisco.com>	<20110129205050.GH6345@ghostprotocols.net> <AANLkTi=QdnJ2R-9bn4r+njwAnNewvWvBO2GRw6W4qwnj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-1.cisco.com ([171.71.176.70]:7742 "EHLO
	sj-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047Ab1BECiw (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 4 Feb 2011 21:38:52 -0500
In-Reply-To: <AANLkTi=QdnJ2R-9bn4r+njwAnNewvWvBO2GRw6W4qwnj@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <arun@sharma-home.net>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, linux-perf-users@vger.kernel.org



On 02/04/11 18:48, Arun Sharma wrote:
> On Sat, Jan 29, 2011 at 12:50 PM, Arnaldo Carvalho de Melo
> <acme@ghostprotocols.net> wrote:
>> /me too
>>
>> I have to get back to that, it is definetely a feature we need to have.
> 
> There are a couple of more minor nits I found in David's patch:
> 
> * perf record --timehist doesn't seem to be doing anything. I used
> perf record -T -a.

For record the the --timehist flag adds the timestamp and cpu to the IP
samples -- hidden attributes from a 'perf report' perspective unless you
add the --timehist flag on the report as well in which case the output
is completely different.

I take it your mileage varied from the above.

David



> * Some of the printfs are missing checks along the lines of:
> 
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -228,6 +228,7 @@ static int perf_session__print_sample(struct
> perf_session *session,
>                 free(syms);
> 
>         } else {
> +               if (!data || !al || !al->thread || !al->sym ||
> !al->map) return 0;
>                 printf(TIMEHIST_FMT,
>                            tstr, data->cpu,
>                            al->thread->comm, al->thread->pid, al->addr,
> 
> to avoid SIGSEGVs when the information in the sample is incomplete.
> 
>  -Arun
