Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE5C1F5846
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Nov 2024 20:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730752622; cv=none; b=EH+A3x4spEo4/87lHFtnZ2+Pm7guOX3fGO/B3FDmxHdBj/FGZxDaEtX/4KfrcjJw8rzvq0BDMwKimrWCARR+7gXJzVfM6Ilme3kTagjwjxPH+q0K/tFXFgq7nAXx/e1suiJgqNV30gkSqu5CU/ivNZnOs5yqvc7fdHV2T+pVs9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730752622; c=relaxed/simple;
	bh=4nBRmUtbA108cfLj2oSnAsY8P82ZupaRNwnNsR+3/5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIb+ib8WgQoIqtl9hHjC0j+PzyiPfvHTVS3MGXx0avYuS8Dz90JSKgfdwonLaxS2iw2L5jz4ONcnof9HoyRM81mymPHvedsvjA8ph6Y0wlwnAmoTagI+IJF8C4nMZsj3Nw9Fh734wRheDnxFSiGYR7+3F+JfECgpaLYxszEwlsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sjFO3h9C; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sjFO3h9C"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so1995ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Nov 2024 12:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730752619; x=1731357419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjVDRx6oH+xeW6jQUK0g6WGli8hpIwXPydX3YYIiQho=;
        b=sjFO3h9C7KSRCegTLvegsh3crfCEKRTKKwRus67oxBcpkeXH6EZf0tC5Kh1MmcRb7E
         msju2noJhhfVkKXf3nAKfQFN1cmJjX2fBn5mtkr00HUOSpWry81lStqWvkamzyqUMI+X
         ckSWUyHARLYy2/KNo3/gGni+ccdnLI/qIxJsLccJy8SWAYbxZNXyslud4+FKwlCN8JNM
         LwLCGbg9+E+IOFI32P+MQwKVhsTow0NbYrJaWjuTut4xVqcYr6CtZthbb4ktei4Z1jlE
         pI0V974ncjNVsssOBJ2DlLghhoRe4ec5DJ2EdNs5ni4su5wRwGH1aNINe5FxHxdAu1Tz
         /nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730752619; x=1731357419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjVDRx6oH+xeW6jQUK0g6WGli8hpIwXPydX3YYIiQho=;
        b=dw/eWFGRlAaHM1bkzo50Lf06t6nE8ZeD+0/ke/TcbF/va5FuUntmL2ZBJmX2d2wJCN
         m9aQ7ngxLTXqj2y6OHE/GsUxhLRYLi3LTPmncm2U/f1/62MmCL1Io9Fj1SvAx4oYaHwQ
         gDX9nvEfwMDIkcACz8mZEe/VZXlqvs9imQwfzpDGi1gu8vCoZ3X0anzL7Jpv60o9gTVh
         lk931apOwi3JsEcDKQlFPFzwA+cDOzOgvibadUTVBSdqD1huqInmnYv7r9xiz+DsHsmx
         ulgMUrutWsc5dfpB4BzhNUvElrNgou05YqS5XufzSijYCTc39OD3JhZ3D/HFYnS2Te/5
         tc9g==
X-Forwarded-Encrypted: i=1; AJvYcCV0ltMWcoF+c5aDQtkl2IKq7x42/sVzx7JO0K364SM3BF1cCFxCsge2/3ug+zs6MRJW+RtrcdngH1sHo0oHLX1a@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn/LMy39puMRY+tq5KKTAAYAUDf0LyTaB3u443LMM/cW8iuq1C
	jnbEBfRvsCB47PeDW5qb4MdPoI6vVTo52/FymRRaI61HGAavYmiEBekkpCADdYCvHQc6KB3I4Qz
	5paGmppp9iJSlKHunTRb9t8Pr0BdbUCZX4pKT
X-Gm-Gg: ASbGncu0ueTsG9NvsVejt7C+MF5l984WGjT/BaEeQeXmuI+lpA3b1E2rd43vSamDfbJ
	/IMs61Oc5CLf6Rhe96iIUaHRrKacQC4mFoBwq7O6X4YV9syFZMsfitvQckR2+LA==
X-Google-Smtp-Source: AGHT+IESkicvZoSSZrcJAJpL2CY40Vg5qDWTWVmcUyR/sBcGeJfCyGZQrc40LU+36/ln0l+5dHy3kQgKyy9BNSbN0Bg=
X-Received: by 2002:a05:6e02:12b4:b0:3a6:b318:3b99 with SMTP id
 e9e14a558f8ab-3a6daa9e751mr627685ab.27.1730752619348; Mon, 04 Nov 2024
 12:36:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241103142302.230370-1-linux@treblig.org>
