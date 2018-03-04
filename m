From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC V2 1/3] perf, tools: Support wildcards on pmu name in
 dynamic pmu events
Date: Sun, 4 Mar 2018 09:12:45 -0800
Message-ID: <20180304171245.GB25017@tassilo.jf.intel.com>
References: <1520034092-35275-1-git-send-email-agustinv@codeaurora.org>
 <1520034092-35275-2-git-send-email-agustinv@codeaurora.org>
 <20180303143436.GA14563@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180303143436.GA14563@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Agustin Vega-Frias <agustinv@codeaurora.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, timur@codeaurora.org
List-Id: linux-perf-users.vger.kernel.org

> > +#include <fnmatch.h>
> >  #include <linux/compiler.h>
> >  #include <linux/list.h>
> >  #include <linux/types.h>
> > @@ -241,7 +242,7 @@ PE_NAME opt_event_config
> >  			if (!strncmp(name, "uncore_", 7) &&
> >  			    strncmp($1, "uncore_", 7))
> >  				name += 7;
> > -			if (!strncmp($1, name, strlen($1))) {
> > +			if (!strncmp($1, name, strlen($1)) || !fnmatch($1, name, 0)) {
> 
> could we now get rid of the strncmp in here and keep the
> glob matching only? 

That would break existing command lines. Not a good idea.

-Andi
