Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D830C433FE
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Sep 2021 21:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 003FE60FD7
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Sep 2021 21:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbhICVxX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 3 Sep 2021 17:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhICVxW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 3 Sep 2021 17:53:22 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DA0C061575;
        Fri,  3 Sep 2021 14:52:22 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 192-20020a1c04c9000000b002f7a4ab0a49so373273wme.0;
        Fri, 03 Sep 2021 14:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=4X569cMojqGCvJ6b5l8jpJFI25ifYXNTwbLVHX2EofM=;
        b=VWyhegPkhwjy9vsmRQA7vARMix2jDpDWJuWPtP6pzjR79F+TWr2inKlvFLd3GAmIVt
         vWVBcuRd4E+AaoJGcet+fwbY6r20LDvNu2i7wrBGAZrAjYmFF7QyNdAys6a7yF6PVyb+
         kYhMSj/s+SpXOcQJnpv0oUis/ioqyug+TDT5FHFt87MZj2sxzFWz+z6cNhSiV8MvYSRm
         +9KnBT/CpJZ1Ou3XT30s1GF1Ymj/rfZveaafkeAuir0uTkRKNu3I1nO2CzMRccggrJo5
         jN37tTmUaqwqp8mitEq9ylMtVyKvLmuD7Dw3PLtVzmlBDjdojqUOSCKhqzAxPeOocCpc
         U1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=4X569cMojqGCvJ6b5l8jpJFI25ifYXNTwbLVHX2EofM=;
        b=jeEnXqXC+R+XYPBn2eDqB8OOgyQpYKk2KjNQpGedhSiHOHypaeq7FyCZ7lF/+hhj2m
         EJu1WQNhOZ//Sx2IvEC3qwcLnWFkYAjk67HSkpLuPToKVkt6emEMmW6nNCQl1OYBzR+y
         ifDLXi7YqLB7YOn0ZegTaSlOO/HYIEUOoXNRjLyhmHCWRlIGDx6SB3Xy94EKaChUcV6F
         d/osfUv9NM8v5apfV71cYzRtGBJT5nDLmE3oytSxWULSS6av61fK1ieyC4Ezqf6jWbUQ
         TlosZaPYp95wBqxi4NkB0xzaj00sQKw/TbhdnbUkn3h91hMCM/RTePynojnLuJx1r6Gq
         XmxQ==
X-Gm-Message-State: AOAM533KO5n3jgksmR/E+KLENaE9Mmb0DlK7gA4Md6/62HFkHFsR5gpH
        AiwDXCqO5IGpU2x2qk6DXqDToN3P0fnJGFMC
X-Google-Smtp-Source: ABdhPJxWE1IXgzk2tIXdRbzsYwp2Bfj8DJqP5O8MwLtSDromiw2lGScrG2XMCPWNsFVbS+GyO6Zkng==
X-Received: by 2002:a1c:202:: with SMTP id 2mr669946wmc.122.1630705940287;
        Fri, 03 Sep 2021 14:52:20 -0700 (PDT)
Received: from [192.168.1.15] ([151.29.107.216])
        by smtp.gmail.com with ESMTPSA id c24sm409253wrb.57.2021.09.03.14.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 14:52:19 -0700 (PDT)
Message-ID: <9506b14fe2965e4145c034715eb10e02f2137f7b.camel@gmail.com>
Subject: Re: [RFC PATCH v1 25/37] perf evsel: move event open in
 evsel__open_cpu to separate function
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Date:   Fri, 03 Sep 2021 23:52:18 +0200
In-Reply-To: <YS6JBBW3d4pmcy/U@kernel.org>
References: <cover.1629490974.git.rickyman7@gmail.com>
         <74ac2eea14f45b2cbecffb509dd5f3cd523d4a9b.1629490974.git.rickyman7@gmail.com>
         <YS6JBBW3d4pmcy/U@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

thanks for your review and your suggestions, and also for the PRIu64 patch.

On Tue, 2021-08-31 at 16:54 -0300, Arnaldo Carvalho de Melo wrote:
> Em Sat, Aug 21, 2021 at 11:19:31AM +0200, Riccardo Mancini escreveu:
> > This is the final patch splitting evsel__open_cpu.
> > This patch moves the entire loop code to a separate function, to be
> > reused for the multithreaded code.
> 
> Are you going to use that 'enum perf_event_open_err' somewhere else?
> I.e. is there a need to expose it in evsel.h?

Yes, in the next patch (26/37). It's being used to expose a function that just
does the perf_event_open calls for an evsel. It needs to return such structure
to provide information about the error (which return code, at which thread).

