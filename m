Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793906312;
	b=zK0aFFe5YrQGIVign1RMXPHFZVvyQKaYD/UBCx5c0gDyC/uta1e6cnyICAn6uYct3CxC
	 QMXvd8C0NjoapFuznBTs1JMCnZf8hcDGIotSPvzzMACRAK5J9zQULSp2mjCckVNgFp97V
	 shtpbpx5Zwbz8EsRRImjWH8K/TVtdI0IidjRtDIcCKeYHsBfsMBk36K0qe+hZwSmY3KVk
	 PqDYzcyS1jCAt+VDjn01qtScePgqpISvOHy4eDsHEc+4+xicig4P6cCxF0MHrH3bxsFmv
	 IAcIbOzP0n7noeV5R5h1BlUECHh6IDgb5W9SKRuCV7+aeUQoDPUMSDqUJi2xqFfOwEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906312;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8ul0rjJXaoWeOZXo5MyeFSNXQ8Y5r/rKYGo2ypC12Mo=;
	b=eGywX6UZF01BSlvfKUnwbEmnVHWC9SY5IodoIRzL4DLt2ZN7M+k92cMQXx8bubRNyG4T
	 wBofjevjFiPdMOP544Hu2J4UCF2K1UUT25Egrsb1tt9eQKec374FGbCgrUfLIGS39sKpm
	 uPhuNrBKVPrSKIL0rzvEfpL7YEI0Q/H4evBWb6oD6qcWC4gMic6BOi3LyQirKeVbtLT7Z
	 F1ab1rH14upOZHMXZ1W4HF6wqxH6uE7HtTr5q4n52SWkd9XHS67rU8EGngnyDSYH3g1D1
	 Y5lC8W1z7hwhfSjyX5UVfD21ue/L7qnnbLJ5DPHsbSrr77tJZoJrlvL8AC+C2KUk7yA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mX4sNr6Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CC0606A31B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 19:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46CC0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mX4sNr6Z
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b1afcd2d23so2130132a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 11:18:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793906311; cv=none;
        d=google.com; s=arc-20260327;
        b=e/CRMPZ+aVTvwhDbRSauQgmUvNHVUWD8PnGXxgoAstMGkex2/2DaFUcFxHay1HfDE5
         cJKwvg7CGRDgkHkaZ63Q1/KPsv6SnLoXTAdr/FQdgL+OIYFmPZImyL+wg21hg1tTWC/i
         nbhwiB2gg8fz9xsQoioOtSqQJ3Ciw3VSSnSa+3iBt9WMuS4diToo3znHyl1vfj0rDaPF
         yDebJmXNx9FkmKrQsiZ8nEMNU0lLYN+YKaygd1SbBdzjd7dz/XR6JIQZCgbrAttW85th
         XRKOx+QutsaYRCTk+aQOu1ubv1wOxKVKdeAXC3EiQNXExL0gWZcWSGdkoxRtkhs/EXom
         +qpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8ul0rjJXaoWeOZXo5MyeFSNXQ8Y5r/rKYGo2ypC12Mo=;
        fh=/aVsPYqpwbTxK9Vt4t0VKuKJivMLMUmpfTjj6eZ2JEU=;
        b=NPSO3BuLRzI8qdcd2Wai3mwkBndN+61UDlGFxMVmhQ0iP/zBQdr+XXpKtrPWcvCPE1
         J4ll+dy621zT7J3KvvUQWSM/IBDON23dsZHjcuYPSZIY3AzPP67HITks+MsnMQBbg1gk
         3RYihDTk+drCJID17W+eJT/jqM5Jg20ViFij2kt91mNVdXwUKNs6U5Jap5Fq7AnhvdMC
         Xe0Th4nyCBteLfnF6QODdXIh1B56ZcW2lBof+0lCemUmrENjYe3N5yU6/ZYTs//zaSg2
         iuyrPXDfSOUcnesvOcPSmoP6MXu76xjd9XqJr5XCMSnhkLq9oEYYn2ly48NQRQXCphrI
         lvTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793906311; x=1794511111; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8ul0rjJXaoWeOZXo5MyeFSNXQ8Y5r/rKYGo2ypC12Mo=;
        b=mX4sNr6Zkw9XI2yPtlzXIuJu74w6sORU67ccRBFHdANMCFmWqqLC57E5pyPsKb7T/+
         uuzA09tFEdgwV7FnmM9l64n7BEq4wguoY0cuDSedCwv9N10rd4nCz3F993e6jQEOHLRf
         c2fEq07kueO+WL1xxtGbWoGHOPdxNhmWvMozF26p/+7H6oidkaZIhXrrAmfW5oFNeL6i
         tnQREi+ksIH0h+fbQzceeBDfOwr/X0CxDfTojVdzPkUGaX+7jfuChVR1u6HrIgg1izT7
         fi4KDrGulEJSmerkA7P/raIOOQ0g3v/59DVa8zp6mkXwnIcEhwa//eykqLpiytZugINd
         Mrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793906311; x=1794511111;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8ul0rjJXaoWeOZXo5MyeFSNXQ8Y5r/rKYGo2ypC12Mo=;
        b=n6s1T4Ke2guAHtAIKJ1yJpLB5x2cCdaVOyRlIUyF0zw/oWMF8rtymxNuodfzwASYm6
         gK0rDOXvDOH56IkOCUB+kyiZWrsLi9B1r7EcZu6W6us20p+3PB30iAjVPn2/HikPt0xr
         WeS7R5Cwi6DsKWGtCHUdB/kgAka+fnMN9QHHZ7IXpOWpqKjd97E1pjh52GqXRIJvL0Lx
         RB6RAVFHsy46RrUm+edERL0o3LbKo4KqaUCYoNvWIhtmIRWS9k6JLeX/3Ji9VSD9hpV6
         IgA3VtfrRW4FQZ5Qkcd4JLdJ/LoqjB+nWbFbaxf9/TB9A8Hi0irtlMC9lkUWh6kyRu7P
         IPOQ==
