Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F2B4195A1
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783619496; cv=pass; b=oLcAI/rBr99vQdZyeXLikdgyLmpRwUv+4lorAf+NQybaDs1CnCCzA8daPGXn5XlQXTCEawB384eWwEh2o9iDpAz+yIW+O1v/NeszGuvFdCTDJ05HUnTLDHbatmu1pJVZMWjPSehF7zs606LmWSCeGpoOH6kLl81RV/PlMigV3eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783619496; c=relaxed/simple;
	bh=wl+t8RzI9cAA2uc0617h1H+isfZrI7i88y1Jfdf03vQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ry27mqHNkBRTsOThx1r6OK6RCS5dvEl9B0qdY1JZiheAztO6zDTCngwxGMjiY1bSULZDThR0uuKtDUnpUMcLb1ficdcRawuWoNyZWA48Cs0W3UXJ78tAJfPVZNEcGAm+6w3kZt23kfwG7evTSN+VcSoQD5z903C3bN2XMyrK48I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SqvXtjwz; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SqvXtjwz"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cb59f6ba26so7285ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 10:51:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783619495; cv=none;
        d=google.com; s=arc-20260327;
        b=EC097JZtA/Ku3IDKzCSFQ5pa5qd6mESSnoS0lwZdveJsTr+ANVF+8l4vNSG2i5pyEV
         I2zXpGRq+D0L04PIcQ1iRu2wK6PUBtxk88UPrqYmrXF4z+yNXGsaEo7rf9gbam5WmJGi
         JXbAQbNm0c84DANWqX25uTAUD+/NFGHflfKrSAK/bOG32bRriHK6/3YI0YeQHOvE0WLC
         0zauOiyHoVTRj3e/yxdvno5fTPiDMTZsRRf98RZkWQ/Et8YIKH6GeGrjpy8iMzfc90On
         VyhBoU+qpFrRojUU/r8ABStegAUTGb7DuazC2vKZA0VU//V03yKd+/WcK2gPOf37U9T4
         426Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6a5xTBg45OoawFz8s9cciqYuVGTngZ6/F8lbTlngng8=;
        fh=/vlD/qCOWbiFOAVgGrC3TxxAkA5onXlUyK8EpM4R8pw=;
        b=HLr3vVd5wYjggfc3KsQCiCgirXZZLqlhfwDrlESos5qXKOeFr8ZP+h2KuPSrIBY7i0
         p6EjAEtRmI4xa3+UhUrv0KTqtgZRGHkJjRVBpns7A245u2VVn53MhbF9yQAZ/pwZRMGu
         Y5OMmFVHiJ7dFrnoLeJti9uNelRQMMoBWju7tmdrSw1iEYWh3++aD2wp/hzM2eLODZHe
         l3Wz7vRWJVyLot3WK/rc1QJYOxFJJwUvIJCmb9tuHxANwbz4Z+sRHSlQeFs3QGn1tBCe
         6F96BleO5myvwBwoXRkD+bsKmHtKdV1x6Z1pGbJASj7mHu4dR5VOgzjZ/ZfTiXKTm6Y9
         eDdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783619495; x=1784224295; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6a5xTBg45OoawFz8s9cciqYuVGTngZ6/F8lbTlngng8=;
        b=SqvXtjwzGxe8aJkVpuFiORl4BIBGLwbq+1wg3KJExCIO3nt+4+K5udbihEjk/i2zg8
         cewjUuYbgTp0OXxH2yBgiIApLLP4DhS9//npfZJGye27izWRAf19QVB88WswWogDi4Cd
         QB0bKyZrwkNgnUd53I/Eeic4YeemuFif0DPLGPzJOQDrmfrur/g3vZza/6s/EK80bubu
         QtYl4PiOZEKRXCH7trlFM4zuKcuQl/SajQbVsoyz9K0umOp2S9j/FK+lxXrRSCcQpl2C
         X5mCr302uFre5e79oyYoR6+iX59kMZRvR0oafVanVXJrvYmNKJrtYimU4FeDa/BmmYmq
         HlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783619495; x=1784224295;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6a5xTBg45OoawFz8s9cciqYuVGTngZ6/F8lbTlngng8=;
        b=qT9aRLFndkSSGrqKquMTR3evl7kSIRWyPs7Cx66pvwYqnLW+qg2LU8wDe9VfOZyDlD
         5h0lMaJ2uA0wlnisIsjNouiM/8ns/e+LWMlt1e2wE/leV+w0cjGjLj9q6PIcvC4hARFE
         OoMeKbNu0Ffm2/Uzj4sSdShT/5zk24LeBo2VH3MJ9U0OeECPVhAxM5R/TbrqNdYcoSEm
         iYeZ80+F0yhRWT00GsmF4WOcTwGoVq7IAgYZduSqbHgKbat4saplOHf4i/cZZKo8StC7
         5olldJnMd9Ppw3SqN6nmw5XsNJMguWr/vj10saHPNM2+WlIIMKCdUr24zmGWoVWMgb1U
         0yVA==
