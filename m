Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A2D30568B
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Jul 2026 08:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783844355; cv=pass; b=eichYvel3qmgzQGaXsAcxxbnEL37BAI8Zg2pXfYrUAlj5HB2uU5kvAJXE7AQGGF0hEfcAeHpUwd7oPy/L+3/ml0kitPscE8PjjsFiQzfk09LS0MhXqRD6ep5zLldi/A9wfQ5G/N5GbfOk7GpGZ6suf8FZX8QO6glsviOD8NdANU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783844355; c=relaxed/simple;
	bh=UHGF0CrkcIHO06sp/4kNQatZxXFkPj2avz5THKyd2vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0JEpllLy8Tg8U88F27X19jlRKasrukVCDflUKpm4rbWN8P0xY9v7+3Sq+H3PBk/gbVExHWXnwPmaHX08kOokz3xE/lBHI/ciS1ek8uhmj8QELKfBcc0f0W2k67c1SDYMTiMmTLUmQgvBYVER1nWfPl5pXFUzIys4zyYX2COuAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=KJJtkMzc; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="KJJtkMzc"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-471eeac43bfso2192353f8f.3
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Jul 2026 01:19:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783844352; cv=none;
        d=google.com; s=arc-20260327;
        b=QU6BL//z3gq51oYPbZmOJf+Oq5seMEXOBveIC37otjXbpjja0x8EynydTeNkSwUPcH
         wFdYln3lEDn4/FZ9o+i6T2r34NvD7z/imX6UhoJzlaXN77rwulPGafhh+7gaR4HpwaUC
         RNuGlqzGCfpD95ImDRYa0qupYKvCBOmC8y0PHaX8CA7ALhbVgBvvM1M2Nj8QFAy2NTFT
         6FZvEzGW0ls0Ylyg5eOLm1Un3snE8zGJS/u2V93bwRkqxnj5RW/JxRWl2UhEqVSv5Qsb
         HhBJPEIiFaCU4U7IiVGBQraQQ55rXubgnDDt0wwPwax5Hjo16LP39qrzXMnSs9TZQJDg
         ju3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qBv7Hzc/dZ4vhh805+d6rzCMGOGEUHJn0T0uC+unQno=;
        fh=C1MdBf9ry+pSBYndxjeXPGicnwQRPMwHsLvQSIp9kaQ=;
        b=GxET89kSXl3a926nW0lJmpC5GijvlVTH31R9MHNY8WBgBm1Y6uWxSum1HsPtlG/Or8
         LFUloIrMEZXVrO7AQP5PZOU3uBvRLGGem9zmkMcDggWH+fR9fW/xmfgeWagSdXv7uf1N
         zUrJYBCerVlKNjjERXIuepdVkruQ2H01uOQeylpa2M/gH6s6Ay670NDtU6A8FsJdvnOA
         bMZcOcKAyUCAJgTwZGNY797Bdx4JeMNcu7K8jhhayxzBU3Hg2+NqhKKYQXPqD27l73C2
         MM6ONtzQmn7vFGs/0I0bJAwYd8hc7/WgPXkzwP1/BAUyLMePdTAKXyXIAO38Xkb93/lM
         PC7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1783844352; x=1784449152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qBv7Hzc/dZ4vhh805+d6rzCMGOGEUHJn0T0uC+unQno=;
        b=KJJtkMzctmzlFVHZKt9IZfHpZYVUeseEBSrt9pI9hzaF38xguzF1aytKIAJtMGUNKi
         LJz92gCDvS+zCYfm9GUXSLO4vHJ9Ssm2rWNIiL+3dJhlpQSnbdOdBPLqlUzxtPS3wT4W
         CUyHgPMTc7hprpbawAtgwZowKJ+3cBbpVLQng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783844352; x=1784449152;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qBv7Hzc/dZ4vhh805+d6rzCMGOGEUHJn0T0uC+unQno=;
        b=IjbtD5xaq41fa2+CI05lrjPBY6AM+cLj1blRxEcOZEKaSoL4cG69Ne4sx96NHCj4Yl
         W0RmJJx2FUV65O0da4RJJmIN/mDQYV48lTBZ4RbwBwgXufQ1w5Ex/imXIQrScxiQFl8o
         iAhDRYC87kfti6MocicH9/cgflxyuNbr9+71Z1xqJLuVL2u7DBdr/BnlfT8d+/7ZQzme
         h6zrjWpJp6RiDCb084fn58oTrIWgaaUZax088mozQWmdD+65V6jKG8kYK+WsP6VuqRvf
         YjWygAnTMHgAkTCWbrM23Th+9DvXyyMVpfTCX2Q4c8lyq8yIAOtbusm/Ntaf4RcT6h4S
         531A==
