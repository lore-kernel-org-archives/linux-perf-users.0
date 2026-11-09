Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794264708;
	b=23Yd1NpNBhIPgKT2ZJhedc86rcTJovOWyblGFmxQcFLt42ifFUeW/a4AHpYAPbgzTmua
	 zeQ8y+FETCC/qM7VLdEByM+zPwPSaLKxGiLAkDhfb/oSEIikburBeqektSSnvu5nYWLmw
	 w1b2MasUcqaQ7W1hj2x6pHcc/qQzuWsp2m7OjhNTT5NG/qlaZDvHLb97iGO5n4VzWwjMI
	 DZ/iWOC+TcWkZPfBEFKrp/A3uSr4g/cHrJuhd0xR7t1/+DfUU4hxbTGo+6U1FC3VvVCP5
	 KR0vR68g6knHaNg9/NunAGyuFEfakWqH2kIIQmNSHun46V/DrVHxSdkhXlWaSzZBDwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794264708;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OWSNwvalNOHXKLMMlHTD1wk9mqbGrJX4DU8R8+H5KVc=;
	b=g9lToz2TmfPnraRBR2oUA62Z0LlOtoJ6SM/cwsXd+SLO2YIirLRw+HHSiYNIrn1QPCHg
	 9A19dCrjB7k/6lFiexK0H6sQApsDL/eXA5mbc/wqFhzxhqZDGB+tvRmz2CKxgLKGMqGUK
	 muS9gqIVWDM+ucj0bhlf498y4B2Oey1yyYOzp5BhlSoQvtu1e5wZZXifoGwhqnzV+JeEQ
	 UeNIdtKMQwfnWbcIfAHzG4shCSMumRWyeEz+E7LKnN4G3R2CdMODcRfaYANNfViuodlmL
	 E3Ocp+ke3R8XXZLP3mrcFFI26jCcR8Y+qo0OmEicq2jaqugRhXJYOjREE8D7npEyyMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jMsltQH3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134D860A2600
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 22:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 134D860A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jMsltQH3
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b56221d361so1743987a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Nov 2026 14:51:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794264706; cv=none;
        d=google.com; s=arc-20260327;
        b=ErdCx1jrBvE9TxFNx2sAapbMXanAuPM75DMT1C9+eI8WZIvJoA4I5dXjE0tpY++m7V
         tl3td4Z1YIlGnnZvFz1zSXDj+TjSGzrnx6Hbm3kKxu7npAlBG+Ijng8aYiyIlw+BWKlP
         Zofl0hVlugsvlpgQjibLN7MMF8IsPJRMymBtt7DZVD4vLtPaZnFryESCNDpQWaOvg1QG
         theGJM4IOzEu6fY6mIw7tstOQ06wjyxvrUyFUsu7hoEWag9HD3SXO7yjTUU1PDYXBKrs
         focYN2nzFV40SNp6WJHzz6tNC1dT/80vDHsRbv2gC3GJGw+IvxWapCNCt2SUpXaspohF
         MHJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OWSNwvalNOHXKLMMlHTD1wk9mqbGrJX4DU8R8+H5KVc=;
        fh=3iEC4dQr/CdsFs4uUIvgCilO+7AklpES1WeMTHNPsA0=;
        b=f4eEUf/bng1E2YB2NkS9DJ5NlHmcrvjCntUd+Y7ZaeJOcsUm72xStYu65jmhX1fQNw
         tiZyHMgXL7Dhxdpm9BtXRGUVL9+PsfY6t11Qkv6ZubMB2Hc24m5VbvnOa+dRTzoxd+M8
         JYFp86/ueUWl2EeHRegoJxgDo7nopzug/ah2FhVsRjPLvrVvK6zgdndqzVPXopTb/9ws
         EeOwAeLz8FPVUCXEWnNyLTFujGxy7TkZT2hDx5uPRiAr15pysToL2g2dMFreurq9gjvW
         Zaf8JbkpeaJkD3+pr+Dab/ugBx1H4xBW6XK3l9lMK4s49XyfnXBFuT+U9rQLbcg5NKHN
         3jTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794264706; x=1794869506; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OWSNwvalNOHXKLMMlHTD1wk9mqbGrJX4DU8R8+H5KVc=;
        b=jMsltQH3itmZCStdzYi0bmXp+Fj1HXIvg7IvfS1CHMum1xbCF/JIbeRe8ClWsuG8pL
         8bElUFjLLmljoLjmxUaVo6ArEzjXsmg6zkTFEz5YFUt+WK049Tk+xtG1de5yRvGpZdXD
         1jDZoUop4xewT+X9GMkZCkPwED/UWggx/VQJyuitisqxmD986RL02C+Pw+Sqc+I3M2wN
         jmElfjsff/itjcLTxX45lJcsvtMZ++ymKuNQIyHcbjXsOI9AJINYpvWkYgFlataTZQim
         TttPbO2LLXOMFArK2iWa/Hpw5ElDINtPk3gzF7jDDibv+nhLFXzndIIX5gGsOtjl1AUI
         /eyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794264706; x=1794869506;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OWSNwvalNOHXKLMMlHTD1wk9mqbGrJX4DU8R8+H5KVc=;
        b=kyao2UO/U0bYHehgOO5NrNZHtqT1TcBEIYG9ZcPb4GKP6heTTvrS+0NUgFOrPM9U03
         18cJJFTA4ft2NsoJjuxhrwTHZSZ1vwE3YSajk3S/w3ngT2YgOI8agorKzGP1qnSvbAtZ
         9/xHk/uGVsOFK9xcegimQ1JXFztFqQXvzMS5TBMBw0GrItQJ12iq7K4RLIblj7zIZIsQ
         p6h+up6idzJteGp8oRVgG9B9Nu922WmUyEhqzpNgsaiKjYU7k+p54kQeEZqa0KEyN/nU
         lbLw+fhtC4TJY8UZtIjQ8g0EvvGN/VAWWGy8PIctfRhPvgkZjfweJApkKII8D1DpDnVa
         tOAQ==
