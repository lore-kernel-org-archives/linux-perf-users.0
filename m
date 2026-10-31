Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793464261;
	b=hbR28eoTeRjA7iF6wi9u+oyYk3nCQGuuJP2irBfuUzI1DhkJRAIPbMGOZ5i4TMUQydyI
	 cduq+cPW/A62K/66eoyfJI5AyUwGhWjBf6rvCZmGWJ04SQc4FFwJ/FjdBrn50/bP7rBQt
	 GeAV2eJ61ftw8e/w7/95G7/HAmc0sWgBTCxBteaXb5yQYgx+Gex2KiCqeWmTKpTVxiQT9
	 I8COp9t78PzndlKavNEZGy8nNqsKg+JoaMkAIyPrGRYxxInstct2u3DptZesDYAcPK7Fn
	 JRj6zAdhGxATBYb3X9PzKNwubTu5Fsr8nz9hOUjPAGj38NaW/HPur7yhCHfc/bw+PMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793464261;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=h3FR2IS2S6bgNUEv3zpQMMPzyfM3xCByYaTG2ccnwnU=;
	b=fPD4Hma2AHiSo83EpemLe9KPuyL9Xpk5R8f0SM2W4zzu6b4tafWT4nx66l4uyRu5X48G
	 Kb5rxmIrr+XtBxb+wBN5kQkRQWkX0hmOEeyyx9ZuIw7WR2wYSyOCzyhJA/F/jlk5fOjc9
	 UD27k4ekUdUMozq3/AixkhMh4un6R/qWtR/uBV8Cj7l/vcYzTQBGare0gO5KSsK2bkngL
	 C+AGz9wxyMsnIe9admeLdBL9JGQ4mZyb1hVFo230Jbk6HGsAM/HK80kxxvyiIUcRrCa8C
	 v+YdtVVCDHblsEmiZSmOyeZQDXor/MUrKO1qtM/v8IFsJwmu2OwRA5i9ppCy0Dq7YOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q3DHX15e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA539606A31C
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Oct 2026 16:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA539606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q3DHX15e
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so2547113a12.2
        for <linux-perf-users@vger.kernel.org>; Sat, 31 Oct 2026 09:31:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793464259; cv=none;
        d=google.com; s=arc-20260327;
        b=IAUYv1rYxRWnki2a/uUK8hVC5o6TtxsSkNiHqAg5ni74IuiSvmEefg/HqOYAz+1nB+
         AX0L8Z4FpQw3u24HllTzWqhWLiqRON9HQ7cWqKTcCqjO8DPnYyoLs4o65tpfHghvO5Qa
         /Fh+t3ipPYJbLg7Ehk8lULn3VvHfiSEEmxIvQp51lAmGXRbwIhI6VGXgPS+t+KEg2r+m
         QHmxyAORsgekrzo5SBsCaFXNpppM906n3yqSip9hvKWt0cKHAvBq6KUvV9e4ARLth10j
         13VdMr+shYHuHQrd+dVHxzqrivm2b+JRqSmnje/9AZlsQibVxEuTxjGeeot4JaWl9Vxq
         PM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h3FR2IS2S6bgNUEv3zpQMMPzyfM3xCByYaTG2ccnwnU=;
        fh=zZ+ltLW+PR5h012MmBr0Pl6ao94BHuQ68IQMMACc39M=;
        b=D72ntTm/ignZw5hUgmZGlm5uxzOIAvyvkhXKPncNTsOqskAd0yqrBP2xrlaqwUpXeR
         4NmwUm3z5m4dKKCRXgZCH7oRAphp7J8VuToeXvYAtYKHTvCHPASpOeAdt0GtUgHREsgA
         gogu+PWs1RpX0ysduZCBFN7Ic8gCP1Nzqt87uoFvMZu4ObIQxgqAxfUnYIZUKsNu/law
         v8wJLuUKD3D0qa2DsXvf6gLZSjvOLeEr0hBgQQWc427weBhIpB/ZZEFXdmmF7KRCAl8R
         hT7HJJ7o/nRNIWz2j5FLjvh43iKtN+5zg0G19QQE4Anq77tP8xpYeFBJPSHdcW3pSR5I
         35Og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793464259; x=1794069059; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h3FR2IS2S6bgNUEv3zpQMMPzyfM3xCByYaTG2ccnwnU=;
        b=q3DHX15eIThbgHInvMNvQrW6Tie1GGu0x3FPkM2KllrQjg0pl9KjsRICTuVoYAVQ1O
         EJUMxOTzt1nziBF6Apjk6KHi5tb8hrc1X61Y9fmAK6j81sae5Sa4d6CSeD8vmu2aQ1xF
         cI1ajkb6Qj4fTOch9qNPtrxnexboroszk6OIZGBQZy2evMWAMIevXmNpqAxXw4yrDgM0
         2WzNDrzg6q9W7Ie+HhyBHkxnwY42A12zde3BF6HCyZwdLppSkWs8Z4QjCI0kMcDF1Y8B
         x2QxYVeo/mjucr8qQtNxcinE40BSaL/YiGARHQQEVBw+RDJVNGN3CGPKHpWjB6h7zoB7
         58Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793464259; x=1794069059;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h3FR2IS2S6bgNUEv3zpQMMPzyfM3xCByYaTG2ccnwnU=;
        b=rATcjTVkwUB2ItRnwFHyLB/zKuD7uVVRsQjoYi0PBsX9WkC9pOumlI144anhVdIJR/
         J6YoPLhnZ6praXzNfPWWw1rZIHDkZEWGH48hWyE6pNtJQBcjPlTB+C2wU47EXSI3zG3/
         ejzqFSccITxgTK2Osz3WOoGPv+tUmbCtdkZz9+1SzeFCIchAdZ/eRltsCxeYy7n1PN1C
         dzjLvU7o/oGtGGpxN1XBtnXjJw+vWpsnwtYKuwqGqf9b+ZcERoGB1uSE+E1lFOciokmq
         i6z268c9P2fQbkaVIcGCIzsLr5Ni6cR6Zb64Sz/flL1gbugs2UuQ1JEka2z7ma3Kq2hq
         qkeA==
