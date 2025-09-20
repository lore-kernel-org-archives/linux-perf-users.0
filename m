Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51341487F4
	for <linux-perf-users@vger.kernel.org>; Sat, 20 Sep 2025 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758377112; cv=none; b=QNPk+3FUmvNGELKZGp1qhnEA2v668XYK4VE+UrjOpd/IrT0+ByNcSIcpdChJbd2MeMieO9mU8wDHL4vKK/8PEmWc1LuPElN954v5w2b/LEdke9DUDJzesbT//9SEZYJ2VcdHlSMhkbLlyN00YYbryKUtuXGDrqX3S6/sOHW53LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758377112; c=relaxed/simple;
	bh=cl6KNVTs1CCjuYRYXgitS90TDF/yPZHGY2fVDgSrlWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WfGA2Y2nM/4qdQ+rLHVvL0eJy0GHG5avTtwlw9VxE2STadc+waMeOJki/3XBkhgtSZsSbxnsRc34fHc/u8V4uU0qvgO1fKyyY0ylsvASiVThxEd6YIx0RryXLyg/K8pVKOWGADuGlrKTJ1cUSqx54J6NTMuN8TfXBvqFzVgC24w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JKSUaLtb; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JKSUaLtb"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-26d9cd643eeso116695ad.0
        for <linux-perf-users@vger.kernel.org>; Sat, 20 Sep 2025 07:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758377108; x=1758981908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4wdSdMbYIdqGOMiZoRxz4STBvd3LUCQKkqL6fqxU6s=;
        b=JKSUaLtbEktL0wIa1rjx4vv8dGZe4u6Xm9K+rSUt4MnBveF+06LF08sH45VWD9p7xt
         fWdjMju2P7pB+A2cHfI9oE1zgSHbcsnUBrnjz92oOscTE2tIZLimKtqlMiCAV/ssgFZh
         f8P+M2eXcc5scER6uRktyw5fR/F+rGSzY3fC9FopZdIpzohHWNVIMl3/nWJzn5tRArZI
         mWKOJP0SOo0utNx3UCWcurepz+hKB616MYMJ9dXMvxyyQ4ifkZehZZ3A5agBeL0vyChh
         RkjQwXpMFZ2Xra4f50FT9Sn4eLWSvQIzE26kc81iHfcRN0tslSmc8Je1iC0pcTkZq2RD
         +XRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758377108; x=1758981908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4wdSdMbYIdqGOMiZoRxz4STBvd3LUCQKkqL6fqxU6s=;
        b=RO0pAidtTtoHS1XRDsGyEAsgY+SqUelQMkzyFrlg/ykSPfMv2HdRhJs9CUfVwmcHhv
         xD6NMInSbb6E0a5+1843N36ZaAJXFpr65E1WBaYPRHAXqVq9a8iA/zbnnMAgIJCVKU9b
         M1kY3rGQWT5jk/wDbofOJ/7bhKBTaNfBNVdT71ZgkunRgZVFhynPJvvBBTXXtR+h3Jyf
         bcHVI4YDpRXNLhGjZr+FWJSA+ENtlaKYkwSaGUNUNSLyuniqQNcb8JKjAkN+4G7WUHPU
         iB9dj3oSzgMQYgJQhfHVlmb/KoXwePIdIIU65r6X7DLAhpmIH9+qPjaj8494cQoNUzud
         N1AA==
X-Forwarded-Encrypted: i=1; AJvYcCXfF/UM69Nf8qJ3SPgdb5Y8Iya7Yh9H2PgGkxNRABo91LceJZ+O2JdzbxpimxfYJ5Rgn3OH1HINZ1AAyAAIFpVY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9vjtx9rz29EqccT9JADjEQgqTnwTEDZRQ1imLQzgT83L2yUdz
	s1/1OE/wZDfXn0JTAoJP1ffeRkGqwLuOGB5CFYftV/GvMPckccvM88PBpBSyOfCAxE/V1z6Mlld
	doWfw2VpCadkjGeMHQ/m03EHNjj00Zh6qhV6osLpc
