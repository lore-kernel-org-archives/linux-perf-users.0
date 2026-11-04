Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793829272;
	b=5JePdZJ7AxEdDD2y/1sE4sCojkCbnQIGm/F3/HpUZ/3Ubr3RrGsjV+5eQQup2FlKVK2s
	 LjyvHFOx5v5Xd/cle5n0MAYichQDIIdO9KtyGiH4B1jERUelnRgPO5B9kHDYSqJm1zRcR
	 vzdts+X7Fv2UDu6hcnpfWlcckMjp5gHh/Y0rQ26/5htZr9hXLRc4ci5pxNaKglwDU2GNr
	 A4+lzuz7TVJumrhlIRXsetmLfYPuBk0oSmm4VhtDMmTeiqejZC2s26pQK7zprOu247hgb
	 rSCtGppq6O11Tp+IjIj+WXYfK6+rAJ6rgO/zwgST2Mgc/RVlT1D+MsMZo82GlyIwWbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793829272;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HdEmkRtqhrHqr/h8390gKYHp61DBlZJjPh2g+WT5sLY=;
	b=oIdGQATgWNjpg4kPEAZiZEzKi0IO5RTbZt6bgpIpmknVdyPAIjkhImx0BBwcWZI0Jhc2
	 dOg6WuK0CAzvssXBt+l1dd1eePlJ0NXug5jo5gcnsRi0GzdHul34tlVMglottMLLhI8mg
	 aK1I/95IQdeuyWFaSKAvph6/u7Vs9fWhXQB/HBiWJ6kM5KwN7peEvyHSizWJnTa3sH0Uh
	 P7V7cY5fBQWAz5FlTi7HGAUhjdJqxdcEulZBBxloX9r7zROAtDtoH6sQ0S6f2eupbTNrA
	 IwAhROnb3g8BbrYrm8MqfMJqjWhsFSFOt3Lt2McIs8T4+G/OIhGP4HifjMlgr9FP9dg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XD9+WKap;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD566070A9E
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 21:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CD566070A9E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XD9+WKap
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c169ae1cb26so6318866b.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 13:54:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793829269; cv=none;
        d=google.com; s=arc-20260327;
        b=n+9n6Oc99cRPYVyDp+H8MQTTe7Ip/JyPFpwVD+0QRNsxGzDhjyLBRdmZMXmiodbeZL
         eHroHVeMGkwLEffkFWKRfheq5cArDANbrB94YQ8jUBqw/xlPoziQGhzoqd9HJ04Ngqla
         ET6La9lyR0E2as9NG7rNqymlK4+JGgPsZUjwOSJvHEA693N8eLkZ3I5eJQCPzoG+ERAJ
         KiSmSaWpZdMNbeZYAN7qKrqgTh7djb6nTAUoKignMCu5xrky6ermwfspx5muQdVqOTj3
         yffOE5rz/aEpSMKB85AeJL86NfcwX9E8DVAAKloSkgIDHmc3CMlNvWR/F1qZv7JfjYL8
         nfWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HdEmkRtqhrHqr/h8390gKYHp61DBlZJjPh2g+WT5sLY=;
        fh=sNzjdNDqqwCosUb0ROFABmslAGE+cn83v9WzA++5Rwo=;
        b=OlgCF1VwBNQ/Qr+E0V3xsAPzylpyaENph/+MmxoQ6ul5uaefmNyMTcQfBWLjvVaUWY
         ZkvoqFKdouXygWFc24mySQQ+fi+Xh5RPytx0j9rZ+QHosrvuosby9r7W9u/U2gwLkKEM
         kndHm9WiOM9QK+Jp/AcfYisHfNqBio+MBx7H15UV3mwXlEjd7NQqKlFB7L8pIatYEjH7
         bqRB3IAFpeL8lMPxrn4nmmIK72x3a0atcO9wo/YazoDwnfnR5KzfJQrBtiH+dOPhdZcx
         Kabo+ohd1VKQrWo0+/WPb1mDPapOR3DyldWcnyqsNxbxuPf9w29sYFSXQ2MH1q5TmALb
         wg1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793829269; x=1794434069; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HdEmkRtqhrHqr/h8390gKYHp61DBlZJjPh2g+WT5sLY=;
        b=XD9+WKapf71YPUc4xSEtJErlSBsU3gon9Ptl1VqUROsoTbu6y8Q2xhKoL8q4kuBAD6
         d37J/ZrBJDD/FulOg79mYGG7K0j5sIdD/dPFbmkKzUjnQ0pj9/AAP/KMecFclt96VtYs
         15oD2aONPjDvUfnGtMiMq2IiQwVmUQ9uhiXsCK/DeWLUdZbuRy06qKnaNJB5ONh3jaU/
         /p1T2j4379sZ7Nmh2LT7Ua5u5SHaRdH0fyzNnDE7Xi1ldZmSxXEJu541KzJshXDq+vN3
         DDZWnrRszLtunqKCjDFQu7N7leyXg/N5/s+eTzw8NtdzXhUYKoIa1y+h6AkleZw55HlX
         Pv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793829269; x=1794434069;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HdEmkRtqhrHqr/h8390gKYHp61DBlZJjPh2g+WT5sLY=;
        b=UxmfAzD3mKZNxnAm7e+njc0T4Mg9EuhB8ZX9MRTB9lN/bd2DhUhezhYKckPdZPIZFT
         Ch4aLptwuGiQLWSE6i5iSLbcj7BayhpV/t7NXsZNaRIJondirnikxl8Ams3uWohSpjp3
         9KH9zWAPmF+DbI6TmkgAw05pGhBN8o9RVKP/j36D+5w5p2P0tzVK3fEVrZ2Ehe4JA1TK
         W/cDSEMCS+wDgR8nRRNRn0QmQGAepaLq+nHXrwnEBAewp68P6P17Bf4ZXWgwx7YZnj/o
         h8mpXHrkipjbGowdmKpvBmPlGzctpa7S77Dopq+UjxUUcS4G730n6rEOhcekcHMs4Po2
         D/Iw==
