Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5EE4C77A6
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689435; cv=pass; b=eOglIOg5jyUIgKTLfPqw8jl21RkVn1D/kbay0KqKX6t2zxhsViXAM9gE+yFevBwoCtc+RlqfeHvLwfjguXaG1ggRKBz71aKL8UKnNxQrN/2Gv/4zHg0yLjSHreJ5gNUuNjJuA+bOHrSYDvDdl/UCugSnTZfdDsxJkqAnbrjGqE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689435; c=relaxed/simple;
	bh=FRA3c/z9qpgox7QXG37ZhFxYwnzl8mVpzqHkTmjdliI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WhWNlnrivMxktzvAimHabPo9jBvs3HlJJp8HjMuU1Bvb5UyYpEmPKjSR7isdmwmB84ce0eUPg4+clsv7ntNunywj6Nk3e2K3Ftpy05p1+nL0XYub55a5ukjTqBUMLtaxWyuCq7g+XFGv4hIYZimpC4u91AP4NQOWMMip3qSYgac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CL2K62wE; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CL2K62wE"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b46da8c48eso935ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 09:23:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778689433; cv=none;
        d=google.com; s=arc-20240605;
        b=DxbajB+6h58duwvmP/LgCRIc9EAX61TiXBacme0ysn4x9vD92g0tJCj/ETgtJrLtVf
         wGwNdDXjRCCT+5i9kUZZMfMCtnCxooNg61zL32hDSuhBkpTb4wvtRv/+Nck3Uv7TvCqX
         Wb6CIfyFHVYFfPDs6mq0aFbKAUlvOifoKWe98ZTOJq1DoPGECjJGvG+J7bH6YgYoy2ZN
         MeX0UfdxQmqlm+QFftqLyxtCoLWICSpAg3v9uAJ+6Oh7E+j37wcVFbfTRyVQB8lHU+ky
         ZFI/hHWvp73lxBVHP0sWokSsjimld/uk1FtD2esbL5t9RI/U0fhJP3BBJvcxWpYI0Pnf
         KaFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K+yTW8DvLZbeENEAQpHtNcUS2NREyLyvXCf/ipnwktM=;
        fh=xeM79W8O650PJUgF+ruPXVGLYpYowSjJ24t7v89lVL8=;
        b=XU3ntbRdH3CcUomCHWOkdj5hl/peAm7jseRcAf7+E8C3F71n4zsp6OHo34gDkXZhZI
         Q3crLruyvTFuwg8g2gRYAHmDf8k4YG/OmTa92c/ZjjO7oNYhkhjzuXdVszf4CU6FUXrP
         bEi4/xWfaNeoj3Oq2R1p2U5FYEvEvstv0LU4d1Re82zgJUs7ccFK3qBur4Nvxu+Gsqgg
         INKj+UizzLhgwh7KPJ6iK3VpSU9WbNBNv6mx/rxa2Xz3l9zP8X7TFLCqCGOsZ3oW9o5N
         8ouzRMF6ZpnP/Q8LHMjj4/h+0x5hnruZ5yya8/pEAekDHJ/ELl9vQIxLKQgYLaHPq29g
         uFkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778689433; x=1779294233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+yTW8DvLZbeENEAQpHtNcUS2NREyLyvXCf/ipnwktM=;
        b=CL2K62wE1KbCOgLkGgWkgDfHmsE/RMBNLMBdrrDFmHYgqGYErMZJsyzQg1NptxJW3u
         41eFumxMi37clbs+fompStBB6E8+75MjrKpUH2hYZCFai0TPKij2qPLzuUHQ6p+BHFku
         lSv1d/SQtZVbjweNynICG79+O8cPvkpRTrhix6ISyZx7L7stfPhaCVdZLHSYI2TTrUYz
         ARbRiZhi7PRJnwpOp/e4Rcd6TiSEXLBgAM8XmfI9cBvosLtAo/fLWELPXAV/PAt9BQCm
         di0BA2Noy0e5ksH+HLFJ0I47YF2NHwJPWz8pSwpCPERk9XOHa58CwudJHJvDpFvyLCoR
         jPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778689433; x=1779294233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K+yTW8DvLZbeENEAQpHtNcUS2NREyLyvXCf/ipnwktM=;
        b=GeIbNk6ZlHJ8fAhgDQOZAqjPFJ97kwviVd0AD5wfka54+ldnX/Z5ZK8hGZNQWYUXIW
         kpVg0t64HSJCJRvhidbGZq1W+RSPNGacRwhS4Q/wY9fNE3CgwoECZxRlSldC3jcMr+za
         bI3v04u7NLxZ+A/OrHJRnSumEbBHdMxWTi8SwGGpCSQ/VH2iCoVucypuq/cNjrTaleI5
         lsJ8aFpFa5RsuoZCSrn4O9kQQSuHEuQ6doKkljXgvGP1YCS89fb8gqj+32ymvz69Gr10
         Dvy0BLf0a/tNnQqz0qU86uSL5rq5w49pV2DVKGw742DBJftD6Vwp2qt8G+QZHcc4Jpnj
         2Dzw==
X-Forwarded-Encrypted: i=1; AFNElJ9ZIbfRIwV24gNy3wrl+75znovzme5e4UWzS7+WlXmoHVPPx0nvZN6DEsNKmj5qX/rl6lhJQH0fe2dRox075Aa7@vger.kernel.org
X-Gm-Message-State: AOJu0YxY60n9aki4LElnLmEpquucHpnOeuY0RDDSxT3c+6nWHIMayROK
	/NXAzNzYd2JRGwqGLmrWkyrsfTCSkKYd2rh5szMO9ek4VTCWId/y+EKVqPRCVv9UOiYgyUnBwrD
	bp3GtjSgfH08tN/GFJaMkL7J7UXMftnynJzURLutV
