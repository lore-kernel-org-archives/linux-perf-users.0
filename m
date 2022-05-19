Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B18C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 May 2022 00:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiESAMJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 18 May 2022 20:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiESAMJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 May 2022 20:12:09 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF1D6D4C5
        for <linux-perf-users@vger.kernel.org>; Wed, 18 May 2022 17:12:07 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j24so4897156wrb.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 May 2022 17:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UMPbP108zmSmA79Ex9wOSSlfwQ3gKV5yePWPwnhsNUE=;
        b=CZIATAB/0KFjkqPCvEeMpBUyrMg4zlqj1ou6BVWIKIT5WCrF+ujf6VoTo0tPGwLysr
         B1YZVK0hAHI91CHUoy+PjNPdiRsVNX8Q89XE0YqEsCUmiz7EkdDaZRkFw8Ghcl8WYyl3
         oVY+Gs/ki10EORI281uRnsBa6mECTnB7YiKNP+RKWqvevdzFte2G/7w6aAKGsN94Jk3h
         8e04BI8hBU3h+zX5deKLjYuJMk2ZpOk0OeyTpyfy4JXsjYcb/wpjngXE9UC5ZxuIkxB+
         ei9D2jkyMKsjNecYrLtI87Bc3x8RXUXUAG1P1o/2dO0KpDuZo8W0hdf1xObo6J2yGq4s
         7bEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UMPbP108zmSmA79Ex9wOSSlfwQ3gKV5yePWPwnhsNUE=;
        b=ltNH/hXXSlAiAx3hK5wGPBDhcW/dyioDi/MO8Lmi/Pag6nurw7KrZG5hITg0XIIPdG
         8cxYru6iaVPwXjLYMDcVsrlD7TOMxIh5y2OEu7rJqF5RxU6Ht5yZsu+esJ6/xjFysPEl
         A63D71mjrjzfQljO8PmqakkgLRkUL5aK4wH6Wm3SUWp4tCNU+UZ9/RFlEzpkLCapOeIh
         2ofqbdgJp5eyPj8MaInioGdAkZP80q/TqFojqxgVdfXyzjgzLHSOMNH/qfQ6DoPf21bB
         rWWH89NR+n+ToBWRoQ1PfstOUM3SlXNnwtRVg/85trpGBnsj7EtYyz0P81KDbNH3Q2VL
         1tWw==
X-Gm-Message-State: AOAM533ex80FuPo7bCQf5ak2OPrF34LkE6fUwXP0/HZZMT/SlftUjKNo
        m9NpaFy8z3VGQCWp2px5LAZygJm1GZoPig5W1az9ol1XdI5mzYAf
X-Google-Smtp-Source: ABdhPJwOHSbyvwC/tfB91xKeOCXDWgEzyg1m/nATbbm87LtWPe35QpvEyo2M/fWV5oDy4klCnlgT/o6QLT5+7a4enjg=
X-Received: by 2002:adf:d1e9:0:b0:20c:6c76:14d5 with SMTP id
 g9-20020adfd1e9000000b0020c6c7614d5mr1649125wrd.375.1652919125332; Wed, 18
 May 2022 17:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.20.2205180047230.29735@Diego> <CAP-5=fU=kydiXW2Q_zc21dywD-wPWtwA8-dvcnu-e0VzOch_Hg@mail.gmail.com>
 <alpine.LRH.2.20.2205182311190.29735@Diego>
