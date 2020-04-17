From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 11/16] perf intel-pt: Add support for synthesizing
 callchains for regular events
Date: Fri, 17 Apr 2020 16:50:00 +0300
Message-ID: <5b8f28f5-968f-bfff-68af-ed0350a90765@intel.com>
References: <20200401101613.6201-1-adrian.hunter@intel.com>
 <20200401101613.6201-12-adrian.hunter@intel.com>
 <20200416151443.GA2650@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200416151443.GA2650@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 16/04/20 6:14 pm, Arnaldo Carvalho de Melo wrote:
> Em Wed, Apr 01, 2020 at 01:16:08PM +0300, Adrian Hunter escreveu:
>> Currently, callchains can be synthesized only for synthesized events.
>> Support also synthesizing callchains for regular events.
> 
> This is super cool, I wonder if we shouldn't do it automatically or just
> adding a new type of callchains, i.e.:
> 
> 	perf record --call-graph pt uname
> 
> Should take care of all the details, i.e. do the extra steps below
> behind the scenes.
> 
> Possibly even find out that the workload specified was built with
> -fomit-frame-pointers, that the hardware has Intel PT and do all behind
> the scenes for:
> 
> 	perf record -g uname
> 
> Alternatively we could take some less seemingly far fetched approach and
> make this configurable via:
> 
> 	perf config call-graph.record-mode=pt
> 
> What do you think?

Adding a --call-graph option sounds reasonable, and config to define default
callgraph options.  But this was done at Andi Kleen's request, so he may
want to comment.
