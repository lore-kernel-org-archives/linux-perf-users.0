From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf record: Allow to disable callchains by setting mode
 to "none"
Date: Tue, 16 Aug 2016 11:43:28 -0300
Message-ID: <20160816144328.GH20972@kernel.org>
References: <20160816103427.5567-1-milian.wolff@kdab.com>
 <1889732.MY2fur9umb@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44626 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752434AbcHPOni (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 16 Aug 2016 10:43:38 -0400
Content-Disposition: inline
In-Reply-To: <1889732.MY2fur9umb@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>, Ingo Molnar <mingo@kernel.org>

Em Tue, Aug 16, 2016 at 04:33:14PM +0200, Milian Wolff escreveu:
> Hey,
> 
> sorry for the noise. This patch can be dropped. Not only is it broken (doesn't 
> set param->enabled = false), the functionality I was looking for exists 
> already in the form of call-graph=no (see evsel.c).
> 
> Is there a reason that the disabling feature is handled outside of 
> parse_callchain_record? Otherwise one should centralize the code imo for 
> readability.
> 
> I'd also like to see "none" being accepted as a synonym to "no".
> 
> If any of the two things above sound valid, then I'd respin the patch below 
> attend to them.

We have logic to support, for instance:

  perf report --no-ch

to be interpreted as:

  perf report --no-children

I.e. if it is unambiguous, we grok it. This code came from the git
source code, where the same thing is valid.

If it is ambiguous, we bail like this:

ot@jouet ~]# perf report --no-c
 Error: Ambiguous option: no-c (could be --no-column-widths or --no-cpu)
 Usage: perf report [<options>]

[root@jouet ~]#

Which has an issue, as it is not considering all the BOOL options that
automatically get a --no- option, like --children -> --no-children, that
needs fixing, but you got the idea: unambiguous, do an
"auto-tab-completion" of sorts, not? Say so and show the other
possibilities.

So if we had that for the terms in the per-event options, that would be
lovely indeed.

Ditto for the other thing you mentioned, initializing related things in
one place is saner, so please consider sending a separate patch for
that.

I'll get to look at your outstanding patches soon, I hope, after getting
over some other patches.

- Arnaldo
 
> Cheers
> 
> On Dienstag, 16. August 2016 12:34:27 CEST Milian Wolff wrote:
> > This change is mostly useful for symmetry purposes. Before, we could:
> > 
> >     --event foo/call-graph=fp/
> >     --event bar/call-graph=dwarf/
> >     --event asdf/call-graph=lbr/
> > 
> > Now, we can also use
> > 
> >     --event xyz/call-graph=none/
> > 
> > The latter is equivalent to
> > 
> >     --event xyz
> > 
> > when the `perf record` invocation does not specify a global call-graph
> > option. If it does, then this patch also allows us to selectively
> > disable the call-graph for single events.
> > 
> > Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> > ---
> >  tools/perf/util/util.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> > index 85c5680..a549fee 100644
> > --- a/tools/perf/util/util.c
> > +++ b/tools/perf/util/util.c
> > @@ -536,6 +536,14 @@ int parse_callchain_record(const char *arg, struct
> > callchain_param *param) pr_err("callchain: No more arguments "
> >  					"needed for --call-graph lbr\n");
> >  			break;
> > +		} else if (!strncmp(name, "none", sizeof("none"))) {
> > +			if (!strtok_r(NULL, ",", &saveptr)) {
> > +				param->record_mode = CALLCHAIN_NONE;
> > +				ret = 0;
> > +			} else
> > +				pr_err("callchain: No more arguments "
> > +					"needed for --call-graph none\n");
> > +			break;
> >  		} else {
> >  			pr_err("callchain: Unknown --call-graph option "
> >  			       "value: %s\n", arg);
> 
> 
> -- 
> Milian Wolff | milian.wolff@kdab.com | Software Engineer
> KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt Experts