X-Forwarded-Encrypted: i=1; AHgh+RrGbr7D7fbnwxM2eri+tmpxjXPlZnk2kc4RxkeXdTocjeeJ7xY1SFCrchYJp6s19T79QiKoh1ZwAGV/qd4lRazS@vger.kernel.org
X-Gm-Message-State: AOJu0YyL/KitiD9fg/I2yj/wek0j5Hg8ncmxlY9No2uXBtHkbbU923DW
	yuinCfEPJbMlx54XCfMzGB2MN/lA18hslMzo8SV1EkuLMIVeIT1zEnR/4ks+2SKyAn1wsifYeda
	Jb2A6bbHPx+V//xD06nWVOmZqVtbo/aWfqkGCHsWXb8c3h/BzTfO1qH6JpN4=
X-Gm-Gg: AfdE7clrJNe8aAupF0gLv/HNYdUsVe8+q3JgMiwSYlolZOKuizXtq/dnXhgUAuINamo
	RFrjZDtSpxENM2RGr5ZSt/W7bugQ5DuDzsSo0Ef8j8ffAtUX57Kviywyu41An1gK/oOodlYOKy4
	pBYF9lkjt121oC8Wj+5Ej2Eh0o2p48lJIWtSxQCdAA7GxE15q7TpJjh16qt15G+1RLzoQaTdgQV
	d5S3c/vSTjcBaUvkFEuT132thqBytmKFuYfFK9LfAyIUwy9QzuPpGPplE3s7utU6RHkXJHLUvLY
	jusKs+09BuMUP1o3C1B9TYoG7jw=
X-Received: by 2002:a17:903:3b8c:b0:2bd:6dad:3dfa with SMTP id
 d9443c01a7336-2ce82bb1d3fmr213975ad.24.1783619493972; Thu, 09 Jul 2026
 10:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ai65GgZcC0LAlWLG@Taeyangs-MacBook-Pro.local> <178307254759.3843924.2571598962077552395.tip-bot2@tip-bot2>
In-Reply-To: <178307254759.3843924.2571598962077552395.tip-bot2@tip-bot2>
From: Ian Rogers <irogers@google.com>
Date: Thu, 9 Jul 2026 10:51:22 -0700
X-Gm-Features: AVVi8Ce0OkKJ5jcTQ3Mux01k-0ZMJkKwEsUEFM9C1QBf4t3iB_5jI1TN_ejhPL8
Message-ID: <CAP-5=fVq=2D6XjVEbAvJz54hG6PcwZZjn-za0hAfK8YV-J+MtQ@mail.gmail.com>
Subject: Re: [tip: perf/urgent] perf/core: Detach event groups during remove_on_exec
To: Taeyang Lee <0wn@theori.io>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Marco Elver <elver@google.com>
Cc: linux-kernel@vger.kernel.org, 
	linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 3:02=E2=80=AFAM tip-bot2 for Taeyang Lee
