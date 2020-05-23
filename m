From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2 0/7] Share events between metrics
Date: Sun, 24 May 2020 00:19:36 +0200
Message-ID: <20200523221936.GA123450@krava>
References: <20200520182011.32236-1-irogers@google.com>
 <20200521114325.GT157452@krava>
 <20200521172235.GD14034@kernel.org>
 <20200522101311.GA404187@krava>
 <20200522144908.GI14034@kernel.org>
 <CAP-5=fUaaNpi3RZd9-Q-uCaudop0tU5NN8HFek5e2XLoBZqt6w@mail.gmail.com>
 <CAP-5=fWZYJ2RXeXGGmFXAW9CNnb2S6cGYKc_M=hUQyCng7KJBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP-5=fWZYJ2RXeXGGmFXAW9CNnb2S6cGYKc_M=hUQyCng7KJBQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko <andriin@fb.com>, Kajol Jain <kjain@linux.ibm.com>, Andi Kleen <ak@linux.intel.com>, John Garry <john.garry@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>, Kim Phillips <kim.phillips@amd.com>, Paul Clarke <pc@us.ibm.com>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>li
List-Id: linux-perf-users.vger.kernel.org

On Fri, May 22, 2020 at 10:56:59AM -0700, Ian Rogers wrote:

SNIP

> >> >       #11 0x00000000004b6911 in cmd_test (argc=1, argv=0x7fffffffd7f0) at tests/builtin-test.c:772
> >> >       #12 0x00000000004e977b in run_builtin (p=0xa7eee8 <commands+552>, argc=3, argv=0x7fffffffd7f0) at perf.c:312
> >> >       #13 0x00000000004e99e8 in handle_internal_command (argc=3, argv=0x7fffffffd7f0) at perf.c:364
> >> >       #14 0x00000000004e9b2f in run_argv (argcp=0x7fffffffd64c, argv=0x7fffffffd640) at perf.c:408
> >> >       #15 0x00000000004e9efb in main (argc=3, argv=0x7fffffffd7f0) at perf.c:538
> >> >
> >> > attached patch fixes it for me, but I'm not sure this
> >> > should be necessary
> >>
> >> ... applying the patch below makes the segfault go away. Ian, Ack? I can
> >> fold it into the patch introducing the problem.
> >
> >
> > I suspect this patch is a memory leak. The underlying issue is likely the outstanding hashmap_clear fix in libbpf. Let me check.
> >
> > Thanks,
> > Ian
> 
> Tested:
> $ git checkout -b testing acme/tmp.perf/core
> $ make ...
> $ perf test 7
> 7: Simple expression parser                              : FAILED!
> $ git cherry-pick 6bca339175bf
> [acme-perf-expr-testing 4614bd252003] libbpf: Fix memory leak and
> possible double-free in hashmap__c

yep, it fixes the issue for me, but I see that under different commit number:

  229bf8bf4d91 libbpf: Fix memory leak and possible double-free in hashmap__clear

jirka

> lear
> Author: Andrii Nakryiko <andriin@fb.com>
> Date: Tue Apr 28 18:21:04 2020 -0700
> 1 file changed, 7 insertions(+)
> $ make ...
> $ perf test 7
> 7: Simple expression parser                              : Ok
> 
> I'd prefer we took the libbpf fix as initializing over the top of the
> hashmap will leak. This fix is in the tools/perf/util/hashmap.c.
> 
> Thanks,
> Ian
> 
> >> - Arnaldo
> >>
> >> > jirka
> >> >
> >> >
> >> > ---

SNIP