X-Forwarded-Encrypted: i=1; AKwUvBw9wlBaHPqL1hmzn//j/xcFuIsNHdAHhtYqm82KP5BZNPbl7ispxYius+fmJha2WUMSyLfElsHfYpBIYhP4oGVI@vger.kernel.org
X-Gm-Message-State: APuU4Z/AXct0mCNolhg6QXxFBIKFUg+l0KDbjSHXyMBRJ9uWl+QuTPip
	j4w4Lq6XnVcINnS5iOlx5DiKA/B1GSvER0Hpu7Pxi2UmFuLloMP4+rlSQ237UJ2x2jbbFgbPUNz
	1joA4j8CaIBu0MrwrimGqjWXkOBwWEcQ=
X-Gm-Gg: AYBFou0ixhcwW6cTloJu6/P/EUsFjhunuQGFarwjB/KDg+4/87KP8THM2lhcBLQ5qM/
	bKDOlycplXMNh6p6YKbJyLc1/Id8q7oCjqxZNI0fX0eFK8qI04+fvCUIcfXAKhPJ6Bl3o4Xs/V5
	mFhPO/pdfmtQy6nIppAU5l6OyVr9upGGAgLO2NI9of9cTScjM+RjpM3lsO64AwHb3F0u94XGwhA
	8xt9akmu1MRMH1we+DQ+pPqd4WbLBINqmR5pJGANn0ncxKc3rzjLrGwIOC86Ep3h5VLx22PDAJg
	dQmbSO0T9cvDGtb9WLSAMNryS4moNm0IKgDoIBee/gjU8kujJe54F6JN3sJSEAtfPfYD0TvCT7K
	YzGU2VvS+xBEymHjwLwHWY9pfu6GrGvHsmYjmGgu+mdC6G3HZhvtGf5qZgt4BthIlkLwBbTB8He
	P9EBNLShi/mezHysd9a1m/fYY=
X-Received: by 2002:a17:907:d649:b0:c36:777f:824c with SMTP id
 a640c23a62f3a-c4d20152725mr68425566b.4.1793829269124; Wed, 04 Nov 2026
 13:54:29 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com> <20261104-alpha-profileme-v6-5-63362e9290a3@gmail.com>
