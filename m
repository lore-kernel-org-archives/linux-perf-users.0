Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9692FFDD8
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Nov 2025 05:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763616640; cv=none; b=J+I5g/IwQ5Oaasp2e5L8PsahjeOgOYLWAlDSB7XYg82ayyano3ej9Y7HuDZVw56OFNFSi6ROrTufOe3c9g6S05qA+/M4nJRtKK01WoIes5++hXCGjtPWVpASMqGqgsmXSI5Swn3eB+0/ogDrz4o6eZBPtBlKeJK649G+g6TvMg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763616640; c=relaxed/simple;
	bh=N6yOztctVwNX0bnzrQfMG+Y3iHsLVmUJdHld0841ovM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SviuOhcN18hiXLslf07QfvnDJbwZq8KiVEB2XC9efrMSjtr+OsMHTLcmscK92kUsegcaUSe8QHePqaYVLU8co7qPjcvbgALeUac2UIB0Ml4ICOm8kjANZEzUP+/SkfJ7QjCSDrQwPzmFKgicEoh1XkBE6L6gCkDuFNUJJpg8FFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sgViMwYP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sgViMwYP"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-295c64cb951so139085ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 21:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763616637; x=1764221437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHE7Bf8hdf1BlTO6T/tS+Le0BhRC7n6lGCF1BwIc6Bo=;
        b=sgViMwYPP/MAaKFrvVRHewCEEFV2jSYykF1mjz1iiFxu80pmSqEI8tiedAIO9Hlvb3
         ATpS5h6pWNMGuUhCs8RJToaBrW3a2NafP/G79GnqJZ7B4kCHvEEMyfGCLvTs8xW6pcXF
         57LZHvUDlOa8AQySjR1/Zh1Th8bYcfiiAvBuFQFRvR9U2aZspGWW6zplHBSbg+lWPKxV
         j+pY9PyAIsFyq9YqkuKjTKK9VRpE5MU9BvuFwY7tL1/adGWvZksBFZplfWLBzxSajr14
         iRLHyIe+6LD03qSSNi3k6vhvWlDMwZXgIfkBYFygRHopaji+6kKPh1oubttHqDgfgXsQ
         0qKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763616637; x=1764221437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PHE7Bf8hdf1BlTO6T/tS+Le0BhRC7n6lGCF1BwIc6Bo=;
        b=eGqgU38Rvv4bESXKOTRqRNYpXeQth+XYNcPHBzV4RY5d2rr3GHKJFQaAhilMqrgKWS
         k4P7Bm70KSKHo1ZhdchJELkicDgVflwPKloimERYo8c5I2+eS2gSa/00RivdY7wUhZPL
         1T1Fi2eystosmkFRAeML5LFbMI6LL1sV6/IUWgRwXK66CoBOiBwltF/bDltsxyEnWsCN
         XRkSrWlNZiLfyc+B1hPbe2f4q0EdtDjCzRmMkYi0NsRRm5WOJLkeNith2qDJpgi2in8x
         7TmrDYGuzG9gGxWMoPtXjadvHLJitV2Zc5r/63+a3Fnlx0Xd8Fg3whSUGWQ931ew8++d
         ylaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1ts0hGypeZElLZ5PnsvClTQj5xyxep6l3nLYzE7QzmShuXbwlBQRQRuYTkIn4O4xttm4gjBq2Z3V4JO7vVy9Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yw11r638WNg+X/AKQ4qRhfn++pqZDcDThbDEnjk8qWJzuWfwIFa
	3if7/O2Vqu1j2Cn56dooUIzfnFjd8Vx2FMOMnspz+JhWGT7Whv83G2vSjNYLbRaDmw/zhYBs92y
	pZJ4ja9Y8SOUHWH8OzQL34v/9QRlzhN6t1Ajq7pIX
X-Gm-Gg: ASbGncvcnYv8Z0Zh3Zl8Vq3sTXG+ds7XAVxGPwd8v9TDhirEQwAQpuBgfD4DO5nlRbh
	BpIAqYwp9Egxo+ydccXSip8gCnT5yHYT9hgirjiGCSGAlFBIj+Icb/EoQksBSkj2E6K/LJpVTl1
	OFrMa5/GdQDuT+mdHpbZ7uYEf8dTRnnVNJPV5hUXX6E4VFUob/QQN0zOVK2aQh0wtz1QO0hQ+gS
	/EemgeDdaTTsvz9pp0jR9BuoOQQDk1dbI4BIq/WvWPlBNzzmbjixCEZyHtZ2dcbyrpmxF3v
