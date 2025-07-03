Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F0620E005
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Jul 2025 03:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751511914; cv=none; b=WoBz+UzrmK7K1AfAF0hN2wG0C16e2b0NXX0qEH1VYAPdHwZDQxxuAJQac49GaoJaU2puDzbSvFH2rphWUexGsTnmxvXqCArqIheFuU9xT1EQnpXu6n/ETDQjX+fb5Qt4iBjzVODZiES0xcYZtii5sIB/eZcqBQKC9qk1hOw4HUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751511914; c=relaxed/simple;
	bh=P1dXl3+KFthDLcrbARX1twwpsVdlUey0a3I0xrRqvOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTll+9H2zQ8Xt008xO1ILJApwRXIVAxngLiOIWJ2QT69wtAlawJ6SaXZP44BIq/csK2YWN41Cq8tn1qbAyquqeZZRTxoNHTjpcgSKE2QVBVqCmOOLND695BdncWthQN+2Zb049eyrY6nDDgGjgJcKiyukOz/cSTUlNABY3TOdko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y9YlaXeT; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y9YlaXeT"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3de210e6076so47505ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Jul 2025 20:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751511912; x=1752116712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fw1zdsvGiW5SffxoZuj66sxIkq2Ei3cUMJ7QdpRM25Q=;
        b=y9YlaXeTYLe/6Vbw63m/m/Gi7kULzKm7/lCbfEKZeN5lNVqtqTfkXoJ1ZKEhiv+Kho
         bktwuv0LEr9ZfdChW4AbNuzuA9HMZEVur+qUhzTWF0IDlo8tLIsLPxFTSyMisyNhDzDi
         CdO80FYX4vzvKpwCvZH5T5+FF/XrAfWR8e9mSOp87PA8ypEoBK7R8ceBS7lzS6eqeDcO
         nRUhYIJFECrlYJop1FgLXJKc83f3119XxTiLseE0BBwN6OFZY2p/jw4Yh0QcVdz2blhh
         E/nRRqX6H+PKs7iomJrCITQGBO7Pl+WOy89dFLhMDjK6eq13WHwgkQASQK8GzeT6/v5M
         KKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751511912; x=1752116712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fw1zdsvGiW5SffxoZuj66sxIkq2Ei3cUMJ7QdpRM25Q=;
        b=IgjVNQVjhEpfPkG0aqtr4r7lx2mlpUZXT00IVGzhBOtaKJ4n/qYRKvj+nDkRG6RuvT
         26RCs3+5Lauf93fljW4J0TKwODUPOfpa1woANl1skUlKZRCR2bHrAJdSBSYxzmAmMDZr
         kIFl5/3umnwPTVDEgwIIHDPhzgUquHx8v4Rupw0e8TxuvrdShJUlDWGMtLYJje3cdxlM
         raIsg4CnVfYfCqzt85JJq1gPZr220Mfj7jLGQkPsoAXM9g0lmrHYdv9PoI9l1qiczRDV
         irz5Ns3QJ4Kzo6jyRRp/31LMZFaHVbhsEHAw4fkvTevZnhe5FLQb90Glid4xVEat4NZb
         GWZg==
X-Forwarded-Encrypted: i=1; AJvYcCW/pEwczWpLXwRaXyi0StZhr9sV3ZLBAURyNXVkhQ9mfYLY6DRc3Tqeq+igmz1E13WAB1IPmrv1T9BKzwarzhm5@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7cq0nsrK5MWynV5zxBVVB8bsaam7WZL/AFNL30vMXi+lXfbqN
	A+gXALkftiwwzAycX/5oNXTBLOfOOD0HL3obkPhb4FN/he83Ts7xNpM+q9VDd8rTw6tyZZvOX5f
	ZdtGwn+FaWUzZx52emGbe/RRWFVcdTfz7gtS+eu3N
X-Gm-Gg: ASbGncur0D/ZaE1x1wwPUlHxfJSRd5WiW5gUtIkDHwm02THOpXOMAO7pojO7B5VSvM0
	GOoy2mb6ShQbYhTrSe/FOYFQenK8KK0TjGP/kTaQt2cD7T0BaXwWgHoOchqqYpCaKK5S6dkjpGw
	ZhO4iQS85UXLKOZNe7bsHRPsa9rR4CUKsqxn3Oqvp0Wnbm
