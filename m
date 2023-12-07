Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076E11BDA;
	Thu,  7 Dec 2023 12:34:34 -0800 (PST)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5bdb0be3591so1104523a12.2;
        Thu, 07 Dec 2023 12:34:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701981273; x=1702586073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6eK7GmkC+MOlgnAqTreiUYrmfw87lLVr1vlz5i4mdHs=;
        b=TeP2gVpD4syeKBQ21b4/nUP3tT/OhylW2otHS7NNKwOIZeDrBBFixQXAsUwjy2zZlS
         tazf/rDlUi96RcjnUNnfaC1LsTPA/0AD+ttA/Jdyd5Auf7u11HL385My4hQvMowNh1Ns
         ItHLYLP51UZ/qeTD9I77djlZtBbogPpvFX1Wf/QqTUSTWdbzPUBnkyI6une3/CkMf+0K
         SRFXKtOuUnY9urGpQTD5/eQYfNK1NasRs5eEiYS3xYkJh70CUUd03UUDmfvXjq71dOa2
         xvpth4dQK9+FJbGHqtGHfcxoMZ302U94s1t5SleytAGNbdjJGQzaEqjFIIVek3sAe446
         Wz8w==
X-Gm-Message-State: AOJu0YwDUWbKRmxjxpQvYw0k6oxffhsBBvhXsi/tAtxZayvvCKGb6uZL
	k7SEDfI/rBNHIa+ko4Iqcu6kRrV5gRvkhEEBpHg=
X-Google-Smtp-Source: AGHT+IHmEL8krtJsjXUO7c7ScOqGojZcZI20DcGgMy7M3cpewmpq6sVH0ytC82O5lueQ2qt9BVL7nQ3jHALMxQoXWRw=
X-Received: by 2002:a05:6a20:4ba9:b0:18f:97c:8a50 with SMTP id
 fu41-20020a056a204ba900b0018f097c8a50mr2705672pzb.123.1701981273120; Thu, 07
 Dec 2023 12:34:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128175441.721579-1-namhyung@kernel.org> <20231128175441.721579-5-namhyung@kernel.org>
 <ZXIoRDWBPEjUpYuP@kernel.org>
In-Reply-To: <ZXIoRDWBPEjUpYuP@kernel.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 7 Dec 2023 12:34:21 -0800
Message-ID: <CAM9d7ch6BRTYoES2atnM8G_qpS6B6Z-oVWD04ZHBBOB9ND11zw@mail.gmail.com>
Subject: Re: [PATCH 4/8] perf annotate: Use global annotation_options
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 12:17=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Nov 28, 2023 at 09:54:37AM -0800, Namhyung Kim escreveu:
> > Now it can directly use the global options and no need to pass it as an
> > argument.
>
> At this point the build breaks when using GTK2=3D1 on the make command
> line, as done in 'make -C tools/perf build-test', so I had to add the
> following patch on top of this 4/8 patch:

Oops, I forgot to test with it.  Thanks for fixing this!

Thanks,
Namhyung

>
>
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.=
c
> index a53a4e711899f20d..9c1e2b2b5bc0b730 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -365,7 +365,6 @@ static void hists__find_annotations(struct hists *his=
ts,
>                         int ret;
>                         int (*annotate)(struct hist_entry *he,
>                                         struct evsel *evsel,
> -                                       struct annotation_options *option=
s,
>                                         struct hist_browser_timer *hbt);
>
>                         annotate =3D dlsym(perf_gtk_handle,
> @@ -375,7 +374,7 @@ static void hists__find_annotations(struct hists *his=
ts,
>                                 return;
>                         }
>
> -                       ret =3D annotate(he, evsel, &annotate_opts, NULL)=
;
> +                       ret =3D annotate(he, evsel, NULL);
>                         if (!ret || !ann->skip_missing)
>                                 return;
>
> diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
> index 2effac77ca8c6742..394861245fd3e48f 100644
> --- a/tools/perf/ui/gtk/annotate.c
> +++ b/tools/perf/ui/gtk/annotate.c
> @@ -162,7 +162,6 @@ static int perf_gtk__annotate_symbol(GtkWidget *windo=
w, struct map_symbol *ms,
>  }
>
>  static int symbol__gtk_annotate(struct map_symbol *ms, struct evsel *evs=
el,
> -                               struct annotation_options *options,
>                                 struct hist_browser_timer *hbt)
>  {
>         struct dso *dso =3D map__dso(ms->map);
> @@ -176,7 +175,7 @@ static int symbol__gtk_annotate(struct map_symbol *ms=
, struct evsel *evsel,
>         if (dso->annotate_warned)
>                 return -1;
>
> -       err =3D symbol__annotate(ms, evsel, options, NULL);
> +       err =3D symbol__annotate(ms, evsel, NULL);
>         if (err) {
>                 char msg[BUFSIZ];
>                 dso->annotate_warned =3D true;
> @@ -244,10 +243,9 @@ static int symbol__gtk_annotate(struct map_symbol *m=
s, struct evsel *evsel,
>
>  int hist_entry__gtk_annotate(struct hist_entry *he,
>                              struct evsel *evsel,
> -                            struct annotation_options *options,
>                              struct hist_browser_timer *hbt)
>  {
> -       return symbol__gtk_annotate(&he->ms, evsel, options, hbt);
> +       return symbol__gtk_annotate(&he->ms, evsel, hbt);
>  }
>
>  void perf_gtk__show_annotations(void)
> diff --git a/tools/perf/ui/gtk/gtk.h b/tools/perf/ui/gtk/gtk.h
> index 1e84dceb52671385..a2b497f03fd6e478 100644
> --- a/tools/perf/ui/gtk/gtk.h
> +++ b/tools/perf/ui/gtk/gtk.h
> @@ -56,13 +56,11 @@ struct evsel;
>  struct evlist;
>  struct hist_entry;
>  struct hist_browser_timer;
> -struct annotation_options;
>
>  int evlist__gtk_browse_hists(struct evlist *evlist, const char *help,
>                              struct hist_browser_timer *hbt, float min_pc=
nt);
>  int hist_entry__gtk_annotate(struct hist_entry *he,
>                              struct evsel *evsel,
> -                            struct annotation_options *options,
>                              struct hist_browser_timer *hbt);
>  void perf_gtk__show_annotations(void);
>
