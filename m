From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf record: Add support to collect callchains from
 kernel or user space only.
Date: Thu, 6 Jun 2019 16:46:14 +0200
Message-ID: <20190606144614.GC12056@krava>
References: <1559222962-22891-1-git-send-email-ufo19890607@gmail.com>
 <20190606142644.GA21245@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190606142644.GA21245@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: ufo19890607 <ufo19890607@gmail.com>, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, adrian.hunter@intel.com, wangnan0@huawei.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com
List-Id: linux-perf-users.vger.kernel.org

On Thu, Jun 06, 2019 at 11:26:44AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, May 30, 2019 at 02:29:22PM +0100, ufo19890607 escreveu:
> > From: yuzhoujian <yuzhoujian@didichuxing.com>
> > 
> > One can just record callchains in the kernel or user space with
> > this new options. We can use it together with "--all-kernel" options.
> > This two options is used just like print_stack(sys) or print_ustack(usr)
> > for systemtap.
> > 
> > Show below is the usage of this new option combined with "--all-kernel"
> > options.
> > 	1. Configure all used events to run in kernel space and just
> > collect kernel callchains.
> > 	$ perf record -a -g --all-kernel --kernel-callchains
> > 	2. Configure all used events to run in kernel space and just
> > collect user callchains.
> > 	$ perf record -a -g --all-kernel --user-callchains
> > 
> > Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
> > ---
> >  tools/perf/Documentation/perf-record.txt | 6 ++++++
> >  tools/perf/builtin-record.c              | 4 ++++
> >  tools/perf/perf.h                        | 2 ++
> >  tools/perf/util/evsel.c                  | 4 ++++
> >  4 files changed, 16 insertions(+)
> > 
> > diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> > index de269430720a..b647eb3db0c6 100644
> > --- a/tools/perf/Documentation/perf-record.txt
> > +++ b/tools/perf/Documentation/perf-record.txt
> > @@ -490,6 +490,12 @@ Configure all used events to run in kernel space.
> >  --all-user::
> >  Configure all used events to run in user space.
> >  
> > +--kernel-callchains::
> > +Collect callchains from kernel space.
> 
> Ok, changing this to:
> 
> Collect callchains only from kernel space. I.e. this option sets
> perf_event_attr.exclude_callchain_user to 1,
> perf_event_attr.exclude_callchain_kernel to 0.
> 
> > +
> > +--user-callchains::
> > +Collect callchains from user space.
> 
> And this one to:
> Collect callchains only from user space. I.e. this option sets
> 
> perf_event_attr.exclude_callchain_kernel to 1,
> perf_event_attr.exclude_callchain_user to 0.
> 
> 
> So that the user don't try using:
> 
>     pref record --user-callchains --kernel-callchains
> 
> expecting to get both user and kernel callchains and instead gets
> nothing.

good catch.. we should add the logic to keep both (default)
in this case.. so do nothing ;-)

jirka
