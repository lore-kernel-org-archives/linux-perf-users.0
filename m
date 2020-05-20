From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 3/7] perf metricgroup: Delay events string creation
Date: Wed, 20 May 2020 17:34:09 -0300
Message-ID: <20200520203409.GA26877@kernel.org>
References: <20200520072814.128267-1-irogers@google.com>
 <20200520072814.128267-4-irogers@google.com>
 <20200520131412.GK157452@krava>
 <CAP-5=fXHRiahLZjQHcFiWW=zdXc7r+=WdMpzeCj-+xPcqB2khQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP-5=fXHRiahLZjQHcFiWW=zdXc7r+=WdMpzeCj-+xPcqB2khQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko <andriin@fb.com>, Kajol Jain <kjain@linux.ibm.com>, Andi Kleen <ak@linux.intel.com>, John Garry <john.garry@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>, Kim Phillips <kim.phillips@amd.com>, Paul Clarke <pc@us.ibm.com>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, linux-perf-users
List-Id: linux-perf-users.vger.kernel.org

Em Wed, May 20, 2020 at 11:22:22AM -0700, Ian Rogers escreveu:
> On Wed, May 20, 2020 at 6:14 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >                               break;
> > >               }
> > >       }
> > > +     if (!ret) {
> >
> > could you please do instead:
> >
> >         if (ret)
> >                 return ret;
> >
> > so the code below cuts down one indent level and you
> > don't need to split up the lines
> 
> Done, broken out as a separate patch in v2:
> https://lore.kernel.org/lkml/20200520182011.32236-3-irogers@google.com/

Jiri, was this the only issue with this patchkit? I've merged already
the first one, that you acked.

- Arnaldo
