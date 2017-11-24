From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: measuring system wide CPU usage ignoring idle process
Date: Fri, 24 Nov 2017 09:14:42 +0100
Message-ID: <20171124081442.GA11086@krava>
References: <3344812.IFj9h2T05j@agathebauer>
 <215895928.dRJQAAs51a@agathebauer>
 <20171120234438.GA22397@krava>
 <6754554.PRelPk1P9n@milian-kdab2>
 <20171123140931.GA5575@krava>
 <20171123142100.GA7066@krava>
 <20171123144220.GB8789@kernel.org>
 <20171123151205.GA8342@krava>
 <20171123185941.GN8789@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751631AbdKXIOo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 24 Nov 2017 03:14:44 -0500
Content-Disposition: inline
In-Reply-To: <20171123185941.GN8789@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>, linux-perf-users@vger.kernel.org, namhyung@kernel.org, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>

On Thu, Nov 23, 2017 at 03:59:41PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Nov 23, 2017 at 04:12:05PM +0100, Jiri Olsa escreveu:
> > On Thu, Nov 23, 2017 at 11:42:20AM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Thu, Nov 23, 2017 at 03:21:00PM +0100, Jiri Olsa escreveu:
> > > > On Thu, Nov 23, 2017 at 03:09:31PM +0100, Jiri Olsa wrote:
> > > > > On Thu, Nov 23, 2017 at 02:40:36PM +0100, Milian Wolff wrote:
> > > > > > > > Sorry for being unclear: I was talking about the task-clock and cpu-clock
> > > > > > > > values which you omitted from your measurements below. My example also
> > > > > > > > shows that the counts for cycles and instructions are fine. But the
> > > > > > > > cpu-clock and task-clock are useless as they always sum up to essentially
> > > > > > > > `$nproc*$runtime`. What I'm hoping for are fractional values for the "N
> > > > > > > > CPUs utilized".
> 
> > > > > > > ugh my bad.. anyway by using -a you create cpu counters
> > > > > > > which never unschedule, so those times will be same
> > > > > > > as the 'sleep 1' run length
> 
> > > Humm, what role perf_event_attr.exclude_idle has here?
> 
> > it's used for omiting samples from idle process.. but looks like it's
> > enforced for software clock events
> 
> looks like it is NOT enforced?

yea.. NOT ;-)

>  
> > AFAICS it's not used in counting mode
> 
> But it should? I think it should, as we see from Milian's use case.
> 
> PeterZ sent a patch, I guess we should continue from there :-)

right

jirka
