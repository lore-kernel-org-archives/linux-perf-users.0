From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: perf lock usage
Date: Thu, 30 Jan 2014 11:33:52 +0100
Message-ID: <20140130103352.GA1161@krava.brq.redhat.com>
References: <21216.48020.60857.22056@gargle.gargle.HOWL>
 <20140128093542.GD1229@krava.brq.redhat.com>
 <21225.2037.467035.833797@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12361 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751027AbaA3Kd6 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 30 Jan 2014 05:33:58 -0500
Content-Disposition: inline
In-Reply-To: <21225.2037.467035.833797@gargle.gargle.HOWL>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Sujith Manoharan <sujith@msujith.org>
Cc: linux-perf-users@vger.kernel.org

On Wed, Jan 29, 2014 at 07:23:57PM +0530, Sujith Manoharan wrote:
> Jiri Olsa wrote:
> > some of the kernel lock types do not follow the:
> >   acquire
> >   contended
> >   acuired
> >   release
> > 
> > lock state machine, like rcu or spin locks.. and thats what
> > caused most of the bad rates in my tests.
> > 
> > I was recently working on some changes for lock tracing,
> > what stats are you interested in?
> 
> I am trying to see lock usage stats for the ath9k wireless driver.
> Mainly in the transmission path, where normal spin locks
> are acquired.

I was using following code for studying the lock flow,
but it can also display the overhead (but not much in detail)

git tree:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/core_lock branch

the usage is sort of described in example here:
https://git.kernel.org/cgit/linux/kernel/git/jolsa/perf.git/commit/?h=perf/core_lock&id=f140425e46b2469b825c12b72507c6f3c539c7dd

so far I've been using the list mode only for checking
the lock flow, but it doesn't seem much useful otherwise..
so I haven't shared it yet

not sure this can be any use for you, but let me know if
you'd need other info

jirka
