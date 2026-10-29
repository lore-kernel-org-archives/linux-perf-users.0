Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793286128;
	b=UAm5X9fMTTeFaKpvYn1+qDNrRbVy7nCfrwUhpCKHFp5mADdroNqVSQbdmbi81IWsaS3U
	 zLeAla1DKq/RdqmE34oIWVOGyDCC1gLoLtCKLHG8nUAkVaDzYGYKCc8SCm4DfFSKKZ47G
	 1xEu4Hq5PVh/H2YWXzRGmu2vWjhWWp6u77PEH34UdZQbmg6fN3zUuyQVWEWcsNYwFuE5f
	 q6BzukBslfFH0nFAZ9oG+c5RonBEm9HtYpVeiBIRdq9ALELj88eJsN2k57c9HghL6QGZi
	 voTaUtq/n40UVx5CaEOMPFxN66AE9bnWMjkmNvCDjF/DIKvNir903jJ3ZzsxU8F89cQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3pv54lpPQ42UJPfl7NiVIVr5xpTo5h1NIoL6uWP0Qlk=;
	b=Z8vGkRBQx2/MyIHpyypka0mmHQfnaq5sRlJbDfjbMBr+0pXJcrV8DddiGyAkCioNLZwk
	 xSOBHrfNNhznzRby/d3IyO00a8wtC90BGpxCbzvnCxNNRKYWAkObe/Sapt3O0gBfnkYL7
	 VBKMKD+fAXV/Rc5OWFYN+KhrDeGtFE56OfLYnyb537a9+vkgENXf9TRxH1pR3BZfBRLPL
	 jplcVVuWaUbCMLJiJkoToZ1uterrSYHrakd8u3U/9oqY9qXJoZwMH33pvQQFyxjTgekr3
	 tloHjeXKuD8Mbe8mph/Buhh0Q0g6QlwQTlJpnEL5mCpxnYsqKBBH4nJum1grklD+dlw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=At8KQKvW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244F9606A32D
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 15:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 244F9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=At8KQKvW
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4682977f9aso284084966b.1
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 08:02:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793286125; cv=none;
        d=google.com; s=arc-20260327;
        b=hnzaln5poVLMjGl8jDj+YFLr3ie2pK5iv47yelRXwXUmCxVnPh8VC9PFmf9vmSUlas
         6Pywm5EMsnBLvZ+hdXvmyGheirblxgeWY/K5SMXbimefDD+0/kIusS3p6xFsTammH8MW
         uVKegvBOg1YCMNheVkpMMskKx+NNx4KTzoPNazoVWJOl0oBQMgJM44ZLBUnmm9ypccac
         wYQm+0vga1VfA3x/NErXA2mDWafDOAhznl3N94DKXDRbaG4IeBR+ZfczvZNJzqUcONAp
         O/2dphT1SRxcDs4B+e9Ror4NIRWj9Cu31pqkDVAjfYegv2nF1n7eoiL5DYVB/afENvEL
         Mocg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3pv54lpPQ42UJPfl7NiVIVr5xpTo5h1NIoL6uWP0Qlk=;
        fh=vXBryeFm2kbY+pndaScLqNp7FPAnEn3NjQUl5Klj+Yo=;
        b=l5fwmZcDEgGG3K1RfAwV2JZtUeLvx0JA1o+g/m6TSkd5/YZAkjCuNnQlEczypYb1D+
         rjQuA63rLHZPV3jhb2THPs3AezBhHyreRTFQgsvGq9LIr4H9ebY1BoUrS5A9gW9Q4gWW
         BNAQ11LpdZj/J1Nyeh6ltPxtpA82SkQ1HoLKULwiFS+O4mLJhJMhNBX1Ra+mXCH0iPpd
         xsxcJdT+gHQkbK9zu8k0x1TTnJ/eM/mSWp2HlMrqDYJN0kRmCtianfb1F2x0+6d90u5V
         uKPb2ngZ7tJrroki3g2xgZ1KNu5FXEqbudOqIju66//Rph4bULAo350O00N689qU0uaz
         5eFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793286125; x=1793890925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3pv54lpPQ42UJPfl7NiVIVr5xpTo5h1NIoL6uWP0Qlk=;
        b=At8KQKvWo8fhNk7ywdT7FNDhpC3ba7IwiYlI7QmFy7Zh3uJJY4cGFeNFCR7BjY9ix0
         Z0LycXeX1d7ozowebTUnosQYM3e0PA4OBDFuKc8XhQQWprwTpYgrRgeFq5c5YRtM+/J1
         APL9/PifUoPMDSW0FVca4S4a4DhjU85h6eVasm15MpBB4SSd/uFe9e2USgS0tVMxtSom
         N/qyqp6LogRmNVZxui1J90unNeWqvpYBjFg8EMdUWe/bycEmgEEmkx8XeMd2U5/u01EQ
         3KuGQZpZJe+HCxk16t3EEUK9x/XgzJHEVq2C7X7nbLxwzAcE2FV8kKPE3ctva+3ZPMP1
         7V8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793286125; x=1793890925;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3pv54lpPQ42UJPfl7NiVIVr5xpTo5h1NIoL6uWP0Qlk=;
        b=2VWO8aGtgh26BqhPTv6gFn+Of3MV7jC2F5N/24IVzCbSACGhCQryBMlANN3QNt5b2f
         jt1T2/lwBs8yxYS6CH1rrZ7kX0cPOgOiBU2q2+F9tlSxA8GYPYvIQ9IOeXdCt3o87FyI
         480hB+IX/EtVx14GsEfHV4YKx03XdJXsNFWQ1b4TewSwjMz+F1lYvxatl6j61ShANppa
         CFAEbpshZR+/6049U6zz3xShRtbBKgXnfn3P1pvSoQOVSD36SXwir51dFls9sp7CIRri
         gGxoInyw6bXETwjExwxKWD0EhqYL9+FlNZ8GpNOXJu+SCYdvDV181s0bgP5dbGaMo/UY
         KDUA==
