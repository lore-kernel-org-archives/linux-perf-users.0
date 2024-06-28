Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8462925634
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719599867; cv=none; b=h37p3J6wHeal35zjWrApo3WlshbJWP2LzHAFP3Yu5pQ3faBMxYDqYYnhnFQnMt/KJJSHjI02ruJ5fkyAq6dSolkAnDVF0MUiEzidwyk5CYSQ/ZB8Vvgz2irdk5fiQ8/wtHbxayf/CS8Eai16rDh4uGgmI42M8yhQ75HUhkytemM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719599867; c=relaxed/simple;
	bh=arqojqVuLArHESnq4PDP8+tsFdpLUrHUv3IUH4mJ0JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRxs7LMdy9yRBYSnqiRRZt8j5J5WS8JO59WxG8bVlTFfeFXeL1Q935bqGyDucd5+8djE68xfRrxaUUW5k8pzOJ0Gl7TAAZr8WT+Gx98VcLF6tj8DLniEhg4xR1o/qumbpSJdLX4aVoGbJ2Wq+9yX9rCWsF8Kb0YCXV0+U8eLXJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csnRah5N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csnRah5N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFEAC116B1;
	Fri, 28 Jun 2024 18:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719599867;
	bh=arqojqVuLArHESnq4PDP8+tsFdpLUrHUv3IUH4mJ0JU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=csnRah5NLCIMzHRLxeqIY16k+lwd9UbFCMWIxMLIO4TcR1XnYS2SWxjsBl2wVM5lo
	 GFrZ5GtID8P9h4xUsNY/9xrnGEIg4a8eEAXOidw7lH+1dzv3VVPL4DhPTTU5LpXLYE
	 KDoIG0oC2fXUtBu8l8DVdhf+raZnRZeG+tf8Z3wlqMkoPFJ+Dl4E6e+n0sa+QIOlZ7
	 DSXuCK62yX5w7+E+sHj3lL8+j81mVIqO57EhWGuMuLllZkRPaHycUZ9gQRkaVELCSL
	 GU/m+u3JQeTOfBo+DwWSNzw7bdZiZTBmSVFS9zlMBbhqpfmbvDEDZ6g7OXMiTiueaU
	 Hl5X7OlABGb0w==
Date: Fri, 28 Jun 2024 11:37:45 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, irogers@google.com,
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
	atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v12 1/4] perf check: introduce check subcommand
Message-ID: <Zn8C-XpC1beIRN8t@google.com>
References: <20240628064236.1123851-1-adityag@linux.ibm.com>
 <20240628064236.1123851-2-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240628064236.1123851-2-adityag@linux.ibm.com>

