Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3358F27B4E1;
	Thu,  5 Jun 2025 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749149160; cv=none; b=DEtIN+ozEwmxvusBxfSYEb0LBej9x/4kK3r8R91zj4TJsWKYPxIS5o916QHSAOlXkkEngkxeUAr1o3tapiSfiDDn2G8YmUJX+P5rF4eN3DHoXZrN6Rle4/NsvlKjQe90VWbjFdGffwe0rdcDeENHWJC/WZuBMLajBWbBBtA+xaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749149160; c=relaxed/simple;
	bh=IfEOWw4oAuKU+uUTXn/k/EyLrClpGST0VfaZ/xjH+L8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7UEqX/ZZboZqycPkoIpcrILsvX42DQSUAXOl7UvvYV3MgbwD1IK6bMBXkjE/n7BYfOCKgt6k9tOBSHalDux3avG1+dDSOyv3eqmvIW7n4h26aZSBSc/bFm/CeZS5+Nrm/2WTUaXGFO+TJqAG7UKFC5gOXHEJPO7TB4iU6zAgZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbXSCJvh; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbXSCJvh"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso875873f8f.0;
        Thu, 05 Jun 2025 11:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749149156; x=1749753956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zC0kg2kxlsnPxrdzCoB+Qdgc18w9zN0W/B7+UBoWraA=;
        b=GbXSCJvhPL7Z6gL02YgD4ipcuObvPaNCKLyyRoISsNxafJ1F1b1rV1secxKDnMF9fG
         EzuIb7vZ03GPSeCc3QdtU0w8c/AeQEHZy83ggYpq2F7zqnG/0YTUIaV7w8xu7MUL+XpF
         T2RgVirGKGkLwNl4CUbvv9ugMFxBZBu4VbQ0LMc4FncsfOJbzyxQdnQleAb82Zk/wbap
         AydeZgz138goM7tiJ4VBVkB5fUgIptGOjJcjKf85/7AOCv08JJNBHVVYt7xDOSxNfcPw
         /pnbWS3pkw8AQkU1SEV1ht85nx7RfYYJDESHqkZUUv8Zh+Ac3AyHOuuD/r04yfrwMv4u
         OMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749149156; x=1749753956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zC0kg2kxlsnPxrdzCoB+Qdgc18w9zN0W/B7+UBoWraA=;
        b=NC0lprem5oH+zyAHmRoLBsBklmnQD7wYRXYVl2y6sdyxPSpzzJL3HMFTjPOfsRctVp
         vyDA2xD8MsZlynl8PqfUPz8R/MJHDXke8KVIVy4Rlu9EAKPkEVplZSTr7uC42glgk5BO
         h97Q97WkYyI0sOh/WMj6L+RUxtuL+dD94LN9OyRCad2UJmZXt2uz/ZNZL7PQn5JMKnPd
         GZic4RNzRfwrg/LrD97VDVhISQIifdymFikbhenUY4BlBDsqFtfcz4YUF78DU0/tARzY
         cduEys+HSgUBRgN1+MsXBvYz4fPyO621g0e19toZZYkXqY39T2QGTS9+Ac1w3FLxhbKN
         vFsw==
X-Forwarded-Encrypted: i=1; AJvYcCVj8KK+E0yxh5ST5Qd0gilsqyDNDIQaJxwoitf5SMvnDfFy9c5lfgOb74wxricsQitHa+7iuFsHJIyVjwO/8Z6MOg==@vger.kernel.org, AJvYcCWlgKN1tqeSDLrr8ZZAzvoKIrZT8J7gp/UjHI6VUfnpoFYc0h8J+Av7o5ZpyA2h7s0ULGTKW1hdDlEMPZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh0MLoyQ2QF3Qm5cUWsOg9AJLvXZ6f4cnOCZ7CExYto1zbHVIE
	heDZdj97Q9FirSE38uyM7QPr0UQETiw/JtPyapk1/QlyQI394+F/f078NRuFcGpAHHpsbtWw7lE
	KvhDpTNIzMSFZnUj4rHe7DxnKYpK9SqjIQsu2
X-Gm-Gg: ASbGncskgqS40oBYee1Kb1qycawW2xkEuHKV+BGglUatSw/fkrXEpzBmrGEonwE911l
	k0Js/DPA5wKTljCJ2Mzjbi2vcQHLbLx0JubZSdnZz2aViFbUTD6KW3AEJfSwK52VhuBgDdO07JW
	OdMauNh1UXyEJICMRRp48WAtodQJwCBzpgwZEcByytdLAmKoit
