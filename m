From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2]: perf record: enable arbitrary event names thru name=
 modifier
Date: Mon, 4 Jun 2018 10:47:16 -0300
Message-ID: <20180604134716.GD3397@kernel.org>
References: <23f72f9b-c513-ecd4-d375-c5cf2eb30197@linux.intel.com>
 <20180601230100.GN30764@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180601230100.GN30764@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Jun 01, 2018 at 04:01:00PM -0700, Andi Kleen escreveu:
> On Thu, May 31, 2018 at 05:08:12PM +0300, Alexey Budankov wrote:
> > 
> > Enable complex event names containing [.:=,] symbols to be encoded into Perf 
> > trace using name= modifier e.g. like this:
> > 
> > perf record -e cpu/name=\'OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.SNOOP_HITM\',\
> > 		period=0x3567e0,event=0x3c,cmask=0x1/Duk ./futex
> > 
> > Below is how it looks like in the report output. Please note explicit escaped 
> > quoting at cmdline string in the header so that thestring can be directly reused
> > for another collection in shell:
> 
> Patch looks good, but new syntax also needs to be documented in some manpage
> (e.g. perf list)

He added the doc part in his v3 post, so I'l collecting your Acked-by,
ok?

- Arnaldo