In-Reply-To: <alpine.LRH.2.20.2205182311190.29735@Diego>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 18 May 2022 17:11:52 -0700
Message-ID: <CAP-5=fX06ZBikci7BUR=NgbZg14mkdt_ccju5KRb1fOYDtbR9w@mail.gmail.com>
Subject: Re: perf stat report segfaults
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     Arnaldo de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 18, 2022 at 2:47 PM Michael Petlan <mpetlan@redhat.com> wrote:
>
> On Wed, 18 May 2022, Ian Rogers wrote:
> > On Wed, May 18, 2022, 12:41 AM Michael Petlan <mpetlan@redhat.com> wrote:
> >       Hello Ian.
> >
> >       I have been rebasing perf in RHEL to v5.17 and I have hit the following
> >       problem:
> >
> >       # perf stat record -- ls
> >       [...]
> >       # perf stat report
> >       Segmentation fault (core dumped)
> >
> >       Investigation led me to your patch:
> >
> >       commit 7ac0089d138f80dcd7ba8ca368a9b2bdfe780b16
> >       Author: Ian Rogers <irogers@google.com>
> >       Date: Tue Jan 4 22:13:38 2022 -0800
> >
> >         perf evsel: Pass cpu not cpu map index to synthesize
> >
> >       This results in that perf_event__synthesize_stat()'s second argument
> >       is -1 instead of 0 before.
> >
> >       With that, the cpu field is stored as ff ff ff ff, as you can see in the
> >       raw report:
> >
> >       -1 -1 0x630 [0x30]: PERF_RECORD_STAT
> >       ... id 9597, cpu -1, thread 1
> >       ... value 3431216, enabled 3431216, running 3431216
> >       : unhandled!
> >
> >       0x660 [0x30]: event: 76
> >       .
> >       . ... raw event: size 48 bytes
> >       .  0000:  00 00 00 4c 00 00 00 30 00 00 00 00 00 00 25 7e  ...L...0......%~
> >       .+>0010:  ff ff ff ff 00 00 00 00 00 00 00 00 00 00 00 36  ...............6
> >       .| 0020:  00 00 00 00 01 44 6e 89 00 00 00 00 01 44 6e 89  .....Dn......Dn.
> >        |
> >        here
> >
> >       This value is later loaded and used as an index to xyarray in libperf, which
> >       causes the segfault.
> >
> >
> > Thanks for reporting this and sorry for the breakage! This kind of problem is something I've been trying  to fix. Basically perf has cpu
> > maps that are sorted arrays of CPU numbers. For a counter that is available on every CPU this gets reported as say [0,1,2,3] on a 4 CPU
> > system. Some counters are available on fewer CPUs, for example my 2 socket skylake machine has a memory controller counter with a cpu map
> > of [0,18]. The indices into the CPU map are more densely encoded than just using the CPU number, so rather than have arrays (for things
> > like file descriptors, saved values, etc.) sized by the number of CPUs they are sized by the CPU map size and indexed using the CPU map
> > index. The problem I've been trying to fix is when the code has inadvertently swapped the two values. This can work if the CPU map has an
> > entry for every CPU in the system, but fails for say my Skylake memory controller.
>
> OK. Let's summarize what we are trying to store in the PERF_RECORD_STAT record.
>
> I'd guess it is something like "event ABC (i.e. cpu-cycles) has been enabled
> on "any" cpu (-1) and gave a value XYZ"
>
> When I run `perf stat record -a -e cpu-cycles -- sleep 2`, I am getting `nproc`
> entries of PERF_RECORD_STAT type each has a valid cpu number from 0 to 7 (my
> machine has 8 cpus). Probably, when all the values are put together, I get this:
>
> $ ./perf stat report
>
>  Performance counter stats for '/home/Michael/Documents/SOURCES/acme/linux/tools/perf/perf stat record -a -e cpu-cycles -- sleep 2':
>
>      2,907,751,861      cpu-cycles
>
>        2.000957416 seconds time elapsed
>
> I suppose that perf stat report when reading the perf.data, creates an xyarray
> with all the data in and then by indexing by 0-7, it obtains the data.
>
> This seems to make sense pretty much.
>
> ...
>
> However, with "any" value (-1), which means "trace process `ls`, no matter which
> cpu it gets scheduled on", we have the problem...
>
> The data is stored at index 0 in xyarray, and the same index it should be read
> from.
>
> From this point of view, my "if (cpu == -1) cpu = 0;" looks fine, just unclear.
>
> Am I right?

