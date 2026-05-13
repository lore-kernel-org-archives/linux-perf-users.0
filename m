Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A3416A956
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 00:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778632459; cv=pass; b=NOUOK9PbfwyPUTnjb8JUS+aSv0LJ0df8nPvUPIaYPsbmAGnFXP/35/4/tGb0KQtYOjFFP3hboBH53dixJ2cJiSDPGE3aBeBckrwvfvtuLD629O9AxGdImm/Jr0fTSGIjlti94W30WDVdLCbrbeVDqDaBkZ5e9F3ri2rR1Z4wT3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778632459; c=relaxed/simple;
	bh=f8jYM07JFQXDe1VgRziPT+sPdw659PU6+aBbrhCdsos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2kRCmXfBh5f9iPxmbBTuaxKjjsgx8uXpp7vzQiF+JhwaLHJJUSLr0pN7QcKQbXj/BdyKYajcC15vu58bFcJIbPNhauRrdEEQ9XAliJ3r7nEXb9ZDFcBHO91fO65ZajFw4ysmWx+L4zL5jaZ2g24Qxage+MSddJdp8JPqrjVTzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aPr/rmxh; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aPr/rmxh"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so975ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 17:34:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778632457; cv=none;
        d=google.com; s=arc-20240605;
        b=Vvjnt12dml55f5bgZBxqP9uG+HSAF2yglyEbkkP5cmin4gV4smVOintEHjoyi+Y4Xz
         UoxS10d8/Siwkkvtr5tf215tfRuv4O+FWVknOqW3zadus+In9lEEkt6kyZepVZkN/evf
         fWplR2KgjhhmuYyqVnwbuU07lNnpi+1r+9IJiAD7KIBien4A9nvgotIwJ6az0KisArmA
         PezQu3cq/SZQpfrBUOrwm0OQ08kvuh36xcGBu9QkY+4+b/ljKr2WTZ6N8zYHEl+A0hLm
         89rRqhT7r2nth+dIPDhQGAcHSkHxxxGWjdw3bLUCLXPvI1C0PsVvF+TGcFWKzzIlK92Y
         Xv7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NGfRvL0rDh5Lm/bcKTRSUeVuSC1oquZBqXB3mow0l+I=;
        fh=s9RX7G1bDunu6nBsuNKOHLr/pAM1wZ66YV9LQNNNAsM=;
        b=GwJxuu5bqjH85QCkrXd9sSL3iSboPk5OlSeVe+ZB2i+AR2fYBq3L6qqnIiUAwE5Hu2
         K7lFLoN1hRC2wSfpCBfleRi9iYc41cyLlABvLx76vLVbq4xi3t8iy4UePHlR5yGeqCIc
         YV0FnEE3QZ4N0IUdaG7shRbSIhEp/rp0GI+leX+rVziHtddjwq+J5KdoOY761RomglFF
         tPvinSUO7sPWLJLFE0TahZWu8fhOPih8s8NpUftxxa7dA2E4Q1tJOBgofQAIvtaBSrxq
         29HIEvEwTESweLl9i3oKA1xZoKA55esC422vfiGaEqwqGB2U/0KohOF8TWJztCIAItPq
         0bWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778632457; x=1779237257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGfRvL0rDh5Lm/bcKTRSUeVuSC1oquZBqXB3mow0l+I=;
        b=aPr/rmxhvJ5IIIm967Q8iNwfRTgqSkQlLpvJXMhmfpQC0hv4BFJiy1hPv5JFGhHheD
         rh23juWm5tHifRPxbH3bcvknll7kTbVSCo4XQEeBfid5C2pu+fap9Jmo3yd3hhSJVhdO
         m0HEUtBSxoFD0bVDxVEoPoVlAK+rWWR5rcdP7f927ddjiXGe3L8gqLY4rOUvwy9H5x3Y
         RcoH5nWbV1OJ553aOE8oj6fhY+kwCLLGGUPEJaA4Anlyj0rESSgpz4D4JYylopE3X1On
         hKu7GufF1Uj2bLvvp+LOTCkqbgdOlDqcniZHeevNPPbfX7rZMQBA4S9PEyTwwVYwc9ZI
         Wjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778632457; x=1779237257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NGfRvL0rDh5Lm/bcKTRSUeVuSC1oquZBqXB3mow0l+I=;
        b=pCWwrZcTqz0t+Iql5JP4rAJu/fb4paSXyuEARIDAvcrSVk9S/UepeGKcTc+P+Nl+4z
         fic2GPzhNi8YmF7+s56k/ycJY+A4KqLJRA5DLSLnLpz+l3nW4aSqCGY9YffUeGdAkLhf
         6TM2Atx6Kw6b3HwDmf2pb4OlLDC1THLwiKrCSLriVqcUIMHOCfX6eic8y6SkLb7WWRRT
         utUMbB8OkRPMrZeckBNSaKp1kkUp/Btz6xmE0KWY1d8iJN6ooG9Jye1b8R9JrEflS3l1
         yJuKNYthTRJfhD+dmR/Kybq07sKu5eJaFMlBt5s39vxy2B5zKOLN/sasuHvwBOHSkbcK
         r/XQ==
