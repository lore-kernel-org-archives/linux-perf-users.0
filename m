Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B457F1A2C12
	for <linux-perf-users@vger.kernel.org>; Sat, 18 May 2024 03:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716002347; cv=none; b=S0W24krRIzX3q0uNKyPLXTDuHkwBcaKtqSBzueF91vVZepEsluZvWfoJUHDJ5t0B8WVVTKKckJIPnBl9L5/S/NCGarWH8eT7RFgNf6H0nL8ccPPjsgmWZB/jDGTsaX5jG4HHHO079roynV6kmZFNZC1ma7muYQeQFFSzGKR9UdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716002347; c=relaxed/simple;
	bh=Ocv+GDYWhHS/bxgULcHDOIw/PRzNJWrvKo1D0YJA1Uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xhrc/jI5g7boMRCRNenonRBW+yrFrZPO4HMIdPkmIEyK43Iuyx7B6ERZV885FlOJiPLgJlBG2FNaqTAgOZ5uJReFardJe0HLQPY848S+g2l0dIHvpQq+Fnf8jL2O8WLhZ8dUSaHk3m5sIFCbRj8GepPjquGSXDB5hM+Kr6inBso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s2h/8WqV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s2h/8WqV"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ec76185c0fso11265ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 17 May 2024 20:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716002345; x=1716607145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHYZzkrrx44/dXPUrXL921LobcpW/8kNWs4R3WGJzMc=;
        b=s2h/8WqVbsfV9kBf4UteTxp1QlT4MWWW8/xtaJzz9XHN7u9a5t92S2xCzieUoK2/To
         wEP+bNT7gRgFOazPEYaGiPR2bqjBoChWRrh+PDtfozRVhx9Eecj3UzfWb3XPIDdUAr5/
         wsZJ5RufcsPsw+b9lnl4HqBG+awcB1QxRdAA3KQLDwqNZ86r9RdXuR/KAiKvxgcE4iSV
         t2C0tQsGA/AnBbJp1y6At3CspBcMyN3G6wGPv9mtNgv8elBIpP506DKMCJA3HjMlwat6
         1G4pgbengJbZNNcK/TTv2N942DfLe8RV/oZc7RVndTFGLp8A37o7t4gHuE4tM1CSS6+H
         wXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716002345; x=1716607145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHYZzkrrx44/dXPUrXL921LobcpW/8kNWs4R3WGJzMc=;
        b=GD7AvxdrXUsDIW7AOpwrgAaIDh+0itfq0vXHU6iV7R/S0QwJua/BhtjFVJyl1LXYMU
         BPrkKU5qN7oOOjByQyMJVX5qBtKLHvH95X9zsS2enik6gAEAbfGjLm9nmdoLsgY+OGdv
         FzbdlD8aKrIcYQwYLQ/pEMwUiD9rDmlMdvbnmtAI9sab6TvZMj2gmas7cdSQHf7Cs+F+
         WCeDyL6T0dd6uBlheHYeoJI6FIj5ItajW5ROXgjgMquOiRnW7kgw0roVKmHY1YC1jdif
         1eQpuS8n8BF3mhD8/9UnWs9ao7aAr7MrwyA8xdF/rictp7r/+OK09LKhF7R86XxBTMlb
         UsBw==
X-Forwarded-Encrypted: i=1; AJvYcCWhzE+v7a29P8KSvnpeu8obGsdhbVTYr9XgdGs1lXjKHIv+WWuJok20ZG84U+AswY90FF3ZZnooOaT1ZMuM00qUIrJOSG5OpFPsb+ZT4v2bXw==
X-Gm-Message-State: AOJu0YzDbOIcWYqMerJVT18yi+UQyCjhQ+ZS8KHTsQe9HhONTyGWhrm9
	6WwURxYnIV58xO8IGNywgWaveaorV57z0No6GRCtjS0m2rTFljBZxTXMrQ0f44LhJ/oI8ngkB52
	7DnPdbADCMKf7wiGLVSmrt1pJEJCYZujbl4B/
X-Google-Smtp-Source: AGHT+IH2VRWfNoITSYXL+SnnZFWWuU9ayHsXI8gmX+AENx0etU6ecQjyNqG8iyyTunQb7gTzSqD00aiLkdRpfLdQqvw=
X-Received: by 2002:a17:902:d5cd:b0:1eb:3f4f:6f02 with SMTP id
 d9443c01a7336-1f2ecbb17c1mr1076535ad.12.1716002344244; Fri, 17 May 2024
 20:19:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516222159.3710131-1-irogers@google.com> <CAM9d7chsZ3EDRYW=YEJBd7wCYRLWNqMOFt33C=ghaY_UqZvGKA@mail.gmail.com>
