Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A41200112;
	Tue,  1 Jul 2025 19:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751399766; cv=none; b=Dh7YqUjEnaEUCydBkI1Z1sAnjS3N2gthjcgWznuHd+Dj3RgJLKA1Ar7L19VERhysJuoh5FvMpFDJxX3X+5IqCr8k7B452JXoGq9ICOp417pHXFKgU4+BUuE15uHejlczgmNwErrUkuYvlIKHSN+FmWVcdwFkD3E36xuH+I+UsHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751399766; c=relaxed/simple;
	bh=x4iptEmMme+uveTp2Ge6W/lFFG16Y0P08zYHR+MNrhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xj2g4yZnumiWiCQKh4+lyJM2Zjh2O0U2MCuf3jmgA81ZM+g8ozVeg1ye4WDEx2HjvpTfeXPkB24RzqVJ7i4miPOOBIG3Al12zTk9A0vRz2NRf8xLW62UTuUhzEFgwM1m2DHrsa7+Y7eWEE3lP1f6S4wGTP1Hv+yUwQ/h/LIbnio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ik9yxMCp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ik9yxMCp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA118C4CEEB;
	Tue,  1 Jul 2025 19:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751399766;
	bh=x4iptEmMme+uveTp2Ge6W/lFFG16Y0P08zYHR+MNrhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ik9yxMCpbPhII9zcFm0oUsTwaNhhmGz6VsAiECvl+1XudKhfQfiUez4vj0mxI+IEo
	 vuJx3ArPMG94TaXhvr4JRqcK3Wb1+S1A4z7JX5tygziMdRsF7uNvDwz7uOPn/cqF1H
	 7XNkFk31keQ0ATqrPqRKgWxUBtjYu4nX7vYrWJA73xGUxUk0BgSLDbFrf3iXfn9O5H
	 mAQ0jRsRg7UtzWYXAnkmwBHgexnobYNFYcrbLpzc65CkvnVQh+FjQ6eltRavnI3/p4
	 I0AJFkruit6VvJclPfK/i/pk/vmbGCXdP1aLwqMWE6GT8B7WwcAED80HiFwYUDOZly
	 xku1IarvK6DrA==
Date: Tue, 1 Jul 2025 12:56:04 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/3] perf test: Add libsubcmd help tests
Message-ID: <aGQ9VC_x3xSJLcEI@google.com>
References: <20250630233246.1063977-1-namhyung@kernel.org>
 <20250630233246.1063977-2-namhyung@kernel.org>
 <CAP-5=fVBrysrjdhabfbGO3P6wsQL_mfECzCC_MmJLBMKK8SrOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVBrysrjdhabfbGO3P6wsQL_mfECzCC_MmJLBMKK8SrOw@mail.gmail.com>

On Tue, Jul 01, 2025 at 08:54:25AM -0700, Ian Rogers wrote:
> On Mon, Jun 30, 2025 at 4:32 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Add a set of tests for subcmd routines.  Currently it fails the last one
> > since there's a bug.  It'll be fixed by the next commit.
> >
> >   $ perf test subcmd
> >    69: libsubcmd help tests                                            :
> >    69.1: Load subcmd names                                             : Ok
> >    69.2: Uniquify subcmd names                                         : Ok
> >    69.3: Exclude duplicate subcmd names                                : FAILED!
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks for your review!

> 
> > ---
> >  tools/perf/tests/Build          |   1 +
> >  tools/perf/tests/builtin-test.c |   1 +
> >  tools/perf/tests/subcmd-help.c  | 109 ++++++++++++++++++++++++++++++++
> >  tools/perf/tests/tests.h        |   1 +
> >  4 files changed, 112 insertions(+)
> >  create mode 100644 tools/perf/tests/subcmd-help.c
> >
> > diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> > index 2181f5a92148b0b9..13a81154ec1e4cd2 100644
> > --- a/tools/perf/tests/Build
> > +++ b/tools/perf/tests/Build
> > @@ -69,6 +69,7 @@ perf-test-y += symbols.o
> >  perf-test-y += util.o
> >  perf-test-y += hwmon_pmu.o
> >  perf-test-y += tool_pmu.o
> > +perf-test-y += subcmd-help.o
> >
> >  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
> >  perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> > index dfaff4185eb05a1a..2da9b69864da53c2 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -139,6 +139,7 @@ static struct test_suite *generic_tests[] = {
> >         &suite__event_groups,
> >         &suite__symbols,
> >         &suite__util,
> > +       &suite__subcmd_help,
> >         NULL,
> >  };
> >
> > diff --git a/tools/perf/tests/subcmd-help.c b/tools/perf/tests/subcmd-help.c
> > new file mode 100644
> > index 0000000000000000..d31259340ae302af
> > --- /dev/null
> > +++ b/tools/perf/tests/subcmd-help.c
> > @@ -0,0 +1,109 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "tests.h"
> > +#include <stdio.h>
> > +#include <subcmd/help.h>
> > +#include "debug.h"
> 
> nit: I don't think stdio.h and debug.h are used here.

Yeah, will remove.  I think I added it for debugging and removed the
debug code later.

Thanks,
Namhyung

