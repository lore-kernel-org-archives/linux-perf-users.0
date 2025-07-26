Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE36645
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Jul 2025 00:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753489015; cv=none; b=j6BWBQ9KGGJadCbuwpyviRkKNaZ/zXuBNaHp8uvife/hL8DnD3e6nfTY+e69GqJA1F7ttxBEDp5BV8pHJ/KoCf9GzM79YJQ+ElI80Xa9l5AlN+LdC12be7KWkNh6NGBuCGKt9RMzQ6ymZafuARuo2h3G2swOJdH14CVPC6Mv2Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753489015; c=relaxed/simple;
	bh=wLT07SspZJyUlUAY+iQCMYoNLLiQF7EBOVzYGdcBfcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nhIsJE06wtX1/oD5Uj08DA/NZ0QIzood64zL9N9/J4zKMv1L0nRTNLL6kiNO4gwXt8nQnIloajMhH4aYOnyhfvXeQ7soK5C9E01zt5hkEEbbigWc31SFFDFWrVCNgDytNHR2FpQzql1/XGNbK7q+/pblM/9kS/Fqf1AtBZe1y3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n/GXpBTJ; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n/GXpBTJ"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3e283b2d065so42895ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 17:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753489013; x=1754093813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWGAQbQT83vwF/MhSXD7xIgiGrpcABal3I6ANTiGhnw=;
        b=n/GXpBTJ5xYonlQPW3VZSmQV/Hez/5fvF6gmmnSxj1Wcr0jRhiBENWwNWvF2eYL3U9
         iyk8kwWwZCmh6rV30M4a2M5d8Y9fcA3aQ1wl3Yh5GEie5ABBcCMV0pja01L4H0i06AKn
         xXoTcicTiae333JKr/NCeTCfeybiyYGEW3HaDuItcVTwgC81IyUlzFISCT8mKPrha6Ti
         zt/rGGZEMX2lDZ55ByaSV55vTD3p+0rdARJE8p/MuaaDcS6PzIwN8Hvz4NQoBT7P4haR
         T+LUg0pZ4TFjOu39RX1qmlgocI5nn679BLZnZVquRxA3qRhJBw9GhIoGH16a+3Nk0azO
         s3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753489013; x=1754093813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWGAQbQT83vwF/MhSXD7xIgiGrpcABal3I6ANTiGhnw=;
        b=YCjh6H3AQcZ7njHhJwXYTW26HyTK9i0OKgGQZtDbloYyun2RRo9O1NqgUPiEN+SbYU
         wJ7Kw7+oMJpaCTxP1PPvITFUyD7bLuKMMaPdn36P22ySal94DZa2a/JVBb2IInHXY0E/
         0KThvJaUt/L0FoRUg6DQksxhE45X1YuxY0WOBjD+3uulKcDb2tdMVikv4c9jpU2OehCP
         VrwWWdRZvyObnnxMwXxBkn+XxOcALUdHuoS+okTdoLvrIX/wXC5xe1QlRlGgAXa1W58P
         kumyZZU7By2y09h3NQfxZ1OnZOdtkwF4i3hvPVNhkp1WLtehhFyrDZcNkwBZWWAJpBc6
         tzaw==
X-Forwarded-Encrypted: i=1; AJvYcCWjt6iiWDceHVksacL+/ob+CDnoqfOmrUWpeL1AQXUrznpuvyKHd/KYlecU613dAgA3V5Ylcp8lL7fYTVM4pzTH@vger.kernel.org
X-Gm-Message-State: AOJu0YzZmcUXO+oaJfw6kmmvhr+K/o9Z8k6ci6J2lOt9cB3hFXqrlyjR
	c0SbaoJ/h98BLtzbUD/0/WQtFFMTDoL9USsGtF1aBSfEzg0vhupmyRuETXcwqTxNK26ED+YXZI/
	ZyyIk7ldPI9rbhpiBB2y3kaBSX0PXRKN4WoOs/Yds
X-Gm-Gg: ASbGncsl/w9gdYP9UWgXxip0i+pfF5RsWsLC7LUw5tIRHAp2QS7+cs3zbqE0HpIln/r
	xCT6Wg4ht6vlEXrRUTdhrcpNsGPJyi6Ugj3tfA/re2Ft/2bDQ9Qh0vo4HavNh2TH1eHp2VHV/I1
	ZrYfX8qCptV90qwL3O4v8wKUZj4LttrkQkceIXP/r78LcIqRQZM9I48yOtu6yHhvrhH5Ql/hoX/
	x2lkru5o35qvRmaxXGrU2181WGqtA==
X-Google-Smtp-Source: AGHT+IE1m8smmID3cFuFNgjSz/MkYOtEOhdWRalCKfFb0FRn9NH9Mkh0FOMnWVqWkUHymBgr+7hXOVd76uU8eaYfKQM=
X-Received: by 2002:a05:6e02:3399:b0:3e2:c639:8279 with SMTP id
 e9e14a558f8ab-3e3cbfebd2cmr1701865ab.20.1753489012378; Fri, 25 Jul 2025
 17:16:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725193755.12276-1-namhyung@kernel.org> <20250725193755.12276-2-namhyung@kernel.org>