X-Google-Smtp-Source: AGHT+IGfE6wi/daruKC40vA1BmYOdC74l7qeFPgqJ2p2hNRKolsW75TbqGOh+ULq4u3Bid5mAIRGQrMyCNRMRUPJCcQ=
X-Received: by 2002:a92:ca06:0:b0:3df:2f9a:1889 with SMTP id
 e9e14a558f8ab-3e05c7ce845mr1945085ab.16.1751511911711; Wed, 02 Jul 2025
 20:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703014942.1369397-1-namhyung@kernel.org> <20250703014942.1369397-2-namhyung@kernel.org>
In-Reply-To: <20250703014942.1369397-2-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 2 Jul 2025 20:04:59 -0700
X-Gm-Features: Ac12FXxJIObrai-0G87tNuUOwBg8FBTgzsFTA3xiLHBFQ0sfTwsD81BS50-I0QI
Message-ID: <CAP-5=fVXgSTGF_NALm2TfLK9+CSL2-H1QvKh5=ozveU1orBJwg@mail.gmail.com>
Subject: Re: [PATCH 1/8] perf sched: Make sure it frees the usage string
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 6:49=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> The parse_options_subcommand() allocates the usage string based on the
> given subcommands.  So it should reach the end of the function to free
> the string to prevent memory leaks.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-sched.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 26ece6e9bfd167b3..b7bbfad0ed600eee 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -3902,9 +3902,9 @@ int cmd_sched(int argc, const char **argv)
>          * Aliased to 'perf script' for now:
>          */
>         if (!strcmp(argv[0], "script")) {
> -               return cmd_script(argc, argv);
> +               ret =3D cmd_script(argc, argv);
>         } else if (strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
> -               return __cmd_record(argc, argv);
> +               ret =3D __cmd_record(argc, argv);
>         } else if (strlen(argv[0]) > 2 && strstarts("latency", argv[0])) =
{
>                 sched.tp_handler =3D &lat_ops;
>                 if (argc > 1) {
> @@ -3913,7 +3913,7 @@ int cmd_sched(int argc, const char **argv)
>                                 usage_with_options(latency_usage, latency=
_options);
>                 }
>                 setup_sorting(&sched, latency_options, latency_usage);
> -               return perf_sched__lat(&sched);
> +               ret =3D perf_sched__lat(&sched);
>         } else if (!strcmp(argv[0], "map")) {
>                 if (argc) {
>                         argc =3D parse_options(argc, argv, map_options, m=
ap_usage, 0);
> @@ -3924,13 +3924,14 @@ int cmd_sched(int argc, const char **argv)
>                                 sched.map.task_names =3D strlist__new(sch=
ed.map.task_name, NULL);
>                                 if (sched.map.task_names =3D=3D NULL) {
>                                         fprintf(stderr, "Failed to parse =
task names\n");
> -                                       return -1;
> +                                       ret =3D -1;
> +                                       goto out;
>                                 }
>                         }
>                 }
>                 sched.tp_handler =3D &map_ops;
>                 setup_sorting(&sched, latency_options, latency_usage);
> -               return perf_sched__map(&sched);
> +               ret =3D perf_sched__map(&sched);
>         } else if (strlen(argv[0]) > 2 && strstarts("replay", argv[0])) {
>                 sched.tp_handler =3D &replay_ops;
>                 if (argc) {
> @@ -3938,7 +3939,7 @@ int cmd_sched(int argc, const char **argv)
>                         if (argc)
>                                 usage_with_options(replay_usage, replay_o=
ptions);
>                 }
> -               return perf_sched__replay(&sched);
> +               ret =3D perf_sched__replay(&sched);
>         } else if (!strcmp(argv[0], "timehist")) {
>                 if (argc) {
>                         argc =3D parse_options(argc, argv, timehist_optio=
ns,
> @@ -3954,19 +3955,19 @@ int cmd_sched(int argc, const char **argv)
>                                 parse_options_usage(NULL, timehist_option=
s, "w", true);
>                         if (sched.show_next)
>                                 parse_options_usage(NULL, timehist_option=
s, "n", true);
> -                       return -EINVAL;
> +                       ret =3D -EINVAL;
> +                       goto out;
>                 }
>                 ret =3D symbol__validate_sym_arguments();
> -               if (ret)
> -                       return ret;
> -
> -               return perf_sched__timehist(&sched);
> +               if (!ret)
> +                       ret =3D perf_sched__timehist(&sched);
>         } else {
>                 usage_with_options(sched_usage, sched_options);
>         }
>
> +out:
>         /* free usage string allocated by parse_options_subcommand */
>         free((void *)sched_usage[0]);
>
> -       return 0;
> +       return ret;
>  }
> --
> 2.50.0.727.gbf7dc18ff4-goog
>