> 
> > +
> > +static int test__load_cmdnames(struct test_suite *test __maybe_unused,
> > +                              int subtest __maybe_unused)
> > +{
> > +       struct cmdnames cmds = {};
> > +
> > +       add_cmdname(&cmds, "aaa", 3);
> > +       add_cmdname(&cmds, "foo", 3);
> > +       add_cmdname(&cmds, "xyz", 3);
> > +
> > +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds, "aaa") == 1);
> > +       TEST_ASSERT_VAL("wrong cmd", is_in_cmdlist(&cmds, "bar") == 0);
> > +       TEST_ASSERT_VAL("case sensitive", is_in_cmdlist(&cmds, "XYZ") == 0);
> > +
> > +       clean_cmdnames(&cmds);
> > +       return TEST_OK;
> > +}
> > +
> > +static int test__uniq_cmdnames(struct test_suite *test __maybe_unused,
> > +                              int subtest __maybe_unused)
> > +{
> > +       struct cmdnames cmds = {};
> > +
> > +       /* uniq() assumes it's sorted */
> > +       add_cmdname(&cmds, "aaa", 3);
> > +       add_cmdname(&cmds, "aaa", 3);
> > +       add_cmdname(&cmds, "bbb", 3);
> > +
> > +       TEST_ASSERT_VAL("invalid original size", cmds.cnt == 3);
> > +       /* uniquify command names (to remove second 'aaa') */
> > +       uniq(&cmds);
> > +       TEST_ASSERT_VAL("invalid final size", cmds.cnt == 2);
> > +
> > +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds, "aaa") == 1);
> > +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds, "bbb") == 1);
> > +       TEST_ASSERT_VAL("wrong cmd", is_in_cmdlist(&cmds, "ccc") == 0);
> > +
> > +       clean_cmdnames(&cmds);
> > +       return TEST_OK;
> > +}
> > +
> > +static int test__exclude_cmdnames(struct test_suite *test __maybe_unused,
> > +                                 int subtest __maybe_unused)
> > +{
> > +       struct cmdnames cmds1 = {};
> > +       struct cmdnames cmds2 = {};
> > +
> > +       add_cmdname(&cmds1, "aaa", 3);
> > +       add_cmdname(&cmds1, "bbb", 3);
> > +       add_cmdname(&cmds1, "ccc", 3);
> > +       add_cmdname(&cmds1, "ddd", 3);
> > +       add_cmdname(&cmds1, "eee", 3);
> > +       add_cmdname(&cmds1, "fff", 3);
> > +       add_cmdname(&cmds1, "ggg", 3);
> > +       add_cmdname(&cmds1, "hhh", 3);
> > +       add_cmdname(&cmds1, "iii", 3);
> > +       add_cmdname(&cmds1, "jjj", 3);
> > +
> > +       add_cmdname(&cmds2, "bbb", 3);
> > +       add_cmdname(&cmds2, "eee", 3);
> > +       add_cmdname(&cmds2, "jjj", 3);
> > +
> > +       TEST_ASSERT_VAL("invalid original size", cmds1.cnt == 10);
> > +       TEST_ASSERT_VAL("invalid original size", cmds2.cnt == 3);
> > +
> > +       /* remove duplicate command names in cmds1 */
> > +       exclude_cmds(&cmds1, &cmds2);
> > +
> > +       TEST_ASSERT_VAL("invalid excluded size", cmds1.cnt == 7);
> > +       TEST_ASSERT_VAL("invalid excluded size", cmds2.cnt == 3);
> > +
> > +       /* excluded commands should not belong to cmds1 */
> > +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds1, "aaa") == 1);
> > +       TEST_ASSERT_VAL("wrong cmd", is_in_cmdlist(&cmds1, "bbb") == 0);
> > +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds1, "ccc") == 1);
> > +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds1, "ddd") == 1);
> > +       TEST_ASSERT_VAL("wrong cmd", is_in_cmdlist(&cmds1, "eee") == 0);
> > +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds1, "fff") == 1);
> > +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds1, "ggg") == 1);
> > +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds1, "hhh") == 1);
> > +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds1, "iii") == 1);
> > +       TEST_ASSERT_VAL("wrong cmd", is_in_cmdlist(&cmds1, "jjj") == 0);
> > +
> > +       /* they should be only in cmds2 */
> > +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds2, "bbb") == 1);
> > +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds2, "eee") == 1);
> > +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds2, "jjj") == 1);
> > +
> > +       clean_cmdnames(&cmds1);
> > +       clean_cmdnames(&cmds2);
> > +       return TEST_OK;
> > +}
> > +
> > +static struct test_case tests__subcmd_help[] = {
> > +       TEST_CASE("Load subcmd names", load_cmdnames),
> > +       TEST_CASE("Uniquify subcmd names", uniq_cmdnames),
> > +       TEST_CASE("Exclude duplicate subcmd names", exclude_cmdnames),
> > +       {       .name = NULL, }
> > +};
> > +
> > +struct test_suite suite__subcmd_help = {
> > +       .desc = "libsubcmd help tests",
> > +       .test_cases = tests__subcmd_help,
> > +};
> > diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> > index 4c128a9594413b32..13cabf85185ed2d3 100644
> > --- a/tools/perf/tests/tests.h
> > +++ b/tools/perf/tests/tests.h
> > @@ -177,6 +177,7 @@ DECLARE_SUITE(sigtrap);
> >  DECLARE_SUITE(event_groups);
> >  DECLARE_SUITE(symbols);
> >  DECLARE_SUITE(util);
> > +DECLARE_SUITE(subcmd_help);
> >
> >  /*
> >   * PowerPC and S390 do not support creation of instruction breakpoints using the
> > --
> > 2.50.0.727.gbf7dc18ff4-goog
> >