X-Gm-Gg: ASbGncupHLMW0Vy6LjmHSnmwFHsUxsiTrYqVl+B1X0upqozAnpA4pQQE3XmSHc9OZuw
	brc6vNInys6oxjG/PPCLTB1hwTKWt/CWAJ0B0ZWyzOGUB3JSzqFplc3vdpo+v49aiRcKKA0CJgJ
	YPLphDUwkp3oqHlxxaIMikDbke6FEdHphGjt5kXofocZCwXMnJtmFf1wLMtdmP4ASQ9t0TS0Atl
	/qgb5Cw1ubOxd333BM=
X-Google-Smtp-Source: AGHT+IGt9WMH4oAa1v0mXV08RgG0i+ea2+8U9Qw7tS4WkEj6oUnPzxJnsrGHvnMb1QljWFMfPeh3w24J+W7Jaru9C3w=
X-Received: by 2002:a17:902:e80d:b0:248:dce7:40e1 with SMTP id
 d9443c01a7336-26808ad114cmr16004965ad.9.1758377107506; Sat, 20 Sep 2025
 07:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918063944.16331-1-namhyung@kernel.org> <20250918063944.16331-2-namhyung@kernel.org>
 <CAP-5=fVeYM7RJ0wW7S+9F+UnWW9pRphJMQhmBxT=V7zfmQF3cA@mail.gmail.com> <aM28tDp-BoNTVQwf@google.com>
