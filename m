Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBD74C92;
	Fri, 30 May 2025 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748647232; cv=none; b=CxvYgmgOS/hmrwL3EhxvNcEChA/JvCZkN9HLsnU4y703q2fZLMq5q0hAPeogTHhrGsKDQApUE39xjZ2VOtMq39OsZxTwv99SY55v5dn3+r+XKL/hOZBTotWQbmFF0rD8MFqNJUvhYosndHj/F3XDCjC2W7Gf+NOOunBu+Dv23do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748647232; c=relaxed/simple;
	bh=qO61gPLsE0AIYJZLhIoPQrFvtsRMsu9nUhY1XK7TAts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1ctpT4i0vEtEiKuMKo+KKZTy5gj8nCiw2WoLT/oCTfrF4oBPmyoURW/HZCad+bUnDlGJTraci/Kas9SwuqGO/6fd+ql0SRYf9oShiCXb3CxarWMyJ/jqGOGO17iHag1Rc9ljJPCeGtfvVXMQqOFAn9NiNU2Xqk71FPY0JPNcXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzhV4YVb; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzhV4YVb"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e7dc3df7ac3so2642214276.3;
        Fri, 30 May 2025 16:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748647229; x=1749252029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpJuhsPdtUKi+G1wZGuyjlHaJ9OpRC6doKclRu5veKQ=;
        b=LzhV4YVbEgns5J2lLrztURCnKeSDPbBIH+yt7+CeAloJTy6UUk1x0gVxLdFSPanLCc
         uYBPVa0Bny931+D6oioqBLC4BklqAATz1HVl208q2WLq72gmcfyGz8k1lBQbt6EI6vjd
         r7IdRkLab1WKqAeqAdtkD79XzmGRzpvkN7Ccojun0O7IQ2Uxu8dDc0ORIHBFcbj8fVHf
         LgmtK/30tTv+qNi8ciToxM1aubWDsWfocfdIiEPYMZTsk0Qq45fOCLq95hbuUSj5+/93
         HVJs6OdS8+u5lkWK8ZEmVEeBara/E4wL2SROutpV9bKXxBCuUrvIWlzkIhDZRnwQNhBJ
         QxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748647229; x=1749252029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NpJuhsPdtUKi+G1wZGuyjlHaJ9OpRC6doKclRu5veKQ=;
        b=xO22zteVxVoC+vezwg17KhZ/QWTMCGeLR+OlxlWoe85hRlJn8RkJa/Z+75eUwO+xUc
         E+TESUSv0zD3n3pWUrTbrKh2DidWgcQIXCTM5lbwlAKJnb73CANWZHbq+IILXO/8wjZT
         gZ43ruq9C4NNryusFpfe/mM3TtBuy/7AlJQx0J1Zja36/zyebI1TzXK5VpCBtMLZz4bO
         eRO1VM2hTOiijcEKuOWGiBIgAjSV8TnyBwqfs+ve3T6Nv85tC+qMKv61A3kxrZAT6BuH
         q6x6sr1NFVXj6ozA3Ki7qIxj3YSxr1wqWryFE4KffZck12px/RS4KMnOoCSDtPKWk6g2
         3KqA==
X-Forwarded-Encrypted: i=1; AJvYcCUqeSoNp5il5aRvEdowFT7AVaew8UQTyJZy9PJq3WIdkqLAimwiWvLgFkVNxRrKpzKPH1Q+G8bztT+Q8Rs=@vger.kernel.org, AJvYcCWUuFb1BZH+qsycTP0Gwh4gmIMCElY61AnUhhUSYkJbPOZTbKEMbZyPD6kFtyKF5ZO//okXSHMtAB9CR2rNVrCJsg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yywc+8hGKyK301rHpnQjo6oWsNQkaVM9zqqnATgb72zoMNzPS0w
	IUHLRSt9A3vP2A//LPWq5XyUyReljE3JbRbY5xNQRqOYsSGTe4v7sSrW/NfGxMDoa8NKJPhmj+/
	H0ARPiNQJf6U/Ow0Ci8Rkkn/HYRrtsmQ=
X-Gm-Gg: ASbGncuLwH+YCq4LruoVtXR04q+qalAtgAwHuF9XzZ/hN2rI2O4kBeGq9ATwDx7mRJI
	sDhXtf2y5KQZ9uSq8nGG4wUlVpTDsm8sU3UQXsKBXNZYR+N9lHznJCjXYWVFP9kZM/9KKe1mfa1
	++4VbYgO8DQBgIsWRxstw4BKPY3zWUEGlXAE9LqGgM0A==