X-Forwarded-Encrypted: i=1; AKwUvBzdYeJ3yZSrS37ct9klOjwgPKujAb1XshHU7r6dYSADvePOIlXK3t9uvtMApgfCPjcM4fvw7wtVuu7YipQXasYr@vger.kernel.org
X-Gm-Message-State: APuU4Z/GUhd5Grmt3+YijopWGYDGE84YtGn3hChNBJzB4Nc6ApR4Rlxc
	/hHa3S5LRiBoYfm8qawMn9ujOlVUxIXP9aMdGw0kySejbOdWvC0CTfR3raFiPyJl5W9l76SWyK3
	kX6mShSVGPFxIcjf29w1ub60jf8f3jqOJr3XiFhDzNQ==
X-Gm-Gg: AYBFou0j8ptEfHaU8/zuQYQV2vLLul3uH0fbayZivKXu7q6B6jHFoEw0+7A5UwS0yZS
	t9AWQ9KGEgKA47upAJWGd0q33Kg8nROnbE3R9l0u2hMolMqOuqXsoGmKQN1JYCAmpbTRAKVEU9F
	eo4FbIBV28rtwTpdt6IYgZ7tx9RJgTC61NiEwL5qcunQGyOckkNzScwFCHdW6pLZ76rmCkcArlT
	VK2gKnKfR6bAdY7uNLFo6xYXTqbyWNmIo+I92PDioEk08fWNYUoMLvdkt4S67DrusdvUjF+OzEn
	2DU0zv/xRz84QzQXWyuN4ozcFoRmTeuMumbfP3JAIgu7UMqmq0fDbrwsjfDWSLWZE1dQAXDZUQM
	ihT0Sb1SXOT5/yLn7Fq+m5NfHXRI9KMNHtDNwl5XF/yPmOel+zpFf+3kS+76mySEpkcNsTpVKAR
	0pgXGvG7u8CnRFzGGeyFmbnMU=
X-Received: by 2002:a05:6402:2809:b0:6b5:8247:7bd2 with SMTP id
 4fb4d7f45d1cf-6b59752e5ecmr192245a12.3.1793906310496; Thu, 05 Nov 2026
 11:18:30 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com> <20261104-alpha-profileme-v6-13-63362e9290a3@gmail.com>
