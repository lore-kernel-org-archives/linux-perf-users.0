Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DAE136E1A;
	Fri, 24 May 2024 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716592860; cv=none; b=tsZCScqFgBnvLv5jIglHxduWLuO3PPmp8sNL7ASOspcVjnEyhRJGdoSiNmbddh8BuMJ76oAaIBLntBtZSFkkqpidQbCdub4EnMWaoS6twg9CBFpPKzcCnDCApdOfkSQORMh/aG2U1LWCUdXuVdg9Ho3ombqeE3ejeaX7iJCXCgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716592860; c=relaxed/simple;
	bh=HcG0HZCe2TOEI9UXK18wxFCx1e145Ro2fmdBDCLuAEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cXwlBFi7Fu6Vq/SJOQVVhjEKW3nKdsSL+QK3VM+i1alfbLlbqQTHjA43cTyXWo4xDhuN4nrQbLV3o5959P0Dr43sxpgFRkhPk9RxEj0JfQWFyXNidIGCcmumM9aoh2+US1qACSlywR4itTrqx2TYt3LhJLP2wh6qbsH6SaANf+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-681919f89f2so1125523a12.1;
        Fri, 24 May 2024 16:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716592858; x=1717197658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/E6h9cLW82Sir29AqENWdj6pESrygYaxB12ff2cWCUk=;
        b=f6NyHfJbv4lBAJFX921+uoMq0VSyVfDHGy3uZrZ0K5zE1M4wXsa8pAYcXCUw8HLUeh
         3Ah40YlWOOwWu8xFJOmNJ7kk8Mi391S6h9hiMRHGEGbmgMYhMIqeT1YULWwXqMM4dVDk
         BPiiGAj0QKU3wKOA/5A2j7rnnVPJdSH0XmIdejNwJS5/UcA/LjGVdhDGHaZlcQgrK4Am
         gt0mzK7iY0u1kfBVXytQZ76VTbFXVAjTIG8GE20sMsPis+KwL1SZugkwSRjn/U4dUEXP
         PWovA5/20CT0rTWVJ7XM/w4ySX776JoRP5lhBe5FmzNY6SKzjyzkR3C5Jw9YQGG3X27B
         3auA==
X-Forwarded-Encrypted: i=1; AJvYcCU3S1RjHBpe+B+z+A/0bIpj96GLCFqcSqL6sBQN1hYT+3V4BqyRNfviydG2DeQk6ofB9PBSmbTLbNnBX0vOGe5/aCxCBWnqSz0lXWuk9X76gdE1j183R29b/ZX7gRu+I/rwH72iPlPt4tJtXT5Jwg==
X-Gm-Message-State: AOJu0YzT4Tf6jNMm26chHaVBRVJ9fJ+GDvaR9wszkVQdtyI6qkv+PcFv
	0yxEnZOHfe+YmttX9xj2zxfZSRhtq3edAedvFfmRsp9jck5yybvhrgfJLTib7W4ErSiEmS6PIp0
	K7g6eWsgIu3VLVmU7ElvWNVt8ZY4=
X-Google-Smtp-Source: AGHT+IE7NcTT15412fctFD9VGsJ3QSLwbXGS9xyrXiED8TenFsgyMY4AzJH1PkoIGhMQxlWXMK4YFYPNZD2IKLDIb4E=
X-Received: by 2002:a17:902:db0d:b0:1ec:53de:a51d with SMTP id
 d9443c01a7336-1f449902d74mr46679745ad.69.1716592858473; Fri, 24 May 2024
 16:20:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521173952.3397644-1-weilin.wang@intel.com> <20240521173952.3397644-6-weilin.wang@intel.com>
In-Reply-To: <20240521173952.3397644-6-weilin.wang@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 24 May 2024 16:20:47 -0700
Message-ID: <CAM9d7cg7Xg=pxc5sxfGo7Om2qh3zoj2nbtyAyu6D5MOedfJ6SQ@mail.gmail.com>
Subject: Re: [RFC PATCH v9 5/7] perf stat: Add command line option for
 enabling tpebs recording