X-Forwarded-Encrypted: i=1; AFNElJ/60b8rxNYl+iHZT7Tg/Sfh5vsiLY2LPk7igCl9WIfFIOgcnbS9O9+JvnsbKKvwNFh7KcJm1JENiKUtgVVzj4pW@vger.kernel.org
X-Gm-Message-State: AOJu0YzwgcKNfDCVye8ORxTxXEZ7jF0crLuBYnU6V1kj0NmctR7ULV38
	tcXsJwv1mjCCJ+GZgjNME+FzdHsjtyNvqscO5FFfX7ZFWc0W/bn/J00EwsiDOy5xn9HDS8w+WIf
	WXCZygHJcvkANW3snI89Fh9w+wbtBz7kuvMkPEOvW
X-Gm-Gg: Acq92OE7uPfjQLK+rDpkvRght00zgn37dxiwxTjuXtVOPFkKs5yrCzQArfWlbKJHV5r
	fS2OplsAoZ+uIcTH/sm3z1sBJUdc/bo8+k4hdu4ooJfkHYVWRSfnKEQbff8gA1ICJG3e+J06Ugs
	DiICvi9+8t3B6PrKegM82ru9PQP5qdZ5NCtULKM7E+7DE809KRw8X3vWuV6WVO2U/e09EdGwge9
	9pnzyZwDfYejkFkEbTpd4VVONhor8dXEUfJ7ngH+JsqoML6zN4PmRf8zuBeKO1im+LbI5Yiuwvt
	MSnHH91YRtWouEeJaoawuhCi9E1/ww==
X-Received: by 2002:a17:902:f081:b0:2b0:b458:2dc3 with SMTP id
 d9443c01a7336-2bd2c1264a3mr465515ad.21.1778632456089; Tue, 12 May 2026
 17:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512233048.9577-1-zide.chen@intel.com> <20260512233048.9577-8-zide.chen@intel.com>
In-Reply-To: <20260512233048.9577-8-zide.chen@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 12 May 2026 17:34:04 -0700
X-Gm-Features: AVHnY4JZSczLhN2GFWv4RvnjGP4nakYR_JLrx1WB1ToxxXlFjj4i8poWm2s6hTg
Message-ID: <CAP-5=fXri3mY5QZYraF0DMnNQzWsTttfEYiwQ74Mi=bQf=5qMA@mail.gmail.com>
Subject: Re: [PATCH 7/7] perf/x86/intel/uncore: Implement lazy setup for
 MSR/MMIO PMU
