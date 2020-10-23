From: Namhyung Kim <namhyung@gmail.com>
Subject: Re: [PATCH] perf trace: Segfault when trying to trace events by cgroup
Date: Fri, 23 Oct 2020 11:48:59 +0900
Message-ID: <CAM9d7cg3gNSA+yXqzUfJW-5M7D=aq43RUuo_Cg+f=xADk9h8VQ@mail.gmail.com>
References: <20201009064547.62047-1-sivanichkin@yandex-team.ru> <6A368965-ACB4-47CD-902C-0B910F6BEEE9@yandex-team.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6A368965-ACB4-47CD-902C-0B910F6BEEE9@yandex-team.ru>
To: Stanislav Ivanichkin <sivanichkin@yandex-team.ru>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>, linux-perf-users <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Hello,

On Tue, Oct 20, 2020 at 5:48 AM Stanislav Ivanichkin
<sivanichkin@yandex-team.ru> wrote:
>
> Hi,
>
> +linux-perf-users@
>
> Gentle ping for this patch
>
> Many Thanks
>
> --
> Stanislav Ivanichkin
>
> > On 9 Oct 2020, at 09:45, Stanislav Ivanichkin <sivanichkin@yandex-team.ru> wrote:
> >
> > # ./perf trace -e sched:sched_switch -G test -a sleep 1
> > perf: Segmentation fault
> > Obtained 11 stack frames.
> > ./perf(sighandler_dump_stack+0x43) [0x55cfdc636db3]
> > /lib/x86_64-linux-gnu/libc.so.6(+0x3efcf) [0x7fd23eecafcf]
> > ./perf(parse_cgroups+0x36) [0x55cfdc673f36]
> > ./perf(+0x3186ed) [0x55cfdc70d6ed]
> > ./perf(parse_options_subcommand+0x629) [0x55cfdc70e999]
> > ./perf(cmd_trace+0x9c2) [0x55cfdc5ad6d2]
> > ./perf(+0x1e8ae0) [0x55cfdc5ddae0]
> > ./perf(+0x1e8ded) [0x55cfdc5ddded]
> > ./perf(main+0x370) [0x55cfdc556f00]
> > /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xe6) [0x7fd23eeadb96]
> > ./perf(_start+0x29) [0x55cfdc557389]
> > Segmentation fault
> >
> > It happens because "struct trace" in option->value is passed to
> > parse_cgroups function instead of "struct evlist".
> >
> > Signed-off-by: Stanislav Ivanichkin <sivanichkin@yandex-team.ru>
> > Reviewed-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>

It seems we should add this too:
Fixes: 9ea42ba4411ac ("perf trace: Support setting cgroups as targets")

> > ---
> > tools/perf/builtin-trace.c | 9 ++++++---
> > 1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index bea461b6f937..cbc4de6840db 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -4651,9 +4651,12 @@ static int trace__parse_cgroups(const struct option *opt, const char *str, int u
> > {
> >       struct trace *trace = opt->value;
> >
> > -     if (!list_empty(&trace->evlist->core.entries))
> > -             return parse_cgroups(opt, str, unset);
> > -
> > +     if (!list_empty(&trace->evlist->core.entries)) {
> > +             struct option o = OPT_CALLBACK('G', "cgroup", &trace->evlist,
> > +                     "name", "monitor event in cgroup name only",
> > +                     parse_cgroups);

Just make it simple and clear what parse_cgroups() expects:

        struct option o = {
                .value = &trace->evlist,
        };

Or else, we can change parse_cgroups() to take evlist directly.
But it needs to change other callsites too.

Either is fine to me.

Thanks
Namhyung

> > +             return parse_cgroups(&o, str, unset);
> > +     }
> >       trace->cgroup = evlist__findnew_cgroup(trace->evlist, str);
> >
> >       return 0;
> > --
> > 2.17.1
> >
>
