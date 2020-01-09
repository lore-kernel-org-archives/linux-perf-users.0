From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 6/9] perf record: Support synthesizing cgroup events
Date: Thu, 9 Jan 2020 14:19:09 +0900
Message-ID: <CAM9d7cgn8Y9FbOHh0+5=8bg4vGACYHjbVuX0_cM-jqGv4cEh0Q@mail.gmail.com>
References: <20200107133501.327117-1-namhyung@kernel.org> <20200107133501.327117-7-namhyung@kernel.org>
 <20200108220851.GC12995@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200108220851.GC12995@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Jan 9, 2020 at 7:09 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jan 07, 2020 at 10:34:58PM +0900, Namhyung Kim wrote:
> > diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> > index 4e8ef1db0c94..5147d22b3bda 100644
> > --- a/tools/perf/util/cgroup.c
> > +++ b/tools/perf/util/cgroup.c
> > @@ -15,8 +15,7 @@ int nr_cgroups;
> >
> >  static struct rb_root cgroup_tree = RB_ROOT;
> >
> > -static int
> > -cgroupfs_find_mountpoint(char *buf, size_t maxlen)
> > +int cgroupfs_find_mountpoint(char *buf, size_t maxlen)
>
> out of scope of this change, but could this be added to api/fs/fs.c?
> it might need more checks then is currently supported, but would be
> nice to have it under same api as the rest

Makes sense, will try to move it.

Thanks
Namhyung
