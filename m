From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Size of perf data files
Date: Fri, 28 Nov 2014 15:18:48 +0900
Message-ID: <87wq6fetkn.fsf@sejong.aot.lge.com>
References: <1601237.BEhNSa8l6d@milian-kdab2>
	<20141126160617.GD30226@kernel.org> <1439400.fEBkspRaxp@milian-kdab2>
	<87oarto40a.fsf@sejong.aot.lge.com>
	<20141127131916.GH30226@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from lgeamrelo04.lge.com ([156.147.1.127]:62063 "EHLO
	lgeamrelo04.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbaK1GSv (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 28 Nov 2014 01:18:51 -0500
In-Reply-To: <20141127131916.GH30226@kernel.org> (Arnaldo Carvalho de Melo's
	message of "Thu, 27 Nov 2014 10:19:16 -0300")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Milian Wolff <mail@milianw.de>, linux-perf-users <linux-perf-users@vger.kernel.org>

Hi Arnaldo,

On Thu, 27 Nov 2014 10:19:16 -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Nov 27, 2014 at 09:56:21AM +0900, Namhyung Kim escreveu:
>> Hi Milian,
>> 
>> On Wed, 26 Nov 2014 19:11:01 +0100, Milian Wolff wrote:
>> > I tried this on a benchmark of mine:
>> >
>> > before:
>> > [ perf record: Woken up 196 times to write data ]
>> > [ perf record: Captured and wrote 48.860 MB perf.data (~2134707 samples) ]
>> >
>> > after, with dwarf,512
>> > [ perf record: Woken up 18 times to write data ]
>> > [ perf record: Captured and wrote 4.401 MB perf.data (~192268 samples) ]
>> >
>> > What confuses me though is the number of samples. When the workload is equal, 
>> > shouldn't the number of samples stay the same? Or what does this mean? The 
>> > resulting reports both look similar enough.
>> 
>> It's bogus - it just calculates the number of samples based on the file
>> size (with fixed sample size).  I think we should either show the correct
>> number as we post-process samples for build-id detection or simply
>> remove it.
>
> Well, since we setup the perf_event_attr we could perhaps do a better
> job at estimating this... In this case we even know how much stack_dump
> we will take at each sample, that would be major culprit for the current
> mis estimation.

Also fp callchain and tracepoint events can lead the mis estimation IMHO.

Thanks,
Namhyung

>
> And yes, if we do the post processing, we can do a precise calculation.
