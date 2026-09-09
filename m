Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4BC53FD3B;
	Wed,  9 Sep 2026 11:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953394; cv=none; b=KpJPaj17qW2vKOJ7KltyYb+boXugtU+hCrnJgWY7exopsYIWPwgjSMgXRKUXJ0LWSnXvXGarvZo9hOogM1rVUBluJ/6IPdtZmtkGMDjOhthtKNgvPwm0aI/K8VJC9jMiOQzeiuOuubYrHq9LELX9j+8yb0NEIXkG1KyZYeDT6Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953394; c=relaxed/simple;
	bh=TRxmlTyP4B5ZCkm16rCigpCB3fiwVp5sA8mYG3brPv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNIVltOuv/m7ZHoGHIO5nNRS2bspRODtMwIcDuVDZy4qWMiWHZhWlaj8sba0rZzT8TGzFurTF4wqKpCyDQE3OOVz4l1GsfIQf4VClKtKH+t2tB+Ps3824x91R+5NjvfzPsStFam2AQ9Sw+g/Y5x7ks16oNYZY/00r0f8UBqlfRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJN5vLjh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJN5vLjh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5B31F00A3A;
	Wed,  9 Sep 2026 11:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953392;
	bh=UaGqKugJQZ36/Ry/4WMQWnoYj7oDdZ6SuiFxYYv4x+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nJN5vLjhqGceMTBVW3a343WS1UQhvBWB3Tmibwx/6xfB3bHHkrCM43l/FUY+TPrjj
	 VPLAEhsuwjPVmbKWrvV6pdafv+hgZVvJauUymG1QAUAZTY7vhCfU/OyzqlwPPGK9KU
	 lR6ezSjaYVQ4ORxxD1kw0CmI14CR2fYIDV1zZT0JyI1kMKcN2QBMEnf8Rsu15kN2lm
	 lKSbEt/kbwpX65BIA0Q04w2Btah+QL0Gl0ZazutXPjGZ2P1tsoEJtuRw3FLX4u17xh
	 iCRdNkvxGBf34ZEvWANOf4aMgLYRCDLZB27ibZhFudSxuEoctrQvw7qjOfLYSHd5ho
	 2BeUzg3aA7AlA==
Date: Wed, 9 Sep 2026 08:29:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Matt Turner <mattst88@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v8 0/3] perf tools: port UI from GTK2 to GTK4
Message-ID: <aqFDLQ5Yu7yg6Y2Z@x2>
References: <20260908-perf-gtk2-v8-0-e90d5d155f0d@gmail.com>
 <aqE_QOp-x1aOQsCX@x2>
 <aqFCMfb94Cdumemm@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqFCMfb94Cdumemm@x2>

On Wed, Sep 09, 2026 at 08:25:41AM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Sep 09, 2026 at 08:13:07AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Sep 08, 2026 at 10:50:33PM -0400, Matt Turner wrote:
> > > GTK2 is long dead upstream and increasingly hard to keep building on
> > > current distros. This series ports perf's GTK-based report browser to
> > > GTK4 and fixes it up so it's actually loadable at runtime after the
> > > port.
> > > 
> > > Patch 1 does the mechanical port (build system, widget API changes),
> > > including the leftover-GTK2-call and signal-handling fixes that were a
> > > separate patch 3 in v4. Patch 2 fixes a runtime issue found after the
> > > port that prevented the browser from loading. Patch 3 fixes two stack
> > > buffer overflows in the hierarchy view that predate the port.
> > 
> > I'm tentatively merging this, will test build on my distro container set
> > and perform some testing, thanks for working on this!
> 
> Some fuzz applying the first patch in the series:
> 
> ⬢ [acme@toolbx perf-tools-next]$ patch -p1 < ./v8_20260908_mattst88_perf_tools_port_ui_from_gtk2_to_gtk4.mbx
> patching file tools/build/Makefile.feature
> patching file tools/build/feature/Makefile
> patching file tools/build/feature/test-gtk2-infobar.c
> patching file tools/build/feature/test-gtk4.c (renamed from tools/build/feature/test-gtk2.c)
> patching file tools/perf/Documentation/perf-report.txt
> Hunk #1 succeeded at 354 with fuzz 2 (offset 3 lines).
> patching file tools/perf/Makefile
> patching file tools/perf/Makefile.config
> patching file tools/perf/Makefile.perf
> patching file tools/perf/builtin-annotate.c
> Hunk #1 succeeded at 61 (offset 9 lines).
> Hunk #2 succeeded at 721 (offset 9 lines).
> Hunk #3 succeeded at 840 (offset 12 lines).
> Hunk #4 succeeded at 910 (offset 12 lines).
> patching file tools/perf/builtin-report.c
> Hunk #1 succeeded at 83 (offset 1 line).
> Hunk #2 succeeded at 1360 (offset 1 line).
> Hunk #3 succeeded at 1714 (offset 4 lines).
> patching file tools/perf/scripts/install-build-deps.sh
> patching file tools/perf/tests/make
> patching file tools/perf/ui/gtk/annotate.c
> patching file tools/perf/ui/gtk/browser.c
> patching file tools/perf/ui/gtk/gtk.h
> patching file tools/perf/ui/gtk/hists.c
> patching file tools/perf/ui/gtk/progress.c
> patching file tools/perf/ui/gtk/setup.c
> patching file tools/perf/ui/gtk/util.c
> patching file tools/perf/ui/setup.c
> ⬢ [acme@toolbx perf-tools-next]$
> 
> I fixed it up quickly, now lets see the rest...

Trying to build with it with just the first patch in this series in it
correctly discovers that the gtk4 devel files are not available but then
proceed to try to include gtk code and thus fail, where it should just
do what the feature detection states: disable gtk support but build
successfully without it, I'm checking if this is a quick surgery.

- Arnaldo

⬢ [acme@toolbx perf-tools-next]$ alias m='rm -rf ~/libexec/perf-core/ ; make -k GTK4=1 O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin && perf test import && cat /tmp/build/$(basename $PWD)/feature/test-all.make.output' ; export PYTHONPATH=/tmp/build/$(basename $PWD)/python
⬢ [acme@toolbx perf-tools-next]$ m
make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
  BUILD:   Doing 'make -j32' parallel build
Makefile.config:781: GTK4 not found, disables GTK4 support. Please install gtk4-devel or libgtk-4-dev

Auto-detecting system features:
...                                   libdw: [ on  ]
...                                   glibc: [ on  ]
...                                    gtk4: [ OFF ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                               libpython: [ on  ]
...                             libcapstone: [ on  ]
...                               llvm-perf: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]
...                              libopenssl: [ on  ]
...                                    rust: [ on  ]

  INSTALL libsubcmd_headers
  INSTALL libsymbol_headers
  INSTALL libapi_headers
  INSTALL libperf_headers
  CC      /tmp/build/perf-tools-next/libperf/core.o
  CC      /tmp/build/perf-tools-next/libperf/cpumap.o
  CC      /tmp/build/perf-tools-next/libperf/threadmap.o
  CC      /tmp/build/perf-tools-next/libperf/evsel.o
  CC      /tmp/build/perf-tools-next/libsubcmd/exec-cmd.o
  CC      /tmp/build/perf-tools-next/libperf/evlist.o
  CC      /tmp/build/perf-tools-next/libperf/mmap.o
  INSTALL libbpf_headers
  CC      /tmp/build/perf-tools-next/libsubcmd/help.o
  CC      /tmp/build/perf-tools-next/libperf/zalloc.o
  CC      /tmp/build/perf-tools-next/libsubcmd/pager.o
  CC      /tmp/build/perf-tools-next/libperf/xyarray.o
  CC      /tmp/build/perf-tools-next/libsubcmd/parse-options.o
  CC      /tmp/build/perf-tools-next/libperf/lib.o
  CC      /tmp/build/perf-tools-next/libsubcmd/run-command.o
  CC      /tmp/build/perf-tools-next/libsubcmd/sigchain.o
  CC      /tmp/build/perf-tools-next/libsubcmd/subcmd-config.o
  LD      /tmp/build/perf-tools-next/libsubcmd/libsubcmd-in.o
  AR      /tmp/build/perf-tools-next/libsubcmd/libsubcmd.a
  LD      /tmp/build/perf-tools-next/libperf/libperf-in.o
  AR      /tmp/build/perf-tools-next/libperf/libperf.a
  MKDIR   /tmp/build/perf-tools-next/ui/gtk/
  CC      /tmp/build/perf-tools-next/jvmti/libjvmti.o
  MKDIR   /tmp/build/perf-tools-next/ui/gtk/
  CC      /tmp/build/perf-tools-next/trace/beauty/syscalltbl.o
  MKDIR   /tmp/build/perf-tools-next/ui/gtk/
  CC      /tmp/build/perf-tools-next/arch/common.o
  CC      /tmp/build/perf-tools-next/jvmti/jvmti_agent.o
  MKDIR   /tmp/build/perf-tools-next/ui/gtk/
  MKDIR   /tmp/build/perf-tools-next/ui/gtk/
  CC      /tmp/build/perf-tools-next/trace/beauty/arch_errno_names.o
  CC      /tmp/build/perf-tools-next/ui/setup.o
  CC      /tmp/build/perf-tools-next/jvmti/libstring.o
  MKDIR   /tmp/build/perf-tools-next/ui/gtk/
  CC      /tmp/build/perf-tools-next/ui/helpline.o
  CC      /tmp/build/perf-tools-next/jvmti/libctype.o
  CC      /tmp/build/perf-tools-next/arch/x86/tests/regs_load.o
  CC      /tmp/build/perf-tools-next/ui/gtk/browser.o
  CC      /tmp/build/perf-tools-next/ui/gtk/hists.o
  CC      /tmp/build/perf-tools-next/ui/gtk/setup.o
  CC      /tmp/build/perf-tools-next/ui/gtk/annotate.o
  CC      /tmp/build/perf-tools-next/ui/progress.o
  CC      /tmp/build/perf-tools-next/scripts/python/Perf-Trace-Util/Context.o
  CC      /tmp/build/perf-tools-next/ui/gtk/util.o
  CC      /tmp/build/perf-tools-next/ui/util.o
  CC      /tmp/build/perf-tools-next/ui/gtk/helpline.o
  CC      /tmp/build/perf-tools-next/ui/gtk/zalloc.o
  CC      /tmp/build/perf-tools-next/arch/x86/tests/dwarf-unwind.o
  CC      /tmp/build/perf-tools-next/ui/gtk/progress.o
  CC      /tmp/build/perf-tools-next/arch/x86/tests/arch-tests.o
  CC      /tmp/build/perf-tools-next/ui/hist.o
  CC      /tmp/build/perf-tools-next/arch/x86/tests/hybrid.o
  CC      /tmp/build/perf-tools-next/builtin-annotate.o
  CC      /tmp/build/perf-tools-next/arch/x86/util/header.o
  CC      /tmp/build/perf-tools-next/arch/x86/tests/intel-pt-test.o
  CC      /tmp/build/perf-tools-next/ui/stdio/hist.o
  CC      /tmp/build/perf-tools-next/arch/x86/tests/bp-modify.o
  CC      /tmp/build/perf-tools-next/ui/browser.o
  CC      /tmp/build/perf-tools-next/tests/builtin-test.o
  CC      /tmp/build/perf-tools-next/ui/keysyms.o
  CC      /tmp/build/perf-tools-next/arch/x86/util/tsc.o
  CC      /tmp/build/perf-tools-next/arch/x86/tests/amd-ibs-via-core-pmu.o
  CC      /tmp/build/perf-tools-next/tests/tests-scripts.o
  CC      /tmp/build/perf-tools-next/builtin-check.o
  LD      /tmp/build/perf-tools-next/trace/beauty/perf-util-in.o
  CC      /tmp/build/perf-tools-next/arch/x86/util/pmu.o
  CC      /tmp/build/perf-tools-next/arch/x86/tests/amd-ibs-period.o
  CC      /tmp/build/perf-tools-next/builtin-config.o
  LD      /tmp/build/perf-tools-next/jvmti/jvmti-in.o
  LD      /tmp/build/perf-tools-next/scripts/python/Perf-Trace-Util/perf-util-in.o
  CC      /tmp/build/perf-tools-next/tests/parse-events.o
  CC      /tmp/build/perf-tools-next/arch/x86/util/topdown.o
  CC      /tmp/build/perf-tools-next/arch/x86/tests/topdown.o
  CC      /tmp/build/perf-tools-next/builtin-diff.o
In file included from ui/gtk/setup.c:2:
ui/gtk/gtk.h:8:10: fatal error: gtk/gtk.h: No such file or directory
    8 | #include <gtk/gtk.h>
      |          ^~~~~~~~~~~
compilation terminated.
  CC      /tmp/build/perf-tools-next/tests/uncore-event-sorting.o
In file included from ui/gtk/annotate.c:2:
ui/gtk/gtk.h:8:10: fatal error: gtk/gtk.h: No such file or directory
    8 | #include <gtk/gtk.h>
      |          ^~~~~~~~~~~
In file included from ui/gtk/helpline.c:2:
ui/gtk/gtk.h:8:10: fatal error: gtk/gtk.h: No such file or directory
    8 | #include <gtk/gtk.h>
      |          ^~~~~~~~~~~
compilation terminated.
compilation terminated.
In file included from ui/gtk/browser.c:2:
ui/gtk/gtk.h:8:10: fatal error: gtk/gtk.h: No such file or directory
    8 | #include <gtk/gtk.h>
      |          ^~~~~~~~~~~
compilation terminated.
  CC      /tmp/build/perf-tools-next/ui/tui/setup.o
  CC      /tmp/build/perf-tools-next/arch/x86/util/machine.o
In file included from ui/gtk/util.c:3:
ui/gtk/gtk.h:8:10: fatal error: gtk/gtk.h: No such file or directory
    8 | #include <gtk/gtk.h>
      |          ^~~~~~~~~~~
compilation terminated.
In file included from ui/gtk/hists.c:2:
ui/gtk/gtk.h:8:10: fatal error: gtk/gtk.h: No such file or directory
    8 | #include <gtk/gtk.h>
      |          ^~~~~~~~~~~
compilation terminated.
make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:96: /tmp/build/perf-tools-next/ui/gtk/annotate.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:96: /tmp/build/perf-tools-next/ui/gtk/browser.o] Error 1
  CC      /tmp/build/perf-tools-next/ui/browsers/annotate.o
make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:96: /tmp/build/perf-tools-next/ui/gtk/helpline.o] Error 1
make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:96: /tmp/build/perf-tools-next/ui/gtk/setup.o] Error 1
  CC      /tmp/build/perf-tools-next/tests/dso-data.o
make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:96: /tmp/build/perf-tools-next/ui/gtk/hists.o] Error 1
make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:96: /tmp/build/perf-tools-next/ui/gtk/util.o] Error 1
  CC      /tmp/build/perf-tools-next/arch/x86/util/event.o
  CC      /tmp/build/perf-tools-next/builtin-evlist.o
  CC      /tmp/build/perf-tools-next/ui/tui/util.o
  LD      /tmp/build/perf-tools-next/scripts/perf-util-in.o
  CC      /tmp/build/perf-tools-next/tests/vmlinux-kallsyms.o
  CC      /tmp/build/perf-tools-next/arch/x86/util/evlist.o
  CC      /tmp/build/perf-tools-next/ui/tui/helpline.o
  CC      /tmp/build/perf-tools-next/builtin-ftrace.o
  CC      /tmp/build/perf-tools-next/ui/browsers/annotate-data.o
  CC      /tmp/build/perf-tools-next/arch/x86/util/mem-events.o
  CC      /tmp/build/perf-tools-next/tests/openat-syscall.o
  CC      /tmp/build/perf-tools-next/ui/tui/progress.o
  CC      /tmp/build/perf-tools-next/builtin-help.o
  CC      /tmp/build/perf-tools-next/ui/browsers/hists.o
  CC      /tmp/build/perf-tools-next/tests/openat-syscall-all-cpus.o
  CC      /tmp/build/perf-tools-next/arch/x86/util/evsel.o
  CC      /tmp/build/perf-tools-next/builtin-buildid-list.o
  CC      /tmp/build/perf-tools-next/tests/openat-syscall-tp-fields.o
  LD      /tmp/build/perf-tools-next/arch/x86/tests/perf-test-in.o
