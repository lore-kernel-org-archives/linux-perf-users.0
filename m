Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E7124113D
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761757030; cv=none; b=XH6jTI0jufpQu1sDNiOvtutdCy2064U19WmBfEGU3lXZgD1rNERaqZGpQ2ITjy74Et1suX4VvaaCgOeP3bN//iQGYZhwe+kaN6NWsNMiOud6UsVm+JXdFXLjho42UW5+YLEZI2fwcHSo5sp0n7N8zTTZFUO61v3Tu/pYSPgqAJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761757030; c=relaxed/simple;
	bh=KCopnOHzNtJBI9hCaSi1+OLZ4L8I1oZQXJb13gs7Sf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZ4A8+KeMqI9dTxoP2qSozm6blmUGjdb7QBKs6aRVZtlFZ/JWG+97NcSFPrqTOQveKpm4y2AL3hgxNUUeHNNuSc8uzHV2jUD4pd78arQ+NqQ0G+Qg34ja0e+/5ZwbFsQ7dHhCBVkG04pjKiCbIsxsMqZaad5dz8mCFwnl1uZKg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hIuQSJ49; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hIuQSJ49"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-290da96b37fso3615ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 09:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761757026; x=1762361826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvO+L0jfzxEO8B732Ignq2kRf9py7vBS2Jzl0kBpy5U=;
        b=hIuQSJ49zz13Os+V6SX+gURUc+BQPHv/1WXDTCwOSmEH30+cbt5cyGUm71QFyn1r8X
         o0z98Q0/0ckWxw3gMf+g/ugF3cqMiLJL/npkEBcKPw4ng5Xlr/oSGHzJfnDiJHSEZs/T
         iuuj7WubU7SbzaZAmVyWZx04X0rGErMpidRjlq2SOa4CQqldCJpsCEqnlPNqOCODNuFc
         vynUTWeg5waK3xp9bGPCLlFmL+4Q35zpPg5kp+sqQ0eo4Ifc+TTwBXxXxOhl0NnkzjnG
         jEni08mOFoWLj7hzEheg8liQ6m3LZlXGjsupZRtloghDtzKdeuYR8RqM5G0nnBjRc2oZ
         oBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761757026; x=1762361826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvO+L0jfzxEO8B732Ignq2kRf9py7vBS2Jzl0kBpy5U=;
        b=Puruoec8I6zj/JIuBvlVMPmgDNoEE4iS6MUJyiXCv7vGPI/tdB1pDJ/0aUTHY5yPBb
         DriHfXrQ6o6iKJhY0YgnBnB0ViYi5e/YGhyJbw+vuw/IGZVW9BBsI61cdKr63t9/NQGt
         rYr9kPso1yM9quoftAn6Bu1Eq54oEvYuQ+ou/61y8tjri69pCvqimKbjXbzGvwOjpNIC
         HKN22bGnW6hL+/vPS29PqTrsa9OwNoaqFjgAACkIHLLukDEqG2piUZQXO6lBFVkU2Fkk
         MGZOVl6wjqejeZ/qwWyUf6YFa6bvdrRimLc1CHbqNdlsKvBMPEc56LRDyX3yydUYDOQH
         d29w==
X-Forwarded-Encrypted: i=1; AJvYcCVyZ9orkikwdPnbjVDSp7xP/ebmNrbdGFDSfh4TdQRXqBw+1GIsH+UHV2NM8ltax35Dgcob6XmiJyf/aZnVyxTA@vger.kernel.org
X-Gm-Message-State: AOJu0YzIopsBuN+mqVFoDByTGsigWcjKL2a9f+ravfpQ10oXkKHODJEJ
	7BvcxGOaWHqSFDHor6/fR3J4FhQXV0uVUvbM8U+BB6hjtugA/ZkrRWZH9m6rdd7KgZSU2hi3eAC
	nm36TZ22bHZOso+vdkC4/bld0GCSLiXi58T5RT0B2
X-Gm-Gg: ASbGncvOtok1iYD7T0LJnz5hPZuwqrWNlkNmIx389UU/oNLRDoszJNvaEAM4YgbNfVC
	U4vqc8buFE8UfokBc6NYhJiymz9D2X7xl4KgWRqTmGaXFY7TD1lOTDQD1zYUrbPAlJYLIoBxs9d
	G24EJlhau3t57oF6dbjhrmzuHhn7+NZcE7rJBQbVsvgM1oaVKdG4WfJoRVj2XlVQCobKQ/4IEXT
	AwTGmawghE2fhvVgOI5fGPtJcZgxWmgbKKgRz7eUWdLgg4u9+ym2v0ldZtolMBUdU3k8PJWOaff
	A3UzsZkq0hexk1E=
X-Google-Smtp-Source: AGHT+IGgdLG19rSZW9XS7SMSWEt5E57uVa8id2CJXXpWmjRSkQSJodMf2MPudOo46ItejuxjGUjj+09t5BNoPR1Kl5E=
X-Received: by 2002:a17:902:db05:b0:26e:ac44:3b44 with SMTP id
 d9443c01a7336-294de569f58mr6978345ad.10.1761757023852; Wed, 29 Oct 2025
 09:57:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029053413.355154-1-irogers@google.com> <20251029053413.355154-13-irogers@google.com>
 <aQI_OJziRPMRqzM9@x1>
In-Reply-To: <aQI_OJziRPMRqzM9@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 29 Oct 2025 09:56:50 -0700
X-Gm-Features: AWmQ_bl6q1mmmiUqpDlLPPGJjRsjEfl75rcH4Wab8cF_9i1vZT5g9KlJDI6yx-s
Message-ID: <CAP-5=fXz+tG-6q54FNY2OrKcz4zjncRXEWzV8E2suXmOA4MzEw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 12/15] perf evlist: Add reference count
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Charlie Jenkins <charlie@rivosinc.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	Song Liu <song@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Blake Jones <blakejones@google.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Chun-Tse Shao <ctshao@google.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 9:22=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Oct 28, 2025 at 10:34:10PM -0700, Ian Rogers wrote:
> > This a no-op for most of the perf tool. The reference count is set to
> > 1 at allocation, the put will see the 1, decrement it and perform the
> > delete. The purpose for adding the reference count is for the python
> > code. Prior to this change the python code would clone evlists, but
> > this has issues if events are opened, etc. This change adds a
> > reference count for the evlists and a later change will add it to
> > evsels. The combination is needed for the python code to operate
> > correctly (not hit asserts in the evsel clone), but the changes are
> > broken apart for the sake of smaller patches.
>
> Looks ok, noisy for all the s/delete/put/ but that is ok, but then you
> are not using the RC_CHK_ACCESS stuff from the get go, why not?

So if I did RC_CHK_ACCESS then every evsel access would need updating,
accessor functions, and a lot of lines of code. As the reference count
checking doesn't work with invasive lists, you need to interpose prev
and next, I think we'd need to specially handle the case probably with
an extra variable in evsel for reference count checking like:
```
RC_STRUCT(evsel) {
...
   struct evsel *evlist_ptr;
...
}
```
and things like evlist__for_each_entry need changes like:
```
#define evlist__for_each_entry(evlist, evsel) \
       __evlist__for_each_entry(&(evlist)->core.entries, orig_evsel) {
           evsel =3D orig_evsel->evlist_ptr
```
but it may be simpler to change evlist to use an array of evsel* as
was done in places like `struct maps`.

Anyway, those changes I think would have taken away from what the
series was trying to do and so weren't done here.

Thanks,
Ian