X-Google-Smtp-Source: AGHT+IFN1kkWsfESQyRXEM0/RnZUrC0oMSWRAIWelC1mu8lz8aqsnE4W9KOAKclX6pTuEdsTxSpoTEgYRqlz8tDTfOk=
X-Received: by 2002:a17:902:d48a:b0:295:30bc:458e with SMTP id
 d9443c01a7336-29b5da68247mr1196115ad.3.1763616636937; Wed, 19 Nov 2025
 21:30:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120004726.61660-1-namhyung@kernel.org> <20251120004726.61660-2-namhyung@kernel.org>
In-Reply-To: <20251120004726.61660-2-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Nov 2025 21:30:25 -0800
X-Gm-Features: AWmQ_bmjtDwDnY6AhwENCSpEurbZKfuI4HxjdGkAa5AnmY2UlgY_PCpDSRCZoxg
Message-ID: <CAP-5=fWSg07fTLJNya0ftdUfk7HTbYXB=5xbbPBeN_q4LNs6cw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] perf list: Share print state with JSON output
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 4:47=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The JSON print state has only one different field (need_sep).  Let's
> add the default print state to the json state and use it.  Then we can
> use the 'ps' variable to update the state properly.
>
> This is a preparation for the next commit.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-list.c | 127 +++++++++++++++++++-------------------
>  1 file changed, 65 insertions(+), 62 deletions(-)
>
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index 28bf1fc7f5eeff8f..6c5913f129f39c94 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -283,8 +283,8 @@ static void default_print_metric(void *ps,
>  }
>
>  struct json_print_state {
> -       /** @fp: File to write output to. */
> -       FILE *fp;
> +       /** The shared print_state */
> +       struct print_state common;
>         /** Should a separator be printed prior to the next item? */
>         bool need_sep;
>  };
> @@ -292,7 +292,7 @@ struct json_print_state {
>  static void json_print_start(void *ps)
>  {
>         struct json_print_state *print_state =3D ps;
> -       FILE *fp =3D print_state->fp;
> +       FILE *fp =3D print_state->common.fp;
>
>         fprintf(fp, "[\n");
>  }
> @@ -300,7 +300,7 @@ static void json_print_start(void *ps)
>  static void json_print_end(void *ps)
>  {
>         struct json_print_state *print_state =3D ps;
> -       FILE *fp =3D print_state->fp;
> +       FILE *fp =3D print_state->common.fp;
>
>         fprintf(fp, "%s]\n", print_state->need_sep ? "\n" : "");
>  }
> @@ -370,7 +370,7 @@ static void json_print_event(void *ps, const char *to=
pic,
>  {
>         struct json_print_state *print_state =3D ps;
>         bool need_sep =3D false;
> -       FILE *fp =3D print_state->fp;
> +       FILE *fp =3D print_state->common.fp;
>         struct strbuf buf;
>
>         strbuf_init(&buf, 0);
> @@ -446,7 +446,7 @@ static void json_print_metric(void *ps __maybe_unused=
, const char *group,
>  {
>         struct json_print_state *print_state =3D ps;
>         bool need_sep =3D false;
> -       FILE *fp =3D print_state->fp;
> +       FILE *fp =3D print_state->common.fp;
>         struct strbuf buf;
>
>         strbuf_init(&buf, 0);
> @@ -521,10 +521,12 @@ int cmd_list(int argc, const char **argv)
>                 .fp =3D stdout,
>                 .desc =3D true,
>         };
> -       struct print_state json_ps =3D {
> -               .fp =3D stdout,
> +       struct json_print_state json_ps =3D {
> +               .common =3D {
> +                       .fp =3D stdout,
> +               },
>         };
> -       void *ps =3D &default_ps;
> +       struct print_state *ps =3D &default_ps;
>         struct print_callbacks print_cb =3D {
>                 .print_start =3D default_print_start,
>                 .print_end =3D default_print_end,
> @@ -572,9 +574,11 @@ int cmd_list(int argc, const char **argv)
>         argc =3D parse_options(argc, argv, list_options, list_usage,
>                              PARSE_OPT_STOP_AT_NON_OPTION);
>
> +       if (json)
> +               ps =3D &json_ps.common;
> +
>         if (output_path) {
> -               default_ps.fp =3D fopen(output_path, "w");
> -               json_ps.fp =3D default_ps.fp;
> +               ps->fp =3D fopen(output_path, "w");
>         }
>
>         setup_pager();
> @@ -590,14 +594,13 @@ int cmd_list(int argc, const char **argv)
>                         .print_metric =3D json_print_metric,
>                         .skip_duplicate_pmus =3D json_skip_duplicate_pmus=
,
>                 };
> -               ps =3D &json_ps;
>         } else {
> -               default_ps.last_topic =3D strdup("");
> -               assert(default_ps.last_topic);
> -               default_ps.visited_metrics =3D strlist__new(NULL, NULL);
> -               assert(default_ps.visited_metrics);
> +               ps->last_topic =3D strdup("");
> +               assert(ps->last_topic);
> +               ps->visited_metrics =3D strlist__new(NULL, NULL);
> +               assert(ps->visited_metrics);
>                 if (unit_name)
> -                       default_ps.pmu_glob =3D strdup(unit_name);
> +                       ps->pmu_glob =3D strdup(unit_name);
>                 else if (cputype) {
>                         const struct perf_pmu *pmu =3D perf_pmus__pmu_for=
_pmu_filter(cputype);
>
> @@ -606,15 +609,15 @@ int cmd_list(int argc, const char **argv)
>                                 ret =3D -1;
>                                 goto out;
>                         }
> -                       default_ps.pmu_glob =3D strdup(pmu->name);
> +                       ps->pmu_glob =3D strdup(pmu->name);
>                 }
>         }
>         print_cb.print_start(ps);
>
>         if (argc =3D=3D 0) {
>                 if (!unit_name) {
> -                       default_ps.metrics =3D true;
> -                       default_ps.metricgroups =3D true;
> +                       ps->metrics =3D true;
> +                       ps->metricgroups =3D true;
>                 }
>                 print_events(&print_cb, ps);
>                 goto out;
> @@ -636,57 +639,57 @@ int cmd_list(int argc, const char **argv)
>                         default_ps.pmu_glob =3D old_pmu_glob;
>                 } else if (strcmp(argv[i], "hw") =3D=3D 0 ||
>                            strcmp(argv[i], "hardware") =3D=3D 0) {
> -                       char *old_event_glob =3D default_ps.event_glob;
> +                       char *old_event_glob =3D ps->event_glob;
>
> -                       default_ps.event_glob =3D strdup("legacy hardware=
");
> -                       if (!default_ps.event_glob) {
> +                       ps->event_glob =3D strdup("legacy hardware");
> +                       if (!ps->event_glob) {
>                                 ret =3D -1;
>                                 goto out;
>                         }
>                         perf_pmus__print_pmu_events(&print_cb, ps);
> -                       zfree(&default_ps.event_glob);
> -                       default_ps.event_glob =3D old_event_glob;
> +                       zfree(&ps->event_glob);
> +                       ps->event_glob =3D old_event_glob;
>                 } else if (strcmp(argv[i], "sw") =3D=3D 0 ||
>                          strcmp(argv[i], "software") =3D=3D 0) {
> -                       char *old_pmu_glob =3D default_ps.pmu_glob;
> +                       char *old_pmu_glob =3D ps->pmu_glob;
>                         static const char * const sw_globs[] =3D { "softw=
are", "tool" };
>
>                         for (size_t j =3D 0; j < ARRAY_SIZE(sw_globs); j+=
+) {
> -                               default_ps.pmu_glob =3D strdup(sw_globs[j=
]);
> -                               if (!default_ps.pmu_glob) {
> +                               ps->pmu_glob =3D strdup(sw_globs[j]);
> +                               if (!ps->pmu_glob) {
>                                         ret =3D -1;
>                                         goto out;
>                                 }
>                                 perf_pmus__print_pmu_events(&print_cb, ps=
);
> -                               zfree(&default_ps.pmu_glob);
> +                               zfree(&ps->pmu_glob);
>                         }
> -                       default_ps.pmu_glob =3D old_pmu_glob;
> +                       ps->pmu_glob =3D old_pmu_glob;
>                 } else if (strcmp(argv[i], "cache") =3D=3D 0 ||
>                            strcmp(argv[i], "hwcache") =3D=3D 0) {
> -                       char *old_event_glob =3D default_ps.event_glob;
> +                       char *old_event_glob =3D ps->event_glob;
>
> -                       default_ps.event_glob =3D strdup("legacy cache");
> -                       if (!default_ps.event_glob) {
> +                       ps->event_glob =3D strdup("legacy cache");
> +                       if (!ps->event_glob) {
>                                 ret =3D -1;
>                                 goto out;
>                         }
>                         perf_pmus__print_pmu_events(&print_cb, ps);
> -                       zfree(&default_ps.event_glob);
> -                       default_ps.event_glob =3D old_event_glob;
> +                       zfree(&ps->event_glob);
> +                       ps->event_glob =3D old_event_glob;
>                 } else if (strcmp(argv[i], "pmu") =3D=3D 0) {
> -                       default_ps.exclude_abi =3D true;
> +                       ps->exclude_abi =3D true;
>                         perf_pmus__print_pmu_events(&print_cb, ps);
> -                       default_ps.exclude_abi =3D false;
> +                       ps->exclude_abi =3D false;
>                 } else if (strcmp(argv[i], "sdt") =3D=3D 0)
>                         print_sdt_events(&print_cb, ps);
>                 else if (strcmp(argv[i], "metric") =3D=3D 0 || strcmp(arg=
v[i], "metrics") =3D=3D 0) {
> -                       default_ps.metricgroups =3D false;
> -                       default_ps.metrics =3D true;
> +                       ps->metricgroups =3D false;
> +                       ps->metrics =3D true;
>                         metricgroup__print(&print_cb, ps);
>                 } else if (strcmp(argv[i], "metricgroup") =3D=3D 0 ||
>                            strcmp(argv[i], "metricgroups") =3D=3D 0) {
> -                       default_ps.metricgroups =3D true;
> -                       default_ps.metrics =3D false;
> +                       ps->metricgroups =3D true;
> +                       ps->metrics =3D false;
>                         metricgroup__print(&print_cb, ps);
>                 }
>  #ifdef HAVE_LIBPFM
> @@ -694,40 +697,40 @@ int cmd_list(int argc, const char **argv)
>                         print_libpfm_events(&print_cb, ps);
>  #endif
>                 else if ((sep =3D strchr(argv[i], ':')) !=3D NULL) {
> -                       char *old_pmu_glob =3D default_ps.pmu_glob;
> -                       char *old_event_glob =3D default_ps.event_glob;
> +                       char *old_pmu_glob =3D ps->pmu_glob;
> +                       char *old_event_glob =3D ps->event_glob;
>
> -                       default_ps.event_glob =3D strdup(argv[i]);
> -                       if (!default_ps.event_glob) {
> +                       ps->event_glob =3D strdup(argv[i]);
> +                       if (!ps->event_glob) {
>                                 ret =3D -1;
>                                 goto out;
>                         }
>
> -                       default_ps.pmu_glob =3D strdup("tracepoint");
> -                       if (!default_ps.pmu_glob) {
> -                               zfree(&default_ps.event_glob);
> +                       ps->pmu_glob =3D strdup("tracepoint");
> +                       if (!ps->pmu_glob) {
> +                               zfree(&ps->event_glob);
>                                 ret =3D -1;
>                                 goto out;
>                         }
>                         perf_pmus__print_pmu_events(&print_cb, ps);
> -                       zfree(&default_ps.pmu_glob);
> -                       default_ps.pmu_glob =3D old_pmu_glob;
> +                       zfree(&ps->pmu_glob);
> +                       ps->pmu_glob =3D old_pmu_glob;
>                         print_sdt_events(&print_cb, ps);
> -                       default_ps.metrics =3D true;
> -                       default_ps.metricgroups =3D true;
> +                       ps->metrics =3D true;
> +                       ps->metricgroups =3D true;
>                         metricgroup__print(&print_cb, ps);
> -                       zfree(&default_ps.event_glob);
> -                       default_ps.event_glob =3D old_event_glob;
> +                       zfree(&ps->event_glob);
> +                       ps->event_glob =3D old_event_glob;
>                 } else {
>                         if (asprintf(&s, "*%s*", argv[i]) < 0) {
>                                 printf("Critical: Not enough memory! Tryi=
ng to continue...\n");
>                                 continue;
>                         }
> -                       default_ps.event_glob =3D s;
> +                       ps->event_glob =3D s;
>                         perf_pmus__print_pmu_events(&print_cb, ps);
>                         print_sdt_events(&print_cb, ps);
> -                       default_ps.metrics =3D true;
> -                       default_ps.metricgroups =3D true;
> +                       ps->metrics =3D true;
> +                       ps->metricgroups =3D true;
>                         metricgroup__print(&print_cb, ps);
>                         free(s);
>                 }
> @@ -735,12 +738,12 @@ int cmd_list(int argc, const char **argv)
>
>  out:
>         print_cb.print_end(ps);
> -       free(default_ps.pmu_glob);
> -       free(default_ps.last_topic);
> -       free(default_ps.last_metricgroups);
> -       strlist__delete(default_ps.visited_metrics);
> +       free(ps->pmu_glob);
> +       free(ps->last_topic);
> +       free(ps->last_metricgroups);
> +       strlist__delete(ps->visited_metrics);
>         if (output_path)
> -               fclose(default_ps.fp);
> +               fclose(ps->fp);
>
>         return ret;
>  }
> --
> 2.52.0.rc1.455.g30608eb744-goog
>