X-Forwarded-Encrypted: i=1; AL+hErEmgWQ2BXNq+1y79A38tJe/M8xdjFUTNREEU4XgYYIkrznn860qAj/x4lGmIH89pEx1sioSFeBs9AnLnKEuPaRF@vger.kernel.org
X-Gm-Message-State: APuU4Z+QZVJolUqufBy89OXqxxmboAj397T1xPxcDF9mejuGVDhbW+oC
	Dz8AteEWO9s052Xz35QqyxrqxOIZjk2ctpIusXi3yV3rnOPVchpFypHtoNPZg+qz2JnGWNvSnjd
	Dwauq+RS7+N261UGhUALD2WKmk1t17ug=
X-Gm-Gg: AYBFou192fACWoXJyNTdKM93ojYf3cANSXD7sZnHKVlWomaHdv8umlDIS4XhP26hOyT
	1ZqVL7KXp9e9xklBM4wo8xmY9oImmnmHl2j/sBF7NchgBkPyD9NS104q3Gx/ZCITAvI0F0u37jm
	nZGA5Xq/Me5ID/wsRVHZ5jyYw/QBI/XxZFxLjjXc3o1usbcBzeC36QKY6JOrjr5jq2RmS8Bwitf
	EyL9pvN3Xb2FXfqW4sN6SFeQcQUrdPSSNnMiQXZq0qmy1nvTHvLY3CJ2qdOKlFebrSPUMMbyU2C
	0+TG83dAPMySZPntZxwIn9NNQzBnXQorjdxqloPoF2s+6Upq9oSBJfUH4+xPv64CctkyO2pUfET
	dkaoQ+jycx0zkQOO5HTTe031QJ/hesApN2qviW4KeyPZVUbFPkkOp3QC9W0C087WwmbO7XDmf3r
	6+PKS5BdvtGL5PbwAgZlEdX6rN
X-Received: by 2002:a05:6402:a509:10b0:6b4:73e6:dc9d with SMTP id
 4fb4d7f45d1cf-6b756b06c8cmr547355a12.41.1794264706391; Mon, 09 Nov 2026
 14:51:46 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-perf-alpha-profileme-v4-0-1771ea02950e@gmail.com> <20261104-perf-alpha-profileme-v4-3-1771ea02950e@gmail.com>
