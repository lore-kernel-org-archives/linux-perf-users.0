From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 6/9] perf record: Support synthesizing cgroup events
Date: Thu, 9 Jan 2020 16:51:23 +0900
Message-ID: <CAM9d7ci-LfDtjX-e343pUMeMB4BD+bbyduYW8LM0Pweus8yarA@mail.gmail.com>
References: <20200107133501.327117-1-namhyung@kernel.org> <20200107133501.327117-7-namhyung@kernel.org>
 <20200108222156.GE12995@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200108222156.GE12995@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Jan 9, 2020 at 7:22 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jan 07, 2020 at 10:34:58PM +0900, Namhyung Kim wrote:
>
> SNIP
>
> > +     closedir(d);
> > +     return ret;
> > +}
> > +
> > +int perf_event__synthesize_cgroups(struct perf_tool *tool,
> > +                                perf_event__handler_t process,
> > +                                struct machine *machine)
> > +{
> > +     union perf_event event;
> > +     char *cgrp_root;
> > +     size_t mount_len;  /* length of mount point in the path */
> > +     int ret = -1;
> > +
> > +     cgrp_root = malloc(PATH_MAX);
> > +     if (cgrp_root == NULL)
> > +             return -1;
> > +
>
> hum, we normally use bufs with PATH_MAX size on stack..
> is there some reason to use heap in here?

No specific reason, will change.

Thanks
Namhyung
