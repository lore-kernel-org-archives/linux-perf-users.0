Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793830293;
	b=jRmuq3S+hkEhto7rbDROI5tM7xMdsmECXnb7UONGIwuwC7uDxfGz9pWjBskjkvoPQsi3
	 OJ5h5QDwp8YeAGCjNfbY6v8BqB2BGDOjDnRwGzziSglQfzkcVkJCn/CMdlaElP7x1LU98
	 SOv5JhvPeeIivv5jd816tJbg9Hpmk8oGCWpDKvTEo2rGcx0Xnyru4wRNSIJFQpKonWFFV
	 L6ekzKiVSnGq2rrimGS7YYg2YfUEAsH9Uwn4rpbCxElbm7YT1ppb3lTmgebVyOhBxjdaL
	 7AYoVZ2TqbfB7BK2xF5ObFgkodOI9o4t9OgLJlo7fiIUbDGN1vpLUOmpGmBRMDtqL1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793830293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=EGlBiCE9y1aipHpdTJ2cp7Guo9/hRSALY5Dt5GVDzPI=;
	b=JQjHgcdNlsJYHGxyJuv/ukTS+D7/kDkxRQ8Hydv+3EI4CbH2Su7NCZTQMazxb8q07aEX
	 J39loJ6pG3JbJzACtpk07JqtDTqkwiKoPiNHPt9i/bUUFrzYfoORDZbKQUjsH5kxpCghf
	 9astOii0xjZI4Rnm1qIE7GuTzJCgHC89QxYz9mR2BAj/Dv+kFL5u1hij18UxiAyb12Hjo
	 gG8NuLAebEld3ZwVsw3WGJVp3F+ia/LK0hhpiQz6RA5TGab3ttexiLmNBiGBvjtm8ylEF
	 V7lSVS9Vx2h/sfklr4KxHPVcFSIDxdFhFS05PSveI8BhlwyJCmylJKBBrg+nIiAESSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uBBDdSja;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B41606A33B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 22:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84B41606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uBBDdSja
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so1880584a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 14:11:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793830292; cv=none;
        d=google.com; s=arc-20260327;
        b=ZujnzWp/RXhBK4iuCOxDA77KoZydrInE1SEaThbXL+Aht1PZjdoepjwin8rXZ3Je5t
         EEPA0rEFWFQBwiRYNdTXMJ7m0ULTy4qGfYRwr9te/6ytiXxUcmH+iOxJV0DhLEaTJztB
         f3AQs2BEJNZgARNIeswMmbwgSpIMf7wOX5YU5D8ZtBF1vN87w0OgTMv0cNCfCIjHYXnO
         26QQF9wrXDzzvLD1LELKRSnb27NXGWTk6DUk+YbZwn9UcNafbW4+FEnrjrYyqwajfh5Z
         grbowks1fNM8BfA4vFGRnVr9hcDYnGa6yNNJcQXsbOLw9E4XjpiEeSUyjczdXaWI3Eui
         iJ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EGlBiCE9y1aipHpdTJ2cp7Guo9/hRSALY5Dt5GVDzPI=;
        fh=+JAc4SUOStCzKwEiQJwoQYmDYL1+Vw4GxYqnKadEeOI=;
        b=DbGtfGfr+kr8qnIxbiK0p+9fauPip5P863NwtvSHuRQVtdmMpFBiicg1JgGTS56QIA
         n12OAaOHsuL1JBGmVVFnrFx7cNGfHzZ8sKa723mkxkPsKEQCQDTVPcc2hoH48flg6QY2
         WLMeFE1wrIJzqGLAnEKXhBHP8MB+hyCdxJWqxwLM+2WsV1PlOmDNTW+ECh6M4dnhW0Dt
         LfX/RyfEc88xAlIWwR2lYueymWRarIZ/Q/2gH1CmTaLnJTgAionS5S6ot3K99Gw2K2fk
         0XKsgPpsyJirNcZb3KEIA0mXEY7/8F2jrNgwuziGNn6o7BW5UqNW+WG5vLAaM0trv77q
         ss1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793830292; x=1794435092; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EGlBiCE9y1aipHpdTJ2cp7Guo9/hRSALY5Dt5GVDzPI=;
        b=uBBDdSja+STCfVqALRK7rclaXxEKAivtHrRY6liSZxvT4tW2UPkEnpTCB9YUAZHAyy
         yh6jK4sh5jG18piBsbOxg5fyHPXBvpFlczChcjTBd0m0dPn+vMeBIZYJ/4Jwu8mpGUma
         0diqU+KkvF94+LJBH3k6F1qIGczNqSkkBaf2J7n0CTFAI/8+wqAej4CW551XZ1jy/bld
         yPe61/ZgQ0SDAyFpkNttxP+6vKUZpWiA6TS8hAT+Htr+YN5aTMyHCBUls4X4DkPrK83o
         9yX4C1JDEGBC7KsU6hWj2S7hH+rMIgFPDotvoxkUffRts2/kCj4769B57sgubzV7iSd5
         M3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793830292; x=1794435092;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EGlBiCE9y1aipHpdTJ2cp7Guo9/hRSALY5Dt5GVDzPI=;
        b=HZl0DlGetxY1yyxsUCuEuEAbkeWHBaI9X8lfLPftlRs9Ow6NzPOdP2cfnnOzPtlL8Z
         xj8/oKzVhBFqGwDggL+kO1zcn55bU/NF6pRDoI3/4H/Q10rzBdurO9Is2+zITSKuvq2w
         eoEf++3EVfA09LxyGsSWDkoHhFAHF5glqkb0wQ7AIxt4LbePI7T0abXKpNDCguvVPcy7
         XA0qwhQmmvEpqeXky0NbgqZ5z8oTZd6FRCHEjAkJi93WrIdp0a1nWTCXu8iJJOr0TH5r
         2ZVHiCLUZE0iV9RfkWNPyu2SSNyVS50RRg6IPu6b4vtovSKX4A0xtqABssZ3SUbdpltK
         r2QQ==
