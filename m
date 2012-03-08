From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/2] perf: add sort by inclusive time functionality (v2)
Date: Thu, 8 Mar 2012 08:29:01 +0100
Message-ID: <20120308072901.GC20784@elte.hu>
References: <1331160079-13821-1-git-send-email-asharma@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:53293 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487Ab2CHH3R (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 8 Mar 2012 02:29:17 -0500
Content-Disposition: inline
In-Reply-To: <1331160079-13821-1-git-send-email-asharma@fb.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <asharma@fb.com>
Cc: linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Mike Galbraith <efault@gmx.de>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Namhyung Kim <namhyung.kim@lge.com>, Tom Zanussi <tzanussi@gmail.com>, linux-perf-users@vger.kernel.org


* Arun Sharma <asharma@fb.com> wrote:

> This patch series refactors existing code a bit and adds sort by 
> inclusive time (time spent in the function + callees).
> 
> Sample command lines:
> 
> # perf record -ag -- sleep 1
> # perf report -g graph,0.5,callee -n -s inclusive

So I tried this out with:

  $ taskset 1 perf record -g git gc

and got entries above 100% (in the TUI):

  $ perf report -g graph,0.5,callee -n -s inclusive

 +  321.11%        5628  [.] 0x392b609269
 +  142.27%        3774  [.] create_delta
 +  78.86%        1248  [.] lookup_object
 +  40.54%        1348  [k] system_call_fastpath
 [...]

Is that expected?

Thanks,

	Ingo