On Fri, Jun 28, 2024 at 12:12:33PM +0530, Aditya Gupta wrote:
> Currently the presence of a feature is checked with a combination of
> perf version --build-options and greps, such as:
> 
>     perf version --build-options | grep " on .* HAVE_FEATURE"
> 
> Instead of this, introduce a subcommand "perf check feature", with which
> scripts can test for presence of a feature, such as:
> 
>     perf check feature HAVE_FEATURE
> 
> 'perf check feature' command is expected to have exit status of 0 if
> feature is built-in, and 1 if it's not built-in or if feature is not known.
> 
> Multiple features can also be passed as a comma-separated list, in which
> case the exit status will be 1 only if all of the passed features are
> built-in. For example, with below command, it will have exit status of 0
> only if both libtraceevent and bpf are enabled, else 1 in all other cases
> 
>     perf check feature libtraceevent,bpf
> 
> The arguments are case-insensitive.
> An array 'supported_features' has also been introduced that can be used by
> other commands like 'perf version --build-options', so that new features
> can be added in one place, with the array
> 
> Reviewed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>  tools/perf/Build                        |   1 +
>  tools/perf/Documentation/perf-check.txt |  79 +++++++++++
>  tools/perf/builtin-check.c              | 178 ++++++++++++++++++++++++
>  tools/perf/builtin.h                    |  17 +++
>  tools/perf/perf.c                       |   1 +
>  5 files changed, 276 insertions(+)
>  create mode 100644 tools/perf/Documentation/perf-check.txt
>  create mode 100644 tools/perf/builtin-check.c
> 
> diff --git a/tools/perf/Build b/tools/perf/Build
> index 1d4957957d75..3e486f7df94b 100644
> --- a/tools/perf/Build
> +++ b/tools/perf/Build
> @@ -1,5 +1,6 @@
>  perf-bench-y += builtin-bench.o
>  perf-y += builtin-annotate.o
> +perf-y += builtin-check.o
>  perf-y += builtin-config.o
>  perf-y += builtin-diff.o
>  perf-y += builtin-evlist.o
> diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
> new file mode 100644
> index 000000000000..88cfd41a76cc
> --- /dev/null
> +++ b/tools/perf/Documentation/perf-check.txt
> @@ -0,0 +1,79 @@
> +perf-check(1)
> +===============
> +
> +NAME
> +----
> +perf-check - check features in perf
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'perf check' [<options>]
> +'perf check' {feature <feature_list>} [<options>]
> +
> +DESCRIPTION
> +-----------
> +With no options given, the 'perf check' just prints the perf version
> +on the standard output.
> +
> +If the subcommand 'feature' is used, then status of feature is printed
> +on the standard output (unless '-q' is also passed), ie. whether it is
> +compiled-in/built-in or not.
> +Also, 'perf check feature' returns with exit status 0 if the feature
> +is built-in, otherwise returns with exit status 1.
> +
> +SUBCOMMANDS
> +-----------
> +
> +feature::
> +
> +        Print whether feature(s) is compiled-in or not, and also returns with an
> +        exit status of 0, if passed feature(s) are compiled-in, else 1.
> +
> +        It expects a feature list as an argument. There can be a single feature
> +        name/macro, or multiple features can also be passed as a comma-separated
> +        list, in which case the exit status will be 0 only if all of the passed
> +        features are compiled-in.
> +
> +        The feature names/macros are case-insensitive.
> +
> +        Example Usage:
> +                perf check feature libtraceevent
> +                perf check feature HAVE_LIBTRACEEVENT
> +                perf check feature libtraceevent,bpf
> +
> +        Supported feature names/macro:
> +                aio                     /  HAVE_AIO_SUPPORT
> +                bpf                     /  HAVE_LIBBPF_SUPPORT
> +                bpf_skeletons           /  HAVE_BPF_SKEL
> +                debuginfod              /  HAVE_DEBUGINFOD_SUPPORT
> +                dwarf                   /  HAVE_DWARF_SUPPORT
> +                dwarf_getlocations      /  HAVE_DWARF_GETLOCATIONS_SUPPORT
> +                get_cpuid               /  HAVE_AUXTRACE_SUPPORT
> +                numa_num_possible_cpus  /  HAVE_LIBNUMA_SUPPORT
> +                libaudit                /  HAVE_LIBAUDIT_SUPPORT
> +                libbfd                  /  HAVE_LIBBFD_SUPPORT
> +                libelf                  /  HAVE_LIBELF_SUPPORT
> +                libcrypto               /  HAVE_LIBCRYPTO_SUPPORT
> +                libdw-dwarf-unwind      /  HAVE_DWARF_SUPPORT
> +                libnuma                 /  HAVE_LIBNUMA_SUPPORT
> +                libperl                 /  HAVE_LIBPERL_SUPPORT
> +                libpfm4                 /  HAVE_LIBPFM
> +                libpython               /  HAVE_LIBPYTHON_SUPPORT
> +                libslang                /  HAVE_SLANG_SUPPORT
> +                libtraceevent           /  HAVE_LIBTRACEEVENT
> +                libunwind               /  HAVE_LIBUNWIND_SUPPORT
> +                lzma                    /  HAVE_LZMA_SUPPORT
> +                syscall_table           /  HAVE_SYSCALL_TABLE_SUPPORT
> +                zlib                    /  HAVE_ZLIB_SUPPORT
> +                zstd                    /  HAVE_ZSTD_SUPPORT
> +
> +OPTIONS
> +-------
> +-q::
> +--quiet::
> +        Do not print any messages or warnings
> +
> +        This can be used along with subcommands such as 'perf check feature'
> +        to hide unnecessary output in test scripts, eg.
> +        'perf check feature --quiet libtraceevent'
> diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
> new file mode 100644
> index 000000000000..44ffde6f8dbe
> --- /dev/null
> +++ b/tools/perf/builtin-check.c
> @@ -0,0 +1,178 @@
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
> +static const char * const check_subcommands[] = { "feature", NULL };
> +static struct option check_options[] = {
> +	OPT_BOOLEAN('q', "quiet", &quiet, "do not show any warnings or messages"),
> +	OPT_END()
> +};
> +static struct option check_feature_options[] = { OPT_END() };