In-Reply-To: <20250725193755.12276-2-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Jul 2025 17:16:39 -0700
X-Gm-Features: Ac12FXyZRMAxtFSurK7aKeC9G_8NlL5V7QhxZMAiTEQfpuDa27RRtPfSAuEbzn0
Message-ID: <CAP-5=fXcBfQCbsrYmyrr4X+Svoo7iJW_62G8jG9C7f7hwwQAfA@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] perf annotate: Rename to __hist_entry__tui_annotate()
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
> There are three different but similar functions for annotation on TUI.
> Rename it to __hist_entry__tui_annotate() and make sure it passes 'he'.
> It's not used for now but it'll be needed for later use.
>
> Also remove map_symbol__tui_annotate() which was a simple wrapper.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/ui/browsers/annotate.c | 17 +++++++----------
>  tools/perf/ui/browsers/hists.c    |  2 +-
>  tools/perf/util/annotate.h        | 12 ------------
>  tools/perf/util/hist.h            | 12 +++++++-----
>  4 files changed, 15 insertions(+), 28 deletions(-)
>
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/a=
nnotate.c
> index 183902dac042ecb0..28ef146f29e8e742 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -27,6 +27,7 @@ struct annotate_browser {
>         struct rb_node             *curr_hot;
>         struct annotation_line     *selection;
>         struct arch                *arch;
> +       struct hist_entry          *he;

nit: as you are here is it worth commenting this, for example, who owns "he=
"?

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>         bool                        searching_backwards;
>         char                        search_bf[128];
>  };
> @@ -557,7 +558,7 @@ static bool annotate_browser__callq(struct annotate_b=
rowser *browser,
>         target_ms.map =3D ms->map;
>         target_ms.sym =3D dl->ops.target.sym;
>         annotation__unlock(notes);
> -       symbol__tui_annotate(&target_ms, evsel, hbt);
> +       __hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt);
>         sym_title(ms->sym, ms->map, title, sizeof(title), annotate_opts.p=
ercent_type);
>         ui_browser__show_title(&browser->b, title);
>         return true;
> @@ -1032,12 +1033,6 @@ static int annotate_browser__run(struct annotate_b=
rowser *browser,
>         return key;
>  }
>
> -int map_symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
> -                            struct hist_browser_timer *hbt)
> -{
> -       return symbol__tui_annotate(ms, evsel, hbt);
> -}
> -
>  int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
>                              struct hist_browser_timer *hbt)
>  {
> @@ -1046,11 +1041,12 @@ int hist_entry__tui_annotate(struct hist_entry *h=
e, struct evsel *evsel,
>         SLang_init_tty(0, 0, 0);
>         SLtty_set_suspend_state(true);
>
> -       return map_symbol__tui_annotate(&he->ms, evsel, hbt);
> +       return __hist_entry__tui_annotate(he, &he->ms, evsel, hbt);
>  }
>
> -int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
> -                        struct hist_browser_timer *hbt)
> +int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol =
*ms,
> +                              struct evsel *evsel,
> +                              struct hist_browser_timer *hbt)
>  {
>         struct symbol *sym =3D ms->sym;
>         struct annotation *notes =3D symbol__annotation(sym);
> @@ -1064,6 +1060,7 @@ int symbol__tui_annotate(struct map_symbol *ms, str=
uct evsel *evsel,
>                         .priv    =3D ms,
>                         .use_navkeypressed =3D true,
>                 },
> +               .he =3D he,
>         };
>         struct dso *dso;
>         int ret =3D -1, err;
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> index d9d3fb44477ac6d5..487c0b08c0038710 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -2484,8 +2484,8 @@ do_annotate(struct hist_browser *browser, struct po=
pup_action *act)
>         else
>                 evsel =3D hists_to_evsel(browser->hists);
>
> -       err =3D map_symbol__tui_annotate(&act->ms, evsel, browser->hbt);
>         he =3D hist_browser__selected_entry(browser);
> +       err =3D __hist_entry__tui_annotate(he, &act->ms, evsel, browser->=
hbt);
>         /*
>          * offer option to annotate the other branch source or target
>          * (if they exists) when returning from annotate
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 8b5131d257b01e3e..0f640e4871744262 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -471,18 +471,6 @@ int hist_entry__annotate_printf(struct hist_entry *h=
e, struct evsel *evsel);
>  int hist_entry__tty_annotate(struct hist_entry *he, struct evsel *evsel)=
;
>  int hist_entry__tty_annotate2(struct hist_entry *he, struct evsel *evsel=
);
>
> -#ifdef HAVE_SLANG_SUPPORT
> -int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
> -                        struct hist_browser_timer *hbt);
> -#else
> -static inline int symbol__tui_annotate(struct map_symbol *ms __maybe_unu=
sed,
> -                               struct evsel *evsel  __maybe_unused,
> -                               struct hist_browser_timer *hbt __maybe_un=
used)
> -{
> -       return 0;
> -}
> -#endif
> -
>  void annotation_options__init(void);
>  void annotation_options__exit(void);
>
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index 70438d03ca9c33b1..c64005278687cb02 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -713,8 +713,9 @@ struct block_hist {
>  #include "../ui/keysyms.h"
>  void attr_to_script(char *buf, struct perf_event_attr *attr);
>
> -int map_symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
> -                            struct hist_browser_timer *hbt);
> +int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol =
*ms,
> +                              struct evsel *evsel,
> +                              struct hist_browser_timer *hbt);
>
>  int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
>                              struct hist_browser_timer *hbt);
> @@ -742,9 +743,10 @@ int evlist__tui_browse_hists(struct evlist *evlist _=
_maybe_unused,
>  {
>         return 0;
>  }
> -static inline int map_symbol__tui_annotate(struct map_symbol *ms __maybe=
_unused,
> -                                          struct evsel *evsel __maybe_un=
used,
> -                                          struct hist_browser_timer *hbt=
 __maybe_unused)
> +static inline int __hist_entry__tui_annotate(struct hist_entry *he __may=
be_unused,
> +                                            struct map_symbol *ms __mayb=
e_unused,
> +                                            struct evsel *evsel __maybe_=
unused,
> +                                            struct hist_browser_timer *h=
bt __maybe_unused)
>  {
>         return 0;
>  }
> --
> 2.50.1
>
