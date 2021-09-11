Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B5AC433EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 11 Sep 2021 19:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92A206108B
	for <linux-perf-users@archiver.kernel.org>; Sat, 11 Sep 2021 19:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbhIKTLg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 11 Sep 2021 15:11:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233412AbhIKTLf (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 11 Sep 2021 15:11:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88DA6610A3;
        Sat, 11 Sep 2021 19:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631387422;
        bh=3aQ1dPvmq5e4fEjLwL0tUxMhP5eHt4VNnDk2o9/eMow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q5GNEu3AFDSs3c2PvEuxQmOEJK28pu5uaien+PGu4O76tbWBa5JnTLc8BxPdisz5C
         c9804CAOsYA+aAfda5tXkIZhsMlnqk+ZFqyxJ1gydvcDSpPUg0MhZOwfS+wNrWIofK
         ga7KyrB4Zwvf2InzffeFGUi5izdWuVFtDDFMpZ1oE/mEQZ3ubzIXR6nwxmaoEERLBH
         tTAFDuDSg1iIc2aR2DgJnRy/7e+aoI3gkb5UlwcovkcFiw2wV7F50tJwb+zjq/bALL
         i8m4sV6F4L8x/gIBnNJh6ih7zhrQFNACWnJ2C8zFP+illWwzT+N5FAeF9hv3qCnDjJ
         tuRFNrPeofvwg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 096904038F; Sat, 11 Sep 2021 16:10:20 -0300 (-03)
Date:   Sat, 11 Sep 2021 16:10:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v1 25/37] perf evsel: move event open in
 evsel__open_cpu to separate function
Message-ID: <YTz/HBuosvqOkvYE@kernel.org>
References: <cover.1629490974.git.rickyman7@gmail.com>
 <74ac2eea14f45b2cbecffb509dd5f3cd523d4a9b.1629490974.git.rickyman7@gmail.com>
 <YS6JBBW3d4pmcy/U@kernel.org>
 <9506b14fe2965e4145c034715eb10e02f2137f7b.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9506b14fe2965e4145c034715eb10e02f2137f7b.camel@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Sep 03, 2021 at 11:52:18PM +0200, Riccardo Mancini escreveu:
> Hi Arnaldo,
> 
> thanks for your review and your suggestions, and also for the PRIu64 patch.
> 
> On Tue, 2021-08-31 at 16:54 -0300, Arnaldo Carvalho de Melo wrote:
> > Em Sat, Aug 21, 2021 at 11:19:31AM +0200, Riccardo Mancini escreveu:
> > > This is the final patch splitting evsel__open_cpu.
> > > This patch moves the entire loop code to a separate function, to be
> > > reused for the multithreaded code.
> > 
> > Are you going to use that 'enum perf_event_open_err' somewhere else?
> > I.e. is there a need to expose it in evsel.h?
> 
> Yes, in the next patch (26/37). It's being used to expose a function that just
> does the perf_event_open calls for an evsel. It needs to return such structure
> to provide information about the error (which return code, at which thread).
> 
> > 
> > I'm stopping at this patch to give the ones I merged so far some
> > testing, will now push it to tmp.perf/core.
> 
> I checked tmp.perf/core and it looks good to me.
> I also did some additional tests to check that fallback mechanisms where
> working:
> 
> check missing pid being ignored (rerun until warning is shown)
> $ sudo ./perf bench internals evlist-open-close -i10 -u $UID
> 
> check that weak group fallback is working
> $ sudo ./perf record -e '{cycles,cache-misses,cache-
> references,cpu_clk_unhalted.thread,cycles,cycles,cycles}:W' 
> 
> check that precision_ip fallback is working:
> edited perf-sys.h to make sys_perf_event_open fail if precision_ip > 2
> $ sudo ./perf record -e '{cycles,cs}:P'
> 
> 
> I've also run perf-test on my machine and it's passing too.
> I'm encounteirng one fail on the "BPF filter" test (42), which is present also
> in perf/core, so it should not be related to this patch.

Thanks! I'll try to resume work on it as soon as I have the plumbers
talk ready :-)

- Arnaldo
 
