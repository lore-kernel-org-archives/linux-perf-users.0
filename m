Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2D286348
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Jul 2025 00:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753490101; cv=none; b=BB30JpRTWWjx0IQkwiavFp/sRzw0yRrT0HlbFH5DGn613oiR7ev9VTEyfsSgEEiPJ8JKnFA7H/ujyW8wiIvoeEislxuP+AB6d9VtFfzk+6IIq23JEAWPdEtC8GQwUks5qvheXY20XVqxfZK6vFrNm5fktDvJbRkKSuQmiNdxoq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753490101; c=relaxed/simple;
	bh=CEMeBZezoOjzuH4XZ0JSOAau1ciA8YndvA6qZcE0mw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEfc0Io1dWjfnaHEro+ufCFwV3yFP5ZLpr8XdY41XBa5lGEgQkKnVT/cVA2VWIZOJz8FjfMJq1+CwlcQRtHSyN9BSirU+1P530ufMchB0xw6ZWqlPOwEBm+vFhZim1bJ/QsV5lSmopuTJZNNb7b/INbNRW/ZNmSIeZHuJe7Ftfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Lie0Dgo; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Lie0Dgo"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3e283b2d065so44125ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 17:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753490099; x=1754094899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZPCpsnOFMzo8Dy5wKM/rmboR8jCseogtU4sWxCBrbc=;
        b=3Lie0DgondpI9jSHwdx8kgY11y5kBQFqU9xLhd6wEdwXL1cx3DDIsh4fCaH6EOlAgx
         +cowVhB+ahHmv/oUQZ4P/+geexZH83C5YyKafDjD06g7nK1AT6nZXcIyRcn+doS46XFI
         DEkT/51Xh22+1tkau+OjnD8VsP4vxui56weJjS4lW7yVdrsEcD2I6DVRj3V4rqg87kKl
         5EHNyHjv9BUuU+QKJ+9pnhrJs1Qvww714shTTMJb3WhiXkXevJeVp8TFgHOxSFJqac4T
         dt/rdJOTnEFqgpBuBgfplbnnhdFAzN+Q92tZLLjN6ei34m+RvXoyBQt1dpx2h0Mw3XgF
         2egQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753490099; x=1754094899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZPCpsnOFMzo8Dy5wKM/rmboR8jCseogtU4sWxCBrbc=;
        b=YkCAgd6kqtHB+Cx//gPo4XLqKMUsJ7XGNmK00jvauFyYVBp5M8aEDeUVqZIn+zPnD4
         GnNLqxCNdeLqcwOYkRyYFmSnTEDIwYHjo8l1QjFwVWXgKAtjUmxJbz2HdRk3VEd/zgMs
         EloEmyg/lf2xDt0Vkg1ABy9WI/tgOhKBvBhX6+yYQbRLUfPqn5B2hOiYXFDlgEmfB1DV
         X+R/lthiXZWwnQljN9sT3DK7V1YU9CqQ9WTA2yRV0NKG46oMr/nHxjw0UzzkJ5MGIbis
         Imoe1mXkLAZno5XqQC9TevyOj3cc3F0rNzoAmdbNxzPhhnAWsrXMcAsR8o1safC5EWm2
         9C3g==
X-Forwarded-Encrypted: i=1; AJvYcCVS0IRUGHScd26PTy2epefS4PfZHsT+ZjyybeJyKp3h0j0UCLORDHAEN43OeYKd/jNTg8YaK3uToHrgl8xmht+G@vger.kernel.org
X-Gm-Message-State: AOJu0YxactUqontDFOJQDTh43alqszMj3laaqgXcXpDC1Gw+LgWVMGxp
	PS6Ciuhag39galdwSCs5C+oyH8jso2ljAxsUZ8mbvAR3v1u6S7PQ0CGayeUnK/fWHu2Dxx97OUh
	E86z0MaDHow2i/Jur+QzYEPUFfkFBieTnv2smAGDL
