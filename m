Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E8538AC91
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Apr 2026 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775143828; cv=pass; b=WTNY8aFhRD2z58CVK9UGEb4acIMcgRgLpAiTbyleUuEgX59Txsi41MRDRKAtPxl9NB7R9cqQaV+9Io2nuDRFwOquK07AnF1H0+6ov70lSMxN0Sb7KFTOSa1yaVqHJqy3sABm8SLDgViwq4Q+YObFLuEi2m4OeFdMhbmQcSUlAJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775143828; c=relaxed/simple;
	bh=JZFjXO/jfZfhRYVqajlzU08tgbq12iwxWILX1Zz+5cY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHW3C9kn+XdtMtwVSGH9ugs83i1SAHw57Tq9Q6Jj6/aXgaXyiUi6H2GwZBVqgE4DonLw+/NN/41pDIPjf+Plc5jqZTZT065Y33O2+m6rARfE6fReUVqNiFrrOzK353ocNqj8rKPSr6IlX6jzTetH4+N8H2Ypb/eNDPGVvlBaT4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NSpBe2n4; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NSpBe2n4"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b2591757fbso119815ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Apr 2026 08:30:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775143827; cv=none;
        d=google.com; s=arc-20240605;
        b=Xu/SMYPHw335a16vEPdUGI1zyl7atqO2ZqpXp0RoiDI1vtqnmAWnk4dU+ce+b0fRBh
         JV7Z5KcACx9v6Es3f4ldVpsVFg4K77H0qs+avwiuY4WH0Qojkiyaj8AkHXDoOA0F4F8+
         rsKBE6hbvFwC3JywfYtplvsMddw6K82l6v8d0bymSb6gOTHNuLImdXJbhUxf6z2S2elD
         eb5VjgUWfuCq6ft3pEtJ86kGY6iMJHlAU9vG8AjYKp+KTYNXaaXBlwFRFNDi69sZ39DZ
         B/Q+0seWvD6OVnB6amgqtrHAIfMamWJw29YrVI1VfY5KvFigDhE7/Xhx/chrGfK5zQtw
         btgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I5haVRGC9b7QkQ0SSs9IjxxUXgTNuHV1w/UHzqTO5Ok=;
        fh=BAS4YuL72xbnq46spPKkqDUOcBtdtW9FeDyWGSS3GYk=;
        b=B4IvVd6AUudLVnR6zXJvlfOpXwGQKyUU8Ilvtw3zwB/V5Ytcoh1fiPqgE4yfz3qGnH
         8XY7DOyHP6CrnSJUY/GaJcA1/UVxV2L+No7+fv92irphHQh+UWgiA7Qps+8/asyai/dG
         jAvEg20aV8pZxCFzR2GtYtintH4xGzilM4mc2gvXgLchNCLcuEMeVClwB9Snd68r7O/E
         M7mqTj9J/2FDPEp0M7NjP9irIMR8AolVOeFHX/6/bl2ykh5DAcri4yNO2wDZJoOiKsqt
         vM6GO4oJr0kalEsqtQ5ckU1lHNul8ei8EyisekHZcIvRDkorJVMaU5pbAK8N1RFIFWVf
         LYSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775143827; x=1775748627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5haVRGC9b7QkQ0SSs9IjxxUXgTNuHV1w/UHzqTO5Ok=;
        b=NSpBe2n4aQqfgVAgJ8HhmhsBc/U0nrNRxy8yvXELQ8/80cDG4LPKK7EsRl+aJqZF7C
         uGINzJFkc6rHavgVB1cy6oplqTjFQefGAZTNEX8nNa0LAzHUlOYJLUSVxFPDjQ6miAH7
         gSi0XXmhegqiiwE3F8WmeCV4qUSgL53o4+nkZInQKMoh5ZJ4iAHlK3Bq0Ikg9OB/x9IQ
         90kQZuQNCo0LEY9S2loZElKLaJGWG74kzkiZZLLNFdZyLAxb3wgHx0hNPWUiWb6mIOQW
         DEOnQnhqC5/sJNRKtVlwG2GvpXiB09HZxVj250P4Bxc9wEIHDnh1Nobu6rdyh9ImUhuM
         Ej8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775143827; x=1775748627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I5haVRGC9b7QkQ0SSs9IjxxUXgTNuHV1w/UHzqTO5Ok=;
        b=KT+rTuDsVbWOMigmQUzISFbkPVxumYt0qHAJwSWx2HnHSIlmRvJsPT02jgmcwLB1YF
         c96z0dKtKLAsgSNryl5L10YJ0Zn6LcPS9YyeTh43+9jquSCOAHDBKGdRxWcHn/LHXMrm
         5GzisINTzoN+mgkDBiY9VcDlnIbaBwKKyGnsDn3J6BIzmKrJjfjNlfO9vl/hkWk6HVqA
         hsnFEDG4bUkLmXQqwLrI1rrNAfbj7nkXycbj6jC1TzuhnKPYoARFIACgkVtGMo2o+mlW
         PtxqwNLOxvYLYqjOryINxq7ZXP70BS7Hhx08vdQ0/6O2I5slfHb+YOr/7hKEeqTteT0u
         Wf5g==
