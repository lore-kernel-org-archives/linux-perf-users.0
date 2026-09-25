Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAAF23FC41
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 04:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790309421; cv=pass; b=MH7Asw8THsdaTpz26B2ykIfL/RXWCmG9rXLpykcNnusaM69uFejlpzendxPy4NL7c1Vp9bJgnPXv56KpBd4RxelohuvDFvISnzadB1jkkoAa1cOpVnXss2eqoQyzLWzcqSdU8o0LBNFrYUByM+H0KWg9wXIVABVsjRvhPiJh1DA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790309421; c=relaxed/simple;
	bh=M4b0D/EwYMh+6bdN1Fu+RZHMzo5OeSLXhaitjXSzB7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uOgPe5I5HFUQwVRBjneVv306+nCD/W8q0WkQw7uEc9ulHIkTVp96zc1DDluXeAbEQTSzPcv34LoumBDcW1yQCGdZQdLHjLBPHkJpej0LYTta+ee1ogCGkrkrqg2Jl5Gm8FwcWMK97ngV3xdO9SJ24lGdPybF4uk8WDM0M94KJ1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZjUoFTNy; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZjUoFTNy"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-530e8c6fb80so101471cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 21:10:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790309417; cv=none;
        d=google.com; s=arc-20260327;
        b=KFaac849xgChwkoBSBG3J5mWBDUIvEA+ukn2Xf+kS+JnnTuo6NRLjRAwbipEQv0Vr/
         oH7MQStsYG8I/vcFmrRVieTCIxI43zzekQIg/8UWd6CdM/pemCySaJKo4DLhh5vHxMFw
         mDK60rUI8DM1a06j84IyZMEeOAauyEuXbjUxHYg0huoludbinLk1ZFpj39Sh65MRQCq+
         3UlatkLtkHlbM/CHdxAU7Bu1JG6AAu9ZQnJqQeuVkM///+YEPgvnV81CGQeefTxEO8mA
         tpqh08J34QSPizIHb6SjyQC35qFSUXNdT7HaFuvXIaWK8pTQK22degpX2r1CdfxrY5kR
         OMzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lkef2rV+QvxTU9ydT0cGheYdDRJ6IRt/HQwGO5F97Jc=;
        fh=T4+Tbcgk3LWkt04sJVytjWjpjTVbIKz6o+EeGdx/+h0=;
        b=hY9SJJ6ZgvbmH9In8mmUNV5qhOy0vprEmFt4w7txOcNYx0UhJeoOn9WJ157Wur/6fL
         G6NqrSqQxoCfS31EVKCIYZ03GAas6Tjse37TXT9HeDRCUUvCTgePANXuau0ivGZ/ZNe8
         CwZmREMiMDknB/YLMIqllilx/RLxEYxWst+3asnAX082JDZSFjn25M5hOFXJnPz9LOQu
         5SMU5pgOHc3GsQYn7wFySLzKkiRvnH8AXmbRjFildGl/qbhf92xj4D168e7VhdmP7kPO
         FFq3Btqaoslcklf3KA9x1IbFAB9tuq2CqdXpiv/HHt89B5evtTqFdpA296V5AXjOtZlA
         pVwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790309417; x=1790914217; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lkef2rV+QvxTU9ydT0cGheYdDRJ6IRt/HQwGO5F97Jc=;
        b=ZjUoFTNyrmEOqTZH+HDkSHyLoLUFdZ67cKHav1pJMbSHuuth953YKTnHDrkTawjPCI
         j+cJZFIguUPob9/LJ+KRiKluR8YAkXNliDAC1vNzOlbprkFAwR19OAMMJeDBNpVEDhbJ
         zR8a6C7yVm2yyqg0Cb+J4jPVwgyVTkqxTM7w/ymwutGInxVqklYH3WizTthhxgyuOmC9
         SuWkRx94+RmwKAJwgFkMr+gHZozN1MhvPbIe8sjPsJdRm0tSjDs9Dom4E2pkpAdC17Xi
         4a8YfPrXLm/jtRUXL97pdRWuhXZIAMgvmuccMf+F0XSCJH9db+ikwY8kru5mI4LSVay8
         Vyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790309417; x=1790914217;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lkef2rV+QvxTU9ydT0cGheYdDRJ6IRt/HQwGO5F97Jc=;
        b=0UoShIf6AlXtz+HRtjXIcEOTBGyHXxprkCk2FH5gh/0uh7E6d6UOVykLw5dByfldDI
         mejgYMIXlSLcT9rY4rQ7/tgv59/j80agpvqCA31OlAIAORYpx3a10hQSGCjM1qgDQV9g
         CjHy+WoUiJRQHsau3ByVxMTdTIgIre2o2bw/SU3yVx0kQyq65jxTpyGgaIqR9elktmY5
         Upxu45G51B4thFrW4EF9dNUZm0CFZ+Rsi38i80pqtTgUg0ULe9yQiR8O+KcMckQ3x3z4
         BbyDehnirJuSRatIoQWBUaBBk71VvWhAeLiMCuEER8hMePGkgSXOTuB0x3nFT+VJkacF
         aAHg==
X-Forwarded-Encrypted: i=1; AKwUvBxTO9EeRZjy617wBl/HzFwNwSCfABgdj0Bb1qLjVwGkm4j7Qv9JY/xPuQLcgi14wvpAp7OOVaK7Qh25zQQ7aHyb@vger.kernel.org
X-Gm-Message-State: AFuF++lM4tULc4J23txvnJF89NT913Q4lTMa6bQf4isWsHmiKNhAfoiM
	Df5JQdWnoDawTRO/7AdyNkfyXF/flgqDxQ2OrxxB527Ie81xik+HNuot0FPxVglmS1yR24NftS0
	okdWlQBIDhSLMHbb9FHor/tkBnOztRdFDbSlbMEM2
X-Gm-Gg: AYBFou3XTqnBlCfYPRSxN5L+z59+5EHqADrhxkv63ZL99kOdI3EVZ0K2fRWANvty3GK
	ieBSQ5lqfPP9B5tN2EhzCv9IFEGTKyTLGMFD8hqSmbNTGWR0DFH1AlO2gpM98FYw3iPwqMcoF4L
	ii/NHUaBv3CY0Fbd0UB4gHpfQ1ga3ECpzy09lGHvtZStvsa/7pFQs/uUae2MI6uIpT+ab9qlA0W
	/+o6wkVDIdykNt9XQyAJKn9KfBlVPlmWgFFpouh/B+MrBFwnUI0P4Ps5B1JtJxGBIdTK+cYkWu6
	TSA7RPdgz+iOR+q0kijGNBwnSqGjdQ69v4lWGlBbh6KDMRTMC3zdaBo=
X-Received: by 2002:a05:622a:8414:10b0:532:84d3:abb with SMTP id
 d75a77b69052e-53310b7db8cmr2577221cf.7.1790309415840; Thu, 24 Sep 2026
 21:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790145937.git.irogers@google.com> <b77523973d8012f1cdc36eca15021b204a42aaac.1790145937.git.irogers@google.com>
 <arXjkuLjHO826tXy@z2>
