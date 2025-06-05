Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0BA23741;
	Thu,  5 Jun 2025 20:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749156415; cv=none; b=e6xYEo8SbkOYSkT4/tgmZDOpxjgpxpWQ5IBtyDShEjMkJgHD6n+o+woxcDEjipwTj5qoF1UossXvJiYR9eN76qVv29IX/ijBtTfaYNPV0OXBl4MhFJtDrGdz8ySXHESBVt3SEZtC68kHGrV+pU2k5/NbgkoDlCY8h//DGNJD1Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749156415; c=relaxed/simple;
	bh=Hlr370905V8Ek2aPjfS1m9DoljSAx5EWXPzLUhStZxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KppB9DJtfIzF6Nbte+ELPAEOiL1etc18EZMToOv1dgN03lVedCBCAKQXHbjDis1G8BihYJeK9zS2hr8GAKG0s+J3cc7/usIVafdWLHZXDe4xdIbNhhzOTBTuOJINxQshvCPyfw+645KvceVoaw3gT59/zsjzBm/eucvim449beE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQ71YviZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQ71YviZ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-442f9043f56so7950135e9.0;
        Thu, 05 Jun 2025 13:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749156411; x=1749761211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v90TTjumZn/dt8zm4k4Ba56Bpw7qpfIrz/0EHgrpLaw=;
        b=GQ71YviZakC8gSJakoXOV7nju5OkLt3iTrPx7b4C/e3CFSdTwRKFqDnr7VRvOJj7R0
         k0v1tbYCogsXSxm9euanaOMgC6ebAWaJO6du2kq4qdYFUSo3RL73XJqSITbVML4Osd3S
         A0psMoWPmaYa74Aj1AmcIkQbFuaj7UsndTD24oU73TyMDGmP7nOeT4z3vXKoz0jwIH8F
         duGgf6jtuTutoaCqlrx/RLnBcNr4AoR4ZK0ySYShhvDEmp60+3B8tD/s9Par0OhyURWR
         gJMZ81XV6y1FRtWTjniNNmFy+9QYVFxw26aghUVeuqdGgshdvr9z8ZEhGuntsqbRt/qa
         omuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749156411; x=1749761211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v90TTjumZn/dt8zm4k4Ba56Bpw7qpfIrz/0EHgrpLaw=;
        b=WmzmqZ/KFyp+6g36yDqtj/mUS81DZO+i/yUkZnirkYux4ZAN4LyvaZOnb+0NtmBYJH
         NGmYG/rHWZVLH+FJnfB/wvxc2FKle8KaqxUJoqsmNmn55DXMPJfz/5TkUGmQ9jgsYMkR
         Twk3ljVUbt1LixVH8oeEP7AahfOPH0Kogc0bwXUFUOfxRMNXp7j/J3wUS1/QwlS9rILX
         IbyA1VPrz2kktMsPP1sQQgPcnXfNfcB6FuKofKyeYHafQOkMSx/+O68msMO9+BTf+MgF
         KlnPpk1zsUs0XV81cG6na3crOUTJkZJm4H4E7wUYSXHqOdOagscYv3MtpAx5bkGUjR5L
         ag+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqjtei5rVkXfXvwPVRvMSXz+Xr0BmU5+D/YVkVJKUmDRGBrH4D+9kgjFevMlwSQ+viEIGXX/msSwEU++E=@vger.kernel.org, AJvYcCXmH8BVhyWsHHAeDa8mm4hz45HA9ZuHBSQWtLsYNxK14edchau1LiD5jZVfyO/f/bdS/xNzAIaNxPP14usAD3PKRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwphGiEo9DvbnWpRS8qcBXdwRb2SnfjRvRrIpMkl3uwL1ASiEFt
	sF2JDU1Ltn0kpUck5YdHf8a+iZEPXNlYbV2LnEghVTj2pGsehraP/iqwukOETlVpGFD/F5MrbiU
	ifIroP0lBZw662H/Pco7pd/yeOZtKMA8=
X-Gm-Gg: ASbGncuM/bGQC0/cAqwE5v85hSi6Mdpobo3lO3G17mke1+IQvfJmichgVUTaxd/UcgE
	p0wG0bJ0UgvbU/UQwJPLQLhDA11V//r1P4EMJ08CXl842U1Hjs/mIwPQO6toRRH/dvgUxONQnC/
	2v/QoRqbDOxOSI0CYiy7bvy4DT5JITYfyWoTcTqvam+/qQu/NG