<tip-bot2@linutronix.de> wrote:
>
> The following commit has been merged into the perf/urgent branch of tip:
>
> Commit-ID:     037a3c43edfb597665dd34457cd22b14692f2ba3
> Gitweb:        https://git.kernel.org/tip/037a3c43edfb597665dd34457cd22b1=
4692f2ba3
> Author:        Taeyang Lee <0wn@theori.io>
> AuthorDate:    Sun, 14 Jun 2026 23:22:18 +09:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Thu, 02 Jul 2026 13:21:48 +02:00
>
> perf/core: Detach event groups during remove_on_exec
>
> perf_event_remove_on_exec() removes events by calling
> perf_event_exit_event(). For top-level events, this removes the event fro=
m
> the context with DETACH_EXIT only.
>
> This can leave inconsistent group state when a removed event is a group
> leader and the group contains siblings without remove_on_exec. If the gro=
up
> was active, the surviving siblings can remain active and attached to the
> removed leader's sibling list, but are no longer represented by a valid
> group leader on the PMU context active lists.
>
> A later close of the removed leader uses DETACH_GROUP and can promote the
> still-active siblings from this stale group state. The next schedule-in c=
an
> then add an already-linked active_list entry again, corrupting the PMU
> context active list.
>
> With DEBUG_LIST enabled, this is caught as a list_add double-add in
> merge_sched_in().
>
> Fix this by detaching group relationships when remove_on_exec removes an
> event. This preserves the existing task-exit and revoke behavior, while
> ensuring surviving siblings are ungrouped before the removed event leaves
> the context.
>
> Fixes: 2e498d0a74e5 ("perf: Add support for event removal on exec")
> Signed-off-by: Taeyang Lee <0wn@theori.io>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://patch.msgid.link/ai65GgZcC0LAlWLG@Taeyangs-MacBook-Pro.loca=
l

Hi Peter, Taeyang and Marco,

AI code review has flagged this code as introducing, or at least being
adjacent, to an existing deadlock. An example of the problem is with
an event being enabled at the same time as perf_event_remove_on_exec
is running due to the user code doing an exec. It seems possible for 1
CPU to hold the perf_event_mutex and be trying to get the
perf_event_context->mutex while the other CPU has the
perf_event_context->mutex and is trying to get the perf_event_mutex. A
fuller AI-generated analysis is below, and it seems correct but I may
be missing something. The fixes for this look somewhat large so I
thought I'd flag the issue before trying anything.

Thanks,
Ian

## Executive Summary

The reported potential AB-BA deadlock between
`owner->perf_event_mutex` (class `&task_struct->perf_event_mutex`) and
`ctx->mutex` (class `&perf_event_context->mutex`) is **PRESENT** in
the current tip-of-tree code in `torvalds/master`.

The lock inversion was introduced in 2021 by commit `2e498d0a74e5`
("perf: Add support for event removal on exec") and remains in the
code after the recent fix in commit `037a3c43edfb` ("perf/core: Detach
event groups during remove_on_exec").

The use of `SINGLE_DEPTH_NESTING` in `perf_remove_from_owner()`
suppresses the Lockdep warning for this specific inversion but **fails
to prevent the actual CPU deadlock at runtime**.

## Lock Inversion Paths

The deadlock can be triggered by Process A (Owner) and Process B
(Monitored Task) executing concurrent system calls.

### Process A Paths (Normal Lock Order: `owner->perf_event_mutex` ->
`ctx->mutex`)

#### Path A1: `prctl(PR_TASK_PERF_EVENTS_ENABLE / DISABLE)`
Process A invokes `prctl` to enable or disable events it owns.
1. **`perf_event_task_enable()`** (or `disable`):
   - Acquires `current->perf_event_mutex` (which is **`A->perf_event_mutex`=
**).
   - Iterates over `A->perf_event_list`.
   - For an event monitoring Process B, calls **`perf_event_ctx_lock(event)=
`**.
2. **`perf_event_ctx_lock_nested()`**:
   - Acquires **`event->ctx->mutex`** (which is **`CtxB->mutex`**).

