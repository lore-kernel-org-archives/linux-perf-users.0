Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793287122;
	b=Z0NnnNsk7vdxImQLJ/iXPocPL20wAsSDxO1WujialAeqhPRk+0w0tJy95IxzVe5rvNVE
	 vj2yiIP+OOTtTnfz5V+G/85/mft2i9nR/s5jkFXtPqSkego8YbXSRjeakBaZV5b6yvvhP
	 BOkUUZlYSFJ6fkLKxGaBuGJBlrpGzcQ5BbogMxW22Yxn6UlygZm3s0gSq0sNFReTGShLa
	 52nzwBtwva9v5YwKzsdGy+hnjJeg3hr95o8MIdmUlWsGSfOR5/RP1TtWPOf8JsjZzNSey
	 SxYNX9NoCe9oEwJeNRDsgUdguoFSujAZeeYzcblhfkfr29xF8G2RO9LW1QZ1XccCmUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793287122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=D/Wu9YO3K1liybRjl2lTdjmphBj+dNZ5DBCU15UvSHo=;
	b=HOIqpHVJOO3fvLXZfJNx8ESlPJ238l6ImL/d0OxNZETyq+UHSztWj+zpOXWS+a/w0qEH
	 M0bA7AWtP80BYWJPhFqmOtyby5bmmREJNzO4JmQcJRtFJBFttZDzAoi392hL+mDQvCW+i
	 wHXBjvbHB72NRE422q7VjD7GCAgBN2No2hglwhuG3AryvM2cva77pq/+lwfNm/CNcrRfr
	 hwpvo7WMDkVn+b69aWMY43VFzmyxjMI6JO21a/uwEAp/jfHMwexdEY47ZrtEofeISYVco
	 gUe3EJEhdmp1gcKnz5K642Tcr3PohcGIafV9AN+YPtB87c38a3KpJhNANJcb8ot+j+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CwbPR6G1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33958606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 15:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33958606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CwbPR6G1
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b21cf1a580so2929798a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 08:18:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793287120; cv=none;
        d=google.com; s=arc-20260327;
        b=oKTLX5beWxy3nrlmy79s3MqM+1qNaHdze7Ni2ZrIqmTXyAGYEzRdIcroLfTPfeQxya
         DJWMxj5Vcc5PzSYNZAmlC6+Wp1FzeusAlHBRFhI9mh20eFPHQrlsmbMeXai6Q+hLiVmg
         6SxCMhKela+cEUxufBcw7l4EURslVrg3y5W2k/msxlA6H6oS5wEelLIsGfmqNILvj10h
         77Cc+rtTHGLa+HQmvovBOdm58F1A5Y7bSloKXWOa6OMOBBG5AU8SSaLbju1LXWWRdNQa
         w/Azl0EpAWRNm6WR7jQuFVSWxMpEWPLTMxWaZF4N14AW+ondSUcOtciIp0RDYGx6gMAa
         K2Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D/Wu9YO3K1liybRjl2lTdjmphBj+dNZ5DBCU15UvSHo=;
        fh=gbn31WWnMFZLbq92TRr1nKDZo68g1fO5ZlMuT+53OnI=;
        b=oxcUsuGB9/vk0Dv5ENNG9AHdhoFAOIZB9UUJUe28NYhdz8FwZdtVQZAx6KEKB23yR/
         d7X37x+9EKAm7PrAqnp+b0akeAqsuXufjE9kHtr2wRH52RwVfVxHp4KIK2uiRKj8mkaG
         dDKesUGQdpYLer8bnUzGek/nZMAQNk/6tLyXurXzOZWGEgnkN/UmjA6tQZxixWpwetL5
         8LWp7KaiGsuA7xPIHspvn+WGiCD1Wv3xKgZD8JZ+Ed6DiZHWQ1whWjB8AVr1uXlwsbio
         GkfMk0gZOVyVZZLaQE/mkNX2U8Ud3yDgag4QG1KU4wp8JwJtem30enw2Ny55PQVDS6T/
         h3ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793287120; x=1793891920; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D/Wu9YO3K1liybRjl2lTdjmphBj+dNZ5DBCU15UvSHo=;
        b=CwbPR6G1hVZsqD5Vye+1LAd0xquM4A9wLnU++urrJll3BzyYuycTVdUbKP3nVNs402
         cm635vOLzkq/k1qKhcnTgkWQ6Cpi9y42gmA1kG2T2ox0xtoTACQcC89JsaSPNQm+US7/
         RCg3BZ/fGk3h6c/1+wjncYn6ckX27gVkfjIc0NTBHE18pbQk6bei7uLZkm9NSEKzEAIQ
         9Tjq9GIvUVnCgF3zqSQrQaFszJPsIjf9g5T4krPGew7Rvf+wOvEnmYFpYz4rtlZplMN9
         S68LT8hNv7B1enR/HCGKYo+228YUu7/K8R+Q05EmHU4RmNJ3ffvd6LbrK3aEFGP0sA1o
         ogvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793287120; x=1793891920;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D/Wu9YO3K1liybRjl2lTdjmphBj+dNZ5DBCU15UvSHo=;
        b=V5ma9wbOuOK3wmDi6l9tmNfFQ33vahONFDbGmB+XsXZ5Zb/sgwRhw50pRCazVsDNIt
         6ikjtsu+hqKm9/fdmyOJ1HCyKQ6drZoX2Lnuzv1Cgc2IcbPgZfOAek+NrB7vzgSrsiwb
         CymiJ0jd6NKm++ffIfdGfGv6On4x7NM1WZJ6Ne1GxPuWT1KdS6sEI7xoAZjYlNvgTCHO
         6ZFldR84zSKtPoMKH7N0PIoNImCPsfTe/36EsRGqZHqePodqYVfAlZ3A2Dr8Ut+kBMIn
         GFjDk9DeOoo+Okojrx+1uB3wS1zJU/MfWoT4A2eE1ppVe7u2X3BlZ0vcunZKBdHOCeFL
         7maA==