It should be OPT_PARENT(check_options) instead of OPT_END().

> +
> +static const char *check_usage[] = {
> +	"perf check [<subcommand>] [<options>]",

You can leave this NULL and parse_options_subcommand() will fill the
first element automatically using check_subcommands[].

Please see other commands like 'perf sched' how to handle this.

Thanks,
Namhyung


> +	NULL
> +};
> +static const char *check_feature_usage[] = {
> +	"perf check feature <feature_list>",
> +	NULL
> +};
> +
> +struct feature_status supported_features[] = {
> +	FEATURE_STATUS("aio", HAVE_AIO_SUPPORT),
> +	FEATURE_STATUS("bpf", HAVE_LIBBPF_SUPPORT),
> +	FEATURE_STATUS("bpf_skeletons", HAVE_BPF_SKEL),
> +	FEATURE_STATUS("debuginfod", HAVE_DEBUGINFOD_SUPPORT),
> +	FEATURE_STATUS("dwarf", HAVE_DWARF_SUPPORT),
> +	FEATURE_STATUS("dwarf_getlocations", HAVE_DWARF_GETLOCATIONS_SUPPORT),
> +	FEATURE_STATUS("dwarf-unwind-support", HAVE_DWARF_UNWIND_SUPPORT),
> +	FEATURE_STATUS("get_cpuid", HAVE_AUXTRACE_SUPPORT),
> +	FEATURE_STATUS("libaudit", HAVE_LIBAUDIT_SUPPORT),
> +	FEATURE_STATUS("libbfd", HAVE_LIBBFD_SUPPORT),
> +	FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
> +	FEATURE_STATUS("libcrypto", HAVE_LIBCRYPTO_SUPPORT),
> +	FEATURE_STATUS("libdw-dwarf-unwind", HAVE_DWARF_SUPPORT),
> +	FEATURE_STATUS("libelf", HAVE_LIBELF_SUPPORT),
> +	FEATURE_STATUS("libnuma", HAVE_LIBNUMA_SUPPORT),
> +	FEATURE_STATUS("libopencsd", HAVE_CSTRACE_SUPPORT),
> +	FEATURE_STATUS("libperl", HAVE_LIBPERL_SUPPORT),
> +	FEATURE_STATUS("libpfm4", HAVE_LIBPFM),
> +	FEATURE_STATUS("libpython", HAVE_LIBPYTHON_SUPPORT),
> +	FEATURE_STATUS("libslang", HAVE_SLANG_SUPPORT),
> +	FEATURE_STATUS("libtraceevent", HAVE_LIBTRACEEVENT),
> +	FEATURE_STATUS("libunwind", HAVE_LIBUNWIND_SUPPORT),
> +	FEATURE_STATUS("lzma", HAVE_LZMA_SUPPORT),
> +	FEATURE_STATUS("numa_num_possible_cpus", HAVE_LIBNUMA_SUPPORT),
> +	FEATURE_STATUS("syscall_table", HAVE_SYSCALL_TABLE_SUPPORT),
> +	FEATURE_STATUS("zlib", HAVE_ZLIB_SUPPORT),
> +	FEATURE_STATUS("zstd", HAVE_ZSTD_SUPPORT),
> +
> +	/* this should remain at end, to know the array end */
> +	FEATURE_STATUS(NULL, _)
> +};
> +
> +static void on_off_print(const char *status)
> +{
> +	printf("[ ");
> +
> +	if (!strcmp(status, "OFF"))
> +		color_fprintf(stdout, PERF_COLOR_RED, "%-3s", status);
> +	else
> +		color_fprintf(stdout, PERF_COLOR_GREEN, "%-3s", status);
> +
> +	printf(" ]");
> +}
> +
> +/* Helper function to print status of a feature along with name/macro */
> +static void status_print(const char *name, const char *macro,
> +			 const char *status)
> +{
> +	printf("%22s: ", name);
> +	on_off_print(status);
> +	printf("  # %s\n", macro);
> +}
> +
> +#define STATUS(feature)                                           \
> +do {                                                              \
> +	if (feature.is_builtin)                                   \
> +		status_print(feature.name, feature.macro, "on");  \
> +	else                                                      \
> +		status_print(feature.name, feature.macro, "OFF"); \
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
> +	for (int i = 0; supported_features[i].name; ++i) {
> +		if ((strcasecmp(feature, supported_features[i].name) == 0) ||
> +		    (strcasecmp(feature, supported_features[i].macro) == 0)) {
> +			if (!quiet)
> +				STATUS(supported_features[i]);
> +			return supported_features[i].is_builtin;
> +		}
> +	}
> +
> +	if (!quiet)
> +		pr_err("Feature not known: '%s'\n", feature);
> +
> +	return 0;
> +}
> +
> +
> +/**
> + * Usage: 'perf check feature <feature_list>'
> + *
> + * <feature_list> can be a single feature name/macro, or a comma-separated list
> + * of feature names/macros
> + * eg. argument can be "libtraceevent" or "libtraceevent,bpf" etc
> + *
> + * In case of a comma-separated list, feature_enabled will be 1, only if
> + * all features passed in the string are supported
> + *
> + * Note that argv will get modified
> + */
> +static int subcommand_feature(int argc, const char **argv)
> +{
> +	char *feature_list;
> +	char *feature_name;
> +	int feature_enabled;
> +
> +	argc = parse_options(argc, argv, check_feature_options,
> +			check_feature_usage, 0);
> +
> +	if (!argc)
> +		usage_with_options(check_feature_usage, check_feature_options);
> +
> +	if (argc > 1) {
> +		pr_err("Too many arguments passed to 'perf check feature'\n");
> +		return -1;
> +	}
> +
> +	feature_enabled = 1;
> +	/* feature_list is a non-const copy of 'argv[0]' */
> +	feature_list = strdup(argv[0]);
> +	if (!feature_list) {
> +		pr_err("ERROR: failed to allocate memory for feature list\n");
> +		return -1;
> +	}
> +
> +	feature_name = strtok(feature_list, ",");
> +
> +	while (feature_name) {
> +		feature_enabled &= has_support(feature_name);
> +		feature_name = strtok(NULL, ",");
> +	}
> +
> +	free(feature_list);
> +
> +	return !feature_enabled;
> +}
> +
> +int cmd_check(int argc, const char **argv)
> +{
> +	argc = parse_options_subcommand(argc, argv, check_options,
> +			check_subcommands, check_usage, 0);
> +
> +	if (!argc)
> +		usage_with_options(check_usage, check_options);
> +
> +	if (strcmp(argv[0], "feature") == 0)
> +		return subcommand_feature(argc, argv);
> +
> +	/* If no subcommand matched above, print usage help */
> +	usage_with_options(check_usage, check_options);
> +	return 0;
> +}
> diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
> index f4375deabfa3..94f4b3769bf7 100644
> --- a/tools/perf/builtin.h
> +++ b/tools/perf/builtin.h
> @@ -2,6 +2,22 @@
>  #ifndef BUILTIN_H
>  #define BUILTIN_H
>  
> +#include <stddef.h>
> +#include <linux/compiler.h>
> +#include <tools/config.h>
> +
> +struct feature_status {
> +	const char *name;
> +	const char *macro;
> +	int is_builtin;
> +};
> +
> +#define FEATURE_STATUS(name_, macro_) {    \
> +	.name = name_,                     \
> +	.macro = #macro_,                  \
> +	.is_builtin = IS_BUILTIN(macro_) }
> +
> +extern struct feature_status supported_features[];
>  struct cmdnames;
>  
>  void list_common_cmds_help(void);
> @@ -11,6 +27,7 @@ int cmd_annotate(int argc, const char **argv);
>  int cmd_bench(int argc, const char **argv);
>  int cmd_buildid_cache(int argc, const char **argv);
>  int cmd_buildid_list(int argc, const char **argv);
> +int cmd_check(int argc, const char **argv);
>  int cmd_config(int argc, const char **argv);
>  int cmd_c2c(int argc, const char **argv);
>  int cmd_diff(int argc, const char **argv);
> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index bd3f80b5bb46..4def800f4089 100644
> --- a/tools/perf/perf.c
> +++ b/tools/perf/perf.c
> @@ -52,6 +52,7 @@ static struct cmd_struct commands[] = {
>  	{ "archive",	NULL,	0 },
>  	{ "buildid-cache", cmd_buildid_cache, 0 },
>  	{ "buildid-list", cmd_buildid_list, 0 },
> +	{ "check",	cmd_check,	0 },
>  	{ "config",	cmd_config,	0 },
>  	{ "c2c",	cmd_c2c,	0 },
>  	{ "diff",	cmd_diff,	0 },
> -- 
> 2.45.2
> 
