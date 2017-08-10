From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 11/14] perf report: cache srclines for callchain nodes
Date: Thu, 10 Aug 2017 23:56:24 +0900
Message-ID: <CAM9d7chNxx8_Z10dViFtDbykpH+zXdhu44AAvpxD2=6wLz_Vkg@mail.gmail.com>
References: <20170806212446.24925-1-milian.wolff@kdab.com> <20170806212446.24925-12-milian.wolff@kdab.com>
 <20170810021325.GA1797@sejong> <4512331.57hptoN48J@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4512331.57hptoN48J@agathebauer>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jin Yao <yao.jin@linux.intel.com>, "linux-kernel@vger.kernel.org" <Linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kernel-team@lge.com
List-Id: linux-perf-users.vger.kernel.org

On Thu, Aug 10, 2017 at 8:51 PM, Milian Wolff <milian.wolff@kdab.com> wrote:
> On Donnerstag, 10. August 2017 04:13:25 CEST Namhyung Kim wrote:
>> Hi Milian,
>>
>> On Sun, Aug 06, 2017 at 11:24:43PM +0200, Milian Wolff wrote:
>> > On one hand this ensures that the memory is properly freed when
>> > the DSO gets freed. On the other hand this significantly speeds up
>> > the processing of the callchain nodes when lots of srclines are
>> > requested. For one of my data files e.g.:
>> >
>> > Before:
>> >  Performance counter stats for 'perf report -s srcline -g srcline --
> stdio':
>> >       52496.495043      task-clock (msec)         #    0.999 CPUs utilized
>> >
>> >                634      context-switches          #    0.012 K/sec
>> >
>> >                  2      cpu-migrations            #    0.000 K/sec
>> >
>> >            191,561      page-faults               #    0.004 M/sec
>> >
>> >    165,074,498,235      cycles                    #    3.144 GHz
>> >    334,170,832,408      instructions              #    2.02  insn per
>> >    cycle
>> >
>> >     90,220,029,745      branches                  # 1718.591 M/sec
>> >
>> >        654,525,177      branch-misses             #    0.73% of all
>> >        branches
>> >
>> >       52.533273822 seconds time elapsedProcessed 236605 events and lost 40
>> >       chunks!>
>> > After:
>> >  Performance counter stats for 'perf report -s srcline -g srcline --
> stdio':
>> >       22606.323706      task-clock (msec)         #    1.000 CPUs utilized
>> >
>> >                 31      context-switches          #    0.001 K/sec
>> >
>> >                  0      cpu-migrations            #    0.000 K/sec
>> >
>> >            185,471      page-faults               #    0.008 M/sec
>> >
>> >     71,188,113,681      cycles                    #    3.149 GHz
>> >
>> >    133,204,943,083      instructions              #    1.87  insn per
>> >    cycle
>> >
>> >     34,886,384,979      branches                  # 1543.214 M/sec
>> >
>> >        278,214,495      branch-misses             #    0.80% of all
>> >        branches
>> >
>> >       22.609857253 seconds time elapsed
>> >
>> > Note that the difference is only this large when `--inline` is not
>> > passed. In such situations, we would use the inliner cache and
>> > thus do not run this code path that often.
>> >
>> > I think that this cache should actually be used in other places, too.
>> > When looking at the valgrind leak report for perf report, we see tons
>> > of srclines being leaked, most notably from calls to
>> > hist_entry__get_srcline. The problem is that get_srcline has many
>> > different formatting options (show_sym, show_addr, potentially even
>> > unwind_inlines when calling __get_srcline directly). As such, the
>> > srcline cannot easily be cached for all calls, or we'd have to add
>> > caches for all formatting combinations (6 so far). An alternative
>> > would be to remove the formatting options and handle that on a
>> > different level - i.e. print the sym/addr on demand wherever we
>> > actually output something. And the unwind_inlines could be moved into
>> > a separate function that does not return the srcline.
>>
>> Agreed.  Also I guess no need to unwind anymore to get a srcfile for
>> an entry with your change.
>
> Does this mean I should respin the patch series with the above changes
> integrated? Or can we get this in first and then continue with the cleanup as
> described above later on?

Nop, it can be done later IMHO.  I will try to review the code next week.

Thanks,
Namhyung
