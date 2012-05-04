From: Namhyung Kim <namhyung.kim@lge.com>
Subject: Re: [BUG] perf top -G is broken
Date: Fri, 04 May 2012 13:09:19 +0900
Message-ID: <87bom4a8pc.fsf@sejong.aot.lge.com>
References: <87pqanmh2y.fsf@sejong.aot.lge.com>
	<20120502160250.GB5745@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE6Q.lge.com ([156.147.1.121]:49352 "EHLO
	LGEMRELSE6Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714Ab2EDEKV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 4 May 2012 00:10:21 -0400
In-Reply-To: <20120502160250.GB5745@infradead.org> (Arnaldo Carvalho de Melo's
	message of "Wed, 2 May 2012 13:02:50 -0300")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: linux-perf-users@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>

Hi,

On Wed, 2 May 2012 13:02:50 -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 02, 2012 at 11:50:45AM +0900, Namhyung Kim escreveu:
>> Some guy reported me that perf top -G is broken with segment fault. I
>> can reproduce it on my system easily but the time is vary - few seconds
>> to 30 minutes. I ran it with --stdio to get a core file:
>
> Does it help to increase --mmap-pages from its default, 128, to
> something like 512 or more?
>
> Also try running with -r 90.
>
> - Arnaldo

Testing both options with current tip/perf/core gives me the same result. :(

Thanks,
Namhyung
