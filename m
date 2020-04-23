From: Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2 00/11] perf metric fixes and test
Date: Thu, 23 Apr 2020 07:31:25 -0700
Message-ID: <CAP-5=fUO5sA8g2qv=Bg5LSSbG3nnhm57cBR7PsraH9+thph5qQ@mail.gmail.com>
References: <20200422220430.254014-1-irogers@google.com> <20200423112825.GD1136647@krava>
 <1dd2e280-d711-2dda-61b1-b81609af6467@linux.intel.com> <20200423140249.GA1199027@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200423140249.GA1199027@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: "Jin, Yao" <yao.jin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Song Liu <songliubraving@fb.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Paul Clarke <pc@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Apr 23, 2020 at 7:03 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Apr 23, 2020 at 09:44:24PM +0800, Jin, Yao wrote:
> > Hi Jiri,
> >
> > On 4/23/2020 7:28 PM, Jiri Olsa wrote:
> > > On Wed, Apr 22, 2020 at 03:04:19PM -0700, Ian Rogers wrote:
> > > > Add a test that all perf metrics (for your architecture) are
> > > > parsable. Fix bugs in the expr parser and in x86 metrics. Untested on
> > > > architectures other than x86.
> > > >
> > > > v2 adds Fixes tags to commit messages for when broken metrics were
> > > >    first added. Adds a debug warning for division by zero in expr, and
> > > >    adds a workaround for id values in the expr test necessary for
> > > >    powerpc. It also fixes broken power8 and power9 metrics.
> > >
> > > looks good to me
> > >
> > > Jin Yao, is there a metric that's not working for you with this patchset
> > > applied?
> > >
> > > thanks,
> > > jirka
> > >
> >
> > Let me look for a CLX for testing, but maybe need some time.
> >
> > BTW, suppose this patchset can work well, does it mean we will change the
> > json file format in future?
> >
> > For example,
> >
> > before:
> > cha@event\\=0x36\\\\\\
> >
> > after:
> > cha@event\\=0x36\\
> >
> > "\\\\" are removed.
> >
> > If so, we need to change our event generation script.
>
> ok, maybe I got the wrong idea that the extra \\\\ were just
> superfluous, what was the actual error there? and what's the
> reason for that many '\' in there?

I believe they are superfluous and break even before the flex change.
I commented on it here with a reproduction of a parse events error on
skylake:
https://lore.kernel.org/lkml/CAP-5=fUnWAycQehCJ9=btquV2c3DVDX+tTEc85H8py9Kfehq4w@mail.gmail.com/

Fixing the script that generates this would be great! With the test
landed it should be much harder for this to be broken in the future.

Thanks,
Ian


> jirka
>
