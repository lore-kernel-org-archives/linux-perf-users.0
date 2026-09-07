Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1104B0491
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Sep 2026 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791877; cv=pass; b=kaPTd7HC93+7vixatwgezLD+zzyKohIKTXIdPXo9er+z8j4ziVd3ibDYQk1yCZxIQ865d5IEB2slHOPJKpfC8d1d2Kme/odhAoFv7+szmOaSpx1UWY35dwMbV5TqEML5/AJlA+HpCtAaftNOglMwN0ufKU/3aciFQB2w+lR/hVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791877; c=relaxed/simple;
	bh=DKz7i9liIcN/i/dGzAWXDRnSqDDTn6UwH/9lJ3R9V/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzCkUhC3JORcrBiVh3yajk/Zb4f3BJ8xifgMfQa956XQeIzmWBLqSdKfrHxgXT9L5Jf9nqfWUxPJswplx7fzfRH+/lsjoT0GFq2Ec7bHb3UzOXMabo5QYIF6gGQofQ0l8tXgGiCb4ASPEauZEDPOs3WCq5tFDOudQAhODW6SetM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amugUsUx; arc=pass smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amugUsUx"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6b1497f0453so2674151eaf.3
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Sep 2026 07:37:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788791872; cv=none;
        d=google.com; s=arc-20260327;
        b=Okg3cP6Br12bMsST4JWKhbd/yxCA72JFN5bm2hSYs3hMtr9wZLVNHqdTsuDtbwZClZ
         uj8c4wC+PCdAvPL0jhux+9lhKQNxIxLmYbfdkfRdkMgwruu0ULBDt6hJXyUxCbtBvWnj
         RaGQvNBNxnXZq1FtfyEt/auhXeej4K4jHeXpaJpbolzU5cYprRy07MINWfMOla9y82DL
         5H8JjVbwwYDgY0v1iqAikrQrJ61FsOdpFck5ug4DlD9XIX7feyeZdEudlLqVYK1Rx5Kh
         HRgcR9ipAiVx4RrM9SyVnFoiKWcqz3a8muRA4sYCr0xoaqyID9o+wC+uw70M3iWUZDmw
         t47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bWdatI20ki6vY8bavStbmgpLHATOXVgXNqz3NlGnHwU=;
        fh=cTvbafwieodSdpar3b+L523hN68oMc+xX79PgkJws2k=;
        b=nX2949XjuGGDU0vb3lceKAC5fohWRzcYbb/kHy2xcbuGd6CvLexXKFbVLJYj5n/8ch
         q9npD4QLz8ZKSDrFolymVAx+9Tsd4pdkNUaQmxscelYyBvM3Qn9WNrlWfQllNX9dYHcu
         fzb/NoX7+DAzYZaDbB6WHmS1s6H6wNV4wIJdYdkfZy+8Sd7kkfzwiJ7WRcPOFjg+MjFV
         hkmBafrkHuagfelcgXcgzwQXK35NMNUaC6ZjdM7vGdOhisp2sIt4w+1A9J4iVe70TTte
         zufKQHMfcXwIAYHdZwbKKhX0QoJkOgsZeDZxDfoTvIOu5XdISr87ytB7Mr9GblX+L8EK
         UB4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788791872; x=1789396672; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bWdatI20ki6vY8bavStbmgpLHATOXVgXNqz3NlGnHwU=;
        b=amugUsUxJ2sfd8RfIhtcCzbgHccj4ayWIoQ8pBI0KTcVLNGUkrTJsIOTl8fGO2ug5+
         USWVRI2CFSKp+aqRW1c9KG6ocBsjO0xoOY9x+NoOkU2+FwtSMXsWu5OsL5imorDVHt9B
         C3iuTxlO0c3Y/cRAIYSNJwJLyKucdvO8NgktyrjcV3AmEwRqlUObkGc7o2GjxqgCSKtr
         W249YSDtVq7pudF0A04HrlK+zL1hGYGzElLPcZNcRYOsRqaocrjkljAbR+2yRHfA7a6E
         ORVDcz1VrwsVWsupi9HJdKaLJehQ5Gmo90dUHF2X5WggPC32uqlEfiM9vm0BKFZk0Izb
         dKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788791872; x=1789396672;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bWdatI20ki6vY8bavStbmgpLHATOXVgXNqz3NlGnHwU=;
        b=P1EGOwVyEHmglcGXQq1smbq9l2JSf6jFfArYwqN8x0NkTJ6HUKgc93IHQdUHVLCjjm
         IsDCJ4wGU3KnI+FyCqnOiG6QELsANT9gAawLB6ar/84HTyiQfNz8TEjW5BVfWw+7Sdgb
         Ahd33AdgkulFUZ3lulDK3pFmxAM5bcC83o+X8YhktZ1Nd3GdLifqazfiBUOLJUNi9WfQ
         kXJjUfuo+EhH6g6fRFrBMSOfO3+Ijm8Cn+cOQAmuXxrzcii025bdW8DkvNYLVEcVw9os
         iz4TXhojtaxHOf4FdtH3d1cJE9hPw3mnm+bSGgdpBPmS7k5vMVqaztnzJUMCd8A6raYw
         l99w==
X-Forwarded-Encrypted: i=1; AKwUvBzs+86rpzvFmrRPXDe8AwT29s550Qg8Y0g6oWwJhu5VOX5gsfuScfi+UivcocGM4y3fA+L4pAJXA5NxpMlMyK/T@vger.kernel.org
X-Gm-Message-State: AFuF++kOvKrDK7cPqN5iUyxtC31cHuBDm6tFQLWiCq3LDej/VcOs+WtR
	qg8kkGB8z937ox3Pw1jmoYqJ39F/Uxvuwhnt2jP58845NWakorz2emHws5/4LBSvSKhUP9S+UEZ
	AgKDfi8Ezmy/W82FXc58YCx+1oxGXOrQ=
X-Gm-Gg: AYBFou0hlXIXbbXc1i0Tv/B8oKzIQAsBmvQ4KBSXpCYFQnF7wRIm3k9n5DqZA5wdX2S
	cO08jB7yLNJIftGmmZqcEEJDyFi3UUCcdC/LPNIXtFZH21RdHm2eeiZVqqWWlmfhIGOFD6d44Sv
	gg1vmzbeEbBIWWhVqf33WYHY2arktYTm4QDKSEmK7vDFK9NEwCvEkAaRE2WegRz7+SP01emQ9xn
	FfhQheAfqe0g2FnE+7IV466bJPiMQBu+EusbJeSeR+iumQU/VnEiRCpnXiP2K4ia1A56gTYKJG+
	NWdkwwYQr6od1NK5DnsubNk1GaAoNyhxII31INm2mXs=
X-Received: by 2002:a05:6820:2211:b0:6b7:46fa:169c with SMTP id
 006d021491bc7-6b746fa1a60mr13316745eaf.49.1788791872148; Mon, 07 Sep 2026
 07:37:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAyWcRWWULkDa9L+Qgxt8c_mAbdYAU4uUA+51HhEKKDao-1KMg@mail.gmail.com>
In-Reply-To: <CAAyWcRWWULkDa9L+Qgxt8c_mAbdYAU4uUA+51HhEKKDao-1KMg@mail.gmail.com>
From: jihoon kim <kigihi85@gmail.com>
Date: Mon, 7 Sep 2026 23:37:38 +0900
X-Gm-Features: AcwNN1VGUtPeszIKl1qVFCTinFknxIBd6tUN8qFC2P-No4qtKXMzAbqaj1H1tKU
Message-ID: <CAAyWcRVsZtF=oZC9UhvDH=m7dQYsv=tED_5DGT-NXwKAAjxuqw@mail.gmail.com>
Subject: Re: [BUG] WARNING in perf_pending_task() outside do_exit() path
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000001e23bd065ae590df"

--0000000000001e23bd065ae590df
Content-Type: multipart/alternative; boundary="0000000000001e23bd065ae590dd"

--0000000000001e23bd065ae590dd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Apologies for missing the attachments in my previous email. I have attached
the reproducer file (`repro_perf_pending_task.c`) for reference.

2026=EB=85=84 9=EC=9B=94 7=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 11:33, j=
ihoon kim <kigihi85@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> Hi,
>
> While fuzz testing mainline (syzkaller, arm64, local build) I hit the
> following WARNING repeatedly and reliably:
>
> ------------[ cut here ]------------
> WARNING: kernel/events/core.c:7629 at perf_pending_task+0x268/0x2a4,
> CPU#1: syz.1.79/2934
> Modules linked in:
> CPU: 1 UID: 0 PID: 2934 Comm: syz.1.79 Tainted: G        W           7.2.=
0
> #1 PREEMPT
> Tainted: [W]=3DWARN
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  perf_pending_task+0x268/0x2a4 (P)
>  task_work_run+0x124/0x1ec
>  exit_to_user_mode_loop+0x1f4/0x210
>  el0_svc+0x1e0/0x270
>  el0t_64_sync_handler+0xa0/0xe4
>  el0t_64_sync+0x198/0x19c
> ---[ end trace 0000000000000000 ]---
>
> This is the WARN_ON_ONCE in perf_sigtrap() (inlined into
> perf_pending_task()):
>
>     static void perf_sigtrap(struct perf_event *event)
>     {
>         if (current->flags & PF_EXITING)
>             return;
>
>         if (WARN_ON_ONCE(event->ctx->task !=3D current))
>             return;
>         ...
>     }
>
> Why I think this is worth a separate look
> ------------------------------------------
> This exact function has a history of related issues:
>
> - CVE-2022-48950: a use-after-free in perf_pending_task() (fixed by
>   extending the perf_event's refcount across the queued task_work,
>   commit 8bffa95ac19ff27c8261904f89d36c7fcf215d59). That fix
>   (put_event(event) at the end of perf_pending_task()) is present in
>   the tree I'm testing, so this is not that bug.
>
> - commit 3da6bb419750 ("perf/core: Fix WARN in perf_sigtrap()"),
>   2025-09-04, fixed a WARN at this same line, but for a call path that
>   goes through do_exit()/do_group_exit()/get_signal() while the task is
>   actively exiting (ctx->task pinned to TASK_TOMBSTONE).
>
> My reproduction's call trace has no do_exit()/get_signal() anywhere =E2=
=80=94
> it's a completely ordinary syscall-return path (task_work_run ->
> exit_to_user_mode_loop). So the task is not exiting, and the 2025-09-04
> fix's precondition doesn't appear to apply here. I have not been able
> to pin down exactly how event->ctx->task and current diverge outside
> that exit path =E2=80=94 reporting in case this rings a bell for people w=
ho
> know this code better than I do.
>
> Severity / impact
> ------------------
> I don't believe this indicates memory corruption:
> - The WARN_ON_ONCE only compares pointer values; nothing is
>   dereferenced before or after the check on the taken branch.
> - This build has CONFIG_KASAN=3Dy; no KASAN report accompanies the WARN.
> - I also built a variant with CONFIG_KCSAN=3Dy (KASAN and KCSAN can't be
>   enabled together in this tree) and reproduced the same WARN several
>   times; KCSAN did not report any data race.
>
> So this looks like a WARN-only assertion violation (no observed
> memory-safety impact), but given the recurring history of races in
> this exact function, it seemed worth flagging rather than silently
> working around it.
>
> Reproducer
> ----------
> Minimized by syzkaller to two syscalls:
>
>     perf_event_open(&(0x7f0000000000)=3D{0x2, 0x80, 0x77, 0x0, 0x0, 0x0,
> 0x0, 0x9c29, 0x147cb, 0x8, 0x0, 0x1, 0x1, 0x0, 0x0, 0x0, 0x0, 0x1, 0x1,
> 0x1, 0x1, 0x1, 0x0, 0x0, 0x0, 0x2, 0x1, 0x0, 0x0, 0x1, 0x1, 0x1, 0x0, 0x0=
,
> 0x0, 0x1, 0x1, 0x1, 0x0, 0x0, 0x0, 0x1, 0x0, 0x0, 0x1, 0x1, 0x1, 0x0, 0xb=
,
> 0x4, @perf_config_ext=3D{0xfffffffffffffbff, 0x100}, 0xa1, 0x3, 0x4, 0x6,
> 0x7, 0x8, 0xfcbe, 0x0, 0x0, 0x0, 0x2}, 0x0, 0xffffffffffffffff,
> 0xffffffffffffffff, 0x2)
>     io_uring_setup(0x25fa, &(0x7f0000000180)=3D{0x0, 0x6bc, 0x2, 0x0, 0xa=
a})
>
> A standalone C reproducer (autogenerated by syzkaller) is attached
> [repro_perf_pending_task.c]. It reproduces reliably within ~20-40s of
> boot under syzkaller's syz-repro tool; I have not yet reduced it to a
> hand-written minimal C repro independent of the syzkaller harness.
>
> Kernel: mainline, local build tagged 7.2.0-g26260251022f-dirty
> Arch: arm64, QEMU/KVM(hvf) virt machine, 2 vCPU / 2GB RAM
>
> Happy to provide the full syzkaller log, the C repro, or test patches.
>
> Thanks,
> Jihoon Kim (Harumomonabi) <kigihi85@gmail.com>

--0000000000001e23bd065ae590dd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>Apologies for missing the attachments in my pre=
vious email. I have attached the reproducer file (`repro_perf_pending_task.=
c`) for reference.</div><br><div class=3D"gmail_quote gmail_quote_container=
"><div dir=3D"ltr" class=3D"gmail_attr">2026=EB=85=84 9=EC=9B=94 7=EC=9D=BC=
 (=EC=9B=94) =EC=98=A4=ED=9B=84 11:33, jihoon kim &lt;<a href=3D"mailto:kig=
ihi85@gmail.com">kigihi85@gmail.com</a>&gt;=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
While fuzz testing mainline (syzkaller, arm64, local build) I hit the<br>
following WARNING repeatedly and reliably:<br>
<br>
------------[ cut here ]------------<br>
WARNING: kernel/events/core.c:7629 at perf_pending_task+0x268/0x2a4, CPU#1:=
 syz.1.79/2934<br>
Modules linked in:<br>
CPU: 1 UID: 0 PID: 2934 Comm: syz.1.79 Tainted: G=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 W=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07.2.0 #1 PREEMPT<br>
Tainted: [W]=3DWARN<br>
Hardware name: linux,dummy-virt (DT)<br>
Call trace:<br>
=C2=A0perf_pending_task+0x268/0x2a4 (P)<br>
=C2=A0task_work_run+0x124/0x1ec<br>
=C2=A0exit_to_user_mode_loop+0x1f4/0x210<br>
=C2=A0el0_svc+0x1e0/0x270<br>
=C2=A0el0t_64_sync_handler+0xa0/0xe4<br>
=C2=A0el0t_64_sync+0x198/0x19c<br>
---[ end trace 0000000000000000 ]---<br>
<br>
This is the WARN_ON_ONCE in perf_sigtrap() (inlined into<br>
perf_pending_task()):<br>
<br>
=C2=A0 =C2=A0 static void perf_sigtrap(struct perf_event *event)<br>
=C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (current-&gt;flags &amp; PF_EXITING)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (WARN_ON_ONCE(event-&gt;ctx-&gt;task !=3D cu=
rrent))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 }<br>
<br>
Why I think this is worth a separate look<br>
------------------------------------------<br>
This exact function has a history of related issues:<br>
<br>
- CVE-2022-48950: a use-after-free in perf_pending_task() (fixed by<br>
=C2=A0 extending the perf_event&#39;s refcount across the queued task_work,=
<br>
=C2=A0 commit 8bffa95ac19ff27c8261904f89d36c7fcf215d59). That fix<br>
=C2=A0 (put_event(event) at the end of perf_pending_task()) is present in<b=
r>
=C2=A0 the tree I&#39;m testing, so this is not that bug.<br>
<br>
- commit 3da6bb419750 (&quot;perf/core: Fix WARN in perf_sigtrap()&quot;),<=
br>
=C2=A0 2025-09-04, fixed a WARN at this same line, but for a call path that=
<br>
=C2=A0 goes through do_exit()/do_group_exit()/get_signal() while the task i=
s<br>
=C2=A0 actively exiting (ctx-&gt;task pinned to TASK_TOMBSTONE).<br>
<br>
My reproduction&#39;s call trace has no do_exit()/get_signal() anywhere =E2=
=80=94<br>
it&#39;s a completely ordinary syscall-return path (task_work_run -&gt;<br>
exit_to_user_mode_loop). So the task is not exiting, and the 2025-09-04<br>
fix&#39;s precondition doesn&#39;t appear to apply here. I have not been ab=
le<br>
to pin down exactly how event-&gt;ctx-&gt;task and current diverge outside<=
br>
that exit path =E2=80=94 reporting in case this rings a bell for people who=
<br>
know this code better than I do.<br>
<br>
Severity / impact<br>
------------------<br>
I don&#39;t believe this indicates memory corruption:<br>
- The WARN_ON_ONCE only compares pointer values; nothing is<br>
=C2=A0 dereferenced before or after the check on the taken branch.<br>
- This build has CONFIG_KASAN=3Dy; no KASAN report accompanies the WARN.<br=
>
- I also built a variant with CONFIG_KCSAN=3Dy (KASAN and KCSAN can&#39;t b=
e<br>
=C2=A0 enabled together in this tree) and reproduced the same WARN several<=
br>
=C2=A0 times; KCSAN did not report any data race.<br>
<br>
So this looks like a WARN-only assertion violation (no observed<br>
memory-safety impact), but given the recurring history of races in<br>
this exact function, it seemed worth flagging rather than silently<br>
working around it.<br>
<br>
Reproducer<br>
----------<br>
Minimized by syzkaller to two syscalls:<br>
<br>
=C2=A0 =C2=A0 perf_event_open(&amp;(0x7f0000000000)=3D{0x2, 0x80, 0x77, 0x0=
, 0x0, 0x0, 0x0, 0x9c29, 0x147cb, 0x8, 0x0, 0x1, 0x1, 0x0, 0x0, 0x0, 0x0, 0=
x1, 0x1, 0x1, 0x1, 0x1, 0x0, 0x0, 0x0, 0x2, 0x1, 0x0, 0x0, 0x1, 0x1, 0x1, 0=
x0, 0x0, 0x0, 0x1, 0x1, 0x1, 0x0, 0x0, 0x0, 0x1, 0x0, 0x0, 0x1, 0x1, 0x1, 0=
x0, 0xb, 0x4, @perf_config_ext=3D{0xfffffffffffffbff, 0x100}, 0xa1, 0x3, 0x=
4, 0x6, 0x7, 0x8, 0xfcbe, 0x0, 0x0, 0x0, 0x2}, 0x0, 0xffffffffffffffff, 0xf=
fffffffffffffff, 0x2)<br>
=C2=A0 =C2=A0 io_uring_setup(0x25fa, &amp;(0x7f0000000180)=3D{0x0, 0x6bc, 0=
x2, 0x0, 0xaa})<br>
<br>
A standalone C reproducer (autogenerated by syzkaller) is attached<br>
[repro_perf_pending_task.c]. It reproduces reliably within ~20-40s of<br>
boot under syzkaller&#39;s syz-repro tool; I have not yet reduced it to a<b=
r>
hand-written minimal C repro independent of the syzkaller harness.<br>
<br>
Kernel: mainline, local build tagged 7.2.0-g26260251022f-dirty<br>
Arch: arm64, QEMU/KVM(hvf) virt machine, 2 vCPU / 2GB RAM<br>
<br>
Happy to provide the full syzkaller log, the C repro, or test patches.<br>
<br>
Thanks,<br>
Jihoon Kim (Harumomonabi) &lt;<a href=3D"mailto:kigihi85@gmail.com" target=
=3D"_blank">kigihi85@gmail.com</a>&gt;</blockquote></div>

--0000000000001e23bd065ae590dd--
--0000000000001e23bd065ae590df
Content-Type: application/octet-stream; name="repro_perf_pending_task.c"
Content-Disposition: attachment; filename="repro_perf_pending_task.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mtrcgv5i0>
X-Attachment-Id: f_mtrcgv5i0