In-Reply-To: <arXjkuLjHO826tXy@z2>
From: Ian Rogers <irogers@google.com>
Date: Thu, 24 Sep 2026 21:10:03 -0700
X-Gm-Features: AclHuK-6HsGiquugZnFYY-UfJzLXLsNL1XqaaTA2arYxFPECa8ZoV2rxlwxAic4
Message-ID: <CAP-5=fU-3uiZFr+pPTSezG-5mpeptdkDZm=7CBzWQdX3qWaqGg@mail.gmail.com>
Subject: Re: [PATCH v5 12/23] perf trace: Filter events in BPF and avoid
 tracepoint vetoes
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, howardchu95@gmail.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 7:59=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Sep 23, 2026 at 12:13:52AM -0700, Ian Rogers wrote:
> > The BPF augmented_raw_syscalls sys_enter and sys_exit programs returned
> > 0 for syscalls that were not of interest. Returning 0 from a tracepoint
> > BPF program vetoes the event for the whole system, so an unrelated
> > concurrent perf trace, perf record or ftrace session listening to
> > raw_syscalls would silently lose events. This is a cross-session side
> > effect and shows up as flaky failures when perf tests run in parallel.
>
> Right.
>
> This is what I wanted to fix in my earlier attempt.
>
> https://lore.kernel.org/r/20250814071754.193265-1-namhyung@kernel.org/
>
> >
> > Furthermore, syscall_unaugmented previously returned 1 without writing
> > anything to the __augmented_syscalls__ ring buffer. This forced
> > userspace perf trace to listen to both raw_syscalls:sys_enter and
> > __augmented_syscalls__ in its evlist, requiring userspace event
> > deduplication.
> >
> > Address these issues:
> > 1. In augmented_raw_syscalls.bpf.c, never return 0 from tracepoint
> >    handlers: return 1 so non-traced syscalls pass through without
> >    vetoing other concurrent listeners.
>
> Ok.
>
>
> > 2. Introduce pids_to_trace and syscalls_to_trace BPF hash maps to
> >    perform targeted filtering directly in BPF. Unselected syscalls or
> >    PIDs return 1 immediately without writing to the buffer.
>
> Can you please do this in a separate patch?  I think it's better to
> minimize the patch and focus on the core changes.
>
>
> > 3. In syscall_unaugmented, output the unaugmented enter payload into
> >    __augmented_syscalls__ and return 1. Change its section from
> >    SEC("tp/raw_syscalls/sys_enter") to
> >    SEC("tp/syscalls/sys_enter_unaugmented") so libbpf does not attempt
> >    to auto-attach it to raw_syscalls:sys_enter.
>
> Ok, but also can be done in a separate patch.
>
>
> > 4. In bpf_trace_augment.c, add helpers to configure target PIDs and
> >    syscalls in the BPF maps, setting the activation flags
> >    (has_pids_to_trace, has_syscalls_to_trace) only after the maps are
> >    fully populated so already-attached BPF programs do not filter again=
st
> >    a half-filled map. Explicitly attach only sys_enter and sys_exit via
> >    an attach_prog() helper that saves -errno before calling pr_debug()
> >    or bpf_link__destroy().
>
> Sounds like it should be done with step 2 above.
>
> >
> >    Destroy the skeleton on every failure path. Leaving a loaded but
> >    unusable skeleton behind is not inert: the setters called later from
> >    trace__run() would program its maps, and a partial attach would leav=
e
> >    a BPF program live on raw_syscalls for a session that never starts.
> >    Since augmented_syscalls__{prepare,create_bpf_output}() failures fal=
l
> >    back to unaugmented tracing rather than aborting, those setters have
> >    to become no-ops, which they only do once skel is NULL again.
> >
> >    errno is used directly here, so include <errno.h> rather than relyin=
g
> >    on it arriving via another header, which it does not under musl.
>
> Can be a separate change as well.
>
>
> > 5. In builtin-trace.c, hook trace__set_ev_qualifier_filter() and PID
> >    filtering into the BPF maps. When __augmented_syscalls__ is active,
> >    remove raw_syscalls:sys_enter from trace.evlist since all traced ent=
er
> >    events (both augmented and unaugmented) are now emitted by BPF into
> >    __augmented_syscalls__. Identify that evsel by comparing against
> >    trace.syscalls.events.sys_enter rather than by a strstr() of its
> >    name. The substring "syscalls:sys_enter" also matches the per
> >    syscall syscalls:sys_enter_SYSCALL tracepoints, which a user can ask
> >    for by name, and now that the match decides what is taken out of the
> >    evlist, claiming one of those would drop an event that was asked for
> >    and would describe __augmented_syscalls__ with its format rather
> >    than the raw one's. Restore tracking on the remaining evsel via
> >    evlist__set_tracking_event() so PERF_RECORD_COMM and tracking events
> >    continue to be recorded. Errors from
> >    augmented_syscalls__set_target_syscalls() are reported and
> >    propagated, the tracepoint filter string is freed on every exit path=
,
> >    and an allocation failure in trace__set_filter_pids() now returns
> >    -ENOMEM instead of being silently ignored.
> >
> >    Note that in trace__set_filter_pids() the target pids and the filter=
ed
> >    pids are two independent axes and both have to be programmed. Naming
> >    pids to leave out with --filter-pids does not widen -p/-t or a workl=
oad
> >    to the whole system, and a BPF tracepoint program is attached system
> >    wide rather than to the target's file descriptors, so pids_to_trace =
is
> >    the only thing keeping other tasks out.
>
> Right, it's confusing that we have both --filter-pids and -p.
>
>
> > 6. Add --syscall-augment option (defaulting to true) to allow users to
> >    explicitly use --no-syscall-augment to run perf trace in the classic
> >    unaugmented tracepoint mode without BPF. When BPF is unavailable or
> >    disabled, ensure the non-augmented tracepoint path cleanly configure=
s
> >    sys_enter and sys_exit without duplicate entries.
>
> What's the benefit to users of disabling syscall augmentation?  Is it
> only for debugging?  Anyway, I think this should be added as a separate
> patch.

It is so we can test with and without augmentation. With augmentation
the BPF program generates all the data so it can be filtered, etc. in
BPF. Even if the augmentation doesn't happen the BPF program writes
the raw data into the ring buffer for output. That's why the
separation you requested earlier isn't possible without introducing
broken intermediate states.

When augmentation and BPF are disabled, events are written to the ring
buffer using the normal tracepoint method and must be filtered, etc.
in the user space code. We need both modes because loading a BPF
program may not be possible and perf trace must continue working. This
flag allows testing data generated by both BPF and tracepoints.

A viable alternative is to generate both BPF and tracepoint data, but
that seemed very inefficient due to the amount of data that would go
in the ring buffer.

Thanks,
Ian

