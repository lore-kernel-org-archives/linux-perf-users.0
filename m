Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F6E1862C
	for <linux-perf-users@vger.kernel.org>; Tue, 14 May 2024 02:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715655087; cv=none; b=nJ1bZoy2iBDPaRwZWsnJzUxqfR19kcMpfrt9TrmoQp6NFuHGnueA5i6eB2YOab42yuMjT1/N8qIhIXe6U6K1v0jH93MzKHv7dvfI6YGk2neIUIJ2Ah97eQUGXtep/b9LCbofWao4K3YEQuEovfHVsTM1ebfsseywcAZuyQ4Jn1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715655087; c=relaxed/simple;
	bh=nLqnRzXuugsBdc7ewTgIC3l72dQ3bEBHuThmW6siqFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYm24ppQJh0rYlhB4+Tva15qnpyZcxVlomyFUAH67ok9QXQsjAeYXr+05PyV54ge7f7rK8TwGdFsVPEwqeRLXbClI1JIb/7x7cQZSEjkBouPkxTKjoILjkcY4UEG1ugCNz61hg+mZ6ZdAzJ3xjwi1EUoCqPBbKpa25hUq+sWKdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3xtrjqgI; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3xtrjqgI"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-43df9ac3ebcso1032631cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 19:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715655085; x=1716259885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIa3lnYqMtW+apSFSgewrwmz8iNQ0a0TRqIJ0PDkJcw=;
        b=3xtrjqgIn8IayUTcsMDHNiIAH6//IGibQNc3rSgr1aaIqrbUHFlXpTZNOxNAnikYTY
         rSX/YCL1sQOQ76OKyTgXz0FhiBc6PWPh/8WmZoKj8d0Bjrz4ErW1DU47hLyZ4GnfJpXG
         64roSrD3NThPWKML99iBP+hxFyM5n3qq0BGL0mtHIql7nnLzsjSPLpG5ciT9NL6hAlhI
         URWVxTGnGzfgQE/oOiSICsCd56u0mMvPC81qj52lTn9GcJGFOaGBO7b8TRM5dxhCLYzV
         DVmjRO3jK90zNl/qd9888LGHpxrCl36HV5gtrCxZm3Kd/AvCMZNgILC2nj0VIVGJq2bi
         Ti/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715655085; x=1716259885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIa3lnYqMtW+apSFSgewrwmz8iNQ0a0TRqIJ0PDkJcw=;
        b=kOvQMP9vuZqYCxBU+zm2g4NWqFY3k5olom6QTlsITUWRdnyt0lkZpf5oAvumMfCP0P
         MAy+Sh45K/VSuhVDjquMtnzsMyxWNimCgy1YXvRehrzCC3oO72/iyz3i8lmwrsNL99gq
         wqRjWTGw6u+O+6EfT7qrWspndPDMASpnfkLRiRd0A6NA3QEnxsd8j/2wTW385rCghK0t
         7vQmVyQaoCcrp0Fao8W4KZamJ/bUZyYqYw5X7Fp81J0/MaSac67yyzvtFD63WMCEBoIr
         hzRF4jQgVnRPGP3HM77toIbkUkf5DGRtG4e1un4QXLiAwSFT/gbcFmtZlU4EBO/tyuBj
         u69A==
X-Forwarded-Encrypted: i=1; AJvYcCXViuCLmM1KDAeIvPZXZlDCnCs55c1NrFF1Y41cNMWf70mdPgqL8rd/wdSKA2SIXzM3GvScBmyAsQMI4ks9y043W9vZB7geqMofPDBw32Oxpg==
X-Gm-Message-State: AOJu0YzZfI+oSMnUuNHTEdTaNslqrAni4m+uWoO0BgVkEQHrAtbobKwB
	K+KJxAeGZYf/dweOCJz8aTzkiGqNaLARF24vFOUr/qSYGe6PPDZqnir5zQL18IcFCrtMY3IFMsx
	6B1yg8VpOFTn3vHBXuMvIUo8DhnNe9WX/oT4/
