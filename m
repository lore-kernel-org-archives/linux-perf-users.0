Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793691717;
	b=Tj3vj/0ZBqGFAo1PoIKrEX4YlCLLUFk7z+1e3sdqJwlEVQaVLBy8dnaTtIjXgn84/iGa
	 eF01ljifp7aFGmBwsSJ7lo2cPb+rp/uPw0pAIGEsEym2yMZPgKG305Vd1lBSieBPrS2wj
	 qCG7byuYT/EHd/DogduDMk6/taayeP5ZrJQLpnq2s7pdga3c9/qKdSvwXmmErRy3sXh28
	 D9cyXN7dNxUtQIMmuFyFHGlaa7vK9qu0TZr7wu0H4NJFKdZAiVTE7432uCXdypE21paPC
	 3XIyrfFYKfudyCd9FUDvtd6QP9R9KIyRGcHw5M1w6AJXHQkBRa33Y8KS8XhNDrcN7zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793691717;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=r1ZzkhVW6W3Y67bRqngJQgynBcegZNrTuFBXrdjNEiY=;
	b=ksh5Cv61wqHhasJ2hu/lB8rGODJ8HL99RJf35Vosyy/mZtUcfAENY4bBIlD5EUL04yej
	 ehbvGhlOheSo4JW7ecA1g6DnXtpyBS71p4PbZRHjAaUHW7FllpN4JuQj3naUrfsgj1bPU
	 XN89g9/NOwVbN3zTMrkkF6/alBbOZxkTTImNUsIPNeAF2XjidSB2BAuATDeWqPD8Y48gF
	 89wgip3cEaXyl/T94J1+q79n1RXpYqxDqks65FKwqiV9arwkLYIZVb1xo+BJ/j6NoPu49
	 +xnEbjzN9l3kRMeMspNNemhoTQoMqhUtHTle9Hx54GbNFwZmW1m1MookH8SMhENu2yQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SnbDBGiD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB66606A329
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 07:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EB66606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SnbDBGiD
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6af9a9451daso6143530a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 23:41:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793691714; cv=none;
        d=google.com; s=arc-20260327;
        b=SsYl7iW89kpiT1duB+lCZijyzLmCDSDmC+QYxAYH9KMZWzrZbI0OWppWvJWurmDWE0
         nLpbNcLlDQ7QqxrFj0z80VeyHAqWg0Ogjj1MqAiOUKwNLQkyUeI4qz4NrixPeJWYAQQv
         KvkiDwOM+kALiBEelwMt8boCcb3YSvhYoS/a13oNW4d18ySPzySDMrfZ4KyPng6SB2a2
         AYhc7oZcjqsujc+jSDhjrpRMMjGRvR3PORHKivpsBIRzThICIPZtLJ1XLvEe5JixDaBt
         TWRqSfDMCnaph4WV4yv+CwFrXxe6x0QQkWWaYg5bUcAU0YBjnkqZCNmS5hpLSalHhTL9
         7GvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r1ZzkhVW6W3Y67bRqngJQgynBcegZNrTuFBXrdjNEiY=;
        fh=eJ6wOh35gLI8OLXf2KZX+Vsq01oFMc9pkvhD7KG4ZRU=;
        b=foQmbnwd25pwK48YBUapG8TCGLGxr50s8G7rg5ND0wMbGCfgWkHHCkW6h8YhXq3ygy
         tvS7LiOMmyIga+4UZYFcaf4ClX7PiTbqO+Bg3dTKDd/UiiM/h1tTyrlLSfimhBZmUZ8X
         RpTLnk+rRhuu2k55Ms8kGpG2yBv5/9bSlJQGndfI2P5hfmxCj4yPvGmTwUmYcZPG3DQj
         5a1OvPnl1VBZpi++DUSpsrSpHNpcylhLbS4yDr0gQ5qpr2xXi8vKNKDIs1LbJ7k60slv
         KIu3MJNQaAjOyYp5p1VB8cg+MqrmzyIyn5miqQej3WCGHf45K+yWLrjgngK3VHv/AsDw
         o3dQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793691714; x=1794296514; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r1ZzkhVW6W3Y67bRqngJQgynBcegZNrTuFBXrdjNEiY=;
        b=SnbDBGiDuXwVg4C4eJHjcibthwlgGUyDAgHXRVfdEXDYkvc6ET+oz3Hm0CrVCmhC0m
         yGvG6yfDQy2XMQXIY6+f5Xflc8lCnzmc1jYeUOcwpoZn+cCUiBBoiQV9LBGijIGJmCkU
         DP4CVmZP1gI8hgWgK/Bf9djyFQ6OLHXn8tndrQYa7lqApT2hb4a9Vfjrt7Q0FGrK2KQg
         L/TMemjsoIUBnmfCkgsIXGUZVho+fk77hZEK4dfPQamOF5lW1b31K3+73/m10IWx+ktN
         Su55ZFhaUyjrg6U/cD+02inSTn1uY3hLRBp4Zpn0d/FWszQp/jPw+TWjkhWRFXBPA0Wv
         Ko2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793691714; x=1794296514;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r1ZzkhVW6W3Y67bRqngJQgynBcegZNrTuFBXrdjNEiY=;
        b=g28fnkswDsXGdN4/rG5+BcTvOcPJVXgd+ajc/jDvLN8VqEG2OC+IvqH/OBj0ktIQgX
         fOWpfyFbvjA1l59VThq3lmM+6DvM8YN0DKeO5TG9jNnhJt81Jc/4E5WnnvXs5t+C8jtc
         VJvnD7N9MBp9aMTImHznbv6kNh3FBpfi2LzlauCSUzeRLL9S1niY1V0Pj1bUrgc9X7fb
         bRFgfo3zxaimhzuoMxjZN2X+UJ0lkhUlSG7PU7SVWON/VuFx/Ky+NSOcAb0cT91PHMMX
         3Rhkm+UNq3BQwQHuJv7y2YRRFm0taIgMv+2oksDNri+7MkDKuQ1ihkSljTXWUIf2TVdm
         1zyQ==