> >
> >    In trace__run(), add those tracepoints only when neither of them is
> >    in the evlist already. trace__add_syscall_newtp() adds the pair
> >    whatever is there, and cmd_trace() may have left either or both
> >    behind: both when it prepared augmentation and then gave up on it,
> >    the exit one alone when __augmented_syscalls__ took over the enters.
> >    Neither is covered by trace.raw_augmented_syscalls, which is only
> >    set when the exit evsel is named raw_syscalls:sys_exit, and not on a
> >    kernel old enough for perf_evsel__raw_syscall_newtp() to have fallen
> >    back to syscalls:sys_exit. Adding the pair again reports the events
> >    that were there twice, which the fallback after a bpf-output failure
> >    already did before this.
> >
> >    Act on trace__add_syscall_newtp()'s result in cmd_trace() rather
> >    than discarding it. Those tracepoints are what the augmented events
> >    are described and paired with, so without them there is nothing to
> >    augment: the skeleton is dropped and the session carries on with
> >    plain tracepoints, which is what the bpf-output failure beside it
> >    already does, and what lets the evlist test above rely on the exit
> >    tracepoint being there whenever the bpf-output event is.
> >
> > A target that does not fit in the map is not a reason to give up on the
> > session. bpf_map__update_elem() answers -E2BIG once max_entries keys ar=
e
> > present, so a target with more threads than pids_to_trace has room for
> > would take the whole of perf trace down with it, on exactly the large
> > workloads where there is least else to reach for. The tasks that fit ar=
e
> > added, a warning says how many did not, and the ones left out are in th=
e
> > position they would have been in had they been created once the map was
> > already full, which sched_process_fork() has to allow for regardless.
> >
> > Report a failure to program the pid filters with the error that caused
> > it. trace__run() sent everything trace__set_filter_pids() returned to
> > out_error_mem, which prints "Not enough memory to run!". That was
> > already a guess, and becomes a wrong one now that the function also
> > writes BPF maps, which fail for reasons of their own that have nothing
> > to do with memory and that the message gives the user no way to act on.
> >
> > Report a failure to program the syscall filters the same way. The
> > pr_err() in trace__set_ev_qualifier_filter() ran before trace__run()
> > reached out_errno and printed "%m", and anything called in between
> > could have changed errno by then, so the two did not have to agree.
> > The inner report becomes a pr_debug() and the caller prints the error
> > it was given, which leaves out_errno without a user and it is removed.
>
> It'd be great if you can shorten the commit message..
>
> Thanks,
> Namhyung
>
> >
> > Assisted-by: Antigravity:gemini-3.1-pro
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/Documentation/perf-trace.txt       |   5 +
> >  tools/perf/builtin-trace.c                    | 222 +++++++++++++++---
> >  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 133 +++++++++--
> >  tools/perf/util/bpf_trace_augment.c           | 169 ++++++++++++-
> >  tools/perf/util/trace_augment.h               |  34 +++
> >  5 files changed, 511 insertions(+), 52 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Docum=
entation/perf-trace.txt
> > index d20b43ea3d37..4680c69160d7 100644
> > --- a/tools/perf/Documentation/perf-trace.txt
> > +++ b/tools/perf/Documentation/perf-trace.txt
> > @@ -260,6 +260,11 @@ the thread executes on the designated CPUs. Defaul=
t is to monitor all CPUs.
> >       Maximum number of lines in the summary mode.  Note that this appl=
ies to
> >       each entry (thread or cgroup).
> >
> > +--syscall-augment::
> > +     Augment syscalls with BPF. Enabled by default when BPF support is=
 available.
