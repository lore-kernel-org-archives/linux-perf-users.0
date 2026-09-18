Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472D72248B3
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 22:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789768844; cv=pass; b=HQi/19oAn20L6upY067Y4V1Y5ToxjCCwRcOywfQ2WK6GNx2E1A08oDqyK4E4UdIyPZjW1agnByMV8IBJ2dGtW1tUCB62hVVJFsY2Z0suPa7TS+vrBd9kEKOM8DeRwJz97LTg63oYvUFHvP70U7T2AnQsTjEip9NEbknXDTk4jCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789768844; c=relaxed/simple;
	bh=TmCs5ofZU+TclI3oWVVxS8pM8JPDChlkug0+4bWkhuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPPFLSoabdacSrLYRmFRbD7kBEBVsnNWUXAmXUpVVTdzCNVbQxYGRUXiQtFmYHGrtpInFpHqQqVB1qwjOYy3lBKt1RG8tHskuBIleKactPCXmYQzbSr0gOsXEJxPuCOd7xqzJ2ml/qjI4qGmvysA3qZerlyj+aodn7vMjfPEiPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QyXd8TB6; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QyXd8TB6"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-530e8c6fb80so31561cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 15:00:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789768842; cv=none;
        d=google.com; s=arc-20260327;
        b=SpOYxymOd+G0c+FJwFjxg+h7jrY1UOGfm5sPmwQhdTmZC5t1Awxcjt2+az268rQzcC
         0Xng8+yXNvSbIc3XYHQP5By2eGwxib+RnHUO1AbsZmO0cL/CdIn07piGSiTi6zrugZFr
         Jh1iIclxfBy3hQzt4MlgnyJSMnesea8mfBKgOuABldIHTyjiJVsQfabf+9iquW0PbHaV
         PfqX4XGI9CCJfafrSU3XhfPpH32hcfo9SaYV36nGPcOrpVhVp2ZJq+wDqUF0wiVcDbs/
         pZqfYjukEB94xlZN6InWCwoETV81z9LYX7XZ0g3HByc9yXNQpYi4atf5fseclax50xDg
         TT+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=voiOG/difO2vCowMEa4Xsn6iYIriusXWzrTniudY9zQ=;
        fh=T8dWnGLZpRfdd1GtomhsEEEJmLiuS2TNXGJEdl0QR30=;
        b=Zy/T3NnYU47rO27wOdoZIzpjC8BkSf2oYKXk0n+vytZYqbazFQ7zbJVSfUC/DCLwzg
         DszXL4S3KJzV4L7CNjq1keDzkDX2u8LHv1q2IRGk5NvS9DReurqhJ+4D4n58BzHZZeQO
         54a/xfshO9CdlICVqEiqigaE1N97FClR6PlMHeqS85Yr82UDnxHtSaG2dACXnHV8Tg3F
         qJFDjh4S7POxpB5ocB0RWN3z2uXwp4i85hTcbTKIswlLwFviTwB1AxTs/s8EI1Mmlv7J
         3PoRCLImyu/ti6TuM26D+LVg3rZWc8X6sbP5TbucHSTta3zTyfPcD5jCzNdOMLZpLXKA
         +e9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789768842; x=1790373642; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=voiOG/difO2vCowMEa4Xsn6iYIriusXWzrTniudY9zQ=;
        b=QyXd8TB6UVbqzuLJSkHFcLywuQFWavonu5PqblotGmsryOI57AbC0yaGIfj1hGl19G
         2eofN1YncVJ9y2LoJzz9g9JuVSYapRV5bUJBz3OkhPl0Ucn1Jawhbdt7KsG5rAkkWk8s
         iYxdloA86qexz621zwQ7dIvgMdjydys1yn8UlbXWiIuiTG6EmQLh0UecA1Iaq0AwFNge
         PQK0X+CsARAsBXhApZz+7U3kvFBt8o4fTRMfDUCr7YlLt52+JrQGURTtfuPCWhvw1NuA
         QB/a0w8JFF+PstQWNhjD9WpiYNe0N1eM++39SSafBcg2Dok71IWPwnudTUBrjgtJ4qKN
         mlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789768842; x=1790373642;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=voiOG/difO2vCowMEa4Xsn6iYIriusXWzrTniudY9zQ=;
        b=0wfy5cfTfalnkQCttThzBcml8VYpjNAYtykcf03UKQH6odQU9GG8RS8RkdzRhH7Xtr
         BYmBn3CWdJwAve5RMmAFOwRjboET2YGJqiHqI4bHUxsx4+1ajvcVhxPGRW0q39qYHQRv
         zD8nvRnxRbTYtKWMJkHnFMe66LfGYNkSoFtq6/PR4uN9NwcU9M3jUJd+4VyNY2MNNX0u
         PLUJLtGstuxj0UW5L9F5ckMs6YJUDA+NR3jXFFqJPaNCrsGVfyeoWejKkyVrVBRxJh6F
         uTf7sVwTuwXuaUTjXeW+3gTO8Abo9N6wS8m4Vc+A3DGahKSYsIxz6Je334KvZzWl4jok
         buIg==
