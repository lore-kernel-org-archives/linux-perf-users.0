Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBE12750FA
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Nov 2025 04:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763440355; cv=none; b=GqNaGq62ptOxkuXdnXcTv3ft9dbp0J6pIAHkWhccS6TPzxNwFgTeUTj8XaGSDqpNOKy0he89+ZWHzCxK76FJapSNwhjzo8Jhvz3nSKUxlLg6thN+EF8QYzPdSMNoOOn0caLf5ymt+0T8iyqiaT06zejoJxuJpaPewwCyN54Jvg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763440355; c=relaxed/simple;
	bh=s0ECH57gJSHoleidcluuVdLE0N/71mLtvAYe8K6JsC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8aJfYHm6BkXQXpvb6e8lf8i4qSCWyR1aeAB1gF95nvlFEEnDIRpg7fk8JPqCPCXdqC7ozuNwHc5FkKSnEnC6twkqY/e1THNOZ49TPF4NDwj6x2xQLdvuE79N2U5IuZ1OEMIBBtt6kWcGH17HqeavHUgfBx8FZ+Z5lcUf6/jjgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OT8NGTHO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OT8NGTHO"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29852dafa7dso86265ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Nov 2025 20:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763440352; x=1764045152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaO0DovpeXvUyZaRuSr4ykrqTjG1wD9UTWW1EXE+bRU=;
        b=OT8NGTHOltBmAKfoXYqer0EKGXEM3xqCJtAdn8cEY18sqR75xh9T38CDThe6D85bYr
         PyDAzgqXDRM/OgTKDYPqHpYvLSGL97r1j8S28UVLdNLPMNEoB+JPeCTsjD0TYIByNULX
         3TYVQVcOTwhkwQ6dnb5fSd+3YxnpgRnNAK/PfvbJPSWTYnjRTD+GZ0t92ZtmkLQreoyr
         x7WyazyDZ3dbDsAW39wYzkJ2TulXyoR+948F0OgAAOEYbxg6widr8kEVXlU36eA4XbxQ
         gKdhfbcIeaBKdswiJNCNJgDonARUFuPHZJy3r689RcUde6yJyz61GZGzr0+vQPK47fz1
         wQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763440352; x=1764045152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EaO0DovpeXvUyZaRuSr4ykrqTjG1wD9UTWW1EXE+bRU=;
        b=SZyoDNwMA4thbXFgzr80MrhLQCqAU/itN2fkzOeETcATcpJM5zhTfwvA8mYeDVXg/6
         bK/BYtyHoQZtaLurb6uPWo3CplpfjXUXF4kRD0/uqCe5dgTPpH4usL1FiC4yDVmxWt2T
         qNAR5w9iPbeb+Uu/E38Bkf9H398Tx4cm5kC/6uWhRGNaBfIKtdm7UE/zDrhc0PcDirSm
         f8UzSYgob9KSUSZvX9nQ5Thr0yZqbHgilpCR9YiYdDGAj78viiZ3AfhPEPc/zUhZm6Zm
         gkWNyoy0iENqxpIaa3hQJ7ga3IveR1kT4tiJAoKnpq837rJ5D90GU2U/J+zB+A9PozlJ
         rQEw==
X-Forwarded-Encrypted: i=1; AJvYcCWl88x6xDx7K0fVs8i4wf8tCAd1++INUBgQCCMJaN98YqO20tsl/d2bQDy16/JfeHA+ezuIvP9LmzxqOjO9CcUi@vger.kernel.org
X-Gm-Message-State: AOJu0YxV212iOMV0umySUD8FAmlBJRz6I/PJeG1noR62iPNDeaEGM5PX
	oIMHG8lnj8NrGsD1rN3rH8x3/8Qjg2Zt6uAXoSo1jel90OFXJ9QLqNRJPxZxdNhYfnSxXOTSQls
	4QYjedgE543z2L7vYGGAHkz/6MkXqzK8gc952XR2w
X-Gm-Gg: ASbGncskN5auLSqdjRGzpJTNkNCSQtQg7WV5wSucZti4enU4GSXseYi7O+ZDEQFIVfJ
	hRCsGa6LlwEVuQHrxDxJJL1io/nfzkdWELqwfDMarbwqsNeAGbp3LEEyF0lF2zO5ikwEQ2oxsxC
	+mmuSX43uJFFhqDLcvRMUHKTInO+6EpaJxfyQylEbd3GFrKkW+AQVPCIGcNx5XGjfMHv8611awu
	Edk6Bxb7u1aFox546jzk9a07/4dSyXB3mOU8/pf8vRfg2vsmlIklsvW2DHuY/Z+/qaNUG0x
X-Google-Smtp-Source: AGHT+IGYy1J8K/+Sj+Sb3KiqjVN3HfkExZBv+DY64dx03YgIpZsLlmq8Bmzssxwh89joUsImWDfoQk6hH7Nx7rympvA=
X-Received: by 2002:a17:903:2309:b0:294:f745:fe7b with SMTP id
 d9443c01a7336-299f6682e46mr1962825ad.6.1763440351321; Mon, 17 Nov 2025
 20:32:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113180517.44096-1-irogers@google.com> <20251113180517.44096-11-irogers@google.com>
 <aRvcuMfbDRSBU87k@google.com>