X-Google-Smtp-Source: AGHT+IGhtFEj9beqqIh4sXHHRvKxoIkelYN2KoaL9BfCJUD+o17rUm887vqMEGHGvEmtncn+5O6pMaj1JWVyLypUqX0=
X-Received: by 2002:a05:622a:40cc:b0:43b:70e:d677 with SMTP id
 d75a77b69052e-43e0a232178mr7454281cf.29.1715655083303; Mon, 13 May 2024
 19:51:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513212007.62904-1-leitao@debian.org>
In-Reply-To: <20240513212007.62904-1-leitao@debian.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 May 2024 19:51:12 -0700
Message-ID: <CAP-5=fXimpTxhC0A+MDs8t9zn=hifHFxLChQm_QzJQtuHbztPg@mail.gmail.com>
Subject: Re: [PATCH v2] perf list: Fix the --no-desc option
To: Breno Leitao <leitao@debian.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, leit@meta.com, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 2:20=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Currently, the --no-desc option in perf list isn't functioning as
> intended.
>
> This issue arises from the overwriting of struct option->desc with the
> opposite value of struct option->long_desc. Consequently, whatever
> parse_options() returns at struct option->desc gets overridden later,
> rendering the --desc or --no-desc arguments ineffective.
>
> To resolve this, set ->desc as true by default and allow parse_options()
> to adjust it accordingly. This adjustment will fix the --no-desc
> option while preserving the functionality of the other parameters.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changelog:
>
> v2:
>         * Do not print desc if long_desc is being printed, as identified
>           by Ian Rogers.
> ---
>  tools/perf/builtin-list.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index e27a1b1288c2..16186acdd301 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -149,7 +149,11 @@ static void default_print_event(void *ps, const char=
 *pmu_name, const char *topi
>         } else
>                 fputc('\n', fp);
>
> -       if (desc && print_state->desc) {
> +       if (long_desc && print_state->long_desc) {
> +               fprintf(fp, "%*s", 8, "[");
> +               wordwrap(fp, long_desc, 8, pager_get_columns(), 0);
> +               fprintf(fp, "]\n");
> +       } else if (desc && print_state->desc) {

I think we need the same fix also in default_print_metric, on an Intel
Tigerlake I see the description repeated like:
```
$ perf list --long-desc
...
Bad:
  tma_info_bad_spec_branch_misprediction_cost
       [Branch Misprediction Cost: Fraction of TMA slots wasted per
non-speculative branch
        misprediction (retired JEClear)]
       [Branch Misprediction Cost: Fraction of TMA slots wasted per
non-speculative branch
        misprediction (retired JEClear). Related metrics:
tma_branch_mispredicts,
        tma_info_bottleneck_mispredictions,tma_mispredicts_resteers]
  tma_info_bad_spec_ipmisp_cond_ntaken
       [Instructions per retired mispredicts for conditional non-taken
branches (lower number
        means higher occurrence rate)]
...
```

Thanks,
Ian

>                 char *desc_with_unit =3D NULL;
>                 int desc_len =3D -1;
>
> @@ -165,12 +169,6 @@ static void default_print_event(void *ps, const char=
 *pmu_name, const char *topi
>                 fprintf(fp, "]\n");
>                 free(desc_with_unit);
>         }
> -       long_desc =3D long_desc ?: desc;
> -       if (long_desc && print_state->long_desc) {
> -               fprintf(fp, "%*s", 8, "[");
> -               wordwrap(fp, long_desc, 8, pager_get_columns(), 0);
> -               fprintf(fp, "]\n");
> -       }
>
>         if (print_state->detailed && encoding_desc) {
>                 fprintf(fp, "%*s", 8, "");
> @@ -484,6 +482,7 @@ int cmd_list(int argc, const char **argv)
>         int i, ret =3D 0;
>         struct print_state default_ps =3D {
>                 .fp =3D stdout,
> +               .desc =3D true,
>         };
>         struct print_state json_ps =3D {
>                 .fp =3D stdout,
> @@ -556,7 +555,6 @@ int cmd_list(int argc, const char **argv)
>                 };
>                 ps =3D &json_ps;
>         } else {
> -               default_ps.desc =3D !default_ps.long_desc;
>                 default_ps.last_topic =3D strdup("");
>                 assert(default_ps.last_topic);
>                 default_ps.visited_metrics =3D strlist__new(NULL, NULL);
> --
> 2.43.0
>