> Thanks,
> Riccardo
> 
> > 
> > - Arnaldo
> >  
> > > Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> > > ---
> > >  tools/perf/util/evsel.c | 142 ++++++++++++++++++++++++----------------
> > >  tools/perf/util/evsel.h |  12 ++++
> > >  2 files changed, 99 insertions(+), 55 deletions(-)
> > > 
> > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > index 2e95416b8320c6b9..e41f55a7a70ea630 100644
> > > --- a/tools/perf/util/evsel.c
> > > +++ b/tools/perf/util/evsel.c
> > > @@ -1945,6 +1945,82 @@ bool evsel__increase_rlimit(enum rlimit_action
> > > *set_rlimit)
> > >         return false;
> > >  }
> > >  
> > > +static struct perf_event_open_result perf_event_open(struct evsel *evsel,
> > > +                                       pid_t pid, int cpu, int thread,
> > > +                                       struct perf_cpu_map *cpus,
> > > +                                       struct perf_thread_map *threads)
> > > +{
> > > +       int fd, group_fd, rc;
> > > +       struct perf_event_open_result res;
> > > +
> > > +       if (!evsel->cgrp && !evsel->core.system_wide)
> > > +               pid = perf_thread_map__pid(threads, thread);
> > > +
> > > +       group_fd = get_group_fd(evsel, cpu, thread);
> > > +
> > > +       test_attr__ready();
> > > +
> > > +       pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags
> > > %#lx",
> > > +                       pid, cpus->map[cpu], group_fd, evsel->open_flags);
> > > +
> > > +       fd = sys_perf_event_open(&evsel->core.attr, pid, cpus->map[cpu],
> > > +                               group_fd, evsel->open_flags);
> > > +
> > > +       FD(evsel, cpu, thread) = fd;
> > > +       res.fd = fd;
> > > +
> > > +       if (fd < 0) {
> > > +               rc = -errno;
> > > +
> > > +               pr_debug2_peo("\nsys_perf_event_open failed, error %d\n",
> > > +                               rc);
> > > +               res.rc = rc;
> > > +               res.err = PEO_FALLBACK;
> > > +               return res;
> > > +       }
> > > +
> > > +       bpf_counter__install_pe(evsel, cpu, fd);
> > > +
> > > +       if (unlikely(test_attr__enabled)) {
> > > +               test_attr__open(&evsel->core.attr, pid,
> > > +                       cpus->map[cpu], fd,
> > > +                       group_fd, evsel->open_flags);
> > > +       }
> > > +
> > > +       pr_debug2_peo(" = %d\n", fd);
> > > +
> > > +       if (evsel->bpf_fd >= 0) {
> > > +               int evt_fd = fd;
> > > +               int bpf_fd = evsel->bpf_fd;
> > > +
> > > +               rc = ioctl(evt_fd,
> > > +                               PERF_EVENT_IOC_SET_BPF,
> > > +                               bpf_fd);
> > > +               if (rc && errno != EEXIST) {
> > > +                       pr_err("failed to attach bpf fd %d: %s\n",
> > > +                               bpf_fd, strerror(errno));
> > > +                       res.rc = -EINVAL;
> > > +                       res.err = PEO_ERROR;
> > > +                       return res;
> > > +               }
> > > +       }
> > > +
> > > +       /*
> > > +        * If we succeeded but had to kill clockid, fail and
> > > +        * have evsel__open_strerror() print us a nice error.
> > > +        */
> > > +       if (perf_missing_features.clockid ||
> > > +               perf_missing_features.clockid_wrong) {
> > > +               res.rc = -EINVAL;
> > > +               res.err = PEO_ERROR;
> > > +               return res;
> > > +       }
> > > +
> > > +       res.rc = 0;
> > > +       res.err = PEO_SUCCESS;
> > > +       return res;
> > > +}
> > > +
> > >  static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
> > >                 struct perf_thread_map *threads,
> > >                 int start_cpu, int end_cpu)
> > > @@ -1952,6 +2028,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct
> > > perf_cpu_map *cpus,
> > >         int cpu, thread, nthreads;
> > >         int pid = -1, err, old_errno;
> > >         enum rlimit_action set_rlimit = NO_CHANGE;
> > > +       struct perf_event_open_result peo_res;
> > >  
> > >         err = __evsel__prepare_open(evsel, cpus, threads);
> > >         if (err)
> > > @@ -1979,67 +2056,22 @@ static int evsel__open_cpu(struct evsel *evsel, struct
> > > perf_cpu_map *cpus,
> > >         for (cpu = start_cpu; cpu < end_cpu; cpu++) {
> > >  
> > >                 for (thread = 0; thread < nthreads; thread++) {
> > > -                       int fd, group_fd;
> > >  retry_open:
> > >                         if (thread >= nthreads)
> > >                                 break;
> > >  
> > > -                       if (!evsel->cgrp && !evsel->core.system_wide)
> > > -                               pid = perf_thread_map__pid(threads, thread);
> > > -
> > > -                       group_fd = get_group_fd(evsel, cpu, thread);
> > > -
> > > -                       test_attr__ready();
> > > -
> > > -                       pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d 
> > > group_fd %d  flags %#lx",
> > > -                               pid, cpus->map[cpu], group_fd, evsel-
> > > >open_flags);
> > > +                       peo_res = perf_event_open(evsel, pid, cpu, thread,
> > > cpus,
> > > +                                               threads);
> > >  
> > > -                       fd = sys_perf_event_open(&evsel->core.attr, pid, cpus-
> > > >map[cpu],
> > > -                                               group_fd, evsel->open_flags);
> > > -
> > > -                       FD(evsel, cpu, thread) = fd;
> > > -
> > > -                       if (fd < 0) {
> > > -                               err = -errno;
> > > -
> > > -                               pr_debug2_peo("\nsys_perf_event_open failed,
> > > error %d\n",
> > > -                                         err);
> > > +                       err = peo_res.rc;
> > > +                       switch (peo_res.err) {
> > > +                       case PEO_SUCCESS:
> > > +                               set_rlimit = NO_CHANGE;
> > > +                               continue;
> > > +                       case PEO_FALLBACK:
> > >                                 goto try_fallback;
> > > -                       }
> > > -
> > > -                       bpf_counter__install_pe(evsel, cpu, fd);
> > > -
> > > -                       if (unlikely(test_attr__enabled)) {
> > > -                               test_attr__open(&evsel->core.attr, pid, cpus-
> > > >map[cpu],
> > > -                                               fd, group_fd, evsel-
> > > >open_flags);
> > > -                       }
> > > -
> > > -                       pr_debug2_peo(" = %d\n", fd);
> > > -
> > > -                       if (evsel->bpf_fd >= 0) {
> > > -                               int evt_fd = fd;
> > > -                               int bpf_fd = evsel->bpf_fd;
> > > -
> > > -                               err = ioctl(evt_fd,
> > > -                                           PERF_EVENT_IOC_SET_BPF,
> > > -                                           bpf_fd);
> > > -                               if (err && errno != EEXIST) {
> > > -                                       pr_err("failed to attach bpf fd %d:
> > > %s\n",
> > > -                                              bpf_fd, strerror(errno));
> > > -                                       err = -EINVAL;
> > > -                                       goto out_close;
> > > -                               }
> > > -                       }
> > > -
> > > -                       set_rlimit = NO_CHANGE;
> > > -
> > > -                       /*
> > > -                        * If we succeeded but had to kill clockid, fail and
> > > -                        * have evsel__open_strerror() print us a nice error.
> > > -                        */
> > > -                       if (perf_missing_features.clockid ||
> > > -                           perf_missing_features.clockid_wrong) {
> > > -                               err = -EINVAL;
> > > +                       default:
> > > +                       case PEO_ERROR:
> > >                                 goto out_close;
> > >                         }
> > >                 }
> > > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > > index 0a245afab2d87d74..8c9827a93ac001a7 100644
> > > --- a/tools/perf/util/evsel.h
> > > +++ b/tools/perf/util/evsel.h
> > > @@ -282,6 +282,18 @@ int evsel__enable(struct evsel *evsel);
> > >  int evsel__disable(struct evsel *evsel);
> > >  int evsel__disable_cpu(struct evsel *evsel, int cpu);
> > >  
> > > +enum perf_event_open_err {
> > > +       PEO_SUCCESS,
> > > +       PEO_FALLBACK,
> > > +       PEO_ERROR
> > > +};
> > > +
> > > +struct perf_event_open_result {
> > > +       enum perf_event_open_err err;
> > > +       int rc;
> > > +       int fd;
> > > +};
> > > +
> > >  int evsel__open_per_cpu(struct evsel *evsel, struct perf_cpu_map *cpus, int
> > > cpu);
> > >  int evsel__open_per_thread(struct evsel *evsel, struct perf_thread_map
> > > *threads);
> > >  int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
> > > -- 
> > > 2.31.1
> > 
> 

-- 

- Arnaldo