**Result:** `A->perf_event_mutex` =E2=86=92 `CtxB->mutex`.

#### Path A2: `close(event_fd)`
Process A (or any task holding a reference to the event fd) closes the
event file descriptor.
1. **`perf_release()`** -> **`perf_event_release_kernel()`**:
   - Calls **`perf_remove_from_owner(event)`**.
2. **`perf_remove_from_owner()`**:
   - Reads `event->owner` (which is Process A).
   - Acquires **`owner->perf_event_mutex`** (which is
**`A->perf_event_mutex`**).
3. **`perf_event_release_kernel()`** continues:
   - Calls **`perf_event_ctx_lock(event)`**.
4. **`perf_event_ctx_lock_nested()`**:
   - Acquires **`event->ctx->mutex`** (which is **`CtxB->mutex`**).

**Result:** `A->perf_event_mutex` =E2=86=92 `CtxB->mutex`.

### Process B Path (Inverted Lock Order: `ctx->mutex` ->
`owner->perf_event_mutex`)

#### Path B1: `execve()`
Process B invokes `execve` to execute a new program image. The events
monitoring Process B that have the `attr.remove_on_exec =3D 1` bit set
are removed.
1. **`begin_new_exec()`** -> **`perf_event_exec()`** ->
**`perf_event_remove_on_exec()`**:
   - Acquires **`ctx->mutex`** (which is **`CtxB->mutex`**).
   - Iterates over `CtxB->event_list`.
   - Finds an event with `attr.remove_on_exec =3D 1` (owned by Process A).
   - Calls **`perf_remove_from_owner(event)`**.
2. **`perf_remove_from_owner()`**:
   - Reads `event->owner` (which is Process A).
   - Acquires **`owner->perf_event_mutex`** (which is
**`A->perf_event_mutex`**) via
`mutex_lock_nested(&owner->perf_event_mutex, SINGLE_DEPTH_NESTING)`.

**Result:** `CtxB->mutex` =E2=86=92 `A->perf_event_mutex`.

## Concrete Deadlock Interleaving

If Process A and Process B execute Path A1 (or A2) and Path B1
concurrently on different CPUs, the following interleaving causes a
CPU deadlock:

| CPU 0 (Process A) | CPU 1 (Process B) |
| :--- | :--- |
| Enters `perf_event_task_enable()` | Enters `perf_event_remove_on_exec()` =
|
| Acquires **`A->perf_event_mutex`** | Acquires **`CtxB->mutex`** |
| Calls `perf_event_ctx_lock(event)` | Calls `perf_remove_from_owner(event)=
` |
| Tries to acquire **`CtxB->mutex`**<br>**(BLOCKS on CPU 1)** | Tries
to acquire **`A->perf_event_mutex`**<br>**(BLOCKS on CPU 0)** |

Both processes are now blocked waiting for each other, resulting in a
permanent system hang (or soft lockup) on the affected cores.

## Analysis of `SINGLE_DEPTH_NESTING`

In `perf_remove_from_owner()`, the lock is acquired as:
```c
mutex_lock_nested(&owner->perf_event_mutex, SINGLE_DEPTH_NESTING);
```
Where `SINGLE_DEPTH_NESTING` is defined as `1`.

This annotation instructs Lockdep to treat this acquisition as being
at subclass 1. Since Path A acquires `A->perf_event_mutex` at the
default subclass 0, Lockdep's dependency graph observes the sequence
as:
- Path A: `Class X (Subclass 0)` =E2=86=92 `Class Y (Subclass 0)`
- Path B: `Class Y (Subclass 0)` =E2=86=92 `Class X (Subclass 1)`

Because `X_0` and `X_1` are treated as distinct nodes for cycle
detection in Lockdep to permit parent-child hierarchical locking, this
annotation **suppresses the Lockdep "possible circular locking
dependency detected" warning**.

