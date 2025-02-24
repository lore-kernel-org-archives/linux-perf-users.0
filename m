Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD1D266184
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Feb 2025 18:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423038; cv=none; b=uzdn36NBu04NhMXFZ+geaDTJ3+ISxfeIJrRRK7nVDxakK6L4bozDeq/isDCgpK6pDqnl6jdpHXc2xJ87Y/1H2TgKwtB7Tbh8FMV57gvYP+lAmVCTiWCU+JQjfbfJSWKFoNrb7Y+CvNur/YYWyWQ0FttGvDng+XvCxNJZThPNOho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423038; c=relaxed/simple;
	bh=5CaLqSIq4mCnOOx0MhA6jcrVXhqB1DEJiNOTtn0cTGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ruzgTEe8i9OnI/i8XGxsik40+Sk2com8BKcSvNNnI3ogFDnVJg3jrCbwmhPZd8QLZ61OEx+ZXjByq2D7VE9WWVt3wokSEV3mApux/wF2PXAArd65KTFL6jTJP9XKahDBZbgJt0CZ+LH8cNgYAeuRPe9G4f0f88t6u6VJiK42HgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VxdP2LC4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VxdP2LC4"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22117c396baso20395ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Feb 2025 10:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740423036; x=1741027836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9zPz9Dl0COcxVGhQTNW8N2OAhun/SnyUt3wbyp6XG8=;
        b=VxdP2LC4bPJvxzeCXZ7n/ytoFv3tkVu6JsgyKBecDU7y+/6G5xIOtptJWTie4QruEu
         3miA30qoTNStdflA3D1YwtHXOg4Y+VxASYBXqUQeKxVoNAdfKX9XZqqhycXWL/6e57Fz
         eqS7eWsATQGlfKkPJRuvAdIUnLkHKte5hX0fFTrJEpIWb1/nVPa0LK1L6+iEF0N9iLsV
         UHpwUvGyAda6Su0Q1LGR5HErczHijtOCzw4SICS3m2QThHBiLbXtURlhntmQztqFqNUl
         cbxXWfQ/sn/8yVRp2J0Q+ZRVm64l6aUlpPXY4jR4273KE9n8B6jx+VvNDHhGFZaStCrI
         dZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740423036; x=1741027836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9zPz9Dl0COcxVGhQTNW8N2OAhun/SnyUt3wbyp6XG8=;
        b=MJ6+9voadRzp01MXuPWXqojL2aJMS45Kf+iRY4/IYxToWxUg9wdG0NrOngAJQ9Xm69
         Bp2zh0ue0blak+i5HgYunoH2HP0yFrRRHKQfj2we+H21YbWdVJgCZwtrdCd1B17sRoWd
         pMRcgq6MScgynFllzsGUar2tRgaAA3WkYOqUD8UL2pV4UZnLkg0p4cNkQ1Z5hDBaalxd
         DSVTpBuEiGMgm/NlAQjWHLuKRvKl2T+O295S814cltYrQd9P74COvL/NWlJbjYWql2Q1
         TIUAgn2uLT944kKevxX/jaLTIY2xlZD0jwzzYf3TkN+Ec5HghA3tj3YDvkyctbzYIvpw
         vJ/A==
X-Forwarded-Encrypted: i=1; AJvYcCW3tuWZPzG5J4e9y9kxDuTsUbUnAzYlw1+OLnsZloP1AGo46wg88/IIYYWIHa7IW1XR3SXp/vONNM46pQYGXXwC@vger.kernel.org
X-Gm-Message-State: AOJu0YwMudpwTMjCaFna7h86lhbPikzud2nDee8HrqTO1Pxn5YzfHEsV
	0ugSp2g/9J11kGVg6b0t5TGqga3zzTx+gKq6JXnczhEMNYyjxRoSu12u3bFwXhTkKE78cJcZd9i
	0dRJKvhDj04Yl65aHu0Sh8kKCEft8TzWPuKhE
X-Gm-Gg: ASbGncv8BbI5FGds+RNjeqmap79cLYTb4TlFz8gFulY6UKbjewmM4pFDHQhUWFhod7X
	Ks5x10M0Mweca/Z6VU9nb8qbVAOegTLKIH+X3n2+i3LCUXA5Y2jmGR8bBUGOe07+/DPG6Navkr5
	aa0NofE86+s5TrjIQ/Oaer+xg4wCjznd8mcN0=
