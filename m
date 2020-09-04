From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 2/4] perf vendor events amd: Add ITLB Instruction Fetch
 Hits event for zen1
Date: Fri, 4 Sep 2020 16:19:12 -0300
Message-ID: <20200904191912.GF3753976@kernel.org>
References: <20200901220944.277505-1-kim.phillips@amd.com>
 <20200901220944.277505-2-kim.phillips@amd.com>
 <CAP-5=fW84gvGr+RxovDrFaRozHEY-_9mV2K-_bG04pmg8SJGvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP-5=fW84gvGr+RxovDrFaRozHEY-_9mV2K-_bG04pmg8SJGvw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Kim Phillips <kim.phillips@amd.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Vijay Thakkar <vijaythakkar@me.com>, Andi Kleen <ak@linux.intel.com>, John Garry <john.garry@huawei.com>, Kan Liang <kan.liang@linux.intel.com>, Yunfeng Ye <yeyunfeng@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>, Borislav Petkov <bp@suse.de>, Jon Grimm <jon.grimm@amd.com>, Martin Jambor <mjambor@suse.cz>, Michael Petlan <mpetlan@redhat.com>, William Cohen <wcohen@redhat.com>, Steph
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Sep 02, 2020 at 11:03:38PM -0700, Ian Rogers escreveu:
> On Tue, Sep 1, 2020 at 3:10 PM Kim Phillips <kim.phillips@amd.com> wrote:
> >
> > The ITLB Instruction Fetch Hits event isn't documented even in
> > later zen1 PPRs, but it seems to count correctly on zen1 hardware.
> >
> > Add it to zen1 group so zen1 users can use the upcoming IC Fetch Miss
> > Ratio Metric.
> >
> > The IF1G, 1IF2M, IF4K (Instruction fetches to a 1 GB, 2 MB, and 4K page)
> > unit masks are not added because unlike zen2 hardware, zen1 hardware
> > counts all its unit masks with a 0 unit mask according to the old
> > convention:
> >
> > zen1$ perf stat -e cpu/event=0x94/,cpu/event=0x94,umask=0xff/ sleep 1
> >
> >  Performance counter stats for 'sleep 1':
> >
> >            211,318      cpu/event=0x94/u
> >            211,318      cpu/event=0x94,umask=0xff/u
> >
> > Rome/zen2:
> >
> > zen2$ perf stat -e cpu/event=0x94/,cpu/event=0x94,umask=0xff/ sleep 1
> >
> >  Performance counter stats for 'sleep 1':
> >
> >                  0      cpu/event=0x94/u
> >            190,744      cpu/event=0x94,umask=0xff/u
> >
> > Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo
