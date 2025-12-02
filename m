Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C237E110;
	Tue,  2 Dec 2025 21:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764711080; cv=none; b=m8Ja4WF4rbcD01W3KL7mqimylIgvGwzGtENwbXEepOaGa4gGuL0uyxdyfbpAYtOhOxJSQxmtDgTj4q7lJgqBl7T55adu7qS12nD3jx27aWqcBsug5JeSYnICfCiTB5QfDH8tEhGANHCIvOtGD3LCIecgRjVPK2vL73OnBPvw6Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764711080; c=relaxed/simple;
	bh=aSqXf4YtOX58FS+a7pKcG3tqhkTkvyrQWYlnlBPKIbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFhynZQ2hvmSj1iYVUO0k8XavfyiHG1ZA21tf+GfLe90DLVCoOrP2qfc2f7i5eg6g5Jt3VuwiTENxghe2MDW0tiXG+LPrm0TT/rYkQyaZeAJ/l+c+Zw9e0KoLA5glU+J89bP/tRrJNdHAAEmwJvKnGwpWmPPE+iFjcrXMHYXpck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+ckGI0E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+ckGI0E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F67CC4CEF1;
	Tue,  2 Dec 2025 21:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764711079;
	bh=aSqXf4YtOX58FS+a7pKcG3tqhkTkvyrQWYlnlBPKIbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K+ckGI0EhwdXTbwDhWOI8VjLqUvnM5Wq/pseHscHYGy0hJrXPNBHoinwvDQ50g4g9
	 K6d6x6BaDJ4MkucoQvX8X1fg3no6pYBFkNWiW0y8qSBDuXJEPUIv5STMf+X5m2cy0s
	 ATxMvvVO5CqGgTgqkRFnxR5hq+HR+lqLePdzk7XRSqMEeqKR17nlr1VON2pgIMSBEJ
	 ntFmcXleHSHJEm42XkbXvN/seKT4agcpPQEWc1LF8r0oGPg5bhL0/r2XQSCyv1yJBP
	 iGdk3fos0aJ8MQvZcB8q915EZeZL+xnvJznoMeEsNkTBWBIneymCKTmLm4/2i7lLAO
	 etKN5cz7ED7xQ==
Date: Tue, 2 Dec 2025 13:31:16 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 5/5] perf test: Add kallsyms split test
Message-ID: <aS9apLuojAO9ZHo5@google.com>
References: <20251202081645.931527-1-namhyung@kernel.org>
 <20251202081645.931527-6-namhyung@kernel.org>
 <CAP-5=fVQz--juRTRg82_oWUpWrt=kzwhEgR=c_zCQ3X3sf5sdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVQz--juRTRg82_oWUpWrt=kzwhEgR=c_zCQ3X3sf5sdg@mail.gmail.com>