> 
> I'm stopping at this patch to give the ones I merged so far some
> testing, will now push it to tmp.perf/core.

I checked tmp.perf/core and it looks good to me.
I also did some additional tests to check that fallback mechanisms where
working:

check missing pid being ignored (rerun until warning is shown)
$ sudo ./perf bench internals evlist-open-close -i10 -u $UID

check that weak group fallback is working
$ sudo ./perf record -e '{cycles,cache-misses,cache-
references,cpu_clk_unhalted.thread,cycles,cycles,cycles}:W' 

check that precision_ip fallback is working:
edited perf-sys.h to make sys_perf_event_open fail if precision_ip > 2
$ sudo ./perf record -e '{cycles,cs}:P'


I've also run perf-test on my machine and it's passing too.
I'm encounteirng one fail on the "BPF filter" test (42), which is present also
in perf/core, so it should not be related to this patch.

Thanks,
Riccardo

> 
> - Arnaldo
>  
> > Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> > ---
> >  tools/perf/util/evsel.c | 142 ++++++++++++++++++++++++----------------
> >  tools/perf/util/evsel.h |  12 ++++
> >  2 files changed, 99 insertions(+), 55 deletions(-)
> > 
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 2e95416b8320c6b9..e41f55a7a70ea630 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1945,6 +1945,82 @@ bool evsel__increase_rlimit(enum rlimit_action
> > *set_rlimit)
> >         return false;
> >  }
> >  
> > +static struct perf_event_open_result perf_event_open(struct evsel *evsel,
> > +                                       pid_t pid, int cpu, int thread,
> > +                                       struct perf_cpu_map *cpus,
> > +                                       struct perf_thread_map *threads)
> > +{
> > +       int fd, group_fd, rc;
> > +       struct perf_event_open_result res;
> > +
> > +       if (!evsel->cgrp && !evsel->core.system_wide)
> > +               pid = perf_thread_map__pid(threads, thread);
> > +
> > +       group_fd = get_group_fd(evsel, cpu, thread);
> > +
> > +       test_attr__ready();
> > +
> > +       pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags
> > %#lx",
> > +                       pid, cpus->map[cpu], group_fd, evsel->open_flags);
> > +
> > +       fd = sys_perf_event_open(&evsel->core.attr, pid, cpus->map[cpu],
> > +                               group_fd, evsel->open_flags);
> > +
> > +       FD(evsel, cpu, thread) = fd;
> > +       res.fd = fd;
> > +
> > +       if (fd < 0) {
> > +               rc = -errno;
> > +
> > +               pr_debug2_peo("\nsys_perf_event_open failed, error %d\n",
> > +                               rc);
> > +               res.rc = rc;
> > +               res.err = PEO_FALLBACK;
> > +               return res;
> > +       }
> > +
> > +       bpf_counter__install_pe(evsel, cpu, fd);
> > +
> > +       if (unlikely(test_attr__enabled)) {
> > +               test_attr__open(&evsel->core.attr, pid,
> > +                       cpus->map[cpu], fd,
> > +                       group_fd, evsel->open_flags);
> > +       }
> > +
> > +       pr_debug2_peo(" = %d\n", fd);
> > +
> > +       if (evsel->bpf_fd >= 0) {
> > +               int evt_fd = fd;
> > +               int bpf_fd = evsel->bpf_fd;
> > +
> > +               rc = ioctl(evt_fd,
> > +                               PERF_EVENT_IOC_SET_BPF,
> > +                               bpf_fd);
> > +               if (rc && errno != EEXIST) {
> > +                       pr_err("failed to attach bpf fd %d: %s\n",
> > +                               bpf_fd, strerror(errno));
> > +                       res.rc = -EINVAL;
> > +                       res.err = PEO_ERROR;
> > +                       return res;
> > +               }
> > +       }
> > +
> > +       /*
> > +        * If we succeeded but had to kill clockid, fail and
> > +        * have evsel__open_strerror() print us a nice error.
> > +        */
> > +       if (perf_missing_features.clockid ||
> > +               perf_missing_features.clockid_wrong) {
> > +               res.rc = -EINVAL;
> > +               res.err = PEO_ERROR;
> > +               return res;
> > +       }
> > +
> > +       res.rc = 0;
> > +       res.err = PEO_SUCCESS;
> > +       return res;
> > +}
> > +
> >  static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
> >                 struct perf_thread_map *threads,
> >                 int start_cpu, int end_cpu)
> > @@ -1952,6 +2028,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct
> > perf_cpu_map *cpus,
> >         int cpu, thread, nthreads;
> >         int pid = -1, err, old_errno;
> >         enum rlimit_action set_rlimit = NO_CHANGE;
> > +       struct perf_event_open_result peo_res;
> >  
> >         err = __evsel__prepare_open(evsel, cpus, threads);
> >         if (err)
> > @@ -1979,67 +2056,22 @@ static int evsel__open_cpu(struct evsel *evsel, struct
> > perf_cpu_map *cpus,
> >         for (cpu = start_cpu; cpu < end_cpu; cpu++) {
> >  
> >                 for (thread = 0; thread < nthreads; thread++) {
> > -                       int fd, group_fd;
> >  retry_open:
> >                         if (thread >= nthreads)
> >                                 break;
> >  
> > -                       if (!evsel->cgrp && !evsel->core.system_wide)
> > -                               pid = perf_thread_map__pid(threads, thread);
> > -
> > -                       group_fd = get_group_fd(evsel, cpu, thread);
> > -
> > -                       test_attr__ready();
> > -
> > -                       pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d 
> > group_fd %d  flags %#lx",
> > -                               pid, cpus->map[cpu], group_fd, evsel-
> > >open_flags);
> > +                       peo_res = perf_event_open(evsel, pid, cpu, thread,
> > cpus,
> > +                                               threads);
> >  
> > -                       fd = sys_perf_event_open(&evsel->core.attr, pid, cpus-
> > >map[cpu],
> > -                                               group_fd, evsel->open_flags);
> > -
> > -                       FD(evsel, cpu, thread) = fd;
> > -
> > -                       if (fd < 0) {
> > -                               err = -errno;
> > -
> > -                               pr_debug2_peo("\nsys_perf_event_open failed,
> > error %d\n",
> > -                                         err);
> > +                       err = peo_res.rc;
> > +                       switch (peo_res.err) {
> > +                       case PEO_SUCCESS:
> > +                               set_rlimit = NO_CHANGE;
> > +                               continue;
> > +                       case PEO_FALLBACK:
> >                                 goto try_fallback;
> > -                       }
> > -
> > -                       bpf_counter__install_pe(evsel, cpu, fd);
> > -
> > -                       if (unlikely(test_attr__enabled)) {
> > -                               test_attr__open(&evsel->core.attr, pid, cpus-
> > >map[cpu],
> > -                                               fd, group_fd, evsel-
> > >open_flags);
> > -                       }
> > -
> > -                       pr_debug2_peo(" = %d\n", fd);
> > -
> > -                       if (evsel->bpf_fd >= 0) {
> > -                               int evt_fd = fd;
> > -                               int bpf_fd = evsel->bpf_fd;
> > -
> > -                               err = ioctl(evt_fd,
> > -                                           PERF_EVENT_IOC_SET_BPF,
> > -                                           bpf_fd);
> > -                               if (err && errno != EEXIST) {
> > -                                       pr_err("failed to attach bpf fd %d:
> > %s\n",
> > -                                              bpf_fd, strerror(errno));
> > -                                       err = -EINVAL;
> > -                                       goto out_close;
> > -                               }
> > -                       }
> > -
> > -                       set_rlimit = NO_CHANGE;
> > -
> > -                       /*
> > -                        * If we succeeded but had to kill clockid, fail and
> > -                        * have evsel__open_strerror() print us a nice error.
> > -                        */
> > -                       if (perf_missing_features.clockid ||
> > -                           perf_missing_features.clockid_wrong) {
> > -                               err = -EINVAL;
> > +                       default:
> > +                       case PEO_ERROR:
> >                                 goto out_close;
> >                         }
> >                 }
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index 0a245afab2d87d74..8c9827a93ac001a7 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -282,6 +282,18 @@ int evsel__enable(struct evsel *evsel);
> >  int evsel__disable(struct evsel *evsel);
> >  int evsel__disable_cpu(struct evsel *evsel, int cpu);
> >  
> > +enum perf_event_open_err {
> > +       PEO_SUCCESS,
> > +       PEO_FALLBACK,
> > +       PEO_ERROR
> > +};
> > +
> > +struct perf_event_open_result {
> > +       enum perf_event_open_err err;
> > +       int rc;
> > +       int fd;
> > +};
> > +
> >  int evsel__open_per_cpu(struct evsel *evsel, struct perf_cpu_map *cpus, int
> > cpu);
> >  int evsel__open_per_thread(struct evsel *evsel, struct perf_thread_map
> > *threads);
> >  int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
> > -- 
> > 2.31.1
> 


