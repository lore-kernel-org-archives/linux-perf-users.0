From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Memory leak in 3.17.rc6.g09bba1?
Date: Fri, 14 Nov 2014 09:30:04 -0300
Message-ID: <20141114123004.GB4163@kernel.org>
References: <54655AAF.90604@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:42924 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965431AbaKNMaK (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 14 Nov 2014 07:30:10 -0500
Content-Disposition: inline
In-Reply-To: <54655AAF.90604@hp.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Rick Jones <rick.jones2@hp.com>
Cc: linux-perf-users@vger.kernel.org

Em Thu, Nov 13, 2014 at 05:28:15PM -0800, Rick Jones escreveu:
> I am running a command:
> 
> perf top -a -g -e skb:kfree_skb
> 
> on a laptop running a 3.18.0-rc2+ kernel from davem's net-next tree. While
> that is running I hit the system as the target of a netperf TCP_CC test (ie
> netserver is running on the system where perf is running, and netperf is run
> on another system, pointing at the first).  I then expand the kfree_skb()
> line and the sk_stream_kill_queues  and tcp_rcv_state_process lines "within"
> that expansion.
> 
> If I watch with plain "top" in another window I can see the RES value for
> the perf process steadily increasing and also its CPU utlization. The latter
> finally peaks at 100% (this is a core 2 duo laptop).
> 
> After about 1800 seconds of being the target of a netperf TCP_CC test the
> RES value for the perf utility is over 1G.
> 
> If I wait long enough, perf will finally segfault.
> 
> Is this a known issue?  If I should file a more formal bug report somewhere
> let me know.

Thanks for reporting the leak, I'll try to reproduce it here and see if
I can fix it.

It should not leak memory, and we know it needs to constrain its use
doing some garbage collecting, and it _definetely_ should not segfault.

It is definetely a usecase we want to support 8-)

- Arnaldo
 
> happy benchmarking,
> 
> rick jones
> 
> raj@raj-8510w:~$ net-next/tools/perf/perf --version
> perf version 3.17.rc6.g09bba1
> 
> netperf -t tcp_cc -H <perfsystem> -l 3600
> 
> might need to repeat it a few times to get the segfault?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