On Tue, Dec 02, 2025 at 12:46:16PM -0800, Ian Rogers wrote:
> On Tue, Dec 2, 2025 at 12:16 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Add fake_root directory for /proc/{version,modules,kallsyms}.  The
> > kallsyms has a bad symbol in the module and it causes the main map
> > splitted.  The test ensures it only has two maps - kernel and the module
> > and it finds the initial map after the module without creating the split
> > maps like [kernel].0 and so on.
> >
> >   $ perf test -vv "split kallsyms"
> >    69: split kallsyms:
> >   --- start ---
> >   test child forked, pid 921678
> >   try to find fake root directory
> >   maps__set_modules_path_dir: cannot open tests/fake_root/lib/modules/X.Y.Z dir
> >   Problems setting modules path maps, continuing anyway...
> >   Failed to open tests/fake_root/proc/kcore. Note /proc/kcore requires CAP_SYS_RAWIO capability to access.
> >   Using tests/fake_root/proc/kallsyms for symbols
> >   kernel map loaded - check symbol and map
> >   ---- end(0) ----
> >    69: split kallsyms                                                  : Ok
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/tests/Build                   |  1 +
> >  tools/perf/tests/builtin-test.c          |  1 +
> >  tools/perf/tests/fake_root/proc/kallsyms | 10 ++++
> >  tools/perf/tests/fake_root/proc/modules  |  1 +
> >  tools/perf/tests/fake_root/proc/version  |  1 +
> >  tools/perf/tests/kallsyms-split.c        | 72 ++++++++++++++++++++++++
> >  tools/perf/tests/tests.h                 |  1 +
> >  7 files changed, 87 insertions(+)
> >  create mode 100644 tools/perf/tests/fake_root/proc/kallsyms
> >  create mode 100644 tools/perf/tests/fake_root/proc/modules
> >  create mode 100644 tools/perf/tests/fake_root/proc/version
> >  create mode 100644 tools/perf/tests/kallsyms-split.c
> >
> > diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> > index af67f8ef74b49c58..c2a67ce459417e0f 100644
> > --- a/tools/perf/tests/Build
> > +++ b/tools/perf/tests/Build
> > @@ -69,6 +69,7 @@ perf-test-y += util.o
> >  perf-test-y += hwmon_pmu.o
> >  perf-test-y += tool_pmu.o
> >  perf-test-y += subcmd-help.o
> > +perf-test-y += kallsyms-split.o
> >
> >  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
> >  perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> > index 9090e8238a447826..bd6ffa8e4578431a 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -140,6 +140,7 @@ static struct test_suite *generic_tests[] = {
> >         &suite__symbols,
> >         &suite__util,
> >         &suite__subcmd_help,
> > +       &suite__kallsyms_split,
> >         NULL,
> >  };
> >
> > diff --git a/tools/perf/tests/fake_root/proc/kallsyms b/tools/perf/tests/fake_root/proc/kallsyms
> > new file mode 100644
> > index 0000000000000000..75d65639e6889c69
> > --- /dev/null
> > +++ b/tools/perf/tests/fake_root/proc/kallsyms
> > @@ -0,0 +1,10 @@
> > +ffffffffab200000 T _stext
> > +ffffffffab200010 T good_symbol
> > +ffffffffab200020 t bad_symbol
> > +ffffffffab200030 t main_symbol1
> > +ffffffffab200040 t main_symbol2
> > +ffffffffab200050 t main_symbol3
> > +ffffffffab200060 T _etext
> > +ffffffffcd000000 T start_module        [module]
> > +ffffffffab200020 u bad_symbol  [module]
> > +ffffffffcd000040 T end_module  [module]
> > diff --git a/tools/perf/tests/fake_root/proc/modules b/tools/perf/tests/fake_root/proc/modules
> > new file mode 100644
> > index 0000000000000000..608c6e2599f08d08
> > --- /dev/null
> > +++ b/tools/perf/tests/fake_root/proc/modules
> > @@ -0,0 +1 @@
> > +module 4096 1 - Live 0xffffffffcd000000
> > diff --git a/tools/perf/tests/fake_root/proc/version b/tools/perf/tests/fake_root/proc/version
> > new file mode 100644
> > index 0000000000000000..9de114d87d5e940e
> > --- /dev/null
> > +++ b/tools/perf/tests/fake_root/proc/version
> > @@ -0,0 +1 @@
> > +Linux version X.Y.Z (just for perf test)
> > diff --git a/tools/perf/tests/kallsyms-split.c b/tools/perf/tests/kallsyms-split.c
> > new file mode 100644
> > index 0000000000000000..b71a2ea6fa696895
> > --- /dev/null
> > +++ b/tools/perf/tests/kallsyms-split.c
> > @@ -0,0 +1,72 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <linux/compiler.h>
> > +#include <unistd.h>
> > +#include "util/dso.h"
> > +#include "util/map.h"
> > +#include "util/symbol.h"
> > +#include "util/debug.h"
> > +#include "util/machine.h"
> > +#include "tests.h"
> > +
> > +static int test__kallsyms_split(struct test_suite *test __maybe_unused,
> > +                               int subtest __maybe_unused)
> > +{
> > +       struct machine m;
> > +       struct map *map = NULL;
> > +       int ret = TEST_FAIL;
> > +       const char *root_dirs[] = { "tests/fake_root", "tools/perf/tests/fake_root", "fake_root" };
> 
> I'm a little concerned about what will happen with the fake_root and
> installation. I think it'd be easier to just create the kallsyms file
> on the fly. We do similar for PMU testing in:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/pmu.c?h=perf-tools-next#n41
> that'd avoid the need to search paths looking for the file. It'd also
> mean that creating a kallsyms file could be done for multiple
> different contexts for greater kallsyms testing.
 
That's also possible.  But then we need to create a temporary directory
and remove the contents when it's terminated.  I thought it'd be easier
to use the static files and just skip if not found.

Thanks,
Namhyung


> > +       unsigned int root_idx;
> > +
> > +       /* force to use /proc/kallsyms */
> > +       symbol_conf.ignore_vmlinux = true;
> > +       symbol_conf.ignore_vmlinux_buildid = true;
> > +
> > +       pr_debug("try to find fake root directory\n");
> > +       for (root_idx = 0; root_idx < ARRAY_SIZE(root_dirs); root_idx++) {
> > +               char buf[128];
> > +
> > +               scnprintf(buf, sizeof(buf), "%s/proc/kallsyms", root_dirs[root_idx]);
> > +               if (!access(buf, F_OK))
> > +                       break;
> > +       }
> > +
> > +       if (root_idx == ARRAY_SIZE(root_dirs)) {
> > +               pr_debug("SKIP: cannot find the fake root directory and files\n");
> > +               return TEST_SKIP;
> > +       }
> > +
> > +       machine__init(&m, root_dirs[root_idx], HOST_KERNEL_ID);
> > +       if (machine__create_kernel_maps(&m) < 0) {
> > +               pr_debug("FAIL: failed to create kernel maps\n");
> > +               goto out;
> > +       }
> > +
> > +       if (map__load(machine__kernel_map(&m)) < 0) {
> > +               pr_debug("SKIP: failed to load kallsyms\n");
> > +               goto out;
> > +       }
> > +
> > +       pr_debug("kernel map loaded - check symbol and map\n");
> > +       if (maps__nr_maps(machine__kernel_maps(&m)) != 2) {
> > +               pr_debug("FAIL: it should have the kernel and a module, but has %u maps\n",
> > +                        maps__nr_maps(machine__kernel_maps(&m)));
> > +               goto out;
> > +       }
> > +
> > +       if (machine__find_kernel_symbol_by_name(&m, "main_symbol3", &map) == NULL) {
> > +               pr_debug("FAIL: failed to find a symbol\n");
> > +               goto out;
> > +       }
> > +
> > +       if (!RC_CHK_EQUAL(map, machine__kernel_map(&m))) {
> > +               pr_debug("FAIL: the symbol is not in the kernel map\n");
> > +               goto out;
> > +       }
> > +       ret = TEST_OK;
> > +
> > +out:
> > +       machine__exit(&m);
> > +       return ret;
> > +}
> > +
> > +DEFINE_SUITE("split kallsyms", kallsyms_split);
> > diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> > index f5fba95b6f3ffbd3..cb67ddbd03753531 100644
> > --- a/tools/perf/tests/tests.h
> > +++ b/tools/perf/tests/tests.h
> > @@ -178,6 +178,7 @@ DECLARE_SUITE(event_groups);
> >  DECLARE_SUITE(symbols);
> >  DECLARE_SUITE(util);
> >  DECLARE_SUITE(subcmd_help);
> > +DECLARE_SUITE(kallsyms_split);
> >
> >  /*
> >   * PowerPC and S390 do not support creation of instruction breakpoints using the
> > --
> > 2.52.0.158.g65b55ccf14-goog
> >
