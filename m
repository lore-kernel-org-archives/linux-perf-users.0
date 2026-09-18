Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE64293B75
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 20:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789764695; cv=pass; b=CEqbNQzkaB0eMxjB1LV8EfGD9Yt7gNKZonDGFXt2GXdBPHEuPX9/YZzKDTc61rQG8rg4tq+M0w8m2/OtOmuEeb6GYlOzGwNF4/PewVDJ87VsXjVAhVsPEpTJxtbHVfuPo3VBGCjIwIjoOIn9oAaJF9LFddUyYFhga9b+/ojqmZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789764695; c=relaxed/simple;
	bh=oPUSEcITDmxRVVnZlFh1ynkVhSLoo9gUmC2CuNteCi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gakuXiV0f3/5T1EfDjHZsLpG5VuV8Lb2pUDxOG/n+mum2CmmS0mC5rxwxnqx6rnQWblWFRkytwdpVRP2SwKt78PaJz1hH6zmYyWVAiDUwYTYUVLbu8sghBej0EEXDb1Ldj/72wP6ZmDjIektXkVG0w/eDgMRjVdHV9pKBbG8FYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dphuwxAq; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dphuwxAq"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53113d72966so14701cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 13:51:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789764692; cv=none;
        d=google.com; s=arc-20260327;
        b=NiyfIL1gWbWjcHScKqZKMi9J9QPqAleGsD2mBs+xctdY8E4Q3em6W4RrNWdAq2kDfo
         5YnOM5c8ype2rFEYfpw1c42swxBtZdROUNeGRueyDzjNCCBrGFqd44LV8GfehePLJyAq
         Yx+T63Jx4K0ptG24YPEerc16iha4FwwRUh8VG1xNx80Cv5/zOpUuqMVCQT7M92JuEL47
         B6iPsLEUV+uWTvf0f/hDiBvFqiI1NHX5ujV75IqwVkbFyuP8dw2QSlLi99AYQRZTo0Qa
         ZGYLroqCyiOt6DsnYb3BeBW1Y7f0EDk7AuNjQK8PQwL+vzlwxwfXt8qP44vP+pC/wXdM
         gLxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w6i3y6+YSUKkiWIngpHApgk9PhG5/Ls3K0ZM/Zs0Bxc=;
        fh=2VkySTRYMafl/TVGVcJWezpj1kCJf1Pdxzb9MizsZho=;
        b=GxAZObv/i3pIIyD/+/6hni/Eff8+oSJ668mgQ4jeW++njcwwKqtZApKqL6X33cKA+u
         BBB5hNopD9cjn8paDjQ7vvtbcr2anJ5BUlm99ycVn0lu/l51GcQubDFV0/P9TSMI8+1C
         Phb/0gU4KHp+/MUzW80v5TrGgTn3En09+fn2UEGmCzOYrCo1aUl4K5grlcfJs0OuSwZO
         BJk+TxqCVNC8RMLTftnG7kUOJtHihu0/8uu71BLq0qC2HxPYkLia2KKNT43Vx85q093A
         CdBaQPQD9FUUB3MT5tdyNEcBHC07MWYS7dpNA8XuEV/Q3JFk9Hw2WRVP4NLmcDIfg/0z
         fARg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789764692; x=1790369492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w6i3y6+YSUKkiWIngpHApgk9PhG5/Ls3K0ZM/Zs0Bxc=;
        b=dphuwxAqfdQg7ZY4Z0rW9Z/2Qsjw3ec+ns+VJWvX2LI5I5EPtMA0w1uWZhDOivG2By
         a0TFDu3JVdeV69JVmtQNd6tp1uO/Zt3w6SpCHinewW5p1JqkY2IOS5pFAD48mqDslCos
         rIMHe/Vol2SSmMU9nv5o3ZZ4HQzgY+pBnRzEIYaUSY32gk96DBdeV+znqyOgjcDSAWAy
         wkKrWRL7E8Rf/arhyIoXNsjyP7F2NpoFRSO8HUA4ZIaGZtU1CaQVqXsV6orUCHQ4DGF3
         KgKwR4W2gQTIqPcG02U3kpwiXivgwMYKj+gAx02CQ4elsGiXaVLdPqsx0h1IMNU+dj7o
         qPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789764692; x=1790369492;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w6i3y6+YSUKkiWIngpHApgk9PhG5/Ls3K0ZM/Zs0Bxc=;
        b=zsbAJqv+ljwWL1RC5ooqPEE+mF+aj6sWAfaaMMjFbyG1BWfHcqO6z2HBgIXXok/k1u
         bzI1eMoUBbQ5GbzsjWFQ4uDReRxEafJ9tpIdmhaB/wQD1rjB+j6O3tZXh4bxAJ/hHpmf
         9wMa4rGrsYhkmyTG7rOcXF4/wWqw7YKooCKtv1RR/fQhIMnnmqnol3jQvEtbvzekwKry
         +Gv2GmuF5Ite2mwpFiwbJ87d2o8GpLACech7t2fZdH88zPyCsRTPIquCW1MWjPsE56IH
         C8xlh/typ/z30UOX8mt025amWev/e7nJTas7m5arKnzf+QAU+N96aq2/3EX56fJ/FE9D
         xwvQ==
