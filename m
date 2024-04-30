Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A911D2EE
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Apr 2024 02:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714445549; cv=none; b=Z0OiWG26+rkih09GWIrUBjggLCs4hWpx9myVvKltlFjBAmwEXHK1l8TZxfd6AjecBQubhwBLQU8EEM4pJO0hAr3zvZk/BDdX8MkwNok7pS4OJABYseZEZCdbYGT4UNlbKq6tBula++NBHSAP/l6SkQ95V53nosClRmpyQ7c2p2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714445549; c=relaxed/simple;
	bh=JmzK1q0EGoSafd9C6nM4zHYa9w8NdwCmO1jsFQ/IA9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PhevbE+MAsZ4FonmMhlmuap5faAwV4+hxiDy2nvHabbnviiVK1/XVw7FDsQptOrQrBHXDlUQVyLhRogbZODUZ5NLRmVYlcyKeMLxUDT0aD3nZQJKSj8MdBsD6+lDLmyde89y/bngth91/73V9dPXQElA6v1Iu7MOenzwMy6GN84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xcptQFBg; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xcptQFBg"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43989e6ca42so114781cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Apr 2024 19:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714445547; x=1715050347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqkGLjUvwIi+WZb9DeaU3ZOZzub03nQXf8QCdwOdixw=;
        b=xcptQFBgVQhtEuYaZZ/G5vA0YIulOZa3t+m5zq40VqMmlUlpkdFaE/Y5nt0Xtyjy9s
         fsXHU4qkEWfXjeA6C7n74altcORE+zFzCeqx6/O30UPwxS9Yr6GQ3xV2/FjWDM4bg/eG
         yYerMpz1tQHQ/INTp5Dzcx5LnVfSRiznYxG+OeKSdI7CMTxmqf9pIkbcjyl3arbM0NB+
         guXBvdYmbg1GS2cLvdSDtxSP+6C8z3tAZmqJm5/Hb0a+8LSBJ0Kuev56FSKBNqbld3Uo
         nHsAP78psI1NpyTRbpG/fAsNV+nH6gTDTC1OxnNjx/721i1WkZdzfmGsPP+CZkkw5Raq
         xGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714445547; x=1715050347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqkGLjUvwIi+WZb9DeaU3ZOZzub03nQXf8QCdwOdixw=;
        b=MRj7lzJ5qZLgYjdOLIg2Dlmab3582MpB6iwImfiP4iA3ZhcFj0bqJXRQiZamdTZjKo
         g9RcfWpOUgsUYg/S8XIJUn/QUxkX5LIoFpijbJ/h75E+nb52vNvzP2CNvX5kysEFbb/V
         xN0fzS7y/Cg1wcehdoWd+1nKGXPcv+bhnqTaNLRhuvGCYHMLp/RFJGl3koyVGjMHAos6
         I9Vy1MU7KtUFIwaZiNCYpu1Wov4feKHSI0Dg12n+bErRC0qMyazq6ty6UnV+cn4TJXZv
         hAFgxXZeZh2qQh6CIncOJHCSIzgIybsrxVAJjzG0DQaGWzvXOzLyL/UWHyHPXHuU+Zm8
         DJ7g==
X-Forwarded-Encrypted: i=1; AJvYcCXq47IIKQ9ZiS5Y4TNGyvr2D3edi5MqHJNqlDozeJ45XmCmwERftjRDJktWIxA5nYhENlYjP/hUAvSDn4tBad6TXejZHudK4UUEx2uvkvhZxw==
X-Gm-Message-State: AOJu0Yx9uv94+LhcR5ILMEQog7UbYM8poczrZcdEvoENERICfgAOo0cS
	CZ7jQUTGcvSWlsJl8zXFJmv7ivyGNiVG+VOii0aaYo5ysM0iWmhxRS2ad7FOCR5ab77KN3S8Zl1
	6cX8XXxN27qi/pZvDvglI0m7wJr6pEj0mzmGx
X-Google-Smtp-Source: AGHT+IHkgFwaqmVNXxgWoRcPJejObaLzomDfvKNjI0+ZhUiWoLBiKSua4LS1YiLP9oMS4NqaFJGGVWD3V+ksq8njPAo=
X-Received: by 2002:ac8:5d88:0:b0:439:ef72:75fb with SMTP id
 d8-20020ac85d88000000b00439ef7275fbmr88618qtx.1.1714445546707; Mon, 29 Apr
 2024 19:52:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240428053616.1125891-1-irogers@google.com> <20240428053616.1125891-3-irogers@google.com>
 <CAM9d7cgcC-qO63neiCtyovC6qiAprMs=HKF66XvfiBqZrOiXXg@mail.gmail.com>
