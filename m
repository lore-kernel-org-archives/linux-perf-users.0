Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6883819F49C
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Jun 2024 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719521317; cv=none; b=JvYS7oPJVy05AGrs5/Yn2WSLTa/n+RqjF7EWbd7cyd2oPcAIcyapYuY+CBOjo6nBhdowvURJbQ1uJw2uvF23QTOKuUYlI0kMxCPlCUo9B37L8QSkM13z+Rnw4WBwL5+BPM/aHMShcrwh77SKlI52YNgffjqxkjFv3DSMbcvDE1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719521317; c=relaxed/simple;
	bh=qoFj5uz5uYzgeuzAusO67gMf3OCHa5+yeZMlTId4hvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFD++91VglLjFYj+31mVEwX08imc7m/zRXEv1FRRvvsInDWAMczCDBnPYt0i+RENktPYlt2bbm/z+uEjg4goKQPD+hkdO91t1PfvQxEcIaB4Cf4Fu5ih+2grj2thteyJ49sH7M/CsE1ImfXCfxo0+KyICEuXzaI9+2I1wnrNONI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dNBWbx0N; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNBWbx0N"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-37624917c2dso11585ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Jun 2024 13:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719521313; x=1720126113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blQSr0euuO4eezaJrwlJMFZXhqIsm2poiLoEpcG/FhQ=;
        b=dNBWbx0NVhuwzoYae3l6yY8f6D/nixYs6DdzsXvL7JcJR6ysQzL5+sbKkvp1zxdmZy
         pAO/5fngcb0p9GZ4nLTR8S8JjmvS1ULUY/s0EQaNXEzGu4KpnhvTG0hfgsNbOf0iiTS3
         3qAqyFqxf5phUmc3LrgtSL6soOM6lhhp4FxVs6ZmzISiYt0liW/UP+6OmD9/XKzDjkCd
         He4OmyHu2ADramz8ciMGIrm31Y1226pgEHzwGRS4vQs4F0EhqgnNPTiZXQDjojmgBd6S
         XlU8aeqnG18jzOL0pvVyegulpg/BrnT1uGFkJGPTESvj9yhCGjPd6KRPceCgS5X/dIf7
         n7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719521313; x=1720126113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=blQSr0euuO4eezaJrwlJMFZXhqIsm2poiLoEpcG/FhQ=;
        b=A621JJMCav4Ar1QHyZGEitk1ddxU3d77vSTnqpcZv3dS51CxNiLS6lbwoPAX/PdNhj
         L6pJEwUp2CeshWU9VbKCQEHFOHdWjXODolBmoqXSqJ2l+J/OowIOs3lZkbxXjOPsNKZr
         y8SW5S+Kg/bw6ThEiAbCU94SIBSoWMxg0O/94QThBoUPSf+INYFPtJdvxy/uSi1A5i2n
         iVPel0hnta5o75e+/r+cUiZ06vBFdkWyLXnu4ioUVgZU515FXCMha+Ze5JnuDp0UUl8O
         TFrhwpsAU62SGfah/LZRTrg9fGsh8ZBVW5+Qgmesf7jfWIR4GWyG0Qsw2etq2apBrB3r
         NAeA==
X-Forwarded-Encrypted: i=1; AJvYcCUZKgkYh2xUEd4h7+XF7ltcHoVxqlNXj73LGfX9FF7wva4TvElx3nwZggTs0RvFjHaPhuN7WpKeZtr6qAJ2cTH3i1h3MhfXkMCmBicSESraOw==
X-Gm-Message-State: AOJu0Yxd9F/RjoDBAbWGzoDEfAW9jZLiZSHGU218y1b3RUhn5T555GEh
	C9tm+ciH7lPJSp0KU8iBmGGXio11ZmaPTLGTWjt0VP71QziadahgGosVYruYVClL4+t3RXThuNK
	rYTmwPG0CN8wm2ANp/SyvNmaH+QZWpa0qSyIY
X-Google-Smtp-Source: AGHT+IE1F1i+e3raVm832rRV/DRDaaBH2wOUTm9EaKzOpa2G8ZW3pLzyybRW6BIwCR8pT2sKUHefxc9eyamcwfg6yes=
X-Received: by 2002:a05:6e02:2162:b0:375:e16c:2011 with SMTP id
 e9e14a558f8ab-37afc4ce703mr138575ab.5.1719521313326; Thu, 27 Jun 2024
 13:48:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627200353.1230407-1-namhyung@kernel.org>
