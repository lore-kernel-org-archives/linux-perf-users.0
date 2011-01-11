From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: perf: commit 55b4462 causes perf record to hang
Date: Tue, 11 Jan 2011 09:28:25 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1101110927290.12146@localhost6.localdomain6>
References: <4D2B544F.1050803@cisco.com> <20110110200032.GA19703@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:42909 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752515Ab1AKI2z (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 11 Jan 2011 03:28:55 -0500
In-Reply-To: <20110110200032.GA19703@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: David Ahern <daahern@cisco.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, tzanussi@gmail.com, Paul Mackerras <paulus@samba.org>, imunsie@au1.ibm.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org

On Mon, 10 Jan 2011, Arnaldo Carvalho de Melo wrote:

> Em Mon, Jan 10, 2011 at 11:47:43AM -0700, David Ahern escreveu:
> > With latest version of perf-core branch, a variant of perf record hangs:
> > # /tmp/build-perf/perf record -v -e cs -fo /tmp/perf.data  -- sleep 1
> > [ perf record: Captured and wrote 0.003 MB /tmp/perf.data (~120 samples) ]
> > 
> > It sits there forever. Back trace is:
> > 
> > (gdb) bt
> > #0  0x0000000000447658 in __perf_session__process_events (session=0xab9500, data_offset=208, data_size=2896, file_size=3104, ops=0x685580) at util/session.c:1006
> > #1  0x00000000004107dd in process_buildids () at builtin-record.c:466
> > #2  0x000000000041084d in atexit_header () at builtin-record.c:477
>  
> > git bisect traced the hang to
> > 
> > commit 55b44629f599a2305265ae9c77f9d9bcfd6ddc17
> > Author: Thomas Gleixner <tglx@linutronix.de>
> > Date:   Tue Nov 30 17:49:46 2010 +0000
> 
> Can you try with this patch, not reverting tglx's patch?
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 6fb4694..313dac2 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1007,7 +1007,7 @@ more:
>  	if (size == 0)
>  		size = 8;
>  
> -	if (head + event->header.size >= mmap_size) {
> +	if (head + event->header.size > mmap_size) {
>  		if (mmaps[map_idx]) {
>  			munmap(mmaps[map_idx], mmap_size);
>  			mmaps[map_idx] = NULL;
> 

/me feels stupid

      tglx
