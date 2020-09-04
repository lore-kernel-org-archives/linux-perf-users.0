From: Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 3/4] perf vendor events amd: Add recommended events
Date: Thu, 3 Sep 2020 22:48:15 -0700
Message-ID: <CAP-5=fW8zLRgxXgY-CFUnU0HiiZMKhJ6b1znMxT8WeLO5Z-wZA@mail.gmail.com>
References: <20200901220944.277505-1-kim.phillips@amd.com> <20200901220944.277505-3-kim.phillips@amd.com>
 <CAP-5=fVwuKOACD++6UyBVW_fgbTXrOwuOJHSYenD87dwVJk0OA@mail.gmail.com> <7a0b893d-8f65-6423-3818-5dafc880dca1@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7a0b893d-8f65-6423-3818-5dafc880dca1@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kim Phillips <kim.phillips@amd.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Vijay Thakkar <vijaythakkar@me.com>, Andi Kleen <ak@linux.intel.com>, John Garry <john.garry@huawei.com>, Kan Liang <kan.liang@linux.intel.com>, Yunfeng Ye <yeyunfeng@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>, Borislav Petkov <bp@suse.de>, Jon Grimm <jon.grimm@amd.com>, Martin Jambor <mjambor@suse.cz>, Michael Petlan <mpetlan@redhat.com>, William Cohen <wcohen@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Sep 3, 2020 at 11:27 AM Kim Phillips <kim.phillips@amd.com> wrote:
>
> On 9/3/20 1:19 AM, Ian Rogers wrote:
> > On Tue, Sep 1, 2020 at 3:10 PM Kim Phillips <kim.phillips@amd.com> wrote:
> >> The nps1_die_to_dram event may need perf stat's --metric-no-group
> >> switch if the number of available data fabric counters is less
> >> than the number it uses (8).
> >
> > These are really excellent additions! Does:
> > "MetricConstraint": "NO_NMI_WATCHDOG"
> > solve the grouping issue? Perhaps the MetricConstraint needs to be
> > named more generically to cover this case as it seems sub-optimal to
> > require the use of --metric-no-group.
>
> That metric uses data fabric (DFPMC/amd_df) events, not Core PMC
> events, which the watchdog uses, so NO_NMI_WATCHDOG wouldn't have
> an effect.  The event is defined as an approximation anyway.
>
> I'll have to get back to you on the other items.
>
> Thanks for your review!

NP, more nits than anything else.

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Kim
