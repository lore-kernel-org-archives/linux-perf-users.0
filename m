Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC621E50B
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jan 2024 23:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-595b208a050so67095eaf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Jan 2024 15:29:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704497397; x=1705102197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enAJrNIuVoDnISEz7sGdWrYfhQOKSOR3aq5q5+RexgY=;
        b=leVvokL7WxrGNrFbCkQf2ksHa0n1+9PcvQbABYXIwkcCEZU+hckNGO/uYmx1MfvbRA
         cG+m1Sc0zeKeCuqq8sWY/IIaC/2YIkxmmOkdpMU0pQXQbZRXUPS+r80Ji5LM/YBXPHeh
         nC5eNFRgv1ZKZQEeKF0eibNouzrFXc9wNBdTtqtyvMpuRvr7YXlfkNQLA6KBjAqsFLzY
         5cbU97WVycRgew/Qx6KtS6xP7X1MA5xkaao34Bff+hzzYKUGFwy4zYu2IFwYmVSWp2cH
         CB+dlStKhNEG5/IAtdvQhE0pc14QLGhdcC75SxKh5XpYOrhs1B2vqHbBo6PJKM8jNTq3
         ykpA==
X-Gm-Message-State: AOJu0YxlhRycSWNyCt6ofDwf/Leg14jpW1o6eKWVgnHqB860BJoSLLCV
	ijPGYVEKmGeamh9vJWNG+bXfmxTnB7Ogc4+XVc0=
X-Google-Smtp-Source: AGHT+IHKpidfVS5E4WAqrpS0txtzjVW/xFyjl+VtVxwH7sqd2/IhO4MdxZy+MzHLJxjpAMxNx/JOzkFTw7JOJ+bqDxs=
X-Received: by 2002:a05:6358:2917:b0:174:f7a9:bece with SMTP id
 y23-20020a056358291700b00174f7a9becemr336542rwb.5.1704497396809; Fri, 05 Jan
 2024 15:29:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204093954.304030-1-adityag@linux.ibm.com> <20231204093954.304030-2-adityag@linux.ibm.com>
In-Reply-To: <20231204093954.304030-2-adityag@linux.ibm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 5 Jan 2024 15:29:45 -0800
Message-ID: <CAM9d7chCNODsbF4wgZPRSXumPAe7NvuOR+gF2Ha6C51JYdHFVw@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] perf check: introduce check subcommand
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, irogers@google.com, 
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com, 
	atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Dec 4, 2023 at 1:40=E2=80=AFAM Aditya Gupta <adityag@linux.ibm.com>=
 wrote:
>
> Currently the presence of a feature is checked with a combination of
> perf version --build-options and greps, such as:
>
>     perf version --build-options | grep " on .* HAVE_FEATURE"
>
> Instead of this, introduce a subcommand "perf check --feature", with whic=
h
> scripts can test for presence of a feature, such as:
>
>     perf check --feature HAVE_FEATURE

Can you please change it to a sub-command instead of an option?
Like "perf check feature HAVE_FEATURE" (without dashes).

I think it's more appropriate since it's intended to return a result.
IMHO options should be used to control (optional) behaviors.
Later, we might add other checking behavior then using it
together with this won't make sense.  Making it a subcommand
would prevent that.

