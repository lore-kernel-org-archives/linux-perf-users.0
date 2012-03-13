From: Namhyung Kim <namhyung.kim@lge.com>
Subject: Re: [PATCH 0/2] perf: add sort by inclusive time functionality (v2)
Date: Tue, 13 Mar 2012 10:36:31 +0900
Message-ID: <4F5EA49F.7020706@lge.com>
References: <1331160079-13821-1-git-send-email-asharma@fb.com> <4F5DA91F.7060908@lge.com> <4F5E3E8C.1020005@fb.com> <4F5E554C.4060209@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE7Q.lge.com ([156.147.1.151]:42604 "EHLO
	LGEMRELSE7Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758272Ab2CMBgf (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 12 Mar 2012 21:36:35 -0400
In-Reply-To: <4F5E554C.4060209@fb.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <asharma@fb.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Arnaldo Carvalho de Melo <acme@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Mike Galbraith <efault@gmx.de>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Tom Zanussi <tzanussi@gmail.com>, linux-perf-users@vger.kernel.org

Hi,

2012-03-13 4:58 AM, Arun Sharma wrote:
> On 3/12/12 11:21 AM, Arun Sharma wrote:
>>> BTW, I don't like the name 'inclusive' as a sort key. If it cares about
>>> time, IMHO, the name should contain 'time' - something like 'itime' or
>>> 'inctime'?
>>
>> The existing sort orders: pid, comm, dso, symbol, parent -- all care
>> about time, but none of them have time in their name?
>
> I'll take that back. What they sort on depends on the event.
>
> perf record -ge cache-misses
> perf report -s inclusive
>
> will sort by the number of cache-misses and not time.
>
> -Arun

AFAIK, "sort" here means how perf identifies a sample event from others: 
"comm" will collect samples have same pid/comm, then "dso" will group samples 
belong to same library, and "symbol" will group again samples have same symbol 
name. This is what default sort order (comm,dso,symbol) does.

In case of "inclusive" it does same thing with "symbol" as you use sort_sym 
for the inclusive sort_dimension. Sorting by period for output is done at 
final stage and it won't be affected by any sort orders. It maybe sound 
confusing but that's how it works.

Thanks,
Namhyung
