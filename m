From: Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 2/8] perf metrics: fix parse errors in cascade lake metrics
Date: Wed, 22 Apr 2020 23:09:11 -0700
Message-ID: <CAP-5=fXVF_ExxVuiivF0JY3MwgxrQZqyFoPwn-p7DPf6Gbdh0g@mail.gmail.com>
References: <20200422074809.160248-1-irogers@google.com> <20200422074809.160248-3-irogers@google.com>
 <20200422143840.GJ608746@tassilo.jf.intel.com> <CAP-5=fUnWAycQehCJ9=btquV2c3DVDX+tTEc85H8py9Kfehq4w@mail.gmail.com>
 <CAP-5=fUMFqiSFLbKA-XWStrePwxiYfq7Jk6mS9=F56Q9y-KVsA@mail.gmail.com>
 <46e803f3-80a4-0d37-9d39-b625b947ac7f@linux.intel.com> <cb5fcb4b-3ac6-66b5-9f9e-7943f4a6dadf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cb5fcb4b-3ac6-66b5-9f9e-7943f4a6dadf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Jin, Yao" <yao.jin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Apr 22, 2020 at 10:54 PM Jin, Yao <yao.jin@linux.intel.com> wrote:
>
> Hi Jiri,
>
> Bisected to this commit which introduced the regression.
>
> 26226a97724d ("perf expr: Move expr lexer to flex")
>
> Would you like to look at that?

Hi Jin,

that commit breaks parsing of things like ','. See fixes in this patch
set such as:
https://lore.kernel.org/lkml/20200422220430.254014-5-irogers@google.com/
Fixing the lex issues then exposes other bugs that need to be
corrected in the json. I've added Fixes to the commit message of:
https://lore.kernel.org/lkml/20200422220430.254014-3-irogers@google.com/
https://lore.kernel.org/lkml/20200422220430.254014-4-irogers@google.com/
and would be glad of a review. If we can land:
https://lore.kernel.org/lkml/20200422220430.254014-12-irogers@google.com/
then expr as the source of parse errors can go away :-) The next
problem is the parse events code, but some of that logic is dependent
on the machine it is running on. It'd be good to add a test that
parsed events code can handle the events in metrics too, filtering out
things like duration_time that are special to metrics.

Thanks,
Ian

> Thanks
> Jin Yao
>
> On 4/23/2020 9:08 AM, Jin, Yao wrote:
> >
> >
> > On 4/23/2020 12:18 AM, Ian Rogers wrote:
> >> On Wed, Apr 22, 2020 at 8:34 AM Ian Rogers <irogers@google.com> wrote:
> >>>
> >>> On Wed, Apr 22, 2020 at 7:38 AM Andi Kleen <ak@linux.intel.com> wrote:
> >>>>
> >>>> On Wed, Apr 22, 2020 at 12:48:03AM -0700, Ian Rogers wrote:
> >>>>> Remove over escaping with \\.
> >>>>> Remove extraneous if 1 if 0 == 1 else 0 else 0.
> >>>>
> >>>> So where do these parse errors happen exactly? Some earlier
> >>>> patches introduced them as regressions?
> >>>
> >>> I'll work to track down a Fixes tag. I can repro the Skylakex errors
> >>> without the test in this series, by doing:
> >>>
> >>> $ perf stat -M DRAM_Read_Latency sleep 1
> >>> Error:
> >>> The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> >>> for event (cha/event=0x36\,uma
> >>> sk=0x21/).
> >>> /bin/dmesg | grep -i perf may provide additional information.
> >>>
> >
> > I also think some patches introduced this regression. When we rollback
> > to commit 61ec07f5917e (perf vendor events intel: Update all the Intel
> > JSON metrics from TMAM 3.6.), there is no this error on CLX.
> >
> > Thanks
> > Jin Yao
> >
> >>> This was just the escaping issue. I'm less clear on the other cascade
> >>> lake issue, and it is a bit more work for me to test on cascade lake.
> >>> What is "if 1 if 0 == 1 else 0 else 0" trying to do? Perhaps hunting
> >>> for the Fixes will let me know, but it looks like a copy-paste error.
> >>>
> >>>> The original metrics worked without parse errors as far as I know.
> >>>
> >>> The skylake issue above repros on 5.2.17 and so it seems like it is
> >>> broken for a while. The test in this series will prevent this in the
> >>> future, but without this patch that test fails.
> >>
> >> The parse errors were introduced with the metrics, so they've never
> >> worked:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=fd5500989c8f3c3944ac0a144be04bae2506f7ba
> >>
> >>
> >> I will send out a v2 with Fixes in the commit message but wanted to
> >> wait in case there was any more feedback. In particular the fixes to
> >> the new test and expr parser lex code. The lex code wasn't broken at
> >> the time the metrics were added and should be working again after this
> >> patch set.
> >>
> >> Thanks,
> >> Ian
> >>
> >>>> If it fixes something earlier it would need Fixes: tags.
> >>>
> >>> Working on it. Thanks for the input!
> >>>
> >>> Ian
> >>>
> >>>> -Andi