X-Forwarded-Encrypted: i=1; AKwUvBwOVnGcFDj/i62qcWqh3Ix7q8FK96stlovXDRsL9vq4lO44N2zkyB4DxrrbhuRBN6zLLO7R90/nFmnkhITcra2S@vger.kernel.org
X-Gm-Message-State: AFq9FYLnUWYT8gfwy0IJOJqIsipCEAx2MgE14oQbt1B44TLYwqZexPWx
	LWcDD25Q+8qDdXNkSnNJuwPjKIoU0BwB5uAtfIMqMS6oZlbAVw3UCfC2W10Lv73+x1aHEV/plXp
	1KQUc7sjOvB7wFF64hQLQFeA2aOFKZpE=
X-Gm-Gg: AYBFou2Aysknjsgv45XzooOw4qCeJ0HjQQiM9xIKFmfdkKWVBAsLAihiGNBoyTGAflB
	VBv1RxWA6CxGVtQpVik+6uwRtmjw0O8+JkwYTUvXj9zXuzDoBeaE915IAga4a/A0CBMGJoSog95
	53qgwtlmuegtu2w/nsUKKqUMGCPwUB/zOd44JPscplkzYUOQt7eqHDonb8e6JZnI0O9ulCge4J+
	is46XBNhXo/F5R9huXWXxfW0BYa5dv8xISyJ+qhFnaaiv0d6GpFB7jgG68S56wUHCHzYmWXpg62
	FImImPUPpI6YdYChHRII68ts0ztmOXntCXagsZNDcUS+Lgah+/59KPHxMDL75of58Zp/iiK94xC
	iG7kxNERSKipmj68dqz69wlpjCgzZ7b895ZVpUPDsk1BTnfvU8QwSBu8umq1nWJt4+Q25
X-Received: by 2002:a17:906:794e:b0:c33:ae8b:817d with SMTP id
 a640c23a62f3a-c49bdf9016cmr515625366b.46.1793286125001; Thu, 29 Oct 2026
 08:02:05 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028-alpha-profileme-v1-0-d44b52bf2500@gmail.com> <20261028-alpha-profileme-v1-5-d44b52bf2500@gmail.com>
In-Reply-To: <20261028-alpha-profileme-v1-5-d44b52bf2500@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Thu, 29 Oct 2026 16:01:53 +0100
X-Gm-Features: AclHuK-GNrjKeGtxUttAzHxHHU9r3Wn59K2y6AwVpRTg9_F9nYsnOjJyieFCY_M
Message-ID: <CA+=Fv5S5S3o1=2LetFuLQNqjtuw0DTgxVWAYAiAVvsdUNgNEyQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] alpha/perf: optionally randomize the ProfileMe
 sampling interval
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
> A fixed sampling interval can phase-lock with a loop whose length divides
> it, so that the same few instructions are profiled over and over while
> the rest of the loop is never seen. DCPI avoided this by randomizing the
> interval.
>
> Add a randomize config bit that varies each interval by up to 1/16 of
> the period in either direction. Only ProfileMe events accept it, since
> Aggregate mode samples already land a variable distance from the
> instruction that overflowed. Counts are unaffected, because prev_count
> already records the value actually written to the counter.
>
> The jitter comes from a per-CPU prandom state rather than
> get_random_u32_below(), which takes the batched entropy local lock and
> triggers an invalid wait context report from lockdep in the PMI.
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/kernel/perf_event.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_even=
t.c
> index 06c9afeb7c05..da8262c74d04 100644
> --- a/arch/alpha/kernel/perf_event.c
> +++ b/arch/alpha/kernel/perf_event.c
> @@ -16,6 +16,7 @@
>  #include <linux/kdebug.h>
>  #include <linux/mutex.h>
>  #include <linux/init.h>
> +#include <linux/prandom.h>
>
>  #include <asm/hwrpb.h>
>  #include <linux/atomic.h>
> @@ -33,9 +34,11 @@
>  /* Layout of attr.config for PERF_TYPE_RAW events; see format/ in sysfs.=
 */