In-Reply-To: <CAM9d7cgcC-qO63neiCtyovC6qiAprMs=HKF66XvfiBqZrOiXXg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 29 Apr 2024 19:52:15 -0700
Message-ID: <CAP-5=fU13Df2HdeS6jXhViv+tJt+aF1KQ_yAaK_f-DBtuLewUg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/3] perf parse-events: Add a retirement latency modifier
To: Namhyung Kim <namhyung@kernel.org>
Cc: weilin.wang@intel.com, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Leo Yan <leo.yan@linux.dev>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Song Liu <song@kernel.org>, James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 2:08=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Sat, Apr 27, 2024 at 10:36=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Retirement latency is a separate sampled count used on newer Intel
> > CPUs.
>
> Can you please update the "event modifiers" section in the perf list
> documentation too?

Will do, currently the only users are TMA metrics.

> Also I'm curious if we have a doc for the JSON metric format.

Nope, nor a schema. It'd be worth setting it up and say using it in
the jevents.py parser. Perhaps the json format can be the same as the
`perf list -j` json output too.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/evsel.h        | 1 +
> >  tools/perf/util/parse-events.c | 2 ++
> >  tools/perf/util/parse-events.h | 1 +
> >  tools/perf/util/parse-events.l | 3 ++-
> >  4 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index 43f6fd1dcb4d..bd8e84954e34 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -98,6 +98,7 @@ struct evsel {
> >                 bool                    bpf_counter;
> >                 bool                    use_config_name;
> >                 bool                    skippable;
> > +               bool                    retire_lat;
> >                 int                     bpf_fd;
> >                 struct bpf_object       *bpf_obj;
> >                 struct list_head        config_terms;
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-eve=
nts.c
> > index 0f308b4db2b9..9c2a76ec8c99 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -1818,6 +1818,8 @@ static int parse_events__modifier_list(struct par=
se_events_state *parse_state,
> >                         evsel->weak_group =3D true;
> >                 if (mod.bpf)
> >                         evsel->bpf_counter =3D true;
> > +               if (mod.retire_lat)
> > +                       evsel->retire_lat =3D true;
> >         }
> >         return 0;
> >  }
> > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-eve=
nts.h
> > index 5695308efab9..eb94d1247dae 100644
> > --- a/tools/perf/util/parse-events.h
> > +++ b/tools/perf/util/parse-events.h
> > @@ -201,6 +201,7 @@ struct parse_events_modifier {
> >         bool hypervisor : 1;    /* 'h' */
> >         bool guest : 1;         /* 'G' */
> >         bool host : 1;          /* 'H' */
> > +       bool retire_lat : 1;    /* 'R' */
> >  };
> >
> >  int parse_events__modifier_event(struct parse_events_state *parse_stat=
e, void *loc,
> > diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-eve=
nts.l
> > index 08ea2d845dc3..85015f080240 100644
> > --- a/tools/perf/util/parse-events.l
> > +++ b/tools/perf/util/parse-events.l
> > @@ -209,6 +209,7 @@ static int modifiers(struct parse_events_state *par=
se_state, yyscan_t scanner)
> >                 CASE('W', weak);
> >                 CASE('e', exclusive);
> >                 CASE('b', bpf);
> > +               CASE('R', retire_lat);
> >                 default:
> >                         return PE_ERROR;
> >                 }
> > @@ -250,7 +251,7 @@ drv_cfg_term        [a-zA-Z0-9_\.]+(=3D[a-zA-Z0-9_*=
?\.:]+)?
> >   * If you add a modifier you need to update check_modifier().
> >   * Also, the letters in modifier_event must not be in modifier_bp.
> >   */
> > -modifier_event [ukhpPGHSDIWeb]{1,15}
> > +modifier_event [ukhpPGHSDIWebR]{1,16}
> >  modifier_bp    [rwx]{1,3}
> >  lc_type        (L1-dcache|l1-d|l1d|L1-data|L1-icache|l1-i|l1i|L1-instr=
uction|LLC|L2|dTLB|d-tlb|Data-TLB|iTLB|i-tlb|Instruction-TLB|branch|branche=
s|bpu|btb|bpc|node)
> >  lc_op_result   (load|loads|read|store|stores|write|prefetch|prefetches=
|speculative-read|speculative-load|refs|Reference|ops|access|misses|miss)
> > --
> > 2.44.0.769.g3c40516874-goog
> >