X-Forwarded-Encrypted: i=1; AJvYcCWqqQ4D8v6yuGRQSvCYO0A129O9hLn7Y1pQ4FGTyxk1pMEC7TGYsohxnS9ExvYO40dIm1gNegQTNU8/ZWi+fHoY@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc0kU5Kf3E60uVlbtuQ1Wl6SIhHpaRzdGRbg+YsvyB1xTBeSLP
	zcu46R/j6aWNeZnzBryd9x9FZhWK2V2TOBQ9j0pZn7UjV1imh/ghMyYkGIrF3tk5oOHdD0lBUm2
	i5YWNEGRPEdABdR12j6/nA/zk9UqRCfvLufuzD2r4
X-Gm-Gg: AeBDiesmAdKhZrzoatvA74e7hISQBoGkBE7Pqo50HoqxWoPdrS0Wk9Kb2PMpLHfOHPZ
	jhg5QuNMSFLyM6Dmdb2OuUYHCOk0uWDCnIuWI55UZ47gPw9trIKaiUrwBQbxnIwOY8l6Q9/M0QH
	rQSNHHOy9QH9AAwxaTSdcZ+EO6knHubCYqSN8+fPOehe5A+U8ojokHwUs9H4s7rRO6oPsjjucxM
	BNlwyFK6wy3PE70wZdh3yJWzcq25uYv4kBCiMBPF/unPpZHx6uBFFJLnC2fSLxzxTLFrnCyxW/X
	XCOTD+c408SWR2mrHp9XpTyw6UYhgJWj1iXx
X-Received: by 2002:a17:903:b8d:b0:271:9873:80d9 with SMTP id
 d9443c01a7336-2b278455672mr2105515ad.7.1775143826015; Thu, 02 Apr 2026
 08:30:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401-james-spe-impdef-decode-v1-0-ad0d372c220c@linaro.org> <20260401-james-spe-impdef-decode-v1-2-ad0d372c220c@linaro.org>