In-Reply-To: <CAM9d7chsZ3EDRYW=YEJBd7wCYRLWNqMOFt33C=ghaY_UqZvGKA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 17 May 2024 20:18:49 -0700
Message-ID: <CAP-5=fUdmrzuqE4FBGr46uu88Hnom6fWQPfv2ai+4Yi5p92A-w@mail.gmail.com>
Subject: Re: [PATCH v1] perf top: Make zeroing histogram on refresh the default
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Changbin Du <changbin.du@huawei.com>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 6:25=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, May 16, 2024 at 3:22=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Instead of decaying histograms over time change it so that they are
> > zero-ed on each perf top refresh. Previously the option '-z', or
> > pressing 'z' in tui mode, would enable this behavior. Decaying samples
> > is non-intuitive as it isn't how "top" works. Make zeroing on refresh
> > the default and rename the command line options from 'z' to 'Z' and
> > 'zero' to 'decay'.
>
> While it may make more sense, I'm afraid of changing the default
> behavior.  I think we can add a config option for this.

I don't think the config option would clear up the confusion. I think
zero should be the default given it matches "top". The problem is
worse with filtering as samples will decay and disappear faster when
there are more of them. We could keep a -z option that does nothing,
for the sake of command line compatibility. I don't see the -z option
documented on the wiki, or Brendan Gregg's tutorials so my guess is
that people don't know it exists (I didn't) and they aren't confused
as cycles:P without filtering looks similar with zero or with
decaying.

Thanks,
Ian