In-Reply-To: <20261104-alpha-profileme-v6-13-63362e9290a3@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Thu, 5 Nov 2026 20:18:18 +0100
X-Gm-Features: AclHuK9rqLSlmxxFUHUNKij2bInqq2qoTL5wATrmtOQUvBJn0UfhkLxA_3fmAGs
Message-ID: <CA+=Fv5Qi9R=+0fkPsKrJBRThYfdUQdH3hvQ6+0oW-1UjeNm8_w@mail.gmail.com>
Subject: Re: [PATCH v6 13/13] alpha/perf: honor exclude_user and
 exclude_kernel for ProfileMe events
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
> The PMU sets PERF_PMU_CAP_NO_EXCLUDE, as the counters count in every
> mode. perf record then fails for unprivileged users: at the default
> perf_event_paranoid of 2, the tool sets exclude_kernel for them.
>
> A ProfileMe sample says which mode the profiled instruction ran in, so
> the excluded samples can be dropped, as AMD IBS does with swfilt. Do
> that for ProfileMe events, counting PALmode as kernel, and ignore
> exclude_hv, as there is no hypervisor. A sample that falls back to the
> interrupted PC is dropped if either its PC or the profiled instruction
> is in an excluded mode. Aggregate events cannot tell, so event_init
> now rejects their exclude bits itself, along with exclude_idle,
> exclude_guest and exclude_host for all events.
>
> The event count, and what PCTR1 counted during a window, still include
> the excluded modes, as they do for IBS.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/kernel/perf_event.c | 47 ++++++++++++++++++++++++++++++++++--=
------
>  1 file changed, 38 insertions(+), 9 deletions(-)
>
> diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_even=
t.c
> index 7e34eac0ea47..c75d204076fa 100644
> --- a/arch/alpha/kernel/perf_event.c
> +++ b/arch/alpha/kernel/perf_event.c
> @@ -832,6 +832,18 @@ static int __hw_perf_event_init(struct perf_event *e=
vent)
>                 return -EINVAL;
>         hwc->flags =3D profileme ? ALPHA_PERF_FLAG_PROFILEME : 0;
>
> +       /*
> +        * The counters count in every mode, but ProfileMe samples say wh=
ich
> +        * mode the profiled instruction ran in, so those that are exclud=
ed can
> +        * be dropped. PALmode counts as kernel, and exclude_hv is ignore=
d, as
> +        * there is no hypervisor.
> +        */
> +       if (attr->exclude_idle || attr->exclude_guest || attr->exclude_ho=
st)
> +               return -EINVAL;
> +       if (!profileme &&
> +           (attr->exclude_user || attr->exclude_kernel || attr->exclude_=
hv))
> +               return -EINVAL;
> +
>         if (attr->config1 & ~ALPHA_PERF_CONFIG1_FILTERS)
>                 return -EINVAL;
>         if (attr->config1 && !profileme)
> @@ -983,7 +995,6 @@ static struct pmu pmu =3D {
>         .stop           =3D alpha_pmu_stop,
>         .read           =3D alpha_pmu_read,
>         .attr_groups    =3D ev67_attr_groups,
> -       .capabilities   =3D PERF_PMU_CAP_NO_EXCLUDE,
>  };
>
>
> @@ -1140,6 +1151,24 @@ static u64 alpha_profileme_status(unsigned long i_=
stat,
>         return status;
>  }
>
> +/*
> + * Whether exclude_user or exclude_kernel rules out a sample of the prof=
iled
> + * instruction at pmpc, reported at pc. A PALmode PMPC counts as kernel.=
 The
> + * two differ only when the sample falls back to the interrupted PC, and
> + * such a sample is then dropped if either mode is excluded.
> + */
> +static bool alpha_profileme_excluded(struct perf_event *event,
> +                                    unsigned long pmpc, unsigned long pc=
)
> +{
> +       bool pm_user =3D !(pmpc & EV67_PMPC_PAL) &&
> +                      (pmpc & EV67_PMPC_PC_MASK) < TASK_SIZE;
> +       bool user =3D pc < TASK_SIZE;
> +
> +       if (event->attr.exclude_user && (pm_user || user))
> +               return true;
> +       return event->attr.exclude_kernel && !(pm_user && user);
> +}
> +
>  /* What the memory instruction at pc does, or PERF_MEM_OP_NA. */
>  static u64 alpha_profileme_mem_op(unsigned long pc)
>  {
> @@ -1250,14 +1279,6 @@ static void alpha_perf_event_profileme(struct perf=
_event *event,
>                 local64_add(ovr, &hwc->period_left);
>         }
>
> -       /* A dropped sample still counts, for throttling and frequency mo=
de. */
> -       if ((alpha_profileme_status(i_stat, pctr_ctl, pmpc) & hwc->config=
) !=3D
> -           hwc->config) {
> -               if (alpha_perf_event_set_period(event, hwc, 0))
> -                       perf_event_account_interrupt(event);
> -               return;
> -       }
> -
>         /*
>          * Attribute the sample to the profiled instruction rather than t=
o
>          * wherever the interrupt landed. perf takes the sample's mode,
> @@ -1303,6 +1324,14 @@ static void alpha_perf_event_profileme(struct perf=
_event *event,
>                 memset(pm_regs, 0, sizeof(*pm_regs));
>         }
>
> +       /* A dropped sample still counts, for throttling and frequency mo=
de. */
> +       if ((alpha_profileme_status(i_stat, pctr_ctl, pmpc) & hwc->config=
) !=3D
> +           hwc->config || alpha_profileme_excluded(event, pmpc, pc)) {
> +               if (alpha_perf_event_set_period(event, hwc, 0))
> +                       perf_event_account_interrupt(event);
> +               return;
> +       }
> +
>         perf_sample_data_init(&data, 0, hwc->last_period);
>         if (pc_only)
>                 alpha_profileme_drop_regs(event, &data, PERF_SAMPLE_REGS_=
USER |
>
> --
> 2.55.0
>

Tested user-only and kernel-only recordings on all three CPUs of my
ES40. I checked both the raw PMPC and the reported sample mode.

With perf_event_paranoid=3D2, an unprivileged process also recorded
203 user-only samples. Every sample had a user PMPC matching its IP.

Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