In-Reply-To: <20240627200353.1230407-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 27 Jun 2024 13:48:22 -0700
Message-ID: <CAP-5=fWSpM7NL7UjXZBN8WHNAE7hGe1ghQ6_DqFe2VjTCGoA7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf stat: Use field separator in the metric header
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 1:03=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> It didn't use the passed field separator (using -x option) when it
> prints the metric headers and always put "," between the fields.
>
> Before:
>   $ sudo ./perf stat -a -x : --per-core -M tma_core_bound --metric-only t=
rue
>   core,cpus,%  tma_core_bound:     <<<--- here: "core,cpus," but ":" expe=
cted
>   S0-D0-C0:2:10.5:
>   S0-D0-C1:2:14.8:
>   S0-D0-C2:2:9.9:
>   S0-D0-C3:2:13.2:
>
> After:
>   $ sudo ./perf stat -a -x : --per-core -M tma_core_bound --metric-only t=
rue
>   core:cpus:%  tma_core_bound:
>   S0-D0-C0:2:10.5:
>   S0-D0-C1:2:15.0:
>   S0-D0-C2:2:16.5:
>   S0-D0-C3:2:12.5:
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/stat-display.c | 37 ++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index 91d2f7f65df7..e8673c9f6b49 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -47,16 +47,27 @@ static int aggr_header_lens[] =3D {
>  };
>
>  static const char *aggr_header_csv[] =3D {
> -       [AGGR_CORE]     =3D       "core,cpus,",
> -       [AGGR_CACHE]    =3D       "cache,cpus,",
> -       [AGGR_DIE]      =3D       "die,cpus,",
> -       [AGGR_SOCKET]   =3D       "socket,cpus,",
> -       [AGGR_NONE]     =3D       "cpu,",
> -       [AGGR_THREAD]   =3D       "comm-pid,",
> -       [AGGR_NODE]     =3D       "node,",
> +       [AGGR_CORE]     =3D       "core%scpus%s",
> +       [AGGR_CACHE]    =3D       "cache%scpus%s",
> +       [AGGR_DIE]      =3D       "die%scpus%s",
> +       [AGGR_SOCKET]   =3D       "socket%scpus%s",
> +       [AGGR_NONE]     =3D       "cpu%s",
> +       [AGGR_THREAD]   =3D       "comm-pid%s",
> +       [AGGR_NODE]     =3D       "node%s",
>         [AGGR_GLOBAL]   =3D       ""
>  };
>
> +static int aggr_header_num[] =3D {
> +       [AGGR_CORE]     =3D       2,
> +       [AGGR_CACHE]    =3D       2,
> +       [AGGR_DIE]      =3D       2,
> +       [AGGR_SOCKET]   =3D       2,
> +       [AGGR_NONE]     =3D       1,
> +       [AGGR_THREAD]   =3D       1,
> +       [AGGR_NODE]     =3D       1,
> +       [AGGR_GLOBAL]   =3D       0,
> +};
> +
>  static const char *aggr_header_std[] =3D {
>         [AGGR_CORE]     =3D       "core",
>         [AGGR_CACHE]    =3D       "cache",
> @@ -1185,8 +1196,18 @@ static void print_metric_headers_csv(struct perf_s=
tat_config *config,
>  {
>         if (config->interval)
>                 fputs("time,", config->output);
> -       if (!config->iostat_run)
> +       if (config->iostat_run)
> +               return;
> +

Having a static count of commas seems somewhat error prone, perhaps:
```
const char *header =3D aggr_header_csv[config->aggr_mode];
if (config->csv_sep =3D=3D ',' || !strchr(header, ',')) {
  fputs(config->output, header);
} else {
  char *tmp =3D strdup(header);
  char *p =3D tmp;
   while (p && *p) {
      if (p =3D=3D ',')
        *p =3D config->csv_sep;
     p++;
   }
  fputs(config->output, tmp);
  free(tmp);
}
```
I'm somewhat surprised that we have no metric tests in the stat output
tests like tools/perf/tests/shell/stat+csv_output.sh. Perhaps we can
add the following:
```
diff --git a/tools/perf/tests/shell/lib/stat_output.sh
b/tools/perf/tests/shell/lib/stat_output.sh
index 9a176ceae4a3..a920b2d78abb 100644
--- a/tools/perf/tests/shell/lib/stat_output.sh
+++ b/tools/perf/tests/shell/lib/stat_output.sh
@@ -148,6 +148,14 @@ check_per_socket()
       echo "[Success]"
}

+check_metric_only()
+{
+        echo -n "Checking $1 output: metric only "
+        perf stat --metric-only $2 -e instructions,cycles true
+        commachecker --metric-only
+        echo "[Success]"
+}
+
# The perf stat options for per-socket, per-core, per-die
# and -A ( no_aggr mode ) uses the info fetched from this
# directory: "/sys/devices/system/cpu/cpu*/topology". For
diff --git a/tools/perf/tests/shell/stat+csv_output.sh
b/tools/perf/tests/shell/stat+csv_output.sh
index fc2d8cc6e5e0..d6807dbab931 100755
--- a/tools/perf/tests/shell/stat+csv_output.sh
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -44,6 +44,7 @@ function commachecker()
       ;; "--per-die")         exp=3D8
       ;; "--per-cluster")     exp=3D8
       ;; "--per-cache")       exp=3D8
+        ;; "--metric-only")     exp=3D2
       esac

       while read line
@@ -83,6 +84,7 @@ then
       check_per_cluster "CSV" "$perf_cmd"
       check_per_die "CSV" "$perf_cmd"
       check_per_socket "CSV" "$perf_cmd"
+        check_metric_only "CSV" "$perf_cmd"
else
       echo "[Skip] Skipping tests for system_wide_no_aggr, per_core,
per_die and per_socket since
socket id exposed via topology is invalid"
fi
```
It is using the hard coded metrics and it looks like the header
printing for that is broken, but this is so often the case for stat
output :-(

Thanks,
Ian

> +       if (aggr_header_num[config->aggr_mode] =3D=3D 1) {
> +               fprintf(config->output, aggr_header_csv[config->aggr_mode=
],
> +                       config->csv_sep);
> +       } else if (aggr_header_num[config->aggr_mode] =3D=3D 2) {
> +               fprintf(config->output, aggr_header_csv[config->aggr_mode=
],
> +                       config->csv_sep, config->csv_sep);
> +       } else {
>                 fputs(aggr_header_csv[config->aggr_mode], config->output)=
;
> +       }
>  }
>
>  static void print_metric_headers_json(struct perf_stat_config *config __=
maybe_unused,
> --
> 2.45.2.803.g4e1b14247a-goog
>
