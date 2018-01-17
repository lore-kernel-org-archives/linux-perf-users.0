From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 2/5] perf unwind: Do not look at globals
Date: Wed, 17 Jan 2018 09:23:07 +0100
Message-ID: <20180117082307.GE6183@krava>
References: <20180116142438.19520-1-acme@kernel.org>
 <20180116142438.19520-3-acme@kernel.org>
 <20180116151915.GC17819@krava>
 <20180116153621.GC16107@kernel.org>
 <20180116182650.GE16107@kernel.org>
 <20180116194909.GB6183@krava>
 <20180116200520.GG16107@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750861AbeAQIXQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 Jan 2018 03:23:16 -0500
Content-Disposition: inline
In-Reply-To: <20180116200520.GG16107@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Hendrick Brueckner <brueckner@linux.vnet.ibm.com>, Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>

On Tue, Jan 16, 2018 at 05:05:20PM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> > >  
> > > +/*
> > > + * Are there any events usind DWARF callchains?
> > > + *
> > > + * I.e.
> > > + *
> > > + * -e cycles/call-graph=dwarf/
> > > + */
> > > +bool dwarf_callchain_users;
> > 
> > hum, I don't follow.. this bool seems to mirror the usage of
> > 'param->record_mode = CALLCHAIN_DWARF', whats the difference?
> > 
> > also, the patch title says 'Do not look at globals', while inside you
> 
> The first version didn't look at globals, the second one doesn't look at
> an _specific_ global variable, the global config for --call-graph, which
> is a global variable, callchain_param, which _we_ can't touch at
> apply_config_terms(), since that is about _just_ that event, not all of
> them.
> 
> > add new global dwarf_callchain_users and work with it.. what do I miss?
> > 
> > I'll check tomorrow with clean head ;-)
> 
> Look closely at apply_config_terms() it passes a _local_ variable to
> 
>                         perf_evsel__config_callchain(evsel, opts, &param);
> 
> It will not affect any globals that tools/perf/util/unwind-libunwind-local.c
> could possibly use... and that is the problem. :-)

ah ok, that one is local.. just to set up the attrs

then adding that new variable is ok, though it could be
aded inside struct callchain_param, to keep callchain
config stuff together

thanks,
jirka