X-Forwarded-Encrypted: i=1; AKwUvBx34n0cMgXfY/chvXkphGRPwp3GrHk5elBsGpd5SBdjOyHxooxWNng779LdR62jnylkwaklu3Rn2X792hi1tYsH@vger.kernel.org
X-Gm-Message-State: AFuF++mPQ/6QEJGQjjnXTedQ3qTG5HNmVb2HQTqFOQKGP2cCXA6Fo8U1
	JnGDWsrQV/fF80NOZNvRLEL4VxAtk/pFhmgfTKxfqK5HJ+9VaxhxT7cvoORH72CLCBAFRhSpAKS
	wpQ5Q0fJzXwxyBUWa0t7uCzTFy56QPdy4RXKpVo7P
X-Gm-Gg: AYBFou2wgxTYOE/YOzrLvjIriD/Fk35I7YBiD/TBktvSWW3TyJFiWuJDiUz9WheGz+L
	tQo6PoIqlvnWBxLPknI7GeUpl83TOi5uhAiLg9QUCiO2jki6bgIzBQPqZlyvbDw7IDcwmTb4dRK
	Me6KOfSMycN1IgBjA/3pon++Kpl6YqE6C5mDhsAP0ZXBApoALiuMAsVJfNHVRqSztrNZV9ALgQF
	xMPprZhv/jmxFxpZPYa1wC0/8geoFp8dXJmWBkvsqsonrMMhZysh4c21B6xleeSQ2lnwpSHZWjT
	6zzBAEg674/u9qGtrzI1JmWc6gwXRB2lGvsvuXKVKLLqs+5oteeENzGHIqYL6oOVdTmPIfbNsX+
	hbexo4A2NfQ==
X-Received: by 2002:a05:622a:4c16:b0:532:9cd6:2184 with SMTP id
 d75a77b69052e-532af5ca677mr4850301cf.6.1789764691490; Fri, 18 Sep 2026
 13:51:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916234652.439778-1-irogers@google.com> <20260917050708.704702-1-irogers@google.com>
 <20260917050708.704702-4-irogers@google.com> <aq2fraVJUKUS2I2z@x2>
In-Reply-To: <aq2fraVJUKUS2I2z@x2>
From: Ian Rogers <irogers@google.com>
Date: Fri, 18 Sep 2026 13:51:20 -0700
X-Gm-Features: AcwNN1VjgXhyfNbvWXTw_gQDcwnlM6lE0cj7tg-BJkOnnf_9yiAi07o50S7oTUc
Message-ID: <CAP-5=fUdgV+s1sqx3HuMtyutd97oX5Snuk620dE8tABcjbCZcg@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] perf tools: Expose opt-in --hybrid-merge
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, ak@kernel.org, ak@linux.intel.com, 
	andi@firstfloor.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 1:31=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Sep 16, 2026 at 10:07:02PM -0700, Ian Rogers wrote:
> > Add --hybrid-merge to perf report and perf top. It merges the events a
> > wildcard expanded to across the core PMUs, and their histograms, so
> > that a symbol which ran on more than one kind of core is reported once
> > with the total rather than once per PMU.
> >
> > evlist__merge_hybrid() links the events and evlist__merge_hists_hybrid(=
)
> > links the histograms. There is nothing to merge on a machine with a
> > single core PMU, or when the events didn't come from a wildcard, so
> > warn in that case rather than quietly producing an unmerged report.
> >
> > Merging collapses the per-PMU entries into one set, which doesn't
> > combine with the per-level breakdown of --hierarchy, so asking for both
> > is an error.
>
> It would be interesting to have a hotkey to switch to this mode on the
> fly and back, even if it required to reset everything when doing so, but
> probably it should be possible on the -> hybrid-merge way.

In an earlier series I did this with an 'M' key. There were issues
with other state based on the unmerged evlist and race conditions
during the merge. Ultimately, the command line option was the easiest
and most correct choice. We can always add a hotkey later.

Thanks,
Ian

> - Arnaldo
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Assisted-by: Antigravity:gemini-3.1-pro
> > ---
> >  tools/perf/Documentation/perf-report.txt |  5 +++++
> >  tools/perf/Documentation/perf-top.txt    |  5 +++++
> >  tools/perf/builtin-report.c              | 19 +++++++++++++++++++
> >  tools/perf/builtin-top.c                 | 17 +++++++++++++++++
> >  tools/perf/util/symbol.c                 |  1 +
> >  5 files changed, 47 insertions(+)
> >
> > diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Docu=
mentation/perf-report.txt
> > index 1a4706329c6c..3718ebd297ce 100644
> > --- a/tools/perf/Documentation/perf-report.txt
> > +++ b/tools/perf/Documentation/perf-report.txt
> > @@ -578,6 +578,11 @@ include::itrace.txt[]
> >  --raw-trace::
> >       When displaying traceevent output, do not use print fmt or plugin=
s.
> >
> > +--hybrid-merge::
> > +     Merge matching events from all hybrid core PMUs into one
> > +     display. For example, if a wildcard expands to run on both p-core=
s and
> > +     e-cores, this aggregates them into a single view.
> > +
> >  -H::
> >  --hierarchy::
> >       Enable hierarchical output.  In the hierarchy mode, each sort key=
 groups
> > diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documen=
tation/perf-top.txt
> > index 2da2a16bbf26..c5e96da6ed82 100644
> > --- a/tools/perf/Documentation/perf-top.txt
> > +++ b/tools/perf/Documentation/perf-top.txt
> > @@ -49,6 +49,11 @@ Default is to monitor all CPUS.
> >       encoding with the layout of the event control registers as descri=
bed
> >       by entries in /sys/bus/event_source/devices/cpu/format/*.
> >
> > +--hybrid-merge::
> > +     Merge matching events from all hybrid core PMUs into one
> > +     display. For example, if a wildcard expands to run on both p-core=
s and
> > +     e-cores, this aggregates them into a single view.
> > +
> >  --filter=3D<filter>::
> >       Event filter.  This option should follow an event selector (-e). =
For
> >       syntax see linkperf:perf-record[1].
> > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > index 279e61c2366c..bda4836fc524 100644
> > --- a/tools/perf/builtin-report.c
> > +++ b/tools/perf/builtin-report.c
> > @@ -1114,6 +1114,17 @@ static int __cmd_report(struct report *rep)
> >       evlist__for_each_entry(session->evlist, pos)
> >               rep->nr_entries +=3D evsel__hists(pos)->nr_entries;
> >
> > +     if (symbol_conf.hybrid_merge) {
> > +             struct perf_env *env =3D perf_session__env(session);
> > +
> > +             if (evlist__can_merge_hybrid(session->evlist, env)) {
> > +                     evlist__merge_hybrid(session->evlist, env);
> > +                     evlist__merge_hists_hybrid(session->evlist, false=
);
> > +             } else {
> > +                     ui__warning("--hybrid-merge: no events to merge a=
cross core PMUs\n");
> > +             }
> > +     }
> > +
> >       if (use_browser =3D=3D 0) {
> >               if (verbose > 3)
> >                       perf_session__fprintf(session, stdout);
> > @@ -1449,6 +1460,8 @@ int cmd_report(int argc, const char **argv)
> >                   parse_branch_mode),
> >       OPT_BOOLEAN(0, "branch-history", &branch_call_mode,
> >                   "add last branch records to call history"),
> > +     OPT_BOOLEAN(0, "hybrid-merge", &symbol_conf.hybrid_merge,
> > +                 "merge the same event across hybrid core PMUs"),
> >       OPT_STRING(0, "objdump", &objdump_path, "path",
> >                  "objdump binary to use for disassembly and annotations=
"),
> >       OPT_STRING(0, "addr2line", &addr2line_path, "path",
> > @@ -1548,6 +1561,12 @@ int cmd_report(int argc, const char **argv)
> >               report.symbol_filter_str =3D argv[0];
> >       }
> >
> > +     if (symbol_conf.report_hierarchy && symbol_conf.hybrid_merge) {
> > +             pr_err("Error: --hierarchy and --hybrid-merge are mutuall=
y exclusive.\n");
> > +             ret =3D -EINVAL;
> > +             goto exit;
> > +     }
> > +
> >       if (disassembler_style) {
> >               annotate_opts.disassembler_style =3D strdup(disassembler_=
style);
> >               if (!annotate_opts.disassembler_style)
> > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> > index c2562d49be46..3bb3337f1244 100644
> > --- a/tools/perf/builtin-top.c
> > +++ b/tools/perf/builtin-top.c
> > @@ -1336,6 +1336,15 @@ static int __cmd_top(struct perf_top *top)
> >          if (!target__none(&opts->target))
> >               evlist__enable(top->evlist);
> >
> > +     if (symbol_conf.hybrid_merge) {
> > +             if (evlist__can_merge_hybrid(top->evlist, /*env=3D*/NULL)=
) {
> > +                     evlist__merge_hybrid(top->evlist, /*env=3D*/NULL)=
;
> > +                     evlist__merge_hists_hybrid(top->evlist, false);
> > +             } else {
> > +                     ui__warning("--hybrid-merge: no events to merge a=
cross core PMUs\n");
> > +             }
> > +     }
> > +
> >       ret =3D -1;
> >       if (pthread_create(&thread_process, NULL, process_thread, top)) {
> >               ui__error("Could not create process thread.\n");
> > @@ -1491,6 +1500,8 @@ int cmd_top(int argc, const char **argv)
> >       OPT_CALLBACK('e', "event", &parse_events_option_args, "event",
> >                    "event selector. use 'perf list' to list available e=
vents",
> >                    parse_events_option),
> > +     OPT_BOOLEAN(0, "hybrid-merge", &symbol_conf.hybrid_merge,
> > +                 "merge the same event across hybrid core PMUs"),
> >       OPT_CALLBACK(0, "filter", &top.evlist, "filter",
> >                    "event filter", parse_filter),
> >       OPT_U64('c', "count", &opts->user_interval, "event period to samp=
le"),
> > @@ -1679,6 +1690,12 @@ int cmd_top(int argc, const char **argv)
> >       if (argc)
> >               usage_with_options(top_usage, options);
> >
> > +     if (symbol_conf.report_hierarchy && symbol_conf.hybrid_merge) {
> > +             pr_err("Error: --hierarchy and --hybrid-merge are mutuall=
y exclusive.\n");
> > +             status =3D -EINVAL;
> > +             goto out_put_evlist;
> > +     }
> > +
> >       if (disassembler_style) {
> >               annotate_opts.disassembler_style =3D strdup(disassembler_=
style);
> >               if (!annotate_opts.disassembler_style) {
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index 3206929473a2..163652f071c6 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -74,6 +74,7 @@ struct symbol_conf symbol_conf =3D {
> >       .symfs                  =3D "",
> >       .symfs_layout_flat      =3D false,
> >       .event_group            =3D true,
> > +     .hybrid_merge           =3D false,
> >       .inline_name            =3D true,
> >       .res_sample             =3D 0,
> >       .addr2line_timeout_ms   =3D 5 * 1000,
> > --
> > 2.55.0.1082.g2b9226bbc0-goog