In-Reply-To: <aRvcuMfbDRSBU87k@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Nov 2025 20:32:20 -0800
X-Gm-Features: AWmQ_bmZLNfFcANOjoFlHLvOHNQFzGrK-ZJSx-DBk-u7-_tN3dj64ESZsVJwnig
Message-ID: <CAP-5=fUF_GQKiBoKVx-z5SUZsmHdqhxzdD39iH9O=53xg2EuHQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] perf stat: Add no-affinity flag
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 6:41=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Nov 13, 2025 at 10:05:16AM -0800, Ian Rogers wrote:
> > Add flag that disables affinity behavior. Using sched_setaffinity to
> > place a perf thread on a CPU can avoid certain interprocessor
> > interrupts but may introduce a delay due to the scheduling,
> > particularly on loaded machines. Add a command line option to disable
> > the behavior. This behavior is less present in other tools like `perf
> > record`, as it uses a ring buffer and doesn't make repeated system
> > calls.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/Documentation/perf-stat.txt | 4 ++++
> >  tools/perf/builtin-stat.c              | 6 ++++++
> >  tools/perf/util/evlist.c               | 2 +-
> >  tools/perf/util/evlist.h               | 1 +
> >  4 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Docume=
ntation/perf-stat.txt
> > index 1a766d4a2233..1ffb510606af 100644
> > --- a/tools/perf/Documentation/perf-stat.txt
> > +++ b/tools/perf/Documentation/perf-stat.txt
> > @@ -382,6 +382,10 @@ color the metric's computed value.
> >  Don't print output, warnings or messages. This is useful with perf sta=
t
> >  record below to only write data to the perf.data file.
> >
> > +--no-affinity::
> > +Don't change scheduler affinities when iterating over CPUs. Disables
> > +an optimization aimed at minimizing interprocessor interrupts.
> > +
> >  STAT RECORD
> >  -----------
> >  Stores stat data into perf data file.
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index aec93b91fd11..fa42b08bd1df 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -2415,6 +2415,7 @@ static int parse_tpebs_mode(const struct option *=
opt, const char *str,
> >  int cmd_stat(int argc, const char **argv)
> >  {
> >       struct opt_aggr_mode opt_mode =3D {};
> > +     bool no_affinity =3D false;
> >       struct option stat_options[] =3D {
> >               OPT_BOOLEAN('T', "transaction", &transaction_run,
> >                       "hardware transaction statistics"),
> > @@ -2543,6 +2544,8 @@ int cmd_stat(int argc, const char **argv)
> >                       "don't print 'summary' for CSV summary output"),
> >               OPT_BOOLEAN(0, "quiet", &quiet,
> >                       "don't print any output, messages or warnings (us=
eful with record)"),
> > +             OPT_BOOLEAN(0, "no-affinity", &no_affinity,
> > +                     "don't allow affinity optimizations aimed at redu=
cing IPIs"),
>
> I know you want to add an option to disable the behaivor, but I think
> it'd better to have a positive option like just '--affinity'.  Then we
> will have '--no-affinity' for free. :)  The current form will allow
> '--no-no-affinity'.
>
> Then the variable also can be 'enable_affinity' or so.
>
> You can mention --no-affinity in the help message and the man page
> document so that users can discover the intention.

I was trying to keep the code the same as the flag. I don't want to
have an affinity flag you need to set to true in say evlist, as that
will need updating in all users of the evlist or become a behavioral
change. We can have the evlist with no_affinity and invert the flag,
it just looks awkward imo.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> >               OPT_CALLBACK(0, "cputype", &evsel_list, "hybrid cpu type"=
,
> >                       "Only enable events on applying cpu with this typ=
e "
> >                       "for hybrid platform (e.g. core or atom)",
> > @@ -2600,6 +2603,9 @@ int cmd_stat(int argc, const char **argv)
> >       } else
> >               stat_config.csv_sep =3D DEFAULT_SEPARATOR;
> >
> > +     if (no_affinity)
> > +             evsel_list->no_affinity =3D true;
> > +
> >       if (argc && strlen(argv[0]) > 2 && strstarts("record", argv[0])) =
{
> >               argc =3D __cmd_record(stat_options, &opt_mode, argc, argv=
);
> >               if (argc < 0)
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index fc3dae7cdfca..53c8e974de8b 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -368,7 +368,7 @@ static bool evlist__use_affinity(struct evlist *evl=
ist)
> >       struct perf_cpu_map *used_cpus =3D NULL;
> >       bool ret =3D false;
> >
> > -     if (!evlist->core.user_requested_cpus ||
> > +     if (evlist->no_affinity || !evlist->core.user_requested_cpus ||
> >           cpu_map__is_dummy(evlist->core.user_requested_cpus))
> >               return false;
> >
> > diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> > index b4604c3f03d6..c7ba0e0b2219 100644
> > --- a/tools/perf/util/evlist.h
> > +++ b/tools/perf/util/evlist.h
> > @@ -59,6 +59,7 @@ struct event_enable_timer;
> >  struct evlist {
> >       struct perf_evlist core;
> >       bool             enabled;
> > +     bool             no_affinity;
> >       int              id_pos;
> >       int              is_pos;
> >       int              nr_br_cntr;
> > --
> > 2.51.2.1041.gc1ab5b90ca-goog
> >