X-Forwarded-Encrypted: i=1; AKwUvBx6aO4jHv9q0mST/B33GZ8PaOO+4TCjzDSdaAM2Y+Jina/+E7iqJoLev4UslwV6UlWACuvrWfSiGn/B0bXmHMsm@vger.kernel.org
X-Gm-Message-State: AFq9FYIq+8R7FwE3ZjNwqtOpjAUGusmYIkxqFVfF7ZPt+PcxuE2fURyo
	JFdbhDeZRG94gyYUI88qFMKs0WPMVlFwHdQf//b7bny1dwbNVToLUauokww6qqMN2PaI3575Tld
	MV6Lo2IoMlwjGZQregIk0KhEe2gTiynA=
X-Gm-Gg: AYBFou0092v2NL6nBmupRDyXvtBm/nODLfBzSqHc5fPKg+2kLrgi2+eiSKbVlUdahVO
	oKtUZ2Jf4EO7pnbWFAka1KtquIOp6S24CcXKQIbqRmaY33xLv7HqkwsRvyQSvqyKDhhZum6Oi8x
	1qC62RaDDRoUwWWB/nz8JUyX77Q/osfZ8VvUo3Kq3fFJZ3hLU/0azwmpwTipAOIVIN5BJnkXfhX
	IFhxkP3bzIwi7CFAHdxY0oejbzLERHUGblQbG60WvwDEFl5opDSOwKABsx3waGrHK7+wDSM78Fc
	yUvpVeXLIjRmDsVvPXVw7nma0XvvlUXZiQc4ncRpJGHaPlyqReHTpRikSIRVysuHzSLfZWiwMdu
	RWSULEQAXq7M/d6hha/Aqo3Ex+IF6IrhYQ4IxqX1f3ctDT9Bcz/RAkiwJOzQsK6Ed4qfewfLR12
	hEKZ7E1puXTQsUiiFdNJZ7Rec=
X-Received: by 2002:aa7:c618:0:b0:6b1:c6fa:c45c with SMTP id
 4fb4d7f45d1cf-6b4d60d6045mr3202760a12.38.1793464258646; Sat, 31 Oct 2026
 09:30:58 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030-alpha-profileme-v2-0-c702f1c65272@gmail.com> <20261030-alpha-profileme-v2-3-c702f1c65272@gmail.com>