X-Gm-Gg: ASbGnctWx1AqfMKkd68HIajOM4y9yU1bJ4I4YqsBoAPk+3KME/ysGCw1RW7+FAfJkVW
	mpujtyp6ItL68v9dZkXzmnaUFIjaZGIjV0Y5u2ox4PoB24EWwOtdXjTp2I2hwdh2GTiuC/vl3St
	jM/6Bgjd6GZexjdWwLEhMMYpb+Y+iOuZdZPQ/oIlkP0Rzh9WJnvtULgtASl1VWOIsTwW7mpDfXN
	IEJynXV
X-Google-Smtp-Source: AGHT+IFP/+PLw/W7PC5xdHYXpvVc7MsNmqcrVmuoK0wFuNmDMht3hAFpkSertLVeZn69lRiXAthCkoCVShx5VL3fM74=
X-Received: by 2002:a92:c24e:0:b0:3e2:86d2:fed6 with SMTP id
 e9e14a558f8ab-3e3cce953b7mr803435ab.21.1753490099216; Fri, 25 Jul 2025
 17:34:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725193755.12276-1-namhyung@kernel.org> <20250725193755.12276-7-namhyung@kernel.org>
In-Reply-To: <20250725193755.12276-7-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Jul 2025 17:34:47 -0700
X-Gm-Features: Ac12FXxWrsAPv-GxYhX7HwrLIGTvf8k6Uj4evVlKPj9FmmNbbIUDtXzDMsCfWU0
Message-ID: <CAP-5=fUZk4Fvo+E88C+o4TCyBsZCAGNwbpi5XMWX0ttbgAA00A@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] perf annotate: Add 'T' hot key to toggle data type display
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 12:38=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Support data type display with a key press so that users can toggle the
> output dynamically on TUI.  Also display "[Type]" in the title line if
> it's enabled.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/ui/browsers/annotate.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/a=
nnotate.c
> index cdee1969f3131a7c..4b059e0bafd33fcf 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -525,9 +525,10 @@ static void ui_browser__init_asm_mode(struct ui_brow=
ser *browser)
>  static int sym_title(struct symbol *sym, struct map *map, char *title,
>                      size_t sz, int percent_type)
>  {
> -       return snprintf(title, sz, "%s  %s [Percent: %s]", sym->name,
> +       return snprintf(title, sz, "%s  %s [Percent: %s] %s", sym->name,
>                         dso__long_name(map__dso(map)),
> -                       percent_type_str(percent_type));
> +                       percent_type_str(percent_type),
> +                       annotate_opts.code_with_type ? "[Type]" : "");
>  }
>
>  /*
> @@ -901,7 +902,8 @@ static int annotate_browser__run(struct annotate_brow=
ser *browser,
>                 "b             Toggle percent base [period/hits]\n"
>                 "B             Branch counter abbr list (Optional)\n"
>                 "?             Search string backwards\n"
> -               "f             Toggle showing offsets to full address\n")=
;
> +               "f             Toggle showing offsets to full address\n"
> +               "T             Toggle data type display\n");
>                         continue;
>                 case 'r':
>                         script_browse(NULL, NULL);
> @@ -1021,6 +1023,12 @@ static int annotate_browser__run(struct annotate_b=
rowser *browser,
>                 case 'f':
>                         annotation__toggle_full_addr(notes, ms);
>                         continue;
> +               case 'T':
> +                       annotate_opts.code_with_type ^=3D 1;
> +                       if (browser->dbg =3D=3D NULL)
> +                               browser->dbg =3D debuginfo__new(dso__long=
_name(map__dso(ms->map)));

browser->dbg =3D dso__debuginfo(map__dso(ms->map));

There was a conversation about dso not necessarily having to have
long_name in the future, etc.

Thanks,
Ian

> +                       annotate_browser__show(&browser->b, title, help);
> +                       continue;
>                 case K_LEFT:
>                 case '<':
>                 case '>':
> @@ -1115,8 +1123,7 @@ int __hist_entry__tui_annotate(struct hist_entry *h=
e, struct map_symbol *ms,
>
>         ret =3D annotate_browser__run(&browser, evsel, hbt);
>
> -       if (annotate_opts.code_with_type)
> -               debuginfo__delete(browser.dbg);
> +       debuginfo__delete(browser.dbg);
>         if (not_annotated && !notes->src->tried_source)
>                 annotated_source__purge(notes->src);
>
> --
> 2.50.1
>