In-Reply-To: <20260401-james-spe-impdef-decode-v1-2-ad0d372c220c@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 2 Apr 2026 08:30:14 -0700
X-Gm-Features: AQROBzAP6yKuK4YHefgxpwrxzp8Y2RKU7903BiEjJc1CooYruerIUT1QOmGlPIg
Message-ID: <CAP-5=fXxogy1-ZijUy1oWEjOM6JOzxE6erXEi0_uEzTc7M8vVQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf arm_spe: Turn event name mappings into an array
To: James Clark <james.clark@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 7:26=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
> This is so we can have a single function that prints events and can be
> used with multiple mappings from different CPUs. Remove any bit that was
> printed so that later we can print out the remaining unknown impdef
> bits.
>
> No functional changes intended.
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     | 88 +++++++++++-----=
------
>  1 file changed, 43 insertions(+), 45 deletions(-)
>
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tool=
s/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 5769ba2f4140..c880b0dec3a1 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -276,6 +276,48 @@ static int arm_spe_pkt_out_string(int *err, char **b=
uf_p, size_t *blen,
>         return ret;
>  }
>
> +struct ev_string {
> +       u8 event;
> +       const char *desc;
> +};
> +
> +static const struct ev_string common_ev_strings[] =3D {
> +       { .event =3D EV_EXCEPTION_GEN, .desc =3D "EXCEPTION-GEN" },
> +       { .event =3D EV_RETIRED, .desc =3D "RETIRED" },
> +       { .event =3D EV_L1D_ACCESS, .desc =3D "L1D-ACCESS" },
> +       { .event =3D EV_L1D_REFILL, .desc =3D "L1D-REFILL" },
> +       { .event =3D EV_TLB_ACCESS, .desc =3D "TLB-ACCESS" },
> +       { .event =3D EV_TLB_WALK, .desc =3D "TLB-REFILL" },
> +       { .event =3D EV_NOT_TAKEN, .desc =3D "NOT-TAKEN" },
> +       { .event =3D EV_MISPRED, .desc =3D "MISPRED" },
> +       { .event =3D EV_LLC_ACCESS, .desc =3D "LLC-ACCESS" },
> +       { .event =3D EV_LLC_MISS, .desc =3D "LLC-REFILL" },
> +       { .event =3D EV_REMOTE_ACCESS, .desc =3D "REMOTE-ACCESS" },
> +       { .event =3D EV_ALIGNMENT, .desc =3D "ALIGNMENT" },
> +       { .event =3D EV_TRANSACTIONAL, .desc =3D "TXN" },
> +       { .event =3D EV_PARTIAL_PREDICATE, .desc =3D "SVE-PARTIAL-PRED" }=
,
> +       { .event =3D EV_EMPTY_PREDICATE, .desc =3D "SVE-EMPTY-PRED" },
> +       { .event =3D EV_L2D_ACCESS, .desc =3D "L2D-ACCESS" },
> +       { .event =3D EV_L2D_MISS, .desc =3D "L2D-MISS" },
> +       { .event =3D EV_CACHE_DATA_MODIFIED, .desc =3D "HITM" },
> +       { .event =3D EV_RECENTLY_FETCHED, .desc =3D "LFB" },
> +       { .event =3D EV_DATA_SNOOPED, .desc =3D "SNOOPED" },
> +       { .event =3D EV_STREAMING_SVE_MODE, .desc =3D "STREAMING-SVE" },
> +       { .event =3D EV_SMCU, .desc =3D "SMCU" },
> +       { .event =3D 0, .desc =3D NULL },
> +};
> +
> +static u64 print_event_list(int *err, char **buf, size_t *buf_len,
> +                           const struct ev_string *ev_strings, u64 paylo=
ad)
> +{
> +       for (const struct ev_string *ev =3D ev_strings; ev->desc !=3D NUL=
L; ev++) {
> +               if (payload & BIT(ev->event))
> +                       arm_spe_pkt_out_string(err, buf, buf_len, " %s", =
ev->desc);
> +               payload &=3D ~BIT(ev->event);

Sashiko has a bunch of worries in these patches about 32-bit builds:
https://sashiko.dev/#/patchset/20260401-james-spe-impdef-decode-v1-0-ad0d37=
2c220c%40linaro.org
The one here is:
"""
Since payload is a u64, does using ~BIT(ev->event) unintentionally clear
the upper 32 bits on 32-bit architectures?

On 32-bit systems, BIT() evaluates to a 32-bit unsigned long. The bitwise
NOT operation creates a 32-bit mask, which is then zero-extended to 64 bits
during the compound assignment to the payload.

This would discard bits 32-63, contradicting the intent mentioned in the
commit message to preserve the remaining unknown impdef bits for later
printing.

Would using BIT_ULL() be safer here to ensure a 64-bit inverted mask?
"""

Thanks,
Ian

> +       }
> +       return payload;
> +}
> +
>  static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
>                                   char *buf, size_t buf_len)
>  {
> @@ -283,51 +325,7 @@ static int arm_spe_pkt_desc_event(const struct arm_s=
pe_pkt *packet,
>         int err =3D 0;
>
>         arm_spe_pkt_out_string(&err, &buf, &buf_len, "EV");
> -
> -       if (payload & BIT(EV_EXCEPTION_GEN))
> -               arm_spe_pkt_out_string(&err, &buf, &buf_len, " EXCEPTION-=
GEN");
> -       if (payload & BIT(EV_RETIRED))
> -               arm_spe_pkt_out_string(&err, &buf, &buf_len, " RETIRED");
> -       if (payload & BIT(EV_L1D_ACCESS))
> -               arm_spe_pkt_out_string(&err, &buf, &buf_len, " L1D-ACCESS=
");
> -       if (payload & BIT(EV_L1D_REFILL))
> -               arm_spe_pkt_out_string(&err, &buf, &buf_len, " L1D-REFILL=
");
> -       if (payload & BIT(EV_TLB_ACCESS))
> -               arm_spe_pkt_out_string(&err, &buf, &buf_len, " TLB-ACCESS=
");
> -       if (payload & BIT(EV_TLB_WALK))
> -               arm_spe_pkt_out_string(&err, &buf, &buf_len, " TLB-REFILL=
");
> -       if (payload & BIT(EV_NOT_TAKEN))
> -               arm_spe_pkt_out_string(&err, &buf, &buf_len, " NOT-TAKEN"=
);
> -       if (payload & BIT(EV_MISPRED))
> -               arm_spe_pkt_out_string(&err, &buf, &buf_len, " MISPRED");
> -       if (payload & BIT(EV_LLC_ACCESS))
> -               arm_spe_pkt_out_string(&err, &buf, &buf_len, " LLC-ACCESS=
");
> -       if (payload & BIT(EV_LLC_MISS))
> -               arm_spe_pkt_out_string(&err, &buf, &buf_len, " LLC-REFILL=
");
> -       if (payload & BIT(EV_REMOTE_ACCESS))
> -               arm_spe_pkt_out_string(&err, &buf, &buf_len, " REMOTE-ACC=
ESS");
> -       if (payload & BIT(EV_ALIGNMENT))
> -               arm_spe_pkt_out_string(&err, &buf, &buf_len, " ALIGNMENT"=
);
> -       if (payload & BIT(EV_TRANSACTIONAL))
> -               arm_spe_pkt_out_string(&err, &buf, &buf_len, " TXN");
> -       if (payload & BIT(EV_PARTIAL_PREDICATE))
> -               arm_spe_pkt_out_string(&err, &buf, &buf_len, " SVE-PARTIA=
L-PRED");
> -       if (payload & BIT(EV_EMPTY_PREDICATE))
> -               arm_spe_pkt_out_string(&err, &buf, &buf_len, " SVE-EMPTY-=
PRED");
> -       if (payload & BIT(EV_L2D_ACCESS))
> -               arm_spe_pkt_out_string(&err, &buf, &buf_len, " L2D-ACCESS=
");
> -       if (payload & BIT(EV_L2D_MISS))
> -               arm_spe_pkt_out_string(&err, &buf, &buf_len, " L2D-MISS")=
;
> -       if (payload & BIT(EV_CACHE_DATA_MODIFIED))
> -               arm_spe_pkt_out_string(&err, &buf, &buf_len, " HITM");
> -       if (payload & BIT(EV_RECENTLY_FETCHED))
> -               arm_spe_pkt_out_string(&err, &buf, &buf_len, " LFB");
> -       if (payload & BIT(EV_DATA_SNOOPED))
> -               arm_spe_pkt_out_string(&err, &buf, &buf_len, " SNOOPED");
> -       if (payload & BIT(EV_STREAMING_SVE_MODE))
> -               arm_spe_pkt_out_string(&err, &buf, &buf_len, " STREAMING-=
SVE");
> -       if (payload & BIT(EV_SMCU))
> -               arm_spe_pkt_out_string(&err, &buf, &buf_len, " SMCU");
> +       print_event_list(&err, &buf, &buf_len, common_ev_strings, payload=
);
>
>         return err;
>  }
>
> --
> 2.34.1
>
