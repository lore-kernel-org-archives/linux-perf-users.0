From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [Suggestion/Problems] perf annoate: Some problems related to the
 source code view and Improvement of it with line numbers
Date: Fri, 17 Feb 2017 10:29:39 -0300
Message-ID: <20170217132939.GA4109@kernel.org>
References: <5c703d64-3ef4-3d43-bf99-f14c5fc4cdac@gmail.com>
 <20170215132411.GF4020@kernel.org>
 <963c309b-ca3a-e5a7-30f3-e0a521e5c3e5@gmail.com>
 <e0cdc76f-2c45-1528-e1e4-0fa3193c59cd@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e0cdc76f-2c45-1528-e1e4-0fa3193c59cd@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Taeung Song <treeze.taeung@gmail.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, perf group <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Feb 17, 2017 at 11:33:29AM +0900, Taeung Song escreveu:
> Hi, Arnaldo :)
> 
> Regarding perf annotate:
> 
> 1) Problem : wrong line numbers on perf-annotate (both stdio and TUI)
> 2) Problem : wrong sum of overhead(percent) matching source lines
> 3) Suggestion : new option showing only source code per function
>                 with overhead info (to be more readable :) )
> 
> I'll send the patchset for them, maybe it'll a bit take time.
> But I won't be long..

Concentrate on the first, send the patch, while waiting for review, work
on the second, and so on :-)

- Arnaldo
 
> Thanks,
> Taeung
> 
> On 02/15/2017 11:24 PM, Taeung Song wrote:
> > 
> > 
> > On 02/15/2017 10:24 PM, Arnaldo Carvalho de Melo wrote:
> > > Em Wed, Feb 15, 2017 at 09:34:51PM +0900, Taeung Song escreveu:
> > > > > Hi all :)
> > > > >
> > > > > I found some problems about showing line numbers of perf-annotate.
> > > > > and I have a suggestion about perf-annotate.
> > > > >
> > > > > Sure, I have a plan to send the patchset about that.
> > > > > But I'd like to know other opinions about that before sending the
> > > > patchset.
> > > > > :)
> > > Humm, TLDR, please try to find one problem, describe it precisely, show
> > > before and after results (in the changeset message), and send it, rinse,
> > > repeat.
> > > 
> > > For instance, if the line numbers are different in --stdio and --tui,
> > > that is a problem, state that, show the output (as you did below), put
> > > it in a patch, send it.
> > > 
> > 
> > Okey it was too long.
> > 
> > I'll separate the contents into simple parts
> > and send a patch with things you said :)
> > for easy review.
> > 
> > Thanks,
> > Taeung