X-Gm-Message-State: AFuF++kWufc111n1IAHl1ElZn8Fq0TUfFn4IEzE7swswyslFlfOg33Yk
	e56TpvGYT0p4wRgvf1Er1uZFMFSNtChfqWD/5H7zFTCWTt4ylJk3JZlSFAllRbTUYuucOc05uLA
	P2oflnIqhA51vL9JaP5Jlr7DExdpYymIUg2XSo4WmeHuZf2u3/be9edn2Nrk=
X-Gm-Gg: AYBFou1fzVdFG8j4PhZCXleSpDaaYx+Uzt24+StHQmx/inoekWRq4PFiYXrvXu1jsAS
	EsOul1zHi11OQ1aZO5j0Rjc8Q49j0Jv+4OauwalrbS/OjxdTCHXAZb8jLYi6+svkYoqHMbX8w4b
	gc62WUvPKd0b97b5JoXiqZotaC/0mtv+HeWDb8wNrwO7FJCiKXKxBAac2H40G/qLW8fr1D5PjQe
	k0kWsp2GBsokF3hIREn/kHNzcGiVqu4tefrWnp2Z1dnZkSZAUCs3NX9/HfQMsa/JvbZQE5+qbfD
	TqFq0S0l/0fSNRVMe4GImrZfUuCjQzdt54thTl4JfSF36rzu+p+qrjYjJg7lPVoop1VyZi4=
X-Received: by 2002:ac8:5fd0:0:b0:531:6de:6028 with SMTP id
 d75a77b69052e-532b09aad6dmr1769141cf.13.1789768841013; Fri, 18 Sep 2026
 15:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918140659.2501976-1-irogers@google.com> <20260918211932.2966061-1-irogers@google.com>
 <20260918211932.2966061-9-irogers@google.com> <20260918213125.85DF91F000FF@smtp.kernel.org>
In-Reply-To: <20260918213125.85DF91F000FF@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 18 Sep 2026 15:00:29 -0700
X-Gm-Features: AcwNN1W_zNlqplcBtqh7oAjSzMnaMFpZjZzCcGJBJHo17uslgWdOtP7wrF1plBc
Message-ID: <CAP-5=fWcmkD4xmVTR84McT=NOveRALKKvPTzaPfi2HRWYxkfZg@mail.gmail.com>
Subject: Re: [PATCH v4 08/18] perf trace: Handle fork and exit directly in BPF
 filter maps
