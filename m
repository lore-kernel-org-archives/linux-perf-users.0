Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F98A30DECA
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209624; cv=none; b=VF6Ge/n7S0I44jRmXvSxCGheWPouXWeHgobti+GuUGooBytSWY7M1PBDjd2RXh/oz1jCu/SFcrCODeiP4w7ORz1Fw8RHn+gVkZjisYDier+uljgbcJl8TzUXheiWNGjx5aq5KPKm6muib2BZNJh4DILZZKw8fwIXV+t1sIktazo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209624; c=relaxed/simple;
	bh=+IH/6+Ara3js2iirQwbhKALB6r1+f4HqSPir2nxWY5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bwep5SNetE+N/HO1mdMJSQG4pF2RfOdftGNvSLaOu4BP1LHQQxjWTPRatJvsigvnVXOVYunVFU2VVZLQE9EaWpWVQds7oHX7aM4cJeCA/QeAp4llBtTHmnhprXV5tx6Q4NZZGUxgt7jNqyHVDMxmAVgag1TaJelXdUjHdohajFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f2NKCRbh; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f2NKCRbh"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-267c90c426dso241235ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 08:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758209622; x=1758814422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/D3R5hj5wqEEDPSgi7BBaRiyt65YSKMB3UvJpMxAys=;
        b=f2NKCRbh/p+U8hq/PGgHZWQhrBaCEtV5dr4yKyIsiFkcrj4a98aSAyEs5VvW+aJ8YY
         4SIKVmFWODIs7O1NJKEBzvw0/BeA+iZ3jJnGTFc2uqEGHrn+3BvM/IBuMX8S/1botvCv
         qCklY2KXVudf7aD83vBp5AUIVlKlmTHtwiXYIfxTzsv1FXDGOYs+9+eREumWksXPiF5J
         mGdQAemxiBYX0BjbRjbuDghCDJHlzSkRGA66cl91i0bssmaiyVjL6cB0kRQ4Yt19KcFF
         IyuU1ivrWe8ZpczaFCkZKZF7ESQSFG5bcd6GF+so66H7cgZaD8ptXfG4CTwGSXBS7Kgk
         zIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758209622; x=1758814422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/D3R5hj5wqEEDPSgi7BBaRiyt65YSKMB3UvJpMxAys=;
        b=P2cZJo+SIR6CWM9pAQ9FM1tqJL+enh5cQJDADn7DrKbSMW4j+M1IYehVSN+6LNXf7x
         PiZA7GYNDTQeQtdfmF7pHTnMZ0iLY8US3eyB5z1N9oEoZqGJvYPSZ/CJ9Xg/WIaR0XDi
         jjTbQJi26KKs8Q2KD4XJcffGBuK1jyL0hZ5fxzujKrCUs59MtrODOWG5X66gwt4DeJw2
         VHsvaOJB3104Q+LoOH/wOAJUVXOYVYBZu/3yY1nHHf5Jnoap6+pr/BSGbaco4wqaNt5q
         9Y+aVQVnh8VFn0gjbDCOZoZgcqA81rFYq492/rS2a9CO4hae/YuY6vAy9B23MjGS09je
         yaiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1omSciSeYYalnXagcW4qSnloAgtwQAmaVdBxN/U521t1cq+yYfweIQdQQVD/3sDwmutAahiEnNCUzOIw15ESI@vger.kernel.org
X-Gm-Message-State: AOJu0YwnQNtBMEdXKVgyu5zR31B7L1zebbTRzx8VvkCWJojXQayHblKq
	gnNdXRebyitucjgqcErA5A63MQtaZbp3xigt3sXlJFuVKROxGqHIGTg67qcK2xojklFpAOS9uVw
	67Gft6K9M5E1E3SZD0oGm9gbqDVQG0Q2DdHa1VpTP
X-Gm-Gg: ASbGncswsZKbSHC6nTzFuK10fSZMRX5TErG6DhrO+ek2rdoSuKaD9/Lg13Yv5Ptbboz
	24L3NLWHJCr2Y08JJ7JH2rMzs2yAcVzlG1+KnpkZJUcP1ZnAVz9DnMn5xaebpDYUoYu/HdCaPMc
	zLdScVEcBZ9J6+pCBZ8WvPIYvMF4OoIuHi/QIErvdXvEjriNsAlMsIkgfki62e/Vt8qN1hilIUK
	787UI/1fRTQl4qKwHSmIflWYzdAPUAHVN4uCVFGifZHLhZ7xcCw5PA08j3WKTHbkWuR2XcoCQ==
