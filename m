Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A5D1EB40;
	Thu, 27 Jun 2024 22:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719527042; cv=none; b=m70iSLjMzDgU8wKAc9J448SL24Gr85Sn60qHAtGG3UweChbEx2fYfdm9FU0tpLwE9Mac+etUCzNmHnNyNsuFFtu9xJ+cVijKxURNiWMyHMdk5sTx2MdC4Pk8jNG41GNYw78ZJrM+0yEwcfUYlllTjSf5LhFmKRIUTQnNS5csUEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719527042; c=relaxed/simple;
	bh=PviT/CztwN5Z05zeLQplg14StfNF1vckdkgRZUipaNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbYk7scJpH6ODe/3z555zVcIFvGSmcOYYBgWYu+Pdn5jgYhc2j2xjGieN85/2rBAVvPu30iZV8YaBSixufbumCeC2PeCbL2vi3PGQflKekagj6dkCn3mlcDoLHPhce2sAOFmlszpH7tJzyBWNXQGRPIwAMvWKyzY8bZEuQDaT9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70673c32118so11546b3a.3;
        Thu, 27 Jun 2024 15:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719527040; x=1720131840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k25KTnBVPDHacGsXCJPZR5rn7BDEOF2zCT8+vYzBgL4=;
        b=I/7gx1kjmJoRmX2ryY/SjDplgA1TYdumNDbLN2SqS2DxQGPixFwesBhLeFRq//KWVY
         5TYWKxMxUkxKofETIfR6ZQXrlAYf+HvUCyR0SCQgi4sjGH5szWahz96Yj5Ta4/MCeZDM
         ae2/KFUtazH6qNFxyaQ7YqsoqPmXHPzryMU/65kcAPaUUTcHOLw/jZXFzUiSF9FuGbW+
         ht0kdYBYdLlbO8W86JQfIT8+3GKQhAX1Rj11Qr8R/xJ6OLZIxs9toU+1SncqNMjEka1x
         fJf3+0+CS7QRm6EVo1Y+WjyvEg0a/xeI+K/awargrzsrei0LpB/uNpTNDj9Ymv3PHz69
         OftQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAXix3JCND/78qVwdjEsd7XElcZG7HAFxFM34qvF5AcorIIiDNMn+ZSTiv+NMwFEx93bLKL4QjUa2RmU6xM7hGzVZ5MXbpJHglg3OgJxMp1f1SG+C60hki1ONRcWstl+6wbYxICV6zyz9mWu4/oA==
X-Gm-Message-State: AOJu0Yzu81v0mGuYQmSFtzMVT/YLzXb8YwmiU7/lAKo0Voqxn+JiUyMT
	tXl1l6mjfr1yIprio7rhf2xvb7qL/anH8S59fBFHnzMZ761HYv0DHJzwRKWKvmO8qOIr39fhsZg
	XAfsmxJykDlscC4jvnQwR3/uVWZo=
X-Google-Smtp-Source: AGHT+IEcK3fIyaBjFYDJbkmQ2KXWWaGSIKUvx3sWF0Ub18jQqEeqsIngmx604WF7UpYM/llLE8qzpf6j7HEeY4QHELw=
X-Received: by 2002:a05:6a20:bca8:b0:1be:c733:ab4d with SMTP id
 adf61e73a8af0-1bec733acfdmr4324950637.26.1719527039636; Thu, 27 Jun 2024
 15:23:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627200353.1230407-1-namhyung@kernel.org> <CAP-5=fWSpM7NL7UjXZBN8WHNAE7hGe1ghQ6_DqFe2VjTCGoA7A@mail.gmail.com>
In-Reply-To: <CAP-5=fWSpM7NL7UjXZBN8WHNAE7hGe1ghQ6_DqFe2VjTCGoA7A@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 27 Jun 2024 15:23:47 -0700
Message-ID: <CAM9d7cibrW=K=GZB_zsURB1Ff6Eok7qy3rVt83VVM6pVhv+Agg@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf stat: Use field separator in the metric header
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Thu, Jun 27, 2024 at 1:48=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Jun 27, 2024 at 1:03=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > It didn't use the passed field separator (using -x option) when it
> > prints the metric headers and always put "," between the fields.
> >
> > Before:
> >   $ sudo ./perf stat -a -x : --per-core -M tma_core_bound --metric-only=
 true
> >   core,cpus,%  tma_core_bound:     <<<--- here: "core,cpus," but ":" ex=
pected
> >   S0-D0-C0:2:10.5:
> >   S0-D0-C1:2:14.8:
> >   S0-D0-C2:2:9.9:
> >   S0-D0-C3:2:13.2:
> >
> > After:
> >   $ sudo ./perf stat -a -x : --per-core -M tma_core_bound --metric-only=
 true
