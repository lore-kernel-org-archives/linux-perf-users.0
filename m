Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73BB3A1AB
	for <linux-perf-users@vger.kernel.org>; Wed,  8 May 2024 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715204250; cv=none; b=h1lWZXSRC1hz4NCgvdnaAeeI2H76c3f7zQA4GqkXPtDaUfq26JoUKwjNMn20f3leCgNktPcVEvG3168AK1ngOIpvn71sS3nekRpfMuUxS4WMuWsDc/5t77UDSojCI+l+J07OWhdWdC7ZmNcbzwkOgHmbZS00CjsIPfmYnsy8+Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715204250; c=relaxed/simple;
	bh=k+4tc+KwmnqhQyyFw7zD965SuJhq3cr3lh52uQiXmIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ngqpQe6e7PDTy2cKK1TX5Pm9QkUX1UFH3l/4S5qBMPWteMSKhuKbRlLxGIS3TtPgcIxthIrpe2JG7Xig/AlY/nZVT2mQwu7dNqx6QQjLPBMvCD72E6RqOYZk1W7vfxoI7Kum4a2wHcD0nwoRHa31wC9f1iKDsqcd4REiH8+7FLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tnOJKQ6J; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tnOJKQ6J"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43d361a2124so117851cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 May 2024 14:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715204248; x=1715809048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydDQmhBL597XUhZAhAsSoGMq2Aqb+GmiKIr8rkv69AA=;
        b=tnOJKQ6JX7AT/akWjDEQfgyfgN02JG39bMUsogOvrg1FCnIDgLBW8iFsCsUZbsjJ76
         nALNA8tIw6EleU+B3uKAOriz4h4mi7m5rg3m2izVEmbqz5oL2OCQ575mZgTTrKpO0ojY
         LoyPHvxvptVUOfA6/md+Gd5plkwM5idmPko9vAuGlwucqUy6lnwIvrMyw3hpbtCboBDl
         i2hvAvQBpejJ6st4l/nMycnxLtunV7t0aqvofJ+4tkD0XZnUexzohTiRSx9shL/oCP9Q
         +5/d+qSs0/d84HWrttXxDrklhUdWcR3s8sUrcv8l3SGP43Qe2pLW8D8S9g1vavuFYMom
         2Rsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715204248; x=1715809048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydDQmhBL597XUhZAhAsSoGMq2Aqb+GmiKIr8rkv69AA=;
        b=kvwopQegyrjjWgXN1IYe3gYkP8rPc4iCoQSIaZjyF5v8acrD8hiwnVcRtHg+QXorS5
         Xc+zoJOypO/0CtbglJh7xPcIRJaf2ctjpm782p3Hg4BstsPkBnoIg6dj88IsTY4iquJZ
         Kxs8+wQKm/6Y+2zAZdw24jDDZMfvtoY9veVl9hw9YkWhiTGC7JJ7OC6/kQck4KQ4laI6
         FlPqMU1ckcH2Q0gmexiAH9Hi5PT7tfHGFIaN4t7cXRv2nUNukDUgqKbyEeBB6oC37Cqf
         eGuTUMho9S1Sxlf6TINAk+E8I4Do0b4Lk7XsOk9ScDn461fvp7oixONjC2nIIg9j1Kzp
         BJEw==
X-Forwarded-Encrypted: i=1; AJvYcCUA8jKj+nzdwODxXKQH0ZmT+jFTH6A5FT3CRNJ5ApYMDSR2wR0T2ZjMb5YNFc6q9wqrNool0dFGN/u+Dlk8qx5brs8EpgT/Tz6+KOb3K1lBfQ==
X-Gm-Message-State: AOJu0Yxg0j9YXgz/gIUZV8YsKYe0ztDdMfQ8+7m8hlkHYgOZvqGr0yGG
	7emb9eeqlo11L3cATTaI5aMSW202a52cQmxSKHkgghm7fBtlOqBNHRr+2EFl9hAMnAZ2R3OdbBo
	NzCCoYNgewi1xoBakVq+FZ1QnGI4nsKkDOZ2K
