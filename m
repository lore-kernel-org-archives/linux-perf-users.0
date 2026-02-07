Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D3C33554C
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Feb 2026 15:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770479660; cv=pass; b=hKWd0cwPgAawfGwiV4vavH7SRYWIo3cUSwFIOEskeJKJ1ho23wTJV9uE6mIrzlxl3nQHIgZAn/lPpV8hAUCqz03yxTULJ1XlhU6Cq0U2aOnwI3+j66rnViE5Ed4go/DhgbuvN5Y+7XOxDf3QNAQdjLpSs7Jp+ewVd4QP8lfmfUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770479660; c=relaxed/simple;
	bh=tAaTM6bfbbHqfsVRChrzd5HSoUINl19Jouk+neHC0M8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XyntsxtIKj7S3HpiuyBE8a1sp3AW7oU2J6Y3fd3y2+aTblXiYlZWBZfe/h53N5ipjgXCiA6joazKJkwVl4Fhqn15P5NbHhNdPCjsgpbkUCjXa3XN6beNyZ95+AITCnd1+HVr/2SBNjPiXYFvoDsz5JMXMRqlI9RfHIeX4/ZIrbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IJnoMeij; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IJnoMeij"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1270f10a774so3280c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 07 Feb 2026 07:54:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770479660; cv=none;
        d=google.com; s=arc-20240605;
        b=b7++XOFFIrNhtyq06FgfI6Jrpw0fjNEfcGlvbHsiLdTQtIE62Yd3zNJ27Nvs546cko
         kCsUf6lLR/z+3ghTAfMliiJve9CukHSOwJwcvVJTTLU7VJMCqr58Heye9yNhxF3p31SC
         NL9Oiih9X7HOjx1SG9EvoG00mnPG8DlQ7KLBSzC79i0sSXMrzs3gnTeQ9WLByEv80HQE
         wLUiRsY2NTI9thzmCSombiXIan8umhpjJr5aNt9BJ5p+HYqo0zfuoZdO3Q1/0b1tJxZR
         Nw32gRdd/4tIKaWDr7nw9qGXmSZAF2Kgqb57hKz/vRUENnVoAJbs6nx1HUEJJ1nEEsQW
         dFeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tftdXe0F+vGLtcbMOFFzyxCX8m4gKvOrxoz3HFKENi4=;
        fh=AiR6EM2lcQvqrc4m8konQ3jbu0EkoM0yqeBX/K02lBg=;
        b=YXGrWyha7S7E6f/VX9Q5SCawZfWAMh4f2nLk3dQNGPCcPbgyQCXHwa0hTKsFxFjLy/
         QT7oq4aH1M/kRewga4Et0t4FECYQwSjgLrWYRI7eY5pW5kjCfjfwQyVuPKYunI/TgLeH
         IboAAerROGEOU2wZhnEtQ1ofiPM02THAR/x2KjoZ3L10Q9PRMI6sEoI5WioXHnpI/Ejk
         YAI4rlykHBb8sIuzwYPvVYBcClgTD3jJZywKUiFt+ry8oDZKuBVaouhORQ9Rm13g9LcP
         JWxTYx10rmcQSkfvVe5lOrtIQ/vWUN3sEQrBUDvWsd0X9iv9rqO6WfJNlRxrjRpGRMdm
         V3Zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770479660; x=1771084460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tftdXe0F+vGLtcbMOFFzyxCX8m4gKvOrxoz3HFKENi4=;
        b=IJnoMeij0dBFZJk6wnkeqPPqBbXDFbcFJodTNk9AvNF1oJIADjboBp2Gi6YyQzR/fn
         /ClI9LvgMhsdF28W+6hmetdnsIHEzLrXmVaC2kJEFUtv6Text+fTp7O7/TtA/nq6Vr4i
         9qxk7xxMoYslJj2ClMvlFC9cOlkpWufV3IvJHh3DUenvJkR+67OTkSzu6eo51Rvlmvwc
         OM150D5UAwDosQ/peQucgNxPcy/uZ0iGl5jgBjOVezmjJ9PJ+Q1H/bexJoleEtmTpYEp
         k6z3A6i2TVRlBb0ncw+YhzJ6SIsFu/OnBZ7r2cVJ8d6IcH9s6zYs6ZRrKN792ab2ehmW
         8Ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770479660; x=1771084460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tftdXe0F+vGLtcbMOFFzyxCX8m4gKvOrxoz3HFKENi4=;
        b=mLFXAPTPJONNIIYRMsrtkPKN/3pKzYxZBiFCMSUFkX1V/+p3Wo/mqrVdmXU0DagTqV
         pOTgti78Z+GB45d4/R/Mic76zplctLGwsIUnaf+159QtFLfF+CqdQ5E9Y3gpdWnmQxqE
         YN/7u0YOn4bm8k6Lzw4TlPO2vGkYrrxY8gqR1xCSSsFgS8CskC2BZFAn9jBuRac0cQNj
         58TvF1Gb8QLePkHxKWpSQbu9FgtzRBcihNuQ0OCmDi3Eb/xaNLSsgfZ3HY9zwIKdmbFU
         H+x2SoqzTyTojypBSPRa/T16OBFE4XIyyOMpKdQCdZZ9brFhiIiDUs8vMhSrWDXu5kR0
         xUBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMUO8eVveSMBFtUxY5HpG0AzDyhsfOikHWrWOLILTtlfM+sWXMzMHAhoIVTPEXFkXpKdPRugt+y4mcUJCfWU3q@vger.kernel.org