>
> 'perf check --feature' command is expected to have exit status of 0 if
> feature is built-in, and 1 if it's not built-in or if feature is not know=
n.
>
> Multiple features can also be passed as a comma-separated list, in which
> case the exit status will be 1 only if all of the passed features are
> built-in. For example, with below command, it will have exit status of 1 =
only
> if both libtraceevent and bpf are enabled, else 0 in all other cases
>
>     perf check --feature libtraceevent,bpf
>
> An array 'supported_features' has also been introduced that can be used b=
y
> other commands like 'perf version --build-options', so that new features
> can be added in one place, with the array
>
> Reviewed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>  tools/perf/Build                        |   1 +
>  tools/perf/Documentation/perf-check.txt |  65 ++++++++++
>  tools/perf/builtin-check.c              | 155 ++++++++++++++++++++++++
>  tools/perf/builtin.h                    |  18 +++
>  tools/perf/perf.c                       |   1 +
>  5 files changed, 240 insertions(+)
>  create mode 100644 tools/perf/Documentation/perf-check.txt
>  create mode 100644 tools/perf/builtin-check.c
>
> diff --git a/tools/perf/Build b/tools/perf/Build
> index aa7623622834..a55a797c1b5f 100644
> --- a/tools/perf/Build
> +++ b/tools/perf/Build
> @@ -1,5 +1,6 @@
>  perf-y +=3D builtin-bench.o
>  perf-y +=3D builtin-annotate.o
> +perf-y +=3D builtin-check.o
>  perf-y +=3D builtin-config.o
>  perf-y +=3D builtin-diff.o
>  perf-y +=3D builtin-evlist.o
> diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documen=
tation/perf-check.txt
> new file mode 100644
> index 000000000000..dfb1dddd0ac3
> --- /dev/null
> +++ b/tools/perf/Documentation/perf-check.txt
> @@ -0,0 +1,65 @@
> +perf-check(1)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +NAME
> +----
> +perf-check - check features in perf
> +
> +SYNOPSIS
> +--------
> +'perf check' [<options>]
> +
> +DESCRIPTION
> +-----------
> +With no options given, the 'perf check' just prints the perf version
> +on the standard output.
> +
> +If the option '--feature' is given, then status of feature is printed
> +on the standard output (unless '-q' is also passed), ie. whether it is
> +compiled-in/built-in or not.
> +Also, 'perf check --feature' returns with exit status 0 if the feature
> +is built-in, otherwise returns with exit status 1.
> +
> +OPTIONS
> +-------
> +-q::
> +               Do not print any messages or warnings
> +
> +--feature::
> +        Print whether feature(s) is compiled-in or not. A feature name/m=
acro is
> +        required to be passed after this flag
> +
> +        Multiple features can also be passed as a comma-separated list, =
in which
> +        case the exit status will be 1 only if all of the passed feature=
s are

Do you mean 0 instead of 1?

> +        compiled-in.
> +
> +        Example Usage:
> +                perf check --feature libtraceevent
> +                perf check --feature HAVE_LIBTRACEEVENT
> +                perf check --feature libtraceevent,bpf
> +
> +        Supported feature names/macro:
> +                dwarf      /  HAVE_DWARF_SUPPORT
> +                dwarf_getlocations  /  HAVE_DWARF_GETLOCATIONS_SUPPORT
> +                libaudit   /  HAVE_LIBAUDIT_SUPPORT
> +                syscall_table       /  HAVE_SYSCALL_TABLE_SUPPORT
> +                libbfd     /  HAVE_LIBBFD_SUPPORT
> +                debuginfod /  HAVE_DEBUGINFOD_SUPPORT
> +                libelf     /  HAVE_LIBELF_SUPPORT
> +                libnuma    /  HAVE_LIBNUMA_SUPPORT
> +                numa_num_possible_cpus  /  HAVE_LIBNUMA_SUPPORT
> +                libperl    /  HAVE_LIBPERL_SUPPORT
> +                libpython  /  HAVE_LIBPYTHON_SUPPORT
> +                libslang   /  HAVE_SLANG_SUPPORT
> +                libcrypto  /  HAVE_LIBCRYPTO_SUPPORT
> +                libunwind  /  HAVE_LIBUNWIND_SUPPORT
> +                libdw-dwarf-unwind  /  HAVE_DWARF_SUPPORT
> +                zlib       /  HAVE_ZLIB_SUPPORT
> +                lzma       /  HAVE_LZMA_SUPPORT
> +                get_cpuid  /  HAVE_AUXTRACE_SUPPORT
> +                bpf        /  HAVE_LIBBPF_SUPPORT
> +                aio        /  HAVE_AIO_SUPPORT
> +                zstd       /  HAVE_ZSTD_SUPPORT
> +                libpfm4    /  HAVE_LIBPFM
> +                libtraceevent      /  HAVE_LIBTRACEEVENT
> +                bpf_skeletons      /  HAVE_BPF_SKEL

Is it case-sensitive?  Maybe better not.

Thanks,
Namhyung


> diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
> new file mode 100644
> index 000000000000..f121d657a7bc
> --- /dev/null
> +++ b/tools/perf/builtin-check.c
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "builtin.h"
> +#include "color.h"
> +#include "util/debug.h"
> +#include "util/header.h"
> +#include <tools/config.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <subcmd/parse-options.h>
> +
> +struct check {
> +       const char *feature;
> +};
> +
> +static struct check check;
> +
> +static struct option check_options[] =3D {
> +       OPT_STRING(0, "feature", &check.feature, NULL, "check if feature(=
s) is built in"),
> +       OPT_BOOLEAN('q', "quiet", &quiet, "do not show any warnings or me=
ssages"),
> +       OPT_END(),
> +};
> +
> +static const char * const check_usage[] =3D {
> +       "perf check [<options>]",
> +       NULL
> +};
> +
> +struct feature_support supported_features[] =3D {
> +       FEATURE_SUPPORT("dwarf", HAVE_DWARF_SUPPORT),
> +       FEATURE_SUPPORT("dwarf_getlocations", HAVE_DWARF_GETLOCATIONS_SUP=
PORT),
> +       FEATURE_SUPPORT("libaudit", HAVE_LIBAUDIT_SUPPORT),
> +       FEATURE_SUPPORT("syscall_table", HAVE_SYSCALL_TABLE_SUPPORT),
> +       FEATURE_SUPPORT("libbfd", HAVE_LIBBFD_SUPPORT),
> +       FEATURE_SUPPORT("debuginfod", HAVE_DEBUGINFOD_SUPPORT),
> +       FEATURE_SUPPORT("libelf", HAVE_LIBELF_SUPPORT),
> +       FEATURE_SUPPORT("libnuma", HAVE_LIBNUMA_SUPPORT),
> +       FEATURE_SUPPORT("numa_num_possible_cpus", HAVE_LIBNUMA_SUPPORT),
> +       FEATURE_SUPPORT("libperl", HAVE_LIBPERL_SUPPORT),
> +       FEATURE_SUPPORT("libpython", HAVE_LIBPYTHON_SUPPORT),
> +       FEATURE_SUPPORT("libslang", HAVE_SLANG_SUPPORT),
> +       FEATURE_SUPPORT("libcrypto", HAVE_LIBCRYPTO_SUPPORT),
> +       FEATURE_SUPPORT("libunwind", HAVE_LIBUNWIND_SUPPORT),
> +       FEATURE_SUPPORT("libdw-dwarf-unwind", HAVE_DWARF_SUPPORT),
> +       FEATURE_SUPPORT("zlib", HAVE_ZLIB_SUPPORT),
> +       FEATURE_SUPPORT("lzma", HAVE_LZMA_SUPPORT),
> +       FEATURE_SUPPORT("get_cpuid", HAVE_AUXTRACE_SUPPORT),
> +       FEATURE_SUPPORT("bpf", HAVE_LIBBPF_SUPPORT),
> +       FEATURE_SUPPORT("aio", HAVE_AIO_SUPPORT),
> +       FEATURE_SUPPORT("zstd", HAVE_ZSTD_SUPPORT),
> +       FEATURE_SUPPORT("libpfm4", HAVE_LIBPFM),
> +       FEATURE_SUPPORT("libtraceevent", HAVE_LIBTRACEEVENT),
> +       FEATURE_SUPPORT("bpf_skeletons", HAVE_BPF_SKEL),
> +
> +       /* this should remain at end, to know the array end */
> +       FEATURE_SUPPORT(NULL, _)
> +};
> +
> +static void on_off_print(const char *status)
> +{
> +       printf("[ ");
> +
> +       if (!strcmp(status, "OFF"))
> +               color_fprintf(stdout, PERF_COLOR_RED, "%-3s", status);
> +       else
> +               color_fprintf(stdout, PERF_COLOR_GREEN, "%-3s", status);
> +
> +       printf(" ]");
> +}
> +
> +static void status_print(const char *name, const char *macro,
> +                        const char *status)
> +{
> +       printf("%22s: ", name);
> +       on_off_print(status);
> +       printf("  # %s\n", macro);
> +}
> +
> +#define STATUS(feature)                                   \
> +do {                                                      \
> +       if (feature.is_builtin)                               \
> +               status_print(feature.name, feature.macro, "on");  \
> +       else                                                  \
> +               status_print(feature.name, feature.macro, "OFF"); \
> +} while (0)
> +
> +/**
> + * check whether "feature" is built-in with perf
> + *
> + * returns:
> + *    0: NOT built-in or Feature not known
> + *    1: Built-in
> + */
> +static int has_support(const char *feature)
> +{
> +       for (int i =3D 0; supported_features[i].name; ++i) {
> +               if ((strcmp(feature, supported_features[i].name) =3D=3D 0=
) ||
> +                   (strcmp(feature, supported_features[i].macro) =3D=3D =
0)) {
> +                       if (!quiet)
> +                               STATUS(supported_features[i]);
> +                       return supported_features[i].is_builtin;
> +               }
> +       }
> +
> +       if (!quiet)
> +               color_fprintf(stdout, PERF_COLOR_RED, "Feature not known:=
 '%s'\n", feature);
> +
> +       return 0;
> +}
> +
> +int cmd_check(int argc, const char **argv)
> +{
> +       char *feature_list;
> +       char *feature_name;
> +       int feature_enabled;
> +       int buf_len;
> +
> +       argc =3D parse_options(argc, argv, check_options, check_usage,
> +                            PARSE_OPT_STOP_AT_NON_OPTION);
> +
> +       if (check.feature) {
> +               /* check.feature can be a single feature name, or a comma=
-separated list
> +                * of feature names.
> +                * eg. check.feature can be "libtraceevent" or
> +                * "libtraceevent,bpf" etc
> +                *
> +                * In case of a comma-separated list, feature_enabled wil=
l be 1, only if
> +                * all features passed in the string are supported
> +                * Note that check.feature will get modified due to strto=
k and str_trim
> +                */
> +               feature_enabled =3D 1;
> +               buf_len =3D strlen(check.feature) + 1;
> +               /* feature_list is a non-const copy of 'check.feature' */
> +               feature_list =3D malloc(buf_len * sizeof(char));
> +               if (!feature_list) {
> +                       color_fprintf(stdout, PERF_COLOR_RED,
> +                                       "ERROR: failed to allocate memory=
 for feature list");
> +                       return -1;
> +               }
> +
> +               memcpy(feature_list, check.feature, buf_len);
> +               feature_name =3D strtok(feature_list, ",");
> +
> +               while (feature_name) {
> +                       feature_enabled &=3D has_support(feature_name);
> +                       feature_name =3D strtok(NULL, ",");
> +               }
> +
> +               free(feature_list);
> +
> +               return !feature_enabled;
> +       }
> +
> +       return 0;
> +}
> diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
> index f2ab5bae2150..9f895981bc9e 100644
> --- a/tools/perf/builtin.h
> +++ b/tools/perf/builtin.h
> @@ -2,6 +2,23 @@
>  #ifndef BUILTIN_H
>  #define BUILTIN_H
>
> +#include <stddef.h>
> +#include <linux/compiler.h>
> +#include <tools/config.h>
> +
> +struct feature_support {
> +       const char *name;
> +       const char *macro;
> +       int is_builtin;
> +};
> +
> +#define FEATURE_SUPPORT(name_, macro_) { \
> +       .name =3D name_,                       \
> +       .macro =3D #macro_,                    \
> +       .is_builtin =3D IS_BUILTIN(macro_) }
> +
> +extern struct feature_support supported_features[];
> +
>  void list_common_cmds_help(void);
>  const char *help_unknown_cmd(const char *cmd);
>
> @@ -9,6 +26,7 @@ int cmd_annotate(int argc, const char **argv);
>  int cmd_bench(int argc, const char **argv);
>  int cmd_buildid_cache(int argc, const char **argv);
>  int cmd_buildid_list(int argc, const char **argv);
> +int cmd_check(int argc, const char **argv);
>  int cmd_config(int argc, const char **argv);
>  int cmd_c2c(int argc, const char **argv);
>  int cmd_diff(int argc, const char **argv);
> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index d3fc8090413c..6514f4121c49 100644
> --- a/tools/perf/perf.c
> +++ b/tools/perf/perf.c
> @@ -50,6 +50,7 @@ static struct cmd_struct commands[] =3D {
>         { "archive",    NULL,   0 },
>         { "buildid-cache", cmd_buildid_cache, 0 },
>         { "buildid-list", cmd_buildid_list, 0 },
> +       { "check",      cmd_check,      0 },
>         { "config",     cmd_config,     0 },
>         { "c2c",        cmd_c2c,        0 },
>         { "diff",       cmd_diff,       0 },
> --
> 2.42.0
>