X-Forwarded-Encrypted: i=1; AKwUvBwu8y/jfvcDKM79iTCGzA3IMt7UWWoJ9tX5lzKdPhEjJzOJvC4FIwFBrR6HGXU1qIrzNpJAlSc2sdYKDEEc1hTw@vger.kernel.org
X-Gm-Message-State: APuU4Z8oP/4x2/3uVKFGjrjasB4+o9jiSRjA9riMv5hzssPOmZbzJtdw
	zWiqgPyzrhbZvE5u7PW4QosyhGxiVXTfTISMvruqvrZNE5MEV4r1LxV3B7XJWS8Kt4zEO07y6vU
	6tOSFwX+QgsLm9XWhgN4WPzcJXEeki0E=
X-Gm-Gg: AYBFou2pSjSDyfL11E0uiKagR256aGPU6x/+FM8HSFUpn+FchQ4drafhABc55duhgbE
	vAodxiDJ4Zbgi7Y1cRzmZ7k59Ypq2E30xkjUth+a1yHSD004pjO/SFratC4DXO8hRsTUl5YPy/c
	k8hLx60joWSpq25QB5Gt1ohnY3OmeoI4jpFfpVeaXoqZokeycZePVd/eHFqEAkE82ADUR3OIYzx
	cg6ZHxFf7XMi4jsuYbI3OpLBc1BWqBQ9tusW0dnUAMvbu4MHtHZLgugPB4nHOV2hChoLglp8vW5
	cAvssKQX9SWud7p3dt4iZgXukdTWDkH6f7f8a8Q1rNZBTmdC1b2+f7M9e5GRzrm70Dsz7bAuZUg
	J5De4JEw3elukPrYg4V/crovjcfdbIAz0WWhLV9oL6b2XHHNpod3EQ1q20UMLpLuHnGIy7A==
X-Received: by 2002:a05:6402:2423:b0:6b2:2331:3ea9 with SMTP id
 4fb4d7f45d1cf-6b4d4d6e333mr8338059a12.17.1793691714034; Mon, 02 Nov 2026
 23:41:54 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-alpha-profileme-v4-0-61e00f5e1da8@gmail.com> <20261102-alpha-profileme-v4-5-61e00f5e1da8@gmail.com>
In-Reply-To: <20261102-alpha-profileme-v4-5-61e00f5e1da8@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Tue, 3 Nov 2026 08:41:40 +0100
X-Gm-Features: AclHuK8kTzNK05F40t_SfR7WN-bB27sD0YgeCLVaOpsXd48Oeq1z6voh9GlP49c
Message-ID: <CA+=Fv5RgTNGzApgq-YcPZ6u_My9-c8T6xMjb-_yuQRV5C53T7Q@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] alpha/perf: implement ProfileMe sampling
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

