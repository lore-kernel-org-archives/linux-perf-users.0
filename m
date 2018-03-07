From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC V3 1/3] perf, tools: Support wildcards on pmu name in
 dynamic pmu events
Date: Wed, 7 Mar 2018 10:54:15 -0800
Message-ID: <20180307185415.GK25017@tassilo.jf.intel.com>
References: <1520345084-42646-1-git-send-email-agustinv@codeaurora.org>
 <1520345084-42646-2-git-send-email-agustinv@codeaurora.org>
 <20180307160224.GN3701@kernel.org>
 <d3bd59db56fbc13b931ae45573bf94d8@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d3bd59db56fbc13b931ae45573bf94d8@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Agustin Vega-Frias <agustinv@codeaurora.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, timur@codeaurora.org
List-Id: linux-perf-users.vger.kernel.org

> Sorry about that. That's probably because FNM_EXTMATCH is a GNU extension,
> not POSIX, and the Alpine and Android runtimes likely don't implement
> that...
> I'll send a fix reverting back to the strncmp to ignore the uncore_ prefix,
> and dropping that extension.

Just don't set it? Even the basic glob patterns are useful.

-Andi