X-Google-Smtp-Source: AGHT+IEAKIekNzD8XcLVnWAmRVNZ+WE6AmBOCbUAw298kBwTYU4gxUOSEAkw4x2d/c+MFrrbM7QPBSSOinj+O4V+rj4=
X-Received: by 2002:a05:6902:2602:b0:e7d:a7c7:3f34 with SMTP id
 3f1490d57ef6-e8128c5837emr98644276.32.1748647229327; Fri, 30 May 2025
 16:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530062408.1438861-1-howardchu95@gmail.com>
 <20250530062408.1438861-2-howardchu95@gmail.com> <aDojkKOJCgvlgL2x@google.com>
In-Reply-To: <aDojkKOJCgvlgL2x@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 30 May 2025 16:20:18 -0700
X-Gm-Features: AX0GCFuEkJtXT0HOq49HvPwSuqUwfSsvYva7rD6FUXPcGy54mJv6Q2CV8qa1z9c
Message-ID: <CAH0uvojJPirC6OYTbfjj_iS3mErksySjAE7z7Nu6E3CSeOc_6Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf trace: Enhance task filtering
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, peterz@infradead.org, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

On Fri, May 30, 2025 at 2:31=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Howard,
>
> On Thu, May 29, 2025 at 11:24:07PM -0700, Howard Chu wrote:
> > This patch does two things:
> > 1. Add a pids_targeted map, put pids that interest perf trace in.
> > 2. Make bpf-output event system-wide.
> >
> > Effect 1:
> > perf trace doesn't augment threads properly. With the script below:
> >
> > Program test_trace_loop.c
> > ~~~
> >     #include <pthread.h>
> >     #include <stdio.h>
> >     #include <unistd.h>
> >     #include <stdlib.h>
> >
> >     #define THREAD_NR 2
> >
> >     struct thread_arg {
> >           int index;
> >     };
> >
> >     void *func(void *arg) {
> >           struct thread_arg *t_arg =3D arg;
> >           while (1) {
> >                   printf("thread %d running\n", t_arg->index);
> >                   sleep(1);
> >           }
> >           return NULL;
> >     }
> >
> >     int main()
> >     {
> >           pthread_t thread_ids[THREAD_NR];
> >           struct thread_arg thread_args[THREAD_NR];
> >
> >           for (int i =3D 0; i < THREAD_NR; i++) {
> >                   thread_args[i].index =3D i;
> >                   if (pthread_create(&thread_ids[i], NULL, &func, &thre=
ad_args[i])) {
> >                           perror("failed to create thread, exiting\n");
> >                           exit(1);
> >                   }
> >           }
> >
> >           while (1) {
> >                   printf("parent sleeping\n");
> >                   sleep(1);
> >           }
> >
> >           for (int i =3D 0; i < THREAD_NR; i++)
> >                   pthread_join(thread_ids[i], NULL);
> >
> >           return 0;
> >     }
> > ~~~
> >
> > Commands
> > ~~~
> > $ gcc test_trace_loop.c -o test_trace_loop
> >
> > $ ./test_trace_loop &
> > [1] 1404183
> >
> > $ pstree 1404183 -p
> > test_trace_loop(1404183)=E2=94=80=E2=94=AC=E2=94=80{test_trace_loop}(14=
04185)
> >                          =E2=94=94=E2=94=80{test_trace_loop}(1404186)
> >
> > $ sudo perf trace -p 1404183 -e *sleep
> > ~~~
> >
> > Output
> > before:
> > $ sudo /tmp/perf/perf trace -p 1404183 -e *sleep
> >          ? (         ): test_trace_loo/1404186  ... [continued]: clock_=
nanosleep())                                  =3D 0
> >          ? (         ): test_trace_loo/1404183  ... [continued]: clock_=
nanosleep())                                  =3D 0
> >      0.119 (         ): test_trace_loo/1404186 clock_nanosleep(rqtp: 0x=
7a86061fde60, rmtp: 0x7a86061fde60)        ...
> >          ? (         ): test_trace_loo/1404185  ... [continued]: clock_=
nanosleep())                                  =3D 0
> >      0.047 (         ): test_trace_loo/1404183 clock_nanosleep(rqtp: { =
.tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7ffd89091450) ...
> >      0.047 (1000.127 ms): test_trace_loo/1404183  ... [continued]: cloc=
k_nanosleep())                                  =3D 0
> >
> > explanation: only the parent thread 1404183 got augmented
> >
> > after:
> > $ sudo /tmp/perf/perf trace -p 1404183 -e *sleep
> >          ? (         ): test_trace_loo/1404183  ... [continued]: clock_=
nanosleep())                                  =3D 0
> >          ? (         ): test_trace_loo/1404186  ... [continued]: clock_=
nanosleep())                                  =3D 0
> >      0.147 (         ): test_trace_loo/1404186 clock_nanosleep(rqtp: { =
.tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7a86061fde60) ...
> >          ? (         ): test_trace_loo/1404185  ... [continued]: clock_=
nanosleep())                                  =3D 0
> >      0.076 (         ): test_trace_loo/1404183 clock_nanosleep(rqtp: { =
.tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7ffd89091450) ...
> >      0.076 (1000.160 ms): test_trace_loo/1404183  ... [continued]: cloc=
k_nanosleep())                                  =3D 0
> >      0.147 (1000.090 ms): test_trace_loo/1404186  ... [continued]: cloc=
k_nanosleep())                                  =3D 0
> >      2.557 (         ): test_trace_loo/1404185 clock_nanosleep(rqtp: { =
.tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7a86069fee60) ...
> >   1000.323 (         ): test_trace_loo/1404186 clock_nanosleep(rqtp: { =
.tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7a86061fde60) ...
> >      2.557 (1000.129 ms): test_trace_loo/1404185  ... [continued]: cloc=
k_nanosleep())                                  =3D 0
> >   1000.384 (         ): test_trace_loo/1404183 clock_nanosleep(rqtp: { =
.tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7ffd89091450) ...
> >
> > explanation: all threads augmented
> >
> > Effect 2: perf trace doesn't collect syscall argument data for *ALL*
> > pids, and throw it away anymore. Those uninteresting pids get filtered
> > right away. There should be a performance advantage.
>
> Thanks for doing this!

Thank you for reviewing this patch.

>
> >
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > ---
> >  tools/perf/builtin-trace.c                    | 52 ++++++++++++++++---
> >  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 35 ++++++++++---
> >  tools/perf/util/evlist.c                      |  2 +-
> >  3 files changed, 73 insertions(+), 16 deletions(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 67b557ec3b0d..11620cb40198 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -4377,6 +4377,7 @@ static int trace__run(struct trace *trace, int ar=
gc, const char **argv)
> >       unsigned long before;
> >       const bool forks =3D argc > 0;
> >       bool draining =3D false;
> > +     bool enable_evlist =3D false;
> >
> >       trace->live =3D true;
> >
> > @@ -4447,6 +4448,9 @@ static int trace__run(struct trace *trace, int ar=
gc, const char **argv)
> >               evlist__set_default_cgroup(trace->evlist, trace->cgroup);
> >
> >  create_maps:
> > +     if (trace->syscalls.events.bpf_output)
> > +             trace->syscalls.events.bpf_output->core.system_wide =3D t=
rue;
> > +
> >       err =3D evlist__create_maps(evlist, &trace->opts.target);
> >       if (err < 0) {
> >               fprintf(trace->output, "Problems parsing the target to tr=
ace, check your options!\n");
> > @@ -4481,20 +4485,54 @@ static int trace__run(struct trace *trace, int =
argc, const char **argv)
> >               goto out_error_open;
> >  #ifdef HAVE_BPF_SKEL
> >       if (trace->syscalls.events.bpf_output) {
> > +             struct perf_evsel *perf_evsel =3D &trace->syscalls.events=
.bpf_output->core;
> >               struct perf_cpu cpu;
> > +             bool t =3D true;
> > +
> > +             enable_evlist =3D true;
> > +             if (trace->opts.target.system_wide)
> > +                     trace->skel->bss->system_wide =3D true;
> > +             else
> > +                     trace->skel->bss->system_wide =3D false;
> >
> >               /*
> >                * Set up the __augmented_syscalls__ BPF map to hold for =
each
> >                * CPU the bpf-output event's file descriptor.
> >                */
> > -             perf_cpu_map__for_each_cpu(cpu, i, trace->syscalls.events=
.bpf_output->core.cpus) {
> > +             perf_cpu_map__for_each_cpu(cpu, i, perf_evsel->cpus) {
> >                       int mycpu =3D cpu.cpu;
> >
> > -                     bpf_map__update_elem(trace->skel->maps.__augmente=
d_syscalls__,
> > -                                     &mycpu, sizeof(mycpu),
> > -                                     xyarray__entry(trace->syscalls.ev=
ents.bpf_output->core.fd,
> > -                                                    mycpu, 0),
> > -                                     sizeof(__u32), BPF_ANY);
> > +                     err =3D bpf_map__update_elem(trace->skel->maps.__=
augmented_syscalls__,
> > +                                                &mycpu, sizeof(mycpu),
> > +                                                xyarray__entry(perf_ev=
sel->fd, mycpu, 0),
> > +                                                sizeof(__u32), BPF_ANY=
);
> > +                     if (err) {
> > +                             pr_err("Couldn't set system-wide bpf outp=
ut perf event fd"
> > +                                    ", err: %d\n", err);
> > +                             goto out_disable;
> > +                     }
> > +             }
> > +
> > +             if (target__has_task(&trace->opts.target)) {
> > +                     struct perf_thread_map *threads =3D trace->evlist=
->core.threads;
> > +
> > +                     for (int thread =3D 0; thread < perf_thread_map__=
nr(threads); thread++) {
> > +                             pid_t pid =3D perf_thread_map__pid(thread=
s, thread);
> > +
> > +                             err =3D bpf_map__update_elem(trace->skel-=
>maps.pids_targeted, &pid,
> > +                                                        sizeof(pid), &=
t, sizeof(t), BPF_ANY);
> > +                             if (err) {
> > +                                     pr_err("Couldn't set pids_targete=
d map, err: %d\n", err);
> > +                                     goto out_disable;
> > +                             }
> > +                     }
> > +             } else if (workload_pid !=3D -1) {
> > +                     err =3D bpf_map__update_elem(trace->skel->maps.pi=
ds_targeted, &workload_pid,
> > +                                                sizeof(workload_pid), =
&t, sizeof(t), BPF_ANY);
> > +                     if (err) {
> > +                             pr_err("Couldn't set pids_targeted map fo=
r workload, err: %d\n", err);
> > +                             goto out_disable;
> > +                     }
> >               }
> >       }
> >
> > @@ -4553,7 +4591,7 @@ static int trace__run(struct trace *trace, int ar=
gc, const char **argv)
> >                       goto out_error_mmap;
> >       }
> >
> > -     if (!target__none(&trace->opts.target) && !trace->opts.target.ini=
tial_delay)
> > +     if (enable_evlist || (!target__none(&trace->opts.target) && !trac=
e->opts.target.initial_delay))
>
> I guess target__none() should not call evlist__enable() here.

Tracing a workload makes target__none() return true... But I need the
evlist enabled for the workload. This statement can be written better:
if bpf-output event is used, enable evlist.

>
>
> >               evlist__enable(evlist);
> >
> >       if (forks)
> > diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/to=
ols/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > index e4352881e3fa..e517eec7290b 100644
> > --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > @@ -26,6 +26,7 @@
> >  #define is_power_of_2(n) (n !=3D 0 && ((n & (n - 1)) =3D=3D 0))
> >
> >  #define MAX_CPUS  4096
> > +#define MAX_PIDS  4096
> >
> >  /* bpf-output associated map */
> >  struct __augmented_syscalls__ {
> > @@ -113,6 +114,15 @@ struct pids_filtered {
> >       __uint(max_entries, 64);
> >  } pids_filtered SEC(".maps");
> >
> > +volatile bool system_wide;
> > +
> > +struct pids_targeted {
> > +     __uint(type, BPF_MAP_TYPE_HASH);
> > +     __type(key, pid_t);
> > +     __type(value, bool);
> > +     __uint(max_entries, MAX_PIDS);
> > +} pids_targeted SEC(".maps");
> > +
> >  struct augmented_args_payload {
> >       struct syscall_enter_args args;
> >       struct augmented_arg arg, arg2; // We have to reserve space for t=
wo arguments (rename, etc)
> > @@ -145,6 +155,11 @@ struct beauty_payload_enter_map {
> >       __uint(max_entries, 1);
> >  } beauty_payload_enter_map SEC(".maps");
> >
> > +static pid_t getpid(void)
> > +{
> > +     return bpf_get_current_pid_tgid();
> > +}
> > +
> >  static inline struct augmented_args_payload *augmented_args_payload(vo=
id)
> >  {
> >       int key =3D 0;
> > @@ -418,14 +433,18 @@ int sys_enter_nanosleep(struct syscall_enter_args=
 *args)
> >       return 1; /* Failure: don't filter */
> >  }
> >
> > -static pid_t getpid(void)
> > +static bool filter_pid(void)
> >  {
> > -     return bpf_get_current_pid_tgid();
> > -}
> > +     if (system_wide)
> > +             return false;
>
> Doesn't it need to check CPU list when -C option is used?

I agree, thanks.

>
> >
> > -static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
> > -{
> > -     return bpf_map_lookup_elem(pids, &pid) !=3D NULL;
> > +     pid_t pid =3D getpid();
> > +
> > +     if (bpf_map_lookup_elem(&pids_targeted, &pid) &&
> > +         !bpf_map_lookup_elem(&pids_filtered, &pid))
>
> Can we just use a single map for this purpose?

pids_targeted allows certain pids, and pids_filtered exclude some
pids. I actually made a mistake here because when doing system-wide
tracing, pids_filtered should be checked too (in my code I just return
if system_wide is true). In per-task tracing however, I think we can
squash them together, if any pid in pids_filtered is also in
pids_targeted,  we still keep that pid since the user specified it, if
not, it gets filtered anyway since it's not in pids_targeted. So you
are right about using a single map for per-task tracing, but only
because pids_filtered is used in system-wide mode, I don't think we
can delete the map.

Thanks,
Howard