X-Gm-Message-State: AOJu0YxOqLMutrxRpjCOpEu8Eiqu2ww/D4Sbz8xUjP9ebXv9S0hngVrE
	e1BwfvQtXaGaZJftgS5vkbYEZFDvaRBORqWcEKgvFAW7FyAq3eVE1owRwkosiW8fPytMQIISOQ5
	2NMsW+wRnAncYNBIMScfgqImFTbYOdg2gPFVqjnsN
X-Gm-Gg: AZuq6aIxfqQmDqZ5vnFzx7or2EEPQLAyTLAi0KdU7OQc0xZ6OmrsRkIr0FU67hFEr6X
	ltRMpfZ826i7xoo3sLu7St7GtmX+AF7+ONPZavcJK1U/D2yC+7/HumoVSyWzhqVc2RMxryX5x8x
	tTTWK5HBofJbvKtnTA7HVf/1a2ppH5aBK3vZmp0OvbBRb6J4iDi9rBPbmfCxi2ydXb2o4H4OwnL
	2A0cCbdTr5IoU6zsgCkce2PLUoYWJm4L0SK8wjd9tqEZh5CPuNP6IZlq7MHpK6NKFyjQqyxPz5A
	MK3zkJEX
X-Received: by 2002:a05:7022:2398:b0:122:8d:4740 with SMTP id
 a92af1059eb24-1270eb772b5mr98469c88.16.1770479659039; Sat, 07 Feb 2026
 07:54:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aYZnkYqWXnKpHd3h@x1> <20260206222509.982489-1-irogers@google.com>
 <20260206222509.982489-7-irogers@google.com> <aYc1NrEYIMxKzlCF@x1>
In-Reply-To: <aYc1NrEYIMxKzlCF@x1>
From: Ian Rogers <irogers@google.com>
Date: Sat, 7 Feb 2026 07:54:05 -0800
X-Gm-Features: AZwV_Qh1rh8c5dw76M0hXZjWJzkg0kYkvWG3WyFBq5YLmSj5pYAsLGEg-AsVPHQ
Message-ID: <CAP-5=fXOasXgKRSvrA1B+Yx42egfZfLO4h1OKrB4tLCCz_o8Cg@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] perf stat: Add no-affinity flag
To: Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ak@linux.intel.com, 
	alexander.shishkin@linux.intel.com, andres@anarazel.de, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, peterz@infradead.org, 
	thomas.falcon@intel.com, tmricht@linux.ibm.com, yang.lee@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 7, 2026 at 4:51=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Fri, Feb 06, 2026 at 02:25:09PM -0800, Ian Rogers wrote:
> > Add flag that disables affinity behavior. Using sched_setaffinity to
> > place a perf thread on a CPU can avoid certain interprocessor
> > interrupts but may introduce a delay due to the scheduling,
> > particularly on loaded machines. Add a command line option to disable
> > the behavior. This behavior is less present in other tools like `perf
> > record`, as it uses a ring buffer and doesn't make repeated system
> > calls.
>
> This is confusing:
>
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ perf stat -h affinity
>
>  Usage: perf stat [<options>] [<command>]
>
>         --affinity        don't allow affinity optimizations aimed at red=
ucing IPIs
>
> =E2=AC=A2 [acme@toolbx perf-tools-next]$
>
> The way it is presented in the -h output it looks as if one has to use:
>
>         perf stat --affinity
>
> To disable affinity setting, when used that way it looks as if the user
> is asking for affinity to be used.
>
> We have things like:
>
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ grep -A2 OPT_.*no- tools/perf/bu=
iltin-record.c
>         OPT_BOOLEAN(0, "no-buffering", &record.opts.no_buffering,
>                     "collect data without buffering"),
>         OPT_BOOLEAN('R', "raw-samples", &record.opts.raw_samples,
> --
>         OPT_BOOLEAN_SET('i', "no-inherit", &record.opts.no_inherit,
>                         &record.opts.no_inherit_set,
>                         "child tasks do not inherit counters"),
> --
>         OPT_BOOLEAN(0, "no-bpf-event", &record.opts.no_bpf_event, "do not=
 record bpf events"),
>         OPT_BOOLEAN(0, "strict-freq", &record.opts.strict_freq,
>                     "Fail if the specified frequency can't be used"),
> --
>         OPT_BOOLEAN('n', "no-samples", &record.opts.no_samples,
>                     "don't sample"),
>         OPT_BOOLEAN_SET('N', "no-buildid-cache", &record.no_buildid_cache=
,
>                         &record.no_buildid_cache_set,
>                         "do not update the buildid cache"),
>         OPT_BOOLEAN_SET('B', "no-buildid", &record.no_buildid,
>                         &record.no_buildid_set,
>                         "do not collect buildids in perf.data"),
> =E2=AC=A2 [acme@toolbx perf-tools-next]$
>
> Probably this needs to be that way?

So it was that way in the v4 patch set but Namhyung asked for it to be
the other way around:
https://lore.kernel.org/lkml/aRvcuMfbDRSBU87k@google.com/
The comment on the option didn't get changed and that's a  mistake.
Let me know what's preferred and I can send a patch.

Thanks,
Ian

> - Arnaldo
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/Documentation/perf-stat.txt | 4 ++++
> >  tools/perf/builtin-stat.c              | 6 ++++++
> >  tools/perf/util/evlist.c               | 6 +-----
> >  tools/perf/util/evlist.h               | 1 +
> >  4 files changed, 12 insertions(+), 5 deletions(-)
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
> > index c1bb40b99176..8bbdea44c3ba 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -2426,6 +2426,7 @@ static int parse_tpebs_mode(const struct option *=
opt, const char *str,
> >  int cmd_stat(int argc, const char **argv)
> >  {
> >       struct opt_aggr_mode opt_mode =3D {};
> > +     bool affinity =3D true, affinity_set =3D false;
> >       struct option stat_options[] =3D {
> >               OPT_BOOLEAN('T', "transaction", &transaction_run,
> >                       "hardware transaction statistics"),
> > @@ -2554,6 +2555,8 @@ int cmd_stat(int argc, const char **argv)
> >                       "don't print 'summary' for CSV summary output"),
> >               OPT_BOOLEAN(0, "quiet", &quiet,
> >                       "don't print any output, messages or warnings (us=
eful with record)"),
> > +             OPT_BOOLEAN_SET(0, "affinity", &affinity, &affinity_set,
> > +                     "don't allow affinity optimizations aimed at redu=
cing IPIs"),
> >               OPT_CALLBACK(0, "cputype", &evsel_list, "hybrid cpu type"=
,
> >                       "Only enable events on applying cpu with this typ=
e "
> >                       "for hybrid platform (e.g. core or atom)",
> > @@ -2611,6 +2614,9 @@ int cmd_stat(int argc, const char **argv)
> >       } else
> >               stat_config.csv_sep =3D DEFAULT_SEPARATOR;
> >
> > +     if (affinity_set)
> > +             evsel_list->no_affinity =3D !affinity;
> > +
> >       if (argc && strlen(argv[0]) > 2 && strstarts("record", argv[0])) =
{
> >               argc =3D __cmd_record(stat_options, &opt_mode, argc, argv=
);
> >               if (argc < 0)
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index 45833244daf3..591bdf0b3e2a 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -369,11 +369,7 @@ static bool evlist__use_affinity(struct evlist *ev=
list)
> >       struct perf_cpu_map *used_cpus =3D NULL;
> >       bool ret =3D false;
> >
> > -     /*
> > -      * With perf record core.user_requested_cpus is usually NULL.
> > -      * Use the old method to handle this for now.
> > -      */
> > -     if (!evlist->core.user_requested_cpus ||
> > +     if (evlist->no_affinity || !evlist->core.user_requested_cpus ||
> >           cpu_map__is_dummy(evlist->core.user_requested_cpus))
> >               return false;
> >
> > diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> > index 30dff7484d3c..d17c3b57a409 100644
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
> > 2.53.0.rc2.204.g2597b5adb4-goog
> >
