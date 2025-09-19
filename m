Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7397622758F;
	Fri, 19 Sep 2025 20:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758313289; cv=none; b=Y2LbgwINQwislpf41Iu5hZfa7ZdwtT/WxPSG/7vU7do70iCS8lJz/xfTCtqWXHqNEMGhVns+KAuFs55vM9oOjDQAWNNrQl400f4AxhXIEpKD9dMKIxLop1/IgfiDhY7MMLC9VsLnFn/cB6Nb/FPVC1Q9ruXOpZRMRoCH77Uw/9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758313289; c=relaxed/simple;
	bh=5abrTe2UeHPGhCaAmf54ZHrfzYUKXoUkdsFRNvp1Trg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzpodCw3nxbVAuprcqOGX5crCrJIpqV0FkOSJ2h1WiL9Ts5TdSyQ3UjyVci/St/8Sr/hjwyVJ9pwLt71wAelJ+9Z/jYTSQk8kVvAEkiuef0E5Ah05aPpLxKtJWreIQENJl2Lu1Q9B2MSlRSyukv+I7x4QxYWizIqfGIeQ1okv3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAIURAy/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAIURAy/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33B6C4CEF0;
	Fri, 19 Sep 2025 20:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758313289;
	bh=5abrTe2UeHPGhCaAmf54ZHrfzYUKXoUkdsFRNvp1Trg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bAIURAy/CALJbSsZAnKza73FVvVI2yb66NsImuG6cPqvCfuxmFKHHSylXKVjL9U+r
	 RX/csHEUkcwot1RyfHOtbFUvGcdW7EEyOH2yv4+Jhp5KT+tIe/APa8+l1W6iq6lwxs
	 IK2O199XuqoArgJLFXFZ6Wwlo1aqotT/4cbTKta/la73aaes2xkHAA6GQh/ULPBGQK
	 59rMxFCvHZcC9BCF5xEyn2X8a7g0oUmPp8oDE6mxgOdvQRf3GOeTsclXZzRMu7Q7c/
	 NXgTN2gA7I8/J1vvMaCMsRdD4bZ8h1pZDlexl2CoYyohslh1O9RwAJJVxQUL5HfxTe
	 jFxC7fGSzz2YQ==
Date: Fri, 19 Sep 2025 13:21:26 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [RFC/PATCH 1/2] perf check: Add 'system' subcommand
Message-ID: <aM27RtGdQBc8OkvR@google.com>
References: <20250918063944.16331-1-namhyung@kernel.org>
 <CAP-5=fVAsDN50X07zpnxikS_tA2cw92YJwHR2f9RVs0fc8j-Ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVAsDN50X07zpnxikS_tA2cw92YJwHR2f9RVs0fc8j-Ng@mail.gmail.com>