X-Google-Smtp-Source: AGHT+IGIFN0E8jVe7fMGKjSxSKE9zRb+8J/69bdE9AbBtRcgo2CHsKfD/x+LbIT7C+SmvN0Abk1G8Y4aN/ASXPpwdGk=
X-Received: by 2002:a05:6000:18ac:b0:3a4:dd8e:e16b with SMTP id
 ffacd0b85a97d-3a531ca742dmr203815f8f.20.1749149156299; Thu, 05 Jun 2025
 11:45:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604171554.3909897-1-kan.liang@linux.intel.com>
 <CAADnVQKjyzdNVR_+WCMzORPJAX00tD3HK0vaCz13ZprWaG72Tg@mail.gmail.com> <d5fcf34f-63fe-451b-89ad-621c38981709@linux.intel.com>
In-Reply-To: <d5fcf34f-63fe-451b-89ad-621c38981709@linux.intel.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Jun 2025 11:45:44 -0700
X-Gm-Features: AX0GCFtYMpyiTReW-K0iqMGCP74NZiJm9_57yh6AqFrV025tx5BG463u-lMbS20
Message-ID: <CAADnVQ+N5UaBwLjtLGHAe1PCjpRzxxcFL45gbb0eHMDZD5+X6A@mail.gmail.com>
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

On Thu, Jun 5, 2025 at 6:46=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2025-06-04 7:21 p.m., Alexei Starovoitov wrote:
> > On Wed, Jun 4, 2025 at 10:16=E2=80=AFAM <kan.liang@linux.intel.com> wro=
te:
> >>
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> Both ARM and IBM CI reports RCU stall, which can be reproduced by the
> >> below perf command.
> >>   perf record -a -e cpu-clock -- sleep 2
> >>
> >> The issue is introduced by the generic throttle patch set, which
> >> unconditionally invoke the event_stop() when throttle is triggered.
> >>
> >> The cpu-clock and task-clock are two special SW events, which rely on
> >> the hrtimer. The throttle is invoked in the hrtimer handler. The
> >> event_stop()->hrtimer_cancel() waits for the handler to finish, which =
is
> >> a deadlock. Instead of invoking the stop(), the HRTIMER_NORESTART shou=
ld
> >> be used to stop the timer.
> >>
> >> There may be two ways to fix it.
> >> - Introduce a PMU flag to track the case. Avoid the event_stop in
> >>   perf_event_throttle() if the flag is detected.
> >>   It has been implemented in the
> >>   https://lore.kernel.org/lkml/20250528175832.2999139-1-kan.liang@linu=
x.intel.com/
> >>   The new flag was thought to be an overkill for the issue.
> >> - Add a check in the event_stop. Return immediately if the throttle is
> >>   invoked in the hrtimer handler. Rely on the existing HRTIMER_NORESTA=
RT
> >>   method to stop the timer.
> >>
> >> The latter is implemented here.
> >>
> >> Move event->hw.interrupts =3D MAX_INTERRUPTS before the stop(). It mak=
es
> >> the order the same as perf_event_unthrottle(). Except the patch, no on=
e
> >> checks the hw.interrupts in the stop(). There is no impact from the
> >> order change.
> >>
> >> Reported-by: Leo Yan <leo.yan@arm.com>
> >> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> >> Closes: https://lore.kernel.org/lkml/20250527161656.GJ2566836@e132581.=
arm.com/
> >> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> >> Closes: https://lore.kernel.org/lkml/djxlh5fx326gcenwrr52ry3pk4wxmugu4=
jccdjysza7tlc5fef@ktp4rffawgcw/
> >> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> >> Closes: https://lore.kernel.org/lkml/8e8f51d8-af64-4d9e-934b-c0ee9f131=
293@linux.ibm.com/
> >> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >
> > It seems the patch fixes one issue and introduces another ?
> >
> > Looks like the throttle event is sticky.
> > Once it's reached the perf_event no longer works ?
>
> No. It should still work even the throttle is triggered.
>
> sdp@d404e6bce080:~$ sudo bash -c 'echo 10 >
> /proc/sys/kernel/perf_event_max_sample_rate'
> sdp@d404e6bce080:~$ sudo perf record -a -e cpu-clock -c10000 -- sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.559 MB perf.data (584 samples) ]

With the patch applied above command hangs in my VM:

# perf record -a -e cpu-clock -c10000 -- sleep 1
[   43.656855] hrtimer: interrupt took 21640 ns
[   68.561052] watchdog: BUG: soft lockup - CPU#0 stuck for 41s! [perf:2253=
]
[   68.561056] Modules linked in: bpf_preload
[   68.561060] CPU: 0 UID: 0 PID: 2253 Comm: perf Not tainted
6.15.0-12294-gc89e5202e569 #1172 PREEMPT
[   68.561062] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   68.561063] RIP: 0010:handle_softirqs+0x77/0x2a0
[   68.561070] Code: 6b 96 02 00 01 00 00 bd 0a 00 00 00 44 89 64 24
14 89 6c 24 10 40 88 7c 24 04 31 c0 65 66 89 05 5f 6b 96 02 fb bb ff
ff ff ff <48> c7 c0 c0 f
[   68.561071] RSP: 0018:ffa0000000003fa0 EFLAGS: 00000246
[   68.561072] RAX: 0000000000000000 RBX: 00000000ffffffff RCX: 00000000000=
006e0
[   68.561073] RDX: 0000000000000007 RSI: ff1100010212e100 RDI: 00000000000=
00000
[   68.561074] RBP: 000000000000000a R08: 0000000000000000 R09: 7ffffffffff=
fffff
[   68.561074] R10: 00000005a3af2140 R11: 0000000000004601 R12: 00000000004=
00100
[   68.561075] R13: 0000000000000000 R14: 0000000000000002 R15: 00000000000=
00000
[   68.561111] FS:  00007fa1b536f780(0000) GS:ff110004abe26000(0000)
knlGS:0000000000000000
[   68.561112] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   68.561113] CR2: 0000000001c67a30 CR3: 000000010f2f3003 CR4: 00000000003=
716f0
[   68.561113] Call Trace:
[   68.561170]  <IRQ>
[   68.561174]  irq_exit_rcu+0x91/0xb0
[   68.561176]  sysvec_apic_timer_interrupt+0x71/0x90
[   68.561181]  </IRQ>
[   68.561181]  <TASK>
[   68.561182]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   68.561184] RIP: 0010:generic_exec_single+0x33/0x120
[   68.561188] Code: 65 39 3d 5c 4d 89 02 74 28 3b 3d b8 f5 17 02 0f
83 de 00 00 00 89 f8 48 0f a3 05 d8 f1 17 02 0f 83 ce 00 00 00 e8 bd
fe ff ff <31> c0 5b 5d 9
[   68.561189] RSP: 0018:ffa00000025a3cc0 EFLAGS: 00000206
[   68.561190] RAX: 0000000000000000 RBX: ffffffff8145b310 RCX: ff110004abe=
26000
[   68.561190] RDX: 0000000000000007 RSI: 0000000000000000 RDI: ff1100042fa=
26540
[   68.561191] RBP: 0000000000000202 R08: 0000000000000000 R09: 00000000000=
00000
[   68.561191] R10: ffa00000025a3ee0 R11: 0000000000000000 R12: ffa00000025=
a3d40
[   68.561192] R13: ff11000100881220 R14: ff11000100880fc0 R15: 00000000000=
00000
[   68.561192]  ? sw_perf_event_destroy+0x70/0x70
[   68.561197]  smp_call_function_single+0xc4/0x110
[   68.561199]  ? sw_perf_event_destroy+0x70/0x70
[   68.561200]  event_function_call+0x160/0x170
[   68.561202]  ? ctx_resched+0x2d0/0x2d0
[   68.561205]  ? perf_event_set_state+0x60/0x60
[   68.561206]  ? _perf_event_disable+0x50/0x50
[   68.561208]  perf_event_for_each_child+0x37/0x80
[   68.561209]  ? _perf_event_disable+0x50/0x50
[   68.561211]  _perf_ioctl+0x1df/0xad0
[   68.561213]  ? __set_cpus_allowed_ptr+0x71/0x80
[   68.561216]  ? avc_has_perm+0x72/0x160
[   68.561219]  ? ldsem_down_write+0x1bb/0x1fc
[   68.561222]  perf_ioctl+0x42/0x70
[   68.561224]  __x64_sys_ioctl+0x8f/0xd0
[   68.561226]  do_syscall_64+0x46/0x160
[   68.561228]  entry_SYSCALL_64_after_hwframe+0x4b/0x53

but only after a fresh boot.

If I run bpf selftests before that it works.
Like test_progs -t stacktrace_build_id_nmi
followed by the same
perf record -a -e cpu-clock ..
it works fine.