X-Forwarded-Encrypted: i=1; AHgh+RriwNJzjm9dgB6jcfNiyDFR9i5UCsPXBtSvxHs5h1pLbPuLbJaH/Yd0I/+qWprHQH5ASwP98sqCYGfEGrO93y7Q@vger.kernel.org
X-Gm-Message-State: AOJu0YyymGgpSoMqYJpzFCiZcsDoNTXqRn66p/DGe6vr/uaCbdUpAzbU
	P7dfDHcYFCLbE+0suSZRjOhGYKVlx3gBSuQzqJ84ZO9UvytBcj5Rfy94vZxkAXNauJ5UFeyZrjK
	QJIdP7qskKiVIs26NNTpI+UeMRvtECj2gP/ktdPUsUA==
X-Gm-Gg: AfdE7ck7WOZMtjj9u+HZ3ogrEK4iqKarAnIZChWk6GWwSa1kgLXTgAcmONpw/hEsB0a
	sSkJ8maCqRCBWQ9SkDck2sl2Ot1bu1u1pIlpPuJNKVHyF23qWszz1Zi6gOOjJnCNZFTWV6OST1+
	NHU6+zZsRSJbPXzJdSGR8g4ZjVaFeCdXl02JgILOWGjFhsS/pCbsrzk92B93ztrHEEdttpxSIqP
	Jr/oQ0Wnqc6DLtcKmQepfpcDz6qrgkw+bWtUw6LuXZKi6f0ECuNZlalirsxDzxm+6DpWEzmsXdB
	jUA/U432vDbyKkKx70KWX8uaRA==
X-Received: by 2002:a05:6000:22c5:b0:46d:d6e0:9cc8 with SMTP id
 ffacd0b85a97d-47f2dcfcd4amr5338205f8f.46.1783844351632; Sun, 12 Jul 2026
 01:19:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ai65GgZcC0LAlWLG@Taeyangs-MacBook-Pro.local> <178307254759.3843924.2571598962077552395.tip-bot2@tip-bot2>
 <CAP-5=fVq=2D6XjVEbAvJz54hG6PcwZZjn-za0hAfK8YV-J+MtQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVq=2D6XjVEbAvJz54hG6PcwZZjn-za0hAfK8YV-J+MtQ@mail.gmail.com>
From: Taeyang Lee <0wn@theori.io>
Date: Sun, 12 Jul 2026 17:18:33 +0900
X-Gm-Features: AUfX_myH6eOczxIdmAD6LZCfXk_SL4V87DHggVEtPdfgryU-SxH-LP9EyDsXaAk
Message-ID: <CAH-2Xv+Y7SOs9Lt2j3PacxefO8EewMurBJ3SdhnJdOf7Eqegmg@mail.gmail.com>
Subject: Re: [tip: perf/urgent] perf/core: Detach event groups during remove_on_exec
To: Ian Rogers <irogers@google.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

I agree that the prctl enable/disable path has a real lock inversion:
perf_event_task_enable()/disable() takes owner->perf_event_mutex before
event->ctx->mutex, while perf_event_remove_on_exec() takes ctx->mutex
before perf_remove_from_owner(), which then takes owner->perf_event_mutex.

This appears pre-existing from the remove_on_exec path rather than being
introduced by 037a3c43edfb; the recent patch changes the detach flags after
perf_remove_from_owner() and does not change this lock ordering. I agree
this should be investigated/fixed separately.

I don't think close(fd) has the same ordering issue, since
perf_event_release_kernel() drops owner->perf_event_mutex before taking
ctx->mutex, but the prctl path is enough for the AB-BA.

Thanks,