X-Google-Smtp-Source: AGHT+IF4iy7Cr6LyEEeDuwD4QeXjKkepRemJp0RPuKz+bUm+oM1sBypRaykIARZw7zxRPsFInMQ7EtobdxMm+8z6kEQ=
X-Received: by 2002:a17:903:22ce:b0:212:26e:1b46 with SMTP id
 d9443c01a7336-22307a9740cmr453145ad.23.1740423035520; Mon, 24 Feb 2025
 10:50:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627200353.1230407-1-namhyung@kernel.org> <CAP-5=fWSpM7NL7UjXZBN8WHNAE7hGe1ghQ6_DqFe2VjTCGoA7A@mail.gmail.com>
 <CAM9d7cibrW=K=GZB_zsURB1Ff6Eok7qy3rVt83VVM6pVhv+Agg@mail.gmail.com>
In-Reply-To: <CAM9d7cibrW=K=GZB_zsURB1Ff6Eok7qy3rVt83VVM6pVhv+Agg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 24 Feb 2025 10:50:24 -0800
X-Gm-Features: AWEUYZnbjIOlvNwJafq1_Xk-12VDEFP9TXTd1RynT8x8YsqpDfDJmh1ZtcqMoB8
Message-ID: <CAP-5=fVmybd=WTKS3kvsF+VU_Lrke9hEvNyBtunAHBw-6ViZig@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf stat: Use field separator in the metric header
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 3:24=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Thu, Jun 27, 2024 at 1:48=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Thu, Jun 27, 2024 at 1:03=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > It didn't use the passed field separator (using -x option) when it
> > > prints the metric headers and always put "," between the fields.
> > >
> > > Before:
> > >   $ sudo ./perf stat -a -x : --per-core -M tma_core_bound --metric-on=
ly true
> > >   core,cpus,%  tma_core_bound:     <<<--- here: "core,cpus," but ":" =
expected
> > >   S0-D0-C0:2:10.5:
> > >   S0-D0-C1:2:14.8:
> > >   S0-D0-C2:2:9.9:
> > >   S0-D0-C3:2:13.2:
> > >
> > > After:
> > >   $ sudo ./perf stat -a -x : --per-core -M tma_core_bound --metric-on=
ly true
> > >   core:cpus:%  tma_core_bound:
> > >   S0-D0-C0:2:10.5:
> > >   S0-D0-C1:2:15.0:
> > >   S0-D0-C2:2:16.5:
> > >   S0-D0-C3:2:12.5:
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/stat-display.c | 37 ++++++++++++++++++++++++++------=
--
> > >  1 file changed, 29 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-di=
splay.c
> > > index 91d2f7f65df7..e8673c9f6b49 100644
> > > --- a/tools/perf/util/stat-display.c
> > > +++ b/tools/perf/util/stat-display.c
> > > @@ -47,16 +47,27 @@ static int aggr_header_lens[] =3D {
> > >  };
> > >
> > >  static const char *aggr_header_csv[] =3D {
> > > -       [AGGR_CORE]     =3D       "core,cpus,",
> > > -       [AGGR_CACHE]    =3D       "cache,cpus,",
> > > -       [AGGR_DIE]      =3D       "die,cpus,",
> > > -       [AGGR_SOCKET]   =3D       "socket,cpus,",
> > > -       [AGGR_NONE]     =3D       "cpu,",
> > > -       [AGGR_THREAD]   =3D       "comm-pid,",
> > > -       [AGGR_NODE]     =3D       "node,",
> > > +       [AGGR_CORE]     =3D       "core%scpus%s",
> > > +       [AGGR_CACHE]    =3D       "cache%scpus%s",
> > > +       [AGGR_DIE]      =3D       "die%scpus%s",
> > > +       [AGGR_SOCKET]   =3D       "socket%scpus%s",
> > > +       [AGGR_NONE]     =3D       "cpu%s",
> > > +       [AGGR_THREAD]   =3D       "comm-pid%s",
> > > +       [AGGR_NODE]     =3D       "node%s",
> > >         [AGGR_GLOBAL]   =3D       ""
> > >  };
> > >
> > > +static int aggr_header_num[] =3D {
> > > +       [AGGR_CORE]     =3D       2,
> > > +       [AGGR_CACHE]    =3D       2,
> > > +       [AGGR_DIE]      =3D       2,
> > > +       [AGGR_SOCKET]   =3D       2,
> > > +       [AGGR_NONE]     =3D       1,
> > > +       [AGGR_THREAD]   =3D       1,
> > > +       [AGGR_NODE]     =3D       1,
> > > +       [AGGR_GLOBAL]   =3D       0,
> > > +};
> > > +
> > >  static const char *aggr_header_std[] =3D {
> > >         [AGGR_CORE]     =3D       "core",
> > >         [AGGR_CACHE]    =3D       "cache",
> > > @@ -1185,8 +1196,18 @@ static void print_metric_headers_csv(struct pe=
rf_stat_config *config,
> > >  {
> > >         if (config->interval)
> > >                 fputs("time,", config->output);
> > > -       if (!config->iostat_run)
> > > +       if (config->iostat_run)
> > > +               return;
> > > +
> >
> > Having a static count of commas seems somewhat error prone, perhaps:
> > ```
> > const char *header =3D aggr_header_csv[config->aggr_mode];
> > if (config->csv_sep =3D=3D ',' || !strchr(header, ',')) {
> >   fputs(config->output, header);
> > } else {
> >   char *tmp =3D strdup(header);
> >   char *p =3D tmp;
> >    while (p && *p) {
> >       if (p =3D=3D ',')
> >         *p =3D config->csv_sep;
> >      p++;
> >    }
> >   fputs(config->output, tmp);
> >   free(tmp);
> > }
> > ```
>
> Looks good.  But I think we should handle longer separators like -x ":::"=
.
> Will do in v2.

Hi Namhyung,

It looks like this has been forgotten. Did you have a v2?

Thanks,
Ian

> > I'm somewhat surprised that we have no metric tests in the stat output
> > tests like tools/perf/tests/shell/stat+csv_output.sh. Perhaps we can
> > add the following:
> > ```
> > diff --git a/tools/perf/tests/shell/lib/stat_output.sh
> > b/tools/perf/tests/shell/lib/stat_output.sh
> > index 9a176ceae4a3..a920b2d78abb 100644
> > --- a/tools/perf/tests/shell/lib/stat_output.sh
> > +++ b/tools/perf/tests/shell/lib/stat_output.sh
> > @@ -148,6 +148,14 @@ check_per_socket()
> >        echo "[Success]"
> > }
> >
> > +check_metric_only()
> > +{
> > +        echo -n "Checking $1 output: metric only "
> > +        perf stat --metric-only $2 -e instructions,cycles true
> > +        commachecker --metric-only
> > +        echo "[Success]"
> > +}
> > +
> > # The perf stat options for per-socket, per-core, per-die
> > # and -A ( no_aggr mode ) uses the info fetched from this
> > # directory: "/sys/devices/system/cpu/cpu*/topology". For
> > diff --git a/tools/perf/tests/shell/stat+csv_output.sh
> > b/tools/perf/tests/shell/stat+csv_output.sh
> > index fc2d8cc6e5e0..d6807dbab931 100755
> > --- a/tools/perf/tests/shell/stat+csv_output.sh
> > +++ b/tools/perf/tests/shell/stat+csv_output.sh
> > @@ -44,6 +44,7 @@ function commachecker()
> >        ;; "--per-die")         exp=3D8
> >        ;; "--per-cluster")     exp=3D8
> >        ;; "--per-cache")       exp=3D8
> > +        ;; "--metric-only")     exp=3D2
> >        esac
> >
> >        while read line
> > @@ -83,6 +84,7 @@ then
> >        check_per_cluster "CSV" "$perf_cmd"
> >        check_per_die "CSV" "$perf_cmd"
> >        check_per_socket "CSV" "$perf_cmd"
> > +        check_metric_only "CSV" "$perf_cmd"
> > else
> >        echo "[Skip] Skipping tests for system_wide_no_aggr, per_core,
> > per_die and per_socket since
> > socket id exposed via topology is invalid"
> > fi
> > ```
> > It is using the hard coded metrics and it looks like the header
> > printing for that is broken, but this is so often the case for stat
> > output :-(
>
> Right, I also noticed something in the header.  One more work
> item to the list.
>
> Anyway, I'll add it to the test case!
>
> Thanks,
> Namhyung
>
> >
> > > +       if (aggr_header_num[config->aggr_mode] =3D=3D 1) {
> > > +               fprintf(config->output, aggr_header_csv[config->aggr_=
mode],
> > > +                       config->csv_sep);
> > > +       } else if (aggr_header_num[config->aggr_mode] =3D=3D 2) {
> > > +               fprintf(config->output, aggr_header_csv[config->aggr_=
mode],
> > > +                       config->csv_sep, config->csv_sep);
> > > +       } else {
> > >                 fputs(aggr_header_csv[config->aggr_mode], config->out=
put);
> > > +       }
> > >  }
> > >
> > >  static void print_metric_headers_json(struct perf_stat_config *confi=
g __maybe_unused,
> > > --
> > > 2.45.2.803.g4e1b14247a-goog
> > >