Yep. I wrote this which is what I was trying to imply by my comments:

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 4a5f3b8ff820..a77c28232298 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -474,9 +474,10 @@ int perf_stat_process_counter(struct
perf_stat_config *config,
int perf_event__process_stat_event(struct perf_session *session,
                                  union perf_event *event)
{
-       struct perf_counts_values count;
+       struct perf_counts_values count, *ptr;
       struct perf_record_stat *st = &event->stat;
       struct evsel *counter;
+       int cpu_map_idx;

       count.val = st->val;
       count.ena = st->ena;
@@ -487,8 +488,18 @@ int perf_event__process_stat_event(struct
perf_session *session,
               pr_err("Failed to resolve counter for stat event.\n");
               return -EINVAL;
       }
-
-       *perf_counts(counter->counts, st->cpu, st->thread) = count;
+       cpu_map_idx = perf_cpu_map__idx(evsel__cpus(counter), (struct
perf_cpu){.cpu = st->cpu});
+       if (cpu_map_idx == -1) {
+               pr_err("Invalid CPU %d for event %s.\n", st->cpu,
evsel__name(counter));
+               return -EINVAL;
+       }
+       ptr = perf_counts(counter->counts, cpu_map_idx, st->thread);
+       if (ptr == NULL) {
+               pr_err("Failed to find perf count for CPU %d thread %d
on event %s.\n",
+                       st->cpu, st->thread, evsel__name(counter));
+               return -EINVAL;
+       }
+       *ptr = count;
       counter->supported = true;
       return 0;
}

Just to note that the threads are similar to CPUs and the logic here
looks similarly broken. The thread map code needs a clean up like the
cpu map. Without/with the change above I can repro. the failure and
that this is a fix.

> >
> > In your example here the CPU value of -1 is a special "any" CPU marker that is described in the perf_event_open man page. When trying to
> > work out the intent of the code in fixing CPU vs index I'd push the value through the API and try to use an intention revealing name, so
> > typically cpu_map_idx. In this case this appears to have been done on the writing side but not on the reading side.
> >
> >       This is my "hotfix":
> >
> >       diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> >       index 817a2de264b4..b6ca193ff972 100644
> >       --- a/tools/perf/util/stat.c
> >       +++ b/tools/perf/util/stat.c
> >       @@ -472,9 +472,10 @@ int perf_stat_process_counter(struct perf_stat_config *config,
> >        int perf_event__process_stat_event(struct perf_session *session,
> >                                          union perf_event *event)
> >        {
> >       -       struct perf_counts_values count;
> >       +  struct perf_counts_values count, *ptr;
> >               struct perf_record_stat *st = &event->stat;
> >               struct evsel *counter;
> >       +       int cpu = st->cpu;
> >
> >               count.val = st->val;
> >               count.ena = st->ena;
> >       @@ -486,7 +487,9 @@ int perf_event__process_stat_event(struct perf_session *session,
> >                       return -EINVAL;
> >               }
> >
> >       -       *perf_counts(counter->counts, st->cpu, st->thread) = count;
> >       +       if (cpu == -1) cpu = 0;
> >       +       ptr = perf_counts(counter->counts, cpu, st->thread);
> >       +       if (ptr) *ptr = count;
> >               counter->supported = true;
> >               return 0;
> >        }
> >
> >
> >       It needs to be reworked, but checking whether perf_counts() returns
> >       not-NULL pointer is necessary anyway.
> >
> >       My question here is what the -1 actually means and whether I can simply
> >       do "if (cpu == -1) cpu = 0;", since the data lies on "offset" 0 anyway,
> >       even when it's recorded by perf with your patch...
> >
> >
> > So I'd rather this wasn't fixed this way. The "cpu" here is really a cpu_map_idx, we need to work backward to make sure that is the case.
> > To try to make this safer I created a struct perf_cpu to disambiguate indices from CPU values. When we load the -1 from the file we need
> > to turn it into an index using the cpu map. As the array is sorted the index will always be 0, but it would be nicer to use
> > perf_cpu_map__idx [1] to show we're translating from what to what and how it relates to a particular cpu map.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/include/internal/cpumap.h?h=perf/core#n27
>
> OK, so instead of
>
>   if (cpu == -1) cpu = 0;
>
> we might use something like
>
>   int cpu = perf_cpu_map__idx();
>
> How the perf_cpu_map__idx() args are specified?
>
> And then continue with:
>
>   ptr = perf_counts(counter->counts, cpu, st->thread);
>   if (ptr != NULL)
>   {
>     *ptr = count;
>         counter->supported = true;
>         return 0;
>   }
>   return -EINVAL;
>
> The NULL check instead of Jiri Olsa's oneliner
> *perf_counts(counter->counts, st->cpu, st->thread) = count;
> ... is needed in my opinion, just because perf_counts() function
> *can* return NULL.

Agreed, there's all manner of potential corruption and the test is
cheap. I incorporated it into my variant of the fix above.

> >
> >       I think the -1 comes from perf_event_open syscall, where cpu == -1 means
> >       all cpus. Am I right?
> >
> >
> > Yep, I'm trying to distinguish "all" from "any". On a 4 CPU system all would be [0, 1, 2, 3] while any would be [-1].
> >
> >       In your opinion, what should be done to fix this problem the best way?
> >
> >
> > Notes above but I'll also try to take a look at this using your very simple reproducer (which should definitely be a test).
>
> ... which is a test for a quite long time.
>
> Some years ago, I wrote a perf testsuite here:
> https://github.com/rfmvh/perftool-testsuite
> (still updated and developed)
>
> However, upstreaming this testsuite to Linus' repo failed two times, so
> I've given up.

Eek, would love to fix this. I didn't know of this testsuite, I
routinely run perf-test and Vince Weaver's tests:
https://github.com/deater/perf_event_tests
Although, perf-test is my go to. I know I've refactored a bunch of the
test stuff, but your tests look like they would mainly live in the
shell tests. Could you rebase and re-send?

> The problem with this testsuite is that very few people outside Red Hat
> actually use it. But I think it'd deserve to be run for upstream perf
> before merging bigger patches too.

100%.

> It's a pity, since I think the test coverage of the testsuite is quite
> wide nowadays.
>
> If you want to run it, just clone the repo, cd to base_stat and run
> ./test_record_report.sh
>
> Requirements for the testsuite are simple -- perl, gcc, gcc-c++, bc
> and bash...

I'll try to play around when I have a bit more time. I want to make
sure all uses of perf_counts are with an index and not CPU. I'll send
the fix above along with other related perf_counts fixes.

Thanks,
Ian

> Thank you for your answer and looking at it.
> Michael
>
> >
> > Thanks,
> > Ian
> >
> >       Thank you.
> >       Michael
> >
> >
> >