In-Reply-To: <aM28tDp-BoNTVQwf@google.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 20 Sep 2025 07:04:56 -0700
X-Gm-Features: AS18NWBqWj2ai6pxgyMeCMiU2b57iMILP_EIgzHhwtkcPODYIWwjJQVpIG0U15w
Message-ID: <CAP-5=fUrB3gJYaCUFpizC5dtOCUdbCqiTFvWvf6be-2YGFM7QQ@mail.gmail.com>
Subject: Re: [RFC/PATCH 2/2] perf check: Add 'pmu' subcommand
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 1:27=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Sep 18, 2025 at 08:33:30AM -0700, Ian Rogers wrote:
> > On Wed, Sep 17, 2025 at 11:39=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > The 'perf check pmu' command will show information about PMUs in the
> > > system like below:
> > >
> > >   $ perf check pmu | head
> > >   cpu_atom: type =3D 10
> > >     core PMU: cpus =3D 16-27
> > >     caps: branches =3D 32
> > >     caps: max_precise =3D 3
> > >     caps: pmu_name =3D alderlake_hybrid
> > >   cpu_core: type =3D 4
> > >     core PMU: cpus =3D 0-15
> > >     caps: branches =3D 32
> > >     caps: max_precise =3D 3
> > >     caps: pmu_name =3D alderlake_hybrid
> > >
> > > The -q option will make it print the name and type of PMUs only.  It
> > > also takes arguments to show matching PMUs only.
> > >
> > >   $ perf check pmu -q uncore
> > >   uncore_arb_0: type =3D 27
> > >   uncore_arb_1: type =3D 28
> > >   uncore_cbox_0: type =3D 15
> > >   uncore_cbox_1: type =3D 16
> > >   uncore_cbox_2: type =3D 17
> > >   uncore_cbox_3: type =3D 18
> > >   uncore_cbox_4: type =3D 19
> > >   uncore_cbox_5: type =3D 20
> > >   uncore_cbox_6: type =3D 21
> > >   uncore_cbox_7: type =3D 22
> > >   uncore_cbox_8: type =3D 23
> > >   uncore_cbox_9: type =3D 24
> > >   uncore_cbox_10: type =3D 25
> > >   uncore_cbox_11: type =3D 26
> > >   uncore_clock: type =3D 29
> > >   uncore_imc_free_running_0: type =3D 32
> > >   uncore_imc_free_running_1: type =3D 33
> > >   uncore_imc_0: type =3D 30
> > >   uncore_imc_1: type =3D 31
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/Documentation/perf-check.txt | 12 +++++
> > >  tools/perf/builtin-check.c              | 60 +++++++++++++++++++++++=
+-
> > >  2 files changed, 71 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Doc=
umentation/perf-check.txt
> > > index 34dccc29d90d2fdf..2fa007698c0f0814 100644
> > > --- a/tools/perf/Documentation/perf-check.txt
> > > +++ b/tools/perf/Documentation/perf-check.txt
> > > @@ -11,6 +11,7 @@ SYNOPSIS
> > >  'perf check' [<options>]
> > >  'perf check' {feature <feature_list>} [<options>]
> > >  'perf check' {system <setting_list>} [<options>]
> > > +'perf check' {pmu <name_list>} [<options>]
> > >
> > >  DESCRIPTION
> > >  -----------
> > > @@ -26,6 +27,9 @@ is built-in, otherwise returns with exit status 1.
> > >  If the subcommand 'system' is used, then system settins are printed =
on
> > >  the standard output with explanation.
> > >
> > > +If the subcommand 'pmu' is used, then available PMU information is p=
rinted
> > > +on the standard output with explanation.
> > > +
> > >  SUBCOMMANDS
> > >  -----------
> > >
> > > @@ -88,6 +92,14 @@ SUBCOMMANDS
> > >                 nmi_watchdog
> > >                 kptr_restrict
> > >
> > > +pmu::
> > > +
> > > +       Print PMU information available in the system.
> > > +
> > > +       Example Usage:
> > > +               perf check pmu
> > > +               perf check pmu <name>
> > > +
> > >
> > >  OPTIONS
> > >  -------
> > > diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
> > > index 1c7c6bb5da5ccbf2..f3d034a94b1227c7 100644
> > > --- a/tools/perf/builtin-check.c
> > > +++ b/tools/perf/builtin-check.c
> > > @@ -3,6 +3,8 @@
> > >  #include "color.h"
> > >  #include "util/debug.h"
> > >  #include "util/header.h"
> > > +#include "util/pmu.h"
> > > +#include "util/pmus.h"
> > >  #include <api/fs/fs.h>
> > >  #include <tools/config.h>
> > >  #include <stdbool.h>
> > > @@ -10,13 +12,14 @@
> > >  #include <string.h>
> > >  #include <subcmd/parse-options.h>
> > >
> > > -static const char * const check_subcommands[] =3D { "feature", "syst=
em", NULL };
> > > +static const char * const check_subcommands[] =3D { "feature", "syst=
em", "pmu", NULL };
> > >  static struct option check_options[] =3D {
> > >         OPT_BOOLEAN('q', "quiet", &quiet, "do not show any warnings o=
r messages"),
> > >         OPT_END()
> > >  };
> > >  static struct option check_feature_options[] =3D { OPT_PARENT(check_=
options) };
> > >  static struct option check_system_options[] =3D { OPT_PARENT(check_o=
ptions) };
> > > +static struct option check_pmu_options[] =3D { OPT_PARENT(check_opti=
ons) };
> > >
> > >  static const char *check_usage[] =3D { NULL, NULL };
> > >  static const char *check_feature_usage[] =3D {
> > > @@ -27,6 +30,10 @@ static const char *check_system_usage[] =3D {
> > >         "perf check system",
> > >         NULL
> > >  };
> > > +static const char *check_pmu_usage[] =3D {
> > > +       "perf check pmu",
> > > +       NULL
> > > +};
> > >
> > >  #define FEATURE_STATUS(name_, macro_) {    \
> > >         .name =3D name_,                     \
> > > @@ -278,6 +285,55 @@ static int subcommand_system(int argc, const cha=
r **argv)
> > >         return 0;
> > >  }
> > >
> > > +/**
> > > + * Usage: 'perf check pmu <names>'
> > > + *
> > > + * Show PMU information.
> > > + */
> > > +static int subcommand_pmu(int argc, const char **argv)
> > > +{
> > > +       struct perf_pmu *pmu =3D NULL;
> > > +       struct perf_pmu_caps *caps;
> > > +
> > > +       argc =3D parse_options(argc, argv, check_pmu_options, check_p=
mu_usage, 0);
> > > +
> > > +       while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
> > > +               if (argc) {
> > > +                       bool found =3D false;
> > > +
> > > +                       /* only show entries match to command line ar=
guments */
> > > +                       for (int k =3D 0; k < argc; k++) {
> > > +                               if (strstr(pmu->name, argv[k])) {
> >
> > To avoid divergence from parse-events it may be better to use
> > perf_pmu__wildcard_match? There is also
> > perf_pmus__scan_matching_wildcard.
>
> Sounds good, will change.
>
> >
> > > +                                       found =3D true;
> > > +                                       break;
> > > +                               }
> > > +                       }
> > > +                       if (!found)
> > > +                               continue;
> > > +               }
> > > +
> > > +               printf("%s: type =3D %u\n", pmu->name, pmu->type);
> > > +               if (quiet)
> > > +                       continue;
> > > +
> > > +               if (pmu->is_core || pmu->is_uncore) {
> > > +                       printf("  %score PMU", pmu->is_uncore ? "un" =
: "");
> > > +                       if (!perf_cpu_map__is_empty(pmu->cpus)) {
> > > +                               printf(": %s =3D ", pmu->is_core ? "c=
pus" : "cpumask");
> >
> > The cpus file is only generally present on hybrid systems. I don't
> > think this needs to be core/uncore dependent - the only thing I've
> > ever seen fail that test are some ARM uncore PMUs. I'd always dump
> > this as cpumask, when !core and !uncore then the default all online
> > CPUs cpumask is important information as that probably isn't the
> > cpumask you want with an uncore PMU.
>
> Ok, I can remove the core/uncore check.  But I think it's better to
> print them only if they actually have maps to inform users that those
> PMUs need some more care. :)

So we have to deal with a bit of history in the code:
1. if there is a cpumask file then this is an uncore PMU and the
cpumask is the one given.
2. if there is a cpus file then this is a core PMU typically a hybrid one.
3. if there is no cpus file then all online CPUs are used in the
cpumask as this is probably a core PMU. Being a core PMU is only set
in the case of the PMU name being "cpu" or "cpum_cf" or for case 2.
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmu.c?h=3Dperf-tools-next#n1966

So there is the broken PMU case where no cpumask is provided for an
uncore PMU. Historically we treat that as having a cpumask of all
online CPUs.

There are other workaround case the perf code deals with:
 - the cpumasks are rewritten for the benefit of NUMA support when
there is sub-NUMA clustering:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/arch/x86/util/pmu.c?h=3Dperf-tools-next#n309
 - on ARM there has been a history of broken cpumasks (note on ARM
both arm and arm64 arch directories get into the perf build):
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/arch/arm/util/pmu.c?h=3Dperf-tools-next#n43

There was an unresolved bug on ARM PMUs where CPU hot plugging
wouldn't update the cpumask and so perf would request typically uncore
events be opened on a CPU that was offline. A driver fix for that was
sent. IIRC Will Deacon had concerns that the kernel's perf API was
racy, a CPU hot plug could happen immediately after the read, and so
that never landed. I believe this means that if you offline a CPU that
is in an ARM uncore cpumask the intersection computation above will
make the cpumask empty and so we therefore open the event on all the
online CPUs. Doing that will likely cause multiplexing, aggregation of
the same count many times and a massive miscalculation of the uncore
event's count.

I therefore believe, with the caveats above, that the cpumask on
perf's internal pmu can never be empty. As it is a complicated thing
that has real implications for how events get opened, I think it is
best to just always print it.

Thanks,
Ian



> >
> > > +                               cpu_map__fprintf(pmu->cpus, stdout);
> > > +                       } else {
> > > +                               printf("\n");
> > > +                       }
> > > +               }
> > > +
> > > +               perf_pmu__caps_parse(pmu);
> > > +               list_for_each_entry(caps, &pmu->caps, list) {
> > > +                       printf("  caps: %s =3D %s\n", caps->name, cap=
s->value);
> > > +               }
> > > +       }
> > > +       return 0;
> >
> > If not found return an error?
>
> Yep, good idea.
>
> Thanks for the review!
> Namhyung
>
> >
> > > +}
> > > +
> > >  int cmd_check(int argc, const char **argv)
> > >  {
> > >         argc =3D parse_options_subcommand(argc, argv, check_options,
> > > @@ -290,6 +346,8 @@ int cmd_check(int argc, const char **argv)
> > >                 return subcommand_feature(argc, argv);
> > >         if (strcmp(argv[0], "system") =3D=3D 0)
> > >                 return subcommand_system(argc, argv);
> > > +       if (strcmp(argv[0], "pmu") =3D=3D 0)
> > > +               return subcommand_pmu(argc, argv);
> > >
> > >         /* If no subcommand matched above, print usage help */
> > >         pr_err("Unknown subcommand: %s\n", argv[0]);
> > > --
> > > 2.51.0
> > >