In-Reply-To: <20261030-alpha-profileme-v2-3-c702f1c65272@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 31 Oct 2026 17:30:47 +0100
X-Gm-Features: AclHuK9z3_v3mz4IBPVdz521171f9r8bZqjdnJXNLYBg6dYURqvWBBixrGC47Fo
Message-ID: <CA+=Fv5ThaboCmvq6DEERjbkjJs8uridxwX8meTpbNPuQvfN_1w@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] alpha/perf: implement ProfileMe sampling
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Fri, Oct 30, 2026 at 5:04=E2=80=AFAM Matt Turner <mattst88@gmail.com> wr=
ote:
>
> The 21264 (EV67 and later) and 21364 have two performance counting modes,
> and the driver only uses Aggregate mode. Its samples report the PC at
> which the counter interrupt was taken, which lands a variable number of
> instructions after the one that overflowed the counter. On an EV7 a
> 16-instruction user loop shows up at only 4 PCs, anywhere from 15
> instructions before to 12 after the real one.
>
> In ProfileMe mode, the instruction that overflows PCTR0 opens a window
> during which PCTR1 counts, and when it closes PALcode delivers the
> interrupt with that instruction's PC latched in PMPC.
>
> Select ProfileMe with the new profileme config bit or with precise_ip,
> since PMPC has no skid. PCTR_CTL[SL0] selects the mode for both
> counters, so a ProfileMe event is scheduled alone and perf core
> multiplexes it with other hardware events. The event type chooses the
> SL1 setting, which decides what PCTR0 samples on and what PCTR1 counts
> in the window:
>
>   event          PCTR0         PCTR1
>   instructions   instructions  cycles
>   bcache-misses  instructions  Bcache misses
>   cycles         cycles        inum retire delay
>   mbox-replay    cycles        Mbox replay traps
>
> Every interrupt rearms both counters, since PCTR0 stops when the window
> closes. The instruction count is corrected by the overcount I_STAT
> reports. The sample is attributed to PMPC. The interrupt can be taken
> in a different mode than the profiled instruction: in an unaligned
> access test on EV7 that was true of three quarters of the samples. So
> for the overflow call the PC is set in the trap frame of the
> instruction's mode, task_pt_regs() for a user instruction, and restored
> afterwards. perf's mode, register and stack sampling then all see the
> same frame. A kernel instruction whose interrupt is taken after the
> return to user mode has no kernel state left, so it gets a per-CPU frame
> holding only its PC, which leaves the user frame intact. PALmode PMPCs
> are physical addresses, so those samples keep the interrupted PC.
>
> PCTR0 is left stopped just past overflow at the end of every window,
> which the EV67 PALcode restrictions 32 and 38 warn about: a disabled
> counter near overflow keeps signaling it and blocks all other
> interrupts, and a disabled counter only clears its overflow state when
> written twice. So the counters are written twice when rearmed, and are
> moved away from overflow when a ProfileMe event is stopped or a stray
> interrupt arrives for one that is gone. Without this, sampling every
> 10000 instructions wedged an EV7 in 7 of 16 runs, with no console
> output, until the service processor reset it. With it, 66 runs passed.
>
> Three behaviors differ from Aggregate mode. perf record's default event
> is cycles:P, so it now records a ProfileMe profile. In ProfileMe mode
> PCTR0 counts valid fetched instructions rather than retired ones, so the
> instructions count includes the wrong path, squashed NOPs, and both
> halves of each CMOV: on an EV7 loop with a randomly mispredicted branch
> it is about twice the Aggregate count. And instructions killed on a
> wrong path are sampled at their own PC, as ProfileMe defines them.
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/include/asm/wrperfmon.h |  12 ++
>  arch/alpha/kernel/perf_event.c     | 217 +++++++++++++++++++++++++++++++=
++++--
>  2 files changed, 219 insertions(+), 10 deletions(-)
>
> diff --git a/arch/alpha/include/asm/wrperfmon.h b/arch/alpha/include/asm/=
wrperfmon.h
> index 1fa9bc813263..7fbbfd74926a 100644
> --- a/arch/alpha/include/asm/wrperfmon.h
> +++ b/arch/alpha/include/asm/wrperfmon.h
> @@ -92,5 +92,17 @@
>  #define EV67_PCTR_CYCLES_UNDEF (1UL<<2)
>  #define EV67_PCTR_INSTR_BCACHEMISS (2UL<<2)
>  #define EV67_PCTR_CYCLES_MBOX (3UL<<2)
> +/* In ProfileMe mode, SL1 =3D 1 makes PCTR1 count the inum retire delay.=
 */
> +#define EV67_PCTR_CYCLES_RETIRE_DELAY (1UL<<2)
> +/* Set in both SL settings where PCTR0 counts cycles. */
> +#define EV67_PCTR_PCTR0_CYCLES (1UL<<2)
> +
> +/* ProfileMe status, from the EV67/EV68 Hardware Reference Manuals. */
> +#define EV67_I_STAT_OVR_SHIFT 30
> +#define EV67_I_STAT_OVR_MASK 0x7UL
> +
> +/* PMPC bits 63:2 hold the profiled PC. Bit 0 set means a PALmode addres=
s. */
> +#define EV67_PMPC_PAL (1UL<<0)
> +#define EV67_PMPC_PC_MASK (~3UL)
>
>  #endif
> diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_even=
t.c
> index 70840c05d39b..c7f0ccf8ec80 100644
> --- a/arch/alpha/kernel/perf_event.c
> +++ b/arch/alpha/kernel/perf_event.c
> @@ -30,6 +30,13 @@
>  #define MAX_HWEVENTS 3
>  #define PMC_NO_INDEX -1
>
> +/* Layout of attr.config for PERF_TYPE_RAW events; see format/ in sysfs.=
 */
> +#define ALPHA_PERF_CONFIG_EVENT                0xffULL
> +#define ALPHA_PERF_CONFIG_PROFILEME    BIT_ULL(8)
> +
> +/* hw_perf_event.flags */
> +#define ALPHA_PERF_FLAG_PROFILEME      0x1
> +
>  /* For tracking PMCs and the hw events they monitor on each CPU. */
>  struct cpu_hw_events {
>         int                     enabled;
> @@ -145,6 +152,19 @@ static const struct ev67_mapping_t ev67_mapping[] =
=3D {
>  };
>
>
> +/*
> + * In ProfileMe mode PCTR0 selects the profiled instruction and PCTR1 co=
unts
> + * during its window. PCTR0 counts instructions or cycles, and each choi=
ce
> + * pairs with two PCTR1 inputs, so each event type picks one SL1 setting=
.
> + * Indexed by enum ev67_pmc_event_type.
> + */
> +static const unsigned long ev67_profileme_sl1[] =3D {
> +       [EV67_CYCLES]           =3D EV67_PCTR_CYCLES_RETIRE_DELAY, /* PCT=
R1: retire delay */
> +       [EV67_INSTRUCTIONS]     =3D EV67_PCTR_INSTR_CYCLES,       /* PCTR=
1: cycles */
> +       [EV67_BCACHEMISS]       =3D EV67_PCTR_INSTR_BCACHEMISS,   /* PCTR=
1: Bcache misses */
> +       [EV67_MBOXREPLAY]       =3D EV67_PCTR_CYCLES_MBOX,        /* PCTR=
1: Mbox replays */
> +};
> +
>  /*
>   * Check that a group of events can be simultaneously scheduled on to th=
e
>   * EV67 PMU.  Also allocate counter indices and config.
> @@ -152,9 +172,21 @@ static const struct ev67_mapping_t ev67_mapping[] =
=3D {
>  static int ev67_check_constraints(struct perf_event **event,
>                                 unsigned long *evtype, int n_ev)
>  {
> -       int idx0;
> +       int idx0, j;
>         unsigned long config;
>
> +       /* A ProfileMe event uses both counters, so it must be alone. */
> +       for (j =3D 0; j < n_ev; j++) {
> +               if (!(event[j]->hw.flags & ALPHA_PERF_FLAG_PROFILEME))
> +                       continue;
> +               if (n_ev !=3D 1)
> +                       return -1;
> +               event[0]->hw.idx =3D 0;
> +               event[0]->hw.config_base =3D EV67_PCTR_MODE_PROFILEME |
> +                                          ev67_profileme_sl1[evtype[0]];
> +               return 0;
> +       }
> +
>         idx0 =3D ev67_mapping[evtype[0]-1].idx;
>         config =3D ev67_mapping[evtype[0]-1].config;
>         if (n_ev =3D=3D 1)
> @@ -213,9 +245,11 @@ static int ev67_raw_event_valid(u64 config)
>
>
>  PMU_FORMAT_ATTR(event, "config:0-7");
> +PMU_FORMAT_ATTR(profileme, "config:8");
>
>  static struct attribute *ev67_format_attrs[] =3D {
>         &format_attr_event.attr,
> +       &format_attr_profileme.attr,
>         NULL,
>  };
>
> @@ -276,6 +310,31 @@ static inline void alpha_write_pmc(int idx, unsigned=
 long val)
>         wrperfmon(PERFMON_CMD_WRITE, val);
>  }
>
> +/* Write PCTR0 and clear PCTR1 in one call, as ProfileMe mode requires. =
*/
> +static inline void alpha_write_pmc_profileme(unsigned long val)
> +{
> +       val &=3D alpha_pmu->pmc_count_mask[0];
> +       val <<=3D alpha_pmu->pmc_count_shift[0];
> +       val |=3D EV67_PCTR_0 | EV67_PCTR_1;
> +       /*
> +        * PCTR0 stops when a ProfileMe window closes, and a stopped coun=
ter
> +        * only clears its overflow state when written twice (EV67 HRM, P=
ALcode
> +        * restriction 38). A counter left signaling overflow blocks all
> +        * other interrupts (restriction 32).
> +        */
> +       wrperfmon(PERFMON_CMD_WRITE, val);
> +       wrperfmon(PERFMON_CMD_WRITE, val);
> +}
> +
> +/* The counters an event occupies, for PERFMON_CMD_ENABLE and DISABLE. *=
/
> +static inline unsigned long alpha_event_idx_mask(struct hw_perf_event *h=
wc,
> +                                                int idx)
> +{
> +       if (hwc->flags & ALPHA_PERF_FLAG_PROFILEME)
> +               return EV67_PCTR_0 | EV67_PCTR_1;
> +       return 1UL<<idx;
> +}
> +
>  static inline unsigned long alpha_read_pmc(int idx)
>  {
>         unsigned long val;
> @@ -320,7 +379,10 @@ static int alpha_perf_event_set_period(struct perf_e=
vent *event,
>
>         local64_set(&hwc->prev_count, (unsigned long)(-left));
>
> -       alpha_write_pmc(idx, (unsigned long)(-left));
> +       if (hwc->flags & ALPHA_PERF_FLAG_PROFILEME)
> +               alpha_write_pmc_profileme((unsigned long)(-left));
> +       else
> +               alpha_write_pmc(idx, (unsigned long)(-left));
>
>         perf_event_update_userpage(event);
>
> @@ -457,7 +519,8 @@ static void maybe_change_configuration(struct cpu_hw_=
events *cpuc)
>                 }
>
>                 if (!(hwc->state & PERF_HES_STOPPED))
> -                       cpuc->idx_mask |=3D (1<<cpuc->current_idx[j]);
> +                       cpuc->idx_mask |=3D alpha_event_idx_mask(hwc,
> +                                                       cpuc->current_idx=
[j]);
>         }
>         cpuc->config =3D cpuc->event[0]->hw.config_base;
>  }
> @@ -548,7 +611,7 @@ static void alpha_pmu_del(struct perf_event *event, i=
nt flags)
>                         alpha_perf_event_update(event, hwc, idx, 0);
>                         perf_event_update_userpage(event);
>
> -                       cpuc->idx_mask &=3D ~(1UL<<idx);
> +                       cpuc->idx_mask &=3D ~alpha_event_idx_mask(hwc, id=
x);
>                         cpuc->n_events--;
>                         break;
>                 }
> @@ -573,7 +636,7 @@ static void alpha_pmu_stop(struct perf_event *event, =
int flags)
>         struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
>
>         if (!(hwc->state & PERF_HES_STOPPED)) {
> -               cpuc->idx_mask &=3D ~(1UL<<hwc->idx);
> +               cpuc->idx_mask &=3D ~alpha_event_idx_mask(hwc, hwc->idx);
>                 hwc->state |=3D PERF_HES_STOPPED;
>         }
>
> @@ -583,7 +646,23 @@ static void alpha_pmu_stop(struct perf_event *event,=
 int flags)
>         }
>
>         if (cpuc->enabled)
> -               wrperfmon(PERFMON_CMD_DISABLE, (1UL<<hwc->idx));
> +               wrperfmon(PERFMON_CMD_DISABLE, alpha_event_idx_mask(hwc, =
hwc->idx));
> +
> +       /*
> +        * A ProfileMe event can be stopped with a window open and PCTR0 =
just
> +        * past overflow. Do not leave it there while it is disabled, see
> +        * alpha_write_pmc_profileme(). The count was read above, so reba=
se
> +        * prev_count on the value written.
> +        */
> +       if ((hwc->flags & ALPHA_PERF_FLAG_PROFILEME) &&
> +           (hwc->state & PERF_HES_UPTODATE)) {
> +               long left =3D local64_read(&hwc->period_left);
> +
> +               left =3D clamp(left, alpha_pmu->pmc_left[0],
> +                            (long)alpha_pmu->pmc_max_period[0]);
> +               local64_set(&hwc->prev_count, (unsigned long)(-left));
> +               alpha_write_pmc_profileme((unsigned long)(-left));
> +       }
>  }
>
>
> @@ -602,9 +681,9 @@ static void alpha_pmu_start(struct perf_event *event,=
 int flags)