In file included from ui/gtk/progress.c:5:
ui/gtk/gtk.h:8:10: fatal error: gtk/gtk.h: No such file or directory
    8 | #include <gtk/gtk.h>
      |          ^~~~~~~~~~~
compilation terminated.
  CC      /tmp/build/perf-tools-next/builtin-buildid-cache.o
  CC      /tmp/build/perf-tools-next/tests/mmap-basic.o
  CC      /tmp/build/perf-tools-next/builtin-kallsyms.o
  CC      /tmp/build/perf-tools-next/ui/browsers/map.o
  CC      /tmp/build/perf-tools-next/tests/perf-record.o
make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:96: /tmp/build/perf-tools-next/ui/gtk/progress.o] Error 1
  CC      /tmp/build/perf-tools-next/arch/x86/util/iostat.o
  CC      /tmp/build/perf-tools-next/builtin-list.o
  CC      /tmp/build/perf-tools-next/ui/browsers/scripts.o
  CC      /tmp/build/perf-tools-next/tests/evsel-roundtrip-name.o
  CC      /tmp/build/perf-tools-next/arch/x86/util/auxtrace.o
  CC      /tmp/build/perf-tools-next/ui/browsers/header.o
  CC      /tmp/build/perf-tools-next/builtin-record.o
  LD      /tmp/build/perf-tools-next/arch/x86/perf-test-in.o
  CC      /tmp/build/perf-tools-next/tests/evsel-tp-sched.o
  CC      /tmp/build/perf-tools-next/arch/x86/util/intel-pt.o
  CC      /tmp/build/perf-tools-next/builtin-report.o
  CC      /tmp/build/perf-tools-next/ui/browsers/res_sample.o
  CC      /tmp/build/perf-tools-next/builtin-stat.o
  LD      /tmp/build/perf-tools-next/arch/perf-test-in.o
  CC      /tmp/build/perf-tools-next/arch/x86/util/intel-bts.o
  CC      /tmp/build/perf-tools-next/ui/browsers/c2c-function.o
  CC      /tmp/build/perf-tools-next/builtin-top.o
  CC      /tmp/build/perf-tools-next/builtin-script.o
  CC      /tmp/build/perf-tools-next/tests/fdarray.o
  LINK    /tmp/build/perf-tools-next/libperf-jvmti.so
  CC      /tmp/build/perf-tools-next/builtin-kvm.o
  CC      /tmp/build/perf-tools-next/tests/pmu.o
  CC      /tmp/build/perf-tools-next/builtin-inject.o
  CC      /tmp/build/perf-tools-next/tests/pmu-events.o
  CC      /tmp/build/perf-tools-next/builtin-mem.o
  CC      /tmp/build/perf-tools-next/tests/hists_common.o
  CC      /tmp/build/perf-tools-next/builtin-data.o
  CC      /tmp/build/perf-tools-next/builtin-version.o
  LD      /tmp/build/perf-tools-next/arch/x86/util/perf-util-in.o
  CC      /tmp/build/perf-tools-next/tests/hists_link.o
  CC      /tmp/build/perf-tools-next/builtin-c2c.o
  CC      /tmp/build/perf-tools-next/tests/hists_filter.o
make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:158: ui/gtk] Error 2
make[2]: *** [Makefile.perf:584: /tmp/build/perf-tools-next/gtk-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
  CC      /tmp/build/perf-tools-next/builtin-daemon.o