In-Reply-To: <20261104-perf-alpha-profileme-v4-3-1771ea02950e@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 9 Nov 2026 23:51:33 +0100
X-Gm-Features: AclHuK9poCE4l8PjGg9oSBI1_steTspM-yIVwxrchfEiyhq-TId8jv-1nN60SLw
Message-ID: <CA+=Fv5QKsbMqiUnKpMkVV8wB+3gP-CcxmzKAK11nfLpjeQjVoQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] perf alpha: Add perf mem support
To: Matt Turner <mattst88@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Wed, Nov 4, 2026 at 7:54=E2=80=AFPM Matt Turner <mattst88@gmail.com> wro=
te:
>
> The Alpha kernel series "alpha/perf: add ProfileMe sampling" reports the
> data source of ProfileMe samples of loads and stores: whether they hit or
> missed the DTB, and whether they were loads, stores or prefetches.
>
> Give the Alpha core PMU a mem-ldst event, cpu/cycles,profileme/, as AMD
> does with IBS Op. cycles:p is not used, as precise events sample only
> retired instructions, and a load or store that misses the DTB is aborted
> and refetched. The profileme format bit only exists on the EV67 and
> later, which have ProfileMe.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  tools/perf/Documentation/perf-mem.txt   |  3 +++
>  tools/perf/arch/alpha/Build             |  2 +-
>  tools/perf/arch/alpha/util/Build        |  2 ++
>  tools/perf/arch/alpha/util/mem-events.c | 17 +++++++++++++++++
>  tools/perf/arch/alpha/util/mem-events.h |  7 +++++++
>  tools/perf/arch/alpha/util/pmu.c        | 11 +++++++++++
>  6 files changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documenta=
tion/perf-mem.txt
> index fe51c5e3333d..cb439940ce90 100644
> --- a/tools/perf/Documentation/perf-mem.txt
> +++ b/tools/perf/Documentation/perf-mem.txt
> @@ -34,6 +34,9 @@ be sampled.
>
>  On AMD this use IBS Op PMU to sample load-store operations.
>
> +On Alpha this uses ProfileMe, on the EV67 and later, to sample all
> +instructions. Loads and stores report whether they hit or missed the DTB=
.
> +
>  COMMON OPTIONS
>  --------------
>  -f::
> diff --git a/tools/perf/arch/alpha/Build b/tools/perf/arch/alpha/Build
> index 1bb8bf6d7fd4..e63eabc2c8f4 100644
> --- a/tools/perf/arch/alpha/Build
> +++ b/tools/perf/arch/alpha/Build
> @@ -1 +1 @@
> -# empty
> +perf-util-y +=3D util/
> diff --git a/tools/perf/arch/alpha/util/Build b/tools/perf/arch/alpha/uti=
l/Build
> new file mode 100644
> index 000000000000..8d924b229470
> --- /dev/null
> +++ b/tools/perf/arch/alpha/util/Build
> @@ -0,0 +1,2 @@
> +perf-util-y +=3D mem-events.o
> +perf-util-y +=3D pmu.o
> diff --git a/tools/perf/arch/alpha/util/mem-events.c b/tools/perf/arch/al=
pha/util/mem-events.c
> new file mode 100644
> index 000000000000..d3cbca1993b4
> --- /dev/null
> +++ b/tools/perf/arch/alpha/util/mem-events.c
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "util/map_symbol.h"
> +#include "util/mem-events.h"
> +#include "mem-events.h"
> +
> +#define E(t, n, s, l, a) { .tag =3D t, .name =3D n, .event_name =3D s, .=
ldlat =3D l, .aux_event =3D a }
> +
> +/*
> + * ProfileMe samples loads and stores alike, and reports DTB hits and mi=
sses
> + * in the data source. A precise event would sample only retired
> + * instructions, which leaves out the DTB misses, so set the profileme b=
it.
> + */
> +struct perf_mem_event perf_mem_events_alpha[PERF_MEM_EVENTS__MAX] =3D {
> +       E(NULL,         NULL,                   NULL,           false,  0=
),
> +       E(NULL,         NULL,                   NULL,           false,  0=
),
> +       E("mem-ldst",   "%s/cycles,profileme/", "cycles",       false,  0=
),
> +};
> diff --git a/tools/perf/arch/alpha/util/mem-events.h b/tools/perf/arch/al=
pha/util/mem-events.h
> new file mode 100644
> index 000000000000..311448cf1218
> --- /dev/null
> +++ b/tools/perf/arch/alpha/util/mem-events.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ALPHA_MEM_EVENTS_H
> +#define _ALPHA_MEM_EVENTS_H
> +
> +extern struct perf_mem_event perf_mem_events_alpha[PERF_MEM_EVENTS__MAX]=
;
> +
> +#endif /* _ALPHA_MEM_EVENTS_H */
> diff --git a/tools/perf/arch/alpha/util/pmu.c b/tools/perf/arch/alpha/uti=
l/pmu.c
> new file mode 100644
> index 000000000000..d19dfc979b08
> --- /dev/null
> +++ b/tools/perf/arch/alpha/util/pmu.c
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "../../../util/pmu.h"
> +#include "mem-events.h"
> +
> +void perf_pmu__arch_init(struct perf_pmu *pmu)
> +{
> +       /* ProfileMe is only on the EV67 and later. */
> +       if (pmu->is_core && perf_pmu__has_format(pmu, "profileme"))
> +               pmu->mem_events =3D perf_mem_events_alpha;
> +}
>
> --
> 2.55.0
>

Tested on my EV67 AlphaServer ES40 with the v6 kernel series.
perf mem record selected cpu/cycles,profileme/ by default, and
perf mem report showed 6452 L1 DTB hits and 81 L1 DTB misses
on a page-stride workload.

Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