In-Reply-To: <20261104-alpha-profileme-v6-5-63362e9290a3@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 4 Nov 2026 22:54:15 +0100
X-Gm-Features: AclHuK8czF3vrbOSg0UUMnEzeHK7PETQNCiHD3zwCys0pWFAup8U0S_Vzp2Fbbk
Message-ID: <CA+=Fv5QO-jD+K00xUSv3yYS+yeAzOCAkiUpD-5aP9+vuEkg4nw@mail.gmail.com>
Subject: Re: [PATCH v6 05/13] alpha/perf: ignore overflow interrupts the
 counter does not account for
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

On Wed, Nov 4, 2026 at 7:49=E2=80=AFPM Matt Turner <mattst88@gmail.com> wro=
te:
>
> The interrupt handler adds a full counter period to the count of the
> event on the counter that interrupted, which goes wrong in two cases.
>
> Rewriting a counter does not cancel its pending interrupt: wrperfmon has
> no way to, and PALcode clears the request only when delivering it. An
> interrupt pending when an event is reloaded, or when perf moves another
> event onto the counter, is then taken as an overflow of a counter that
> has not overflowed. It adds a bogus period to the count and can emit a
> false sample.
>
> And alpha_perf_event_update() already adds the period when a read finds
> that the counter overflowed before its interrupt was taken. The
> interrupt then adds it again.
>
> An overflow leaves the counter just past zero, below the value it was
> written with, while a counter that has not overflowed is at or above it.
> Ignore an interrupt for a counter in the latter state, unless a read
> has already counted the overflow, in which case add nothing. For this to
> hold, write the counters at most half their range below overflow, as
> armpmu_event_set_period() does. Counting events then take an interrupt
> every 2^19 events rather than every 2^20.
>
> Fixes: 979f867191f8 ("alpha: implement HW performance events on the EV67 =
and later CPUs")
> Suggested-by: Ian Rogers <irogers@google.com>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/kernel/perf_event.c | 59 ++++++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 52 insertions(+), 7 deletions(-)
>
> diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_even=
t.c
> index ecec78c355cd..dd7fc4ac1396 100644
> --- a/arch/alpha/kernel/perf_event.c
> +++ b/arch/alpha/kernel/perf_event.c
> @@ -30,6 +30,9 @@
>  #define MAX_HWEVENTS 3
>  #define PMC_NO_INDEX -1
>
> +/* hw_perf_event.flags */
> +#define ALPHA_PERF_FLAG_WRAPPED                0x1
> +
>  /* For tracking PMCs and the hw events they monitor on each CPU. */
>  struct cpu_hw_events {
>         int                     enabled;
> @@ -315,10 +318,16 @@ static int alpha_perf_event_set_period(struct perf_=
event *event,
>         if (unlikely(left < alpha_pmu->pmc_left[idx]))
>                 left =3D alpha_pmu->pmc_left[idx];
>
> -       if (left > (long)alpha_pmu->pmc_max_period[idx])
> -               left =3D alpha_pmu->pmc_max_period[idx];
> +       /*
> +        * Start at most half the counter's range below overflow, so that=
 the
> +        * value an overflow leaves, just past zero, is always below the =
value
> +        * written. See alpha_perf_event_ovf().
> +        */
> +       if (left > (long)(alpha_pmu->pmc_max_period[idx] >> 1))
> +               left =3D alpha_pmu->pmc_max_period[idx] >> 1;
>
>         local64_set(&hwc->prev_count, (unsigned long)(-left));
> +       hwc->flags &=3D ~ALPHA_PERF_FLAG_WRAPPED;
>
>         alpha_write_pmc(idx, (unsigned long)(-left));
>
> @@ -338,9 +347,9 @@ static int alpha_perf_event_set_period(struct perf_ev=
ent *event,
>   * zero.  The value passed via ovf by the interrupt handler corrects for
>   * overflow.
>   *
> - * This can be racey on rare occasions -- a call to this routine can occ=
ur
> - * with an overflowed counter just before the PMI service routine is cal=
led.
> - * The check for delta negative hopefully always rectifies this situatio=
n.
> + * A call to this routine can occur with an overflowed counter just befo=
re
> + * the PMI service routine is called. A negative delta detects this, as =
the
> + * counter is always written at most half its range below overflow.
>   */
>  static unsigned long alpha_perf_event_update(struct perf_event *event,
>                                         struct hw_perf_event *hwc, int id=
x, long ovf)
> @@ -359,10 +368,12 @@ static unsigned long alpha_perf_event_update(struct=
 perf_event *event,
>         delta =3D (new_raw_count - (prev_raw_count & alpha_pmu->pmc_count=
_mask[idx])) + ovf;
>
>         /* It is possible on very rare occasions that the PMC has overflo=
wed
> -        * but the interrupt is yet to come.  Detect and fix this situati=
on.
> +        * but the interrupt is yet to come.  Detect and fix this situati=
on,
> +        * and tell the interrupt not to count the overflow again.
>          */
>         if (unlikely(delta < 0)) {
>                 delta +=3D alpha_pmu->pmc_max_period[idx] + 1;
> +               hwc->flags |=3D ALPHA_PERF_FLAG_WRAPPED;
>         }
>
>         local64_add(delta, &event->count);
> @@ -835,6 +846,32 @@ void perf_event_print_debug(void)
>  }
>
>
> +/*
> + * Return the overflow that an interrupt from counter idx adds to the co=
unt,
> + * or -1 if the counter has not overflowed since it was written.
> + *
> + * Rewriting a counter does not cancel its pending interrupt: wrperfmon =
has
> + * no way to, and PALcode clears the request only when delivering it. So=
 an
> + * interrupt can arrive after the counter was reloaded or given to anoth=
er
> + * event. The counter is then at or above the value written, whereas an
> + * overflow leaves it just past zero, below that value.
> + */
> +static long alpha_perf_event_ovf(struct hw_perf_event *hwc, int idx)
> +{
> +       unsigned long prev;
> +
> +       /* alpha_perf_event_update() has already counted this overflow. *=
/
> +       if (hwc->flags & ALPHA_PERF_FLAG_WRAPPED)
> +               return 0;
> +
> +       prev =3D local64_read(&hwc->prev_count) & alpha_pmu->pmc_count_ma=
sk[idx];
> +       if (alpha_read_pmc(idx) >=3D prev)
> +               return -1;
> +
> +       return alpha_pmu->pmc_max_period[idx] + 1;
> +}
> +
> +
>  /*
>   * Performance Monitoring Interrupt Service Routine called when a PMC
>   * overflows.  The PMC that overflowed is passed in la_ptr.
> @@ -847,6 +884,7 @@ static void alpha_perf_event_irq_handler(unsigned lon=
g la_ptr,
>         struct perf_event *event;
>         struct hw_perf_event *hwc;
>         int idx, j;
> +       long ovf;
>
>         __this_cpu_inc(irq_pmi_count);
>         cpuc =3D this_cpu_ptr(&cpu_hw_events);
> @@ -891,7 +929,14 @@ static void alpha_perf_event_irq_handler(unsigned lo=
ng la_ptr,
>         }
>
>         hwc =3D &event->hw;
> -       alpha_perf_event_update(event, hwc, idx, alpha_pmu->pmc_max_perio=
d[idx]+1);
> +       ovf =3D alpha_perf_event_ovf(hwc, idx);
> +       if (ovf < 0) {
> +               /* The interrupt was pending when the counter was written=
. */
> +               wrperfmon(PERFMON_CMD_ENABLE, cpuc->idx_mask);
> +               return;
> +       }
> +
> +       alpha_perf_event_update(event, hwc, idx, ovf);
>         perf_sample_data_init(&data, 0, hwc->last_period);
>
>         if (alpha_perf_event_set_period(event, hwc, idx))
>
> --
> 2.55.0
>

The wrapped flag addresses my concern about a read accounting for an
overflow before its PMI arrives. I checked that sequence and the
stale-PMI-after-reload case with simulated counter values.

On my ES40, repeated reads while multiplexing Aggregate and ProfileMe
events passed on all three CPUs. I didn't instrument the stale PMI
itself on hardware.

Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
