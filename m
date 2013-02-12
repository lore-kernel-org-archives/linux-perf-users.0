From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: Perf record premature termination
Date: Tue, 12 Feb 2013 09:07:31 -0800
Message-ID: <1360688851.17632.195.camel@schen9-DESK>
References: <1360608612.17632.193.camel@schen9-DESK>
	 <511947CB.5010600@gmail.com> <1360620940.17632.194.camel@schen9-DESK>
	 <51197120.7030207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61303 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932327Ab3BLRHo (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 12 Feb 2013 12:07:44 -0500
In-Reply-To: <51197120.7030207@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, ak <ak@linux.intel.com>

On Mon, 2013-02-11 at 15:30 -0700, David Ahern wrote:
> On 2/11/13 3:15 PM, Tim Chen wrote:
> > On Mon, 2013-02-11 at 12:34 -0700, David Ahern wrote:
> >> On 2/11/13 11:50 AM, Tim Chen wrote:
> >>> David,
> >>>
> >>> When I am doing a profiling of kernel compile with 32 threads on a 4
> >>> socket westmere machine, I found that perf record terminated right away
> >>> for the version of perf in 3.7 kernel source tree.
> >>> There's no profile data recroded and the compile is running in
> >>> background.
> >>>
> >>> $ make -j32 &
> >>> then
> >>> $ sudo /test/perf record -a -g -f sleep 5
> >>> sleep: Terminated
> 
> This is the more appropriate fix. Make mmap consistent with comm. Revert 
> the other one.

Thanks.  Works for me.

Tim