X-Google-Smtp-Source: AGHT+IHNG0OusN6PhAZS5Bt1MMDds8hLtDhtzz9mhedJzHPOG9JR/pys1gNFCkz0lwZvMdUvekp6y5CURQN503bAsGM=
X-Received: by 2002:a17:902:f54a:b0:267:a1d5:7376 with SMTP id
 d9443c01a7336-26800f660d1mr10270765ad.12.1758209622052; Thu, 18 Sep 2025
 08:33:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918063944.16331-1-namhyung@kernel.org> <20250918063944.16331-2-namhyung@kernel.org>
In-Reply-To: <20250918063944.16331-2-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 18 Sep 2025 08:33:30 -0700
X-Gm-Features: AS18NWC-OPCaGMIykeA7pKWFs7uEIjKZm8cXv1a-GsE6_mxpMLF2deM1EFgmpRA
Message-ID: <CAP-5=fVeYM7RJ0wW7S+9F+UnWW9pRphJMQhmBxT=V7zfmQF3cA@mail.gmail.com>
Subject: Re: [RFC/PATCH 2/2] perf check: Add 'pmu' subcommand
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 11:39=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> The 'perf check pmu' command will show information about PMUs in the
> system like below:
>
>   $ perf check pmu | head
>   cpu_atom: type =3D 10
>     core PMU: cpus =3D 16-27
>     caps: branches =3D 32
>     caps: max_precise =3D 3
>     caps: pmu_name =3D alderlake_hybrid
>   cpu_core: type =3D 4
>     core PMU: cpus =3D 0-15
>     caps: branches =3D 32
>     caps: max_precise =3D 3
>     caps: pmu_name =3D alderlake_hybrid
>
> The -q option will make it print the name and type of PMUs only.  It
> also takes arguments to show matching PMUs only.
>
>   $ perf check pmu -q uncore
>   uncore_arb_0: type =3D 27
>   uncore_arb_1: type =3D 28
>   uncore_cbox_0: type =3D 15
>   uncore_cbox_1: type =3D 16
>   uncore_cbox_2: type =3D 17
>   uncore_cbox_3: type =3D 18
>   uncore_cbox_4: type =3D 19
>   uncore_cbox_5: type =3D 20
>   uncore_cbox_6: type =3D 21
>   uncore_cbox_7: type =3D 22
>   uncore_cbox_8: type =3D 23
>   uncore_cbox_9: type =3D 24
>   uncore_cbox_10: type =3D 25
>   uncore_cbox_11: type =3D 26
>   uncore_clock: type =3D 29
>   uncore_imc_free_running_0: type =3D 32
>   uncore_imc_free_running_1: type =3D 33
>   uncore_imc_0: type =3D 30
>   uncore_imc_1: type =3D 31
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-check.txt | 12 +++++
>  tools/perf/builtin-check.c              | 60 ++++++++++++++++++++++++-
>  2 files changed, 71 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documen=
tation/perf-check.txt
> index 34dccc29d90d2fdf..2fa007698c0f0814 100644
> --- a/tools/perf/Documentation/perf-check.txt
> +++ b/tools/perf/Documentation/perf-check.txt
> @@ -11,6 +11,7 @@ SYNOPSIS
>  'perf check' [<options>]
>  'perf check' {feature <feature_list>} [<options>]
>  'perf check' {system <setting_list>} [<options>]
> +'perf check' {pmu <name_list>} [<options>]
>
>  DESCRIPTION
>  -----------
> @@ -26,6 +27,9 @@ is built-in, otherwise returns with exit status 1.
>  If the subcommand 'system' is used, then system settins are printed on
>  the standard output with explanation.
>
> +If the subcommand 'pmu' is used, then available PMU information is print=
ed
> +on the standard output with explanation.
> +
>  SUBCOMMANDS
>  -----------
>
> @@ -88,6 +92,14 @@ SUBCOMMANDS
>                 nmi_watchdog
>                 kptr_restrict
>
> +pmu::
> +
> +       Print PMU information available in the system.
> +
> +       Example Usage:
> +               perf check pmu
> +               perf check pmu <name>
> +
>
>  OPTIONS
>  -------
> diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
> index 1c7c6bb5da5ccbf2..f3d034a94b1227c7 100644
> --- a/tools/perf/builtin-check.c
> +++ b/tools/perf/builtin-check.c
> @@ -3,6 +3,8 @@
>  #include "color.h"
>  #include "util/debug.h"
>  #include "util/header.h"
> +#include "util/pmu.h"
> +#include "util/pmus.h"
>  #include <api/fs/fs.h>
>  #include <tools/config.h>
>  #include <stdbool.h>
> @@ -10,13 +12,14 @@
>  #include <string.h>
>  #include <subcmd/parse-options.h>
>
> -static const char * const check_subcommands[] =3D { "feature", "system",=
 NULL };
