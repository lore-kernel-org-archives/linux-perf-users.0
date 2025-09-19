Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A47231A21;
	Fri, 19 Sep 2025 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758313655; cv=none; b=Ul1cHJYYRGR/KZDWkwfXW7uMdoRFQqjmR+xnv5UenzGDTWGLk0d73s93TEyu29YAXs6GTIxjdccx1Du+Y9c+RwyM2M007A7atBaIJRqoG2uHz/HfctP8l/YzvNm6mXHXE7PFmhp1njb3mbzoST7KnFX47gJsGu0rwH3OJw2EDhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758313655; c=relaxed/simple;
	bh=fg09Om18mkO6eiqdmUq2dfPvEDJJN2M7zulvQ/4P6cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qC2He+EEn/9D+CH8D5Z1h098YpMlzyKRDOXZamhZ6NQxo3lWBsQas7nPefRKIzUwEAu3C85jzmPGmBAwYRwOYesd56cxwLp8CpUmNCy970WyBTmWFMIOed29rZ0ZPiAGjyK6xNswD6BBulOi2ycw5nY9lY45Cv3uhiXl8w3p15I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIg2PARL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIg2PARL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FD5C4CEF0;
	Fri, 19 Sep 2025 20:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758313654;
	bh=fg09Om18mkO6eiqdmUq2dfPvEDJJN2M7zulvQ/4P6cE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iIg2PARLQeiCkGWs3Y772fB+8JDgGWOppV7STnAHRRoOioyT6ELgKjPamZNskXw65
	 LZ86yF57m9m7bkeh4auCSHAexV5KKRS7vQTVVr7+rTTeiS+AAaHQEJtr2Vs8SIzv80
	 W01Uug/aknG4+cp9ddvF2kOk9LIoyl1XEnkekYwSUAx9zS8W1Y5BF8pYY0vPlGHxGp
	 binAUPF95TpyYMM6VdNel7x5r1UUDT6blUj4rERpOA1UrKYKVHJYbpMiyc10tdMBgQ
	 S4ipOY0yTRkDcZ1vy7irSAycLjuYTwHSsRhDPy169ntfzrpaZ/4TRmbyPMr8P7RdUU
	 JVbU/j0oHxHvw==
Date: Fri, 19 Sep 2025 13:27:32 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [RFC/PATCH 2/2] perf check: Add 'pmu' subcommand
Message-ID: <aM28tDp-BoNTVQwf@google.com>
References: <20250918063944.16331-1-namhyung@kernel.org>
 <20250918063944.16331-2-namhyung@kernel.org>
 <CAP-5=fVeYM7RJ0wW7S+9F+UnWW9pRphJMQhmBxT=V7zfmQF3cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVeYM7RJ0wW7S+9F+UnWW9pRphJMQhmBxT=V7zfmQF3cA@mail.gmail.com>