On Tue, Nov 3, 2026 at 4:02=E2=80=AFAM Matt Turner <mattst88@gmail.com> wro=
te:
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
> access test on EV7 that was true of three quarters of the samples. When
> the modes match, the PC is set in the interrupt's frame for the overflow
> call and restored afterwards, so perf's mode, register and stack
> sampling all see the same frame. When they differ the registers are not
> available: a kernel instruction whose interrupt is taken after the
> return to user mode has no kernel state left, and a user instruction's
> frame may not be built yet, as the interrupt is often taken on the first
> instruction of the entry code. Those samples use a per-CPU frame holding
> only the PC, and a user instruction's sample reports no registers or
> user stack. PALmode PMPCs are physical addresses, so those samples keep
> the interrupted PC.
>
> PCTR0 is left stopped just past overflow at the end of every window,
> which the EV67 PALcode restrictions 32 and 38 warn about: a disabled
> counter near overflow keeps signaling it and blocks all other
> interrupts, and a disabled counter only clears its overflow state when
> written twice. So the counters are written twice when rearmed, and are
> moved away from overflow when a ProfileMe event is stopped or removed
> or a stray interrupt arrives for one that is gone. Without this,
> sampling every 10000 instructions wedged an EV7 in 7 of 16 runs, with
> no console output, until the service processor reset it. With it, 66
> runs passed.
>
> Rewriting a counter does not cancel its pending interrupt: wrperfmon has
> no way to, and PALcode clears the request only when delivering it. An
> interrupt that was pending when a ProfileMe event was stopped is
> ignored. One still pending when perf multiplexes in an event of the
> other mode on PCTR0 is taken as that event's overflow, which costs one
> false sample and adds a bogus period to the count.
>
> Three behaviors differ from Aggregate mode. perf record's default event
> is cycles:P, so it now records a ProfileMe profile. In ProfileMe mode
> PCTR0 counts valid fetched instructions rather than retired ones, so the
> instructions count includes the wrong path, squashed NOPs, and both
> halves of each CMOV: on an EV7 loop with a randomly mispredicted branch
> it is about twice the Aggregate count. And instructions killed on a
> wrong path are sampled at their own PC, as ProfileMe defines them.
>
> Suggested-by: Magnus Lindholm <linmag7@gmail.com>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/include/asm/wrperfmon.h |  12 ++
>  arch/alpha/kernel/perf_event.c     | 285 +++++++++++++++++++++++++++++++=
++++--
>  2 files changed, 286 insertions(+), 11 deletions(-)
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
> index ecec78c355cd..29577a493e55 100644
> --- a/arch/alpha/kernel/perf_event.c
> +++ b/arch/alpha/kernel/perf_event.c
> @@ -16,6 +16,7 @@
>  #include <linux/kdebug.h>
>  #include <linux/mutex.h>
>  #include <linux/init.h>
> +#include <linux/sched/task_stack.h>
>
>  #include <asm/hwrpb.h>
>  #include <linux/atomic.h>
> @@ -30,6 +31,13 @@
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
> @@ -145,6 +153,19 @@ static const struct ev67_mapping_t ev67_mapping[] =
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
> @@ -152,9 +173,21 @@ static const struct ev67_mapping_t ev67_mapping[] =
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
> @@ -213,9 +246,11 @@ static int ev67_raw_event_valid(u64 config)
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
> @@ -276,6 +311,31 @@ static inline void alpha_write_pmc(int idx, unsigned=
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
> @@ -286,6 +346,23 @@ static inline unsigned long alpha_read_pmc(int idx)
>         return val;
>  }
>
> +/*
> + * Move a stopped ProfileMe counter away from overflow. See
> + * alpha_write_pmc_profileme() for why. The caller has read the count, s=
o
> + * prev_count can be rebased on the value written.
> + *
> + * A pending PMI stays pending: PALcode clears it only when delivering i=
t.
> + */
> +static void alpha_perf_event_park(struct hw_perf_event *hwc)
> +{
> +       long left =3D local64_read(&hwc->period_left);
> +
> +       left =3D clamp(left, alpha_pmu->pmc_left[0],
> +                    (long)alpha_pmu->pmc_max_period[0]);
> +       local64_set(&hwc->prev_count, (unsigned long)(-left));
> +       alpha_write_pmc_profileme((unsigned long)(-left));
> +}
> +
>  /* Set a new period to sample over */
>  static int alpha_perf_event_set_period(struct perf_event *event,
>                                 struct hw_perf_event *hwc, int idx)
> @@ -320,7 +397,10 @@ static int alpha_perf_event_set_period(struct perf_e=
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
> @@ -459,7 +539,8 @@ static void maybe_change_configuration(struct cpu_hw_=
events *cpuc)
>                 if (!(hwc->state & PERF_HES_STOPPED)) {
>                         /* The counter is live, so hwc->prev_count will g=
o stale. */
>                         hwc->state &=3D ~PERF_HES_UPTODATE;
> -                       cpuc->idx_mask |=3D (1<<cpuc->current_idx[j]);
> +                       cpuc->idx_mask |=3D alpha_event_idx_mask(hwc,
> +                                                       cpuc->current_idx=
[j]);
>                 }
>         }
>         cpuc->config =3D cpuc->event[0]->hw.config_base;
> @@ -551,7 +632,10 @@ static void alpha_pmu_del(struct perf_event *event, =
int flags)
>                         alpha_perf_event_update(event, hwc, idx, 0);
>                         perf_event_update_userpage(event);
>
> -                       cpuc->idx_mask &=3D ~(1UL<<idx);
> +                       if (hwc->flags & ALPHA_PERF_FLAG_PROFILEME)
> +                               alpha_perf_event_park(hwc);
> +
> +                       cpuc->idx_mask &=3D ~alpha_event_idx_mask(hwc, id=
x);
>                         cpuc->n_events--;
>                         break;
>                 }
> @@ -576,17 +660,22 @@ static void alpha_pmu_stop(struct perf_event *event=
, int flags)
>         struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
>
>         if (!(hwc->state & PERF_HES_STOPPED)) {
> -               cpuc->idx_mask &=3D ~(1UL<<hwc->idx);
> +               cpuc->idx_mask &=3D ~alpha_event_idx_mask(hwc, hwc->idx);
>                 hwc->state |=3D PERF_HES_STOPPED;
>         }
>
> -       if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)=
) {
> +       /* Parking a ProfileMe event overwrites the counter, so read it f=
irst. */
> +       if (((flags & PERF_EF_UPDATE) || (hwc->flags & ALPHA_PERF_FLAG_PR=
OFILEME)) &&
> +           !(hwc->state & PERF_HES_UPTODATE)) {
>                 alpha_perf_event_update(event, hwc, hwc->idx, 0);
>                 hwc->state |=3D PERF_HES_UPTODATE;
>         }
>
>         if (cpuc->enabled)
> -               wrperfmon(PERFMON_CMD_DISABLE, (1UL<<hwc->idx));
> +               wrperfmon(PERFMON_CMD_DISABLE, alpha_event_idx_mask(hwc, =
hwc->idx));
> +
> +       if (hwc->flags & ALPHA_PERF_FLAG_PROFILEME)
> +               alpha_perf_event_park(hwc);
>  }
>
>
> @@ -605,9 +694,9 @@ static void alpha_pmu_start(struct perf_event *event,=
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
> @@ -647,6 +736,7 @@ static int __hw_perf_event_init(struct perf_event *ev=
ent)
>         struct perf_event *evts[MAX_HWEVENTS];
>         unsigned long evtypes[MAX_HWEVENTS];
>         int idx_rubbish_bin[MAX_HWEVENTS];
> +       bool profileme =3D false;
>         int ev;
>         int n;
>
> @@ -660,9 +750,13 @@ static int __hw_perf_event_init(struct perf_event *e=
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
> @@ -671,6 +765,17 @@ static int __hw_perf_event_init(struct perf_event *e=
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

One remaining question, should we accept precise_ip=3D3? For a PAL-mode
PMPC we report the interrupted PC, which can differ from the profiled
instruction. Should we reject level 3, or skip those fallback samples
when level 3 is requested? What do you think?

> +       if (profileme && !is_sampling_event(event))
> +               return -EINVAL;
> +       hwc->flags =3D profileme ? ALPHA_PERF_FLAG_PROFILEME : 0;
> +
>         /*
>          * We place the event type in event_base here and leave calculati=
on
>          * of the codes to programme the PMU for alpha_pmu_enable() becau=
se
> @@ -835,6 +940,147 @@ void perf_event_print_debug(void)
>  }
>
>
> +/*
> + * Frame holding only the PC, for a ProfileMe interrupt taken in a diffe=
rent
> + * mode than the profiled instruction. Being off the stack,
> + * perf_reg_value() reports no SP.
> + */
> +static DEFINE_PER_CPU(struct pt_regs, alpha_profileme_regs);
> +
> +/*
> + * Report the sample with none of the given PERF_SAMPLE_REGS_* registers=
.
> + * Having no user registers also means no user stack.
> + */
> +static void alpha_profileme_drop_regs(struct perf_event *event,
> +                                     struct perf_sample_data *data, u64 =
which)
> +{
> +       /* STACK_USER consults regs_user even without REGS_USER. */
> +       if (which & PERF_SAMPLE_REGS_USER)
> +               data->regs_user =3D (struct perf_regs){ .abi =3D PERF_SAM=
PLE_REGS_ABI_NONE };
> +       if (which & PERF_SAMPLE_REGS_INTR)
> +               data->regs_intr =3D (struct perf_regs){ .abi =3D PERF_SAM=
PLE_REGS_ABI_NONE };
> +       data->sample_flags |=3D which;
> +       /* Only the ABI word is written for each. */
> +       data->dyn_size +=3D hweight64(event->attr.sample_type & which) * =
sizeof(u64);
> +}
> +
> +/* Report the user registers from a frame known to be complete. */
> +static void alpha_profileme_set_regs_user(struct perf_event *event,
> +                                         struct perf_sample_data *data)
> +{
> +       data->regs_user.regs =3D task_pt_regs(current);
> +       data->regs_user.abi =3D perf_reg_abi(current);
> +       data->sample_flags |=3D PERF_SAMPLE_REGS_USER;
> +       /* STACK_USER consults regs_user even without REGS_USER. */
> +       if (event->attr.sample_type & PERF_SAMPLE_REGS_USER)
> +               data->dyn_size +=3D (1 + hweight64(event->attr.sample_reg=
s_user)) *
> +                                 sizeof(u64);
> +}
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
> +       bool pc_only =3D false;
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
> +        * registers and stack from regs, so:
> +        *
> +        * - Interrupt taken in the same mode: the PC is set in the
> +        *   interrupt's own frame, and restored afterwards.
> +        * - User instruction, interrupt taken in the kernel, typically
> +        *   because the instruction trapped: the frame at task_pt_regs()=
 may
> +        *   not be built yet. The interrupt is often taken on the first
> +        *   instruction of the entry code, and its own frame then overla=
ps
> +        *   that one. Report the PC alone, in a per-CPU frame.
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
> +               if (is_user_task(current)) {
> +                       pc_only =3D true;
> +                       pm_regs =3D this_cpu_ptr(&alpha_profileme_regs);
> +                       memset(pm_regs, 0, sizeof(*pm_regs));
> +                       /* PS bit 3 is the mode bit that user_mode() test=
s. */
> +                       pm_regs->ps =3D 8;
> +               } else {
> +                       pc =3D regs->pc;
> +               }
> +       } else if (pc >=3D TASK_SIZE && user_mode(regs)) {
> +               pm_regs =3D this_cpu_ptr(&alpha_profileme_regs);
> +               memset(pm_regs, 0, sizeof(*pm_regs));
> +       }
> +
> +       perf_sample_data_init(&data, 0, hwc->last_period);
> +       if (pc_only)
> +               alpha_profileme_drop_regs(event, &data, PERF_SAMPLE_REGS_=
USER |
> +                                                       PERF_SAMPLE_REGS_=
INTR);
> +       /*
> +        * perf_get_regs_user() has the same check, but it will find the =
PMPC
> +        * in regs->pc rather than where the interrupt was taken. Decide =
here
> +        * from the interrupted PC, for either answer that would differ.
> +        */
> +       else if (!user_mode(regs) && in_entry_save_code(regs->pc))
> +               alpha_profileme_drop_regs(event, &data, PERF_SAMPLE_REGS_=
USER);
> +       else if (in_entry_save_code(pc) && is_user_task(current))
> +               alpha_profileme_set_regs_user(event, &data);
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
> @@ -869,6 +1115,10 @@ static void alpha_perf_event_irq_handler(unsigned l=
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
> @@ -876,6 +1126,8 @@ static void alpha_perf_event_irq_handler(unsigned lo=
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
> @@ -891,6 +1143,17 @@ static void alpha_perf_event_irq_handler(unsigned l=
ong la_ptr,
>         }
>
>         hwc =3D &event->hw;
> +       if (hwc->flags & ALPHA_PERF_FLAG_PROFILEME) {
> +               /*
> +                * This overflow was pending when the event was stopped, =
and
> +                * alpha_pmu_stop() has already parked the counter.
> +                */
> +               if (!(hwc->state & PERF_HES_STOPPED))
> +                       alpha_perf_event_profileme(event, hwc, regs);
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

Thanks

Magnus
