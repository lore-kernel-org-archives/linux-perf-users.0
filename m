From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: BoF on LPC 2019 : Linux Perf advancements for compute intensive
 and server systems
Date: Tue, 27 Aug 2019 09:48:02 +0200
Message-ID: <20190827074802.GA22896@krava>
References: <43216530-4410-6cc4-aa4a-51fa7e7c1b0c@linux.intel.com>
 <20190826135536.GA24801@kernel.org>
 <da687997-6280-2613-a389-f7b94c600c2b@linux.intel.com>
 <20190826175758.GH5447@tassilo.jf.intel.com>
 <20190826221021.GB21761@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190826221021.GB21761@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Andi Kleen <ak@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Kan Liang <kan.liang@linux.intel.com>, Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>, Song Liu <songliubraving@fb.com>, "Jin, Yao" <yao.jin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Kees Cook <keescook@chromium.org>, Jonatan Corbet <corbet@lwn.net>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Aug 26, 2019 at 07:10:21PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Aug 26, 2019 at 10:57:58AM -0700, Andi Kleen escreveu:
> > > 
> > > > 
> > > > All those are already merged, after long reviewing phases and lots of
> > > > testing, right?
> > > 
> > > Right. These changes now constitute parts of the Linux kernel source tree.
> > 
> > Might be better to focus on future areas that haven't been merged yet.
> 
> Agreed, we can have a initial, short report on what has been done to
> address these issues, and I think Alexey could take care of that, but
> then we should try and list here what else in addition to what Ian et
> all listed on their talk.
> 
> And perhaps even things that ammeliorate the problems they list there,
> i.e. Ian, Stephane, the things that Alexey listed were already
> tested/considered by you guys?

there's also ongoing work on adding threads to perf record:
  https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/#t

currently being stuck on me sending the perf_sesion changes

Alexey ran some initial benchmarks and it seems to perform nicely,
not sure we discussed the results on list thought

jirka