> All the prep patches looks ok, assuming they build in succession.
>
> - Arnaldo
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/x86/tests/hybrid.c          |   2 +-
> >  tools/perf/arch/x86/tests/topdown.c         |   2 +-
> >  tools/perf/arch/x86/util/iostat.c           |   2 +-
> >  tools/perf/bench/evlist-open-close.c        |  18 +-
> >  tools/perf/builtin-ftrace.c                 |   8 +-
> >  tools/perf/builtin-kvm.c                    |   4 +-
> >  tools/perf/builtin-lock.c                   |   2 +-
> >  tools/perf/builtin-record.c                 |   4 +-
> >  tools/perf/builtin-stat.c                   |   8 +-
> >  tools/perf/builtin-top.c                    |  52 +++---
> >  tools/perf/builtin-trace.c                  |  26 +--
> >  tools/perf/tests/backward-ring-buffer.c     |  18 +-
> >  tools/perf/tests/code-reading.c             |   4 +-
> >  tools/perf/tests/event-times.c              |   4 +-
> >  tools/perf/tests/event_update.c             |   2 +-
> >  tools/perf/tests/evsel-roundtrip-name.c     |   8 +-
> >  tools/perf/tests/expand-cgroup.c            |   8 +-
> >  tools/perf/tests/hists_cumulate.c           |   2 +-
> >  tools/perf/tests/hists_filter.c             |   2 +-
> >  tools/perf/tests/hists_link.c               |   2 +-
> >  tools/perf/tests/hists_output.c             |   2 +-
> >  tools/perf/tests/hwmon_pmu.c                |   2 +-
> >  tools/perf/tests/keep-tracking.c            |   2 +-
> >  tools/perf/tests/mmap-basic.c               |  18 +-
> >  tools/perf/tests/openat-syscall-tp-fields.c |  18 +-
> >  tools/perf/tests/parse-events.c             |   4 +-
> >  tools/perf/tests/parse-metric.c             |   4 +-
> >  tools/perf/tests/parse-no-sample-id-all.c   |   2 +-
> >  tools/perf/tests/perf-record.c              |  18 +-
> >  tools/perf/tests/perf-time-to-tsc.c         |   2 +-
> >  tools/perf/tests/pfm.c                      |   4 +-
> >  tools/perf/tests/pmu-events.c               |   6 +-
> >  tools/perf/tests/pmu.c                      |   2 +-
> >  tools/perf/tests/sw-clock.c                 |  14 +-
> >  tools/perf/tests/switch-tracking.c          |   2 +-
> >  tools/perf/tests/task-exit.c                |  14 +-
> >  tools/perf/tests/tool_pmu.c                 |   2 +-
> >  tools/perf/tests/topology.c                 |   2 +-
> >  tools/perf/util/cgroup.c                    |   4 +-
> >  tools/perf/util/data-convert-bt.c           |   2 +-
> >  tools/perf/util/evlist.c                    |  20 ++-
> >  tools/perf/util/evlist.h                    |   7 +-
> >  tools/perf/util/expr.c                      |   2 +-
> >  tools/perf/util/header.c                    |  12 +-
> >  tools/perf/util/metricgroup.c               |   6 +-
> >  tools/perf/util/parse-events.c              |   4 +-
> >  tools/perf/util/perf_api_probe.c            |   2 +-
> >  tools/perf/util/python.c                    | 176 +++++++-------------
> >  tools/perf/util/record.c                    |   2 +-
> >  tools/perf/util/session.c                   |   2 +-
> >  tools/perf/util/sideband_evlist.c           |  16 +-
> >  51 files changed, 252 insertions(+), 299 deletions(-)
> >
> > diff --git a/tools/perf/arch/x86/tests/hybrid.c b/tools/perf/arch/x86/t=
ests/hybrid.c
> > index e221ea104174..dfb0ffc0d030 100644
> > --- a/tools/perf/arch/x86/tests/hybrid.c
> > +++ b/tools/perf/arch/x86/tests/hybrid.c
> > @@ -268,7 +268,7 @@ static int test_event(const struct evlist_test *e)
> >               ret =3D e->check(evlist);
> >       }
> >       parse_events_error__exit(&err);
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >
> >       return ret;
> >  }
> > diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/=
tests/topdown.c
> > index 1eba3b4594ef..b31aef4ef28b 100644
> > --- a/tools/perf/arch/x86/tests/topdown.c
> > +++ b/tools/perf/arch/x86/tests/topdown.c
> > @@ -55,7 +55,7 @@ static int event_cb(void *state, struct pmu_event_inf=
o *info)
> >                       *ret =3D TEST_FAIL;
> >               }
> >       }
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >       return 0;
> >  }
> >
> > diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/ut=
il/iostat.c
> > index 7442a2cd87ed..e0417552b0cb 100644
> > --- a/tools/perf/arch/x86/util/iostat.c
> > +++ b/tools/perf/arch/x86/util/iostat.c
> > @@ -337,7 +337,7 @@ int iostat_prepare(struct evlist *evlist, struct pe=
rf_stat_config *config)
> >       if (evlist->core.nr_entries > 0) {
> >               pr_warning("The -e and -M options are not supported."
> >                          "All chosen events/metrics will be dropped\n")=
;
> > -             evlist__delete(evlist);
> > +             evlist__put(evlist);
> >               evlist =3D evlist__new();
> >               if (!evlist)
> >                       return -ENOMEM;
> > diff --git a/tools/perf/bench/evlist-open-close.c b/tools/perf/bench/ev=
list-open-close.c
> > index bfaf50e4e519..a802fb005ee3 100644
> > --- a/tools/perf/bench/evlist-open-close.c
> > +++ b/tools/perf/bench/evlist-open-close.c
> > @@ -75,7 +75,7 @@ static struct evlist *bench__create_evlist(char *evst=
r, const char *uid_str)
> >               parse_events_error__exit(&err);
> >               pr_err("Run 'perf list' for a list of valid events\n");
> >               ret =3D 1;
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >       parse_events_error__exit(&err);
> >       if (uid_str) {
> > @@ -84,24 +84,24 @@ static struct evlist *bench__create_evlist(char *ev=
str, const char *uid_str)
> >               if (uid =3D=3D UINT_MAX) {
> >                       pr_err("Invalid User: %s", uid_str);
> >                       ret =3D -EINVAL;
> > -                     goto out_delete_evlist;
> > +                     goto out_put_evlist;
> >               }
> >               ret =3D parse_uid_filter(evlist, uid);
> >               if (ret)
> > -                     goto out_delete_evlist;
> > +                     goto out_put_evlist;
> >       }
> >       ret =3D evlist__create_maps(evlist, &opts.target);
> >       if (ret < 0) {
> >               pr_err("Not enough memory to create thread/cpu maps\n");
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       evlist__config(evlist, &opts, NULL);
> >
> >       return evlist;
> >
> > -out_delete_evlist:
> > -     evlist__delete(evlist);
> > +out_put_evlist:
> > +     evlist__put(evlist);
> >       return NULL;
> >  }
> >
> > @@ -150,7 +150,7 @@ static int bench_evlist_open_close__run(char *evstr=
, const char *uid_str)
> >               evlist->core.nr_entries, evlist__count_evsel_fds(evlist))=
;
> >       printf("  Number of iterations:\t%d\n", iterations);
> >
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >
> >       for (i =3D 0; i < iterations; i++) {
> >               pr_debug("Started iteration %d\n", i);
> > @@ -161,7 +161,7 @@ static int bench_evlist_open_close__run(char *evstr=
, const char *uid_str)
> >               gettimeofday(&start, NULL);
> >               err =3D bench__do_evlist_open_close(evlist);
> >               if (err) {
> > -                     evlist__delete(evlist);
> > +                     evlist__put(evlist);
> >                       return err;
> >               }
> >
> > @@ -170,7 +170,7 @@ static int bench_evlist_open_close__run(char *evstr=
, const char *uid_str)
> >               runtime_us =3D timeval2usec(&diff);
> >               update_stats(&time_stats, runtime_us);
> >
> > -             evlist__delete(evlist);
> > +             evlist__put(evlist);
> >               pr_debug("Iteration %d took:\t%" PRIu64 "us\n", i, runtim=
e_us);
> >       }
> >
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index 6b6eec65f93f..4a2fe05e9786 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -1993,20 +1993,20 @@ int cmd_ftrace(int argc, const char **argv)
> >
> >       ret =3D evlist__create_maps(ftrace.evlist, &ftrace.target);
> >       if (ret < 0)
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >
> >       if (argc) {
> >               ret =3D evlist__prepare_workload(ftrace.evlist, &ftrace.t=
arget,
> >                                              argv, false,
> >                                              ftrace__workload_exec_fail=
ed_signal);
> >               if (ret < 0)
> > -                     goto out_delete_evlist;
> > +                     goto out_put_evlist;
> >       }
> >
> >       ret =3D cmd_func(&ftrace);
> >
> > -out_delete_evlist:
> > -     evlist__delete(ftrace.evlist);
> > +out_put_evlist:
> > +     evlist__put(ftrace.evlist);
> >
> >  out_delete_filters:
> >       delete_filter_func(&ftrace.filters);
> > diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> > index f0f285763f19..b07cbe051e33 100644
> > --- a/tools/perf/builtin-kvm.c
> > +++ b/tools/perf/builtin-kvm.c
> > @@ -1806,7 +1806,7 @@ static struct evlist *kvm_live_event_list(void)
> >
> >  out:
> >       if (err) {
> > -             evlist__delete(evlist);
> > +             evlist__put(evlist);
> >               evlist =3D NULL;
> >       }
> >
> > @@ -1937,7 +1937,7 @@ static int kvm_events_live(struct perf_kvm_stat *=
kvm,
> >  out:
> >       perf_session__delete(kvm->session);
> >       kvm->session =3D NULL;
> > -     evlist__delete(kvm->evlist);
> > +     evlist__put(kvm->evlist);
> >
> >       return err;
> >  }
> > diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> > index 078634461df2..2a57767f03a9 100644
> > --- a/tools/perf/builtin-lock.c
> > +++ b/tools/perf/builtin-lock.c
> > @@ -2143,7 +2143,7 @@ static int __cmd_contention(int argc, const char =
**argv)
> >
> >  out_delete:
> >       lock_filter_finish();
> > -     evlist__delete(con.evlist);
> > +     evlist__put(con.evlist);
> >       lock_contention_finish(&con);
> >       perf_session__delete(session);
> >       perf_env__exit(&host_env);
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 3d8cf4090a92..738dbae80eac 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -4349,7 +4349,7 @@ int cmd_record(int argc, const char **argv)
> >                       goto out;
> >
> >               evlist__splice_list_tail(rec->evlist, &def_evlist->core.e=
ntries);
> > -             evlist__delete(def_evlist);
> > +             evlist__put(def_evlist);
> >       }
> >
> >       if (rec->opts.target.tid && !rec->opts.no_inherit_set)
> > @@ -4460,7 +4460,7 @@ int cmd_record(int argc, const char **argv)
> >       auxtrace_record__free(rec->itr);
> >  out_opts:
> >       evlist__close_control(rec->opts.ctl_fd, rec->opts.ctl_fd_ack, &re=
c->opts.ctl_fd_close);
> > -     evlist__delete(rec->evlist);
> > +     evlist__put(rec->evlist);
> >       return err;
> >  }
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 886727ae8529..282926c6abd4 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -2067,7 +2067,7 @@ static int add_default_events(void)
> >                       metricgroup__copy_metric_events(evlist, /*cgrp=3D=
*/NULL,
> >                                                       &evlist->metric_e=
vents,
> >                                                       &metric_evlist->m=
etric_events);
> > -                     evlist__delete(metric_evlist);
> > +                     evlist__put(metric_evlist);
> >               }
> >       }
> >
> > @@ -2142,7 +2142,7 @@ static int add_default_events(void)
> >       metricgroup__copy_metric_events(evsel_list, /*cgrp=3D*/NULL,
> >                                       &evsel_list->metric_events,
> >                                       &evlist->metric_events);
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >       return ret;
> >  }
> >
> > @@ -2373,7 +2373,7 @@ static int __cmd_report(int argc, const char **ar=
gv)
> >
> >       perf_stat.session  =3D session;
> >       stat_config.output =3D stderr;
> > -     evlist__delete(evsel_list);
> > +     evlist__put(evsel_list);
> >       evsel_list         =3D session->evlist;
> >
> >       ret =3D perf_session__process_events(session);
> > @@ -3042,7 +3042,7 @@ int cmd_stat(int argc, const char **argv)
> >       if (smi_cost && smi_reset)
> >               sysfs__write_int(FREEZE_ON_SMI_PATH, 0);
> >
> > -     evlist__delete(evsel_list);
> > +     evlist__put(evsel_list);
> >
> >       evlist__close_control(stat_config.ctl_fd, stat_config.ctl_fd_ack,=
 &stat_config.ctl_fd_close);
