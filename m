From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] tools lib traceevent: Fix buffer overflow in arg_eval
Date: Thu, 28 Feb 2019 16:07:59 -0300
Message-ID: <20190228190759.GL9508@kernel.org>
References: <20190228015532.8941-1-tonyj@suse.de>
 <20190227221250.74996869@vmware.local.home>
 <20190228190123.GK9508@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190228190123.GK9508@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tony Jones <tonyj@suse.de>, linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org, Mathias Krause <minipli@googlemail.com>, linux-trace-devel@vger.kernel.org, Tzvetomir Stoyanov <tstoyanov@vmware.com>, Michael Sartain <mikesart@fastmail.com>
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Feb 28, 2019 at 04:01:23PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Feb 27, 2019 at 10:12:50PM -0500, Steven Rostedt escreveu:
> > On Wed, 27 Feb 2019 17:55:32 -0800
> > Tony Jones <tonyj@suse.de> wrote:
> > 
> > > Fix buffer overflow observed when running perf test.
> > > 
> > > The overflow is when trying to evaluate "1ULL << (64 - 1)" which
> > > is resulting in -9223372036854775808 which overflows the 20 character
> > > buffer.
> > > 
> > > If is possible this bug has been reported before but I still don't
> > > see any fix checked in:
> > > 
> > > See: https://www.spinics.net/lists/linux-perf-users/msg07714.html
> > > 
> > > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > Cc: linux-perf-users@vger.kernel.org
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Signed-off-by: Tony Jones <tonyj@suse.de>
> > 
> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > I have to say I've let this slide and it is not the first time a patch
> > went out with this fix. But this one has the correct fix because we
> > should use a buffer with a multiple of 4. Anyway, Tony I believe was
> > the first to report this anyway.
> > 
> > For reference we have:
> > 
> > I first heard about Tony's complaint on a post to linux-perf-users on Jan 18.
> > 
> > But then we had after that:
> > 
> >  Michael Sartain reported it on 1/24 (and fixed by Tzvetomir)
> >  https://lore.kernel.org/linux-trace-devel/20190125102014.19600-1-tstoyanov@vmware.com/
> >  
> > It was later fixed again by Mathias Krause
> >  https://lore.kernel.org/linux-trace-devel/20190223122404.21137-1-minipli@googlemail.com/
> > 
> > But since Tony was first to report it, and we discussed that it should
> > be 24 bytes, I would say this is the patch to take.
> > 
> > Again, sorry for not getting this acknowledged earlier and everyone doing
> > the same thing multiple times. :-/
> > 
> > Arnaldo, please take this patch. But also add:
> > 
> > Reported-by: Michael Sartain <mikesart@fastmail.com>
> > Reported-by: Mathias Krause <minipli@googlemail.com>
> 
> Will do.
> 
> Thanks for the credit research,

Some more research, an approximation, adding:

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Fixes: f7d82350e597 ("tools/events: Add files to create libtraceevent.a")

That is the 'git blame' entry for when that line was added with sizeof
== 20

- Arnaldo