X-Forwarded-Encrypted: i=1; AKwUvBxHaLOtRLLmcqJwvGYgsoYceYn+6IS2jgD/AFhduJ+rkQTOznA/+ptxzgvS5V2OoIXmF7JvKLvGLc8Q8ZT5iJDl@vger.kernel.org
X-Gm-Message-State: APuU4Z8pet7kZU4BgXDJAgl0x1VJcLPYWx4xj1C1n77q0yX6b+Vg+fXE
	MokZCU4BaV2cNz6o84J3LeDjpgdiZ7LCSytq741Nk4VvaxO6I/jKaljKP7U50rpk+8O1ccGej0m
	QxT5mHsT3CQsLPqP0UE1HXg/t3IIWTvw=
X-Gm-Gg: AYBFou2HCYzjGT36iKd8gnTuYdWoXkZy3scsI0mLHWP9cgSqf2nd38f753ZnQHwKgGy
	cKx7ySLmN3mAS3Jfoym0WJGUuiKKrbc6FrarZxP3Y/7OjUsT/AJS77StznRUhLO1meA34r/gtXj
	HP3XnvBr3O+DsQCJqaW9ZvZg1CA+6T75/tR1x0Z2/DSAOPP3+8GATLwvFBcmJwKccXJMwIZieKu
	J8N8exytMdjYLvREdEzxIv62TknElNnx1Z/q+yyj6Oudz+fLoV0C8qkrHLVXcyzYXdAZxqlMAvc
	Fy3dfgEUp8fBBZ8f42quiPsf2FmTUfKWFTq+jOafB8PpvJKOtQc0PVeMuuCa2yslE93fN2l/lhB
	KD/4SpQ8cVc1gHM4nNCilGK2BeTU7BEw2sv6bT7q8gvy7LWvmOry5rcimNgKHdk5Evae+hT65Be
	ju1NxT0eszAdJeeq2Pnv3ZGXc=
X-Received: by 2002:a05:6402:27d3:b0:6b3:fc71:fc29 with SMTP id
 4fb4d7f45d1cf-6b4d33aafabmr14094964a12.6.1793830291784; Wed, 04 Nov 2026
 14:11:31 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com> <20261104-alpha-profileme-v6-9-63362e9290a3@gmail.com>