However, the hardware and the actual runtime mutex implementation
(`kernel/locking/mutex.c`) strip the subclass argument in non-Lockdep
builds, and even in Lockdep builds, mutual exclusion is enforced
purely based on the physical memory address of the `struct mutex`.
Since both paths target the EXACT SAME memory address for
`A->perf_event_mutex` and `CtxB->mutex`, the CPU-level deadlock
remains unaffected by the annotation.

The accompanying comment in `perf_remove_from_owner()`:
```c
/*
 * If we're here through perf_event_exit_task() we're already
 * holding ctx->mutex which would be an inversion wrt. the
 * normal lock order.
 *
 * However we can safely take this lock because its the child
 * ctx->mutex.
 */
```
is a historical artifact (dating back to commit `f63a8daa5812` in
2015) and does not hold true for the `remove_on_exec` path introduced
in 2021 by commit `2e498d0a74e5`, as Process B is the target profilee
and not necessarily a child process of the owner Task A, and no
hierarchical relationship protects these specific lock instances.

## Conclusion

The AB-BA deadlock between `owner->perf_event_mutex` and `ctx->mutex`
is **VERIFIED** to be present in the current tip-of-tree kernel.

> ---
>  kernel/events/core.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 954c36e..d7f3e2c 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4729,7 +4729,7 @@ static void perf_remove_from_owner(struct perf_even=
t *event);
>  static void perf_event_exit_event(struct perf_event *event,
>                                   struct perf_event_context *ctx,
>                                   struct task_struct *task,
> -                                 bool revoke);
> +                                 unsigned long detach_flags);
>
>  /*
>   * Removes all events from the current task that have been marked
> @@ -4756,7 +4756,7 @@ static void perf_event_remove_on_exec(struct perf_e=
vent_context *ctx)
>
>                 modified =3D true;
>
> -               perf_event_exit_event(event, ctx, ctx->task, false);
> +               perf_event_exit_event(event, ctx, ctx->task, DETACH_GROUP=
);
>         }
>
>         raw_spin_lock_irqsave(&ctx->lock, flags);
> @@ -12937,7 +12937,7 @@ static void __pmu_detach_event(struct pmu *pmu, s=
truct perf_event *event,
>         /*
>          * De-schedule the event and mark it REVOKED.
>          */
> -       perf_event_exit_event(event, ctx, ctx->task, true);
> +       perf_event_exit_event(event, ctx, ctx->task, DETACH_REVOKE);
>
>         /*
>          * All _free_event() bits that rely on event->pmu:
> @@ -14525,12 +14525,13 @@ static void
>  perf_event_exit_event(struct perf_event *event,
>                       struct perf_event_context *ctx,
>                       struct task_struct *task,
> -                     bool revoke)
> +                     unsigned long detach_flags)
>  {
>         struct perf_event *parent_event =3D event->parent;
> -       unsigned long detach_flags =3D DETACH_EXIT;
>         unsigned int attach_state;
>
> +       detach_flags |=3D DETACH_EXIT;
> +
>         if (parent_event) {
>                 /*
>                  * Do not destroy the 'original' grouping; because of the
> @@ -14553,8 +14554,8 @@ perf_event_exit_event(struct perf_event *event,
>                         sync_child_event(event, task);
>         }
>
> -       if (revoke)
> -               detach_flags |=3D DETACH_GROUP | DETACH_REVOKE;
> +       if (detach_flags & DETACH_REVOKE)
> +               detach_flags |=3D DETACH_GROUP;
>
>         perf_remove_from_context(event, detach_flags);
>         /*
> @@ -14642,7 +14643,7 @@ static void perf_event_exit_task_context(struct t=
ask_struct *task, bool exit)
>                 perf_event_task(task, ctx, 0);
>
>         list_for_each_entry_safe(child_event, next, &ctx->event_list, eve=
nt_entry)
> -               perf_event_exit_event(child_event, ctx, exit ? task : NUL=
L, false);
> +               perf_event_exit_event(child_event, ctx, exit ? task : NUL=
L, 0);
>
>         mutex_unlock(&ctx->mutex);
>
>