X-Google-Smtp-Source: AGHT+IE0AU5quGK0KVI25Bdc5fbSP35ZBxoSww0sLdLWt3JoGcp1IL7AsydK/axu0lYTgOctphTfW5SrTC/Mb2HRpLE=
X-Received: by 2002:a05:6000:40c7:b0:3a4:f7db:6ff7 with SMTP id
 ffacd0b85a97d-3a5319b49c3mr559209f8f.52.1749156411187; Thu, 05 Jun 2025
 13:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604171554.3909897-1-kan.liang@linux.intel.com>
 <CAADnVQKjyzdNVR_+WCMzORPJAX00tD3HK0vaCz13ZprWaG72Tg@mail.gmail.com>
 <d5fcf34f-63fe-451b-89ad-621c38981709@linux.intel.com> <CAADnVQ+N5UaBwLjtLGHAe1PCjpRzxxcFL45gbb0eHMDZD5+X6A@mail.gmail.com>
 <3f8b0b58-3b48-470e-b8ff-a71a26370bc3@linux.intel.com>
In-Reply-To: <3f8b0b58-3b48-470e-b8ff-a71a26370bc3@linux.intel.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Jun 2025 13:46:40 -0700
X-Gm-Features: AX0GCFuGJHp8-D7LlGPjVA94oYoimjDIPbQUA2yAlCGEG1TFDnUJUe6M-idLojo
Message-ID: <CAADnVQKRJKsG08KkEriuBQop0LgDr+c9rkNE6MUh_n3rzZoXVQ@mail.gmail.com>
Subject: Re: [PATCH V3] perf: Fix the throttle error of some clock events
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, LKML <linux-kernel@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, Stephane Eranian <eranian@google.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, Leo Yan <leo.yan@arm.com>, 
	Aishwarya TCV <aishwarya.tcv@arm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 1:24=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2025-06-05 2:45 p.m., Alexei Starovoitov wrote:
> > On Thu, Jun 5, 2025 at 6:46=E2=80=AFAM Liang, Kan <kan.liang@linux.inte=
l.com> wrote:
> >>
> >>
> >>
> >> On 2025-06-04 7:21 p.m., Alexei Starovoitov wrote:
> >>> On Wed, Jun 4, 2025 at 10:16=E2=80=AFAM <kan.liang@linux.intel.com> w=
rote:
> >>>>
> >>>> From: Kan Liang <kan.liang@linux.intel.com>
> >>>>
> >>>> Both ARM and IBM CI reports RCU stall, which can be reproduced by th=
e
> >>>> below perf command.
> >>>>   perf record -a -e cpu-clock -- sleep 2
> >>>>
> >>>> The issue is introduced by the generic throttle patch set, which
> >>>> unconditionally invoke the event_stop() when throttle is triggered.
> >>>>
> >>>> The cpu-clock and task-clock are two special SW events, which rely o=
n
> >>>> the hrtimer. The throttle is invoked in the hrtimer handler. The
> >>>> event_stop()->hrtimer_cancel() waits for the handler to finish, whic=
h is
> >>>> a deadlock. Instead of invoking the stop(), the HRTIMER_NORESTART sh=
ould
> >>>> be used to stop the timer.
> >>>>
> >>>> There may be two ways to fix it.
> >>>> - Introduce a PMU flag to track the case. Avoid the event_stop in
> >>>>   perf_event_throttle() if the flag is detected.
> >>>>   It has been implemented in the
> >>>>   https://lore.kernel.org/lkml/20250528175832.2999139-1-kan.liang@li=
nux.intel.com/
> >>>>   The new flag was thought to be an overkill for the issue.
> >>>> - Add a check in the event_stop. Return immediately if the throttle =
is
> >>>>   invoked in the hrtimer handler. Rely on the existing HRTIMER_NORES=
TART
> >>>>   method to stop the timer.
> >>>>
> >>>> The latter is implemented here.
> >>>>
> >>>> Move event->hw.interrupts =3D MAX_INTERRUPTS before the stop(). It m=
akes
> >>>> the order the same as perf_event_unthrottle(). Except the patch, no =
one
> >>>> checks the hw.interrupts in the stop(). There is no impact from the
> >>>> order change.
> >>>>
> >>>> Reported-by: Leo Yan <leo.yan@arm.com>
> >>>> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> >>>> Closes: https://lore.kernel.org/lkml/20250527161656.GJ2566836@e13258=
1.arm.com/
> >>>> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> >>>> Closes: https://lore.kernel.org/lkml/djxlh5fx326gcenwrr52ry3pk4wxmug=
u4jccdjysza7tlc5fef@ktp4rffawgcw/
> >>>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> >>>> Closes: https://lore.kernel.org/lkml/8e8f51d8-af64-4d9e-934b-c0ee9f1=
31293@linux.ibm.com/
> >>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >>>
> >>> It seems the patch fixes one issue and introduces another ?
> >>>
> >>> Looks like the throttle event is sticky.
> >>> Once it's reached the perf_event no longer works ?
> >>
> >> No. It should still work even the throttle is triggered.
> >>
> >> sdp@d404e6bce080:~$ sudo bash -c 'echo 10 >
> >> /proc/sys/kernel/perf_event_max_sample_rate'
> >> sdp@d404e6bce080:~$ sudo perf record -a -e cpu-clock -c10000 -- sleep =
1
> >> [ perf record: Woken up 1 times to write data ]
> >> [ perf record: Captured and wrote 0.559 MB perf.data (584 samples) ]
> >
> > With the patch applied above command hangs in my VM:
> >
> > # perf record -a -e cpu-clock -c10000 -- sleep 1
> > [   43.656855] hrtimer: interrupt took 21640 ns
> > [   68.561052] watchdog: BUG: soft lockup - CPU#0 stuck for 41s! [perf:=
2253]
> > [   68.561056] Modules linked in: bpf_preload
> > [   68.561060] CPU: 0 UID: 0 PID: 2253 Comm: perf Not tainted
> > 6.15.0-12294-gc89e5202e569 #1172 PREEMPT
> > [   68.561062] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> > [   68.561063] RIP: 0010:handle_softirqs+0x77/0x2a0
> > [   68.561070] Code: 6b 96 02 00 01 00 00 bd 0a 00 00 00 44 89 64 24
> > 14 89 6c 24 10 40 88 7c 24 04 31 c0 65 66 89 05 5f 6b 96 02 fb bb ff
> > ff ff ff <48> c7 c0 c0 f
> > [   68.561071] RSP: 0018:ffa0000000003fa0 EFLAGS: 00000246
> > [   68.561072] RAX: 0000000000000000 RBX: 00000000ffffffff RCX: 0000000=
0000006e0
> > [   68.561073] RDX: 0000000000000007 RSI: ff1100010212e100 RDI: 0000000=
000000000
> > [   68.561074] RBP: 000000000000000a R08: 0000000000000000 R09: 7ffffff=
fffffffff
> > [   68.561074] R10: 00000005a3af2140 R11: 0000000000004601 R12: 0000000=
000400100
> > [   68.561075] R13: 0000000000000000 R14: 0000000000000002 R15: 0000000=
000000000
> > [   68.561111] FS:  00007fa1b536f780(0000) GS:ff110004abe26000(0000)
> > knlGS:0000000000000000
> > [   68.561112] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   68.561113] CR2: 0000000001c67a30 CR3: 000000010f2f3003 CR4: 0000000=
0003716f0
> > [   68.561113] Call Trace:
> > [   68.561170]  <IRQ>
> > [   68.561174]  irq_exit_rcu+0x91/0xb0
> > [   68.561176]  sysvec_apic_timer_interrupt+0x71/0x90
> > [   68.561181]  </IRQ>
> > [   68.561181]  <TASK>
> > [   68.561182]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> > [   68.561184] RIP: 0010:generic_exec_single+0x33/0x120
> > [   68.561188] Code: 65 39 3d 5c 4d 89 02 74 28 3b 3d b8 f5 17 02 0f
> > 83 de 00 00 00 89 f8 48 0f a3 05 d8 f1 17 02 0f 83 ce 00 00 00 e8 bd
> > fe ff ff <31> c0 5b 5d 9
> > [   68.561189] RSP: 0018:ffa00000025a3cc0 EFLAGS: 00000206
> > [   68.561190] RAX: 0000000000000000 RBX: ffffffff8145b310 RCX: ff11000=
4abe26000
> > [   68.561190] RDX: 0000000000000007 RSI: 0000000000000000 RDI: ff11000=
42fa26540
> > [   68.561191] RBP: 0000000000000202 R08: 0000000000000000 R09: 0000000=
000000000
> > [   68.561191] R10: ffa00000025a3ee0 R11: 0000000000000000 R12: ffa0000=
0025a3d40
> > [   68.561192] R13: ff11000100881220 R14: ff11000100880fc0 R15: 0000000=
000000000
> > [   68.561192]  ? sw_perf_event_destroy+0x70/0x70
> > [   68.561197]  smp_call_function_single+0xc4/0x110
> > [   68.561199]  ? sw_perf_event_destroy+0x70/0x70
> > [   68.561200]  event_function_call+0x160/0x170
> > [   68.561202]  ? ctx_resched+0x2d0/0x2d0
> > [   68.561205]  ? perf_event_set_state+0x60/0x60
> > [   68.561206]  ? _perf_event_disable+0x50/0x50
> > [   68.561208]  perf_event_for_each_child+0x37/0x80
> > [   68.561209]  ? _perf_event_disable+0x50/0x50
> > [   68.561211]  _perf_ioctl+0x1df/0xad0
> > [   68.561213]  ? __set_cpus_allowed_ptr+0x71/0x80
> > [   68.561216]  ? avc_has_perm+0x72/0x160
> > [   68.561219]  ? ldsem_down_write+0x1bb/0x1fc
> > [   68.561222]  perf_ioctl+0x42/0x70
> > [   68.561224]  __x64_sys_ioctl+0x8f/0xd0
> > [   68.561226]  do_syscall_64+0x46/0x160
> > [   68.561228]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> >
> > but only after a fresh boot.
> >
> > If I run bpf selftests before that it works.
> > Like test_progs -t stacktrace_build_id_nmi
> > followed by the same
> > perf record -a -e cpu-clock ..
> > it works fine.
> >
>
> There should be a bug in V3. When stops in the throttle, the event
> should not be updated, stop(event, 0). But the cpu_clock_event_stop()
> doesn't handle the flag. That changes the behavior a little bit.
>
> Could you please try the below patch and see if it helps?
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index cd85b1820e7d..b6c57ba24e78 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2656,8 +2656,8 @@ static void perf_event_unthrottle(struct
> perf_event *event, bool start)
>
>  static void perf_event_throttle(struct perf_event *event)
>  {
> -       event->pmu->stop(event, 0);
>         event->hw.interrupts =3D MAX_INTERRUPTS;
> +       event->pmu->stop(event, 0);
>         if (event =3D=3D event->group_leader)
>                 perf_log_throttle(event, 0);
>  }
> @@ -11777,7 +11777,12 @@ static void perf_swevent_cancel_hrtimer(struct
> perf_event *event)
>  {
>         struct hw_perf_event *hwc =3D &event->hw;
>
> -       if (is_sampling_event(event)) {
> +       /*
> +        * The throttle can be triggered in the hrtimer handler.
> +        * The HRTIMER_NORESTART should be used to stop the timer,
> +        * rather than hrtimer_cancel(). See perf_swevent_hrtimer()
> +        */
> +       if (is_sampling_event(event) && (hwc->interrupts !=3D MAX_INTERRU=
PTS)) {
>                 ktime_t remaining =3D hrtimer_get_remaining(&hwc->hrtimer=
);
>                 local64_set(&hwc->period_left, ktime_to_ns(remaining));
>
> @@ -11832,7 +11837,8 @@ static void cpu_clock_event_start(struct
> perf_event *event, int flags)
>  static void cpu_clock_event_stop(struct perf_event *event, int flags)
>  {
>         perf_swevent_cancel_hrtimer(event);
> -       cpu_clock_event_update(event);
> +       if (flags & PERF_EF_UPDATE)
> +               cpu_clock_event_update(event);
>  }

Nope. The last hunk didn't make any difference.
Same soft lockup.