> >
> > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> > index 710604c4f6f6..45d5dae54dcd 100644
> > --- a/tools/perf/builtin-top.c
> > +++ b/tools/perf/builtin-top.c
> > @@ -1641,14 +1641,14 @@ int cmd_top(int argc, const char **argv)
> >       perf_env__init(&host_env);
> >       status =3D perf_config(perf_top_config, &top);
> >       if (status)
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       /*
> >        * Since the per arch annotation init routine may need the cpuid,=
 read
> >        * it here, since we are not getting this from the perf.data head=
er.
> >        */
> >       status =3D perf_env__set_cmdline(&host_env, argc, argv);
> >       if (status)
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >
> >       status =3D perf_env__read_cpuid(&host_env);
> >       if (status) {
> > @@ -1669,44 +1669,44 @@ int cmd_top(int argc, const char **argv)
> >               annotate_opts.disassembler_style =3D strdup(disassembler_=
style);
> >               if (!annotate_opts.disassembler_style) {
> >                       status =3D -ENOMEM;
> > -                     goto out_delete_evlist;
> > +                     goto out_put_evlist;
> >               }
> >       }
> >       if (objdump_path) {
> >               annotate_opts.objdump_path =3D strdup(objdump_path);
> >               if (!annotate_opts.objdump_path) {
> >                       status =3D -ENOMEM;
> > -                     goto out_delete_evlist;
> > +                     goto out_put_evlist;
> >               }
> >       }
> >       if (addr2line_path) {
> >               symbol_conf.addr2line_path =3D strdup(addr2line_path);
> >               if (!symbol_conf.addr2line_path) {
> >                       status =3D -ENOMEM;
> > -                     goto out_delete_evlist;
> > +                     goto out_put_evlist;
> >               }
> >       }
> >
> >       status =3D symbol__validate_sym_arguments();
> >       if (status)
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >
> >       if (annotate_check_args() < 0)
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >
> >       if (!top.evlist->core.nr_entries) {
> >               struct evlist *def_evlist =3D evlist__new_default();
> >
> >               if (!def_evlist)
> > -                     goto out_delete_evlist;
> > +                     goto out_put_evlist;
> >
> >               evlist__splice_list_tail(top.evlist, &def_evlist->core.en=
tries);
> > -             evlist__delete(def_evlist);
> > +             evlist__put(def_evlist);
> >       }
> >
> >       status =3D evswitch__init(&top.evswitch, top.evlist, stderr);
> >       if (status)
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >
> >       if (symbol_conf.report_hierarchy) {
> >               /* disable incompatible options */
> > @@ -1717,18 +1717,18 @@ int cmd_top(int argc, const char **argv)
> >                       pr_err("Error: --hierarchy and --fields options c=
annot be used together\n");
> >                       parse_options_usage(top_usage, options, "fields",=
 0);
> >                       parse_options_usage(NULL, options, "hierarchy", 0=
);
> > -                     goto out_delete_evlist;
> > +                     goto out_put_evlist;
> >               }
> >       }
> >
> >       if (top.stitch_lbr && !(callchain_param.record_mode =3D=3D CALLCH=
AIN_LBR)) {
> >               pr_err("Error: --stitch-lbr must be used with --call-grap=
h lbr\n");
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       if (nr_cgroups > 0 && opts->record_cgroup) {
> >               pr_err("--cgroup and --all-cgroups cannot be used togethe=
r\n");
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       if (branch_call_mode) {
> > @@ -1752,7 +1752,7 @@ int cmd_top(int argc, const char **argv)
> >               status =3D perf_env__read_core_pmu_caps(&host_env);
> >               if (status) {
> >                       pr_err("PMU capability data is not available\n");
> > -                     goto out_delete_evlist;
> > +                     goto out_put_evlist;
> >               }
> >       }
> >
> > @@ -1775,7 +1775,7 @@ int cmd_top(int argc, const char **argv)
> >       if (IS_ERR(top.session)) {
> >               status =3D PTR_ERR(top.session);
> >               top.session =3D NULL;
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >       top.evlist->session =3D top.session;
> >
> > @@ -1785,7 +1785,7 @@ int cmd_top(int argc, const char **argv)
> >               if (field_order)
> >                       parse_options_usage(sort_order ? NULL : top_usage=
,
> >                                           options, "fields", 0);
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       status =3D target__validate(target);
> > @@ -1800,11 +1800,11 @@ int cmd_top(int argc, const char **argv)
> >               if (uid =3D=3D UINT_MAX) {
> >                       ui__error("Invalid User: %s", top.uid_str);
> >                       status =3D -EINVAL;
> > -                     goto out_delete_evlist;
> > +                     goto out_put_evlist;
> >               }
> >               status =3D parse_uid_filter(top.evlist, uid);
> >               if (status)
> > -                     goto out_delete_evlist;
> > +                     goto out_put_evlist;
> >       }
> >
> >       if (target__none(target))
> > @@ -1814,7 +1814,7 @@ int cmd_top(int argc, const char **argv)
> >               ui__error("Couldn't create thread/CPU maps: %s\n",
> >                         errno =3D=3D ENOENT ? "No such process" : str_e=
rror_r(errno, errbuf, sizeof(errbuf)));
> >               status =3D -errno;
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       if (top.delay_secs < 1)
> > @@ -1822,7 +1822,7 @@ int cmd_top(int argc, const char **argv)
> >
> >       if (record_opts__config(opts)) {
> >               status =3D -EINVAL;
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       top.sym_evsel =3D evlist__first(top.evlist);
> > @@ -1837,14 +1837,14 @@ int cmd_top(int argc, const char **argv)
> >
> >       status =3D symbol__annotation_init();
> >       if (status < 0)
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >
> >       annotation_config__init();
> >
> >       symbol_conf.try_vmlinux_path =3D (symbol_conf.vmlinux_name =3D=3D=
 NULL);
> >       status =3D symbol__init(NULL);
> >       if (status < 0)
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >
> >       sort__setup_elide(stdout);
> >
> > @@ -1864,13 +1864,13 @@ int cmd_top(int argc, const char **argv)
> >               if (top.sb_evlist =3D=3D NULL) {
> >                       pr_err("Couldn't create side band evlist.\n.");
> >                       status =3D -EINVAL;
> > -                     goto out_delete_evlist;
> > +                     goto out_put_evlist;
> >               }
> >
> >               if (evlist__add_bpf_sb_event(top.sb_evlist, &host_env)) {
> >                       pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT si=
de band events.\n.");
> >                       status =3D -EINVAL;
> > -                     goto out_delete_evlist;
> > +                     goto out_put_evlist;
> >               }
> >       }
> >  #endif
> > @@ -1885,8 +1885,8 @@ int cmd_top(int argc, const char **argv)
> >       if (!opts->no_bpf_event)
> >               evlist__stop_sb_thread(top.sb_evlist);
> >
> > -out_delete_evlist:
> > -     evlist__delete(top.evlist);
> > +out_put_evlist:
> > +     evlist__put(top.evlist);
> >       perf_session__delete(top.session);
> >       annotation_options__exit();
> >       perf_env__exit(&host_env);
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index a743bda294bd..c056df42a78f 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -4364,7 +4364,7 @@ static int trace__run(struct trace *trace, int ar=
gc, const char **argv)
> >
> >       if (trace->summary_bpf) {
> >               if (trace_prepare_bpf_summary(trace->summary_mode) < 0)
> > -                     goto out_delete_evlist;
> > +                     goto out_put_evlist;
> >
> >               if (trace->summary_only)
> >                       goto create_maps;
> > @@ -4432,19 +4432,19 @@ static int trace__run(struct trace *trace, int =
argc, const char **argv)
> >       err =3D evlist__create_maps(evlist, &trace->opts.target);
> >       if (err < 0) {
> >               fprintf(trace->output, "Problems parsing the target to tr=
ace, check your options!\n");
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       err =3D trace__symbols_init(trace, argc, argv, evlist);
> >       if (err < 0) {
> >               fprintf(trace->output, "Problems initializing symbol libr=
aries!\n");
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       if (trace->summary_mode =3D=3D SUMMARY__BY_TOTAL && !trace->summa=
ry_bpf) {
> >               trace->syscall_stats =3D alloc_syscall_stats();
> >               if (IS_ERR(trace->syscall_stats))
> > -                     goto out_delete_evlist;
> > +                     goto out_put_evlist;
> >       }
> >
> >       evlist__config(evlist, &trace->opts, &callchain_param);
> > @@ -4453,7 +4453,7 @@ static int trace__run(struct trace *trace, int ar=
gc, const char **argv)
> >               err =3D evlist__prepare_workload(evlist, &trace->opts.tar=
get, argv, false, NULL);
> >               if (err < 0) {
> >                       fprintf(trace->output, "Couldn't run the workload=
!\n");
> > -                     goto out_delete_evlist;
> > +                     goto out_put_evlist;
> >               }
> >               workload_pid =3D evlist->workload.pid;
> >       }
> > @@ -4501,7 +4501,7 @@ static int trace__run(struct trace *trace, int ar=
gc, const char **argv)
> >
> >       err =3D trace__expand_filters(trace, &evsel);
> >       if (err)
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       err =3D evlist__apply_filters(evlist, &evsel, &trace->opts.target=
);
> >       if (err < 0)
> >               goto out_error_apply_filters;
> > @@ -4618,12 +4618,12 @@ static int trace__run(struct trace *trace, int =
argc, const char **argv)
> >               }
> >       }
> >
> > -out_delete_evlist:
> > +out_put_evlist:
> >       trace_cleanup_bpf_summary();
> >       delete_syscall_stats(trace->syscall_stats);
> >       trace__symbols__exit(trace);
> >       evlist__free_syscall_tp_fields(evlist);
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >       cgroup__put(trace->cgroup);
> >       trace->evlist =3D NULL;
> >       trace->live =3D false;
> > @@ -4648,22 +4648,22 @@ static int trace__run(struct trace *trace, int =
argc, const char **argv)
> >
> >  out_error:
> >       fprintf(trace->output, "%s\n", errbuf);
> > -     goto out_delete_evlist;
> > +     goto out_put_evlist;
> >
> >  out_error_apply_filters:
> >       fprintf(trace->output,
> >               "Failed to set filter \"%s\" on event %s with %d (%s)\n",
> >               evsel->filter, evsel__name(evsel), errno,
> >               str_error_r(errno, errbuf, sizeof(errbuf)));
> > -     goto out_delete_evlist;
> > +     goto out_put_evlist;
> >  }
> >  out_error_mem:
> >       fprintf(trace->output, "Not enough memory to run!\n");
> > -     goto out_delete_evlist;
> > +     goto out_put_evlist;
> >
> >  out_errno:
> >       fprintf(trace->output, "errno=3D%d,%s\n", errno, strerror(errno))=
;
> > -     goto out_delete_evlist;
> > +     goto out_put_evlist;
> >  }
> >
> >  static int trace__replay(struct trace *trace)
> > @@ -5331,7 +5331,7 @@ static void trace__exit(struct trace *trace)
> >               zfree(&trace->syscalls.table);
> >       }
> >       zfree(&trace->perfconfig_events);
> > -     evlist__delete(trace->evlist);
> > +     evlist__put(trace->evlist);
> >       trace->evlist =3D NULL;
> >       ordered_events__free(&trace->oe.data);
> >  #ifdef HAVE_LIBBPF_SUPPORT
> > diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests=
/backward-ring-buffer.c
> > index c5e7999f2817..2b49b002d749 100644
> > --- a/tools/perf/tests/backward-ring-buffer.c
> > +++ b/tools/perf/tests/backward-ring-buffer.c
> > @@ -111,7 +111,7 @@ static int test__backward_ring_buffer(struct test_s=
uite *test __maybe_unused, in
> >       err =3D evlist__create_maps(evlist, &opts.target);
> >       if (err < 0) {
> >               pr_debug("Not enough memory to create thread/cpu maps\n")=
;
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       parse_events_error__init(&parse_error);
> > @@ -124,7 +124,7 @@ static int test__backward_ring_buffer(struct test_s=
uite *test __maybe_unused, in
> >       if (err) {
> >               pr_debug("Failed to parse tracepoint event, try use root\=
n");
> >               ret =3D TEST_SKIP;
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       evlist__config(evlist, &opts, NULL);
> > @@ -133,19 +133,19 @@ static int test__backward_ring_buffer(struct test=
_suite *test __maybe_unused, in
> >       if (err < 0) {
> >               pr_debug("perf_evlist__open: %s\n",
> >                        str_error_r(errno, sbuf, sizeof(sbuf)));
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       ret =3D TEST_FAIL;
> >       err =3D do_test(evlist, opts.mmap_pages, &sample_count,
> >                     &comm_count);
> >       if (err !=3D TEST_OK)
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >
> >       if ((sample_count !=3D NR_ITERS) || (comm_count !=3D NR_ITERS)) {
> >               pr_err("Unexpected counter: sample_count=3D%d, comm_count=
=3D%d\n",
> >                      sample_count, comm_count);
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       evlist__close(evlist);
> > @@ -154,16 +154,16 @@ static int test__backward_ring_buffer(struct test=
_suite *test __maybe_unused, in
> >       if (err < 0) {
> >               pr_debug("perf_evlist__open: %s\n",
> >                        str_error_r(errno, sbuf, sizeof(sbuf)));
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       err =3D do_test(evlist, 1, &sample_count, &comm_count);
> >       if (err !=3D TEST_OK)
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >
> >       ret =3D TEST_OK;
> > -out_delete_evlist:
> > -     evlist__delete(evlist);
> > +out_put_evlist:
> > +     evlist__put(evlist);
> >       return ret;
> >  }
> >
> > diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-re=
ading.c
> > index 5927d1ea20e2..8da8951154d8 100644
> > --- a/tools/perf/tests/code-reading.c
> > +++ b/tools/perf/tests/code-reading.c
> > @@ -806,7 +806,7 @@ static int do_test_code_reading(bool try_kcore)
> >                       }
> >
> >                       perf_evlist__set_maps(&evlist->core, NULL, NULL);
> > -                     evlist__delete(evlist);
> > +                     evlist__put(evlist);
> >                       evlist =3D NULL;
> >                       continue;
> >               }
> > @@ -843,7 +843,7 @@ static int do_test_code_reading(bool try_kcore)
> >  out_put:
> >       thread__put(thread);
> >  out_err:
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >       perf_cpu_map__put(cpus);
> >       perf_thread_map__put(threads);
> >       machine__delete(machine);
> > diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-ti=
mes.c
> > index ae3b98bb42cf..94ab54ecd3f9 100644
> > --- a/tools/perf/tests/event-times.c
> > +++ b/tools/perf/tests/event-times.c
> > @@ -186,7 +186,7 @@ static int test_times(int (attach)(struct evlist *)=
,
> >       err =3D attach(evlist);
> >       if (err =3D=3D TEST_SKIP) {
> >               pr_debug("  SKIP  : not enough rights\n");
> > -             evlist__delete(evlist);
> > +             evlist__put(evlist);
> >               return err;
> >       }
> >
> > @@ -205,7 +205,7 @@ static int test_times(int (attach)(struct evlist *)=
,
> >                count.ena, count.run);
> >
> >  out_err:
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >       return !err ? TEST_OK : TEST_FAIL;
> >  }
> >
> > diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_u=
pdate.c
> > index cb9e6de2e033..8de66dac52b0 100644
> > --- a/tools/perf/tests/event_update.c
> > +++ b/tools/perf/tests/event_update.c
> > @@ -115,7 +115,7 @@ static int test__event_update(struct test_suite *te=
st __maybe_unused, int subtes
> >       TEST_ASSERT_VAL("failed to synthesize attr update cpus",
> >                       !perf_event__synthesize_event_update_cpus(&tmp.to=
ol, evsel, process_event_cpus));
> >
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >       return 0;
> >  }
> >
> > diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests=
/evsel-roundtrip-name.c
> > index 1922cac13a24..6a220634c52f 100644
> > --- a/tools/perf/tests/evsel-roundtrip-name.c
> > +++ b/tools/perf/tests/evsel-roundtrip-name.c
> > @@ -33,7 +33,7 @@ static int perf_evsel__roundtrip_cache_name_test(void=
)
> >                               if (err) {
> >                                       pr_debug("Failure to parse cache =
event '%s' possibly as PMUs don't support it",
> >                                               name);
> > -                                     evlist__delete(evlist);
> > +                                     evlist__put(evlist);
> >                                       continue;
> >                               }
> >                               evlist__for_each_entry(evlist, evsel) {
> > @@ -42,7 +42,7 @@ static int perf_evsel__roundtrip_cache_name_test(void=
)
> >                                               ret =3D TEST_FAIL;
> >                                       }
> >                               }
> > -                             evlist__delete(evlist);
> > +                             evlist__put(evlist);
> >                       }
> >               }
> >       }
> > @@ -66,7 +66,7 @@ static int perf_evsel__name_array_test(const char *co=
nst names[], int nr_names)
> >               if (err) {
> >                       pr_debug("failed to parse event '%s', err %d\n",
> >                                names[i], err);
> > -                     evlist__delete(evlist);
> > +                     evlist__put(evlist);
> >                       ret =3D TEST_FAIL;
> >                       continue;
> >               }
> > @@ -76,7 +76,7 @@ static int perf_evsel__name_array_test(const char *co=
nst names[], int nr_names)
> >                               ret =3D TEST_FAIL;
> >                       }
> >               }
> > -             evlist__delete(evlist);
> > +             evlist__put(evlist);
> >       }
> >       return ret;
> >  }
> > diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand=
-cgroup.c
> > index c7b32a220ca1..9060b085e3de 100644
> > --- a/tools/perf/tests/expand-cgroup.c
> > +++ b/tools/perf/tests/expand-cgroup.c
> > @@ -104,7 +104,7 @@ static int expand_default_events(void)
> >       TEST_ASSERT_VAL("failed to get evlist", evlist);
> >
> >       ret =3D test_expand_events(evlist);
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >       return ret;
> >  }
> >
> > @@ -131,7 +131,7 @@ static int expand_group_events(void)
> >       ret =3D test_expand_events(evlist);
> >  out:
> >       parse_events_error__exit(&err);
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >       return ret;
> >  }
> >
> > @@ -162,7 +162,7 @@ static int expand_libpfm_events(void)
> >
> >       ret =3D test_expand_events(evlist);
> >  out:
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >       return ret;
> >  }
> >
> > @@ -186,7 +186,7 @@ static int expand_metric_events(void)
> >       ret =3D test_expand_events(evlist);
> >
> >  out:
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >       return ret;
> >  }
> >
> > diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists=
_cumulate.c
> > index 3eb9ef8d7ec6..8f7cce7b5085 100644
> > --- a/tools/perf/tests/hists_cumulate.c
> > +++ b/tools/perf/tests/hists_cumulate.c
> > @@ -744,7 +744,7 @@ static int test__hists_cumulate(struct test_suite *=
test __maybe_unused, int subt
> >
> >  out:
> >       /* tear down everything */
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >       machines__exit(&machines);
> >       put_fake_samples();
> >
> > diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_f=
ilter.c
> > index 1cebd20cc91c..447fb2b5947c 100644
> > --- a/tools/perf/tests/hists_filter.c
> > +++ b/tools/perf/tests/hists_filter.c
> > @@ -331,7 +331,7 @@ static int test__hists_filter(struct test_suite *te=
st __maybe_unused, int subtes
> >
> >  out:
> >       /* tear down everything */
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >       reset_output_field();
> >       machines__exit(&machines);
> >       put_fake_samples();
> > diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_lin=
k.c
> > index 996f5f0b3bd1..9646c3b7b4de 100644
> > --- a/tools/perf/tests/hists_link.c
> > +++ b/tools/perf/tests/hists_link.c
> > @@ -352,7 +352,7 @@ static int test__hists_link(struct test_suite *test=
 __maybe_unused, int subtest
> >
> >  out:
> >       /* tear down everything */
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >       reset_output_field();
> >       machines__exit(&machines);
> >       put_fake_samples();
> > diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_o=
utput.c
> > index ee5ec8bda60e..aa8565fbaf90 100644
> > --- a/tools/perf/tests/hists_output.c
> > +++ b/tools/perf/tests/hists_output.c
> > @@ -631,7 +631,7 @@ static int test__hists_output(struct test_suite *te=
st __maybe_unused, int subtes
> >
> >  out:
> >       /* tear down everything */
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >       machines__exit(&machines);
> >       put_fake_samples();
> >
> > diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.=
c
> > index 97ea036ebae6..7d1040619575 100644
> > --- a/tools/perf/tests/hwmon_pmu.c
> > +++ b/tools/perf/tests/hwmon_pmu.c
> > @@ -211,7 +211,7 @@ static int do_test(size_t i, bool with_pmu, bool wi=
th_alias)
> >
> >  out:
> >       parse_events_error__exit(&err);
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >       return ret;
> >  }
> >
> > diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-t=
racking.c
> > index 729cc9cc1cb7..51cfd6522867 100644
> > --- a/tools/perf/tests/keep-tracking.c
> > +++ b/tools/perf/tests/keep-tracking.c
> > @@ -153,7 +153,7 @@ static int test__keep_tracking(struct test_suite *t=
est __maybe_unused, int subte
> >  out_err:
> >       if (evlist) {
> >               evlist__disable(evlist);
> > -             evlist__delete(evlist);
> > +             evlist__put(evlist);
> >       }
> >       perf_cpu_map__put(cpus);
> >       perf_thread_map__put(threads);
> > diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basi=
c.c
> > index a622bb8d4cc8..2591b6fbec3f 100644
> > --- a/tools/perf/tests/mmap-basic.c
> > +++ b/tools/perf/tests/mmap-basic.c
> > @@ -93,7 +93,7 @@ static int test__basic_mmap(struct test_suite *test _=
_maybe_unused, int subtest
> >                               /* Permissions failure, flag the failure =
as a skip. */
> >                               err =3D TEST_SKIP;
> >                       }
> > -                     goto out_delete_evlist;
> > +                     goto out_put_evlist;
> >               }
> >
> >               evsels[i]->core.attr.wakeup_events =3D 1;
> > @@ -105,7 +105,7 @@ static int test__basic_mmap(struct test_suite *test=
 __maybe_unused, int subtest
> >                       pr_debug("failed to open counter: %s, "
> >                                "tweak /proc/sys/kernel/perf_event_paran=
oid?\n",
> >                                str_error_r(errno, sbuf, sizeof(sbuf)));
> > -                     goto out_delete_evlist;
> > +                     goto out_put_evlist;
> >               }
> >
> >               nr_events[i] =3D 0;
> > @@ -115,7 +115,7 @@ static int test__basic_mmap(struct test_suite *test=
 __maybe_unused, int subtest
> >       if (evlist__mmap(evlist, 128) < 0) {
> >               pr_debug("failed to mmap events: %d (%s)\n", errno,
> >                        str_error_r(errno, sbuf, sizeof(sbuf)));
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       for (i =3D 0; i < nsyscalls; ++i)
> > @@ -133,7 +133,7 @@ static int test__basic_mmap(struct test_suite *test=
 __maybe_unused, int subtest
> >               if (event->header.type !=3D PERF_RECORD_SAMPLE) {
> >                       pr_debug("unexpected %s event\n",
> >                                perf_event__name(event->header.type));
> > -                     goto out_delete_evlist;
> > +                     goto out_put_evlist;
> >               }
> >
> >               perf_sample__init(&sample, /*all=3D*/false);
> > @@ -141,7 +141,7 @@ static int test__basic_mmap(struct test_suite *test=
 __maybe_unused, int subtest
> >               if (err) {
> >                       pr_err("Can't parse sample, err =3D %d\n", err);
> >                       perf_sample__exit(&sample);
> > -                     goto out_delete_evlist;
> > +                     goto out_put_evlist;
> >               }
> >
> >               err =3D -1;
> > @@ -150,7 +150,7 @@ static int test__basic_mmap(struct test_suite *test=
 __maybe_unused, int subtest
> >               if (evsel =3D=3D NULL) {
> >                       pr_debug("event with id %" PRIu64
> >                                " doesn't map to an evsel\n", sample.id)=
;
> > -                     goto out_delete_evlist;
> > +                     goto out_put_evlist;
> >               }
> >               nr_events[evsel->core.idx]++;
> >               perf_mmap__consume(&md->core);
> > @@ -165,12 +165,12 @@ static int test__basic_mmap(struct test_suite *te=
st __maybe_unused, int subtest
> >                                expected_nr_events[evsel->core.idx],
> >                                evsel__name(evsel), nr_events[evsel->cor=
e.idx]);
> >                       err =3D -1;
> > -                     goto out_delete_evlist;
> > +                     goto out_put_evlist;
> >               }
> >       }
> >
> > -out_delete_evlist:
> > -     evlist__delete(evlist);
> > +out_put_evlist:
> > +     evlist__put(evlist);
> >  out_free_cpus:
> >       perf_cpu_map__put(cpus);
> >  out_free_threads:
> > diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/t=
ests/openat-syscall-tp-fields.c
> > index 2a139d2781a8..3ff595c7a86a 100644
> > --- a/tools/perf/tests/openat-syscall-tp-fields.c
> > +++ b/tools/perf/tests/openat-syscall-tp-fields.c
> > @@ -51,7 +51,7 @@ static int test__syscall_openat_tp_fields(struct test=
_suite *test __maybe_unused
> >       if (IS_ERR(evsel)) {
> >               pr_debug("%s: evsel__newtp\n", __func__);
> >               ret =3D PTR_ERR(evsel) =3D=3D -EACCES ? TEST_SKIP : TEST_=
FAIL;
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       evlist__add(evlist, evsel);
> > @@ -59,7 +59,7 @@ static int test__syscall_openat_tp_fields(struct test=
_suite *test __maybe_unused
> >       err =3D evlist__create_maps(evlist, &opts.target);
> >       if (err < 0) {
> >               pr_debug("%s: evlist__create_maps\n", __func__);
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       evsel__config(evsel, &opts, NULL);
> > @@ -70,14 +70,14 @@ static int test__syscall_openat_tp_fields(struct te=
st_suite *test __maybe_unused
> >       if (err < 0) {
> >               pr_debug("perf_evlist__open: %s\n",
> >                        str_error_r(errno, sbuf, sizeof(sbuf)));
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       err =3D evlist__mmap(evlist, UINT_MAX);
> >       if (err < 0) {
> >               pr_debug("evlist__mmap: %s\n",
> >                        str_error_r(errno, sbuf, sizeof(sbuf)));
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       evlist__enable(evlist);
> > @@ -115,7 +115,7 @@ static int test__syscall_openat_tp_fields(struct te=
st_suite *test __maybe_unused
> >                               if (err) {
> >                                       pr_debug("Can't parse sample, err=
 =3D %d\n", err);
> >                                       perf_sample__exit(&sample);
> > -                                     goto out_delete_evlist;
> > +                                     goto out_put_evlist;
> >                               }
> >
> >                               tp_flags =3D evsel__intval(evsel, &sample=
, "flags");
> > @@ -123,7 +123,7 @@ static int test__syscall_openat_tp_fields(struct te=
st_suite *test __maybe_unused
> >                               if (flags !=3D tp_flags) {
> >                                       pr_debug("%s: Expected flags=3D%#=
x, got %#x\n",
> >                                                __func__, flags, tp_flag=
s);
> > -                                     goto out_delete_evlist;
> > +                                     goto out_put_evlist;
> >                               }
> >
> >                               goto out_ok;
> > @@ -136,13 +136,13 @@ static int test__syscall_openat_tp_fields(struct =
test_suite *test __maybe_unused
> >
> >               if (++nr_polls > 5) {
> >                       pr_debug("%s: no events!\n", __func__);
> > -                     goto out_delete_evlist;
> > +                     goto out_put_evlist;
> >               }
> >       }
> >  out_ok:
> >       ret =3D TEST_OK;
> > -out_delete_evlist:
> > -     evlist__delete(evlist);
> > +out_put_evlist:
> > +     evlist__put(evlist);
> >  out:
> >       return ret;
> >  }
> > diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-e=
vents.c
> > index e4cdb517c10e..0778462016f7 100644
> > --- a/tools/perf/tests/parse-events.c
> > +++ b/tools/perf/tests/parse-events.c
> > @@ -2550,7 +2550,7 @@ static int test_event(const struct evlist_test *e=
)
> >               ret =3D e->check(evlist);
> >       }
> >       parse_events_error__exit(&err);
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >
> >       return ret;
> >  }
> > @@ -2576,7 +2576,7 @@ static int test_event_fake_pmu(const char *str)
> >       }
> >
> >       parse_events_error__exit(&err);
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >
> >       return ret;
> >  }
> > diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-m=
etric.c
> > index 66a5275917e2..b343628c7a7e 100644
> > --- a/tools/perf/tests/parse-metric.c
> > +++ b/tools/perf/tests/parse-metric.c
> > @@ -83,7 +83,7 @@ static int __compute_metric(const char *name, struct =
value *vals,
> >
> >       cpus =3D perf_cpu_map__new("0");
> >       if (!cpus) {
> > -             evlist__delete(evlist);
> > +             evlist__put(evlist);
> >               return -ENOMEM;
> >       }
> >
> > @@ -112,7 +112,7 @@ static int __compute_metric(const char *name, struc=
t value *vals,
> >       /* ... cleanup. */
> >       evlist__free_stats(evlist);
> >       perf_cpu_map__put(cpus);
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >       return err;
> >  }
> >
> > diff --git a/tools/perf/tests/parse-no-sample-id-all.c b/tools/perf/tes=
ts/parse-no-sample-id-all.c
> > index 50e68b7d43aa..d5a8d065809e 100644
> > --- a/tools/perf/tests/parse-no-sample-id-all.c
> > +++ b/tools/perf/tests/parse-no-sample-id-all.c
> > @@ -49,7 +49,7 @@ static int process_events(union perf_event **events, =
size_t count)
> >       for (i =3D 0; i < count && !err; i++)
> >               err =3D process_event(&evlist, events[i]);
> >
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >
> >       return err;
> >  }
> > diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-rec=
ord.c
> > index efbd9cd60c63..babec674b83c 100644
> > --- a/tools/perf/tests/perf-record.c
> > +++ b/tools/perf/tests/perf-record.c
> > @@ -102,7 +102,7 @@ static int test__PERF_RECORD(struct test_suite *tes=
t __maybe_unused, int subtest
> >       err =3D evlist__create_maps(evlist, &opts.target);
> >       if (err < 0) {
> >               pr_debug("Not enough memory to create thread/cpu maps\n")=
;
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       /*
> > @@ -114,7 +114,7 @@ static int test__PERF_RECORD(struct test_suite *tes=
t __maybe_unused, int subtest
> >       err =3D evlist__prepare_workload(evlist, &opts.target, argv, fals=
e, NULL);
> >       if (err < 0) {
> >               pr_debug("Couldn't run the workload!\n");
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       /*
> > @@ -131,7 +131,7 @@ static int test__PERF_RECORD(struct test_suite *tes=
t __maybe_unused, int subtest
> >               pr_debug("sched__get_first_possible_cpu: %s\n",
> >                        str_error_r(errno, sbuf, sizeof(sbuf)));
> >               evlist__cancel_workload(evlist);
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       cpu =3D err;
> > @@ -143,7 +143,7 @@ static int test__PERF_RECORD(struct test_suite *tes=
t __maybe_unused, int subtest
> >               pr_debug("sched_setaffinity: %s\n",
> >                        str_error_r(errno, sbuf, sizeof(sbuf)));
> >               evlist__cancel_workload(evlist);
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       /*
> > @@ -155,7 +155,7 @@ static int test__PERF_RECORD(struct test_suite *tes=
t __maybe_unused, int subtest
> >               pr_debug("perf_evlist__open: %s\n",
> >                        str_error_r(errno, sbuf, sizeof(sbuf)));
> >               evlist__cancel_workload(evlist);
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       /*
> > @@ -168,7 +168,7 @@ static int test__PERF_RECORD(struct test_suite *tes=
t __maybe_unused, int subtest
> >               pr_debug("evlist__mmap: %s\n",
> >                        str_error_r(errno, sbuf, sizeof(sbuf)));
> >               evlist__cancel_workload(evlist);
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       /*
> > @@ -206,7 +206,7 @@ static int test__PERF_RECORD(struct test_suite *tes=
t __maybe_unused, int subtest
> >                                       if (verbose > 0)
> >                                               perf_event__fprintf(event=
, NULL, stderr);
> >                                       pr_debug("Couldn't parse sample\n=
");
> > -                                     goto out_delete_evlist;
> > +                                     goto out_put_evlist;
> >                               }
> >
> >                               if (verbose > 0) {
> > @@ -346,9 +346,9 @@ static int test__PERF_RECORD(struct test_suite *tes=
t __maybe_unused, int subtest
> >               pr_debug("PERF_RECORD_MMAP for %s missing!\n", "[vdso]");
> >               ++errs;
> >       }
> > -out_delete_evlist:
> > +out_put_evlist:
> >       CPU_FREE(cpu_mask);
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >  out:
> >       perf_sample__exit(&sample);
> >       if (err =3D=3D -EACCES)
> > diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/per=
f-time-to-tsc.c
> > index cca41bd37ae3..d3538fa20af3 100644
> > --- a/tools/perf/tests/perf-time-to-tsc.c
> > +++ b/tools/perf/tests/perf-time-to-tsc.c
> > @@ -201,7 +201,7 @@ static int test__perf_time_to_tsc(struct test_suite=
 *test __maybe_unused, int su
> >       err =3D TEST_OK;
> >
> >  out_err:
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >       perf_cpu_map__put(cpus);
> >       perf_thread_map__put(threads);
> >       return err;
> > diff --git a/tools/perf/tests/pfm.c b/tools/perf/tests/pfm.c
> > index 2e38dfa34b6c..099a50dec37e 100644
> > --- a/tools/perf/tests/pfm.c
> > +++ b/tools/perf/tests/pfm.c
> > @@ -79,7 +79,7 @@ static int test__pfm_events(struct test_suite *test _=
_maybe_unused,
> >                               evlist__nr_groups(evlist),
> >                               0);
> >
> > -             evlist__delete(evlist);
> > +             evlist__put(evlist);
> >       }
> >       return 0;
> >  }
> > @@ -164,7 +164,7 @@ static int test__pfm_group(struct test_suite *test =
__maybe_unused,
> >                               evlist__nr_groups(evlist),
> >                               table[i].nr_groups);
> >
> > -             evlist__delete(evlist);
> > +             evlist__put(evlist);
> >       }
> >       return 0;
> >  }
> > diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-event=
s.c
> > index f40a828c9861..ab547f301c61 100644
> > --- a/tools/perf/tests/pmu-events.c
> > +++ b/tools/perf/tests/pmu-events.c
> > @@ -797,7 +797,7 @@ static int check_parse_id(const char *id, struct pa=
rse_events_error *error)
> >                            /*warn_if_reordered=3D*/true, /*fake_tp=3D*/=
false);
> >       free(dup);
> >
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >       return ret;
> >  }
> >
> > @@ -844,7 +844,7 @@ static int test__parsing_callback(const struct pmu_=
metric *pm,
> >
> >       cpus =3D perf_cpu_map__new("0");
> >       if (!cpus) {
> > -             evlist__delete(evlist);
> > +             evlist__put(evlist);
> >               return -ENOMEM;
> >       }
> >
> > @@ -901,7 +901,7 @@ static int test__parsing_callback(const struct pmu_=
metric *pm,
> >       /* ... cleanup. */
> >       evlist__free_stats(evlist);
> >       perf_cpu_map__put(cpus);
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >       return err;
> >  }
> >
> > diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
> > index cbded2c6faa4..bd3f4a2806ed 100644
> > --- a/tools/perf/tests/pmu.c
> > +++ b/tools/perf/tests/pmu.c
> > @@ -249,7 +249,7 @@ static int test__pmu_events(struct test_suite *test=
 __maybe_unused, int subtest
> >       ret =3D TEST_OK;
> >  err_out:
> >       parse_events_error__exit(&err);
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >       test_pmu_put(dir, pmu);
> >       return ret;
> >  }
> > diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
> > index 4a2ad7176fa0..f7f1f16638b4 100644
> > --- a/tools/perf/tests/sw-clock.c
> > +++ b/tools/perf/tests/sw-clock.c
> > @@ -58,7 +58,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clo=
ck_id)
> >       evsel =3D evsel__new(&attr);
> >       if (evsel =3D=3D NULL) {
> >               pr_debug("evsel__new\n");
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >       evlist__add(evlist, evsel);
> >
> > @@ -67,7 +67,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clo=
ck_id)
> >       if (!cpus || !threads) {
> >               err =3D -ENOMEM;
> >               pr_debug("Not enough memory to create thread/cpu maps\n")=
;
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       perf_evlist__set_maps(&evlist->core, cpus, threads);
> > @@ -79,14 +79,14 @@ static int __test__sw_clock_freq(enum perf_sw_ids c=
lock_id)
> >               pr_debug("Couldn't open evlist: %s\nHint: check %s, using=
 %" PRIu64 " in this test.\n",
> >                        str_error_r(errno, sbuf, sizeof(sbuf)),
> >                        knob, (u64)attr.sample_freq);
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       err =3D evlist__mmap(evlist, 128);
> >       if (err < 0) {
> >               pr_debug("failed to mmap event: %d (%s)\n", errno,
> >                        str_error_r(errno, sbuf, sizeof(sbuf)));
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       evlist__enable(evlist);
> > @@ -112,7 +112,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids c=
lock_id)
> >               if (err < 0) {
> >                       pr_debug("Error during parse sample\n");
> >                       perf_sample__exit(&sample);
> > -                     goto out_delete_evlist;
> > +                     goto out_put_evlist;
> >               }
> >
> >               total_periods +=3D sample.period;
> > @@ -130,10 +130,10 @@ static int __test__sw_clock_freq(enum perf_sw_ids=
 clock_id)
> >               err =3D -1;
> >       }
> >
> > -out_delete_evlist:
> > +out_put_evlist:
> >       perf_cpu_map__put(cpus);
> >       perf_thread_map__put(threads);
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >       return err;
> >  }
> >
> > diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/swit=
ch-tracking.c
> > index 15791fcb76b2..c3d5825df0a8 100644
> > --- a/tools/perf/tests/switch-tracking.c
> > +++ b/tools/perf/tests/switch-tracking.c
> > @@ -577,7 +577,7 @@ static int test__switch_tracking(struct test_suite =
*test __maybe_unused, int sub
> >  out:
> >       if (evlist) {
> >               evlist__disable(evlist);
> > -             evlist__delete(evlist);
> > +             evlist__put(evlist);
> >       }
> >       perf_cpu_map__put(cpus);
> >       perf_thread_map__put(threads);
> > diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.=
c
> > index 4053ff2813bb..a46650b10689 100644
> > --- a/tools/perf/tests/task-exit.c
> > +++ b/tools/perf/tests/task-exit.c
> > @@ -74,7 +74,7 @@ static int test__task_exit(struct test_suite *test __=
maybe_unused, int subtest _
> >       if (!cpus || !threads) {
> >               err =3D -ENOMEM;
> >               pr_debug("Not enough memory to create thread/cpu maps\n")=
;
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       perf_evlist__set_maps(&evlist->core, cpus, threads);
> > @@ -82,7 +82,7 @@ static int test__task_exit(struct test_suite *test __=
maybe_unused, int subtest _
> >       err =3D evlist__prepare_workload(evlist, &target, argv, false, wo=
rkload_exec_failed_signal);
> >       if (err < 0) {
> >               pr_debug("Couldn't run the workload!\n");
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       evsel =3D evlist__first(evlist);
> > @@ -101,14 +101,14 @@ static int test__task_exit(struct test_suite *tes=
t __maybe_unused, int subtest _
> >       if (err < 0) {
> >               pr_debug("Couldn't open the evlist: %s\n",
> >                        str_error_r(-err, sbuf, sizeof(sbuf)));
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       if (evlist__mmap(evlist, 128) < 0) {
> >               pr_debug("failed to mmap events: %d (%s)\n", errno,
> >                        str_error_r(errno, sbuf, sizeof(sbuf)));
> >               err =3D -1;
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >       }
> >
> >       evlist__start_workload(evlist);
> > @@ -133,7 +133,7 @@ static int test__task_exit(struct test_suite *test =
__maybe_unused, int subtest _
> >               if (retry_count++ > 1000) {
> >                       pr_debug("Failed after retrying 1000 times\n");
> >                       err =3D -1;
> > -                     goto out_delete_evlist;
> > +                     goto out_put_evlist;
> >               }
> >
> >               goto retry;
> > @@ -144,10 +144,10 @@ static int test__task_exit(struct test_suite *tes=
t __maybe_unused, int subtest _
> >               err =3D -1;
> >       }
> >
> > -out_delete_evlist:
> > +out_put_evlist:
> >       perf_cpu_map__put(cpus);
> >       perf_thread_map__put(threads);
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >       return err;
> >  }
> >
> > diff --git a/tools/perf/tests/tool_pmu.c b/tools/perf/tests/tool_pmu.c
> > index 1e900ef92e37..e78ff9dcea97 100644
> > --- a/tools/perf/tests/tool_pmu.c
> > +++ b/tools/perf/tests/tool_pmu.c
> > @@ -67,7 +67,7 @@ static int do_test(enum tool_pmu_event ev, bool with_=
pmu)
> >
> >  out:
> >       parse_events_error__exit(&err);
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >       return ret;
> >  }
> >
> > diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
> > index af4618c3124a..b88447899021 100644
> > --- a/tools/perf/tests/topology.c
> > +++ b/tools/perf/tests/topology.c
> > @@ -55,7 +55,7 @@ static int session_write_header(char *path)
> >                       !perf_session__write_header(session, session->evl=
ist,
> >                                                   perf_data__fd(&data),=
 true));
> >
> > -     evlist__delete(session->evlist);
> > +     evlist__put(session->evlist);
> >       perf_session__delete(session);
> >
> >       return 0;
> > diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> > index 25e2769b5e74..ed230cd44ba7 100644
> > --- a/tools/perf/util/cgroup.c
> > +++ b/tools/perf/util/cgroup.c
> > @@ -503,8 +503,8 @@ int evlist__expand_cgroup(struct evlist *evlist, co=
nst char *str, bool open_cgro
> >       cgrp_event_expanded =3D true;
> >
> >  out_err:
> > -     evlist__delete(orig_list);
> > -     evlist__delete(tmp_list);
> > +     evlist__put(orig_list);
> > +     evlist__put(tmp_list);
> >       metricgroup__rblist_exit(&orig_metric_events);
> >       release_cgroup_list();
> >
> > diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-c=
onvert-bt.c
> > index 3d2e437e1354..1166cdb00aca 100644
> > --- a/tools/perf/util/data-convert-bt.c
> > +++ b/tools/perf/util/data-convert-bt.c
> > @@ -1331,7 +1331,7 @@ static void cleanup_events(struct perf_session *s=
ession)
> >               zfree(&evsel->priv);
> >       }
> >
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >       session->evlist =3D NULL;
> >  }
> >
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index d99a3f12606f..ea1f398c14e3 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -73,7 +73,7 @@ int sigqueue(pid_t pid, int sig, const union sigval v=
alue);
> >  #define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
> >  #define SID(e, x, y) xyarray__entry(e->core.sample_id, x, y)
> >
> > -void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
> > +static void evlist__init(struct evlist *evlist, struct perf_cpu_map *c=
pus,
> >                 struct perf_thread_map *threads)
> >  {
> >       perf_evlist__init(&evlist->core);
> > @@ -85,6 +85,7 @@ void evlist__init(struct evlist *evlist, struct perf_=
cpu_map *cpus,
> >       evlist->ctl_fd.pos =3D -1;
> >       evlist->nr_br_cntr =3D -1;
> >       metricgroup__rblist_init(&evlist->metric_events);
> > +     refcount_set(&evlist->refcnt, 1);
> >  }
> >
> >  struct evlist *evlist__new(void)
> > @@ -116,7 +117,7 @@ struct evlist *evlist__new_default(void)
> >                        can_profile_kernel ? "P" : "Pu");
> >               err =3D parse_event(evlist, buf);
> >               if (err) {
> > -                     evlist__delete(evlist);
> > +                     evlist__put(evlist);
> >                       return NULL;
> >               }
> >       }
> > @@ -136,13 +137,19 @@ struct evlist *evlist__new_dummy(void)
> >       struct evlist *evlist =3D evlist__new();
> >
> >       if (evlist && evlist__add_dummy(evlist)) {
> > -             evlist__delete(evlist);
> > +             evlist__put(evlist);
> >               evlist =3D NULL;
> >       }
> >
> >       return evlist;
> >  }
> >
> > +struct evlist *evlist__get(struct evlist *evlist)
> > +{
> > +     refcount_inc(&evlist->refcnt);
> > +     return evlist;
> > +}
> > +
> >  /**
> >   * evlist__set_id_pos - set the positions of event ids.
> >   * @evlist: selected event list
> > @@ -181,7 +188,7 @@ static void evlist__purge(struct evlist *evlist)
> >       evlist->core.nr_entries =3D 0;
> >  }
> >
> > -void evlist__exit(struct evlist *evlist)
> > +static void evlist__exit(struct evlist *evlist)
> >  {
> >       metricgroup__rblist_exit(&evlist->metric_events);
> >       event_enable_timer__exit(&evlist->eet);
> > @@ -190,11 +197,14 @@ void evlist__exit(struct evlist *evlist)
> >       perf_evlist__exit(&evlist->core);
> >  }
> >
> > -void evlist__delete(struct evlist *evlist)
> > +void evlist__put(struct evlist *evlist)
> >  {
> >       if (evlist =3D=3D NULL)
> >               return;
> >
> > +     if (!refcount_dec_and_test(&evlist->refcnt))
> > +             return;
> > +
> >       evlist__free_stats(evlist);
> >       evlist__munmap(evlist);
> >       evlist__close(evlist);
> > diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> > index 61acbb10d9a5..66fb5da08160 100644
> > --- a/tools/perf/util/evlist.h
> > +++ b/tools/perf/util/evlist.h
> > @@ -59,6 +59,7 @@ struct event_enable_timer;
> >
> >  struct evlist {
> >       struct perf_evlist core;
> > +     refcount_t       refcnt;
> >       bool             enabled;
> >       int              id_pos;
> >       int              is_pos;
> > @@ -104,10 +105,8 @@ struct evsel_str_handler {
> >  struct evlist *evlist__new(void);
> >  struct evlist *evlist__new_default(void);
> >  struct evlist *evlist__new_dummy(void);
> > -void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
> > -               struct perf_thread_map *threads);
> > -void evlist__exit(struct evlist *evlist);
> > -void evlist__delete(struct evlist *evlist);
> > +struct evlist *evlist__get(struct evlist *evlist);
> > +void evlist__put(struct evlist *evlist);
> >
> >  void evlist__add(struct evlist *evlist, struct evsel *entry);
> >  void evlist__remove(struct evlist *evlist, struct evsel *evsel);
> > diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> > index 7fda0ff89c16..4304b53b5a37 100644
> > --- a/tools/perf/util/expr.c
> > +++ b/tools/perf/util/expr.c
> > @@ -451,7 +451,7 @@ double expr__has_event(const struct expr_parse_ctx =
*ctx, bool compute_ids, const
> >               ret =3D parse_event(tmp, id) ? 0 : 1;
> >       }
> >  out:
> > -     evlist__delete(tmp);
> > +     evlist__put(tmp);
> >       return ret;
> >  }
> >
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index 4f2a6e10ed5c..e959ddb12dc8 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -4307,12 +4307,12 @@ int perf_session__read_header(struct perf_sessi=
on *session)
> >               evsel =3D evsel__new(&f_attr.attr);
> >
> >               if (evsel =3D=3D NULL)
> > -                     goto out_delete_evlist;
> > +                     goto out_put_evlist;
> >
> >               evsel->needs_swap =3D header->needs_swap;
> >               /*
> >                * Do it before so that if perf_evsel__alloc_id fails, th=
is
> > -              * entry gets purged too at evlist__delete().
> > +              * entry gets purged too at evlist__put().
> >                */
> >               evlist__add(session->evlist, evsel);
> >
> > @@ -4323,7 +4323,7 @@ int perf_session__read_header(struct perf_session=
 *session)
> >                * hattr->ids threads.
> >                */
> >               if (perf_evsel__alloc_id(&evsel->core, 1, nr_ids))
> > -                     goto out_delete_evlist;
> > +                     goto out_put_evlist;
> >
> >               lseek(fd, f_attr.ids.offset, SEEK_SET);
> >
> > @@ -4342,7 +4342,7 @@ int perf_session__read_header(struct perf_session=
 *session)
> >                                     perf_file_section__process);
> >
> >       if (evlist__prepare_tracepoint_events(session->evlist, session->t=
event.pevent))
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >  #else
> >       perf_header__process_sections(header, fd, NULL, perf_file_section=
__process);
> >  #endif
> > @@ -4351,8 +4351,8 @@ int perf_session__read_header(struct perf_session=
 *session)
> >  out_errno:
> >       return -errno;
> >
> > -out_delete_evlist:
> > -     evlist__delete(session->evlist);
> > +out_put_evlist:
> > +     evlist__put(session->evlist);
> >       session->evlist =3D NULL;
> >       return -ENOMEM;
> >  }
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgrou=
p.c
> > index 595b83142d2c..64c64dff7424 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -212,7 +212,7 @@ static void metric__free(struct metric *m)
> >       zfree(&m->metric_refs);
> >       expr__ctx_free(m->pctx);
> >       zfree(&m->modifier);
> > -     evlist__delete(m->evlist);
> > +     evlist__put(m->evlist);
> >       free(m);
> >  }
> >
> > @@ -1318,7 +1318,7 @@ static int parse_ids(bool metric_no_merge, bool f=
ake_pmu,
> >       parsed_evlist =3D NULL;
> >  err_out:
> >       parse_events_error__exit(&parse_error);
> > -     evlist__delete(parsed_evlist);
> > +     evlist__put(parsed_evlist);
> >       strbuf_release(&events);
> >       return ret;
> >  }
> > @@ -1470,7 +1470,7 @@ static int parse_groups(struct evlist *perf_evlis=
t,
> >
> >       if (combined_evlist) {
> >               evlist__splice_list_tail(perf_evlist, &combined_evlist->c=
ore.entries);
> > -             evlist__delete(combined_evlist);
> > +             evlist__put(combined_evlist);
> >       }
> >
> >       list_for_each_entry(m, &metric_list, nd) {
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-eve=
nts.c
> > index 0c0dc20b1c13..607ab7b82486 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -2223,7 +2223,7 @@ int __parse_events(struct evlist *evlist, const c=
har *str, const char *pmu_filte
> >
> >       /*
> >        * There are 2 users - builtin-record and builtin-test objects.
> > -      * Both call evlist__delete in case of error, so we dont
> > +      * Both call evlist__put in case of error, so we dont
> >        * need to bother.
> >        */
> >       return ret;
> > @@ -2424,7 +2424,7 @@ int parse_events_option_new_evlist(const struct o=
ption *opt, const char *str, in
> >       }
> >       ret =3D parse_events_option(opt, str, unset);
> >       if (ret) {
> > -             evlist__delete(*args->evlistp);
> > +             evlist__put(*args->evlistp);
> >               *args->evlistp =3D NULL;
> >       }
> >
> > diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_ap=
i_probe.c
> > index 3345145a9307..8cd254d36220 100644
> > --- a/tools/perf/util/perf_api_probe.c
> > +++ b/tools/perf/util/perf_api_probe.c
> > @@ -56,7 +56,7 @@ static int perf_do_probe_api(setup_probe_fn_t fn, str=
uct perf_cpu cpu, const cha
> >       err =3D 0;
> >
> >  out_delete:
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >       return err;
> >  }
> >
> > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > index dfc6e9299af9..4149a51e9878 100644
> > --- a/tools/perf/util/python.c
> > +++ b/tools/perf/util/python.c
> > @@ -1273,7 +1273,7 @@ static int pyrf_evsel__setup_types(void)
> >  struct pyrf_evlist {
> >       PyObject_HEAD
> >
> > -     struct evlist evlist;
> > +     struct evlist *evlist;
> >  };
> >
> >  static int pyrf_evlist__init(struct pyrf_evlist *pevlist,
> > @@ -1286,15 +1286,21 @@ static int pyrf_evlist__init(struct pyrf_evlist=
 *pevlist,
> >       if (!PyArg_ParseTuple(args, "OO", &pcpus, &pthreads))
> >               return -1;
> >
> > +     pevlist->evlist =3D evlist__new();
> > +     if (!pevlist->evlist) {
> > +             PyErr_NoMemory();
> > +             return -1;
> > +     }
> >       threads =3D ((struct pyrf_thread_map *)pthreads)->threads;
> >       cpus =3D ((struct pyrf_cpu_map *)pcpus)->cpus;
> > -     evlist__init(&pevlist->evlist, cpus, threads);
> > +     perf_evlist__set_maps(&pevlist->evlist->core, cpus, threads);
> > +
> >       return 0;
> >  }
> >
> >  static void pyrf_evlist__delete(struct pyrf_evlist *pevlist)
> >  {
> > -     evlist__exit(&pevlist->evlist);
> > +     evlist__put(pevlist->evlist);
> >       Py_TYPE(pevlist)->tp_free((PyObject*)pevlist);
> >  }
> >
> > @@ -1303,7 +1309,7 @@ static PyObject *pyrf_evlist__all_cpus(struct pyr=
f_evlist *pevlist)
> >       struct pyrf_cpu_map *pcpu_map =3D PyObject_New(struct pyrf_cpu_ma=
p, &pyrf_cpu_map__type);
> >
> >       if (pcpu_map)
> > -             pcpu_map->cpus =3D perf_cpu_map__get(pevlist->evlist.core=
.all_cpus);
> > +             pcpu_map->cpus =3D perf_cpu_map__get(pevlist->evlist->cor=
e.all_cpus);
> >
> >       return (PyObject *)pcpu_map;
> >  }
> > @@ -1316,7 +1322,7 @@ static PyObject *pyrf_evlist__metrics(struct pyrf=
_evlist *pevlist)
> >       if (!list)
> >               return NULL;
> >
> > -     for (node =3D rb_first_cached(&pevlist->evlist.metric_events.entr=
ies); node;
> > +     for (node =3D rb_first_cached(&pevlist->evlist->metric_events.ent=
ries); node;
> >            node =3D rb_next(node)) {
> >               struct metric_event *me =3D container_of(node, struct met=
ric_event, nd);
> >               struct list_head *pos;
> > @@ -1400,7 +1406,7 @@ static PyObject *pyrf_evlist__compute_metric(stru=
ct pyrf_evlist *pevlist,
> >       if (!PyArg_ParseTuple(args, "sii", &metric, &cpu, &thread))
> >               return NULL;
> >
> > -     for (node =3D rb_first_cached(&pevlist->evlist.metric_events.entr=
ies);
> > +     for (node =3D rb_first_cached(&pevlist->evlist->metric_events.ent=
ries);
> >            mexp =3D=3D NULL && node;
> >            node =3D rb_next(node)) {
> >               struct metric_event *me =3D container_of(node, struct met=
ric_event, nd);
> > @@ -1456,7 +1462,7 @@ static PyObject *pyrf_evlist__compute_metric(stru=
ct pyrf_evlist *pevlist,
> >  static PyObject *pyrf_evlist__mmap(struct pyrf_evlist *pevlist,
> >                                  PyObject *args, PyObject *kwargs)
> >  {
> > -     struct evlist *evlist =3D &pevlist->evlist;
> > +     struct evlist *evlist =3D pevlist->evlist;
> >       static char *kwlist[] =3D { "pages", "overwrite", NULL };
> >       int pages =3D 128, overwrite =3D false;
> >
> > @@ -1476,7 +1482,7 @@ static PyObject *pyrf_evlist__mmap(struct pyrf_ev=
list *pevlist,
> >  static PyObject *pyrf_evlist__poll(struct pyrf_evlist *pevlist,
> >                                  PyObject *args, PyObject *kwargs)
> >  {
> > -     struct evlist *evlist =3D &pevlist->evlist;
> > +     struct evlist *evlist =3D pevlist->evlist;
> >       static char *kwlist[] =3D { "timeout", NULL };
> >       int timeout =3D -1, n;
> >
> > @@ -1496,7 +1502,7 @@ static PyObject *pyrf_evlist__get_pollfd(struct p=
yrf_evlist *pevlist,
> >                                        PyObject *args __maybe_unused,
> >                                        PyObject *kwargs __maybe_unused)
> >  {
> > -     struct evlist *evlist =3D &pevlist->evlist;
> > +     struct evlist *evlist =3D pevlist->evlist;
> >          PyObject *list =3D PyList_New(0);
> >       int i;
> >
> > @@ -1525,7 +1531,7 @@ static PyObject *pyrf_evlist__add(struct pyrf_evl=
ist *pevlist,
> >                                 PyObject *args,
> >                                 PyObject *kwargs __maybe_unused)
> >  {
> > -     struct evlist *evlist =3D &pevlist->evlist;
> > +     struct evlist *evlist =3D pevlist->evlist;
> >       PyObject *pevsel;
> >       struct evsel *evsel;
> >
> > @@ -1557,7 +1563,7 @@ static struct mmap *get_md(struct evlist *evlist,=
 int cpu)
> >  static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
> >                                         PyObject *args, PyObject *kwarg=
s)
> >  {
> > -     struct evlist *evlist =3D &pevlist->evlist;
> > +     struct evlist *evlist =3D pevlist->evlist;
> >       union perf_event *event;
> >       int sample_id_all =3D 1, cpu;
> >       static char *kwlist[] =3D { "cpu", "sample_id_all", NULL };
> > @@ -1614,7 +1620,7 @@ static PyObject *pyrf_evlist__read_on_cpu(struct =
pyrf_evlist *pevlist,
> >  static PyObject *pyrf_evlist__open(struct pyrf_evlist *pevlist,
> >                                  PyObject *args, PyObject *kwargs)
> >  {
> > -     struct evlist *evlist =3D &pevlist->evlist;
> > +     struct evlist *evlist =3D pevlist->evlist;
> >
> >       if (evlist__open(evlist) < 0) {
> >               PyErr_SetFromErrno(PyExc_OSError);
> > @@ -1627,7 +1633,7 @@ static PyObject *pyrf_evlist__open(struct pyrf_ev=
list *pevlist,
> >
> >  static PyObject *pyrf_evlist__close(struct pyrf_evlist *pevlist)
> >  {
> > -     struct evlist *evlist =3D &pevlist->evlist;
> > +     struct evlist *evlist =3D pevlist->evlist;
> >
> >       evlist__close(evlist);
> >
> > @@ -1653,7 +1659,7 @@ static PyObject *pyrf_evlist__config(struct pyrf_=
evlist *pevlist)
> >               .no_buffering        =3D true,
> >               .no_inherit          =3D true,
> >       };
> > -     struct evlist *evlist =3D &pevlist->evlist;
> > +     struct evlist *evlist =3D pevlist->evlist;
> >
> >       evlist__config(evlist, &opts, &callchain_param);
> >       Py_INCREF(Py_None);
> > @@ -1662,14 +1668,14 @@ static PyObject *pyrf_evlist__config(struct pyr=
f_evlist *pevlist)
> >
> >  static PyObject *pyrf_evlist__disable(struct pyrf_evlist *pevlist)
> >  {
> > -     evlist__disable(&pevlist->evlist);
> > +     evlist__disable(pevlist->evlist);
> >       Py_INCREF(Py_None);
> >       return Py_None;
> >  }
> >
> >  static PyObject *pyrf_evlist__enable(struct pyrf_evlist *pevlist)
> >  {
> > -     evlist__enable(&pevlist->evlist);
> > +     evlist__enable(pevlist->evlist);
> >       Py_INCREF(Py_None);
> >       return Py_None;
> >  }
> > @@ -1760,7 +1766,23 @@ static Py_ssize_t pyrf_evlist__length(PyObject *=
obj)
> >  {
> >       struct pyrf_evlist *pevlist =3D (void *)obj;
> >
> > -     return pevlist->evlist.core.nr_entries;
> > +     return pevlist->evlist->core.nr_entries;
> > +}
> > +
> > +static PyObject *pyrf_evsel__from_evsel(struct evsel *evsel)
> > +{
> > +     struct pyrf_evsel *pevsel =3D PyObject_New(struct pyrf_evsel, &py=
rf_evsel__type);
> > +
> > +     if (!pevsel)
> > +             return NULL;
> > +
> > +     memset(&pevsel->evsel, 0, sizeof(pevsel->evsel));
> > +     evsel__init(&pevsel->evsel, &evsel->core.attr, evsel->core.idx);
> > +
> > +     evsel__clone(&pevsel->evsel, evsel);
> > +     if (evsel__is_group_leader(evsel))
> > +             evsel__set_leader(&pevsel->evsel, &pevsel->evsel);
> > +     return (PyObject *)pevsel;
> >  }
> >
> >  static PyObject *pyrf_evlist__item(PyObject *obj, Py_ssize_t i)
> > @@ -1768,17 +1790,16 @@ static PyObject *pyrf_evlist__item(PyObject *ob=
j, Py_ssize_t i)
> >       struct pyrf_evlist *pevlist =3D (void *)obj;
> >       struct evsel *pos;
> >
> > -     if (i >=3D pevlist->evlist.core.nr_entries) {
> > +     if (i >=3D pevlist->evlist->core.nr_entries) {
> >               PyErr_SetString(PyExc_IndexError, "Index out of range");
> >               return NULL;
> >       }
> >
> > -     evlist__for_each_entry(&pevlist->evlist, pos) {
> > +     evlist__for_each_entry(pevlist->evlist, pos) {
> >               if (i-- =3D=3D 0)
> >                       break;
> >       }
> > -
> > -     return Py_BuildValue("O", container_of(pos, struct pyrf_evsel, ev=
sel));
> > +     return pyrf_evsel__from_evsel(pos);
> >  }
> >
> >  static PyObject *pyrf_evlist__str(PyObject *self)
> > @@ -1790,7 +1811,7 @@ static PyObject *pyrf_evlist__str(PyObject *self)
> >       PyObject *result;
> >
> >       strbuf_addstr(&sb, "evlist([");
> > -     evlist__for_each_entry(&pevlist->evlist, pos) {
> > +     evlist__for_each_entry(pevlist->evlist, pos) {
> >               if (!first)
> >                       strbuf_addch(&sb, ',');
> >               if (!pos->pmu)
> > @@ -1931,110 +1952,30 @@ static PyObject *pyrf__tracepoint(struct pyrf_=
evsel *pevsel,
> >       return PyLong_FromLong(tp_pmu__id(sys, name));
> >  }
> >
> > -static PyObject *pyrf_evsel__from_evsel(struct evsel *evsel)
> > -{
> > -     struct pyrf_evsel *pevsel =3D PyObject_New(struct pyrf_evsel, &py=
rf_evsel__type);
> > -
> > -     if (!pevsel)
> > -             return NULL;
> > -
> > -     memset(&pevsel->evsel, 0, sizeof(pevsel->evsel));
> > -     evsel__init(&pevsel->evsel, &evsel->core.attr, evsel->core.idx);
> > -
> > -     evsel__clone(&pevsel->evsel, evsel);
> > -     if (evsel__is_group_leader(evsel))
> > -             evsel__set_leader(&pevsel->evsel, &pevsel->evsel);
> > -     return (PyObject *)pevsel;
> > -}
> > -
> > -static int evlist__pos(struct evlist *evlist, struct evsel *evsel)
> > -{
> > -     struct evsel *pos;
> > -     int idx =3D 0;
> > -
> > -     evlist__for_each_entry(evlist, pos) {
> > -             if (evsel =3D=3D pos)
> > -                     return idx;
> > -             idx++;
> > -     }
> > -     return -1;
> > -}
> > -
> > -static struct evsel *evlist__at(struct evlist *evlist, int idx)
> > -{
> > -     struct evsel *pos;
> > -     int idx2 =3D 0;
> > -
> > -     evlist__for_each_entry(evlist, pos) {
> > -             if (idx =3D=3D idx2)
> > -                     return pos;
> > -             idx2++;
> > -     }
> > -     return NULL;
> > -}
> > -
> >  static PyObject *pyrf_evlist__from_evlist(struct evlist *evlist)
> >  {
> >       struct pyrf_evlist *pevlist =3D PyObject_New(struct pyrf_evlist, =
&pyrf_evlist__type);
> > -     struct evsel *pos;
> > -     struct rb_node *node;
> >
> >       if (!pevlist)
> >               return NULL;
> >
> > -     memset(&pevlist->evlist, 0, sizeof(pevlist->evlist));
> > -     evlist__init(&pevlist->evlist, evlist->core.all_cpus, evlist->cor=
e.threads);
> > -     evlist__for_each_entry(evlist, pos) {
> > -             struct pyrf_evsel *pevsel =3D (void *)pyrf_evsel__from_ev=
sel(pos);
> > -
> > -             evlist__add(&pevlist->evlist, &pevsel->evsel);
> > -     }
> > -     evlist__for_each_entry(&pevlist->evlist, pos) {
> > -             struct evsel *leader =3D evsel__leader(pos);
> > -
> > -             if (pos !=3D leader) {
> > -                     int idx =3D evlist__pos(evlist, leader);
> > -
> > -                     if (idx >=3D 0)
> > -                             evsel__set_leader(pos, evlist__at(&pevlis=
t->evlist, idx));
> > -                     else if (leader =3D=3D NULL)
> > -                             evsel__set_leader(pos, pos);
> > -             }
> > -     }
> > -     metricgroup__copy_metric_events(&pevlist->evlist, /*cgrp=3D*/NULL=
,
> > -                                     &pevlist->evlist.metric_events,
> > -                                     &evlist->metric_events);
> > -     for (node =3D rb_first_cached(&pevlist->evlist.metric_events.entr=
ies); node;
> > -          node =3D rb_next(node)) {
> > -             struct metric_event *me =3D container_of(node, struct met=
ric_event, nd);
> > -             struct list_head *mpos;
> > -             int idx =3D evlist__pos(evlist, me->evsel);
> > -
> > -             if (idx >=3D 0)
> > -                     me->evsel =3D evlist__at(&pevlist->evlist, idx);
> > -             list_for_each(mpos, &me->head) {
> > -                     struct metric_expr *e =3D container_of(mpos, stru=
ct metric_expr, nd);
> > -
> > -                     for (int j =3D 0; e->metric_events[j]; j++) {
> > -                             idx =3D evlist__pos(evlist, e->metric_eve=
nts[j]);
> > -                             if (idx >=3D 0)
> > -                                     e->metric_events[j] =3D evlist__a=
t(&pevlist->evlist, idx);
> > -                     }
> > -             }
> > -     }
> > +     pevlist->evlist =3D evlist__get(evlist);
> >       return (PyObject *)pevlist;
> >  }
> >
> >  static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
> >  {
> >       const char *input;
> > -     struct evlist evlist =3D {};
> > +     struct evlist *evlist =3D evlist__new();
> >       struct parse_events_error err;
> >       PyObject *result;
> >       PyObject *pcpus =3D NULL, *pthreads =3D NULL;
> >       struct perf_cpu_map *cpus;
> >       struct perf_thread_map *threads;
> >
> > +     if (!evlist)
> > +             return PyErr_NoMemory();
> > +
> >       if (!PyArg_ParseTuple(args, "s|OO", &input, &pcpus, &pthreads))
> >               return NULL;
> >
> > @@ -2042,35 +1983,38 @@ static PyObject *pyrf__parse_events(PyObject *s=
elf, PyObject *args)
> >       cpus =3D pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
> >
> >       parse_events_error__init(&err);
> > -     evlist__init(&evlist, cpus, threads);
> > -     if (parse_events(&evlist, input, &err)) {
> > +     perf_evlist__set_maps(&evlist->core, cpus, threads);
> > +     if (parse_events(evlist, input, &err)) {
> >               parse_events_error__print(&err, input);
> >               PyErr_SetFromErrno(PyExc_OSError);
> >               return NULL;
> >       }
> > -     result =3D pyrf_evlist__from_evlist(&evlist);
> > -     evlist__exit(&evlist);
> > +     result =3D pyrf_evlist__from_evlist(evlist);
> > +     evlist__put(evlist);
> >       return result;
> >  }
> >
> >  static PyObject *pyrf__parse_metrics(PyObject *self, PyObject *args)
> >  {
> >       const char *input, *pmu =3D NULL;
> > -     struct evlist evlist =3D {};
> > +     struct evlist *evlist =3D evlist__new();
> >       PyObject *result;
> >       PyObject *pcpus =3D NULL, *pthreads =3D NULL;
> >       struct perf_cpu_map *cpus;
> >       struct perf_thread_map *threads;
> >       int ret;
> >
> > +     if (!evlist)
> > +             return PyErr_NoMemory();
> > +
> >       if (!PyArg_ParseTuple(args, "s|sOO", &input, &pmu, &pcpus, &pthre=
ads))
> >               return NULL;
> >
> >       threads =3D pthreads ? ((struct pyrf_thread_map *)pthreads)->thre=
ads : NULL;
> >       cpus =3D pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
> >
> > -     evlist__init(&evlist, cpus, threads);
> > -     ret =3D metricgroup__parse_groups(&evlist, pmu ?: "all", input,
> > +     perf_evlist__set_maps(&evlist->core, cpus, threads);
> > +     ret =3D metricgroup__parse_groups(evlist, pmu ?: "all", input,
> >                                       /*metric_no_group=3D*/ false,
> >                                       /*metric_no_merge=3D*/ false,
> >                                       /*metric_no_threshold=3D*/ true,
> > @@ -2082,8 +2026,8 @@ static PyObject *pyrf__parse_metrics(PyObject *se=
lf, PyObject *args)
> >               PyErr_SetFromErrno(PyExc_OSError);
> >               return NULL;
> >       }
> > -     result =3D pyrf_evlist__from_evlist(&evlist);
> > -     evlist__exit(&evlist);
> > +     result =3D pyrf_evlist__from_evlist(evlist);
> > +     evlist__put(evlist);
> >       return result;
> >  }
> >
> > diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
> > index e867de8ddaaa..8a5fc7d5e43c 100644
> > --- a/tools/perf/util/record.c
> > +++ b/tools/perf/util/record.c
> > @@ -264,7 +264,7 @@ bool evlist__can_select_event(struct evlist *evlist=
, const char *str)
> >       ret =3D true;
> >
> >  out_delete:
> > -     evlist__delete(temp_evlist);
> > +     evlist__put(temp_evlist);
> >       return ret;
> >  }
> >
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index 081e68c72c30..f241d91221d7 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -256,7 +256,7 @@ void perf_session__delete(struct perf_session *sess=
ion)
> >       machines__exit(&session->machines);
> >       if (session->data) {
> >               if (perf_data__is_read(session->data))
> > -                     evlist__delete(session->evlist);
> > +                     evlist__put(session->evlist);
> >               perf_data__close(session->data);
> >       }
> >  #ifdef HAVE_LIBTRACEEVENT
> > diff --git a/tools/perf/util/sideband_evlist.c b/tools/perf/util/sideba=
nd_evlist.c
> > index 388846f17bc1..b84a5463e039 100644
> > --- a/tools/perf/util/sideband_evlist.c
> > +++ b/tools/perf/util/sideband_evlist.c
> > @@ -102,7 +102,7 @@ int evlist__start_sb_thread(struct evlist *evlist, =
struct target *target)
> >               return 0;
> >
> >       if (evlist__create_maps(evlist, target))
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >
> >       if (evlist->core.nr_entries > 1) {
> >               bool can_sample_identifier =3D perf_can_sample_identifier=
();
> > @@ -116,25 +116,25 @@ int evlist__start_sb_thread(struct evlist *evlist=
, struct target *target)
> >       evlist__for_each_entry(evlist, counter) {
> >               if (evsel__open(counter, evlist->core.user_requested_cpus=
,
> >                               evlist->core.threads) < 0)
> > -                     goto out_delete_evlist;
> > +                     goto out_put_evlist;
> >       }
> >
> >       if (evlist__mmap(evlist, UINT_MAX))
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >
> >       evlist__for_each_entry(evlist, counter) {
> >               if (evsel__enable(counter))
> > -                     goto out_delete_evlist;
> > +                     goto out_put_evlist;
> >       }
> >
> >       evlist->thread.done =3D 0;
> >       if (pthread_create(&evlist->thread.th, NULL, perf_evlist__poll_th=
read, evlist))
> > -             goto out_delete_evlist;
> > +             goto out_put_evlist;
> >
> >       return 0;
> >
> > -out_delete_evlist:
> > -     evlist__delete(evlist);
> > +out_put_evlist:
> > +     evlist__put(evlist);
> >       evlist =3D NULL;
> >       return -1;
> >  }
> > @@ -145,5 +145,5 @@ void evlist__stop_sb_thread(struct evlist *evlist)
> >               return;
> >       evlist->thread.done =3D 1;
> >       pthread_join(evlist->thread.th, NULL);
> > -     evlist__delete(evlist);
> > +     evlist__put(evlist);
> >  }
> > --
> > 2.51.1.851.g4ebd6896fd-goog
