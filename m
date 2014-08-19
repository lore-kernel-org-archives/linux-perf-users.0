From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: Problems with perf
Date: Tue, 19 Aug 2014 10:08:52 +0200
Message-ID: <20140819080852.GA12435@krava.brq.redhat.com>
References: <CABooUW2QDE_zRMyNzSEvWMEy+c-yrMvm+rSoASsx7ctBTijvFg@mail.gmail.com>
 <loom.20140818T205057-420@post.gmane.org>
 <loom.20140818T221806-241@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:19770 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbaHSII4 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 19 Aug 2014 04:08:56 -0400
Content-Disposition: inline
In-Reply-To: <loom.20140818T221806-241@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Tommy <tommy24@gatech.edu>
Cc: linux-perf-users@vger.kernel.org

On Mon, Aug 18, 2014 at 08:21:22PM +0000, Tommy wrote:
> Tommy <tommy24 <at> gatech.edu> writes:
> 
> > 
> > Jen-Cheng(Tommy) Huang <tommy24 <at> gatech.edu> writes:
> > > 
> > > Hi
> > > 
> > > I am trying to use perf with event grouping to profile Java apps.
> > > My kernel is 3.16.1-1.el6.elrepo.x86_64
> > > perf version 3.16.1-1.el6.elrepo.x86_64
> > > The Java app I use is hadoop TaskTracker, which spawns multiple child 
> > JVMs.
> > > There seems to be something wrong with event group, since very few
> > > samples were collected if I use more than one event in a group.
> > > The following shows an example
> > > 
> > > I used
> > > perf record -e '{instructions}:S' -c 100000 [TaskTracker command]
> > > This one works fine and it collects a reasonable amount of samples and
> > > several threads are sampled.
> > > 
> > > However, the following command does not work.
> > > perf record -e '{instructions,cycles}:S' -c 100000 [TaskTracker command]
> > > Less than 1000 samples were collected and only one thread was sampled
> > > 
> > > If I don't use :S to read samples, the sample counts are reasonable,
> > > but the event grouping is gone. (both events were sampled, no leader
> > > event.)
> > > perf record -e '{instructions,cycles}' -c 100000 [TaskTracker command]
> > > 
> > > I tested single-threaded app, such as SPEC CPU.
> > > Everything works fine. The event grouping works fine, so as the :S flag.
> > > However, the Java app that I tested does not.
> > > Please let me know if any suggestions on this issue.
> > > 
> > > Thanks.
> > > 
> > To make it clear about the sample count difference, this is the stats 
> > collected from a few seconds run of the same app: With only one event in a 
> > group, it has ~362339 samples while 2 events in a group, it has only 938 
> > samples (only 1 thread was profiled). I think the sample recording is 
> > somehow stopped.
> > Thanks.
> 
> I found that even the woken counts are different
> 1 event in a group:
> [ perf record: Woken up 27 times to write data ]
> [ perf record: Captured and wrote 7.165 MB perf.data (~313046 samples) ]
> 
> 2 events in a group:
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.051 MB perf.data (~2223 samples) ]

hi,
we switch off event inheritance for multiple events in group
with leader sampling. That's probably why you see less samples
and only one thread. 

The reason for that is the way we read event values, which
does not support inherited events yet.

I'll check and see what can be done about that.. at least
display a warning ;-)

thanks,
jirka