To: weilin.wang@intel.com
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 10:40=E2=80=AFAM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> With this command line option, tpebs recording is turned off in perf stat=
 on
> default. It will only be turned on when this option is given in perf stat
> command.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/builtin-stat.c | 19 +++++++++++++------
>  tools/perf/util/evsel.c   | 19 ++++++++++++++-----
>  2 files changed, 27 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index c0e9dfa3b3c2..c27521fb1aee 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -117,6 +117,7 @@ static volatile sig_atomic_t        child_pid        =
               =3D -1;
>  static int                     detailed_run                    =3D  0;
>  static bool                    transaction_run;
>  static bool                    topdown_run                     =3D false=
;
> +static bool                    tpebs_recording                 =3D false=
;
>  static bool                    smi_cost                        =3D false=
;
>  static bool                    smi_reset                       =3D false=
;
>  static int                     big_num_opt                     =3D  -1;
> @@ -677,9 +678,11 @@ static int __run_perf_stat(int argc, const char **ar=
gv, int run_idx)
>         int err;
>         bool second_pass =3D false;
>
> -       err =3D start_tpebs(&stat_config, evsel_list);
> -       if (err < 0)
> -               return err;
> +       if (tpebs_recording) {
> +               err =3D start_tpebs(&stat_config, evsel_list);
> +               if (err < 0)
> +                       return err;
> +       }
>
>         if (forks) {
>                 if (evlist__prepare_workload(evsel_list, &target, argv, i=
s_pipe, workload_exec_failed_signal) < 0) {
> @@ -886,9 +889,11 @@ static int __run_perf_stat(int argc, const char **ar=
gv, int run_idx)
>
>         t1 =3D rdclock();
>
> -       err =3D stop_tpebs();
> -       if (err < 0)
> -               return err;
> +       if (tpebs_recording) {
> +               err =3D stop_tpebs();
> +               if (err < 0)
> +                       return err;
> +       }
>
>         if (stat_config.walltime_run_table)
>                 stat_config.walltime_run[run_idx] =3D t1 - t0;
> @@ -1246,6 +1251,8 @@ static struct option stat_options[] =3D {
>                        "disable adding events for the metric threshold ca=
lculation"),
>         OPT_BOOLEAN(0, "topdown", &topdown_run,
>                         "measure top-down statistics"),
> +       OPT_BOOLEAN(0, "enable-tpebs-recording", &tpebs_recording,

Just --tpebs or --tpebs-record?  I just prefer short names. :)


> +                       "enable recording for tpebs when retire_latency r=
equired"),
>         OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
>                         "Set the metrics level for the top-down statistic=
s (0: max level)"),
>         OPT_BOOLEAN(0, "smi-cost", &smi_cost,
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 4d700338fc99..e1f3f63dfb54 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1540,21 +1540,30 @@ static int evsel__set_retire_lat(struct evsel *ev=
sel, int cpu_map_idx, int threa
>                 }
>         }
>
> -       if (!found)
> -               return -1;
> +       /* Set ena and run to non-zero */
> +       count->ena =3D count->run =3D 1;
> +       count->lost =3D 0;
> +
> +       if (!found) {
> +               /*
> +                * Set default value or 0 when retire_latency for this ev=
ent is
> +                * not found from sampling data (enable_tpebs_recording n=
ot set
> +                * or 0 sample recorded).
> +                */
> +               val =3D 0;
> +               return 0;
> +       }
>
>         /*
>          * Only set retire_latency value to the first CPU and thread.
>          */
>         if (cpu_map_idx =3D=3D 0 && thread =3D=3D 0)
> +       /* Lost precision when casting from double to __u64. Any improvem=
ent? */

Maybe you can save val * 1000 and then later
convert back to double and divide by 1000?

Thanks,
Namhyung


>                 val =3D t->val;
>         else
>                 val =3D 0;
>
>         count->val =3D val;
> -       /* Set ena and run to non-zero */
> -       count->ena =3D count->run =3D 1;
> -       count->lost =3D 0;
>         return 0;
>  }
>
> --
> 2.43.0
>
