From: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: How does perf collects per thread/process events ?
Date: Mon, 22 Jul 2013 14:19:44 +1000
Message-ID: <1374466784.17730.12.camel@concordia>
References: <51E566DD.1070006@insa-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:49580 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382Ab3GVETs (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 22 Jul 2013 00:19:48 -0400
In-Reply-To: <51E566DD.1070006@insa-lyon.fr>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Manuel Selva <selva.manuel@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Tue, 2013-07-16 at 17:29 +0200, Manuel Selva wrote:
> Hi,
> 
> My question regards a platform equipped with 2 Intel Xeon X5650.
> According to the perf wiki page 
> (https://perf.wiki.kernel.org/index.php/Tutorial), "by default perf stat 
> counts for all threads of the process and subsequent child processes and 
> threads" and "By default, perf stat counts in per-thread mode".
> 
> So a first question is what is the default: per thread or per process ?

It's per process, which is as described in the first quote above. The
second quote is just wrong AFAICS.

> Then, independently of the answer, I am wondering how does perf handles 
> per thread or per process regarding the scheduler and migrations. I 
> didn't find it explicitly in the Intel documentation but it seems 
> natural that hardware performance counters located on a given core are 
> only capable of counting event on this core and not on other cores. Is 
> it true ?
> 
> Moreover, the wiki page says that "When a thread migrated from one 
> processor to another, counters are saved on the current processor and 
> are restored on the new one" (this seems to confirm the answer to my 
> previous question above). It means that the scheduler is aware about 
> "perf" or that perf is able to register a hook into the scheduler. So I 
> guess this is done in the kernel part of perf (in the implementation of 
> the perf_event_open system call) and not in the user land part, is it true ?

Yes.

cheers
