From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC V3 1/3] perf, tools: Support wildcards on pmu name in
 dynamic pmu events
Date: Wed, 7 Mar 2018 16:05:09 -0300
Message-ID: <20180307190509.GQ3701@kernel.org>
References: <1520345084-42646-1-git-send-email-agustinv@codeaurora.org>
 <1520345084-42646-2-git-send-email-agustinv@codeaurora.org>
 <20180307160224.GN3701@kernel.org>
 <d3bd59db56fbc13b931ae45573bf94d8@codeaurora.org>
 <20180307185415.GK25017@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180307185415.GK25017@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Agustin Vega-Frias <agustinv@codeaurora.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, timur@codeaurora.org
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Mar 07, 2018 at 10:54:15AM -0800, Andi Kleen escreveu:
> > Sorry about that. That's probably because FNM_EXTMATCH is a GNU extension,
> > not POSIX, and the Alpine and Android runtimes likely don't implement
> > that...
> > I'll send a fix reverting back to the strncmp to ignore the uncore_ prefix,
> > and dropping that extension.
> 
> Just don't set it? Even the basic glob patterns are useful.

Or use:

#ifndef FNM_EXTMATCH
#define FNM_EXTMATCH 0
#endif

So on systems without it, its not used, while on GNU systems, we have
that functionality (pretty fancy, someone may need that... ;-))

- Arnaldo