X-Forwarded-Encrypted: i=1; AKwUvBxxXWPA1a5qh3U0ZSPdlkfWBViXc0ctyV49S2cLCRGldB9ziFKdDwfmIs+55k2o0RizGEisMrtp9PYgEQEXw456@vger.kernel.org
X-Gm-Message-State: AFq9FYIWnKKbnWQNjdHU2urIhMmP1cDrlTiHhEubpfXYz+oEv0TCyeX+
	bIXyfQmgW++2e+z1X18hzG1z1y1Su7JR+yMNn/rdMGVT0dUe+nu6zpUY8oNGea/q6ogc8Onvxmd
	APhg+VJXFcmFnltUbyzPbOcSKQTZihu8=
X-Gm-Gg: AYBFou28klRwBdNzDIzQUawaTnJ/2AMmH0cL+G3pdR96mLUyRGBq/K9xr0+a1wql8gW
	3H0P+Q4SpRn7WZXu8LdB7O7bSE3YZMsO+xs0+hPR7sRBCCwe3PecSwtPT56BxiZioLH4EfyBgg4
	vBJNSuHcDNPOl11GXnG2+YDmE5BnIC9oXbsKN1FHXzkg0LhP0erKg6a0v+oCd3nxz0egQk3H9Kb
	Cp8qE15GZS0TzQj+9VldEmUWsFgIdd8+VOpfnw1wEcgZO11ZLs6C1BXcTWEYtakf7gWeRpX1d8O
	ibSMZVxIufWluKKrrwZyZqJvotJtlJa0UAsF00IWChVnfO3Z4RIxJEwTPkj46YE4vbhUsszT3px
	Jy4qhMs2aMAr/j/mmVJfu3izB3WOXD+cLyMILMc3YKMH5Fyvx5mmtLFpYapTfrPGwAxEP
X-Received: by 2002:a05:6402:915:b0:6ad:186a:fda9 with SMTP id
 4fb4d7f45d1cf-6b49cb595fdmr4258827a12.2.1793287119506; Thu, 29 Oct 2026
 08:18:39 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028-alpha-profileme-v1-0-d44b52bf2500@gmail.com> <20261028-alpha-profileme-v1-3-d44b52bf2500@gmail.com>
In-Reply-To: <20261028-alpha-profileme-v1-3-d44b52bf2500@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Thu, 29 Oct 2026 16:18:28 +0100
X-Gm-Features: AclHuK-WstMEHXHa_Ptp4wLTZ50jgyZfEdzb0_GODwrDd5X15FX2ERZX1amgJLs
Message-ID: <CA+=Fv5QZhtB646nAvoMzbc5O+EdFOnZhXyRrv_1Q-LGWKfbrEQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] alpha/perf: implement ProfileMe sampling
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

