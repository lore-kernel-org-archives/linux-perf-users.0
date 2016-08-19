From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Accessing sample data (like period) for trace events from python
 scripts
Date: Fri, 19 Aug 2016 10:35:49 +0900
Message-ID: <20160819013549.GA22968@sejong>
References: <12483222.2TZrqxLJ8H@agathebauer>
 <20160817030553.GB8981@sejong>
 <8086607.n4B18LBsdA@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:52640 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754212AbcHSBgq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 Aug 2016 21:36:46 -0400
In-Reply-To: <8086607.n4B18LBsdA@milian-kdab2>
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org

On Wed, Aug 17, 2016 at 10:48:31AM +0200, Milian Wolff wrote:
> On Wednesday, August 17, 2016 12:05:53 PM CEST Namhyung Kim wrote:
> > Hi Milian,
> > 
> > On Tue, Aug 16, 2016 at 08:42:01PM +0200, Milian Wolff wrote:
> > > Hey all,
> > > 
> > > It doesn't seem to be possible to access the period, tid and various other
> > > sample fields from a python (and perl?) script using `perf script`. My
> > > use-
> > > case would be analyzing a perf data file created by perf inject
> > > --sched-stat.
> > 
> > I think you can access param_dict["sample"]["period"].
> 
> No, that is not possible, but would be a viable solution as well.

Sorry for late reply.  Oh, you wanted to access period of tracepoint
but I guess it's always 1, no?

Thanks,
Namhyung


> 
> ~~~~~~~~~~~~~~~~~~
> /tmp$ cat perf-script.py
> 
> import os
> import sys
> 
> sys.path.append(os.environ['PERF_EXEC_PATH'] + \
>         '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> 
> from perf_trace_context import *
> from Core import *
> 
> def trace_unhandled(event_name, context, event_fields_dict):
>         print event_fields_dict['sample']['period']
> 
> /tmp$ perf script -s perf-script.py
> Traceback (most recent call last):
>   File "perf-script.py", line 11, in trace_unhandled
>     print event_fields_dict['sample']['period']
> KeyError: 'sample'
> Fatal Python error: problem in Python trace event handler
> Aborted (core dumped)
> ~~~~~~~~~~~~~~~~~~
> 
> Cheers
> -- 
> Milian Wolff | milian.wolff@kdab.com | Software Engineer
> KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt Experts