To: Zide Chen <zide.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 4:39=E2=80=AFPM Zide Chen <zide.chen@intel.com> wro=
te:
>
> MSR and MMIO uncore PMUs are currently registered at module init time
> and appear in sysfs even when no PMU boxes are functional.
>
> Apply the same lazy registration model used by PCI uncore PMUs: the
> PMU is registered when the first box is successfully initialized, and
> unregistered when the last box exits.  If a box fails to initialize on
> a subsequent die, the PMU is marked broken but remains registered to
> avoid disrupting any in-flight perf events.
>
> Box allocation and free remain at module init/exit time to avoid
> repeated kfree/alloc cycles across CPU offline/online events.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  arch/x86/events/intel/uncore.c | 72 ++++++----------------------------
>  1 file changed, 12 insertions(+), 60 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncor=
e.c
> index 399f434e1a7d..2aaac0b49bb6 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1564,8 +1564,11 @@ static void uncore_box_unref(struct intel_uncore_t=
ype **types, int die)
>                 for (i =3D 0; i < type->num_boxes; i++, pmu++) {
>                         box =3D pmu->boxes[die];
>                         if (box && box->cpu >=3D 0 &&
> -                           atomic_dec_return(&box->cpu_refcnt) =3D=3D 0)
> +                           atomic_dec_return(&box->cpu_refcnt) =3D=3D 0)=
 {
> +                               if (atomic_dec_return(&pmu->die_refcnt) =
=3D=3D 0)
> +                                       uncore_pmu_unregister(pmu);
>                                 uncore_box_exit(box);
> +                       }
>                 }
>         }
>  }
> @@ -1659,7 +1662,7 @@ static int uncore_box_ref(struct intel_uncore_type =
**types,
>                         box =3D pmu->boxes[die];
>                         if (box && box->cpu >=3D 0 &&
>                             atomic_inc_return(&box->cpu_refcnt) =3D=3D 1)
> -                               uncore_box_init(box);
> +                               uncore_box_setup(pmu, box);
>                 }
>         }
>         return 0;
> @@ -1690,67 +1693,16 @@ static int uncore_event_cpu_online(unsigned int c=
pu)
>         return 0;
>  }
>
> -static int __init type_pmu_register(struct intel_uncore_type *type)
> +static int __init uncore_cpu_mmio_init(struct intel_uncore_type **types)
>  {
> -       int i, ret;
> -
> -       for (i =3D 0; i < type->num_boxes; i++) {
> -               ret =3D uncore_pmu_register(&type->pmus[i]);
> -               if (ret)
> -                       return ret;
> -       }
> -       return 0;
> -}
> -
> -static int __init uncore_msr_pmus_register(void)
> -{
> -       struct intel_uncore_type **types =3D uncore_msr_uncores;
> -       int ret;
> -
> -       for (; *types; types++) {
> -               ret =3D type_pmu_register(*types);
> -               if (ret)
> -                       return ret;
> -       }
> -       return 0;
> -}
> -
> -static int __init uncore_cpu_init(void)
> -{
> -       int ret;
> -
> -       ret =3D uncore_types_init(uncore_msr_uncores);
> -       if (ret)
> -               goto err;
> -
> -       ret =3D uncore_msr_pmus_register();
> -       if (ret)
> -               goto err;
> -       return 0;
> -err:
> -       uncore_types_exit(uncore_msr_uncores);
> -       uncore_msr_uncores =3D empty_uncore;
> -       return ret;
> -}
> -
> -static int __init uncore_mmio_init(void)
> -{
> -       struct intel_uncore_type **types =3D uncore_mmio_uncores;
>         int ret;
>
>         ret =3D uncore_types_init(types);
> -       if (ret)
> -               goto err;
> +       if (!ret)
> +               return 0;
>
> -       for (; *types; types++) {
> -               ret =3D type_pmu_register(*types);
> -               if (ret)
> -                       goto err;
> -       }
> -       return 0;
> -err:
> -       uncore_types_exit(uncore_mmio_uncores);
> -       uncore_mmio_uncores =3D empty_uncore;
> +       uncore_types_exit(types);
> +       types =3D empty_uncore;
>         return ret;
>  }
>
> @@ -2052,12 +2004,12 @@ static int __init intel_uncore_init(void)
>
>         if (uncore_init->cpu_init) {
>                 uncore_init->cpu_init();
> -               cret =3D uncore_cpu_init();
> +               cret =3D uncore_cpu_mmio_init(uncore_msr_uncores);
>         }
>
>         if (uncore_init->mmio_init) {
>                 uncore_init->mmio_init();
> -               mret =3D uncore_mmio_init();
> +               mret =3D uncore_cpu_mmio_init(uncore_mmio_uncores);
>         }
>
>         if (cret && pret && mret) {
> --
> 2.54.0
>