Ly8gYXV0b2dlbmVyYXRlZCBieSBzeXprYWxsZXIgKGh0dHBzOi8vZ2l0aHViLmNvbS9nb29nbGUv
c3l6a2FsbGVyKQoKI2RlZmluZSBfR05VX1NPVVJDRSAKCiNpbmNsdWRlIDxhcnBhL2luZXQuaD4K
I2luY2x1ZGUgPGRpcmVudC5oPgojaW5jbHVkZSA8ZW5kaWFuLmg+CiNpbmNsdWRlIDxlcnJuby5o
PgojaW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPGlmYWRkcnMuaD4KI2luY2x1ZGUgPG5ldC9p
Zi5oPgojaW5jbHVkZSA8bmV0L2lmX2FycC5oPgojaW5jbHVkZSA8bmV0aW5ldC9pbi5oPgojaW5j
bHVkZSA8cHRocmVhZC5oPgojaW5jbHVkZSA8c2NoZWQuaD4KI2luY2x1ZGUgPHNldGptcC5oPgoj
aW5jbHVkZSA8c2lnbmFsLmg+CiNpbmNsdWRlIDxzdGRhcmcuaD4KI2luY2x1ZGUgPHN0ZGJvb2wu
aD4KI2luY2x1ZGUgPHN0ZGludC5oPgojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0ZGxp
Yi5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxzeXMvZXBvbGwuaD4KI2luY2x1ZGUg
PHN5cy9pb2N0bC5oPgojaW5jbHVkZSA8c3lzL21vdW50Lmg+CiNpbmNsdWRlIDxzeXMvcHJjdGwu
aD4KI2luY2x1ZGUgPHN5cy9yZXNvdXJjZS5oPgojaW5jbHVkZSA8c3lzL3NvY2tldC5oPgojaW5j
bHVkZSA8c3lzL3N0YXQuaD4KI2luY2x1ZGUgPHN5cy9zd2FwLmg+CiNpbmNsdWRlIDxzeXMvc3lz
Y2FsbC5oPgojaW5jbHVkZSA8c3lzL3N5c21hY3Jvcy5oPgojaW5jbHVkZSA8c3lzL3RpbWUuaD4K
I2luY2x1ZGUgPHN5cy90eXBlcy5oPgojaW5jbHVkZSA8c3lzL3Vpby5oPgojaW5jbHVkZSA8c3lz
L3dhaXQuaD4KI2luY2x1ZGUgPHRpbWUuaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgoKI2luY2x1ZGUg
PGxpbnV4L2NhcGFiaWxpdHkuaD4KI2luY2x1ZGUgPGxpbnV4L2V0aHRvb2wuaD4KI2luY2x1ZGUg
PGxpbnV4L2ZhbGxvYy5oPgojaW5jbHVkZSA8bGludXgvZnV0ZXguaD4KI2luY2x1ZGUgPGxpbnV4
L2dlbmV0bGluay5oPgojaW5jbHVkZSA8bGludXgvaWZfYWRkci5oPgojaW5jbHVkZSA8bGludXgv
aWZfZXRoZXIuaD4KI2luY2x1ZGUgPGxpbnV4L2lmX2xpbmsuaD4KI2luY2x1ZGUgPGxpbnV4L2lm
X3R1bi5oPgojaW5jbHVkZSA8bGludXgvaW42Lmg+CiNpbmNsdWRlIDxsaW51eC9pcC5oPgojaW5j
bHVkZSA8bGludXgvbmVpZ2hib3VyLmg+CiNpbmNsdWRlIDxsaW51eC9uZXQuaD4KI2luY2x1ZGUg
PGxpbnV4L25ldGxpbmsuaD4KI2luY2x1ZGUgPGxpbnV4L25sODAyMTEuaD4KI2luY2x1ZGUgPGxp
bnV4L3Jma2lsbC5oPgojaW5jbHVkZSA8bGludXgvcnRuZXRsaW5rLmg+CiNpbmNsdWRlIDxsaW51
eC9zb2NraW9zLmg+CiNpbmNsdWRlIDxsaW51eC90Y3AuaD4KI2luY2x1ZGUgPGxpbnV4L3ZldGgu
aD4KCiNpZm5kZWYgX19OUl9pb191cmluZ19zZXR1cAojZGVmaW5lIF9fTlJfaW9fdXJpbmdfc2V0
dXAgNDI1CiNlbmRpZgojaWZuZGVmIF9fTlJfbW1hcAojZGVmaW5lIF9fTlJfbW1hcCAyMjIKI2Vu
ZGlmCiNpZm5kZWYgX19OUl9wZXJmX2V2ZW50X29wZW4KI2RlZmluZSBfX05SX3BlcmZfZXZlbnRf
b3BlbiAyNDEKI2VuZGlmCgpzdGF0aWMgdW5zaWduZWQgbG9uZyBsb25nIHByb2NpZDsKCnN0YXRp
YyBfX3RocmVhZCBpbnQgY2xvbmVfb25nb2luZzsKc3RhdGljIF9fdGhyZWFkIGludCBza2lwX3Nl
Z3Y7CnN0YXRpYyBfX3RocmVhZCBqbXBfYnVmIHNlZ3ZfZW52OwoKc3RhdGljIHZvaWQgc2Vndl9o
YW5kbGVyKGludCBzaWcsIHNpZ2luZm9fdCogaW5mbywgdm9pZCogY3R4KQp7CglpZiAoX19hdG9t
aWNfbG9hZF9uKCZjbG9uZV9vbmdvaW5nLCBfX0FUT01JQ19SRUxBWEVEKSAhPSAwKSB7CgkJZXhp
dChzaWcpOwoJfQoJdWludHB0cl90IGFkZHIgPSAodWludHB0cl90KWluZm8tPnNpX2FkZHI7Cglj
b25zdCB1aW50cHRyX3QgcHJvZ19zdGFydCA9IDEgPDwgMjA7Cgljb25zdCB1aW50cHRyX3QgcHJv
Z19lbmQgPSAxMDAgPDwgMjA7CglpbnQgc2tpcCA9IF9fYXRvbWljX2xvYWRfbigmc2tpcF9zZWd2
LCBfX0FUT01JQ19SRUxBWEVEKSAhPSAwOwoJaW50IHZhbGlkID0gYWRkciA8IHByb2dfc3RhcnQg
fHwgYWRkciA+IHByb2dfZW5kOwoJaWYgKHNraXAgJiYgdmFsaWQpIHsKCQlfbG9uZ2ptcChzZWd2
X2VudiwgMSk7Cgl9CglleGl0KHNpZyk7Cn0KCnN0YXRpYyB2b2lkIGluc3RhbGxfc2Vndl9oYW5k
bGVyKHZvaWQpCnsKCXN0cnVjdCBzaWdhY3Rpb24gc2E7CgltZW1zZXQoJnNhLCAwLCBzaXplb2Yo
c2EpKTsKCXNhLnNhX2hhbmRsZXIgPSBTSUdfSUdOOwoJc3lzY2FsbChTWVNfcnRfc2lnYWN0aW9u
LCAweDIwLCAmc2EsIE5VTEwsIDgpOwoJc3lzY2FsbChTWVNfcnRfc2lnYWN0aW9uLCAweDIxLCAm
c2EsIE5VTEwsIDgpOwoJbWVtc2V0KCZzYSwgMCwgc2l6ZW9mKHNhKSk7CglzYS5zYV9zaWdhY3Rp
b24gPSBzZWd2X2hhbmRsZXI7CglzYS5zYV9mbGFncyA9IFNBX05PREVGRVIgfCBTQV9TSUdJTkZP
OwoJc2lnYWN0aW9uKFNJR1NFR1YsICZzYSwgTlVMTCk7CglzaWdhY3Rpb24oU0lHQlVTLCAmc2Es
IE5VTEwpOwp9CgojZGVmaW5lIE5PTkZBSUxJTkcoLi4uKSAoeyBpbnQgb2sgPSAxOyBfX2F0b21p
Y19mZXRjaF9hZGQoJnNraXBfc2VndiwgMSwgX19BVE9NSUNfU0VRX0NTVCk7IGlmIChfc2V0am1w
KHNlZ3ZfZW52KSA9PSAwKSB7IF9fVkFfQVJHU19fOyB9IGVsc2Ugb2sgPSAwOyBfX2F0b21pY19m
ZXRjaF9zdWIoJnNraXBfc2VndiwgMSwgX19BVE9NSUNfU0VRX0NTVCk7IG9rOyB9KQoKc3RhdGlj
IHZvaWQgc2xlZXBfbXModWludDY0X3QgbXMpCnsKCXVzbGVlcChtcyAqIDEwMDApOwp9CgpzdGF0
aWMgdWludDY0X3QgY3VycmVudF90aW1lX21zKHZvaWQpCnsKCXN0cnVjdCB0aW1lc3BlYyB0czsK
CWlmIChjbG9ja19nZXR0aW1lKENMT0NLX01PTk9UT05JQywgJnRzKSkKCWV4aXQoMSk7CglyZXR1
cm4gKHVpbnQ2NF90KXRzLnR2X3NlYyAqIDEwMDAgKyAodWludDY0X3QpdHMudHZfbnNlYyAvIDEw
MDAwMDA7Cn0KCnN0YXRpYyB2b2lkIHVzZV90ZW1wb3JhcnlfZGlyKHZvaWQpCnsKCWNoYXIgdG1w
ZGlyX3RlbXBsYXRlW10gPSAiLi9zeXprYWxsZXIuWFhYWFhYIjsKCWNoYXIqIHRtcGRpciA9IG1r
ZHRlbXAodG1wZGlyX3RlbXBsYXRlKTsKCWlmICghdG1wZGlyKQoJZXhpdCgxKTsKCWlmIChjaG1v
ZCh0bXBkaXIsIDA3NzcpKQoJZXhpdCgxKTsKCWlmIChjaGRpcih0bXBkaXIpKQoJZXhpdCgxKTsK
fQoKc3RhdGljIHZvaWQgdGhyZWFkX3N0YXJ0KHZvaWQqICgqZm4pKHZvaWQqKSwgdm9pZCogYXJn
KQp7CglwdGhyZWFkX3QgdGg7CglwdGhyZWFkX2F0dHJfdCBhdHRyOwoJcHRocmVhZF9hdHRyX2lu
aXQoJmF0dHIpOwoJcHRocmVhZF9hdHRyX3NldHN0YWNrc2l6ZSgmYXR0ciwgMTI4IDw8IDEwKTsK
CWludCBpID0gMDsKCWZvciAoOyBpIDwgMTAwOyBpKyspIHsKCQlpZiAocHRocmVhZF9jcmVhdGUo
JnRoLCAmYXR0ciwgZm4sIGFyZykgPT0gMCkgewoJCQlwdGhyZWFkX2F0dHJfZGVzdHJveSgmYXR0
cik7CgkJCXJldHVybjsKCQl9CgkJaWYgKGVycm5vID09IEVBR0FJTikgewoJCQl1c2xlZXAoNTAp
OwoJCQljb250aW51ZTsKCQl9CgkJYnJlYWs7Cgl9CglleGl0KDEpOwp9CgojZGVmaW5lIEJJVE1B
U0soYmZfb2ZmLGJmX2xlbikgKCgoMXVsbCA8PCAoYmZfbGVuKSkgLSAxKSA8PCAoYmZfb2ZmKSkK
I2RlZmluZSBTVE9SRV9CWV9CSVRNQVNLKHR5cGUsaHRvYmUsYWRkcix2YWwsYmZfb2ZmLGJmX2xl
bikgKih0eXBlKikoYWRkcikgPSBodG9iZSgoaHRvYmUoKih0eXBlKikoYWRkcikpICYgfkJJVE1B
U0soKGJmX29mZiksIChiZl9sZW4pKSkgfCAoKCh0eXBlKSh2YWwpIDw8IChiZl9vZmYpKSAmIEJJ
VE1BU0soKGJmX29mZiksIChiZl9sZW4pKSkpCgp0eXBlZGVmIHN0cnVjdCB7CglpbnQgc3RhdGU7
Cn0gZXZlbnRfdDsKCnN0YXRpYyB2b2lkIGV2ZW50X2luaXQoZXZlbnRfdCogZXYpCnsKCWV2LT5z
dGF0ZSA9IDA7Cn0KCnN0YXRpYyB2b2lkIGV2ZW50X3Jlc2V0KGV2ZW50X3QqIGV2KQp7Cglldi0+
c3RhdGUgPSAwOwp9CgpzdGF0aWMgdm9pZCBldmVudF9zZXQoZXZlbnRfdCogZXYpCnsKCWlmIChl
di0+c3RhdGUpCglleGl0KDEpOwoJX19hdG9taWNfc3RvcmVfbigmZXYtPnN0YXRlLCAxLCBfX0FU
T01JQ19SRUxFQVNFKTsKCXN5c2NhbGwoU1lTX2Z1dGV4LCAmZXYtPnN0YXRlLCBGVVRFWF9XQUtF
IHwgRlVURVhfUFJJVkFURV9GTEFHLCAxMDAwMDAwKTsKfQoKc3RhdGljIHZvaWQgZXZlbnRfd2Fp
dChldmVudF90KiBldikKewoJd2hpbGUgKCFfX2F0b21pY19sb2FkX24oJmV2LT5zdGF0ZSwgX19B
VE9NSUNfQUNRVUlSRSkpCgkJc3lzY2FsbChTWVNfZnV0ZXgsICZldi0+c3RhdGUsIEZVVEVYX1dB
SVQgfCBGVVRFWF9QUklWQVRFX0ZMQUcsIDAsIDApOwp9CgpzdGF0aWMgaW50IGV2ZW50X2lzc2V0
KGV2ZW50X3QqIGV2KQp7CglyZXR1cm4gX19hdG9taWNfbG9hZF9uKCZldi0+c3RhdGUsIF9fQVRP
TUlDX0FDUVVJUkUpOwp9CgpzdGF0aWMgaW50IGV2ZW50X3RpbWVkd2FpdChldmVudF90KiBldiwg
dWludDY0X3QgdGltZW91dCkKewoJdWludDY0X3Qgc3RhcnQgPSBjdXJyZW50X3RpbWVfbXMoKTsK
CXVpbnQ2NF90IG5vdyA9IHN0YXJ0OwoJZm9yICg7OykgewoJCXVpbnQ2NF90IHJlbWFpbiA9IHRp
bWVvdXQgLSAobm93IC0gc3RhcnQpOwoJCXN0cnVjdCB0aW1lc3BlYyB0czsKCQl0cy50dl9zZWMg
PSByZW1haW4gLyAxMDAwOwoJCXRzLnR2X25zZWMgPSAocmVtYWluICUgMTAwMCkgKiAxMDAwICog
MTAwMDsKCQlzeXNjYWxsKFNZU19mdXRleCwgJmV2LT5zdGF0ZSwgRlVURVhfV0FJVCB8IEZVVEVY
X1BSSVZBVEVfRkxBRywgMCwgJnRzKTsKCQlpZiAoX19hdG9taWNfbG9hZF9uKCZldi0+c3RhdGUs
IF9fQVRPTUlDX0FDUVVJUkUpKQoJCQlyZXR1cm4gMTsKCQlub3cgPSBjdXJyZW50X3RpbWVfbXMo
KTsKCQlpZiAobm93IC0gc3RhcnQgPiB0aW1lb3V0KQoJCQlyZXR1cm4gMDsKCX0KfQoKc3RhdGlj
IGJvb2wgd3JpdGVfZmlsZShjb25zdCBjaGFyKiBmaWxlLCBjb25zdCBjaGFyKiB3aGF0LCAuLi4p
CnsKCWNoYXIgYnVmWzEwMjRdOwoJdmFfbGlzdCBhcmdzOwoJdmFfc3RhcnQoYXJncywgd2hhdCk7
Cgl2c25wcmludGYoYnVmLCBzaXplb2YoYnVmKSwgd2hhdCwgYXJncyk7Cgl2YV9lbmQoYXJncyk7
CglidWZbc2l6ZW9mKGJ1ZikgLSAxXSA9IDA7CglpbnQgbGVuID0gc3RybGVuKGJ1Zik7CglpbnQg
ZmQgPSBvcGVuKGZpbGUsIE9fV1JPTkxZIHwgT19DTE9FWEVDKTsKCWlmIChmZCA9PSAtMSkKCQly
ZXR1cm4gZmFsc2U7CglpZiAod3JpdGUoZmQsIGJ1ZiwgbGVuKSAhPSBsZW4pIHsKCQlpbnQgZXJy
ID0gZXJybm87CgkJY2xvc2UoZmQpOwoJCWVycm5vID0gZXJyOwoJCXJldHVybiBmYWxzZTsKCX0K
CWNsb3NlKGZkKTsKCXJldHVybiB0cnVlOwp9CgpzdHJ1Y3Qgbmxtc2cgewoJY2hhciogcG9zOwoJ
aW50IG5lc3Rpbmc7CglzdHJ1Y3QgbmxhdHRyKiBuZXN0ZWRbOF07CgljaGFyIGJ1Zls0MDk2XTsK
fTsKCnN0YXRpYyB2b2lkIG5ldGxpbmtfaW5pdChzdHJ1Y3Qgbmxtc2cqIG5sbXNnLCBpbnQgdHlw
LCBpbnQgZmxhZ3MsCgkJCSBjb25zdCB2b2lkKiBkYXRhLCBpbnQgc2l6ZSkKewoJbWVtc2V0KG5s
bXNnLCAwLCBzaXplb2YoKm5sbXNnKSk7CglzdHJ1Y3Qgbmxtc2doZHIqIGhkciA9IChzdHJ1Y3Qg
bmxtc2doZHIqKW5sbXNnLT5idWY7CgloZHItPm5sbXNnX3R5cGUgPSB0eXA7CgloZHItPm5sbXNn
X2ZsYWdzID0gTkxNX0ZfUkVRVUVTVCB8IE5MTV9GX0FDSyB8IGZsYWdzOwoJbWVtY3B5KGhkciAr
IDEsIGRhdGEsIHNpemUpOwoJbmxtc2ctPnBvcyA9IChjaGFyKikoaGRyICsgMSkgKyBOTE1TR19B
TElHTihzaXplKTsKfQoKc3RhdGljIHZvaWQgbmV0bGlua19hdHRyKHN0cnVjdCBubG1zZyogbmxt
c2csIGludCB0eXAsCgkJCSBjb25zdCB2b2lkKiBkYXRhLCBpbnQgc2l6ZSkKewoJc3RydWN0IG5s
YXR0ciogYXR0ciA9IChzdHJ1Y3QgbmxhdHRyKilubG1zZy0+cG9zOwoJYXR0ci0+bmxhX2xlbiA9
IHNpemVvZigqYXR0cikgKyBzaXplOwoJYXR0ci0+bmxhX3R5cGUgPSB0eXA7CglpZiAoc2l6ZSA+
IDApCgkJbWVtY3B5KGF0dHIgKyAxLCBkYXRhLCBzaXplKTsKCW5sbXNnLT5wb3MgKz0gTkxNU0df
QUxJR04oYXR0ci0+bmxhX2xlbik7Cn0KCnN0YXRpYyB2b2lkIG5ldGxpbmtfbmVzdChzdHJ1Y3Qg
bmxtc2cqIG5sbXNnLCBpbnQgdHlwKQp7CglzdHJ1Y3QgbmxhdHRyKiBhdHRyID0gKHN0cnVjdCBu
bGF0dHIqKW5sbXNnLT5wb3M7CglhdHRyLT5ubGFfdHlwZSA9IHR5cDsKCW5sbXNnLT5wb3MgKz0g
c2l6ZW9mKCphdHRyKTsKCW5sbXNnLT5uZXN0ZWRbbmxtc2ctPm5lc3RpbmcrK10gPSBhdHRyOwp9
CgpzdGF0aWMgdm9pZCBuZXRsaW5rX2RvbmUoc3RydWN0IG5sbXNnKiBubG1zZykKewoJc3RydWN0
IG5sYXR0ciogYXR0ciA9IG5sbXNnLT5uZXN0ZWRbLS1ubG1zZy0+bmVzdGluZ107CglhdHRyLT5u
bGFfbGVuID0gbmxtc2ctPnBvcyAtIChjaGFyKilhdHRyOwp9CgpzdHJ1Y3QgdmZfaW50ZiB7Cglj
aGFyIHBhc3NfdGhydV9pbnRmW0lGTkFNU0laXTsKCWludCBwcGlkOwp9OwoKc3RhdGljIHN0cnVj
dCB2Zl9pbnRmIHZmX2ludGY7CgpzdGF0aWMgdm9pZCBmaW5kX3ZmX2ludGVyZmFjZSh2b2lkKQp7
CglzdHJ1Y3QgaWZhZGRycyogYWRkcmVzc2VzID0gTlVMTDsKCWludCBwaWQgPSBnZXRwaWQoKTsK
CWludCByZXQgPSAwOwoJbWVtc2V0KCZ2Zl9pbnRmLCAwLCBzaXplb2Yoc3RydWN0IHZmX2ludGYp
KTsKCWlmIChnZXRpZmFkZHJzKCZhZGRyZXNzZXMpID09IC0xKSB7CgkJcmV0dXJuOwoJfQoJaW50
IGZkID0gc29ja2V0KEFGX0lORVQsIFNPQ0tfREdSQU0sIElQUFJPVE9fSVApOwoJaWYgKGZkIDwg
MCkgewoJCXJldHVybjsKCX0KCXN0cnVjdCBpZnJlcSBpZnI7CglzdHJ1Y3QgZXRodG9vbF9kcnZp
bmZvIGRydmluZm87CglzdHJ1Y3QgaWZhZGRycyogYWRkcmVzcyA9IGFkZHJlc3NlczsKCXdoaWxl
IChhZGRyZXNzKSB7CgkJbWVtc2V0KCZpZnIsIDAsIHNpemVvZihzdHJ1Y3QgaWZyZXEpKTsKCQlz
dHJjcHkoaWZyLmlmcl9uYW1lLCBhZGRyZXNzLT5pZmFfbmFtZSk7CgkJbWVtc2V0KCZkcnZpbmZv
LCAwLCBzaXplb2Yoc3RydWN0IGV0aHRvb2xfZHJ2aW5mbykpOwoJCWRydmluZm8uY21kID0gRVRI
VE9PTF9HRFJWSU5GTzsKCQlpZnIuaWZyX2RhdGEgPSAoY2FkZHJfdCkmZHJ2aW5mbzsKCQlyZXQg
PSBpb2N0bChmZCwgU0lPQ0VUSFRPT0wsICZpZnIpOwoJCWlmIChyZXQgPCAwKSB7CgkJfSBlbHNl
IGlmIChzdHJsZW4oZHJ2aW5mby5idXNfaW5mbykpIHsKCQkJaWYgKHN0cmNtcChkcnZpbmZvLmJ1
c19pbmZvLCAiMDAwMDowMDoxMS4wIikgPT0gMCkgewoJCQkJaWYgKHN0cmxlbihhZGRyZXNzLT5p
ZmFfbmFtZSkgPCBJRk5BTVNJWikgewoJCQkJCXN0cm5jcHkodmZfaW50Zi5wYXNzX3RocnVfaW50
ZiwKCQkJCQkJYWRkcmVzcy0+aWZhX25hbWUsIElGTkFNU0laKTsKCQkJCQl2Zl9pbnRmLnBwaWQg
PSBwaWQ7CgkJCQl9IGVsc2UgewoJCQkJfQoJCQkJYnJlYWs7CgkJCX0KCQl9CgkJYWRkcmVzcyA9
IGFkZHJlc3MtPmlmYV9uZXh0OwoJfQoJZnJlZWlmYWRkcnMoYWRkcmVzc2VzKTsKCWlmICghdmZf
aW50Zi5wcGlkKSB7CgkJbWVtc2V0KCZ2Zl9pbnRmLCAwLCBzaXplb2Yoc3RydWN0IHZmX2ludGYp
KTsKCQlyZXR1cm47Cgl9Cn0KCnN0YXRpYyBpbnQgbmV0bGlua19zZW5kX2V4dChzdHJ1Y3Qgbmxt
c2cqIG5sbXNnLCBpbnQgc29jaywKCQkJICAgIHVpbnQxNl90IHJlcGx5X3R5cGUsIGludCogcmVw
bHlfbGVuLCBib29sIGRvZmFpbCkKewoJaWYgKG5sbXNnLT5wb3MgPiBubG1zZy0+YnVmICsgc2l6
ZW9mKG5sbXNnLT5idWYpIHx8IG5sbXNnLT5uZXN0aW5nKQoJZXhpdCgxKTsKCXN0cnVjdCBubG1z
Z2hkciogaGRyID0gKHN0cnVjdCBubG1zZ2hkciopbmxtc2ctPmJ1ZjsKCWhkci0+bmxtc2dfbGVu
ID0gbmxtc2ctPnBvcyAtIG5sbXNnLT5idWY7CglzdHJ1Y3Qgc29ja2FkZHJfbmwgYWRkcjsKCW1l
bXNldCgmYWRkciwgMCwgc2l6ZW9mKGFkZHIpKTsKCWFkZHIubmxfZmFtaWx5ID0gQUZfTkVUTElO
SzsKCXNzaXplX3QgbiA9IHNlbmR0byhzb2NrLCBubG1zZy0+YnVmLCBoZHItPm5sbXNnX2xlbiwg
MCwgKHN0cnVjdCBzb2NrYWRkciopJmFkZHIsIHNpemVvZihhZGRyKSk7CglpZiAobiAhPSAoc3Np
emVfdCloZHItPm5sbXNnX2xlbikgewoJCWlmIChkb2ZhaWwpCglleGl0KDEpOwoJCXJldHVybiAt
MTsKCX0KCW4gPSByZWN2KHNvY2ssIG5sbXNnLT5idWYsIHNpemVvZihubG1zZy0+YnVmKSwgMCk7
CglpZiAocmVwbHlfbGVuKQoJCSpyZXBseV9sZW4gPSAwOwoJaWYgKG4gPCAwKSB7CgkJaWYgKGRv
ZmFpbCkKCWV4aXQoMSk7CgkJcmV0dXJuIC0xOwoJfQoJaWYgKG4gPCAoc3NpemVfdClzaXplb2Yo
c3RydWN0IG5sbXNnaGRyKSkgewoJCWVycm5vID0gRUlOVkFMOwoJCWlmIChkb2ZhaWwpCglleGl0
KDEpOwoJCXJldHVybiAtMTsKCX0KCWlmIChoZHItPm5sbXNnX3R5cGUgPT0gTkxNU0dfRE9ORSkK
CQlyZXR1cm4gMDsKCWlmIChyZXBseV9sZW4gJiYgaGRyLT5ubG1zZ190eXBlID09IHJlcGx5X3R5
cGUpIHsKCQkqcmVwbHlfbGVuID0gbjsKCQlyZXR1cm4gMDsKCX0KCWlmIChuIDwgKHNzaXplX3Qp
KHNpemVvZihzdHJ1Y3Qgbmxtc2doZHIpICsgc2l6ZW9mKHN0cnVjdCBubG1zZ2VycikpKSB7CgkJ
ZXJybm8gPSBFSU5WQUw7CgkJaWYgKGRvZmFpbCkKCWV4aXQoMSk7CgkJcmV0dXJuIC0xOwoJfQoJ
aWYgKGhkci0+bmxtc2dfdHlwZSAhPSBOTE1TR19FUlJPUikgewoJCWVycm5vID0gRUlOVkFMOwoJ
CWlmIChkb2ZhaWwpCglleGl0KDEpOwoJCXJldHVybiAtMTsKCX0KCWVycm5vID0gLSgoc3RydWN0
IG5sbXNnZXJyKikoaGRyICsgMSkpLT5lcnJvcjsKCXJldHVybiAtZXJybm87Cn0KCnN0YXRpYyBp
bnQgbmV0bGlua19zZW5kKHN0cnVjdCBubG1zZyogbmxtc2csIGludCBzb2NrKQp7CglyZXR1cm4g
bmV0bGlua19zZW5kX2V4dChubG1zZywgc29jaywgMCwgTlVMTCwgdHJ1ZSk7Cn0KCnN0YXRpYyBp
bnQgbmV0bGlua19xdWVyeV9mYW1pbHlfaWQoc3RydWN0IG5sbXNnKiBubG1zZywgaW50IHNvY2ss
IGNvbnN0IGNoYXIqIGZhbWlseV9uYW1lLCBib29sIGRvZmFpbCkKewoJc3RydWN0IGdlbmxtc2do
ZHIgZ2VubGhkcjsKCW1lbXNldCgmZ2VubGhkciwgMCwgc2l6ZW9mKGdlbmxoZHIpKTsKCWdlbmxo
ZHIuY21kID0gQ1RSTF9DTURfR0VURkFNSUxZOwoJbmV0bGlua19pbml0KG5sbXNnLCBHRU5MX0lE
X0NUUkwsIDAsICZnZW5saGRyLCBzaXplb2YoZ2VubGhkcikpOwoJbmV0bGlua19hdHRyKG5sbXNn
LCBDVFJMX0FUVFJfRkFNSUxZX05BTUUsIGZhbWlseV9uYW1lLCBzdHJubGVuKGZhbWlseV9uYW1l
LCBHRU5MX05BTVNJWiAtIDEpICsgMSk7CglpbnQgbiA9IDA7CglpbnQgZXJyID0gbmV0bGlua19z
ZW5kX2V4dChubG1zZywgc29jaywgR0VOTF9JRF9DVFJMLCAmbiwgZG9mYWlsKTsKCWlmIChlcnIg
PCAwKSB7CgkJcmV0dXJuIC0xOwoJfQoJdWludDE2X3QgaWQgPSAwOwoJc3RydWN0IG5sYXR0ciog
YXR0ciA9IChzdHJ1Y3QgbmxhdHRyKikobmxtc2ctPmJ1ZiArIE5MTVNHX0hEUkxFTiArIE5MTVNH
X0FMSUdOKHNpemVvZihnZW5saGRyKSkpOwoJZm9yICg7IChjaGFyKilhdHRyIDwgbmxtc2ctPmJ1
ZiArIG47IGF0dHIgPSAoc3RydWN0IG5sYXR0ciopKChjaGFyKilhdHRyICsgTkxNU0dfQUxJR04o
YXR0ci0+bmxhX2xlbikpKSB7CgkJaWYgKGF0dHItPm5sYV90eXBlID09IENUUkxfQVRUUl9GQU1J
TFlfSUQpIHsKCQkJaWQgPSAqKHVpbnQxNl90KikoYXR0ciArIDEpOwoJCQlicmVhazsKCQl9Cgl9
CglpZiAoIWlkKSB7CgkJZXJybm8gPSBFSU5WQUw7CgkJcmV0dXJuIC0xOwoJfQoJcmVjdihzb2Nr
LCBubG1zZy0+YnVmLCBzaXplb2Yobmxtc2ctPmJ1ZiksIDApOwoJcmV0dXJuIGlkOwp9CgpzdGF0
aWMgaW50IG5ldGxpbmtfbmV4dF9tc2coc3RydWN0IG5sbXNnKiBubG1zZywgdW5zaWduZWQgaW50
IG9mZnNldCwKCQkJICAgIHVuc2lnbmVkIGludCB0b3RhbF9sZW4pCnsKCXN0cnVjdCBubG1zZ2hk
ciogaGRyID0gKHN0cnVjdCBubG1zZ2hkciopKG5sbXNnLT5idWYgKyBvZmZzZXQpOwoJaWYgKG9m
ZnNldCA9PSB0b3RhbF9sZW4gfHwgb2Zmc2V0ICsgaGRyLT5ubG1zZ19sZW4gPiB0b3RhbF9sZW4p
CgkJcmV0dXJuIC0xOwoJcmV0dXJuIGhkci0+bmxtc2dfbGVuOwp9CgpzdGF0aWMgdW5zaWduZWQg
aW50IHF1ZXVlX2NvdW50ID0gMjsKCnN0YXRpYyB2b2lkIG5ldGxpbmtfYWRkX2RldmljZV9pbXBs
KHN0cnVjdCBubG1zZyogbmxtc2csIGNvbnN0IGNoYXIqIHR5cGUsCgkJCQkgICAgY29uc3QgY2hh
ciogbmFtZSwgYm9vbCB1cCkKewoJc3RydWN0IGlmaW5mb21zZyBoZHI7CgltZW1zZXQoJmhkciwg
MCwgc2l6ZW9mKGhkcikpOwoJaWYgKHVwKQoJCWhkci5pZmlfZmxhZ3MgPSBoZHIuaWZpX2NoYW5n
ZSA9IElGRl9VUDsKCW5ldGxpbmtfaW5pdChubG1zZywgUlRNX05FV0xJTkssIE5MTV9GX0VYQ0wg
fCBOTE1fRl9DUkVBVEUsICZoZHIsIHNpemVvZihoZHIpKTsKCWlmIChuYW1lKQoJCW5ldGxpbmtf
YXR0cihubG1zZywgSUZMQV9JRk5BTUUsIG5hbWUsIHN0cmxlbihuYW1lKSk7CgluZXRsaW5rX2F0
dHIobmxtc2csIElGTEFfTlVNX1RYX1FVRVVFUywgJnF1ZXVlX2NvdW50LCBzaXplb2YocXVldWVf
Y291bnQpKTsKCW5ldGxpbmtfYXR0cihubG1zZywgSUZMQV9OVU1fUlhfUVVFVUVTLCAmcXVldWVf
Y291bnQsIHNpemVvZihxdWV1ZV9jb3VudCkpOwoJbmV0bGlua19uZXN0KG5sbXNnLCBJRkxBX0xJ
TktJTkZPKTsKCW5ldGxpbmtfYXR0cihubG1zZywgSUZMQV9JTkZPX0tJTkQsIHR5cGUsIHN0cmxl
bih0eXBlKSk7Cn0KCnN0YXRpYyB2b2lkIG5ldGxpbmtfYWRkX2RldmljZShzdHJ1Y3Qgbmxtc2cq
IG5sbXNnLCBpbnQgc29jaywgY29uc3QgY2hhciogdHlwZSwKCQkJICAgICAgIGNvbnN0IGNoYXIq
IG5hbWUpCnsKCW5ldGxpbmtfYWRkX2RldmljZV9pbXBsKG5sbXNnLCB0eXBlLCBuYW1lLCBmYWxz
ZSk7CgluZXRsaW5rX2RvbmUobmxtc2cpOwoJaW50IGVyciA9IG5ldGxpbmtfc2VuZChubG1zZywg
c29jayk7CglpZiAoZXJyIDwgMCkgewoJfQp9CgpzdGF0aWMgdm9pZCBuZXRsaW5rX2FkZF92ZXRo
KHN0cnVjdCBubG1zZyogbmxtc2csIGludCBzb2NrLCBjb25zdCBjaGFyKiBuYW1lLAoJCQkgICAg
IGNvbnN0IGNoYXIqIHBlZXIpCnsKCW5ldGxpbmtfYWRkX2RldmljZV9pbXBsKG5sbXNnLCAidmV0
aCIsIG5hbWUsIGZhbHNlKTsKCW5ldGxpbmtfbmVzdChubG1zZywgSUZMQV9JTkZPX0RBVEEpOwoJ
bmV0bGlua19uZXN0KG5sbXNnLCBWRVRIX0lORk9fUEVFUik7CglubG1zZy0+cG9zICs9IHNpemVv
ZihzdHJ1Y3QgaWZpbmZvbXNnKTsKCW5ldGxpbmtfYXR0cihubG1zZywgSUZMQV9JRk5BTUUsIHBl
ZXIsIHN0cmxlbihwZWVyKSk7CgluZXRsaW5rX2F0dHIobmxtc2csIElGTEFfTlVNX1RYX1FVRVVF
UywgJnF1ZXVlX2NvdW50LCBzaXplb2YocXVldWVfY291bnQpKTsKCW5ldGxpbmtfYXR0cihubG1z
ZywgSUZMQV9OVU1fUlhfUVVFVUVTLCAmcXVldWVfY291bnQsIHNpemVvZihxdWV1ZV9jb3VudCkp
OwoJbmV0bGlua19kb25lKG5sbXNnKTsKCW5ldGxpbmtfZG9uZShubG1zZyk7CgluZXRsaW5rX2Rv
bmUobmxtc2cpOwoJaW50IGVyciA9IG5ldGxpbmtfc2VuZChubG1zZywgc29jayk7CglpZiAoZXJy
IDwgMCkgewoJfQp9CgpzdGF0aWMgdm9pZCBuZXRsaW5rX2FkZF94ZnJtKHN0cnVjdCBubG1zZyog
bmxtc2csIGludCBzb2NrLCBjb25zdCBjaGFyKiBuYW1lKQp7CgluZXRsaW5rX2FkZF9kZXZpY2Vf
aW1wbChubG1zZywgInhmcm0iLCBuYW1lLCB0cnVlKTsKCW5ldGxpbmtfbmVzdChubG1zZywgSUZM
QV9JTkZPX0RBVEEpOwoJaW50IGlmX2lkID0gMTsKCW5ldGxpbmtfYXR0cihubG1zZywgMiwgJmlm
X2lkLCBzaXplb2YoaWZfaWQpKTsKCW5ldGxpbmtfZG9uZShubG1zZyk7CgluZXRsaW5rX2RvbmUo
bmxtc2cpOwoJaW50IGVyciA9IG5ldGxpbmtfc2VuZChubG1zZywgc29jayk7CglpZiAoZXJyIDwg
MCkgewoJfQp9CgpzdGF0aWMgdm9pZCBuZXRsaW5rX2FkZF9oc3Ioc3RydWN0IG5sbXNnKiBubG1z
ZywgaW50IHNvY2ssIGNvbnN0IGNoYXIqIG5hbWUsCgkJCSAgICBjb25zdCBjaGFyKiBzbGF2ZTEs
IGNvbnN0IGNoYXIqIHNsYXZlMikKewoJbmV0bGlua19hZGRfZGV2aWNlX2ltcGwobmxtc2csICJo
c3IiLCBuYW1lLCBmYWxzZSk7CgluZXRsaW5rX25lc3Qobmxtc2csIElGTEFfSU5GT19EQVRBKTsK
CWludCBpZmluZGV4MSA9IGlmX25hbWV0b2luZGV4KHNsYXZlMSk7CgluZXRsaW5rX2F0dHIobmxt
c2csIElGTEFfSFNSX1NMQVZFMSwgJmlmaW5kZXgxLCBzaXplb2YoaWZpbmRleDEpKTsKCWludCBp
ZmluZGV4MiA9IGlmX25hbWV0b2luZGV4KHNsYXZlMik7CgluZXRsaW5rX2F0dHIobmxtc2csIElG
TEFfSFNSX1NMQVZFMiwgJmlmaW5kZXgyLCBzaXplb2YoaWZpbmRleDIpKTsKCW5ldGxpbmtfZG9u
ZShubG1zZyk7CgluZXRsaW5rX2RvbmUobmxtc2cpOwoJaW50IGVyciA9IG5ldGxpbmtfc2VuZChu
bG1zZywgc29jayk7CglpZiAoZXJyIDwgMCkgewoJfQp9CgpzdGF0aWMgdm9pZCBuZXRsaW5rX2Fk
ZF9saW5rZWQoc3RydWN0IG5sbXNnKiBubG1zZywgaW50IHNvY2ssIGNvbnN0IGNoYXIqIHR5cGUs
IGNvbnN0IGNoYXIqIG5hbWUsIGNvbnN0IGNoYXIqIGxpbmspCnsKCW5ldGxpbmtfYWRkX2Rldmlj
ZV9pbXBsKG5sbXNnLCB0eXBlLCBuYW1lLCBmYWxzZSk7CgluZXRsaW5rX2RvbmUobmxtc2cpOwoJ
aW50IGlmaW5kZXggPSBpZl9uYW1ldG9pbmRleChsaW5rKTsKCW5ldGxpbmtfYXR0cihubG1zZywg
SUZMQV9MSU5LLCAmaWZpbmRleCwgc2l6ZW9mKGlmaW5kZXgpKTsKCWludCBlcnIgPSBuZXRsaW5r
X3NlbmQobmxtc2csIHNvY2spOwoJaWYgKGVyciA8IDApIHsKCX0KfQoKc3RhdGljIHZvaWQgbmV0
bGlua19hZGRfdmxhbihzdHJ1Y3Qgbmxtc2cqIG5sbXNnLCBpbnQgc29jaywgY29uc3QgY2hhciog
bmFtZSwgY29uc3QgY2hhciogbGluaywgdWludDE2X3QgaWQsIHVpbnQxNl90IHByb3RvKQp7Cglu
ZXRsaW5rX2FkZF9kZXZpY2VfaW1wbChubG1zZywgInZsYW4iLCBuYW1lLCBmYWxzZSk7CgluZXRs
aW5rX25lc3Qobmxtc2csIElGTEFfSU5GT19EQVRBKTsKCW5ldGxpbmtfYXR0cihubG1zZywgSUZM
QV9WTEFOX0lELCAmaWQsIHNpemVvZihpZCkpOwoJbmV0bGlua19hdHRyKG5sbXNnLCBJRkxBX1ZM
QU5fUFJPVE9DT0wsICZwcm90bywgc2l6ZW9mKHByb3RvKSk7CgluZXRsaW5rX2RvbmUobmxtc2cp
OwoJbmV0bGlua19kb25lKG5sbXNnKTsKCWludCBpZmluZGV4ID0gaWZfbmFtZXRvaW5kZXgobGlu
ayk7CgluZXRsaW5rX2F0dHIobmxtc2csIElGTEFfTElOSywgJmlmaW5kZXgsIHNpemVvZihpZmlu
ZGV4KSk7CglpbnQgZXJyID0gbmV0bGlua19zZW5kKG5sbXNnLCBzb2NrKTsKCWlmIChlcnIgPCAw
KSB7Cgl9Cn0KCnN0YXRpYyB2b2lkIG5ldGxpbmtfYWRkX21hY3ZsYW4oc3RydWN0IG5sbXNnKiBu
bG1zZywgaW50IHNvY2ssIGNvbnN0IGNoYXIqIG5hbWUsIGNvbnN0IGNoYXIqIGxpbmspCnsKCW5l
dGxpbmtfYWRkX2RldmljZV9pbXBsKG5sbXNnLCAibWFjdmxhbiIsIG5hbWUsIGZhbHNlKTsKCW5l
dGxpbmtfbmVzdChubG1zZywgSUZMQV9JTkZPX0RBVEEpOwoJdWludDMyX3QgbW9kZSA9IE1BQ1ZM
QU5fTU9ERV9CUklER0U7CgluZXRsaW5rX2F0dHIobmxtc2csIElGTEFfTUFDVkxBTl9NT0RFLCAm
bW9kZSwgc2l6ZW9mKG1vZGUpKTsKCW5ldGxpbmtfZG9uZShubG1zZyk7CgluZXRsaW5rX2RvbmUo
bmxtc2cpOwoJaW50IGlmaW5kZXggPSBpZl9uYW1ldG9pbmRleChsaW5rKTsKCW5ldGxpbmtfYXR0
cihubG1zZywgSUZMQV9MSU5LLCAmaWZpbmRleCwgc2l6ZW9mKGlmaW5kZXgpKTsKCWludCBlcnIg
PSBuZXRsaW5rX3NlbmQobmxtc2csIHNvY2spOwoJaWYgKGVyciA8IDApIHsKCX0KfQoKc3RhdGlj
IHZvaWQgbmV0bGlua19hZGRfZ2VuZXZlKHN0cnVjdCBubG1zZyogbmxtc2csIGludCBzb2NrLCBj
b25zdCBjaGFyKiBuYW1lLCB1aW50MzJfdCB2bmksIHN0cnVjdCBpbl9hZGRyKiBhZGRyNCwgc3Ry
dWN0IGluNl9hZGRyKiBhZGRyNikKewoJbmV0bGlua19hZGRfZGV2aWNlX2ltcGwobmxtc2csICJn
ZW5ldmUiLCBuYW1lLCBmYWxzZSk7CgluZXRsaW5rX25lc3Qobmxtc2csIElGTEFfSU5GT19EQVRB
KTsKCW5ldGxpbmtfYXR0cihubG1zZywgSUZMQV9HRU5FVkVfSUQsICZ2bmksIHNpemVvZih2bmkp
KTsKCWlmIChhZGRyNCkKCQluZXRsaW5rX2F0dHIobmxtc2csIElGTEFfR0VORVZFX1JFTU9URSwg
YWRkcjQsIHNpemVvZigqYWRkcjQpKTsKCWlmIChhZGRyNikKCQluZXRsaW5rX2F0dHIobmxtc2cs
IElGTEFfR0VORVZFX1JFTU9URTYsIGFkZHI2LCBzaXplb2YoKmFkZHI2KSk7CgluZXRsaW5rX2Rv
bmUobmxtc2cpOwoJbmV0bGlua19kb25lKG5sbXNnKTsKCWludCBlcnIgPSBuZXRsaW5rX3NlbmQo
bmxtc2csIHNvY2spOwoJaWYgKGVyciA8IDApIHsKCX0KfQoKI2RlZmluZSBJRkxBX0lQVkxBTl9G
TEFHUyAyCiNkZWZpbmUgSVBWTEFOX01PREVfTDNTIDIKI3VuZGVmIElQVkxBTl9GX1ZFUEEKI2Rl
ZmluZSBJUFZMQU5fRl9WRVBBIDIKCnN0YXRpYyB2b2lkIG5ldGxpbmtfYWRkX2lwdmxhbihzdHJ1
Y3Qgbmxtc2cqIG5sbXNnLCBpbnQgc29jaywgY29uc3QgY2hhciogbmFtZSwgY29uc3QgY2hhciog
bGluaywgdWludDE2X3QgbW9kZSwgdWludDE2X3QgZmxhZ3MpCnsKCW5ldGxpbmtfYWRkX2Rldmlj
ZV9pbXBsKG5sbXNnLCAiaXB2bGFuIiwgbmFtZSwgZmFsc2UpOwoJbmV0bGlua19uZXN0KG5sbXNn
LCBJRkxBX0lORk9fREFUQSk7CgluZXRsaW5rX2F0dHIobmxtc2csIElGTEFfSVBWTEFOX01PREUs
ICZtb2RlLCBzaXplb2YobW9kZSkpOwoJbmV0bGlua19hdHRyKG5sbXNnLCBJRkxBX0lQVkxBTl9G
TEFHUywgJmZsYWdzLCBzaXplb2YoZmxhZ3MpKTsKCW5ldGxpbmtfZG9uZShubG1zZyk7CgluZXRs
aW5rX2RvbmUobmxtc2cpOwoJaW50IGlmaW5kZXggPSBpZl9uYW1ldG9pbmRleChsaW5rKTsKCW5l
dGxpbmtfYXR0cihubG1zZywgSUZMQV9MSU5LLCAmaWZpbmRleCwgc2l6ZW9mKGlmaW5kZXgpKTsK
CWludCBlcnIgPSBuZXRsaW5rX3NlbmQobmxtc2csIHNvY2spOwoJaWYgKGVyciA8IDApIHsKCX0K
fQoKc3RhdGljIHZvaWQgbmV0bGlua19kZXZpY2VfY2hhbmdlKHN0cnVjdCBubG1zZyogbmxtc2cs
IGludCBzb2NrLCBjb25zdCBjaGFyKiBuYW1lLCBib29sIHVwLAoJCQkJICBjb25zdCBjaGFyKiBt
YXN0ZXIsIGNvbnN0IHZvaWQqIG1hYywgaW50IG1hY3NpemUsCgkJCQkgIGNvbnN0IGNoYXIqIG5l
d19uYW1lKQp7CglzdHJ1Y3QgaWZpbmZvbXNnIGhkcjsKCW1lbXNldCgmaGRyLCAwLCBzaXplb2Yo
aGRyKSk7CglpZiAodXApCgkJaGRyLmlmaV9mbGFncyA9IGhkci5pZmlfY2hhbmdlID0gSUZGX1VQ
OwoJaGRyLmlmaV9pbmRleCA9IGlmX25hbWV0b2luZGV4KG5hbWUpOwoJbmV0bGlua19pbml0KG5s
bXNnLCBSVE1fTkVXTElOSywgMCwgJmhkciwgc2l6ZW9mKGhkcikpOwoJaWYgKG5ld19uYW1lKQoJ
CW5ldGxpbmtfYXR0cihubG1zZywgSUZMQV9JRk5BTUUsIG5ld19uYW1lLCBzdHJsZW4obmV3X25h
bWUpKTsKCWlmIChtYXN0ZXIpIHsKCQlpbnQgaWZpbmRleCA9IGlmX25hbWV0b2luZGV4KG1hc3Rl
cik7CgkJbmV0bGlua19hdHRyKG5sbXNnLCBJRkxBX01BU1RFUiwgJmlmaW5kZXgsIHNpemVvZihp
ZmluZGV4KSk7Cgl9CglpZiAobWFjc2l6ZSkKCQluZXRsaW5rX2F0dHIobmxtc2csIElGTEFfQURE
UkVTUywgbWFjLCBtYWNzaXplKTsKCWludCBlcnIgPSBuZXRsaW5rX3NlbmQobmxtc2csIHNvY2sp
OwoJaWYgKGVyciA8IDApIHsKCX0KfQoKc3RhdGljIGludCBuZXRsaW5rX2FkZF9hZGRyKHN0cnVj
dCBubG1zZyogbmxtc2csIGludCBzb2NrLCBjb25zdCBjaGFyKiBkZXYsCgkJCSAgICBjb25zdCB2
b2lkKiBhZGRyLCBpbnQgYWRkcnNpemUpCnsKCXN0cnVjdCBpZmFkZHJtc2cgaGRyOwoJbWVtc2V0
KCZoZHIsIDAsIHNpemVvZihoZHIpKTsKCWhkci5pZmFfZmFtaWx5ID0gYWRkcnNpemUgPT0gNCA/
IEFGX0lORVQgOiBBRl9JTkVUNjsKCWhkci5pZmFfcHJlZml4bGVuID0gYWRkcnNpemUgPT0gNCA/
IDI0IDogMTIwOwoJaGRyLmlmYV9zY29wZSA9IFJUX1NDT1BFX1VOSVZFUlNFOwoJaGRyLmlmYV9p
bmRleCA9IGlmX25hbWV0b2luZGV4KGRldik7CgluZXRsaW5rX2luaXQobmxtc2csIFJUTV9ORVdB
RERSLCBOTE1fRl9DUkVBVEUgfCBOTE1fRl9SRVBMQUNFLCAmaGRyLCBzaXplb2YoaGRyKSk7Cglu
ZXRsaW5rX2F0dHIobmxtc2csIElGQV9MT0NBTCwgYWRkciwgYWRkcnNpemUpOwoJbmV0bGlua19h
dHRyKG5sbXNnLCBJRkFfQUREUkVTUywgYWRkciwgYWRkcnNpemUpOwoJcmV0dXJuIG5ldGxpbmtf
c2VuZChubG1zZywgc29jayk7Cn0KCnN0YXRpYyB2b2lkIG5ldGxpbmtfYWRkX2FkZHI0KHN0cnVj
dCBubG1zZyogbmxtc2csIGludCBzb2NrLAoJCQkgICAgICBjb25zdCBjaGFyKiBkZXYsIGNvbnN0
IGNoYXIqIGFkZHIpCnsKCXN0cnVjdCBpbl9hZGRyIGluX2FkZHI7CglpbmV0X3B0b24oQUZfSU5F
VCwgYWRkciwgJmluX2FkZHIpOwoJaW50IGVyciA9IG5ldGxpbmtfYWRkX2FkZHIobmxtc2csIHNv
Y2ssIGRldiwgJmluX2FkZHIsIHNpemVvZihpbl9hZGRyKSk7CglpZiAoZXJyIDwgMCkgewoJfQp9
CgpzdGF0aWMgdm9pZCBuZXRsaW5rX2FkZF9hZGRyNihzdHJ1Y3Qgbmxtc2cqIG5sbXNnLCBpbnQg
c29jaywKCQkJICAgICAgY29uc3QgY2hhciogZGV2LCBjb25zdCBjaGFyKiBhZGRyKQp7CglzdHJ1
Y3QgaW42X2FkZHIgaW42X2FkZHI7CglpbmV0X3B0b24oQUZfSU5FVDYsIGFkZHIsICZpbjZfYWRk
cik7CglpbnQgZXJyID0gbmV0bGlua19hZGRfYWRkcihubG1zZywgc29jaywgZGV2LCAmaW42X2Fk
ZHIsIHNpemVvZihpbjZfYWRkcikpOwoJaWYgKGVyciA8IDApIHsKCX0KfQoKc3RhdGljIHZvaWQg
bmV0bGlua19hZGRfbmVpZ2goc3RydWN0IG5sbXNnKiBubG1zZywgaW50IHNvY2ssIGNvbnN0IGNo
YXIqIG5hbWUsCgkJCSAgICAgIGNvbnN0IHZvaWQqIGFkZHIsIGludCBhZGRyc2l6ZSwgY29uc3Qg
dm9pZCogbWFjLCBpbnQgbWFjc2l6ZSkKewoJc3RydWN0IG5kbXNnIGhkcjsKCW1lbXNldCgmaGRy
LCAwLCBzaXplb2YoaGRyKSk7CgloZHIubmRtX2ZhbWlseSA9IGFkZHJzaXplID09IDQgPyBBRl9J
TkVUIDogQUZfSU5FVDY7CgloZHIubmRtX2lmaW5kZXggPSBpZl9uYW1ldG9pbmRleChuYW1lKTsK
CWhkci5uZG1fc3RhdGUgPSBOVURfUEVSTUFORU5UOwoJbmV0bGlua19pbml0KG5sbXNnLCBSVE1f
TkVXTkVJR0gsIE5MTV9GX0VYQ0wgfCBOTE1fRl9DUkVBVEUsICZoZHIsIHNpemVvZihoZHIpKTsK
CW5ldGxpbmtfYXR0cihubG1zZywgTkRBX0RTVCwgYWRkciwgYWRkcnNpemUpOwoJbmV0bGlua19h
dHRyKG5sbXNnLCBOREFfTExBRERSLCBtYWMsIG1hY3NpemUpOwoJaW50IGVyciA9IG5ldGxpbmtf
c2VuZChubG1zZywgc29jayk7CglpZiAoZXJyIDwgMCkgewoJfQp9CgpzdGF0aWMgc3RydWN0IG5s
bXNnIG5sbXNnOwoKc3RhdGljIGludCB0dW5mZCA9IC0xOwoKI2RlZmluZSBUVU5fSUZBQ0UgInN5
el90dW4iCiNkZWZpbmUgTE9DQUxfTUFDIDB4YWFhYWFhYWFhYWFhCiNkZWZpbmUgUkVNT1RFX01B
QyAweGFhYWFhYWFhYWFiYgojZGVmaW5lIExPQ0FMX0lQVjQgIjE3Mi4yMC4yMC4xNzAiCiNkZWZp
bmUgUkVNT1RFX0lQVjQgIjE3Mi4yMC4yMC4xODciCiNkZWZpbmUgTE9DQUxfSVBWNiAiZmU4MDo6
YWEiCiNkZWZpbmUgUkVNT1RFX0lQVjYgImZlODA6OmJiIgoKI2RlZmluZSBJRkZfTkFQSSAweDAw
MTAKc3RhdGljIHZvaWQgY29ycmVjdF9kZXZfbmV0X3R1bih2b2lkKQp7CglzdHJ1Y3Qgc3RhdCBz
dDsKCWlmIChzdGF0KCIvZGV2L25ldC90dW4iLCAmc3QpID09IDApIHsKCQlpZiAoU19JU0NIUihz
dC5zdF9tb2RlKSAmJiBtYWpvcihzdC5zdF9yZGV2KSA9PSAxMCAmJiBtaW5vcihzdC5zdF9yZGV2
KSA9PSAyMDApCgkJCXJldHVybjsKCQlpZiAodW5saW5rKCIvZGV2L25ldC90dW4iKSkgewoJCX0K
CX0KCWlmIChta2RpcigiL2Rldi9uZXQiLCAwNzU1KSAmJiBlcnJubyAhPSBFRVhJU1QpIHsKCX0K
CWlmIChta25vZCgiL2Rldi9uZXQvdHVuIiwgU19JRkNIUiB8IDA2NjYsIG1ha2VkZXYoMTAsIDIw
MCkpKSB7Cgl9CglpZiAoY2htb2QoIi9kZXYvbmV0L3R1biIsIDA2NjYpKSB7Cgl9Cn0KCnN0YXRp
YyB2b2lkIGluaXRpYWxpemVfdHVuKHZvaWQpCnsKCWNvcnJlY3RfZGV2X25ldF90dW4oKTsKCXR1
bmZkID0gb3BlbigiL2Rldi9uZXQvdHVuIiwgT19SRFdSIHwgT19OT05CTE9DSyk7CglpZiAodHVu
ZmQgPT0gLTEpIHsKCQlwcmludGYoInR1bjogY2FuJ3Qgb3BlbiAvZGV2L25ldC90dW46IHBsZWFz
ZSBlbmFibGUgQ09ORklHX1RVTj15XG4iKTsKCQlwcmludGYoIm90aGVyd2lzZSBmdXp6aW5nIG9y
IHJlcHJvZHVjaW5nIG1pZ2h0IG5vdCB3b3JrIGFzIGludGVuZGVkXG4iKTsKCQlyZXR1cm47Cgl9
Cgljb25zdCBpbnQga1R1bkZkID0gMjAwOwoJaWYgKGR1cDIodHVuZmQsIGtUdW5GZCkgPCAwKQoJ
ZXhpdCgxKTsKCWNsb3NlKHR1bmZkKTsKCXR1bmZkID0ga1R1bkZkOwoJc3RydWN0IGlmcmVxIGlm
cjsKCW1lbXNldCgmaWZyLCAwLCBzaXplb2YoaWZyKSk7CglzdHJuY3B5KGlmci5pZnJfbmFtZSwg
VFVOX0lGQUNFLCBJRk5BTVNJWik7CglpZnIuaWZyX2ZsYWdzID0gSUZGX1RBUCB8IElGRl9OT19Q
STsKCWlmIChpb2N0bCh0dW5mZCwgVFVOU0VUSUZGLCAodm9pZCopJmlmcikgPCAwKSB7CglleGl0
KDEpOwoJfQoJY2hhciBzeXNjdGxbNjRdOwoJc3ByaW50ZihzeXNjdGwsICIvcHJvYy9zeXMvbmV0
L2lwdjYvY29uZi8lcy9hY2NlcHRfZGFkIiwgVFVOX0lGQUNFKTsKCXdyaXRlX2ZpbGUoc3lzY3Rs
LCAiMCIpOwoJc3ByaW50ZihzeXNjdGwsICIvcHJvYy9zeXMvbmV0L2lwdjYvY29uZi8lcy9yb3V0
ZXJfc29saWNpdGF0aW9ucyIsIFRVTl9JRkFDRSk7Cgl3cml0ZV9maWxlKHN5c2N0bCwgIjAiKTsK
CWludCBzb2NrID0gc29ja2V0KEFGX05FVExJTkssIFNPQ0tfUkFXLCBORVRMSU5LX1JPVVRFKTsK
CWlmIChzb2NrID09IC0xKQoJZXhpdCgxKTsKCW5ldGxpbmtfYWRkX2FkZHI0KCZubG1zZywgc29j
aywgVFVOX0lGQUNFLCBMT0NBTF9JUFY0KTsKCW5ldGxpbmtfYWRkX2FkZHI2KCZubG1zZywgc29j
aywgVFVOX0lGQUNFLCBMT0NBTF9JUFY2KTsKCXVpbnQ2NF90IG1hY2FkZHIgPSBSRU1PVEVfTUFD
OwoJc3RydWN0IGluX2FkZHIgaW5fYWRkcjsKCWluZXRfcHRvbihBRl9JTkVULCBSRU1PVEVfSVBW
NCwgJmluX2FkZHIpOwoJbmV0bGlua19hZGRfbmVpZ2goJm5sbXNnLCBzb2NrLCBUVU5fSUZBQ0Us
ICZpbl9hZGRyLCBzaXplb2YoaW5fYWRkciksICZtYWNhZGRyLCBFVEhfQUxFTik7CglzdHJ1Y3Qg
aW42X2FkZHIgaW42X2FkZHI7CglpbmV0X3B0b24oQUZfSU5FVDYsIFJFTU9URV9JUFY2LCAmaW42
X2FkZHIpOwoJbmV0bGlua19hZGRfbmVpZ2goJm5sbXNnLCBzb2NrLCBUVU5fSUZBQ0UsICZpbjZf
YWRkciwgc2l6ZW9mKGluNl9hZGRyKSwgJm1hY2FkZHIsIEVUSF9BTEVOKTsKCW1hY2FkZHIgPSBM
T0NBTF9NQUM7CgluZXRsaW5rX2RldmljZV9jaGFuZ2UoJm5sbXNnLCBzb2NrLCBUVU5fSUZBQ0Us
IHRydWUsIDAsICZtYWNhZGRyLCBFVEhfQUxFTiwgTlVMTCk7CgljbG9zZShzb2NrKTsKfQoKY29u
c3QgaW50IGtJbml0TmV0TnNGZCA9IDIwMTsKCiNkZWZpbmUgREVWTElOS19GQU1JTFlfTkFNRSAi
ZGV2bGluayIKCiNkZWZpbmUgREVWTElOS19DTURfUE9SVF9HRVQgNQojZGVmaW5lIERFVkxJTktf
Q01EX1JFTE9BRCAzNwojZGVmaW5lIERFVkxJTktfQVRUUl9CVVNfTkFNRSAxCiNkZWZpbmUgREVW
TElOS19BVFRSX0RFVl9OQU1FIDIKI2RlZmluZSBERVZMSU5LX0FUVFJfTkVUREVWX05BTUUgNwoj
ZGVmaW5lIERFVkxJTktfQVRUUl9ORVROU19GRCAxMzgKCnN0YXRpYyB2b2lkIG5ldGxpbmtfZGV2
bGlua19uZXRuc19tb3ZlKGNvbnN0IGNoYXIqIGJ1c19uYW1lLCBjb25zdCBjaGFyKiBkZXZfbmFt
ZSwgaW50IG5ldG5zX2ZkKQp7CglzdHJ1Y3QgZ2VubG1zZ2hkciBnZW5saGRyOwoJaW50IHNvY2s7
CglpbnQgaWQsIGVycjsKCXNvY2sgPSBzb2NrZXQoQUZfTkVUTElOSywgU09DS19SQVcsIE5FVExJ
TktfR0VORVJJQyk7CglpZiAoc29jayA9PSAtMSkKCWV4aXQoMSk7CglpZCA9IG5ldGxpbmtfcXVl
cnlfZmFtaWx5X2lkKCZubG1zZywgc29jaywgREVWTElOS19GQU1JTFlfTkFNRSwgdHJ1ZSk7Cglp
ZiAoaWQgPT0gLTEpCgkJZ290byBlcnJvcjsKCW1lbXNldCgmZ2VubGhkciwgMCwgc2l6ZW9mKGdl
bmxoZHIpKTsKCWdlbmxoZHIuY21kID0gREVWTElOS19DTURfUkVMT0FEOwoJbmV0bGlua19pbml0
KCZubG1zZywgaWQsIDAsICZnZW5saGRyLCBzaXplb2YoZ2VubGhkcikpOwoJbmV0bGlua19hdHRy
KCZubG1zZywgREVWTElOS19BVFRSX0JVU19OQU1FLCBidXNfbmFtZSwgc3RybGVuKGJ1c19uYW1l
KSArIDEpOwoJbmV0bGlua19hdHRyKCZubG1zZywgREVWTElOS19BVFRSX0RFVl9OQU1FLCBkZXZf
bmFtZSwgc3RybGVuKGRldl9uYW1lKSArIDEpOwoJbmV0bGlua19hdHRyKCZubG1zZywgREVWTElO
S19BVFRSX05FVE5TX0ZELCAmbmV0bnNfZmQsIHNpemVvZihuZXRuc19mZCkpOwoJZXJyID0gbmV0
bGlua19zZW5kKCZubG1zZywgc29jayk7CglpZiAoZXJyIDwgMCkgewoJfQplcnJvcjoKCWNsb3Nl
KHNvY2spOwp9CgpzdGF0aWMgc3RydWN0IG5sbXNnIG5sbXNnMjsKCnN0YXRpYyB2b2lkIGluaXRp
YWxpemVfZGV2bGlua19wb3J0cyhjb25zdCBjaGFyKiBidXNfbmFtZSwgY29uc3QgY2hhciogZGV2
X25hbWUsCgkJCQkgICAgIGNvbnN0IGNoYXIqIG5ldGRldl9wcmVmaXgpCnsKCXN0cnVjdCBnZW5s
bXNnaGRyIGdlbmxoZHI7CglpbnQgbGVuLCB0b3RhbF9sZW4sIGlkLCBlcnIsIG9mZnNldDsKCXVp
bnQxNl90IG5ldGRldl9pbmRleDsKCWludCBzb2NrID0gc29ja2V0KEFGX05FVExJTkssIFNPQ0tf
UkFXLCBORVRMSU5LX0dFTkVSSUMpOwoJaWYgKHNvY2sgPT0gLTEpCglleGl0KDEpOwoJaW50IHJ0
c29jayA9IHNvY2tldChBRl9ORVRMSU5LLCBTT0NLX1JBVywgTkVUTElOS19ST1VURSk7CglpZiAo
cnRzb2NrID09IC0xKQoJZXhpdCgxKTsKCWlkID0gbmV0bGlua19xdWVyeV9mYW1pbHlfaWQoJm5s
bXNnLCBzb2NrLCBERVZMSU5LX0ZBTUlMWV9OQU1FLCB0cnVlKTsKCWlmIChpZCA9PSAtMSkKCQln
b3RvIGVycm9yOwoJbWVtc2V0KCZnZW5saGRyLCAwLCBzaXplb2YoZ2VubGhkcikpOwoJZ2VubGhk
ci5jbWQgPSBERVZMSU5LX0NNRF9QT1JUX0dFVDsKCW5ldGxpbmtfaW5pdCgmbmxtc2csIGlkLCBO
TE1fRl9EVU1QLCAmZ2VubGhkciwgc2l6ZW9mKGdlbmxoZHIpKTsKCW5ldGxpbmtfYXR0cigmbmxt
c2csIERFVkxJTktfQVRUUl9CVVNfTkFNRSwgYnVzX25hbWUsIHN0cmxlbihidXNfbmFtZSkgKyAx
KTsKCW5ldGxpbmtfYXR0cigmbmxtc2csIERFVkxJTktfQVRUUl9ERVZfTkFNRSwgZGV2X25hbWUs
IHN0cmxlbihkZXZfbmFtZSkgKyAxKTsKCWVyciA9IG5ldGxpbmtfc2VuZF9leHQoJm5sbXNnLCBz
b2NrLCBpZCwgJnRvdGFsX2xlbiwgdHJ1ZSk7CglpZiAoZXJyIDwgMCkgewoJCWdvdG8gZXJyb3I7
Cgl9CglvZmZzZXQgPSAwOwoJbmV0ZGV2X2luZGV4ID0gMDsKCXdoaWxlICgobGVuID0gbmV0bGlu
a19uZXh0X21zZygmbmxtc2csIG9mZnNldCwgdG90YWxfbGVuKSkgIT0gLTEpIHsKCQlzdHJ1Y3Qg
bmxhdHRyKiBhdHRyID0gKHN0cnVjdCBubGF0dHIqKShubG1zZy5idWYgKyBvZmZzZXQgKyBOTE1T
R19IRFJMRU4gKyBOTE1TR19BTElHTihzaXplb2YoZ2VubGhkcikpKTsKCQlmb3IgKDsgKGNoYXIq
KWF0dHIgPCBubG1zZy5idWYgKyBvZmZzZXQgKyBsZW47IGF0dHIgPSAoc3RydWN0IG5sYXR0ciop
KChjaGFyKilhdHRyICsgTkxNU0dfQUxJR04oYXR0ci0+bmxhX2xlbikpKSB7CgkJCWlmIChhdHRy
LT5ubGFfdHlwZSA9PSBERVZMSU5LX0FUVFJfTkVUREVWX05BTUUpIHsKCQkJCWNoYXIqIHBvcnRf
bmFtZTsKCQkJCWNoYXIgbmV0ZGV2X25hbWVbSUZOQU1TSVpdOwoJCQkJcG9ydF9uYW1lID0gKGNo
YXIqKShhdHRyICsgMSk7CgkJCQlzbnByaW50ZihuZXRkZXZfbmFtZSwgc2l6ZW9mKG5ldGRldl9u
YW1lKSwgIiVzJWQiLCBuZXRkZXZfcHJlZml4LCBuZXRkZXZfaW5kZXgpOwoJCQkJbmV0bGlua19k
ZXZpY2VfY2hhbmdlKCZubG1zZzIsIHJ0c29jaywgcG9ydF9uYW1lLCB0cnVlLCAwLCAwLCAwLCBu
ZXRkZXZfbmFtZSk7CgkJCQlicmVhazsKCQkJfQoJCX0KCQlvZmZzZXQgKz0gbGVuOwoJCW5ldGRl
dl9pbmRleCsrOwoJfQplcnJvcjoKCWNsb3NlKHJ0c29jayk7CgljbG9zZShzb2NrKTsKfQoKc3Rh
dGljIHZvaWQgaW5pdGlhbGl6ZV9kZXZsaW5rX3BjaSh2b2lkKQp7CglpbnQgbmV0bnMgPSBvcGVu
KCIvcHJvYy9zZWxmL25zL25ldCIsIE9fUkRPTkxZKTsKCWlmIChuZXRucyA9PSAtMSkKCWV4aXQo
MSk7CglpbnQgcmV0ID0gc2V0bnMoa0luaXROZXROc0ZkLCAwKTsKCWlmIChyZXQgPT0gLTEpCgll
eGl0KDEpOwoJbmV0bGlua19kZXZsaW5rX25ldG5zX21vdmUoInBjaSIsICIwMDAwOjAwOjEwLjAi
LCBuZXRucyk7CglyZXQgPSBzZXRucyhuZXRucywgMCk7CglpZiAocmV0ID09IC0xKQoJZXhpdCgx
KTsKCWNsb3NlKG5ldG5zKTsKCWluaXRpYWxpemVfZGV2bGlua19wb3J0cygicGNpIiwgIjAwMDA6
MDA6MTAuMCIsICJuZXRwY2kiKTsKfQoKI2RlZmluZSBXSUZJX0lOSVRJQUxfREVWSUNFX0NPVU5U
IDIKI2RlZmluZSBXSUZJX01BQ19CQVNFIHsgMHgwOCwgMHgwMiwgMHgxMSwgMHgwMCwgMHgwMCwg
MHgwMH0KI2RlZmluZSBXSUZJX0lCU1NfQlNTSUQgeyAweDUwLCAweDUwLCAweDUwLCAweDUwLCAw
eDUwLCAweDUwfQojZGVmaW5lIFdJRklfSUJTU19TU0lEIHsgMHgxMCwgMHgxMCwgMHgxMCwgMHgx
MCwgMHgxMCwgMHgxMH0KI2RlZmluZSBXSUZJX0RFRkFVTFRfRlJFUVVFTkNZIDI0MTIKI2RlZmlu
ZSBXSUZJX0RFRkFVTFRfU0lHTkFMIDAKI2RlZmluZSBXSUZJX0RFRkFVTFRfUlhfUkFURSAxCiNk
ZWZpbmUgSFdTSU1fQ01EX1JFR0lTVEVSIDEKI2RlZmluZSBIV1NJTV9DTURfRlJBTUUgMgojZGVm
aW5lIEhXU0lNX0NNRF9ORVdfUkFESU8gNAojZGVmaW5lIEhXU0lNX0FUVFJfU1VQUE9SVF9QMlBf
REVWSUNFIDE0CiNkZWZpbmUgSFdTSU1fQVRUUl9QRVJNX0FERFIgMjIKCiNkZWZpbmUgSUZfT1BF
Ul9VUCA2CnN0cnVjdCBqb2luX2lic3NfcHJvcHMgewoJaW50IHdpcGh5X2ZyZXE7Cglib29sIHdp
cGh5X2ZyZXFfZml4ZWQ7Cgl1aW50OF90KiBtYWM7Cgl1aW50OF90KiBzc2lkOwoJaW50IHNzaWRf
bGVuOwp9OwoKc3RhdGljIGludCBzZXRfaW50ZXJmYWNlX3N0YXRlKGNvbnN0IGNoYXIqIGludGVy
ZmFjZV9uYW1lLCBpbnQgb24pCnsKCXN0cnVjdCBpZnJlcSBpZnI7CglpbnQgc29jayA9IHNvY2tl
dChBRl9JTkVULCBTT0NLX0RHUkFNLCAwKTsKCWlmIChzb2NrIDwgMCkgewoJCXJldHVybiAtMTsK
CX0KCW1lbXNldCgmaWZyLCAwLCBzaXplb2YoaWZyKSk7CglzdHJjcHkoaWZyLmlmcl9uYW1lLCBp
bnRlcmZhY2VfbmFtZSk7CglpbnQgcmV0ID0gaW9jdGwoc29jaywgU0lPQ0dJRkZMQUdTLCAmaWZy
KTsKCWlmIChyZXQgPCAwKSB7CgkJY2xvc2Uoc29jayk7CgkJcmV0dXJuIC0xOwoJfQoJaWYgKG9u
KQoJCWlmci5pZnJfZmxhZ3MgfD0gSUZGX1VQOwoJZWxzZQoJCWlmci5pZnJfZmxhZ3MgJj0gfklG
Rl9VUDsKCXJldCA9IGlvY3RsKHNvY2ssIFNJT0NTSUZGTEFHUywgJmlmcik7CgljbG9zZShzb2Nr
KTsKCWlmIChyZXQgPCAwKSB7CgkJcmV0dXJuIC0xOwoJfQoJcmV0dXJuIDA7Cn0KCnN0YXRpYyBp
bnQgbmw4MDIxMV9zZXRfaW50ZXJmYWNlKHN0cnVjdCBubG1zZyogbmxtc2csIGludCBzb2NrLCBp
bnQgbmw4MDIxMV9mYW1pbHksIHVpbnQzMl90IGlmaW5kZXgsCgkJCQkgdWludDMyX3QgaWZ0eXBl
LCBib29sIGRvZmFpbCkKewoJc3RydWN0IGdlbmxtc2doZHIgZ2VubGhkcjsKCW1lbXNldCgmZ2Vu
bGhkciwgMCwgc2l6ZW9mKGdlbmxoZHIpKTsKCWdlbmxoZHIuY21kID0gTkw4MDIxMV9DTURfU0VU
X0lOVEVSRkFDRTsKCW5ldGxpbmtfaW5pdChubG1zZywgbmw4MDIxMV9mYW1pbHksIDAsICZnZW5s
aGRyLCBzaXplb2YoZ2VubGhkcikpOwoJbmV0bGlua19hdHRyKG5sbXNnLCBOTDgwMjExX0FUVFJf
SUZJTkRFWCwgJmlmaW5kZXgsIHNpemVvZihpZmluZGV4KSk7CgluZXRsaW5rX2F0dHIobmxtc2cs
IE5MODAyMTFfQVRUUl9JRlRZUEUsICZpZnR5cGUsIHNpemVvZihpZnR5cGUpKTsKCWludCBlcnIg
PSBuZXRsaW5rX3NlbmRfZXh0KG5sbXNnLCBzb2NrLCAwLCBOVUxMLCBkb2ZhaWwpOwoJaWYgKGVy
ciA8IDApIHsKCX0KCXJldHVybiBlcnI7Cn0KCnN0YXRpYyBpbnQgbmw4MDIxMV9qb2luX2lic3Mo
c3RydWN0IG5sbXNnKiBubG1zZywgaW50IHNvY2ssIGludCBubDgwMjExX2ZhbWlseSwgdWludDMy
X3QgaWZpbmRleCwKCQkJICAgICBzdHJ1Y3Qgam9pbl9pYnNzX3Byb3BzKiBwcm9wcywgYm9vbCBk
b2ZhaWwpCnsKCXN0cnVjdCBnZW5sbXNnaGRyIGdlbmxoZHI7CgltZW1zZXQoJmdlbmxoZHIsIDAs
IHNpemVvZihnZW5saGRyKSk7CglnZW5saGRyLmNtZCA9IE5MODAyMTFfQ01EX0pPSU5fSUJTUzsK
CW5ldGxpbmtfaW5pdChubG1zZywgbmw4MDIxMV9mYW1pbHksIDAsICZnZW5saGRyLCBzaXplb2Yo
Z2VubGhkcikpOwoJbmV0bGlua19hdHRyKG5sbXNnLCBOTDgwMjExX0FUVFJfSUZJTkRFWCwgJmlm
aW5kZXgsIHNpemVvZihpZmluZGV4KSk7CgluZXRsaW5rX2F0dHIobmxtc2csIE5MODAyMTFfQVRU
Ul9TU0lELCBwcm9wcy0+c3NpZCwgcHJvcHMtPnNzaWRfbGVuKTsKCW5ldGxpbmtfYXR0cihubG1z
ZywgTkw4MDIxMV9BVFRSX1dJUEhZX0ZSRVEsICYocHJvcHMtPndpcGh5X2ZyZXEpLCBzaXplb2Yo
cHJvcHMtPndpcGh5X2ZyZXEpKTsKCWlmIChwcm9wcy0+bWFjKQoJCW5ldGxpbmtfYXR0cihubG1z
ZywgTkw4MDIxMV9BVFRSX01BQywgcHJvcHMtPm1hYywgRVRIX0FMRU4pOwoJaWYgKHByb3BzLT53
aXBoeV9mcmVxX2ZpeGVkKQoJCW5ldGxpbmtfYXR0cihubG1zZywgTkw4MDIxMV9BVFRSX0ZSRVFf
RklYRUQsIE5VTEwsIDApOwoJaW50IGVyciA9IG5ldGxpbmtfc2VuZF9leHQobmxtc2csIHNvY2ss
IDAsIE5VTEwsIGRvZmFpbCk7CglpZiAoZXJyIDwgMCkgewoJfQoJcmV0dXJuIGVycjsKfQoKc3Rh
dGljIGludCBnZXRfaWZsYV9vcGVyc3RhdGUoc3RydWN0IG5sbXNnKiBubG1zZywgaW50IGlmaW5k
ZXgsIGJvb2wgZG9mYWlsKQp7CglzdHJ1Y3QgaWZpbmZvbXNnIGluZm87CgltZW1zZXQoJmluZm8s
IDAsIHNpemVvZihpbmZvKSk7CglpbmZvLmlmaV9mYW1pbHkgPSBBRl9VTlNQRUM7CglpbmZvLmlm
aV9pbmRleCA9IGlmaW5kZXg7CglpbnQgc29jayA9IHNvY2tldChBRl9ORVRMSU5LLCBTT0NLX1JB
VywgTkVUTElOS19ST1VURSk7CglpZiAoc29jayA9PSAtMSkgewoJCXJldHVybiAtMTsKCX0KCW5l
dGxpbmtfaW5pdChubG1zZywgUlRNX0dFVExJTkssIDAsICZpbmZvLCBzaXplb2YoaW5mbykpOwoJ
aW50IG47CglpbnQgZXJyID0gbmV0bGlua19zZW5kX2V4dChubG1zZywgc29jaywgUlRNX05FV0xJ
TkssICZuLCBkb2ZhaWwpOwoJY2xvc2Uoc29jayk7CglpZiAoZXJyKSB7CgkJcmV0dXJuIC0xOwoJ
fQoJc3RydWN0IHJ0YXR0ciogYXR0ciA9IElGTEFfUlRBKE5MTVNHX0RBVEEobmxtc2ctPmJ1Zikp
OwoJZm9yICg7IFJUQV9PSyhhdHRyLCBuKTsgYXR0ciA9IFJUQV9ORVhUKGF0dHIsIG4pKSB7CgkJ
aWYgKGF0dHItPnJ0YV90eXBlID09IElGTEFfT1BFUlNUQVRFKQoJCQlyZXR1cm4gKigoaW50MzJf
dCopUlRBX0RBVEEoYXR0cikpOwoJfQoJcmV0dXJuIC0xOwp9CgpzdGF0aWMgaW50IGF3YWl0X2lm
bGFfb3BlcnN0YXRlKHN0cnVjdCBubG1zZyogbmxtc2csIGNoYXIqIGludGVyZmFjZSwgaW50IG9w
ZXJzdGF0ZSwgYm9vbCBkb2ZhaWwpCnsKCWludCBpZmluZGV4ID0gaWZfbmFtZXRvaW5kZXgoaW50
ZXJmYWNlKTsKCXdoaWxlICh0cnVlKSB7CgkJdXNsZWVwKDEwMDApOwoJCWludCByZXQgPSBnZXRf
aWZsYV9vcGVyc3RhdGUobmxtc2csIGlmaW5kZXgsIGRvZmFpbCk7CgkJaWYgKHJldCA8IDApCgkJ
CXJldHVybiByZXQ7CgkJaWYgKHJldCA9PSBvcGVyc3RhdGUpCgkJCXJldHVybiAwOwoJfQoJcmV0
dXJuIDA7Cn0KCnN0YXRpYyBpbnQgbmw4MDIxMV9zZXR1cF9pYnNzX2ludGVyZmFjZShzdHJ1Y3Qg
bmxtc2cqIG5sbXNnLCBpbnQgc29jaywgaW50IG5sODAyMTFfZmFtaWx5X2lkLCBjaGFyKiBpbnRl
cmZhY2UsCgkJCQkJc3RydWN0IGpvaW5faWJzc19wcm9wcyogaWJzc19wcm9wcywgYm9vbCBkb2Zh
aWwpCnsKCWludCBpZmluZGV4ID0gaWZfbmFtZXRvaW5kZXgoaW50ZXJmYWNlKTsKCWlmIChpZmlu
ZGV4ID09IDApIHsKCQlyZXR1cm4gLTE7Cgl9CglpbnQgcmV0ID0gbmw4MDIxMV9zZXRfaW50ZXJm
YWNlKG5sbXNnLCBzb2NrLCBubDgwMjExX2ZhbWlseV9pZCwgaWZpbmRleCwgTkw4MDIxMV9JRlRZ
UEVfQURIT0MsIGRvZmFpbCk7CglpZiAocmV0IDwgMCkgewoJCXJldHVybiAtMTsKCX0KCXJldCA9
IHNldF9pbnRlcmZhY2Vfc3RhdGUoaW50ZXJmYWNlLCAxKTsKCWlmIChyZXQgPCAwKSB7CgkJcmV0
dXJuIC0xOwoJfQoJcmV0ID0gbmw4MDIxMV9qb2luX2lic3Mobmxtc2csIHNvY2ssIG5sODAyMTFf
ZmFtaWx5X2lkLCBpZmluZGV4LCBpYnNzX3Byb3BzLCBkb2ZhaWwpOwoJaWYgKHJldCA8IDApIHsK
CQlyZXR1cm4gLTE7Cgl9CglyZXR1cm4gMDsKfQoKc3RhdGljIGludCBod3NpbTgwMjExX2NyZWF0
ZV9kZXZpY2Uoc3RydWN0IG5sbXNnKiBubG1zZywgaW50IHNvY2ssIGludCBod3NpbV9mYW1pbHks
IHVpbnQ4X3QgbWFjX2FkZHJbRVRIX0FMRU5dKQp7CglzdHJ1Y3QgZ2VubG1zZ2hkciBnZW5saGRy
OwoJbWVtc2V0KCZnZW5saGRyLCAwLCBzaXplb2YoZ2VubGhkcikpOwoJZ2VubGhkci5jbWQgPSBI
V1NJTV9DTURfTkVXX1JBRElPOwoJbmV0bGlua19pbml0KG5sbXNnLCBod3NpbV9mYW1pbHksIDAs
ICZnZW5saGRyLCBzaXplb2YoZ2VubGhkcikpOwoJbmV0bGlua19hdHRyKG5sbXNnLCBIV1NJTV9B
VFRSX1NVUFBPUlRfUDJQX0RFVklDRSwgTlVMTCwgMCk7CgluZXRsaW5rX2F0dHIobmxtc2csIEhX
U0lNX0FUVFJfUEVSTV9BRERSLCBtYWNfYWRkciwgRVRIX0FMRU4pOwoJaW50IGVyciA9IG5ldGxp
bmtfc2VuZChubG1zZywgc29jayk7CglpZiAoZXJyIDwgMCkgewoJfQoJcmV0dXJuIGVycjsKfQoK
c3RhdGljIHZvaWQgaW5pdGlhbGl6ZV93aWZpX2RldmljZXModm9pZCkKewoJaW50IHJma2lsbCA9
IG9wZW4oIi9kZXYvcmZraWxsIiwgT19SRFdSKTsKCWlmIChyZmtpbGwgPT0gLTEpCglleGl0KDEp
OwoJc3RydWN0IHJma2lsbF9ldmVudCBldmVudCA9IHswfTsKCWV2ZW50LnR5cGUgPSBSRktJTExf
VFlQRV9BTEw7CglldmVudC5vcCA9IFJGS0lMTF9PUF9DSEFOR0VfQUxMOwoJaWYgKHdyaXRlKHJm
a2lsbCwgJmV2ZW50LCBzaXplb2YoZXZlbnQpKSAhPSAoc3NpemVfdCkoc2l6ZW9mKGV2ZW50KSkp
CglleGl0KDEpOwoJY2xvc2UocmZraWxsKTsKCXVpbnQ4X3QgbWFjX2FkZHJbNl0gPSBXSUZJX01B
Q19CQVNFOwoJaW50IHNvY2sgPSBzb2NrZXQoQUZfTkVUTElOSywgU09DS19SQVcsIE5FVExJTktf
R0VORVJJQyk7CglpZiAoc29jayA8IDApCglleGl0KDEpOwoJaW50IGh3c2ltX2ZhbWlseV9pZCA9
IG5ldGxpbmtfcXVlcnlfZmFtaWx5X2lkKCZubG1zZywgc29jaywgIk1BQzgwMjExX0hXU0lNIiwg
dHJ1ZSk7CglpbnQgbmw4MDIxMV9mYW1pbHlfaWQgPSBuZXRsaW5rX3F1ZXJ5X2ZhbWlseV9pZCgm
bmxtc2csIHNvY2ssICJubDgwMjExIiwgdHJ1ZSk7CglpZiAoaHdzaW1fZmFtaWx5X2lkIDwgMCB8
fCBubDgwMjExX2ZhbWlseV9pZCA8IDApCglleGl0KDEpOwoJdWludDhfdCBzc2lkW10gPSBXSUZJ
X0lCU1NfU1NJRDsKCXVpbnQ4X3QgYnNzaWRbXSA9IFdJRklfSUJTU19CU1NJRDsKCXN0cnVjdCBq
b2luX2lic3NfcHJvcHMgaWJzc19wcm9wcyA9IHsKCSAgICAud2lwaHlfZnJlcSA9IFdJRklfREVG
QVVMVF9GUkVRVUVOQ1ksIC53aXBoeV9mcmVxX2ZpeGVkID0gdHJ1ZSwgLm1hYyA9IGJzc2lkLCAu
c3NpZCA9IHNzaWQsIC5zc2lkX2xlbiA9IHNpemVvZihzc2lkKX07Cglmb3IgKGludCBkZXZpY2Vf
aWQgPSAwOyBkZXZpY2VfaWQgPCBXSUZJX0lOSVRJQUxfREVWSUNFX0NPVU5UOyBkZXZpY2VfaWQr
KykgewoJCW1hY19hZGRyWzVdID0gZGV2aWNlX2lkOwoJCWludCByZXQgPSBod3NpbTgwMjExX2Ny
ZWF0ZV9kZXZpY2UoJm5sbXNnLCBzb2NrLCBod3NpbV9mYW1pbHlfaWQsIG1hY19hZGRyKTsKCQlp
ZiAocmV0IDwgMCkKCWV4aXQoMSk7CgkJY2hhciBpbnRlcmZhY2VbNl0gPSAid2xhbjAiOwoJCWlu
dGVyZmFjZVs0XSArPSBkZXZpY2VfaWQ7CgkJaWYgKG5sODAyMTFfc2V0dXBfaWJzc19pbnRlcmZh
Y2UoJm5sbXNnLCBzb2NrLCBubDgwMjExX2ZhbWlseV9pZCwgaW50ZXJmYWNlLCAmaWJzc19wcm9w
cywgdHJ1ZSkgPCAwKQoJZXhpdCgxKTsKCX0KCWZvciAoaW50IGRldmljZV9pZCA9IDA7IGRldmlj
ZV9pZCA8IFdJRklfSU5JVElBTF9ERVZJQ0VfQ09VTlQ7IGRldmljZV9pZCsrKSB7CgkJY2hhciBp
bnRlcmZhY2VbNl0gPSAid2xhbjAiOwoJCWludGVyZmFjZVs0XSArPSBkZXZpY2VfaWQ7CgkJaW50
IHJldCA9IGF3YWl0X2lmbGFfb3BlcnN0YXRlKCZubG1zZywgaW50ZXJmYWNlLCBJRl9PUEVSX1VQ
LCB0cnVlKTsKCQlpZiAocmV0IDwgMCkKCWV4aXQoMSk7Cgl9CgljbG9zZShzb2NrKTsKfQoKc3Rh
dGljIGludCBydW5jbWRsaW5lKGNoYXIqIGNtZGxpbmUpCnsKCWludCByZXQgPSBzeXN0ZW0oY21k
bGluZSk7CglpZiAocmV0KSB7Cgl9CglyZXR1cm4gcmV0Owp9CgojZGVmaW5lIERFVl9JUFY0ICIx
NzIuMjAuMjAuJWQiCiNkZWZpbmUgREVWX0lQVjYgImZlODA6OiUwMngiCiNkZWZpbmUgREVWX01B
QyAweDAwYWFhYWFhYWFhYQoKc3RhdGljIHZvaWQgbmV0ZGV2c2ltX2FkZCh1bnNpZ25lZCBpbnQg
YWRkciwgdW5zaWduZWQgaW50IHBvcnRfY291bnQpCnsKCXdyaXRlX2ZpbGUoIi9zeXMvYnVzL25l
dGRldnNpbS9kZWxfZGV2aWNlIiwgIiV1IiwgYWRkcik7CglpZiAod3JpdGVfZmlsZSgiL3N5cy9i
dXMvbmV0ZGV2c2ltL25ld19kZXZpY2UiLCAiJXUgJXUiLCBhZGRyLCBwb3J0X2NvdW50KSkgewoJ
CWNoYXIgYnVmWzMyXTsKCQlzbnByaW50ZihidWYsIHNpemVvZihidWYpLCAibmV0ZGV2c2ltJWQi
LCBhZGRyKTsKCQlpbml0aWFsaXplX2RldmxpbmtfcG9ydHMoIm5ldGRldnNpbSIsIGJ1ZiwgIm5l
dGRldnNpbSIpOwoJfQp9CgojZGVmaW5lIFdHX0dFTkxfTkFNRSAid2lyZWd1YXJkIgplbnVtIHdn
X2NtZCB7CglXR19DTURfR0VUX0RFVklDRSwKCVdHX0NNRF9TRVRfREVWSUNFLAp9OwplbnVtIHdn
ZGV2aWNlX2F0dHJpYnV0ZSB7CglXR0RFVklDRV9BX1VOU1BFQywKCVdHREVWSUNFX0FfSUZJTkRF
WCwKCVdHREVWSUNFX0FfSUZOQU1FLAoJV0dERVZJQ0VfQV9QUklWQVRFX0tFWSwKCVdHREVWSUNF
X0FfUFVCTElDX0tFWSwKCVdHREVWSUNFX0FfRkxBR1MsCglXR0RFVklDRV9BX0xJU1RFTl9QT1JU
LAoJV0dERVZJQ0VfQV9GV01BUkssCglXR0RFVklDRV9BX1BFRVJTLAp9OwplbnVtIHdncGVlcl9h
dHRyaWJ1dGUgewoJV0dQRUVSX0FfVU5TUEVDLAoJV0dQRUVSX0FfUFVCTElDX0tFWSwKCVdHUEVF
Ul9BX1BSRVNIQVJFRF9LRVksCglXR1BFRVJfQV9GTEFHUywKCVdHUEVFUl9BX0VORFBPSU5ULAoJ
V0dQRUVSX0FfUEVSU0lTVEVOVF9LRUVQQUxJVkVfSU5URVJWQUwsCglXR1BFRVJfQV9MQVNUX0hB
TkRTSEFLRV9USU1FLAoJV0dQRUVSX0FfUlhfQllURVMsCglXR1BFRVJfQV9UWF9CWVRFUywKCVdH
UEVFUl9BX0FMTE9XRURJUFMsCglXR1BFRVJfQV9QUk9UT0NPTF9WRVJTSU9OLAp9OwplbnVtIHdn
YWxsb3dlZGlwX2F0dHJpYnV0ZSB7CglXR0FMTE9XRURJUF9BX1VOU1BFQywKCVdHQUxMT1dFRElQ
X0FfRkFNSUxZLAoJV0dBTExPV0VESVBfQV9JUEFERFIsCglXR0FMTE9XRURJUF9BX0NJRFJfTUFT
SywKfTsKCnN0YXRpYyB2b2lkIG5ldGxpbmtfd2lyZWd1YXJkX3NldHVwKHZvaWQpCnsKCWNvbnN0
IGNoYXIgaWZuYW1lX2FbXSA9ICJ3ZzAiOwoJY29uc3QgY2hhciBpZm5hbWVfYltdID0gIndnMSI7
Cgljb25zdCBjaGFyIGlmbmFtZV9jW10gPSAid2cyIjsKCWNvbnN0IGNoYXIgcHJpdmF0ZV9hW10g
PSAiXHhhMFx4NWNceGE4XHg0Zlx4NmNceDljXHg4ZVx4MzhceDUzXHhlMlx4ZmRceDdhXHg3MFx4
YWVceDBmXHhiMlx4MGZceGExXHg1Mlx4NjBceDBjXHhiMFx4MDhceDQ1XHgxN1x4NGZceDA4XHgw
N1x4NmZceDhkXHg3OFx4NDMiOwoJY29uc3QgY2hhciBwcml2YXRlX2JbXSA9ICJceGIwXHg4MFx4
NzNceGU4XHhkNFx4NGVceDkxXHhlM1x4ZGFceDkyXHgyY1x4MjJceDQzXHg4Mlx4NDRceGJiXHg4
OFx4NWNceDY5XHhlMlx4NjlceGM4XHhlOVx4ZDhceDM1XHhiMVx4MTRceDI5XHgzYVx4NGRceGRj
XHg2ZSI7Cgljb25zdCBjaGFyIHByaXZhdGVfY1tdID0gIlx4YTBceGNiXHg4N1x4OWFceDQ3XHhm
NVx4YmNceDY0XHg0Y1x4MGVceDY5XHgzZlx4YTZceGQwXHgzMVx4YzdceDRhXHgxNVx4NTNceGI2
XHhlOVx4MDFceGI5XHhmZlx4MmZceDUxXHg4Y1x4NzhceDA0XHgyZlx4YjVceDQyIjsKCWNvbnN0
IGNoYXIgcHVibGljX2FbXSA9ICJceDk3XHg1Y1x4OWRceDgxXHhjOVx4ODNceGM4XHgyMFx4OWVc
eGU3XHg4MVx4MjVceDRiXHg4OVx4OWZceDhlXHhkOVx4MjVceGFlXHg5Zlx4MDlceDIzXHhjMlx4
M2NceDYyXHhmNVx4M2NceDU3XHhjZFx4YmZceDY5XHgxYyI7Cgljb25zdCBjaGFyIHB1YmxpY19i
W10gPSAiXHhkMVx4NzNceDI4XHg5OVx4ZjZceDExXHhjZFx4ODlceDk0XHgwM1x4NGRceDdmXHg0
MVx4M2RceGM5XHg1N1x4NjNceDBlXHg1NFx4OTNceGMyXHg4NVx4YWNceGE0XHgwMFx4NjVceGNi
XHg2M1x4MTFceGJlXHg2OVx4NmIiOwoJY29uc3QgY2hhciBwdWJsaWNfY1tdID0gIlx4ZjRceDRk
XHhhM1x4NjdceGE4XHg4ZVx4ZTZceDU2XHg0Zlx4MDJceDAyXHgxMVx4NDVceDY3XHgyN1x4MDhc
eDJmXHg1Y1x4ZWJceGVlXHg4Ylx4MWJceGY1XHhlYlx4NzNceDM3XHgzNFx4MWJceDQ1XHg5Ylx4
MzlceDIyIjsKCWNvbnN0IHVpbnQxNl90IGxpc3Rlbl9hID0gMjAwMDE7Cgljb25zdCB1aW50MTZf
dCBsaXN0ZW5fYiA9IDIwMDAyOwoJY29uc3QgdWludDE2X3QgbGlzdGVuX2MgPSAyMDAwMzsKCWNv
bnN0IHVpbnQxNl90IGFmX2luZXQgPSBBRl9JTkVUOwoJY29uc3QgdWludDE2X3QgYWZfaW5ldDYg
PSBBRl9JTkVUNjsKCWNvbnN0IHN0cnVjdCBzb2NrYWRkcl9pbiBlbmRwb2ludF9iX3Y0ID0gewoJ
ICAgIC5zaW5fZmFtaWx5ID0gQUZfSU5FVCwKCSAgICAuc2luX3BvcnQgPSBodG9ucyhsaXN0ZW5f
YiksCgkgICAgLnNpbl9hZGRyID0ge2h0b25sKElOQUREUl9MT09QQkFDSyl9fTsKCWNvbnN0IHN0
cnVjdCBzb2NrYWRkcl9pbiBlbmRwb2ludF9jX3Y0ID0gewoJICAgIC5zaW5fZmFtaWx5ID0gQUZf
SU5FVCwKCSAgICAuc2luX3BvcnQgPSBodG9ucyhsaXN0ZW5fYyksCgkgICAgLnNpbl9hZGRyID0g
e2h0b25sKElOQUREUl9MT09QQkFDSyl9fTsKCXN0cnVjdCBzb2NrYWRkcl9pbjYgZW5kcG9pbnRf
YV92NiA9IHsKCSAgICAuc2luNl9mYW1pbHkgPSBBRl9JTkVUNiwKCSAgICAuc2luNl9wb3J0ID0g
aHRvbnMobGlzdGVuX2EpfTsKCWVuZHBvaW50X2FfdjYuc2luNl9hZGRyID0gaW42YWRkcl9sb29w
YmFjazsKCXN0cnVjdCBzb2NrYWRkcl9pbjYgZW5kcG9pbnRfY192NiA9IHsKCSAgICAuc2luNl9m
YW1pbHkgPSBBRl9JTkVUNiwKCSAgICAuc2luNl9wb3J0ID0gaHRvbnMobGlzdGVuX2MpfTsKCWVu
ZHBvaW50X2NfdjYuc2luNl9hZGRyID0gaW42YWRkcl9sb29wYmFjazsKCWNvbnN0IHN0cnVjdCBp
bl9hZGRyIGZpcnN0X2hhbGZfdjQgPSB7MH07Cgljb25zdCBzdHJ1Y3QgaW5fYWRkciBzZWNvbmRf
aGFsZl92NCA9IHsodWludDMyX3QpaHRvbmwoMTI4IDw8IDI0KX07Cgljb25zdCBzdHJ1Y3QgaW42
X2FkZHIgZmlyc3RfaGFsZl92NiA9IHt7ezB9fX07Cgljb25zdCBzdHJ1Y3QgaW42X2FkZHIgc2Vj
b25kX2hhbGZfdjYgPSB7e3sweDgwfX19OwoJY29uc3QgdWludDhfdCBoYWxmX2NpZHIgPSAxOwoJ
Y29uc3QgdWludDE2X3QgcGVyc2lzdGVudF9rZWVwYWxpdmVzW10gPSB7MSwgMywgNywgOSwgMTQs
IDE5fTsKCXN0cnVjdCBnZW5sbXNnaGRyIGdlbmxoZHIgPSB7CgkgICAgLmNtZCA9IFdHX0NNRF9T
RVRfREVWSUNFLAoJICAgIC52ZXJzaW9uID0gMX07CglpbnQgc29jazsKCWludCBpZCwgZXJyOwoJ
c29jayA9IHNvY2tldChBRl9ORVRMSU5LLCBTT0NLX1JBVywgTkVUTElOS19HRU5FUklDKTsKCWlm
IChzb2NrID09IC0xKSB7CgkJcmV0dXJuOwoJfQoJaWQgPSBuZXRsaW5rX3F1ZXJ5X2ZhbWlseV9p
ZCgmbmxtc2csIHNvY2ssIFdHX0dFTkxfTkFNRSwgdHJ1ZSk7CglpZiAoaWQgPT0gLTEpCgkJZ290
byBlcnJvcjsKCW5ldGxpbmtfaW5pdCgmbmxtc2csIGlkLCAwLCAmZ2VubGhkciwgc2l6ZW9mKGdl
bmxoZHIpKTsKCW5ldGxpbmtfYXR0cigmbmxtc2csIFdHREVWSUNFX0FfSUZOQU1FLCBpZm5hbWVf
YSwgc3RybGVuKGlmbmFtZV9hKSArIDEpOwoJbmV0bGlua19hdHRyKCZubG1zZywgV0dERVZJQ0Vf
QV9QUklWQVRFX0tFWSwgcHJpdmF0ZV9hLCAzMik7CgluZXRsaW5rX2F0dHIoJm5sbXNnLCBXR0RF
VklDRV9BX0xJU1RFTl9QT1JULCAmbGlzdGVuX2EsIDIpOwoJbmV0bGlua19uZXN0KCZubG1zZywg
TkxBX0ZfTkVTVEVEIHwgV0dERVZJQ0VfQV9QRUVSUyk7CgluZXRsaW5rX25lc3QoJm5sbXNnLCBO
TEFfRl9ORVNURUQgfCAwKTsKCW5ldGxpbmtfYXR0cigmbmxtc2csIFdHUEVFUl9BX1BVQkxJQ19L
RVksIHB1YmxpY19iLCAzMik7CgluZXRsaW5rX2F0dHIoJm5sbXNnLCBXR1BFRVJfQV9FTkRQT0lO
VCwgJmVuZHBvaW50X2JfdjQsIHNpemVvZihlbmRwb2ludF9iX3Y0KSk7CgluZXRsaW5rX2F0dHIo
Jm5sbXNnLCBXR1BFRVJfQV9QRVJTSVNURU5UX0tFRVBBTElWRV9JTlRFUlZBTCwgJnBlcnNpc3Rl
bnRfa2VlcGFsaXZlc1swXSwgMik7CgluZXRsaW5rX25lc3QoJm5sbXNnLCBOTEFfRl9ORVNURUQg
fCBXR1BFRVJfQV9BTExPV0VESVBTKTsKCW5ldGxpbmtfbmVzdCgmbmxtc2csIE5MQV9GX05FU1RF
RCB8IDApOwoJbmV0bGlua19hdHRyKCZubG1zZywgV0dBTExPV0VESVBfQV9GQU1JTFksICZhZl9p
bmV0LCAyKTsKCW5ldGxpbmtfYXR0cigmbmxtc2csIFdHQUxMT1dFRElQX0FfSVBBRERSLCAmZmly
c3RfaGFsZl92NCwgc2l6ZW9mKGZpcnN0X2hhbGZfdjQpKTsKCW5ldGxpbmtfYXR0cigmbmxtc2cs
IFdHQUxMT1dFRElQX0FfQ0lEUl9NQVNLLCAmaGFsZl9jaWRyLCAxKTsKCW5ldGxpbmtfZG9uZSgm
bmxtc2cpOwoJbmV0bGlua19uZXN0KCZubG1zZywgTkxBX0ZfTkVTVEVEIHwgMCk7CgluZXRsaW5r
X2F0dHIoJm5sbXNnLCBXR0FMTE9XRURJUF9BX0ZBTUlMWSwgJmFmX2luZXQ2LCAyKTsKCW5ldGxp
bmtfYXR0cigmbmxtc2csIFdHQUxMT1dFRElQX0FfSVBBRERSLCAmZmlyc3RfaGFsZl92Niwgc2l6
ZW9mKGZpcnN0X2hhbGZfdjYpKTsKCW5ldGxpbmtfYXR0cigmbmxtc2csIFdHQUxMT1dFRElQX0Ff
Q0lEUl9NQVNLLCAmaGFsZl9jaWRyLCAxKTsKCW5ldGxpbmtfZG9uZSgmbmxtc2cpOwoJbmV0bGlu
a19kb25lKCZubG1zZyk7CgluZXRsaW5rX2RvbmUoJm5sbXNnKTsKCW5ldGxpbmtfbmVzdCgmbmxt
c2csIE5MQV9GX05FU1RFRCB8IDApOwoJbmV0bGlua19hdHRyKCZubG1zZywgV0dQRUVSX0FfUFVC
TElDX0tFWSwgcHVibGljX2MsIDMyKTsKCW5ldGxpbmtfYXR0cigmbmxtc2csIFdHUEVFUl9BX0VO
RFBPSU5ULCAmZW5kcG9pbnRfY192Niwgc2l6ZW9mKGVuZHBvaW50X2NfdjYpKTsKCW5ldGxpbmtf
YXR0cigmbmxtc2csIFdHUEVFUl9BX1BFUlNJU1RFTlRfS0VFUEFMSVZFX0lOVEVSVkFMLCAmcGVy
c2lzdGVudF9rZWVwYWxpdmVzWzFdLCAyKTsKCW5ldGxpbmtfbmVzdCgmbmxtc2csIE5MQV9GX05F
U1RFRCB8IFdHUEVFUl9BX0FMTE9XRURJUFMpOwoJbmV0bGlua19uZXN0KCZubG1zZywgTkxBX0Zf
TkVTVEVEIHwgMCk7CgluZXRsaW5rX2F0dHIoJm5sbXNnLCBXR0FMTE9XRURJUF9BX0ZBTUlMWSwg
JmFmX2luZXQsIDIpOwoJbmV0bGlua19hdHRyKCZubG1zZywgV0dBTExPV0VESVBfQV9JUEFERFIs
ICZzZWNvbmRfaGFsZl92NCwgc2l6ZW9mKHNlY29uZF9oYWxmX3Y0KSk7CgluZXRsaW5rX2F0dHIo
Jm5sbXNnLCBXR0FMTE9XRURJUF9BX0NJRFJfTUFTSywgJmhhbGZfY2lkciwgMSk7CgluZXRsaW5r
X2RvbmUoJm5sbXNnKTsKCW5ldGxpbmtfbmVzdCgmbmxtc2csIE5MQV9GX05FU1RFRCB8IDApOwoJ
bmV0bGlua19hdHRyKCZubG1zZywgV0dBTExPV0VESVBfQV9GQU1JTFksICZhZl9pbmV0NiwgMik7
CgluZXRsaW5rX2F0dHIoJm5sbXNnLCBXR0FMTE9XRURJUF9BX0lQQUREUiwgJnNlY29uZF9oYWxm
X3Y2LCBzaXplb2Yoc2Vjb25kX2hhbGZfdjYpKTsKCW5ldGxpbmtfYXR0cigmbmxtc2csIFdHQUxM
T1dFRElQX0FfQ0lEUl9NQVNLLCAmaGFsZl9jaWRyLCAxKTsKCW5ldGxpbmtfZG9uZSgmbmxtc2cp
OwoJbmV0bGlua19kb25lKCZubG1zZyk7CgluZXRsaW5rX2RvbmUoJm5sbXNnKTsKCW5ldGxpbmtf
ZG9uZSgmbmxtc2cpOwoJZXJyID0gbmV0bGlua19zZW5kKCZubG1zZywgc29jayk7CglpZiAoZXJy
IDwgMCkgewoJfQoJbmV0bGlua19pbml0KCZubG1zZywgaWQsIDAsICZnZW5saGRyLCBzaXplb2Yo
Z2VubGhkcikpOwoJbmV0bGlua19hdHRyKCZubG1zZywgV0dERVZJQ0VfQV9JRk5BTUUsIGlmbmFt
ZV9iLCBzdHJsZW4oaWZuYW1lX2IpICsgMSk7CgluZXRsaW5rX2F0dHIoJm5sbXNnLCBXR0RFVklD
RV9BX1BSSVZBVEVfS0VZLCBwcml2YXRlX2IsIDMyKTsKCW5ldGxpbmtfYXR0cigmbmxtc2csIFdH
REVWSUNFX0FfTElTVEVOX1BPUlQsICZsaXN0ZW5fYiwgMik7CgluZXRsaW5rX25lc3QoJm5sbXNn
LCBOTEFfRl9ORVNURUQgfCBXR0RFVklDRV9BX1BFRVJTKTsKCW5ldGxpbmtfbmVzdCgmbmxtc2cs
IE5MQV9GX05FU1RFRCB8IDApOwoJbmV0bGlua19hdHRyKCZubG1zZywgV0dQRUVSX0FfUFVCTElD
X0tFWSwgcHVibGljX2EsIDMyKTsKCW5ldGxpbmtfYXR0cigmbmxtc2csIFdHUEVFUl9BX0VORFBP
SU5ULCAmZW5kcG9pbnRfYV92Niwgc2l6ZW9mKGVuZHBvaW50X2FfdjYpKTsKCW5ldGxpbmtfYXR0
cigmbmxtc2csIFdHUEVFUl9BX1BFUlNJU1RFTlRfS0VFUEFMSVZFX0lOVEVSVkFMLCAmcGVyc2lz
dGVudF9rZWVwYWxpdmVzWzJdLCAyKTsKCW5ldGxpbmtfbmVzdCgmbmxtc2csIE5MQV9GX05FU1RF
RCB8IFdHUEVFUl9BX0FMTE9XRURJUFMpOwoJbmV0bGlua19uZXN0KCZubG1zZywgTkxBX0ZfTkVT
VEVEIHwgMCk7CgluZXRsaW5rX2F0dHIoJm5sbXNnLCBXR0FMTE9XRURJUF9BX0ZBTUlMWSwgJmFm
X2luZXQsIDIpOwoJbmV0bGlua19hdHRyKCZubG1zZywgV0dBTExPV0VESVBfQV9JUEFERFIsICZm
aXJzdF9oYWxmX3Y0LCBzaXplb2YoZmlyc3RfaGFsZl92NCkpOwoJbmV0bGlua19hdHRyKCZubG1z
ZywgV0dBTExPV0VESVBfQV9DSURSX01BU0ssICZoYWxmX2NpZHIsIDEpOwoJbmV0bGlua19kb25l
KCZubG1zZyk7CgluZXRsaW5rX25lc3QoJm5sbXNnLCBOTEFfRl9ORVNURUQgfCAwKTsKCW5ldGxp
bmtfYXR0cigmbmxtc2csIFdHQUxMT1dFRElQX0FfRkFNSUxZLCAmYWZfaW5ldDYsIDIpOwoJbmV0
bGlua19hdHRyKCZubG1zZywgV0dBTExPV0VESVBfQV9JUEFERFIsICZmaXJzdF9oYWxmX3Y2LCBz
aXplb2YoZmlyc3RfaGFsZl92NikpOwoJbmV0bGlua19hdHRyKCZubG1zZywgV0dBTExPV0VESVBf
QV9DSURSX01BU0ssICZoYWxmX2NpZHIsIDEpOwoJbmV0bGlua19kb25lKCZubG1zZyk7CgluZXRs
aW5rX2RvbmUoJm5sbXNnKTsKCW5ldGxpbmtfZG9uZSgmbmxtc2cpOwoJbmV0bGlua19uZXN0KCZu
bG1zZywgTkxBX0ZfTkVTVEVEIHwgMCk7CgluZXRsaW5rX2F0dHIoJm5sbXNnLCBXR1BFRVJfQV9Q
VUJMSUNfS0VZLCBwdWJsaWNfYywgMzIpOwoJbmV0bGlua19hdHRyKCZubG1zZywgV0dQRUVSX0Ff
RU5EUE9JTlQsICZlbmRwb2ludF9jX3Y0LCBzaXplb2YoZW5kcG9pbnRfY192NCkpOwoJbmV0bGlu
a19hdHRyKCZubG1zZywgV0dQRUVSX0FfUEVSU0lTVEVOVF9LRUVQQUxJVkVfSU5URVJWQUwsICZw
ZXJzaXN0ZW50X2tlZXBhbGl2ZXNbM10sIDIpOwoJbmV0bGlua19uZXN0KCZubG1zZywgTkxBX0Zf
TkVTVEVEIHwgV0dQRUVSX0FfQUxMT1dFRElQUyk7CgluZXRsaW5rX25lc3QoJm5sbXNnLCBOTEFf
Rl9ORVNURUQgfCAwKTsKCW5ldGxpbmtfYXR0cigmbmxtc2csIFdHQUxMT1dFRElQX0FfRkFNSUxZ
LCAmYWZfaW5ldCwgMik7CgluZXRsaW5rX2F0dHIoJm5sbXNnLCBXR0FMTE9XRURJUF9BX0lQQURE
UiwgJnNlY29uZF9oYWxmX3Y0LCBzaXplb2Yoc2Vjb25kX2hhbGZfdjQpKTsKCW5ldGxpbmtfYXR0
cigmbmxtc2csIFdHQUxMT1dFRElQX0FfQ0lEUl9NQVNLLCAmaGFsZl9jaWRyLCAxKTsKCW5ldGxp
bmtfZG9uZSgmbmxtc2cpOwoJbmV0bGlua19uZXN0KCZubG1zZywgTkxBX0ZfTkVTVEVEIHwgMCk7
CgluZXRsaW5rX2F0dHIoJm5sbXNnLCBXR0FMTE9XRURJUF9BX0ZBTUlMWSwgJmFmX2luZXQ2LCAy
KTsKCW5ldGxpbmtfYXR0cigmbmxtc2csIFdHQUxMT1dFRElQX0FfSVBBRERSLCAmc2Vjb25kX2hh
bGZfdjYsIHNpemVvZihzZWNvbmRfaGFsZl92NikpOwoJbmV0bGlua19hdHRyKCZubG1zZywgV0dB
TExPV0VESVBfQV9DSURSX01BU0ssICZoYWxmX2NpZHIsIDEpOwoJbmV0bGlua19kb25lKCZubG1z
Zyk7CgluZXRsaW5rX2RvbmUoJm5sbXNnKTsKCW5ldGxpbmtfZG9uZSgmbmxtc2cpOwoJbmV0bGlu
a19kb25lKCZubG1zZyk7CgllcnIgPSBuZXRsaW5rX3NlbmQoJm5sbXNnLCBzb2NrKTsKCWlmIChl
cnIgPCAwKSB7Cgl9CgluZXRsaW5rX2luaXQoJm5sbXNnLCBpZCwgMCwgJmdlbmxoZHIsIHNpemVv
ZihnZW5saGRyKSk7CgluZXRsaW5rX2F0dHIoJm5sbXNnLCBXR0RFVklDRV9BX0lGTkFNRSwgaWZu
YW1lX2MsIHN0cmxlbihpZm5hbWVfYykgKyAxKTsKCW5ldGxpbmtfYXR0cigmbmxtc2csIFdHREVW
SUNFX0FfUFJJVkFURV9LRVksIHByaXZhdGVfYywgMzIpOwoJbmV0bGlua19hdHRyKCZubG1zZywg
V0dERVZJQ0VfQV9MSVNURU5fUE9SVCwgJmxpc3Rlbl9jLCAyKTsKCW5ldGxpbmtfbmVzdCgmbmxt
c2csIE5MQV9GX05FU1RFRCB8IFdHREVWSUNFX0FfUEVFUlMpOwoJbmV0bGlua19uZXN0KCZubG1z
ZywgTkxBX0ZfTkVTVEVEIHwgMCk7CgluZXRsaW5rX2F0dHIoJm5sbXNnLCBXR1BFRVJfQV9QVUJM
SUNfS0VZLCBwdWJsaWNfYSwgMzIpOwoJbmV0bGlua19hdHRyKCZubG1zZywgV0dQRUVSX0FfRU5E
UE9JTlQsICZlbmRwb2ludF9hX3Y2LCBzaXplb2YoZW5kcG9pbnRfYV92NikpOwoJbmV0bGlua19h
dHRyKCZubG1zZywgV0dQRUVSX0FfUEVSU0lTVEVOVF9LRUVQQUxJVkVfSU5URVJWQUwsICZwZXJz
aXN0ZW50X2tlZXBhbGl2ZXNbNF0sIDIpOwoJbmV0bGlua19uZXN0KCZubG1zZywgTkxBX0ZfTkVT
VEVEIHwgV0dQRUVSX0FfQUxMT1dFRElQUyk7CgluZXRsaW5rX25lc3QoJm5sbXNnLCBOTEFfRl9O
RVNURUQgfCAwKTsKCW5ldGxpbmtfYXR0cigmbmxtc2csIFdHQUxMT1dFRElQX0FfRkFNSUxZLCAm
YWZfaW5ldCwgMik7CgluZXRsaW5rX2F0dHIoJm5sbXNnLCBXR0FMTE9XRURJUF9BX0lQQUREUiwg
JmZpcnN0X2hhbGZfdjQsIHNpemVvZihmaXJzdF9oYWxmX3Y0KSk7CgluZXRsaW5rX2F0dHIoJm5s
bXNnLCBXR0FMTE9XRURJUF9BX0NJRFJfTUFTSywgJmhhbGZfY2lkciwgMSk7CgluZXRsaW5rX2Rv
bmUoJm5sbXNnKTsKCW5ldGxpbmtfbmVzdCgmbmxtc2csIE5MQV9GX05FU1RFRCB8IDApOwoJbmV0
bGlua19hdHRyKCZubG1zZywgV0dBTExPV0VESVBfQV9GQU1JTFksICZhZl9pbmV0NiwgMik7Cglu
ZXRsaW5rX2F0dHIoJm5sbXNnLCBXR0FMTE9XRURJUF9BX0lQQUREUiwgJmZpcnN0X2hhbGZfdjYs
IHNpemVvZihmaXJzdF9oYWxmX3Y2KSk7CgluZXRsaW5rX2F0dHIoJm5sbXNnLCBXR0FMTE9XRURJ
UF9BX0NJRFJfTUFTSywgJmhhbGZfY2lkciwgMSk7CgluZXRsaW5rX2RvbmUoJm5sbXNnKTsKCW5l
dGxpbmtfZG9uZSgmbmxtc2cpOwoJbmV0bGlua19kb25lKCZubG1zZyk7CgluZXRsaW5rX25lc3Qo
Jm5sbXNnLCBOTEFfRl9ORVNURUQgfCAwKTsKCW5ldGxpbmtfYXR0cigmbmxtc2csIFdHUEVFUl9B
X1BVQkxJQ19LRVksIHB1YmxpY19iLCAzMik7CgluZXRsaW5rX2F0dHIoJm5sbXNnLCBXR1BFRVJf
QV9FTkRQT0lOVCwgJmVuZHBvaW50X2JfdjQsIHNpemVvZihlbmRwb2ludF9iX3Y0KSk7CgluZXRs
aW5rX2F0dHIoJm5sbXNnLCBXR1BFRVJfQV9QRVJTSVNURU5UX0tFRVBBTElWRV9JTlRFUlZBTCwg
JnBlcnNpc3RlbnRfa2VlcGFsaXZlc1s1XSwgMik7CgluZXRsaW5rX25lc3QoJm5sbXNnLCBOTEFf
Rl9ORVNURUQgfCBXR1BFRVJfQV9BTExPV0VESVBTKTsKCW5ldGxpbmtfbmVzdCgmbmxtc2csIE5M
QV9GX05FU1RFRCB8IDApOwoJbmV0bGlua19hdHRyKCZubG1zZywgV0dBTExPV0VESVBfQV9GQU1J
TFksICZhZl9pbmV0LCAyKTsKCW5ldGxpbmtfYXR0cigmbmxtc2csIFdHQUxMT1dFRElQX0FfSVBB
RERSLCAmc2Vjb25kX2hhbGZfdjQsIHNpemVvZihzZWNvbmRfaGFsZl92NCkpOwoJbmV0bGlua19h
dHRyKCZubG1zZywgV0dBTExPV0VESVBfQV9DSURSX01BU0ssICZoYWxmX2NpZHIsIDEpOwoJbmV0
bGlua19kb25lKCZubG1zZyk7CgluZXRsaW5rX25lc3QoJm5sbXNnLCBOTEFfRl9ORVNURUQgfCAw
KTsKCW5ldGxpbmtfYXR0cigmbmxtc2csIFdHQUxMT1dFRElQX0FfRkFNSUxZLCAmYWZfaW5ldDYs
IDIpOwoJbmV0bGlua19hdHRyKCZubG1zZywgV0dBTExPV0VESVBfQV9JUEFERFIsICZzZWNvbmRf
aGFsZl92Niwgc2l6ZW9mKHNlY29uZF9oYWxmX3Y2KSk7CgluZXRsaW5rX2F0dHIoJm5sbXNnLCBX
R0FMTE9XRURJUF9BX0NJRFJfTUFTSywgJmhhbGZfY2lkciwgMSk7CgluZXRsaW5rX2RvbmUoJm5s
bXNnKTsKCW5ldGxpbmtfZG9uZSgmbmxtc2cpOwoJbmV0bGlua19kb25lKCZubG1zZyk7CgluZXRs
aW5rX2RvbmUoJm5sbXNnKTsKCWVyciA9IG5ldGxpbmtfc2VuZCgmbmxtc2csIHNvY2spOwoJaWYg
KGVyciA8IDApIHsKCX0KCmVycm9yOgoJY2xvc2Uoc29jayk7Cn0KCnN0YXRpYyB2b2lkIG5ldGxp
bmtfbmljdmZfc2V0dXAodm9pZCkKewoJY2hhciBjbWRsaW5lWzI1Nl07CglpZiAoIXZmX2ludGYu
cHBpZCkKCQlyZXR1cm47CglzcHJpbnRmKGNtZGxpbmUsICJuc2VudGVyIC10IDEgLW4gaXAgbGlu
ayBzZXQgJXMgbmV0bnMgJWQiLAoJCXZmX2ludGYucGFzc190aHJ1X2ludGYsIGdldHBpZCgpKTsK
CWlmIChydW5jbWRsaW5lKGNtZGxpbmUpKQoJZXhpdCgxKTsKCXNwcmludGYoY21kbGluZSwgImlw
IGEgcyAlcyIsIHZmX2ludGYucGFzc190aHJ1X2ludGYpOwoJaWYgKHJ1bmNtZGxpbmUoY21kbGlu
ZSkpCglleGl0KDEpOwoJc3ByaW50ZihjbWRsaW5lLCAiaXAgbGluayBzZXQgJXMgZG93biIsIHZm
X2ludGYucGFzc190aHJ1X2ludGYpOwoJaWYgKHJ1bmNtZGxpbmUoY21kbGluZSkpCglleGl0KDEp
OwoJc3ByaW50ZihjbWRsaW5lLCAiaXAgbGluayBzZXQgJXMgbmFtZSBuaWN2ZjAiLCB2Zl9pbnRm
LnBhc3NfdGhydV9pbnRmKTsKCWlmIChydW5jbWRsaW5lKGNtZGxpbmUpKQoJZXhpdCgxKTsKfQpz
dGF0aWMgdm9pZCBpbml0aWFsaXplX25ldGRldmljZXModm9pZCkKewoJY2hhciBuZXRkZXZzaW1b
MTZdOwoJc3ByaW50ZihuZXRkZXZzaW0sICJuZXRkZXZzaW0lZCIsIChpbnQpcHJvY2lkKTsKCXN0
cnVjdCB7CgkJY29uc3QgY2hhciogdHlwZTsKCQljb25zdCBjaGFyKiBkZXY7Cgl9IGRldnR5cGVz
W10gPSB7CgkgICAgeyJpcDZncmV0YXAiLCAiaXA2Z3JldGFwMCJ9LAoJICAgIHsiYnJpZGdlIiwg
ImJyaWRnZTAifSwKCSAgICB7InZjYW4iLCAidmNhbjAifSwKCSAgICB7ImJvbmQiLCAiYm9uZDAi
fSwKCSAgICB7InRlYW0iLCAidGVhbTAifSwKCSAgICB7ImR1bW15IiwgImR1bW15MCJ9LAoJICAg
IHsibmljdmYiLCAibmljdmYwIn0sCgkgICAgeyJubG1vbiIsICJubG1vbjAifSwKCSAgICB7ImNh
aWYiLCAiY2FpZjAifSwKCSAgICB7ImJhdGFkdiIsICJiYXRhZHYwIn0sCgkgICAgeyJ2eGNhbiIs
ICJ2eGNhbjEifSwKCSAgICB7InZldGgiLCAwfSwKCSAgICB7IndpcmVndWFyZCIsICJ3ZzAifSwK
CSAgICB7IndpcmVndWFyZCIsICJ3ZzEifSwKCSAgICB7IndpcmVndWFyZCIsICJ3ZzIifSwKCX07
Cgljb25zdCBjaGFyKiBkZXZtYXN0ZXJzW10gPSB7ImJyaWRnZSIsICJib25kIiwgInRlYW0iLCAi
YmF0YWR2In07CglzdHJ1Y3QgewoJCWNvbnN0IGNoYXIqIG5hbWU7CgkJaW50IG1hY3NpemU7CgkJ
Ym9vbCBub2lwdjY7Cgl9IGRldmljZXNbXSA9IHsKCSAgICB7ImxvIiwgRVRIX0FMRU59LAoJICAg
IHsic2l0MCIsIDB9LAoJICAgIHsiYnJpZGdlMCIsIEVUSF9BTEVOfSwKCSAgICB7InZjYW4wIiwg
MCwgdHJ1ZX0sCgkgICAgeyJ0dW5sMCIsIDB9LAoJICAgIHsiZ3JlMCIsIDB9LAoJICAgIHsiZ3Jl
dGFwMCIsIEVUSF9BTEVOfSwKCSAgICB7ImlwX3Z0aTAiLCAwfSwKCSAgICB7ImlwNl92dGkwIiwg
MH0sCgkgICAgeyJpcDZ0bmwwIiwgMH0sCgkgICAgeyJpcDZncmUwIiwgMH0sCgkgICAgeyJpcDZn
cmV0YXAwIiwgRVRIX0FMRU59LAoJICAgIHsiZXJzcGFuMCIsIEVUSF9BTEVOfSwKCSAgICB7ImJv
bmQwIiwgRVRIX0FMRU59LAoJICAgIHsidmV0aDAiLCBFVEhfQUxFTn0sCgkgICAgeyJ2ZXRoMSIs
IEVUSF9BTEVOfSwKCSAgICB7InRlYW0wIiwgRVRIX0FMRU59LAoJICAgIHsidmV0aDBfdG9fYnJp
ZGdlIiwgRVRIX0FMRU59LAoJICAgIHsidmV0aDFfdG9fYnJpZGdlIiwgRVRIX0FMRU59LAoJICAg
IHsidmV0aDBfdG9fYm9uZCIsIEVUSF9BTEVOfSwKCSAgICB7InZldGgxX3RvX2JvbmQiLCBFVEhf
QUxFTn0sCgkgICAgeyJ2ZXRoMF90b190ZWFtIiwgRVRIX0FMRU59LAoJICAgIHsidmV0aDFfdG9f
dGVhbSIsIEVUSF9BTEVOfSwKCSAgICB7InZldGgwX3RvX2hzciIsIEVUSF9BTEVOfSwKCSAgICB7
InZldGgxX3RvX2hzciIsIEVUSF9BTEVOfSwKCSAgICB7ImhzcjAiLCAwfSwKCSAgICB7ImR1bW15
MCIsIEVUSF9BTEVOfSwKCSAgICB7Im5pY3ZmMCIsIDAsIHRydWV9LAoJICAgIHsibmxtb24wIiwg
MH0sCgkgICAgeyJ2eGNhbjAiLCAwLCB0cnVlfSwKCSAgICB7InZ4Y2FuMSIsIDAsIHRydWV9LAoJ
ICAgIHsiY2FpZjAiLCBFVEhfQUxFTn0sCgkgICAgeyJiYXRhZHYwIiwgRVRIX0FMRU59LAoJICAg
IHtuZXRkZXZzaW0sIEVUSF9BTEVOfSwKCSAgICB7Inhmcm0wIiwgRVRIX0FMRU59LAoJICAgIHsi
dmV0aDBfdmlydF93aWZpIiwgRVRIX0FMRU59LAoJICAgIHsidmV0aDFfdmlydF93aWZpIiwgRVRI
X0FMRU59LAoJICAgIHsidmlydF93aWZpMCIsIEVUSF9BTEVOfSwKCSAgICB7InZldGgwX3ZsYW4i
LCBFVEhfQUxFTn0sCgkgICAgeyJ2ZXRoMV92bGFuIiwgRVRIX0FMRU59LAoJICAgIHsidmxhbjAi
LCBFVEhfQUxFTn0sCgkgICAgeyJ2bGFuMSIsIEVUSF9BTEVOfSwKCSAgICB7Im1hY3ZsYW4wIiwg
RVRIX0FMRU59LAoJICAgIHsibWFjdmxhbjEiLCBFVEhfQUxFTn0sCgkgICAgeyJpcHZsYW4wIiwg
RVRIX0FMRU59LAoJICAgIHsiaXB2bGFuMSIsIEVUSF9BTEVOfSwKCSAgICB7InZldGgwX21hY3Z0
YXAiLCBFVEhfQUxFTn0sCgkgICAgeyJ2ZXRoMV9tYWN2dGFwIiwgRVRIX0FMRU59LAoJICAgIHsi
bWFjdnRhcDAiLCBFVEhfQUxFTn0sCgkgICAgeyJtYWNzZWMwIiwgRVRIX0FMRU59LAoJICAgIHsi
dmV0aDBfdG9fYmF0YWR2IiwgRVRIX0FMRU59LAoJICAgIHsidmV0aDFfdG9fYmF0YWR2IiwgRVRI
X0FMRU59LAoJICAgIHsiYmF0YWR2X3NsYXZlXzAiLCBFVEhfQUxFTn0sCgkgICAgeyJiYXRhZHZf
c2xhdmVfMSIsIEVUSF9BTEVOfSwKCSAgICB7ImdlbmV2ZTAiLCBFVEhfQUxFTn0sCgkgICAgeyJn
ZW5ldmUxIiwgRVRIX0FMRU59LAoJICAgIHsid2cwIiwgMH0sCgkgICAgeyJ3ZzEiLCAwfSwKCSAg
ICB7IndnMiIsIDB9LAoJfTsKCWludCBzb2NrID0gc29ja2V0KEFGX05FVExJTkssIFNPQ0tfUkFX
LCBORVRMSU5LX1JPVVRFKTsKCWlmIChzb2NrID09IC0xKQoJZXhpdCgxKTsKCXVuc2lnbmVkIGk7
Cglmb3IgKGkgPSAwOyBpIDwgc2l6ZW9mKGRldnR5cGVzKSAvIHNpemVvZihkZXZ0eXBlc1swXSk7
IGkrKykKCQluZXRsaW5rX2FkZF9kZXZpY2UoJm5sbXNnLCBzb2NrLCBkZXZ0eXBlc1tpXS50eXBl
LCBkZXZ0eXBlc1tpXS5kZXYpOwoJZm9yIChpID0gMDsgaSA8IHNpemVvZihkZXZtYXN0ZXJzKSAv
IChzaXplb2YoZGV2bWFzdGVyc1swXSkpOyBpKyspIHsKCQljaGFyIG1hc3RlclszMl0sIHNsYXZl
MFszMl0sIHZldGgwWzMyXSwgc2xhdmUxWzMyXSwgdmV0aDFbMzJdOwoJCXNwcmludGYoc2xhdmUw
LCAiJXNfc2xhdmVfMCIsIGRldm1hc3RlcnNbaV0pOwoJCXNwcmludGYodmV0aDAsICJ2ZXRoMF90
b18lcyIsIGRldm1hc3RlcnNbaV0pOwoJCW5ldGxpbmtfYWRkX3ZldGgoJm5sbXNnLCBzb2NrLCBz
bGF2ZTAsIHZldGgwKTsKCQlzcHJpbnRmKHNsYXZlMSwgIiVzX3NsYXZlXzEiLCBkZXZtYXN0ZXJz
W2ldKTsKCQlzcHJpbnRmKHZldGgxLCAidmV0aDFfdG9fJXMiLCBkZXZtYXN0ZXJzW2ldKTsKCQlu
ZXRsaW5rX2FkZF92ZXRoKCZubG1zZywgc29jaywgc2xhdmUxLCB2ZXRoMSk7CgkJc3ByaW50Ziht
YXN0ZXIsICIlczAiLCBkZXZtYXN0ZXJzW2ldKTsKCQluZXRsaW5rX2RldmljZV9jaGFuZ2UoJm5s
bXNnLCBzb2NrLCBzbGF2ZTAsIGZhbHNlLCBtYXN0ZXIsIDAsIDAsIE5VTEwpOwoJCW5ldGxpbmtf
ZGV2aWNlX2NoYW5nZSgmbmxtc2csIHNvY2ssIHNsYXZlMSwgZmFsc2UsIG1hc3RlciwgMCwgMCwg
TlVMTCk7Cgl9CgluZXRsaW5rX2FkZF94ZnJtKCZubG1zZywgc29jaywgInhmcm0wIik7CgluZXRs
aW5rX2RldmljZV9jaGFuZ2UoJm5sbXNnLCBzb2NrLCAiYnJpZGdlX3NsYXZlXzAiLCB0cnVlLCAw
LCAwLCAwLCBOVUxMKTsKCW5ldGxpbmtfZGV2aWNlX2NoYW5nZSgmbmxtc2csIHNvY2ssICJicmlk
Z2Vfc2xhdmVfMSIsIHRydWUsIDAsIDAsIDAsIE5VTEwpOwoJbmV0bGlua19hZGRfdmV0aCgmbmxt
c2csIHNvY2ssICJoc3Jfc2xhdmVfMCIsICJ2ZXRoMF90b19oc3IiKTsKCW5ldGxpbmtfYWRkX3Zl
dGgoJm5sbXNnLCBzb2NrLCAiaHNyX3NsYXZlXzEiLCAidmV0aDFfdG9faHNyIik7CgluZXRsaW5r
X2FkZF9oc3IoJm5sbXNnLCBzb2NrLCAiaHNyMCIsICJoc3Jfc2xhdmVfMCIsICJoc3Jfc2xhdmVf
MSIpOwoJbmV0bGlua19kZXZpY2VfY2hhbmdlKCZubG1zZywgc29jaywgImhzcl9zbGF2ZV8wIiwg
dHJ1ZSwgMCwgMCwgMCwgTlVMTCk7CgluZXRsaW5rX2RldmljZV9jaGFuZ2UoJm5sbXNnLCBzb2Nr
LCAiaHNyX3NsYXZlXzEiLCB0cnVlLCAwLCAwLCAwLCBOVUxMKTsKCW5ldGxpbmtfYWRkX3ZldGgo
Jm5sbXNnLCBzb2NrLCAidmV0aDBfdmlydF93aWZpIiwgInZldGgxX3ZpcnRfd2lmaSIpOwoJbmV0
bGlua19hZGRfbGlua2VkKCZubG1zZywgc29jaywgInZpcnRfd2lmaSIsICJ2aXJ0X3dpZmkwIiwg
InZldGgxX3ZpcnRfd2lmaSIpOwoJbmV0bGlua19hZGRfdmV0aCgmbmxtc2csIHNvY2ssICJ2ZXRo
MF92bGFuIiwgInZldGgxX3ZsYW4iKTsKCW5ldGxpbmtfYWRkX3ZsYW4oJm5sbXNnLCBzb2NrLCAi
dmxhbjAiLCAidmV0aDBfdmxhbiIsIDAsIGh0b25zKEVUSF9QXzgwMjFRKSk7CgluZXRsaW5rX2Fk
ZF92bGFuKCZubG1zZywgc29jaywgInZsYW4xIiwgInZldGgwX3ZsYW4iLCAxLCBodG9ucyhFVEhf
UF84MDIxQUQpKTsKCW5ldGxpbmtfYWRkX21hY3ZsYW4oJm5sbXNnLCBzb2NrLCAibWFjdmxhbjAi
LCAidmV0aDFfdmxhbiIpOwoJbmV0bGlua19hZGRfbWFjdmxhbigmbmxtc2csIHNvY2ssICJtYWN2
bGFuMSIsICJ2ZXRoMV92bGFuIik7CgluZXRsaW5rX2FkZF9pcHZsYW4oJm5sbXNnLCBzb2NrLCAi
aXB2bGFuMCIsICJ2ZXRoMF92bGFuIiwgSVBWTEFOX01PREVfTDIsIDApOwoJbmV0bGlua19hZGRf
aXB2bGFuKCZubG1zZywgc29jaywgImlwdmxhbjEiLCAidmV0aDBfdmxhbiIsIElQVkxBTl9NT0RF
X0wzUywgSVBWTEFOX0ZfVkVQQSk7CgluZXRsaW5rX2FkZF92ZXRoKCZubG1zZywgc29jaywgInZl
dGgwX21hY3Z0YXAiLCAidmV0aDFfbWFjdnRhcCIpOwoJbmV0bGlua19hZGRfbGlua2VkKCZubG1z
Zywgc29jaywgIm1hY3Z0YXAiLCAibWFjdnRhcDAiLCAidmV0aDBfbWFjdnRhcCIpOwoJbmV0bGlu
a19hZGRfbGlua2VkKCZubG1zZywgc29jaywgIm1hY3NlYyIsICJtYWNzZWMwIiwgInZldGgxX21h
Y3Z0YXAiKTsKCWNoYXIgYWRkclszMl07CglzcHJpbnRmKGFkZHIsIERFVl9JUFY0LCAxNCArIDEw
KTsKCXN0cnVjdCBpbl9hZGRyIGdlbmV2ZV9hZGRyNDsKCWlmIChpbmV0X3B0b24oQUZfSU5FVCwg
YWRkciwgJmdlbmV2ZV9hZGRyNCkgPD0gMCkKCWV4aXQoMSk7CglzdHJ1Y3QgaW42X2FkZHIgZ2Vu
ZXZlX2FkZHI2OwoJaWYgKGluZXRfcHRvbihBRl9JTkVUNiwgImZjMDA6OjAxIiwgJmdlbmV2ZV9h
ZGRyNikgPD0gMCkKCWV4aXQoMSk7CgluZXRsaW5rX2FkZF9nZW5ldmUoJm5sbXNnLCBzb2NrLCAi
Z2VuZXZlMCIsIDAsICZnZW5ldmVfYWRkcjQsIDApOwoJbmV0bGlua19hZGRfZ2VuZXZlKCZubG1z
Zywgc29jaywgImdlbmV2ZTEiLCAxLCAwLCAmZ2VuZXZlX2FkZHI2KTsKCW5ldGRldnNpbV9hZGQo
KGludClwcm9jaWQsIDQpOwoJbmV0bGlua193aXJlZ3VhcmRfc2V0dXAoKTsKCW5ldGxpbmtfbmlj
dmZfc2V0dXAoKTsKCWZvciAoaSA9IDA7IGkgPCBzaXplb2YoZGV2aWNlcykgLyAoc2l6ZW9mKGRl
dmljZXNbMF0pKTsgaSsrKSB7CgkJY2hhciBhZGRyWzMyXTsKCQlzcHJpbnRmKGFkZHIsIERFVl9J
UFY0LCBpICsgMTApOwoJCW5ldGxpbmtfYWRkX2FkZHI0KCZubG1zZywgc29jaywgZGV2aWNlc1tp
XS5uYW1lLCBhZGRyKTsKCQlpZiAoIWRldmljZXNbaV0ubm9pcHY2KSB7CgkJCXNwcmludGYoYWRk
ciwgREVWX0lQVjYsIGkgKyAxMCk7CgkJCW5ldGxpbmtfYWRkX2FkZHI2KCZubG1zZywgc29jaywg
ZGV2aWNlc1tpXS5uYW1lLCBhZGRyKTsKCQl9CgkJdWludDY0X3QgbWFjYWRkciA9IERFVl9NQUMg
KyAoKGkgKyAxMHVsbCkgPDwgNDApOwoJCW5ldGxpbmtfZGV2aWNlX2NoYW5nZSgmbmxtc2csIHNv
Y2ssIGRldmljZXNbaV0ubmFtZSwgdHJ1ZSwgMCwgJm1hY2FkZHIsIGRldmljZXNbaV0ubWFjc2l6
ZSwgTlVMTCk7Cgl9CgljbG9zZShzb2NrKTsKfQpzdGF0aWMgdm9pZCBpbml0aWFsaXplX25ldGRl
dmljZXNfaW5pdCh2b2lkKQp7CglpbnQgc29jayA9IHNvY2tldChBRl9ORVRMSU5LLCBTT0NLX1JB
VywgTkVUTElOS19ST1VURSk7CglpZiAoc29jayA9PSAtMSkKCWV4aXQoMSk7CglzdHJ1Y3QgewoJ
CWNvbnN0IGNoYXIqIHR5cGU7CgkJaW50IG1hY3NpemU7CgkJYm9vbCBub2lwdjY7CgkJYm9vbCBu
b3VwOwoJfSBkZXZ0eXBlc1tdID0gewoJICAgIHsibnIiLCA3LCB0cnVlfSwKCSAgICB7InJvc2Ui
LCA1LCB0cnVlLCB0cnVlfSwKCX07Cgl1bnNpZ25lZCBpOwoJZm9yIChpID0gMDsgaSA8IHNpemVv
ZihkZXZ0eXBlcykgLyBzaXplb2YoZGV2dHlwZXNbMF0pOyBpKyspIHsKCQljaGFyIGRldlszMl0s
IGFkZHJbMzJdOwoJCXNwcmludGYoZGV2LCAiJXMlZCIsIGRldnR5cGVzW2ldLnR5cGUsIChpbnQp
cHJvY2lkKTsKCQlzcHJpbnRmKGFkZHIsICIxNzIuMzAuJWQuJWQiLCBpLCAoaW50KXByb2NpZCAr
IDEpOwoJCW5ldGxpbmtfYWRkX2FkZHI0KCZubG1zZywgc29jaywgZGV2LCBhZGRyKTsKCQlpZiAo
IWRldnR5cGVzW2ldLm5vaXB2NikgewoJCQlzcHJpbnRmKGFkZHIsICJmZTg4OjolMDJ4OiUwMngi
LCBpLCAoaW50KXByb2NpZCArIDEpOwoJCQluZXRsaW5rX2FkZF9hZGRyNigmbmxtc2csIHNvY2ss
IGRldiwgYWRkcik7CgkJfQoJCWludCBtYWNzaXplID0gZGV2dHlwZXNbaV0ubWFjc2l6ZTsKCQl1
aW50NjRfdCBtYWNhZGRyID0gMHhiYmJiYmIgKyAoKHVuc2lnbmVkIGxvbmcgbG9uZylpIDw8ICg4
ICogKG1hY3NpemUgLSAyKSkpICsKCQkJCSAocHJvY2lkIDw8ICg4ICogKG1hY3NpemUgLSAxKSkp
OwoJCW5ldGxpbmtfZGV2aWNlX2NoYW5nZSgmbmxtc2csIHNvY2ssIGRldiwgIWRldnR5cGVzW2ld
Lm5vdXAsIDAsICZtYWNhZGRyLCBtYWNzaXplLCBOVUxMKTsKCX0KCWNsb3NlKHNvY2spOwoJZmlu
ZF92Zl9pbnRlcmZhY2UoKTsKfQoKc3RhdGljIGludCByZWFkX3R1bihjaGFyKiBkYXRhLCBpbnQg
c2l6ZSkKewoJaWYgKHR1bmZkIDwgMCkKCQlyZXR1cm4gLTE7CglpbnQgcnYgPSByZWFkKHR1bmZk
LCBkYXRhLCBzaXplKTsKCWlmIChydiA8IDApIHsKCQlpZiAoZXJybm8gPT0gRUFHQUlOIHx8IGVy
cm5vID09IEVCQURGIHx8IGVycm5vID09IEVCQURGRCkKCQkJcmV0dXJuIC0xOwoJZXhpdCgxKTsK
CX0KCXJldHVybiBydjsKfQoKc3RhdGljIHZvaWQgZmx1c2hfdHVuKCkKewoJY2hhciBkYXRhWzEw
MDBdOwoJd2hpbGUgKHJlYWRfdHVuKCZkYXRhWzBdLCBzaXplb2YoZGF0YSkpICE9IC0xKSB7Cgl9
Cn0KCiNkZWZpbmUgTUFYX0ZEUyAzMAoKI2RlZmluZSBCVFBST1RPX0hDSSAxCiNkZWZpbmUgQUNM
X0xJTksgMQojZGVmaW5lIFNDQU5fUEFHRSAyCgp0eXBlZGVmIHN0cnVjdCB7Cgl1aW50OF90IGJb
Nl07Cn0gX19hdHRyaWJ1dGVfXygocGFja2VkKSkgYmRhZGRyX3Q7CgojZGVmaW5lIEhDSV9DT01N
QU5EX1BLVCAxCiNkZWZpbmUgSENJX0VWRU5UX1BLVCA0CiNkZWZpbmUgSENJX1ZFTkRPUl9QS1Qg
MHhmZgoKc3RydWN0IGhjaV9jb21tYW5kX2hkciB7Cgl1aW50MTZfdCBvcGNvZGU7Cgl1aW50OF90
IHBsZW47Cn0gX19hdHRyaWJ1dGVfXygocGFja2VkKSk7CgpzdHJ1Y3QgaGNpX2V2ZW50X2hkciB7
Cgl1aW50OF90IGV2dDsKCXVpbnQ4X3QgcGxlbjsKfSBfX2F0dHJpYnV0ZV9fKChwYWNrZWQpKTsK
CiNkZWZpbmUgSENJX0VWX0NPTk5fQ09NUExFVEUgMHgwMwpzdHJ1Y3QgaGNpX2V2X2Nvbm5fY29t
cGxldGUgewoJdWludDhfdCBzdGF0dXM7Cgl1aW50MTZfdCBoYW5kbGU7CgliZGFkZHJfdCBiZGFk
ZHI7Cgl1aW50OF90IGxpbmtfdHlwZTsKCXVpbnQ4X3QgZW5jcl9tb2RlOwp9IF9fYXR0cmlidXRl
X18oKHBhY2tlZCkpOwoKI2RlZmluZSBIQ0lfRVZfQ09OTl9SRVFVRVNUIDB4MDQKc3RydWN0IGhj
aV9ldl9jb25uX3JlcXVlc3QgewoJYmRhZGRyX3QgYmRhZGRyOwoJdWludDhfdCBkZXZfY2xhc3Nb
M107Cgl1aW50OF90IGxpbmtfdHlwZTsKfSBfX2F0dHJpYnV0ZV9fKChwYWNrZWQpKTsKCiNkZWZp
bmUgSENJX0VWX1JFTU9URV9GRUFUVVJFUyAweDBiCnN0cnVjdCBoY2lfZXZfcmVtb3RlX2ZlYXR1
cmVzIHsKCXVpbnQ4X3Qgc3RhdHVzOwoJdWludDE2X3QgaGFuZGxlOwoJdWludDhfdCBmZWF0dXJl
c1s4XTsKfSBfX2F0dHJpYnV0ZV9fKChwYWNrZWQpKTsKCiNkZWZpbmUgSENJX0VWX0NNRF9DT01Q
TEVURSAweDBlCnN0cnVjdCBoY2lfZXZfY21kX2NvbXBsZXRlIHsKCXVpbnQ4X3QgbmNtZDsKCXVp
bnQxNl90IG9wY29kZTsKfSBfX2F0dHJpYnV0ZV9fKChwYWNrZWQpKTsKCiNkZWZpbmUgSENJX09Q
X1dSSVRFX1NDQU5fRU5BQkxFIDB4MGMxYQoKI2RlZmluZSBIQ0lfT1BfUkVBRF9CVUZGRVJfU0la
RSAweDEwMDUKc3RydWN0IGhjaV9ycF9yZWFkX2J1ZmZlcl9zaXplIHsKCXVpbnQ4X3Qgc3RhdHVz
OwoJdWludDE2X3QgYWNsX210dTsKCXVpbnQ4X3Qgc2NvX210dTsKCXVpbnQxNl90IGFjbF9tYXhf
cGt0OwoJdWludDE2X3Qgc2NvX21heF9wa3Q7Cn0gX19hdHRyaWJ1dGVfXygocGFja2VkKSk7Cgoj
ZGVmaW5lIEhDSV9PUF9SRUFEX0JEX0FERFIgMHgxMDA5CnN0cnVjdCBoY2lfcnBfcmVhZF9iZF9h
ZGRyIHsKCXVpbnQ4X3Qgc3RhdHVzOwoJYmRhZGRyX3QgYmRhZGRyOwp9IF9fYXR0cmlidXRlX18o
KHBhY2tlZCkpOwoKI2RlZmluZSBIQ0lfRVZfTEVfTUVUQSAweDNlCnN0cnVjdCBoY2lfZXZfbGVf
bWV0YSB7Cgl1aW50OF90IHN1YmV2ZW50Owp9IF9fYXR0cmlidXRlX18oKHBhY2tlZCkpOwoKI2Rl
ZmluZSBIQ0lfRVZfTEVfQ09OTl9DT01QTEVURSAweDAxCnN0cnVjdCBoY2lfZXZfbGVfY29ubl9j
b21wbGV0ZSB7Cgl1aW50OF90IHN0YXR1czsKCXVpbnQxNl90IGhhbmRsZTsKCXVpbnQ4X3Qgcm9s
ZTsKCXVpbnQ4X3QgYmRhZGRyX3R5cGU7CgliZGFkZHJfdCBiZGFkZHI7Cgl1aW50MTZfdCBpbnRl
cnZhbDsKCXVpbnQxNl90IGxhdGVuY3k7Cgl1aW50MTZfdCBzdXBlcnZpc2lvbl90aW1lb3V0OwoJ
dWludDhfdCBjbGtfYWNjdXJhbmN5Owp9IF9fYXR0cmlidXRlX18oKHBhY2tlZCkpOwoKc3RydWN0
IGhjaV9kZXZfcmVxIHsKCXVpbnQxNl90IGRldl9pZDsKCXVpbnQzMl90IGRldl9vcHQ7Cn07Cgpz
dHJ1Y3QgdmhjaV92ZW5kb3JfcGt0X3JlcXVlc3QgewoJdWludDhfdCB0eXBlOwoJdWludDhfdCBv
cGNvZGU7Cn0gX19hdHRyaWJ1dGVfXygocGFja2VkKSk7CgpzdHJ1Y3QgdmhjaV9wa3QgewoJdWlu
dDhfdCB0eXBlOwoJdW5pb24gewoJCXN0cnVjdCB7CgkJCXVpbnQ4X3Qgb3Bjb2RlOwoJCQl1aW50
MTZfdCBpZDsKCQl9IF9fYXR0cmlidXRlX18oKHBhY2tlZCkpIHZlbmRvcl9wa3Q7CgkJc3RydWN0
IGhjaV9jb21tYW5kX2hkciBjb21tYW5kX2hkcjsKCX07Cn0gX19hdHRyaWJ1dGVfXygocGFja2Vk
KSk7CgojZGVmaW5lIEhDSURFVlVQIF9JT1coJ0gnLCAyMDEsIGludCkKI2RlZmluZSBIQ0lTRVRT
Q0FOIF9JT1coJ0gnLCAyMjEsIGludCkKCnN0YXRpYyBpbnQgdmhjaV9mZCA9IC0xOwoKc3RhdGlj
IHZvaWQgcmZraWxsX3VuYmxvY2tfYWxsKCkKewoJaW50IGZkID0gb3BlbigiL2Rldi9yZmtpbGwi
LCBPX1dST05MWSk7CglpZiAoZmQgPCAwKQoJZXhpdCgxKTsKCXN0cnVjdCByZmtpbGxfZXZlbnQg
ZXZlbnQgPSB7MH07CglldmVudC5pZHggPSAwOwoJZXZlbnQudHlwZSA9IFJGS0lMTF9UWVBFX0FM
TDsKCWV2ZW50Lm9wID0gUkZLSUxMX09QX0NIQU5HRV9BTEw7CglldmVudC5zb2Z0ID0gMDsKCWV2
ZW50LmhhcmQgPSAwOwoJaWYgKHdyaXRlKGZkLCAmZXZlbnQsIHNpemVvZihldmVudCkpIDwgMCkK
CWV4aXQoMSk7CgljbG9zZShmZCk7Cn0KCnN0YXRpYyB2b2lkIGhjaV9zZW5kX2V2ZW50X3BhY2tl
dChpbnQgZmQsIHVpbnQ4X3QgZXZ0LCB2b2lkKiBkYXRhLCBzaXplX3QgZGF0YV9sZW4pCnsKCXN0
cnVjdCBpb3ZlYyBpdlszXTsKCXN0cnVjdCBoY2lfZXZlbnRfaGRyIGhkcjsKCWhkci5ldnQgPSBl
dnQ7CgloZHIucGxlbiA9IGRhdGFfbGVuOwoJdWludDhfdCB0eXBlID0gSENJX0VWRU5UX1BLVDsK
CWl2WzBdLmlvdl9iYXNlID0gJnR5cGU7CglpdlswXS5pb3ZfbGVuID0gc2l6ZW9mKHR5cGUpOwoJ
aXZbMV0uaW92X2Jhc2UgPSAmaGRyOwoJaXZbMV0uaW92X2xlbiA9IHNpemVvZihoZHIpOwoJaXZb
Ml0uaW92X2Jhc2UgPSBkYXRhOwoJaXZbMl0uaW92X2xlbiA9IGRhdGFfbGVuOwoJaWYgKHdyaXRl
dihmZCwgaXYsIHNpemVvZihpdikgLyBzaXplb2Yoc3RydWN0IGlvdmVjKSkgPCAwKQoJZXhpdCgx
KTsKfQoKc3RhdGljIHZvaWQgaGNpX3NlbmRfZXZlbnRfY21kX2NvbXBsZXRlKGludCBmZCwgdWlu
dDE2X3Qgb3Bjb2RlLCB2b2lkKiBkYXRhLCBzaXplX3QgZGF0YV9sZW4pCnsKCXN0cnVjdCBpb3Zl
YyBpdls0XTsKCXN0cnVjdCBoY2lfZXZlbnRfaGRyIGhkcjsKCWhkci5ldnQgPSBIQ0lfRVZfQ01E
X0NPTVBMRVRFOwoJaGRyLnBsZW4gPSBzaXplb2Yoc3RydWN0IGhjaV9ldl9jbWRfY29tcGxldGUp
ICsgZGF0YV9sZW47CglzdHJ1Y3QgaGNpX2V2X2NtZF9jb21wbGV0ZSBldnRfaGRyOwoJZXZ0X2hk
ci5uY21kID0gMTsKCWV2dF9oZHIub3Bjb2RlID0gb3Bjb2RlOwoJdWludDhfdCB0eXBlID0gSENJ
X0VWRU5UX1BLVDsKCWl2WzBdLmlvdl9iYXNlID0gJnR5cGU7CglpdlswXS5pb3ZfbGVuID0gc2l6
ZW9mKHR5cGUpOwoJaXZbMV0uaW92X2Jhc2UgPSAmaGRyOwoJaXZbMV0uaW92X2xlbiA9IHNpemVv
ZihoZHIpOwoJaXZbMl0uaW92X2Jhc2UgPSAmZXZ0X2hkcjsKCWl2WzJdLmlvdl9sZW4gPSBzaXpl
b2YoZXZ0X2hkcik7CglpdlszXS5pb3ZfYmFzZSA9IGRhdGE7CglpdlszXS5pb3ZfbGVuID0gZGF0
YV9sZW47CglpZiAod3JpdGV2KGZkLCBpdiwgc2l6ZW9mKGl2KSAvIHNpemVvZihzdHJ1Y3QgaW92
ZWMpKSA8IDApCglleGl0KDEpOwp9CgpzdGF0aWMgYm9vbCBwcm9jZXNzX2NvbW1hbmRfcGt0KGlu
dCBmZCwgY2hhciogYnVmLCBzc2l6ZV90IGJ1Zl9zaXplKQp7CglzdHJ1Y3QgaGNpX2NvbW1hbmRf
aGRyKiBoZHIgPSAoc3RydWN0IGhjaV9jb21tYW5kX2hkciopYnVmOwoJaWYgKGJ1Zl9zaXplIDwg
KHNzaXplX3Qpc2l6ZW9mKHN0cnVjdCBoY2lfY29tbWFuZF9oZHIpIHx8CgkgICAgaGRyLT5wbGVu
ICE9IGJ1Zl9zaXplIC0gc2l6ZW9mKHN0cnVjdCBoY2lfY29tbWFuZF9oZHIpKQoJZXhpdCgxKTsK
CXN3aXRjaCAoaGRyLT5vcGNvZGUpIHsKCWNhc2UgSENJX09QX1dSSVRFX1NDQU5fRU5BQkxFOiB7
CgkJdWludDhfdCBzdGF0dXMgPSAwOwoJCWhjaV9zZW5kX2V2ZW50X2NtZF9jb21wbGV0ZShmZCwg
aGRyLT5vcGNvZGUsICZzdGF0dXMsIHNpemVvZihzdGF0dXMpKTsKCQlyZXR1cm4gdHJ1ZTsKCX0K
CWNhc2UgSENJX09QX1JFQURfQkRfQUREUjogewoJCXN0cnVjdCBoY2lfcnBfcmVhZF9iZF9hZGRy
IHJwID0gezB9OwoJCXJwLnN0YXR1cyA9IDA7CgkJbWVtc2V0KCZycC5iZGFkZHIsIDB4YWEsIDYp
OwoJCWhjaV9zZW5kX2V2ZW50X2NtZF9jb21wbGV0ZShmZCwgaGRyLT5vcGNvZGUsICZycCwgc2l6
ZW9mKHJwKSk7CgkJcmV0dXJuIGZhbHNlOwoJfQoJY2FzZSBIQ0lfT1BfUkVBRF9CVUZGRVJfU0la
RTogewoJCXN0cnVjdCBoY2lfcnBfcmVhZF9idWZmZXJfc2l6ZSBycCA9IHswfTsKCQlycC5zdGF0
dXMgPSAwOwoJCXJwLmFjbF9tdHUgPSAxMDIxOwoJCXJwLnNjb19tdHUgPSA5NjsKCQlycC5hY2xf
bWF4X3BrdCA9IDQ7CgkJcnAuc2NvX21heF9wa3QgPSA2OwoJCWhjaV9zZW5kX2V2ZW50X2NtZF9j
b21wbGV0ZShmZCwgaGRyLT5vcGNvZGUsICZycCwgc2l6ZW9mKHJwKSk7CgkJcmV0dXJuIGZhbHNl
OwoJfQoJfQoJY2hhciBkdW1teVsweGY5XSA9IHswfTsKCWhjaV9zZW5kX2V2ZW50X2NtZF9jb21w
bGV0ZShmZCwgaGRyLT5vcGNvZGUsIGR1bW15LCBzaXplb2YoZHVtbXkpKTsKCXJldHVybiBmYWxz
ZTsKfQoKc3RhdGljIHZvaWQqIGV2ZW50X3RocmVhZCh2b2lkKiBhcmcpCnsKCXdoaWxlICgxKSB7
CgkJY2hhciBidWZbMTAyNF0gPSB7MH07CgkJc3NpemVfdCBidWZfc2l6ZSA9IHJlYWQodmhjaV9m
ZCwgYnVmLCBzaXplb2YoYnVmKSk7CgkJaWYgKGJ1Zl9zaXplIDwgMCkKCWV4aXQoMSk7CgkJaWYg
KGJ1Zl9zaXplID4gMCAmJiBidWZbMF0gPT0gSENJX0NPTU1BTkRfUEtUKSB7CgkJCWlmIChwcm9j
ZXNzX2NvbW1hbmRfcGt0KHZoY2lfZmQsIGJ1ZiArIDEsIGJ1Zl9zaXplIC0gMSkpCgkJCQlicmVh
azsKCQl9Cgl9CglyZXR1cm4gTlVMTDsKfQojZGVmaW5lIEhDSV9IQU5ETEVfMSAyMDAKI2RlZmlu
ZSBIQ0lfSEFORExFXzIgMjAxCgojZGVmaW5lIEhDSV9QUklNQVJZIDAKI2RlZmluZSBIQ0lfT1Bf
UkVTRVQgMHgwYzAzCgpzdGF0aWMgdm9pZCBpbml0aWFsaXplX3ZoY2koKQp7CglpbnQgaGNpX3Nv
Y2sgPSBzb2NrZXQoQUZfQkxVRVRPT1RILCBTT0NLX1JBVywgQlRQUk9UT19IQ0kpOwoJaWYgKGhj
aV9zb2NrIDwgMCkKCWV4aXQoMSk7Cgl2aGNpX2ZkID0gb3BlbigiL2Rldi92aGNpIiwgT19SRFdS
KTsKCWlmICh2aGNpX2ZkID09IC0xKQoJZXhpdCgxKTsKCWNvbnN0IGludCBrVmhjaUZkID0gMjAy
OwoJaWYgKGR1cDIodmhjaV9mZCwga1ZoY2lGZCkgPCAwKQoJZXhpdCgxKTsKCWNsb3NlKHZoY2lf
ZmQpOwoJdmhjaV9mZCA9IGtWaGNpRmQ7CglzdHJ1Y3QgdmhjaV92ZW5kb3JfcGt0X3JlcXVlc3Qg
dmVuZG9yX3BrdF9yZXEgPSB7SENJX1ZFTkRPUl9QS1QsIEhDSV9QUklNQVJZfTsKCWlmICh3cml0
ZSh2aGNpX2ZkLCAmdmVuZG9yX3BrdF9yZXEsIHNpemVvZih2ZW5kb3JfcGt0X3JlcSkpICE9IHNp
emVvZih2ZW5kb3JfcGt0X3JlcSkpCglleGl0KDEpOwoJc3RydWN0IHZoY2lfcGt0IHZoY2lfcGt0
OwoJaWYgKHJlYWQodmhjaV9mZCwgJnZoY2lfcGt0LCBzaXplb2YodmhjaV9wa3QpKSAhPSBzaXpl
b2YodmhjaV9wa3QpKQoJZXhpdCgxKTsKCWlmICh2aGNpX3BrdC50eXBlID09IEhDSV9DT01NQU5E
X1BLVCAmJiB2aGNpX3BrdC5jb21tYW5kX2hkci5vcGNvZGUgPT0gSENJX09QX1JFU0VUKSB7CgkJ
Y2hhciByZXNwb25zZVsxXSA9IHswfTsKCQloY2lfc2VuZF9ldmVudF9jbWRfY29tcGxldGUodmhj
aV9mZCwgSENJX09QX1JFU0VULCByZXNwb25zZSwgc2l6ZW9mKHJlc3BvbnNlKSk7CgkJaWYgKHJl
YWQodmhjaV9mZCwgJnZoY2lfcGt0LCBzaXplb2YodmhjaV9wa3QpKSAhPSBzaXplb2YodmhjaV9w
a3QpKQoJZXhpdCgxKTsKCX0KCWlmICh2aGNpX3BrdC50eXBlICE9IEhDSV9WRU5ET1JfUEtUKQoJ
ZXhpdCgxKTsKCWludCBkZXZfaWQgPSB2aGNpX3BrdC52ZW5kb3JfcGt0LmlkOwoJcHRocmVhZF90
IHRoOwoJaWYgKHB0aHJlYWRfY3JlYXRlKCZ0aCwgTlVMTCwgZXZlbnRfdGhyZWFkLCBOVUxMKSkK
CWV4aXQoMSk7CglpbnQgcmV0ID0gaW9jdGwoaGNpX3NvY2ssIEhDSURFVlVQLCBkZXZfaWQpOwoJ
aWYgKHJldCkgewoJCWlmIChlcnJubyA9PSBFUkZLSUxMKSB7CgkJCXJma2lsbF91bmJsb2NrX2Fs
bCgpOwoJCQlyZXQgPSBpb2N0bChoY2lfc29jaywgSENJREVWVVAsIGRldl9pZCk7CgkJfQoJCWlm
IChyZXQgJiYgZXJybm8gIT0gRUFMUkVBRFkpCglleGl0KDEpOwoJfQoJc3RydWN0IGhjaV9kZXZf
cmVxIGRyID0gezB9OwoJZHIuZGV2X2lkID0gZGV2X2lkOwoJZHIuZGV2X29wdCA9IFNDQU5fUEFH
RTsKCWlmIChpb2N0bChoY2lfc29jaywgSENJU0VUU0NBTiwgJmRyKSkKCWV4aXQoMSk7CglzdHJ1
Y3QgaGNpX2V2X2Nvbm5fcmVxdWVzdCByZXF1ZXN0OwoJbWVtc2V0KCZyZXF1ZXN0LCAwLCBzaXpl
b2YocmVxdWVzdCkpOwoJbWVtc2V0KCZyZXF1ZXN0LmJkYWRkciwgMHhhYSwgNik7CgkqKHVpbnQ4
X3QqKSZyZXF1ZXN0LmJkYWRkci5iWzVdID0gMHgxMDsKCXJlcXVlc3QubGlua190eXBlID0gQUNM
X0xJTks7CgloY2lfc2VuZF9ldmVudF9wYWNrZXQodmhjaV9mZCwgSENJX0VWX0NPTk5fUkVRVUVT
VCwgJnJlcXVlc3QsIHNpemVvZihyZXF1ZXN0KSk7CglzdHJ1Y3QgaGNpX2V2X2Nvbm5fY29tcGxl
dGUgY29tcGxldGU7CgltZW1zZXQoJmNvbXBsZXRlLCAwLCBzaXplb2YoY29tcGxldGUpKTsKCWNv
bXBsZXRlLnN0YXR1cyA9IDA7Cgljb21wbGV0ZS5oYW5kbGUgPSBIQ0lfSEFORExFXzE7CgltZW1z
ZXQoJmNvbXBsZXRlLmJkYWRkciwgMHhhYSwgNik7CgkqKHVpbnQ4X3QqKSZjb21wbGV0ZS5iZGFk
ZHIuYls1XSA9IDB4MTA7Cgljb21wbGV0ZS5saW5rX3R5cGUgPSBBQ0xfTElOSzsKCWNvbXBsZXRl
LmVuY3JfbW9kZSA9IDA7CgloY2lfc2VuZF9ldmVudF9wYWNrZXQodmhjaV9mZCwgSENJX0VWX0NP
Tk5fQ09NUExFVEUsICZjb21wbGV0ZSwgc2l6ZW9mKGNvbXBsZXRlKSk7CglzdHJ1Y3QgaGNpX2V2
X3JlbW90ZV9mZWF0dXJlcyBmZWF0dXJlczsKCW1lbXNldCgmZmVhdHVyZXMsIDAsIHNpemVvZihm
ZWF0dXJlcykpOwoJZmVhdHVyZXMuc3RhdHVzID0gMDsKCWZlYXR1cmVzLmhhbmRsZSA9IEhDSV9I
QU5ETEVfMTsKCWhjaV9zZW5kX2V2ZW50X3BhY2tldCh2aGNpX2ZkLCBIQ0lfRVZfUkVNT1RFX0ZF
QVRVUkVTLCAmZmVhdHVyZXMsIHNpemVvZihmZWF0dXJlcykpOwoJc3RydWN0IHsKCQlzdHJ1Y3Qg
aGNpX2V2X2xlX21ldGEgbGVfbWV0YTsKCQlzdHJ1Y3QgaGNpX2V2X2xlX2Nvbm5fY29tcGxldGUg
bGVfY29ubjsKCX0gbGVfY29ubjsKCW1lbXNldCgmbGVfY29ubiwgMCwgc2l6ZW9mKGxlX2Nvbm4p
KTsKCWxlX2Nvbm4ubGVfbWV0YS5zdWJldmVudCA9IEhDSV9FVl9MRV9DT05OX0NPTVBMRVRFOwoJ
bWVtc2V0KCZsZV9jb25uLmxlX2Nvbm4uYmRhZGRyLCAweGFhLCA2KTsKCSoodWludDhfdCopJmxl
X2Nvbm4ubGVfY29ubi5iZGFkZHIuYls1XSA9IDB4MTE7CglsZV9jb25uLmxlX2Nvbm4ucm9sZSA9
IDE7CglsZV9jb25uLmxlX2Nvbm4uaGFuZGxlID0gSENJX0hBTkRMRV8yOwoJaGNpX3NlbmRfZXZl
bnRfcGFja2V0KHZoY2lfZmQsIEhDSV9FVl9MRV9NRVRBLCAmbGVfY29ubiwgc2l6ZW9mKGxlX2Nv
bm4pKTsKCXB0aHJlYWRfam9pbih0aCwgTlVMTCk7CgljbG9zZShoY2lfc29jayk7Cn0KCiNkZWZp
bmUgWFRfVEFCTEVfU0laRSAxNTM2CiNkZWZpbmUgWFRfTUFYX0VOVFJJRVMgMTAKCnN0cnVjdCB4
dF9jb3VudGVycyB7Cgl1aW50NjRfdCBwY250LCBiY250Owp9OwoKc3RydWN0IGlwdF9nZXRpbmZv
IHsKCWNoYXIgbmFtZVszMl07Cgl1bnNpZ25lZCBpbnQgdmFsaWRfaG9va3M7Cgl1bnNpZ25lZCBp
bnQgaG9va19lbnRyeVs1XTsKCXVuc2lnbmVkIGludCB1bmRlcmZsb3dbNV07Cgl1bnNpZ25lZCBp
bnQgbnVtX2VudHJpZXM7Cgl1bnNpZ25lZCBpbnQgc2l6ZTsKfTsKCnN0cnVjdCBpcHRfZ2V0X2Vu
dHJpZXMgewoJY2hhciBuYW1lWzMyXTsKCXVuc2lnbmVkIGludCBzaXplOwoJdWludDY0X3QgZW50
cnl0YWJsZVtYVF9UQUJMRV9TSVpFIC8gc2l6ZW9mKHVpbnQ2NF90KV07Cn07CgpzdHJ1Y3QgaXB0
X3JlcGxhY2UgewoJY2hhciBuYW1lWzMyXTsKCXVuc2lnbmVkIGludCB2YWxpZF9ob29rczsKCXVu
c2lnbmVkIGludCBudW1fZW50cmllczsKCXVuc2lnbmVkIGludCBzaXplOwoJdW5zaWduZWQgaW50
IGhvb2tfZW50cnlbNV07Cgl1bnNpZ25lZCBpbnQgdW5kZXJmbG93WzVdOwoJdW5zaWduZWQgaW50
IG51bV9jb3VudGVyczsKCXN0cnVjdCB4dF9jb3VudGVycyogY291bnRlcnM7Cgl1aW50NjRfdCBl
bnRyeXRhYmxlW1hUX1RBQkxFX1NJWkUgLyBzaXplb2YodWludDY0X3QpXTsKfTsKCnN0cnVjdCBp
cHRfdGFibGVfZGVzYyB7Cgljb25zdCBjaGFyKiBuYW1lOwoJc3RydWN0IGlwdF9nZXRpbmZvIGlu
Zm87CglzdHJ1Y3QgaXB0X3JlcGxhY2UgcmVwbGFjZTsKfTsKCnN0YXRpYyBzdHJ1Y3QgaXB0X3Rh
YmxlX2Rlc2MgaXB2NF90YWJsZXNbXSA9IHsKICAgIHsubmFtZSA9ICJmaWx0ZXIifSwKICAgIHsu
bmFtZSA9ICJuYXQifSwKICAgIHsubmFtZSA9ICJtYW5nbGUifSwKICAgIHsubmFtZSA9ICJyYXci
fSwKICAgIHsubmFtZSA9ICJzZWN1cml0eSJ9LAp9OwoKc3RhdGljIHN0cnVjdCBpcHRfdGFibGVf
ZGVzYyBpcHY2X3RhYmxlc1tdID0gewogICAgey5uYW1lID0gImZpbHRlciJ9LAogICAgey5uYW1l
ID0gIm5hdCJ9LAogICAgey5uYW1lID0gIm1hbmdsZSJ9LAogICAgey5uYW1lID0gInJhdyJ9LAog
ICAgey5uYW1lID0gInNlY3VyaXR5In0sCn07CgojZGVmaW5lIElQVF9CQVNFX0NUTCA2NAojZGVm
aW5lIElQVF9TT19TRVRfUkVQTEFDRSAoSVBUX0JBU0VfQ1RMKQojZGVmaW5lIElQVF9TT19HRVRf
SU5GTyAoSVBUX0JBU0VfQ1RMKQojZGVmaW5lIElQVF9TT19HRVRfRU5UUklFUyAoSVBUX0JBU0Vf
Q1RMICsgMSkKCnN0cnVjdCBhcnB0X2dldGluZm8gewoJY2hhciBuYW1lWzMyXTsKCXVuc2lnbmVk
IGludCB2YWxpZF9ob29rczsKCXVuc2lnbmVkIGludCBob29rX2VudHJ5WzNdOwoJdW5zaWduZWQg
aW50IHVuZGVyZmxvd1szXTsKCXVuc2lnbmVkIGludCBudW1fZW50cmllczsKCXVuc2lnbmVkIGlu
dCBzaXplOwp9OwoKc3RydWN0IGFycHRfZ2V0X2VudHJpZXMgewoJY2hhciBuYW1lWzMyXTsKCXVu
c2lnbmVkIGludCBzaXplOwoJdWludDY0X3QgZW50cnl0YWJsZVtYVF9UQUJMRV9TSVpFIC8gc2l6
ZW9mKHVpbnQ2NF90KV07Cn07CgpzdHJ1Y3QgYXJwdF9yZXBsYWNlIHsKCWNoYXIgbmFtZVszMl07
Cgl1bnNpZ25lZCBpbnQgdmFsaWRfaG9va3M7Cgl1bnNpZ25lZCBpbnQgbnVtX2VudHJpZXM7Cgl1
bnNpZ25lZCBpbnQgc2l6ZTsKCXVuc2lnbmVkIGludCBob29rX2VudHJ5WzNdOwoJdW5zaWduZWQg
aW50IHVuZGVyZmxvd1szXTsKCXVuc2lnbmVkIGludCBudW1fY291bnRlcnM7CglzdHJ1Y3QgeHRf
Y291bnRlcnMqIGNvdW50ZXJzOwoJdWludDY0X3QgZW50cnl0YWJsZVtYVF9UQUJMRV9TSVpFIC8g
c2l6ZW9mKHVpbnQ2NF90KV07Cn07CgpzdHJ1Y3QgYXJwdF90YWJsZV9kZXNjIHsKCWNvbnN0IGNo
YXIqIG5hbWU7CglzdHJ1Y3QgYXJwdF9nZXRpbmZvIGluZm87CglzdHJ1Y3QgYXJwdF9yZXBsYWNl
IHJlcGxhY2U7Cn07CgpzdGF0aWMgc3RydWN0IGFycHRfdGFibGVfZGVzYyBhcnB0X3RhYmxlc1td
ID0gewogICAgey5uYW1lID0gImZpbHRlciJ9LAp9OwoKI2RlZmluZSBBUlBUX0JBU0VfQ1RMIDk2
CiNkZWZpbmUgQVJQVF9TT19TRVRfUkVQTEFDRSAoQVJQVF9CQVNFX0NUTCkKI2RlZmluZSBBUlBU
X1NPX0dFVF9JTkZPIChBUlBUX0JBU0VfQ1RMKQojZGVmaW5lIEFSUFRfU09fR0VUX0VOVFJJRVMg
KEFSUFRfQkFTRV9DVEwgKyAxKQoKc3RhdGljIHZvaWQgY2hlY2twb2ludF9pcHRhYmxlcyhzdHJ1
Y3QgaXB0X3RhYmxlX2Rlc2MqIHRhYmxlcywgaW50IG51bV90YWJsZXMsIGludCBmYW1pbHksIGlu
dCBsZXZlbCkKewoJaW50IGZkID0gc29ja2V0KGZhbWlseSwgU09DS19TVFJFQU0sIElQUFJPVE9f
VENQKTsKCWlmIChmZCA9PSAtMSkgewoJCXN3aXRjaCAoZXJybm8pIHsKCQljYXNlIEVBRk5PU1VQ
UE9SVDoKCQljYXNlIEVOT1BST1RPT1BUOgoJCWNhc2UgRU5PRU5UOgoJCQlyZXR1cm47CgkJfQoJ
ZXhpdCgxKTsKCX0KCWZvciAoaW50IGkgPSAwOyBpIDwgbnVtX3RhYmxlczsgaSsrKSB7CgkJc3Ry
dWN0IGlwdF90YWJsZV9kZXNjKiB0YWJsZSA9ICZ0YWJsZXNbaV07CgkJc3RyY3B5KHRhYmxlLT5p
bmZvLm5hbWUsIHRhYmxlLT5uYW1lKTsKCQlzdHJjcHkodGFibGUtPnJlcGxhY2UubmFtZSwgdGFi
bGUtPm5hbWUpOwoJCXNvY2tsZW5fdCBvcHRsZW4gPSBzaXplb2YodGFibGUtPmluZm8pOwoJCWlm
IChnZXRzb2Nrb3B0KGZkLCBsZXZlbCwgSVBUX1NPX0dFVF9JTkZPLCAmdGFibGUtPmluZm8sICZv
cHRsZW4pKSB7CgkJCXN3aXRjaCAoZXJybm8pIHsKCQkJY2FzZSBFUEVSTToKCQkJY2FzZSBFTk9F
TlQ6CgkJCWNhc2UgRU5PUFJPVE9PUFQ6CgkJCQljb250aW51ZTsKCQkJfQoJZXhpdCgxKTsKCQl9
CgkJaWYgKHRhYmxlLT5pbmZvLnNpemUgPiBzaXplb2YodGFibGUtPnJlcGxhY2UuZW50cnl0YWJs
ZSkpCglleGl0KDEpOwoJCWlmICh0YWJsZS0+aW5mby5udW1fZW50cmllcyA+IFhUX01BWF9FTlRS
SUVTKQoJZXhpdCgxKTsKCQlzdHJ1Y3QgaXB0X2dldF9lbnRyaWVzIGVudHJpZXM7CgkJbWVtc2V0
KCZlbnRyaWVzLCAwLCBzaXplb2YoZW50cmllcykpOwoJCXN0cmNweShlbnRyaWVzLm5hbWUsIHRh
YmxlLT5uYW1lKTsKCQllbnRyaWVzLnNpemUgPSB0YWJsZS0+aW5mby5zaXplOwoJCW9wdGxlbiA9
IHNpemVvZihlbnRyaWVzKSAtIHNpemVvZihlbnRyaWVzLmVudHJ5dGFibGUpICsgdGFibGUtPmlu
Zm8uc2l6ZTsKCQlpZiAoZ2V0c29ja29wdChmZCwgbGV2ZWwsIElQVF9TT19HRVRfRU5UUklFUywg
JmVudHJpZXMsICZvcHRsZW4pKQoJZXhpdCgxKTsKCQl0YWJsZS0+cmVwbGFjZS52YWxpZF9ob29r
cyA9IHRhYmxlLT5pbmZvLnZhbGlkX2hvb2tzOwoJCXRhYmxlLT5yZXBsYWNlLm51bV9lbnRyaWVz
ID0gdGFibGUtPmluZm8ubnVtX2VudHJpZXM7CgkJdGFibGUtPnJlcGxhY2Uuc2l6ZSA9IHRhYmxl
LT5pbmZvLnNpemU7CgkJbWVtY3B5KHRhYmxlLT5yZXBsYWNlLmhvb2tfZW50cnksIHRhYmxlLT5p
bmZvLmhvb2tfZW50cnksIHNpemVvZih0YWJsZS0+cmVwbGFjZS5ob29rX2VudHJ5KSk7CgkJbWVt
Y3B5KHRhYmxlLT5yZXBsYWNlLnVuZGVyZmxvdywgdGFibGUtPmluZm8udW5kZXJmbG93LCBzaXpl
b2YodGFibGUtPnJlcGxhY2UudW5kZXJmbG93KSk7CgkJbWVtY3B5KHRhYmxlLT5yZXBsYWNlLmVu
dHJ5dGFibGUsIGVudHJpZXMuZW50cnl0YWJsZSwgdGFibGUtPmluZm8uc2l6ZSk7Cgl9CgljbG9z
ZShmZCk7Cn0KCnN0YXRpYyB2b2lkIHJlc2V0X2lwdGFibGVzKHN0cnVjdCBpcHRfdGFibGVfZGVz
YyogdGFibGVzLCBpbnQgbnVtX3RhYmxlcywgaW50IGZhbWlseSwgaW50IGxldmVsKQp7CglpbnQg
ZmQgPSBzb2NrZXQoZmFtaWx5LCBTT0NLX1NUUkVBTSwgSVBQUk9UT19UQ1ApOwoJaWYgKGZkID09
IC0xKSB7CgkJc3dpdGNoIChlcnJubykgewoJCWNhc2UgRUFGTk9TVVBQT1JUOgoJCWNhc2UgRU5P
UFJPVE9PUFQ6CgkJY2FzZSBFTk9FTlQ6CgkJCXJldHVybjsKCQl9CglleGl0KDEpOwoJfQoJZm9y
IChpbnQgaSA9IDA7IGkgPCBudW1fdGFibGVzOyBpKyspIHsKCQlzdHJ1Y3QgaXB0X3RhYmxlX2Rl
c2MqIHRhYmxlID0gJnRhYmxlc1tpXTsKCQlpZiAodGFibGUtPmluZm8udmFsaWRfaG9va3MgPT0g
MCkKCQkJY29udGludWU7CgkJc3RydWN0IGlwdF9nZXRpbmZvIGluZm87CgkJbWVtc2V0KCZpbmZv
LCAwLCBzaXplb2YoaW5mbykpOwoJCXN0cmNweShpbmZvLm5hbWUsIHRhYmxlLT5uYW1lKTsKCQlz
b2NrbGVuX3Qgb3B0bGVuID0gc2l6ZW9mKGluZm8pOwoJCWlmIChnZXRzb2Nrb3B0KGZkLCBsZXZl
bCwgSVBUX1NPX0dFVF9JTkZPLCAmaW5mbywgJm9wdGxlbikpCglleGl0KDEpOwoJCWlmIChtZW1j
bXAoJnRhYmxlLT5pbmZvLCAmaW5mbywgc2l6ZW9mKHRhYmxlLT5pbmZvKSkgPT0gMCkgewoJCQlz
dHJ1Y3QgaXB0X2dldF9lbnRyaWVzIGVudHJpZXM7CgkJCW1lbXNldCgmZW50cmllcywgMCwgc2l6
ZW9mKGVudHJpZXMpKTsKCQkJc3RyY3B5KGVudHJpZXMubmFtZSwgdGFibGUtPm5hbWUpOwoJCQll
bnRyaWVzLnNpemUgPSB0YWJsZS0+aW5mby5zaXplOwoJCQlvcHRsZW4gPSBzaXplb2YoZW50cmll
cykgLSBzaXplb2YoZW50cmllcy5lbnRyeXRhYmxlKSArIGVudHJpZXMuc2l6ZTsKCQkJaWYgKGdl
dHNvY2tvcHQoZmQsIGxldmVsLCBJUFRfU09fR0VUX0VOVFJJRVMsICZlbnRyaWVzLCAmb3B0bGVu
KSkKCWV4aXQoMSk7CgkJCWlmIChtZW1jbXAodGFibGUtPnJlcGxhY2UuZW50cnl0YWJsZSwgZW50
cmllcy5lbnRyeXRhYmxlLCB0YWJsZS0+aW5mby5zaXplKSA9PSAwKQoJCQkJY29udGludWU7CgkJ
fQoJCXN0cnVjdCB4dF9jb3VudGVycyBjb3VudGVyc1tYVF9NQVhfRU5UUklFU107CgkJdGFibGUt
PnJlcGxhY2UubnVtX2NvdW50ZXJzID0gaW5mby5udW1fZW50cmllczsKCQl0YWJsZS0+cmVwbGFj
ZS5jb3VudGVycyA9IGNvdW50ZXJzOwoJCW9wdGxlbiA9IHNpemVvZih0YWJsZS0+cmVwbGFjZSkg
LSBzaXplb2YodGFibGUtPnJlcGxhY2UuZW50cnl0YWJsZSkgKyB0YWJsZS0+cmVwbGFjZS5zaXpl
OwoJCWlmIChzZXRzb2Nrb3B0KGZkLCBsZXZlbCwgSVBUX1NPX1NFVF9SRVBMQUNFLCAmdGFibGUt
PnJlcGxhY2UsIG9wdGxlbikpCglleGl0KDEpOwoJfQoJY2xvc2UoZmQpOwp9CgpzdGF0aWMgdm9p
ZCBjaGVja3BvaW50X2FycHRhYmxlcyh2b2lkKQp7CglpbnQgZmQgPSBzb2NrZXQoQUZfSU5FVCwg
U09DS19TVFJFQU0sIElQUFJPVE9fVENQKTsKCWlmIChmZCA9PSAtMSkgewoJCXN3aXRjaCAoZXJy
bm8pIHsKCQljYXNlIEVBRk5PU1VQUE9SVDoKCQljYXNlIEVOT1BST1RPT1BUOgoJCWNhc2UgRU5P
RU5UOgoJCQlyZXR1cm47CgkJfQoJZXhpdCgxKTsKCX0KCWZvciAodW5zaWduZWQgaSA9IDA7IGkg
PCBzaXplb2YoYXJwdF90YWJsZXMpIC8gc2l6ZW9mKGFycHRfdGFibGVzWzBdKTsgaSsrKSB7CgkJ
c3RydWN0IGFycHRfdGFibGVfZGVzYyogdGFibGUgPSAmYXJwdF90YWJsZXNbaV07CgkJc3RyY3B5
KHRhYmxlLT5pbmZvLm5hbWUsIHRhYmxlLT5uYW1lKTsKCQlzdHJjcHkodGFibGUtPnJlcGxhY2Uu
bmFtZSwgdGFibGUtPm5hbWUpOwoJCXNvY2tsZW5fdCBvcHRsZW4gPSBzaXplb2YodGFibGUtPmlu
Zm8pOwoJCWlmIChnZXRzb2Nrb3B0KGZkLCBTT0xfSVAsIEFSUFRfU09fR0VUX0lORk8sICZ0YWJs
ZS0+aW5mbywgJm9wdGxlbikpIHsKCQkJc3dpdGNoIChlcnJubykgewoJCQljYXNlIEVQRVJNOgoJ
CQljYXNlIEVOT0VOVDoKCQkJY2FzZSBFTk9QUk9UT09QVDoKCQkJCWNvbnRpbnVlOwoJCQl9Cgll
eGl0KDEpOwoJCX0KCQlpZiAodGFibGUtPmluZm8uc2l6ZSA+IHNpemVvZih0YWJsZS0+cmVwbGFj
ZS5lbnRyeXRhYmxlKSkKCWV4aXQoMSk7CgkJaWYgKHRhYmxlLT5pbmZvLm51bV9lbnRyaWVzID4g
WFRfTUFYX0VOVFJJRVMpCglleGl0KDEpOwoJCXN0cnVjdCBhcnB0X2dldF9lbnRyaWVzIGVudHJp
ZXM7CgkJbWVtc2V0KCZlbnRyaWVzLCAwLCBzaXplb2YoZW50cmllcykpOwoJCXN0cmNweShlbnRy
aWVzLm5hbWUsIHRhYmxlLT5uYW1lKTsKCQllbnRyaWVzLnNpemUgPSB0YWJsZS0+aW5mby5zaXpl
OwoJCW9wdGxlbiA9IHNpemVvZihlbnRyaWVzKSAtIHNpemVvZihlbnRyaWVzLmVudHJ5dGFibGUp
ICsgdGFibGUtPmluZm8uc2l6ZTsKCQlpZiAoZ2V0c29ja29wdChmZCwgU09MX0lQLCBBUlBUX1NP
X0dFVF9FTlRSSUVTLCAmZW50cmllcywgJm9wdGxlbikpCglleGl0KDEpOwoJCXRhYmxlLT5yZXBs
YWNlLnZhbGlkX2hvb2tzID0gdGFibGUtPmluZm8udmFsaWRfaG9va3M7CgkJdGFibGUtPnJlcGxh
Y2UubnVtX2VudHJpZXMgPSB0YWJsZS0+aW5mby5udW1fZW50cmllczsKCQl0YWJsZS0+cmVwbGFj
ZS5zaXplID0gdGFibGUtPmluZm8uc2l6ZTsKCQltZW1jcHkodGFibGUtPnJlcGxhY2UuaG9va19l
bnRyeSwgdGFibGUtPmluZm8uaG9va19lbnRyeSwgc2l6ZW9mKHRhYmxlLT5yZXBsYWNlLmhvb2tf
ZW50cnkpKTsKCQltZW1jcHkodGFibGUtPnJlcGxhY2UudW5kZXJmbG93LCB0YWJsZS0+aW5mby51
bmRlcmZsb3csIHNpemVvZih0YWJsZS0+cmVwbGFjZS51bmRlcmZsb3cpKTsKCQltZW1jcHkodGFi
bGUtPnJlcGxhY2UuZW50cnl0YWJsZSwgZW50cmllcy5lbnRyeXRhYmxlLCB0YWJsZS0+aW5mby5z
aXplKTsKCX0KCWNsb3NlKGZkKTsKfQoKc3RhdGljIHZvaWQgcmVzZXRfYXJwdGFibGVzKCkKewoJ
aW50IGZkID0gc29ja2V0KEFGX0lORVQsIFNPQ0tfU1RSRUFNLCBJUFBST1RPX1RDUCk7CglpZiAo
ZmQgPT0gLTEpIHsKCQlzd2l0Y2ggKGVycm5vKSB7CgkJY2FzZSBFQUZOT1NVUFBPUlQ6CgkJY2Fz
ZSBFTk9QUk9UT09QVDoKCQljYXNlIEVOT0VOVDoKCQkJcmV0dXJuOwoJCX0KCWV4aXQoMSk7Cgl9
Cglmb3IgKHVuc2lnbmVkIGkgPSAwOyBpIDwgc2l6ZW9mKGFycHRfdGFibGVzKSAvIHNpemVvZihh
cnB0X3RhYmxlc1swXSk7IGkrKykgewoJCXN0cnVjdCBhcnB0X3RhYmxlX2Rlc2MqIHRhYmxlID0g
JmFycHRfdGFibGVzW2ldOwoJCWlmICh0YWJsZS0+aW5mby52YWxpZF9ob29rcyA9PSAwKQoJCQlj
b250aW51ZTsKCQlzdHJ1Y3QgYXJwdF9nZXRpbmZvIGluZm87CgkJbWVtc2V0KCZpbmZvLCAwLCBz
aXplb2YoaW5mbykpOwoJCXN0cmNweShpbmZvLm5hbWUsIHRhYmxlLT5uYW1lKTsKCQlzb2NrbGVu
X3Qgb3B0bGVuID0gc2l6ZW9mKGluZm8pOwoJCWlmIChnZXRzb2Nrb3B0KGZkLCBTT0xfSVAsIEFS
UFRfU09fR0VUX0lORk8sICZpbmZvLCAmb3B0bGVuKSkKCWV4aXQoMSk7CgkJaWYgKG1lbWNtcCgm
dGFibGUtPmluZm8sICZpbmZvLCBzaXplb2YodGFibGUtPmluZm8pKSA9PSAwKSB7CgkJCXN0cnVj
dCBhcnB0X2dldF9lbnRyaWVzIGVudHJpZXM7CgkJCW1lbXNldCgmZW50cmllcywgMCwgc2l6ZW9m
KGVudHJpZXMpKTsKCQkJc3RyY3B5KGVudHJpZXMubmFtZSwgdGFibGUtPm5hbWUpOwoJCQllbnRy
aWVzLnNpemUgPSB0YWJsZS0+aW5mby5zaXplOwoJCQlvcHRsZW4gPSBzaXplb2YoZW50cmllcykg
LSBzaXplb2YoZW50cmllcy5lbnRyeXRhYmxlKSArIGVudHJpZXMuc2l6ZTsKCQkJaWYgKGdldHNv
Y2tvcHQoZmQsIFNPTF9JUCwgQVJQVF9TT19HRVRfRU5UUklFUywgJmVudHJpZXMsICZvcHRsZW4p
KQoJZXhpdCgxKTsKCQkJaWYgKG1lbWNtcCh0YWJsZS0+cmVwbGFjZS5lbnRyeXRhYmxlLCBlbnRy
aWVzLmVudHJ5dGFibGUsIHRhYmxlLT5pbmZvLnNpemUpID09IDApCgkJCQljb250aW51ZTsKCQl9
IGVsc2UgewoJCX0KCQlzdHJ1Y3QgeHRfY291bnRlcnMgY291bnRlcnNbWFRfTUFYX0VOVFJJRVNd
OwoJCXRhYmxlLT5yZXBsYWNlLm51bV9jb3VudGVycyA9IGluZm8ubnVtX2VudHJpZXM7CgkJdGFi
bGUtPnJlcGxhY2UuY291bnRlcnMgPSBjb3VudGVyczsKCQlvcHRsZW4gPSBzaXplb2YodGFibGUt
PnJlcGxhY2UpIC0gc2l6ZW9mKHRhYmxlLT5yZXBsYWNlLmVudHJ5dGFibGUpICsgdGFibGUtPnJl
cGxhY2Uuc2l6ZTsKCQlpZiAoc2V0c29ja29wdChmZCwgU09MX0lQLCBBUlBUX1NPX1NFVF9SRVBM
QUNFLCAmdGFibGUtPnJlcGxhY2UsIG9wdGxlbikpCglleGl0KDEpOwoJfQoJY2xvc2UoZmQpOwp9
CgojZGVmaW5lIE5GX0JSX05VTUhPT0tTIDYKI2RlZmluZSBFQlRfVEFCTEVfTUFYTkFNRUxFTiAz
MgojZGVmaW5lIEVCVF9DSEFJTl9NQVhOQU1FTEVOIDMyCiNkZWZpbmUgRUJUX0JBU0VfQ1RMIDEy
OAojZGVmaW5lIEVCVF9TT19TRVRfRU5UUklFUyAoRUJUX0JBU0VfQ1RMKQojZGVmaW5lIEVCVF9T
T19HRVRfSU5GTyAoRUJUX0JBU0VfQ1RMKQojZGVmaW5lIEVCVF9TT19HRVRfRU5UUklFUyAoRUJU
X1NPX0dFVF9JTkZPICsgMSkKI2RlZmluZSBFQlRfU09fR0VUX0lOSVRfSU5GTyAoRUJUX1NPX0dF
VF9FTlRSSUVTICsgMSkKI2RlZmluZSBFQlRfU09fR0VUX0lOSVRfRU5UUklFUyAoRUJUX1NPX0dF
VF9JTklUX0lORk8gKyAxKQoKc3RydWN0IGVidF9yZXBsYWNlIHsKCWNoYXIgbmFtZVtFQlRfVEFC
TEVfTUFYTkFNRUxFTl07Cgl1bnNpZ25lZCBpbnQgdmFsaWRfaG9va3M7Cgl1bnNpZ25lZCBpbnQg
bmVudHJpZXM7Cgl1bnNpZ25lZCBpbnQgZW50cmllc19zaXplOwoJc3RydWN0IGVidF9lbnRyaWVz
KiBob29rX2VudHJ5W05GX0JSX05VTUhPT0tTXTsKCXVuc2lnbmVkIGludCBudW1fY291bnRlcnM7
CglzdHJ1Y3QgZWJ0X2NvdW50ZXIqIGNvdW50ZXJzOwoJY2hhciogZW50cmllczsKfTsKCnN0cnVj
dCBlYnRfZW50cmllcyB7Cgl1bnNpZ25lZCBpbnQgZGlzdGluZ3Vpc2hlcjsKCWNoYXIgbmFtZVtF
QlRfQ0hBSU5fTUFYTkFNRUxFTl07Cgl1bnNpZ25lZCBpbnQgY291bnRlcl9vZmZzZXQ7CglpbnQg
cG9saWN5OwoJdW5zaWduZWQgaW50IG5lbnRyaWVzOwoJY2hhciBkYXRhWzBdIF9fYXR0cmlidXRl
X18oKGFsaWduZWQoX19hbGlnbm9mX18oc3RydWN0IGVidF9yZXBsYWNlKSkpKTsKfTsKCnN0cnVj
dCBlYnRfdGFibGVfZGVzYyB7Cgljb25zdCBjaGFyKiBuYW1lOwoJc3RydWN0IGVidF9yZXBsYWNl
IHJlcGxhY2U7CgljaGFyIGVudHJ5dGFibGVbWFRfVEFCTEVfU0laRV07Cn07CgpzdGF0aWMgc3Ry
dWN0IGVidF90YWJsZV9kZXNjIGVidF90YWJsZXNbXSA9IHsKICAgIHsubmFtZSA9ICJmaWx0ZXIi
fSwKICAgIHsubmFtZSA9ICJuYXQifSwKICAgIHsubmFtZSA9ICJicm91dGUifSwKfTsKCnN0YXRp
YyB2b2lkIGNoZWNrcG9pbnRfZWJ0YWJsZXModm9pZCkKewoJaW50IGZkID0gc29ja2V0KEFGX0lO
RVQsIFNPQ0tfU1RSRUFNLCBJUFBST1RPX1RDUCk7CglpZiAoZmQgPT0gLTEpIHsKCQlzd2l0Y2gg
KGVycm5vKSB7CgkJY2FzZSBFQUZOT1NVUFBPUlQ6CgkJY2FzZSBFTk9QUk9UT09QVDoKCQljYXNl
IEVOT0VOVDoKCQkJcmV0dXJuOwoJCX0KCWV4aXQoMSk7Cgl9Cglmb3IgKHNpemVfdCBpID0gMDsg
aSA8IHNpemVvZihlYnRfdGFibGVzKSAvIHNpemVvZihlYnRfdGFibGVzWzBdKTsgaSsrKSB7CgkJ
c3RydWN0IGVidF90YWJsZV9kZXNjKiB0YWJsZSA9ICZlYnRfdGFibGVzW2ldOwoJCXN0cmNweSh0
YWJsZS0+cmVwbGFjZS5uYW1lLCB0YWJsZS0+bmFtZSk7CgkJc29ja2xlbl90IG9wdGxlbiA9IHNp
emVvZih0YWJsZS0+cmVwbGFjZSk7CgkJaWYgKGdldHNvY2tvcHQoZmQsIFNPTF9JUCwgRUJUX1NP
X0dFVF9JTklUX0lORk8sICZ0YWJsZS0+cmVwbGFjZSwgJm9wdGxlbikpIHsKCQkJc3dpdGNoIChl
cnJubykgewoJCQljYXNlIEVQRVJNOgoJCQljYXNlIEVOT0VOVDoKCQkJY2FzZSBFTk9QUk9UT09Q
VDoKCQkJCWNvbnRpbnVlOwoJCQl9CglleGl0KDEpOwoJCX0KCQlpZiAodGFibGUtPnJlcGxhY2Uu
ZW50cmllc19zaXplID4gc2l6ZW9mKHRhYmxlLT5lbnRyeXRhYmxlKSkKCWV4aXQoMSk7CgkJdGFi
bGUtPnJlcGxhY2UubnVtX2NvdW50ZXJzID0gMDsKCQl0YWJsZS0+cmVwbGFjZS5lbnRyaWVzID0g
dGFibGUtPmVudHJ5dGFibGU7CgkJb3B0bGVuID0gc2l6ZW9mKHRhYmxlLT5yZXBsYWNlKSArIHRh
YmxlLT5yZXBsYWNlLmVudHJpZXNfc2l6ZTsKCQlpZiAoZ2V0c29ja29wdChmZCwgU09MX0lQLCBF
QlRfU09fR0VUX0lOSVRfRU5UUklFUywgJnRhYmxlLT5yZXBsYWNlLCAmb3B0bGVuKSkKCWV4aXQo
MSk7Cgl9CgljbG9zZShmZCk7Cn0KCnN0YXRpYyB2b2lkIHJlc2V0X2VidGFibGVzKCkKewoJaW50
IGZkID0gc29ja2V0KEFGX0lORVQsIFNPQ0tfU1RSRUFNLCBJUFBST1RPX1RDUCk7CglpZiAoZmQg
PT0gLTEpIHsKCQlzd2l0Y2ggKGVycm5vKSB7CgkJY2FzZSBFQUZOT1NVUFBPUlQ6CgkJY2FzZSBF
Tk9QUk9UT09QVDoKCQljYXNlIEVOT0VOVDoKCQkJcmV0dXJuOwoJCX0KCWV4aXQoMSk7Cgl9Cglm
b3IgKHVuc2lnbmVkIGkgPSAwOyBpIDwgc2l6ZW9mKGVidF90YWJsZXMpIC8gc2l6ZW9mKGVidF90
YWJsZXNbMF0pOyBpKyspIHsKCQlzdHJ1Y3QgZWJ0X3RhYmxlX2Rlc2MqIHRhYmxlID0gJmVidF90
YWJsZXNbaV07CgkJaWYgKHRhYmxlLT5yZXBsYWNlLnZhbGlkX2hvb2tzID09IDApCgkJCWNvbnRp
bnVlOwoJCXN0cnVjdCBlYnRfcmVwbGFjZSByZXBsYWNlOwoJCW1lbXNldCgmcmVwbGFjZSwgMCwg
c2l6ZW9mKHJlcGxhY2UpKTsKCQlzdHJjcHkocmVwbGFjZS5uYW1lLCB0YWJsZS0+bmFtZSk7CgkJ
c29ja2xlbl90IG9wdGxlbiA9IHNpemVvZihyZXBsYWNlKTsKCQlpZiAoZ2V0c29ja29wdChmZCwg
U09MX0lQLCBFQlRfU09fR0VUX0lORk8sICZyZXBsYWNlLCAmb3B0bGVuKSkKCWV4aXQoMSk7CgkJ
cmVwbGFjZS5udW1fY291bnRlcnMgPSAwOwoJCXRhYmxlLT5yZXBsYWNlLmVudHJpZXMgPSAwOwoJ
CWZvciAodW5zaWduZWQgaCA9IDA7IGggPCBORl9CUl9OVU1IT09LUzsgaCsrKQoJCQl0YWJsZS0+
cmVwbGFjZS5ob29rX2VudHJ5W2hdID0gMDsKCQlpZiAobWVtY21wKCZ0YWJsZS0+cmVwbGFjZSwg
JnJlcGxhY2UsIHNpemVvZih0YWJsZS0+cmVwbGFjZSkpID09IDApIHsKCQkJY2hhciBlbnRyeXRh
YmxlW1hUX1RBQkxFX1NJWkVdOwoJCQltZW1zZXQoJmVudHJ5dGFibGUsIDAsIHNpemVvZihlbnRy
eXRhYmxlKSk7CgkJCXJlcGxhY2UuZW50cmllcyA9IGVudHJ5dGFibGU7CgkJCW9wdGxlbiA9IHNp
emVvZihyZXBsYWNlKSArIHJlcGxhY2UuZW50cmllc19zaXplOwoJCQlpZiAoZ2V0c29ja29wdChm
ZCwgU09MX0lQLCBFQlRfU09fR0VUX0VOVFJJRVMsICZyZXBsYWNlLCAmb3B0bGVuKSkKCWV4aXQo
MSk7CgkJCWlmIChtZW1jbXAodGFibGUtPmVudHJ5dGFibGUsIGVudHJ5dGFibGUsIHJlcGxhY2Uu
ZW50cmllc19zaXplKSA9PSAwKQoJCQkJY29udGludWU7CgkJfQoJCWZvciAodW5zaWduZWQgaiA9
IDAsIGggPSAwOyBoIDwgTkZfQlJfTlVNSE9PS1M7IGgrKykgewoJCQlpZiAodGFibGUtPnJlcGxh
Y2UudmFsaWRfaG9va3MgJiAoMSA8PCBoKSkgewoJCQkJdGFibGUtPnJlcGxhY2UuaG9va19lbnRy
eVtoXSA9IChzdHJ1Y3QgZWJ0X2VudHJpZXMqKXRhYmxlLT5lbnRyeXRhYmxlICsgajsKCQkJCWor
KzsKCQkJfQoJCX0KCQl0YWJsZS0+cmVwbGFjZS5lbnRyaWVzID0gdGFibGUtPmVudHJ5dGFibGU7
CgkJb3B0bGVuID0gc2l6ZW9mKHRhYmxlLT5yZXBsYWNlKSArIHRhYmxlLT5yZXBsYWNlLmVudHJp
ZXNfc2l6ZTsKCQlpZiAoc2V0c29ja29wdChmZCwgU09MX0lQLCBFQlRfU09fU0VUX0VOVFJJRVMs
ICZ0YWJsZS0+cmVwbGFjZSwgb3B0bGVuKSkKCWV4aXQoMSk7Cgl9CgljbG9zZShmZCk7Cn0KCnN0
YXRpYyB2b2lkIGNoZWNrcG9pbnRfbmV0X25hbWVzcGFjZSh2b2lkKQp7CgljaGVja3BvaW50X2Vi
dGFibGVzKCk7CgljaGVja3BvaW50X2FycHRhYmxlcygpOwoJY2hlY2twb2ludF9pcHRhYmxlcyhp
cHY0X3RhYmxlcywgc2l6ZW9mKGlwdjRfdGFibGVzKSAvIHNpemVvZihpcHY0X3RhYmxlc1swXSks
IEFGX0lORVQsIFNPTF9JUCk7CgljaGVja3BvaW50X2lwdGFibGVzKGlwdjZfdGFibGVzLCBzaXpl
b2YoaXB2Nl90YWJsZXMpIC8gc2l6ZW9mKGlwdjZfdGFibGVzWzBdKSwgQUZfSU5FVDYsIFNPTF9J
UFY2KTsKfQoKc3RhdGljIHZvaWQgcmVzZXRfbmV0X25hbWVzcGFjZSh2b2lkKQp7CglyZXNldF9l
YnRhYmxlcygpOwoJcmVzZXRfYXJwdGFibGVzKCk7CglyZXNldF9pcHRhYmxlcyhpcHY0X3RhYmxl
cywgc2l6ZW9mKGlwdjRfdGFibGVzKSAvIHNpemVvZihpcHY0X3RhYmxlc1swXSksIEFGX0lORVQs
IFNPTF9JUCk7CglyZXNldF9pcHRhYmxlcyhpcHY2X3RhYmxlcywgc2l6ZW9mKGlwdjZfdGFibGVz
KSAvIHNpemVvZihpcHY2X3RhYmxlc1swXSksIEFGX0lORVQ2LCBTT0xfSVBWNik7Cn0KCnN0YXRp
YyB2b2lkIG1vdW50X2Nncm91cHMoY29uc3QgY2hhciogZGlyLCBjb25zdCBjaGFyKiogY29udHJv
bGxlcnMsIGludCBjb3VudCkKewoJaWYgKG1rZGlyKGRpciwgMDc3NykpIHsKCQlyZXR1cm47Cgl9
CgljaGFyIGVuYWJsZWRbMTI4XSA9IHswfTsKCWludCBpID0gMDsKCWZvciAoOyBpIDwgY291bnQ7
IGkrKykgewoJCWlmIChtb3VudCgibm9uZSIsIGRpciwgImNncm91cCIsIDAsIGNvbnRyb2xsZXJz
W2ldKSkgewoJCQljb250aW51ZTsKCQl9CgkJdW1vdW50KGRpcik7CgkJc3RyY2F0KGVuYWJsZWQs
ICIsIik7CgkJc3RyY2F0KGVuYWJsZWQsIGNvbnRyb2xsZXJzW2ldKTsKCX0KCWlmIChlbmFibGVk
WzBdID09IDApIHsKCQlpZiAocm1kaXIoZGlyKSAmJiBlcnJubyAhPSBFQlVTWSkKCWV4aXQoMSk7
CgkJcmV0dXJuOwoJfQoJaWYgKG1vdW50KCJub25lIiwgZGlyLCAiY2dyb3VwIiwgMCwgZW5hYmxl
ZCArIDEpKSB7CgkJaWYgKHJtZGlyKGRpcikgJiYgZXJybm8gIT0gRUJVU1kpCglleGl0KDEpOwoJ
fQoJaWYgKGNobW9kKGRpciwgMDc3NykpIHsKCX0KfQoKc3RhdGljIHZvaWQgbW91bnRfY2dyb3Vw
czIoY29uc3QgY2hhcioqIGNvbnRyb2xsZXJzLCBpbnQgY291bnQpCnsKCWlmIChta2RpcigiL3N5
emNncm91cC91bmlmaWVkIiwgMDc3NykpIHsKCQlyZXR1cm47Cgl9CglpZiAobW91bnQoIm5vbmUi
LCAiL3N5emNncm91cC91bmlmaWVkIiwgImNncm91cDIiLCAwLCBOVUxMKSkgewoJCWlmIChybWRp
cigiL3N5emNncm91cC91bmlmaWVkIikgJiYgZXJybm8gIT0gRUJVU1kpCglleGl0KDEpOwoJCXJl
dHVybjsKCX0KCWlmIChjaG1vZCgiL3N5emNncm91cC91bmlmaWVkIiwgMDc3NykpIHsKCX0KCWlu
dCBjb250cm9sID0gb3BlbigiL3N5emNncm91cC91bmlmaWVkL2Nncm91cC5zdWJ0cmVlX2NvbnRy
b2wiLCBPX1dST05MWSk7CglpZiAoY29udHJvbCA9PSAtMSkKCQlyZXR1cm47CglpbnQgaTsKCWZv
ciAoaSA9IDA7IGkgPCBjb3VudDsgaSsrKQoJCWlmICh3cml0ZShjb250cm9sLCBjb250cm9sbGVy
c1tpXSwgc3RybGVuKGNvbnRyb2xsZXJzW2ldKSkgPCAwKSB7CgkJfQoJY2xvc2UoY29udHJvbCk7
Cn0KCnN0YXRpYyB2b2lkIHNldHVwX2Nncm91cHMoKQp7Cgljb25zdCBjaGFyKiB1bmlmaWVkX2Nv
bnRyb2xsZXJzW10gPSB7IitjcHUiLCAiK2lvIiwgIitwaWRzIn07Cgljb25zdCBjaGFyKiBuZXRf
Y29udHJvbGxlcnNbXSA9IHsibmV0IiwgIm5ldF9wcmlvIiwgImRldmljZXMiLCAiYmxraW8iLCAi
ZnJlZXplciJ9OwoJY29uc3QgY2hhciogY3B1X2NvbnRyb2xsZXJzW10gPSB7ImNwdXNldCIsICJj
cHVhY2N0IiwgImh1Z2V0bGIiLCAicmxpbWl0IiwgIm1lbW9yeSJ9OwoJaWYgKG1rZGlyKCIvc3l6
Y2dyb3VwIiwgMDc3NykpIHsKCQlyZXR1cm47Cgl9Cgltb3VudF9jZ3JvdXBzMih1bmlmaWVkX2Nv
bnRyb2xsZXJzLCBzaXplb2YodW5pZmllZF9jb250cm9sbGVycykgLyBzaXplb2YodW5pZmllZF9j
b250cm9sbGVyc1swXSkpOwoJbW91bnRfY2dyb3VwcygiL3N5emNncm91cC9uZXQiLCBuZXRfY29u
dHJvbGxlcnMsIHNpemVvZihuZXRfY29udHJvbGxlcnMpIC8gc2l6ZW9mKG5ldF9jb250cm9sbGVy
c1swXSkpOwoJbW91bnRfY2dyb3VwcygiL3N5emNncm91cC9jcHUiLCBjcHVfY29udHJvbGxlcnMs
IHNpemVvZihjcHVfY29udHJvbGxlcnMpIC8gc2l6ZW9mKGNwdV9jb250cm9sbGVyc1swXSkpOwoJ
d3JpdGVfZmlsZSgiL3N5emNncm91cC9jcHUvY2dyb3VwLmNsb25lX2NoaWxkcmVuIiwgIjEiKTsK
CXdyaXRlX2ZpbGUoIi9zeXpjZ3JvdXAvY3B1L2NwdXNldC5tZW1vcnlfcHJlc3N1cmVfZW5hYmxl
ZCIsICIxIik7Cn0KCnN0YXRpYyB2b2lkIHNldHVwX2Nncm91cHNfbG9vcCgpCnsKCWludCBwaWQg
PSBnZXRwaWQoKTsKCWNoYXIgZmlsZVsxMjhdOwoJY2hhciBjZ3JvdXBkaXJbNjRdOwoJc25wcmlu
dGYoY2dyb3VwZGlyLCBzaXplb2YoY2dyb3VwZGlyKSwgIi9zeXpjZ3JvdXAvdW5pZmllZC9zeXol
bGx1IiwgcHJvY2lkKTsKCWlmIChta2RpcihjZ3JvdXBkaXIsIDA3NzcpKSB7Cgl9CglzbnByaW50
ZihmaWxlLCBzaXplb2YoZmlsZSksICIlcy9waWRzLm1heCIsIGNncm91cGRpcik7Cgl3cml0ZV9m
aWxlKGZpbGUsICIzMiIpOwoJc25wcmludGYoZmlsZSwgc2l6ZW9mKGZpbGUpLCAiJXMvY2dyb3Vw
LnByb2NzIiwgY2dyb3VwZGlyKTsKCXdyaXRlX2ZpbGUoZmlsZSwgIiVkIiwgcGlkKTsKCXNucHJp
bnRmKGNncm91cGRpciwgc2l6ZW9mKGNncm91cGRpciksICIvc3l6Y2dyb3VwL2NwdS9zeXolbGx1
IiwgcHJvY2lkKTsKCWlmIChta2RpcihjZ3JvdXBkaXIsIDA3NzcpKSB7Cgl9CglzbnByaW50Zihm
aWxlLCBzaXplb2YoZmlsZSksICIlcy9jZ3JvdXAucHJvY3MiLCBjZ3JvdXBkaXIpOwoJd3JpdGVf
ZmlsZShmaWxlLCAiJWQiLCBwaWQpOwoJc25wcmludGYoZmlsZSwgc2l6ZW9mKGZpbGUpLCAiJXMv
bWVtb3J5LnNvZnRfbGltaXRfaW5fYnl0ZXMiLCBjZ3JvdXBkaXIpOwoJd3JpdGVfZmlsZShmaWxl
LCAiJWQiLCAyOTkgPDwgMjApOwoJc25wcmludGYoZmlsZSwgc2l6ZW9mKGZpbGUpLCAiJXMvbWVt
b3J5LmxpbWl0X2luX2J5dGVzIiwgY2dyb3VwZGlyKTsKCXdyaXRlX2ZpbGUoZmlsZSwgIiVkIiwg
MzAwIDw8IDIwKTsKCXNucHJpbnRmKGNncm91cGRpciwgc2l6ZW9mKGNncm91cGRpciksICIvc3l6
Y2dyb3VwL25ldC9zeXolbGx1IiwgcHJvY2lkKTsKCWlmIChta2RpcihjZ3JvdXBkaXIsIDA3Nzcp
KSB7Cgl9CglzbnByaW50ZihmaWxlLCBzaXplb2YoZmlsZSksICIlcy9jZ3JvdXAucHJvY3MiLCBj
Z3JvdXBkaXIpOwoJd3JpdGVfZmlsZShmaWxlLCAiJWQiLCBwaWQpOwp9CgpzdGF0aWMgdm9pZCBz
ZXR1cF9jZ3JvdXBzX3Rlc3QoKQp7CgljaGFyIGNncm91cGRpcls2NF07CglzbnByaW50ZihjZ3Jv
dXBkaXIsIHNpemVvZihjZ3JvdXBkaXIpLCAiL3N5emNncm91cC91bmlmaWVkL3N5eiVsbHUiLCBw
cm9jaWQpOwoJaWYgKHN5bWxpbmsoY2dyb3VwZGlyLCAiLi9jZ3JvdXAiKSkgewoJfQoJc25wcmlu
dGYoY2dyb3VwZGlyLCBzaXplb2YoY2dyb3VwZGlyKSwgIi9zeXpjZ3JvdXAvY3B1L3N5eiVsbHUi
LCBwcm9jaWQpOwoJaWYgKHN5bWxpbmsoY2dyb3VwZGlyLCAiLi9jZ3JvdXAuY3B1IikpIHsKCX0K
CXNucHJpbnRmKGNncm91cGRpciwgc2l6ZW9mKGNncm91cGRpciksICIvc3l6Y2dyb3VwL25ldC9z
eXolbGx1IiwgcHJvY2lkKTsKCWlmIChzeW1saW5rKGNncm91cGRpciwgIi4vY2dyb3VwLm5ldCIp
KSB7Cgl9Cn0KCnN0YXRpYyB2b2lkIGluaXRpYWxpemVfY2dyb3VwcygpCnsKCWlmIChta2Rpcigi
Li9zeXotdG1wL25ld3Jvb3Qvc3l6Y2dyb3VwIiwgMDcwMCkpCglleGl0KDEpOwoJaWYgKG1rZGly
KCIuL3N5ei10bXAvbmV3cm9vdC9zeXpjZ3JvdXAvdW5pZmllZCIsIDA3MDApKQoJZXhpdCgxKTsK
CWlmIChta2RpcigiLi9zeXotdG1wL25ld3Jvb3Qvc3l6Y2dyb3VwL2NwdSIsIDA3MDApKQoJZXhp
dCgxKTsKCWlmIChta2RpcigiLi9zeXotdG1wL25ld3Jvb3Qvc3l6Y2dyb3VwL25ldCIsIDA3MDAp
KQoJZXhpdCgxKTsKCXVuc2lnbmVkIGJpbmRfbW91bnRfZmxhZ3MgPSBNU19CSU5EIHwgTVNfUkVD
IHwgTVNfUFJJVkFURTsKCWlmIChtb3VudCgiL3N5emNncm91cC91bmlmaWVkIiwgIi4vc3l6LXRt
cC9uZXdyb290L3N5emNncm91cC91bmlmaWVkIiwgTlVMTCwgYmluZF9tb3VudF9mbGFncywgTlVM
TCkpIHsKCX0KCWlmIChtb3VudCgiL3N5emNncm91cC9jcHUiLCAiLi9zeXotdG1wL25ld3Jvb3Qv
c3l6Y2dyb3VwL2NwdSIsIE5VTEwsIGJpbmRfbW91bnRfZmxhZ3MsIE5VTEwpKSB7Cgl9CglpZiAo
bW91bnQoIi9zeXpjZ3JvdXAvbmV0IiwgIi4vc3l6LXRtcC9uZXdyb290L3N5emNncm91cC9uZXQi
LCBOVUxMLCBiaW5kX21vdW50X2ZsYWdzLCBOVUxMKSkgewoJfQp9CgpzdGF0aWMgdm9pZCBzZXR1
cF9nYWRnZXRmcygpOwpzdGF0aWMgdm9pZCBzZXR1cF9iaW5kZXJmcygpOwpzdGF0aWMgdm9pZCBz
ZXR1cF9mdXNlY3RsKCk7CnN0YXRpYyB2b2lkIHNhbmRib3hfY29tbW9uX21vdW50X3RtcGZzKHZv
aWQpCnsKCXdyaXRlX2ZpbGUoIi9wcm9jL3N5cy9mcy9tb3VudC1tYXgiLCAiMTAwMDAwIik7Cglp
ZiAobWtkaXIoIi4vc3l6LXRtcCIsIDA3NzcpKQoJZXhpdCgxKTsKCWlmIChtb3VudCgiIiwgIi4v
c3l6LXRtcCIsICJ0bXBmcyIsIDAsIE5VTEwpKQoJZXhpdCgxKTsKCWlmIChta2RpcigiLi9zeXot
dG1wL25ld3Jvb3QiLCAwNzc3KSkKCWV4aXQoMSk7CglpZiAobWtkaXIoIi4vc3l6LXRtcC9uZXdy
b290L2RldiIsIDA3MDApKQoJZXhpdCgxKTsKCXVuc2lnbmVkIGJpbmRfbW91bnRfZmxhZ3MgPSBN
U19CSU5EIHwgTVNfUkVDIHwgTVNfUFJJVkFURTsKCWlmIChtb3VudCgiL2RldiIsICIuL3N5ei10
bXAvbmV3cm9vdC9kZXYiLCBOVUxMLCBiaW5kX21vdW50X2ZsYWdzLCBOVUxMKSkKCWV4aXQoMSk7
CglpZiAobWtkaXIoIi4vc3l6LXRtcC9uZXdyb290L3Byb2MiLCAwNzAwKSkKCWV4aXQoMSk7Cglp
ZiAobW91bnQoInN5ei1wcm9jIiwgIi4vc3l6LXRtcC9uZXdyb290L3Byb2MiLCAicHJvYyIsIDAs
IE5VTEwpKQoJZXhpdCgxKTsKCWlmIChta2RpcigiLi9zeXotdG1wL25ld3Jvb3Qvc2VsaW51eCIs
IDA3MDApKQoJZXhpdCgxKTsKCWNvbnN0IGNoYXIqIHNlbGludXhfcGF0aCA9ICIuL3N5ei10bXAv
bmV3cm9vdC9zZWxpbnV4IjsKCWlmIChtb3VudCgiL3NlbGludXgiLCBzZWxpbnV4X3BhdGgsIE5V
TEwsIGJpbmRfbW91bnRfZmxhZ3MsIE5VTEwpKSB7CgkJaWYgKGVycm5vICE9IEVOT0VOVCkKCWV4
aXQoMSk7CgkJaWYgKG1vdW50KCIvc3lzL2ZzL3NlbGludXgiLCBzZWxpbnV4X3BhdGgsIE5VTEws
IGJpbmRfbW91bnRfZmxhZ3MsIE5VTEwpICYmIGVycm5vICE9IEVOT0VOVCkKCWV4aXQoMSk7Cgl9
CglpZiAobWtkaXIoIi4vc3l6LXRtcC9uZXdyb290L3N5cyIsIDA3MDApKQoJZXhpdCgxKTsKCWlm
IChtb3VudCgiL3N5cyIsICIuL3N5ei10bXAvbmV3cm9vdC9zeXMiLCAwLCBiaW5kX21vdW50X2Zs
YWdzLCBOVUxMKSkKCWV4aXQoMSk7CglpZiAobW91bnQoIi9zeXMva2VybmVsL2RlYnVnIiwgIi4v
c3l6LXRtcC9uZXdyb290L3N5cy9rZXJuZWwvZGVidWciLCBOVUxMLCBiaW5kX21vdW50X2ZsYWdz
LCBOVUxMKSAmJiBlcnJubyAhPSBFTk9FTlQpCglleGl0KDEpOwoJaWYgKG1vdW50KCIvc3lzL2Zz
L3NtYWNrZnMiLCAiLi9zeXotdG1wL25ld3Jvb3Qvc3lzL2ZzL3NtYWNrZnMiLCBOVUxMLCBiaW5k
X21vdW50X2ZsYWdzLCBOVUxMKSAmJiBlcnJubyAhPSBFTk9FTlQpCglleGl0KDEpOwoJaWYgKG1v
dW50KCIvcHJvYy9zeXMvZnMvYmluZm10X21pc2MiLCAiLi9zeXotdG1wL25ld3Jvb3QvcHJvYy9z
eXMvZnMvYmluZm10X21pc2MiLCBOVUxMLCBiaW5kX21vdW50X2ZsYWdzLCBOVUxMKSAmJiBlcnJu
byAhPSBFTk9FTlQpCglleGl0KDEpOwoJaWYgKG1rZGlyKCIuL3N5ei10bXAvbmV3cm9vdC9zeXot
aW5wdXRzIiwgMDcwMCkpCglleGl0KDEpOwoJaWYgKG1vdW50KCIvc3l6LWlucHV0cyIsICIuL3N5
ei10bXAvbmV3cm9vdC9zeXotaW5wdXRzIiwgTlVMTCwgYmluZF9tb3VudF9mbGFncyB8IE1TX1JE
T05MWSwgTlVMTCkgJiYgZXJybm8gIT0gRU5PRU5UKQoJZXhpdCgxKTsKCWluaXRpYWxpemVfY2dy
b3VwcygpOwoJaWYgKG1rZGlyKCIuL3N5ei10bXAvcGl2b3QiLCAwNzc3KSkKCWV4aXQoMSk7Cglp
ZiAoc3lzY2FsbChTWVNfcGl2b3Rfcm9vdCwgIi4vc3l6LXRtcCIsICIuL3N5ei10bXAvcGl2b3Qi
KSkgewoJCWlmIChjaGRpcigiLi9zeXotdG1wIikpCglleGl0KDEpOwoJfSBlbHNlIHsKCQlpZiAo
Y2hkaXIoIi8iKSkKCWV4aXQoMSk7CgkJaWYgKHVtb3VudDIoIi4vcGl2b3QiLCBNTlRfREVUQUNI
KSkKCWV4aXQoMSk7Cgl9CglpZiAoY2hyb290KCIuL25ld3Jvb3QiKSkKCWV4aXQoMSk7CglpZiAo
Y2hkaXIoIi8iKSkKCWV4aXQoMSk7CglzZXR1cF9nYWRnZXRmcygpOwoJc2V0dXBfYmluZGVyZnMo
KTsKCXNldHVwX2Z1c2VjdGwoKTsKfQoKc3RhdGljIHZvaWQgc2V0dXBfZ2FkZ2V0ZnMoKQp7Cglp
ZiAobWtkaXIoIi9kZXYvZ2FkZ2V0ZnMiLCAwNzc3KSkgewoJfQoJaWYgKG1vdW50KCJnYWRnZXRm
cyIsICIvZGV2L2dhZGdldGZzIiwgImdhZGdldGZzIiwgMCwgTlVMTCkpIHsKCX0KfQoKc3RhdGlj
IHZvaWQgc2V0dXBfZnVzZWN0bCgpCnsKCWlmIChtb3VudCgwLCAiL3N5cy9mcy9mdXNlL2Nvbm5l
Y3Rpb25zIiwgImZ1c2VjdGwiLCAwLCAwKSkgewoJfQp9CgpzdGF0aWMgdm9pZCBzZXR1cF9iaW5k
ZXJmcygpCnsKCWlmIChta2RpcigiL2Rldi9iaW5kZXJmcyIsIDA3NzcpKSB7Cgl9CglpZiAobW91
bnQoImJpbmRlciIsICIvZGV2L2JpbmRlcmZzIiwgImJpbmRlciIsIDAsIE5VTEwpKSB7Cgl9Cn0K
CnN0YXRpYyB2b2lkIGxvb3AoKTsKCnN0YXRpYyB2b2lkIHNhbmRib3hfY29tbW9uKCkKewoJcHJj
dGwoUFJfU0VUX1BERUFUSFNJRywgU0lHS0lMTCwgMCwgMCwgMCk7CglpZiAoZ2V0cHBpZCgpID09
IDEpCglleGl0KDEpOwoJaW50IG5ldG5zID0gb3BlbigiL3Byb2Mvc2VsZi9ucy9uZXQiLCBPX1JE
T05MWSk7CglpZiAobmV0bnMgPT0gLTEpCglleGl0KDEpOwoJaWYgKGR1cDIobmV0bnMsIGtJbml0
TmV0TnNGZCkgPCAwKQoJZXhpdCgxKTsKCWNsb3NlKG5ldG5zKTsKCXN0cnVjdCBybGltaXQgcmxp
bTsKCXJsaW0ucmxpbV9jdXIgPSBybGltLnJsaW1fbWF4ID0gKDIwMCA8PCAyMCk7CglzZXRybGlt
aXQoUkxJTUlUX0FTLCAmcmxpbSk7CglybGltLnJsaW1fY3VyID0gcmxpbS5ybGltX21heCA9IDMy
IDw8IDIwOwoJc2V0cmxpbWl0KFJMSU1JVF9NRU1MT0NLLCAmcmxpbSk7CglybGltLnJsaW1fY3Vy
ID0gcmxpbS5ybGltX21heCA9IDEzNiA8PCAyMDsKCXNldHJsaW1pdChSTElNSVRfRlNJWkUsICZy
bGltKTsKCXJsaW0ucmxpbV9jdXIgPSBybGltLnJsaW1fbWF4ID0gMSA8PCAyMDsKCXNldHJsaW1p
dChSTElNSVRfU1RBQ0ssICZybGltKTsKCXJsaW0ucmxpbV9jdXIgPSBybGltLnJsaW1fbWF4ID0g
MTI4IDw8IDIwOwoJc2V0cmxpbWl0KFJMSU1JVF9DT1JFLCAmcmxpbSk7CglybGltLnJsaW1fY3Vy
ID0gcmxpbS5ybGltX21heCA9IDI1NjsKCXNldHJsaW1pdChSTElNSVRfTk9GSUxFLCAmcmxpbSk7
CglpZiAodW5zaGFyZShDTE9ORV9ORVdOUykpIHsKCX0KCWlmIChtb3VudChOVUxMLCAiLyIsIE5V
TEwsIE1TX1JFQyB8IE1TX1BSSVZBVEUsIE5VTEwpKSB7Cgl9CglpZiAodW5zaGFyZShDTE9ORV9O
RVdJUEMpKSB7Cgl9CglpZiAodW5zaGFyZSgweDAyMDAwMDAwKSkgewoJfQoJaWYgKHVuc2hhcmUo
Q0xPTkVfTkVXVVRTKSkgewoJfQoJaWYgKHVuc2hhcmUoQ0xPTkVfU1lTVlNFTSkpIHsKCX0KCXR5
cGVkZWYgc3RydWN0IHsKCQljb25zdCBjaGFyKiBuYW1lOwoJCWNvbnN0IGNoYXIqIHZhbHVlOwoJ
fSBzeXNjdGxfdDsKCXN0YXRpYyBjb25zdCBzeXNjdGxfdCBzeXNjdGxzW10gPSB7CgkgICAgeyIv
cHJvYy9zeXMva2VybmVsL3NobW1heCIsICIxNjc3NzIxNiJ9LAoJICAgIHsiL3Byb2Mvc3lzL2tl
cm5lbC9zaG1hbGwiLCAiNTM2ODcwOTEyIn0sCgkgICAgeyIvcHJvYy9zeXMva2VybmVsL3NobW1u
aSIsICIxMDI0In0sCgkgICAgeyIvcHJvYy9zeXMva2VybmVsL21zZ21heCIsICI4MTkyIn0sCgkg
ICAgeyIvcHJvYy9zeXMva2VybmVsL21zZ21uaSIsICIxMDI0In0sCgkgICAgeyIvcHJvYy9zeXMv
a2VybmVsL21zZ21uYiIsICIxMDI0In0sCgkgICAgeyIvcHJvYy9zeXMva2VybmVsL3NlbSIsICIx
MDI0IDEwNDg1NzYgNTAwIDEwMjQifSwKCX07Cgl1bnNpZ25lZCBpOwoJZm9yIChpID0gMDsgaSA8
IHNpemVvZihzeXNjdGxzKSAvIHNpemVvZihzeXNjdGxzWzBdKTsgaSsrKQoJCXdyaXRlX2ZpbGUo
c3lzY3Rsc1tpXS5uYW1lLCBzeXNjdGxzW2ldLnZhbHVlKTsKfQoKc3RhdGljIGludCB3YWl0X2Zv
cl9sb29wKGludCBwaWQpCnsKCWlmIChwaWQgPCAwKQoJZXhpdCgxKTsKCWludCBzdGF0dXMgPSAw
OwoJd2hpbGUgKHdhaXRwaWQoLTEsICZzdGF0dXMsIF9fV0FMTCkgIT0gcGlkKSB7Cgl9CglyZXR1
cm4gV0VYSVRTVEFUVVMoc3RhdHVzKTsKfQoKc3RhdGljIHZvaWQgZHJvcF9jYXBzKHZvaWQpCnsK
CXN0cnVjdCBfX3VzZXJfY2FwX2hlYWRlcl9zdHJ1Y3QgY2FwX2hkciA9IHt9OwoJc3RydWN0IF9f
dXNlcl9jYXBfZGF0YV9zdHJ1Y3QgY2FwX2RhdGFbMl0gPSB7fTsKCWNhcF9oZHIudmVyc2lvbiA9
IF9MSU5VWF9DQVBBQklMSVRZX1ZFUlNJT05fMzsKCWNhcF9oZHIucGlkID0gZ2V0cGlkKCk7Cglp
ZiAoc3lzY2FsbChTWVNfY2FwZ2V0LCAmY2FwX2hkciwgJmNhcF9kYXRhKSkKCWV4aXQoMSk7Cglj
b25zdCBpbnQgZHJvcCA9ICgxIDw8IENBUF9TWVNfUFRSQUNFKSB8ICgxIDw8IENBUF9TWVNfTklD
RSk7CgljYXBfZGF0YVswXS5lZmZlY3RpdmUgJj0gfmRyb3A7CgljYXBfZGF0YVswXS5wZXJtaXR0
ZWQgJj0gfmRyb3A7CgljYXBfZGF0YVswXS5pbmhlcml0YWJsZSAmPSB+ZHJvcDsKCWlmIChzeXNj
YWxsKFNZU19jYXBzZXQsICZjYXBfaGRyLCAmY2FwX2RhdGEpKQoJZXhpdCgxKTsKfQoKc3RhdGlj
IGludCBkb19zYW5kYm94X25vbmUodm9pZCkKewoJaWYgKHVuc2hhcmUoQ0xPTkVfTkVXUElEKSkg
ewoJfQoJaW50IHBpZCA9IGZvcmsoKTsKCWlmIChwaWQgIT0gMCkKCQlyZXR1cm4gd2FpdF9mb3Jf
bG9vcChwaWQpOwoJaW5pdGlhbGl6ZV92aGNpKCk7CglzYW5kYm94X2NvbW1vbigpOwoJZHJvcF9j
YXBzKCk7Cglpbml0aWFsaXplX25ldGRldmljZXNfaW5pdCgpOwoJaWYgKHVuc2hhcmUoQ0xPTkVf
TkVXTkVUKSkgewoJfQoJd3JpdGVfZmlsZSgiL3Byb2Mvc3lzL25ldC9pcHY0L3BpbmdfZ3JvdXBf
cmFuZ2UiLCAiMCA2NTUzNSIpOwoJaW5pdGlhbGl6ZV9kZXZsaW5rX3BjaSgpOwoJaW5pdGlhbGl6
ZV90dW4oKTsKCWluaXRpYWxpemVfbmV0ZGV2aWNlcygpOwoJaW5pdGlhbGl6ZV93aWZpX2Rldmlj
ZXMoKTsKCXNhbmRib3hfY29tbW9uX21vdW50X3RtcGZzKCk7Cglsb29wKCk7CglleGl0KDEpOwp9
CgojZGVmaW5lIEZTX0lPQ19TRVRGTEFHUyBfSU9XKCdmJywgMiwgbG9uZykKc3RhdGljIHZvaWQg
cmVtb3ZlX2Rpcihjb25zdCBjaGFyKiBkaXIpCnsKCWludCBpdGVyID0gMDsKCURJUiogZHAgPSAw
OwoJY29uc3QgaW50IHVtb3VudF9mbGFncyA9IE1OVF9GT1JDRSB8IFVNT1VOVF9OT0ZPTExPVzsK
CnJldHJ5OgoJCXdoaWxlICh1bW91bnQyKGRpciwgdW1vdW50X2ZsYWdzKSA9PSAwKSB7CgkJfQoJ
ZHAgPSBvcGVuZGlyKGRpcik7CglpZiAoZHAgPT0gTlVMTCkgewoJCWlmIChlcnJubyA9PSBFTUZJ
TEUpIHsKCWV4aXQoMSk7CgkJfQoJZXhpdCgxKTsKCX0KCXN0cnVjdCBkaXJlbnQqIGVwID0gMDsK
CXdoaWxlICgoZXAgPSByZWFkZGlyKGRwKSkpIHsKCQlpZiAoc3RyY21wKGVwLT5kX25hbWUsICIu
IikgPT0gMCB8fCBzdHJjbXAoZXAtPmRfbmFtZSwgIi4uIikgPT0gMCkKCQkJY29udGludWU7CgkJ
Y2hhciBmaWxlbmFtZVtGSUxFTkFNRV9NQVhdOwoJCXNucHJpbnRmKGZpbGVuYW1lLCBzaXplb2Yo
ZmlsZW5hbWUpLCAiJXMvJXMiLCBkaXIsIGVwLT5kX25hbWUpOwoJCQl3aGlsZSAodW1vdW50Mihm
aWxlbmFtZSwgdW1vdW50X2ZsYWdzKSA9PSAwKSB7CgkJCX0KCQlzdHJ1Y3Qgc3RhdCBzdDsKCQlp
ZiAobHN0YXQoZmlsZW5hbWUsICZzdCkpCglleGl0KDEpOwoJCWlmIChTX0lTRElSKHN0LnN0X21v
ZGUpKSB7CgkJCXJlbW92ZV9kaXIoZmlsZW5hbWUpOwoJCQljb250aW51ZTsKCQl9CgkJaW50IGk7
CgkJZm9yIChpID0gMDs7IGkrKykgewoJCQlpZiAodW5saW5rKGZpbGVuYW1lKSA9PSAwKQoJCQkJ
YnJlYWs7CgkJCWlmIChlcnJubyA9PSBFUEVSTSkgewoJCQkJaW50IGZkID0gb3BlbihmaWxlbmFt
ZSwgT19SRE9OTFkpOwoJCQkJaWYgKGZkICE9IC0xKSB7CgkJCQkJbG9uZyBmbGFncyA9IDA7CgkJ
CQkJaWYgKGlvY3RsKGZkLCBGU19JT0NfU0VURkxBR1MsICZmbGFncykgPT0gMCkgewoJCQkJCX0K
CQkJCQljbG9zZShmZCk7CgkJCQkJY29udGludWU7CgkJCQl9CgkJCX0KCQkJaWYgKGVycm5vID09
IEVST0ZTKSB7CgkJCQlicmVhazsKCQkJfQoJCQlpZiAoZXJybm8gIT0gRUJVU1kgfHwgaSA+IDEw
MCkKCWV4aXQoMSk7CgkJCQlpZiAodW1vdW50MihmaWxlbmFtZSwgdW1vdW50X2ZsYWdzKSkKCWV4
aXQoMSk7CgkJfQoJfQoJY2xvc2VkaXIoZHApOwoJZm9yIChpbnQgaSA9IDA7OyBpKyspIHsKCQlp
ZiAocm1kaXIoZGlyKSA9PSAwKQoJCQlicmVhazsKCQlpZiAoaSA8IDEwMCkgewoJCQlpZiAoZXJy
bm8gPT0gRVBFUk0pIHsKCQkJCWludCBmZCA9IG9wZW4oZGlyLCBPX1JET05MWSk7CgkJCQlpZiAo
ZmQgIT0gLTEpIHsKCQkJCQlsb25nIGZsYWdzID0gMDsKCQkJCQlpZiAoaW9jdGwoZmQsIEZTX0lP
Q19TRVRGTEFHUywgJmZsYWdzKSA9PSAwKSB7CgkJCQkJfQoJCQkJCWNsb3NlKGZkKTsKCQkJCQlj
b250aW51ZTsKCQkJCX0KCQkJfQoJCQlpZiAoZXJybm8gPT0gRVJPRlMpIHsKCQkJCWJyZWFrOwoJ
CQl9CgkJCWlmIChlcnJubyA9PSBFQlVTWSkgewoJCQkJCWlmICh1bW91bnQyKGRpciwgdW1vdW50
X2ZsYWdzKSkKCWV4aXQoMSk7CgkJCQljb250aW51ZTsKCQkJfQoJCQlpZiAoZXJybm8gPT0gRU5P
VEVNUFRZKSB7CgkJCQlpZiAoaXRlciA8IDEwMCkgewoJCQkJCWl0ZXIrKzsKCQkJCQlnb3RvIHJl
dHJ5OwoJCQkJfQoJCQl9CgkJfQoJZXhpdCgxKTsKCX0KfQoKc3RhdGljIHZvaWQga2lsbF9hbmRf
d2FpdChpbnQgcGlkLCBpbnQqIHN0YXR1cykKewoJa2lsbCgtcGlkLCBTSUdLSUxMKTsKCWtpbGwo
cGlkLCBTSUdLSUxMKTsKCWZvciAoaW50IGkgPSAwOyBpIDwgMTAwOyBpKyspIHsKCQlpZiAod2Fp
dHBpZCgtMSwgc3RhdHVzLCBXTk9IQU5HIHwgX19XQUxMKSA9PSBwaWQpCgkJCXJldHVybjsKCQl1
c2xlZXAoMTAwMCk7Cgl9CglESVIqIGRpciA9IG9wZW5kaXIoIi9zeXMvZnMvZnVzZS9jb25uZWN0
aW9ucyIpOwoJaWYgKGRpcikgewoJCWZvciAoOzspIHsKCQkJc3RydWN0IGRpcmVudCogZW50ID0g
cmVhZGRpcihkaXIpOwoJCQlpZiAoIWVudCkKCQkJCWJyZWFrOwoJCQlpZiAoc3RyY21wKGVudC0+
ZF9uYW1lLCAiLiIpID09IDAgfHwgc3RyY21wKGVudC0+ZF9uYW1lLCAiLi4iKSA9PSAwKQoJCQkJ
Y29udGludWU7CgkJCWNoYXIgYWJvcnRbMzAwXTsKCQkJc25wcmludGYoYWJvcnQsIHNpemVvZihh
Ym9ydCksICIvc3lzL2ZzL2Z1c2UvY29ubmVjdGlvbnMvJXMvYWJvcnQiLCBlbnQtPmRfbmFtZSk7
CgkJCWludCBmZCA9IG9wZW4oYWJvcnQsIE9fV1JPTkxZKTsKCQkJaWYgKGZkID09IC0xKSB7CgkJ
CQljb250aW51ZTsKCQkJfQoJCQlpZiAod3JpdGUoZmQsIGFib3J0LCAxKSA8IDApIHsKCQkJfQoJ
CQljbG9zZShmZCk7CgkJfQoJCWNsb3NlZGlyKGRpcik7Cgl9IGVsc2UgewoJfQoJd2hpbGUgKHdh
aXRwaWQoLTEsIHN0YXR1cywgX19XQUxMKSAhPSBwaWQpIHsKCX0KfQoKc3RhdGljIHZvaWQgc2V0
dXBfbG9vcCgpCnsKCXNldHVwX2Nncm91cHNfbG9vcCgpOwoJY2hlY2twb2ludF9uZXRfbmFtZXNw
YWNlKCk7Cn0KCnN0YXRpYyB2b2lkIHJlc2V0X2xvb3AoKQp7CglyZXNldF9uZXRfbmFtZXNwYWNl
KCk7Cn0KCnN0YXRpYyB2b2lkIHNldHVwX3Rlc3QoKQp7CglwcmN0bChQUl9TRVRfUERFQVRIU0lH
LCBTSUdLSUxMLCAwLCAwLCAwKTsKCXNldHBncnAoKTsKCXNldHVwX2Nncm91cHNfdGVzdCgpOwoJ
d3JpdGVfZmlsZSgiL3Byb2Mvc2VsZi9vb21fc2NvcmVfYWRqIiwgIjEwMDAiKTsKCWZsdXNoX3R1
bigpOwoJaWYgKHN5bWxpbmsoIi9kZXYvYmluZGVyZnMiLCAiLi9iaW5kZXJmcyIpKSB7Cgl9Cn0K
CnN0YXRpYyB2b2lkIGNsb3NlX2ZkcygpCnsKCWZvciAoaW50IGZkID0gMzsgZmQgPCBNQVhfRkRT
OyBmZCsrKQoJCWNsb3NlKGZkKTsKfQoKc3RhdGljIGNvbnN0IGNoYXIqIHNldHVwX2JpbmZtdF9t
aXNjKCkKewoJaWYgKG1vdW50KDAsICIvcHJvYy9zeXMvZnMvYmluZm10X21pc2MiLCAiYmluZm10
X21pc2MiLCAwLCAwKSAmJiBlcnJubyAhPSBFQlVTWSkgewoJCXJldHVybiBOVUxMOwoJfQoJaWYg
KCF3cml0ZV9maWxlKCIvcHJvYy9zeXMvZnMvYmluZm10X21pc2MvcmVnaXN0ZXIiLCAiOnN5ejA6
TTowOlx4MDE6Oi4vZmlsZTA6IikgfHwKCSAgICAhd3JpdGVfZmlsZSgiL3Byb2Mvc3lzL2ZzL2Jp
bmZtdF9taXNjL3JlZ2lzdGVyIiwgIjpzeXoxOk06MTpceDAyOjouL2ZpbGUwOlBPQyIpKQoJCXJl
dHVybiAid3JpdGUoL3Byb2Mvc3lzL2ZzL2JpbmZtdF9taXNjL3JlZ2lzdGVyKSBmYWlsZWQiOwoJ
cmV0dXJuIE5VTEw7Cn0KCnN0YXRpYyBjb25zdCBjaGFyKiBzZXR1cF91c2IoKQp7CglpZiAoY2ht
b2QoIi9kZXYvcmF3LWdhZGdldCIsIDA2NjYpKQoJCXJldHVybiAiZmFpbGVkIHRvIGNobW9kIC9k
ZXYvcmF3LWdhZGdldCI7CglyZXR1cm4gTlVMTDsKfQoKc3RhdGljIHZvaWQgc2V0dXBfc3lzY3Rs
KCkKewoJaW50IGNhZF9waWQgPSBmb3JrKCk7CglpZiAoY2FkX3BpZCA8IDApCglleGl0KDEpOwoJ
aWYgKGNhZF9waWQgPT0gMCkgewoJCWZvciAoOzspCgkJCXNsZWVwKDEwMCk7Cgl9CgljaGFyIHRt
cHBpZFszMl07CglzbnByaW50Zih0bXBwaWQsIHNpemVvZih0bXBwaWQpLCAiJWQiLCBjYWRfcGlk
KTsKCXN0cnVjdCB7CgkJY29uc3QgY2hhciogbmFtZTsKCQljb25zdCBjaGFyKiBkYXRhOwoJfSBm
aWxlc1tdID0gewoJICAgIHsiL3Byb2Mvc3lzL2tlcm5lbC9odW5nX3Rhc2tfY2hlY2tfaW50ZXJ2
YWxfc2VjcyIsICIyMCJ9LAoJICAgIHsiL3Byb2Mvc3lzL25ldC9jb3JlL2JwZl9qaXRfa2FsbHN5
bXMiLCAiMSJ9LAoJICAgIHsiL3Byb2Mvc3lzL25ldC9jb3JlL2JwZl9qaXRfaGFyZGVuIiwgIjAi
fSwKCSAgICB7Ii9wcm9jL3N5cy9rZXJuZWwva3B0cl9yZXN0cmljdCIsICIwIn0sCgkgICAgeyIv
cHJvYy9zeXMva2VybmVsL3NvZnRsb2NrdXBfYWxsX2NwdV9iYWNrdHJhY2UiLCAiMSJ9LAoJICAg
IHsiL3Byb2Mvc3lzL2ZzL21vdW50LW1heCIsICIxMDAifSwKCSAgICB7Ii9wcm9jL3N5cy92bS9v
b21fZHVtcF90YXNrcyIsICIwIn0sCgkgICAgeyIvcHJvYy9zeXMvZGVidWcvZXhjZXB0aW9uLXRy
YWNlIiwgIjAifSwKCSAgICB7Ii9wcm9jL3N5cy9rZXJuZWwvcHJpbnRrIiwgIjcgNCAxIDMifSwK
CSAgICB7Ii9wcm9jL3N5cy9rZXJuZWwva2V5cy9nY19kZWxheSIsICIxIn0sCgkgICAgeyIvcHJv
Yy9zeXMvdm0vb29tX2tpbGxfYWxsb2NhdGluZ190YXNrIiwgIjEifSwKCSAgICB7Ii9zeXMva2Vy
bmVsL2RlYnVnL2ZhaWxzbGFiL3Rhc2stZmlsdGVyIiwgIlkifSwKCSAgICB7Ii9zeXMva2VybmVs
L2RlYnVnL2ZhaWxfcGFnZV9hbGxvYy90YXNrLWZpbHRlciIsICJZIn0sCgkgICAgeyIvc3lzL2tl
cm5lbC9kZWJ1Zy9mYWlsX2Z1dGV4L3Rhc2stZmlsdGVyIiwgIlkifSwKCSAgICB7Ii9zeXMva2Vy
bmVsL2RlYnVnL2ZhaWxfdXNlcmNvcHkvdGFzay1maWx0ZXIiLCAiWSJ9LAoJICAgIHsiL3N5cy9r
ZXJuZWwvZGVidWcvZmFpbF9tYWtlX3JlcXVlc3QvdGFzay1maWx0ZXIiLCAiWSJ9LAoJICAgIHsi
L3N5cy9rZXJuZWwvZGVidWcvZmFpbF9pb190aW1lb3V0L3Rhc2stZmlsdGVyIiwgIlkifSwKCSAg
ICB7Ii9zeXMva2VybmVsL2RlYnVnL2ZhaWxfaW9tbXVmZC90YXNrLWZpbHRlciIsICJZIn0sCgkg
ICAgeyIvcHJvYy9zeXMva2VybmVsL2N0cmwtYWx0LWRlbCIsICIwIn0sCgkgICAgeyIvcHJvYy9z
eXMva2VybmVsL2NhZF9waWQiLCB0bXBwaWR9LAoJfTsKCWZvciAoc2l6ZV90IGkgPSAwOyBpIDwg
c2l6ZW9mKGZpbGVzKSAvIHNpemVvZihmaWxlc1swXSk7IGkrKykgewoJCWlmICghd3JpdGVfZmls
ZShmaWxlc1tpXS5uYW1lLCBmaWxlc1tpXS5kYXRhKSkgewoJCX0KCX0KCWtpbGwoY2FkX3BpZCwg
U0lHS0lMTCk7Cgl3aGlsZSAod2FpdHBpZChjYWRfcGlkLCBOVUxMLCAwKSAhPSBjYWRfcGlkKQoJ
CTsKfQoKI2RlZmluZSBOTDgwMjE1NF9DTURfU0VUX1NIT1JUX0FERFIgMTEKI2RlZmluZSBOTDgw
MjE1NF9BVFRSX0lGSU5ERVggMwojZGVmaW5lIE5MODAyMTU0X0FUVFJfU0hPUlRfQUREUiAxMAoK
c3RhdGljIGNvbnN0IGNoYXIqIHNldHVwXzgwMjE1NCgpCnsKCWNvbnN0IGNoYXIqIGVycm9yID0g
TlVMTDsKCWludCBzb2NrX2dlbmVyaWMgPSAtMTsKCWludCBzb2NrX3JvdXRlID0gc29ja2V0KEFG
X05FVExJTkssIFNPQ0tfUkFXLCBORVRMSU5LX1JPVVRFKTsKCWlmIChzb2NrX3JvdXRlID09IC0x
KSB7CgkJZXJyb3IgPSAic29ja2V0KEFGX05FVExJTkssIFNPQ0tfUkFXLCBORVRMSU5LX1JPVVRF
KSBmYWlsZWQiOwoJCWdvdG8gZmFpbDsKCX0KCXNvY2tfZ2VuZXJpYyA9IHNvY2tldChBRl9ORVRM
SU5LLCBTT0NLX1JBVywgTkVUTElOS19HRU5FUklDKTsKCWlmIChzb2NrX2dlbmVyaWMgPT0gLTEp
IHsKCQllcnJvciA9ICJzb2NrZXQoQUZfTkVUTElOSywgU09DS19SQVcsIE5FVExJTktfR0VORVJJ
QykgZmFpbGVkIjsKCQlnb3RvIGZhaWw7Cgl9Cgl7CgkJaW50IG5sODAyMTU0X2ZhbWlseV9pZCA9
IG5ldGxpbmtfcXVlcnlfZmFtaWx5X2lkKCZubG1zZywgc29ja19nZW5lcmljLCAibmw4MDIxNTQi
LCB0cnVlKTsKCQlpZiAobmw4MDIxNTRfZmFtaWx5X2lkIDwgMCkgewoJCQllcnJvciA9ICJuZXRs
aW5rX3F1ZXJ5X2ZhbWlseV9pZCBmYWlsZWQiOwoJCQlnb3RvIGZhaWw7CgkJfQoJCWZvciAoaW50
IGkgPSAwOyBpIDwgMjsgaSsrKSB7CgkJCWNoYXIgZGV2bmFtZVtdID0gIndwYW4wIjsKCQkJZGV2
bmFtZVtzdHJsZW4oZGV2bmFtZSkgLSAxXSArPSBpOwoJCQl1aW50NjRfdCBod2FkZHIgPSAweGFh
YWFhYWFhYWFhYTAwMDIgKyAoaSA8PCA4KTsKCQkJdWludDE2X3Qgc2hvcnRhZGRyID0gMHhhYWEw
ICsgaTsKCQkJaW50IGlmaW5kZXggPSBpZl9uYW1ldG9pbmRleChkZXZuYW1lKTsKCQkJc3RydWN0
IGdlbmxtc2doZHIgZ2VubGhkcjsKCQkJbWVtc2V0KCZnZW5saGRyLCAwLCBzaXplb2YoZ2VubGhk
cikpOwoJCQlnZW5saGRyLmNtZCA9IE5MODAyMTU0X0NNRF9TRVRfU0hPUlRfQUREUjsKCQkJbmV0
bGlua19pbml0KCZubG1zZywgbmw4MDIxNTRfZmFtaWx5X2lkLCAwLCAmZ2VubGhkciwgc2l6ZW9m
KGdlbmxoZHIpKTsKCQkJbmV0bGlua19hdHRyKCZubG1zZywgTkw4MDIxNTRfQVRUUl9JRklOREVY
LCAmaWZpbmRleCwgc2l6ZW9mKGlmaW5kZXgpKTsKCQkJbmV0bGlua19hdHRyKCZubG1zZywgTkw4
MDIxNTRfQVRUUl9TSE9SVF9BRERSLCAmc2hvcnRhZGRyLCBzaXplb2Yoc2hvcnRhZGRyKSk7CgkJ
CWlmIChuZXRsaW5rX3NlbmQoJm5sbXNnLCBzb2NrX2dlbmVyaWMpIDwgMCkgewoJCQkJZXJyb3Ig
PSAiTkw4MDIxNTRfQ01EX1NFVF9TSE9SVF9BRERSIGZhaWxlZCI7CgkJCQlnb3RvIGZhaWw7CgkJ
CX0KCQkJbmV0bGlua19kZXZpY2VfY2hhbmdlKCZubG1zZywgc29ja19yb3V0ZSwgZGV2bmFtZSwg
dHJ1ZSwgMCwgJmh3YWRkciwgc2l6ZW9mKGh3YWRkciksIDApOwoJCQlpZiAoaSA9PSAwKSB7CgkJ
CQluZXRsaW5rX2FkZF9kZXZpY2VfaW1wbCgmbmxtc2csICJsb3dwYW4iLCAibG93cGFuMCIsIGZh
bHNlKTsKCQkJCW5ldGxpbmtfZG9uZSgmbmxtc2cpOwoJCQkJbmV0bGlua19hdHRyKCZubG1zZywg
SUZMQV9MSU5LLCAmaWZpbmRleCwgc2l6ZW9mKGlmaW5kZXgpKTsKCQkJCWlmIChuZXRsaW5rX3Nl
bmQoJm5sbXNnLCBzb2NrX3JvdXRlKSA8IDApIHsKCQkJCQllcnJvciA9ICJuZXRsaW5rOiBhZGRp
bmcgZGV2aWNlIGxvd3BhbjAgdHlwZSBsb3dwYW4gbGluayB3cGFuMCI7CgkJCQkJZ290byBmYWls
OwoJCQkJfQoJCQl9CgkJfQoJfQpmYWlsOgoJY2xvc2Uoc29ja19yb3V0ZSk7CgljbG9zZShzb2Nr
X2dlbmVyaWMpOwoJcmV0dXJuIGVycm9yOwp9CgojZGVmaW5lIFNXQVBfRklMRSAiLi9zd2FwLWZp
bGUiCiNkZWZpbmUgU1dBUF9GSUxFX1NJWkUgKDEyOCAqIDEwMDAgKiAxMDAwKQoKc3RhdGljIGNv
bnN0IGNoYXIqIHNldHVwX3N3YXAoKQp7Cglzd2Fwb2ZmKFNXQVBfRklMRSk7Cgl1bmxpbmsoU1dB
UF9GSUxFKTsKCWludCBmZCA9IG9wZW4oU1dBUF9GSUxFLCBPX0NSRUFUIHwgT19XUk9OTFkgfCBP
X0NMT0VYRUMsIDA2MDApOwoJaWYgKGZkID09IC0xKQoJCXJldHVybiAic3dhcCBmaWxlIG9wZW4g
ZmFpbGVkIjsKCWZhbGxvY2F0ZShmZCwgRkFMTE9DX0ZMX1pFUk9fUkFOR0UsIDAsIFNXQVBfRklM
RV9TSVpFKTsKCWNsb3NlKGZkKTsKCWNoYXIgY21kbGluZVs2NF07CglzcHJpbnRmKGNtZGxpbmUs
ICJta3N3YXAgJXMiLCBTV0FQX0ZJTEUpOwoJaWYgKHJ1bmNtZGxpbmUoY21kbGluZSkpCgkJcmV0
dXJuICJta3N3YXAgZmFpbGVkIjsKCWlmIChzd2Fwb24oU1dBUF9GSUxFLCBTV0FQX0ZMQUdfUFJF
RkVSKSA9PSAxKQoJCXJldHVybiAic3dhcG9uIGZhaWxlZCI7CglyZXR1cm4gTlVMTDsKfQoKc3Ry
dWN0IHRocmVhZF90IHsKCWludCBjcmVhdGVkLCBjYWxsOwoJZXZlbnRfdCByZWFkeSwgZG9uZTsK
fTsKCnN0YXRpYyBzdHJ1Y3QgdGhyZWFkX3QgdGhyZWFkc1sxNl07CnN0YXRpYyB2b2lkIGV4ZWN1
dGVfY2FsbChpbnQgY2FsbCk7CnN0YXRpYyBpbnQgcnVubmluZzsKCnN0YXRpYyB2b2lkKiB0aHIo
dm9pZCogYXJnKQp7CglzdHJ1Y3QgdGhyZWFkX3QqIHRoID0gKHN0cnVjdCB0aHJlYWRfdCopYXJn
OwoJZm9yICg7OykgewoJCWV2ZW50X3dhaXQoJnRoLT5yZWFkeSk7CgkJZXZlbnRfcmVzZXQoJnRo
LT5yZWFkeSk7CgkJZXhlY3V0ZV9jYWxsKHRoLT5jYWxsKTsKCQlfX2F0b21pY19mZXRjaF9zdWIo
JnJ1bm5pbmcsIDEsIF9fQVRPTUlDX1JFTEFYRUQpOwoJCWV2ZW50X3NldCgmdGgtPmRvbmUpOwoJ
fQoJcmV0dXJuIDA7Cn0KCnN0YXRpYyB2b2lkIGV4ZWN1dGVfb25lKHZvaWQpCnsKCWlmICh3cml0
ZSgxLCAiZXhlY3V0aW5nIHByb2dyYW1cbiIsIHNpemVvZigiZXhlY3V0aW5nIHByb2dyYW1cbiIp
IC0gMSkpIHsKCX0KCWludCBpLCBjYWxsLCB0aHJlYWQ7Cglmb3IgKGNhbGwgPSAwOyBjYWxsIDwg
MjsgY2FsbCsrKSB7CgkJZm9yICh0aHJlYWQgPSAwOyB0aHJlYWQgPCAoaW50KShzaXplb2YodGhy
ZWFkcykgLyBzaXplb2YodGhyZWFkc1swXSkpOyB0aHJlYWQrKykgewoJCQlzdHJ1Y3QgdGhyZWFk
X3QqIHRoID0gJnRocmVhZHNbdGhyZWFkXTsKCQkJaWYgKCF0aC0+Y3JlYXRlZCkgewoJCQkJdGgt
PmNyZWF0ZWQgPSAxOwoJCQkJZXZlbnRfaW5pdCgmdGgtPnJlYWR5KTsKCQkJCWV2ZW50X2luaXQo
JnRoLT5kb25lKTsKCQkJCWV2ZW50X3NldCgmdGgtPmRvbmUpOwoJCQkJdGhyZWFkX3N0YXJ0KHRo
ciwgdGgpOwoJCQl9CgkJCWlmICghZXZlbnRfaXNzZXQoJnRoLT5kb25lKSkKCQkJCWNvbnRpbnVl
OwoJCQlldmVudF9yZXNldCgmdGgtPmRvbmUpOwoJCQl0aC0+Y2FsbCA9IGNhbGw7CgkJCV9fYXRv
bWljX2ZldGNoX2FkZCgmcnVubmluZywgMSwgX19BVE9NSUNfUkVMQVhFRCk7CgkJCWV2ZW50X3Nl
dCgmdGgtPnJlYWR5KTsKCQkJZXZlbnRfdGltZWR3YWl0KCZ0aC0+ZG9uZSwgNTApOwoJCQlicmVh
azsKCQl9Cgl9Cglmb3IgKGkgPSAwOyBpIDwgMTAwICYmIF9fYXRvbWljX2xvYWRfbigmcnVubmlu
ZywgX19BVE9NSUNfUkVMQVhFRCk7IGkrKykKCQlzbGVlcF9tcygxKTsKCWNsb3NlX2ZkcygpOwp9
CgpzdGF0aWMgdm9pZCBleGVjdXRlX29uZSh2b2lkKTsKCiNkZWZpbmUgV0FJVF9GTEFHUyBfX1dB
TEwKCnN0YXRpYyB2b2lkIGxvb3Aodm9pZCkKewoJc2V0dXBfbG9vcCgpOwoJaW50IGl0ZXIgPSAw
OwoJZm9yICg7OyBpdGVyKyspIHsKCQljaGFyIGN3ZGJ1ZlszMl07CgkJc3ByaW50Zihjd2RidWYs
ICIuLyVkIiwgaXRlcik7CgkJaWYgKG1rZGlyKGN3ZGJ1ZiwgMDc3NykpCglleGl0KDEpOwoJCXJl
c2V0X2xvb3AoKTsKCQlpbnQgcGlkID0gZm9yaygpOwoJCWlmIChwaWQgPCAwKQoJZXhpdCgxKTsK
CQlpZiAocGlkID09IDApIHsKCQkJaWYgKGNoZGlyKGN3ZGJ1ZikpCglleGl0KDEpOwoJCQlzZXR1
cF90ZXN0KCk7CgkJCWV4ZWN1dGVfb25lKCk7CgkJCWV4aXQoMCk7CgkJfQoJCWludCBzdGF0dXMg
PSAwOwoJCXVpbnQ2NF90IHN0YXJ0ID0gY3VycmVudF90aW1lX21zKCk7CgkJZm9yICg7OykgewoJ
CQlzbGVlcF9tcygxMCk7CgkJCWlmICh3YWl0cGlkKC0xLCAmc3RhdHVzLCBXTk9IQU5HIHwgV0FJ
VF9GTEFHUykgPT0gcGlkKQoJCQkJYnJlYWs7CgkJCWlmIChjdXJyZW50X3RpbWVfbXMoKSAtIHN0
YXJ0IDwgNTAwMCkKCQkJCWNvbnRpbnVlOwoJCQlraWxsX2FuZF93YWl0KHBpZCwgJnN0YXR1cyk7
CgkJCWJyZWFrOwoJCX0KCQlyZW1vdmVfZGlyKGN3ZGJ1Zik7Cgl9Cn0KCnZvaWQgZXhlY3V0ZV9j
YWxsKGludCBjYWxsKQp7CgkJc3dpdGNoIChjYWxsKSB7CgljYXNlIDA6Ci8vICBwZXJmX2V2ZW50
X29wZW4gYXJndW1lbnRzOiBbCi8vICAgIGF0dHI6IHB0cltpbiwgcGVyZl9ldmVudF9hdHRyXSB7
Ci8vICAgICAgcGVyZl9ldmVudF9hdHRyIHsKLy8gICAgICAgIHR5cGU6IHBlcmZfZXZlbnRfdHlw
ZSA9IDB4MiAoNCBieXRlcykKLy8gICAgICAgIHNpemU6IGxlbiA9IDB4ODAgKDQgYnl0ZXMpCi8v
ICAgICAgICBjb25maWcwOiBpbnQ4ID0gMHg3NyAoMSBieXRlcykKLy8gICAgICAgIGNvbmZpZzE6
IGludDggPSAweDAgKDEgYnl0ZXMpCi8vICAgICAgICBjb25maWcyOiBpbnQ4ID0gMHgwICgxIGJ5
dGVzKQovLyAgICAgICAgY29uZmlnMzogaW50OCA9IDB4MCAoMSBieXRlcykKLy8gICAgICAgIGNv
bmZpZzQ6IGNvbnN0ID0gMHgwICg0IGJ5dGVzKQovLyAgICAgICAgc2FtcGxlX2ZyZXE6IGludDY0
ID0gMHg5YzI5ICg4IGJ5dGVzKQovLyAgICAgICAgc2FtcGxlX3R5cGU6IHBlcmZfc2FtcGxlX3R5
cGUgPSAweDE0N2NiICg4IGJ5dGVzKQovLyAgICAgICAgcmVhZF9mb3JtYXQ6IHBlcmZfcmVhZF9m
b3JtYXQgPSAweDggKDggYnl0ZXMpCi8vICAgICAgICBkaXNhYmxlZDogaW50NjQgPSAweDAgKDAg
Ynl0ZXMpCi8vICAgICAgICBpbmhlcml0OiBpbnQ2NCA9IDB4MSAoMCBieXRlcykKLy8gICAgICAg
IHBpbm5lZDogaW50NjQgPSAweDEgKDAgYnl0ZXMpCi8vICAgICAgICBleGNsdXNpdmU6IGludDY0
ID0gMHgwICgwIGJ5dGVzKQovLyAgICAgICAgZXhjbHVkZV91c2VyOiBpbnQ2NCA9IDB4MCAoMCBi
eXRlcykKLy8gICAgICAgIGV4Y2x1ZGVfa2VybmVsOiBpbnQ2NCA9IDB4MCAoMCBieXRlcykKLy8g
ICAgICAgIGV4Y2x1ZGVfaHY6IGludDY0ID0gMHgwICgwIGJ5dGVzKQovLyAgICAgICAgZXhjbHVk
ZV9pZGxlOiBpbnQ2NCA9IDB4MSAoMCBieXRlcykKLy8gICAgICAgIG1tYXA6IGludDY0ID0gMHgx
ICgwIGJ5dGVzKQovLyAgICAgICAgY29tbTogaW50NjQgPSAweDEgKDAgYnl0ZXMpCi8vICAgICAg
ICBmcmVxOiBpbnQ2NCA9IDB4MSAoMCBieXRlcykKLy8gICAgICAgIGluaGVyaXRfc3RhdDogaW50
NjQgPSAweDEgKDAgYnl0ZXMpCi8vICAgICAgICBlbmFibGVfb25fZXhlYzogaW50NjQgPSAweDAg
KDAgYnl0ZXMpCi8vICAgICAgICB0YXNrOiBpbnQ2NCA9IDB4MCAoMCBieXRlcykKLy8gICAgICAg
IHdhdGVybWFyazogaW50NjQgPSAweDAgKDAgYnl0ZXMpCi8vICAgICAgICBwcmVjaXNlX2lwOiBp
bnQ2NCA9IDB4MiAoMCBieXRlcykKLy8gICAgICAgIG1tYXBfZGF0YTogaW50NjQgPSAweDEgKDAg
Ynl0ZXMpCi8vICAgICAgICBzYW1wbGVfaWRfYWxsOiBpbnQ2NCA9IDB4MCAoMCBieXRlcykKLy8g
ICAgICAgIGV4Y2x1ZGVfaG9zdDogaW50NjQgPSAweDAgKDAgYnl0ZXMpCi8vICAgICAgICBleGNs
dWRlX2d1ZXN0OiBpbnQ2NCA9IDB4MSAoMCBieXRlcykKLy8gICAgICAgIGV4Y2x1ZGVfY2FsbGNo
YWluX2tlcm5lbDogaW50NjQgPSAweDEgKDAgYnl0ZXMpCi8vICAgICAgICBleGNsdWRlX2NhbGxj
aGFpbl91c2VyOiBpbnQ2NCA9IDB4MSAoMCBieXRlcykKLy8gICAgICAgIG1tYXAyOiBpbnQ2NCA9
IDB4MCAoMCBieXRlcykKLy8gICAgICAgIGNvbW1fZXhlYzogaW50NjQgPSAweDAgKDAgYnl0ZXMp
Ci8vICAgICAgICB1c2VfY2xvY2tpZDogaW50NjQgPSAweDAgKDAgYnl0ZXMpCi8vICAgICAgICBj
b250ZXh0X3N3aXRjaDogaW50NjQgPSAweDEgKDAgYnl0ZXMpCi8vICAgICAgICB3cml0ZV9iYWNr
d2FyZDogaW50NjQgPSAweDEgKDAgYnl0ZXMpCi8vICAgICAgICBuYW1lc3BhY2VzOiBpbnQ2NCA9
IDB4MSAoMCBieXRlcykKLy8gICAgICAgIGtzeW1ib2w6IGludDY0ID0gMHgwICgwIGJ5dGVzKQov
LyAgICAgICAgYnBmX2V2ZW50OiBpbnQ2NCA9IDB4MCAoMCBieXRlcykKLy8gICAgICAgIGF1eF9v
dXRwdXQ6IGludDY0ID0gMHgwICgwIGJ5dGVzKQovLyAgICAgICAgY2dyb3VwOiBpbnQ2NCA9IDB4
MSAoMCBieXRlcykKLy8gICAgICAgIHRleHRfcG9rZTogaW50NjQgPSAweDAgKDAgYnl0ZXMpCi8v
ICAgICAgICBidWlsZF9pZDogaW50NjQgPSAweDAgKDAgYnl0ZXMpCi8vICAgICAgICBpbmhlcml0
X3RocmVhZDogaW50NjQgPSAweDEgKDAgYnl0ZXMpCi8vICAgICAgICByZW1vdmVfb25fZXhlYzog
aW50NjQgPSAweDEgKDAgYnl0ZXMpCi8vICAgICAgICBzaWd0cmFwOiBpbnQ2NCA9IDB4MSAoMCBi
eXRlcykKLy8gICAgICAgIF9fcmVzZXJ2ZWRfMTogY29uc3QgPSAweDAgKDggYnl0ZXMpCi8vICAg
ICAgICB3YWtldXBfZXZlbnRzOiBpbnQzMiA9IDB4YiAoNCBieXRlcykKLy8gICAgICAgIGJwX3R5
cGU6IHBlcmZfYnBfdHlwZSA9IDB4NCAoNCBieXRlcykKLy8gICAgICAgIGJwX2NvbmZpZzogdW5p
b24gcGVyZl9icF9jb25maWcgewovLyAgICAgICAgICBwZXJmX2NvbmZpZ19leHQ6IHBlcmZfY29u
ZmlnX2V4dCB7Ci8vICAgICAgICAgICAgY29uZmlnMTogaW50NjQgPSAweGZmZmZmZmZmZmZmZmZi
ZmYgKDggYnl0ZXMpCi8vICAgICAgICAgICAgY29uZmlnMjogaW50NjQgPSAweDEwMCAoOCBieXRl
cykKLy8gICAgICAgICAgfQovLyAgICAgICAgfQovLyAgICAgICAgYnJhbmNoX3NhbXBsZV90eXBl
OiBwZXJmX2JyYW5jaF9zYW1wbGVfdHlwZSA9IDB4YTEgKDggYnl0ZXMpCi8vICAgICAgICBzYW1w
bGVfcmVnc191c2VyOiBpbnQ2NCA9IDB4MyAoOCBieXRlcykKLy8gICAgICAgIHNhbXBsZV9zdGFj
a191c2VyOiBpbnQzMiA9IDB4NCAoNCBieXRlcykKLy8gICAgICAgIGNsb2NraWQ6IGNsb2NrX3R5
cGUgPSAweDYgKDQgYnl0ZXMpCi8vICAgICAgICBzYW1wbGVfcmVnc19pbnRyOiBpbnQ2NCA9IDB4
NyAoOCBieXRlcykKLy8gICAgICAgIGF1eF93YXRlcm1hcms6IGludDMyID0gMHg4ICg0IGJ5dGVz
KQovLyAgICAgICAgc2FtcGxlX21heF9zdGFjazogaW50MTYgPSAweGZjYmUgKDIgYnl0ZXMpCi8v
ICAgICAgICBfX3Jlc2VydmVkXzI6IGNvbnN0ID0gMHgwICgyIGJ5dGVzKQovLyAgICAgICAgYXV4
X3NhbXBsZV9zaXplOiBpbnQzMiA9IDB4MCAoNCBieXRlcykKLy8gICAgICAgIF9fcmVzZXJ2ZWRf
MzogY29uc3QgPSAweDAgKDQgYnl0ZXMpCi8vICAgICAgICBzaWdfZGF0YTogaW50NjQgPSAweDIg
KDggYnl0ZXMpCi8vICAgICAgfQovLyAgICB9Ci8vICAgIHBpZDogcGlkIChyZXNvdXJjZSkKLy8g
ICAgY3B1OiBpbnRwdHIgPSAweGZmZmZmZmZmZmZmZmZmZmYgKDggYnl0ZXMpCi8vICAgIGdyb3Vw
OiBmZF9wZXJmIChyZXNvdXJjZSkKLy8gICAgZmxhZ3M6IHBlcmZfZmxhZ3MgPSAweDIgKDggYnl0
ZXMpCi8vICBdCi8vICByZXR1cm5zIGZkX3BlcmYKCQlOT05GQUlMSU5HKCoodWludDMyX3QqKTB4
MjAwMDAwMDAgPSAyKTsKCQlOT05GQUlMSU5HKCoodWludDMyX3QqKTB4MjAwMDAwMDQgPSAweDgw
KTsKCQlOT05GQUlMSU5HKCoodWludDhfdCopMHgyMDAwMDAwOCA9IDB4NzcpOwoJCU5PTkZBSUxJ
TkcoKih1aW50OF90KikweDIwMDAwMDA5ID0gMCk7CgkJTk9ORkFJTElORygqKHVpbnQ4X3QqKTB4
MjAwMDAwMGEgPSAwKTsKCQlOT05GQUlMSU5HKCoodWludDhfdCopMHgyMDAwMDAwYiA9IDApOwoJ
CU5PTkZBSUxJTkcoKih1aW50MzJfdCopMHgyMDAwMDAwYyA9IDApOwoJCU5PTkZBSUxJTkcoKih1
aW50NjRfdCopMHgyMDAwMDAxMCA9IDB4OWMyOSk7CgkJTk9ORkFJTElORygqKHVpbnQ2NF90Kikw
eDIwMDAwMDE4ID0gMHgxNDdjYik7CgkJTk9ORkFJTElORygqKHVpbnQ2NF90KikweDIwMDAwMDIw
ID0gOCk7CgkJTk9ORkFJTElORyhTVE9SRV9CWV9CSVRNQVNLKHVpbnQ2NF90LCAsIDB4MjAwMDAw
MjgsIDAsIDAsIDEpKTsKCQlOT05GQUlMSU5HKFNUT1JFX0JZX0JJVE1BU0sodWludDY0X3QsICwg
MHgyMDAwMDAyOCwgMSwgMSwgMSkpOwoJCU5PTkZBSUxJTkcoU1RPUkVfQllfQklUTUFTSyh1aW50
NjRfdCwgLCAweDIwMDAwMDI4LCAxLCAyLCAxKSk7CgkJTk9ORkFJTElORyhTVE9SRV9CWV9CSVRN
QVNLKHVpbnQ2NF90LCAsIDB4MjAwMDAwMjgsIDAsIDMsIDEpKTsKCQlOT05GQUlMSU5HKFNUT1JF
X0JZX0JJVE1BU0sodWludDY0X3QsICwgMHgyMDAwMDAyOCwgMCwgNCwgMSkpOwoJCU5PTkZBSUxJ
TkcoU1RPUkVfQllfQklUTUFTSyh1aW50NjRfdCwgLCAweDIwMDAwMDI4LCAwLCA1LCAxKSk7CgkJ
Tk9ORkFJTElORyhTVE9SRV9CWV9CSVRNQVNLKHVpbnQ2NF90LCAsIDB4MjAwMDAwMjgsIDAsIDYs
IDEpKTsKCQlOT05GQUlMSU5HKFNUT1JFX0JZX0JJVE1BU0sodWludDY0X3QsICwgMHgyMDAwMDAy
OCwgMSwgNywgMSkpOwoJCU5PTkZBSUxJTkcoU1RPUkVfQllfQklUTUFTSyh1aW50NjRfdCwgLCAw
eDIwMDAwMDI4LCAxLCA4LCAxKSk7CgkJTk9ORkFJTElORyhTVE9SRV9CWV9CSVRNQVNLKHVpbnQ2
NF90LCAsIDB4MjAwMDAwMjgsIDEsIDksIDEpKTsKCQlOT05GQUlMSU5HKFNUT1JFX0JZX0JJVE1B
U0sodWludDY0X3QsICwgMHgyMDAwMDAyOCwgMSwgMTAsIDEpKTsKCQlOT05GQUlMSU5HKFNUT1JF
X0JZX0JJVE1BU0sodWludDY0X3QsICwgMHgyMDAwMDAyOCwgMSwgMTEsIDEpKTsKCQlOT05GQUlM
SU5HKFNUT1JFX0JZX0JJVE1BU0sodWludDY0X3QsICwgMHgyMDAwMDAyOCwgMCwgMTIsIDEpKTsK
CQlOT05GQUlMSU5HKFNUT1JFX0JZX0JJVE1BU0sodWludDY0X3QsICwgMHgyMDAwMDAyOCwgMCwg
MTMsIDEpKTsKCQlOT05GQUlMSU5HKFNUT1JFX0JZX0JJVE1BU0sodWludDY0X3QsICwgMHgyMDAw
MDAyOCwgMCwgMTQsIDEpKTsKCQlOT05GQUlMSU5HKFNUT1JFX0JZX0JJVE1BU0sodWludDY0X3Qs
ICwgMHgyMDAwMDAyOCwgMiwgMTUsIDIpKTsKCQlOT05GQUlMSU5HKFNUT1JFX0JZX0JJVE1BU0so
dWludDY0X3QsICwgMHgyMDAwMDAyOCwgMSwgMTcsIDEpKTsKCQlOT05GQUlMSU5HKFNUT1JFX0JZ
X0JJVE1BU0sodWludDY0X3QsICwgMHgyMDAwMDAyOCwgMCwgMTgsIDEpKTsKCQlOT05GQUlMSU5H
KFNUT1JFX0JZX0JJVE1BU0sodWludDY0X3QsICwgMHgyMDAwMDAyOCwgMCwgMTksIDEpKTsKCQlO
T05GQUlMSU5HKFNUT1JFX0JZX0JJVE1BU0sodWludDY0X3QsICwgMHgyMDAwMDAyOCwgMSwgMjAs
IDEpKTsKCQlOT05GQUlMSU5HKFNUT1JFX0JZX0JJVE1BU0sodWludDY0X3QsICwgMHgyMDAwMDAy
OCwgMSwgMjEsIDEpKTsKCQlOT05GQUlMSU5HKFNUT1JFX0JZX0JJVE1BU0sodWludDY0X3QsICwg
MHgyMDAwMDAyOCwgMSwgMjIsIDEpKTsKCQlOT05GQUlMSU5HKFNUT1JFX0JZX0JJVE1BU0sodWlu
dDY0X3QsICwgMHgyMDAwMDAyOCwgMCwgMjMsIDEpKTsKCQlOT05GQUlMSU5HKFNUT1JFX0JZX0JJ
VE1BU0sodWludDY0X3QsICwgMHgyMDAwMDAyOCwgMCwgMjQsIDEpKTsKCQlOT05GQUlMSU5HKFNU
T1JFX0JZX0JJVE1BU0sodWludDY0X3QsICwgMHgyMDAwMDAyOCwgMCwgMjUsIDEpKTsKCQlOT05G
QUlMSU5HKFNUT1JFX0JZX0JJVE1BU0sodWludDY0X3QsICwgMHgyMDAwMDAyOCwgMSwgMjYsIDEp
KTsKCQlOT05GQUlMSU5HKFNUT1JFX0JZX0JJVE1BU0sodWludDY0X3QsICwgMHgyMDAwMDAyOCwg
MSwgMjcsIDEpKTsKCQlOT05GQUlMSU5HKFNUT1JFX0JZX0JJVE1BU0sodWludDY0X3QsICwgMHgy
MDAwMDAyOCwgMSwgMjgsIDEpKTsKCQlOT05GQUlMSU5HKFNUT1JFX0JZX0JJVE1BU0sodWludDY0
X3QsICwgMHgyMDAwMDAyOCwgMCwgMjksIDEpKTsKCQlOT05GQUlMSU5HKFNUT1JFX0JZX0JJVE1B
U0sodWludDY0X3QsICwgMHgyMDAwMDAyOCwgMCwgMzAsIDEpKTsKCQlOT05GQUlMSU5HKFNUT1JF
X0JZX0JJVE1BU0sodWludDY0X3QsICwgMHgyMDAwMDAyOCwgMCwgMzEsIDEpKTsKCQlOT05GQUlM
SU5HKFNUT1JFX0JZX0JJVE1BU0sodWludDY0X3QsICwgMHgyMDAwMDAyOCwgMSwgMzIsIDEpKTsK
CQlOT05GQUlMSU5HKFNUT1JFX0JZX0JJVE1BU0sodWludDY0X3QsICwgMHgyMDAwMDAyOCwgMCwg
MzMsIDEpKTsKCQlOT05GQUlMSU5HKFNUT1JFX0JZX0JJVE1BU0sodWludDY0X3QsICwgMHgyMDAw
MDAyOCwgMCwgMzQsIDEpKTsKCQlOT05GQUlMSU5HKFNUT1JFX0JZX0JJVE1BU0sodWludDY0X3Qs
ICwgMHgyMDAwMDAyOCwgMSwgMzUsIDEpKTsKCQlOT05GQUlMSU5HKFNUT1JFX0JZX0JJVE1BU0so
dWludDY0X3QsICwgMHgyMDAwMDAyOCwgMSwgMzYsIDEpKTsKCQlOT05GQUlMSU5HKFNUT1JFX0JZ
X0JJVE1BU0sodWludDY0X3QsICwgMHgyMDAwMDAyOCwgMSwgMzcsIDEpKTsKCQlOT05GQUlMSU5H
KFNUT1JFX0JZX0JJVE1BU0sodWludDY0X3QsICwgMHgyMDAwMDAyOCwgMCwgMzgsIDI2KSk7CgkJ
Tk9ORkFJTElORygqKHVpbnQzMl90KikweDIwMDAwMDMwID0gMHhiKTsKCQlOT05GQUlMSU5HKCoo
dWludDMyX3QqKTB4MjAwMDAwMzQgPSA0KTsKCQlOT05GQUlMSU5HKCoodWludDY0X3QqKTB4MjAw
MDAwMzggPSAweGZmZmZmZmZmZmZmZmZiZmYpOwoJCU5PTkZBSUxJTkcoKih1aW50NjRfdCopMHgy
MDAwMDA0MCA9IDB4MTAwKTsKCQlOT05GQUlMSU5HKCoodWludDY0X3QqKTB4MjAwMDAwNDggPSAw
eGExKTsKCQlOT05GQUlMSU5HKCoodWludDY0X3QqKTB4MjAwMDAwNTAgPSAzKTsKCQlOT05GQUlM
SU5HKCoodWludDMyX3QqKTB4MjAwMDAwNTggPSA0KTsKCQlOT05GQUlMSU5HKCoodWludDMyX3Qq
KTB4MjAwMDAwNWMgPSA2KTsKCQlOT05GQUlMSU5HKCoodWludDY0X3QqKTB4MjAwMDAwNjAgPSA3
KTsKCQlOT05GQUlMSU5HKCoodWludDMyX3QqKTB4MjAwMDAwNjggPSA4KTsKCQlOT05GQUlMSU5H
KCoodWludDE2X3QqKTB4MjAwMDAwNmMgPSAweGZjYmUpOwoJCU5PTkZBSUxJTkcoKih1aW50MTZf
dCopMHgyMDAwMDA2ZSA9IDApOwoJCU5PTkZBSUxJTkcoKih1aW50MzJfdCopMHgyMDAwMDA3MCA9
IDApOwoJCU5PTkZBSUxJTkcoKih1aW50MzJfdCopMHgyMDAwMDA3NCA9IDApOwoJCU5PTkZBSUxJ
TkcoKih1aW50NjRfdCopMHgyMDAwMDA3OCA9IDIpOwoJCXN5c2NhbGwoX19OUl9wZXJmX2V2ZW50
X29wZW4sIC8qYXR0cj0qLzB4MjAwMDAwMDB1bCwgLypwaWQ9Ki8wLCAvKmNwdT0qLyhpbnRwdHJf
dCktMSwgLypncm91cD0qLyhpbnRwdHJfdCktMSwgLypmbGFncz1QRVJGX0ZMQUdfRkRfT1VUUFVU
Ki8ydWwpOwoJCWJyZWFrOwoJY2FzZSAxOgovLyAgaW9fdXJpbmdfc2V0dXAgYXJndW1lbnRzOiBb
Ci8vICAgIGVudHJpZXM6IGludDMyID0gMHgyNWZhICg0IGJ5dGVzKQovLyAgICBwYXJhbXM6IHB0
cltpbm91dCwgaW9fdXJpbmdfcGFyYW1zXSB7Ci8vICAgICAgaW9fdXJpbmdfcGFyYW1zIHsKLy8g
ICAgICAgIHNxX2VudHJpZXM6IGludDMyID0gMHgwICg0IGJ5dGVzKQovLyAgICAgICAgY3FfZW50
cmllczogaW50MzIgPSAweDZiYyAoNCBieXRlcykKLy8gICAgICAgIGZsYWdzOiBpb191cmluZ19z
ZXR1cF9mbGFncyA9IDB4MiAoNCBieXRlcykKLy8gICAgICAgIHNxX3RocmVhZF9jcHU6IGludDMy
ID0gMHgwICg0IGJ5dGVzKQovLyAgICAgICAgc3FfdGhyZWFkX2lkbGU6IGludDMyID0gMHhhYSAo
NCBieXRlcykKLy8gICAgICAgIGZlYXR1cmVzOiBpbnQzMiA9IDB4MCAoNCBieXRlcykKLy8gICAg
ICAgIHdxX2ZkOiBmZF9pb191cmluZyAocmVzb3VyY2UpCi8vICAgICAgICByZXN2OiBidWZmZXI6
IHswMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMH0gKGxlbmd0aCAweGMpCi8vICAg
ICAgICBzcV9vZmY6IGlvX3NxcmluZ19vZmZzZXRzIHsKLy8gICAgICAgICAgaGVhZDogaW50MzIg
PSAweDAgKDQgYnl0ZXMpCi8vICAgICAgICAgIHRhaWw6IGludDMyID0gMHgwICg0IGJ5dGVzKQov
LyAgICAgICAgICByaW5nX21hc2s6IGludDMyID0gMHgwICg0IGJ5dGVzKQovLyAgICAgICAgICBy
aW5nX2VudHJpZXM6IGludDMyID0gMHgwICg0IGJ5dGVzKQovLyAgICAgICAgICBmbGFnczogaW50
MzIgPSAweDAgKDQgYnl0ZXMpCi8vICAgICAgICAgIGRyb3BwZWQ6IGludDMyID0gMHgwICg0IGJ5
dGVzKQovLyAgICAgICAgICBhcnJheTogaW50MzIgPSAweDAgKDQgYnl0ZXMpCi8vICAgICAgICAg
IHJlc3YxOiBpbnQzMiA9IDB4MCAoNCBieXRlcykKLy8gICAgICAgICAgdXNlcl9hZGRyOiBpbnQ2
NCA9IDB4MCAoOCBieXRlcykKLy8gICAgICAgIH0KLy8gICAgICAgIGNxX29mZjogaW9fY3FyaW5n
X29mZnNldHMgewovLyAgICAgICAgICBoZWFkOiBpbnQzMiA9IDB4MCAoNCBieXRlcykKLy8gICAg
ICAgICAgdGFpbDogaW50MzIgPSAweDAgKDQgYnl0ZXMpCi8vICAgICAgICAgIHJpbmdfbWFzazog
aW50MzIgPSAweDAgKDQgYnl0ZXMpCi8vICAgICAgICAgIHJpbmdfZW50cmllczogaW50MzIgPSAw
eDAgKDQgYnl0ZXMpCi8vICAgICAgICAgIG92ZXJmbG93OiBpbnQzMiA9IDB4MCAoNCBieXRlcykK
Ly8gICAgICAgICAgY3FlczogaW50MzIgPSAweDAgKDQgYnl0ZXMpCi8vICAgICAgICAgIGZsYWdz
OiBpbnQzMiA9IDB4MCAoNCBieXRlcykKLy8gICAgICAgICAgcmVzdjE6IGludDMyID0gMHgwICg0
IGJ5dGVzKQovLyAgICAgICAgICB1c2VyX2FkZHI6IGludDY0ID0gMHgwICg4IGJ5dGVzKQovLyAg
ICAgICAgfQovLyAgICAgIH0KLy8gICAgfQovLyAgXQovLyAgcmV0dXJucyBmZF9pb191cmluZwoJ
CU5PTkZBSUxJTkcoKih1aW50MzJfdCopMHgyMDAwMDE4NCA9IDB4NmJjKTsKCQlOT05GQUlMSU5H
KCoodWludDMyX3QqKTB4MjAwMDAxODggPSAyKTsKCQlOT05GQUlMSU5HKCoodWludDMyX3QqKTB4
MjAwMDAxOGMgPSAwKTsKCQlOT05GQUlMSU5HKCoodWludDMyX3QqKTB4MjAwMDAxOTAgPSAweGFh
KTsKCQlOT05GQUlMSU5HKCoodWludDMyX3QqKTB4MjAwMDAxOTggPSAtMSk7CgkJTk9ORkFJTElO
RyhtZW1zZXQoKHZvaWQqKTB4MjAwMDAxOWMsIDAsIDEyKSk7CgkJc3lzY2FsbChfX05SX2lvX3Vy
aW5nX3NldHVwLCAvKmVudHJpZXM9Ki8weDI1ZmEsIC8qcGFyYW1zPSovMHgyMDAwMDE4MHVsKTsK
CQlicmVhazsKCX0KCn0KaW50IG1haW4odm9pZCkKewoJCXN5c2NhbGwoX19OUl9tbWFwLCAvKmFk
ZHI9Ki8weDFmZmZmMDAwdWwsIC8qbGVuPSovMHgxMDAwLCAvKnByb3Q9Ki8wdWwsIC8qZmxhZ3M9
TUFQX0ZJWEVEfE1BUF9BTk9OWU1PVVN8TUFQX1BSSVZBVEUqLzB4MzJ1bCwgLypmZD0qLyhpbnRw
dHJfdCktMSwgLypvZmZzZXQ9Ki8wdWwpOwoJc3lzY2FsbChfX05SX21tYXAsIC8qYWRkcj0qLzB4
MjAwMDAwMDB1bCwgLypsZW49Ki8weDEwMDAwMDAsIC8qcHJvdD1QUk9UX1dSSVRFfFBST1RfUkVB
RHxQUk9UX0VYRUMqLzd1bCwgLypmbGFncz1NQVBfRklYRUR8TUFQX0FOT05ZTU9VU3xNQVBfUFJJ
VkFURSovMHgzMnVsLCAvKmZkPSovKGludHB0cl90KS0xLCAvKm9mZnNldD0qLzB1bCk7CglzeXNj
YWxsKF9fTlJfbW1hcCwgLyphZGRyPSovMHgyMTAwMDAwMHVsLCAvKmxlbj0qLzB4MTAwMCwgLypw
cm90PSovMHVsLCAvKmZsYWdzPU1BUF9GSVhFRHxNQVBfQU5PTllNT1VTfE1BUF9QUklWQVRFKi8w
eDMydWwsIC8qZmQ9Ki8oaW50cHRyX3QpLTEsIC8qb2Zmc2V0PSovMHVsKTsKCXNldHVwX3N5c2N0
bCgpOwoJc2V0dXBfY2dyb3VwcygpOwoJY29uc3QgY2hhciogcmVhc29uOwoJKHZvaWQpcmVhc29u
OwoJaWYgKChyZWFzb24gPSBzZXR1cF9iaW5mbXRfbWlzYygpKSkgewoJCWZwcmludGYoc3RkZXJy
LCAicmVwcm9kdWNlciBzZXR1cCBmYWlsZWQ6IGJpbmZtdF9taXNjOiAlc1xuIiwgcmVhc29uKTsK
CQlleGl0KDEpOwoJfQoJaWYgKChyZWFzb24gPSBzZXR1cF91c2IoKSkpIHsKCQlmcHJpbnRmKHN0
ZGVyciwgInJlcHJvZHVjZXIgc2V0dXAgZmFpbGVkOiBVU0IgaW5qZWN0aW9uOiAlc1xuIiwgcmVh
c29uKTsKCQlleGl0KDEpOwoJfQoJaWYgKChyZWFzb24gPSBzZXR1cF84MDIxNTQoKSkpIHsKCQlm
cHJpbnRmKHN0ZGVyciwgInJlcHJvZHVjZXIgc2V0dXAgZmFpbGVkOiA4MDIxNTQgaW5qZWN0aW9u
OiAlc1xuIiwgcmVhc29uKTsKCQlleGl0KDEpOwoJfQoJaWYgKChyZWFzb24gPSBzZXR1cF9zd2Fw
KCkpKSB7CgkJZnByaW50ZihzdGRlcnIsICJyZXByb2R1Y2VyIHNldHVwIGZhaWxlZDogc3dhcDog
JXNcbiIsIHJlYXNvbik7CgkJZXhpdCgxKTsKCX0KCWluc3RhbGxfc2Vndl9oYW5kbGVyKCk7Cglm
b3IgKHByb2NpZCA9IDA7IHByb2NpZCA8IDQ7IHByb2NpZCsrKSB7CgkJaWYgKGZvcmsoKSA9PSAw
KSB7CgkJCXVzZV90ZW1wb3JhcnlfZGlyKCk7CgkJCWRvX3NhbmRib3hfbm9uZSgpOwoJCX0KCX0K
CXNsZWVwKDEwMDAwMDApOwoJcmV0dXJuIDA7Cn0K
--0000000000001e23bd065ae590df--