> Also instead of adding a new option, it should be able to use the
> existing --no-zero option.
>
> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/Documentation/perf-top.txt |  6 +++---
> >  tools/perf/builtin-top.c              | 23 +++++++++++++----------
> >  tools/perf/ui/browsers/hists.c        |  7 ++++---
> >  tools/perf/util/top.h                 |  2 +-
> >  4 files changed, 21 insertions(+), 17 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documen=
tation/perf-top.txt
> > index 667e5102075e..f1524cc0d409 100644
> > --- a/tools/perf/Documentation/perf-top.txt
> > +++ b/tools/perf/Documentation/perf-top.txt
> > @@ -124,9 +124,9 @@ Default is to monitor all CPUS.
> >  --verbose::
> >         Be more verbose (show counter open errors, etc).
> >
> > --z::
> > ---zero::
> > -       Zero history across display updates.
> > +-Z::
> > +--decay::
> > +       Decay rather than zero history across display updates.
> >
> >  -s::
> >  --sort::
> > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> > index e8cbbf10d361..8f06635cb7cd 100644
> > --- a/tools/perf/builtin-top.c
> > +++ b/tools/perf/builtin-top.c
> > @@ -266,10 +266,10 @@ static void perf_top__show_details(struct perf_to=
p *top)
> >         more =3D symbol__annotate_printf(&he->ms, top->sym_evsel);
> >
> >         if (top->evlist->enabled) {
> > -               if (top->zero)
> > -                       symbol__annotate_zero_histogram(symbol, top->sy=
m_evsel->core.idx);
> > -               else
> > +               if (top->decay_samples)
> >                         symbol__annotate_decay_histogram(symbol, top->s=
ym_evsel->core.idx);
> > +               else
> > +                       symbol__annotate_zero_histogram(symbol, top->sy=
m_evsel->core.idx);
> >         }
> >         if (more !=3D 0)
> >                 printf("%d lines not displayed, maybe increase display =
entries [e]\n", more);
> > @@ -292,11 +292,11 @@ static void perf_top__resort_hists(struct perf_to=
p *t)
> >                 hists__unlink(hists);
> >
> >                 if (evlist->enabled) {
> > -                       if (t->zero) {
> > -                               hists__delete_entries(hists);
> > -                       } else {
> > +                       if (t->decay_samples) {
> >                                 hists__decay_entries(hists, t->hide_use=
r_symbols,
> >                                                      t->hide_kernel_sym=
bols);
> > +                       } else {
> > +                               hists__delete_entries(hists);
> >                         }
> >                 }
> >
> > @@ -460,7 +460,9 @@ static void perf_top__print_mapped_keys(struct perf=
_top *top)
> >         fprintf(stdout,
> >                 "\t[U]     hide user symbols.               \t(%s)\n",
> >                 top->hide_user_symbols ? "yes" : "no");
> > -       fprintf(stdout, "\t[z]     toggle sample zeroing.             \=
t(%d)\n", top->zero ? 1 : 0);
> > +       fprintf(stdout,
> > +               "\t[z]     toggle sample zeroing/decaying.  \t(%s)\n",
> > +               top->decay_samples ? "decay" : "zero");
> >         fprintf(stdout, "\t[qQ]    quit.\n");
> >  }
> >
> > @@ -583,7 +585,7 @@ static bool perf_top__handle_keypress(struct perf_t=
op *top, int c)
> >                         top->hide_user_symbols =3D !top->hide_user_symb=
ols;
> >                         break;
> >                 case 'z':
> > -                       top->zero =3D !top->zero;
> > +                       top->decay_samples =3D !top->decay_samples;
> >                         break;
> >                 default:
> >                         break;
> > @@ -648,7 +650,7 @@ static void *display_thread_tui(void *arg)
> >         ret =3D evlist__tui_browse_hists(top->evlist, help, &hbt, top->=
min_percent,
> >                                        &top->session->header.env, !top-=
>record_opts.overwrite);
> >         if (ret =3D=3D K_RELOAD) {
> > -               top->zero =3D true;
> > +               top->decay_samples =3D false;
> >                 goto repeat;
> >         } else
> >                 stop_top();
> > @@ -1502,7 +1504,8 @@ int cmd_top(int argc, const char **argv)
> >                     "child tasks do not inherit counters"),
> >         OPT_STRING(0, "sym-annotate", &top.sym_filter, "symbol name",
> >                     "symbol to annotate"),
> > -       OPT_BOOLEAN('z', "zero", &top.zero, "zero history across update=
s"),
> > +       OPT_BOOLEAN('Z', "decay", &top.decay_samples,
> > +                   "decay rather than zero history across updates"),
> >         OPT_CALLBACK('F', "freq", &top.record_opts, "freq or 'max'",
> >                      "profile at this frequency",
> >                       record__parse_freq),
> > diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hi=
sts.c
> > index b7219df51236..bcc4720f8198 100644
> > --- a/tools/perf/ui/browsers/hists.c
> > +++ b/tools/perf/ui/browsers/hists.c
> > @@ -2305,8 +2305,8 @@ static int hists_browser__scnprintf_title(struct =
hist_browser *browser, char *bf
> >                                      " drop: %" PRIu64 "/%" PRIu64,
> >                                      top->drop, top->drop_total);
> >
> > -               if (top->zero)
> > -                       printed +=3D scnprintf(bf + printed, size - pri=
nted, " [z]");
> > +               if (top->decay_samples)
> > +                       printed +=3D scnprintf(bf + printed, size - pri=
nted, " [decay]");
> >
> >                 perf_top__reset_sample_counters(top);
> >         }
> > @@ -3209,9 +3209,10 @@ static int evsel__hists_browse(struct evsel *evs=
el, int nr_events, const char *h
> >                         continue;
> >                 case 'z':
> >                         if (!is_report_browser(hbt)) {
> > +                               /* Toggle between zeroing and decaying =
samples. */
> >                                 struct perf_top *top =3D hbt->arg;
> >
> > -                               top->zero =3D !top->zero;
> > +                               top->decay_samples =3D !top->decay_samp=
les;
> >                         }
> >                         continue;
> >                 case 'L':
> > diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
> > index 4c5588dbb131..b2c199925b36 100644
> > --- a/tools/perf/util/top.h
> > +++ b/tools/perf/util/top.h
> > @@ -32,7 +32,7 @@ struct perf_top {
> >         u64                guest_us_samples, guest_kernel_samples;
> >         int                print_entries, count_filter, delay_secs;
> >         int                max_stack;
> > -       bool               hide_kernel_symbols, hide_user_symbols, zero=
;
> > +       bool               hide_kernel_symbols, hide_user_symbols, deca=
y_samples;
> >  #ifdef HAVE_SLANG_SUPPORT
> >         bool               use_tui;
> >  #endif
> > --
> > 2.45.0.rc1.225.g2a3ae87e7f-goog
> >
