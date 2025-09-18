Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C3923B616
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210505; cv=none; b=N7XE6V3XJmg0Dkvp5DHCNAT1xmpOQgxjuXO4NOEX9WS+5+l9QONrnsxZR7y6mO2WD4Ql3XHebelj3mFqS1tpeEJNIdsVpEOu4IU+GbRH6+G/MlVenVy7j1nOx7EE50ce1bUjToQ3A2TEwaCpFal6Cb+SCJK5l2bPL2oVt5S6OWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210505; c=relaxed/simple;
	bh=OVohnyVhLf5T24J1Y7oEnLoDBfMrF00Ecfqof2AUM6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tM1GuTxsKBusXLzDXLuFub1ysxu9z1B7Xe9Y1z1eHr5bUrqvB5QR6ttedRR2lnAULlteWcTCuOm1bgyoz0W6s0JXfi9EY4U4Ru9Bh2CLP5lozGDeK8yaYzXqegno0U7qMfe1HnY10VdvIkeDXAjVNUFPQ3b1uHVdSSQ46nKXfTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f+sQUIc9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f+sQUIc9"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-267c90c426dso245755ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 08:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758210502; x=1758815302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABbWXtLT9Tem//sob+wqU2AgqkC5UZMRqd7mBmeRtRg=;
        b=f+sQUIc9rGbEipPLc+iMwsYMD3rz9IsHPbey+mU128a+R/PC2aX62O/pZkcmfxHzFt
         Go3XXuj/fVJXEYtcV2XS9ARNFD+FJAJxBqpaLGLfWj/LtKbnIJ1k+OG8hIiM8NjnZS20
         QL6BXKES4ttZR9e5TYu1qaDwVrmqATSrioWyOVbkZmdIH8MKI86RBUJa+Nuuqu56J1JZ
         LPrjNbGLtih8Mxe9xSa0skD8Qza6nG8iS2QGpViKJtj5dAk8ZTXZ0cRdewAppK0a7BJ2
         JljkOn/e4Tx+EDwLy3CMqPai35WnOOeOg+KkQ5MBzgO7tBaLR/CRW0dVZFOxQge/GSBy
         +VHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210502; x=1758815302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABbWXtLT9Tem//sob+wqU2AgqkC5UZMRqd7mBmeRtRg=;
        b=E+ENctjzz/F/GfGRG2lTzTMTBe4aRIXhemTlRiCVKPHACYkZ4EitKWPddvyVjDMSBr
         OwlYO8ob3oEOCtaYEKi+Os6OQfW9BxmH979EslsgWE8QcbvjrLTcHyonusZAgRTXVJtt
         U1YxKrwMBB2P5mFANhejjlJA0Il5tRzSZA5xHqOjaGcwmvMKIBUllKChh8ifWu3cZ54m
         AGm9LJMqA0rktftXF+ECVM4slP903LcCcPMTh52LC2Nd2hu3lVQyYe9oislcjAy8XFOJ
         b7DvdPT0BUGF6mt26IXsZjLiIByN8z/PTDzmsaS1CQGviwsSJyPAC0tYkvCg4/O0hu8/
         lI0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKRUJzKE3EYCNz2VcmKyV9LPKCpVQvZ4YAF7Uwn93UOjbbGbmLNCVM5TRVxCWJqVGU2rYUz87M2ezF/r0XpsUr@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4AdiJ0gvz6OHa+PJRoyNOImi/WsrQSwOitgU5+aS8K6zLwM51
	25Ed4qrINcAdVpNlxN2aV9j8ODUUNXAEoS0jokmBxhoz6u2TWxa+Tzov/iDYfe8SAiVqRiRcVe0
	tsAmcqefBtjVcguxKHWnRRfi35Sp/fuA0snty7ngU
X-Gm-Gg: ASbGnctavkmDULDTZ2LdAqd/UT5OmJcPlOKsLeCObGcLPLAbqKj0wo4gQ1OckBkYra9
	P+aqvAV2tBoG55jKvZ11k/3m86VJeO2X/feI68fmJ8G+zbl3VjbkfT2ln+8xTPXJwIeBlXvX3qj
	Hs3F6rFM1rFHlJ4BO74eWQZKR2P0fjPsK+vng3roQUi3Kt57wmW773sT/QqELObYkajI5vODwaz
	NusNO9hL/WDWbBJR7zazb+s6BeNCyihUQNMoihAOBWrx1P3D/+jma/+L5kZLfg=