On Thu, Sep 18, 2025 at 08:33:30AM -0700, Ian Rogers wrote:
> On Wed, Sep 17, 2025 at 11:39 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The 'perf check pmu' command will show information about PMUs in the
> > system like below:
> >
> >   $ perf check pmu | head
> >   cpu_atom: type = 10
> >     core PMU: cpus = 16-27
> >     caps: branches = 32
> >     caps: max_precise = 3
> >     caps: pmu_name = alderlake_hybrid
> >   cpu_core: type = 4
> >     core PMU: cpus = 0-15
> >     caps: branches = 32
> >     caps: max_precise = 3
> >     caps: pmu_name = alderlake_hybrid
> >
> > The -q option will make it print the name and type of PMUs only.  It
> > also takes arguments to show matching PMUs only.
> >
> >   $ perf check pmu -q uncore
> >   uncore_arb_0: type = 27
> >   uncore_arb_1: type = 28
> >   uncore_cbox_0: type = 15
> >   uncore_cbox_1: type = 16
> >   uncore_cbox_2: type = 17
> >   uncore_cbox_3: type = 18
> >   uncore_cbox_4: type = 19
> >   uncore_cbox_5: type = 20
> >   uncore_cbox_6: type = 21
> >   uncore_cbox_7: type = 22
> >   uncore_cbox_8: type = 23
> >   uncore_cbox_9: type = 24
> >   uncore_cbox_10: type = 25
> >   uncore_cbox_11: type = 26
> >   uncore_clock: type = 29
> >   uncore_imc_free_running_0: type = 32
> >   uncore_imc_free_running_1: type = 33
> >   uncore_imc_0: type = 30
> >   uncore_imc_1: type = 31
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/Documentation/perf-check.txt | 12 +++++
> >  tools/perf/builtin-check.c              | 60 ++++++++++++++++++++++++-
> >  2 files changed, 71 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
> > index 34dccc29d90d2fdf..2fa007698c0f0814 100644
> > --- a/tools/perf/Documentation/perf-check.txt
> > +++ b/tools/perf/Documentation/perf-check.txt
> > @@ -11,6 +11,7 @@ SYNOPSIS
> >  'perf check' [<options>]
> >  'perf check' {feature <feature_list>} [<options>]
> >  'perf check' {system <setting_list>} [<options>]
> > +'perf check' {pmu <name_list>} [<options>]
> >
> >  DESCRIPTION
> >  -----------
> > @@ -26,6 +27,9 @@ is built-in, otherwise returns with exit status 1.
> >  If the subcommand 'system' is used, then system settins are printed on
> >  the standard output with explanation.
> >
> > +If the subcommand 'pmu' is used, then available PMU information is printed
> > +on the standard output with explanation.
> > +
> >  SUBCOMMANDS
> >  -----------
> >
> > @@ -88,6 +92,14 @@ SUBCOMMANDS
> >                 nmi_watchdog
> >                 kptr_restrict
> >
> > +pmu::
> > +
> > +       Print PMU information available in the system.
> > +
> > +       Example Usage:
> > +               perf check pmu
> > +               perf check pmu <name>
> > +
> >
> >  OPTIONS
> >  -------
> > diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
> > index 1c7c6bb5da5ccbf2..f3d034a94b1227c7 100644
> > --- a/tools/perf/builtin-check.c
> > +++ b/tools/perf/builtin-check.c
> > @@ -3,6 +3,8 @@
> >  #include "color.h"
> >  #include "util/debug.h"
> >  #include "util/header.h"
> > +#include "util/pmu.h"
> > +#include "util/pmus.h"
> >  #include <api/fs/fs.h>
> >  #include <tools/config.h>
> >  #include <stdbool.h>
> > @@ -10,13 +12,14 @@
> >  #include <string.h>
> >  #include <subcmd/parse-options.h>
> >
> > -static const char * const check_subcommands[] = { "feature", "system", NULL };
> > +static const char * const check_subcommands[] = { "feature", "system", "pmu", NULL };
> >  static struct option check_options[] = {
> >         OPT_BOOLEAN('q', "quiet", &quiet, "do not show any warnings or messages"),
> >         OPT_END()
> >  };
> >  static struct option check_feature_options[] = { OPT_PARENT(check_options) };
> >  static struct option check_system_options[] = { OPT_PARENT(check_options) };
> > +static struct option check_pmu_options[] = { OPT_PARENT(check_options) };
> >
> >  static const char *check_usage[] = { NULL, NULL };
> >  static const char *check_feature_usage[] = {
> > @@ -27,6 +30,10 @@ static const char *check_system_usage[] = {
> >         "perf check system",
> >         NULL
> >  };
> > +static const char *check_pmu_usage[] = {
> > +       "perf check pmu",
> > +       NULL
> > +};
> >
> >  #define FEATURE_STATUS(name_, macro_) {    \
> >         .name = name_,                     \
> > @@ -278,6 +285,55 @@ static int subcommand_system(int argc, const char **argv)
> >         return 0;
> >  }
> >
> > +/**
> > + * Usage: 'perf check pmu <names>'
> > + *
> > + * Show PMU information.
> > + */
> > +static int subcommand_pmu(int argc, const char **argv)
> > +{
> > +       struct perf_pmu *pmu = NULL;
> > +       struct perf_pmu_caps *caps;
> > +
> > +       argc = parse_options(argc, argv, check_pmu_options, check_pmu_usage, 0);
> > +
> > +       while ((pmu = perf_pmus__scan(pmu)) != NULL) {
> > +               if (argc) {
> > +                       bool found = false;
> > +
> > +                       /* only show entries match to command line arguments */
> > +                       for (int k = 0; k < argc; k++) {
> > +                               if (strstr(pmu->name, argv[k])) {
> 
> To avoid divergence from parse-events it may be better to use
> perf_pmu__wildcard_match? There is also
> perf_pmus__scan_matching_wildcard.

Sounds good, will change.

> 
> > +                                       found = true;
> > +                                       break;
> > +                               }
> > +                       }
> > +                       if (!found)
> > +                               continue;
> > +               }
> > +
> > +               printf("%s: type = %u\n", pmu->name, pmu->type);
> > +               if (quiet)
> > +                       continue;
> > +
> > +               if (pmu->is_core || pmu->is_uncore) {
> > +                       printf("  %score PMU", pmu->is_uncore ? "un" : "");
> > +                       if (!perf_cpu_map__is_empty(pmu->cpus)) {
> > +                               printf(": %s = ", pmu->is_core ? "cpus" : "cpumask");
> 
> The cpus file is only generally present on hybrid systems. I don't
> think this needs to be core/uncore dependent - the only thing I've
> ever seen fail that test are some ARM uncore PMUs. I'd always dump
> this as cpumask, when !core and !uncore then the default all online
> CPUs cpumask is important information as that probably isn't the
> cpumask you want with an uncore PMU.

Ok, I can remove the core/uncore check.  But I think it's better to
print them only if they actually have maps to inform users that those
PMUs need some more care. :)

> 
> > +                               cpu_map__fprintf(pmu->cpus, stdout);
> > +                       } else {
> > +                               printf("\n");
> > +                       }
> > +               }
> > +
> > +               perf_pmu__caps_parse(pmu);
> > +               list_for_each_entry(caps, &pmu->caps, list) {
> > +                       printf("  caps: %s = %s\n", caps->name, caps->value);
> > +               }
> > +       }
> > +       return 0;
> 
> If not found return an error?
 
Yep, good idea.

Thanks for the review!
Namhyung

> 
> > +}
> > +
> >  int cmd_check(int argc, const char **argv)
> >  {
> >         argc = parse_options_subcommand(argc, argv, check_options,
> > @@ -290,6 +346,8 @@ int cmd_check(int argc, const char **argv)
> >                 return subcommand_feature(argc, argv);
> >         if (strcmp(argv[0], "system") == 0)
> >                 return subcommand_system(argc, argv);
> > +       if (strcmp(argv[0], "pmu") == 0)
> > +               return subcommand_pmu(argc, argv);
> >
> >         /* If no subcommand matched above, print usage help */
> >         pr_err("Unknown subcommand: %s\n", argv[0]);
> > --
> > 2.51.0
> >
