Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E9F9CA5D
	for <linux-perf-users@vger.kernel.org>; Sat, 30 Sep 2023 06:19:12 +0000 (UTC)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A215F1AB
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Sep 2023 23:19:10 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7a26fd82847so49587739f.3
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Sep 2023 23:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696054750; x=1696659550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1MkJy7Wb/T3B4h0JC+qhG5J2ExdnVU7HQXNJjtkmVk=;
        b=pDlmXW/NADMVRNqFw3iCp4Q++niL9gHEHNmcmglNsrIMJifG5Z/ArXStadEGPfOteJ
         n9BBf8L0rJ1lGr7e+Cbaa8irBCTaa/Jmp5cyogHEHsnwmlmThyEJmYoHpoUxdRHcw4pu
         v3as39o6X84Yx7iwb/oRsGf+mgMGc6Dc9J/JkiDT4MNKmPQvaI2F1RgMwU/Ju9QLJhaO
         2o6VQZk8tAXOy1t+kAU3wyz48t7tfWmk/M1bJahSpWxj/AXGIPQRDQUkKz1KW5CqhBQK
         ihPsIBeHfj4M2Hd3y59y0lIaYC1ANaiicVKM6+rik8KLPKWlr/nTbHPldNVzGaRm7utY
         MULA==
X-Gm-Message-State: AOJu0YzFR0I2cSo61oo9mtwMVIhiCfT5Oiq/WpFV1BoXXWfTKKWTgAXe
	Z2cq5hjogXZQ83+Zu0t5XQujIz3nPii+rR0JaNM=
X-Google-Smtp-Source: AGHT+IEqDOVT6xBi87Pj7SFKTyw5+Vm3GNsYkQshly9C/ayyXDTZe6FiQuf7gGpK21wg4VlOmMj58ww9MBEf2kMoANM=
X-Received: by 2002:a6b:fd0b:0:b0:79f:a36e:bd1f with SMTP id
 c11-20020a6bfd0b000000b0079fa36ebd1fmr6889766ioi.5.1696054749639; Fri, 29 Sep
 2023 23:19:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230929055757.83174-1-adityag@linux.ibm.com> <20230929055757.83174-2-adityag@linux.ibm.com>
In-Reply-To: <20230929055757.83174-2-adityag@linux.ibm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 29 Sep 2023 23:18:57 -0700
Message-ID: <CAM9d7ciYngXfyVdPfnknkQLy-7oi0H=1Ufn9yKgp3h_MuAEb_A@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] perf check: introduce check subcommand
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, irogers@google.com, 
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com, 
	atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

On Thu, Sep 28, 2023 at 10:58=E2=80=AFPM Aditya Gupta <adityag@linux.ibm.co=
m> wrote:
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
>
> 'perf check --feature' command is expected to have exit status of 1 if
> feature is built-in, and 0 if it's not built-in or if feature is not know=
n.
>
> An array 'supported_features' has also been introduced that can be used b=
y
> other commands like 'perf version --build-options', so that new features
> can be added in one place, with the array
>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>  tools/perf/Build                        |   1 +
>  tools/perf/Documentation/perf-check.txt |  56 +++++++++++
>  tools/perf/builtin-check.c              | 122 ++++++++++++++++++++++++
>  tools/perf/builtin.h                    |  18 ++++
>  tools/perf/perf.c                       |   1 +
>  5 files changed, 198 insertions(+)
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
> index 000000000000..5cf6ab7df8c3
> --- /dev/null
> +++ b/tools/perf/Documentation/perf-check.txt
> @@ -0,0 +1,56 @@
> +perf-check(1)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +NAME
> +----
> +perf-check - check features in perf
> +
> +SYNOPSIS
> +--------
> +'perf check' [-q] [--feature]

I think it's better to say like below for later changes.

'perf check' [<options>]

> +
> +DESCRIPTION
> +-----------
> +With no options given, the 'perf check' just prints the perf version
> +on the standard output.
> +
> +If the option '--feature' is given, then status of feature is printed
> +on the standard output, ie. whether it is compiled-in/built-in or not
> +
> +OPTIONS
> +-------
> +-q::
> +               Do not print any messages or warnings
> +
> +--feature::
> +        Print whether a feature is compiled-in or not. A feature name/ma=
cro is
> +        required to be passed after this flag
> +
> +        Example Usage:
> +                perf check --feature libtraceevent
> +                perf check --feature HAVE_LIBTRACEEVENT
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
> diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
> new file mode 100644
> index 000000000000..da7ee93bbbf5
> --- /dev/null
> +++ b/tools/perf/builtin-check.c
> @@ -0,0 +1,122 @@
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
> +       OPT_STRING(0, "feature", &check.feature, NULL, "check if a featur=
e is built in"),
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
> +
> +       // this should remain at end, to know the array end

We prefer C-style comments using /* ... */.

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
 %s", feature);
> +
> +       return 0;
> +}
> +
> +int cmd_check(int argc, const char **argv)
> +{
> +       argc =3D parse_options(argc, argv, check_options, check_usage,
> +                            PARSE_OPT_STOP_AT_NON_OPTION);
> +
> +       if (!quiet)
> +               printf("perf check %s\n", perf_version_string);
> +
> +       if (check.feature)
> +               return has_support(check.feature);

Oh, sorry for making you confused.  I think it'd be better to exit with 0
for success and 1 (or other) for failure to conform to the shell
convention.  You may invert the return value from the function.

Thanks,
Namhyung


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
> 2.41.0
>