>  #define ALPHA_PERF_CONFIG_EVENT                0xffULL
>  #define ALPHA_PERF_CONFIG_PROFILEME    BIT_ULL(8)
> +#define ALPHA_PERF_CONFIG_RANDOMIZE    BIT_ULL(9)
>
>  /* hw_perf_event.flags */
>  #define ALPHA_PERF_FLAG_PROFILEME      0x1
> +#define ALPHA_PERF_FLAG_RANDOMIZE      0x2
>
>  /* For tracking PMCs and the hw events they monitor on each CPU. */
>  struct cpu_hw_events {
> @@ -59,6 +62,9 @@ struct cpu_hw_events {
>  };
>  DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
>
> +/* For randomizing sample intervals from the PMI, where locks are not al=
lowed. */
> +static DEFINE_PER_CPU(struct rnd_state, alpha_perf_rnd);
> +
>
>
>  /*
> @@ -246,10 +252,12 @@ static int ev67_raw_event_valid(u64 config)
>
>  PMU_FORMAT_ATTR(event, "config:0-7");
>  PMU_FORMAT_ATTR(profileme, "config:8");
> +PMU_FORMAT_ATTR(randomize, "config:9");
>
>  static struct attribute *ev67_format_attrs[] =3D {
>         &format_attr_event.attr,
>         &format_attr_profileme.attr,
> +       &format_attr_randomize.attr,
>         NULL,
>  };
>
> @@ -360,6 +368,20 @@ static int alpha_perf_event_set_period(struct perf_e=
vent *event,
>                 ret =3D 1;
>         }
>
> +       /*
> +        * Vary each new interval by up to 1/16 of the period either way,=
 so
> +        * the samples cannot phase-lock with a loop whose length divides=
 the
> +        * period. The count stays exact because prev_count records the v=
alue
> +        * actually written.
> +        */
> +       if (ret && (hwc->flags & ALPHA_PERF_FLAG_RANDOMIZE) && period >=
=3D 8) {
> +               long jitter =3D period / 8;
> +               u32 r =3D prandom_u32_state(this_cpu_ptr(&alpha_perf_rnd)=
);
> +
> +               left +=3D (long)((u64)r * jitter >> 32) - jitter / 2;
> +               local64_set(&hwc->period_left, left);
> +       }
> +

One minor corner case? This  multiplication can overflow for very
large  sample periods. I guess normal sampling periods are not
affected, is it worth using overflow-safe multiply/shift to avoid this
limitation?

>         /*
>          * Hardware restrictions require that the counters must not be
>          * written with values that are too close to the maximum period.
> @@ -715,7 +737,8 @@ static int __hw_perf_event_init(struct perf_event *ev=
ent)
>                 return -EOPNOTSUPP;
>         } else if (attr->type =3D=3D PERF_TYPE_RAW) {
>                 if (attr->config & ~(ALPHA_PERF_CONFIG_EVENT |
> -                                    ALPHA_PERF_CONFIG_PROFILEME))
> +                                    ALPHA_PERF_CONFIG_PROFILEME |
> +                                    ALPHA_PERF_CONFIG_RANDOMIZE))
>                         return -EINVAL;
>                 ev =3D attr->config & ALPHA_PERF_CONFIG_EVENT;
>                 if (!alpha_pmu->raw_event_valid(ev))
> @@ -740,6 +763,14 @@ static int __hw_perf_event_init(struct perf_event *e=
vent)
>                 return -EINVAL;
>         hwc->flags =3D profileme ? ALPHA_PERF_FLAG_PROFILEME : 0;
>
> +       if (attr->type =3D=3D PERF_TYPE_RAW &&
> +           (attr->config & ALPHA_PERF_CONFIG_RANDOMIZE)) {
> +               if (!profileme)
> +                       return -EINVAL;
> +               prandom_init_once(&alpha_perf_rnd);
> +               hwc->flags |=3D ALPHA_PERF_FLAG_RANDOMIZE;
> +       }
> +
>         /*
>          * We place the event type in event_base here and leave calculati=
on
>          * of the codes to programme the PMU for alpha_pmu_enable() becau=
se
>
> --
> 2.55.0
>

I'll report back once I've done some testing on real hardware.

Thanks

Magnus