In-Reply-To: <20261104-alpha-profileme-v6-9-63362e9290a3@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 4 Nov 2026 23:11:19 +0100
X-Gm-Features: AclHuK9rURAADFMaHKSa3C6tUNWpCMLgBwWXXb11rOWiWxNNie3COpwPoW2A6qs
Message-ID: <CA+=Fv5Sp7wkgZ0PXS2RNfVPZ3z8PkFe7zesGgVOUM6oQP9Q1FQ@mail.gmail.com>
Subject: Re: [PATCH v6 09/13] alpha/perf: report the ProfileMe window count as
 the sample weight
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
> What PCTR1 counted during the ProfileMe window, the inum retire delay for
> cycles:p or the window length for instructions:p, is only available in
> the PERF_SAMPLE_RAW data.
>
> Report it in var1_dw of the sample weight, which the weight and
> local_weight sort keys read. It is 20 bits, so it fits. As Alpha is
> little-endian, this is also the right value for plain PERF_SAMPLE_WEIGHT,
> which is what perf record -W asks for. Samples that fall back to the
> interrupted PC get no weight, as it belongs to a different instruction.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/kernel/perf_event.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_even=
t.c
> index b33677cc23ca..c9ab40ff76ad 100644
> --- a/arch/alpha/kernel/perf_event.c
> +++ b/arch/alpha/kernel/perf_event.c
> @@ -1068,7 +1068,7 @@ static void alpha_perf_event_profileme(struct perf_=
event *event,
>         struct perf_raw_record raw;
>         struct perf_sample_data data;
>         struct pt_regs *pm_regs;
> -       bool pc_only =3D false;
> +       bool pc_only =3D false, exact =3D true;
>         unsigned long pctr_ctl, i_stat, pmpc, ovr, pc, saved_pc, saved_ps=
;
>
>         pctr_ctl =3D wrperfmon(PERFMON_CMD_READ, 0);
> @@ -1115,6 +1115,7 @@ static void alpha_perf_event_profileme(struct perf_=
event *event,
>         pc =3D pmpc & EV67_PMPC_PC_MASK;
>         if (pmpc & EV67_PMPC_PAL) {
>                 pc =3D regs->pc;
> +               exact =3D false;
>         } else if (pc < TASK_SIZE && !user_mode(regs)) {
>                 if (is_user_task(current)) {
>                         pc_only =3D true;
> @@ -1124,6 +1125,7 @@ static void alpha_perf_event_profileme(struct perf_=
event *event,
>                         pm_regs->ps =3D 8;
>                 } else {
>                         pc =3D regs->pc;
> +                       exact =3D false;
>                 }
>         } else if (pc >=3D TASK_SIZE && user_mode(regs)) {
>                 pm_regs =3D this_cpu_ptr(&alpha_profileme_regs);
> @@ -1157,6 +1159,15 @@ static void alpha_perf_event_profileme(struct perf=
_event *event,
>         };
>         perf_sample_save_raw_data(&data, event, &raw);
>
> +       /* The count belongs to the profiled instruction, not the interru=
pted PC. */
> +       if (exact && (event->attr.sample_type & PERF_SAMPLE_WEIGHT_TYPE))=
 {
> +               /* perf_sample_data_init() does not clear it. */
> +               data.weight.full =3D 0;
> +               data.weight.var1_dw =3D (pctr_ctl >> EV67_PCTR_1_COUNT_SH=
IFT) &
> +                                     EV67_PCTR_1_COUNT_MASK;
> +               data.sample_flags |=3D PERF_SAMPLE_WEIGHT_TYPE;
> +       }
> +
>         if (!alpha_perf_event_set_period(event, hwc, 0))
>                 return;
>
>
> --
> 2.55.0
>

On my ES40 I compared the sample weight with PCTR1 in the raw record
for all four counting modes. They matched for samples attributed to
PMPC, and samples that fell back to the interrupted PC had weight zero.

Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