On Thu, Sep 18, 2025 at 08:48:10AM -0700, Ian Rogers wrote:
> On Wed, Sep 17, 2025 at 11:39 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The 'perf check system' is to check sysctl settings related to perf.
> > By default it'd print the following output.
> >
> >   $ perf check system
> >   perf_event_paranoid  = 2      # non-root can profile user code only
> >   perf_event_max_stack = 127    # maximum callchain length
> >   perf_event_mlock_kb  = 516    # maximum ring buffer size (including a header page) for non-root
> >   nmi_watchdog         = 1      # a hardware PMU counter may be used by the kernel
> >   kptr_restrict        = 0      # kernel pointers are printed as-is
> >
> > The -q option suppresses the description.  It can also take command line
> > argument to match specific items.
> >
> >   $ perf check system -q nmi
> >   nmi_watchdog         = 1
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/Documentation/perf-check.txt |  20 ++++
> >  tools/perf/builtin-check.c              | 116 +++++++++++++++++++++++-
> >  2 files changed, 135 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
> > index ee92042082f73121..34dccc29d90d2fdf 100644
> > --- a/tools/perf/Documentation/perf-check.txt
> > +++ b/tools/perf/Documentation/perf-check.txt
> > @@ -10,6 +10,7 @@ SYNOPSIS
> >  [verse]
> >  'perf check' [<options>]
> >  'perf check' {feature <feature_list>} [<options>]
> > +'perf check' {system <setting_list>} [<options>]
> >
> >  DESCRIPTION
> >  -----------
> > @@ -22,6 +23,9 @@ compiled-in/built-in or not.
> >  Also, 'perf check feature' returns with exit status 0 if the feature
> >  is built-in, otherwise returns with exit status 1.
> >
> > +If the subcommand 'system' is used, then system settins are printed on
> > +the standard output with explanation.
> > +
> >  SUBCOMMANDS
> >  -----------
> >
> > @@ -69,6 +73,22 @@ SUBCOMMANDS
> >                  zlib                    /  HAVE_ZLIB_SUPPORT
> >                  zstd                    /  HAVE_ZSTD_SUPPORT
> >
> > +system::
> > +
> > +       Print system settings (sysctl) that affect perf behaviors.
> > +
> > +       Example Usage:
> > +               perf check system
> > +               perf check system watchdog
> > +
> > +       Supported settings:
> > +               perf_event_paranoid
> > +               perf_event_max_stack
> > +               perf_event_mlock_kb
> > +               nmi_watchdog
> > +               kptr_restrict
> > +
> > +
> >  OPTIONS
> >  -------
> >  -q::
> > diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
> > index b1e205871ab17a77..1c7c6bb5da5ccbf2 100644
> > --- a/tools/perf/builtin-check.c
> > +++ b/tools/perf/builtin-check.c
> > @@ -3,24 +3,30 @@
> >  #include "color.h"
> >  #include "util/debug.h"
> >  #include "util/header.h"
> > +#include <api/fs/fs.h>
> >  #include <tools/config.h>
> >  #include <stdbool.h>
> >  #include <stdio.h>
> >  #include <string.h>
> >  #include <subcmd/parse-options.h>
> >
> > -static const char * const check_subcommands[] = { "feature", NULL };
> > +static const char * const check_subcommands[] = { "feature", "system", NULL };
> >  static struct option check_options[] = {
> >         OPT_BOOLEAN('q', "quiet", &quiet, "do not show any warnings or messages"),
> >         OPT_END()
> >  };
> >  static struct option check_feature_options[] = { OPT_PARENT(check_options) };
> > +static struct option check_system_options[] = { OPT_PARENT(check_options) };
> >
> >  static const char *check_usage[] = { NULL, NULL };
> >  static const char *check_feature_usage[] = {
> >         "perf check feature <feature_list>",
> >         NULL
> >  };
> > +static const char *check_system_usage[] = {
> > +       "perf check system",
> > +       NULL
> > +};
> >
> >  #define FEATURE_STATUS(name_, macro_) {    \
> >         .name = name_,                     \
> > @@ -166,6 +172,112 @@ static int subcommand_feature(int argc, const char **argv)
> >         return !feature_enabled;
> >  }
> >
> > +static int read_sysctl_kernel_int(const char *name)
> > +{
> > +       char path[128];
> > +       int value;
> > +
> > +       scnprintf(path, sizeof(path), "kernel/%s", name);
> > +       if (sysctl__read_int(path, &value))
> > +               return INT_MAX;
> > +
> > +       return value;
> > +}
> > +
> > +static const char *system_help_perf_event_paranoid(int value)
> > +{
> > +       if (value == 2)
> > +               return "non-root can profile user code only";
> > +       if (value == 1)
> > +               return "non-root can profile kernel and user code";
> > +       if (value == 0)
> > +               return "non-root can profile system-wide w/o tracepoints data";
> > +       if (value < 0)
> > +               return "no restrictions";
> > +
> > +       return "non-root cannot use perf event";
> > +}
> > +
> > +static const char *system_help_perf_event_max_stack(int value __maybe_unused)
> > +{
> > +       return "maximum callchain length";
> > +}
> > +
> > +static const char *system_help_perf_event_mlock_kb(int value __maybe_unused)
> > +{
> > +       return "maximum ring buffer size (including a header page) for non-root";
> > +}
> > +
> > +static const char *system_help_nmi_watchdog(int value)
> > +{
> > +       if (value)
> > +               return "a hardware PMU counter may be used by the kernel";
> > +
> > +       return "perf can use full PMU counters";
> > +}
> > +
> > +static const char *system_help_kptr_restrict(int value)
> > +{
> > +       if (value == 0)
> > +               return "kernel pointers are printed as-is";
> > +       if (value == 1)
> > +               return "non-root cannot see the kernel pointers";
> > +       if (value == 2)
> > +               return "root may not see some kernel pointers";
> > +
> > +       return "unknown value";
> > +}
> > +
> > +/**
> > + * Usage: 'perf check system <settings>'
> > + *
> > + * Show system settings that affect perf behavior.
> > + */
> > +static int subcommand_system(int argc, const char **argv)
> > +{
> > +#define PERF_SYSCTL(name) { #name, system_help_##name }
> > +       struct {
> > +               const char *name;
> > +               const char *(*help)(int value);
> > +       } sysctls[] = {
> > +               PERF_SYSCTL(perf_event_paranoid),
> > +               PERF_SYSCTL(perf_event_max_stack),
> > +               PERF_SYSCTL(perf_event_mlock_kb),
> > +               PERF_SYSCTL(nmi_watchdog),
> > +               PERF_SYSCTL(kptr_restrict),
> > +       };
> > +#undef PERF_SYSCTL
> > +
> > +       argc = parse_options(argc, argv, check_system_options,
> > +                            check_system_usage, 0);
> > +
> > +       for (size_t i = 0; i < ARRAY_SIZE(sysctls); i++) {
> > +               int value;
> > +
> > +               if (argc) {
> > +                       bool found = false;
> > +
> > +                       /* only show entries match to command line arguments */
> > +                       for (int k = 0; k < argc; k++) {
> > +                               if (strstr(sysctls[i].name, argv[k])) {
> > +                                       found = true;
> > +                                       break;
> > +                               }
> > +                       }
> > +                       if (!found)
> > +                               continue;
> > +               }
> > +
> > +               value = read_sysctl_kernel_int(sysctls[i].name);
> > +               printf("%-20s = %d", sysctls[i].name, value);
> > +               if (!quiet)
> > +                       printf("\t# %s", sysctls[i].help(value));
> > +               printf("\n");
> > +       }
> > +
> > +       return 0;
> 
> This looks useful! Rather than returning 0 should this return
> something indicating whether perf does or doesn't have the permission?
> In that case, what about root? We have this pattern in our shell
> tests:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/shell/lib/stat_output.sh?h=perf-tools-next
> ```
> function ParanoidAndNotRoot()
> {
> [ "$(id -u)" != 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -gt $1 ]
> }
> ```
> I wonder things like this can use these values instead.
 
Yep, but I guess it needs a separate interface to do that.
Maybe something like this?

  $ perf check permission (user|kernel|cpu|raw-tp)

Thanks,
Namhyung

> 
> > +}
> > +
> >  int cmd_check(int argc, const char **argv)
> >  {
> >         argc = parse_options_subcommand(argc, argv, check_options,
> > @@ -176,6 +288,8 @@ int cmd_check(int argc, const char **argv)
> >
> >         if (strcmp(argv[0], "feature") == 0)
> >                 return subcommand_feature(argc, argv);
> > +       if (strcmp(argv[0], "system") == 0)
> > +               return subcommand_system(argc, argv);
> >
> >         /* If no subcommand matched above, print usage help */
> >         pr_err("Unknown subcommand: %s\n", argv[0]);
> > --
> > 2.51.0
> >