X-Google-Smtp-Source: AGHT+IHkWZBD4+AiHBE92/4cPg/M+NS/l+PSxeUW1OKZMMEvW+vuOX9xQoB1feOy5BmVf8ra4h0LeutC6OOYCfiJr6M=
X-Received: by 2002:a17:902:c40d:b0:25b:fba3:afb5 with SMTP id
 d9443c01a7336-26808ad1016mr10519905ad.11.1758210501905; Thu, 18 Sep 2025
 08:48:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918063944.16331-1-namhyung@kernel.org>
In-Reply-To: <20250918063944.16331-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 18 Sep 2025 08:48:10 -0700
X-Gm-Features: AS18NWDFNFct_ayl7wcaTDAYADbAh50UJmqwghs2NJlhzGiI6bfhvidN4bJNIng
Message-ID: <CAP-5=fVAsDN50X07zpnxikS_tA2cw92YJwHR2f9RVs0fc8j-Ng@mail.gmail.com>
Subject: Re: [RFC/PATCH 1/2] perf check: Add 'system' subcommand
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
> The 'perf check system' is to check sysctl settings related to perf.
> By default it'd print the following output.
>
>   $ perf check system
>   perf_event_paranoid  =3D 2      # non-root can profile user code only
>   perf_event_max_stack =3D 127    # maximum callchain length
>   perf_event_mlock_kb  =3D 516    # maximum ring buffer size (including a=
 header page) for non-root
>   nmi_watchdog         =3D 1      # a hardware PMU counter may be used by=
 the kernel
>   kptr_restrict        =3D 0      # kernel pointers are printed as-is
>
> The -q option suppresses the description.  It can also take command line
> argument to match specific items.
>
>   $ perf check system -q nmi
>   nmi_watchdog         =3D 1
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-check.txt |  20 ++++
>  tools/perf/builtin-check.c              | 116 +++++++++++++++++++++++-
>  2 files changed, 135 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documen=
tation/perf-check.txt
> index ee92042082f73121..34dccc29d90d2fdf 100644
> --- a/tools/perf/Documentation/perf-check.txt
> +++ b/tools/perf/Documentation/perf-check.txt
> @@ -10,6 +10,7 @@ SYNOPSIS
>  [verse]
>  'perf check' [<options>]
>  'perf check' {feature <feature_list>} [<options>]
> +'perf check' {system <setting_list>} [<options>]
>
>  DESCRIPTION
>  -----------
> @@ -22,6 +23,9 @@ compiled-in/built-in or not.
>  Also, 'perf check feature' returns with exit status 0 if the feature
>  is built-in, otherwise returns with exit status 1.
>
> +If the subcommand 'system' is used, then system settins are printed on
> +the standard output with explanation.
> +
>  SUBCOMMANDS
>  -----------
>
> @@ -69,6 +73,22 @@ SUBCOMMANDS
>                  zlib                    /  HAVE_ZLIB_SUPPORT
>                  zstd                    /  HAVE_ZSTD_SUPPORT
>
> +system::
> +
> +       Print system settings (sysctl) that affect perf behaviors.
> +
> +       Example Usage:
> +               perf check system
> +               perf check system watchdog
> +
> +       Supported settings:
> +               perf_event_paranoid
> +               perf_event_max_stack
> +               perf_event_mlock_kb
> +               nmi_watchdog
> +               kptr_restrict
> +
> +
>  OPTIONS
>  -------
>  -q::
> diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
> index b1e205871ab17a77..1c7c6bb5da5ccbf2 100644
> --- a/tools/perf/builtin-check.c
> +++ b/tools/perf/builtin-check.c
> @@ -3,24 +3,30 @@
>  #include "color.h"
>  #include "util/debug.h"
>  #include "util/header.h"
> +#include <api/fs/fs.h>
>  #include <tools/config.h>
>  #include <stdbool.h>
>  #include <stdio.h>
>  #include <string.h>
>  #include <subcmd/parse-options.h>
>
> -static const char * const check_subcommands[] =3D { "feature", NULL };
> +static const char * const check_subcommands[] =3D { "feature", "system",=
 NULL };