> > +     Use --no-syscall-augment to disable BPF augmentation and fall bac=
k to the
> > +     unaugmented tracepoint approach.
> > +
> >
> >  PAGEFAULTS
> >  ----------
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 0ae14ecd9f00..f7226331c311 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -200,6 +200,7 @@ struct trace {
> >       int                     max_summary;
> >       int                     raw_augmented_syscalls_args_size;
> >       bool                    raw_augmented_syscalls;
> > +     bool                    syscall_augment;
> >       bool                    fd_path_disabled;
> >       bool                    sort_events;
> >       bool                    not_ev_qualifier;
> > @@ -2071,6 +2072,23 @@ static int trace__process_event(struct trace *tr=
ace, struct machine *machine,
> >                             "LOST %" PRIu64 " events!\n", (u64)event->l=
ost.lost);
> >               ret =3D machine__process_lost_event(machine, event, sampl=
e);
> >               break;
> > +     case PERF_RECORD_FORK:
> > +             if (trace->raw_augmented_syscalls &&
> > +                 (augmented_syscalls__has_target_pid(event->fork.ppid)=
 ||
> > +                  augmented_syscalls__has_target_pid(event->fork.ptid)=
)) {
> > +                     augmented_syscalls__add_target_pid(event->fork.pi=
d);
> > +             }
> > +             ret =3D machine__process_fork_event(machine, event, sampl=
e);
> > +             break;
> > +     case PERF_RECORD_EXIT:
> > +             if (trace->raw_augmented_syscalls) {
> > +                     if (event->fork.pid =3D=3D event->fork.tid)
> > +                             augmented_syscalls__del_target_pid(event-=
>fork.pid);
> > +                     else
> > +                             augmented_syscalls__del_target_pid(event-=
>fork.tid);
> > +             }
> > +             ret =3D machine__process_exit_event(machine, event, sampl=
e);
> > +             break;
> >       default:
> >               ret =3D machine__process_event(machine, event, sample);
> >               break;
> > @@ -4102,7 +4120,7 @@ static int trace__add_syscall_newtp(struct trace =
*trace)
> >
> >  static int trace__set_ev_qualifier_tp_filter(struct trace *trace)
> >  {
> > -     int err =3D -1;
> > +     int err =3D 0;
> >       struct evsel *sys_exit;
> >       char *filter =3D asprintf_expr_inout_ints("id", !trace->not_ev_qu=
alifier,
> >                                               trace->ev_qualifier_ids.n=
r,
> > @@ -4111,15 +4129,27 @@ static int trace__set_ev_qualifier_tp_filter(st=
ruct trace *trace)
> >       if (filter =3D=3D NULL)
> >               goto out_enomem;
> >
> > -     if (!evsel__append_tp_filter(trace->syscalls.events.sys_enter, fi=
lter)) {
> > -             sys_exit =3D trace->syscalls.events.sys_exit;
> > +     /*
> > +      * With BPF augmentation sys_enter is filtered in BPF and removed=
 from
> > +      * the evlist, so only apply the tracepoint filter to the events =
that
> > +      * are actually present.
> > +      */
> > +     if (trace->syscalls.events.sys_enter)
> > +             err =3D evsel__append_tp_filter(trace->syscalls.events.sy=
s_enter, filter);
> > +
> > +     sys_exit =3D trace->syscalls.events.sys_exit;
> > +     if (!err && sys_exit)
> >               err =3D evsel__append_tp_filter(sys_exit, filter);
> > -     }
> >
> >       free(filter);
> >  out:
> >       return err;
> >  out_enomem:
> > +     /*
> > +      * err defaults to 0 because either tracepoint may legitimately b=
e
> > +      * absent, so the error has to be set explicitly here.
> > +      */
> > +     err =3D -ENOMEM;
> >       errno =3D ENOMEM;
> >       goto out;
> >  }
> > @@ -4561,7 +4591,27 @@ static int trace__init_syscalls_bpf_prog_array_m=
aps(struct trace *trace __maybe_
> >
> >  static int trace__set_ev_qualifier_filter(struct trace *trace)
> >  {
> > -     if (trace->syscalls.events.sys_enter)
> > +     /*
> > +      * Synchronize syscall filter with BPF augmenter map:
> > +      * Pass trace->not_ev_qualifier to indicate blacklist mode ('!' p=
refix,
> > +      * e.g., -e !open,close) vs whitelist mode (-e open,close).
> > +      *
> > +      * A failure here would leave the BPF program filtering on a part=
ially
> > +      * populated map, silently dropping or emitting the wrong syscall=
s, so
> > +      * propagate the error rather than continuing.
> > +      */
> > +     if (trace->ev_qualifier_ids.nr > 0) {
> > +             int err =3D augmented_syscalls__set_target_syscalls(trace=
->ev_qualifier_ids.nr,
> > +                                                               trace->=
ev_qualifier_ids.entries,
> > +                                                               trace->=
not_ev_qualifier);
> > +
> > +             if (err) {
> > +                     pr_debug("Failed to set the syscalls to trace in =
the BPF map: %d\n", err);
> > +                     return err;
> > +             }
> > +     }
> > +
> > +     if (trace->syscalls.events.sys_enter || trace->syscalls.events.sy=
s_exit)
> >               return trace__set_ev_qualifier_tp_filter(trace);
> >       return 0;
> >  }
> > @@ -4602,13 +4652,21 @@ static int trace__set_filter_loop_pids(struct t=
race *trace)
> >
> >  static int trace__set_filter_pids(struct trace *trace)
> >  {
> > -     int err =3D 0;
> > +     struct perf_thread_map *threads =3D evlist__core(trace->evlist)->=
threads;
> >       /*
> >        * Better not use !target__has_task() here because we need to cov=
er the
> >        * case where no threads were specified in the command line, but =
a
> >        * workload was, and in that case we will fill in the thread_map =
when
> >        * we fork the workload in evlist__prepare_workload.
> >        */
> > +     bool has_target =3D perf_thread_map__pid(threads, 0) !=3D -1;
> > +     int err =3D 0;
> > +
> > +     /*
> > +      * The exclusion list: --filter-pids names tasks to never report,=
 and
> > +      * with no target at all we instead exclude perf itself so that t=
racing
> > +      * does not feed back into itself.
> > +      */
> >       if (trace->filter_pids.nr > 0) {
> >               err =3D evlist__append_tp_filter_pids(trace->evlist, trac=
e->filter_pids.nr,
> >                                                   trace->filter_pids.en=
tries);
> > @@ -4616,10 +4674,37 @@ static int trace__set_filter_pids(struct trace =
*trace)
> >                       err =3D augmented_syscalls__set_filter_pids(trace=
->filter_pids.nr,
> >                                                      trace->filter_pids=
.entries);
> >               }
> > -     } else if (perf_thread_map__pid(evlist__core(trace->evlist)->thre=
ads, 0) =3D=3D -1) {
> > +     } else if (!has_target) {
> >               err =3D trace__set_filter_loop_pids(trace);
> >       }
> >
> > +     if (err)
> > +             return err;
> > +
> > +     /*
> > +      * The inclusion list, which is a separate axis from the exclusio=
n list
> > +      * above and so must be programmed even when --filter-pids was gi=
ven:
> > +      * naming tasks to leave out does not widen -p/-t or a workload t=
o the
> > +      * whole system.
> > +      *
> > +      * This matters more than it does on the tracepoint only path. A =
BPF
> > +      * tracepoint program is attached system wide rather than to the
> > +      * target's file descriptors, so pids_to_trace is the only thing
> > +      * keeping other tasks out.
> > +      */
> > +     if (has_target) {
> > +             int nr =3D perf_thread_map__nr(threads);
> > +             pid_t *pids =3D malloc(nr * sizeof(pid_t));
> > +
> > +             if (pids =3D=3D NULL)
> > +                     return -ENOMEM;
> > +
> > +             for (int i =3D 0; i < nr; i++)
> > +                     pids[i] =3D perf_thread_map__pid(threads, i);
> > +             err =3D augmented_syscalls__set_target_pids(nr, pids);
> > +             free(pids);
> > +     }
> > +
> >       return err;
> >  }
> >
> > @@ -4846,7 +4931,20 @@ static int trace__run(struct trace *trace, int a=
rgc, const char **argv)
> >       }
> >
> >       if (!trace->raw_augmented_syscalls) {
> > -             if (trace->trace_syscalls && trace__add_syscall_newtp(tra=
ce))
> > +             /*
> > +              * The syscall tracepoints may be in the evlist already:
> > +              * cmd_trace() adds the pair whenever it prepares BPF
> > +              * augmentation, and it then either keeps them, gives up =
on
> > +              * augmentation and leaves them behind, or has
> > +              * __augmented_syscalls__ take over the enters and remove=
s only
> > +              * the enter one. trace__add_syscall_newtp() adds the pai=
r
> > +              * whatever is there, so it is called only when neither i=
s, and
> > +              * every event it adds is one the evlist does not already=
 have.
> > +              */
> > +             bool have_syscall_tp =3D trace->syscalls.events.sys_enter=
 !=3D NULL ||
> > +                                    trace->syscalls.events.sys_exit !=
=3D NULL;
> > +
> > +             if (trace->trace_syscalls && !have_syscall_tp && trace__a=
dd_syscall_newtp(trace))
> >                       goto out_error_raw_syscalls;
> >
> >               if (trace->trace_syscalls)
> > @@ -4941,7 +5039,7 @@ static int trace__run(struct trace *trace, int ar=
gc, const char **argv)
> >
> >       err =3D trace__set_filter_pids(trace);
> >       if (err < 0)
> > -             goto out_error_mem;
> > +             goto out_error_filter_pids;
> >
> >       /*
> >        * TODO: Initialize for all host binary machine types, not just
> > @@ -4952,7 +5050,7 @@ static int trace__run(struct trace *trace, int ar=
gc, const char **argv)
> >       if (trace->ev_qualifier_ids.nr > 0) {
> >               err =3D trace__set_ev_qualifier_filter(trace);
> >               if (err < 0)
> > -                     goto out_errno;
> > +                     goto out_error_ev_qualifier;
> >
> >               if (trace->syscalls.events.sys_exit) {
> >                       pr_debug("event qualifier tracepoint filter: %s\n=
",
> > @@ -5132,14 +5230,32 @@ static int trace__run(struct trace *trace, int =
argc, const char **argv)
> >               "Failed to set filter \"%s\" on event %s: %m\n",
> >               evsel->filter, evsel__name(evsel));
> >       goto out_put_evlist;
> > +
> > +out_error_filter_pids:
> > +     /*
> > +      * Report what actually went wrong. Programming the pid filters
> > +      * allocates, but it also writes BPF maps, which fails for reason=
s of
> > +      * its own: -E2BIG when the target has more threads than pids_to_=
trace
> > +      * has room for, say.
> > +      */
> > +     fprintf(trace->output, "Failed to set the pid filters: %s\n",
> > +             str_error_r(-err, errbuf, sizeof(errbuf)));
> > +     goto out_put_evlist;
> > +
> > +out_error_ev_qualifier:
> > +     /*
> > +      * Use the returned error, not errno. Reporting the failure on th=
e way
> > +      * out of trace__set_ev_qualifier_filter() goes through the forma=
tted
> > +      * output functions, which are free to leave errno describing
> > +      * something else by the time it is read here.
> > +      */
> > +     fprintf(trace->output, "Failed to set the syscall filters: %s\n",
> > +             str_error_r(-err, errbuf, sizeof(errbuf)));
> > +     goto out_put_evlist;
> >  }
> >  out_error_mem:
> >       fprintf(trace->output, "Not enough memory to run!\n");
> >       goto out_put_evlist;
> > -
> > -out_errno:
> > -     fprintf(trace->output, "%m\n");
> > -     goto out_put_evlist;
> >  }
> >
> >  static int trace__replay(struct trace *trace)
> > @@ -5854,6 +5970,7 @@ int cmd_trace(int argc, const char **argv)
> >               .show_arg_names =3D true,
> >               .args_alignment =3D 70,
> >               .trace_syscalls =3D false,
> > +             .syscall_augment =3D true,
> >               .kernel_syscallchains =3D false,
> >               .max_stack =3D UINT_MAX,
> >               .max_events =3D ULONG_MAX,
> > @@ -5909,6 +6026,8 @@ int cmd_trace(int argc, const char **argv)
> >       OPT_CALLBACK_DEFAULT('F', "pf", &trace.trace_pgfaults, "all|maj|m=
in",
> >                    "Trace pagefaults", parse_pagefaults, "maj"),
> >       OPT_BOOLEAN(0, "syscalls", &trace.trace_syscalls, "Trace syscalls=
"),
> > +     OPT_BOOLEAN(0, "syscall-augment", &trace.syscall_augment,
> > +                 "Augment syscalls with BPF"),
> >       OPT_BOOLEAN('f', "force", &trace.force, "don't complain, do it"),
> >       OPT_CALLBACK(0, "call-graph", &trace.opts,
> >                    "record_mode[,record_size]", record_callchain_help,
> > @@ -6031,7 +6150,7 @@ int cmd_trace(int argc, const char **argv)
> >                                      "cgroup monitoring only available =
in system-wide mode");
> >       }
> >
> > -     if (!trace.trace_syscalls)
> > +     if (!trace.trace_syscalls || !trace.syscall_augment)
> >               goto skip_augmentation;
> >
> >       if ((argc >=3D 1) && (strcmp(argv[0], "record") =3D=3D 0)) {
> > @@ -6053,11 +6172,34 @@ int cmd_trace(int argc, const char **argv)
> >       if (err < 0)
> >               goto skip_augmentation;
> >
> > -     trace__add_syscall_newtp(&trace);
> > +     /*
> > +      * The syscall tracepoints are what the augmented events are desc=
ribed
> > +      * and paired with: the enter one supplies the format
> > +      * __augmented_syscalls__ is read with, and the exit one reports =
the
> > +      * returns, since BPF only takes over the enters. Without them th=
ere is
> > +      * nothing to augment, so drop the skeleton and carry on with pla=
in
> > +      * tracepoints, as the bpf-output failure below does.
> > +      */
> > +     if (trace__add_syscall_newtp(&trace)) {
> > +             pr_debug("Failed to set up the syscall tracepoints, disab=
ling augmentation\n");
> > +             augmented_syscalls__cleanup();
> > +             goto skip_augmentation;
> > +     }
> >
> >       err =3D augmented_syscalls__create_bpf_output(trace.evlist);
> > -     if (err =3D=3D 0)
> > +     if (err =3D=3D 0) {
> >               trace.syscalls.events.bpf_output =3D evlist__last(trace.e=
vlist);
> > +     } else {
> > +             /*
> > +              * augmented_syscalls__prepare() already attached sys_ent=
er and
> > +              * sys_exit, which are system wide. Falling through to
> > +              * skip_augmentation without undoing that would run a BPF
> > +              * program for every syscall on the machine, for the whol=
e
> > +              * session, with nothing consuming the output.
> > +              */
> > +             pr_debug("Failed to create the augmented syscalls bpf-out=
put event, disabling augmentation\n");
> > +             augmented_syscalls__cleanup();
> > +     }
> >
> >  skip_augmentation:
> >       err =3D -1;
> > @@ -6113,7 +6255,9 @@ int cmd_trace(int argc, const char **argv)
> >        * syscall.
> >        */
> >       if (trace.syscalls.events.bpf_output) {
> > -             evlist__for_each_entry(trace.evlist, evsel) {
> > +             struct evsel *n;
> > +
> > +             evlist__for_each_entry_safe(trace.evlist, n, evsel) {
> >                       bool raw_syscalls_sys_exit =3D evsel__name_is(evs=
el, "raw_syscalls:sys_exit");
> >
> >                       if (raw_syscalls_sys_exit) {
> > @@ -6121,28 +6265,44 @@ int cmd_trace(int argc, const char **argv)
> >                               goto init_augmented_syscall_tp;
> >                       }
> >
> > -                     if (trace.syscalls.events.bpf_output->priv =3D=3D=
 NULL &&
> > -                         strstr(evsel__name(evsel), "syscalls:sys_ente=
r")) {
> > +                     /*
> > +                      * Match the evsel trace__add_syscall_newtp() mad=
e by
> > +                      * identity rather than by name. It is called
> > +                      * raw_syscalls:sys_enter, or syscalls:sys_enter =
on
> > +                      * kernels too old to have the raw variant, and a
> > +                      * substring test for the latter also matches the
> > +                      * per syscall syscalls:sys_enter_SYSCALL tracepo=
ints
> > +                      * a user can ask for by name. Claiming one of th=
ose
> > +                      * here would take the event the user asked for o=
ut of
> > +                      * the evlist below and describe __augmented_sysc=
alls__
> > +                      * with the wrong tracefs format.
> > +                      */
> > +                     if (evsel =3D=3D trace.syscalls.events.sys_enter)=
 {
> >                               struct evsel *augmented =3D trace.syscall=
s.events.bpf_output;
> >                               if (evsel__init_augmented_syscall_tp(augm=
ented, evsel) ||
> >                                   evsel__init_augmented_syscall_tp_args=
(augmented))
> >                                       goto out;
> >                               /*
> > -                              * Augmented is __augmented_syscalls__ BP=
F_OUTPUT event
> > +                              * Augmented is __augmented_syscalls__ BP=
F_OUTPUT event.
> >                                * Above we made sure we can get from the=
 payload the tp fields
> >                                * that we get from syscalls:sys_enter tr=
acefs format file.
> > +                              * Since BPF outputs all enter events (bo=
th augmented and
> > +                              * unaugmented) into __augmented_syscalls=
__, we remove the raw
> > +                              * sys_enter evsel from evlist so that pe=
rf trace only listens
> > +                              * to __augmented_syscalls__, avoiding du=
plicate events and
> > +                              * avoiding kernel tracepoint vetoes.
> > +                              *
> > +                              * Because evlist__remove() removes the f=
irst evsel (which had
> > +                              * tracking=3Dtrue by default), re-design=
ate the tracking event
> > +                              * so PERF_RECORD_COMM and fork tracking =
continue to be enabled.
> >                                */
> >                               augmented->handler =3D trace__sys_enter;
> > -                             /*
> > -                              * Now we do the same for the *syscalls:s=
ys_enter event so that
> > -                              * if we handle it directly, i.e. if the =
BPF prog returns 0 so
> > -                              * as not to filter it, then we'll handle=
 it just like we would
> > -                              * for the BPF_OUTPUT one:
> > -                              */
> > -                             if (evsel__init_augmented_syscall_tp(evse=
l, evsel) ||
> > -                                 evsel__init_augmented_syscall_tp_args=
(evsel))
> > -                                     goto out;
> > -                             evsel->handler =3D trace__sys_enter;
> > +                             evlist__remove(trace.evlist, evsel);
> > +                             evsel__put_and_free_priv(evsel);
> > +                             trace.syscalls.events.sys_enter =3D NULL;
> > +                             evlist__set_tracking_event(trace.evlist,
> > +                                     trace.syscalls.events.sys_exit ?:=
 augmented);
> > +                             continue;
> >                       }
> >
> >                       if (strstarts(evsel__name(evsel), "syscalls:sys_e=
xit_")) {
> > diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/to=
ols/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > index 18904bebf672..f16299c1d311 100644
> > --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > @@ -114,6 +114,41 @@ struct pids_filtered {
> >       __uint(max_entries, 64);
> >  } pids_filtered SEC(".maps");
> >
> > +/*
> > + * Optional hash map containing specific PIDs/TGIDs to trace (e.g., wh=
en
> > + * attached to a process with -p or tracing a specific command workloa=
d).
> > + *
> > + * has_pids_to_trace: Set to true if target PID filtering is active.
> > + *                    When false, all processes are eligible for traci=
ng.
> > + */
> > +struct pids_to_trace {
> > +     __uint(type, BPF_MAP_TYPE_HASH);
> > +     __type(key, pid_t);
> > +     __type(value, bool);
> > +     __uint(max_entries, 1024);
> > +} pids_to_trace SEC(".maps");
> > +
> > +bool has_pids_to_trace;
> > +
> > +/*
> > + * Hash map storing syscall IDs for filtering (via 'perf trace -e ...'=
).
> > + *
> > + * has_syscalls_to_trace: Set to true if any syscall filter is active.
> > + * not_syscalls_to_trace: Inverts matching when '!' prefix is used in =
-e
> > + *                        (e.g., -e !open,close means trace everything=
 EXCEPT
> > + *                        open and close; an exclusion blacklist rathe=
r than
> > + *                        an inclusion whitelist).
> > + */
> > +struct syscalls_to_trace {
> > +     __uint(type, BPF_MAP_TYPE_HASH);
> > +     __type(key, int);
> > +     __type(value, bool);
> > +     __uint(max_entries, 1024);
> > +} syscalls_to_trace SEC(".maps");
> > +
> > +bool has_syscalls_to_trace;
> > +bool not_syscalls_to_trace;
> > +
> >  struct augmented_args_payload {
> >       struct syscall_enter_args args;
> >       struct augmented_arg arg, arg2; // We have to reserve space for t=
wo arguments (rename, etc)
> > @@ -154,8 +189,8 @@ static inline struct augmented_args_payload *augmen=
ted_args_payload(void)
> >
> >  static inline int augmented__output(void *ctx, struct augmented_args_p=
ayload *args, int len)
> >  {
> > -     /* If perf_event_output fails, return non-zero so that it gets re=
corded unaugmented */
> > -     return bpf_perf_event_output(ctx, &__augmented_syscalls__, BPF_F_=
CURRENT_CPU, args, len);
> > +     bpf_perf_event_output(ctx, &__augmented_syscalls__, BPF_F_CURRENT=
_CPU, args, len);
> > +     return 1;
> >  }
> >
> >  static inline int augmented__beauty_output(void *ctx, void *data, int =
len)
> > @@ -191,10 +226,21 @@ unsigned int augmented_arg__read_str(struct augme=
nted_arg *augmented_arg, const
> >       return augmented_len;
> >  }
> >
> > -SEC("tp/raw_syscalls/sys_enter")
> > +/*
> > + * Default sys_enter program for syscalls without pointer argument aug=
mentation.
> > + * Writes the raw struct syscall_enter_args payload into __augmented_s=
yscalls__
> > + * and returns 1 so the tracepoint is never vetoed in the kernel.
> > + */
> > +SEC("tp/syscalls/sys_enter_unaugmented")
> >  int syscall_unaugmented(struct syscall_enter_args *args)
> >  {
> > -     return 1;
> > +     struct augmented_args_payload *augmented_args =3D augmented_args_=
payload();
> > +
> > +     if (augmented_args =3D=3D NULL)
> > +             return 1;
> > +
> > +     bpf_probe_read_kernel(&augmented_args->args, sizeof(augmented_arg=
s->args), args);
> > +     return augmented__output(args, augmented_args, sizeof(augmented_a=
rgs->args));
> >  }
> >
> >  /*
> > @@ -454,11 +500,41 @@ static pid_t getpid(void)
> >       return bpf_get_current_pid_tgid();
> >  }
> >
> > +/*
> > + * Returns true if a PID is explicitly excluded/filtered out (e.g., vi=
a --filter-pids).
> > + */
> >  static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
> >  {
> >       return bpf_map_lookup_elem(pids, &pid) !=3D NULL;
> >  }
> >
> > +/*
> > + * Checks if the current task (thread PID or process TGID) is targeted=
 for tracing.
> > + * Checks both PID (thread ID) and TGID (process ID) so that all threa=
ds of a
> > + * target process match.
> > + */
> > +static inline bool pid_to_trace__has(pid_t pid)
> > +{
> > +     pid_t tgid =3D bpf_get_current_pid_tgid() >> 32;
> > +
> > +     return bpf_map_lookup_elem(&pids_to_trace, &pid) !=3D NULL ||
> > +            bpf_map_lookup_elem(&pids_to_trace, &tgid) !=3D NULL;
> > +}
> > +
> > +/*
> > + * Determines if a syscall should be traced based on the filter map:
> > + * - When not_syscalls_to_trace is true: blacklist mode (trace if NOT =
in map).
> > + * - When not_syscalls_to_trace is false: whitelist mode (trace ONLY i=
f IN map).
> > + */
> > +static inline bool syscall_to_trace__enabled(int id)
> > +{
> > +     bool in_map =3D bpf_map_lookup_elem(&syscalls_to_trace, &id) !=3D=
 NULL;
> > +
> > +     if (not_syscalls_to_trace)
> > +             return !in_map;
> > +     return in_map;
> > +}
> > +
> >  u64 ZERO =3D 0;
> >
> >  /*
> > @@ -604,6 +680,11 @@ static int augment_sys_enter(void *ctx, struct sys=
call_enter_args *args)
> >       return augmented__beauty_output(ctx, payload, sizeof(struct sysca=
ll_enter_args) + output);
> >  }
> >
> > +/*
> > + * Main raw_syscalls:sys_enter tracepoint handler.
> > + * Always returns 1 so the tracepoint is never vetoed in the kernel fo=
r
> > + * other concurrent listeners. Filtered events simply do not output to=
 the ring buffer.
> > + */
> >  SEC("tp/raw_syscalls/sys_enter")
> >  int sys_enter(struct syscall_enter_args *args)
> >  {
> > @@ -618,8 +699,11 @@ int sys_enter(struct syscall_enter_args *args)
> >        * initial, non-augmented raw_syscalls:sys_enter payload.
> >        */
> >
> > +     if (has_pids_to_trace && !pid_to_trace__has(getpid()))
> > +             return 1;
> > +
> >       if (pid_filter__has(&pids_filtered, getpid()))
> > -             return 0;
> > +             return 1;
> >
> >       augmented_args =3D augmented_args_payload();
> >       if (augmented_args =3D=3D NULL)
> > @@ -627,25 +711,41 @@ int sys_enter(struct syscall_enter_args *args)
> >
> >       bpf_probe_read_kernel(&augmented_args->args, sizeof(augmented_arg=
s->args), args);
> >
> > +     if (has_syscalls_to_trace && !syscall_to_trace__enabled(augmented=
_args->args.syscall_nr))
> > +             return 1;
> > +
> >       /*
> > -      * Jump to syscall specific augmenter, even if the default one,
> > -      * "!raw_syscalls:unaugmented" that will just return 1 to return =
the
> > -      * unaugmented tracepoint payload.
> > +      * Jump to syscall specific augmenter. If augmented, augment_sys_=
enter()
> > +      * outputs the payload to __augmented_syscalls__ and returns 0.
> > +      * Return 1 so we never veto the kernel tracepoint for other list=
eners.
> >        */
> > -     if (augment_sys_enter(args, &augmented_args->args))
> > -             bpf_tail_call(args, &syscalls_sys_enter, augmented_args->=
args.syscall_nr);
> > +     if (augment_sys_enter(args, &augmented_args->args) =3D=3D 0)
> > +             return 1;
> >
> > -     // If not found on the PROG_ARRAY syscalls map, then we're filter=
ing it:
> > -     return 0;
> > +     bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.sys=
call_nr);
> > +
> > +     /*
> > +      * If not found on the PROG_ARRAY syscalls map, return 1 so we
> > +      * don't veto the tracepoint event system-wide for other concurre=
nt
> > +      * listeners.
> > +      */
> > +     return 1;
> >  }
> >
> > +/*
> > + * Main raw_syscalls:sys_exit tracepoint handler.
> > + * Always returns 1 so the tracepoint is never vetoed in the kernel.
> > + */
> >  SEC("tp/raw_syscalls/sys_exit")
> >  int sys_exit(struct syscall_exit_args *args)
> >  {
> >       struct syscall_exit_args exit_args;
> >
> > +     if (has_pids_to_trace && !pid_to_trace__has(getpid()))
> > +             return 1;
> > +
> >       if (pid_filter__has(&pids_filtered, getpid()))
> > -             return 0;
> > +             return 1;
> >
> >       bpf_probe_read_kernel(&exit_args, sizeof(exit_args), args);
> >       /*
> > @@ -655,9 +755,12 @@ int sys_exit(struct syscall_exit_args *args)
> >        */
> >       bpf_tail_call(args, &syscalls_sys_exit, exit_args.syscall_nr);
> >       /*
> > -      * If not found on the PROG_ARRAY syscalls map, then we're filter=
ing it:
> > +      * If not found on the PROG_ARRAY syscalls map, return 1 so we
> > +      * don't veto the tracepoint event system-wide for other concurre=
nt
> > +      * listeners. perf trace's own evsel filter will discard non-matc=
hing
> > +      * syscalls.
> >        */
> > -     return 0;
> > +     return 1;
> >  }
> >
> >  char _license[] SEC("license") =3D "GPL";
> > diff --git a/tools/perf/util/bpf_trace_augment.c b/tools/perf/util/bpf_=
trace_augment.c
> > index ebb26225fb04..5f15b27264e9 100644
> > --- a/tools/perf/util/bpf_trace_augment.c
> > +++ b/tools/perf/util/bpf_trace_augment.c
> > @@ -1,5 +1,6 @@
> >  #include <assert.h>
> >  #include <bpf/libbpf.h>
> > +#include <errno.h>
> >  #include <internal/xyarray.h>
> >  #include <string.h>
> >
> > @@ -12,6 +13,23 @@
> >  static struct augmented_raw_syscalls_bpf *skel;
> >  static struct evsel *bpf_output;
> >
> > +/* Set by attach_prog() so the first failure is what gets reported. */
> > +static int attach_err;
> > +
> > +static int attach_prog(struct bpf_link **link, struct bpf_program *pro=
g, const char *name)
> > +{
> > +     *link =3D bpf_program__attach(prog);
> > +     if (*link)
> > +             return 0;
> > +     /*
> > +      * Save errno before pr_debug(), which formats and writes output =
and so
> > +      * can overwrite it.
> > +      */
> > +     attach_err =3D -errno;
> > +     pr_debug("Failed to attach %s BPF program\n", name);
> > +     return attach_err;
> > +}
> > +
> >  int augmented_syscalls__prepare(void)
> >  {
> >       struct bpf_program *prog;
> > @@ -37,11 +55,35 @@ int augmented_syscalls__prepare(void)
> >       if (err < 0) {
> >               libbpf_strerror(err, buf, sizeof(buf));
> >               pr_debug("Failed to load augmented syscalls BPF skeleton:=
 %s\n", buf);
> > +             /*
> > +              * Tear the skeleton down rather than leaving a half init=
ialized
> > +              * one behind. The caller falls back to unaugmented traci=
ng and
> > +              * still calls the setters below, which must then do noth=
ing
> > +              * instead of failing against a skeleton with no maps.
> > +              */
> > +             augmented_syscalls__cleanup();
> >               return err;
> >       }
> >
> > -     augmented_raw_syscalls_bpf__attach(skel);
> > +     /*
> > +      * Only sys_enter and sys_exit are attached, the remaining progra=
ms are
> > +      * reached by tail calls. Attach them explicitly and, on failure,=
 undo
> > +      * any partial attachment: leaving sys_enter live on
> > +      * raw_syscalls:sys_enter would keep running a BPF program for ev=
ery
> > +      * syscall on the system for a perf trace session that never star=
ts.
> > +      */
> > +     if (attach_prog(&skel->links.sys_enter, skel->progs.sys_enter, "s=
ys_enter"))
> > +             goto out_cleanup;
> > +     if (attach_prog(&skel->links.sys_exit, skel->progs.sys_exit, "sys=
_exit"))
> > +             goto out_cleanup;
> > +
> >       return 0;
> > +
> > +out_cleanup:
> > +     err =3D attach_err;
> > +     /* Destroys every link attached above along with the skeleton. */
> > +     augmented_syscalls__cleanup();
> > +     return err;
> >  }
> >
> >  int augmented_syscalls__create_bpf_output(struct evlist *evlist)
> > @@ -82,22 +124,136 @@ void augmented_syscalls__setup_bpf_output(void)
> >       }
> >  }
> >
> > +/*
> > + * Add every pid to a pid keyed filter map.
> > + *
> > + * A map with no room left is not treated as a failure. bpf_map__updat=
e_elem()
> > + * answers -E2BIG once max_entries keys are present, and a task that d=
id not
> > + * fit is then one the filter does not know about, which is exactly th=
e
> > + * position it would be in had it been created after the map filled up=
.
> > + * Refusing to trace at all instead would make perf trace unusable aga=
inst the
> > + * very large targets that are the only way to reach the limit, so say=
 how many
> > + * missed out and carry on with those that did fit.
> > + */
> > +static int add_pids_to_map(struct bpf_map *map, const char *missing_ou=
t_on,
> > +                        unsigned int nr, pid_t *pids)
> > +{
> > +     unsigned int nr_no_room =3D 0;
> > +     bool value =3D true;
> > +
> > +     for (unsigned int i =3D 0; i < nr; ++i) {
> > +             int err =3D bpf_map__update_elem(map, &pids[i], sizeof(*p=
ids),
> > +                                            &value, sizeof(value), BPF=
_ANY);
> > +
> > +             if (err =3D=3D -E2BIG) {
> > +                     nr_no_room++;
> > +                     continue;
> > +             }
> > +             if (err)
> > +                     return err;
> > +     }
> > +
> > +     if (nr_no_room) {
> > +             pr_warning("Only %u of %u tasks fit in the %s BPF map, %u=
 will not be %s.\n",
> > +                        nr - nr_no_room, nr, bpf_map__name(map), nr_no=
_room,
> > +                        missing_out_on);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  int augmented_syscalls__set_filter_pids(unsigned int nr, pid_t *pids)
> > +{
> > +     if (skel =3D=3D NULL)
> > +             return 0;
> > +
> > +     return add_pids_to_map(skel->maps.pids_filtered, "filtered out", =
nr, pids);
> > +}
> > +
> > +/*
> > + * Populate target PIDs in the BPF pids_to_trace map (e.g., for -p <PI=
D> or
> > + * when tracing a specified command workload).
> > + */
> > +int augmented_syscalls__set_target_pids(unsigned int nr, pid_t *pids)
> > +{
> > +     int err;
> > +
> > +     if (skel =3D=3D NULL || nr =3D=3D 0)
> > +             return 0;
> > +
> > +     err =3D add_pids_to_map(skel->maps.pids_to_trace, "traced", nr, p=
ids);
> > +     if (err)
> > +             return err;
> > +
> > +     /*
> > +      * Set the flag only once every target is in the map. The BPF pro=
grams
> > +      * are attached by this point, so flipping it first would have th=
em
> > +      * filter against a partially populated map and drop syscalls mad=
e by
> > +      * the targets that had not been added yet.
> > +      */
> > +     skel->bss->has_pids_to_trace =3D true;
> > +     return 0;
> > +}
> > +
> > +int augmented_syscalls__add_target_pid(pid_t pid)
> > +{
> > +     bool value =3D true;
> > +
> > +     if (skel =3D=3D NULL || !skel->bss->has_pids_to_trace || skel->ma=
ps.pids_to_trace =3D=3D NULL)
> > +             return 0;
> > +
> > +     return bpf_map__update_elem(skel->maps.pids_to_trace, &pid, sizeo=
f(pid),
> > +                                 &value, sizeof(value), BPF_ANY);
> > +}
> > +
> > +int augmented_syscalls__del_target_pid(pid_t pid)
> > +{
> > +     if (skel =3D=3D NULL || !skel->bss->has_pids_to_trace || skel->ma=
ps.pids_to_trace =3D=3D NULL)
> > +             return 0;
> > +
> > +     return bpf_map__delete_elem(skel->maps.pids_to_trace, &pid, sizeo=
f(pid), 0);
> > +}
> > +
> > +bool augmented_syscalls__has_target_pid(pid_t pid)
> > +{
> > +     bool value;
> > +
> > +     if (skel =3D=3D NULL || !skel->bss->has_pids_to_trace || skel->ma=
ps.pids_to_trace =3D=3D NULL)
> > +             return false;
> > +
> > +     return bpf_map__lookup_elem(skel->maps.pids_to_trace, &pid, sizeo=
f(pid),
> > +                                 &value, sizeof(value), 0) =3D=3D 0;
> > +}
> > +
> > +/*
> > + * Populate syscalls in the BPF syscalls_to_trace map:
> > + * - not_syscalls: true if '!' prefix was specified (blacklist mode: t=
race
> > + *   all syscalls EXCEPT these).
> > + *   false if whitelist mode (trace ONLY these syscalls).
> > + */
> > +int augmented_syscalls__set_target_syscalls(unsigned int nr, int *sysc=
all_ids, bool not_syscalls)
> >  {
> >       bool value =3D true;
> >       int err =3D 0;
> >
> > -     if (skel =3D=3D NULL)
> > +     if (skel =3D=3D NULL || nr =3D=3D 0)
> >               return 0;
> >
> > +     skel->bss->not_syscalls_to_trace =3D not_syscalls;
> >       for (size_t i =3D 0; i < nr; ++i) {
> > -             err =3D bpf_map__update_elem(skel->maps.pids_filtered, &p=
ids[i],
> > -                                        sizeof(*pids), &value, sizeof(=
value),
> > +             err =3D bpf_map__update_elem(skel->maps.syscalls_to_trace=
, &syscall_ids[i],
> > +                                        sizeof(int), &value, sizeof(va=
lue),
> >                                          BPF_ANY);
> >               if (err)
> > -                     break;
> > +                     return err;
> >       }
> > -     return err;
> > +     /*
> > +      * As for the pid maps, publish the filter only once it is comple=
te:
> > +      * in whitelist mode a half filled map would drop syscalls that w=
ere
> > +      * asked for but not added yet.
> > +      */
> > +     skel->bss->has_syscalls_to_trace =3D true;
> > +     return 0;
> >  }
> >
> >  int augmented_syscalls__get_map_fds(int *enter_fd, int *exit_fd, int *=
beauty_fd)
> > @@ -142,4 +298,5 @@ struct bpf_program *augmented_syscalls__find_by_tit=
le(const char *name)
> >  void augmented_syscalls__cleanup(void)
> >  {
> >       augmented_raw_syscalls_bpf__destroy(skel);
> > +     skel =3D NULL;
> >  }
> > diff --git a/tools/perf/util/trace_augment.h b/tools/perf/util/trace_au=
gment.h
> > index a1cd9a5e0213..5702eda3b469 100644
> > --- a/tools/perf/util/trace_augment.h
> > +++ b/tools/perf/util/trace_augment.h
> > @@ -2,6 +2,7 @@
> >  #define TRACE_AUGMENT_H
> >
> >  #include <linux/compiler.h>
> > +#include <stdbool.h>
> >  #include <sys/types.h>
> >
> >  struct bpf_program;
> > @@ -13,6 +14,11 @@ int augmented_syscalls__prepare(void);
> >  int augmented_syscalls__create_bpf_output(struct evlist *evlist);
> >  void augmented_syscalls__setup_bpf_output(void);
> >  int augmented_syscalls__set_filter_pids(unsigned int nr, pid_t *pids);
> > +int augmented_syscalls__set_target_pids(unsigned int nr, pid_t *pids);
> > +int augmented_syscalls__add_target_pid(pid_t pid);
> > +int augmented_syscalls__del_target_pid(pid_t pid);
> > +bool augmented_syscalls__has_target_pid(pid_t pid);
> > +int augmented_syscalls__set_target_syscalls(unsigned int nr, int *sysc=
all_ids, bool not_syscalls);
> >  int augmented_syscalls__get_map_fds(int *enter_fd, int *exit_fd, int *=
beauty_fd);
> >  struct bpf_program *augmented_syscalls__find_by_title(const char *name=
);
> >  struct bpf_program *augmented_syscalls__unaugmented(void);
> > @@ -40,6 +46,34 @@ static inline int augmented_syscalls__set_filter_pid=
s(unsigned int nr __maybe_un
> >       return 0;
> >  }
> >
> > +static inline int augmented_syscalls__set_target_pids(unsigned int nr =
__maybe_unused,
> > +                                                   pid_t *pids __maybe=
_unused)
> > +{
> > +     return 0;
> > +}
> > +
> > +static inline int augmented_syscalls__add_target_pid(pid_t pid __maybe=
_unused)
> > +{
> > +     return 0;
> > +}
> > +
> > +static inline int augmented_syscalls__del_target_pid(pid_t pid __maybe=
_unused)
> > +{
> > +     return 0;
> > +}
> > +
> > +static inline bool augmented_syscalls__has_target_pid(pid_t pid __mayb=
e_unused)
> > +{
> > +     return false;
> > +}
> > +
> > +static inline int augmented_syscalls__set_target_syscalls(unsigned int=
 nr __maybe_unused,
> > +                                                       int *syscall_id=
s __maybe_unused,
> > +                                                       bool not_syscal=
ls __maybe_unused)
> > +{
> > +     return 0;
> > +}
> > +
> >  static inline int augmented_syscalls__get_map_fds(int *enter_fd __mayb=
e_unused,
> >                                                 int *exit_fd __maybe_un=
used,
> >                                                 int *beauty_fd __maybe_=
unused)
> > --
> > 2.56.0.rc1.315.gc6ed9934b7-goog
> >