X-Gm-Gg: Acq92OE2ubKIRg2nZTPRMwlWsMovCcBcxkh87KKdAPAhhhoA7U9Jte2lG9UTjaH3B3r
	fYVjL19quHQF5lSNRIxaP9ZSbIs4but/HnPmJaAQ44Hp6dy/q81iB6pxbbumGvO0QJ0P/fTtJAX
	+ATl10NurTBWka2Z2NYZudez7pBLSjvYgt9GxzyaPvg7yMFBaH0Q+v0v4nYG7ydTTAkCkoDyLkE
	Vi4mi411Sp/RUR/D1y1XczNjiKFLPSzVOjbEZ8jyrqupnICmGHJurroLsU4gohGQEhc0XK2z5zE
	AY+zKY2yy7gDkSe244pcSI5LzJsDnLiABmC0JuM9wTtyWRhADjVJ37auKwE=
X-Received: by 2002:a17:902:db0d:b0:2bd:907:2ce5 with SMTP id
 d9443c01a7336-2bd2c0f09a7mr3131145ad.7.1778689432162; Wed, 13 May 2026
 09:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513144906.557896-1-ak@linux.intel.com>
In-Reply-To: <20260513144906.557896-1-ak@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 13 May 2026 09:23:38 -0700
X-Gm-Features: AVHnY4KsCShegaim6pCDqhYK6s_MCsIyuyzRbn_a5Kz8XZAMPvhFacmfOb8bCeg
Message-ID: <CAP-5=fXhi9W-T1BLJVvQ4DRN6EpxtZQduev0fVXNJTmrF6idSw@mail.gmail.com>
Subject: Re: [PATCH v2] perf stat: Make metric only column line up with header
To: Andi Kleen <ak@linux.intel.com>
Cc: namhyung@kernel.org, acme@kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 7:55=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> Since some time the metric-only output columns are messed up and do not
> line up with the header, which makes it hard to read. I haven't bisected
> it, but presumably it was broken for some time.
>
> There were multiple problems:
> - The dummy pm invocation at the beginning did print a bogus field
> - The column computation in pm did not agree with the header length
> - The color escape strings from highlighting confuse printf's field
>   length computation
>
> Fix all those. I simplified the column width computation significantly,
> ignoring EVNAME_LEN, MGROUP_LEN, config->unit_width which don't
> seem to be useful in the metric only context. It now only uses
> the actual unit width as well as config->metric_only_len. The result
> is more code removed than added.
>
> Before:
>
> % perf stat --topdown -a -I 1000
> +           time %  tma_backend_bound %  tma_frontend_bound %  tma_bad_sp=
eculation      %  tma_retiring
>      1.000190386                                         45.5            =
       40.0                     5.3                     9.2
>      2.005185654                                         45.3            =
       40.1                     5.6                     9.0
>      3.009193207                                         45.4            =
       39.9                     5.6                     9.1
>
> After:
>
> % perf stat --topdown -a -I 1000
> +          time %  tma_backend_bound %  tma_frontend_bound %  tma_bad_spe=
culation      %  tma_retiring
>      1.000810024                 46.3                 39.7               =
    5.3                 8.7
>      2.004800656                 45.8                 39.8               =
    5.4                 8.9
>      3.008804783                 46.0                 39.6               =
    5.4                 9.0
>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

I dislike the spaghetti code in stat-display.c :-) One day it would be
great to throw an LLM at doing a clean implementation. Having tests
for formatting would be useful :-)

Thanks,
Ian

> ---
>
> v2: Add missing headers removed by git because they started with #
> Remove unrelated hunk.
> ---
>  tools/perf/util/stat-display.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index 993f4c4b8f44..2b69d238858c 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -580,16 +580,13 @@ static void print_metricgroup_header_std(struct per=
f_stat_config *config,
>                                          const char *metricgroup_name)
>  {
>         struct outstate *os =3D ctx;
> -       int n;
>
>         if (!metricgroup_name) {
>                 __new_line_std(config, os);
>                 return;
>         }
>
> -       n =3D fprintf(config->output, " %*s", EVNAME_LEN, metricgroup_nam=
e);
> -
> -       fprintf(config->output, "%*s", MGROUP_LEN + config->unit_width + =
2 - n, "");
> +       fprintf(config->output, " %*s", config->metric_only_len, metricgr=
oup_name);
>  }
>
>  static void print_metric_only(struct perf_stat_config *config,
> @@ -599,19 +596,20 @@ static void print_metric_only(struct perf_stat_conf=
ig *config,
>         struct outstate *os =3D ctx;
>         FILE *out =3D os->fh;
>         char str[1024];
> -       unsigned mlen =3D config->metric_only_len;
> +       unsigned mlen;
>         const char *color =3D metric_threshold_classify__color(thresh);
> +       int olen;
>
> -       if (!unit)
> -               unit =3D "";
> -       if (mlen < strlen(unit))
> -               mlen =3D strlen(unit) + 1;
> +       if (!unit) {
> +               os->first =3D false;
> +               return;
> +       }
>
> -       if (color)
> -               mlen +=3D strlen(color) + sizeof(PERF_COLOR_RESET) - 1;
> +       mlen =3D max_t(unsigned, strlen(unit), config->metric_only_len);
>
> +       olen =3D snprintf(str, sizeof(str), fmt ?: "", val);
>         color_snprintf(str, sizeof(str), color ?: "", fmt ?: "", val);
> -       fprintf(out, "%*s ", mlen, str);
> +       fprintf(out, "%*s%s", max_t(int, mlen - olen, 1), "", str);
>         os->first =3D false;
>  }
>
> --
> 2.54.0
>
>