To: linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 2:31=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] perf: PID reuse TOCTOU race in sched_process_exec
> --
>
> commit d8a2403eb7c48846672bae9851f669ee1a4f9446
> Author: Ian Rogers <irogers@google.com>
>
> perf trace: Handle fork and exit directly in BPF filter maps
>
> This commit shifts PID map filtering for fork and exit events from
> asynchronous userspace handling directly to BTF-typed BPF programs attach=
ed
> to scheduler tracepoints. This closes windows where events might be dropp=
ed
> due to PIDs being recycled before userspace processes the tracking events=
.
>
> > diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/to=
ols/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> [ ... ]
> > +SEC("tp_btf/sched_process_exec")
> > +int BPF_PROG(sched_process_exec, struct task_struct *p, pid_t old_pid)
> > +{
> > +     pid_t pid =3D p->pid;
> > +     bool val =3D true;
> > +
> > +     if (pid =3D=3D old_pid)
> > +             return 0;
> > +
> > +     /*
> > +      * Drop the old key before adding the new one. The maps are bound=
ed and
> > +      * the move is only ever a rename, but inserting first needs a sp=
are
> > +      * slot for as long as both keys are present: on a full map that =
insert
> > +      * fails with -E2BIG while the delete still succeeds, which would=
 lose
> > +      * the task rather than move it. Deleting first frees the slot th=
e
> > +      * insert goes on to use. The task is mid exec and issues no sysc=
alls in
> > +      * between, so the gap is not observable.
> > +      *
> > +      * There is no atomic rename for a hash map, so on a map that is =
exactly
> > +      * full this narrows the window rather than closing it: a fork on
> > +      * another CPU can still take the freed slot before the insert be=
low
> > +      * runs, and the task is then dropped just as any other task is o=
nce the
> > +      * map is full.
> > +      */
> > +     if (bpf_map_lookup_elem(&pids_to_trace, &old_pid) !=3D NULL) {
> > +             bpf_map_delete_elem(&pids_to_trace, &old_pid);
> > +             bpf_map_update_elem(&pids_to_trace, &pid, &val, BPF_ANY);
> > +     }
>
> [Severity: Medium]
> Does this sequence have a TOCTOU race with PID reuse?
>
> When a non-leader thread calls execve, its old PID is released in
> de_thread() before the sched_process_exec tracepoint fires. If a concurre=
nt
> fork on another CPU recycles this old PID before the tracepoint executes,
> could this BPF program inadvertently delete the new process's state from
> pids_to_trace, while simultaneously updating the exec'ing task's tracing
> state based on the recycled PID's state?
>
> While PID wrap-around in this microsecond window might be rare in practic=
e,
> can local userspace trigger this by racing execve and fork under heavy
> thread creation load, leading to corrupted trace states and silent drops
> for newly created tasks?

Recycling PIDs within that window is possible, but it would require
such heavy load that fixing it isn't considered a worthwhile
introduction of complexity. A longer LLM explanation follows.

Thanks,
Ian

Yes, and the window is wider than the question suggests. old_pid is
sampled in exec_binprm() before the loader runs:

  /* Need to fetch pid before load_binary changes it */
  old_pid =3D current->pid;
  ...
  ret =3D search_binary_handler(bprm);
  ...
  trace_sched_process_exec(current, old_pid, bprm);

de_thread() is reached from begin_new_exec(), inside that
search_binary_handler(). exchange_tids() hands the exec'ing thread the
leader's pid, and release_task(leader) then frees the pid the thread
started with, since the leader is holding it after the swap. old_pid
is therefore up for reuse for the whole of the rest of the exec -
mapping the binary and the interpreter, setup_arg_pages(), and any
faults those take - and not merely for an instant either side of the
tracepoint.

## What the race actually costs

Because the maps are keyed by pid alone, the exec'ing thread T (old
tid P_old) and the task N that was given P_old share one key =E2=80=94
sched_process_fork() inserting N just overwrites the slot. So the
program cannot tell whose entry it is moving, and the outcome depends
on who the surviving entry was really for:

   T in map?              | N in map?              | Result
  ------------------------|------------------------|-----------------------=
-----------------------
   yes                    | no                     | Move is correct =E2=80=
=94
nothing lost
   yes                    | yes                    | One shared entry
moves to T; N loses it
   no                     | yes                    | N's entry moves
to T; N loses it, T gains it
   no                     | no                     | Lookup fails, no-op

The three harms that fall out of the two bad rows:

1. N silently loses its entry. In pids_to_trace it stops being
reported for the rest of the session; in pids_filtered its exclusion
is gone, so it starts being reported even though -- filter-pids named
it.

2. N's descendants go with it. sched_process_fork() admits a child by
looking up parent->pid, so once N's entry is gone nothing N forks
afterwards is added either. The loss is a subtree, not one task.

3. T gains an entry it did not earn (bottom row only). In
pids_to_trace a task outside the target set gets reported; in
pids_filtered a task that was being traced is now silently excluded.

None of it self-heals =E2=80=94 nothing re-adds N, and sched_process_exit()
only ever deletes.

## Why leave it alone

1. Nothing here can tell the two apart. The value is a bool: presence
says only "some task with this pid was of interest". Closing the race
means putting a task identity in the value for the exec handler to
compare against p =E2=80=94 start time, say. But userspace seeds entries to=
o,
and /proc only publishes start time at clock-tick resolution, so the
target's own threads enumerated at startup could carry no usable
identity and would have to be waved through. Partial coverage for a
fair amount of machinery.

2. It cannot be aimed at. A task can't request a pid =E2=80=94 clone3()'s
set_tid is gated on checkpoint_restore_ns_capable(). Everything else
goes through idr_alloc_cyclic(pid_min, pid_max), so hitting P_old
means getting the cursor the whole way round inside one exec, i.e.
running the pid space near exhaustion rather than just forking hard.

3. It stays inside the session. Both maps only ever hold tasks perf
trace was already following, so this is misattribution within the
target set, not tracing escaping it. No privilege boundary is involved
=E2=80=94 perf trace could already trace both tasks.

> > +
> > +     if (bpf_map_lookup_elem(&pids_filtered, &old_pid) !=3D NULL) {
> > +             bpf_map_delete_elem(&pids_filtered, &old_pid);
> > +             bpf_map_update_elem(&pids_filtered, &pid, &val, BPF_ANY);
> > +     }
> > +
> > +     return 0;
> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918211932.29=
66061-1-irogers@google.com?part=3D8
