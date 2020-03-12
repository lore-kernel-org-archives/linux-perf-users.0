From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf tools: add support for lipfm4
Date: Thu, 12 Mar 2020 11:03:49 +0100
Message-ID: <20200312100349.GB254105@krava>
References: <20200310185003.57344-1-irogers@google.com>
 <20200310195915.GA1676879@tassilo.jf.intel.com>
 <CABPqkBRQo=bEOiCFGFjwcM8TZaXMFyaL7o1hcFd6Bc3w+LhJQA@mail.gmail.com>
 <20200311161320.GA254105@krava>
 <CAP-5=fXYMTT7-iiaacO1VF0rRSO6t9W0a5edkiEwdZMYBcrtpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP-5=fXYMTT7-iiaacO1VF0rRSO6t9W0a5edkiEwdZMYBcrtpQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Stephane Eranian <eranian@google.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Igor Lubashev <ilubashe@akamai.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiwei
List-Id: linux-perf-users.vger.kernel.org

On Wed, Mar 11, 2020 at 12:32:26PM -0700, Ian Rogers wrote:
> On Wed, Mar 11, 2020 at 9:13 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Tue, Mar 10, 2020 at 02:39:23PM -0700, Stephane Eranian wrote:
> > > On Tue, Mar 10, 2020 at 12:59 PM Andi Kleen <ak@linux.intel.com> wrote:
> > > >
> > > > On Tue, Mar 10, 2020 at 11:50:03AM -0700, Ian Rogers wrote:
> > > > > This patch links perf with the libpfm4 library.
> > > > > This library contains all the hardware event tables for all
> > > > > processors supported by perf_events. This is a helper library
> > > > > that help convert from a symbolic event name to the event
> > > > > encoding required by the underlying kernel interface. This
> > > > > library is open-source and available from: http://perfmon2.sf.net.
> > > >
> > > > For most CPUs the builtin perf JSON event support should make
> > > > this redundant.
> > > >
> > > We decided to post this patch to propose an alternative to the JSON
> > > file approach. It could be an option during the build.
> > > The libpfm4 library has been around for 15 years now. Therefore, it
> > > supports a lot of processors core and uncore and it  is very portable.
> > > The key value add I see is that this is a library that can be, and has
> > > been, used by tool developers directly in their apps. It can
> > > work with more than Linux perf_events interface. It is not tied to the
> > > interface. It has well defined and documented entry points.
> > > We do use libpfm4 extensively at Google in both the perf tool and
> > > applications. The PAPI toolkit also relies on this library.
> > >
> > > I don't see this as competing with the JSON approach. It is just an
> > > option I'd like to offer to users especially those familiar
> > > with it in their apps.
> >
> > I dont mind having it, in fact I found really old email where I'm
> > asking Peter about that ;-) and he wasn't very keen about that:
> >   https://lore.kernel.org/lkml/1312806326.10488.30.camel@twins/
> >
> > not sure what was the actual reason at that time and if anything
> > changed since.. Peter?
> >
> > btw I can't apply even that v2 on latest Arnaldo's branch
> >
> > jirka
> 
> Thanks Jiri,
> 
> the patches were done on tip.git/master, perhaps there is a conflict
> with the Documents Makefile due to adding better man page dates? I'll
> try to repro building on
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/ on the
> perf/core branch unless you  have a different suggestion? I also

yes, it's perf/core

jirka