> >   core:cpus:%  tma_core_bound:
> >   S0-D0-C0:2:10.5:
> >   S0-D0-C1:2:15.0:
> >   S0-D0-C2:2:16.5:
> >   S0-D0-C3:2:12.5:
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/stat-display.c | 37 ++++++++++++++++++++++++++--------
> >  1 file changed, 29 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-disp=
lay.c
> > index 91d2f7f65df7..e8673c9f6b49 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -47,16 +47,27 @@ static int aggr_header_lens[] =3D {
> >  };
> >
> >  static const char *aggr_header_csv[] =3D {
> > -       [AGGR_CORE]     =3D       "core,cpus,",
> > -       [AGGR_CACHE]    =3D       "cache,cpus,",
> > -       [AGGR_DIE]      =3D       "die,cpus,",
> > -       [AGGR_SOCKET]   =3D       "socket,cpus,",
> > -       [AGGR_NONE]     =3D       "cpu,",
> > -       [AGGR_THREAD]   =3D       "comm-pid,",
> > -       [AGGR_NODE]     =3D       "node,",
> > +       [AGGR_CORE]     =3D       "core%scpus%s",
> > +       [AGGR_CACHE]    =3D       "cache%scpus%s",
> > +       [AGGR_DIE]      =3D       "die%scpus%s",
> > +       [AGGR_SOCKET]   =3D       "socket%scpus%s",
> > +       [AGGR_NONE]     =3D       "cpu%s",
> > +       [AGGR_THREAD]   =3D       "comm-pid%s",
> > +       [AGGR_NODE]     =3D       "node%s",
> >         [AGGR_GLOBAL]   =3D       ""
> >  };
> >
> > +static int aggr_header_num[] =3D {
> > +       [AGGR_CORE]     =3D       2,
> > +       [AGGR_CACHE]    =3D       2,
> > +       [AGGR_DIE]      =3D       2,
> > +       [AGGR_SOCKET]   =3D       2,
> > +       [AGGR_NONE]     =3D       1,
> > +       [AGGR_THREAD]   =3D       1,
> > +       [AGGR_NODE]     =3D       1,
> > +       [AGGR_GLOBAL]   =3D       0,
> > +};
> > +
> >  static const char *aggr_header_std[] =3D {
> >         [AGGR_CORE]     =3D       "core",
> >         [AGGR_CACHE]    =3D       "cache",
> > @@ -1185,8 +1196,18 @@ static void print_metric_headers_csv(struct perf=
_stat_config *config,
> >  {
> >         if (config->interval)
> >                 fputs("time,", config->output);
> > -       if (!config->iostat_run)
> > +       if (config->iostat_run)
> > +               return;
> > +
>
> Having a static count of commas seems somewhat error prone, perhaps:
> ```
> const char *header =3D aggr_header_csv[config->aggr_mode];
> if (config->csv_sep =3D=3D ',' || !strchr(header, ',')) {
>   fputs(config->output, header);
> } else {
>   char *tmp =3D strdup(header);
>   char *p =3D tmp;
>    while (p && *p) {
>       if (p =3D=3D ',')
>         *p =3D config->csv_sep;
>      p++;
>    }
>   fputs(config->output, tmp);
>   free(tmp);
> }
> ```

Looks good.  But I think we should handle longer separators like -x ":::".
Will do in v2.

> I'm somewhat surprised that we have no metric tests in the stat output
> tests like tools/perf/tests/shell/stat+csv_output.sh. Perhaps we can
> add the following:
> ```
> diff --git a/tools/perf/tests/shell/lib/stat_output.sh
> b/tools/perf/tests/shell/lib/stat_output.sh
> index 9a176ceae4a3..a920b2d78abb 100644
> --- a/tools/perf/tests/shell/lib/stat_output.sh
> +++ b/tools/perf/tests/shell/lib/stat_output.sh
> @@ -148,6 +148,14 @@ check_per_socket()
>        echo "[Success]"
> }
>
> +check_metric_only()
> +{
> +        echo -n "Checking $1 output: metric only "
> +        perf stat --metric-only $2 -e instructions,cycles true
> +        commachecker --metric-only
> +        echo "[Success]"
> +}
> +
> # The perf stat options for per-socket, per-core, per-die
> # and -A ( no_aggr mode ) uses the info fetched from this
> # directory: "/sys/devices/system/cpu/cpu*/topology". For
> diff --git a/tools/perf/tests/shell/stat+csv_output.sh
> b/tools/perf/tests/shell/stat+csv_output.sh
> index fc2d8cc6e5e0..d6807dbab931 100755
> --- a/tools/perf/tests/shell/stat+csv_output.sh
> +++ b/tools/perf/tests/shell/stat+csv_output.sh
> @@ -44,6 +44,7 @@ function commachecker()
>        ;; "--per-die")         exp=3D8
>        ;; "--per-cluster")     exp=3D8
>        ;; "--per-cache")       exp=3D8
> +        ;; "--metric-only")     exp=3D2
>        esac
>
>        while read line
> @@ -83,6 +84,7 @@ then
>        check_per_cluster "CSV" "$perf_cmd"
>        check_per_die "CSV" "$perf_cmd"
>        check_per_socket "CSV" "$perf_cmd"
> +        check_metric_only "CSV" "$perf_cmd"
> else
>        echo "[Skip] Skipping tests for system_wide_no_aggr, per_core,
> per_die and per_socket since
> socket id exposed via topology is invalid"
> fi
> ```
> It is using the hard coded metrics and it looks like the header
> printing for that is broken, but this is so often the case for stat
> output :-(

Right, I also noticed something in the header.  One more work
item to the list.

Anyway, I'll add it to the test case!

Thanks,
Namhyung

>
> > +       if (aggr_header_num[config->aggr_mode] =3D=3D 1) {
> > +               fprintf(config->output, aggr_header_csv[config->aggr_mo=
de],
> > +                       config->csv_sep);
> > +       } else if (aggr_header_num[config->aggr_mode] =3D=3D 2) {
> > +               fprintf(config->output, aggr_header_csv[config->aggr_mo=
de],
> > +                       config->csv_sep, config->csv_sep);
> > +       } else {
> >                 fputs(aggr_header_csv[config->aggr_mode], config->outpu=
t);
> > +       }
> >  }
> >
> >  static void print_metric_headers_json(struct perf_stat_config *config =
__maybe_unused,
> > --
> > 2.45.2.803.g4e1b14247a-goog
> >