>  static struct option check_options[] =3D {
>         OPT_BOOLEAN('q', "quiet", &quiet, "do not show any warnings or me=
ssages"),
>         OPT_END()
>  };
>  static struct option check_feature_options[] =3D { OPT_PARENT(check_opti=
ons) };
> +static struct option check_system_options[] =3D { OPT_PARENT(check_optio=
ns) };
>
>  static const char *check_usage[] =3D { NULL, NULL };
>  static const char *check_feature_usage[] =3D {
>         "perf check feature <feature_list>",
>         NULL
>  };
> +static const char *check_system_usage[] =3D {
> +       "perf check system",
> +       NULL
> +};
>
>  #define FEATURE_STATUS(name_, macro_) {    \
>         .name =3D name_,                     \
> @@ -166,6 +172,112 @@ static int subcommand_feature(int argc, const char =
**argv)
>         return !feature_enabled;
>  }
>
> +static int read_sysctl_kernel_int(const char *name)
> +{
> +       char path[128];
> +       int value;
> +
> +       scnprintf(path, sizeof(path), "kernel/%s", name);
> +       if (sysctl__read_int(path, &value))
> +               return INT_MAX;
> +
> +       return value;
> +}
> +
> +static const char *system_help_perf_event_paranoid(int value)
> +{
> +       if (value =3D=3D 2)
> +               return "non-root can profile user code only";
> +       if (value =3D=3D 1)
> +               return "non-root can profile kernel and user code";
> +       if (value =3D=3D 0)
> +               return "non-root can profile system-wide w/o tracepoints =
data";
> +       if (value < 0)
> +               return "no restrictions";
> +
> +       return "non-root cannot use perf event";
> +}
> +
> +static const char *system_help_perf_event_max_stack(int value __maybe_un=
used)
> +{
> +       return "maximum callchain length";
> +}
> +
> +static const char *system_help_perf_event_mlock_kb(int value __maybe_unu=
sed)
> +{
> +       return "maximum ring buffer size (including a header page) for no=
n-root";
> +}
> +
> +static const char *system_help_nmi_watchdog(int value)
> +{
> +       if (value)
> +               return "a hardware PMU counter may be used by the kernel"=
;
> +
> +       return "perf can use full PMU counters";
> +}
> +
> +static const char *system_help_kptr_restrict(int value)
> +{
> +       if (value =3D=3D 0)
> +               return "kernel pointers are printed as-is";
> +       if (value =3D=3D 1)
> +               return "non-root cannot see the kernel pointers";
> +       if (value =3D=3D 2)
> +               return "root may not see some kernel pointers";
> +
> +       return "unknown value";
> +}
> +
> +/**
> + * Usage: 'perf check system <settings>'
> + *
> + * Show system settings that affect perf behavior.
> + */
> +static int subcommand_system(int argc, const char **argv)
> +{
> +#define PERF_SYSCTL(name) { #name, system_help_##name }
> +       struct {
> +               const char *name;
> +               const char *(*help)(int value);
> +       } sysctls[] =3D {
> +               PERF_SYSCTL(perf_event_paranoid),
> +               PERF_SYSCTL(perf_event_max_stack),
> +               PERF_SYSCTL(perf_event_mlock_kb),
> +               PERF_SYSCTL(nmi_watchdog),
> +               PERF_SYSCTL(kptr_restrict),
> +       };
> +#undef PERF_SYSCTL
> +
> +       argc =3D parse_options(argc, argv, check_system_options,
> +                            check_system_usage, 0);
> +
> +       for (size_t i =3D 0; i < ARRAY_SIZE(sysctls); i++) {
> +               int value;
> +
> +               if (argc) {
> +                       bool found =3D false;
> +
> +                       /* only show entries match to command line argume=
nts */
> +                       for (int k =3D 0; k < argc; k++) {
> +                               if (strstr(sysctls[i].name, argv[k])) {
> +                                       found =3D true;
> +                                       break;
> +                               }
> +                       }
> +                       if (!found)
> +                               continue;
> +               }
> +
> +               value =3D read_sysctl_kernel_int(sysctls[i].name);
> +               printf("%-20s =3D %d", sysctls[i].name, value);
> +               if (!quiet)
> +                       printf("\t# %s", sysctls[i].help(value));
> +               printf("\n");
> +       }
> +
> +       return 0;

This looks useful! Rather than returning 0 should this return
something indicating whether perf does or doesn't have the permission?
In that case, what about root? We have this pattern in our shell
tests:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/lib/stat_output.sh?h=3Dperf-tools-next
```
function ParanoidAndNotRoot()
{
[ "$(id -u)" !=3D 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -g=
t $1 ]
}
```
I wonder things like this can use these values instead.

Thanks,
Ian


> +}
> +
>  int cmd_check(int argc, const char **argv)
>  {
>         argc =3D parse_options_subcommand(argc, argv, check_options,
> @@ -176,6 +288,8 @@ int cmd_check(int argc, const char **argv)
>
>         if (strcmp(argv[0], "feature") =3D=3D 0)
>                 return subcommand_feature(argc, argv);
> +       if (strcmp(argv[0], "system") =3D=3D 0)
> +               return subcommand_system(argc, argv);
>
>         /* If no subcommand matched above, print usage help */
>         pr_err("Unknown subcommand: %s\n", argv[0]);
> --
> 2.51.0
>