On Wed, Oct 28, 2026 at 7:09=E2=80=AFPM Matt Turner <mattst88@gmail.com> wr=
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
> reports. The sample is attributed to PMPC with the mode bit in regs
> adjusted to match, since the interrupt can be taken in a different mode
> than the profiled instruction: in an unaligned access test on EV7 that
> was true of three quarters of the samples. PALmode PMPCs are physical
> addresses, so those samples keep the interrupted PC.
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
>  arch/alpha/include/asm/wrperfmon.h |  12 +++
>  arch/alpha/kernel/perf_event.c     | 157 +++++++++++++++++++++++++++++++=
+++---
>  2 files changed, 159 insertions(+), 10 deletions(-)
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
> index 70840c05d39b..24c96feda942 100644
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
> @@ -276,6 +310,24 @@ static inline void alpha_write_pmc(int idx, unsigned=
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
> @@ -320,7 +372,10 @@ static int alpha_perf_event_set_period(struct perf_e=
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
> @@ -457,7 +512,8 @@ static void maybe_change_configuration(struct cpu_hw_=
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
> @@ -548,7 +604,7 @@ static void alpha_pmu_del(struct perf_event *event, i=
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
> @@ -573,7 +629,7 @@ static void alpha_pmu_stop(struct perf_event *event, =
int flags)
>         struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
>
>         if (!(hwc->state & PERF_HES_STOPPED)) {
> -               cpuc->idx_mask &=3D ~(1UL<<hwc->idx);
> +               cpuc->idx_mask &=3D ~alpha_event_idx_mask(hwc, hwc->idx);
>                 hwc->state |=3D PERF_HES_STOPPED;
>         }
>
> @@ -583,7 +639,7 @@ static void alpha_pmu_stop(struct perf_event *event, =
int flags)
>         }
>
>         if (cpuc->enabled)
> -               wrperfmon(PERFMON_CMD_DISABLE, (1UL<<hwc->idx));
> +               wrperfmon(PERFMON_CMD_DISABLE, alpha_event_idx_mask(hwc, =
hwc->idx));
>  }
>
>
> @@ -602,9 +658,9 @@ static void alpha_pmu_start(struct perf_event *event,=
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
> @@ -644,6 +700,7 @@ static int __hw_perf_event_init(struct perf_event *ev=
ent)
>         struct perf_event *evts[MAX_HWEVENTS];
>         unsigned long evtypes[MAX_HWEVENTS];
>         int idx_rubbish_bin[MAX_HWEVENTS];
> +       bool profileme =3D false;
>         int ev;
>         int n;
>
> @@ -657,9 +714,13 @@ static int __hw_perf_event_init(struct perf_event *e=
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
> @@ -668,6 +729,17 @@ static int __hw_perf_event_init(struct perf_event *e=
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
> @@ -832,6 +904,61 @@ void perf_event_print_debug(void)
>  }
>
>
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
> +       struct pt_regs pm_regs;
> +       unsigned long i_stat, pmpc, ovr;
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
> +        * wherever the interrupt landed, including the user/kernel mode =
that
> +        * perf derives from regs. A PALmode PMPC is a physical address t=
hat
> +        * perf cannot resolve. That happens for ITB miss, Istream access
> +        * violation and interrupt redirects, and for instructions inside
> +        * PALcode. Keep the interrupted PC, which for redirects is the
> +        * instruction that trapped.
> +        */
> +       pm_regs =3D *regs;

On Alpha, perf_reg_value(SP) derives kernel SP from regs + 1.
I think passing this copy therefore reports an address past the local copy,
rather than past the original interrupt frame.

> +       if (!(pmpc & EV67_PMPC_PAL)) {
> +               pm_regs.pc =3D pmpc & EV67_PMPC_PC_MASK;
> +               /* PS bit 3 is the mode bit that user_mode() tests. */
> +               if (pm_regs.pc < TASK_SIZE)

If PMPC is in userspace but the interrupt arrived in kernel mode,
this also makes perf_sample_regs_user() select the copied kernel
registers as user registers, bypassing perf_get_regs_user().

The EV67 HRM, section 6.10.3.2 (pages 6-21/6-22), describes PMPC
as the profiled PC; the interrupt follows window closure (also
Architecture Reference Manual, section E.2.5.1, page E-22).
That does not make the interrupt registers the profiled user state.

Could we preserve the original frame for register/stack capture
and supply the profiled IP and mode separately?


> +                       pm_regs.ps |=3D 8UL;
> +               else
> +                       pm_regs.ps &=3D ~8UL;
> +       }
> +
> +       perf_sample_data_init(&data, 0, hwc->last_period);
> +
> +       if (alpha_perf_event_set_period(event, hwc, 0))
> +               perf_event_overflow(event, &data, &pm_regs);
> +}
> +
>  /*
>   * Performance Monitoring Interrupt Service Routine called when a PMC
>   * overflows.  The PMC that overflowed is passed in la_ptr.
> @@ -866,6 +993,10 @@ static void alpha_perf_event_irq_handler(unsigned lo=
ng la_ptr,
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
> @@ -888,6 +1019,12 @@ static void alpha_perf_event_irq_handler(unsigned l=
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


I'll test this on my ES40 later.

Thanks

Magnus