On Fri, Jul 10, 2026 at 2:51=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Jul 3, 2026 at 3:02=E2=80=AFAM tip-bot2 for Taeyang Lee
> <tip-bot2@linutronix.de> wrote:
> >
> > The following commit has been merged into the perf/urgent branch of tip=
:
> >
> > Commit-ID:     037a3c43edfb597665dd34457cd22b14692f2ba3
> > Gitweb:        https://git.kernel.org/tip/037a3c43edfb597665dd34457cd22=
b14692f2ba3
> > Author:        Taeyang Lee <0wn@theori.io>
> > AuthorDate:    Sun, 14 Jun 2026 23:22:18 +09:00
> > Committer:     Peter Zijlstra <peterz@infradead.org>
> > CommitterDate: Thu, 02 Jul 2026 13:21:48 +02:00
> >
> > perf/core: Detach event groups during remove_on_exec
> >
> > perf_event_remove_on_exec() removes events by calling
> > perf_event_exit_event(). For top-level events, this removes the event f=
rom
> > the context with DETACH_EXIT only.
> >
> > This can leave inconsistent group state when a removed event is a group
> > leader and the group contains siblings without remove_on_exec. If the g=
roup
> > was active, the surviving siblings can remain active and attached to th=
e
> > removed leader's sibling list, but are no longer represented by a valid
> > group leader on the PMU context active lists.
> >
> > A later close of the removed leader uses DETACH_GROUP and can promote t=
he
> > still-active siblings from this stale group state. The next schedule-in=
 can