> +static const char * const check_subcommands[] =3D { "feature", "system",=
 "pmu", NULL };
>  static struct option check_options[] =3D {
>         OPT_BOOLEAN('q', "quiet", &quiet, "do not show any warnings or me=
ssages"),
>         OPT_END()
>  };
>  static struct option check_feature_options[] =3D { OPT_PARENT(check_opti=
ons) };
>  static struct option check_system_options[] =3D { OPT_PARENT(check_optio=
ns) };
> +static struct option check_pmu_options[] =3D { OPT_PARENT(check_options)=
 };
>
>  static const char *check_usage[] =3D { NULL, NULL };
>  static const char *check_feature_usage[] =3D {
> @@ -27,6 +30,10 @@ static const char *check_system_usage[] =3D {
>         "perf check system",
>         NULL
>  };
> +static const char *check_pmu_usage[] =3D {
> +       "perf check pmu",
> +       NULL
> +};
>
>  #define FEATURE_STATUS(name_, macro_) {    \
>         .name =3D name_,                     \
> @@ -278,6 +285,55 @@ static int subcommand_system(int argc, const char **=
argv)
>         return 0;
>  }
>
> +/**
> + * Usage: 'perf check pmu <names>'
> + *
> + * Show PMU information.
> + */
> +static int subcommand_pmu(int argc, const char **argv)
> +{
> +       struct perf_pmu *pmu =3D NULL;
> +       struct perf_pmu_caps *caps;
> +
> +       argc =3D parse_options(argc, argv, check_pmu_options, check_pmu_u=
sage, 0);
> +
> +       while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
> +               if (argc) {
> +                       bool found =3D false;
> +
> +                       /* only show entries match to command line argume=
nts */
> +                       for (int k =3D 0; k < argc; k++) {
> +                               if (strstr(pmu->name, argv[k])) {

To avoid divergence from parse-events it may be better to use
perf_pmu__wildcard_match? There is also
perf_pmus__scan_matching_wildcard.

> +                                       found =3D true;
> +                                       break;
> +                               }
> +                       }
> +                       if (!found)
> +                               continue;
> +               }
> +
> +               printf("%s: type =3D %u\n", pmu->name, pmu->type);
> +               if (quiet)
> +                       continue;
> +
> +               if (pmu->is_core || pmu->is_uncore) {
> +                       printf("  %score PMU", pmu->is_uncore ? "un" : ""=
);
> +                       if (!perf_cpu_map__is_empty(pmu->cpus)) {
> +                               printf(": %s =3D ", pmu->is_core ? "cpus"=
 : "cpumask");

The cpus file is only generally present on hybrid systems. I don't
think this needs to be core/uncore dependent - the only thing I've
ever seen fail that test are some ARM uncore PMUs. I'd always dump
this as cpumask, when !core and !uncore then the default all online
CPUs cpumask is important information as that probably isn't the
cpumask you want with an uncore PMU.

> +                               cpu_map__fprintf(pmu->cpus, stdout);
> +                       } else {
> +                               printf("\n");
> +                       }
> +               }
> +
> +               perf_pmu__caps_parse(pmu);
> +               list_for_each_entry(caps, &pmu->caps, list) {
> +                       printf("  caps: %s =3D %s\n", caps->name, caps->v=
alue);
> +               }
> +       }
> +       return 0;

If not found return an error?

Thanks,
Ian


> +}
> +
>  int cmd_check(int argc, const char **argv)
>  {
>         argc =3D parse_options_subcommand(argc, argv, check_options,
> @@ -290,6 +346,8 @@ int cmd_check(int argc, const char **argv)
>                 return subcommand_feature(argc, argv);
>         if (strcmp(argv[0], "system") =3D=3D 0)
>                 return subcommand_system(argc, argv);
> +       if (strcmp(argv[0], "pmu") =3D=3D 0)
> +               return subcommand_pmu(argc, argv);
>
>         /* If no subcommand matched above, print usage help */
>         pr_err("Unknown subcommand: %s\n", argv[0]);
> --
> 2.51.0
>
