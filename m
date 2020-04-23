From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 2/8] perf metrics: fix parse errors in cascade lake
 metrics
Date: Thu, 23 Apr 2020 12:11:20 +0200
Message-ID: <20200423101120.GC1136647@krava>
References: <20200422074809.160248-1-irogers@google.com>
 <20200422074809.160248-3-irogers@google.com>
 <20200422143840.GJ608746@tassilo.jf.intel.com>
 <CAP-5=fUnWAycQehCJ9=btquV2c3DVDX+tTEc85H8py9Kfehq4w@mail.gmail.com>
 <CAP-5=fUMFqiSFLbKA-XWStrePwxiYfq7Jk6mS9=F56Q9y-KVsA@mail.gmail.com>
 <46e803f3-80a4-0d37-9d39-b625b947ac7f@linux.intel.com>
 <cb5fcb4b-3ac6-66b5-9f9e-7943f4a6dadf@linux.intel.com>
 <CAP-5=fXVF_ExxVuiivF0JY3MwgxrQZqyFoPwn-p7DPf6Gbdh0g@mail.gmail.com>
 <abec8f03-ecb5-9bfe-c8ab-2c6d2aad2a60@linux.intel.com>
 <20200423101030.GB1136647@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200423101030.GB1136647@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: "Jin, Yao" <yao.jin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Apr 23, 2020 at 12:10:36PM +0200, Jiri Olsa wrote:
> On Thu, Apr 23, 2020 at 03:51:18PM +0800, Jin, Yao wrote:
> > Hi Ian,
> > 
> > On 4/23/2020 2:09 PM, Ian Rogers wrote:
> > > On Wed, Apr 22, 2020 at 10:54 PM Jin, Yao <yao.jin@linux.intel.com> wrote:
> > > > 
> > > > Hi Jiri,
> > > > 
> > > > Bisected to this commit which introduced the regression.
> > > > 
> > > > 26226a97724d ("perf expr: Move expr lexer to flex")
> > > > 
> > > > Would you like to look at that?
> > > 
> > > Hi Jin,
> > > 
> > > that commit breaks parsing of things like ','. See fixes in this patch
> > > set such as:
> > > https://lore.kernel.org/lkml/20200422220430.254014-5-irogers@google.com/
> > > Fixing the lex issues then exposes other bugs that need to be
> > > corrected in the json. I've added Fixes to the commit message of:
> > > https://lore.kernel.org/lkml/20200422220430.254014-3-irogers@google.com/
> > > https://lore.kernel.org/lkml/20200422220430.254014-4-irogers@google.com/
> > > and would be glad of a review. If we can land:
> > > https://lore.kernel.org/lkml/20200422220430.254014-12-irogers@google.com/
> > > then expr as the source of parse errors can go away :-) The next
> > > problem is the parse events code, but some of that logic is dependent
> > > on the machine it is running on. It'd be good to add a test that
> > > parsed events code can handle the events in metrics too, filtering out
> > > things like duration_time that are special to metrics.
> > > 
> > > Thanks,
> > > Ian
> > > 
> > 
> > Only with the fix
> > "https://lore.kernel.org/lkml/20200422220430.254014-5-irogers@google.com/"
> > (without other json modifications), the issue was still there.
> > 
> > localhost:~ # perf stat -M DRAM_Read_Latency
> > event syntax error:
> > '../event=0x36,,umask=0x21/,cha/event=0x35,cha_0/event=0x0/}:W,duration_time'
> >                                   \___ parser error
> > 
> >  Usage: perf stat [<options>] [<command>]
> > 
> >     -M, --metrics <metric/metric group list>
> >                           monitor specified metrics or metric groups
> > (separated by ,)
> 
> hum, I don't have that metric, is there another example of broken metric?
> 
> [jolsa@krava perf]$ sudo ./perf stat -M DRAM_Read_Latency
> Cannot find metric or group `DRAM_Read_Latency'
> 
> > 
> > So you added other commits which changed the json to let the parse work. But
> > I don't know if we have to do with this way because it should be a
> > regression issue.
> > 
> > In my opinion, we'd better fix the issue in 26226a97724d ("perf expr: Move
> > expr lexer to flex") and try not to change the json if possible.
> 
> yea, that change definitely had a potential of breaking things ;-)
> but it should be easy to fix them
> 
> I'll go through the v3 of the patchset

ok, there's v2 now ;-)

jirka