>
>         hwc->state =3D 0;
>
> -       cpuc->idx_mask |=3D 1UL<<hwc->idx;
> +       cpuc->idx_mask |=3D alpha_event_idx_mask(hwc, hwc->idx);
>         if (cpuc->enabled)
> -               wrperfmon(PERFMON_CMD_ENABLE, (1UL<<hwc->idx));
> +               wrperfmon(PERFMON_CMD_ENABLE, alpha_event_idx_mask(hwc, h=
wc->idx));
>  }
>
>
> @@ -644,6 +723,7 @@ static int __hw_perf_event_init(struct perf_event *ev=
ent)
>         struct perf_event *evts[MAX_HWEVENTS];
>         unsigned long evtypes[MAX_HWEVENTS];
>         int idx_rubbish_bin[MAX_HWEVENTS];
> +       bool profileme =3D false;
>         int ev;
>         int n;
>
> @@ -657,9 +737,13 @@ static int __hw_perf_event_init(struct perf_event *e=
vent)
>         } else if (attr->type =3D=3D PERF_TYPE_HW_CACHE) {
>                 return -EOPNOTSUPP;
>         } else if (attr->type =3D=3D PERF_TYPE_RAW) {
> -               if (!alpha_pmu->raw_event_valid(attr->config))
> +               if (attr->config & ~(ALPHA_PERF_CONFIG_EVENT |
> +                                    ALPHA_PERF_CONFIG_PROFILEME))
>                         return -EINVAL;
> -               ev =3D attr->config;
> +               ev =3D attr->config & ALPHA_PERF_CONFIG_EVENT;
> +               if (!alpha_pmu->raw_event_valid(ev))
> +                       return -EINVAL;
> +               profileme =3D attr->config & ALPHA_PERF_CONFIG_PROFILEME;
>         } else {
>                 return -EOPNOTSUPP;
>         }
> @@ -668,6 +752,17 @@ static int __hw_perf_event_init(struct perf_event *e=
vent)
>                 return ev;
>         }
>
> +       /*
> +        * ProfileMe samples report the exact PC of the profiled instruct=
ion,
> +        * so it also serves any request for precise samples. It only mak=
es
> +        * sense for sampling events.
> +        */
> +       if (attr->precise_ip)
> +               profileme =3D true;
> +       if (profileme && !is_sampling_event(event))
> +               return -EINVAL;
> +       hwc->flags =3D profileme ? ALPHA_PERF_FLAG_PROFILEME : 0;
> +
>         /*
>          * We place the event type in event_base here and leave calculati=
on
>          * of the codes to programme the PMU for alpha_pmu_enable() becau=
se
> @@ -832,6 +927,96 @@ void perf_event_print_debug(void)
>  }
>
>
> +/*
> + * Sample registers for a ProfileMe kernel instruction whose interrupt w=
as
> + * taken in user mode. Being off the stack, perf_reg_value() reports no =
SP.
> + */
> +static DEFINE_PER_CPU(struct pt_regs, alpha_profileme_regs);
> +
> +/*
> + * Handle the close of a ProfileMe window on PCTR0.
> + *
> + * PCTR0 stops counting when the window closes and does not start again
> + * until PCTR_CTL is written, so the status must be read first and the
> + * counters then rearmed unconditionally.
> + */
> +static void alpha_perf_event_profileme(struct perf_event *event,
> +                                      struct hw_perf_event *hwc,
> +                                      struct pt_regs *regs)
> +{
> +       struct perf_sample_data data;
> +       struct pt_regs *pm_regs;
> +       unsigned long i_stat, pmpc, ovr, pc, saved_pc, saved_ps;
> +
> +       i_stat =3D wrperfmon(PERFMON_CMD_I_STAT, 0);
> +       pmpc =3D wrperfmon(PERFMON_CMD_PMPC, 0);
> +
> +       alpha_perf_event_update(event, hwc, 0, alpha_pmu->pmc_max_period[=
0]+1);
> +
> +       /*
> +        * When PCTR0 counts instructions, up to 7 of them are counted af=
ter
> +        * the overflow but before the window opens. I_STAT reports how m=
any.
> +        */
> +       if (!(hwc->config_base & EV67_PCTR_PCTR0_CYCLES)) {
> +               ovr =3D (i_stat >> EV67_I_STAT_OVR_SHIFT) & EV67_I_STAT_O=
VR_MASK;
> +               local64_sub(ovr, &event->count);
> +               local64_add(ovr, &hwc->period_left);
> +       }
> +
> +       /*
> +        * Attribute the sample to the profiled instruction rather than t=
o
> +        * wherever the interrupt landed. perf takes the sample's mode,
> +        * registers and stack from regs, so the PC is set in the trap fr=
ame
> +        * of the mode the instruction ran in, and restored afterwards:
> +        *
> +        * - Interrupt taken in the same mode: the interrupt's own frame.
> +        * - User instruction, interrupt taken in the kernel, typically
> +        *   because the instruction trapped: the user frame at
> +        *   task_pt_regs().
> +        * - Kernel instruction, interrupt taken just after returning to =
user
> +        *   mode: the kernel state is gone, so a per-CPU frame that hold=
s only
> +        *   the PC. The user frame in regs is left alone, since perf sam=
ples
> +        *   the user registers from it.
> +        *
> +        * A PALmode PMPC is a physical address that perf cannot resolve.=
 That
> +        * happens for ITB miss, Istream access violation and interrupt
> +        * redirects, and for instructions inside PALcode. Keep the
> +        * interrupted PC, which for redirects is the instruction that
> +        * trapped. Do the same for a user PMPC in a kernel thread, which=
 has
> +        * no user frame.
> +        */
> +       pm_regs =3D regs;
> +       pc =3D pmpc & EV67_PMPC_PC_MASK;
> +       if (pmpc & EV67_PMPC_PAL) {
> +               pc =3D regs->pc;
> +       } else if (pc < TASK_SIZE && !user_mode(regs)) {
> +               if (is_user_task(current))
> +                       pm_regs =3D task_pt_regs(current);


Across all three CPUs on my ES40, I found 434 samples where r7/r8
differed from the values held in the user loop. In every one of those
samples, the PMI had landed at the first instruction of entUna, before
it saved the user registers. At that point the r7/r8 slots in
task_pt_regs(current) overlap the interrupt frame's r23/r24 slots.

I tested the change below on top of v2. When the PMPC is in user
space but the PMI lands in kernel mode, it keeps the PMPC as the
sample IP and marks both register sets unavailable. All 1,102 checked
trapping-loop samples kept the correct PC, with no bogus r7/r8.

This also drops the user registers and stack if the PMI lands after
entry has finished saving them, so we lose the chance to unwind that
sample. Is keeping just the sampled PC good enough for these
cross-mode samples?


Thanks,
Magnus

diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.=
c
index c553cbd6c7a3..62b333515633 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -965,4 +965,3 @@ void perf_event_print_debug(void)
 /*
- * Sample registers for a ProfileMe kernel instruction whose interrupt was
- * taken in user mode. Being off the stack, perf_reg_value() reports no SP=
.
+ * PC-only frame for a ProfileMe interrupt taken in a different mode.
  */
@@ -985,2 +984,3 @@ static void alpha_perf_event_profileme(struct
perf_event *event,
  struct pt_regs *pm_regs;
+ bool user_pc_only =3D false;
  unsigned long pctr_ctl, i_stat, pmpc, ovr, pc, saved_pc, saved_ps;
@@ -1011,4 +1011,4 @@ static void alpha_perf_event_profileme(struct
perf_event *event,
  * - User instruction, interrupt taken in the kernel, typically
- *   because the instruction trapped: the user frame at
- *   task_pt_regs().
+ *   because the instruction trapped: the entry code may not have
+ *   built the user frame yet. Report only the profiled PC.
  * - Kernel instruction, interrupt taken just after returning to user
@@ -1030,6 +1030,10 @@ static void alpha_perf_event_profileme(struct
perf_event *event,
  } else if (pc < TASK_SIZE && !user_mode(regs)) {
- if (is_user_task(current))
- pm_regs =3D task_pt_regs(current);
- else
+ if (is_user_task(current)) {
+ user_pc_only =3D true;
+ pm_regs =3D this_cpu_ptr(&alpha_profileme_regs);
+ memset(pm_regs, 0, sizeof(*pm_regs));
+ pm_regs->ps =3D 8; /* user mode */
+ } else {
  pc =3D regs->pc;
+ }
  } else if (pc >=3D TASK_SIZE && user_mode(regs)) {
@@ -1040,2 +1044,12 @@ static void alpha_perf_event_profileme(struct
perf_event *event,
  perf_sample_data_init(&data, 0, hwc->last_period);
+ if (user_pc_only) {
+ u64 mask =3D event->attr.sample_type &
+ (PERF_SAMPLE_REGS_USER | PERF_SAMPLE_REGS_INTR);
+
+ /* STACK_USER also consults regs_user, even without REGS_USER. */
+ data.regs_user =3D (struct perf_regs){ .abi =3D PERF_SAMPLE_REGS_ABI_NONE=
 };
+ data.regs_intr =3D data.regs_user;
+ data.sample_flags |=3D PERF_SAMPLE_REGS_USER | PERF_SAMPLE_REGS_INTR;
+ data.dyn_size +=3D hweight64(mask) * sizeof(u64);
+ }




> +               else
> +                       pc =3D regs->pc;
> +       } else if (pc >=3D TASK_SIZE && user_mode(regs)) {
> +               pm_regs =3D this_cpu_ptr(&alpha_profileme_regs);
> +               memset(pm_regs, 0, sizeof(*pm_regs));
> +       }
> +
> +       perf_sample_data_init(&data, 0, hwc->last_period);
> +
> +       if (!alpha_perf_event_set_period(event, hwc, 0))
> +               return;
> +
> +       saved_pc =3D pm_regs->pc;
> +       saved_ps =3D pm_regs->ps;
> +       pm_regs->pc =3D pc;
> +       /* PS bit 3 is the mode bit that user_mode() tests. */
> +       if (pc >=3D TASK_SIZE)
> +               pm_regs->ps &=3D ~8UL;
> +
> +       perf_event_overflow(event, &data, pm_regs);
> +
> +       pm_regs->pc =3D saved_pc;
> +       pm_regs->ps =3D saved_ps;
> +}
> +
>  /*
>   * Performance Monitoring Interrupt Service Routine called when a PMC
>   * overflows.  The PMC that overflowed is passed in la_ptr.
> @@ -866,6 +1051,10 @@ static void alpha_perf_event_irq_handler(unsigned l=
ong la_ptr,
>
>         idx =3D la_ptr;
>
> +       /* A ProfileMe event owns both counters but lives at index 0. */
> +       if (cpuc->config & EV67_PCTR_MODE_PROFILEME)
> +               idx =3D 0;
> +
>         for (j =3D 0; j < cpuc->n_events; j++) {
>                 if (cpuc->current_idx[j] =3D=3D idx)
>                         break;
> @@ -873,6 +1062,8 @@ static void alpha_perf_event_irq_handler(unsigned lo=
ng la_ptr,
>
>         if (unlikely(j =3D=3D cpuc->n_events)) {
>                 /* This can occur if the event is disabled right on a PMC=
 overflow. */
> +               if (cpuc->config & EV67_PCTR_MODE_PROFILEME)
> +                       alpha_write_pmc_profileme(-alpha_pmu->pmc_max_per=
iod[0]);
>                 wrperfmon(PERFMON_CMD_ENABLE, cpuc->idx_mask);
>                 return;
>         }
> @@ -888,6 +1079,12 @@ static void alpha_perf_event_irq_handler(unsigned l=
ong la_ptr,
>         }
>
>         hwc =3D &event->hw;
> +       if (hwc->flags & ALPHA_PERF_FLAG_PROFILEME) {
> +               alpha_perf_event_profileme(event, hwc, regs);
> +               wrperfmon(PERFMON_CMD_ENABLE, cpuc->idx_mask);
> +               return;
> +       }
> +
>         alpha_perf_event_update(event, hwc, idx, alpha_pmu->pmc_max_perio=
d[idx]+1);
>         perf_sample_data_init(&data, 0, hwc->last_period);
>
>
> --
> 2.55.0
>