> > then add an already-linked active_list entry again, corrupting the PMU
> > context active list.
> >
> > With DEBUG_LIST enabled, this is caught as a list_add double-add in
> > merge_sched_in().
> >
> > Fix this by detaching group relationships when remove_on_exec removes a=
n
> > event. This preserves the existing task-exit and revoke behavior, while
> > ensuring surviving siblings are ungrouped before the removed event leav=
es
> > the context.
> >
> > Fixes: 2e498d0a74e5 ("perf: Add support for event removal on exec")
> > Signed-off-by: Taeyang Lee <0wn@theori.io>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Link: https://patch.msgid.link/ai65GgZcC0LAlWLG@Taeyangs-MacBook-Pro.lo=
cal
>
> Hi Peter, Taeyang and Marco,
>
> AI code review has flagged this code as introducing, or at least being
> adjacent, to an existing deadlock. An example of the problem is with
> an event being enabled at the same time as perf_event_remove_on_exec
> is running due to the user code doing an exec. It seems possible for 1
> CPU to hold the perf_event_mutex and be trying to get the
> perf_event_context->mutex while the other CPU has the
> perf_event_context->mutex and is trying to get the perf_event_mutex. A
> fuller AI-generated analysis is below, and it seems correct but I may
> be missing something. The fixes for this look somewhat large so I
> thought I'd flag the issue before trying anything.
>
> Thanks,
> Ian
>
> ## Executive Summary
>
> The reported potential AB-BA deadlock between
> `owner->perf_event_mutex` (class `&task_struct->perf_event_mutex`) and
> `ctx->mutex` (class `&perf_event_context->mutex`) is **PRESENT** in
> the current tip-of-tree code in `torvalds/master`.
>
> The lock inversion was introduced in 2021 by commit `2e498d0a74e5`
> ("perf: Add support for event removal on exec") and remains in the
> code after the recent fix in commit `037a3c43edfb` ("perf/core: Detach
> event groups during remove_on_exec").
>
> The use of `SINGLE_DEPTH_NESTING` in `perf_remove_from_owner()`
> suppresses the Lockdep warning for this specific inversion but **fails
> to prevent the actual CPU deadlock at runtime**.
>
> ## Lock Inversion Paths
>
> The deadlock can be triggered by Process A (Owner) and Process B
> (Monitored Task) executing concurrent system calls.
>
> ### Process A Paths (Normal Lock Order: `owner->perf_event_mutex` ->
> `ctx->mutex`)
>
> #### Path A1: `prctl(PR_TASK_PERF_EVENTS_ENABLE / DISABLE)`
> Process A invokes `prctl` to enable or disable events it owns.
> 1. **`perf_event_task_enable()`** (or `disable`):
>    - Acquires `current->perf_event_mutex` (which is **`A->perf_event_mute=
x`**).
>    - Iterates over `A->perf_event_list`.
>    - For an event monitoring Process B, calls **`perf_event_ctx_lock(even=
t)`**.
> 2. **`perf_event_ctx_lock_nested()`**:
>    - Acquires **`event->ctx->mutex`** (which is **`CtxB->mutex`**).
>
> **Result:** `A->perf_event_mutex` =E2=86=92 `CtxB->mutex`.
>
> #### Path A2: `close(event_fd)`
> Process A (or any task holding a reference to the event fd) closes the
> event file descriptor.
> 1. **`perf_release()`** -> **`perf_event_release_kernel()`**:
>    - Calls **`perf_remove_from_owner(event)`**.
> 2. **`perf_remove_from_owner()`**:
>    - Reads `event->owner` (which is Process A).
>    - Acquires **`owner->perf_event_mutex`** (which is
> **`A->perf_event_mutex`**).
> 3. **`perf_event_release_kernel()`** continues:
>    - Calls **`perf_event_ctx_lock(event)`**.
> 4. **`perf_event_ctx_lock_nested()`**:
>    - Acquires **`event->ctx->mutex`** (which is **`CtxB->mutex`**).
>
> **Result:** `A->perf_event_mutex` =E2=86=92 `CtxB->mutex`.
>
> ### Process B Path (Inverted Lock Order: `ctx->mutex` ->
> `owner->perf_event_mutex`)
>
> #### Path B1: `execve()`
> Process B invokes `execve` to execute a new program image. The events
> monitoring Process B that have the `attr.remove_on_exec =3D 1` bit set
> are removed.
> 1. **`begin_new_exec()`** -> **`perf_event_exec()`** ->
> **`perf_event_remove_on_exec()`**:
>    - Acquires **`ctx->mutex`** (which is **`CtxB->mutex`**).
>    - Iterates over `CtxB->event_list`.
>    - Finds an event with `attr.remove_on_exec =3D 1` (owned by Process A)=
.
>    - Calls **`perf_remove_from_owner(event)`**.
> 2. **`perf_remove_from_owner()`**:
>    - Reads `event->owner` (which is Process A).
>    - Acquires **`owner->perf_event_mutex`** (which is
> **`A->perf_event_mutex`**) via
> `mutex_lock_nested(&owner->perf_event_mutex, SINGLE_DEPTH_NESTING)`.
>
> **Result:** `CtxB->mutex` =E2=86=92 `A->perf_event_mutex`.
>
> ## Concrete Deadlock Interleaving
>
> If Process A and Process B execute Path A1 (or A2) and Path B1
> concurrently on different CPUs, the following interleaving causes a
> CPU deadlock:
>
> | CPU 0 (Process A) | CPU 1 (Process B) |
> | :--- | :--- |
> | Enters `perf_event_task_enable()` | Enters `perf_event_remove_on_exec()=
` |
> | Acquires **`A->perf_event_mutex`** | Acquires **`CtxB->mutex`** |
> | Calls `perf_event_ctx_lock(event)` | Calls `perf_remove_from_owner(even=
t)` |
> | Tries to acquire **`CtxB->mutex`**<br>**(BLOCKS on CPU 1)** | Tries
> to acquire **`A->perf_event_mutex`**<br>**(BLOCKS on CPU 0)** |
>
> Both processes are now blocked waiting for each other, resulting in a
> permanent system hang (or soft lockup) on the affected cores.
>
> ## Analysis of `SINGLE_DEPTH_NESTING`
>
> In `perf_remove_from_owner()`, the lock is acquired as:
> ```c
> mutex_lock_nested(&owner->perf_event_mutex, SINGLE_DEPTH_NESTING);
> ```
> Where `SINGLE_DEPTH_NESTING` is defined as `1`.
>
> This annotation instructs Lockdep to treat this acquisition as being
> at subclass 1. Since Path A acquires `A->perf_event_mutex` at the
> default subclass 0, Lockdep's dependency graph observes the sequence
> as:
> - Path A: `Class X (Subclass 0)` =E2=86=92 `Class Y (Subclass 0)`
> - Path B: `Class Y (Subclass 0)` =E2=86=92 `Class X (Subclass 1)`
>
> Because `X_0` and `X_1` are treated as distinct nodes for cycle
> detection in Lockdep to permit parent-child hierarchical locking, this
> annotation **suppresses the Lockdep "possible circular locking
> dependency detected" warning**.
>
> However, the hardware and the actual runtime mutex implementation
> (`kernel/locking/mutex.c`) strip the subclass argument in non-Lockdep
> builds, and even in Lockdep builds, mutual exclusion is enforced
> purely based on the physical memory address of the `struct mutex`.
> Since both paths target the EXACT SAME memory address for
> `A->perf_event_mutex` and `CtxB->mutex`, the CPU-level deadlock
> remains unaffected by the annotation.
>
> The accompanying comment in `perf_remove_from_owner()`:
> ```c
> /*
>  * If we're here through perf_event_exit_task() we're already
>  * holding ctx->mutex which would be an inversion wrt. the
>  * normal lock order.
>  *
>  * However we can safely take this lock because its the child
>  * ctx->mutex.
>  */
> ```
> is a historical artifact (dating back to commit `f63a8daa5812` in
> 2015) and does not hold true for the `remove_on_exec` path introduced
> in 2021 by commit `2e498d0a74e5`, as Process B is the target profilee
> and not necessarily a child process of the owner Task A, and no
> hierarchical relationship protects these specific lock instances.
>
> ## Conclusion
>
> The AB-BA deadlock between `owner->perf_event_mutex` and `ctx->mutex`
> is **VERIFIED** to be present in the current tip-of-tree kernel.
>
> > ---
> >  kernel/events/core.c | 17 +++++++++--------
> >  1 file changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 954c36e..d7f3e2c 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -4729,7 +4729,7 @@ static void perf_remove_from_owner(struct perf_ev=
ent *event);
> >  static void perf_event_exit_event(struct perf_event *event,
> >                                   struct perf_event_context *ctx,
> >                                   struct task_struct *task,
> > -                                 bool revoke);
> > +                                 unsigned long detach_flags);
> >
> >  /*
> >   * Removes all events from the current task that have been marked
> > @@ -4756,7 +4756,7 @@ static void perf_event_remove_on_exec(struct perf=
_event_context *ctx)
> >
> >                 modified =3D true;
> >
> > -               perf_event_exit_event(event, ctx, ctx->task, false);
> > +               perf_event_exit_event(event, ctx, ctx->task, DETACH_GRO=
UP);
> >         }
> >
> >         raw_spin_lock_irqsave(&ctx->lock, flags);
> > @@ -12937,7 +12937,7 @@ static void __pmu_detach_event(struct pmu *pmu,=
 struct perf_event *event,
> >         /*
> >          * De-schedule the event and mark it REVOKED.
> >          */
> > -       perf_event_exit_event(event, ctx, ctx->task, true);
> > +       perf_event_exit_event(event, ctx, ctx->task, DETACH_REVOKE);
> >
> >         /*
> >          * All _free_event() bits that rely on event->pmu:
> > @@ -14525,12 +14525,13 @@ static void
> >  perf_event_exit_event(struct perf_event *event,
> >                       struct perf_event_context *ctx,
> >                       struct task_struct *task,
> > -                     bool revoke)
> > +                     unsigned long detach_flags)
> >  {
> >         struct perf_event *parent_event =3D event->parent;
> > -       unsigned long detach_flags =3D DETACH_EXIT;
> >         unsigned int attach_state;
> >
> > +       detach_flags |=3D DETACH_EXIT;
> > +
> >         if (parent_event) {
> >                 /*
> >                  * Do not destroy the 'original' grouping; because of t=
he
> > @@ -14553,8 +14554,8 @@ perf_event_exit_event(struct perf_event *event,
> >                         sync_child_event(event, task);
> >         }
> >
> > -       if (revoke)
> > -               detach_flags |=3D DETACH_GROUP | DETACH_REVOKE;
> > +       if (detach_flags & DETACH_REVOKE)
> > +               detach_flags |=3D DETACH_GROUP;
> >
> >         perf_remove_from_context(event, detach_flags);
> >         /*
> > @@ -14642,7 +14643,7 @@ static void perf_event_exit_task_context(struct=
 task_struct *task, bool exit)
> >                 perf_event_task(task, ctx, 0);
> >
> >         list_for_each_entry_safe(child_event, next, &ctx->event_list, e=
vent_entry)
> > -               perf_event_exit_event(child_event, ctx, exit ? task : N=
ULL, false);
> > +               perf_event_exit_event(child_event, ctx, exit ? task : N=
ULL, 0);
> >
> >         mutex_unlock(&ctx->mutex);
> >
> >



--=20
___

Taeyang Lee Researcher
Theori, Inc. / Xint Code
Website. www.theori.io
Email. 0wn@theori.io