In-Reply-To: <20241103142302.230370-1-linux@treblig.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Nov 2024 12:36:48 -0800
Message-ID: <CAP-5=fXNJ_QbEA20eusx7EDqp=pQgVdW_+-w1T=vsrzH4BGjpw@mail.gmail.com>
Subject: Re: [PATCH] perf: event: Remove deadcode
To: linux@treblig.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 3, 2024 at 6:23=E2=80=AFAM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> event_format__print() last use was removed by 2017's
> commit 894f3f1732cb ("perf script: Use event_format__fprintf()")
>
> evlist__find_tracepoint_by_id() last use was removed by 2012's
> commit e60fc847cefa ("perf evlist: Remove some unused methods")
>
> evlist__set_tp_filter_pid() last use was removed by 2017's
> commit dd1a50377c92 ("perf trace: Introduce filter_loop_pids()")
>
> Remove them.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/evlist.c            | 18 ------------------
>  tools/perf/util/evlist.h            |  2 --
>  tools/perf/util/trace-event-parse.c |  6 ------
>  tools/perf/util/trace-event.h       |  3 ---
>  4 files changed, 29 deletions(-)
>
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index f14b7e6ff1dc..4b992a3f2985 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -362,19 +362,6 @@ __weak int arch_evlist__add_default_attrs(struct evl=
ist *evlist,
>         return __evlist__add_default_attrs(evlist, attrs, nr_attrs);
>  }
>
> -struct evsel *evlist__find_tracepoint_by_id(struct evlist *evlist, int i=
d)
> -{
> -       struct evsel *evsel;
> -
> -       evlist__for_each_entry(evlist, evsel) {
> -               if (evsel->core.attr.type   =3D=3D PERF_TYPE_TRACEPOINT &=
&
> -                   (int)evsel->core.attr.config =3D=3D id)
> -                       return evsel;
> -       }
> -
> -       return NULL;
> -}
> -
>  struct evsel *evlist__find_tracepoint_by_name(struct evlist *evlist, con=
st char *name)
>  {
>         struct evsel *evsel;
> @@ -1199,11 +1186,6 @@ int evlist__set_tp_filter_pids(struct evlist *evli=
st, size_t npids, pid_t *pids)
>         return ret;
>  }
>
> -int evlist__set_tp_filter_pid(struct evlist *evlist, pid_t pid)
> -{
> -       return evlist__set_tp_filter_pids(evlist, 1, &pid);
> -}
> -
>  int evlist__append_tp_filter_pids(struct evlist *evlist, size_t npids, p=
id_t *pids)
>  {
>         char *filter =3D asprintf__tp_filter_pids(npids, pids);
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index bcc1c6984bb5..ff73908e2178 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -144,7 +144,6 @@ int __evlist__set_tracepoints_handlers(struct evlist =
*evlist,
>         __evlist__set_tracepoints_handlers(evlist, array, ARRAY_SIZE(arra=
y))
>
>  int evlist__set_tp_filter(struct evlist *evlist, const char *filter);
> -int evlist__set_tp_filter_pid(struct evlist *evlist, pid_t pid);
>  int evlist__set_tp_filter_pids(struct evlist *evlist, size_t npids, pid_=
t *pids);
>
>  int evlist__append_tp_filter(struct evlist *evlist, const char *filter);
> @@ -152,7 +151,6 @@ int evlist__append_tp_filter(struct evlist *evlist, c=
onst char *filter);
>  int evlist__append_tp_filter_pid(struct evlist *evlist, pid_t pid);
>  int evlist__append_tp_filter_pids(struct evlist *evlist, size_t npids, p=
id_t *pids);
>
> -struct evsel *evlist__find_tracepoint_by_id(struct evlist *evlist, int i=
d);
>  struct evsel *evlist__find_tracepoint_by_name(struct evlist *evlist, con=
st char *name);
>
>  int evlist__add_pollfd(struct evlist *evlist, int fd);
> diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-=
event-parse.c
> index f0332bd3a501..d97830cdbd7e 100644
> --- a/tools/perf/util/trace-event-parse.c
> +++ b/tools/perf/util/trace-event-parse.c
> @@ -116,12 +116,6 @@ void event_format__fprintf(struct tep_event *event,
>         trace_seq_destroy(&s);
>  }
>
> -void event_format__print(struct tep_event *event,
> -                        int cpu, void *data, int size)
> -{
> -       return event_format__fprintf(event, cpu, data, size, stdout);
> -}
> -
>  /*
>   * prev_state is of size long, which is 32 bits on 32 bit architectures.
>   * As it needs to have the same bits for both 32 bit and 64 bit architec=
tures
> diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.=
h
> index bbf8b26bc8da..0e5133f1b910 100644
> --- a/tools/perf/util/trace-event.h
> +++ b/tools/perf/util/trace-event.h
> @@ -42,9 +42,6 @@ struct tep_event *trace_event__tp_format_id(int id);
>  void event_format__fprintf(struct tep_event *event,
>                            int cpu, void *data, int size, FILE *fp);
>
> -void event_format__print(struct tep_event *event,
> -                        int cpu, void *data, int size);
> -
>  int parse_ftrace_file(struct tep_handle *pevent, char *buf, unsigned lon=
g size);
>  int parse_event_file(struct tep_handle *pevent,
>                      char *buf, unsigned long size, char *sys);
> --
> 2.47.0
>