X-Google-Smtp-Source: AGHT+IHyODFej2ggc3VFTiA+YFPclKrjBW8J8DzqpcSBbh3yZyBgiZXR3hh/wfA5Mm3leRfz8n0esXBnN2N8Iczt5OI=
X-Received: by 2002:a05:622a:53c3:b0:439:ef72:75fb with SMTP id
 d75a77b69052e-43df44da949mr267921cf.1.1715204247554; Wed, 08 May 2024
 14:37:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240505-perf_digit-v2-0-6ece307fdaad@codewreck.org> <20240505-perf_digit-v2-1-6ece307fdaad@codewreck.org>
In-Reply-To: <20240505-perf_digit-v2-1-6ece307fdaad@codewreck.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 May 2024 14:37:16 -0700
Message-ID: <CAP-5=fUmeyd3BR7njJEDQ-=qkpvLPMoQO-7De+3mqLaSOoZZxw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf parse-events: pass parse_state to add_tracepoint
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 5, 2024 at 4:14=E2=80=AFAM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> The next patch will add another flag to parse_state that we will want to
> pass to evsel__nwetp_idx(), so pass the whole parse_state all the way
> down instead of giving only the index

Nit: evsel__newtp_idx typo
Fwiw, I think the idx value is possibly something to be done away
with. We renumber the evsels here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/parse-events.c?h=3Dperf-tools-next#n2077

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Originally-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
>  tools/perf/util/parse-events.c | 31 ++++++++++++++++++-------------
>  tools/perf/util/parse-events.h |  3 ++-
>  tools/perf/util/parse-events.y |  2 +-
>  3 files changed, 21 insertions(+), 15 deletions(-)
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index 6f8b0fa17689..6e8cba03f0ac 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -519,13 +519,14 @@ static void tracepoint_error(struct parse_events_er=
ror *e, int err,
>         parse_events_error__handle(e, column, strdup(str), strdup(help));
>  }
>
> -static int add_tracepoint(struct list_head *list, int *idx,
> +static int add_tracepoint(struct parse_events_state *parse_state,
> +                         struct list_head *list,
>                           const char *sys_name, const char *evt_name,
>                           struct parse_events_error *err,
>                           struct parse_events_terms *head_config, void *l=
oc_)
>  {
>         YYLTYPE *loc =3D loc_;
> -       struct evsel *evsel =3D evsel__newtp_idx(sys_name, evt_name, (*id=
x)++);
> +       struct evsel *evsel =3D evsel__newtp_idx(sys_name, evt_name, pars=
e_state->idx++);
>
>         if (IS_ERR(evsel)) {
>                 tracepoint_error(err, PTR_ERR(evsel), sys_name, evt_name,=
 loc->first_column);
> @@ -544,7 +545,8 @@ static int add_tracepoint(struct list_head *list, int=
 *idx,
>         return 0;
>  }
>
> -static int add_tracepoint_multi_event(struct list_head *list, int *idx,
> +static int add_tracepoint_multi_event(struct parse_events_state *parse_s=
tate,
> +                                     struct list_head *list,
>                                       const char *sys_name, const char *e=
vt_name,
>                                       struct parse_events_error *err,
>                                       struct parse_events_terms *head_con=
fig, YYLTYPE *loc)
> @@ -578,7 +580,7 @@ static int add_tracepoint_multi_event(struct list_hea=
d *list, int *idx,
>
>                 found++;
>
> -               ret =3D add_tracepoint(list, idx, sys_name, evt_ent->d_na=
me,
> +               ret =3D add_tracepoint(parse_state, list, sys_name, evt_e=
nt->d_name,
>                                      err, head_config, loc);
>         }
>
> @@ -592,19 +594,21 @@ static int add_tracepoint_multi_event(struct list_h=
ead *list, int *idx,
>         return ret;
>  }
>
> -static int add_tracepoint_event(struct list_head *list, int *idx,
> +static int add_tracepoint_event(struct parse_events_state *parse_state,
> +                               struct list_head *list,
>                                 const char *sys_name, const char *evt_nam=
e,
>                                 struct parse_events_error *err,
>                                 struct parse_events_terms *head_config, Y=
YLTYPE *loc)
>  {
>         return strpbrk(evt_name, "*?") ?
> -               add_tracepoint_multi_event(list, idx, sys_name, evt_name,
> +               add_tracepoint_multi_event(parse_state, list, sys_name, e=
vt_name,
>                                            err, head_config, loc) :
> -               add_tracepoint(list, idx, sys_name, evt_name,
> +               add_tracepoint(parse_state, list, sys_name, evt_name,
>                                err, head_config, loc);
>  }
>
> -static int add_tracepoint_multi_sys(struct list_head *list, int *idx,
> +static int add_tracepoint_multi_sys(struct parse_events_state *parse_sta=
te,
> +                                   struct list_head *list,
>                                     const char *sys_name, const char *evt=
_name,
>                                     struct parse_events_error *err,
>                                     struct parse_events_terms *head_confi=
g, YYLTYPE *loc)
> @@ -630,7 +634,7 @@ static int add_tracepoint_multi_sys(struct list_head =
*list, int *idx,
>                 if (!strglobmatch(events_ent->d_name, sys_name))
>                         continue;
>
> -               ret =3D add_tracepoint_event(list, idx, events_ent->d_nam=
e,
> +               ret =3D add_tracepoint_event(parse_state, list, events_en=
t->d_name,
>                                            evt_name, err, head_config, lo=
c);
>         }
>
> @@ -1266,7 +1270,8 @@ static int get_config_chgs(struct perf_pmu *pmu, st=
ruct parse_events_terms *head
>         return 0;
>  }
>
> -int parse_events_add_tracepoint(struct list_head *list, int *idx,
> +int parse_events_add_tracepoint(struct parse_events_state *parse_state,
> +                               struct list_head *list,
>                                 const char *sys, const char *event,
>                                 struct parse_events_error *err,
>                                 struct parse_events_terms *head_config, v=
oid *loc_)
> @@ -1282,14 +1287,14 @@ int parse_events_add_tracepoint(struct list_head =
*list, int *idx,
>         }
>
>         if (strpbrk(sys, "*?"))
> -               return add_tracepoint_multi_sys(list, idx, sys, event,
> +               return add_tracepoint_multi_sys(parse_state, list, sys, e=
vent,
>                                                 err, head_config, loc);
>         else
> -               return add_tracepoint_event(list, idx, sys, event,
> +               return add_tracepoint_event(parse_state, list, sys, event=
,
>                                             err, head_config, loc);
>  #else
> +       (void)parse_state;
>         (void)list;
> -       (void)idx;
>         (void)sys;
>         (void)event;
>         (void)head_config;
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-event=
s.h
> index 809359e8544e..fd55a154ceff 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -189,7 +189,8 @@ int parse_events_terms__to_strbuf(const struct parse_=
events_terms *terms, struct
>  int parse_events__modifier_event(struct list_head *list, char *str, bool=
 add);
>  int parse_events__modifier_group(struct list_head *list, char *event_mod=
);
>  int parse_events_name(struct list_head *list, const char *name);
> -int parse_events_add_tracepoint(struct list_head *list, int *idx,
> +int parse_events_add_tracepoint(struct parse_events_state *parse_state,
> +                               struct list_head *list,
>                                 const char *sys, const char *event,
>                                 struct parse_events_error *error,
>                                 struct parse_events_terms *head_config, v=
oid *loc);
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-event=
s.y
> index d70f5d84af92..0bab4263f8e3 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -537,7 +537,7 @@ tracepoint_name opt_event_config
>         if (!list)
>                 YYNOMEM;
>
> -       err =3D parse_events_add_tracepoint(list, &parse_state->idx, $1.s=
ys, $1.event,
> +       err =3D parse_events_add_tracepoint(parse_state, list, $1.sys, $1=
.event,
>                                         error, $2, &@1);
>
>         parse_events_terms__delete($2);
>
> --
> 2.44.0
>
