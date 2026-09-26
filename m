Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBC73630A0;
	Sat, 26 Sep 2026 18:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790448995; cv=none; b=N/h4jlZ5Y9hQvM4AUtalhZs9pdd3WZAvhEWZPEtArJETqZfxU3RBwEhyoXZxqvC/8N0TjaXDgmJllhMPPsM4WyvKtHaZ1QRTx0IY9HlngQhq5L4MvAXymgmblt2EYAUm5Wb7ilpopesFN11cI3kIqLexLrKFSg+gMexROm1A/gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790448995; c=relaxed/simple;
	bh=oB5kDSHpFybSDEUubF68pOMMKw3z1UcQhTkQZVGl2PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5Y3mLWVPfEBh/7EQtR90IlXyvKUU8cof+HdyWq+NzRauyG78D4P6NvopwJr5BXCsAmUMlii6B3IAtZmJwgn3FupabhvUzZHyBwrM7txTAmLrQQPN6DvzpL3/vrk5WP8OC9hL/hfRQ5WTukgv2jlqGpeIxIDP84liyUW0mYtHyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyvuIjvu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyvuIjvu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A3F1F000FF;
	Sat, 26 Sep 2026 18:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790448979;
	bh=N7DrUvCcsSosPH/hr6/KQz2fMDmiGjJPiJ7T5kljh2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iyvuIjvuaFX4VNV5Kb9ZSw6oPFPbjOsQpsmqmX/QS60wI5VVftcGKV73ixUlL0U07
	 ymGlUPx6v+xdbrIk4EpejJ0l8lWfDjDkOiux/vZqxSdYcB4dwwZya51mWl5RICPYeN
	 YVBRNozDRx9mWBUJXovCKJmKCyrHNuid2MD+fQz2iWKIXIDKTKbw8Qdab/dNLMz9yN
	 ekn18gvFxdyHqLO5a2PXgam9zh6yi3OIlpe/MZvYhqR0cw9VItLsB9dm9jSUhxgvqw
	 AZKUaVXiaaMJx8XC/qQN3Vco8tNCM/Q2v5HE9RBXExO5JVAkLja/YcchhAsE7bYimn
	 43uecd5KIVeMQ==
Date: Sat, 26 Sep 2026 20:56:15 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: alice.mei.rogers@gmail.com, james.clark@linaro.org, leo.yan@linux.dev,
	namhyung@kernel.org, adrian.hunter@intel.com,
	dapeng1.mi@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org, tmricht@linux.ibm.com
Subject: Re: [PATCH v4 46/49] perf: Remove libpython support and legacy
 Python scripts
Message-ID: <argVT3RHLso7Iz8e@x2>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-47-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926062029.800743-47-irogers@google.com>

On Fri, Sep 25, 2026 at 11:20:13PM -0700, Ian Rogers wrote:
> Remove embedded Python interpreter support (libpython) from perf, as
> all Python scripts have been migrated to standalone scripts using the
> perf Python extension module.
> 
> Changes include:
> - Remove libpython detection and build flags from Makefile.config.
> - Remove legacy Python script installation rules from Makefile.perf.
> - Delete tools/perf/util/scripting-engines/trace-event-python.c and
>   tools/perf/scripts/python/Perf-Trace-Util/Context.c.
> - Remove Python scripting engine registration from
>   trace-event-scripting.c.
> - Remove libpython from the supported features list in builtin-check.c
>   and Documentation/perf-check.txt.
> - Delete the legacy Python scripts and bin wrappers in
>   tools/perf/scripts/python/ and update shell tests.

This one had a small clash with the python 3.9 patch, I'll put this in
tmp.perf-tools-next so that you can double check if I resolved the
conflict correctly.

- Arnaldo
 
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Documentation/perf-check.txt       |    1 -
>  tools/perf/Makefile.config                    |   26 +-
>  tools/perf/Makefile.perf                      |    7 +-
>  tools/perf/builtin-check.c                    |    2 +-
>  tools/perf/scripts/Build                      |   27 -
>  .../perf/scripts/python/Perf-Trace-Util/Build |    4 -
>  .../scripts/python/Perf-Trace-Util/Context.c  |  225 --
>  .../Perf-Trace-Util/lib/Perf/Trace/Core.py    |  116 -
>  .../lib/Perf/Trace/EventClass.py              |   97 -
>  .../lib/Perf/Trace/SchedGui.py                |  184 --
>  .../Perf-Trace-Util/lib/Perf/Trace/Util.py    |   92 -
>  .../scripts/python/arm-cs-trace-disasm.py     |  356 ---
>  .../python/bin/compaction-times-record        |    2 -
>  .../python/bin/compaction-times-report        |    4 -
>  .../python/bin/event_analyzing_sample-record  |    8 -
>  .../python/bin/event_analyzing_sample-report  |    3 -
>  .../python/bin/export-to-postgresql-record    |    8 -
>  .../python/bin/export-to-postgresql-report    |   29 -
>  .../python/bin/export-to-sqlite-record        |    8 -
>  .../python/bin/export-to-sqlite-report        |   29 -
>  .../python/bin/failed-syscalls-by-pid-record  |    3 -
>  .../python/bin/failed-syscalls-by-pid-report  |   10 -
>  .../perf/scripts/python/bin/flamegraph-record |    2 -
>  .../perf/scripts/python/bin/flamegraph-report |    3 -
>  .../python/bin/futex-contention-record        |    2 -
>  .../python/bin/futex-contention-report        |    4 -
>  tools/perf/scripts/python/bin/gecko-record    |    2 -
>  tools/perf/scripts/python/bin/gecko-report    |    7 -
>  .../scripts/python/bin/intel-pt-events-record |   13 -
>  .../scripts/python/bin/intel-pt-events-report |    3 -
>  .../scripts/python/bin/mem-phys-addr-record   |   19 -
>  .../scripts/python/bin/mem-phys-addr-report   |    3 -
>  .../scripts/python/bin/net_dropmonitor-record |    2 -
>  .../scripts/python/bin/net_dropmonitor-report |    4 -
>  .../scripts/python/bin/netdev-times-record    |    8 -
>  .../scripts/python/bin/netdev-times-report    |    5 -
>  .../scripts/python/bin/powerpc-hcalls-record  |    2 -
>  .../scripts/python/bin/powerpc-hcalls-report  |    2 -
>  .../scripts/python/bin/sched-migration-record |    2 -
>  .../scripts/python/bin/sched-migration-report |    3 -
>  tools/perf/scripts/python/bin/sctop-record    |    3 -
>  tools/perf/scripts/python/bin/sctop-report    |   24 -
>  .../scripts/python/bin/stackcollapse-record   |    8 -
>  .../scripts/python/bin/stackcollapse-report   |    3 -
>  .../python/bin/syscall-counts-by-pid-record   |    3 -
>  .../python/bin/syscall-counts-by-pid-report   |   10 -
>  .../scripts/python/bin/syscall-counts-record  |    3 -
>  .../scripts/python/bin/syscall-counts-report  |   10 -
>  .../scripts/python/bin/task-analyzer-record   |    2 -
>  .../scripts/python/bin/task-analyzer-report   |    3 -
>  tools/perf/scripts/python/check-perf-trace.py |   84 -
>  tools/perf/scripts/python/compaction-times.py |  311 ---
>  .../scripts/python/event_analyzing_sample.py  |  192 --
>  .../scripts/python/export-to-postgresql.py    | 1114 --------
>  tools/perf/scripts/python/export-to-sqlite.py |  799 ------
>  .../scripts/python/failed-syscalls-by-pid.py  |   79 -
>  tools/perf/scripts/python/flamegraph.py       |  267 --
>  tools/perf/scripts/python/futex-contention.py |   57 -
>  tools/perf/scripts/python/gecko.py            |  395 ---
>  tools/perf/scripts/python/intel-pt-events.py  |  494 ----
>  tools/perf/scripts/python/libxed.py           |  107 -
>  tools/perf/scripts/python/mem-phys-addr.py    |  127 -
>  tools/perf/scripts/python/net_dropmonitor.py  |   78 -
>  tools/perf/scripts/python/netdev-times.py     |  473 ----
>  tools/perf/scripts/python/powerpc-hcalls.py   |  335 ---
>  tools/perf/scripts/python/sched-migration.py  |  462 ----
>  tools/perf/scripts/python/sctop.py            |   89 -
>  tools/perf/scripts/python/stackcollapse.py    |  127 -
>  tools/perf/scripts/python/stat-cpi.py         |   79 -
>  .../scripts/python/syscall-counts-by-pid.py   |   75 -
>  tools/perf/scripts/python/syscall-counts.py   |   65 -
>  tools/perf/scripts/python/task-analyzer.py    |  934 -------
>  tools/perf/tests/shell/script.sh              |   42 -
>  tools/perf/tests/shell/script_python.sh       |  113 -
>  tools/perf/util/scripting-engines/Build       |    4 -
>  .../scripting-engines/trace-event-python.c    | 2335 -----------------
>  tools/perf/util/trace-event-scripting.c       |    9 -
>  77 files changed, 4 insertions(+), 10638 deletions(-)
>  delete mode 100644 tools/perf/scripts/python/Perf-Trace-Util/Build
>  delete mode 100644 tools/perf/scripts/python/Perf-Trace-Util/Context.c
>  delete mode 100644 tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py
>  delete mode 100755 tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py
>  delete mode 100644 tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py
>  delete mode 100644 tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
>  delete mode 100755 tools/perf/scripts/python/arm-cs-trace-disasm.py
>  delete mode 100644 tools/perf/scripts/python/bin/compaction-times-record
>  delete mode 100644 tools/perf/scripts/python/bin/compaction-times-report
>  delete mode 100644 tools/perf/scripts/python/bin/event_analyzing_sample-record
>  delete mode 100644 tools/perf/scripts/python/bin/event_analyzing_sample-report
>  delete mode 100644 tools/perf/scripts/python/bin/export-to-postgresql-record
>  delete mode 100644 tools/perf/scripts/python/bin/export-to-postgresql-report
>  delete mode 100644 tools/perf/scripts/python/bin/export-to-sqlite-record
>  delete mode 100644 tools/perf/scripts/python/bin/export-to-sqlite-report
>  delete mode 100644 tools/perf/scripts/python/bin/failed-syscalls-by-pid-record
>  delete mode 100644 tools/perf/scripts/python/bin/failed-syscalls-by-pid-report
>  delete mode 100755 tools/perf/scripts/python/bin/flamegraph-record
>  delete mode 100755 tools/perf/scripts/python/bin/flamegraph-report
>  delete mode 100644 tools/perf/scripts/python/bin/futex-contention-record
>  delete mode 100644 tools/perf/scripts/python/bin/futex-contention-report
>  delete mode 100644 tools/perf/scripts/python/bin/gecko-record
>  delete mode 100755 tools/perf/scripts/python/bin/gecko-report
>  delete mode 100644 tools/perf/scripts/python/bin/intel-pt-events-record
>  delete mode 100644 tools/perf/scripts/python/bin/intel-pt-events-report
>  delete mode 100644 tools/perf/scripts/python/bin/mem-phys-addr-record
>  delete mode 100644 tools/perf/scripts/python/bin/mem-phys-addr-report
>  delete mode 100755 tools/perf/scripts/python/bin/net_dropmonitor-record
>  delete mode 100755 tools/perf/scripts/python/bin/net_dropmonitor-report
>  delete mode 100644 tools/perf/scripts/python/bin/netdev-times-record
>  delete mode 100644 tools/perf/scripts/python/bin/netdev-times-report
>  delete mode 100644 tools/perf/scripts/python/bin/powerpc-hcalls-record
>  delete mode 100644 tools/perf/scripts/python/bin/powerpc-hcalls-report
>  delete mode 100644 tools/perf/scripts/python/bin/sched-migration-record
>  delete mode 100644 tools/perf/scripts/python/bin/sched-migration-report
>  delete mode 100644 tools/perf/scripts/python/bin/sctop-record
>  delete mode 100644 tools/perf/scripts/python/bin/sctop-report
>  delete mode 100755 tools/perf/scripts/python/bin/stackcollapse-record
>  delete mode 100755 tools/perf/scripts/python/bin/stackcollapse-report
>  delete mode 100644 tools/perf/scripts/python/bin/syscall-counts-by-pid-record
>  delete mode 100644 tools/perf/scripts/python/bin/syscall-counts-by-pid-report
>  delete mode 100644 tools/perf/scripts/python/bin/syscall-counts-record
>  delete mode 100644 tools/perf/scripts/python/bin/syscall-counts-report
>  delete mode 100755 tools/perf/scripts/python/bin/task-analyzer-record
>  delete mode 100755 tools/perf/scripts/python/bin/task-analyzer-report
>  delete mode 100644 tools/perf/scripts/python/check-perf-trace.py
>  delete mode 100644 tools/perf/scripts/python/compaction-times.py
>  delete mode 100644 tools/perf/scripts/python/event_analyzing_sample.py
>  delete mode 100644 tools/perf/scripts/python/export-to-postgresql.py
>  delete mode 100644 tools/perf/scripts/python/export-to-sqlite.py
>  delete mode 100644 tools/perf/scripts/python/failed-syscalls-by-pid.py
>  delete mode 100755 tools/perf/scripts/python/flamegraph.py
>  delete mode 100644 tools/perf/scripts/python/futex-contention.py
>  delete mode 100644 tools/perf/scripts/python/gecko.py
>  delete mode 100644 tools/perf/scripts/python/intel-pt-events.py
>  delete mode 100644 tools/perf/scripts/python/libxed.py
>  delete mode 100644 tools/perf/scripts/python/mem-phys-addr.py
>  delete mode 100755 tools/perf/scripts/python/net_dropmonitor.py
>  delete mode 100644 tools/perf/scripts/python/netdev-times.py
>  delete mode 100644 tools/perf/scripts/python/powerpc-hcalls.py
>  delete mode 100644 tools/perf/scripts/python/sched-migration.py
>  delete mode 100644 tools/perf/scripts/python/sctop.py
>  delete mode 100755 tools/perf/scripts/python/stackcollapse.py
>  delete mode 100644 tools/perf/scripts/python/stat-cpi.py
>  delete mode 100644 tools/perf/scripts/python/syscall-counts-by-pid.py
>  delete mode 100644 tools/perf/scripts/python/syscall-counts.py
>  delete mode 100755 tools/perf/scripts/python/task-analyzer.py
>  delete mode 100755 tools/perf/tests/shell/script_python.sh
>  delete mode 100644 tools/perf/util/scripting-engines/trace-event-python.c
> 
> diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
> index 09e1d35677f5..3d169e5bb372 100644
> --- a/tools/perf/Documentation/perf-check.txt
> +++ b/tools/perf/Documentation/perf-check.txt
> @@ -60,7 +60,6 @@ feature::
>                  libopencsd              /  HAVE_CSTRACE_SUPPORT
>                  libperl                 /  HAVE_LIBPERL_SUPPORT
>                  libpfm4                 /  HAVE_LIBPFM
> -                libpython               /  HAVE_LIBPYTHON_SUPPORT
>                  libslang                /  HAVE_SLANG_SUPPORT
>                  libtraceevent           /  HAVE_LIBTRACEEVENT
>                  libunwind               /  HAVE_LIBUNWIND_SUPPORT
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index b288ae0191ac..e6cfcbe0483b 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -800,27 +800,6 @@ ifdef GTK4
>    endif
>  endif
>  
> -ifdef LIBPERL
> -  PERL_EMBED_LDOPTS = $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null)
> -  PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
> -  PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
> -  PERL_EMBED_CCOPTS = $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/null)
> -  PERL_EMBED_CCOPTS := $(filter-out -specs=%,$(PERL_EMBED_CCOPTS))
> -  PERL_EMBED_CCOPTS := $(filter-out -flto% -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
> -  PERL_EMBED_LDOPTS := $(filter-out -specs=%,$(PERL_EMBED_LDOPTS))
> -  FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
> -
> -  $(call feature_check,libperl)
> -  ifneq ($(feature-libperl), 1)
> -    $(error Missing perl devel files. Please install perl-ExtUtils-Embed/libperl-dev)
> -  else
> -    LDFLAGS += $(PERL_EMBED_LDFLAGS)
> -    EXTLIBS += $(PERL_EMBED_LIBADD)
> -    CFLAGS += -DHAVE_LIBPERL_SUPPORT
> -    $(call detected,CONFIG_LIBPERL)
> -  endif
> -endif
> -
>  ifeq ($(feature-timerfd), 1)
>    CFLAGS += -DHAVE_TIMERFD_SUPPORT
>  else
> @@ -851,8 +830,7 @@ else
>        ifneq ($(feature-libpython), 1)
>          $(call disable-python,No 'Python.h' was found: disables Python support - please install python-devel/python-dev)
>        else
> -         LDFLAGS += $(PYTHON_EMBED_LDFLAGS)
> -         EXTLIBS += $(PYTHON_EMBED_LIBADD)
> +         CFLAGS += -DHAVE_LIBPYTHON_SUPPORT
>           PYTHON_SETUPTOOLS_INSTALLED := $(shell $(PYTHON) -c 'import setuptools;' 2> /dev/null && echo "yes" || echo "no")
>           ifeq ($(PYTHON_SETUPTOOLS_INSTALLED), yes)
>             PYTHON_EXTENSION_SUFFIX := $(shell $(PYTHON) -c 'from importlib import machinery; print(machinery.EXTENSION_SUFFIXES[0])')
> @@ -863,8 +841,6 @@ else
>  	 else
>             $(warning Missing python setuptools, the python binding won't be built, please install python3-setuptools or equivalent)
>           endif
> -         CFLAGS += -DHAVE_LIBPYTHON_SUPPORT
> -         $(call detected,CONFIG_LIBPYTHON)
>           ifeq ($(filter -fPIC,$(CFLAGS)),)
>             # Building a shared library requires position independent code.
>             CFLAGS += -fPIC
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 89edf2720fc1..eaff13a31c50 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -902,11 +902,8 @@ ifdef LIBPERL
>  endif
>  ifndef NO_LIBPYTHON
>  	$(call QUIET_INSTALL, python-scripts) \
> -		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python/Perf-Trace-Util/lib/Perf/Trace'; \
> -		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python/bin'; \
> -		$(INSTALL) scripts/python/Perf-Trace-Util/lib/Perf/Trace/* -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python/Perf-Trace-Util/lib/Perf/Trace'; \
> -		$(INSTALL) scripts/python/*.py -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python'; \
> -		$(INSTALL) scripts/python/bin/* -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python/bin'
> +		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python'; \
> +		$(INSTALL) python/*.py -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python'
>  	$(call QUIET_INSTALL, python-scripts-standalone) \
>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/python' && \
>  		$(INSTALL) python/*.py -m 755 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/python' && \
> diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
> index 60437650c50f..35272aaeb613 100644
> --- a/tools/perf/builtin-check.c
> +++ b/tools/perf/builtin-check.c
> @@ -52,8 +52,8 @@ struct feature_status supported_features[] = {
>  	FEATURE_STATUS("libnuma", HAVE_LIBNUMA_SUPPORT),
>  	FEATURE_STATUS("libopencsd", HAVE_CSTRACE_SUPPORT),
>  	FEATURE_STATUS_TIP("libperl", HAVE_LIBPERL_SUPPORT, "Deprecated, use LIBPERL=1 and install perl-ExtUtils-Embed/libperl-dev to build with it"),
> +	FEATURE_STATUS("python-module", HAVE_LIBPYTHON_SUPPORT),
>  	FEATURE_STATUS("libpfm4", HAVE_LIBPFM),
> -	FEATURE_STATUS("libpython", HAVE_LIBPYTHON_SUPPORT),
>  	FEATURE_STATUS("libslang", HAVE_SLANG_SUPPORT),
>  	FEATURE_STATUS("libtraceevent", HAVE_LIBTRACEEVENT),
>  	FEATURE_STATUS_TIP("libunwind", HAVE_LIBUNWIND_SUPPORT, "Deprecated, use LIBUNWIND=1 and install libunwind-dev[el] to build with it"),
> diff --git a/tools/perf/scripts/Build b/tools/perf/scripts/Build
> index 91229a1fe3ff..fbeab8fff88b 100644
> --- a/tools/perf/scripts/Build
> +++ b/tools/perf/scripts/Build
> @@ -1,30 +1,3 @@
>  ifeq ($(CONFIG_LIBTRACEEVENT),y)
>    perf-util-$(CONFIG_LIBPERL)   += perl/Perf-Trace-Util/
>  endif
> -perf-util-$(CONFIG_LIBPYTHON) += python/Perf-Trace-Util/
> -
> -ifdef MYPY
> -  PY_TESTS := $(shell find python -type f -name '*.py')
> -  MYPY_TEST_LOGS := $(PY_TESTS:python/%=python/%.mypy_log)
> -else
> -  MYPY_TEST_LOGS :=
> -endif
> -
> -$(OUTPUT)%.mypy_log: %
> -	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,test)mypy "$<" > $@ || (cat $@ && rm $@ && false)
> -
> -perf-y += $(MYPY_TEST_LOGS)
> -
> -ifdef PYLINT
> -  PY_TESTS := $(shell find python -type f -name '*.py')
> -  PYLINT_TEST_LOGS := $(PY_TESTS:python/%=python/%.pylint_log)
> -else
> -  PYLINT_TEST_LOGS :=
> -endif
> -
> -$(OUTPUT)%.pylint_log: %
> -	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,test)pylint "$<" > $@ || (cat $@ && rm $@ && false)
> -
> -perf-y += $(PYLINT_TEST_LOGS)
> diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Build b/tools/perf/scripts/python/Perf-Trace-Util/Build
> deleted file mode 100644
> index be3710c61320..000000000000
> --- a/tools/perf/scripts/python/Perf-Trace-Util/Build
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -perf-util-y += Context.o
> -
> -# -Wno-declaration-after-statement: The python headers have mixed code with declarations (decls after asserts, for instance)
> -CFLAGS_Context.o += $(PYTHON_EMBED_CCOPTS) -Wno-redundant-decls -Wno-strict-prototypes -Wno-unused-parameter -Wno-nested-externs -Wno-declaration-after-statement
> diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
> deleted file mode 100644
> index c19f44610983..000000000000
> --- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
> +++ /dev/null
> @@ -1,225 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Context.c.  Python interfaces for perf script.
> - *
> - * Copyright (C) 2010 Tom Zanussi <tzanussi@gmail.com>
> - */
> -
> -/*
> - * Use Py_ssize_t for '#' formats to avoid DeprecationWarning: PY_SSIZE_T_CLEAN
> - * will be required for '#' formats.
> - */
> -#define PY_SSIZE_T_CLEAN
> -
> -#include <Python.h>
> -#include "../../../util/config.h"
> -#include "../../../util/trace-event.h"
> -#include "../../../util/event.h"
> -#include "../../../util/symbol.h"
> -#include "../../../util/thread.h"
> -#include "../../../util/map.h"
> -#include "../../../util/maps.h"
> -#include "../../../util/auxtrace.h"
> -#include "../../../util/session.h"
> -#include "../../../util/srcline.h"
> -#include "../../../util/srccode.h"
> -
> -#define _PyCapsule_GetPointer(arg1, arg2) \
> -  PyCapsule_GetPointer((arg1), (arg2))
> -#define _PyBytes_FromStringAndSize(arg1, arg2) \
> -  PyBytes_FromStringAndSize((arg1), (arg2))
> -#define _PyUnicode_AsUTF8(arg) \
> -  PyUnicode_AsUTF8(arg)
> -
> -PyMODINIT_FUNC PyInit_perf_trace_context(void);
> -
> -static struct scripting_context *get_args(PyObject *args, const char *name, PyObject **arg2)
> -{
> -	int cnt = 1 + !!arg2;
> -	PyObject *context;
> -
> -	if (!PyArg_UnpackTuple(args, name, 1, cnt, &context, arg2))
> -		return NULL;
> -
> -	return _PyCapsule_GetPointer(context, NULL);
> -}
> -
> -static struct scripting_context *get_scripting_context(PyObject *args)
> -{
> -	return get_args(args, "context", NULL);
> -}
> -
> -#ifdef HAVE_LIBTRACEEVENT
> -static PyObject *perf_trace_context_common_pc(PyObject *obj, PyObject *args)
> -{
> -	struct scripting_context *c = get_scripting_context(args);
> -
> -	if (!c)
> -		return NULL;
> -
> -	return Py_BuildValue("i", common_pc(c));
> -}
> -
> -static PyObject *perf_trace_context_common_flags(PyObject *obj,
> -						 PyObject *args)
> -{
> -	struct scripting_context *c = get_scripting_context(args);
> -
> -	if (!c)
> -		return NULL;
> -
> -	return Py_BuildValue("i", common_flags(c));
> -}
> -
> -static PyObject *perf_trace_context_common_lock_depth(PyObject *obj,
> -						      PyObject *args)
> -{
> -	struct scripting_context *c = get_scripting_context(args);
> -
> -	if (!c)
> -		return NULL;
> -
> -	return Py_BuildValue("i", common_lock_depth(c));
> -}
> -#endif
> -
> -static PyObject *perf_sample_insn(PyObject *obj, PyObject *args)
> -{
> -	struct scripting_context *c = get_scripting_context(args);
> -
> -	if (!c)
> -		return NULL;
> -
> -	if (c->sample->ip && !c->sample->insn_len && thread__maps(c->al->thread)) {
> -		struct machine *machine =  maps__machine(thread__maps(c->al->thread));
> -
> -		perf_sample__fetch_insn(c->sample, c->al->thread, machine);
> -	}
> -	if (!c->sample->insn_len)
> -		Py_RETURN_NONE; /* N.B. This is a return statement */
> -
> -	return _PyBytes_FromStringAndSize(c->sample->insn, c->sample->insn_len);
> -}
> -
> -static PyObject *perf_set_itrace_options(PyObject *obj, PyObject *args)
> -{
> -	struct scripting_context *c;
> -	const char *itrace_options;
> -	int retval = -1;
> -	PyObject *str;
> -
> -	c = get_args(args, "itrace_options", &str);
> -	if (!c)
> -		return NULL;
> -
> -	if (!c->session || !c->session->itrace_synth_opts)
> -		goto out;
> -
> -	if (c->session->itrace_synth_opts->set) {
> -		retval = 1;
> -		goto out;
> -	}
> -
> -	itrace_options = _PyUnicode_AsUTF8(str);
> -
> -	retval = itrace_do_parse_synth_opts(c->session->itrace_synth_opts, itrace_options, 0);
> -out:
> -	return Py_BuildValue("i", retval);
> -}
> -
> -static PyObject *perf_sample_src(PyObject *obj, PyObject *args, bool get_srccode)
> -{
> -	struct scripting_context *c = get_scripting_context(args);
> -	unsigned int line = 0;
> -	char *srcfile = NULL;
> -	char *srccode = NULL;
> -	PyObject *result;
> -	struct map *map;
> -	struct dso *dso;
> -	int len = 0;
> -	u64 addr;
> -
> -	if (!c)
> -		return NULL;
> -
> -	map = c->al->map;
> -	addr = c->al->addr;
> -	dso = map ? map__dso(map) : NULL;
> -
> -	if (dso)
> -		srcfile = get_srcline_split(dso, map__rip_2objdump(map, addr), &line);
> -
> -	if (get_srccode) {
> -		if (srcfile)
> -			srccode = find_sourceline(srcfile, line, &len);
> -		result = Py_BuildValue("(sIs#)", srcfile, line, srccode, (Py_ssize_t)len);
> -	} else {
> -		result = Py_BuildValue("(sI)", srcfile, line);
> -	}
> -
> -	free(srcfile);
> -
> -	return result;
> -}
> -
> -static PyObject *perf_sample_srcline(PyObject *obj, PyObject *args)
> -{
> -	return perf_sample_src(obj, args, false);
> -}
> -
> -static PyObject *perf_sample_srccode(PyObject *obj, PyObject *args)
> -{
> -	return perf_sample_src(obj, args, true);
> -}
> -
> -static PyObject *__perf_config_get(PyObject *obj, PyObject *args)
> -{
> -	const char *config_name;
> -
> -	if (!PyArg_ParseTuple(args, "s", &config_name))
> -		return NULL;
> -	return Py_BuildValue("s", perf_config_get(config_name));
> -}
> -
> -static PyMethodDef ContextMethods[] = {
> -#ifdef HAVE_LIBTRACEEVENT
> -	{ "common_pc", perf_trace_context_common_pc, METH_VARARGS,
> -	  "Get the common preempt count event field value."},
> -	{ "common_flags", perf_trace_context_common_flags, METH_VARARGS,
> -	  "Get the common flags event field value."},
> -	{ "common_lock_depth", perf_trace_context_common_lock_depth,
> -	  METH_VARARGS,	"Get the common lock depth event field value."},
> -#endif
> -	{ "perf_sample_insn", perf_sample_insn,
> -	  METH_VARARGS,	"Get the machine code instruction."},
> -	{ "perf_set_itrace_options", perf_set_itrace_options,
> -	  METH_VARARGS,	"Set --itrace options."},
> -	{ "perf_sample_srcline", perf_sample_srcline,
> -	  METH_VARARGS,	"Get source file name and line number."},
> -	{ "perf_sample_srccode", perf_sample_srccode,
> -	  METH_VARARGS,	"Get source file name, line number and line."},
> -	{ "perf_config_get", __perf_config_get, METH_VARARGS, "Get perf config entry"},
> -	{ NULL, NULL, 0, NULL}
> -};
> -
> -PyMODINIT_FUNC PyInit_perf_trace_context(void)
> -{
> -	static struct PyModuleDef moduledef = {
> -		PyModuleDef_HEAD_INIT,
> -		"perf_trace_context",	/* m_name */
> -		"",			/* m_doc */
> -		-1,			/* m_size */
> -		ContextMethods,		/* m_methods */
> -		NULL,			/* m_reload */
> -		NULL,			/* m_traverse */
> -		NULL,			/* m_clear */
> -		NULL,			/* m_free */
> -	};
> -	PyObject *mod;
> -
> -	mod = PyModule_Create(&moduledef);
> -	/* Add perf_script_context to the module so it can be imported */
> -	PyObject_SetAttrString(mod, "perf_script_context", Py_None);
> -
> -	return mod;
> -}
> diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py
> deleted file mode 100644
> index 54ace2f6bc36..000000000000
> --- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py
> +++ /dev/null
> @@ -1,116 +0,0 @@
> -# Core.py - Python extension for perf script, core functions
> -#
> -# Copyright (C) 2010 by Tom Zanussi <tzanussi@gmail.com>
> -#
> -# This software may be distributed under the terms of the GNU General
> -# Public License ("GPL") version 2 as published by the Free Software
> -# Foundation.
> -
> -from collections import defaultdict
> -
> -def autodict():
> -    return defaultdict(autodict)
> -
> -flag_fields = autodict()
> -symbolic_fields = autodict()
> -
> -def define_flag_field(event_name, field_name, delim):
> -    flag_fields[event_name][field_name]['delim'] = delim
> -
> -def define_flag_value(event_name, field_name, value, field_str):
> -    flag_fields[event_name][field_name]['values'][value] = field_str
> -
> -def define_symbolic_field(event_name, field_name):
> -    # nothing to do, really
> -    pass
> -
> -def define_symbolic_value(event_name, field_name, value, field_str):
> -    symbolic_fields[event_name][field_name]['values'][value] = field_str
> -
> -def flag_str(event_name, field_name, value):
> -    string = ""
> -
> -    if flag_fields[event_name][field_name]:
> -        print_delim = 0
> -        for idx in sorted(flag_fields[event_name][field_name]['values']):
> -            if not value and not idx:
> -                string += flag_fields[event_name][field_name]['values'][idx]
> -                break
> -            if idx and (value & idx) == idx:
> -                if print_delim and flag_fields[event_name][field_name]['delim']:
> -                    string += " " + flag_fields[event_name][field_name]['delim'] + " "
> -                string += flag_fields[event_name][field_name]['values'][idx]
> -                print_delim = 1
> -                value &= ~idx
> -
> -    return string
> -
> -def symbol_str(event_name, field_name, value):
> -    string = ""
> -
> -    if symbolic_fields[event_name][field_name]:
> -        for idx in sorted(symbolic_fields[event_name][field_name]['values']):
> -            if not value and not idx:
> -                string = symbolic_fields[event_name][field_name]['values'][idx]
> -                break
> -            if (value == idx):
> -                string = symbolic_fields[event_name][field_name]['values'][idx]
> -                break
> -
> -    return string
> -
> -trace_flags = { 0x00: "NONE", \
> -                    0x01: "IRQS_OFF", \
> -                    0x02: "IRQS_NOSUPPORT", \
> -                    0x04: "NEED_RESCHED", \
> -                    0x08: "HARDIRQ", \
> -                    0x10: "SOFTIRQ" }
> -
> -def trace_flag_str(value):
> -    string = ""
> -    print_delim = 0
> -
> -    for idx in trace_flags:
> -        if not value and not idx:
> -            string += "NONE"
> -            break
> -
> -        if idx and (value & idx) == idx:
> -            if print_delim:
> -                string += " | ";
> -            string += trace_flags[idx]
> -            print_delim = 1
> -            value &= ~idx
> -
> -    return string
> -
> -
> -def taskState(state):
> -	states = {
> -		0 : "R",
> -		1 : "S",
> -		2 : "D",
> -		64: "DEAD"
> -	}
> -
> -	if state not in states:
> -		return "Unknown"
> -
> -	return states[state]
> -
> -
> -class EventHeaders:
> -	def __init__(self, common_cpu, common_secs, common_nsecs,
> -		     common_pid, common_comm, common_callchain):
> -		self.cpu = common_cpu
> -		self.secs = common_secs
> -		self.nsecs = common_nsecs
> -		self.pid = common_pid
> -		self.comm = common_comm
> -		self.callchain = common_callchain
> -
> -	def ts(self):
> -		return (self.secs * (10 ** 9)) + self.nsecs
> -
> -	def ts_format(self):
> -		return "%d.%d" % (self.secs, int(self.nsecs / 1000))
> diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py
> deleted file mode 100755
> index 21a7a1298094..000000000000
> --- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py
> +++ /dev/null
> @@ -1,97 +0,0 @@
> -# EventClass.py
> -# SPDX-License-Identifier: GPL-2.0
> -#
> -# This is a library defining some events types classes, which could
> -# be used by other scripts to analyzing the perf samples.
> -#
> -# Currently there are just a few classes defined for examples,
> -# PerfEvent is the base class for all perf event sample, PebsEvent
> -# is a HW base Intel x86 PEBS event, and user could add more SW/HW
> -# event classes based on requirements.
> -from __future__ import print_function
> -
> -import struct
> -
> -# Event types, user could add more here
> -EVTYPE_GENERIC  = 0
> -EVTYPE_PEBS     = 1     # Basic PEBS event
> -EVTYPE_PEBS_LL  = 2     # PEBS event with load latency info
> -EVTYPE_IBS      = 3
> -
> -#
> -# Currently we don't have good way to tell the event type, but by
> -# the size of raw buffer, raw PEBS event with load latency data's
> -# size is 176 bytes, while the pure PEBS event's size is 144 bytes.
> -#
> -def create_event(name, comm, dso, symbol, raw_buf):
> -        if (len(raw_buf) == 144):
> -                event = PebsEvent(name, comm, dso, symbol, raw_buf)
> -        elif (len(raw_buf) == 176):
> -                event = PebsNHM(name, comm, dso, symbol, raw_buf)
> -        else:
> -                event = PerfEvent(name, comm, dso, symbol, raw_buf)
> -
> -        return event
> -
> -class PerfEvent(object):
> -        event_num = 0
> -        def __init__(self, name, comm, dso, symbol, raw_buf, ev_type=EVTYPE_GENERIC):
> -                self.name       = name
> -                self.comm       = comm
> -                self.dso        = dso
> -                self.symbol     = symbol
> -                self.raw_buf    = raw_buf
> -                self.ev_type    = ev_type
> -                PerfEvent.event_num += 1
> -
> -        def show(self):
> -                print("PMU event: name=%12s, symbol=%24s, comm=%8s, dso=%12s" %
> -                      (self.name, self.symbol, self.comm, self.dso))
> -
> -#
> -# Basic Intel PEBS (Precise Event-based Sampling) event, whose raw buffer
> -# contains the context info when that event happened: the EFLAGS and
> -# linear IP info, as well as all the registers.
> -#
> -class PebsEvent(PerfEvent):
> -        pebs_num = 0
> -        def __init__(self, name, comm, dso, symbol, raw_buf, ev_type=EVTYPE_PEBS):
> -                tmp_buf=raw_buf[0:80]
> -                flags, ip, ax, bx, cx, dx, si, di, bp, sp = struct.unpack('QQQQQQQQQQ', tmp_buf)
> -                self.flags = flags
> -                self.ip    = ip
> -                self.ax    = ax
> -                self.bx    = bx
> -                self.cx    = cx
> -                self.dx    = dx
> -                self.si    = si
> -                self.di    = di
> -                self.bp    = bp
> -                self.sp    = sp
> -
> -                PerfEvent.__init__(self, name, comm, dso, symbol, raw_buf, ev_type)
> -                PebsEvent.pebs_num += 1
> -                del tmp_buf
> -
> -#
> -# Intel Nehalem and Westmere support PEBS plus Load Latency info which lie
> -# in the four 64 bit words write after the PEBS data:
> -#       Status: records the IA32_PERF_GLOBAL_STATUS register value
> -#       DLA:    Data Linear Address (EIP)
> -#       DSE:    Data Source Encoding, where the latency happens, hit or miss
> -#               in L1/L2/L3 or IO operations
> -#       LAT:    the actual latency in cycles
> -#
> -class PebsNHM(PebsEvent):
> -        pebs_nhm_num = 0
> -        def __init__(self, name, comm, dso, symbol, raw_buf, ev_type=EVTYPE_PEBS_LL):
> -                tmp_buf=raw_buf[144:176]
> -                status, dla, dse, lat = struct.unpack('QQQQ', tmp_buf)
> -                self.status = status
> -                self.dla = dla
> -                self.dse = dse
> -                self.lat = lat
> -
> -                PebsEvent.__init__(self, name, comm, dso, symbol, raw_buf, ev_type)
> -                PebsNHM.pebs_nhm_num += 1
> -                del tmp_buf
> diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py
> deleted file mode 100644
> index cac7b2542ee8..000000000000
> --- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py
> +++ /dev/null
> @@ -1,184 +0,0 @@
> -# SchedGui.py - Python extension for perf script, basic GUI code for
> -#		traces drawing and overview.
> -#
> -# Copyright (C) 2010 by Frederic Weisbecker <fweisbec@gmail.com>
> -#
> -# This software is distributed under the terms of the GNU General
> -# Public License ("GPL") version 2 as published by the Free Software
> -# Foundation.
> -
> -
> -try:
> -	import wx
> -except ImportError:
> -	raise ImportError("You need to install the wxpython lib for this script")
> -
> -
> -class RootFrame(wx.Frame):
> -	Y_OFFSET = 100
> -	RECT_HEIGHT = 100
> -	RECT_SPACE = 50
> -	EVENT_MARKING_WIDTH = 5
> -
> -	def __init__(self, sched_tracer, title, parent = None, id = -1):
> -		wx.Frame.__init__(self, parent, id, title)
> -
> -		(self.screen_width, self.screen_height) = wx.GetDisplaySize()
> -		self.screen_width -= 10
> -		self.screen_height -= 10
> -		self.zoom = 0.5
> -		self.scroll_scale = 20
> -		self.sched_tracer = sched_tracer
> -		self.sched_tracer.set_root_win(self)
> -		(self.ts_start, self.ts_end) = sched_tracer.interval()
> -		self.update_width_virtual()
> -		self.nr_rects = sched_tracer.nr_rectangles() + 1
> -		self.height_virtual = RootFrame.Y_OFFSET + (self.nr_rects * (RootFrame.RECT_HEIGHT + RootFrame.RECT_SPACE))
> -
> -		# whole window panel
> -		self.panel = wx.Panel(self, size=(self.screen_width, self.screen_height))
> -
> -		# scrollable container
> -		self.scroll = wx.ScrolledWindow(self.panel)
> -		self.scroll.SetScrollbars(self.scroll_scale, self.scroll_scale, self.width_virtual / self.scroll_scale, self.height_virtual / self.scroll_scale)
> -		self.scroll.EnableScrolling(True, True)
> -		self.scroll.SetFocus()
> -
> -		# scrollable drawing area
> -		self.scroll_panel = wx.Panel(self.scroll, size=(self.screen_width - 15, self.screen_height / 2))
> -		self.scroll_panel.Bind(wx.EVT_PAINT, self.on_paint)
> -		self.scroll_panel.Bind(wx.EVT_KEY_DOWN, self.on_key_press)
> -		self.scroll_panel.Bind(wx.EVT_LEFT_DOWN, self.on_mouse_down)
> -		self.scroll.Bind(wx.EVT_PAINT, self.on_paint)
> -		self.scroll.Bind(wx.EVT_KEY_DOWN, self.on_key_press)
> -		self.scroll.Bind(wx.EVT_LEFT_DOWN, self.on_mouse_down)
> -
> -		self.scroll.Fit()
> -		self.Fit()
> -
> -		self.scroll_panel.SetDimensions(-1, -1, self.width_virtual, self.height_virtual, wx.SIZE_USE_EXISTING)
> -
> -		self.txt = None
> -
> -		self.Show(True)
> -
> -	def us_to_px(self, val):
> -		return val / (10 ** 3) * self.zoom
> -
> -	def px_to_us(self, val):
> -		return (val / self.zoom) * (10 ** 3)
> -
> -	def scroll_start(self):
> -		(x, y) = self.scroll.GetViewStart()
> -		return (x * self.scroll_scale, y * self.scroll_scale)
> -
> -	def scroll_start_us(self):
> -		(x, y) = self.scroll_start()
> -		return self.px_to_us(x)
> -
> -	def paint_rectangle_zone(self, nr, color, top_color, start, end):
> -		offset_px = self.us_to_px(start - self.ts_start)
> -		width_px = self.us_to_px(end - self.ts_start)
> -
> -		offset_py = RootFrame.Y_OFFSET + (nr * (RootFrame.RECT_HEIGHT + RootFrame.RECT_SPACE))
> -		width_py = RootFrame.RECT_HEIGHT
> -
> -		dc = self.dc
> -
> -		if top_color is not None:
> -			(r, g, b) = top_color
> -			top_color = wx.Colour(r, g, b)
> -			brush = wx.Brush(top_color, wx.SOLID)
> -			dc.SetBrush(brush)
> -			dc.DrawRectangle(offset_px, offset_py, width_px, RootFrame.EVENT_MARKING_WIDTH)
> -			width_py -= RootFrame.EVENT_MARKING_WIDTH
> -			offset_py += RootFrame.EVENT_MARKING_WIDTH
> -
> -		(r ,g, b) = color
> -		color = wx.Colour(r, g, b)
> -		brush = wx.Brush(color, wx.SOLID)
> -		dc.SetBrush(brush)
> -		dc.DrawRectangle(offset_px, offset_py, width_px, width_py)
> -
> -	def update_rectangles(self, dc, start, end):
> -		start += self.ts_start
> -		end += self.ts_start
> -		self.sched_tracer.fill_zone(start, end)
> -
> -	def on_paint(self, event):
> -		dc = wx.PaintDC(self.scroll_panel)
> -		self.dc = dc
> -
> -		width = min(self.width_virtual, self.screen_width)
> -		(x, y) = self.scroll_start()
> -		start = self.px_to_us(x)
> -		end = self.px_to_us(x + width)
> -		self.update_rectangles(dc, start, end)
> -
> -	def rect_from_ypixel(self, y):
> -		y -= RootFrame.Y_OFFSET
> -		rect = y / (RootFrame.RECT_HEIGHT + RootFrame.RECT_SPACE)
> -		height = y % (RootFrame.RECT_HEIGHT + RootFrame.RECT_SPACE)
> -
> -		if rect < 0 or rect > self.nr_rects - 1 or height > RootFrame.RECT_HEIGHT:
> -			return -1
> -
> -		return rect
> -
> -	def update_summary(self, txt):
> -		if self.txt:
> -			self.txt.Destroy()
> -		self.txt = wx.StaticText(self.panel, -1, txt, (0, (self.screen_height / 2) + 50))
> -
> -
> -	def on_mouse_down(self, event):
> -		(x, y) = event.GetPositionTuple()
> -		rect = self.rect_from_ypixel(y)
> -		if rect == -1:
> -			return
> -
> -		t = self.px_to_us(x) + self.ts_start
> -
> -		self.sched_tracer.mouse_down(rect, t)
> -
> -
> -	def update_width_virtual(self):
> -		self.width_virtual = self.us_to_px(self.ts_end - self.ts_start)
> -
> -	def __zoom(self, x):
> -		self.update_width_virtual()
> -		(xpos, ypos) = self.scroll.GetViewStart()
> -		xpos = self.us_to_px(x) / self.scroll_scale
> -		self.scroll.SetScrollbars(self.scroll_scale, self.scroll_scale, self.width_virtual / self.scroll_scale, self.height_virtual / self.scroll_scale, xpos, ypos)
> -		self.Refresh()
> -
> -	def zoom_in(self):
> -		x = self.scroll_start_us()
> -		self.zoom *= 2
> -		self.__zoom(x)
> -
> -	def zoom_out(self):
> -		x = self.scroll_start_us()
> -		self.zoom /= 2
> -		self.__zoom(x)
> -
> -
> -	def on_key_press(self, event):
> -		key = event.GetRawKeyCode()
> -		if key == ord("+"):
> -			self.zoom_in()
> -			return
> -		if key == ord("-"):
> -			self.zoom_out()
> -			return
> -
> -		key = event.GetKeyCode()
> -		(x, y) = self.scroll.GetViewStart()
> -		if key == wx.WXK_RIGHT:
> -			self.scroll.Scroll(x + 1, y)
> -		elif key == wx.WXK_LEFT:
> -			self.scroll.Scroll(x - 1, y)
> -		elif key == wx.WXK_DOWN:
> -			self.scroll.Scroll(x, y + 1)
> -		elif key == wx.WXK_UP:
> -			self.scroll.Scroll(x, y - 1)
> diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
> deleted file mode 100644
> index b75d31858e54..000000000000
> --- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
> +++ /dev/null
> @@ -1,92 +0,0 @@
> -# Util.py - Python extension for perf script, miscellaneous utility code
> -#
> -# Copyright (C) 2010 by Tom Zanussi <tzanussi@gmail.com>
> -#
> -# This software may be distributed under the terms of the GNU General
> -# Public License ("GPL") version 2 as published by the Free Software
> -# Foundation.
> -from __future__ import print_function
> -
> -import errno, os
> -
> -FUTEX_WAIT = 0
> -FUTEX_WAKE = 1
> -FUTEX_PRIVATE_FLAG = 128
> -FUTEX_CLOCK_REALTIME = 256
> -FUTEX_CMD_MASK = ~(FUTEX_PRIVATE_FLAG | FUTEX_CLOCK_REALTIME)
> -
> -NSECS_PER_SEC    = 1000000000
> -
> -def avg(total, n):
> -    return total / n
> -
> -def nsecs(secs, nsecs):
> -    return secs * NSECS_PER_SEC + nsecs
> -
> -def nsecs_secs(nsecs):
> -    return nsecs / NSECS_PER_SEC
> -
> -def nsecs_nsecs(nsecs):
> -    return nsecs % NSECS_PER_SEC
> -
> -def nsecs_str(nsecs):
> -    str = "%5u.%09u" % (nsecs_secs(nsecs), nsecs_nsecs(nsecs)),
> -    return str
> -
> -def add_stats(dict, key, value):
> -	if key not in dict:
> -		dict[key] = (value, value, value, 1)
> -	else:
> -		min, max, avg, count = dict[key]
> -		if value < min:
> -			min = value
> -		if value > max:
> -			max = value
> -		avg = (avg + value) / 2
> -		dict[key] = (min, max, avg, count + 1)
> -
> -def clear_term():
> -    print("\x1b[H\x1b[2J")
> -
> -audit_package_warned = False
> -
> -try:
> -	import audit
> -	machine_to_id = {
> -		'x86_64': audit.MACH_86_64,
> -		'aarch64': audit.MACH_AARCH64,
> -		'alpha'	: audit.MACH_ALPHA,
> -		'ia64'	: audit.MACH_IA64,
> -		'ppc'	: audit.MACH_PPC,
> -		'ppc64'	: audit.MACH_PPC64,
> -		'ppc64le' : audit.MACH_PPC64LE,
> -		's390'	: audit.MACH_S390,
> -		's390x'	: audit.MACH_S390X,
> -		'i386'	: audit.MACH_X86,
> -		'i586'	: audit.MACH_X86,
> -		'i686'	: audit.MACH_X86,
> -	}
> -	try:
> -		machine_to_id['armeb'] = audit.MACH_ARMEB
> -	except:
> -		pass
> -	machine_id = machine_to_id[os.uname()[4]]
> -except:
> -	if not audit_package_warned:
> -		audit_package_warned = True
> -		print("Install the python-audit package to get syscall names.\n"
> -                    "For example:\n  # apt-get install python3-audit (Ubuntu)"
> -                    "\n  # yum install python3-audit (Fedora)"
> -                    "\n  etc.\n")
> -
> -def syscall_name(id):
> -	try:
> -		return audit.audit_syscall_to_name(id, machine_id)
> -	except:
> -		return str(id)
> -
> -def strerror(nr):
> -	try:
> -		return errno.errorcode[abs(nr)]
> -	except:
> -		return "Unknown %d errno" % nr
> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> deleted file mode 100755
> index 42579f858684..000000000000
> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> +++ /dev/null
> @@ -1,356 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -# arm-cs-trace-disasm.py: ARM CoreSight Trace Dump With Disassember
> -#
> -# Author: Tor Jeremiassen <tor@ti.com>
> -#         Mathieu Poirier <mathieu.poirier@linaro.org>
> -#         Leo Yan <leo.yan@linaro.org>
> -#         Al Grant <Al.Grant@arm.com>
> -
> -from __future__ import print_function
> -import os
> -from os import path
> -import re
> -from subprocess import *
> -import argparse
> -import platform
> -
> -from perf_trace_context import perf_sample_srccode, perf_config_get
> -
> -# Below are some example commands for using this script.
> -# Note a --kcore recording is required for accurate decode
> -# due to the alternatives patching mechanism. In addition to this,
> -# source line info comes from Perf, and when using kcore there is
> -# no debug info. The following lists the supported features in each mode:
> -#
> -# +-----------+-----------------+------------------+------------------+
> -# | Recording | Accurate decode | Source line dump | Disassembly dump |
> -# +-----------+-----------------+------------------+------------------+
> -# | --kcore   | yes             | no               | yes              |
> -# | normal    | no              | yes (inaccurate) | yes (inaccurate) |
> -# +-----------+-----------------+------------------+------------------+
> -#
> -# Output disassembly with objdump and auto detect vmlinux
> -# (when running on same machine.):
> -#  perf script --itrace=b -s scripts/python/arm-cs-trace-disasm.py \
> -#       -- -d
> -#
> -# Output disassembly with llvm-objdump:
> -#  perf script --itrace=b -s scripts/python/arm-cs-trace-disasm.py \
> -#		-- -d llvm-objdump-11 -k path/to/vmlinux
> -#
> -# Output accurate disassembly by passing kcore to script:
> -#  perf script --itrace=b -s scripts/python/arm-cs-trace-disasm.py \
> -#		-- -d -k perf.data/kcore_dir/kcore
> -#
> -# Output only source line and symbols:
> -#  perf script --itrace=b -s scripts/python/arm-cs-trace-disasm.py
> -
> -def default_objdump():
> -	config = perf_config_get("annotate.objdump")
> -	return config if config else "objdump"
> -
> -# Command line parsing.
> -def int_arg(v):
> -	v = int(v)
> -	if v < 0:
> -		raise argparse.ArgumentTypeError("Argument must be a positive integer")
> -	return v
> -
> -args = argparse.ArgumentParser()
> -args.add_argument("-k", "--vmlinux",
> -		  help="Set path to vmlinux or kcore file. Omit to autodetect if running on same machine")
> -args.add_argument("-d", "--objdump", nargs="?", const=default_objdump(),
> -		  help="Show disassembly. Can also be used to change the objdump path"),
> -args.add_argument("-v", "--verbose", action="store_true", help="Enable debugging log")
> -args.add_argument("--start-time", type=int_arg, help="Monotonic clock time of sample to start from. "
> -		  "See 'time' field on samples in -v mode.")
> -args.add_argument("--stop-time", type=int_arg, help="Monotonic clock time of sample to stop at. "
> -		  "See 'time' field on samples in -v mode.")
> -args.add_argument("--start-sample", type=int_arg, help="Index of sample to start from. "
> -		  "See 'index' field on samples in -v mode.")
> -args.add_argument("--stop-sample", type=int_arg, help="Index of sample to stop at. "
> -		  "See 'index' field on samples in -v mode.")
> -
> -options = args.parse_args()
> -if (options.start_time and options.stop_time and
> -    options.start_time >= options.stop_time):
> -	print("--start-time must less than --stop-time")
> -	exit(2)
> -if (options.start_sample and options.stop_sample and
> -    options.start_sample >= options.stop_sample):
> -	print("--start-sample must less than --stop-sample")
> -	exit(2)
> -
> -# Initialize global dicts and regular expression
> -disasm_cache = dict()
> -cpu_data = dict()
> -disasm_re = re.compile(r"^\s*([0-9a-fA-F]+):")
> -disasm_func_re = re.compile(r"^\s*([0-9a-fA-F]+)\s.*:")
> -cache_size = 64*1024
> -sample_idx = -1
> -
> -glb_source_file_name	= None
> -glb_line_number		= None
> -glb_dso			= None
> -
> -kver = platform.release()
> -vmlinux_paths = [
> -	f"/usr/lib/debug/boot/vmlinux-{kver}.debug",
> -	f"/usr/lib/debug/lib/modules/{kver}/vmlinux",
> -	f"/lib/modules/{kver}/build/vmlinux",
> -	f"/usr/lib/debug/boot/vmlinux-{kver}",
> -	f"/boot/vmlinux-{kver}",
> -	f"/boot/vmlinux",
> -	f"vmlinux"
> -]
> -
> -def get_optional(perf_dict, field):
> -       if field in perf_dict:
> -               return perf_dict[field]
> -       return "[unknown]"
> -
> -def get_offset(perf_dict, field):
> -	if field in perf_dict:
> -		return "+%#x" % perf_dict[field]
> -	return ""
> -
> -def find_vmlinux():
> -	if hasattr(find_vmlinux, "path"):
> -		return find_vmlinux.path
> -
> -	for v in vmlinux_paths:
> -		if os.access(v, os.R_OK):
> -			find_vmlinux.path = v
> -			break
> -	else:
> -		find_vmlinux.path = None
> -
> -	return find_vmlinux.path
> -
> -def get_dso_file_path(dso_name, dso_build_id):
> -	if (dso_name == "[kernel.kallsyms]" or dso_name == "vmlinux"):
> -		if (options.vmlinux):
> -			return options.vmlinux;
> -		else:
> -			return find_vmlinux() if find_vmlinux() else dso_name
> -
> -	if (dso_name == "[vdso]") :
> -		append = "/vdso"
> -	else:
> -		append = "/elf"
> -
> -	dso_path = os.environ['PERF_BUILDID_DIR'] + "/" + dso_name + "/" + dso_build_id + append;
> -	# Replace duplicate slash chars to single slash char
> -	dso_path = dso_path.replace('//', '/', 1)
> -	return dso_path
> -
> -def read_disam(dso_fname, dso_start, start_addr, stop_addr):
> -	addr_range = str(start_addr) + ":" + str(stop_addr) + ":" + dso_fname
> -
> -	# Don't let the cache get too big, clear it when it hits max size
> -	if (len(disasm_cache) > cache_size):
> -		disasm_cache.clear();
> -
> -	if addr_range in disasm_cache:
> -		disasm_output = disasm_cache[addr_range];
> -	else:
> -		start_addr = start_addr - dso_start;
> -		stop_addr = stop_addr - dso_start;
> -		disasm = [ options.objdump, "-d", "-z",
> -			   "--start-address="+format(start_addr,"#x"),
> -			   "--stop-address="+format(stop_addr,"#x") ]
> -		disasm += [ dso_fname ]
> -		disasm_output = check_output(disasm).decode('utf-8').split('\n')
> -		disasm_cache[addr_range] = disasm_output
> -
> -	return disasm_output
> -
> -def print_disam(dso_fname, dso_start, start_addr, stop_addr):
> -	for line in read_disam(dso_fname, dso_start, start_addr, stop_addr):
> -		m = disasm_func_re.search(line)
> -		if m is None:
> -			m = disasm_re.search(line)
> -			if m is None:
> -				continue
> -		print("\t" + line)
> -
> -def print_sample(sample):
> -	print("Sample = { cpu: %04d addr: 0x%016x phys_addr: 0x%016x ip: 0x%016x " \
> -	      "pid: %d tid: %d period: %d time: %d index: %d}" % \
> -	      (sample['cpu'], sample['addr'], sample['phys_addr'], \
> -	       sample['ip'], sample['pid'], sample['tid'], \
> -	       sample['period'], sample['time'], sample_idx))
> -
> -def trace_begin():
> -	print('ARM CoreSight Trace Data Assembler Dump')
> -
> -def trace_end():
> -	print('End')
> -
> -def trace_unhandled(event_name, context, event_fields_dict):
> -	print(' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())]))
> -
> -def common_start_str(comm, sample):
> -	sec = int(sample["time"] / 1000000000)
> -	ns = sample["time"] % 1000000000
> -	cpu = sample["cpu"]
> -	pid = sample["pid"]
> -	tid = sample["tid"]
> -	return "%16s %5u/%-5u [%04u] %9u.%09u  " % (comm, pid, tid, cpu, sec, ns)
> -
> -# This code is copied from intel-pt-events.py for printing source code
> -# line and symbols.
> -def print_srccode(comm, param_dict, sample, symbol, dso):
> -	ip = sample["ip"]
> -	if symbol == "[unknown]":
> -		start_str = common_start_str(comm, sample) + ("%x" % ip).rjust(16).ljust(40)
> -	else:
> -		offs = get_offset(param_dict, "symoff")
> -		start_str = common_start_str(comm, sample) + (symbol + offs).ljust(40)
> -
> -	global glb_source_file_name
> -	global glb_line_number
> -	global glb_dso
> -
> -	source_file_name, line_number, source_line = perf_sample_srccode(perf_script_context)
> -	if source_file_name:
> -		if glb_line_number == line_number and glb_source_file_name == source_file_name:
> -			src_str = ""
> -		else:
> -			if len(source_file_name) > 40:
> -				src_file = ("..." + source_file_name[-37:]) + " "
> -			else:
> -				src_file = source_file_name.ljust(41)
> -
> -			if source_line is None:
> -				src_str = src_file + str(line_number).rjust(4) + " <source not found>"
> -			else:
> -				src_str = src_file + str(line_number).rjust(4) + " " + source_line
> -		glb_dso = None
> -	elif dso == glb_dso:
> -		src_str = ""
> -	else:
> -		src_str = dso
> -		glb_dso = dso
> -
> -	glb_line_number = line_number
> -	glb_source_file_name = source_file_name
> -
> -	print(start_str, src_str)
> -
> -def process_event(param_dict):
> -	global cache_size
> -	global options
> -	global sample_idx
> -
> -	sample = param_dict["sample"]
> -	comm = param_dict["comm"]
> -
> -	name = param_dict["ev_name"]
> -	dso = get_optional(param_dict, "dso")
> -	dso_bid = get_optional(param_dict, "dso_bid")
> -	dso_start = get_optional(param_dict, "dso_map_start")
> -	dso_end = get_optional(param_dict, "dso_map_end")
> -	symbol = get_optional(param_dict, "symbol")
> -	map_pgoff = get_optional(param_dict, "map_pgoff")
> -	# check for valid map offset
> -	if (str(map_pgoff) == '[unknown]'):
> -		map_pgoff = 0
> -
> -	cpu = sample["cpu"]
> -	ip = sample["ip"]
> -	addr = sample["addr"]
> -
> -	sample_idx += 1
> -
> -	if (options.start_time and sample["time"] < options.start_time):
> -		return
> -	if (options.stop_time and sample["time"] > options.stop_time):
> -		exit(0)
> -	if (options.start_sample and sample_idx < options.start_sample):
> -		return
> -	if (options.stop_sample and sample_idx > options.stop_sample):
> -		exit(0)
> -
> -	if (options.verbose == True):
> -		print("Event type: %s" % name)
> -		print_sample(sample)
> -
> -	# Initialize CPU data if it's empty, and directly return back
> -	# if this is the first tracing event for this CPU.
> -	if (cpu_data.get(str(cpu) + 'addr') == None):
> -		cpu_data[str(cpu) + 'addr'] = addr
> -		return
> -
> -	# If cannot find dso so cannot dump assembler, bail out
> -	if (dso == '[unknown]'):
> -		return
> -
> -	# Validate dso start and end addresses
> -	if ((dso_start == '[unknown]') or (dso_end == '[unknown]')):
> -		print("Failed to find valid dso map for dso %s" % dso)
> -		return
> -
> -	if (name[0:12] == "instructions"):
> -		print_srccode(comm, param_dict, sample, symbol, dso)
> -		return
> -
> -	# Don't proceed if this event is not a branch sample, .
> -	if (name[0:8] != "branches"):
> -		return
> -
> -	# The format for packet is:
> -	#
> -	#		  +------------+------------+------------+
> -	#  sample_prev:   |    addr    |    ip	    |	 cpu	 |
> -	#		  +------------+------------+------------+
> -	#  sample_next:   |    addr    |    ip	    |	 cpu	 |
> -	#		  +------------+------------+------------+
> -	#
> -	# We need to combine the two continuous packets to get the instruction
> -	# range for sample_prev::cpu:
> -	#
> -	#     [ sample_prev::addr .. sample_next::ip ]
> -	#
> -	# For this purose, sample_prev::addr is stored into cpu_data structure
> -	# and read back for 'start_addr' when the new packet comes, and we need
> -	# to use sample_next::ip to calculate 'stop_addr', plusing extra 4 for
> -	# 'stop_addr' is for the sake of objdump so the final assembler dump can
> -	# include last instruction for sample_next::ip.
> -	start_addr = cpu_data[str(cpu) + 'addr']
> -	stop_addr  = ip + 4
> -
> -	# Record for previous sample packet
> -	cpu_data[str(cpu) + 'addr'] = addr
> -
> -	# Filter out zero start_address. Optionally identify CS_ETM_TRACE_ON packet
> -	if (start_addr == 0):
> -		if ((stop_addr == 4) and (options.verbose == True)):
> -			print("CPU%d: CS_ETM_TRACE_ON packet is inserted" % cpu)
> -		return
> -
> -	if (start_addr < int(dso_start) or start_addr > int(dso_end)):
> -		print("Start address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (start_addr, int(dso_start), int(dso_end), dso))
> -		return
> -
> -	if (stop_addr < int(dso_start) or stop_addr > int(dso_end)):
> -		print("Stop address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
> -		return
> -
> -	if (options.objdump != None):
> -		# It doesn't need to decrease virtual memory offset for disassembly
> -		# for kernel dso and executable file dso, so in this case we set
> -		# vm_start to zero.
> -		if (dso == "[kernel.kallsyms]" or dso_start == 0x400000):
> -			dso_vm_start = 0
> -			map_pgoff = 0
> -		else:
> -			dso_vm_start = int(dso_start)
> -
> -		dso_fname = get_dso_file_path(dso, dso_bid)
> -		if path.exists(dso_fname):
> -			print_disam(dso_fname, dso_vm_start, start_addr + map_pgoff, stop_addr + map_pgoff)
> -		else:
> -			print("Failed to find dso %s for address range [ 0x%x .. 0x%x ]" % (dso, start_addr + map_pgoff, stop_addr + map_pgoff))
> -
> -	print_srccode(comm, param_dict, sample, symbol, dso)
> diff --git a/tools/perf/scripts/python/bin/compaction-times-record b/tools/perf/scripts/python/bin/compaction-times-record
> deleted file mode 100644
> index 6edcd40e14e8..000000000000
> --- a/tools/perf/scripts/python/bin/compaction-times-record
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -#!/bin/bash
> -perf record -e compaction:mm_compaction_begin -e compaction:mm_compaction_end -e compaction:mm_compaction_migratepages -e compaction:mm_compaction_isolate_migratepages -e compaction:mm_compaction_isolate_freepages $@
> diff --git a/tools/perf/scripts/python/bin/compaction-times-report b/tools/perf/scripts/python/bin/compaction-times-report
> deleted file mode 100644
> index 3dc13897cfde..000000000000
> --- a/tools/perf/scripts/python/bin/compaction-times-report
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -#!/bin/bash
> -#description: display time taken by mm compaction
> -#args: [-h] [-u] [-p|-pv] [-t | [-m] [-fs] [-ms]] [pid|pid-range|comm-regex]
> -perf script -s "$PERF_EXEC_PATH"/scripts/python/compaction-times.py $@
> diff --git a/tools/perf/scripts/python/bin/event_analyzing_sample-record b/tools/perf/scripts/python/bin/event_analyzing_sample-record
> deleted file mode 100644
> index 5ce652dabd02..000000000000
> --- a/tools/perf/scripts/python/bin/event_analyzing_sample-record
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -#!/bin/bash
> -
> -#
> -# event_analyzing_sample.py can cover all type of perf samples including
> -# the tracepoints, so no special record requirements, just record what
> -# you want to analyze.
> -#
> -perf record $@
> diff --git a/tools/perf/scripts/python/bin/event_analyzing_sample-report b/tools/perf/scripts/python/bin/event_analyzing_sample-report
> deleted file mode 100644
> index 0941fc94e158..000000000000
> --- a/tools/perf/scripts/python/bin/event_analyzing_sample-report
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -#!/bin/bash
> -# description: analyze all perf samples
> -perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/event_analyzing_sample.py
> diff --git a/tools/perf/scripts/python/bin/export-to-postgresql-record b/tools/perf/scripts/python/bin/export-to-postgresql-record
> deleted file mode 100644
> index 221d66e05713..000000000000
> --- a/tools/perf/scripts/python/bin/export-to-postgresql-record
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -#!/bin/bash
> -
> -#
> -# export perf data to a postgresql database. Can cover
> -# perf ip samples (excluding the tracepoints). No special
> -# record requirements, just record what you want to export.
> -#
> -perf record $@
> diff --git a/tools/perf/scripts/python/bin/export-to-postgresql-report b/tools/perf/scripts/python/bin/export-to-postgresql-report
> deleted file mode 100644
> index cd335b6e2a01..000000000000
> --- a/tools/perf/scripts/python/bin/export-to-postgresql-report
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -#!/bin/bash
> -# description: export perf data to a postgresql database
> -# args: [database name] [columns] [calls]
> -n_args=0
> -for i in "$@"
> -do
> -    if expr match "$i" "-" > /dev/null ; then
> -	break
> -    fi
> -    n_args=$(( $n_args + 1 ))
> -done
> -if [ "$n_args" -gt 3 ] ; then
> -    echo "usage: export-to-postgresql-report [database name] [columns] [calls]"
> -    exit
> -fi
> -if [ "$n_args" -gt 2 ] ; then
> -    dbname=$1
> -    columns=$2
> -    calls=$3
> -    shift 3
> -elif [ "$n_args" -gt 1 ] ; then
> -    dbname=$1
> -    columns=$2
> -    shift 2
> -elif [ "$n_args" -gt 0 ] ; then
> -    dbname=$1
> -    shift
> -fi
> -perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/export-to-postgresql.py $dbname $columns $calls
> diff --git a/tools/perf/scripts/python/bin/export-to-sqlite-record b/tools/perf/scripts/python/bin/export-to-sqlite-record
> deleted file mode 100644
> index 070204fd6d00..000000000000
> --- a/tools/perf/scripts/python/bin/export-to-sqlite-record
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -#!/bin/bash
> -
> -#
> -# export perf data to a sqlite3 database. Can cover
> -# perf ip samples (excluding the tracepoints). No special
> -# record requirements, just record what you want to export.
> -#
> -perf record $@
> diff --git a/tools/perf/scripts/python/bin/export-to-sqlite-report b/tools/perf/scripts/python/bin/export-to-sqlite-report
> deleted file mode 100644
> index 5ff6033e70ba..000000000000
> --- a/tools/perf/scripts/python/bin/export-to-sqlite-report
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -#!/bin/bash
> -# description: export perf data to a sqlite3 database
> -# args: [database name] [columns] [calls]
> -n_args=0
> -for i in "$@"
> -do
> -    if expr match "$i" "-" > /dev/null ; then
> -	break
> -    fi
> -    n_args=$(( $n_args + 1 ))
> -done
> -if [ "$n_args" -gt 3 ] ; then
> -    echo "usage: export-to-sqlite-report [database name] [columns] [calls]"
> -    exit
> -fi
> -if [ "$n_args" -gt 2 ] ; then
> -    dbname=$1
> -    columns=$2
> -    calls=$3
> -    shift 3
> -elif [ "$n_args" -gt 1 ] ; then
> -    dbname=$1
> -    columns=$2
> -    shift 2
> -elif [ "$n_args" -gt 0 ] ; then
> -    dbname=$1
> -    shift
> -fi
> -perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/export-to-sqlite.py $dbname $columns $calls
> diff --git a/tools/perf/scripts/python/bin/failed-syscalls-by-pid-record b/tools/perf/scripts/python/bin/failed-syscalls-by-pid-record
> deleted file mode 100644
> index 74685f318379..000000000000
> --- a/tools/perf/scripts/python/bin/failed-syscalls-by-pid-record
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -#!/bin/bash
> -(perf record -e raw_syscalls:sys_exit $@ || \
> - perf record -e syscalls:sys_exit $@) 2> /dev/null
> diff --git a/tools/perf/scripts/python/bin/failed-syscalls-by-pid-report b/tools/perf/scripts/python/bin/failed-syscalls-by-pid-report
> deleted file mode 100644
> index fda5096d0cbf..000000000000
> --- a/tools/perf/scripts/python/bin/failed-syscalls-by-pid-report
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -#!/bin/bash
> -# description: system-wide failed syscalls, by pid
> -# args: [comm]
> -if [ $# -gt 0 ] ; then
> -    if ! expr match "$1" "-" > /dev/null ; then
> -	comm=$1
> -	shift
> -    fi
> -fi
> -perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/failed-syscalls-by-pid.py $comm
> diff --git a/tools/perf/scripts/python/bin/flamegraph-record b/tools/perf/scripts/python/bin/flamegraph-record
> deleted file mode 100755
> index 7df5a19c0163..000000000000
> --- a/tools/perf/scripts/python/bin/flamegraph-record
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -#!/bin/bash
> -perf record -g "$@"
> diff --git a/tools/perf/scripts/python/bin/flamegraph-report b/tools/perf/scripts/python/bin/flamegraph-report
> deleted file mode 100755
> index 453a6918afbe..000000000000
> --- a/tools/perf/scripts/python/bin/flamegraph-report
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -#!/bin/bash
> -# description: create flame graphs
> -perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py "$@"
> diff --git a/tools/perf/scripts/python/bin/futex-contention-record b/tools/perf/scripts/python/bin/futex-contention-record
> deleted file mode 100644
> index b1495c9a9b20..000000000000
> --- a/tools/perf/scripts/python/bin/futex-contention-record
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -#!/bin/bash
> -perf record -e syscalls:sys_enter_futex -e syscalls:sys_exit_futex $@
> diff --git a/tools/perf/scripts/python/bin/futex-contention-report b/tools/perf/scripts/python/bin/futex-contention-report
> deleted file mode 100644
> index 6c44271091ab..000000000000
> --- a/tools/perf/scripts/python/bin/futex-contention-report
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -#!/bin/bash
> -# description: futext contention measurement
> -
> -perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/futex-contention.py
> diff --git a/tools/perf/scripts/python/bin/gecko-record b/tools/perf/scripts/python/bin/gecko-record
> deleted file mode 100644
> index f0d1aa55f171..000000000000
> --- a/tools/perf/scripts/python/bin/gecko-record
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -#!/bin/bash
> -perf record -F 99 -g "$@"
> diff --git a/tools/perf/scripts/python/bin/gecko-report b/tools/perf/scripts/python/bin/gecko-report
> deleted file mode 100755
> index 1867ec8d9757..000000000000
> --- a/tools/perf/scripts/python/bin/gecko-report
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -#!/bin/bash
> -# description: create firefox gecko profile json format from perf.data
> -if [ "$*" = "-i -" ]; then
> -perf script -s "$PERF_EXEC_PATH"/scripts/python/gecko.py
> -else
> -perf script -s "$PERF_EXEC_PATH"/scripts/python/gecko.py -- "$@"
> -fi
> diff --git a/tools/perf/scripts/python/bin/intel-pt-events-record b/tools/perf/scripts/python/bin/intel-pt-events-record
> deleted file mode 100644
> index 6b9877cfe23e..000000000000
> --- a/tools/perf/scripts/python/bin/intel-pt-events-record
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -#!/bin/bash
> -
> -#
> -# print Intel PT Events including Power Events and PTWRITE. The intel_pt PMU
> -# event needs to be specified with appropriate config terms.
> -#
> -if ! echo "$@" | grep -q intel_pt ; then
> -	echo "Options must include the Intel PT event e.g. -e intel_pt/pwr_evt,ptw/"
> -	echo "and for power events it probably needs to be system wide i.e. -a option"
> -	echo "For example: -a -e intel_pt/pwr_evt,branch=0/ sleep 1"
> -	exit 1
> -fi
> -perf record $@
> diff --git a/tools/perf/scripts/python/bin/intel-pt-events-report b/tools/perf/scripts/python/bin/intel-pt-events-report
> deleted file mode 100644
> index beeac3fde9db..000000000000
> --- a/tools/perf/scripts/python/bin/intel-pt-events-report
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -#!/bin/bash
> -# description: print Intel PT Events including Power Events and PTWRITE
> -perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/intel-pt-events.py
> diff --git a/tools/perf/scripts/python/bin/mem-phys-addr-record b/tools/perf/scripts/python/bin/mem-phys-addr-record
> deleted file mode 100644
> index 5a875122a904..000000000000
> --- a/tools/perf/scripts/python/bin/mem-phys-addr-record
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -#!/bin/bash
> -
> -#
> -# Profiling physical memory by all retired load instructions/uops event
> -# MEM_INST_RETIRED.ALL_LOADS or MEM_UOPS_RETIRED.ALL_LOADS
> -#
> -
> -load=`perf list | grep mem_inst_retired.all_loads`
> -if [ -z "$load" ]; then
> -	load=`perf list | grep mem_uops_retired.all_loads`
> -fi
> -if [ -z "$load" ]; then
> -	echo "There is no event to count all retired load instructions/uops."
> -	exit 1
> -fi
> -
> -arg=$(echo $load | tr -d ' ')
> -arg="$arg:P"
> -perf record --phys-data -e $arg $@
> diff --git a/tools/perf/scripts/python/bin/mem-phys-addr-report b/tools/perf/scripts/python/bin/mem-phys-addr-report
> deleted file mode 100644
> index 3f2b847e2eab..000000000000
> --- a/tools/perf/scripts/python/bin/mem-phys-addr-report
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -#!/bin/bash
> -# description: resolve physical address samples
> -perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/mem-phys-addr.py
> diff --git a/tools/perf/scripts/python/bin/net_dropmonitor-record b/tools/perf/scripts/python/bin/net_dropmonitor-record
> deleted file mode 100755
> index 423fb81dadae..000000000000
> --- a/tools/perf/scripts/python/bin/net_dropmonitor-record
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -#!/bin/bash
> -perf record -e skb:kfree_skb $@
> diff --git a/tools/perf/scripts/python/bin/net_dropmonitor-report b/tools/perf/scripts/python/bin/net_dropmonitor-report
> deleted file mode 100755
> index 8d698f5a06aa..000000000000
> --- a/tools/perf/scripts/python/bin/net_dropmonitor-report
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -#!/bin/bash
> -# description: display a table of dropped frames
> -
> -perf script -s "$PERF_EXEC_PATH"/scripts/python/net_dropmonitor.py $@
> diff --git a/tools/perf/scripts/python/bin/netdev-times-record b/tools/perf/scripts/python/bin/netdev-times-record
> deleted file mode 100644
> index 558754b840a9..000000000000
> --- a/tools/perf/scripts/python/bin/netdev-times-record
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -#!/bin/bash
> -perf record -e net:net_dev_xmit -e net:net_dev_queue		\
> -		-e net:netif_receive_skb -e net:netif_rx		\
> -		-e skb:consume_skb -e skb:kfree_skb			\
> -		-e skb:skb_copy_datagram_iovec -e napi:napi_poll	\
> -		-e irq:irq_handler_entry -e irq:irq_handler_exit	\
> -		-e irq:softirq_entry -e irq:softirq_exit		\
> -		-e irq:softirq_raise $@
> diff --git a/tools/perf/scripts/python/bin/netdev-times-report b/tools/perf/scripts/python/bin/netdev-times-report
> deleted file mode 100644
> index 8f759291da86..000000000000
> --- a/tools/perf/scripts/python/bin/netdev-times-report
> +++ /dev/null
> @@ -1,5 +0,0 @@
> -#!/bin/bash
> -# description: display a process of packet and processing time
> -# args: [tx] [rx] [dev=] [debug]
> -
> -perf script -s "$PERF_EXEC_PATH"/scripts/python/netdev-times.py $@
> diff --git a/tools/perf/scripts/python/bin/powerpc-hcalls-record b/tools/perf/scripts/python/bin/powerpc-hcalls-record
> deleted file mode 100644
> index b7402aa9147d..000000000000
> --- a/tools/perf/scripts/python/bin/powerpc-hcalls-record
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -#!/bin/bash
> -perf record -e "{powerpc:hcall_entry,powerpc:hcall_exit}" $@
> diff --git a/tools/perf/scripts/python/bin/powerpc-hcalls-report b/tools/perf/scripts/python/bin/powerpc-hcalls-report
> deleted file mode 100644
> index dd32ad7465f6..000000000000
> --- a/tools/perf/scripts/python/bin/powerpc-hcalls-report
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -#!/bin/bash
> -perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/powerpc-hcalls.py
> diff --git a/tools/perf/scripts/python/bin/sched-migration-record b/tools/perf/scripts/python/bin/sched-migration-record
> deleted file mode 100644
> index 7493fddbe995..000000000000
> --- a/tools/perf/scripts/python/bin/sched-migration-record
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -#!/bin/bash
> -perf record -m 16384 -e sched:sched_wakeup -e sched:sched_wakeup_new -e sched:sched_switch -e sched:sched_migrate_task $@
> diff --git a/tools/perf/scripts/python/bin/sched-migration-report b/tools/perf/scripts/python/bin/sched-migration-report
> deleted file mode 100644
> index 68b037a1849b..000000000000
> --- a/tools/perf/scripts/python/bin/sched-migration-report
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -#!/bin/bash
> -# description: sched migration overview
> -perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/sched-migration.py
> diff --git a/tools/perf/scripts/python/bin/sctop-record b/tools/perf/scripts/python/bin/sctop-record
> deleted file mode 100644
> index d6940841e54f..000000000000
> --- a/tools/perf/scripts/python/bin/sctop-record
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -#!/bin/bash
> -(perf record -e raw_syscalls:sys_enter $@ || \
> - perf record -e syscalls:sys_enter $@) 2> /dev/null
> diff --git a/tools/perf/scripts/python/bin/sctop-report b/tools/perf/scripts/python/bin/sctop-report
> deleted file mode 100644
> index c32db294124d..000000000000
> --- a/tools/perf/scripts/python/bin/sctop-report
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -#!/bin/bash
> -# description: syscall top
> -# args: [comm] [interval]
> -n_args=0
> -for i in "$@"
> -do
> -    if expr match "$i" "-" > /dev/null ; then
> -	break
> -    fi
> -    n_args=$(( $n_args + 1 ))
> -done
> -if [ "$n_args" -gt 2 ] ; then
> -    echo "usage: sctop-report [comm] [interval]"
> -    exit
> -fi
> -if [ "$n_args" -gt 1 ] ; then
> -    comm=$1
> -    interval=$2
> -    shift 2
> -elif [ "$n_args" -gt 0 ] ; then
> -    interval=$1
> -    shift
> -fi
> -perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/sctop.py $comm $interval
> diff --git a/tools/perf/scripts/python/bin/stackcollapse-record b/tools/perf/scripts/python/bin/stackcollapse-record
> deleted file mode 100755
> index 9d8f9f0f3a17..000000000000
> --- a/tools/perf/scripts/python/bin/stackcollapse-record
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -#!/bin/sh
> -
> -#
> -# stackcollapse.py can cover all type of perf samples including
> -# the tracepoints, so no special record requirements, just record what
> -# you want to analyze.
> -#
> -perf record "$@"
> diff --git a/tools/perf/scripts/python/bin/stackcollapse-report b/tools/perf/scripts/python/bin/stackcollapse-report
> deleted file mode 100755
> index 21a356bd27f6..000000000000
> --- a/tools/perf/scripts/python/bin/stackcollapse-report
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -#!/bin/sh
> -# description: produce callgraphs in short form for scripting use
> -perf script -s "$PERF_EXEC_PATH"/scripts/python/stackcollapse.py "$@"
> diff --git a/tools/perf/scripts/python/bin/syscall-counts-by-pid-record b/tools/perf/scripts/python/bin/syscall-counts-by-pid-record
> deleted file mode 100644
> index d6940841e54f..000000000000
> --- a/tools/perf/scripts/python/bin/syscall-counts-by-pid-record
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -#!/bin/bash
> -(perf record -e raw_syscalls:sys_enter $@ || \
> - perf record -e syscalls:sys_enter $@) 2> /dev/null
> diff --git a/tools/perf/scripts/python/bin/syscall-counts-by-pid-report b/tools/perf/scripts/python/bin/syscall-counts-by-pid-report
> deleted file mode 100644
> index 16eb8d65c543..000000000000
> --- a/tools/perf/scripts/python/bin/syscall-counts-by-pid-report
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -#!/bin/bash
> -# description: system-wide syscall counts, by pid
> -# args: [comm]
> -if [ $# -gt 0 ] ; then
> -    if ! expr match "$1" "-" > /dev/null ; then
> -	comm=$1
> -	shift
> -    fi
> -fi
> -perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/syscall-counts-by-pid.py $comm
> diff --git a/tools/perf/scripts/python/bin/syscall-counts-record b/tools/perf/scripts/python/bin/syscall-counts-record
> deleted file mode 100644
> index d6940841e54f..000000000000
> --- a/tools/perf/scripts/python/bin/syscall-counts-record
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -#!/bin/bash
> -(perf record -e raw_syscalls:sys_enter $@ || \
> - perf record -e syscalls:sys_enter $@) 2> /dev/null
> diff --git a/tools/perf/scripts/python/bin/syscall-counts-report b/tools/perf/scripts/python/bin/syscall-counts-report
> deleted file mode 100644
> index 0f0e9d453bb4..000000000000
> --- a/tools/perf/scripts/python/bin/syscall-counts-report
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -#!/bin/bash
> -# description: system-wide syscall counts
> -# args: [comm]
> -if [ $# -gt 0 ] ; then
> -    if ! expr match "$1" "-" > /dev/null ; then
> -	comm=$1
> -	shift
> -    fi
> -fi
> -perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/syscall-counts.py $comm
> diff --git a/tools/perf/scripts/python/bin/task-analyzer-record b/tools/perf/scripts/python/bin/task-analyzer-record
> deleted file mode 100755
> index 0f6b51bb2767..000000000000
> --- a/tools/perf/scripts/python/bin/task-analyzer-record
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -#!/bin/bash
> -perf record -e sched:sched_switch -e sched:sched_migrate_task "$@"
> diff --git a/tools/perf/scripts/python/bin/task-analyzer-report b/tools/perf/scripts/python/bin/task-analyzer-report
> deleted file mode 100755
> index 4b16a8cc40a0..000000000000
> --- a/tools/perf/scripts/python/bin/task-analyzer-report
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -#!/bin/bash
> -# description: analyze timings of tasks
> -perf script -s "$PERF_EXEC_PATH"/scripts/python/task-analyzer.py -- "$@"
> diff --git a/tools/perf/scripts/python/check-perf-trace.py b/tools/perf/scripts/python/check-perf-trace.py
> deleted file mode 100644
> index d2c22954800d..000000000000
> --- a/tools/perf/scripts/python/check-perf-trace.py
> +++ /dev/null
> @@ -1,84 +0,0 @@
> -# perf script event handlers, generated by perf script -g python
> -# (c) 2010, Tom Zanussi <tzanussi@gmail.com>
> -# Licensed under the terms of the GNU GPL License version 2
> -#
> -# This script tests basic functionality such as flag and symbol
> -# strings, common_xxx() calls back into perf, begin, end, unhandled
> -# events, etc.  Basically, if this script runs successfully and
> -# displays expected results, Python scripting support should be ok.
> -
> -from __future__ import print_function
> -
> -import os
> -import sys
> -
> -sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> -	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> -
> -from Core import *
> -from perf_trace_context import *
> -
> -unhandled = autodict()
> -
> -def trace_begin():
> -	print("trace_begin")
> -	pass
> -
> -def trace_end():
> -	print_unhandled()
> -
> -def irq__softirq_entry(event_name, context, common_cpu,
> -		       common_secs, common_nsecs, common_pid, common_comm,
> -		       common_callchain, vec):
> -	print_header(event_name, common_cpu, common_secs, common_nsecs,
> -		common_pid, common_comm)
> -
> -	print_uncommon(context)
> -
> -	print("vec=%s" % (symbol_str("irq__softirq_entry", "vec", vec)))
> -
> -def kmem__kmalloc(event_name, context, common_cpu,
> -		  common_secs, common_nsecs, common_pid, common_comm,
> -		  common_callchain, call_site, ptr, bytes_req, bytes_alloc,
> -		  gfp_flags):
> -	print_header(event_name, common_cpu, common_secs, common_nsecs,
> -		common_pid, common_comm)
> -
> -	print_uncommon(context)
> -
> -	print("call_site=%u, ptr=%u, bytes_req=%u, "
> -		"bytes_alloc=%u, gfp_flags=%s" %
> -		(call_site, ptr, bytes_req, bytes_alloc,
> -		flag_str("kmem__kmalloc", "gfp_flags", gfp_flags)))
> -
> -def trace_unhandled(event_name, context, event_fields_dict):
> -	try:
> -		unhandled[event_name] += 1
> -	except TypeError:
> -		unhandled[event_name] = 1
> -
> -def print_header(event_name, cpu, secs, nsecs, pid, comm):
> -	print("%-20s %5u %05u.%09u %8u %-20s " %
> -		(event_name, cpu, secs, nsecs, pid, comm),
> -		end=' ')
> -
> -# print trace fields not included in handler args
> -def print_uncommon(context):
> -	print("common_preempt_count=%d, common_flags=%s, "
> -		"common_lock_depth=%d, " %
> -		(common_pc(context), trace_flag_str(common_flags(context)),
> -		common_lock_depth(context)))
> -
> -def print_unhandled():
> -	keys = unhandled.keys()
> -	if not keys:
> -		return
> -
> -	print("\nunhandled events:\n")
> -
> -	print("%-40s  %10s" % ("event", "count"))
> -	print("%-40s  %10s" % ("----------------------------------------",
> -				"-----------"))
> -
> -	for event_name in keys:
> -		print("%-40s  %10d\n" % (event_name, unhandled[event_name]))
> diff --git a/tools/perf/scripts/python/compaction-times.py b/tools/perf/scripts/python/compaction-times.py
> deleted file mode 100644
> index 9401f7c14747..000000000000
> --- a/tools/perf/scripts/python/compaction-times.py
> +++ /dev/null
> @@ -1,311 +0,0 @@
> -# report time spent in compaction
> -# Licensed under the terms of the GNU GPL License version 2
> -
> -# testing:
> -# 'echo 1 > /proc/sys/vm/compact_memory' to force compaction of all zones
> -
> -import os
> -import sys
> -import re
> -
> -import signal
> -signal.signal(signal.SIGPIPE, signal.SIG_DFL)
> -
> -usage = "usage: perf script report compaction-times.py -- [-h] [-u] [-p|-pv] [-t | [-m] [-fs] [-ms]] [pid|pid-range|comm-regex]\n"
> -
> -class popt:
> -	DISP_DFL = 0
> -	DISP_PROC = 1
> -	DISP_PROC_VERBOSE=2
> -
> -class topt:
> -	DISP_TIME = 0
> -	DISP_MIG = 1
> -	DISP_ISOLFREE = 2
> -	DISP_ISOLMIG = 4
> -	DISP_ALL = 7
> -
> -class comm_filter:
> -	def __init__(self, re):
> -		self.re = re
> -
> -	def filter(self, pid, comm):
> -		m = self.re.search(comm)
> -		return m == None or m.group() == ""
> -
> -class pid_filter:
> -	def __init__(self, low, high):
> -		self.low = (0 if low == "" else int(low))
> -		self.high = (0 if high == "" else int(high))
> -
> -	def filter(self, pid, comm):
> -		return not (pid >= self.low and (self.high == 0 or pid <= self.high))
> -
> -def set_type(t):
> -	global opt_disp
> -	opt_disp = (t if opt_disp == topt.DISP_ALL else opt_disp|t)
> -
> -def ns(sec, nsec):
> -	return (sec * 1000000000) + nsec
> -
> -def time(ns):
> -	return "%dns" % ns if opt_ns else "%dus" % (round(ns, -3) / 1000)
> -
> -class pair:
> -	def __init__(self, aval, bval, alabel = None, blabel = None):
> -		self.alabel = alabel
> -		self.blabel = blabel
> -		self.aval = aval
> -		self.bval = bval
> -
> -	def __add__(self, rhs):
> -		self.aval += rhs.aval
> -		self.bval += rhs.bval
> -		return self
> -
> -	def __str__(self):
> -		return "%s=%d %s=%d" % (self.alabel, self.aval, self.blabel, self.bval)
> -
> -class cnode:
> -	def __init__(self, ns):
> -		self.ns = ns
> -		self.migrated = pair(0, 0, "moved", "failed")
> -		self.fscan = pair(0,0, "scanned", "isolated")
> -		self.mscan = pair(0,0, "scanned", "isolated")
> -
> -	def __add__(self, rhs):
> -		self.ns += rhs.ns
> -		self.migrated += rhs.migrated
> -		self.fscan += rhs.fscan
> -		self.mscan += rhs.mscan
> -		return self
> -
> -	def __str__(self):
> -		prev = 0
> -		s = "%s " % time(self.ns)
> -		if (opt_disp & topt.DISP_MIG):
> -			s += "migration: %s" % self.migrated
> -			prev = 1
> -		if (opt_disp & topt.DISP_ISOLFREE):
> -			s += "%sfree_scanner: %s" % (" " if prev else "", self.fscan)
> -			prev = 1
> -		if (opt_disp & topt.DISP_ISOLMIG):
> -			s += "%smigration_scanner: %s" % (" " if prev else "", self.mscan)
> -		return s
> -
> -	def complete(self, secs, nsecs):
> -		self.ns = ns(secs, nsecs) - self.ns
> -
> -	def increment(self, migrated, fscan, mscan):
> -		if (migrated != None):
> -			self.migrated += migrated
> -		if (fscan != None):
> -			self.fscan += fscan
> -		if (mscan != None):
> -			self.mscan += mscan
> -
> -
> -class chead:
> -	heads = {}
> -	val = cnode(0);
> -	fobj = None
> -
> -	@classmethod
> -	def add_filter(cls, filter):
> -		cls.fobj = filter
> -
> -	@classmethod
> -	def create_pending(cls, pid, comm, start_secs, start_nsecs):
> -		filtered = 0
> -		try:
> -			head = cls.heads[pid]
> -			filtered = head.is_filtered()
> -		except KeyError:
> -			if cls.fobj != None:
> -				filtered = cls.fobj.filter(pid, comm)
> -			head = cls.heads[pid] = chead(comm, pid, filtered)
> -
> -		if not filtered:
> -			head.mark_pending(start_secs, start_nsecs)
> -
> -	@classmethod
> -	def increment_pending(cls, pid, migrated, fscan, mscan):
> -		head = cls.heads[pid]
> -		if not head.is_filtered():
> -			if head.is_pending():
> -				head.do_increment(migrated, fscan, mscan)
> -			else:
> -				sys.stderr.write("missing start compaction event for pid %d\n" % pid)
> -
> -	@classmethod
> -	def complete_pending(cls, pid, secs, nsecs):
> -		head = cls.heads[pid]
> -		if not head.is_filtered():
> -			if head.is_pending():
> -				head.make_complete(secs, nsecs)
> -			else:
> -				sys.stderr.write("missing start compaction event for pid %d\n" % pid)
> -
> -	@classmethod
> -	def gen(cls):
> -		if opt_proc != popt.DISP_DFL:
> -			for i in cls.heads:
> -				yield cls.heads[i]
> -
> -	@classmethod
> -	def str(cls):
> -		return cls.val
> -
> -	def __init__(self, comm, pid, filtered):
> -		self.comm = comm
> -		self.pid = pid
> -		self.val = cnode(0)
> -		self.pending = None
> -		self.filtered = filtered
> -		self.list = []
> -
> -	def __add__(self, rhs):
> -		self.ns += rhs.ns
> -		self.val += rhs.val
> -		return self
> -
> -	def mark_pending(self, secs, nsecs):
> -		self.pending = cnode(ns(secs, nsecs))
> -
> -	def do_increment(self, migrated, fscan, mscan):
> -		self.pending.increment(migrated, fscan, mscan)
> -
> -	def make_complete(self, secs, nsecs):
> -		self.pending.complete(secs, nsecs)
> -		chead.val += self.pending
> -
> -		if opt_proc != popt.DISP_DFL:
> -			self.val += self.pending
> -
> -			if opt_proc == popt.DISP_PROC_VERBOSE:
> -				self.list.append(self.pending)
> -		self.pending = None
> -
> -	def enumerate(self):
> -		if opt_proc == popt.DISP_PROC_VERBOSE and not self.is_filtered():
> -			for i, pelem in enumerate(self.list):
> -				sys.stdout.write("%d[%s].%d: %s\n" % (self.pid, self.comm, i+1, pelem))
> -
> -	def is_pending(self):
> -		return self.pending != None
> -
> -	def is_filtered(self):
> -		return self.filtered
> -
> -	def display(self):
> -		if not self.is_filtered():
> -			sys.stdout.write("%d[%s]: %s\n" % (self.pid, self.comm, self.val))
> -
> -
> -def trace_end():
> -	sys.stdout.write("total: %s\n" % chead.str())
> -	for i in chead.gen():
> -		i.display(),
> -		i.enumerate()
> -
> -def compaction__mm_compaction_migratepages(event_name, context, common_cpu,
> -	common_secs, common_nsecs, common_pid, common_comm,
> -	common_callchain, nr_migrated, nr_failed):
> -
> -	chead.increment_pending(common_pid,
> -		pair(nr_migrated, nr_failed), None, None)
> -
> -def compaction__mm_compaction_isolate_freepages(event_name, context, common_cpu,
> -	common_secs, common_nsecs, common_pid, common_comm,
> -	common_callchain, start_pfn, end_pfn, nr_scanned, nr_taken):
> -
> -	chead.increment_pending(common_pid,
> -		None, pair(nr_scanned, nr_taken), None)
> -
> -def compaction__mm_compaction_isolate_migratepages(event_name, context, common_cpu,
> -	common_secs, common_nsecs, common_pid, common_comm,
> -	common_callchain, start_pfn, end_pfn, nr_scanned, nr_taken):
> -
> -	chead.increment_pending(common_pid,
> -		None, None, pair(nr_scanned, nr_taken))
> -
> -def compaction__mm_compaction_end(event_name, context, common_cpu,
> -	common_secs, common_nsecs, common_pid, common_comm,
> -	common_callchain, zone_start, migrate_start, free_start, zone_end,
> -	sync, status):
> -
> -	chead.complete_pending(common_pid, common_secs, common_nsecs)
> -
> -def compaction__mm_compaction_begin(event_name, context, common_cpu,
> -	common_secs, common_nsecs, common_pid, common_comm,
> -	common_callchain, zone_start, migrate_start, free_start, zone_end,
> -	sync):
> -
> -	chead.create_pending(common_pid, common_comm, common_secs, common_nsecs)
> -
> -def pr_help():
> -	global usage
> -
> -	sys.stdout.write(usage)
> -	sys.stdout.write("\n")
> -	sys.stdout.write("-h	display this help\n")
> -	sys.stdout.write("-p	display by process\n")
> -	sys.stdout.write("-pv	display by process (verbose)\n")
> -	sys.stdout.write("-t	display stall times only\n")
> -	sys.stdout.write("-m	display stats for migration\n")
> -	sys.stdout.write("-fs	display stats for free scanner\n")
> -	sys.stdout.write("-ms	display stats for migration scanner\n")
> -	sys.stdout.write("-u	display results in microseconds (default nanoseconds)\n")
> -
> -
> -comm_re = None
> -pid_re = None
> -pid_regex = r"^(\d*)-(\d*)$|^(\d*)$"
> -
> -opt_proc = popt.DISP_DFL
> -opt_disp = topt.DISP_ALL
> -
> -opt_ns = True
> -
> -argc = len(sys.argv) - 1
> -if argc >= 1:
> -	pid_re = re.compile(pid_regex)
> -
> -	for i, opt in enumerate(sys.argv[1:]):
> -		if opt[0] == "-":
> -			if opt == "-h":
> -				pr_help()
> -				exit(0);
> -			elif opt == "-p":
> -				opt_proc = popt.DISP_PROC
> -			elif opt == "-pv":
> -				opt_proc = popt.DISP_PROC_VERBOSE
> -			elif opt == '-u':
> -				opt_ns = False
> -			elif opt == "-t":
> -				set_type(topt.DISP_TIME)
> -			elif opt == "-m":
> -				set_type(topt.DISP_MIG)
> -			elif opt == "-fs":
> -				set_type(topt.DISP_ISOLFREE)
> -			elif opt == "-ms":
> -				set_type(topt.DISP_ISOLMIG)
> -			else:
> -				sys.exit(usage)
> -
> -		elif i == argc - 1:
> -			m = pid_re.search(opt)
> -			if m != None and m.group() != "":
> -				if m.group(3) != None:
> -					f = pid_filter(m.group(3), m.group(3))
> -				else:
> -					f = pid_filter(m.group(1), m.group(2))
> -			else:
> -				try:
> -					comm_re=re.compile(opt)
> -				except:
> -					sys.stderr.write("invalid regex '%s'" % opt)
> -					sys.exit(usage)
> -				f = comm_filter(comm_re)
> -
> -			chead.add_filter(f)
> diff --git a/tools/perf/scripts/python/event_analyzing_sample.py b/tools/perf/scripts/python/event_analyzing_sample.py
> deleted file mode 100644
> index aa1e2cfa26a6..000000000000
> --- a/tools/perf/scripts/python/event_analyzing_sample.py
> +++ /dev/null
> @@ -1,192 +0,0 @@
> -# event_analyzing_sample.py: general event handler in python
> -# SPDX-License-Identifier: GPL-2.0
> -#
> -# Current perf report is already very powerful with the annotation integrated,
> -# and this script is not trying to be as powerful as perf report, but
> -# providing end user/developer a flexible way to analyze the events other
> -# than trace points.
> -#
> -# The 2 database related functions in this script just show how to gather
> -# the basic information, and users can modify and write their own functions
> -# according to their specific requirement.
> -#
> -# The first function "show_general_events" just does a basic grouping for all
> -# generic events with the help of sqlite, and the 2nd one "show_pebs_ll" is
> -# for a x86 HW PMU event: PEBS with load latency data.
> -#
> -
> -from __future__ import print_function
> -
> -import os
> -import sys
> -import math
> -import struct
> -import sqlite3
> -
> -sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> -        '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> -
> -from perf_trace_context import *
> -from EventClass import *
> -
> -#
> -# If the perf.data has a big number of samples, then the insert operation
> -# will be very time consuming (about 10+ minutes for 10000 samples) if the
> -# .db database is on disk. Move the .db file to RAM based FS to speedup
> -# the handling, which will cut the time down to several seconds.
> -#
> -con = sqlite3.connect("/dev/shm/perf.db")
> -con.isolation_level = None
> -
> -def trace_begin():
> -        print("In trace_begin:\n")
> -
> -        #
> -        # Will create several tables at the start, pebs_ll is for PEBS data with
> -        # load latency info, while gen_events is for general event.
> -        #
> -        con.execute("""
> -                create table if not exists gen_events (
> -                        name text,
> -                        symbol text,
> -                        comm text,
> -                        dso text
> -                );""")
> -        con.execute("""
> -                create table if not exists pebs_ll (
> -                        name text,
> -                        symbol text,
> -                        comm text,
> -                        dso text,
> -                        flags integer,
> -                        ip integer,
> -                        status integer,
> -                        dse integer,
> -                        dla integer,
> -                        lat integer
> -                );""")
> -
> -#
> -# Create and insert event object to a database so that user could
> -# do more analysis with simple database commands.
> -#
> -def process_event(param_dict):
> -        event_attr = param_dict["attr"]
> -        sample     = param_dict["sample"]
> -        raw_buf    = param_dict["raw_buf"]
> -        comm       = param_dict["comm"]
> -        name       = param_dict["ev_name"]
> -
> -        # Symbol and dso info are not always resolved
> -        if ("dso" in param_dict):
> -                dso = param_dict["dso"]
> -        else:
> -                dso = "Unknown_dso"
> -
> -        if ("symbol" in param_dict):
> -                symbol = param_dict["symbol"]
> -        else:
> -                symbol = "Unknown_symbol"
> -
> -        # Create the event object and insert it to the right table in database
> -        event = create_event(name, comm, dso, symbol, raw_buf)
> -        insert_db(event)
> -
> -def insert_db(event):
> -        if event.ev_type == EVTYPE_GENERIC:
> -                con.execute("insert into gen_events values(?, ?, ?, ?)",
> -                                (event.name, event.symbol, event.comm, event.dso))
> -        elif event.ev_type == EVTYPE_PEBS_LL:
> -                event.ip &= 0x7fffffffffffffff
> -                event.dla &= 0x7fffffffffffffff
> -                con.execute("insert into pebs_ll values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
> -                        (event.name, event.symbol, event.comm, event.dso, event.flags,
> -                                event.ip, event.status, event.dse, event.dla, event.lat))
> -
> -def trace_end():
> -        print("In trace_end:\n")
> -        # We show the basic info for the 2 type of event classes
> -        show_general_events()
> -        show_pebs_ll()
> -        con.close()
> -
> -#
> -# As the event number may be very big, so we can't use linear way
> -# to show the histogram in real number, but use a log2 algorithm.
> -#
> -
> -def num2sym(num):
> -        # Each number will have at least one '#'
> -        snum = '#' * (int)(math.log(num, 2) + 1)
> -        return snum
> -
> -def show_general_events():
> -
> -        # Check the total record number in the table
> -        count = con.execute("select count(*) from gen_events")
> -        for t in count:
> -                print("There is %d records in gen_events table" % t[0])
> -                if t[0] == 0:
> -                        return
> -
> -        print("Statistics about the general events grouped by thread/symbol/dso: \n")
> -
> -         # Group by thread
> -        commq = con.execute("select comm, count(comm) from gen_events group by comm order by -count(comm)")
> -        print("\n%16s %8s %16s\n%s" % ("comm", "number", "histogram", "="*42))
> -        for row in commq:
> -             print("%16s %8d     %s" % (row[0], row[1], num2sym(row[1])))
> -
> -        # Group by symbol
> -        print("\n%32s %8s %16s\n%s" % ("symbol", "number", "histogram", "="*58))
> -        symbolq = con.execute("select symbol, count(symbol) from gen_events group by symbol order by -count(symbol)")
> -        for row in symbolq:
> -             print("%32s %8d     %s" % (row[0], row[1], num2sym(row[1])))
> -
> -        # Group by dso
> -        print("\n%40s %8s %16s\n%s" % ("dso", "number", "histogram", "="*74))
> -        dsoq = con.execute("select dso, count(dso) from gen_events group by dso order by -count(dso)")
> -        for row in dsoq:
> -             print("%40s %8d     %s" % (row[0], row[1], num2sym(row[1])))
> -
> -#
> -# This function just shows the basic info, and we could do more with the
> -# data in the tables, like checking the function parameters when some
> -# big latency events happen.
> -#
> -def show_pebs_ll():
> -
> -        count = con.execute("select count(*) from pebs_ll")
> -        for t in count:
> -                print("There is %d records in pebs_ll table" % t[0])
> -                if t[0] == 0:
> -                        return
> -
> -        print("Statistics about the PEBS Load Latency events grouped by thread/symbol/dse/latency: \n")
> -
> -        # Group by thread
> -        commq = con.execute("select comm, count(comm) from pebs_ll group by comm order by -count(comm)")
> -        print("\n%16s %8s %16s\n%s" % ("comm", "number", "histogram", "="*42))
> -        for row in commq:
> -             print("%16s %8d     %s" % (row[0], row[1], num2sym(row[1])))
> -
> -        # Group by symbol
> -        print("\n%32s %8s %16s\n%s" % ("symbol", "number", "histogram", "="*58))
> -        symbolq = con.execute("select symbol, count(symbol) from pebs_ll group by symbol order by -count(symbol)")
> -        for row in symbolq:
> -             print("%32s %8d     %s" % (row[0], row[1], num2sym(row[1])))
> -
> -        # Group by dse
> -        dseq = con.execute("select dse, count(dse) from pebs_ll group by dse order by -count(dse)")
> -        print("\n%32s %8s %16s\n%s" % ("dse", "number", "histogram", "="*58))
> -        for row in dseq:
> -             print("%32s %8d     %s" % (row[0], row[1], num2sym(row[1])))
> -
> -        # Group by latency
> -        latq = con.execute("select lat, count(lat) from pebs_ll group by lat order by lat")
> -        print("\n%32s %8s %16s\n%s" % ("latency", "number", "histogram", "="*58))
> -        for row in latq:
> -             print("%32s %8d     %s" % (row[0], row[1], num2sym(row[1])))
> -
> -def trace_unhandled(event_name, context, event_fields_dict):
> -        print (' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())]))
> diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
> deleted file mode 100644
> index 3a6bdcd74e60..000000000000
> --- a/tools/perf/scripts/python/export-to-postgresql.py
> +++ /dev/null
> @@ -1,1114 +0,0 @@
> -# export-to-postgresql.py: export perf data to a postgresql database
> -# Copyright (c) 2014, Intel Corporation.
> -#
> -# This program is free software; you can redistribute it and/or modify it
> -# under the terms and conditions of the GNU General Public License,
> -# version 2, as published by the Free Software Foundation.
> -#
> -# This program is distributed in the hope it will be useful, but WITHOUT
> -# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> -# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> -# more details.
> -
> -from __future__ import print_function
> -
> -import os
> -import sys
> -import struct
> -import datetime
> -
> -# To use this script you will need to have installed package python-pyside which
> -# provides LGPL-licensed Python bindings for Qt.  You will also need the package
> -# libqt4-sql-psql for Qt postgresql support.
> -#
> -# The script assumes postgresql is running on the local machine and that the
> -# user has postgresql permissions to create databases. Examples of installing
> -# postgresql and adding such a user are:
> -#
> -# fedora:
> -#
> -#	$ sudo yum install postgresql postgresql-server qt-postgresql
> -#	$ sudo su - postgres -c initdb
> -#	$ sudo service postgresql start
> -#	$ sudo su - postgres
> -#	$ createuser -s <your user id here>    # Older versions may not support -s, in which case answer the prompt below:
> -#	Shall the new role be a superuser? (y/n) y
> -#	$ sudo yum install python-pyside
> -#
> -#	Alternately, to use Python3 and/or pyside 2, one of the following:
> -#		$ sudo yum install python3-pyside
> -#		$ pip install --user PySide2
> -#		$ pip3 install --user PySide2
> -#
> -# ubuntu:
> -#
> -#	$ sudo apt-get install postgresql
> -#	$ sudo su - postgres
> -#	$ createuser -s <your user id here>
> -#	$ sudo apt-get install python-pyside.qtsql libqt4-sql-psql
> -#
> -#	Alternately, to use Python3 and/or pyside 2, one of the following:
> -#
> -#		$ sudo apt-get install python3-pyside.qtsql libqt4-sql-psql
> -#		$ sudo apt-get install python-pyside2.qtsql libqt5sql5-psql
> -#		$ sudo apt-get install python3-pyside2.qtsql libqt5sql5-psql
> -#
> -# An example of using this script with Intel PT:
> -#
> -#	$ perf record -e intel_pt//u ls
> -#	$ perf script -s ~/libexec/perf-core/scripts/python/export-to-postgresql.py pt_example branches calls
> -#	2015-05-29 12:49:23.464364 Creating database...
> -#	2015-05-29 12:49:26.281717 Writing to intermediate files...
> -#	2015-05-29 12:49:27.190383 Copying to database...
> -#	2015-05-29 12:49:28.140451 Removing intermediate files...
> -#	2015-05-29 12:49:28.147451 Adding primary keys
> -#	2015-05-29 12:49:28.655683 Adding foreign keys
> -#	2015-05-29 12:49:29.365350 Done
> -#
> -# To browse the database, psql can be used e.g.
> -#
> -#	$ psql pt_example
> -#	pt_example=# select * from samples_view where id < 100;
> -#	pt_example=# \d+
> -#	pt_example=# \d+ samples_view
> -#	pt_example=# \q
> -#
> -# An example of using the database is provided by the script
> -# exported-sql-viewer.py.  Refer to that script for details.
> -#
> -# Tables:
> -#
> -#	The tables largely correspond to perf tools' data structures.  They are largely self-explanatory.
> -#
> -#	samples
> -#
> -#		'samples' is the main table. It represents what instruction was executing at a point in time
> -#		when something (a selected event) happened.  The memory address is the instruction pointer or 'ip'.
> -#
> -#	calls
> -#
> -#		'calls' represents function calls and is related to 'samples' by 'call_id' and 'return_id'.
> -#		'calls' is only created when the 'calls' option to this script is specified.
> -#
> -#	call_paths
> -#
> -#		'call_paths' represents all the call stacks.  Each 'call' has an associated record in 'call_paths'.
> -#		'calls_paths' is only created when the 'calls' option to this script is specified.
> -#
> -#	branch_types
> -#
> -#		'branch_types' provides descriptions for each type of branch.
> -#
> -#	comm_threads
> -#
> -#		'comm_threads' shows how 'comms' relates to 'threads'.
> -#
> -#	comms
> -#
> -#		'comms' contains a record for each 'comm' - the name given to the executable that is running.
> -#
> -#	dsos
> -#
> -#		'dsos' contains a record for each executable file or library.
> -#
> -#	machines
> -#
> -#		'machines' can be used to distinguish virtual machines if virtualization is supported.
> -#
> -#	selected_events
> -#
> -#		'selected_events' contains a record for each kind of event that has been sampled.
> -#
> -#	symbols
> -#
> -#		'symbols' contains a record for each symbol.  Only symbols that have samples are present.
> -#
> -#	threads
> -#
> -#		'threads' contains a record for each thread.
> -#
> -# Views:
> -#
> -#	Most of the tables have views for more friendly display.  The views are:
> -#
> -#		calls_view
> -#		call_paths_view
> -#		comm_threads_view
> -#		dsos_view
> -#		machines_view
> -#		samples_view
> -#		symbols_view
> -#		threads_view
> -#
> -# More examples of browsing the database with psql:
> -#   Note that some of the examples are not the most optimal SQL query.
> -#   Note that call information is only available if the script's 'calls' option has been used.
> -#
> -#	Top 10 function calls (not aggregated by symbol):
> -#
> -#		SELECT * FROM calls_view ORDER BY elapsed_time DESC LIMIT 10;
> -#
> -#	Top 10 function calls (aggregated by symbol):
> -#
> -#		SELECT symbol_id,(SELECT name FROM symbols WHERE id = symbol_id) AS symbol,
> -#			SUM(elapsed_time) AS tot_elapsed_time,SUM(branch_count) AS tot_branch_count
> -#			FROM calls_view GROUP BY symbol_id ORDER BY tot_elapsed_time DESC LIMIT 10;
> -#
> -#		Note that the branch count gives a rough estimation of cpu usage, so functions
> -#		that took a long time but have a relatively low branch count must have spent time
> -#		waiting.
> -#
> -#	Find symbols by pattern matching on part of the name (e.g. names containing 'alloc'):
> -#
> -#		SELECT * FROM symbols_view WHERE name LIKE '%alloc%';
> -#
> -#	Top 10 function calls for a specific symbol (e.g. whose symbol_id is 187):
> -#
> -#		SELECT * FROM calls_view WHERE symbol_id = 187 ORDER BY elapsed_time DESC LIMIT 10;
> -#
> -#	Show function calls made by function in the same context (i.e. same call path) (e.g. one with call_path_id 254):
> -#
> -#		SELECT * FROM calls_view WHERE parent_call_path_id = 254;
> -#
> -#	Show branches made during a function call (e.g. where call_id is 29357 and return_id is 29370 and tid is 29670)
> -#
> -#		SELECT * FROM samples_view WHERE id >= 29357 AND id <= 29370 AND tid = 29670 AND event LIKE 'branches%';
> -#
> -#	Show transactions:
> -#
> -#		SELECT * FROM samples_view WHERE event = 'transactions';
> -#
> -#		Note transaction start has 'in_tx' true whereas, transaction end has 'in_tx' false.
> -#		Transaction aborts have branch_type_name 'transaction abort'
> -#
> -#	Show transaction aborts:
> -#
> -#		SELECT * FROM samples_view WHERE event = 'transactions' AND branch_type_name = 'transaction abort';
> -#
> -# To print a call stack requires walking the call_paths table.  For example this python script:
> -#   #!/usr/bin/python2
> -#
> -#   import sys
> -#   from PySide.QtSql import *
> -#
> -#   if __name__ == '__main__':
> -#           if (len(sys.argv) < 3):
> -#                   print >> sys.stderr, "Usage is: printcallstack.py <database name> <call_path_id>"
> -#                   raise Exception("Too few arguments")
> -#           dbname = sys.argv[1]
> -#           call_path_id = sys.argv[2]
> -#           db = QSqlDatabase.addDatabase('QPSQL')
> -#           db.setDatabaseName(dbname)
> -#           if not db.open():
> -#                   raise Exception("Failed to open database " + dbname + " error: " + db.lastError().text())
> -#           query = QSqlQuery(db)
> -#           print "    id          ip  symbol_id  symbol                          dso_id  dso_short_name"
> -#           while call_path_id != 0 and call_path_id != 1:
> -#                   ret = query.exec_('SELECT * FROM call_paths_view WHERE id = ' + str(call_path_id))
> -#                   if not ret:
> -#                           raise Exception("Query failed: " + query.lastError().text())
> -#                   if not query.next():
> -#                           raise Exception("Query failed")
> -#                   print "{0:>6}  {1:>10}  {2:>9}  {3:<30}  {4:>6}  {5:<30}".format(query.value(0), query.value(1), query.value(2), query.value(3), query.value(4), query.value(5))
> -#                   call_path_id = query.value(6)
> -
> -pyside_version_1 = True
> -if not "pyside-version-1" in sys.argv:
> -	try:
> -		from PySide2.QtSql import *
> -		pyside_version_1 = False
> -	except:
> -		pass
> -
> -if pyside_version_1:
> -	from PySide.QtSql import *
> -
> -if sys.version_info < (3, 0):
> -	def toserverstr(str):
> -		return str
> -	def toclientstr(str):
> -		return str
> -else:
> -	# Assume UTF-8 server_encoding and client_encoding
> -	def toserverstr(str):
> -		return bytes(str, "UTF_8")
> -	def toclientstr(str):
> -		return bytes(str, "UTF_8")
> -
> -# Need to access PostgreSQL C library directly to use COPY FROM STDIN
> -from ctypes import *
> -libpq = CDLL("libpq.so.5")
> -PQconnectdb = libpq.PQconnectdb
> -PQconnectdb.restype = c_void_p
> -PQconnectdb.argtypes = [ c_char_p ]
> -PQfinish = libpq.PQfinish
> -PQfinish.argtypes = [ c_void_p ]
> -PQstatus = libpq.PQstatus
> -PQstatus.restype = c_int
> -PQstatus.argtypes = [ c_void_p ]
> -PQexec = libpq.PQexec
> -PQexec.restype = c_void_p
> -PQexec.argtypes = [ c_void_p, c_char_p ]
> -PQresultStatus = libpq.PQresultStatus
> -PQresultStatus.restype = c_int
> -PQresultStatus.argtypes = [ c_void_p ]
> -PQputCopyData = libpq.PQputCopyData
> -PQputCopyData.restype = c_int
> -PQputCopyData.argtypes = [ c_void_p, c_void_p, c_int ]
> -PQputCopyEnd = libpq.PQputCopyEnd
> -PQputCopyEnd.restype = c_int
> -PQputCopyEnd.argtypes = [ c_void_p, c_void_p ]
> -
> -sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> -	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> -
> -# These perf imports are not used at present
> -#from perf_trace_context import *
> -#from Core import *
> -
> -perf_db_export_mode = True
> -perf_db_export_calls = False
> -perf_db_export_callchains = False
> -
> -def printerr(*args, **kw_args):
> -	print(*args, file=sys.stderr, **kw_args)
> -
> -def printdate(*args, **kw_args):
> -        print(datetime.datetime.today(), *args, sep=' ', **kw_args)
> -
> -def usage():
> -	printerr("Usage is: export-to-postgresql.py <database name> [<columns>] [<calls>] [<callchains>] [<pyside-version-1>]");
> -	printerr("where:  columns            'all' or 'branches'");
> -	printerr("        calls              'calls' => create calls and call_paths table");
> -	printerr("        callchains         'callchains' => create call_paths table");
> -	printerr("        pyside-version-1   'pyside-version-1' => use pyside version 1");
> -	raise Exception("Too few or bad arguments")
> -
> -if (len(sys.argv) < 2):
> -	usage()
> -
> -dbname = sys.argv[1]
> -
> -if (len(sys.argv) >= 3):
> -	columns = sys.argv[2]
> -else:
> -	columns = "all"
> -
> -if columns not in ("all", "branches"):
> -	usage()
> -
> -branches = (columns == "branches")
> -
> -for i in range(3,len(sys.argv)):
> -	if (sys.argv[i] == "calls"):
> -		perf_db_export_calls = True
> -	elif (sys.argv[i] == "callchains"):
> -		perf_db_export_callchains = True
> -	elif (sys.argv[i] == "pyside-version-1"):
> -		pass
> -	else:
> -		usage()
> -
> -output_dir_name = os.getcwd() + "/" + dbname + "-perf-data"
> -os.mkdir(output_dir_name)
> -
> -def do_query(q, s):
> -	if (q.exec_(s)):
> -		return
> -	raise Exception("Query failed: " + q.lastError().text())
> -
> -printdate("Creating database...")
> -
> -db = QSqlDatabase.addDatabase('QPSQL')
> -query = QSqlQuery(db)
> -db.setDatabaseName('postgres')
> -db.open()
> -try:
> -	do_query(query, 'CREATE DATABASE ' + dbname)
> -except:
> -	os.rmdir(output_dir_name)
> -	raise
> -query.finish()
> -query.clear()
> -db.close()
> -
> -db.setDatabaseName(dbname)
> -db.open()
> -
> -query = QSqlQuery(db)
> -do_query(query, 'SET client_min_messages TO WARNING')
> -
> -do_query(query, 'CREATE TABLE selected_events ('
> -		'id		bigint		NOT NULL,'
> -		'name		varchar(80))')
> -do_query(query, 'CREATE TABLE machines ('
> -		'id		bigint		NOT NULL,'
> -		'pid		integer,'
> -		'root_dir 	varchar(4096))')
> -do_query(query, 'CREATE TABLE threads ('
> -		'id		bigint		NOT NULL,'
> -		'machine_id	bigint,'
> -		'process_id	bigint,'
> -		'pid		integer,'
> -		'tid		integer)')
> -do_query(query, 'CREATE TABLE comms ('
> -		'id		bigint		NOT NULL,'
> -		'comm		varchar(16),'
> -		'c_thread_id	bigint,'
> -		'c_time		bigint,'
> -		'exec_flag	boolean)')
> -do_query(query, 'CREATE TABLE comm_threads ('
> -		'id		bigint		NOT NULL,'
> -		'comm_id	bigint,'
> -		'thread_id	bigint)')
> -do_query(query, 'CREATE TABLE dsos ('
> -		'id		bigint		NOT NULL,'
> -		'machine_id	bigint,'
> -		'short_name	varchar(256),'
> -		'long_name	varchar(4096),'
> -		'build_id	varchar(64))')
> -do_query(query, 'CREATE TABLE symbols ('
> -		'id		bigint		NOT NULL,'
> -		'dso_id		bigint,'
> -		'sym_start	bigint,'
> -		'sym_end	bigint,'
> -		'binding	integer,'
> -		'name		varchar(2048))')
> -do_query(query, 'CREATE TABLE branch_types ('
> -		'id		integer		NOT NULL,'
> -		'name		varchar(80))')
> -
> -if branches:
> -	do_query(query, 'CREATE TABLE samples ('
> -		'id		bigint		NOT NULL,'
> -		'evsel_id	bigint,'
> -		'machine_id	bigint,'
> -		'thread_id	bigint,'
> -		'comm_id	bigint,'
> -		'dso_id		bigint,'
> -		'symbol_id	bigint,'
> -		'sym_offset	bigint,'
> -		'ip		bigint,'
> -		'time		bigint,'
> -		'cpu		integer,'
> -		'to_dso_id	bigint,'
> -		'to_symbol_id	bigint,'
> -		'to_sym_offset	bigint,'
> -		'to_ip		bigint,'
> -		'branch_type	integer,'
> -		'in_tx		boolean,'
> -		'call_path_id	bigint,'
> -		'insn_count	bigint,'
> -		'cyc_count	bigint,'
> -		'flags		integer)')
> -else:
> -	do_query(query, 'CREATE TABLE samples ('
> -		'id		bigint		NOT NULL,'
> -		'evsel_id	bigint,'
> -		'machine_id	bigint,'
> -		'thread_id	bigint,'
> -		'comm_id	bigint,'
> -		'dso_id		bigint,'
> -		'symbol_id	bigint,'
> -		'sym_offset	bigint,'
> -		'ip		bigint,'
> -		'time		bigint,'
> -		'cpu		integer,'
> -		'to_dso_id	bigint,'
> -		'to_symbol_id	bigint,'
> -		'to_sym_offset	bigint,'
> -		'to_ip		bigint,'
> -		'period		bigint,'
> -		'weight		bigint,'
> -		'transaction	bigint,'
> -		'data_src	bigint,'
> -		'branch_type	integer,'
> -		'in_tx		boolean,'
> -		'call_path_id	bigint,'
> -		'insn_count	bigint,'
> -		'cyc_count	bigint,'
> -		'flags		integer)')
> -
> -if perf_db_export_calls or perf_db_export_callchains:
> -	do_query(query, 'CREATE TABLE call_paths ('
> -		'id		bigint		NOT NULL,'
> -		'parent_id	bigint,'
> -		'symbol_id	bigint,'
> -		'ip		bigint)')
> -if perf_db_export_calls:
> -	do_query(query, 'CREATE TABLE calls ('
> -		'id		bigint		NOT NULL,'
> -		'thread_id	bigint,'
> -		'comm_id	bigint,'
> -		'call_path_id	bigint,'
> -		'call_time	bigint,'
> -		'return_time	bigint,'
> -		'branch_count	bigint,'
> -		'call_id	bigint,'
> -		'return_id	bigint,'
> -		'parent_call_path_id	bigint,'
> -		'flags		integer,'
> -		'parent_id	bigint,'
> -		'insn_count	bigint,'
> -		'cyc_count	bigint)')
> -
> -do_query(query, 'CREATE TABLE ptwrite ('
> -	'id		bigint		NOT NULL,'
> -	'payload	bigint,'
> -	'exact_ip	boolean)')
> -
> -do_query(query, 'CREATE TABLE cbr ('
> -	'id		bigint		NOT NULL,'
> -	'cbr		integer,'
> -	'mhz		integer,'
> -	'percent	integer)')
> -
> -do_query(query, 'CREATE TABLE mwait ('
> -	'id		bigint		NOT NULL,'
> -	'hints		integer,'
> -	'extensions	integer)')
> -
> -do_query(query, 'CREATE TABLE pwre ('
> -	'id		bigint		NOT NULL,'
> -	'cstate		integer,'
> -	'subcstate	integer,'
> -	'hw		boolean)')
> -
> -do_query(query, 'CREATE TABLE exstop ('
> -	'id		bigint		NOT NULL,'
> -	'exact_ip	boolean)')
> -
> -do_query(query, 'CREATE TABLE pwrx ('
> -	'id		bigint		NOT NULL,'
> -	'deepest_cstate	integer,'
> -	'last_cstate	integer,'
> -	'wake_reason	integer)')
> -
> -do_query(query, 'CREATE TABLE context_switches ('
> -		'id		bigint		NOT NULL,'
> -		'machine_id	bigint,'
> -		'time		bigint,'
> -		'cpu		integer,'
> -		'thread_out_id	bigint,'
> -		'comm_out_id	bigint,'
> -		'thread_in_id	bigint,'
> -		'comm_in_id	bigint,'
> -		'flags		integer)')
> -
> -do_query(query, 'CREATE VIEW machines_view AS '
> -	'SELECT '
> -		'id,'
> -		'pid,'
> -		'root_dir,'
> -		'CASE WHEN id=0 THEN \'unknown\' WHEN pid=-1 THEN \'host\' ELSE \'guest\' END AS host_or_guest'
> -	' FROM machines')
> -
> -do_query(query, 'CREATE VIEW dsos_view AS '
> -	'SELECT '
> -		'id,'
> -		'machine_id,'
> -		'(SELECT host_or_guest FROM machines_view WHERE id = machine_id) AS host_or_guest,'
> -		'short_name,'
> -		'long_name,'
> -		'build_id'
> -	' FROM dsos')
> -
> -do_query(query, 'CREATE VIEW symbols_view AS '
> -	'SELECT '
> -		'id,'
> -		'name,'
> -		'(SELECT short_name FROM dsos WHERE id=dso_id) AS dso,'
> -		'dso_id,'
> -		'sym_start,'
> -		'sym_end,'
> -		'CASE WHEN binding=0 THEN \'local\' WHEN binding=1 THEN \'global\' ELSE \'weak\' END AS binding'
> -	' FROM symbols')
> -
> -do_query(query, 'CREATE VIEW threads_view AS '
> -	'SELECT '
> -		'id,'
> -		'machine_id,'
> -		'(SELECT host_or_guest FROM machines_view WHERE id = machine_id) AS host_or_guest,'
> -		'process_id,'
> -		'pid,'
> -		'tid'
> -	' FROM threads')
> -
> -do_query(query, 'CREATE VIEW comm_threads_view AS '
> -	'SELECT '
> -		'comm_id,'
> -		'(SELECT comm FROM comms WHERE id = comm_id) AS command,'
> -		'thread_id,'
> -		'(SELECT pid FROM threads WHERE id = thread_id) AS pid,'
> -		'(SELECT tid FROM threads WHERE id = thread_id) AS tid'
> -	' FROM comm_threads')
> -
> -if perf_db_export_calls or perf_db_export_callchains:
> -	do_query(query, 'CREATE VIEW call_paths_view AS '
> -		'SELECT '
> -			'c.id,'
> -			'to_hex(c.ip) AS ip,'
> -			'c.symbol_id,'
> -			'(SELECT name FROM symbols WHERE id = c.symbol_id) AS symbol,'
> -			'(SELECT dso_id FROM symbols WHERE id = c.symbol_id) AS dso_id,'
> -			'(SELECT dso FROM symbols_view  WHERE id = c.symbol_id) AS dso_short_name,'
> -			'c.parent_id,'
> -			'to_hex(p.ip) AS parent_ip,'
> -			'p.symbol_id AS parent_symbol_id,'
> -			'(SELECT name FROM symbols WHERE id = p.symbol_id) AS parent_symbol,'
> -			'(SELECT dso_id FROM symbols WHERE id = p.symbol_id) AS parent_dso_id,'
> -			'(SELECT dso FROM symbols_view  WHERE id = p.symbol_id) AS parent_dso_short_name'
> -		' FROM call_paths c INNER JOIN call_paths p ON p.id = c.parent_id')
> -if perf_db_export_calls:
> -	do_query(query, 'CREATE VIEW calls_view AS '
> -		'SELECT '
> -			'calls.id,'
> -			'thread_id,'
> -			'(SELECT pid FROM threads WHERE id = thread_id) AS pid,'
> -			'(SELECT tid FROM threads WHERE id = thread_id) AS tid,'
> -			'(SELECT comm FROM comms WHERE id = comm_id) AS command,'
> -			'call_path_id,'
> -			'to_hex(ip) AS ip,'
> -			'symbol_id,'
> -			'(SELECT name FROM symbols WHERE id = symbol_id) AS symbol,'
> -			'call_time,'
> -			'return_time,'
> -			'return_time - call_time AS elapsed_time,'
> -			'branch_count,'
> -			'insn_count,'
> -			'cyc_count,'
> -			'CASE WHEN cyc_count=0 THEN CAST(0 AS NUMERIC(20, 2)) ELSE CAST((CAST(insn_count AS FLOAT) / cyc_count) AS NUMERIC(20, 2)) END AS IPC,'
> -			'call_id,'
> -			'return_id,'
> -			'CASE WHEN flags=0 THEN \'\' WHEN flags=1 THEN \'no call\' WHEN flags=2 THEN \'no return\' WHEN flags=3 THEN \'no call/return\' WHEN flags=6 THEN \'jump\' ELSE CAST ( flags AS VARCHAR(6) ) END AS flags,'
> -			'parent_call_path_id,'
> -			'calls.parent_id'
> -		' FROM calls INNER JOIN call_paths ON call_paths.id = call_path_id')
> -
> -do_query(query, 'CREATE VIEW samples_view AS '
> -	'SELECT '
> -		'id,'
> -		'time,'
> -		'cpu,'
> -		'(SELECT pid FROM threads WHERE id = thread_id) AS pid,'
> -		'(SELECT tid FROM threads WHERE id = thread_id) AS tid,'
> -		'(SELECT comm FROM comms WHERE id = comm_id) AS command,'
> -		'(SELECT name FROM selected_events WHERE id = evsel_id) AS event,'
> -		'to_hex(ip) AS ip_hex,'
> -		'(SELECT name FROM symbols WHERE id = symbol_id) AS symbol,'
> -		'sym_offset,'
> -		'(SELECT short_name FROM dsos WHERE id = dso_id) AS dso_short_name,'
> -		'to_hex(to_ip) AS to_ip_hex,'
> -		'(SELECT name FROM symbols WHERE id = to_symbol_id) AS to_symbol,'
> -		'to_sym_offset,'
> -		'(SELECT short_name FROM dsos WHERE id = to_dso_id) AS to_dso_short_name,'
> -		'(SELECT name FROM branch_types WHERE id = branch_type) AS branch_type_name,'
> -		'in_tx,'
> -		'insn_count,'
> -		'cyc_count,'
> -		'CASE WHEN cyc_count=0 THEN CAST(0 AS NUMERIC(20, 2)) ELSE CAST((CAST(insn_count AS FLOAT) / cyc_count) AS NUMERIC(20, 2)) END AS IPC,'
> -		'flags'
> -	' FROM samples')
> -
> -do_query(query, 'CREATE VIEW ptwrite_view AS '
> -	'SELECT '
> -		'ptwrite.id,'
> -		'time,'
> -		'cpu,'
> -		'to_hex(payload) AS payload_hex,'
> -		'CASE WHEN exact_ip=FALSE THEN \'False\' ELSE \'True\' END AS exact_ip'
> -	' FROM ptwrite'
> -	' INNER JOIN samples ON samples.id = ptwrite.id')
> -
> -do_query(query, 'CREATE VIEW cbr_view AS '
> -	'SELECT '
> -		'cbr.id,'
> -		'time,'
> -		'cpu,'
> -		'cbr,'
> -		'mhz,'
> -		'percent'
> -	' FROM cbr'
> -	' INNER JOIN samples ON samples.id = cbr.id')
> -
> -do_query(query, 'CREATE VIEW mwait_view AS '
> -	'SELECT '
> -		'mwait.id,'
> -		'time,'
> -		'cpu,'
> -		'to_hex(hints) AS hints_hex,'
> -		'to_hex(extensions) AS extensions_hex'
> -	' FROM mwait'
> -	' INNER JOIN samples ON samples.id = mwait.id')
> -
> -do_query(query, 'CREATE VIEW pwre_view AS '
> -	'SELECT '
> -		'pwre.id,'
> -		'time,'
> -		'cpu,'
> -		'cstate,'
> -		'subcstate,'
> -		'CASE WHEN hw=FALSE THEN \'False\' ELSE \'True\' END AS hw'
> -	' FROM pwre'
> -	' INNER JOIN samples ON samples.id = pwre.id')
> -
> -do_query(query, 'CREATE VIEW exstop_view AS '
> -	'SELECT '
> -		'exstop.id,'
> -		'time,'
> -		'cpu,'
> -		'CASE WHEN exact_ip=FALSE THEN \'False\' ELSE \'True\' END AS exact_ip'
> -	' FROM exstop'
> -	' INNER JOIN samples ON samples.id = exstop.id')
> -
> -do_query(query, 'CREATE VIEW pwrx_view AS '
> -	'SELECT '
> -		'pwrx.id,'
> -		'time,'
> -		'cpu,'
> -		'deepest_cstate,'
> -		'last_cstate,'
> -		'CASE     WHEN wake_reason=1 THEN \'Interrupt\''
> -			' WHEN wake_reason=2 THEN \'Timer Deadline\''
> -			' WHEN wake_reason=4 THEN \'Monitored Address\''
> -			' WHEN wake_reason=8 THEN \'HW\''
> -			' ELSE CAST ( wake_reason AS VARCHAR(2) )'
> -		'END AS wake_reason'
> -	' FROM pwrx'
> -	' INNER JOIN samples ON samples.id = pwrx.id')
> -
> -do_query(query, 'CREATE VIEW power_events_view AS '
> -	'SELECT '
> -		'samples.id,'
> -		'samples.time,'
> -		'samples.cpu,'
> -		'selected_events.name AS event,'
> -		'FORMAT(\'%6s\', cbr.cbr) AS cbr,'
> -		'FORMAT(\'%6s\', cbr.mhz) AS MHz,'
> -		'FORMAT(\'%5s\', cbr.percent) AS percent,'
> -		'to_hex(mwait.hints) AS hints_hex,'
> -		'to_hex(mwait.extensions) AS extensions_hex,'
> -		'FORMAT(\'%3s\', pwre.cstate) AS cstate,'
> -		'FORMAT(\'%3s\', pwre.subcstate) AS subcstate,'
> -		'CASE WHEN pwre.hw=FALSE THEN \'False\' WHEN pwre.hw=TRUE THEN \'True\' ELSE NULL END AS hw,'
> -		'CASE WHEN exstop.exact_ip=FALSE THEN \'False\' WHEN exstop.exact_ip=TRUE THEN \'True\' ELSE NULL END AS exact_ip,'
> -		'FORMAT(\'%3s\', pwrx.deepest_cstate) AS deepest_cstate,'
> -		'FORMAT(\'%3s\', pwrx.last_cstate) AS last_cstate,'
> -		'CASE     WHEN pwrx.wake_reason=1 THEN \'Interrupt\''
> -			' WHEN pwrx.wake_reason=2 THEN \'Timer Deadline\''
> -			' WHEN pwrx.wake_reason=4 THEN \'Monitored Address\''
> -			' WHEN pwrx.wake_reason=8 THEN \'HW\''
> -			' ELSE FORMAT(\'%2s\', pwrx.wake_reason)'
> -		'END AS wake_reason'
> -	' FROM cbr'
> -	' FULL JOIN mwait ON mwait.id = cbr.id'
> -	' FULL JOIN pwre ON pwre.id = cbr.id'
> -	' FULL JOIN exstop ON exstop.id = cbr.id'
> -	' FULL JOIN pwrx ON pwrx.id = cbr.id'
> -	' INNER JOIN samples ON samples.id = coalesce(cbr.id, mwait.id, pwre.id, exstop.id, pwrx.id)'
> -	' INNER JOIN selected_events ON selected_events.id = samples.evsel_id'
> -	' ORDER BY samples.id')
> -
> -do_query(query, 'CREATE VIEW context_switches_view AS '
> -	'SELECT '
> -		'context_switches.id,'
> -		'context_switches.machine_id,'
> -		'context_switches.time,'
> -		'context_switches.cpu,'
> -		'th_out.pid AS pid_out,'
> -		'th_out.tid AS tid_out,'
> -		'comm_out.comm AS comm_out,'
> -		'th_in.pid AS pid_in,'
> -		'th_in.tid AS tid_in,'
> -		'comm_in.comm AS comm_in,'
> -		'CASE	  WHEN context_switches.flags = 0 THEN \'in\''
> -			' WHEN context_switches.flags = 1 THEN \'out\''
> -			' WHEN context_switches.flags = 3 THEN \'out preempt\''
> -			' ELSE CAST ( context_switches.flags AS VARCHAR(11) )'
> -		'END AS flags'
> -	' FROM context_switches'
> -	' INNER JOIN threads AS th_out ON th_out.id   = context_switches.thread_out_id'
> -	' INNER JOIN threads AS th_in  ON th_in.id    = context_switches.thread_in_id'
> -	' INNER JOIN comms AS comm_out ON comm_out.id = context_switches.comm_out_id'
> -	' INNER JOIN comms AS comm_in  ON comm_in.id  = context_switches.comm_in_id')
> -
> -file_header = struct.pack("!11sii", b"PGCOPY\n\377\r\n\0", 0, 0)
> -file_trailer = b"\377\377"
> -
> -def open_output_file(file_name):
> -	path_name = output_dir_name + "/" + file_name
> -	file = open(path_name, "wb+")
> -	file.write(file_header)
> -	return file
> -
> -def close_output_file(file):
> -	file.write(file_trailer)
> -	file.close()
> -
> -def copy_output_file_direct(file, table_name):
> -	close_output_file(file)
> -	sql = "COPY " + table_name + " FROM '" + file.name + "' (FORMAT 'binary')"
> -	do_query(query, sql)
> -
> -# Use COPY FROM STDIN because security may prevent postgres from accessing the files directly
> -def copy_output_file(file, table_name):
> -	conn = PQconnectdb(toclientstr("dbname = " + dbname))
> -	if (PQstatus(conn)):
> -		raise Exception("COPY FROM STDIN PQconnectdb failed")
> -	file.write(file_trailer)
> -	file.seek(0)
> -	sql = "COPY " + table_name + " FROM STDIN (FORMAT 'binary')"
> -	res = PQexec(conn, toclientstr(sql))
> -	if (PQresultStatus(res) != 4):
> -		raise Exception("COPY FROM STDIN PQexec failed")
> -	data = file.read(65536)
> -	while (len(data)):
> -		ret = PQputCopyData(conn, data, len(data))
> -		if (ret != 1):
> -			raise Exception("COPY FROM STDIN PQputCopyData failed, error " + str(ret))
> -		data = file.read(65536)
> -	ret = PQputCopyEnd(conn, None)
> -	if (ret != 1):
> -		raise Exception("COPY FROM STDIN PQputCopyEnd failed, error " + str(ret))
> -	PQfinish(conn)
> -
> -def remove_output_file(file):
> -	name = file.name
> -	file.close()
> -	os.unlink(name)
> -
> -evsel_file		= open_output_file("evsel_table.bin")
> -machine_file		= open_output_file("machine_table.bin")
> -thread_file		= open_output_file("thread_table.bin")
> -comm_file		= open_output_file("comm_table.bin")
> -comm_thread_file	= open_output_file("comm_thread_table.bin")
> -dso_file		= open_output_file("dso_table.bin")
> -symbol_file		= open_output_file("symbol_table.bin")
> -branch_type_file	= open_output_file("branch_type_table.bin")
> -sample_file		= open_output_file("sample_table.bin")
> -if perf_db_export_calls or perf_db_export_callchains:
> -	call_path_file		= open_output_file("call_path_table.bin")
> -if perf_db_export_calls:
> -	call_file		= open_output_file("call_table.bin")
> -ptwrite_file		= open_output_file("ptwrite_table.bin")
> -cbr_file		= open_output_file("cbr_table.bin")
> -mwait_file		= open_output_file("mwait_table.bin")
> -pwre_file		= open_output_file("pwre_table.bin")
> -exstop_file		= open_output_file("exstop_table.bin")
> -pwrx_file		= open_output_file("pwrx_table.bin")
> -context_switches_file	= open_output_file("context_switches_table.bin")
> -
> -def trace_begin():
> -	printdate("Writing to intermediate files...")
> -	# id == 0 means unknown.  It is easier to create records for them than replace the zeroes with NULLs
> -	evsel_table(0, "unknown")
> -	machine_table(0, 0, "unknown")
> -	thread_table(0, 0, 0, -1, -1)
> -	comm_table(0, "unknown", 0, 0, 0)
> -	dso_table(0, 0, "unknown", "unknown", "")
> -	symbol_table(0, 0, 0, 0, 0, "unknown")
> -	sample_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
> -	if perf_db_export_calls or perf_db_export_callchains:
> -		call_path_table(0, 0, 0, 0)
> -		call_return_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
> -
> -unhandled_count = 0
> -
> -def is_table_empty(table_name):
> -	do_query(query, 'SELECT * FROM ' + table_name + ' LIMIT 1');
> -	if query.next():
> -		return False
> -	return True
> -
> -def drop(table_name):
> -	do_query(query, 'DROP VIEW ' + table_name + '_view');
> -	do_query(query, 'DROP TABLE ' + table_name);
> -
> -def trace_end():
> -	printdate("Copying to database...")
> -	copy_output_file(evsel_file,		"selected_events")
> -	copy_output_file(machine_file,		"machines")
> -	copy_output_file(thread_file,		"threads")
> -	copy_output_file(comm_file,		"comms")
> -	copy_output_file(comm_thread_file,	"comm_threads")
> -	copy_output_file(dso_file,		"dsos")
> -	copy_output_file(symbol_file,		"symbols")
> -	copy_output_file(branch_type_file,	"branch_types")
> -	copy_output_file(sample_file,		"samples")
> -	if perf_db_export_calls or perf_db_export_callchains:
> -		copy_output_file(call_path_file,	"call_paths")
> -	if perf_db_export_calls:
> -		copy_output_file(call_file,		"calls")
> -	copy_output_file(ptwrite_file,		"ptwrite")
> -	copy_output_file(cbr_file,		"cbr")
> -	copy_output_file(mwait_file,		"mwait")
> -	copy_output_file(pwre_file,		"pwre")
> -	copy_output_file(exstop_file,		"exstop")
> -	copy_output_file(pwrx_file,		"pwrx")
> -	copy_output_file(context_switches_file,	"context_switches")
> -
> -	printdate("Removing intermediate files...")
> -	remove_output_file(evsel_file)
> -	remove_output_file(machine_file)
> -	remove_output_file(thread_file)
> -	remove_output_file(comm_file)
> -	remove_output_file(comm_thread_file)
> -	remove_output_file(dso_file)
> -	remove_output_file(symbol_file)
> -	remove_output_file(branch_type_file)
> -	remove_output_file(sample_file)
> -	if perf_db_export_calls or perf_db_export_callchains:
> -		remove_output_file(call_path_file)
> -	if perf_db_export_calls:
> -		remove_output_file(call_file)
> -	remove_output_file(ptwrite_file)
> -	remove_output_file(cbr_file)
> -	remove_output_file(mwait_file)
> -	remove_output_file(pwre_file)
> -	remove_output_file(exstop_file)
> -	remove_output_file(pwrx_file)
> -	remove_output_file(context_switches_file)
> -	os.rmdir(output_dir_name)
> -	printdate("Adding primary keys")
> -	do_query(query, 'ALTER TABLE selected_events ADD PRIMARY KEY (id)')
> -	do_query(query, 'ALTER TABLE machines        ADD PRIMARY KEY (id)')
> -	do_query(query, 'ALTER TABLE threads         ADD PRIMARY KEY (id)')
> -	do_query(query, 'ALTER TABLE comms           ADD PRIMARY KEY (id)')
> -	do_query(query, 'ALTER TABLE comm_threads    ADD PRIMARY KEY (id)')
> -	do_query(query, 'ALTER TABLE dsos            ADD PRIMARY KEY (id)')
> -	do_query(query, 'ALTER TABLE symbols         ADD PRIMARY KEY (id)')
> -	do_query(query, 'ALTER TABLE branch_types    ADD PRIMARY KEY (id)')
> -	do_query(query, 'ALTER TABLE samples         ADD PRIMARY KEY (id)')
> -	if perf_db_export_calls or perf_db_export_callchains:
> -		do_query(query, 'ALTER TABLE call_paths      ADD PRIMARY KEY (id)')
> -	if perf_db_export_calls:
> -		do_query(query, 'ALTER TABLE calls           ADD PRIMARY KEY (id)')
> -	do_query(query, 'ALTER TABLE ptwrite         ADD PRIMARY KEY (id)')
> -	do_query(query, 'ALTER TABLE cbr             ADD PRIMARY KEY (id)')
> -	do_query(query, 'ALTER TABLE mwait           ADD PRIMARY KEY (id)')
> -	do_query(query, 'ALTER TABLE pwre            ADD PRIMARY KEY (id)')
> -	do_query(query, 'ALTER TABLE exstop          ADD PRIMARY KEY (id)')
> -	do_query(query, 'ALTER TABLE pwrx            ADD PRIMARY KEY (id)')
> -	do_query(query, 'ALTER TABLE context_switches ADD PRIMARY KEY (id)')
> -
> -	printdate("Adding foreign keys")
> -	do_query(query, 'ALTER TABLE threads '
> -					'ADD CONSTRAINT machinefk  FOREIGN KEY (machine_id)   REFERENCES machines   (id),'
> -					'ADD CONSTRAINT processfk  FOREIGN KEY (process_id)   REFERENCES threads    (id)')
> -	do_query(query, 'ALTER TABLE comms '
> -					'ADD CONSTRAINT threadfk   FOREIGN KEY (c_thread_id)  REFERENCES threads    (id)')
> -	do_query(query, 'ALTER TABLE comm_threads '
> -					'ADD CONSTRAINT commfk     FOREIGN KEY (comm_id)      REFERENCES comms      (id),'
> -					'ADD CONSTRAINT threadfk   FOREIGN KEY (thread_id)    REFERENCES threads    (id)')
> -	do_query(query, 'ALTER TABLE dsos '
> -					'ADD CONSTRAINT machinefk  FOREIGN KEY (machine_id)   REFERENCES machines   (id)')
> -	do_query(query, 'ALTER TABLE symbols '
> -					'ADD CONSTRAINT dsofk      FOREIGN KEY (dso_id)       REFERENCES dsos       (id)')
> -	do_query(query, 'ALTER TABLE samples '
> -					'ADD CONSTRAINT evselfk    FOREIGN KEY (evsel_id)     REFERENCES selected_events (id),'
> -					'ADD CONSTRAINT machinefk  FOREIGN KEY (machine_id)   REFERENCES machines   (id),'
> -					'ADD CONSTRAINT threadfk   FOREIGN KEY (thread_id)    REFERENCES threads    (id),'
> -					'ADD CONSTRAINT commfk     FOREIGN KEY (comm_id)      REFERENCES comms      (id),'
> -					'ADD CONSTRAINT dsofk      FOREIGN KEY (dso_id)       REFERENCES dsos       (id),'
> -					'ADD CONSTRAINT symbolfk   FOREIGN KEY (symbol_id)    REFERENCES symbols    (id),'
> -					'ADD CONSTRAINT todsofk    FOREIGN KEY (to_dso_id)    REFERENCES dsos       (id),'
> -					'ADD CONSTRAINT tosymbolfk FOREIGN KEY (to_symbol_id) REFERENCES symbols    (id)')
> -	if perf_db_export_calls or perf_db_export_callchains:
> -		do_query(query, 'ALTER TABLE call_paths '
> -					'ADD CONSTRAINT parentfk    FOREIGN KEY (parent_id)    REFERENCES call_paths (id),'
> -					'ADD CONSTRAINT symbolfk    FOREIGN KEY (symbol_id)    REFERENCES symbols    (id)')
> -	if perf_db_export_calls:
> -		do_query(query, 'ALTER TABLE calls '
> -					'ADD CONSTRAINT threadfk    FOREIGN KEY (thread_id)    REFERENCES threads    (id),'
> -					'ADD CONSTRAINT commfk      FOREIGN KEY (comm_id)      REFERENCES comms      (id),'
> -					'ADD CONSTRAINT call_pathfk FOREIGN KEY (call_path_id) REFERENCES call_paths (id),'
> -					'ADD CONSTRAINT callfk      FOREIGN KEY (call_id)      REFERENCES samples    (id),'
> -					'ADD CONSTRAINT returnfk    FOREIGN KEY (return_id)    REFERENCES samples    (id),'
> -					'ADD CONSTRAINT parent_call_pathfk FOREIGN KEY (parent_call_path_id) REFERENCES call_paths (id)')
> -		do_query(query, 'CREATE INDEX pcpid_idx ON calls (parent_call_path_id)')
> -		do_query(query, 'CREATE INDEX pid_idx ON calls (parent_id)')
> -		do_query(query, 'ALTER TABLE comms ADD has_calls boolean')
> -		do_query(query, 'UPDATE comms SET has_calls = TRUE WHERE comms.id IN (SELECT DISTINCT comm_id FROM calls)')
> -	do_query(query, 'ALTER TABLE ptwrite '
> -					'ADD CONSTRAINT idfk        FOREIGN KEY (id)           REFERENCES samples   (id)')
> -	do_query(query, 'ALTER TABLE  cbr '
> -					'ADD CONSTRAINT idfk        FOREIGN KEY (id)           REFERENCES samples   (id)')
> -	do_query(query, 'ALTER TABLE  mwait '
> -					'ADD CONSTRAINT idfk        FOREIGN KEY (id)           REFERENCES samples   (id)')
> -	do_query(query, 'ALTER TABLE  pwre '
> -					'ADD CONSTRAINT idfk        FOREIGN KEY (id)           REFERENCES samples   (id)')
> -	do_query(query, 'ALTER TABLE  exstop '
> -					'ADD CONSTRAINT idfk        FOREIGN KEY (id)           REFERENCES samples   (id)')
> -	do_query(query, 'ALTER TABLE  pwrx '
> -					'ADD CONSTRAINT idfk        FOREIGN KEY (id)           REFERENCES samples   (id)')
> -	do_query(query, 'ALTER TABLE  context_switches '
> -					'ADD CONSTRAINT machinefk   FOREIGN KEY (machine_id)    REFERENCES machines (id),'
> -					'ADD CONSTRAINT toutfk      FOREIGN KEY (thread_out_id) REFERENCES threads  (id),'
> -					'ADD CONSTRAINT tinfk       FOREIGN KEY (thread_in_id)  REFERENCES threads  (id),'
> -					'ADD CONSTRAINT coutfk      FOREIGN KEY (comm_out_id)   REFERENCES comms    (id),'
> -					'ADD CONSTRAINT cinfk       FOREIGN KEY (comm_in_id)    REFERENCES comms    (id)')
> -
> -	printdate("Dropping unused tables")
> -	if is_table_empty("ptwrite"):
> -		drop("ptwrite")
> -	if is_table_empty("mwait") and is_table_empty("pwre") and is_table_empty("exstop") and is_table_empty("pwrx"):
> -		do_query(query, 'DROP VIEW power_events_view');
> -		drop("mwait")
> -		drop("pwre")
> -		drop("exstop")
> -		drop("pwrx")
> -		if is_table_empty("cbr"):
> -			drop("cbr")
> -	if is_table_empty("context_switches"):
> -		drop("context_switches")
> -
> -	if (unhandled_count):
> -		printdate("Warning: ", unhandled_count, " unhandled events")
> -	printdate("Done")
> -
> -def trace_unhandled(event_name, context, event_fields_dict):
> -	global unhandled_count
> -	unhandled_count += 1
> -
> -def sched__sched_switch(*x):
> -	pass
> -
> -def evsel_table(evsel_id, evsel_name, *x):
> -	evsel_name = toserverstr(evsel_name)
> -	n = len(evsel_name)
> -	fmt = "!hiqi" + str(n) + "s"
> -	value = struct.pack(fmt, 2, 8, evsel_id, n, evsel_name)
> -	evsel_file.write(value)
> -
> -def machine_table(machine_id, pid, root_dir, *x):
> -	root_dir = toserverstr(root_dir)
> -	n = len(root_dir)
> -	fmt = "!hiqiii" + str(n) + "s"
> -	value = struct.pack(fmt, 3, 8, machine_id, 4, pid, n, root_dir)
> -	machine_file.write(value)
> -
> -def thread_table(thread_id, machine_id, process_id, pid, tid, *x):
> -	value = struct.pack("!hiqiqiqiiii", 5, 8, thread_id, 8, machine_id, 8, process_id, 4, pid, 4, tid)
> -	thread_file.write(value)
> -
> -def comm_table(comm_id, comm_str, thread_id, time, exec_flag, *x):
> -	comm_str = toserverstr(comm_str)
> -	n = len(comm_str)
> -	fmt = "!hiqi" + str(n) + "s" + "iqiqiB"
> -	value = struct.pack(fmt, 5, 8, comm_id, n, comm_str, 8, thread_id, 8, time, 1, exec_flag)
> -	comm_file.write(value)
> -
> -def comm_thread_table(comm_thread_id, comm_id, thread_id, *x):
> -	fmt = "!hiqiqiq"
> -	value = struct.pack(fmt, 3, 8, comm_thread_id, 8, comm_id, 8, thread_id)
> -	comm_thread_file.write(value)
> -
> -def dso_table(dso_id, machine_id, short_name, long_name, build_id, *x):
> -	short_name = toserverstr(short_name)
> -	long_name = toserverstr(long_name)
> -	build_id = toserverstr(build_id)
> -	n1 = len(short_name)
> -	n2 = len(long_name)
> -	n3 = len(build_id)
> -	fmt = "!hiqiqi" + str(n1) + "si"  + str(n2) + "si" + str(n3) + "s"
> -	value = struct.pack(fmt, 5, 8, dso_id, 8, machine_id, n1, short_name, n2, long_name, n3, build_id)
> -	dso_file.write(value)
> -
> -def symbol_table(symbol_id, dso_id, sym_start, sym_end, binding, symbol_name, *x):
> -	symbol_name = toserverstr(symbol_name)
> -	n = len(symbol_name)
> -	fmt = "!hiqiqiqiqiii" + str(n) + "s"
> -	value = struct.pack(fmt, 6, 8, symbol_id, 8, dso_id, 8, sym_start, 8, sym_end, 4, binding, n, symbol_name)
> -	symbol_file.write(value)
> -
> -def branch_type_table(branch_type, name, *x):
> -	name = toserverstr(name)
> -	n = len(name)
> -	fmt = "!hiii" + str(n) + "s"
> -	value = struct.pack(fmt, 2, 4, branch_type, n, name)
> -	branch_type_file.write(value)
> -
> -def sample_table(sample_id, evsel_id, machine_id, thread_id, comm_id, dso_id, symbol_id, sym_offset, ip, time, cpu, to_dso_id, to_symbol_id, to_sym_offset, to_ip, period, weight, transaction, data_src, branch_type, in_tx, call_path_id, insn_cnt, cyc_cnt, flags, *x):
> -	if branches:
> -		value = struct.pack("!hiqiqiqiqiqiqiqiqiqiqiiiqiqiqiqiiiBiqiqiqii", 21, 8, sample_id, 8, evsel_id, 8, machine_id, 8, thread_id, 8, comm_id, 8, dso_id, 8, symbol_id, 8, sym_offset, 8, ip, 8, time, 4, cpu, 8, to_dso_id, 8, to_symbol_id, 8, to_sym_offset, 8, to_ip, 4, branch_type, 1, in_tx, 8, call_path_id, 8, insn_cnt, 8, cyc_cnt, 4, flags)
> -	else:
> -		value = struct.pack("!hiqiqiqiqiqiqiqiqiqiqiiiqiqiqiqiqiqiqiqiiiBiqiqiqii", 25, 8, sample_id, 8, evsel_id, 8, machine_id, 8, thread_id, 8, comm_id, 8, dso_id, 8, symbol_id, 8, sym_offset, 8, ip, 8, time, 4, cpu, 8, to_dso_id, 8, to_symbol_id, 8, to_sym_offset, 8, to_ip, 8, period, 8, weight, 8, transaction, 8, data_src, 4, branch_type, 1, in_tx, 8, call_path_id, 8, insn_cnt, 8, cyc_cnt, 4, flags)
> -	sample_file.write(value)
> -
> -def call_path_table(cp_id, parent_id, symbol_id, ip, *x):
> -	fmt = "!hiqiqiqiq"
> -	value = struct.pack(fmt, 4, 8, cp_id, 8, parent_id, 8, symbol_id, 8, ip)
> -	call_path_file.write(value)
> -
> -def call_return_table(cr_id, thread_id, comm_id, call_path_id, call_time, return_time, branch_count, call_id, return_id, parent_call_path_id, flags, parent_id, insn_cnt, cyc_cnt, *x):
> -	fmt = "!hiqiqiqiqiqiqiqiqiqiqiiiqiqiq"
> -	value = struct.pack(fmt, 14, 8, cr_id, 8, thread_id, 8, comm_id, 8, call_path_id, 8, call_time, 8, return_time, 8, branch_count, 8, call_id, 8, return_id, 8, parent_call_path_id, 4, flags, 8, parent_id, 8, insn_cnt, 8, cyc_cnt)
> -	call_file.write(value)
> -
> -def ptwrite(id, raw_buf):
> -	data = struct.unpack_from("<IQ", raw_buf)
> -	flags = data[0]
> -	payload = data[1]
> -	exact_ip = flags & 1
> -	value = struct.pack("!hiqiqiB", 3, 8, id, 8, payload, 1, exact_ip)
> -	ptwrite_file.write(value)
> -
> -def cbr(id, raw_buf):
> -	data = struct.unpack_from("<BBBBII", raw_buf)
> -	cbr = data[0]
> -	MHz = (data[4] + 500) / 1000
> -	percent = ((cbr * 1000 / data[2]) + 5) / 10
> -	value = struct.pack("!hiqiiiiii", 4, 8, id, 4, cbr, 4, int(MHz), 4, int(percent))
> -	cbr_file.write(value)
> -
> -def mwait(id, raw_buf):
> -	data = struct.unpack_from("<IQ", raw_buf)
> -	payload = data[1]
> -	hints = payload & 0xff
> -	extensions = (payload >> 32) & 0x3
> -	value = struct.pack("!hiqiiii", 3, 8, id, 4, hints, 4, extensions)
> -	mwait_file.write(value)
> -
> -def pwre(id, raw_buf):
> -	data = struct.unpack_from("<IQ", raw_buf)
> -	payload = data[1]
> -	hw = (payload >> 7) & 1
> -	cstate = (payload >> 12) & 0xf
> -	subcstate = (payload >> 8) & 0xf
> -	value = struct.pack("!hiqiiiiiB", 4, 8, id, 4, cstate, 4, subcstate, 1, hw)
> -	pwre_file.write(value)
> -
> -def exstop(id, raw_buf):
> -	data = struct.unpack_from("<I", raw_buf)
> -	flags = data[0]
> -	exact_ip = flags & 1
> -	value = struct.pack("!hiqiB", 2, 8, id, 1, exact_ip)
> -	exstop_file.write(value)
> -
> -def pwrx(id, raw_buf):
> -	data = struct.unpack_from("<IQ", raw_buf)
> -	payload = data[1]
> -	deepest_cstate = payload & 0xf
> -	last_cstate = (payload >> 4) & 0xf
> -	wake_reason = (payload >> 8) & 0xf
> -	value = struct.pack("!hiqiiiiii", 4, 8, id, 4, deepest_cstate, 4, last_cstate, 4, wake_reason)
> -	pwrx_file.write(value)
> -
> -def synth_data(id, config, raw_buf, *x):
> -	if config == 0:
> -		ptwrite(id, raw_buf)
> -	elif config == 1:
> -		mwait(id, raw_buf)
> -	elif config == 2:
> -		pwre(id, raw_buf)
> -	elif config == 3:
> -		exstop(id, raw_buf)
> -	elif config == 4:
> -		pwrx(id, raw_buf)
> -	elif config == 5:
> -		cbr(id, raw_buf)
> -
> -def context_switch_table(id, machine_id, time, cpu, thread_out_id, comm_out_id, thread_in_id, comm_in_id, flags, *x):
> -	fmt = "!hiqiqiqiiiqiqiqiqii"
> -	value = struct.pack(fmt, 9, 8, id, 8, machine_id, 8, time, 4, cpu, 8, thread_out_id, 8, comm_out_id, 8, thread_in_id, 8, comm_in_id, 4, flags)
> -	context_switches_file.write(value)
> diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
> deleted file mode 100644
> index 73c992feb1b9..000000000000
> --- a/tools/perf/scripts/python/export-to-sqlite.py
> +++ /dev/null
> @@ -1,799 +0,0 @@
> -# export-to-sqlite.py: export perf data to a sqlite3 database
> -# Copyright (c) 2017, Intel Corporation.
> -#
> -# This program is free software; you can redistribute it and/or modify it
> -# under the terms and conditions of the GNU General Public License,
> -# version 2, as published by the Free Software Foundation.
> -#
> -# This program is distributed in the hope it will be useful, but WITHOUT
> -# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> -# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> -# more details.
> -
> -from __future__ import print_function
> -
> -import os
> -import sys
> -import struct
> -import datetime
> -
> -# To use this script you will need to have installed package python-pyside which
> -# provides LGPL-licensed Python bindings for Qt.  You will also need the package
> -# libqt4-sql-sqlite for Qt sqlite3 support.
> -#
> -# Examples of installing pyside:
> -#
> -# ubuntu:
> -#
> -#	$ sudo apt-get install python-pyside.qtsql libqt4-sql-psql
> -#
> -#	Alternately, to use Python3 and/or pyside 2, one of the following:
> -#
> -#		$ sudo apt-get install python3-pyside.qtsql libqt4-sql-psql
> -#		$ sudo apt-get install python-pyside2.qtsql libqt5sql5-psql
> -#		$ sudo apt-get install python3-pyside2.qtsql libqt5sql5-psql
> -# fedora:
> -#
> -#	$ sudo yum install python-pyside
> -#
> -#	Alternately, to use Python3 and/or pyside 2, one of the following:
> -#		$ sudo yum install python3-pyside
> -#		$ pip install --user PySide2
> -#		$ pip3 install --user PySide2
> -#
> -# An example of using this script with Intel PT:
> -#
> -#	$ perf record -e intel_pt//u ls
> -#	$ perf script -s ~/libexec/perf-core/scripts/python/export-to-sqlite.py pt_example branches calls
> -#	2017-07-31 14:26:07.326913 Creating database...
> -#	2017-07-31 14:26:07.538097 Writing records...
> -#	2017-07-31 14:26:09.889292 Adding indexes
> -#	2017-07-31 14:26:09.958746 Done
> -#
> -# To browse the database, sqlite3 can be used e.g.
> -#
> -#	$ sqlite3 pt_example
> -#	sqlite> .header on
> -#	sqlite> select * from samples_view where id < 10;
> -#	sqlite> .mode column
> -#	sqlite> select * from samples_view where id < 10;
> -#	sqlite> .tables
> -#	sqlite> .schema samples_view
> -#	sqlite> .quit
> -#
> -# An example of using the database is provided by the script
> -# exported-sql-viewer.py.  Refer to that script for details.
> -#
> -# The database structure is practically the same as created by the script
> -# export-to-postgresql.py. Refer to that script for details.  A notable
> -# difference is  the 'transaction' column of the 'samples' table which is
> -# renamed 'transaction_' in sqlite because 'transaction' is a reserved word.
> -
> -pyside_version_1 = True
> -if not "pyside-version-1" in sys.argv:
> -	try:
> -		from PySide2.QtSql import *
> -		pyside_version_1 = False
> -	except:
> -		pass
> -
> -if pyside_version_1:
> -	from PySide.QtSql import *
> -
> -sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> -	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> -
> -# These perf imports are not used at present
> -#from perf_trace_context import *
> -#from Core import *
> -
> -perf_db_export_mode = True
> -perf_db_export_calls = False
> -perf_db_export_callchains = False
> -
> -def printerr(*args, **keyword_args):
> -	print(*args, file=sys.stderr, **keyword_args)
> -
> -def printdate(*args, **kw_args):
> -        print(datetime.datetime.today(), *args, sep=' ', **kw_args)
> -
> -def usage():
> -	printerr("Usage is: export-to-sqlite.py <database name> [<columns>] [<calls>] [<callchains>] [<pyside-version-1>]");
> -	printerr("where:  columns            'all' or 'branches'");
> -	printerr("        calls              'calls' => create calls and call_paths table");
> -	printerr("        callchains         'callchains' => create call_paths table");
> -	printerr("        pyside-version-1   'pyside-version-1' => use pyside version 1");
> -	raise Exception("Too few or bad arguments")
> -
> -if (len(sys.argv) < 2):
> -	usage()
> -
> -dbname = sys.argv[1]
> -
> -if (len(sys.argv) >= 3):
> -	columns = sys.argv[2]
> -else:
> -	columns = "all"
> -
> -if columns not in ("all", "branches"):
> -	usage()
> -
> -branches = (columns == "branches")
> -
> -for i in range(3,len(sys.argv)):
> -	if (sys.argv[i] == "calls"):
> -		perf_db_export_calls = True
> -	elif (sys.argv[i] == "callchains"):
> -		perf_db_export_callchains = True
> -	elif (sys.argv[i] == "pyside-version-1"):
> -		pass
> -	else:
> -		usage()
> -
> -def do_query(q, s):
> -	if (q.exec_(s)):
> -		return
> -	raise Exception("Query failed: " + q.lastError().text())
> -
> -def do_query_(q):
> -	if (q.exec_()):
> -		return
> -	raise Exception("Query failed: " + q.lastError().text())
> -
> -printdate("Creating database ...")
> -
> -db_exists = False
> -try:
> -	f = open(dbname)
> -	f.close()
> -	db_exists = True
> -except:
> -	pass
> -
> -if db_exists:
> -	raise Exception(dbname + " already exists")
> -
> -db = QSqlDatabase.addDatabase('QSQLITE')
> -db.setDatabaseName(dbname)
> -db.open()
> -
> -query = QSqlQuery(db)
> -
> -do_query(query, 'PRAGMA journal_mode = OFF')
> -do_query(query, 'BEGIN TRANSACTION')
> -
> -do_query(query, 'CREATE TABLE selected_events ('
> -		'id		integer		NOT NULL	PRIMARY KEY,'
> -		'name		varchar(80))')
> -do_query(query, 'CREATE TABLE machines ('
> -		'id		integer		NOT NULL	PRIMARY KEY,'
> -		'pid		integer,'
> -		'root_dir 	varchar(4096))')
> -do_query(query, 'CREATE TABLE threads ('
> -		'id		integer		NOT NULL	PRIMARY KEY,'
> -		'machine_id	bigint,'
> -		'process_id	bigint,'
> -		'pid		integer,'
> -		'tid		integer)')
> -do_query(query, 'CREATE TABLE comms ('
> -		'id		integer		NOT NULL	PRIMARY KEY,'
> -		'comm		varchar(16),'
> -		'c_thread_id	bigint,'
> -		'c_time		bigint,'
> -		'exec_flag	boolean)')
> -do_query(query, 'CREATE TABLE comm_threads ('
> -		'id		integer		NOT NULL	PRIMARY KEY,'
> -		'comm_id	bigint,'
> -		'thread_id	bigint)')
> -do_query(query, 'CREATE TABLE dsos ('
> -		'id		integer		NOT NULL	PRIMARY KEY,'
> -		'machine_id	bigint,'
> -		'short_name	varchar(256),'
> -		'long_name	varchar(4096),'
> -		'build_id	varchar(64))')
> -do_query(query, 'CREATE TABLE symbols ('
> -		'id		integer		NOT NULL	PRIMARY KEY,'
> -		'dso_id		bigint,'
> -		'sym_start	bigint,'
> -		'sym_end	bigint,'
> -		'binding	integer,'
> -		'name		varchar(2048))')
> -do_query(query, 'CREATE TABLE branch_types ('
> -		'id		integer		NOT NULL	PRIMARY KEY,'
> -		'name		varchar(80))')
> -
> -if branches:
> -	do_query(query, 'CREATE TABLE samples ('
> -		'id		integer		NOT NULL	PRIMARY KEY,'
> -		'evsel_id	bigint,'
> -		'machine_id	bigint,'
> -		'thread_id	bigint,'
> -		'comm_id	bigint,'
> -		'dso_id		bigint,'
> -		'symbol_id	bigint,'
> -		'sym_offset	bigint,'
> -		'ip		bigint,'
> -		'time		bigint,'
> -		'cpu		integer,'
> -		'to_dso_id	bigint,'
> -		'to_symbol_id	bigint,'
> -		'to_sym_offset	bigint,'
> -		'to_ip		bigint,'
> -		'branch_type	integer,'
> -		'in_tx		boolean,'
> -		'call_path_id	bigint,'
> -		'insn_count	bigint,'
> -		'cyc_count	bigint,'
> -		'flags		integer)')
> -else:
> -	do_query(query, 'CREATE TABLE samples ('
> -		'id		integer		NOT NULL	PRIMARY KEY,'
> -		'evsel_id	bigint,'
> -		'machine_id	bigint,'
> -		'thread_id	bigint,'
> -		'comm_id	bigint,'
> -		'dso_id		bigint,'
> -		'symbol_id	bigint,'
> -		'sym_offset	bigint,'
> -		'ip		bigint,'
> -		'time		bigint,'
> -		'cpu		integer,'
> -		'to_dso_id	bigint,'
> -		'to_symbol_id	bigint,'
> -		'to_sym_offset	bigint,'
> -		'to_ip		bigint,'
> -		'period		bigint,'
> -		'weight		bigint,'
> -		'transaction_	bigint,'
> -		'data_src	bigint,'
> -		'branch_type	integer,'
> -		'in_tx		boolean,'
> -		'call_path_id	bigint,'
> -		'insn_count	bigint,'
> -		'cyc_count	bigint,'
> -		'flags		integer)')
> -
> -if perf_db_export_calls or perf_db_export_callchains:
> -	do_query(query, 'CREATE TABLE call_paths ('
> -		'id		integer		NOT NULL	PRIMARY KEY,'
> -		'parent_id	bigint,'
> -		'symbol_id	bigint,'
> -		'ip		bigint)')
> -if perf_db_export_calls:
> -	do_query(query, 'CREATE TABLE calls ('
> -		'id		integer		NOT NULL	PRIMARY KEY,'
> -		'thread_id	bigint,'
> -		'comm_id	bigint,'
> -		'call_path_id	bigint,'
> -		'call_time	bigint,'
> -		'return_time	bigint,'
> -		'branch_count	bigint,'
> -		'call_id	bigint,'
> -		'return_id	bigint,'
> -		'parent_call_path_id	bigint,'
> -		'flags		integer,'
> -		'parent_id	bigint,'
> -		'insn_count	bigint,'
> -		'cyc_count	bigint)')
> -
> -do_query(query, 'CREATE TABLE ptwrite ('
> -		'id		integer		NOT NULL	PRIMARY KEY,'
> -		'payload	bigint,'
> -		'exact_ip	integer)')
> -
> -do_query(query, 'CREATE TABLE cbr ('
> -		'id		integer		NOT NULL	PRIMARY KEY,'
> -		'cbr		integer,'
> -		'mhz		integer,'
> -		'percent	integer)')
> -
> -do_query(query, 'CREATE TABLE mwait ('
> -		'id		integer		NOT NULL	PRIMARY KEY,'
> -		'hints		integer,'
> -		'extensions	integer)')
> -
> -do_query(query, 'CREATE TABLE pwre ('
> -		'id		integer		NOT NULL	PRIMARY KEY,'
> -		'cstate		integer,'
> -		'subcstate	integer,'
> -		'hw		integer)')
> -
> -do_query(query, 'CREATE TABLE exstop ('
> -		'id		integer		NOT NULL	PRIMARY KEY,'
> -		'exact_ip	integer)')
> -
> -do_query(query, 'CREATE TABLE pwrx ('
> -		'id		integer		NOT NULL	PRIMARY KEY,'
> -		'deepest_cstate	integer,'
> -		'last_cstate	integer,'
> -		'wake_reason	integer)')
> -
> -do_query(query, 'CREATE TABLE context_switches ('
> -		'id		integer		NOT NULL	PRIMARY KEY,'
> -		'machine_id	bigint,'
> -		'time		bigint,'
> -		'cpu		integer,'
> -		'thread_out_id	bigint,'
> -		'comm_out_id	bigint,'
> -		'thread_in_id	bigint,'
> -		'comm_in_id	bigint,'
> -		'flags		integer)')
> -
> -# printf was added to sqlite in version 3.8.3
> -sqlite_has_printf = False
> -try:
> -	do_query(query, 'SELECT printf("") FROM machines')
> -	sqlite_has_printf = True
> -except:
> -	pass
> -
> -def emit_to_hex(x):
> -	if sqlite_has_printf:
> -		return 'printf("%x", ' + x + ')'
> -	else:
> -		return x
> -
> -do_query(query, 'CREATE VIEW machines_view AS '
> -	'SELECT '
> -		'id,'
> -		'pid,'
> -		'root_dir,'
> -		'CASE WHEN id=0 THEN \'unknown\' WHEN pid=-1 THEN \'host\' ELSE \'guest\' END AS host_or_guest'
> -	' FROM machines')
> -
> -do_query(query, 'CREATE VIEW dsos_view AS '
> -	'SELECT '
> -		'id,'
> -		'machine_id,'
> -		'(SELECT host_or_guest FROM machines_view WHERE id = machine_id) AS host_or_guest,'
> -		'short_name,'
> -		'long_name,'
> -		'build_id'
> -	' FROM dsos')
> -
> -do_query(query, 'CREATE VIEW symbols_view AS '
> -	'SELECT '
> -		'id,'
> -		'name,'
> -		'(SELECT short_name FROM dsos WHERE id=dso_id) AS dso,'
> -		'dso_id,'
> -		'sym_start,'
> -		'sym_end,'
> -		'CASE WHEN binding=0 THEN \'local\' WHEN binding=1 THEN \'global\' ELSE \'weak\' END AS binding'
> -	' FROM symbols')
> -
> -do_query(query, 'CREATE VIEW threads_view AS '
> -	'SELECT '
> -		'id,'
> -		'machine_id,'
> -		'(SELECT host_or_guest FROM machines_view WHERE id = machine_id) AS host_or_guest,'
> -		'process_id,'
> -		'pid,'
> -		'tid'
> -	' FROM threads')
> -
> -do_query(query, 'CREATE VIEW comm_threads_view AS '
> -	'SELECT '
> -		'comm_id,'
> -		'(SELECT comm FROM comms WHERE id = comm_id) AS command,'
> -		'thread_id,'
> -		'(SELECT pid FROM threads WHERE id = thread_id) AS pid,'
> -		'(SELECT tid FROM threads WHERE id = thread_id) AS tid'
> -	' FROM comm_threads')
> -
> -if perf_db_export_calls or perf_db_export_callchains:
> -	do_query(query, 'CREATE VIEW call_paths_view AS '
> -		'SELECT '
> -			'c.id,'
> -			+ emit_to_hex('c.ip') + ' AS ip,'
> -			'c.symbol_id,'
> -			'(SELECT name FROM symbols WHERE id = c.symbol_id) AS symbol,'
> -			'(SELECT dso_id FROM symbols WHERE id = c.symbol_id) AS dso_id,'
> -			'(SELECT dso FROM symbols_view  WHERE id = c.symbol_id) AS dso_short_name,'
> -			'c.parent_id,'
> -			+ emit_to_hex('p.ip') + ' AS parent_ip,'
> -			'p.symbol_id AS parent_symbol_id,'
> -			'(SELECT name FROM symbols WHERE id = p.symbol_id) AS parent_symbol,'
> -			'(SELECT dso_id FROM symbols WHERE id = p.symbol_id) AS parent_dso_id,'
> -			'(SELECT dso FROM symbols_view  WHERE id = p.symbol_id) AS parent_dso_short_name'
> -		' FROM call_paths c INNER JOIN call_paths p ON p.id = c.parent_id')
> -if perf_db_export_calls:
> -	do_query(query, 'CREATE VIEW calls_view AS '
> -		'SELECT '
> -			'calls.id,'
> -			'thread_id,'
> -			'(SELECT pid FROM threads WHERE id = thread_id) AS pid,'
> -			'(SELECT tid FROM threads WHERE id = thread_id) AS tid,'
> -			'(SELECT comm FROM comms WHERE id = comm_id) AS command,'
> -			'call_path_id,'
> -			+ emit_to_hex('ip') + ' AS ip,'
> -			'symbol_id,'
> -			'(SELECT name FROM symbols WHERE id = symbol_id) AS symbol,'
> -			'call_time,'
> -			'return_time,'
> -			'return_time - call_time AS elapsed_time,'
> -			'branch_count,'
> -			'insn_count,'
> -			'cyc_count,'
> -			'CASE WHEN cyc_count=0 THEN CAST(0 AS FLOAT) ELSE ROUND(CAST(insn_count AS FLOAT) / cyc_count, 2) END AS IPC,'
> -			'call_id,'
> -			'return_id,'
> -			'CASE WHEN flags=0 THEN \'\' WHEN flags=1 THEN \'no call\' WHEN flags=2 THEN \'no return\' WHEN flags=3 THEN \'no call/return\' WHEN flags=6 THEN \'jump\' ELSE flags END AS flags,'
> -			'parent_call_path_id,'
> -			'calls.parent_id'
> -		' FROM calls INNER JOIN call_paths ON call_paths.id = call_path_id')
> -
> -do_query(query, 'CREATE VIEW samples_view AS '
> -	'SELECT '
> -		'id,'
> -		'time,'
> -		'cpu,'
> -		'(SELECT pid FROM threads WHERE id = thread_id) AS pid,'
> -		'(SELECT tid FROM threads WHERE id = thread_id) AS tid,'
> -		'(SELECT comm FROM comms WHERE id = comm_id) AS command,'
> -		'(SELECT name FROM selected_events WHERE id = evsel_id) AS event,'
> -		+ emit_to_hex('ip') + ' AS ip_hex,'
> -		'(SELECT name FROM symbols WHERE id = symbol_id) AS symbol,'
> -		'sym_offset,'
> -		'(SELECT short_name FROM dsos WHERE id = dso_id) AS dso_short_name,'
> -		+ emit_to_hex('to_ip') + ' AS to_ip_hex,'
> -		'(SELECT name FROM symbols WHERE id = to_symbol_id) AS to_symbol,'
> -		'to_sym_offset,'
> -		'(SELECT short_name FROM dsos WHERE id = to_dso_id) AS to_dso_short_name,'
> -		'(SELECT name FROM branch_types WHERE id = branch_type) AS branch_type_name,'
> -		'in_tx,'
> -		'insn_count,'
> -		'cyc_count,'
> -		'CASE WHEN cyc_count=0 THEN CAST(0 AS FLOAT) ELSE ROUND(CAST(insn_count AS FLOAT) / cyc_count, 2) END AS IPC,'
> -		'flags'
> -	' FROM samples')
> -
> -do_query(query, 'CREATE VIEW ptwrite_view AS '
> -	'SELECT '
> -		'ptwrite.id,'
> -		'time,'
> -		'cpu,'
> -		+ emit_to_hex('payload') + ' AS payload_hex,'
> -		'CASE WHEN exact_ip=0 THEN \'False\' ELSE \'True\' END AS exact_ip'
> -	' FROM ptwrite'
> -	' INNER JOIN samples ON samples.id = ptwrite.id')
> -
> -do_query(query, 'CREATE VIEW cbr_view AS '
> -	'SELECT '
> -		'cbr.id,'
> -		'time,'
> -		'cpu,'
> -		'cbr,'
> -		'mhz,'
> -		'percent'
> -	' FROM cbr'
> -	' INNER JOIN samples ON samples.id = cbr.id')
> -
> -do_query(query, 'CREATE VIEW mwait_view AS '
> -	'SELECT '
> -		'mwait.id,'
> -		'time,'
> -		'cpu,'
> -		+ emit_to_hex('hints') + ' AS hints_hex,'
> -		+ emit_to_hex('extensions') + ' AS extensions_hex'
> -	' FROM mwait'
> -	' INNER JOIN samples ON samples.id = mwait.id')
> -
> -do_query(query, 'CREATE VIEW pwre_view AS '
> -	'SELECT '
> -		'pwre.id,'
> -		'time,'
> -		'cpu,'
> -		'cstate,'
> -		'subcstate,'
> -		'CASE WHEN hw=0 THEN \'False\' ELSE \'True\' END AS hw'
> -	' FROM pwre'
> -	' INNER JOIN samples ON samples.id = pwre.id')
> -
> -do_query(query, 'CREATE VIEW exstop_view AS '
> -	'SELECT '
> -		'exstop.id,'
> -		'time,'
> -		'cpu,'
> -		'CASE WHEN exact_ip=0 THEN \'False\' ELSE \'True\' END AS exact_ip'
> -	' FROM exstop'
> -	' INNER JOIN samples ON samples.id = exstop.id')
> -
> -do_query(query, 'CREATE VIEW pwrx_view AS '
> -	'SELECT '
> -		'pwrx.id,'
> -		'time,'
> -		'cpu,'
> -		'deepest_cstate,'
> -		'last_cstate,'
> -		'CASE     WHEN wake_reason=1 THEN \'Interrupt\''
> -			' WHEN wake_reason=2 THEN \'Timer Deadline\''
> -			' WHEN wake_reason=4 THEN \'Monitored Address\''
> -			' WHEN wake_reason=8 THEN \'HW\''
> -			' ELSE wake_reason '
> -		'END AS wake_reason'
> -	' FROM pwrx'
> -	' INNER JOIN samples ON samples.id = pwrx.id')
> -
> -do_query(query, 'CREATE VIEW power_events_view AS '
> -	'SELECT '
> -		'samples.id,'
> -		'time,'
> -		'cpu,'
> -		'selected_events.name AS event,'
> -		'CASE WHEN selected_events.name=\'cbr\' THEN (SELECT cbr FROM cbr WHERE cbr.id = samples.id) ELSE "" END AS cbr,'
> -		'CASE WHEN selected_events.name=\'cbr\' THEN (SELECT mhz FROM cbr WHERE cbr.id = samples.id) ELSE "" END AS mhz,'
> -		'CASE WHEN selected_events.name=\'cbr\' THEN (SELECT percent FROM cbr WHERE cbr.id = samples.id) ELSE "" END AS percent,'
> -		'CASE WHEN selected_events.name=\'mwait\' THEN (SELECT ' + emit_to_hex('hints') + ' FROM mwait WHERE mwait.id = samples.id) ELSE "" END AS hints_hex,'
> -		'CASE WHEN selected_events.name=\'mwait\' THEN (SELECT ' + emit_to_hex('extensions') + ' FROM mwait WHERE mwait.id = samples.id) ELSE "" END AS extensions_hex,'
> -		'CASE WHEN selected_events.name=\'pwre\' THEN (SELECT cstate FROM pwre WHERE pwre.id = samples.id) ELSE "" END AS cstate,'
> -		'CASE WHEN selected_events.name=\'pwre\' THEN (SELECT subcstate FROM pwre WHERE pwre.id = samples.id) ELSE "" END AS subcstate,'
> -		'CASE WHEN selected_events.name=\'pwre\' THEN (SELECT hw FROM pwre WHERE pwre.id = samples.id) ELSE "" END AS hw,'
> -		'CASE WHEN selected_events.name=\'exstop\' THEN (SELECT exact_ip FROM exstop WHERE exstop.id = samples.id) ELSE "" END AS exact_ip,'
> -		'CASE WHEN selected_events.name=\'pwrx\' THEN (SELECT deepest_cstate FROM pwrx WHERE pwrx.id = samples.id) ELSE "" END AS deepest_cstate,'
> -		'CASE WHEN selected_events.name=\'pwrx\' THEN (SELECT last_cstate FROM pwrx WHERE pwrx.id = samples.id) ELSE "" END AS last_cstate,'
> -		'CASE WHEN selected_events.name=\'pwrx\' THEN (SELECT '
> -			'CASE     WHEN wake_reason=1 THEN \'Interrupt\''
> -				' WHEN wake_reason=2 THEN \'Timer Deadline\''
> -				' WHEN wake_reason=4 THEN \'Monitored Address\''
> -				' WHEN wake_reason=8 THEN \'HW\''
> -				' ELSE wake_reason '
> -			'END'
> -		' FROM pwrx WHERE pwrx.id = samples.id) ELSE "" END AS wake_reason'
> -	' FROM samples'
> -	' INNER JOIN selected_events ON selected_events.id = evsel_id'
> -	' WHERE selected_events.name IN (\'cbr\',\'mwait\',\'exstop\',\'pwre\',\'pwrx\')')
> -
> -do_query(query, 'CREATE VIEW context_switches_view AS '
> -	'SELECT '
> -		'context_switches.id,'
> -		'context_switches.machine_id,'
> -		'context_switches.time,'
> -		'context_switches.cpu,'
> -		'th_out.pid AS pid_out,'
> -		'th_out.tid AS tid_out,'
> -		'comm_out.comm AS comm_out,'
> -		'th_in.pid AS pid_in,'
> -		'th_in.tid AS tid_in,'
> -		'comm_in.comm AS comm_in,'
> -		'CASE	  WHEN context_switches.flags = 0 THEN \'in\''
> -			' WHEN context_switches.flags = 1 THEN \'out\''
> -			' WHEN context_switches.flags = 3 THEN \'out preempt\''
> -			' ELSE context_switches.flags '
> -		'END AS flags'
> -	' FROM context_switches'
> -	' INNER JOIN threads AS th_out ON th_out.id   = context_switches.thread_out_id'
> -	' INNER JOIN threads AS th_in  ON th_in.id    = context_switches.thread_in_id'
> -	' INNER JOIN comms AS comm_out ON comm_out.id = context_switches.comm_out_id'
> -	' INNER JOIN comms AS comm_in  ON comm_in.id  = context_switches.comm_in_id')
> -
> -do_query(query, 'END TRANSACTION')
> -
> -evsel_query = QSqlQuery(db)
> -evsel_query.prepare("INSERT INTO selected_events VALUES (?, ?)")
> -machine_query = QSqlQuery(db)
> -machine_query.prepare("INSERT INTO machines VALUES (?, ?, ?)")
> -thread_query = QSqlQuery(db)
> -thread_query.prepare("INSERT INTO threads VALUES (?, ?, ?, ?, ?)")
> -comm_query = QSqlQuery(db)
> -comm_query.prepare("INSERT INTO comms VALUES (?, ?, ?, ?, ?)")
> -comm_thread_query = QSqlQuery(db)
> -comm_thread_query.prepare("INSERT INTO comm_threads VALUES (?, ?, ?)")
> -dso_query = QSqlQuery(db)
> -dso_query.prepare("INSERT INTO dsos VALUES (?, ?, ?, ?, ?)")
> -symbol_query = QSqlQuery(db)
> -symbol_query.prepare("INSERT INTO symbols VALUES (?, ?, ?, ?, ?, ?)")
> -branch_type_query = QSqlQuery(db)
> -branch_type_query.prepare("INSERT INTO branch_types VALUES (?, ?)")
> -sample_query = QSqlQuery(db)
> -if branches:
> -	sample_query.prepare("INSERT INTO samples VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
> -else:
> -	sample_query.prepare("INSERT INTO samples VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
> -if perf_db_export_calls or perf_db_export_callchains:
> -	call_path_query = QSqlQuery(db)
> -	call_path_query.prepare("INSERT INTO call_paths VALUES (?, ?, ?, ?)")
> -if perf_db_export_calls:
> -	call_query = QSqlQuery(db)
> -	call_query.prepare("INSERT INTO calls VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
> -ptwrite_query = QSqlQuery(db)
> -ptwrite_query.prepare("INSERT INTO ptwrite VALUES (?, ?, ?)")
> -cbr_query = QSqlQuery(db)
> -cbr_query.prepare("INSERT INTO cbr VALUES (?, ?, ?, ?)")
> -mwait_query = QSqlQuery(db)
> -mwait_query.prepare("INSERT INTO mwait VALUES (?, ?, ?)")
> -pwre_query = QSqlQuery(db)
> -pwre_query.prepare("INSERT INTO pwre VALUES (?, ?, ?, ?)")
> -exstop_query = QSqlQuery(db)
> -exstop_query.prepare("INSERT INTO exstop VALUES (?, ?)")
> -pwrx_query = QSqlQuery(db)
> -pwrx_query.prepare("INSERT INTO pwrx VALUES (?, ?, ?, ?)")
> -context_switch_query = QSqlQuery(db)
> -context_switch_query.prepare("INSERT INTO context_switches VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)")
> -
> -def trace_begin():
> -	printdate("Writing records...")
> -	do_query(query, 'BEGIN TRANSACTION')
> -	# id == 0 means unknown.  It is easier to create records for them than replace the zeroes with NULLs
> -	evsel_table(0, "unknown")
> -	machine_table(0, 0, "unknown")
> -	thread_table(0, 0, 0, -1, -1)
> -	comm_table(0, "unknown", 0, 0, 0)
> -	dso_table(0, 0, "unknown", "unknown", "")
> -	symbol_table(0, 0, 0, 0, 0, "unknown")
> -	sample_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
> -	if perf_db_export_calls or perf_db_export_callchains:
> -		call_path_table(0, 0, 0, 0)
> -		call_return_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
> -
> -unhandled_count = 0
> -
> -def is_table_empty(table_name):
> -	do_query(query, 'SELECT * FROM ' + table_name + ' LIMIT 1');
> -	if query.next():
> -		return False
> -	return True
> -
> -def drop(table_name):
> -	do_query(query, 'DROP VIEW ' + table_name + '_view');
> -	do_query(query, 'DROP TABLE ' + table_name);
> -
> -def trace_end():
> -	do_query(query, 'END TRANSACTION')
> -
> -	printdate("Adding indexes")
> -	if perf_db_export_calls:
> -		do_query(query, 'CREATE INDEX pcpid_idx ON calls (parent_call_path_id)')
> -		do_query(query, 'CREATE INDEX pid_idx ON calls (parent_id)')
> -		do_query(query, 'ALTER TABLE comms ADD has_calls boolean')
> -		do_query(query, 'UPDATE comms SET has_calls = 1 WHERE comms.id IN (SELECT DISTINCT comm_id FROM calls)')
> -
> -	printdate("Dropping unused tables")
> -	if is_table_empty("ptwrite"):
> -		drop("ptwrite")
> -	if is_table_empty("mwait") and is_table_empty("pwre") and is_table_empty("exstop") and is_table_empty("pwrx"):
> -		do_query(query, 'DROP VIEW power_events_view');
> -		drop("mwait")
> -		drop("pwre")
> -		drop("exstop")
> -		drop("pwrx")
> -		if is_table_empty("cbr"):
> -			drop("cbr")
> -	if is_table_empty("context_switches"):
> -		drop("context_switches")
> -
> -	if (unhandled_count):
> -		printdate("Warning: ", unhandled_count, " unhandled events")
> -	printdate("Done")
> -
> -def trace_unhandled(event_name, context, event_fields_dict):
> -	global unhandled_count
> -	unhandled_count += 1
> -
> -def sched__sched_switch(*x):
> -	pass
> -
> -def bind_exec(q, n, x):
> -	for xx in x[0:n]:
> -		q.addBindValue(str(xx))
> -	do_query_(q)
> -
> -def evsel_table(*x):
> -	bind_exec(evsel_query, 2, x)
> -
> -def machine_table(*x):
> -	bind_exec(machine_query, 3, x)
> -
> -def thread_table(*x):
> -	bind_exec(thread_query, 5, x)
> -
> -def comm_table(*x):
> -	bind_exec(comm_query, 5, x)
> -
> -def comm_thread_table(*x):
> -	bind_exec(comm_thread_query, 3, x)
> -
> -def dso_table(*x):
> -	bind_exec(dso_query, 5, x)
> -
> -def symbol_table(*x):
> -	bind_exec(symbol_query, 6, x)
> -
> -def branch_type_table(*x):
> -	bind_exec(branch_type_query, 2, x)
> -
> -def sample_table(*x):
> -	if branches:
> -		for xx in x[0:15]:
> -			sample_query.addBindValue(str(xx))
> -		for xx in x[19:25]:
> -			sample_query.addBindValue(str(xx))
> -		do_query_(sample_query)
> -	else:
> -		bind_exec(sample_query, 25, x)
> -
> -def call_path_table(*x):
> -	bind_exec(call_path_query, 4, x)
> -
> -def call_return_table(*x):
> -	bind_exec(call_query, 14, x)
> -
> -def ptwrite(id, raw_buf):
> -	data = struct.unpack_from("<IQ", raw_buf)
> -	flags = data[0]
> -	payload = data[1]
> -	exact_ip = flags & 1
> -	ptwrite_query.addBindValue(str(id))
> -	ptwrite_query.addBindValue(str(payload))
> -	ptwrite_query.addBindValue(str(exact_ip))
> -	do_query_(ptwrite_query)
> -
> -def cbr(id, raw_buf):
> -	data = struct.unpack_from("<BBBBII", raw_buf)
> -	cbr = data[0]
> -	MHz = (data[4] + 500) / 1000
> -	percent = ((cbr * 1000 / data[2]) + 5) / 10
> -	cbr_query.addBindValue(str(id))
> -	cbr_query.addBindValue(str(cbr))
> -	cbr_query.addBindValue(str(MHz))
> -	cbr_query.addBindValue(str(percent))
> -	do_query_(cbr_query)
> -
> -def mwait(id, raw_buf):
> -	data = struct.unpack_from("<IQ", raw_buf)
> -	payload = data[1]
> -	hints = payload & 0xff
> -	extensions = (payload >> 32) & 0x3
> -	mwait_query.addBindValue(str(id))
> -	mwait_query.addBindValue(str(hints))
> -	mwait_query.addBindValue(str(extensions))
> -	do_query_(mwait_query)
> -
> -def pwre(id, raw_buf):
> -	data = struct.unpack_from("<IQ", raw_buf)
> -	payload = data[1]
> -	hw = (payload >> 7) & 1
> -	cstate = (payload >> 12) & 0xf
> -	subcstate = (payload >> 8) & 0xf
> -	pwre_query.addBindValue(str(id))
> -	pwre_query.addBindValue(str(cstate))
> -	pwre_query.addBindValue(str(subcstate))
> -	pwre_query.addBindValue(str(hw))
> -	do_query_(pwre_query)
> -
> -def exstop(id, raw_buf):
> -	data = struct.unpack_from("<I", raw_buf)
> -	flags = data[0]
> -	exact_ip = flags & 1
> -	exstop_query.addBindValue(str(id))
> -	exstop_query.addBindValue(str(exact_ip))
> -	do_query_(exstop_query)
> -
> -def pwrx(id, raw_buf):
> -	data = struct.unpack_from("<IQ", raw_buf)
> -	payload = data[1]
> -	deepest_cstate = payload & 0xf
> -	last_cstate = (payload >> 4) & 0xf
> -	wake_reason = (payload >> 8) & 0xf
> -	pwrx_query.addBindValue(str(id))
> -	pwrx_query.addBindValue(str(deepest_cstate))
> -	pwrx_query.addBindValue(str(last_cstate))
> -	pwrx_query.addBindValue(str(wake_reason))
> -	do_query_(pwrx_query)
> -
> -def synth_data(id, config, raw_buf, *x):
> -	if config == 0:
> -		ptwrite(id, raw_buf)
> -	elif config == 1:
> -		mwait(id, raw_buf)
> -	elif config == 2:
> -		pwre(id, raw_buf)
> -	elif config == 3:
> -		exstop(id, raw_buf)
> -	elif config == 4:
> -		pwrx(id, raw_buf)
> -	elif config == 5:
> -		cbr(id, raw_buf)
> -
> -def context_switch_table(*x):
> -	bind_exec(context_switch_query, 9, x)
> diff --git a/tools/perf/scripts/python/failed-syscalls-by-pid.py b/tools/perf/scripts/python/failed-syscalls-by-pid.py
> deleted file mode 100644
> index 310efe5e7e23..000000000000
> --- a/tools/perf/scripts/python/failed-syscalls-by-pid.py
> +++ /dev/null
> @@ -1,79 +0,0 @@
> -# failed system call counts, by pid
> -# (c) 2010, Tom Zanussi <tzanussi@gmail.com>
> -# Licensed under the terms of the GNU GPL License version 2
> -#
> -# Displays system-wide failed system call totals, broken down by pid.
> -# If a [comm] arg is specified, only syscalls called by [comm] are displayed.
> -
> -from __future__ import print_function
> -
> -import os
> -import sys
> -
> -sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> -	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> -
> -from perf_trace_context import *
> -from Core import *
> -from Util import *
> -
> -usage = "perf script -s syscall-counts-by-pid.py [comm|pid]\n";
> -
> -for_comm = None
> -for_pid = None
> -
> -if len(sys.argv) > 2:
> -	sys.exit(usage)
> -
> -if len(sys.argv) > 1:
> -	try:
> -		for_pid = int(sys.argv[1])
> -	except:
> -		for_comm = sys.argv[1]
> -
> -syscalls = autodict()
> -
> -def trace_begin():
> -	print("Press control+C to stop and show the summary")
> -
> -def trace_end():
> -	print_error_totals()
> -
> -def raw_syscalls__sys_exit(event_name, context, common_cpu,
> -	common_secs, common_nsecs, common_pid, common_comm,
> -	common_callchain, id, ret):
> -	if (for_comm and common_comm != for_comm) or \
> -	   (for_pid  and common_pid  != for_pid ):
> -		return
> -
> -	if ret < 0:
> -		try:
> -			syscalls[common_comm][common_pid][id][ret] += 1
> -		except TypeError:
> -			syscalls[common_comm][common_pid][id][ret] = 1
> -
> -def syscalls__sys_exit(event_name, context, common_cpu,
> -	common_secs, common_nsecs, common_pid, common_comm,
> -	id, ret):
> -	raw_syscalls__sys_exit(**locals())
> -
> -def print_error_totals():
> -	if for_comm is not None:
> -		print("\nsyscall errors for %s:\n" % (for_comm))
> -	else:
> -		print("\nsyscall errors:\n")
> -
> -	print("%-30s  %10s" % ("comm [pid]", "count"))
> -	print("%-30s  %10s" % ("------------------------------", "----------"))
> -
> -	comm_keys = syscalls.keys()
> -	for comm in comm_keys:
> -		pid_keys = syscalls[comm].keys()
> -		for pid in pid_keys:
> -			print("\n%s [%d]" % (comm, pid))
> -			id_keys = syscalls[comm][pid].keys()
> -			for id in id_keys:
> -				print("  syscall: %-16s" % syscall_name(id))
> -				ret_keys = syscalls[comm][pid][id].keys()
> -				for ret, val in sorted(syscalls[comm][pid][id].items(), key = lambda kv: (kv[1], kv[0]), reverse = True):
> -					print("    err = %-20s  %10d" % (strerror(ret), val))
> diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
> deleted file mode 100755
> index ad735990c5be..000000000000
> --- a/tools/perf/scripts/python/flamegraph.py
> +++ /dev/null
> @@ -1,267 +0,0 @@
> -# flamegraph.py - create flame graphs from perf samples
> -# SPDX-License-Identifier: GPL-2.0
> -#
> -# Usage:
> -#
> -#     perf record -a -g -F 99 sleep 60
> -#     perf script report flamegraph
> -#
> -# Combined:
> -#
> -#     perf script flamegraph -a -F 99 sleep 60
> -#
> -# Written by Andreas Gerstmayr <agerstmayr@redhat.com>
> -# Flame Graphs invented by Brendan Gregg <bgregg@netflix.com>
> -# Works in tandem with d3-flame-graph by Martin Spier <mspier@netflix.com>
> -#
> -# pylint: disable=missing-module-docstring
> -# pylint: disable=missing-class-docstring
> -# pylint: disable=missing-function-docstring
> -
> -import argparse
> -import hashlib
> -import io
> -import json
> -import os
> -import subprocess
> -import sys
> -from typing import Dict, Optional, Union
> -import urllib.request
> -
> -MINIMAL_HTML = """<head>
> -  <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.css">
> -</head>
> -<body>
> -  <div id="chart"></div>
> -  <script type="text/javascript" src="https://d3js.org/d3.v7.js"></script>
> -  <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.min.js"></script>
> -  <script type="text/javascript">
> -  const stacks = [/** @flamegraph_json **/];
> -  // Note, options is unused.
> -  const options = [/** @options_json **/];
> -
> -  var chart = flamegraph();
> -  d3.select("#chart")
> -        .datum(stacks[0])
> -        .call(chart);
> -  </script>
> -</body>
> -"""
> -
> -# pylint: disable=too-few-public-methods
> -class Node:
> -    def __init__(self, name: str, libtype: str):
> -        self.name = name
> -        # "root" | "kernel" | ""
> -        # "" indicates user space
> -        self.libtype = libtype
> -        self.value: int = 0
> -        self.children: list[Node] = []
> -
> -    def to_json(self) -> Dict[str, Union[str, int, list[Dict]]]:
> -        return {
> -            "n": self.name,
> -            "l": self.libtype,
> -            "v": self.value,
> -            "c": [x.to_json() for x in self.children]
> -        }
> -
> -
> -class FlameGraphCLI:
> -    def __init__(self, args):
> -        self.args = args
> -        self.stack = Node("all", "root")
> -
> -    @staticmethod
> -    def get_libtype_from_dso(dso: Optional[str]) -> str:
> -        """
> -        when kernel-debuginfo is installed,
> -        dso points to /usr/lib/debug/lib/modules/*/vmlinux
> -        """
> -        if dso and (dso == "[kernel.kallsyms]" or dso.endswith("/vmlinux")):
> -            return "kernel"
> -
> -        return ""
> -
> -    @staticmethod
> -    def find_or_create_node(node: Node, name: str, libtype: str) -> Node:
> -        for child in node.children:
> -            if child.name == name:
> -                return child
> -
> -        child = Node(name, libtype)
> -        node.children.append(child)
> -        return child
> -
> -    def process_event(self, event) -> None:
> -        # ignore events where the event name does not match
> -        # the one specified by the user
> -        if self.args.event_name and event.get("ev_name") != self.args.event_name:
> -            return
> -
> -        pid = event.get("sample", {}).get("pid", 0)
> -        # event["dso"] sometimes contains /usr/lib/debug/lib/modules/*/vmlinux
> -        # for user-space processes; let's use pid for kernel or user-space distinction
> -        if pid == 0:
> -            comm = event["comm"]
> -            libtype = "kernel"
> -        else:
> -            comm = f"{event['comm']} ({pid})"
> -            libtype = ""
> -        node = self.find_or_create_node(self.stack, comm, libtype)
> -
> -        if "callchain" in event:
> -            for entry in reversed(event["callchain"]):
> -                name = entry.get("sym", {}).get("name", "[unknown]")
> -                libtype = self.get_libtype_from_dso(entry.get("dso"))
> -                node = self.find_or_create_node(node, name, libtype)
> -        else:
> -            name = event.get("symbol", "[unknown]")
> -            libtype = self.get_libtype_from_dso(event.get("dso"))
> -            node = self.find_or_create_node(node, name, libtype)
> -        node.value += 1
> -
> -    def get_report_header(self) -> str:
> -        if self.args.input == "-":
> -            # when this script is invoked with "perf script flamegraph",
> -            # no perf.data is created and we cannot read the header of it
> -            return ""
> -
> -        try:
> -            # if the file name other than perf.data is given,
> -            # we read the header of that file
> -            if self.args.input:
> -                output = subprocess.check_output(["perf", "report", "--header-only",
> -                                                  "-i", self.args.input])
> -            else:
> -                output = subprocess.check_output(["perf", "report", "--header-only"])
> -
> -            result = output.decode("utf-8")
> -            if self.args.event_name:
> -                result += "\nFocused event: " + self.args.event_name
> -            return result
> -        except Exception as err:  # pylint: disable=broad-except
> -            print(f"Error reading report header: {err}", file=sys.stderr)
> -            return ""
> -
> -    def trace_end(self) -> None:
> -        stacks_json = json.dumps(self.stack, default=lambda x: x.to_json())
> -
> -        if self.args.format == "html":
> -            report_header = self.get_report_header()
> -            options = {
> -                "colorscheme": self.args.colorscheme,
> -                "context": report_header
> -            }
> -            options_json = json.dumps(options)
> -
> -            template_md5sum = None
> -            if self.args.format == "html":
> -                if os.path.isfile(self.args.template):
> -                    template = f"file://{self.args.template}"
> -                else:
> -                    if not self.args.allow_download:
> -                        print(f"""Warning: Flame Graph template '{self.args.template}'
> -does not exist. To avoid this please install a package such as the
> -js-d3-flame-graph or libjs-d3-flame-graph, specify an existing flame
> -graph template (--template PATH) or use another output format (--format
> -FORMAT).""",
> -                              file=sys.stderr)
> -                        if self.args.input == "-":
> -                            print(
> -"""Not attempting to download Flame Graph template as script command line
> -input is disabled due to using live mode. If you want to download the
> -template retry without live mode. For example, use 'perf record -a -g
> --F 99 sleep 60' and 'perf script report flamegraph'. Alternatively,
> -download the template from:
> -https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/d3-flamegraph-base.html
> -and place it at:
> -/usr/share/d3-flame-graph/d3-flamegraph-base.html""",
> -                                  file=sys.stderr)
> -                            sys.exit(1)
> -                        s = None
> -                        while s not in ["y", "n"]:
> -                            s = input("Do you wish to download a template from cdn.jsdelivr.net?" +
> -                                      "(this warning can be suppressed with --allow-download) [yn] "
> -                                      ).lower()
> -                        if s == "n":
> -                            sys.exit(1)
> -                    template = ("https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/"
> -                                "d3-flamegraph-base.html")
> -                    template_md5sum = "143e0d06ba69b8370b9848dcd6ae3f36"
> -
> -            try:
> -                with urllib.request.urlopen(template) as url_template:
> -                    output_str = "".join([
> -                        l.decode("utf-8") for l in url_template.readlines()
> -                    ])
> -            except Exception as err:
> -                print(f"Error reading template {template}: {err}\n"
> -                      "a minimal flame graph will be generated", file=sys.stderr)
> -                output_str = MINIMAL_HTML
> -                template_md5sum = None
> -
> -            if template_md5sum:
> -                download_md5sum = hashlib.md5(output_str.encode("utf-8")).hexdigest()
> -                if download_md5sum != template_md5sum:
> -                    s = None
> -                    while s not in ["y", "n"]:
> -                        s = input(f"""Unexpected template md5sum.
> -{download_md5sum} != {template_md5sum}, for:
> -{output_str}
> -continue?[yn] """).lower()
> -                    if s == "n":
> -                        sys.exit(1)
> -
> -            output_str = output_str.replace("/** @options_json **/", options_json)
> -            output_str = output_str.replace("/** @flamegraph_json **/", stacks_json)
> -
> -            output_fn = self.args.output or "flamegraph.html"
> -        else:
> -            output_str = stacks_json
> -            output_fn = self.args.output or "stacks.json"
> -
> -        if output_fn == "-":
> -            with io.open(sys.stdout.fileno(), "w", encoding="utf-8", closefd=False) as out:
> -                out.write(output_str)
> -        else:
> -            print(f"dumping data to {output_fn}")
> -            try:
> -                with io.open(output_fn, "w", encoding="utf-8") as out:
> -                    out.write(output_str)
> -            except IOError as err:
> -                print(f"Error writing output file: {err}", file=sys.stderr)
> -                sys.exit(1)
> -
> -
> -if __name__ == "__main__":
> -    parser = argparse.ArgumentParser(description="Create flame graphs.")
> -    parser.add_argument("-f", "--format",
> -                        default="html", choices=["json", "html"],
> -                        help="output file format")
> -    parser.add_argument("-o", "--output",
> -                        help="output file name")
> -    parser.add_argument("--template",
> -                        default="/usr/share/d3-flame-graph/d3-flamegraph-base.html",
> -                        help="path to flame graph HTML template")
> -    parser.add_argument("--colorscheme",
> -                        default="blue-green",
> -                        help="flame graph color scheme",
> -                        choices=["blue-green", "orange"])
> -    parser.add_argument("-i", "--input",
> -                        help=argparse.SUPPRESS)
> -    parser.add_argument("--allow-download",
> -                        default=False,
> -                        action="store_true",
> -                        help="allow unprompted downloading of HTML template")
> -    parser.add_argument("-e", "--event",
> -                        default="",
> -                        dest="event_name",
> -                        type=str,
> -                        help="specify the event to generate flamegraph for")
> -
> -    cli_args = parser.parse_args()
> -    cli = FlameGraphCLI(cli_args)
> -
> -    process_event = cli.process_event
> -    trace_end = cli.trace_end
> diff --git a/tools/perf/scripts/python/futex-contention.py b/tools/perf/scripts/python/futex-contention.py
> deleted file mode 100644
> index 7e884d46f920..000000000000
> --- a/tools/perf/scripts/python/futex-contention.py
> +++ /dev/null
> @@ -1,57 +0,0 @@
> -# futex contention
> -# (c) 2010, Arnaldo Carvalho de Melo <acme@redhat.com>
> -# Licensed under the terms of the GNU GPL License version 2
> -#
> -# Translation of:
> -#
> -# http://sourceware.org/systemtap/wiki/WSFutexContention
> -#
> -# to perf python scripting.
> -#
> -# Measures futex contention
> -
> -from __future__ import print_function
> -
> -import os
> -import sys
> -sys.path.append(os.environ['PERF_EXEC_PATH'] +
> -                '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> -from Util import *
> -
> -process_names = {}
> -thread_thislock = {}
> -thread_blocktime = {}
> -
> -lock_waits = {}  # long-lived stats on (tid,lock) blockage elapsed time
> -process_names = {}  # long-lived pid-to-execname mapping
> -
> -
> -def syscalls__sys_enter_futex(event, ctxt, cpu, s, ns, tid, comm, callchain,
> -                              nr, uaddr, op, val, utime, uaddr2, val3):
> -    cmd = op & FUTEX_CMD_MASK
> -    if cmd != FUTEX_WAIT:
> -        return  # we don't care about originators of WAKE events
> -
> -    process_names[tid] = comm
> -    thread_thislock[tid] = uaddr
> -    thread_blocktime[tid] = nsecs(s, ns)
> -
> -
> -def syscalls__sys_exit_futex(event, ctxt, cpu, s, ns, tid, comm, callchain,
> -                             nr, ret):
> -    if tid in thread_blocktime:
> -        elapsed = nsecs(s, ns) - thread_blocktime[tid]
> -        add_stats(lock_waits, (tid, thread_thislock[tid]), elapsed)
> -        del thread_blocktime[tid]
> -        del thread_thislock[tid]
> -
> -
> -def trace_begin():
> -    print("Press control+C to stop and show the summary")
> -
> -
> -def trace_end():
> -    for (tid, lock) in lock_waits:
> -        min, max, avg, count = lock_waits[tid, lock]
> -        print("%s[%d] lock %x contended %d times, %d avg ns [max: %d ns, min %d ns]" %
> -              (process_names[tid], tid, lock, count, avg, max, min))
> diff --git a/tools/perf/scripts/python/gecko.py b/tools/perf/scripts/python/gecko.py
> deleted file mode 100644
> index bc5a72f94bfa..000000000000
> --- a/tools/perf/scripts/python/gecko.py
> +++ /dev/null
> @@ -1,395 +0,0 @@
> -# gecko.py - Convert perf record output to Firefox's gecko profile format
> -# SPDX-License-Identifier: GPL-2.0
> -#
> -# The script converts perf.data to Gecko Profile Format,
> -# which can be read by https://profiler.firefox.com/.
> -#
> -# Usage:
> -#
> -#     perf record -a -g -F 99 sleep 60
> -#     perf script report gecko
> -#
> -# Combined:
> -#
> -#     perf script gecko -F 99 -a sleep 60
> -
> -import os
> -import sys
> -import time
> -import json
> -import string
> -import random
> -import argparse
> -import threading
> -import webbrowser
> -import urllib.parse
> -from os import system
> -from functools import reduce
> -from dataclasses import dataclass, field
> -from http.server import HTTPServer, SimpleHTTPRequestHandler, test
> -from typing import List, Dict, Optional, NamedTuple, Set, Tuple, Any
> -
> -# Add the Perf-Trace-Util library to the Python path
> -sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> -	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> -
> -from perf_trace_context import *
> -from Core import *
> -
> -StringID = int
> -StackID = int
> -FrameID = int
> -CategoryID = int
> -Milliseconds = float
> -
> -# start_time is intialiazed only once for the all event traces.
> -start_time = None
> -
> -# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/profile.js#L425
> -# Follow Brendan Gregg's Flamegraph convention: orange for kernel and yellow for user space by default.
> -CATEGORIES = None
> -
> -# The product name is used by the profiler UI to show the Operating system and Processor.
> -PRODUCT = os.popen('uname -op').read().strip()
> -
> -# store the output file
> -output_file = None
> -
> -# Here key = tid, value = Thread
> -tid_to_thread = dict()
> -
> -# The HTTP server is used to serve the profile to the profiler UI.
> -http_server_thread = None
> -
> -# The category index is used by the profiler UI to show the color of the flame graph.
> -USER_CATEGORY_INDEX = 0
> -KERNEL_CATEGORY_INDEX = 1
> -
> -# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L156
> -class Frame(NamedTuple):
> -	string_id: StringID
> -	relevantForJS: bool
> -	innerWindowID: int
> -	implementation: None
> -	optimizations: None
> -	line: None
> -	column: None
> -	category: CategoryID
> -	subcategory: int
> -
> -# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L216
> -class Stack(NamedTuple):
> -	prefix_id: Optional[StackID]
> -	frame_id: FrameID
> -
> -# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L90
> -class Sample(NamedTuple):
> -	stack_id: Optional[StackID]
> -	time_ms: Milliseconds
> -	responsiveness: int
> -
> -@dataclass
> -class Thread:
> -	"""A builder for a profile of the thread.
> -
> -	Attributes:
> -		comm: Thread command-line (name).
> -		pid: process ID of containing process.
> -		tid: thread ID.
> -		samples: Timeline of profile samples.
> -		frameTable: interned stack frame ID -> stack frame.
> -		stringTable: interned string ID -> string.
> -		stringMap: interned string -> string ID.
> -		stackTable: interned stack ID -> stack.
> -		stackMap: (stack prefix ID, leaf stack frame ID) -> interned Stack ID.
> -		frameMap: Stack Frame string -> interned Frame ID.
> -		comm: str
> -		pid: int
> -		tid: int
> -		samples: List[Sample] = field(default_factory=list)
> -		frameTable: List[Frame] = field(default_factory=list)
> -		stringTable: List[str] = field(default_factory=list)
> -		stringMap: Dict[str, int] = field(default_factory=dict)
> -		stackTable: List[Stack] = field(default_factory=list)
> -		stackMap: Dict[Tuple[Optional[int], int], int] = field(default_factory=dict)
> -		frameMap: Dict[str, int] = field(default_factory=dict)
> -	"""
> -	comm: str
> -	pid: int
> -	tid: int
> -	samples: List[Sample] = field(default_factory=list)
> -	frameTable: List[Frame] = field(default_factory=list)
> -	stringTable: List[str] = field(default_factory=list)
> -	stringMap: Dict[str, int] = field(default_factory=dict)
> -	stackTable: List[Stack] = field(default_factory=list)
> -	stackMap: Dict[Tuple[Optional[int], int], int] = field(default_factory=dict)
> -	frameMap: Dict[str, int] = field(default_factory=dict)
> -
> -	def _intern_stack(self, frame_id: int, prefix_id: Optional[int]) -> int:
> -		"""Gets a matching stack, or saves the new stack. Returns a Stack ID."""
> -		key = f"{frame_id}" if prefix_id is None else f"{frame_id},{prefix_id}"
> -		# key = (prefix_id, frame_id)
> -		stack_id = self.stackMap.get(key)
> -		if stack_id is None:
> -			# return stack_id
> -			stack_id = len(self.stackTable)
> -			self.stackTable.append(Stack(prefix_id=prefix_id, frame_id=frame_id))
> -			self.stackMap[key] = stack_id
> -		return stack_id
> -
> -	def _intern_string(self, string: str) -> int:
> -		"""Gets a matching string, or saves the new string. Returns a String ID."""
> -		string_id = self.stringMap.get(string)
> -		if string_id is not None:
> -			return string_id
> -		string_id = len(self.stringTable)
> -		self.stringTable.append(string)
> -		self.stringMap[string] = string_id
> -		return string_id
> -
> -	def _intern_frame(self, frame_str: str) -> int:
> -		"""Gets a matching stack frame, or saves the new frame. Returns a Frame ID."""
> -		frame_id = self.frameMap.get(frame_str)
> -		if frame_id is not None:
> -			return frame_id
> -		frame_id = len(self.frameTable)
> -		self.frameMap[frame_str] = frame_id
> -		string_id = self._intern_string(frame_str)
> -
> -		symbol_name_to_category = KERNEL_CATEGORY_INDEX if frame_str.find('kallsyms') != -1 \
> -		or frame_str.find('/vmlinux') != -1 \
> -		or frame_str.endswith('.ko)') \
> -		else USER_CATEGORY_INDEX
> -
> -		self.frameTable.append(Frame(
> -			string_id=string_id,
> -			relevantForJS=False,
> -			innerWindowID=0,
> -			implementation=None,
> -			optimizations=None,
> -			line=None,
> -			column=None,
> -			category=symbol_name_to_category,
> -			subcategory=None,
> -		))
> -		return frame_id
> -
> -	def _add_sample(self, comm: str, stack: List[str], time_ms: Milliseconds) -> None:
> -		"""Add a timestamped stack trace sample to the thread builder.
> -		Args:
> -			comm: command-line (name) of the thread at this sample
> -			stack: sampled stack frames. Root first, leaf last.
> -			time_ms: timestamp of sample in milliseconds.
> -		"""
> -		# Ihreads may not set their names right after they are created.
> -		# Instead, they might do it later. In such situations, to use the latest name they have set.
> -		if self.comm != comm:
> -			self.comm = comm
> -
> -		prefix_stack_id = reduce(lambda prefix_id, frame: self._intern_stack
> -						(self._intern_frame(frame), prefix_id), stack, None)
> -		if prefix_stack_id is not None:
> -			self.samples.append(Sample(stack_id=prefix_stack_id,
> -									time_ms=time_ms,
> -									responsiveness=0))
> -
> -	def _to_json_dict(self) -> Dict:
> -		"""Converts current Thread to GeckoThread JSON format."""
> -		# Gecko profile format is row-oriented data as List[List],
> -		# And a schema for interpreting each index.
> -		# Schema:
> -		# https://github.com/firefox-devtools/profiler/blob/main/docs-developer/gecko-profile-format.md
> -		# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L230
> -		return {
> -			"tid": self.tid,
> -			"pid": self.pid,
> -			"name": self.comm,
> -			# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L51
> -			"markers": {
> -				"schema": {
> -					"name": 0,
> -					"startTime": 1,
> -					"endTime": 2,
> -					"phase": 3,
> -					"category": 4,
> -					"data": 5,
> -				},
> -				"data": [],
> -			},
> -
> -			# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L90
> -			"samples": {
> -				"schema": {
> -					"stack": 0,
> -					"time": 1,
> -					"responsiveness": 2,
> -				},
> -				"data": self.samples
> -			},
> -
> -			# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L156
> -			"frameTable": {
> -				"schema": {
> -					"location": 0,
> -					"relevantForJS": 1,
> -					"innerWindowID": 2,
> -					"implementation": 3,
> -					"optimizations": 4,
> -					"line": 5,
> -					"column": 6,
> -					"category": 7,
> -					"subcategory": 8,
> -				},
> -				"data": self.frameTable,
> -			},
> -
> -			# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L216
> -			"stackTable": {
> -				"schema": {
> -					"prefix": 0,
> -					"frame": 1,
> -				},
> -				"data": self.stackTable,
> -			},
> -			"stringTable": self.stringTable,
> -			"registerTime": 0,
> -			"unregisterTime": None,
> -			"processType": "default",
> -		}
> -
> -# Uses perf script python interface to parse each
> -# event and store the data in the thread builder.
> -def process_event(param_dict: Dict) -> None:
> -	global start_time
> -	global tid_to_thread
> -	time_stamp = (param_dict['sample']['time'] // 1000) / 1000
> -	pid = param_dict['sample']['pid']
> -	tid = param_dict['sample']['tid']
> -	comm = param_dict['comm']
> -
> -	# Start time is the time of the first sample
> -	if not start_time:
> -		start_time = time_stamp
> -
> -	# Parse and append the callchain of the current sample into a stack.
> -	stack = []
> -	if param_dict['callchain']:
> -		for call in param_dict['callchain']:
> -			if 'sym' not in call:
> -				continue
> -			stack.append(f'{call["sym"]["name"]} (in {call["dso"]})')
> -		if len(stack) != 0:
> -			# Reverse the stack, as root come first and the leaf at the end.
> -			stack = stack[::-1]
> -
> -	# During perf record if -g is not used, the callchain is not available.
> -	# In that case, the symbol and dso are available in the event parameters.
> -	else:
> -		func = param_dict['symbol'] if 'symbol' in param_dict else '[unknown]'
> -		dso = param_dict['dso'] if 'dso' in param_dict else '[unknown]'
> -		stack.append(f'{func} (in {dso})')
> -
> -	# Add sample to the specific thread.
> -	thread = tid_to_thread.get(tid)
> -	if thread is None:
> -		thread = Thread(comm=comm, pid=pid, tid=tid)
> -		tid_to_thread[tid] = thread
> -	thread._add_sample(comm=comm, stack=stack, time_ms=time_stamp)
> -
> -def trace_begin() -> None:
> -	global output_file
> -	if (output_file is None):
> -		print("Staring Firefox Profiler on your default browser...")
> -		global http_server_thread
> -		http_server_thread = threading.Thread(target=test, args=(CORSRequestHandler, HTTPServer,))
> -		http_server_thread.daemon = True
> -		http_server_thread.start()
> -
> -# Trace_end runs at the end and will be used to aggregate
> -# the data into the final json object and print it out to stdout.
> -def trace_end() -> None:
> -	global output_file
> -	threads = [thread._to_json_dict() for thread in tid_to_thread.values()]
> -
> -	# Schema: https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L305
> -	gecko_profile_with_meta = {
> -		"meta": {
> -			"interval": 1,
> -			"processType": 0,
> -			"product": PRODUCT,
> -			"stackwalk": 1,
> -			"debug": 0,
> -			"gcpoison": 0,
> -			"asyncstack": 1,
> -			"startTime": start_time,
> -			"shutdownTime": None,
> -			"version": 24,
> -			"presymbolicated": True,
> -			"categories": CATEGORIES,
> -			"markerSchema": [],
> -			},
> -		"libs": [],
> -		"threads": threads,
> -		"processes": [],
> -		"pausedRanges": [],
> -	}
> -	# launch the profiler on local host if not specified --save-only args, otherwise print to file
> -	if (output_file is None):
> -		output_file = 'gecko_profile.json'
> -		with open(output_file, 'w') as f:
> -			json.dump(gecko_profile_with_meta, f, indent=2)
> -		launchFirefox(output_file)
> -		time.sleep(1)
> -		print(f'[ perf gecko: Captured and wrote into {output_file} ]')
> -	else:
> -		print(f'[ perf gecko: Captured and wrote into {output_file} ]')
> -		with open(output_file, 'w') as f:
> -			json.dump(gecko_profile_with_meta, f, indent=2)
> -
> -# Used to enable Cross-Origin Resource Sharing (CORS) for requests coming from 'https://profiler.firefox.com', allowing it to access resources from this server.
> -class CORSRequestHandler(SimpleHTTPRequestHandler):
> -	def end_headers (self):
> -		self.send_header('Access-Control-Allow-Origin', 'https://profiler.firefox.com')
> -		SimpleHTTPRequestHandler.end_headers(self)
> -
> -# start a local server to serve the gecko_profile.json file to the profiler.firefox.com
> -def launchFirefox(file):
> -	safe_string = urllib.parse.quote_plus(f'http://localhost:8000/{file}')
> -	url = 'https://profiler.firefox.com/from-url/' + safe_string
> -	webbrowser.open(f'{url}')
> -
> -def main() -> None:
> -	global output_file
> -	global CATEGORIES
> -	parser = argparse.ArgumentParser(description="Convert perf.data to Firefox\'s Gecko Profile format which can be uploaded to profiler.firefox.com for visualization")
> -
> -	# Add the command-line options
> -	# Colors must be defined according to this:
> -	# https://github.com/firefox-devtools/profiler/blob/50124adbfa488adba6e2674a8f2618cf34b59cd2/res/css/categories.css
> -	parser.add_argument('--user-color', default='yellow', help='Color for the User category', choices=['yellow', 'blue', 'purple', 'green', 'orange', 'red', 'grey', 'magenta'])
> -	parser.add_argument('--kernel-color', default='orange', help='Color for the Kernel category', choices=['yellow', 'blue', 'purple', 'green', 'orange', 'red', 'grey', 'magenta'])
> -	# If --save-only is specified, the output will be saved to a file instead of opening Firefox's profiler directly.
> -	parser.add_argument('--save-only', help='Save the output to a file instead of opening Firefox\'s profiler')
> -
> -	# Parse the command-line arguments
> -	args = parser.parse_args()
> -	# Access the values provided by the user
> -	user_color = args.user_color
> -	kernel_color = args.kernel_color
> -	output_file = args.save_only
> -
> -	CATEGORIES = [
> -		{
> -			"name": 'User',
> -			"color": user_color,
> -			"subcategories": ['Other']
> -		},
> -		{
> -			"name": 'Kernel',
> -			"color": kernel_color,
> -			"subcategories": ['Other']
> -		},
> -	]
> -
> -if __name__ == '__main__':
> -	main()
> diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
> deleted file mode 100644
> index 346c89bd16d6..000000000000
> --- a/tools/perf/scripts/python/intel-pt-events.py
> +++ /dev/null
> @@ -1,494 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -# intel-pt-events.py: Print Intel PT Events including Power Events and PTWRITE
> -# Copyright (c) 2017-2021, Intel Corporation.
> -#
> -# This program is free software; you can redistribute it and/or modify it
> -# under the terms and conditions of the GNU General Public License,
> -# version 2, as published by the Free Software Foundation.
> -#
> -# This program is distributed in the hope it will be useful, but WITHOUT
> -# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> -# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> -# more details.
> -
> -from __future__ import division, print_function
> -
> -import io
> -import os
> -import sys
> -import struct
> -import argparse
> -import contextlib
> -
> -from libxed import LibXED
> -from ctypes import create_string_buffer, addressof
> -
> -sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> -	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> -
> -from perf_trace_context import perf_set_itrace_options, \
> -	perf_sample_insn, perf_sample_srccode
> -
> -try:
> -	broken_pipe_exception = BrokenPipeError
> -except:
> -	broken_pipe_exception = IOError
> -
> -glb_switch_str		= {}
> -glb_insn		= False
> -glb_disassembler	= None
> -glb_src			= False
> -glb_source_file_name	= None
> -glb_line_number		= None
> -glb_dso			= None
> -glb_stash_dict		= {}
> -glb_output		= None
> -glb_output_pos		= 0
> -glb_cpu			= -1
> -glb_time		= 0
> -
> -def get_optional_null(perf_dict, field):
> -	if field in perf_dict:
> -		return perf_dict[field]
> -	return ""
> -
> -def get_optional_zero(perf_dict, field):
> -	if field in perf_dict:
> -		return perf_dict[field]
> -	return 0
> -
> -def get_optional_bytes(perf_dict, field):
> -	if field in perf_dict:
> -		return perf_dict[field]
> -	return bytes()
> -
> -def get_optional(perf_dict, field):
> -	if field in perf_dict:
> -		return perf_dict[field]
> -	return "[unknown]"
> -
> -def get_offset(perf_dict, field):
> -	if field in perf_dict:
> -		return "+%#x" % perf_dict[field]
> -	return ""
> -
> -def trace_begin():
> -	ap = argparse.ArgumentParser(usage = "", add_help = False)
> -	ap.add_argument("--insn-trace", action='store_true')
> -	ap.add_argument("--src-trace", action='store_true')
> -	ap.add_argument("--all-switch-events", action='store_true')
> -	ap.add_argument("--interleave", type=int, nargs='?', const=4, default=0)
> -	global glb_args
> -	global glb_insn
> -	global glb_src
> -	glb_args = ap.parse_args()
> -	if glb_args.insn_trace:
> -		print("Intel PT Instruction Trace")
> -		itrace = "i0nsepwxI"
> -		glb_insn = True
> -	elif glb_args.src_trace:
> -		print("Intel PT Source Trace")
> -		itrace = "i0nsepwxI"
> -		glb_insn = True
> -		glb_src = True
> -	else:
> -		print("Intel PT Branch Trace, Power Events, Event Trace and PTWRITE")
> -		itrace = "bepwxI"
> -	global glb_disassembler
> -	try:
> -		glb_disassembler = LibXED()
> -	except:
> -		glb_disassembler = None
> -	perf_set_itrace_options(perf_script_context, itrace)
> -
> -def trace_end():
> -	if glb_args.interleave:
> -		flush_stashed_output()
> -	print("End")
> -
> -def trace_unhandled(event_name, context, event_fields_dict):
> -		print(' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())]))
> -
> -def stash_output():
> -	global glb_stash_dict
> -	global glb_output_pos
> -	output_str = glb_output.getvalue()[glb_output_pos:]
> -	n = len(output_str)
> -	if n:
> -		glb_output_pos += n
> -		if glb_cpu not in glb_stash_dict:
> -			glb_stash_dict[glb_cpu] = []
> -		glb_stash_dict[glb_cpu].append(output_str)
> -
> -def flush_stashed_output():
> -	global glb_stash_dict
> -	while glb_stash_dict:
> -		cpus = list(glb_stash_dict.keys())
> -		# Output at most glb_args.interleave output strings per cpu
> -		for cpu in cpus:
> -			items = glb_stash_dict[cpu]
> -			countdown = glb_args.interleave
> -			while len(items) and countdown:
> -				sys.stdout.write(items[0])
> -				del items[0]
> -				countdown -= 1
> -			if not items:
> -				del glb_stash_dict[cpu]
> -
> -def print_ptwrite(raw_buf):
> -	data = struct.unpack_from("<IQ", raw_buf)
> -	flags = data[0]
> -	payload = data[1]
> -	exact_ip = flags & 1
> -	try:
> -		s = payload.to_bytes(8, "little").decode("ascii").rstrip("\x00")
> -		if not s.isprintable():
> -			s = ""
> -	except:
> -		s = ""
> -	print("IP: %u payload: %#x" % (exact_ip, payload), s, end=' ')
> -
> -def print_cbr(raw_buf):
> -	data = struct.unpack_from("<BBBBII", raw_buf)
> -	cbr = data[0]
> -	f = (data[4] + 500) / 1000
> -	p = ((cbr * 1000 / data[2]) + 5) / 10
> -	print("%3u  freq: %4u MHz  (%3u%%)" % (cbr, f, p), end=' ')
> -
> -def print_mwait(raw_buf):
> -	data = struct.unpack_from("<IQ", raw_buf)
> -	payload = data[1]
> -	hints = payload & 0xff
> -	extensions = (payload >> 32) & 0x3
> -	print("hints: %#x extensions: %#x" % (hints, extensions), end=' ')
> -
> -def print_pwre(raw_buf):
> -	data = struct.unpack_from("<IQ", raw_buf)
> -	payload = data[1]
> -	hw = (payload >> 7) & 1
> -	cstate = (payload >> 12) & 0xf
> -	subcstate = (payload >> 8) & 0xf
> -	print("hw: %u cstate: %u sub-cstate: %u" % (hw, cstate, subcstate),
> -		end=' ')
> -
> -def print_exstop(raw_buf):
> -	data = struct.unpack_from("<I", raw_buf)
> -	flags = data[0]
> -	exact_ip = flags & 1
> -	print("IP: %u" % (exact_ip), end=' ')
> -
> -def print_pwrx(raw_buf):
> -	data = struct.unpack_from("<IQ", raw_buf)
> -	payload = data[1]
> -	deepest_cstate = payload & 0xf
> -	last_cstate = (payload >> 4) & 0xf
> -	wake_reason = (payload >> 8) & 0xf
> -	print("deepest cstate: %u last cstate: %u wake reason: %#x" %
> -		(deepest_cstate, last_cstate, wake_reason), end=' ')
> -
> -def print_psb(raw_buf):
> -	data = struct.unpack_from("<IQ", raw_buf)
> -	offset = data[1]
> -	print("offset: %#x" % (offset), end=' ')
> -
> -glb_cfe = ["", "INTR", "IRET", "SMI", "RSM", "SIPI", "INIT", "VMENTRY", "VMEXIT",
> -		"VMEXIT_INTR", "SHUTDOWN", "", "UINT", "UIRET"] + [""] * 18
> -glb_evd = ["", "PFA", "VMXQ", "VMXR"] + [""] * 60
> -
> -def print_evt(raw_buf):
> -	data = struct.unpack_from("<BBH", raw_buf)
> -	typ = data[0] & 0x1f
> -	ip_flag = (data[0] & 0x80) >> 7
> -	vector = data[1]
> -	evd_cnt = data[2]
> -	s = glb_cfe[typ]
> -	if s:
> -		print(" cfe: %s IP: %u vector: %u" % (s, ip_flag, vector), end=' ')
> -	else:
> -		print(" cfe: %u IP: %u vector: %u" % (typ, ip_flag, vector), end=' ')
> -	pos = 4
> -	for i in range(evd_cnt):
> -		data = struct.unpack_from("<QQ", raw_buf)
> -		et = data[0] & 0x3f
> -		s = glb_evd[et]
> -		if s:
> -			print("%s: %#x" % (s, data[1]), end=' ')
> -		else:
> -			print("EVD_%u: %#x" % (et, data[1]), end=' ')
> -
> -def print_iflag(raw_buf):
> -	data = struct.unpack_from("<IQ", raw_buf)
> -	iflag = data[0] & 1
> -	old_iflag = iflag ^ 1
> -	via_branch = data[0] & 2
> -	branch_ip = data[1]
> -	if via_branch:
> -		s = "via"
> -	else:
> -		s = "non"
> -	print("IFLAG: %u->%u %s branch" % (old_iflag, iflag, s), end=' ')
> -
> -def common_start_str(comm, sample):
> -	ts = sample["time"]
> -	cpu = sample["cpu"]
> -	pid = sample["pid"]
> -	tid = sample["tid"]
> -	if "machine_pid" in sample:
> -		machine_pid = sample["machine_pid"]
> -		vcpu = sample["vcpu"]
> -		return "VM:%5d VCPU:%03d %16s %5u/%-5u [%03u] %9u.%09u  " % (machine_pid, vcpu, comm, pid, tid, cpu, ts / 1000000000, ts %1000000000)
> -	else:
> -		return "%16s %5u/%-5u [%03u] %9u.%09u  " % (comm, pid, tid, cpu, ts / 1000000000, ts %1000000000)
> -
> -def print_common_start(comm, sample, name):
> -	flags_disp = get_optional_null(sample, "flags_disp")
> -	# Unused fields:
> -	# period      = sample["period"]
> -	# phys_addr   = sample["phys_addr"]
> -	# weight      = sample["weight"]
> -	# transaction = sample["transaction"]
> -	# cpumode     = get_optional_zero(sample, "cpumode")
> -	print(common_start_str(comm, sample) + "%8s  %21s" % (name, flags_disp), end=' ')
> -
> -def print_instructions_start(comm, sample):
> -	if "x" in get_optional_null(sample, "flags"):
> -		print(common_start_str(comm, sample) + "x", end=' ')
> -	else:
> -		print(common_start_str(comm, sample), end='  ')
> -
> -def disassem(insn, ip):
> -	inst = glb_disassembler.Instruction()
> -	glb_disassembler.SetMode(inst, 0) # Assume 64-bit
> -	buf = create_string_buffer(64)
> -	buf.value = insn
> -	return glb_disassembler.DisassembleOne(inst, addressof(buf), len(insn), ip)
> -
> -def print_common_ip(param_dict, sample, symbol, dso):
> -	ip   = sample["ip"]
> -	offs = get_offset(param_dict, "symoff")
> -	if "cyc_cnt" in sample:
> -		cyc_cnt = sample["cyc_cnt"]
> -		insn_cnt = get_optional_zero(sample, "insn_cnt")
> -		ipc_str = "  IPC: %#.2f (%u/%u)" % (insn_cnt / cyc_cnt, insn_cnt, cyc_cnt)
> -	else:
> -		ipc_str = ""
> -	if glb_insn and glb_disassembler is not None:
> -		insn = perf_sample_insn(perf_script_context)
> -		if insn and len(insn):
> -			cnt, text = disassem(insn, ip)
> -			byte_str = ("%x" % ip).rjust(16)
> -			if sys.version_info.major >= 3:
> -				for k in range(cnt):
> -					byte_str += " %02x" % insn[k]
> -			else:
> -				for k in xrange(cnt):
> -					byte_str += " %02x" % ord(insn[k])
> -			print("%-40s  %-30s" % (byte_str, text), end=' ')
> -		print("%s%s (%s)" % (symbol, offs, dso), end=' ')
> -	else:
> -		print("%16x %s%s (%s)" % (ip, symbol, offs, dso), end=' ')
> -	if "addr_correlates_sym" in sample:
> -		addr   = sample["addr"]
> -		dso    = get_optional(sample, "addr_dso")
> -		symbol = get_optional(sample, "addr_symbol")
> -		offs   = get_offset(sample, "addr_symoff")
> -		print("=> %x %s%s (%s)%s" % (addr, symbol, offs, dso, ipc_str))
> -	else:
> -		print(ipc_str)
> -
> -def print_srccode(comm, param_dict, sample, symbol, dso, with_insn):
> -	ip = sample["ip"]
> -	if symbol == "[unknown]":
> -		start_str = common_start_str(comm, sample) + ("%x" % ip).rjust(16).ljust(40)
> -	else:
> -		offs = get_offset(param_dict, "symoff")
> -		start_str = common_start_str(comm, sample) + (symbol + offs).ljust(40)
> -
> -	if with_insn and glb_insn and glb_disassembler is not None:
> -		insn = perf_sample_insn(perf_script_context)
> -		if insn and len(insn):
> -			cnt, text = disassem(insn, ip)
> -		start_str += text.ljust(30)
> -
> -	global glb_source_file_name
> -	global glb_line_number
> -	global glb_dso
> -
> -	source_file_name, line_number, source_line = perf_sample_srccode(perf_script_context)
> -	if source_file_name:
> -		if glb_line_number == line_number and glb_source_file_name == source_file_name:
> -			src_str = ""
> -		else:
> -			if len(source_file_name) > 40:
> -				src_file = ("..." + source_file_name[-37:]) + " "
> -			else:
> -				src_file = source_file_name.ljust(41)
> -			if source_line is None:
> -				src_str = src_file + str(line_number).rjust(4) + " <source not found>"
> -			else:
> -				src_str = src_file + str(line_number).rjust(4) + " " + source_line
> -		glb_dso = None
> -	elif dso == glb_dso:
> -		src_str = ""
> -	else:
> -		src_str = dso
> -		glb_dso = dso
> -
> -	glb_line_number = line_number
> -	glb_source_file_name = source_file_name
> -
> -	print(start_str, src_str)
> -
> -def do_process_event(param_dict):
> -	sample	   = param_dict["sample"]
> -	raw_buf	   = param_dict["raw_buf"]
> -	comm	   = param_dict["comm"]
> -	name	   = param_dict["ev_name"]
> -	# Unused fields:
> -	# callchain  = param_dict["callchain"]
> -	# brstack    = param_dict["brstack"]
> -	# brstacksym = param_dict["brstacksym"]
> -	# event_attr = param_dict["attr"]
> -
> -	# Symbol and dso info are not always resolved
> -	dso    = get_optional(param_dict, "dso")
> -	symbol = get_optional(param_dict, "symbol")
> -
> -	cpu = sample["cpu"]
> -	if cpu in glb_switch_str:
> -		print(glb_switch_str[cpu])
> -		del glb_switch_str[cpu]
> -
> -	if name.startswith("instructions"):
> -		if glb_src:
> -			print_srccode(comm, param_dict, sample, symbol, dso, True)
> -		else:
> -			print_instructions_start(comm, sample)
> -			print_common_ip(param_dict, sample, symbol, dso)
> -	elif name.startswith("branches"):
> -		if glb_src:
> -			print_srccode(comm, param_dict, sample, symbol, dso, False)
> -		else:
> -			print_common_start(comm, sample, name)
> -			print_common_ip(param_dict, sample, symbol, dso)
> -	elif name == "ptwrite":
> -		print_common_start(comm, sample, name)
> -		print_ptwrite(raw_buf)
> -		print_common_ip(param_dict, sample, symbol, dso)
> -	elif name == "cbr":
> -		print_common_start(comm, sample, name)
> -		print_cbr(raw_buf)
> -		print_common_ip(param_dict, sample, symbol, dso)
> -	elif name == "mwait":
> -		print_common_start(comm, sample, name)
> -		print_mwait(raw_buf)
> -		print_common_ip(param_dict, sample, symbol, dso)
> -	elif name == "pwre":
> -		print_common_start(comm, sample, name)
> -		print_pwre(raw_buf)
> -		print_common_ip(param_dict, sample, symbol, dso)
> -	elif name == "exstop":
> -		print_common_start(comm, sample, name)
> -		print_exstop(raw_buf)
> -		print_common_ip(param_dict, sample, symbol, dso)
> -	elif name == "pwrx":
> -		print_common_start(comm, sample, name)
> -		print_pwrx(raw_buf)
> -		print_common_ip(param_dict, sample, symbol, dso)
> -	elif name == "psb":
> -		print_common_start(comm, sample, name)
> -		print_psb(raw_buf)
> -		print_common_ip(param_dict, sample, symbol, dso)
> -	elif name == "evt":
> -		print_common_start(comm, sample, name)
> -		print_evt(raw_buf)
> -		print_common_ip(param_dict, sample, symbol, dso)
> -	elif name == "iflag":
> -		print_common_start(comm, sample, name)
> -		print_iflag(raw_buf)
> -		print_common_ip(param_dict, sample, symbol, dso)
> -	else:
> -		print_common_start(comm, sample, name)
> -		print_common_ip(param_dict, sample, symbol, dso)
> -
> -def interleave_events(param_dict):
> -	global glb_cpu
> -	global glb_time
> -	global glb_output
> -	global glb_output_pos
> -
> -	sample  = param_dict["sample"]
> -	glb_cpu = sample["cpu"]
> -	ts      = sample["time"]
> -
> -	if glb_time != ts:
> -		glb_time = ts
> -		flush_stashed_output()
> -
> -	glb_output_pos = 0
> -	with contextlib.redirect_stdout(io.StringIO()) as glb_output:
> -		do_process_event(param_dict)
> -
> -	stash_output()
> -
> -def process_event(param_dict):
> -	try:
> -		if glb_args.interleave:
> -			interleave_events(param_dict)
> -		else:
> -			do_process_event(param_dict)
> -	except broken_pipe_exception:
> -		# Stop python printing broken pipe errors and traceback
> -		sys.stdout = open(os.devnull, 'w')
> -		sys.exit(1)
> -
> -def auxtrace_error(typ, code, cpu, pid, tid, ip, ts, msg, cpumode, *x):
> -	if glb_args.interleave:
> -		flush_stashed_output()
> -	if len(x) >= 2 and x[0]:
> -		machine_pid = x[0]
> -		vcpu = x[1]
> -	else:
> -		machine_pid = 0
> -		vcpu = -1
> -	try:
> -		if machine_pid:
> -			print("VM:%5d VCPU:%03d %16s %5u/%-5u [%03u] %9u.%09u  error type %u code %u: %s ip 0x%16x" %
> -				(machine_pid, vcpu, "Trace error", pid, tid, cpu, ts / 1000000000, ts %1000000000, typ, code, msg, ip))
> -		else:
> -			print("%16s %5u/%-5u [%03u] %9u.%09u  error type %u code %u: %s ip 0x%16x" %
> -				("Trace error", pid, tid, cpu, ts / 1000000000, ts %1000000000, typ, code, msg, ip))
> -	except broken_pipe_exception:
> -		# Stop python printing broken pipe errors and traceback
> -		sys.stdout = open(os.devnull, 'w')
> -		sys.exit(1)
> -
> -def context_switch(ts, cpu, pid, tid, np_pid, np_tid, machine_pid, out, out_preempt, *x):
> -	if glb_args.interleave:
> -		flush_stashed_output()
> -	if out:
> -		out_str = "Switch out "
> -	else:
> -		out_str = "Switch In  "
> -	if out_preempt:
> -		preempt_str = "preempt"
> -	else:
> -		preempt_str = ""
> -	if len(x) >= 2 and x[0]:
> -		machine_pid = x[0]
> -		vcpu = x[1]
> -	else:
> -		vcpu = None;
> -	if machine_pid == -1:
> -		machine_str = ""
> -	elif vcpu is None:
> -		machine_str = "machine PID %d" % machine_pid
> -	else:
> -		machine_str = "machine PID %d VCPU %d" % (machine_pid, vcpu)
> -	switch_str = "%16s %5d/%-5d [%03u] %9u.%09u %5d/%-5d %s %s" % \
> -		(out_str, pid, tid, cpu, ts / 1000000000, ts %1000000000, np_pid, np_tid, machine_str, preempt_str)
> -	if glb_args.all_switch_events:
> -		print(switch_str)
> -	else:
> -		global glb_switch_str
> -		glb_switch_str[cpu] = switch_str
> diff --git a/tools/perf/scripts/python/libxed.py b/tools/perf/scripts/python/libxed.py
> deleted file mode 100644
> index 2c70a5a7eb9c..000000000000
> --- a/tools/perf/scripts/python/libxed.py
> +++ /dev/null
> @@ -1,107 +0,0 @@
> -#!/usr/bin/env python
> -# SPDX-License-Identifier: GPL-2.0
> -# libxed.py: Python wrapper for libxed.so
> -# Copyright (c) 2014-2021, Intel Corporation.
> -
> -# To use Intel XED, libxed.so must be present. To build and install
> -# libxed.so:
> -#            git clone https://github.com/intelxed/mbuild.git mbuild
> -#            git clone https://github.com/intelxed/xed
> -#            cd xed
> -#            ./mfile.py --share
> -#            sudo ./mfile.py --prefix=/usr/local install
> -#            sudo ldconfig
> -#
> -
> -import sys
> -
> -from ctypes import CDLL, Structure, create_string_buffer, addressof, sizeof, \
> -		   c_void_p, c_bool, c_byte, c_char, c_int, c_uint, c_longlong, c_ulonglong
> -
> -# XED Disassembler
> -
> -class xed_state_t(Structure):
> -
> -	_fields_ = [
> -		("mode", c_int),
> -		("width", c_int)
> -	]
> -
> -class XEDInstruction():
> -
> -	def __init__(self, libxed):
> -		# Current xed_decoded_inst_t structure is 192 bytes. Use 512 to allow for future expansion
> -		xedd_t = c_byte * 512
> -		self.xedd = xedd_t()
> -		self.xedp = addressof(self.xedd)
> -		libxed.xed_decoded_inst_zero(self.xedp)
> -		self.state = xed_state_t()
> -		self.statep = addressof(self.state)
> -		# Buffer for disassembled instruction text
> -		self.buffer = create_string_buffer(256)
> -		self.bufferp = addressof(self.buffer)
> -
> -class LibXED():
> -
> -	def __init__(self):
> -		try:
> -			self.libxed = CDLL("libxed.so")
> -		except:
> -			self.libxed = None
> -		if not self.libxed:
> -			self.libxed = CDLL("/usr/local/lib/libxed.so")
> -
> -		self.xed_tables_init = self.libxed.xed_tables_init
> -		self.xed_tables_init.restype = None
> -		self.xed_tables_init.argtypes = []
> -
> -		self.xed_decoded_inst_zero = self.libxed.xed_decoded_inst_zero
> -		self.xed_decoded_inst_zero.restype = None
> -		self.xed_decoded_inst_zero.argtypes = [ c_void_p ]
> -
> -		self.xed_operand_values_set_mode = self.libxed.xed_operand_values_set_mode
> -		self.xed_operand_values_set_mode.restype = None
> -		self.xed_operand_values_set_mode.argtypes = [ c_void_p, c_void_p ]
> -
> -		self.xed_decoded_inst_zero_keep_mode = self.libxed.xed_decoded_inst_zero_keep_mode
> -		self.xed_decoded_inst_zero_keep_mode.restype = None
> -		self.xed_decoded_inst_zero_keep_mode.argtypes = [ c_void_p ]
> -
> -		self.xed_decode = self.libxed.xed_decode
> -		self.xed_decode.restype = c_int
> -		self.xed_decode.argtypes = [ c_void_p, c_void_p, c_uint ]
> -
> -		self.xed_format_context = self.libxed.xed_format_context
> -		self.xed_format_context.restype = c_uint
> -		self.xed_format_context.argtypes = [ c_int, c_void_p, c_void_p, c_int, c_ulonglong, c_void_p, c_void_p ]
> -
> -		self.xed_tables_init()
> -
> -	def Instruction(self):
> -		return XEDInstruction(self)
> -
> -	def SetMode(self, inst, mode):
> -		if mode:
> -			inst.state.mode = 4 # 32-bit
> -			inst.state.width = 4 # 4 bytes
> -		else:
> -			inst.state.mode = 1 # 64-bit
> -			inst.state.width = 8 # 8 bytes
> -		self.xed_operand_values_set_mode(inst.xedp, inst.statep)
> -
> -	def DisassembleOne(self, inst, bytes_ptr, bytes_cnt, ip):
> -		self.xed_decoded_inst_zero_keep_mode(inst.xedp)
> -		err = self.xed_decode(inst.xedp, bytes_ptr, bytes_cnt)
> -		if err:
> -			return 0, ""
> -		# Use AT&T mode (2), alternative is Intel (3)
> -		ok = self.xed_format_context(2, inst.xedp, inst.bufferp, sizeof(inst.buffer), ip, 0, 0)
> -		if not ok:
> -			return 0, ""
> -		if sys.version_info[0] == 2:
> -			result = inst.buffer.value
> -		else:
> -			result = inst.buffer.value.decode()
> -		# Return instruction length and the disassembled instruction text
> -		# For now, assume the length is in byte 166
> -		return inst.xedd[166], result
> diff --git a/tools/perf/scripts/python/mem-phys-addr.py b/tools/perf/scripts/python/mem-phys-addr.py
> deleted file mode 100644
> index 5e237a5a5f1b..000000000000
> --- a/tools/perf/scripts/python/mem-phys-addr.py
> +++ /dev/null
> @@ -1,127 +0,0 @@
> -# mem-phys-addr.py: Resolve physical address samples
> -# SPDX-License-Identifier: GPL-2.0
> -#
> -# Copyright (c) 2018, Intel Corporation.
> -
> -import os
> -import sys
> -import re
> -import bisect
> -import collections
> -from dataclasses import dataclass
> -from typing import (Dict, Optional)
> -
> -sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> -    '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> -
> -@dataclass(frozen=True)
> -class IomemEntry:
> -    """Read from a line in /proc/iomem"""
> -    begin: int
> -    end: int
> -    indent: int
> -    label: str
> -
> -# Physical memory layout from /proc/iomem. Key is the indent and then
> -# a list of ranges.
> -iomem: Dict[int, list[IomemEntry]] = collections.defaultdict(list)
> -# Child nodes from the iomem parent.
> -children: Dict[IomemEntry, set[IomemEntry]] = collections.defaultdict(set)
> -# Maximum indent seen before an entry in the iomem file.
> -max_indent: int = 0
> -# Count for each range of memory.
> -load_mem_type_cnt: Dict[IomemEntry, int] = collections.Counter()
> -# Perf event name set from the first sample in the data.
> -event_name: Optional[str] = None
> -
> -def parse_iomem():
> -    """Populate iomem from /proc/iomem file"""
> -    global iomem
> -    global max_indent
> -    global children
> -    with open('/proc/iomem', 'r', encoding='ascii') as f:
> -        for line in f:
> -            indent = 0
> -            while line[indent] == ' ':
> -                indent += 1
> -            if indent > max_indent:
> -                max_indent = indent
> -            m = re.split('-|:', line, 2)
> -            begin = int(m[0], 16)
> -            end = int(m[1], 16)
> -            label = m[2].strip()
> -            entry = IomemEntry(begin, end, indent, label)
> -            # Before adding entry, search for a parent node using its begin.
> -            if indent > 0:
> -                parent = find_memory_type(begin)
> -                assert parent, f"Given indent expected a parent for {label}"
> -                children[parent].add(entry)
> -            iomem[indent].append(entry)
> -
> -def find_memory_type(phys_addr) -> Optional[IomemEntry]:
> -    """Search iomem for the range containing phys_addr with the maximum indent"""
> -    for i in range(max_indent, -1, -1):
> -        if i not in iomem:
> -            continue
> -        position = bisect.bisect_right(iomem[i], phys_addr,
> -                                       key=lambda entry: entry.begin)
> -        if position is None:
> -            continue
> -        iomem_entry = iomem[i][position-1]
> -        if  iomem_entry.begin <= phys_addr <= iomem_entry.end:
> -            return iomem_entry
> -    print(f"Didn't find {phys_addr}")
> -    return None
> -
> -def print_memory_type():
> -    print(f"Event: {event_name}")
> -    print(f"{'Memory type':<40}  {'count':>10}  {'percentage':>10}")
> -    print(f"{'-' * 40:<40}  {'-' * 10:>10}  {'-' * 10:>10}")
> -    total = sum(load_mem_type_cnt.values())
> -    # Add count from children into the parent.
> -    for i in range(max_indent, -1, -1):
> -        if i not in iomem:
> -            continue
> -        for entry in iomem[i]:
> -            global children
> -            for child in children[entry]:
> -                if load_mem_type_cnt[child] > 0:
> -                    load_mem_type_cnt[entry] += load_mem_type_cnt[child]
> -
> -    def print_entries(entries):
> -        """Print counts from parents down to their children"""
> -        global children
> -        for entry in sorted(entries,
> -                            key = lambda entry: load_mem_type_cnt[entry],
> -                            reverse = True):
> -            count = load_mem_type_cnt[entry]
> -            if count > 0:
> -                mem_type = ' ' * entry.indent + f"{entry.begin:x}-{entry.end:x} : {entry.label}"
> -                percent = 100 * count / total
> -                print(f"{mem_type:<40}  {count:>10}  {percent:>10.1f}")
> -                print_entries(children[entry])
> -
> -    print_entries(iomem[0])
> -
> -def trace_begin():
> -    parse_iomem()
> -
> -def trace_end():
> -    print_memory_type()
> -
> -def process_event(param_dict):
> -    if "sample" not in param_dict:
> -        return
> -
> -    sample = param_dict["sample"]
> -    if "phys_addr" not in sample:
> -        return
> -
> -    phys_addr  = sample["phys_addr"]
> -    entry = find_memory_type(phys_addr)
> -    if entry:
> -        load_mem_type_cnt[entry] += 1
> -
> -    global event_name
> -    if event_name is None:
> -        event_name  = param_dict["ev_name"]
> diff --git a/tools/perf/scripts/python/net_dropmonitor.py b/tools/perf/scripts/python/net_dropmonitor.py
> deleted file mode 100755
> index a97e7a6e0940..000000000000
> --- a/tools/perf/scripts/python/net_dropmonitor.py
> +++ /dev/null
> @@ -1,78 +0,0 @@
> -# Monitor the system for dropped packets and proudce a report of drop locations and counts
> -# SPDX-License-Identifier: GPL-2.0
> -
> -from __future__ import print_function
> -
> -import os
> -import sys
> -
> -sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> -	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> -
> -from perf_trace_context import *
> -from Core import *
> -from Util import *
> -
> -drop_log = {}
> -kallsyms = []
> -
> -def get_kallsyms_table():
> -	global kallsyms
> -
> -	try:
> -		f = open("/proc/kallsyms", "r")
> -	except:
> -		return
> -
> -	for line in f:
> -		loc = int(line.split()[0], 16)
> -		name = line.split()[2]
> -		kallsyms.append((loc, name))
> -	kallsyms.sort()
> -
> -def get_sym(sloc):
> -	loc = int(sloc)
> -
> -	# Invariant: kallsyms[i][0] <= loc for all 0 <= i <= start
> -	#            kallsyms[i][0] > loc for all end <= i < len(kallsyms)
> -	start, end = -1, len(kallsyms)
> -	while end != start + 1:
> -		pivot = (start + end) // 2
> -		if loc < kallsyms[pivot][0]:
> -			end = pivot
> -		else:
> -			start = pivot
> -
> -	# Now (start == -1 or kallsyms[start][0] <= loc)
> -	# and (start == len(kallsyms) - 1 or loc < kallsyms[start + 1][0])
> -	if start >= 0:
> -		symloc, name = kallsyms[start]
> -		return (name, loc - symloc)
> -	else:
> -		return (None, 0)
> -
> -def print_drop_table():
> -	print("%25s %25s %25s" % ("LOCATION", "OFFSET", "COUNT"))
> -	for i in drop_log.keys():
> -		(sym, off) = get_sym(i)
> -		if sym == None:
> -			sym = i
> -		print("%25s %25s %25s" % (sym, off, drop_log[i]))
> -
> -
> -def trace_begin():
> -	print("Starting trace (Ctrl-C to dump results)")
> -
> -def trace_end():
> -	print("Gathering kallsyms data")
> -	get_kallsyms_table()
> -	print_drop_table()
> -
> -# called from perf, when it finds a corresponding event
> -def skb__kfree_skb(name, context, cpu, sec, nsec, pid, comm, callchain,
> -		   skbaddr, location, protocol, reason):
> -	slocation = str(location)
> -	try:
> -		drop_log[slocation] = drop_log[slocation] + 1
> -	except:
> -		drop_log[slocation] = 1
> diff --git a/tools/perf/scripts/python/netdev-times.py b/tools/perf/scripts/python/netdev-times.py
> deleted file mode 100644
> index 30c4bccee5b2..000000000000
> --- a/tools/perf/scripts/python/netdev-times.py
> +++ /dev/null
> @@ -1,473 +0,0 @@
> -# Display a process of packets and processed time.
> -# SPDX-License-Identifier: GPL-2.0
> -# It helps us to investigate networking or network device.
> -#
> -# options
> -# tx: show only tx chart
> -# rx: show only rx chart
> -# dev=: show only thing related to specified device
> -# debug: work with debug mode. It shows buffer status.
> -
> -from __future__ import print_function
> -
> -import os
> -import sys
> -
> -sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> -	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> -
> -from perf_trace_context import *
> -from Core import *
> -from Util import *
> -from functools import cmp_to_key
> -
> -all_event_list = []; # insert all tracepoint event related with this script
> -irq_dic = {}; # key is cpu and value is a list which stacks irqs
> -              # which raise NET_RX softirq
> -net_rx_dic = {}; # key is cpu and value include time of NET_RX softirq-entry
> -		 # and a list which stacks receive
> -receive_hunk_list = []; # a list which include a sequence of receive events
> -rx_skb_list = []; # received packet list for matching
> -		       # skb_copy_datagram_iovec
> -
> -buffer_budget = 65536; # the budget of rx_skb_list, tx_queue_list and
> -		       # tx_xmit_list
> -of_count_rx_skb_list = 0; # overflow count
> -
> -tx_queue_list = []; # list of packets which pass through dev_queue_xmit
> -of_count_tx_queue_list = 0; # overflow count
> -
> -tx_xmit_list = [];  # list of packets which pass through dev_hard_start_xmit
> -of_count_tx_xmit_list = 0; # overflow count
> -
> -tx_free_list = [];  # list of packets which is freed
> -
> -# options
> -show_tx = 0;
> -show_rx = 0;
> -dev = 0; # store a name of device specified by option "dev="
> -debug = 0;
> -
> -# indices of event_info tuple
> -EINFO_IDX_NAME=   0
> -EINFO_IDX_CONTEXT=1
> -EINFO_IDX_CPU=    2
> -EINFO_IDX_TIME=   3
> -EINFO_IDX_PID=    4
> -EINFO_IDX_COMM=   5
> -
> -# Calculate a time interval(msec) from src(nsec) to dst(nsec)
> -def diff_msec(src, dst):
> -	return (dst - src) / 1000000.0
> -
> -# Display a process of transmitting a packet
> -def print_transmit(hunk):
> -	if dev != 0 and hunk['dev'].find(dev) < 0:
> -		return
> -	print("%7s %5d %6d.%06dsec %12.3fmsec      %12.3fmsec" %
> -		(hunk['dev'], hunk['len'],
> -		nsecs_secs(hunk['queue_t']),
> -		nsecs_nsecs(hunk['queue_t'])/1000,
> -		diff_msec(hunk['queue_t'], hunk['xmit_t']),
> -		diff_msec(hunk['xmit_t'], hunk['free_t'])))
> -
> -# Format for displaying rx packet processing
> -PF_IRQ_ENTRY= "  irq_entry(+%.3fmsec irq=%d:%s)"
> -PF_SOFT_ENTRY="  softirq_entry(+%.3fmsec)"
> -PF_NAPI_POLL= "  napi_poll_exit(+%.3fmsec %s)"
> -PF_JOINT=     "         |"
> -PF_WJOINT=    "         |            |"
> -PF_NET_RECV=  "         |---netif_receive_skb(+%.3fmsec skb=%x len=%d)"
> -PF_NET_RX=    "         |---netif_rx(+%.3fmsec skb=%x)"
> -PF_CPY_DGRAM= "         |      skb_copy_datagram_iovec(+%.3fmsec %d:%s)"
> -PF_KFREE_SKB= "         |      kfree_skb(+%.3fmsec location=%x)"
> -PF_CONS_SKB=  "         |      consume_skb(+%.3fmsec)"
> -
> -# Display a process of received packets and interrputs associated with
> -# a NET_RX softirq
> -def print_receive(hunk):
> -	show_hunk = 0
> -	irq_list = hunk['irq_list']
> -	cpu = irq_list[0]['cpu']
> -	base_t = irq_list[0]['irq_ent_t']
> -	# check if this hunk should be showed
> -	if dev != 0:
> -		for i in range(len(irq_list)):
> -			if irq_list[i]['name'].find(dev) >= 0:
> -				show_hunk = 1
> -				break
> -	else:
> -		show_hunk = 1
> -	if show_hunk == 0:
> -		return
> -
> -	print("%d.%06dsec cpu=%d" %
> -		(nsecs_secs(base_t), nsecs_nsecs(base_t)/1000, cpu))
> -	for i in range(len(irq_list)):
> -		print(PF_IRQ_ENTRY %
> -			(diff_msec(base_t, irq_list[i]['irq_ent_t']),
> -			irq_list[i]['irq'], irq_list[i]['name']))
> -		print(PF_JOINT)
> -		irq_event_list = irq_list[i]['event_list']
> -		for j in range(len(irq_event_list)):
> -			irq_event = irq_event_list[j]
> -			if irq_event['event'] == 'netif_rx':
> -				print(PF_NET_RX %
> -					(diff_msec(base_t, irq_event['time']),
> -					irq_event['skbaddr']))
> -				print(PF_JOINT)
> -	print(PF_SOFT_ENTRY %
> -		diff_msec(base_t, hunk['sirq_ent_t']))
> -	print(PF_JOINT)
> -	event_list = hunk['event_list']
> -	for i in range(len(event_list)):
> -		event = event_list[i]
> -		if event['event_name'] == 'napi_poll':
> -			print(PF_NAPI_POLL %
> -				(diff_msec(base_t, event['event_t']),
> -				event['dev']))
> -			if i == len(event_list) - 1:
> -				print("")
> -			else:
> -				print(PF_JOINT)
> -		else:
> -			print(PF_NET_RECV %
> -				(diff_msec(base_t, event['event_t']),
> -				event['skbaddr'],
> -				event['len']))
> -			if 'comm' in event.keys():
> -				print(PF_WJOINT)
> -				print(PF_CPY_DGRAM %
> -					(diff_msec(base_t, event['comm_t']),
> -					event['pid'], event['comm']))
> -			elif 'handle' in event.keys():
> -				print(PF_WJOINT)
> -				if event['handle'] == "kfree_skb":
> -					print(PF_KFREE_SKB %
> -						(diff_msec(base_t,
> -						event['comm_t']),
> -						event['location']))
> -				elif event['handle'] == "consume_skb":
> -					print(PF_CONS_SKB %
> -						diff_msec(base_t,
> -							event['comm_t']))
> -			print(PF_JOINT)
> -
> -def trace_begin():
> -	global show_tx
> -	global show_rx
> -	global dev
> -	global debug
> -
> -	for i in range(len(sys.argv)):
> -		if i == 0:
> -			continue
> -		arg = sys.argv[i]
> -		if arg == 'tx':
> -			show_tx = 1
> -		elif arg =='rx':
> -			show_rx = 1
> -		elif arg.find('dev=',0, 4) >= 0:
> -			dev = arg[4:]
> -		elif arg == 'debug':
> -			debug = 1
> -	if show_tx == 0  and show_rx == 0:
> -		show_tx = 1
> -		show_rx = 1
> -
> -def trace_end():
> -	# order all events in time
> -	all_event_list.sort(key=cmp_to_key(lambda a,b :a[EINFO_IDX_TIME] < b[EINFO_IDX_TIME]))
> -	# process all events
> -	for i in range(len(all_event_list)):
> -		event_info = all_event_list[i]
> -		name = event_info[EINFO_IDX_NAME]
> -		if name == 'irq__softirq_exit':
> -			handle_irq_softirq_exit(event_info)
> -		elif name == 'irq__softirq_entry':
> -			handle_irq_softirq_entry(event_info)
> -		elif name == 'irq__softirq_raise':
> -			handle_irq_softirq_raise(event_info)
> -		elif name == 'irq__irq_handler_entry':
> -			handle_irq_handler_entry(event_info)
> -		elif name == 'irq__irq_handler_exit':
> -			handle_irq_handler_exit(event_info)
> -		elif name == 'napi__napi_poll':
> -			handle_napi_poll(event_info)
> -		elif name == 'net__netif_receive_skb':
> -			handle_netif_receive_skb(event_info)
> -		elif name == 'net__netif_rx':
> -			handle_netif_rx(event_info)
> -		elif name == 'skb__skb_copy_datagram_iovec':
> -			handle_skb_copy_datagram_iovec(event_info)
> -		elif name == 'net__net_dev_queue':
> -			handle_net_dev_queue(event_info)
> -		elif name == 'net__net_dev_xmit':
> -			handle_net_dev_xmit(event_info)
> -		elif name == 'skb__kfree_skb':
> -			handle_kfree_skb(event_info)
> -		elif name == 'skb__consume_skb':
> -			handle_consume_skb(event_info)
> -	# display receive hunks
> -	if show_rx:
> -		for i in range(len(receive_hunk_list)):
> -			print_receive(receive_hunk_list[i])
> -	# display transmit hunks
> -	if show_tx:
> -		print("   dev    len      Qdisc        "
> -			"       netdevice             free")
> -		for i in range(len(tx_free_list)):
> -			print_transmit(tx_free_list[i])
> -	if debug:
> -		print("debug buffer status")
> -		print("----------------------------")
> -		print("xmit Qdisc:remain:%d overflow:%d" %
> -			(len(tx_queue_list), of_count_tx_queue_list))
> -		print("xmit netdevice:remain:%d overflow:%d" %
> -			(len(tx_xmit_list), of_count_tx_xmit_list))
> -		print("receive:remain:%d overflow:%d" %
> -			(len(rx_skb_list), of_count_rx_skb_list))
> -
> -# called from perf, when it finds a correspoinding event
> -def irq__softirq_entry(name, context, cpu, sec, nsec, pid, comm, callchain, vec):
> -	if symbol_str("irq__softirq_entry", "vec", vec) != "NET_RX":
> -		return
> -	event_info = (name, context, cpu, nsecs(sec, nsec), pid, comm, vec)
> -	all_event_list.append(event_info)
> -
> -def irq__softirq_exit(name, context, cpu, sec, nsec, pid, comm, callchain, vec):
> -	if symbol_str("irq__softirq_entry", "vec", vec) != "NET_RX":
> -		return
> -	event_info = (name, context, cpu, nsecs(sec, nsec), pid, comm, vec)
> -	all_event_list.append(event_info)
> -
> -def irq__softirq_raise(name, context, cpu, sec, nsec, pid, comm, callchain, vec):
> -	if symbol_str("irq__softirq_entry", "vec", vec) != "NET_RX":
> -		return
> -	event_info = (name, context, cpu, nsecs(sec, nsec), pid, comm, vec)
> -	all_event_list.append(event_info)
> -
> -def irq__irq_handler_entry(name, context, cpu, sec, nsec, pid, comm,
> -			callchain, irq, irq_name):
> -	event_info = (name, context, cpu, nsecs(sec, nsec), pid, comm,
> -			irq, irq_name)
> -	all_event_list.append(event_info)
> -
> -def irq__irq_handler_exit(name, context, cpu, sec, nsec, pid, comm, callchain, irq, ret):
> -	event_info = (name, context, cpu, nsecs(sec, nsec), pid, comm, irq, ret)
> -	all_event_list.append(event_info)
> -
> -def napi__napi_poll(name, context, cpu, sec, nsec, pid, comm, callchain, napi,
> -		dev_name, work=None, budget=None):
> -	event_info = (name, context, cpu, nsecs(sec, nsec), pid, comm,
> -			napi, dev_name, work, budget)
> -	all_event_list.append(event_info)
> -
> -def net__netif_receive_skb(name, context, cpu, sec, nsec, pid, comm, callchain, skbaddr,
> -			skblen, dev_name):
> -	event_info = (name, context, cpu, nsecs(sec, nsec), pid, comm,
> -			skbaddr, skblen, dev_name)
> -	all_event_list.append(event_info)
> -
> -def net__netif_rx(name, context, cpu, sec, nsec, pid, comm, callchain, skbaddr,
> -			skblen, dev_name):
> -	event_info = (name, context, cpu, nsecs(sec, nsec), pid, comm,
> -			skbaddr, skblen, dev_name)
> -	all_event_list.append(event_info)
> -
> -def net__net_dev_queue(name, context, cpu, sec, nsec, pid, comm, callchain,
> -			skbaddr, skblen, dev_name):
> -	event_info = (name, context, cpu, nsecs(sec, nsec), pid, comm,
> -			skbaddr, skblen, dev_name)
> -	all_event_list.append(event_info)
> -
> -def net__net_dev_xmit(name, context, cpu, sec, nsec, pid, comm, callchain,
> -			skbaddr, skblen, rc, dev_name):
> -	event_info = (name, context, cpu, nsecs(sec, nsec), pid, comm,
> -			skbaddr, skblen, rc ,dev_name)
> -	all_event_list.append(event_info)
> -
> -def skb__kfree_skb(name, context, cpu, sec, nsec, pid, comm, callchain,
> -			skbaddr, location, protocol, reason):
> -	event_info = (name, context, cpu, nsecs(sec, nsec), pid, comm,
> -			skbaddr, location, protocol, reason)
> -	all_event_list.append(event_info)
> -
> -def skb__consume_skb(name, context, cpu, sec, nsec, pid, comm, callchain,
> -			skbaddr, location):
> -	event_info = (name, context, cpu, nsecs(sec, nsec), pid, comm,
> -			skbaddr)
> -	all_event_list.append(event_info)
> -
> -def skb__skb_copy_datagram_iovec(name, context, cpu, sec, nsec, pid, comm, callchain,
> -	skbaddr, skblen):
> -	event_info = (name, context, cpu, nsecs(sec, nsec), pid, comm,
> -			skbaddr, skblen)
> -	all_event_list.append(event_info)
> -
> -def handle_irq_handler_entry(event_info):
> -	(name, context, cpu, time, pid, comm, irq, irq_name) = event_info
> -	if cpu not in irq_dic.keys():
> -		irq_dic[cpu] = []
> -	irq_record = {'irq':irq, 'name':irq_name, 'cpu':cpu, 'irq_ent_t':time}
> -	irq_dic[cpu].append(irq_record)
> -
> -def handle_irq_handler_exit(event_info):
> -	(name, context, cpu, time, pid, comm, irq, ret) = event_info
> -	if cpu not in irq_dic.keys():
> -		return
> -	irq_record = irq_dic[cpu].pop()
> -	if irq != irq_record['irq']:
> -		return
> -	irq_record.update({'irq_ext_t':time})
> -	# if an irq doesn't include NET_RX softirq, drop.
> -	if 'event_list' in irq_record.keys():
> -		irq_dic[cpu].append(irq_record)
> -
> -def handle_irq_softirq_raise(event_info):
> -	(name, context, cpu, time, pid, comm, vec) = event_info
> -	if cpu not in irq_dic.keys() \
> -	or len(irq_dic[cpu]) == 0:
> -		return
> -	irq_record = irq_dic[cpu].pop()
> -	if 'event_list' in irq_record.keys():
> -		irq_event_list = irq_record['event_list']
> -	else:
> -		irq_event_list = []
> -	irq_event_list.append({'time':time, 'event':'sirq_raise'})
> -	irq_record.update({'event_list':irq_event_list})
> -	irq_dic[cpu].append(irq_record)
> -
> -def handle_irq_softirq_entry(event_info):
> -	(name, context, cpu, time, pid, comm, vec) = event_info
> -	net_rx_dic[cpu] = {'sirq_ent_t':time, 'event_list':[]}
> -
> -def handle_irq_softirq_exit(event_info):
> -	(name, context, cpu, time, pid, comm, vec) = event_info
> -	irq_list = []
> -	event_list = 0
> -	if cpu in irq_dic.keys():
> -		irq_list = irq_dic[cpu]
> -		del irq_dic[cpu]
> -	if cpu in net_rx_dic.keys():
> -		sirq_ent_t = net_rx_dic[cpu]['sirq_ent_t']
> -		event_list = net_rx_dic[cpu]['event_list']
> -		del net_rx_dic[cpu]
> -	if irq_list == [] or event_list == 0:
> -		return
> -	rec_data = {'sirq_ent_t':sirq_ent_t, 'sirq_ext_t':time,
> -			'irq_list':irq_list, 'event_list':event_list}
> -	# merge information related to a NET_RX softirq
> -	receive_hunk_list.append(rec_data)
> -
> -def handle_napi_poll(event_info):
> -	(name, context, cpu, time, pid, comm, napi, dev_name,
> -		work, budget) = event_info
> -	if cpu in net_rx_dic.keys():
> -		event_list = net_rx_dic[cpu]['event_list']
> -		rec_data = {'event_name':'napi_poll',
> -				'dev':dev_name, 'event_t':time,
> -				'work':work, 'budget':budget}
> -		event_list.append(rec_data)
> -
> -def handle_netif_rx(event_info):
> -	(name, context, cpu, time, pid, comm,
> -		skbaddr, skblen, dev_name) = event_info
> -	if cpu not in irq_dic.keys() \
> -	or len(irq_dic[cpu]) == 0:
> -		return
> -	irq_record = irq_dic[cpu].pop()
> -	if 'event_list' in irq_record.keys():
> -		irq_event_list = irq_record['event_list']
> -	else:
> -		irq_event_list = []
> -	irq_event_list.append({'time':time, 'event':'netif_rx',
> -		'skbaddr':skbaddr, 'skblen':skblen, 'dev_name':dev_name})
> -	irq_record.update({'event_list':irq_event_list})
> -	irq_dic[cpu].append(irq_record)
> -
> -def handle_netif_receive_skb(event_info):
> -	global of_count_rx_skb_list
> -
> -	(name, context, cpu, time, pid, comm,
> -		skbaddr, skblen, dev_name) = event_info
> -	if cpu in net_rx_dic.keys():
> -		rec_data = {'event_name':'netif_receive_skb',
> -				'event_t':time, 'skbaddr':skbaddr, 'len':skblen}
> -		event_list = net_rx_dic[cpu]['event_list']
> -		event_list.append(rec_data)
> -		rx_skb_list.insert(0, rec_data)
> -		if len(rx_skb_list) > buffer_budget:
> -			rx_skb_list.pop()
> -			of_count_rx_skb_list += 1
> -
> -def handle_net_dev_queue(event_info):
> -	global of_count_tx_queue_list
> -
> -	(name, context, cpu, time, pid, comm,
> -		skbaddr, skblen, dev_name) = event_info
> -	skb = {'dev':dev_name, 'skbaddr':skbaddr, 'len':skblen, 'queue_t':time}
> -	tx_queue_list.insert(0, skb)
> -	if len(tx_queue_list) > buffer_budget:
> -		tx_queue_list.pop()
> -		of_count_tx_queue_list += 1
> -
> -def handle_net_dev_xmit(event_info):
> -	global of_count_tx_xmit_list
> -
> -	(name, context, cpu, time, pid, comm,
> -		skbaddr, skblen, rc, dev_name) = event_info
> -	if rc == 0: # NETDEV_TX_OK
> -		for i in range(len(tx_queue_list)):
> -			skb = tx_queue_list[i]
> -			if skb['skbaddr'] == skbaddr:
> -				skb['xmit_t'] = time
> -				tx_xmit_list.insert(0, skb)
> -				del tx_queue_list[i]
> -				if len(tx_xmit_list) > buffer_budget:
> -					tx_xmit_list.pop()
> -					of_count_tx_xmit_list += 1
> -				return
> -
> -def handle_kfree_skb(event_info):
> -	(name, context, cpu, time, pid, comm,
> -		skbaddr, location, protocol, reason) = event_info
> -	for i in range(len(tx_queue_list)):
> -		skb = tx_queue_list[i]
> -		if skb['skbaddr'] == skbaddr:
> -			del tx_queue_list[i]
> -			return
> -	for i in range(len(tx_xmit_list)):
> -		skb = tx_xmit_list[i]
> -		if skb['skbaddr'] == skbaddr:
> -			skb['free_t'] = time
> -			tx_free_list.append(skb)
> -			del tx_xmit_list[i]
> -			return
> -	for i in range(len(rx_skb_list)):
> -		rec_data = rx_skb_list[i]
> -		if rec_data['skbaddr'] == skbaddr:
> -			rec_data.update({'handle':"kfree_skb",
> -					'comm':comm, 'pid':pid, 'comm_t':time})
> -			del rx_skb_list[i]
> -			return
> -
> -def handle_consume_skb(event_info):
> -	(name, context, cpu, time, pid, comm, skbaddr) = event_info
> -	for i in range(len(tx_xmit_list)):
> -		skb = tx_xmit_list[i]
> -		if skb['skbaddr'] == skbaddr:
> -			skb['free_t'] = time
> -			tx_free_list.append(skb)
> -			del tx_xmit_list[i]
> -			return
> -
> -def handle_skb_copy_datagram_iovec(event_info):
> -	(name, context, cpu, time, pid, comm, skbaddr, skblen) = event_info
> -	for i in range(len(rx_skb_list)):
> -		rec_data = rx_skb_list[i]
> -		if skbaddr == rec_data['skbaddr']:
> -			rec_data.update({'handle':"skb_copy_datagram_iovec",
> -					'comm':comm, 'pid':pid, 'comm_t':time})
> -			del rx_skb_list[i]
> -			return
> diff --git a/tools/perf/scripts/python/powerpc-hcalls.py b/tools/perf/scripts/python/powerpc-hcalls.py
> deleted file mode 100644
> index fedce1b68cad..000000000000
> --- a/tools/perf/scripts/python/powerpc-hcalls.py
> +++ /dev/null
> @@ -1,335 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0+
> -#
> -# Copyright (C) 2018 Ravi Bangoria, IBM Corporation
> -#
> -# Hypervisor call statisics
> -
> -from __future__ import print_function
> -
> -import os
> -import sys
> -
> -sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> -	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> -
> -from perf_trace_context import *
> -from Core import *
> -from Util import *
> -
> -# output: {
> -#	opcode: {
> -#		'min': minimum time nsec
> -#		'max': maximum time nsec
> -#		'time': average time nsec
> -#		'cnt': counter
> -#	} ...
> -# }
> -output = {}
> -sort_key = 'count'
> -
> -# d_enter: {
> -#	cpu: {
> -#		opcode: nsec
> -#	} ...
> -# }
> -d_enter = {}
> -
> -hcall_table = {
> -	4: 'H_REMOVE',
> -	8: 'H_ENTER',
> -	12: 'H_READ',
> -	16: 'H_CLEAR_MOD',
> -	20: 'H_CLEAR_REF',
> -	24: 'H_PROTECT',
> -	28: 'H_GET_TCE',
> -	32: 'H_PUT_TCE',
> -	36: 'H_SET_SPRG0',
> -	40: 'H_SET_DABR',
> -	44: 'H_PAGE_INIT',
> -	48: 'H_SET_ASR',
> -	52: 'H_ASR_ON',
> -	56: 'H_ASR_OFF',
> -	60: 'H_LOGICAL_CI_LOAD',
> -	64: 'H_LOGICAL_CI_STORE',
> -	68: 'H_LOGICAL_CACHE_LOAD',
> -	72: 'H_LOGICAL_CACHE_STORE',
> -	76: 'H_LOGICAL_ICBI',
> -	80: 'H_LOGICAL_DCBF',
> -	84: 'H_GET_TERM_CHAR',
> -	88: 'H_PUT_TERM_CHAR',
> -	92: 'H_REAL_TO_LOGICAL',
> -	96: 'H_HYPERVISOR_DATA',
> -	100: 'H_EOI',
> -	104: 'H_CPPR',
> -	108: 'H_IPI',
> -	112: 'H_IPOLL',
> -	116: 'H_XIRR',
> -	120: 'H_MIGRATE_DMA',
> -	124: 'H_PERFMON',
> -	220: 'H_REGISTER_VPA',
> -	224: 'H_CEDE',
> -	228: 'H_CONFER',
> -	232: 'H_PROD',
> -	236: 'H_GET_PPP',
> -	240: 'H_SET_PPP',
> -	244: 'H_PURR',
> -	248: 'H_PIC',
> -	252: 'H_REG_CRQ',
> -	256: 'H_FREE_CRQ',
> -	260: 'H_VIO_SIGNAL',
> -	264: 'H_SEND_CRQ',
> -	272: 'H_COPY_RDMA',
> -	276: 'H_REGISTER_LOGICAL_LAN',
> -	280: 'H_FREE_LOGICAL_LAN',
> -	284: 'H_ADD_LOGICAL_LAN_BUFFER',
> -	288: 'H_SEND_LOGICAL_LAN',
> -	292: 'H_BULK_REMOVE',
> -	304: 'H_MULTICAST_CTRL',
> -	308: 'H_SET_XDABR',
> -	312: 'H_STUFF_TCE',
> -	316: 'H_PUT_TCE_INDIRECT',
> -	332: 'H_CHANGE_LOGICAL_LAN_MAC',
> -	336: 'H_VTERM_PARTNER_INFO',
> -	340: 'H_REGISTER_VTERM',
> -	344: 'H_FREE_VTERM',
> -	348: 'H_RESET_EVENTS',
> -	352: 'H_ALLOC_RESOURCE',
> -	356: 'H_FREE_RESOURCE',
> -	360: 'H_MODIFY_QP',
> -	364: 'H_QUERY_QP',
> -	368: 'H_REREGISTER_PMR',
> -	372: 'H_REGISTER_SMR',
> -	376: 'H_QUERY_MR',
> -	380: 'H_QUERY_MW',
> -	384: 'H_QUERY_HCA',
> -	388: 'H_QUERY_PORT',
> -	392: 'H_MODIFY_PORT',
> -	396: 'H_DEFINE_AQP1',
> -	400: 'H_GET_TRACE_BUFFER',
> -	404: 'H_DEFINE_AQP0',
> -	408: 'H_RESIZE_MR',
> -	412: 'H_ATTACH_MCQP',
> -	416: 'H_DETACH_MCQP',
> -	420: 'H_CREATE_RPT',
> -	424: 'H_REMOVE_RPT',
> -	428: 'H_REGISTER_RPAGES',
> -	432: 'H_DISABLE_AND_GET',
> -	436: 'H_ERROR_DATA',
> -	440: 'H_GET_HCA_INFO',
> -	444: 'H_GET_PERF_COUNT',
> -	448: 'H_MANAGE_TRACE',
> -	456: 'H_GET_CPU_CHARACTERISTICS',
> -	468: 'H_FREE_LOGICAL_LAN_BUFFER',
> -	472: 'H_POLL_PENDING',
> -	484: 'H_QUERY_INT_STATE',
> -	580: 'H_ILLAN_ATTRIBUTES',
> -	584: 'H_ADD_LOGICAL_LAN_BUFFERS',
> -	592: 'H_MODIFY_HEA_QP',
> -	596: 'H_QUERY_HEA_QP',
> -	600: 'H_QUERY_HEA',
> -	604: 'H_QUERY_HEA_PORT',
> -	608: 'H_MODIFY_HEA_PORT',
> -	612: 'H_REG_BCMC',
> -	616: 'H_DEREG_BCMC',
> -	620: 'H_REGISTER_HEA_RPAGES',
> -	624: 'H_DISABLE_AND_GET_HEA',
> -	628: 'H_GET_HEA_INFO',
> -	632: 'H_ALLOC_HEA_RESOURCE',
> -	644: 'H_ADD_CONN',
> -	648: 'H_DEL_CONN',
> -	664: 'H_JOIN',
> -	672: 'H_VASI_SIGNAL',
> -	676: 'H_VASI_STATE',
> -	680: 'H_VIOCTL',
> -	688: 'H_ENABLE_CRQ',
> -	696: 'H_GET_EM_PARMS',
> -	720: 'H_SET_MPP',
> -	724: 'H_GET_MPP',
> -	732: 'H_REG_SUB_CRQ',
> -	736: 'H_FREE_SUB_CRQ',
> -	740: 'H_SEND_SUB_CRQ',
> -	744: 'H_SEND_SUB_CRQ_INDIRECT',
> -	748: 'H_HOME_NODE_ASSOCIATIVITY',
> -	756: 'H_BEST_ENERGY',
> -	764: 'H_XIRR_X',
> -	768: 'H_RANDOM',
> -	772: 'H_COP',
> -	788: 'H_GET_MPP_X',
> -	796: 'H_SET_MODE',
> -	808: 'H_BLOCK_REMOVE',
> -	856: 'H_CLEAR_HPT',
> -	864: 'H_REQUEST_VMC',
> -	876: 'H_RESIZE_HPT_PREPARE',
> -	880: 'H_RESIZE_HPT_COMMIT',
> -	892: 'H_REGISTER_PROC_TBL',
> -	896: 'H_SIGNAL_SYS_RESET',
> -	904: 'H_ALLOCATE_VAS_WINDOW',
> -	908: 'H_MODIFY_VAS_WINDOW',
> -	912: 'H_DEALLOCATE_VAS_WINDOW',
> -	916: 'H_QUERY_VAS_WINDOW',
> -	920: 'H_QUERY_VAS_CAPABILITIES',
> -	924: 'H_QUERY_NX_CAPABILITIES',
> -	928: 'H_GET_NX_FAULT',
> -	936: 'H_INT_GET_SOURCE_INFO',
> -	940: 'H_INT_SET_SOURCE_CONFIG',
> -	944: 'H_INT_GET_SOURCE_CONFIG',
> -	948: 'H_INT_GET_QUEUE_INFO',
> -	952: 'H_INT_SET_QUEUE_CONFIG',
> -	956: 'H_INT_GET_QUEUE_CONFIG',
> -	960: 'H_INT_SET_OS_REPORTING_LINE',
> -	964: 'H_INT_GET_OS_REPORTING_LINE',
> -	968: 'H_INT_ESB',
> -	972: 'H_INT_SYNC',
> -	976: 'H_INT_RESET',
> -	996: 'H_SCM_READ_METADATA',
> -	1000: 'H_SCM_WRITE_METADATA',
> -	1004: 'H_SCM_BIND_MEM',
> -	1008: 'H_SCM_UNBIND_MEM',
> -	1012: 'H_SCM_QUERY_BLOCK_MEM_BINDING',
> -	1016: 'H_SCM_QUERY_LOGICAL_MEM_BINDING',
> -	1020: 'H_SCM_UNBIND_ALL',
> -	1024: 'H_SCM_HEALTH',
> -	1048: 'H_SCM_PERFORMANCE_STATS',
> -	1052: 'H_PKS_GET_CONFIG',
> -	1056: 'H_PKS_SET_PASSWORD',
> -	1060: 'H_PKS_GEN_PASSWORD',
> -	1068: 'H_PKS_WRITE_OBJECT',
> -	1072: 'H_PKS_GEN_KEY',
> -	1076: 'H_PKS_READ_OBJECT',
> -	1080: 'H_PKS_REMOVE_OBJECT',
> -	1084: 'H_PKS_CONFIRM_OBJECT_FLUSHED',
> -	1096: 'H_RPT_INVALIDATE',
> -	1100: 'H_SCM_FLUSH',
> -	1104: 'H_GET_ENERGY_SCALE_INFO',
> -	1108: 'H_PKS_SIGNED_UPDATE',
> -	1112: 'H_HTM',
> -	1116: 'H_WATCHDOG',
> -	# Platform specific hcalls used by KVM on PowerVM
> -	1120: 'H_GUEST_GET_CAPABILITIES',
> -	1124: 'H_GUEST_SET_CAPABILITIES',
> -	1136: 'H_GUEST_CREATE',
> -	1140: 'H_GUEST_CREATE_VCPU',
> -	1144: 'H_GUEST_GET_STATE',
> -	1148: 'H_GUEST_SET_STATE',
> -	1152: 'H_GUEST_RUN_VCPU',
> -	1156: 'H_GUEST_COPY_MEMORY',
> -	1160: 'H_GUEST_DELETE',
> -	# Key wrapping hcalls
> -	1168: 'H_PKS_WRAP_OBJECT',
> -	1172: 'H_PKS_UNWRAP_OBJECT',
> -	# Platform-specific hcalls used by the Ultravisor
> -	61184: 'H_SVM_PAGE_IN',
> -	61188: 'H_SVM_PAGE_OUT',
> -	61192: 'H_SVM_INIT_START',
> -	61196: 'H_SVM_INIT_DONE',
> -	61204: 'H_SVM_INIT_ABORT',
> -	# Platform specific hcalls used by KVM
> -	61440: 'H_RTAS',
> -	# Platform specific hcalls used by QEMU/SLOF
> -	61441: 'H_LOGICAL_MEMOP',
> -	61442: 'H_CAS',
> -	61443: 'H_UPDATE_DT',
> -	# Platform specific hcalls provided by PHYP
> -	61560: 'H_GET_24X7_CATALOG_PAGE',
> -	61564: 'H_GET_24X7_DATA',
> -	61568: 'H_GET_PERF_COUNTER_INFO',
> -	# Platform-specific hcalls used for nested HV KVM
> -	63488: 'H_SET_PARTITION_TABLE',
> -	63492: 'H_ENTER_NESTED',
> -	63496: 'H_TLB_INVALIDATE',
> -	63500: 'H_COPY_TOFROM_GUEST',
> -}
> -
> -def hcall_table_lookup(opcode):
> -	if (opcode in hcall_table):
> -		return hcall_table[opcode]
> -	else:
> -		return opcode
> -
> -print_ptrn = '%-28s%10s%10s%10s%10s'
> -
> -def sort_output(opcode):
> -	stats = output[opcode]
> -
> -	if sort_key == 'min':
> -		return stats['min']
> -	if sort_key == 'max':
> -		return stats['max']
> -	if sort_key == 'avg':
> -		return stats['time'] // stats['cnt']
> -
> -	return stats['cnt']
> -
> -def trace_begin():
> -	global sort_key
> -
> -	valid_sort_keys = ['count', 'min', 'max', 'avg']
> -
> -	i = 1
> -	while i < len(sys.argv):
> -		arg = sys.argv[i]
> -
> -		if arg == '-s' or arg == '--sort':
> -			if i + 1 >= len(sys.argv):
> -				print("Error: -s/--sort requires a sort key argument")
> -				sys.exit(1)
> -			sort_key = sys.argv[i + 1]
> -			i += 2
> -			continue
> -
> -		if arg.startswith('--sort='):
> -			sort_key = arg.split('=', 1)[1]
> -			i += 1
> -			continue
> -
> -		i += 1
> -
> -	if sort_key not in valid_sort_keys:
> -		print(f"Error: Invalid sort key '{sort_key}'. Valid options are: {', '.join(valid_sort_keys)}")
> -		sys.exit(1)
> -
> -	print("SORT KEY =", sort_key)
> -
> -def trace_end():
> -	print(print_ptrn % ('hcall', 'count', 'min(ns)', 'max(ns)', 'avg(ns)'))
> -	print('-' * 68)
> -	for opcode in sorted(output, key = sort_output,
> -                            reverse=True):
> -		h_name = hcall_table_lookup(opcode)
> -		time = output[opcode]['time']
> -		cnt = output[opcode]['cnt']
> -		min_t = output[opcode]['min']
> -		max_t = output[opcode]['max']
> -
> -		print(print_ptrn % (h_name, cnt, min_t, max_t, time//cnt))
> -
> -def powerpc__hcall_exit(name, context, cpu, sec, nsec, pid, comm, callchain,
> -			opcode, retval):
> -	if (cpu in d_enter and opcode in d_enter[cpu]):
> -		diff = nsecs(sec, nsec) - d_enter[cpu][opcode]
> -
> -		if (opcode in output):
> -			output[opcode]['time'] += diff
> -			output[opcode]['cnt'] += 1
> -			if (output[opcode]['min'] > diff):
> -				output[opcode]['min'] = diff
> -			if (output[opcode]['max'] < diff):
> -				output[opcode]['max'] = diff
> -		else:
> -			output[opcode] = {
> -				'time': diff,
> -				'cnt': 1,
> -				'min': diff,
> -				'max': diff,
> -			}
> -
> -		del d_enter[cpu][opcode]
> -#	else:
> -#		print("Can't find matching hcall_enter event. Ignoring sample")
> -
> -def powerpc__hcall_entry(event_name, context, cpu, sec, nsec, pid, comm,
> -			 callchain, opcode):
> -		if (cpu in d_enter):
> -			d_enter[cpu][opcode] = nsecs(sec, nsec)
> -		else:
> -			d_enter[cpu] = {opcode: nsecs(sec, nsec)}
> diff --git a/tools/perf/scripts/python/sched-migration.py b/tools/perf/scripts/python/sched-migration.py
> deleted file mode 100644
> index 8196e3087c9e..000000000000
> --- a/tools/perf/scripts/python/sched-migration.py
> +++ /dev/null
> @@ -1,462 +0,0 @@
> -# Cpu task migration overview toy
> -#
> -# Copyright (C) 2010 Frederic Weisbecker <fweisbec@gmail.com>
> -#
> -# perf script event handlers have been generated by perf script -g python
> -#
> -# This software is distributed under the terms of the GNU General
> -# Public License ("GPL") version 2 as published by the Free Software
> -# Foundation.
> -from __future__ import print_function
> -
> -import os
> -import sys
> -
> -from collections import defaultdict
> -try:
> -	from UserList import UserList
> -except ImportError:
> -	# Python 3: UserList moved to the collections package
> -	from collections import UserList
> -
> -sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> -	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> -sys.path.append('scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> -
> -from perf_trace_context import *
> -from Core import *
> -from SchedGui import *
> -
> -
> -threads = { 0 : "idle"}
> -
> -def thread_name(pid):
> -	return "%s:%d" % (threads[pid], pid)
> -
> -class RunqueueEventUnknown:
> -	@staticmethod
> -	def color():
> -		return None
> -
> -	def __repr__(self):
> -		return "unknown"
> -
> -class RunqueueEventSleep:
> -	@staticmethod
> -	def color():
> -		return (0, 0, 0xff)
> -
> -	def __init__(self, sleeper):
> -		self.sleeper = sleeper
> -
> -	def __repr__(self):
> -		return "%s gone to sleep" % thread_name(self.sleeper)
> -
> -class RunqueueEventWakeup:
> -	@staticmethod
> -	def color():
> -		return (0xff, 0xff, 0)
> -
> -	def __init__(self, wakee):
> -		self.wakee = wakee
> -
> -	def __repr__(self):
> -		return "%s woke up" % thread_name(self.wakee)
> -
> -class RunqueueEventFork:
> -	@staticmethod
> -	def color():
> -		return (0, 0xff, 0)
> -
> -	def __init__(self, child):
> -		self.child = child
> -
> -	def __repr__(self):
> -		return "new forked task %s" % thread_name(self.child)
> -
> -class RunqueueMigrateIn:
> -	@staticmethod
> -	def color():
> -		return (0, 0xf0, 0xff)
> -
> -	def __init__(self, new):
> -		self.new = new
> -
> -	def __repr__(self):
> -		return "task migrated in %s" % thread_name(self.new)
> -
> -class RunqueueMigrateOut:
> -	@staticmethod
> -	def color():
> -		return (0xff, 0, 0xff)
> -
> -	def __init__(self, old):
> -		self.old = old
> -
> -	def __repr__(self):
> -		return "task migrated out %s" % thread_name(self.old)
> -
> -class RunqueueSnapshot:
> -	def __init__(self, tasks = [0], event = RunqueueEventUnknown()):
> -		self.tasks = tuple(tasks)
> -		self.event = event
> -
> -	def sched_switch(self, prev, prev_state, next):
> -		event = RunqueueEventUnknown()
> -
> -		if taskState(prev_state) == "R" and next in self.tasks \
> -			and prev in self.tasks:
> -			return self
> -
> -		if taskState(prev_state) != "R":
> -			event = RunqueueEventSleep(prev)
> -
> -		next_tasks = list(self.tasks[:])
> -		if prev in self.tasks:
> -			if taskState(prev_state) != "R":
> -				next_tasks.remove(prev)
> -		elif taskState(prev_state) == "R":
> -			next_tasks.append(prev)
> -
> -		if next not in next_tasks:
> -			next_tasks.append(next)
> -
> -		return RunqueueSnapshot(next_tasks, event)
> -
> -	def migrate_out(self, old):
> -		if old not in self.tasks:
> -			return self
> -		next_tasks = [task for task in self.tasks if task != old]
> -
> -		return RunqueueSnapshot(next_tasks, RunqueueMigrateOut(old))
> -
> -	def __migrate_in(self, new, event):
> -		if new in self.tasks:
> -			self.event = event
> -			return self
> -		next_tasks = self.tasks[:] + tuple([new])
> -
> -		return RunqueueSnapshot(next_tasks, event)
> -
> -	def migrate_in(self, new):
> -		return self.__migrate_in(new, RunqueueMigrateIn(new))
> -
> -	def wake_up(self, new):
> -		return self.__migrate_in(new, RunqueueEventWakeup(new))
> -
> -	def wake_up_new(self, new):
> -		return self.__migrate_in(new, RunqueueEventFork(new))
> -
> -	def load(self):
> -		""" Provide the number of tasks on the runqueue.
> -		    Don't count idle"""
> -		return len(self.tasks) - 1
> -
> -	def __repr__(self):
> -		ret = self.tasks.__repr__()
> -		ret += self.origin_tostring()
> -
> -		return ret
> -
> -class TimeSlice:
> -	def __init__(self, start, prev):
> -		self.start = start
> -		self.prev = prev
> -		self.end = start
> -		# cpus that triggered the event
> -		self.event_cpus = []
> -		if prev is not None:
> -			self.total_load = prev.total_load
> -			self.rqs = prev.rqs.copy()
> -		else:
> -			self.rqs = defaultdict(RunqueueSnapshot)
> -			self.total_load = 0
> -
> -	def __update_total_load(self, old_rq, new_rq):
> -		diff = new_rq.load() - old_rq.load()
> -		self.total_load += diff
> -
> -	def sched_switch(self, ts_list, prev, prev_state, next, cpu):
> -		old_rq = self.prev.rqs[cpu]
> -		new_rq = old_rq.sched_switch(prev, prev_state, next)
> -
> -		if old_rq is new_rq:
> -			return
> -
> -		self.rqs[cpu] = new_rq
> -		self.__update_total_load(old_rq, new_rq)
> -		ts_list.append(self)
> -		self.event_cpus = [cpu]
> -
> -	def migrate(self, ts_list, new, old_cpu, new_cpu):
> -		if old_cpu == new_cpu:
> -			return
> -		old_rq = self.prev.rqs[old_cpu]
> -		out_rq = old_rq.migrate_out(new)
> -		self.rqs[old_cpu] = out_rq
> -		self.__update_total_load(old_rq, out_rq)
> -
> -		new_rq = self.prev.rqs[new_cpu]
> -		in_rq = new_rq.migrate_in(new)
> -		self.rqs[new_cpu] = in_rq
> -		self.__update_total_load(new_rq, in_rq)
> -
> -		ts_list.append(self)
> -
> -		if old_rq is not out_rq:
> -			self.event_cpus.append(old_cpu)
> -		self.event_cpus.append(new_cpu)
> -
> -	def wake_up(self, ts_list, pid, cpu, fork):
> -		old_rq = self.prev.rqs[cpu]
> -		if fork:
> -			new_rq = old_rq.wake_up_new(pid)
> -		else:
> -			new_rq = old_rq.wake_up(pid)
> -
> -		if new_rq is old_rq:
> -			return
> -		self.rqs[cpu] = new_rq
> -		self.__update_total_load(old_rq, new_rq)
> -		ts_list.append(self)
> -		self.event_cpus = [cpu]
> -
> -	def next(self, t):
> -		self.end = t
> -		return TimeSlice(t, self)
> -
> -class TimeSliceList(UserList):
> -	def __init__(self, arg = []):
> -		self.data = arg
> -
> -	def get_time_slice(self, ts):
> -		if len(self.data) == 0:
> -			slice = TimeSlice(ts, TimeSlice(-1, None))
> -		else:
> -			slice = self.data[-1].next(ts)
> -		return slice
> -
> -	def find_time_slice(self, ts):
> -		start = 0
> -		end = len(self.data)
> -		found = -1
> -		searching = True
> -		while searching:
> -			if start == end or start == end - 1:
> -				searching = False
> -
> -			i = (end + start) / 2
> -			if self.data[i].start <= ts and self.data[i].end >= ts:
> -				found = i
> -				end = i
> -				continue
> -
> -			if self.data[i].end < ts:
> -				start = i
> -
> -			elif self.data[i].start > ts:
> -				end = i
> -
> -		return found
> -
> -	def set_root_win(self, win):
> -		self.root_win = win
> -
> -	def mouse_down(self, cpu, t):
> -		idx = self.find_time_slice(t)
> -		if idx == -1:
> -			return
> -
> -		ts = self[idx]
> -		rq = ts.rqs[cpu]
> -		raw = "CPU: %d\n" % cpu
> -		raw += "Last event : %s\n" % rq.event.__repr__()
> -		raw += "Timestamp : %d.%06d\n" % (ts.start / (10 ** 9), (ts.start % (10 ** 9)) / 1000)
> -		raw += "Duration : %6d us\n" % ((ts.end - ts.start) / (10 ** 6))
> -		raw += "Load = %d\n" % rq.load()
> -		for t in rq.tasks:
> -			raw += "%s \n" % thread_name(t)
> -
> -		self.root_win.update_summary(raw)
> -
> -	def update_rectangle_cpu(self, slice, cpu):
> -		rq = slice.rqs[cpu]
> -
> -		if slice.total_load != 0:
> -			load_rate = rq.load() / float(slice.total_load)
> -		else:
> -			load_rate = 0
> -
> -		red_power = int(0xff - (0xff * load_rate))
> -		color = (0xff, red_power, red_power)
> -
> -		top_color = None
> -
> -		if cpu in slice.event_cpus:
> -			top_color = rq.event.color()
> -
> -		self.root_win.paint_rectangle_zone(cpu, color, top_color, slice.start, slice.end)
> -
> -	def fill_zone(self, start, end):
> -		i = self.find_time_slice(start)
> -		if i == -1:
> -			return
> -
> -		for i in range(i, len(self.data)):
> -			timeslice = self.data[i]
> -			if timeslice.start > end:
> -				return
> -
> -			for cpu in timeslice.rqs:
> -				self.update_rectangle_cpu(timeslice, cpu)
> -
> -	def interval(self):
> -		if len(self.data) == 0:
> -			return (0, 0)
> -
> -		return (self.data[0].start, self.data[-1].end)
> -
> -	def nr_rectangles(self):
> -		last_ts = self.data[-1]
> -		max_cpu = 0
> -		for cpu in last_ts.rqs:
> -			if cpu > max_cpu:
> -				max_cpu = cpu
> -		return max_cpu
> -
> -
> -class SchedEventProxy:
> -	def __init__(self):
> -		self.current_tsk = defaultdict(lambda : -1)
> -		self.timeslices = TimeSliceList()
> -
> -	def sched_switch(self, headers, prev_comm, prev_pid, prev_prio, prev_state,
> -			 next_comm, next_pid, next_prio):
> -		""" Ensure the task we sched out this cpu is really the one
> -		    we logged. Otherwise we may have missed traces """
> -
> -		on_cpu_task = self.current_tsk[headers.cpu]
> -
> -		if on_cpu_task != -1 and on_cpu_task != prev_pid:
> -			print("Sched switch event rejected ts: %s cpu: %d prev: %s(%d) next: %s(%d)" % \
> -				headers.ts_format(), headers.cpu, prev_comm, prev_pid, next_comm, next_pid)
> -
> -		threads[prev_pid] = prev_comm
> -		threads[next_pid] = next_comm
> -		self.current_tsk[headers.cpu] = next_pid
> -
> -		ts = self.timeslices.get_time_slice(headers.ts())
> -		ts.sched_switch(self.timeslices, prev_pid, prev_state, next_pid, headers.cpu)
> -
> -	def migrate(self, headers, pid, prio, orig_cpu, dest_cpu):
> -		ts = self.timeslices.get_time_slice(headers.ts())
> -		ts.migrate(self.timeslices, pid, orig_cpu, dest_cpu)
> -
> -	def wake_up(self, headers, comm, pid, success, target_cpu, fork):
> -		if success == 0:
> -			return
> -		ts = self.timeslices.get_time_slice(headers.ts())
> -		ts.wake_up(self.timeslices, pid, target_cpu, fork)
> -
> -
> -def trace_begin():
> -	global parser
> -	parser = SchedEventProxy()
> -
> -def trace_end():
> -	app = wx.App(False)
> -	timeslices = parser.timeslices
> -	frame = RootFrame(timeslices, "Migration")
> -	app.MainLoop()
> -
> -def sched__sched_stat_runtime(event_name, context, common_cpu,
> -	common_secs, common_nsecs, common_pid, common_comm,
> -	common_callchain, comm, pid, runtime, vruntime):
> -	pass
> -
> -def sched__sched_stat_iowait(event_name, context, common_cpu,
> -	common_secs, common_nsecs, common_pid, common_comm,
> -	common_callchain, comm, pid, delay):
> -	pass
> -
> -def sched__sched_stat_sleep(event_name, context, common_cpu,
> -	common_secs, common_nsecs, common_pid, common_comm,
> -	common_callchain, comm, pid, delay):
> -	pass
> -
> -def sched__sched_stat_wait(event_name, context, common_cpu,
> -	common_secs, common_nsecs, common_pid, common_comm,
> -	common_callchain, comm, pid, delay):
> -	pass
> -
> -def sched__sched_process_fork(event_name, context, common_cpu,
> -	common_secs, common_nsecs, common_pid, common_comm,
> -	common_callchain, parent_comm, parent_pid, child_comm, child_pid):
> -	pass
> -
> -def sched__sched_process_wait(event_name, context, common_cpu,
> -	common_secs, common_nsecs, common_pid, common_comm,
> -	common_callchain, comm, pid, prio):
> -	pass
> -
> -def sched__sched_process_exit(event_name, context, common_cpu,
> -	common_secs, common_nsecs, common_pid, common_comm,
> -	common_callchain, comm, pid, prio):
> -	pass
> -
> -def sched__sched_process_free(event_name, context, common_cpu,
> -	common_secs, common_nsecs, common_pid, common_comm,
> -	common_callchain, comm, pid, prio):
> -	pass
> -
> -def sched__sched_migrate_task(event_name, context, common_cpu,
> -	common_secs, common_nsecs, common_pid, common_comm,
> -	common_callchain, comm, pid, prio, orig_cpu,
> -	dest_cpu):
> -	headers = EventHeaders(common_cpu, common_secs, common_nsecs,
> -				common_pid, common_comm, common_callchain)
> -	parser.migrate(headers, pid, prio, orig_cpu, dest_cpu)
> -
> -def sched__sched_switch(event_name, context, common_cpu,
> -	common_secs, common_nsecs, common_pid, common_comm, common_callchain,
> -	prev_comm, prev_pid, prev_prio, prev_state,
> -	next_comm, next_pid, next_prio):
> -
> -	headers = EventHeaders(common_cpu, common_secs, common_nsecs,
> -				common_pid, common_comm, common_callchain)
> -	parser.sched_switch(headers, prev_comm, prev_pid, prev_prio, prev_state,
> -			 next_comm, next_pid, next_prio)
> -
> -def sched__sched_wakeup_new(event_name, context, common_cpu,
> -	common_secs, common_nsecs, common_pid, common_comm,
> -	common_callchain, comm, pid, prio, success,
> -	target_cpu):
> -	headers = EventHeaders(common_cpu, common_secs, common_nsecs,
> -				common_pid, common_comm, common_callchain)
> -	parser.wake_up(headers, comm, pid, success, target_cpu, 1)
> -
> -def sched__sched_wakeup(event_name, context, common_cpu,
> -	common_secs, common_nsecs, common_pid, common_comm,
> -	common_callchain, comm, pid, prio, success,
> -	target_cpu):
> -	headers = EventHeaders(common_cpu, common_secs, common_nsecs,
> -				common_pid, common_comm, common_callchain)
> -	parser.wake_up(headers, comm, pid, success, target_cpu, 0)
> -
> -def sched__sched_wait_task(event_name, context, common_cpu,
> -	common_secs, common_nsecs, common_pid, common_comm,
> -	common_callchain, comm, pid, prio):
> -	pass
> -
> -def sched__sched_kthread_stop_ret(event_name, context, common_cpu,
> -	common_secs, common_nsecs, common_pid, common_comm,
> -	common_callchain, ret):
> -	pass
> -
> -def sched__sched_kthread_stop(event_name, context, common_cpu,
> -	common_secs, common_nsecs, common_pid, common_comm,
> -	common_callchain, comm, pid):
> -	pass
> -
> -def trace_unhandled(event_name, context, event_fields_dict):
> -	pass
> diff --git a/tools/perf/scripts/python/sctop.py b/tools/perf/scripts/python/sctop.py
> deleted file mode 100644
> index 6e0278dcb092..000000000000
> --- a/tools/perf/scripts/python/sctop.py
> +++ /dev/null
> @@ -1,89 +0,0 @@
> -# system call top
> -# (c) 2010, Tom Zanussi <tzanussi@gmail.com>
> -# Licensed under the terms of the GNU GPL License version 2
> -#
> -# Periodically displays system-wide system call totals, broken down by
> -# syscall.  If a [comm] arg is specified, only syscalls called by
> -# [comm] are displayed. If an [interval] arg is specified, the display
> -# will be refreshed every [interval] seconds.  The default interval is
> -# 3 seconds.
> -
> -from __future__ import print_function
> -
> -import os, sys, time
> -
> -try:
> -	import thread
> -except ImportError:
> -	import _thread as thread
> -
> -sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> -	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> -
> -from perf_trace_context import *
> -from Core import *
> -from Util import *
> -
> -usage = "perf script -s sctop.py [comm] [interval]\n";
> -
> -for_comm = None
> -default_interval = 3
> -interval = default_interval
> -
> -if len(sys.argv) > 3:
> -	sys.exit(usage)
> -
> -if len(sys.argv) > 2:
> -	for_comm = sys.argv[1]
> -	interval = int(sys.argv[2])
> -elif len(sys.argv) > 1:
> -	try:
> -		interval = int(sys.argv[1])
> -	except ValueError:
> -		for_comm = sys.argv[1]
> -		interval = default_interval
> -
> -syscalls = autodict()
> -
> -def trace_begin():
> -	thread.start_new_thread(print_syscall_totals, (interval,))
> -	pass
> -
> -def raw_syscalls__sys_enter(event_name, context, common_cpu,
> -	common_secs, common_nsecs, common_pid, common_comm,
> -	common_callchain, id, args):
> -	if for_comm is not None:
> -		if common_comm != for_comm:
> -			return
> -	try:
> -		syscalls[id] += 1
> -	except TypeError:
> -		syscalls[id] = 1
> -
> -def syscalls__sys_enter(event_name, context, common_cpu,
> -	common_secs, common_nsecs, common_pid, common_comm,
> -	id, args):
> -	raw_syscalls__sys_enter(**locals())
> -
> -def print_syscall_totals(interval):
> -	while 1:
> -		clear_term()
> -		if for_comm is not None:
> -			print("\nsyscall events for %s:\n" % (for_comm))
> -		else:
> -			print("\nsyscall events:\n")
> -
> -		print("%-40s  %10s" % ("event", "count"))
> -		print("%-40s  %10s" %
> -			("----------------------------------------",
> -			"----------"))
> -
> -		for id, val in sorted(syscalls.items(),
> -				key = lambda kv: (kv[1], kv[0]),
> -				reverse = True):
> -			try:
> -				print("%-40s  %10d" % (syscall_name(id), val))
> -			except TypeError:
> -				pass
> -		syscalls.clear()
> -		time.sleep(interval)
> diff --git a/tools/perf/scripts/python/stackcollapse.py b/tools/perf/scripts/python/stackcollapse.py
> deleted file mode 100755
> index b1c4def1410a..000000000000
> --- a/tools/perf/scripts/python/stackcollapse.py
> +++ /dev/null
> @@ -1,127 +0,0 @@
> -# stackcollapse.py - format perf samples with one line per distinct call stack
> -# SPDX-License-Identifier: GPL-2.0
> -#
> -# This script's output has two space-separated fields.  The first is a semicolon
> -# separated stack including the program name (from the "comm" field) and the
> -# function names from the call stack.  The second is a count:
> -#
> -#  swapper;start_kernel;rest_init;cpu_idle;default_idle;native_safe_halt 2
> -#
> -# The file is sorted according to the first field.
> -#
> -# Input may be created and processed using:
> -#
> -#  perf record -a -g -F 99 sleep 60
> -#  perf script report stackcollapse > out.stacks-folded
> -#
> -# (perf script record stackcollapse works too).
> -#
> -# Written by Paolo Bonzini <pbonzini@redhat.com>
> -# Based on Brendan Gregg's stackcollapse-perf.pl script.
> -
> -from __future__ import print_function
> -
> -import os
> -import sys
> -from collections import defaultdict
> -from optparse import OptionParser, make_option
> -
> -sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> -    '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> -
> -from perf_trace_context import *
> -from Core import *
> -from EventClass import *
> -
> -# command line parsing
> -
> -option_list = [
> -    # formatting options for the bottom entry of the stack
> -    make_option("--include-tid", dest="include_tid",
> -                 action="store_true", default=False,
> -                 help="include thread id in stack"),
> -    make_option("--include-pid", dest="include_pid",
> -                 action="store_true", default=False,
> -                 help="include process id in stack"),
> -    make_option("--no-comm", dest="include_comm",
> -                 action="store_false", default=True,
> -                 help="do not separate stacks according to comm"),
> -    make_option("--tidy-java", dest="tidy_java",
> -                 action="store_true", default=False,
> -                 help="beautify Java signatures"),
> -    make_option("--kernel", dest="annotate_kernel",
> -                 action="store_true", default=False,
> -                 help="annotate kernel functions with _[k]")
> -]
> -
> -parser = OptionParser(option_list=option_list)
> -(opts, args) = parser.parse_args()
> -
> -if len(args) != 0:
> -    parser.error("unexpected command line argument")
> -if opts.include_tid and not opts.include_comm:
> -    parser.error("requesting tid but not comm is invalid")
> -if opts.include_pid and not opts.include_comm:
> -    parser.error("requesting pid but not comm is invalid")
> -
> -# event handlers
> -
> -lines = defaultdict(lambda: 0)
> -
> -def process_event(param_dict):
> -    def tidy_function_name(sym, dso):
> -        if sym is None:
> -            sym = '[unknown]'
> -
> -        sym = sym.replace(';', ':')
> -        if opts.tidy_java:
> -            # the original stackcollapse-perf.pl script gives the
> -            # example of converting this:
> -            #    Lorg/mozilla/javascript/MemberBox;.<init>(Ljava/lang/reflect/Method;)V
> -            # to this:
> -            #    org/mozilla/javascript/MemberBox:.init
> -            sym = sym.replace('<', '')
> -            sym = sym.replace('>', '')
> -            if sym[0] == 'L' and sym.find('/'):
> -                sym = sym[1:]
> -            try:
> -                sym = sym[:sym.index('(')]
> -            except ValueError:
> -                pass
> -
> -        if opts.annotate_kernel and dso == '[kernel.kallsyms]':
> -            return sym + '_[k]'
> -        else:
> -            return sym
> -
> -    stack = list()
> -    if 'callchain' in param_dict:
> -        for entry in param_dict['callchain']:
> -            entry.setdefault('sym', dict())
> -            entry['sym'].setdefault('name', None)
> -            entry.setdefault('dso', None)
> -            stack.append(tidy_function_name(entry['sym']['name'],
> -                                            entry['dso']))
> -    else:
> -        param_dict.setdefault('symbol', None)
> -        param_dict.setdefault('dso', None)
> -        stack.append(tidy_function_name(param_dict['symbol'],
> -                                        param_dict['dso']))
> -
> -    if opts.include_comm:
> -        comm = param_dict["comm"].replace(' ', '_')
> -        sep = "-"
> -        if opts.include_pid:
> -            comm = comm + sep + str(param_dict['sample']['pid'])
> -            sep = "/"
> -        if opts.include_tid:
> -            comm = comm + sep + str(param_dict['sample']['tid'])
> -        stack.append(comm)
> -
> -    stack_string = ';'.join(reversed(stack))
> -    lines[stack_string] = lines[stack_string] + 1
> -
> -def trace_end():
> -    list = sorted(lines)
> -    for stack in list:
> -        print("%s %d" % (stack, lines[stack]))
> diff --git a/tools/perf/scripts/python/stat-cpi.py b/tools/perf/scripts/python/stat-cpi.py
> deleted file mode 100644
> index 01fa933ff3cf..000000000000
> --- a/tools/perf/scripts/python/stat-cpi.py
> +++ /dev/null
> @@ -1,79 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -
> -from __future__ import print_function
> -
> -data    = {}
> -times   = []
> -threads = []
> -cpus    = []
> -
> -def get_key(time, event, cpu, thread):
> -    return "%d-%s-%d-%d" % (time, event, cpu, thread)
> -
> -def store_key(time, cpu, thread):
> -    if (time not in times):
> -        times.append(time)
> -
> -    if (cpu not in cpus):
> -        cpus.append(cpu)
> -
> -    if (thread not in threads):
> -        threads.append(thread)
> -
> -def store(time, event, cpu, thread, val, ena, run):
> -    #print("event %s cpu %d, thread %d, time %d, val %d, ena %d, run %d" %
> -    #      (event, cpu, thread, time, val, ena, run))
> -
> -    store_key(time, cpu, thread)
> -    key = get_key(time, event, cpu, thread)
> -    data[key] = [ val, ena, run]
> -
> -def get(time, event, cpu, thread):
> -    key = get_key(time, event, cpu, thread)
> -    return data[key][0]
> -
> -def stat__cycles_k(cpu, thread, time, val, ena, run):
> -    store(time, "cycles", cpu, thread, val, ena, run);
> -
> -def stat__instructions_k(cpu, thread, time, val, ena, run):
> -    store(time, "instructions", cpu, thread, val, ena, run);
> -
> -def stat__cycles_u(cpu, thread, time, val, ena, run):
> -    store(time, "cycles", cpu, thread, val, ena, run);
> -
> -def stat__instructions_u(cpu, thread, time, val, ena, run):
> -    store(time, "instructions", cpu, thread, val, ena, run);
> -
> -def stat__cycles(cpu, thread, time, val, ena, run):
> -    store(time, "cycles", cpu, thread, val, ena, run);
> -
> -def stat__instructions(cpu, thread, time, val, ena, run):
> -    store(time, "instructions", cpu, thread, val, ena, run);
> -
> -def stat__interval(time):
> -    for cpu in cpus:
> -        for thread in threads:
> -            cyc = get(time, "cycles", cpu, thread)
> -            ins = get(time, "instructions", cpu, thread)
> -            cpi = 0
> -
> -            if ins != 0:
> -                cpi = cyc/float(ins)
> -
> -            print("%15f: cpu %d, thread %d -> cpi %f (%d/%d)" % (time/(float(1000000000)), cpu, thread, cpi, cyc, ins))
> -
> -def trace_end():
> -    pass
> -# XXX trace_end callback could be used as an alternative place
> -#     to compute same values as in the script above:
> -#
> -#    for time in times:
> -#        for cpu in cpus:
> -#            for thread in threads:
> -#                cyc = get(time, "cycles", cpu, thread)
> -#                ins = get(time, "instructions", cpu, thread)
> -#
> -#                if ins != 0:
> -#                    cpi = cyc/float(ins)
> -#
> -#                print("time %.9f, cpu %d, thread %d -> cpi %f" % (time/(float(1000000000)), cpu, thread, cpi))
> diff --git a/tools/perf/scripts/python/syscall-counts-by-pid.py b/tools/perf/scripts/python/syscall-counts-by-pid.py
> deleted file mode 100644
> index f254e40c6f0f..000000000000
> --- a/tools/perf/scripts/python/syscall-counts-by-pid.py
> +++ /dev/null
> @@ -1,75 +0,0 @@
> -# system call counts, by pid
> -# (c) 2010, Tom Zanussi <tzanussi@gmail.com>
> -# Licensed under the terms of the GNU GPL License version 2
> -#
> -# Displays system-wide system call totals, broken down by syscall.
> -# If a [comm] arg is specified, only syscalls called by [comm] are displayed.
> -
> -from __future__ import print_function
> -
> -import os, sys
> -
> -sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> -	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> -
> -from perf_trace_context import *
> -from Core import *
> -from Util import syscall_name
> -
> -usage = "perf script -s syscall-counts-by-pid.py [comm]\n";
> -
> -for_comm = None
> -for_pid = None
> -
> -if len(sys.argv) > 2:
> -	sys.exit(usage)
> -
> -if len(sys.argv) > 1:
> -	try:
> -		for_pid = int(sys.argv[1])
> -	except:
> -		for_comm = sys.argv[1]
> -
> -syscalls = autodict()
> -
> -def trace_begin():
> -	print("Press control+C to stop and show the summary")
> -
> -def trace_end():
> -	print_syscall_totals()
> -
> -def raw_syscalls__sys_enter(event_name, context, common_cpu,
> -		common_secs, common_nsecs, common_pid, common_comm,
> -		common_callchain, id, args):
> -	if (for_comm and common_comm != for_comm) or \
> -		(for_pid and common_pid != for_pid ):
> -		return
> -	try:
> -		syscalls[common_comm][common_pid][id] += 1
> -	except TypeError:
> -		syscalls[common_comm][common_pid][id] = 1
> -
> -def syscalls__sys_enter(event_name, context, common_cpu,
> -		common_secs, common_nsecs, common_pid, common_comm,
> -		id, args):
> -	raw_syscalls__sys_enter(**locals())
> -
> -def print_syscall_totals():
> -	if for_comm is not None:
> -		print("\nsyscall events for %s:\n" % (for_comm))
> -	else:
> -		print("\nsyscall events by comm/pid:\n")
> -
> -	print("%-40s  %10s" % ("comm [pid]/syscalls", "count"))
> -	print("%-40s  %10s" % ("----------------------------------------",
> -				"----------"))
> -
> -	comm_keys = syscalls.keys()
> -	for comm in comm_keys:
> -		pid_keys = syscalls[comm].keys()
> -		for pid in pid_keys:
> -			print("\n%s [%d]" % (comm, pid))
> -			id_keys = syscalls[comm][pid].keys()
> -			for id, val in sorted(syscalls[comm][pid].items(),
> -				key = lambda kv: (kv[1], kv[0]), reverse = True):
> -				print("  %-38s  %10d" % (syscall_name(id), val))
> diff --git a/tools/perf/scripts/python/syscall-counts.py b/tools/perf/scripts/python/syscall-counts.py
> deleted file mode 100644
> index 8adb95ff1664..000000000000
> --- a/tools/perf/scripts/python/syscall-counts.py
> +++ /dev/null
> @@ -1,65 +0,0 @@
> -# system call counts
> -# (c) 2010, Tom Zanussi <tzanussi@gmail.com>
> -# Licensed under the terms of the GNU GPL License version 2
> -#
> -# Displays system-wide system call totals, broken down by syscall.
> -# If a [comm] arg is specified, only syscalls called by [comm] are displayed.
> -
> -from __future__ import print_function
> -
> -import os
> -import sys
> -
> -sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> -	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> -
> -from perf_trace_context import *
> -from Core import *
> -from Util import syscall_name
> -
> -usage = "perf script -s syscall-counts.py [comm]\n";
> -
> -for_comm = None
> -
> -if len(sys.argv) > 2:
> -	sys.exit(usage)
> -
> -if len(sys.argv) > 1:
> -	for_comm = sys.argv[1]
> -
> -syscalls = autodict()
> -
> -def trace_begin():
> -	print("Press control+C to stop and show the summary")
> -
> -def trace_end():
> -	print_syscall_totals()
> -
> -def raw_syscalls__sys_enter(event_name, context, common_cpu,
> -		common_secs, common_nsecs, common_pid, common_comm,
> -		common_callchain, id, args):
> -	if for_comm is not None:
> -		if common_comm != for_comm:
> -			return
> -	try:
> -		syscalls[id] += 1
> -	except TypeError:
> -		syscalls[id] = 1
> -
> -def syscalls__sys_enter(event_name, context, common_cpu,
> -		common_secs, common_nsecs, common_pid, common_comm, id, args):
> -	raw_syscalls__sys_enter(**locals())
> -
> -def print_syscall_totals():
> -	if for_comm is not None:
> -		print("\nsyscall events for %s:\n" % (for_comm))
> -	else:
> -		print("\nsyscall events:\n")
> -
> -	print("%-40s  %10s" % ("event", "count"))
> -	print("%-40s  %10s" % ("----------------------------------------",
> -				"-----------"))
> -
> -	for id, val in sorted(syscalls.items(),
> -			key = lambda kv: (kv[1], kv[0]), reverse = True):
> -		print("%-40s  %10d" % (syscall_name(id), val))
> diff --git a/tools/perf/scripts/python/task-analyzer.py b/tools/perf/scripts/python/task-analyzer.py
> deleted file mode 100755
> index 3f1df9894246..000000000000
> --- a/tools/perf/scripts/python/task-analyzer.py
> +++ /dev/null
> @@ -1,934 +0,0 @@
> -# task-analyzer.py - comprehensive perf tasks analysis
> -# SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) 2022, Hagen Paul Pfeifer <hagen@jauu.net>
> -# Licensed under the terms of the GNU GPL License version 2
> -#
> -# Usage:
> -#
> -#     perf record -e sched:sched_switch -a -- sleep 10
> -#     perf script report task-analyzer
> -#
> -
> -from __future__ import print_function
> -import sys
> -import os
> -import string
> -import argparse
> -import decimal
> -
> -
> -sys.path.append(
> -    os.environ["PERF_EXEC_PATH"] + "/scripts/python/Perf-Trace-Util/lib/Perf/Trace"
> -)
> -from perf_trace_context import *
> -from Core import *
> -
> -# Definition of possible ASCII color codes
> -_COLORS = {
> -    "grey": "\033[90m",
> -    "red": "\033[91m",
> -    "green": "\033[92m",
> -    "yellow": "\033[93m",
> -    "blue": "\033[94m",
> -    "violet": "\033[95m",
> -    "reset": "\033[0m",
> -}
> -
> -# Columns will have a static size to align everything properly
> -# Support of 116 days of active update with nano precision
> -LEN_SWITCHED_IN = len("9999999.999999999")  # 17
> -LEN_SWITCHED_OUT = len("9999999.999999999")  # 17
> -LEN_CPU = len("000")
> -LEN_PID = len("maxvalue")  # 8
> -LEN_TID = len("maxvalue")  # 8
> -LEN_COMM = len("max-comms-length")  # 16
> -LEN_RUNTIME = len("999999.999")  # 10
> -# Support of 3.45 hours of timespans
> -LEN_OUT_IN = len("99999999999.999")  # 15
> -LEN_OUT_OUT = len("99999999999.999")  # 15
> -LEN_IN_IN = len("99999999999.999")  # 15
> -LEN_IN_OUT = len("99999999999.999")  # 15
> -
> -
> -# py2/py3 compatibility layer, see PEP469
> -try:
> -    dict.iteritems
> -except AttributeError:
> -    # py3
> -    def itervalues(d):
> -        return iter(d.values())
> -
> -    def iteritems(d):
> -        return iter(d.items())
> -
> -else:
> -    # py2
> -    def itervalues(d):
> -        return d.itervalues()
> -
> -    def iteritems(d):
> -        return d.iteritems()
> -
> -
> -def _check_color():
> -    global _COLORS
> -    """user enforced no-color or if stdout is no tty we disable colors"""
> -    if sys.stdout.isatty() and args.stdio_color != "never":
> -        return
> -    _COLORS = {
> -        "grey": "",
> -        "red": "",
> -        "green": "",
> -        "yellow": "",
> -        "blue": "",
> -        "violet": "",
> -        "reset": "",
> -    }
> -
> -
> -def _parse_args():
> -    global args
> -    parser = argparse.ArgumentParser(description="Analyze tasks behavior")
> -    parser.add_argument(
> -        "--time-limit",
> -        default=[],
> -        help=
> -            "print tasks only in time[s] window e.g"
> -        " --time-limit 123.111:789.222(print all between 123.111 and 789.222)"
> -        " --time-limit 123: (print all from 123)"
> -        " --time-limit :456 (print all until incl. 456)",
> -    )
> -    parser.add_argument(
> -        "--summary", action="store_true", help="print addtional runtime information"
> -    )
> -    parser.add_argument(
> -        "--summary-only", action="store_true", help="print only summary without traces"
> -    )
> -    parser.add_argument(
> -        "--summary-extended",
> -        action="store_true",
> -        help="print the summary with additional information of max inter task times"
> -            " relative to the prev task",
> -    )
> -    parser.add_argument(
> -        "--ns", action="store_true", help="show timestamps in nanoseconds"
> -    )
> -    parser.add_argument(
> -        "--ms", action="store_true", help="show timestamps in milliseconds"
> -    )
> -    parser.add_argument(
> -        "--extended-times",
> -        action="store_true",
> -        help="Show the elapsed times between schedule in/schedule out"
> -            " of this task and the schedule in/schedule out of previous occurrence"
> -            " of the same task",
> -    )
> -    parser.add_argument(
> -        "--filter-tasks",
> -        default=[],
> -        help="filter out unneeded tasks by tid, pid or processname."
> -        " E.g --filter-task 1337,/sbin/init ",
> -    )
> -    parser.add_argument(
> -        "--limit-to-tasks",
> -        default=[],
> -        help="limit output to selected task by tid, pid, processname."
> -        " E.g --limit-to-tasks 1337,/sbin/init",
> -    )
> -    parser.add_argument(
> -        "--highlight-tasks",
> -        default="",
> -        help="colorize special tasks by their pid/tid/comm."
> -        " E.g. --highlight-tasks 1:red,mutt:yellow"
> -        " Colors available: red,grey,yellow,blue,violet,green",
> -    )
> -    parser.add_argument(
> -        "--rename-comms-by-tids",
> -        default="",
> -        help="rename task names by using tid (<tid>:<newname>,<tid>:<newname>)"
> -            " This option is handy for inexpressive processnames like python interpreted"
> -            " process. E.g --rename 1337:my-python-app",
> -    )
> -    parser.add_argument(
> -        "--stdio-color",
> -        default="auto",
> -        choices=["always", "never", "auto"],
> -        help="always, never or auto, allowing configuring color output"
> -            " via the command line",
> -    )
> -    parser.add_argument(
> -        "--csv",
> -        default="",
> -        help="Write trace to file selected by user. Options, like --ns or --extended"
> -            "-times are used.",
> -    )
> -    parser.add_argument(
> -        "--csv-summary",
> -        default="",
> -        help="Write summary to file selected by user. Options, like --ns or"
> -            " --summary-extended are used.",
> -    )
> -    args = parser.parse_args()
> -    args.tid_renames = dict()
> -
> -    _argument_filter_sanity_check()
> -    _argument_prepare_check()
> -
> -
> -def time_uniter(unit):
> -    picker = {
> -        "s": 1,
> -        "ms": 1e3,
> -        "us": 1e6,
> -        "ns": 1e9,
> -    }
> -    return picker[unit]
> -
> -
> -def _init_db():
> -    global db
> -    db = dict()
> -    db["running"] = dict()
> -    db["cpu"] = dict()
> -    db["tid"] = dict()
> -    db["global"] = []
> -    if args.summary or args.summary_extended or args.summary_only:
> -        db["task_info"] = dict()
> -        db["runtime_info"] = dict()
> -        # min values for summary depending on the header
> -        db["task_info"]["pid"] = len("PID")
> -        db["task_info"]["tid"] = len("TID")
> -        db["task_info"]["comm"] = len("Comm")
> -        db["runtime_info"]["runs"] = len("Runs")
> -        db["runtime_info"]["acc"] = len("Accumulated")
> -        db["runtime_info"]["max"] = len("Max")
> -        db["runtime_info"]["max_at"] = len("Max At")
> -        db["runtime_info"]["min"] = len("Min")
> -        db["runtime_info"]["mean"] = len("Mean")
> -        db["runtime_info"]["median"] = len("Median")
> -        if args.summary_extended:
> -            db["inter_times"] = dict()
> -            db["inter_times"]["out_in"] = len("Out-In")
> -            db["inter_times"]["inter_at"] = len("At")
> -            db["inter_times"]["out_out"] = len("Out-Out")
> -            db["inter_times"]["in_in"] = len("In-In")
> -            db["inter_times"]["in_out"] = len("In-Out")
> -
> -
> -def _median(numbers):
> -    """phython3 hat statistics module - we have nothing"""
> -    n = len(numbers)
> -    index = n // 2
> -    if n % 2:
> -        return sorted(numbers)[index]
> -    return sum(sorted(numbers)[index - 1 : index + 1]) / 2
> -
> -
> -def _mean(numbers):
> -    return sum(numbers) / len(numbers)
> -
> -
> -class Timespans(object):
> -    """
> -    The elapsed time between two occurrences of the same task is being tracked with the
> -    help of this class. There are 4 of those Timespans Out-Out, In-Out, Out-In and
> -    In-In.
> -    The first half of the name signals the first time point of the
> -    first task. The second half of the name represents the second
> -    timepoint of the second task.
> -    """
> -
> -    def __init__(self):
> -        self._last_start = None
> -        self._last_finish = None
> -        self.out_out = -1
> -        self.in_out = -1
> -        self.out_in = -1
> -        self.in_in = -1
> -        if args.summary_extended:
> -            self._time_in = -1
> -            self.max_out_in = -1
> -            self.max_at = -1
> -            self.max_in_out = -1
> -            self.max_in_in = -1
> -            self.max_out_out = -1
> -
> -    def feed(self, task):
> -        """
> -        Called for every recorded trace event to find process pair and calculate the
> -        task timespans. Chronological ordering, feed does not do reordering
> -        """
> -        if not self._last_finish:
> -            self._last_start = task.time_in(time_unit)
> -            self._last_finish = task.time_out(time_unit)
> -            return
> -        self._time_in = task.time_in()
> -        time_in = task.time_in(time_unit)
> -        time_out = task.time_out(time_unit)
> -        self.in_in = time_in - self._last_start
> -        self.out_in = time_in - self._last_finish
> -        self.in_out = time_out - self._last_start
> -        self.out_out = time_out - self._last_finish
> -        if args.summary_extended:
> -            self._update_max_entries()
> -        self._last_finish = task.time_out(time_unit)
> -        self._last_start = task.time_in(time_unit)
> -
> -    def _update_max_entries(self):
> -        if self.in_in > self.max_in_in:
> -            self.max_in_in = self.in_in
> -        if self.out_out > self.max_out_out:
> -            self.max_out_out = self.out_out
> -        if self.in_out > self.max_in_out:
> -            self.max_in_out = self.in_out
> -        if self.out_in > self.max_out_in:
> -            self.max_out_in = self.out_in
> -            self.max_at = self._time_in
> -
> -
> -
> -class Summary(object):
> -    """
> -    Primary instance for calculating the summary output. Processes the whole trace to
> -    find and memorize relevant data such as mean, max et cetera. This instance handles
> -    dynamic alignment aspects for summary output.
> -    """
> -
> -    def __init__(self):
> -        self._body = []
> -
> -    class AlignmentHelper:
> -        """
> -        Used to calculated the alignment for the output of the summary.
> -        """
> -        def __init__(self, pid, tid, comm, runs, acc, mean,
> -                    median, min, max, max_at):
> -            self.pid = pid
> -            self.tid = tid
> -            self.comm = comm
> -            self.runs = runs
> -            self.acc = acc
> -            self.mean = mean
> -            self.median = median
> -            self.min = min
> -            self.max = max
> -            self.max_at = max_at
> -            if args.summary_extended:
> -                self.out_in = None
> -                self.inter_at = None
> -                self.out_out = None
> -                self.in_in = None
> -                self.in_out = None
> -
> -    def _print_header(self):
> -        '''
> -        Output is trimmed in _format_stats thus additional adjustment in the header
> -        is needed, depending on the choice of timeunit. The adjustment corresponds
> -        to the amount of column titles being adjusted in _column_titles.
> -        '''
> -        decimal_precision = 6 if not args.ns else 9
> -        fmt = " {{:^{}}}".format(sum(db["task_info"].values()))
> -        fmt += " {{:^{}}}".format(
> -            sum(db["runtime_info"].values()) - 2 * decimal_precision
> -            )
> -        _header = ("Task Information", "Runtime Information")
> -
> -        if args.summary_extended:
> -            fmt += " {{:^{}}}".format(
> -                sum(db["inter_times"].values()) - 4 * decimal_precision
> -                )
> -            _header += ("Max Inter Task Times",)
> -        fd_sum.write(fmt.format(*_header) +  "\n")
> -
> -    def _column_titles(self):
> -        """
> -        Cells are being processed and displayed in different way so an alignment adjust
> -        is implemented depeding on the choice of the timeunit. The positions of the max
> -        values are being displayed in grey. Thus in their format two additional {},
> -        are placed for color set and reset.
> -        """
> -        separator, fix_csv_align = _prepare_fmt_sep()
> -        decimal_precision, time_precision = _prepare_fmt_precision()
> -        fmt = "{{:>{}}}".format(db["task_info"]["pid"] * fix_csv_align)
> -        fmt += "{}{{:>{}}}".format(separator, db["task_info"]["tid"] * fix_csv_align)
> -        fmt += "{}{{:>{}}}".format(separator, db["task_info"]["comm"] * fix_csv_align)
> -        fmt += "{}{{:>{}}}".format(separator, db["runtime_info"]["runs"] * fix_csv_align)
> -        fmt += "{}{{:>{}}}".format(separator, db["runtime_info"]["acc"] * fix_csv_align)
> -        fmt += "{}{{:>{}}}".format(separator, db["runtime_info"]["mean"] * fix_csv_align)
> -        fmt += "{}{{:>{}}}".format(
> -            separator, db["runtime_info"]["median"] * fix_csv_align
> -        )
> -        fmt += "{}{{:>{}}}".format(
> -            separator, (db["runtime_info"]["min"] - decimal_precision) * fix_csv_align
> -        )
> -        fmt += "{}{{:>{}}}".format(
> -            separator, (db["runtime_info"]["max"] - decimal_precision) * fix_csv_align
> -        )
> -        fmt += "{}{{}}{{:>{}}}{{}}".format(
> -            separator, (db["runtime_info"]["max_at"] - time_precision) * fix_csv_align
> -        )
> -
> -        column_titles = ("PID", "TID", "Comm")
> -        column_titles += ("Runs", "Accumulated", "Mean", "Median", "Min", "Max")
> -        column_titles += (_COLORS["grey"], "Max At", _COLORS["reset"])
> -
> -        if args.summary_extended:
> -            fmt += "{}{{:>{}}}".format(
> -                separator,
> -                (db["inter_times"]["out_in"] - decimal_precision) * fix_csv_align
> -            )
> -            fmt += "{}{{}}{{:>{}}}{{}}".format(
> -                separator,
> -                (db["inter_times"]["inter_at"] - time_precision) * fix_csv_align
> -            )
> -            fmt += "{}{{:>{}}}".format(
> -                separator,
> -                (db["inter_times"]["out_out"] - decimal_precision) * fix_csv_align
> -            )
> -            fmt += "{}{{:>{}}}".format(
> -                separator,
> -                (db["inter_times"]["in_in"] - decimal_precision) * fix_csv_align
> -            )
> -            fmt += "{}{{:>{}}}".format(
> -                separator,
> -                (db["inter_times"]["in_out"] - decimal_precision) * fix_csv_align
> -            )
> -
> -            column_titles += ("Out-In", _COLORS["grey"], "Max At", _COLORS["reset"],
> -                        "Out-Out", "In-In", "In-Out")
> -
> -        fd_sum.write(fmt.format(*column_titles) + "\n")
> -
> -
> -    def _task_stats(self):
> -        """calculates the stats of every task and constructs the printable summary"""
> -        for tid in sorted(db["tid"]):
> -            color_one_sample = _COLORS["grey"]
> -            color_reset = _COLORS["reset"]
> -            no_executed = 0
> -            runtimes = []
> -            time_in = []
> -            timespans = Timespans()
> -            for task in db["tid"][tid]:
> -                pid = task.pid
> -                comm = task.comm
> -                no_executed += 1
> -                runtimes.append(task.runtime(time_unit))
> -                time_in.append(task.time_in())
> -                timespans.feed(task)
> -            if len(runtimes) > 1:
> -                color_one_sample = ""
> -                color_reset = ""
> -            time_max = max(runtimes)
> -            time_min = min(runtimes)
> -            max_at = time_in[runtimes.index(max(runtimes))]
> -
> -            # The size of the decimal after sum,mean and median varies, thus we cut
> -            # the decimal number, by rounding it. It has no impact on the output,
> -            # because we have a precision of the decimal points at the output.
> -            time_sum = round(sum(runtimes), 3)
> -            time_mean = round(_mean(runtimes), 3)
> -            time_median = round(_median(runtimes), 3)
> -
> -            align_helper = self.AlignmentHelper(pid, tid, comm, no_executed, time_sum,
> -                                    time_mean, time_median, time_min, time_max, max_at)
> -            self._body.append([pid, tid, comm, no_executed, time_sum, color_one_sample,
> -                                time_mean, time_median, time_min, time_max,
> -                                _COLORS["grey"], max_at, _COLORS["reset"], color_reset])
> -            if args.summary_extended:
> -                self._body[-1].extend([timespans.max_out_in,
> -                                _COLORS["grey"], timespans.max_at,
> -                                _COLORS["reset"], timespans.max_out_out,
> -                                timespans.max_in_in,
> -                                timespans.max_in_out])
> -                align_helper.out_in = timespans.max_out_in
> -                align_helper.inter_at = timespans.max_at
> -                align_helper.out_out = timespans.max_out_out
> -                align_helper.in_in = timespans.max_in_in
> -                align_helper.in_out = timespans.max_in_out
> -            self._calc_alignments_summary(align_helper)
> -
> -    def _format_stats(self):
> -        separator, fix_csv_align = _prepare_fmt_sep()
> -        decimal_precision, time_precision = _prepare_fmt_precision()
> -        len_pid = db["task_info"]["pid"] * fix_csv_align
> -        len_tid = db["task_info"]["tid"] * fix_csv_align
> -        len_comm = db["task_info"]["comm"] * fix_csv_align
> -        len_runs = db["runtime_info"]["runs"] * fix_csv_align
> -        len_acc = db["runtime_info"]["acc"] * fix_csv_align
> -        len_mean = db["runtime_info"]["mean"] * fix_csv_align
> -        len_median = db["runtime_info"]["median"] * fix_csv_align
> -        len_min = (db["runtime_info"]["min"] - decimal_precision) * fix_csv_align
> -        len_max = (db["runtime_info"]["max"] - decimal_precision) * fix_csv_align
> -        len_max_at = (db["runtime_info"]["max_at"] - time_precision) * fix_csv_align
> -        if args.summary_extended:
> -            len_out_in = (
> -                db["inter_times"]["out_in"] - decimal_precision
> -            ) * fix_csv_align
> -            len_inter_at = (
> -                db["inter_times"]["inter_at"] - time_precision
> -            ) * fix_csv_align
> -            len_out_out = (
> -                db["inter_times"]["out_out"] - decimal_precision
> -            ) * fix_csv_align
> -            len_in_in = (db["inter_times"]["in_in"] - decimal_precision) * fix_csv_align
> -            len_in_out = (
> -                db["inter_times"]["in_out"] - decimal_precision
> -            ) * fix_csv_align
> -
> -        fmt = "{{:{}d}}".format(len_pid)
> -        fmt += "{}{{:{}d}}".format(separator, len_tid)
> -        fmt += "{}{{:>{}}}".format(separator, len_comm)
> -        fmt += "{}{{:{}d}}".format(separator, len_runs)
> -        fmt += "{}{{:{}.{}f}}".format(separator, len_acc, time_precision)
> -        fmt += "{}{{}}{{:{}.{}f}}".format(separator, len_mean, time_precision)
> -        fmt += "{}{{:{}.{}f}}".format(separator, len_median, time_precision)
> -        fmt += "{}{{:{}.{}f}}".format(separator, len_min, time_precision)
> -        fmt += "{}{{:{}.{}f}}".format(separator, len_max, time_precision)
> -        fmt += "{}{{}}{{:{}.{}f}}{{}}{{}}".format(
> -            separator, len_max_at, decimal_precision
> -        )
> -        if args.summary_extended:
> -            fmt += "{}{{:{}.{}f}}".format(separator, len_out_in, time_precision)
> -            fmt += "{}{{}}{{:{}.{}f}}{{}}".format(
> -                separator, len_inter_at, decimal_precision
> -            )
> -            fmt += "{}{{:{}.{}f}}".format(separator, len_out_out, time_precision)
> -            fmt += "{}{{:{}.{}f}}".format(separator, len_in_in, time_precision)
> -            fmt += "{}{{:{}.{}f}}".format(separator, len_in_out, time_precision)
> -        return fmt
> -
> -
> -    def _calc_alignments_summary(self, align_helper):
> -        # Length is being cut in 3 groups so that further addition is easier to handle.
> -        # The length of every argument from the alignment helper is being checked if it
> -        # is longer than the longest until now. In that case the length is being saved.
> -        for key in db["task_info"]:
> -            if len(str(getattr(align_helper, key))) > db["task_info"][key]:
> -                db["task_info"][key] = len(str(getattr(align_helper, key)))
> -        for key in db["runtime_info"]:
> -            if len(str(getattr(align_helper, key))) > db["runtime_info"][key]:
> -                db["runtime_info"][key] = len(str(getattr(align_helper, key)))
> -        if args.summary_extended:
> -            for key in db["inter_times"]:
> -                if len(str(getattr(align_helper, key))) > db["inter_times"][key]:
> -                    db["inter_times"][key] = len(str(getattr(align_helper, key)))
> -
> -
> -    def print(self):
> -        self._task_stats()
> -        fmt = self._format_stats()
> -
> -        if not args.csv_summary:
> -            print("\nSummary")
> -            self._print_header()
> -        self._column_titles()
> -        for i in range(len(self._body)):
> -            fd_sum.write(fmt.format(*tuple(self._body[i])) + "\n")
> -
> -
> -
> -class Task(object):
> -    """ The class is used to handle the information of a given task."""
> -
> -    def __init__(self, id, tid, cpu, comm):
> -        self.id = id
> -        self.tid = tid
> -        self.cpu = cpu
> -        self.comm = comm
> -        self.pid = None
> -        self._time_in = None
> -        self._time_out = None
> -
> -    def schedule_in_at(self, time):
> -        """set the time where the task was scheduled in"""
> -        self._time_in = time
> -
> -    def schedule_out_at(self, time):
> -        """set the time where the task was scheduled out"""
> -        self._time_out = time
> -
> -    def time_out(self, unit="s"):
> -        """return time where a given task was scheduled out"""
> -        factor = time_uniter(unit)
> -        return self._time_out * decimal.Decimal(factor)
> -
> -    def time_in(self, unit="s"):
> -        """return time where a given task was scheduled in"""
> -        factor = time_uniter(unit)
> -        return self._time_in * decimal.Decimal(factor)
> -
> -    def runtime(self, unit="us"):
> -        factor = time_uniter(unit)
> -        return (self._time_out - self._time_in) * decimal.Decimal(factor)
> -
> -    def update_pid(self, pid):
> -        self.pid = pid
> -
> -
> -def _task_id(pid, cpu):
> -    """returns a "unique-enough" identifier, please do not change"""
> -    return "{}-{}".format(pid, cpu)
> -
> -
> -def _filter_non_printable(unfiltered):
> -    """comm names may contain loony chars like '\x00000'"""
> -    filtered = ""
> -    for char in unfiltered:
> -        if char not in string.printable:
> -            continue
> -        filtered += char
> -    return filtered
> -
> -
> -def _fmt_header():
> -    separator, fix_csv_align = _prepare_fmt_sep()
> -    fmt = "{{:>{}}}".format(LEN_SWITCHED_IN*fix_csv_align)
> -    fmt += "{}{{:>{}}}".format(separator, LEN_SWITCHED_OUT*fix_csv_align)
> -    fmt += "{}{{:>{}}}".format(separator, LEN_CPU*fix_csv_align)
> -    fmt += "{}{{:>{}}}".format(separator, LEN_PID*fix_csv_align)
> -    fmt += "{}{{:>{}}}".format(separator, LEN_TID*fix_csv_align)
> -    fmt += "{}{{:>{}}}".format(separator, LEN_COMM*fix_csv_align)
> -    fmt += "{}{{:>{}}}".format(separator, LEN_RUNTIME*fix_csv_align)
> -    fmt += "{}{{:>{}}}".format(separator, LEN_OUT_IN*fix_csv_align)
> -    if args.extended_times:
> -        fmt += "{}{{:>{}}}".format(separator, LEN_OUT_OUT*fix_csv_align)
> -        fmt += "{}{{:>{}}}".format(separator, LEN_IN_IN*fix_csv_align)
> -        fmt += "{}{{:>{}}}".format(separator, LEN_IN_OUT*fix_csv_align)
> -    return fmt
> -
> -
> -def _fmt_body():
> -    separator, fix_csv_align = _prepare_fmt_sep()
> -    decimal_precision, time_precision = _prepare_fmt_precision()
> -    fmt = "{{}}{{:{}.{}f}}".format(LEN_SWITCHED_IN*fix_csv_align, decimal_precision)
> -    fmt += "{}{{:{}.{}f}}".format(
> -        separator, LEN_SWITCHED_OUT*fix_csv_align, decimal_precision
> -    )
> -    fmt += "{}{{:{}d}}".format(separator, LEN_CPU*fix_csv_align)
> -    fmt += "{}{{:{}d}}".format(separator, LEN_PID*fix_csv_align)
> -    fmt += "{}{{}}{{:{}d}}{{}}".format(separator, LEN_TID*fix_csv_align)
> -    fmt += "{}{{}}{{:>{}}}".format(separator, LEN_COMM*fix_csv_align)
> -    fmt += "{}{{:{}.{}f}}".format(separator, LEN_RUNTIME*fix_csv_align, time_precision)
> -    if args.extended_times:
> -        fmt += "{}{{:{}.{}f}}".format(separator, LEN_OUT_IN*fix_csv_align, time_precision)
> -        fmt += "{}{{:{}.{}f}}".format(separator, LEN_OUT_OUT*fix_csv_align, time_precision)
> -        fmt += "{}{{:{}.{}f}}".format(separator, LEN_IN_IN*fix_csv_align, time_precision)
> -        fmt += "{}{{:{}.{}f}}{{}}".format(
> -            separator, LEN_IN_OUT*fix_csv_align, time_precision
> -        )
> -    else:
> -        fmt += "{}{{:{}.{}f}}{{}}".format(
> -            separator, LEN_OUT_IN*fix_csv_align, time_precision
> -        )
> -    return fmt
> -
> -
> -def _print_header():
> -    fmt = _fmt_header()
> -    header = ("Switched-In", "Switched-Out", "CPU", "PID", "TID", "Comm", "Runtime",
> -            "Time Out-In")
> -    if args.extended_times:
> -        header += ("Time Out-Out", "Time In-In", "Time In-Out")
> -    fd_task.write(fmt.format(*header) + "\n")
> -
> -
> -
> -def _print_task_finish(task):
> -    """calculating every entry of a row and printing it immediately"""
> -    c_row_set = ""
> -    c_row_reset = ""
> -    out_in = -1
> -    out_out = -1
> -    in_in = -1
> -    in_out = -1
> -    fmt = _fmt_body()
> -    # depending on user provided highlight option we change the color
> -    # for particular tasks
> -    if str(task.tid) in args.highlight_tasks_map:
> -        c_row_set = _COLORS[args.highlight_tasks_map[str(task.tid)]]
> -        c_row_reset = _COLORS["reset"]
> -    if task.comm in args.highlight_tasks_map:
> -        c_row_set = _COLORS[args.highlight_tasks_map[task.comm]]
> -        c_row_reset = _COLORS["reset"]
> -    # grey-out entries if PID == TID, they
> -    # are identical, no threaded model so the
> -    # thread id (tid) do not matter
> -    c_tid_set = ""
> -    c_tid_reset = ""
> -    if task.pid == task.tid:
> -        c_tid_set = _COLORS["grey"]
> -        c_tid_reset = _COLORS["reset"]
> -    if task.tid in db["tid"]:
> -        # get last task of tid
> -        last_tid_task = db["tid"][task.tid][-1]
> -        # feed the timespan calculate, last in tid db
> -        # and second the current one
> -        timespan_gap_tid = Timespans()
> -        timespan_gap_tid.feed(last_tid_task)
> -        timespan_gap_tid.feed(task)
> -        out_in = timespan_gap_tid.out_in
> -        out_out = timespan_gap_tid.out_out
> -        in_in = timespan_gap_tid.in_in
> -        in_out = timespan_gap_tid.in_out
> -
> -
> -    if args.extended_times:
> -        line_out = fmt.format(c_row_set, task.time_in(), task.time_out(), task.cpu,
> -                        task.pid, c_tid_set, task.tid, c_tid_reset, c_row_set, task.comm,
> -                        task.runtime(time_unit), out_in, out_out, in_in, in_out,
> -                        c_row_reset) + "\n"
> -    else:
> -        line_out = fmt.format(c_row_set, task.time_in(), task.time_out(), task.cpu,
> -                        task.pid, c_tid_set, task.tid, c_tid_reset, c_row_set, task.comm,
> -                        task.runtime(time_unit), out_in, c_row_reset) + "\n"
> -    try:
> -        fd_task.write(line_out)
> -    except(IOError):
> -        # don't mangle the output if user SIGINT this script
> -        sys.exit()
> -
> -def _record_cleanup(_list):
> -    """
> -    no need to store more then one element if --summarize
> -    is not enabled
> -    """
> -    if not args.summary and len(_list) > 1:
> -        _list = _list[len(_list) - 1 :]
> -
> -
> -def _record_by_tid(task):
> -    tid = task.tid
> -    if tid not in db["tid"]:
> -        db["tid"][tid] = []
> -    db["tid"][tid].append(task)
> -    _record_cleanup(db["tid"][tid])
> -
> -
> -def _record_by_cpu(task):
> -    cpu = task.cpu
> -    if cpu not in db["cpu"]:
> -        db["cpu"][cpu] = []
> -    db["cpu"][cpu].append(task)
> -    _record_cleanup(db["cpu"][cpu])
> -
> -
> -def _record_global(task):
> -    """record all executed task, ordered by finish chronological"""
> -    db["global"].append(task)
> -    _record_cleanup(db["global"])
> -
> -
> -def _handle_task_finish(tid, cpu, time, perf_sample_dict):
> -    if tid == 0:
> -        return
> -    _id = _task_id(tid, cpu)
> -    if _id not in db["running"]:
> -        # may happen, if we missed the switch to
> -        # event. Seen in combination with --exclude-perf
> -        # where the start is filtered out, but not the
> -        # switched in. Probably a bug in exclude-perf
> -        # option.
> -        return
> -    task = db["running"][_id]
> -    task.schedule_out_at(time)
> -
> -    # record tid, during schedule in the tid
> -    # is not available, update now
> -    pid = int(perf_sample_dict["sample"]["pid"])
> -
> -    task.update_pid(pid)
> -    del db["running"][_id]
> -
> -    # print only tasks which are not being filtered and no print of trace
> -    # for summary only, but record every task.
> -    if not _limit_filtered(tid, pid, task.comm) and not args.summary_only:
> -        _print_task_finish(task)
> -    _record_by_tid(task)
> -    _record_by_cpu(task)
> -    _record_global(task)
> -
> -
> -def _handle_task_start(tid, cpu, comm, time):
> -    if tid == 0:
> -        return
> -    if tid in args.tid_renames:
> -        comm = args.tid_renames[tid]
> -    _id = _task_id(tid, cpu)
> -    if _id in db["running"]:
> -        # handle corner cases where already running tasks
> -        # are switched-to again - saw this via --exclude-perf
> -        # recorded traces. We simple ignore this "second start"
> -        # event.
> -        return
> -    assert _id not in db["running"]
> -    task = Task(_id, tid, cpu, comm)
> -    task.schedule_in_at(time)
> -    db["running"][_id] = task
> -
> -
> -def _time_to_internal(time_ns):
> -    """
> -    To prevent float rounding errors we use Decimal internally
> -    """
> -    return decimal.Decimal(time_ns) / decimal.Decimal(1e9)
> -
> -
> -def _limit_filtered(tid, pid, comm):
> -    if args.filter_tasks:
> -        if str(tid) in args.filter_tasks or comm in args.filter_tasks:
> -            return True
> -        else:
> -            return False
> -    if args.limit_to_tasks:
> -        if str(tid) in args.limit_to_tasks or comm in args.limit_to_tasks:
> -            return False
> -        else:
> -            return True
> -
> -
> -def _argument_filter_sanity_check():
> -    if args.limit_to_tasks and args.filter_tasks:
> -        sys.exit("Error: Filter and Limit at the same time active.")
> -    if args.extended_times and args.summary_only:
> -        sys.exit("Error: Summary only and extended times active.")
> -    if args.time_limit and ":" not in args.time_limit:
> -        sys.exit(
> -            "Error: No bound set for time limit. Please set bound by ':' e.g :123."
> -        )
> -    if args.time_limit and (args.summary or args.summary_only or args.summary_extended):
> -        sys.exit("Error: Cannot set time limit and print summary")
> -    if args.csv_summary:
> -        args.summary = True
> -        if args.csv == args.csv_summary:
> -            sys.exit("Error: Chosen files for csv and csv summary are the same")
> -    if args.csv and (args.summary_extended or args.summary) and not args.csv_summary:
> -        sys.exit("Error: No file chosen to write summary to. Choose with --csv-summary "
> -        "<file>")
> -    if args.csv and args.summary_only:
> -        sys.exit("Error: --csv chosen and --summary-only. Standard task would not be"
> -            "written to csv file.")
> -
> -def _argument_prepare_check():
> -    global time_unit, fd_task, fd_sum
> -    if args.filter_tasks:
> -        args.filter_tasks = args.filter_tasks.split(",")
> -    if args.limit_to_tasks:
> -        args.limit_to_tasks = args.limit_to_tasks.split(",")
> -    if args.time_limit:
> -        args.time_limit = args.time_limit.split(":")
> -    for rename_tuple in args.rename_comms_by_tids.split(","):
> -        tid_name = rename_tuple.split(":")
> -        if len(tid_name) != 2:
> -            continue
> -        args.tid_renames[int(tid_name[0])] = tid_name[1]
> -    args.highlight_tasks_map = dict()
> -    for highlight_tasks_tuple in args.highlight_tasks.split(","):
> -        tasks_color_map = highlight_tasks_tuple.split(":")
> -        # default highlight color to red if no color set by user
> -        if len(tasks_color_map) == 1:
> -            tasks_color_map.append("red")
> -        if args.highlight_tasks and tasks_color_map[1].lower() not in _COLORS:
> -            sys.exit(
> -                "Error: Color not defined, please choose from grey,red,green,yellow,blue,"
> -                "violet"
> -            )
> -        if len(tasks_color_map) != 2:
> -            continue
> -        args.highlight_tasks_map[tasks_color_map[0]] = tasks_color_map[1]
> -    time_unit = "us"
> -    if args.ns:
> -        time_unit = "ns"
> -    elif args.ms:
> -        time_unit = "ms"
> -
> -
> -    fd_task = sys.stdout
> -    if args.csv:
> -        args.stdio_color = "never"
> -        fd_task = open(args.csv, "w")
> -        print("generating csv at",args.csv,)
> -
> -    fd_sum = sys.stdout
> -    if args.csv_summary:
> -        args.stdio_color = "never"
> -        fd_sum = open(args.csv_summary, "w")
> -        print("generating csv summary at",args.csv_summary)
> -        if not args.csv:
> -            args.summary_only = True
> -
> -
> -def _is_within_timelimit(time):
> -    """
> -    Check if a time limit was given by parameter, if so ignore the rest. If not,
> -    process the recorded trace in its entirety.
> -    """
> -    if not args.time_limit:
> -        return True
> -    lower_time_limit = args.time_limit[0]
> -    upper_time_limit = args.time_limit[1]
> -    # check for upper limit
> -    if upper_time_limit == "":
> -        if time >= decimal.Decimal(lower_time_limit):
> -            return True
> -    # check for lower limit
> -    if lower_time_limit == "":
> -        if time <= decimal.Decimal(upper_time_limit):
> -            return True
> -        # quit if time exceeds upper limit. Good for big datasets
> -        else:
> -            quit()
> -    if lower_time_limit != "" and upper_time_limit != "":
> -        if (time >= decimal.Decimal(lower_time_limit) and
> -            time <= decimal.Decimal(upper_time_limit)):
> -            return True
> -        # quit if time exceeds upper limit. Good for big datasets
> -        elif time > decimal.Decimal(upper_time_limit):
> -            quit()
> -
> -def _prepare_fmt_precision():
> -    decimal_precision = 6
> -    time_precision = 3
> -    if args.ns:
> -     decimal_precision = 9
> -     time_precision = 0
> -    return decimal_precision, time_precision
> -
> -def _prepare_fmt_sep():
> -    separator = " "
> -    fix_csv_align = 1
> -    if args.csv or args.csv_summary:
> -        separator = ";"
> -        fix_csv_align = 0
> -    return separator, fix_csv_align
> -
> -def trace_unhandled(event_name, context, event_fields_dict, perf_sample_dict):
> -    pass
> -
> -
> -def trace_begin():
> -    _parse_args()
> -    _check_color()
> -    _init_db()
> -    if not args.summary_only:
> -        _print_header()
> -
> -def trace_end():
> -    if args.summary or args.summary_extended or args.summary_only:
> -        Summary().print()
> -
> -def sched__sched_switch(event_name, context, common_cpu, common_secs, common_nsecs,
> -                        common_pid, common_comm, common_callchain, prev_comm,
> -                        prev_pid, prev_prio, prev_state, next_comm, next_pid,
> -                        next_prio, perf_sample_dict):
> -    # ignore common_secs & common_nsecs cause we need
> -    # high res timestamp anyway, using the raw value is
> -    # faster
> -    time = _time_to_internal(perf_sample_dict["sample"]["time"])
> -    if not _is_within_timelimit(time):
> -        # user specific --time-limit a:b set
> -        return
> -
> -    next_comm = _filter_non_printable(next_comm)
> -    _handle_task_finish(prev_pid, common_cpu, time, perf_sample_dict)
> -    _handle_task_start(next_pid, common_cpu, next_comm, time)
> diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/script.sh
> index 254fc3ae94e7..af687c7cfe44 100755
> --- a/tools/perf/tests/shell/script.sh
> +++ b/tools/perf/tests/shell/script.sh
> @@ -6,9 +6,6 @@ set -e
>  
>  temp_dir=$(mktemp -d /tmp/perf-test-script.XXXXXXXXXX)
>  
> -perfdatafile="${temp_dir}/perf.data"
> -db_test="${temp_dir}/db_test.py"
> -
>  err=0
>  
>  cleanup()
> @@ -30,44 +27,6 @@ trap_cleanup()
>  
>  trap trap_cleanup EXIT TERM INT
>  
> -
> -test_db()
> -{
> -	echo "DB test"
> -
> -	# Check if python script is supported
> -        if perf version --build-options | grep python | grep -q OFF ; then
> -		echo "SKIP: python scripting is not supported"
> -		err=2
> -		return
> -	fi
> -
> -	cat << "_end_of_file_" > "${db_test}"
> -perf_db_export_mode = True
> -perf_db_export_calls = False
> -perf_db_export_callchains = True
> -
> -def sample_table(*args):
> -    print(f'sample_table({args})')
> -
> -def call_path_table(*args):
> -    print(f'call_path_table({args}')
> -_end_of_file_
> -	case $(uname -m)
> -	in s390x)
> -		cmd_flags="--call-graph dwarf -e cpu-clock";;
> -	*)
> -		cmd_flags="-g";;
> -	esac
> -
> -	perf record $cmd_flags -o "${perfdatafile}" true
> -	# Disable lsan to avoid warnings about python memory leaks.
> -	export ASAN_OPTIONS=detect_leaks=0
> -	perf script -i "${perfdatafile}" -s "${db_test}"
> -	export ASAN_OPTIONS=
> -	echo "DB test [Success]"
> -}
> -
>  test_parallel_perf()
>  {
>  	echo "parallel-perf test"
> @@ -91,7 +50,6 @@ test_parallel_perf()
>  	echo "parallel-perf test [Success]"
>  }
>  
> -test_db
>  test_parallel_perf
>  
>  cleanup
> diff --git a/tools/perf/tests/shell/script_python.sh b/tools/perf/tests/shell/script_python.sh
> deleted file mode 100755
> index 6bc66074a31f..000000000000
> --- a/tools/perf/tests/shell/script_python.sh
> +++ /dev/null
> @@ -1,113 +0,0 @@
> -#!/bin/bash
> -# perf script python tests
> -# SPDX-License-Identifier: GPL-2.0
> -
> -set -e
> -
> -# set PERF_EXEC_PATH to find scripts in the source directory
> -perfdir=$(dirname "$0")/../..
> -if [ -e "$perfdir/scripts/python/Perf-Trace-Util" ]; then
> -  export PERF_EXEC_PATH=$perfdir
> -fi
> -
> -
> -perfdata=$(mktemp /tmp/__perf_test_script_python.perf.data.XXXXX)
> -generated_script=$(mktemp /tmp/__perf_test_script.XXXXX.py)
> -
> -cleanup() {
> -  rm -f "${perfdata}"
> -  rm -f "${generated_script}"
> -  trap - EXIT TERM INT
> -}
> -
> -trap_cleanup() {
> -  echo "Unexpected signal in ${FUNCNAME[1]}"
> -  cleanup
> -  exit 1
> -}
> -trap trap_cleanup TERM INT
> -trap cleanup EXIT
> -
> -check_python_support() {
> -	if perf check feature -q libpython; then
> -		return 0
> -	fi
> -	echo "perf script python test [Skipped: no libpython support]"
> -	return 2
> -}
> -
> -test_script() {
> -	local event_name=$1
> -	local expected_output=$2
> -	local record_opts=$3
> -
> -	echo "Testing event: $event_name"
> -
> -	# Try to record. If this fails, it might be permissions or lack of
> -	# support. Return 2 to indicate "skip this event" rather than "fail
> -	# test".
> -	if ! perf record -o "${perfdata}" -e "$event_name" $record_opts -- perf test -w thloop > /dev/null 2>&1; then
> -		echo "perf script python test [Skipped: failed to record $event_name]"
> -		return 2
> -	fi
> -
> -	echo "Generating python script..."
> -	if ! perf script -i "${perfdata}" -g "${generated_script}"; then
> -		echo "perf script python test [Failed: script generation for $event_name]"
> -		return 1
> -	fi
> -
> -	if [ ! -f "${generated_script}" ]; then
> -		echo "perf script python test [Failed: script not generated for $event_name]"
> -		return 1
> -	fi
> -
> -	# Perf script -g python doesn't generate process_event for generic
> -	# events so append it manually to test that the callback works.
> -	if ! grep -q "def process_event" "${generated_script}"; then
> -		cat <<EOF >> "${generated_script}"
> -
> -def process_event(param_dict):
> -	print("param_dict: %s" % param_dict)
> -EOF
> -	fi
> -
> -	echo "Executing python script..."
> -	output=$(perf script -i "${perfdata}" -s "${generated_script}" 2>&1)
> -
> -	if echo "$output" | grep -q "$expected_output"; then
> -		echo "perf script python test [Success: $event_name triggered $expected_output]"
> -		return 0
> -	else
> -		echo "perf script python test [Failed: $event_name did not trigger $expected_output]"
> -		echo "Output was:"
> -		echo "$output" | head -n 20
> -		return 1
> -	fi
> -}
> -
> -check_python_support || exit 2
> -
> -# Try tracepoint first
> -test_script "sched:sched_switch" "sched__sched_switch" "-c 1" && res=0 || res=$?
> -
> -if [ $res -eq 0 ]; then
> -	exit 0
> -elif [ $res -eq 1 ]; then
> -	exit 1
> -fi
> -
> -# If tracepoint skipped (res=2), try task-clock
> -# For generic events like task-clock, the generated script uses process_event()
> -# which prints the param_dict.
> -test_script "task-clock" "param_dict" "-c 100" && res=0 || res=$?
> -
> -if [ $res -eq 0 ]; then
> -	exit 0
> -elif [ $res -eq 1 ]; then
> -	exit 1
> -fi
> -
> -# If both skipped
> -echo "perf script python test [Skipped: Could not record tracepoint or task-clock]"
> -exit 2
> diff --git a/tools/perf/util/scripting-engines/Build b/tools/perf/util/scripting-engines/Build
> index 24f087b0cd11..3f1dc10526f8 100644
> --- a/tools/perf/util/scripting-engines/Build
> +++ b/tools/perf/util/scripting-engines/Build
> @@ -1,9 +1,5 @@
>  ifeq ($(CONFIG_LIBTRACEEVENT),y)
>    perf-util-$(CONFIG_LIBPERL)   += trace-event-perl.o
>  endif
> -perf-util-$(CONFIG_LIBPYTHON) += trace-event-python.o
>  
>  CFLAGS_trace-event-perl.o += $(PERL_EMBED_CCOPTS) -Wno-redundant-decls -Wno-strict-prototypes -Wno-unused-parameter -Wno-shadow -Wno-nested-externs -Wno-undef -Wno-switch-default -Wno-bad-function-cast -Wno-declaration-after-statement -Wno-switch-enum -Wno-thread-safety-analysis
> -
> -# -Wno-declaration-after-statement: The python headers have mixed code with declarations (decls after asserts, for instance)
> -CFLAGS_trace-event-python.o += $(PYTHON_EMBED_CCOPTS) -Wno-redundant-decls -Wno-strict-prototypes -Wno-unused-parameter -Wno-shadow -Wno-deprecated-declarations -Wno-switch-enum -Wno-declaration-after-statement
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> deleted file mode 100644
> index 038c4268a429..000000000000
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ /dev/null
> @@ -1,2335 +0,0 @@
> -/*
> - * trace-event-python.  Feed trace events to an embedded Python interpreter.
> - *
> - * Copyright (C) 2010 Tom Zanussi <tzanussi@gmail.com>
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, write to the Free Software
> - *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> - *
> - */
> -
> -#include <Python.h>
> -
> -#include <inttypes.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include <stdbool.h>
> -#include <errno.h>
> -#include <linux/bitmap.h>
> -#include <linux/compiler.h>
> -#include <linux/time64.h>
> -#ifdef HAVE_LIBTRACEEVENT
> -#include <event-parse.h>
> -#endif
> -
> -#include "../build-id.h"
> -#include "../counts.h"
> -#include "../debug.h"
> -#include "../dso.h"
> -#include "../callchain.h"
> -#include "../env.h"
> -#include "../evsel.h"
> -#include "../event.h"
> -#include "../thread.h"
> -#include "../comm.h"
> -#include "../machine.h"
> -#include "../mem-info.h"
> -#include "../db-export.h"
> -#include "../thread-stack.h"
> -#include "../trace-event.h"
> -#include "../call-path.h"
> -#include "dwarf-regs.h"
> -#include "map.h"
> -#include "symbol.h"
> -#include "thread_map.h"
> -#include "print_binary.h"
> -#include "stat.h"
> -#include "mem-events.h"
> -#include "util/perf_regs.h"
> -#include "util/session.h"
> -
> -#define _PyUnicode_FromString(arg) \
> -  PyUnicode_FromString(arg)
> -#define _PyUnicode_FromStringAndSize(arg1, arg2) \
> -  PyUnicode_FromStringAndSize((arg1), (arg2))
> -#define _PyBytes_FromStringAndSize(arg1, arg2) \
> -  PyBytes_FromStringAndSize((arg1), (arg2))
> -#define _PyLong_FromLong(arg) \
> -  PyLong_FromLong(arg)
> -#define _PyLong_AsLong(arg) \
> -  PyLong_AsLong(arg)
> -#define _PyCapsule_New(arg1, arg2, arg3) \
> -  PyCapsule_New((arg1), (arg2), (arg3))
> -
> -PyMODINIT_FUNC PyInit_perf_trace_context(void);
> -
> -#ifdef HAVE_LIBTRACEEVENT
> -#define TRACE_EVENT_TYPE_MAX				\
> -	((1 << (sizeof(unsigned short) * 8)) - 1)
> -
> -#define N_COMMON_FIELDS	7
> -
> -static char *cur_field_name;
> -static int zero_flag_atom;
> -#endif
> -
> -#define MAX_FIELDS	64
> -
> -extern struct scripting_context *scripting_context;
> -
> -static PyObject *main_module, *main_dict;
> -
> -struct tables {
> -	struct db_export	dbe;
> -	PyObject		*evsel_handler;
> -	PyObject		*machine_handler;
> -	PyObject		*thread_handler;
> -	PyObject		*comm_handler;
> -	PyObject		*comm_thread_handler;
> -	PyObject		*dso_handler;
> -	PyObject		*symbol_handler;
> -	PyObject		*branch_type_handler;
> -	PyObject		*sample_handler;
> -	PyObject		*call_path_handler;
> -	PyObject		*call_return_handler;
> -	PyObject		*synth_handler;
> -	PyObject		*context_switch_handler;
> -	bool			db_export_mode;
> -};
> -
> -static struct tables tables_global;
> -
> -static void handler_call_die(const char *handler_name) __noreturn;
> -static void handler_call_die(const char *handler_name)
> -{
> -	PyErr_Print();
> -	Py_FatalError("problem in Python trace event handler");
> -	// Py_FatalError does not return
> -	// but we have to make the compiler happy
> -	abort();
> -}
> -
> -/*
> - * Insert val into the dictionary and decrement the reference counter.
> - * This is necessary for dictionaries since PyDict_SetItemString() does not
> - * steal a reference, as opposed to PyTuple_SetItem().
> - */
> -static void pydict_set_item_string_decref(PyObject *dict, const char *key, PyObject *val)
> -{
> -	PyDict_SetItemString(dict, key, val);
> -	Py_DECREF(val);
> -}
> -
> -static PyObject *get_handler(const char *handler_name)
> -{
> -	PyObject *handler;
> -
> -	handler = PyDict_GetItemString(main_dict, handler_name);
> -	if (handler && !PyCallable_Check(handler))
> -		return NULL;
> -	return handler;
> -}
> -
> -static void call_object(PyObject *handler, PyObject *args, const char *die_msg)
> -{
> -	PyObject *retval;
> -
> -	retval = PyObject_CallObject(handler, args);
> -	if (retval == NULL)
> -		handler_call_die(die_msg);
> -	Py_DECREF(retval);
> -}
> -
> -static void try_call_object(const char *handler_name, PyObject *args)
> -{
> -	PyObject *handler;
> -
> -	handler = get_handler(handler_name);
> -	if (handler)
> -		call_object(handler, args, handler_name);
> -}
> -
> -#ifdef HAVE_LIBTRACEEVENT
> -static int get_argument_count(PyObject *handler)
> -{
> -	int arg_count = 0;
> -
> -	PyObject *code_obj = PyObject_GetAttrString(handler, "__code__");
> -	PyErr_Clear();
> -	if (code_obj) {
> -		PyObject *arg_count_obj = PyObject_GetAttrString(code_obj,
> -			"co_argcount");
> -		if (arg_count_obj) {
> -			arg_count = (int) _PyLong_AsLong(arg_count_obj);
> -			Py_DECREF(arg_count_obj);
> -		}
> -		Py_DECREF(code_obj);
> -	}
> -	return arg_count;
> -}
> -
> -static void define_value(enum tep_print_arg_type field_type,
> -			 const char *ev_name,
> -			 const char *field_name,
> -			 const char *field_value,
> -			 const char *field_str)
> -{
> -	const char *handler_name = "define_flag_value";
> -	PyObject *t;
> -	unsigned long long value;
> -	unsigned n = 0;
> -
> -	if (field_type == TEP_PRINT_SYMBOL)
> -		handler_name = "define_symbolic_value";
> -
> -	t = PyTuple_New(4);
> -	if (!t)
> -		Py_FatalError("couldn't create Python tuple");
> -
> -	value = eval_flag(field_value);
> -
> -	PyTuple_SetItem(t, n++, _PyUnicode_FromString(ev_name));
> -	PyTuple_SetItem(t, n++, _PyUnicode_FromString(field_name));
> -	PyTuple_SetItem(t, n++, _PyLong_FromLong(value));
> -	PyTuple_SetItem(t, n++, _PyUnicode_FromString(field_str));
> -
> -	try_call_object(handler_name, t);
> -
> -	Py_DECREF(t);
> -}
> -
> -static void define_values(enum tep_print_arg_type field_type,
> -			  struct tep_print_flag_sym *field,
> -			  const char *ev_name,
> -			  const char *field_name)
> -{
> -	define_value(field_type, ev_name, field_name, field->value,
> -		     field->str);
> -
> -	if (field->next)
> -		define_values(field_type, field->next, ev_name, field_name);
> -}
> -
> -static void define_field(enum tep_print_arg_type field_type,
> -			 const char *ev_name,
> -			 const char *field_name,
> -			 const char *delim)
> -{
> -	const char *handler_name = "define_flag_field";
> -	PyObject *t;
> -	unsigned n = 0;
> -
> -	if (field_type == TEP_PRINT_SYMBOL)
> -		handler_name = "define_symbolic_field";
> -
> -	if (field_type == TEP_PRINT_FLAGS)
> -		t = PyTuple_New(3);
> -	else
> -		t = PyTuple_New(2);
> -	if (!t)
> -		Py_FatalError("couldn't create Python tuple");
> -
> -	PyTuple_SetItem(t, n++, _PyUnicode_FromString(ev_name));
> -	PyTuple_SetItem(t, n++, _PyUnicode_FromString(field_name));
> -	if (field_type == TEP_PRINT_FLAGS)
> -		PyTuple_SetItem(t, n++, _PyUnicode_FromString(delim));
> -
> -	try_call_object(handler_name, t);
> -
> -	Py_DECREF(t);
> -}
> -
> -static void define_event_symbols(struct tep_event *event,
> -				 const char *ev_name,
> -				 struct tep_print_arg *args)
> -{
> -	if (args == NULL)
> -		return;
> -
> -	switch (args->type) {
> -	case TEP_PRINT_NULL:
> -		break;
> -	case TEP_PRINT_ATOM:
> -		define_value(TEP_PRINT_FLAGS, ev_name, cur_field_name, "0",
> -			     args->atom.atom);
> -		zero_flag_atom = 0;
> -		break;
> -	case TEP_PRINT_FIELD:
> -		free(cur_field_name);
> -		cur_field_name = strdup(args->field.name);
> -		break;
> -	case TEP_PRINT_FLAGS:
> -		define_event_symbols(event, ev_name, args->flags.field);
> -		define_field(TEP_PRINT_FLAGS, ev_name, cur_field_name,
> -			     args->flags.delim);
> -		define_values(TEP_PRINT_FLAGS, args->flags.flags, ev_name,
> -			      cur_field_name);
> -		break;
> -	case TEP_PRINT_SYMBOL:
> -		define_event_symbols(event, ev_name, args->symbol.field);
> -		define_field(TEP_PRINT_SYMBOL, ev_name, cur_field_name, NULL);
> -		define_values(TEP_PRINT_SYMBOL, args->symbol.symbols, ev_name,
> -			      cur_field_name);
> -		break;
> -	case TEP_PRINT_HEX:
> -	case TEP_PRINT_HEX_STR:
> -		define_event_symbols(event, ev_name, args->hex.field);
> -		define_event_symbols(event, ev_name, args->hex.size);
> -		break;
> -	case TEP_PRINT_INT_ARRAY:
> -		define_event_symbols(event, ev_name, args->int_array.field);
> -		define_event_symbols(event, ev_name, args->int_array.count);
> -		define_event_symbols(event, ev_name, args->int_array.el_size);
> -		break;
> -	case TEP_PRINT_STRING:
> -		break;
> -	case TEP_PRINT_TYPE:
> -		define_event_symbols(event, ev_name, args->typecast.item);
> -		break;
> -	case TEP_PRINT_OP:
> -		if (strcmp(args->op.op, ":") == 0)
> -			zero_flag_atom = 1;
> -		define_event_symbols(event, ev_name, args->op.left);
> -		define_event_symbols(event, ev_name, args->op.right);
> -		break;
> -	default:
> -		/* gcc warns for these? */
> -	case TEP_PRINT_BSTRING:
> -	case TEP_PRINT_DYNAMIC_ARRAY:
> -	case TEP_PRINT_DYNAMIC_ARRAY_LEN:
> -	case TEP_PRINT_FUNC:
> -	case TEP_PRINT_BITMASK:
> -		/* we should warn... */
> -		return;
> -	}
> -
> -	if (args->next)
> -		define_event_symbols(event, ev_name, args->next);
> -}
> -
> -static PyObject *get_field_numeric_entry(struct tep_event *event,
> -		struct tep_format_field *field, void *data)
> -{
> -	bool is_array = field->flags & TEP_FIELD_IS_ARRAY;
> -	PyObject *obj = NULL, *list = NULL;
> -	unsigned long long val;
> -	unsigned int item_size, n_items, i;
> -
> -	if (is_array) {
> -		list = PyList_New(field->arraylen);
> -		if (!list)
> -			Py_FatalError("couldn't create Python list");
> -		item_size = field->size / field->arraylen;
> -		n_items = field->arraylen;
> -	} else {
> -		item_size = field->size;
> -		n_items = 1;
> -	}
> -
> -	for (i = 0; i < n_items; i++) {
> -
> -		val = read_size(event, data + field->offset + i * item_size,
> -				item_size);
> -		if (field->flags & TEP_FIELD_IS_SIGNED) {
> -			if ((long long)val >= LONG_MIN &&
> -					(long long)val <= LONG_MAX)
> -				obj = _PyLong_FromLong(val);
> -			else
> -				obj = PyLong_FromLongLong(val);
> -		} else {
> -			if (val <= LONG_MAX)
> -				obj = _PyLong_FromLong(val);
> -			else
> -				obj = PyLong_FromUnsignedLongLong(val);
> -		}
> -		if (is_array)
> -			PyList_SET_ITEM(list, i, obj);
> -	}
> -	if (is_array)
> -		obj = list;
> -	return obj;
> -}
> -#endif
> -
> -static const char *get_dsoname(struct map *map)
> -{
> -	const char *dsoname = "[unknown]";
> -	struct dso *dso = map ? map__dso(map) : NULL;
> -
> -	if (dso) {
> -		if (symbol_conf.show_kernel_path && dso__long_name(dso))
> -			dsoname = dso__long_name(dso);
> -		else
> -			dsoname = dso__name(dso);
> -	}
> -
> -	return dsoname;
> -}
> -
> -static unsigned long get_offset(struct symbol *sym, struct addr_location *al)
> -{
> -	unsigned long offset;
> -
> -	if (al->addr < sym->end)
> -		offset = al->addr - sym->start;
> -	else
> -		offset = al->addr - map__start(al->map) - sym->start;
> -
> -	return offset;
> -}
> -
> -static PyObject *python_process_callchain(struct perf_sample *sample,
> -					 struct addr_location *al)
> -{
> -	PyObject *pylist;
> -	struct callchain_cursor *cursor;
> -
> -	pylist = PyList_New(0);
> -	if (!pylist)
> -		Py_FatalError("couldn't create Python list");
> -
> -	if (!symbol_conf.use_callchain || !sample->callchain)
> -		goto exit;
> -
> -	cursor = get_tls_callchain_cursor();
> -	if (thread__resolve_callchain(al->thread, cursor,
> -				      sample, NULL, NULL,
> -				      scripting_max_stack) != 0) {
> -		pr_err("Failed to resolve callchain. Skipping\n");
> -		goto exit;
> -	}
> -	callchain_cursor_commit(cursor);
> -
> -
> -	while (1) {
> -		PyObject *pyelem;
> -		struct callchain_cursor_node *node;
> -		node = callchain_cursor_current(cursor);
> -		if (!node)
> -			break;
> -
> -		pyelem = PyDict_New();
> -		if (!pyelem)
> -			Py_FatalError("couldn't create Python dictionary");
> -
> -
> -		pydict_set_item_string_decref(pyelem, "ip",
> -				PyLong_FromUnsignedLongLong(node->ip));
> -
> -		if (node->ms.sym) {
> -			PyObject *pysym  = PyDict_New();
> -			if (!pysym)
> -				Py_FatalError("couldn't create Python dictionary");
> -			pydict_set_item_string_decref(pysym, "start",
> -					PyLong_FromUnsignedLongLong(node->ms.sym->start));
> -			pydict_set_item_string_decref(pysym, "end",
> -					PyLong_FromUnsignedLongLong(node->ms.sym->end));
> -			pydict_set_item_string_decref(pysym, "binding",
> -					_PyLong_FromLong(symbol__binding(node->ms.sym)));
> -			pydict_set_item_string_decref(pysym, "name",
> -					_PyUnicode_FromStringAndSize(node->ms.sym->name,
> -							node->ms.sym->namelen));
> -			pydict_set_item_string_decref(pyelem, "sym", pysym);
> -
> -			if (node->ms.map) {
> -				struct map *map = node->ms.map;
> -				struct addr_location node_al;
> -				unsigned long offset;
> -
> -				addr_location__init(&node_al);
> -				node_al.addr = map__map_ip(map, node->ip);
> -				node_al.map  = map__get(map);
> -				offset = get_offset(node->ms.sym, &node_al);
> -				addr_location__exit(&node_al);
> -
> -				pydict_set_item_string_decref(
> -					pyelem, "sym_off",
> -					PyLong_FromUnsignedLongLong(offset));
> -			}
> -			if (node->srcline && strcmp(":0", node->srcline)) {
> -				pydict_set_item_string_decref(
> -					pyelem, "sym_srcline",
> -					_PyUnicode_FromString(node->srcline));
> -			}
> -		}
> -
> -		if (node->ms.map) {
> -			const char *dsoname = get_dsoname(node->ms.map);
> -
> -			pydict_set_item_string_decref(pyelem, "dso",
> -					_PyUnicode_FromString(dsoname));
> -		}
> -
> -		callchain_cursor_advance(cursor);
> -		PyList_Append(pylist, pyelem);
> -		Py_DECREF(pyelem);
> -	}
> -
> -exit:
> -	return pylist;
> -}
> -
> -static PyObject *python_process_brstack(struct perf_sample *sample,
> -					struct thread *thread)
> -{
> -	struct branch_stack *br = sample->branch_stack;
> -	struct branch_entry *entries = perf_sample__branch_entries(sample);
> -	PyObject *pylist;
> -	u64 i;
> -
> -	pylist = PyList_New(0);
> -	if (!pylist)
> -		Py_FatalError("couldn't create Python list");
> -
> -	if (!(br && br->nr))
> -		goto exit;
> -
> -	for (i = 0; i < br->nr; i++) {
> -		PyObject *pyelem;
> -		struct addr_location al;
> -		const char *dsoname;
> -
> -		pyelem = PyDict_New();
> -		if (!pyelem)
> -			Py_FatalError("couldn't create Python dictionary");
> -
> -		pydict_set_item_string_decref(pyelem, "from",
> -		    PyLong_FromUnsignedLongLong(entries[i].from));
> -		pydict_set_item_string_decref(pyelem, "to",
> -		    PyLong_FromUnsignedLongLong(entries[i].to));
> -		pydict_set_item_string_decref(pyelem, "mispred",
> -		    PyBool_FromLong(entries[i].flags.mispred));
> -		pydict_set_item_string_decref(pyelem, "predicted",
> -		    PyBool_FromLong(entries[i].flags.predicted));
> -		pydict_set_item_string_decref(pyelem, "in_tx",
> -		    PyBool_FromLong(entries[i].flags.in_tx));
> -		pydict_set_item_string_decref(pyelem, "abort",
> -		    PyBool_FromLong(entries[i].flags.abort));
> -		pydict_set_item_string_decref(pyelem, "cycles",
> -		    PyLong_FromUnsignedLongLong(entries[i].flags.cycles));
> -
> -		addr_location__init(&al);
> -		thread__find_map_fb(thread, sample->cpumode,
> -				    entries[i].from, &al);
> -		dsoname = get_dsoname(al.map);
> -		pydict_set_item_string_decref(pyelem, "from_dsoname",
> -					      _PyUnicode_FromString(dsoname));
> -
> -		thread__find_map_fb(thread, sample->cpumode,
> -				    entries[i].to, &al);
> -		dsoname = get_dsoname(al.map);
> -		pydict_set_item_string_decref(pyelem, "to_dsoname",
> -					      _PyUnicode_FromString(dsoname));
> -
> -		addr_location__exit(&al);
> -		PyList_Append(pylist, pyelem);
> -		Py_DECREF(pyelem);
> -	}
> -
> -exit:
> -	return pylist;
> -}
> -
> -static int get_symoff(struct symbol *sym, struct addr_location *al,
> -		      bool print_off, char *bf, int size)
> -{
> -	unsigned long offset;
> -
> -	if (!sym || !sym->name[0])
> -		return scnprintf(bf, size, "%s", "[unknown]");
> -
> -	if (!print_off)
> -		return scnprintf(bf, size, "%s", sym->name);
> -
> -	offset = get_offset(sym, al);
> -
> -	return scnprintf(bf, size, "%s+0x%x", sym->name, offset);
> -}
> -
> -static int get_br_mspred(struct branch_flags *flags, char *bf, int size)
> -{
> -	if (!flags->mispred  && !flags->predicted)
> -		return scnprintf(bf, size, "%s", "-");
> -
> -	if (flags->mispred)
> -		return scnprintf(bf, size, "%s", "M");
> -
> -	return scnprintf(bf, size, "%s", "P");
> -}
> -
> -static PyObject *python_process_brstacksym(struct perf_sample *sample,
> -					   struct thread *thread)
> -{
> -	struct branch_stack *br = sample->branch_stack;
> -	struct branch_entry *entries = perf_sample__branch_entries(sample);
> -	PyObject *pylist;
> -	u64 i;
> -	char bf[512];
> -
> -	pylist = PyList_New(0);
> -	if (!pylist)
> -		Py_FatalError("couldn't create Python list");
> -
> -	if (!(br && br->nr))
> -		goto exit;
> -
> -	for (i = 0; i < br->nr; i++) {
> -		PyObject *pyelem;
> -		struct addr_location al;
> -
> -		addr_location__init(&al);
> -		pyelem = PyDict_New();
> -		if (!pyelem)
> -			Py_FatalError("couldn't create Python dictionary");
> -
> -		thread__find_symbol_fb(thread, sample->cpumode,
> -				       entries[i].from, &al);
> -		get_symoff(al.sym, &al, true, bf, sizeof(bf));
> -		pydict_set_item_string_decref(pyelem, "from",
> -					      _PyUnicode_FromString(bf));
> -
> -		thread__find_symbol_fb(thread, sample->cpumode,
> -				       entries[i].to, &al);
> -		get_symoff(al.sym, &al, true, bf, sizeof(bf));
> -		pydict_set_item_string_decref(pyelem, "to",
> -					      _PyUnicode_FromString(bf));
> -
> -		get_br_mspred(&entries[i].flags, bf, sizeof(bf));
> -		pydict_set_item_string_decref(pyelem, "pred",
> -					      _PyUnicode_FromString(bf));
> -
> -		if (entries[i].flags.in_tx) {
> -			pydict_set_item_string_decref(pyelem, "in_tx",
> -					      _PyUnicode_FromString("X"));
> -		} else {
> -			pydict_set_item_string_decref(pyelem, "in_tx",
> -					      _PyUnicode_FromString("-"));
> -		}
> -
> -		if (entries[i].flags.abort) {
> -			pydict_set_item_string_decref(pyelem, "abort",
> -					      _PyUnicode_FromString("A"));
> -		} else {
> -			pydict_set_item_string_decref(pyelem, "abort",
> -					      _PyUnicode_FromString("-"));
> -		}
> -
> -		PyList_Append(pylist, pyelem);
> -		Py_DECREF(pyelem);
> -		addr_location__exit(&al);
> -	}
> -
> -exit:
> -	return pylist;
> -}
> -
> -static PyObject *get_sample_value_as_tuple(struct sample_read_value *value,
> -					   u64 read_format)
> -{
> -	PyObject *t;
> -
> -	t = PyTuple_New(3);
> -	if (!t)
> -		Py_FatalError("couldn't create Python tuple");
> -	PyTuple_SetItem(t, 0, PyLong_FromUnsignedLongLong(value->id));
> -	PyTuple_SetItem(t, 1, PyLong_FromUnsignedLongLong(value->value));
> -	if (read_format & PERF_FORMAT_LOST)
> -		PyTuple_SetItem(t, 2, PyLong_FromUnsignedLongLong(value->lost));
> -
> -	return t;
> -}
> -
> -static void set_sample_read_in_dict(PyObject *dict_sample, struct perf_sample *sample)
> -{
> -	u64 read_format = sample->evsel->core.attr.read_format;
> -	PyObject *values;
> -	unsigned int i;
> -
> -	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED) {
> -		pydict_set_item_string_decref(dict_sample, "time_enabled",
> -			PyLong_FromUnsignedLongLong(sample->read.time_enabled));
> -	}
> -
> -	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING) {
> -		pydict_set_item_string_decref(dict_sample, "time_running",
> -			PyLong_FromUnsignedLongLong(sample->read.time_running));
> -	}
> -
> -	if (read_format & PERF_FORMAT_GROUP)
> -		values = PyList_New(sample->read.group.nr);
> -	else
> -		values = PyList_New(1);
> -
> -	if (!values)
> -		Py_FatalError("couldn't create Python list");
> -
> -	if (read_format & PERF_FORMAT_GROUP) {
> -		struct sample_read_value *v = sample->read.group.values;
> -
> -		i = 0;
> -		sample_read_group__for_each(v, sample->read.group.nr, read_format) {
> -			PyObject *t = get_sample_value_as_tuple(v, read_format);
> -			PyList_SET_ITEM(values, i, t);
> -			i++;
> -		}
> -	} else {
> -		PyObject *t = get_sample_value_as_tuple(&sample->read.one,
> -							read_format);
> -		PyList_SET_ITEM(values, 0, t);
> -	}
> -	pydict_set_item_string_decref(dict_sample, "values", values);
> -}
> -
> -static void set_sample_datasrc_in_dict(PyObject *dict,
> -				      struct perf_sample *sample)
> -{
> -	struct perf_session *session = evsel__session(sample->evsel);
> -	struct mem_info *mi = mem_info__new();
> -	char decode[200];
> -
> -	if (!mi)
> -		Py_FatalError("couldn't create mem-info");
> -
> -	pydict_set_item_string_decref(dict, "datasrc",
> -			PyLong_FromUnsignedLongLong(sample->data_src));
> -
> -	mem_info__data_src(mi)->val = sample->data_src;
> -	perf_script__meminfo_scnprintf(decode, 200, mi, session);
> -	mem_info__put(mi);
> -
> -	pydict_set_item_string_decref(dict, "datasrc_decode",
> -			_PyUnicode_FromString(decode));
> -}
> -
> -static int regs_map(struct regs_dump *regs, uint64_t mask, uint16_t e_machine,
> -		    uint32_t e_flags, char *bf, int size)
> -{
> -	unsigned int i = 0, r;
> -	int printed = 0;
> -
> -	bf[0] = 0;
> -
> -	if (size <= 0)
> -		return 0;
> -
> -	if (!regs || !regs->regs)
> -		return 0;
> -
> -	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
> -		u64 val = regs->regs[i++];
> -
> -		printed += scnprintf(bf + printed, size - printed,
> -				     "%5s:0x%" PRIx64 " ",
> -				     perf_reg_name(r, e_machine, e_flags, regs->abi), val);
> -	}
> -
> -	return printed;
> -}
> -
> -static void simd_regs_map(struct regs_dump *regs, struct perf_event_attr *attr,
> -			  uint16_t e_machine, char *bf, int size, int printed, bool intr)
> -{
> -	const char *name = "unknown";
> -	int reg_c, idx, pred_base;
> -	unsigned int i = 0, j;
> -	uint16_t qwords;
> -
> -	if (size <= 0 || printed >= size)
> -		return;
> -
> -	if (!regs || !regs->simd_data)
> -		return;
> -
> -	if (!regs->nr_vectors && !regs->nr_pred)
> -		return;
> -
> -	for (reg_c = 0; reg_c < 64; reg_c++) {
> -		if (!regs->nr_vectors)
> -			break;
> -		if (intr) {
> -			perf_intr_simd_reg_class_bitmap_qwords(e_machine, reg_c,
> -							       &qwords, /*pred=*/false);
> -		} else {
> -			perf_user_simd_reg_class_bitmap_qwords(e_machine, reg_c,
> -							       &qwords, /*pred=*/false);
> -		}
> -		if (regs->vector_qwords == qwords) {
> -			name = perf_simd_reg_class_name(e_machine, reg_c, /*pred=*/false);
> -			break;
> -		}
> -	}
> -
> -	for (i = 0; i < regs->nr_vectors; i++) {
> -		for (j = 0; j < regs->vector_qwords; j++) {
> -			idx = i * regs->vector_qwords + j;
> -			if (regs->vector_qwords > 1) {
> -				printed += scnprintf(bf + printed, size - printed,
> -						"%5s[%d][%d]:0x%" PRIx64 " ",
> -						name, i, j, regs->simd_data[idx]);
> -			} else {
> -				printed += scnprintf(bf + printed, size - printed,
> -						"%5s[%d]:0x%" PRIx64 " ",
> -						name, i, regs->simd_data[idx]);
> -			}
> -		}
> -	}
> -
> -	name = "unknown";
> -	for (reg_c = 0; reg_c < 64; reg_c++) {
> -		if (!regs->nr_pred)
> -			break;
> -		if (intr) {
> -			perf_intr_simd_reg_class_bitmap_qwords(e_machine, reg_c,
> -							       &qwords, /*pred=*/true);
> -		} else {
> -			perf_user_simd_reg_class_bitmap_qwords(e_machine, reg_c,
> -							       &qwords, /*pred=*/true);
> -		}
> -		if (regs->pred_qwords == qwords) {
> -			name = perf_simd_reg_class_name(e_machine, reg_c, /*pred=*/true);
> -			break;
> -		}
> -	}
> -
> -	pred_base = regs->nr_vectors * regs->vector_qwords;
> -	for (i = 0; i < regs->nr_pred; i++) {
> -		for (j = 0; j < regs->pred_qwords; j++) {
> -			idx = pred_base + i * regs->pred_qwords + j;
> -			if (regs->pred_qwords > 1) {
> -				printed += scnprintf(bf + printed, size - printed,
> -						"%5s[%d][%d]:0x%" PRIx64 " ",
> -						name, i, j, regs->simd_data[idx]);
> -			} else {
> -				printed += scnprintf(bf + printed, size - printed,
> -						"%5s[%d]:0x%" PRIx64 " ",
> -						name, i, regs->simd_data[idx]);
> -			}
> -		}
> -	}
> -}
> -
> -#define MAX_REG_SIZE 128
> -
> -static int set_regs_in_dict(PyObject *dict,
> -			     struct perf_sample *sample,
> -			     uint16_t e_machine,
> -			     uint32_t e_flags)
> -{
> -	struct perf_event_attr *attr = &sample->evsel->core.attr;
> -	int intr_size, user_size, size;
> -	struct regs_dump *regs;
> -	char *bf = NULL;
> -	int printed;
> -
> -	intr_size = (__sw_hweight64(attr->sample_regs_intr) * MAX_REG_SIZE) + 1;
> -	user_size = (__sw_hweight64(attr->sample_regs_user) * MAX_REG_SIZE) + 1;
> -	if (sample->intr_regs && attr->sample_simd_regs_enabled) {
> -		regs = sample->intr_regs;
> -		intr_size += (regs->nr_vectors * regs->vector_qwords +
> -			      regs->nr_pred * regs->pred_qwords) * MAX_REG_SIZE;
> -	}
> -	if (sample->user_regs && attr->sample_simd_regs_enabled) {
> -		regs = sample->user_regs;
> -		user_size += (regs->nr_vectors * regs->vector_qwords +
> -			      regs->nr_pred * regs->pred_qwords) * MAX_REG_SIZE;
> -	}
> -	size = intr_size > user_size ? intr_size : user_size;
> -
> -	if (sample->intr_regs) {
> -		bf = malloc(size);
> -		if (!bf)
> -			return -1;
> -
> -		printed = regs_map(sample->intr_regs, attr->sample_regs_intr,
> -				   e_machine, e_flags, bf, size);
> -		if (attr->sample_simd_regs_enabled) {
> -			simd_regs_map(sample->intr_regs, attr, e_machine, bf,
> -				      size, printed, true);
> -		}
> -
> -		pydict_set_item_string_decref(dict, "iregs",
> -					_PyUnicode_FromString(bf));
> -	}
> -
> -	if (sample->user_regs) {
> -		if (!bf) {
> -			bf = malloc(size);
> -			if (!bf)
> -				return -1;
> -		}
> -		printed = regs_map(sample->user_regs, attr->sample_regs_user,
> -				   e_machine, e_flags, bf, size);
> -		if (attr->sample_simd_regs_enabled) {
> -			simd_regs_map(sample->user_regs, attr, e_machine, bf,
> -				      size, printed, false);
> -		}
> -
> -		pydict_set_item_string_decref(dict, "uregs",
> -					_PyUnicode_FromString(bf));
> -	}
> -	free(bf);
> -
> -	return 0;
> -}
> -
> -static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
> -			    const char *dso_field, const char *dso_bid_field,
> -			    const char *dso_map_start, const char *dso_map_end,
> -			    const char *sym_field, const char *symoff_field,
> -			    const char *map_pgoff)
> -{
> -	if (al->map) {
> -		char sbuild_id[SBUILD_ID_SIZE];
> -		struct dso *dso = map__dso(al->map);
> -
> -		pydict_set_item_string_decref(dict, dso_field,
> -					      _PyUnicode_FromString(dso__name(dso)));
> -		build_id__snprintf(dso__bid(dso), sbuild_id, sizeof(sbuild_id));
> -		pydict_set_item_string_decref(dict, dso_bid_field,
> -			_PyUnicode_FromString(sbuild_id));
> -		pydict_set_item_string_decref(dict, dso_map_start,
> -			PyLong_FromUnsignedLong(map__start(al->map)));
> -		pydict_set_item_string_decref(dict, dso_map_end,
> -			PyLong_FromUnsignedLong(map__end(al->map)));
> -		pydict_set_item_string_decref(dict, map_pgoff,
> -			PyLong_FromUnsignedLongLong(map__pgoff(al->map)));
> -	}
> -	if (al->sym) {
> -		pydict_set_item_string_decref(dict, sym_field,
> -			_PyUnicode_FromString(al->sym->name));
> -		pydict_set_item_string_decref(dict, symoff_field,
> -			PyLong_FromUnsignedLong(get_offset(al->sym, al)));
> -	}
> -}
> -
> -static void set_sample_flags(PyObject *dict, u32 flags)
> -{
> -	const char *ch = PERF_IP_FLAG_CHARS;
> -	char *p, str[33];
> -
> -	for (p = str; *ch; ch++, flags >>= 1) {
> -		if (flags & 1)
> -			*p++ = *ch;
> -	}
> -	*p = 0;
> -	pydict_set_item_string_decref(dict, "flags", _PyUnicode_FromString(str));
> -}
> -
> -static void python_process_sample_flags(struct perf_sample *sample, PyObject *dict_sample)
> -{
> -	char flags_disp[SAMPLE_FLAGS_BUF_SIZE];
> -
> -	set_sample_flags(dict_sample, sample->flags);
> -	perf_sample__sprintf_flags(sample->flags, flags_disp, sizeof(flags_disp));
> -	pydict_set_item_string_decref(dict_sample, "flags_disp",
> -		_PyUnicode_FromString(flags_disp));
> -}
> -
> -static PyObject *get_perf_sample_dict(struct perf_sample *sample,
> -					 struct addr_location *al,
> -					 struct addr_location *addr_al,
> -					 PyObject *callchain)
> -{
> -	PyObject *dict, *dict_sample, *brstack, *brstacksym;
> -	uint16_t e_machine = EM_HOST;
> -	uint32_t e_flags = EF_HOST;
> -	struct evsel *evsel = sample->evsel;
> -
> -	dict = PyDict_New();
> -	if (!dict)
> -		Py_FatalError("couldn't create Python dictionary");
> -
> -	dict_sample = PyDict_New();
> -	if (!dict_sample)
> -		Py_FatalError("couldn't create Python dictionary");
> -
> -	pydict_set_item_string_decref(dict, "ev_name", _PyUnicode_FromString(evsel__name(evsel)));
> -	pydict_set_item_string_decref(dict, "attr", _PyBytes_FromStringAndSize((const char *)&evsel->core.attr, sizeof(evsel->core.attr)));
> -
> -	pydict_set_item_string_decref(dict_sample, "id",
> -			PyLong_FromUnsignedLongLong(sample->id));
> -	pydict_set_item_string_decref(dict_sample, "stream_id",
> -			PyLong_FromUnsignedLongLong(sample->stream_id));
> -	pydict_set_item_string_decref(dict_sample, "pid",
> -			_PyLong_FromLong(sample->pid));
> -	pydict_set_item_string_decref(dict_sample, "tid",
> -			_PyLong_FromLong(sample->tid));
> -	pydict_set_item_string_decref(dict_sample, "cpu",
> -			_PyLong_FromLong(sample->cpu));
> -	pydict_set_item_string_decref(dict_sample, "ip",
> -			PyLong_FromUnsignedLongLong(sample->ip));
> -	pydict_set_item_string_decref(dict_sample, "time",
> -			PyLong_FromUnsignedLongLong(sample->time));
> -	pydict_set_item_string_decref(dict_sample, "period",
> -			PyLong_FromUnsignedLongLong(sample->period));
> -	pydict_set_item_string_decref(dict_sample, "phys_addr",
> -			PyLong_FromUnsignedLongLong(sample->phys_addr));
> -	pydict_set_item_string_decref(dict_sample, "addr",
> -			PyLong_FromUnsignedLongLong(sample->addr));
> -	set_sample_read_in_dict(dict_sample, sample);
> -	pydict_set_item_string_decref(dict_sample, "weight",
> -			PyLong_FromUnsignedLongLong(sample->weight));
> -	pydict_set_item_string_decref(dict_sample, "ins_lat",
> -			PyLong_FromUnsignedLong(sample->ins_lat));
> -	pydict_set_item_string_decref(dict_sample, "transaction",
> -			PyLong_FromUnsignedLongLong(sample->transaction));
> -	set_sample_datasrc_in_dict(dict_sample, sample);
> -	pydict_set_item_string_decref(dict, "sample", dict_sample);
> -
> -	pydict_set_item_string_decref(dict, "raw_buf", _PyBytes_FromStringAndSize(
> -			(const char *)sample->raw_data, sample->raw_size));
> -	pydict_set_item_string_decref(dict, "comm",
> -			_PyUnicode_FromString(thread__comm_str(al->thread)));
> -	set_sym_in_dict(dict, al, "dso", "dso_bid", "dso_map_start", "dso_map_end",
> -			"symbol", "symoff", "map_pgoff");
> -
> -	pydict_set_item_string_decref(dict, "callchain", callchain);
> -
> -	brstack = python_process_brstack(sample, al->thread);
> -	pydict_set_item_string_decref(dict, "brstack", brstack);
> -
> -	brstacksym = python_process_brstacksym(sample, al->thread);
> -	pydict_set_item_string_decref(dict, "brstacksym", brstacksym);
> -
> -	if (sample->machine_pid) {
> -		pydict_set_item_string_decref(dict_sample, "machine_pid",
> -				_PyLong_FromLong(sample->machine_pid));
> -		pydict_set_item_string_decref(dict_sample, "vcpu",
> -				_PyLong_FromLong(sample->vcpu));
> -	}
> -
> -	pydict_set_item_string_decref(dict_sample, "cpumode",
> -			_PyLong_FromLong((unsigned long)sample->cpumode));
> -
> -	if (addr_al) {
> -		pydict_set_item_string_decref(dict_sample, "addr_correlates_sym",
> -			PyBool_FromLong(1));
> -		set_sym_in_dict(dict_sample, addr_al, "addr_dso", "addr_dso_bid",
> -				"addr_dso_map_start", "addr_dso_map_end",
> -				"addr_symbol", "addr_symoff", "addr_map_pgoff");
> -	}
> -
> -	if (sample->flags)
> -		python_process_sample_flags(sample, dict_sample);
> -
> -	/* Instructions per cycle (IPC) */
> -	if (sample->insn_cnt && sample->cyc_cnt) {
> -		pydict_set_item_string_decref(dict_sample, "insn_cnt",
> -			PyLong_FromUnsignedLongLong(sample->insn_cnt));
> -		pydict_set_item_string_decref(dict_sample, "cyc_cnt",
> -			PyLong_FromUnsignedLongLong(sample->cyc_cnt));
> -	}
> -
> -	if (al->thread)
> -		e_machine = thread__e_machine(al->thread, /*machine=*/NULL, &e_flags);
> -
> -	if (set_regs_in_dict(dict, sample, e_machine, e_flags))
> -		Py_FatalError("Failed to setting regs in dict");
> -
> -	return dict;
> -}
> -
> -#ifdef HAVE_LIBTRACEEVENT
> -static void python_process_tracepoint(struct perf_sample *sample,
> -				      struct addr_location *al,
> -				      struct addr_location *addr_al)
> -{
> -	struct tep_event *event;
> -	PyObject *handler, *context, *t, *obj = NULL, *callchain;
> -	PyObject *dict = NULL, *all_entries_dict = NULL;
> -	static char handler_name[256];
> -	struct tep_format_field *field;
> -	unsigned long s, ns;
> -	unsigned n = 0;
> -	int pid;
> -	int cpu = sample->cpu;
> -	void *data = sample->raw_data;
> -	unsigned long long nsecs = sample->time;
> -	const char *comm = thread__comm_str(al->thread);
> -	const char *default_handler_name = "trace_unhandled";
> -	DECLARE_BITMAP(events_defined, TRACE_EVENT_TYPE_MAX);
> -	struct evsel *evsel = sample->evsel;
> -
> -	bitmap_zero(events_defined, TRACE_EVENT_TYPE_MAX);
> -
> -	event = evsel__tp_format(evsel);
> -	if (!event) {
> -		snprintf(handler_name, sizeof(handler_name),
> -			 "ug! no event found for type %" PRIu64, (u64)evsel->core.attr.config);
> -		Py_FatalError(handler_name);
> -	}
> -
> -	pid = raw_field_value(event, "common_pid", data);
> -
> -	sprintf(handler_name, "%s__%s", event->system, event->name);
> -
> -	if (!__test_and_set_bit(event->id, events_defined))
> -		define_event_symbols(event, handler_name, event->print_fmt.args);
> -
> -	handler = get_handler(handler_name);
> -	if (!handler) {
> -		handler = get_handler(default_handler_name);
> -		if (!handler)
> -			return;
> -		dict = PyDict_New();
> -		if (!dict)
> -			Py_FatalError("couldn't create Python dict");
> -	}
> -
> -	t = PyTuple_New(MAX_FIELDS);
> -	if (!t)
> -		Py_FatalError("couldn't create Python tuple");
> -
> -
> -	s = nsecs / NSEC_PER_SEC;
> -	ns = nsecs - s * NSEC_PER_SEC;
> -
> -	context = _PyCapsule_New(scripting_context, NULL, NULL);
> -
> -	PyTuple_SetItem(t, n++, _PyUnicode_FromString(handler_name));
> -	PyTuple_SetItem(t, n++, context);
> -
> -	/* ip unwinding */
> -	callchain = python_process_callchain(sample, al);
> -	/* Need an additional reference for the perf_sample dict */
> -	Py_INCREF(callchain);
> -
> -	if (!dict) {
> -		PyTuple_SetItem(t, n++, _PyLong_FromLong(cpu));
> -		PyTuple_SetItem(t, n++, _PyLong_FromLong(s));
> -		PyTuple_SetItem(t, n++, _PyLong_FromLong(ns));
> -		PyTuple_SetItem(t, n++, _PyLong_FromLong(pid));
> -		PyTuple_SetItem(t, n++, _PyUnicode_FromString(comm));
> -		PyTuple_SetItem(t, n++, callchain);
> -	} else {
> -		pydict_set_item_string_decref(dict, "common_cpu", _PyLong_FromLong(cpu));
> -		pydict_set_item_string_decref(dict, "common_s", _PyLong_FromLong(s));
> -		pydict_set_item_string_decref(dict, "common_ns", _PyLong_FromLong(ns));
> -		pydict_set_item_string_decref(dict, "common_pid", _PyLong_FromLong(pid));
> -		pydict_set_item_string_decref(dict, "common_comm", _PyUnicode_FromString(comm));
> -		pydict_set_item_string_decref(dict, "common_callchain", callchain);
> -	}
> -	for (field = event->format.fields; field; field = field->next) {
> -		unsigned int offset, len;
> -		unsigned long long val;
> -
> -		if (field->flags & TEP_FIELD_IS_ARRAY) {
> -			offset = field->offset;
> -			len    = field->size;
> -			if (field->flags & TEP_FIELD_IS_DYNAMIC) {
> -				val     = tep_read_number(scripting_context->pevent,
> -							  data + offset, len);
> -				offset  = val;
> -				len     = offset >> 16;
> -				offset &= 0xffff;
> -				if (tep_field_is_relative(field->flags))
> -					offset += field->offset + field->size;
> -			}
> -			if (field->flags & TEP_FIELD_IS_STRING &&
> -			    is_printable_array(data + offset, len)) {
> -				obj = _PyUnicode_FromString((char *) data + offset);
> -			} else {
> -				obj = PyByteArray_FromStringAndSize((const char *) data + offset, len);
> -				field->flags &= ~TEP_FIELD_IS_STRING;
> -			}
> -		} else { /* FIELD_IS_NUMERIC */
> -			obj = get_field_numeric_entry(event, field, data);
> -		}
> -		if (!dict)
> -			PyTuple_SetItem(t, n++, obj);
> -		else
> -			pydict_set_item_string_decref(dict, field->name, obj);
> -
> -	}
> -
> -	if (dict)
> -		PyTuple_SetItem(t, n++, dict);
> -
> -	if (get_argument_count(handler) == (int) n + 1) {
> -		all_entries_dict = get_perf_sample_dict(sample, al, addr_al,
> -			callchain);
> -		PyTuple_SetItem(t, n++,	all_entries_dict);
> -	} else {
> -		Py_DECREF(callchain);
> -	}
> -
> -	if (_PyTuple_Resize(&t, n) == -1)
> -		Py_FatalError("error resizing Python tuple");
> -
> -	if (!dict)
> -		call_object(handler, t, handler_name);
> -	else
> -		call_object(handler, t, default_handler_name);
> -
> -	Py_DECREF(t);
> -}
> -#else
> -static void python_process_tracepoint(struct perf_sample *sample __maybe_unused,
> -				      struct addr_location *al __maybe_unused,
> -				      struct addr_location *addr_al __maybe_unused)
> -{
> -	fprintf(stderr, "Tracepoint events are not supported because "
> -			"perf is not linked with libtraceevent.\n");
> -}
> -#endif
> -
> -static PyObject *tuple_new(unsigned int sz)
> -{
> -	PyObject *t;
> -
> -	t = PyTuple_New(sz);
> -	if (!t)
> -		Py_FatalError("couldn't create Python tuple");
> -	return t;
> -}
> -
> -static int tuple_set_s64(PyObject *t, unsigned int pos, s64 val)
> -{
> -#if BITS_PER_LONG == 64
> -	return PyTuple_SetItem(t, pos, _PyLong_FromLong(val));
> -#endif
> -#if BITS_PER_LONG == 32
> -	return PyTuple_SetItem(t, pos, PyLong_FromLongLong(val));
> -#endif
> -}
> -
> -/*
> - * Databases support only signed 64-bit numbers, so even though we are
> - * exporting a u64, it must be as s64.
> - */
> -#define tuple_set_d64 tuple_set_s64
> -
> -static int tuple_set_u64(PyObject *t, unsigned int pos, u64 val)
> -{
> -#if BITS_PER_LONG == 64
> -	return PyTuple_SetItem(t, pos, PyLong_FromUnsignedLong(val));
> -#endif
> -#if BITS_PER_LONG == 32
> -	return PyTuple_SetItem(t, pos, PyLong_FromUnsignedLongLong(val));
> -#endif
> -}
> -
> -static int tuple_set_u32(PyObject *t, unsigned int pos, u32 val)
> -{
> -	return PyTuple_SetItem(t, pos, PyLong_FromUnsignedLong(val));
> -}
> -
> -static int tuple_set_s32(PyObject *t, unsigned int pos, s32 val)
> -{
> -	return PyTuple_SetItem(t, pos, _PyLong_FromLong(val));
> -}
> -
> -static int tuple_set_bool(PyObject *t, unsigned int pos, bool val)
> -{
> -	return PyTuple_SetItem(t, pos, PyBool_FromLong(val));
> -}
> -
> -static int tuple_set_string(PyObject *t, unsigned int pos, const char *s)
> -{
> -	return PyTuple_SetItem(t, pos, _PyUnicode_FromString(s));
> -}
> -
> -static int tuple_set_bytes(PyObject *t, unsigned int pos, void *bytes,
> -			   unsigned int sz)
> -{
> -	return PyTuple_SetItem(t, pos, _PyBytes_FromStringAndSize(bytes, sz));
> -}
> -
> -static int python_export_evsel(struct db_export *dbe, struct evsel *evsel)
> -{
> -	struct tables *tables = container_of(dbe, struct tables, dbe);
> -	PyObject *t;
> -
> -	t = tuple_new(2);
> -
> -	tuple_set_d64(t, 0, evsel->db_id);
> -	tuple_set_string(t, 1, evsel__name(evsel));
> -
> -	call_object(tables->evsel_handler, t, "evsel_table");
> -
> -	Py_DECREF(t);
> -
> -	return 0;
> -}
> -
> -static int python_export_machine(struct db_export *dbe,
> -				 struct machine *machine)
> -{
> -	struct tables *tables = container_of(dbe, struct tables, dbe);
> -	PyObject *t;
> -
> -	t = tuple_new(3);
> -
> -	tuple_set_d64(t, 0, machine->db_id);
> -	tuple_set_s32(t, 1, machine->pid);
> -	tuple_set_string(t, 2, machine->root_dir ? machine->root_dir : "");
> -
> -	call_object(tables->machine_handler, t, "machine_table");
> -
> -	Py_DECREF(t);
> -
> -	return 0;
> -}
> -
> -static int python_export_thread(struct db_export *dbe, struct thread *thread,
> -				u64 main_thread_db_id, struct machine *machine)
> -{
> -	struct tables *tables = container_of(dbe, struct tables, dbe);
> -	PyObject *t;
> -
> -	t = tuple_new(5);
> -
> -	tuple_set_d64(t, 0, thread__db_id(thread));
> -	tuple_set_d64(t, 1, machine->db_id);
> -	tuple_set_d64(t, 2, main_thread_db_id);
> -	tuple_set_s32(t, 3, thread__pid(thread));
> -	tuple_set_s32(t, 4, thread__tid(thread));
> -
> -	call_object(tables->thread_handler, t, "thread_table");
> -
> -	Py_DECREF(t);
> -
> -	return 0;
> -}
> -
> -static int python_export_comm(struct db_export *dbe, struct comm *comm,
> -			      struct thread *thread)
> -{
> -	struct tables *tables = container_of(dbe, struct tables, dbe);
> -	PyObject *t;
> -
> -	t = tuple_new(5);
> -
> -	tuple_set_d64(t, 0, comm->db_id);
> -	tuple_set_string(t, 1, comm__str(comm));
> -	tuple_set_d64(t, 2, thread__db_id(thread));
> -	tuple_set_d64(t, 3, comm->start);
> -	tuple_set_s32(t, 4, comm->exec);
> -
> -	call_object(tables->comm_handler, t, "comm_table");
> -
> -	Py_DECREF(t);
> -
> -	return 0;
> -}
> -
> -static int python_export_comm_thread(struct db_export *dbe, u64 db_id,
> -				     struct comm *comm, struct thread *thread)
> -{
> -	struct tables *tables = container_of(dbe, struct tables, dbe);
> -	PyObject *t;
> -
> -	t = tuple_new(3);
> -
> -	tuple_set_d64(t, 0, db_id);
> -	tuple_set_d64(t, 1, comm->db_id);
> -	tuple_set_d64(t, 2, thread__db_id(thread));
> -
> -	call_object(tables->comm_thread_handler, t, "comm_thread_table");
> -
> -	Py_DECREF(t);
> -
> -	return 0;
> -}
> -
> -static int python_export_dso(struct db_export *dbe, struct dso *dso,
> -			     struct machine *machine)
> -{
> -	struct tables *tables = container_of(dbe, struct tables, dbe);
> -	char sbuild_id[SBUILD_ID_SIZE];
> -	PyObject *t;
> -
> -	build_id__snprintf(dso__bid(dso), sbuild_id, sizeof(sbuild_id));
> -
> -	t = tuple_new(5);
> -
> -	tuple_set_d64(t, 0, dso__db_id(dso));
> -	tuple_set_d64(t, 1, machine->db_id);
> -	tuple_set_string(t, 2, dso__short_name(dso));
> -	tuple_set_string(t, 3, dso__long_name(dso));
> -	tuple_set_string(t, 4, sbuild_id);
> -
> -	call_object(tables->dso_handler, t, "dso_table");
> -
> -	Py_DECREF(t);
> -
> -	return 0;
> -}
> -
> -static int python_export_symbol(struct db_export *dbe, struct symbol *sym,
> -				struct dso *dso)
> -{
> -	struct tables *tables = container_of(dbe, struct tables, dbe);
> -	u64 *sym_db_id = symbol__priv(sym);
> -	PyObject *t;
> -
> -	t = tuple_new(6);
> -
> -	tuple_set_d64(t, 0, *sym_db_id);
> -	tuple_set_d64(t, 1, dso__db_id(dso));
> -	tuple_set_d64(t, 2, sym->start);
> -	tuple_set_d64(t, 3, sym->end);
> -	tuple_set_s32(t, 4, symbol__binding(sym));
> -	tuple_set_string(t, 5, sym->name);
> -
> -	call_object(tables->symbol_handler, t, "symbol_table");
> -
> -	Py_DECREF(t);
> -
> -	return 0;
> -}
> -
> -static int python_export_branch_type(struct db_export *dbe, u32 branch_type,
> -				     const char *name)
> -{
> -	struct tables *tables = container_of(dbe, struct tables, dbe);
> -	PyObject *t;
> -
> -	t = tuple_new(2);
> -
> -	tuple_set_s32(t, 0, branch_type);
> -	tuple_set_string(t, 1, name);
> -
> -	call_object(tables->branch_type_handler, t, "branch_type_table");
> -
> -	Py_DECREF(t);
> -
> -	return 0;
> -}
> -
> -static void python_export_sample_table(struct db_export *dbe,
> -				       struct export_sample *es)
> -{
> -	struct tables *tables = container_of(dbe, struct tables, dbe);
> -	PyObject *t;
> -
> -	t = tuple_new(28);
> -
> -	tuple_set_d64(t, 0, es->db_id);
> -	tuple_set_d64(t, 1, es->sample->evsel->db_id);
> -	tuple_set_d64(t, 2, maps__machine(thread__maps(es->al->thread))->db_id);
> -	tuple_set_d64(t, 3, thread__db_id(es->al->thread));
> -	tuple_set_d64(t, 4, es->comm_db_id);
> -	tuple_set_d64(t, 5, es->dso_db_id);
> -	tuple_set_d64(t, 6, es->sym_db_id);
> -	tuple_set_d64(t, 7, es->offset);
> -	tuple_set_d64(t, 8, es->sample->ip);
> -	tuple_set_d64(t, 9, es->sample->time);
> -	tuple_set_s32(t, 10, es->sample->cpu);
> -	tuple_set_d64(t, 11, es->addr_dso_db_id);
> -	tuple_set_d64(t, 12, es->addr_sym_db_id);
> -	tuple_set_d64(t, 13, es->addr_offset);
> -	tuple_set_d64(t, 14, es->sample->addr);
> -	tuple_set_d64(t, 15, es->sample->period);
> -	tuple_set_d64(t, 16, es->sample->weight);
> -	tuple_set_d64(t, 17, es->sample->transaction);
> -	tuple_set_d64(t, 18, es->sample->data_src);
> -	tuple_set_s32(t, 19, es->sample->flags & PERF_BRANCH_MASK);
> -	tuple_set_s32(t, 20, !!(es->sample->flags & PERF_IP_FLAG_IN_TX));
> -	tuple_set_d64(t, 21, es->call_path_id);
> -	tuple_set_d64(t, 22, es->sample->insn_cnt);
> -	tuple_set_d64(t, 23, es->sample->cyc_cnt);
> -	tuple_set_s32(t, 24, es->sample->flags);
> -	tuple_set_d64(t, 25, es->sample->id);
> -	tuple_set_d64(t, 26, es->sample->stream_id);
> -	tuple_set_u32(t, 27, es->sample->ins_lat);
> -
> -	call_object(tables->sample_handler, t, "sample_table");
> -
> -	Py_DECREF(t);
> -}
> -
> -static void python_export_synth(struct db_export *dbe, struct export_sample *es)
> -{
> -	struct tables *tables = container_of(dbe, struct tables, dbe);
> -	PyObject *t;
> -
> -	t = tuple_new(3);
> -
> -	tuple_set_d64(t, 0, es->db_id);
> -	tuple_set_d64(t, 1, es->sample->evsel->core.attr.config);
> -	tuple_set_bytes(t, 2, es->sample->raw_data, es->sample->raw_size);
> -
> -	call_object(tables->synth_handler, t, "synth_data");
> -
> -	Py_DECREF(t);
> -}
> -
> -static int python_export_sample(struct db_export *dbe,
> -				struct export_sample *es)
> -{
> -	struct tables *tables = container_of(dbe, struct tables, dbe);
> -
> -	python_export_sample_table(dbe, es);
> -
> -	if (es->sample->evsel->core.attr.type == PERF_TYPE_SYNTH && tables->synth_handler)
> -		python_export_synth(dbe, es);
> -
> -	return 0;
> -}
> -
> -static int python_export_call_path(struct db_export *dbe, struct call_path *cp)
> -{
> -	struct tables *tables = container_of(dbe, struct tables, dbe);
> -	PyObject *t;
> -	u64 parent_db_id, sym_db_id;
> -
> -	parent_db_id = cp->parent ? cp->parent->db_id : 0;
> -	sym_db_id = cp->sym ? *(u64 *)symbol__priv(cp->sym) : 0;
> -
> -	t = tuple_new(4);
> -
> -	tuple_set_d64(t, 0, cp->db_id);
> -	tuple_set_d64(t, 1, parent_db_id);
> -	tuple_set_d64(t, 2, sym_db_id);
> -	tuple_set_d64(t, 3, cp->ip);
> -
> -	call_object(tables->call_path_handler, t, "call_path_table");
> -
> -	Py_DECREF(t);
> -
> -	return 0;
> -}
> -
> -static int python_export_call_return(struct db_export *dbe,
> -				     struct call_return *cr)
> -{
> -	struct tables *tables = container_of(dbe, struct tables, dbe);
> -	u64 comm_db_id = cr->comm ? cr->comm->db_id : 0;
> -	PyObject *t;
> -
> -	t = tuple_new(14);
> -
> -	tuple_set_d64(t, 0, cr->db_id);
> -	tuple_set_d64(t, 1, thread__db_id(cr->thread));
> -	tuple_set_d64(t, 2, comm_db_id);
> -	tuple_set_d64(t, 3, cr->cp->db_id);
> -	tuple_set_d64(t, 4, cr->call_time);
> -	tuple_set_d64(t, 5, cr->return_time);
> -	tuple_set_d64(t, 6, cr->branch_count);
> -	tuple_set_d64(t, 7, cr->call_ref);
> -	tuple_set_d64(t, 8, cr->return_ref);
> -	tuple_set_d64(t, 9, cr->cp->parent->db_id);
> -	tuple_set_s32(t, 10, cr->flags);
> -	tuple_set_d64(t, 11, cr->parent_db_id);
> -	tuple_set_d64(t, 12, cr->insn_count);
> -	tuple_set_d64(t, 13, cr->cyc_count);
> -
> -	call_object(tables->call_return_handler, t, "call_return_table");
> -
> -	Py_DECREF(t);
> -
> -	return 0;
> -}
> -
> -static int python_export_context_switch(struct db_export *dbe, u64 db_id,
> -					struct machine *machine,
> -					struct perf_sample *sample,
> -					u64 th_out_id, u64 comm_out_id,
> -					u64 th_in_id, u64 comm_in_id, int flags)
> -{
> -	struct tables *tables = container_of(dbe, struct tables, dbe);
> -	PyObject *t;
> -
> -	t = tuple_new(9);
> -
> -	tuple_set_d64(t, 0, db_id);
> -	tuple_set_d64(t, 1, machine->db_id);
> -	tuple_set_d64(t, 2, sample->time);
> -	tuple_set_s32(t, 3, sample->cpu);
> -	tuple_set_d64(t, 4, th_out_id);
> -	tuple_set_d64(t, 5, comm_out_id);
> -	tuple_set_d64(t, 6, th_in_id);
> -	tuple_set_d64(t, 7, comm_in_id);
> -	tuple_set_s32(t, 8, flags);
> -
> -	call_object(tables->context_switch_handler, t, "context_switch");
> -
> -	Py_DECREF(t);
> -
> -	return 0;
> -}
> -
> -static int python_process_call_return(struct call_return *cr, u64 *parent_db_id,
> -				      void *data)
> -{
> -	struct db_export *dbe = data;
> -
> -	return db_export__call_return(dbe, cr, parent_db_id);
> -}
> -
> -static void python_process_general_event(struct perf_sample *sample,
> -					 struct addr_location *al,
> -					 struct addr_location *addr_al)
> -{
> -	PyObject *handler, *t, *dict, *callchain;
> -	static char handler_name[64];
> -	unsigned n = 0;
> -
> -	snprintf(handler_name, sizeof(handler_name), "%s", "process_event");
> -
> -	handler = get_handler(handler_name);
> -	if (!handler)
> -		return;
> -
> -	/*
> -	 * Use the MAX_FIELDS to make the function expandable, though
> -	 * currently there is only one item for the tuple.
> -	 */
> -	t = PyTuple_New(MAX_FIELDS);
> -	if (!t)
> -		Py_FatalError("couldn't create Python tuple");
> -
> -	/* ip unwinding */
> -	callchain = python_process_callchain(sample, al);
> -	dict = get_perf_sample_dict(sample, al, addr_al, callchain);
> -
> -	PyTuple_SetItem(t, n++, dict);
> -	if (_PyTuple_Resize(&t, n) == -1)
> -		Py_FatalError("error resizing Python tuple");
> -
> -	call_object(handler, t, handler_name);
> -
> -	Py_DECREF(t);
> -}
> -
> -static void python_process_event(union perf_event *event,
> -				 struct perf_sample *sample,
> -				 struct addr_location *al,
> -				 struct addr_location *addr_al)
> -{
> -	struct tables *tables = &tables_global;
> -
> -	scripting_context__update(scripting_context, event, sample, al, addr_al);
> -
> -	switch (sample->evsel->core.attr.type) {
> -	case PERF_TYPE_TRACEPOINT:
> -		python_process_tracepoint(sample, al, addr_al);
> -		break;
> -	/* Reserve for future process_hw/sw/raw APIs */
> -	default:
> -		if (tables->db_export_mode)
> -			db_export__sample(&tables->dbe, event, sample, al, addr_al);
> -		else
> -			python_process_general_event(sample, al, addr_al);
> -	}
> -}
> -
> -static void python_process_throttle(union perf_event *event,
> -				    struct perf_sample *sample,
> -				    struct machine *machine)
> -{
> -	const char *handler_name;
> -	PyObject *handler, *t;
> -
> -	if (event->header.type == PERF_RECORD_THROTTLE)
> -		handler_name = "throttle";
> -	else
> -		handler_name = "unthrottle";
> -	handler = get_handler(handler_name);
> -	if (!handler)
> -		return;
> -
> -	t = tuple_new(6);
> -	if (!t)
> -		return;
> -
> -	tuple_set_u64(t, 0, event->throttle.time);
> -	tuple_set_u64(t, 1, event->throttle.id);
> -	tuple_set_u64(t, 2, event->throttle.stream_id);
> -	tuple_set_s32(t, 3, sample->cpu);
> -	tuple_set_s32(t, 4, sample->pid);
> -	tuple_set_s32(t, 5, sample->tid);
> -
> -	call_object(handler, t, handler_name);
> -
> -	Py_DECREF(t);
> -}
> -
> -static void python_do_process_switch(union perf_event *event,
> -				     struct perf_sample *sample,
> -				     struct machine *machine)
> -{
> -	const char *handler_name = "context_switch";
> -	bool out = event->header.misc & PERF_RECORD_MISC_SWITCH_OUT;
> -	bool out_preempt = out && (event->header.misc & PERF_RECORD_MISC_SWITCH_OUT_PREEMPT);
> -	pid_t np_pid = -1, np_tid = -1;
> -	PyObject *handler, *t;
> -
> -	handler = get_handler(handler_name);
> -	if (!handler)
> -		return;
> -
> -	if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE) {
> -		np_pid = event->context_switch.next_prev_pid;
> -		np_tid = event->context_switch.next_prev_tid;
> -	}
> -
> -	t = tuple_new(11);
> -	if (!t)
> -		return;
> -
> -	tuple_set_u64(t, 0, sample->time);
> -	tuple_set_s32(t, 1, sample->cpu);
> -	tuple_set_s32(t, 2, sample->pid);
> -	tuple_set_s32(t, 3, sample->tid);
> -	tuple_set_s32(t, 4, np_pid);
> -	tuple_set_s32(t, 5, np_tid);
> -	tuple_set_s32(t, 6, machine->pid);
> -	tuple_set_bool(t, 7, out);
> -	tuple_set_bool(t, 8, out_preempt);
> -	tuple_set_s32(t, 9, sample->machine_pid);
> -	tuple_set_s32(t, 10, sample->vcpu);
> -
> -	call_object(handler, t, handler_name);
> -
> -	Py_DECREF(t);
> -}
> -
> -static void python_process_switch(union perf_event *event,
> -				  struct perf_sample *sample,
> -				  struct machine *machine)
> -{
> -	struct tables *tables = &tables_global;
> -
> -	if (tables->db_export_mode)
> -		db_export__switch(&tables->dbe, event, sample, machine);
> -	else
> -		python_do_process_switch(event, sample, machine);
> -}
> -
> -static void python_process_auxtrace_error(struct perf_session *session __maybe_unused,
> -					  union perf_event *event)
> -{
> -	struct perf_record_auxtrace_error *e = &event->auxtrace_error;
> -	u8 cpumode = e->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
> -	const char *handler_name = "auxtrace_error";
> -	unsigned long long tm = e->time;
> -	const char *msg = e->msg;
> -	s32 machine_pid = 0, vcpu = 0;
> -	char msg_buf[MAX_AUXTRACE_ERROR_MSG + 1];
> -	int msg_max;
> -	PyObject *handler, *t;
> -
> -	handler = get_handler(handler_name);
> -	if (!handler)
> -		return;
> -
> -	if (!e->fmt) {
> -		tm = 0;
> -		msg = (const char *)&e->time;
> -	}
> -
> -	/* Bound msg to the bytes within the event, ensure NUL-termination */
> -	msg_max = (int)((void *)event + event->header.size - (void *)msg);
> -	if (msg_max <= 0) {
> -		msg_buf[0] = '\0';
> -	} else {
> -		if (msg_max > (int)sizeof(msg_buf) - 1)
> -			msg_max = sizeof(msg_buf) - 1;
> -		memcpy(msg_buf, msg, msg_max);
> -		msg_buf[msg_max] = '\0';
> -	}
> -
> -	/* Only access fmt >= 2 fields if the event is large enough */
> -	if (e->fmt >= 2 &&
> -	    event->header.size >= offsetof(typeof(event->auxtrace_error), vcpu) +
> -				  sizeof(event->auxtrace_error.vcpu)) {
> -		machine_pid = e->machine_pid;
> -		vcpu = e->vcpu;
> -	}
> -
> -	t = tuple_new(11);
> -
> -	tuple_set_u32(t, 0, e->type);
> -	tuple_set_u32(t, 1, e->code);
> -	tuple_set_s32(t, 2, e->cpu);
> -	tuple_set_s32(t, 3, e->pid);
> -	tuple_set_s32(t, 4, e->tid);
> -	tuple_set_u64(t, 5, e->ip);
> -	tuple_set_u64(t, 6, tm);
> -	tuple_set_string(t, 7, msg_buf);
> -	tuple_set_u32(t, 8, cpumode);
> -	tuple_set_s32(t, 9, machine_pid);
> -	tuple_set_s32(t, 10, vcpu);
> -
> -	call_object(handler, t, handler_name);
> -
> -	Py_DECREF(t);
> -}
> -
> -static void get_handler_name(char *str, size_t size,
> -			     struct evsel *evsel)
> -{
> -	char *p = str;
> -
> -	scnprintf(str, size, "stat__%s", evsel__name(evsel));
> -
> -	while ((p = strchr(p, ':'))) {
> -		*p = '_';
> -		p++;
> -	}
> -}
> -
> -static void
> -process_stat(struct evsel *counter, struct perf_cpu cpu, int thread, u64 tstamp,
> -	     struct perf_counts_values *count)
> -{
> -	PyObject *handler, *t;
> -	static char handler_name[256];
> -	int n = 0;
> -
> -	t = PyTuple_New(MAX_FIELDS);
> -	if (!t)
> -		Py_FatalError("couldn't create Python tuple");
> -
> -	get_handler_name(handler_name, sizeof(handler_name),
> -			 counter);
> -
> -	handler = get_handler(handler_name);
> -	if (!handler) {
> -		pr_debug("can't find python handler %s\n", handler_name);
> -		return;
> -	}
> -
> -	PyTuple_SetItem(t, n++, _PyLong_FromLong(cpu.cpu));
> -	PyTuple_SetItem(t, n++, _PyLong_FromLong(thread));
> -
> -	tuple_set_u64(t, n++, tstamp);
> -	tuple_set_u64(t, n++, count->val);
> -	tuple_set_u64(t, n++, count->ena);
> -	tuple_set_u64(t, n++, count->run);
> -
> -	if (_PyTuple_Resize(&t, n) == -1)
> -		Py_FatalError("error resizing Python tuple");
> -
> -	call_object(handler, t, handler_name);
> -
> -	Py_DECREF(t);
> -}
> -
> -static void python_process_stat(struct perf_stat_config *config,
> -				struct evsel *counter, u64 tstamp)
> -{
> -	struct perf_thread_map *threads = counter->core.threads;
> -	struct perf_cpu_map *cpus = counter->core.cpus;
> -
> -	for (int thread = 0; thread < perf_thread_map__nr(threads); thread++) {
> -		unsigned int idx;
> -		struct perf_cpu cpu;
> -
> -		perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
> -			process_stat(counter, cpu,
> -				     perf_thread_map__pid(threads, thread), tstamp,
> -				     perf_counts(counter->counts, idx, thread));
> -		}
> -	}
> -}
> -
> -static void python_process_stat_interval(u64 tstamp)
> -{
> -	PyObject *handler, *t;
> -	static const char handler_name[] = "stat__interval";
> -	int n = 0;
> -
> -	t = PyTuple_New(MAX_FIELDS);
> -	if (!t)
> -		Py_FatalError("couldn't create Python tuple");
> -
> -	handler = get_handler(handler_name);
> -	if (!handler) {
> -		pr_debug("can't find python handler %s\n", handler_name);
> -		return;
> -	}
> -
> -	tuple_set_u64(t, n++, tstamp);
> -
> -	if (_PyTuple_Resize(&t, n) == -1)
> -		Py_FatalError("error resizing Python tuple");
> -
> -	call_object(handler, t, handler_name);
> -
> -	Py_DECREF(t);
> -}
> -
> -static int perf_script_context_init(void)
> -{
> -	PyObject *perf_script_context;
> -	PyObject *perf_trace_context;
> -	PyObject *dict;
> -	int ret;
> -
> -	perf_trace_context = PyImport_AddModule("perf_trace_context");
> -	if (!perf_trace_context)
> -		return -1;
> -	dict = PyModule_GetDict(perf_trace_context);
> -	if (!dict)
> -		return -1;
> -
> -	perf_script_context = _PyCapsule_New(scripting_context, NULL, NULL);
> -	if (!perf_script_context)
> -		return -1;
> -
> -	ret = PyDict_SetItemString(dict, "perf_script_context", perf_script_context);
> -	if (!ret)
> -		ret = PyDict_SetItemString(main_dict, "perf_script_context", perf_script_context);
> -	Py_DECREF(perf_script_context);
> -	return ret;
> -}
> -
> -static int run_start_sub(void)
> -{
> -	main_module = PyImport_AddModule("__main__");
> -	if (main_module == NULL)
> -		return -1;
> -	Py_INCREF(main_module);
> -
> -	main_dict = PyModule_GetDict(main_module);
> -	if (main_dict == NULL)
> -		goto error;
> -	Py_INCREF(main_dict);
> -
> -	if (perf_script_context_init())
> -		goto error;
> -
> -	try_call_object("trace_begin", NULL);
> -
> -	return 0;
> -
> -error:
> -	Py_XDECREF(main_dict);
> -	Py_XDECREF(main_module);
> -	return -1;
> -}
> -
> -#define SET_TABLE_HANDLER_(name, handler_name, table_name) do {		\
> -	tables->handler_name = get_handler(#table_name);		\
> -	if (tables->handler_name)					\
> -		tables->dbe.export_ ## name = python_export_ ## name;	\
> -} while (0)
> -
> -#define SET_TABLE_HANDLER(name) \
> -	SET_TABLE_HANDLER_(name, name ## _handler, name ## _table)
> -
> -static void set_table_handlers(struct tables *tables)
> -{
> -	const char *perf_db_export_mode = "perf_db_export_mode";
> -	const char *perf_db_export_calls = "perf_db_export_calls";
> -	const char *perf_db_export_callchains = "perf_db_export_callchains";
> -	PyObject *db_export_mode, *db_export_calls, *db_export_callchains;
> -	bool export_calls = false;
> -	bool export_callchains = false;
> -	int ret;
> -
> -	memset(tables, 0, sizeof(struct tables));
> -	if (db_export__init(&tables->dbe))
> -		Py_FatalError("failed to initialize export");
> -
> -	db_export_mode = PyDict_GetItemString(main_dict, perf_db_export_mode);
> -	if (!db_export_mode)
> -		return;
> -
> -	ret = PyObject_IsTrue(db_export_mode);
> -	if (ret == -1)
> -		handler_call_die(perf_db_export_mode);
> -	if (!ret)
> -		return;
> -
> -	/* handle export calls */
> -	tables->dbe.crp = NULL;
> -	db_export_calls = PyDict_GetItemString(main_dict, perf_db_export_calls);
> -	if (db_export_calls) {
> -		ret = PyObject_IsTrue(db_export_calls);
> -		if (ret == -1)
> -			handler_call_die(perf_db_export_calls);
> -		export_calls = !!ret;
> -	}
> -
> -	if (export_calls) {
> -		tables->dbe.crp =
> -			call_return_processor__new(python_process_call_return,
> -						   &tables->dbe);
> -		if (!tables->dbe.crp)
> -			Py_FatalError("failed to create calls processor");
> -	}
> -
> -	/* handle export callchains */
> -	tables->dbe.cpr = NULL;
> -	db_export_callchains = PyDict_GetItemString(main_dict,
> -						    perf_db_export_callchains);
> -	if (db_export_callchains) {
> -		ret = PyObject_IsTrue(db_export_callchains);
> -		if (ret == -1)
> -			handler_call_die(perf_db_export_callchains);
> -		export_callchains = !!ret;
> -	}
> -
> -	if (export_callchains) {
> -		/*
> -		 * Attempt to use the call path root from the call return
> -		 * processor, if the call return processor is in use. Otherwise,
> -		 * we allocate a new call path root. This prevents exporting
> -		 * duplicate call path ids when both are in use simultaneously.
> -		 */
> -		if (tables->dbe.crp)
> -			tables->dbe.cpr = tables->dbe.crp->cpr;
> -		else
> -			tables->dbe.cpr = call_path_root__new();
> -
> -		if (!tables->dbe.cpr)
> -			Py_FatalError("failed to create call path root");
> -	}
> -
> -	tables->db_export_mode = true;
> -	/*
> -	 * Reserve per symbol space for symbol->db_id via symbol__priv()
> -	 */
> -	symbol_conf.priv_size = sizeof(u64);
> -
> -	SET_TABLE_HANDLER(evsel);
> -	SET_TABLE_HANDLER(machine);
> -	SET_TABLE_HANDLER(thread);
> -	SET_TABLE_HANDLER(comm);
> -	SET_TABLE_HANDLER(comm_thread);
> -	SET_TABLE_HANDLER(dso);
> -	SET_TABLE_HANDLER(symbol);
> -	SET_TABLE_HANDLER(branch_type);
> -	SET_TABLE_HANDLER(sample);
> -	SET_TABLE_HANDLER(call_path);
> -	SET_TABLE_HANDLER(call_return);
> -	SET_TABLE_HANDLER(context_switch);
> -
> -	/*
> -	 * Synthesized events are samples but with architecture-specific data
> -	 * stored in sample->raw_data. They are exported via
> -	 * python_export_sample() and consequently do not need a separate export
> -	 * callback.
> -	 */
> -	tables->synth_handler = get_handler("synth_data");
> -}
> -
> -static void _free_command_line(wchar_t **command_line, int num)
> -{
> -	int i;
> -	for (i = 0; i < num; i++)
> -		PyMem_RawFree(command_line[i]);
> -	free(command_line);
> -}
> -
> -
> -/*
> - * Start trace script
> - */
> -static int python_start_script(const char *script, int argc, const char **argv,
> -			       struct perf_session *session)
> -{
> -	struct tables *tables = &tables_global;
> -	wchar_t **command_line;
> -	char buf[PATH_MAX];
> -	int i, err = 0;
> -	FILE *fp;
> -
> -	scripting_context->session = session;
> -	command_line = malloc((argc + 1) * sizeof(wchar_t *));
> -	if (!command_line)
> -		return -1;
> -
> -	command_line[0] = Py_DecodeLocale(script, NULL);
> -	for (i = 1; i < argc + 1; i++)
> -		command_line[i] = Py_DecodeLocale(argv[i - 1], NULL);
> -	PyImport_AppendInittab("perf_trace_context", PyInit_perf_trace_context);
> -	Py_Initialize();
> -
> -	PySys_SetArgv(argc + 1, command_line);
> -
> -	fp = fopen(script, "r");
> -	if (!fp) {
> -		sprintf(buf, "Can't open python script \"%s\"", script);
> -		perror(buf);
> -		err = -1;
> -		goto error;
> -	}
> -
> -	err = PyRun_SimpleFile(fp, script);
> -	if (err) {
> -		fprintf(stderr, "Error running python script %s\n", script);
> -		goto error;
> -	}
> -
> -	err = run_start_sub();
> -	if (err) {
> -		fprintf(stderr, "Error starting python script %s\n", script);
> -		goto error;
> -	}
> -
> -	set_table_handlers(tables);
> -
> -	if (tables->db_export_mode) {
> -		err = db_export__branch_types(&tables->dbe);
> -		if (err)
> -			goto error;
> -	}
> -
> -	_free_command_line(command_line, argc + 1);
> -
> -	return err;
> -error:
> -	Py_Finalize();
> -	_free_command_line(command_line, argc + 1);
> -
> -	return err;
> -}
> -
> -static int python_flush_script(void)
> -{
> -	return 0;
> -}
> -
> -/*
> - * Stop trace script
> - */
> -static int python_stop_script(void)
> -{
> -	struct tables *tables = &tables_global;
> -
> -	try_call_object("trace_end", NULL);
> -
> -	db_export__exit(&tables->dbe);
> -
> -	Py_XDECREF(main_dict);
> -	Py_XDECREF(main_module);
> -	Py_Finalize();
> -
> -	return 0;
> -}
> -
> -#ifdef HAVE_LIBTRACEEVENT
> -static int python_generate_script(struct tep_handle *pevent, const char *outfile)
> -{
> -	int i, not_first, count, nr_events;
> -	struct tep_event **all_events;
> -	struct tep_event *event = NULL;
> -	struct tep_format_field *f;
> -	char fname[PATH_MAX];
> -	FILE *ofp;
> -
> -	sprintf(fname, "%s.py", outfile);
> -	ofp = fopen(fname, "w");
> -	if (ofp == NULL) {
> -		fprintf(stderr, "couldn't open %s\n", fname);
> -		return -1;
> -	}
> -	fprintf(ofp, "# perf script event handlers, "
> -		"generated by perf script -g python\n");
> -
> -	fprintf(ofp, "# Licensed under the terms of the GNU GPL"
> -		" License version 2\n\n");
> -
> -	fprintf(ofp, "# The common_* event handler fields are the most useful "
> -		"fields common to\n");
> -
> -	fprintf(ofp, "# all events.  They don't necessarily correspond to "
> -		"the 'common_*' fields\n");
> -
> -	fprintf(ofp, "# in the format files.  Those fields not available as "
> -		"handler params can\n");
> -
> -	fprintf(ofp, "# be retrieved using Python functions of the form "
> -		"common_*(context).\n");
> -
> -	fprintf(ofp, "# See the perf-script-python Documentation for the list "
> -		"of available functions.\n\n");
> -
> -	fprintf(ofp, "from __future__ import print_function\n\n");
> -	fprintf(ofp, "import os\n");
> -	fprintf(ofp, "import sys\n\n");
> -
> -	fprintf(ofp, "sys.path.append(os.environ['PERF_EXEC_PATH'] + \\\n");
> -	fprintf(ofp, "\t'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')\n");
> -	fprintf(ofp, "\nfrom perf_trace_context import *\n");
> -	fprintf(ofp, "from Core import *\n\n\n");
> -
> -	fprintf(ofp, "def trace_begin():\n");
> -	fprintf(ofp, "\tprint(\"in trace_begin\")\n\n");
> -
> -	fprintf(ofp, "def trace_end():\n");
> -	fprintf(ofp, "\tprint(\"in trace_end\")\n\n");
> -
> -	nr_events = tep_get_events_count(pevent);
> -	all_events = tep_list_events(pevent, TEP_EVENT_SORT_ID);
> -
> -	for (i = 0; all_events && i < nr_events; i++) {
> -		event = all_events[i];
> -		fprintf(ofp, "def %s__%s(", event->system, event->name);
> -		fprintf(ofp, "event_name, ");
> -		fprintf(ofp, "context, ");
> -		fprintf(ofp, "common_cpu,\n");
> -		fprintf(ofp, "\tcommon_secs, ");
> -		fprintf(ofp, "common_nsecs, ");
> -		fprintf(ofp, "common_pid, ");
> -		fprintf(ofp, "common_comm,\n\t");
> -		fprintf(ofp, "common_callchain, ");
> -
> -		not_first = 0;
> -		count = 0;
> -
> -		for (f = event->format.fields; f; f = f->next) {
> -			if (not_first++)
> -				fprintf(ofp, ", ");
> -			if (++count % 5 == 0)
> -				fprintf(ofp, "\n\t");
> -
> -			fprintf(ofp, "%s", f->name);
> -		}
> -		if (not_first++)
> -			fprintf(ofp, ", ");
> -		if (++count % 5 == 0)
> -			fprintf(ofp, "\n\t\t");
> -		fprintf(ofp, "perf_sample_dict");
> -
> -		fprintf(ofp, "):\n");
> -
> -		fprintf(ofp, "\t\tprint_header(event_name, common_cpu, "
> -			"common_secs, common_nsecs,\n\t\t\t"
> -			"common_pid, common_comm)\n\n");
> -
> -		fprintf(ofp, "\t\tprint(\"");
> -
> -		not_first = 0;
> -		count = 0;
> -
> -		for (f = event->format.fields; f; f = f->next) {
> -			if (not_first++)
> -				fprintf(ofp, ", ");
> -			if (count && count % 3 == 0) {
> -				fprintf(ofp, "\" \\\n\t\t\"");
> -			}
> -			count++;
> -
> -			fprintf(ofp, "%s=", f->name);
> -			if (f->flags & TEP_FIELD_IS_STRING ||
> -			    f->flags & TEP_FIELD_IS_FLAG ||
> -			    f->flags & TEP_FIELD_IS_ARRAY ||
> -			    f->flags & TEP_FIELD_IS_SYMBOLIC)
> -				fprintf(ofp, "%%s");
> -			else if (f->flags & TEP_FIELD_IS_SIGNED)
> -				fprintf(ofp, "%%d");
> -			else
> -				fprintf(ofp, "%%u");
> -		}
> -
> -		fprintf(ofp, "\" %% \\\n\t\t(");
> -
> -		not_first = 0;
> -		count = 0;
> -
> -		for (f = event->format.fields; f; f = f->next) {
> -			if (not_first++)
> -				fprintf(ofp, ", ");
> -
> -			if (++count % 5 == 0)
> -				fprintf(ofp, "\n\t\t");
> -
> -			if (f->flags & TEP_FIELD_IS_FLAG) {
> -				if ((count - 1) % 5 != 0) {
> -					fprintf(ofp, "\n\t\t");
> -					count = 4;
> -				}
> -				fprintf(ofp, "flag_str(\"");
> -				fprintf(ofp, "%s__%s\", ", event->system,
> -					event->name);
> -				fprintf(ofp, "\"%s\", %s)", f->name,
> -					f->name);
> -			} else if (f->flags & TEP_FIELD_IS_SYMBOLIC) {
> -				if ((count - 1) % 5 != 0) {
> -					fprintf(ofp, "\n\t\t");
> -					count = 4;
> -				}
> -				fprintf(ofp, "symbol_str(\"");
> -				fprintf(ofp, "%s__%s\", ", event->system,
> -					event->name);
> -				fprintf(ofp, "\"%s\", %s)", f->name,
> -					f->name);
> -			} else
> -				fprintf(ofp, "%s", f->name);
> -		}
> -
> -		fprintf(ofp, "))\n\n");
> -
> -		fprintf(ofp, "\t\tprint('Sample: {'+"
> -			"get_dict_as_string(perf_sample_dict['sample'], ', ')+'}')\n\n");
> -
> -		fprintf(ofp, "\t\tfor node in common_callchain:");
> -		fprintf(ofp, "\n\t\t\tif 'sym' in node:");
> -		fprintf(ofp, "\n\t\t\t\tprint(\"\t[%%x] %%s%%s%%s%%s\" %% (");
> -		fprintf(ofp, "\n\t\t\t\t\tnode['ip'], node['sym']['name'],");
> -		fprintf(ofp, "\n\t\t\t\t\t\"+0x{:x}\".format(node['sym_off']) if 'sym_off' in node else \"\",");
> -		fprintf(ofp, "\n\t\t\t\t\t\" ({})\".format(node['dso'])  if 'dso' in node else \"\",");
> -		fprintf(ofp, "\n\t\t\t\t\t\" \" + node['sym_srcline'] if 'sym_srcline' in node else \"\"))");
> -		fprintf(ofp, "\n\t\t\telse:");
> -		fprintf(ofp, "\n\t\t\t\tprint(\"\t[%%x]\" %% (node['ip']))\n\n");
> -		fprintf(ofp, "\t\tprint()\n\n");
> -
> -	}
> -
> -	fprintf(ofp, "def trace_unhandled(event_name, context, "
> -		"event_fields_dict, perf_sample_dict):\n");
> -
> -	fprintf(ofp, "\t\tprint(get_dict_as_string(event_fields_dict))\n");
> -	fprintf(ofp, "\t\tprint('Sample: {'+"
> -		"get_dict_as_string(perf_sample_dict['sample'], ', ')+'}')\n\n");
> -
> -	fprintf(ofp, "def print_header("
> -		"event_name, cpu, secs, nsecs, pid, comm):\n"
> -		"\tprint(\"%%-20s %%5u %%05u.%%09u %%8u %%-20s \" %% \\\n\t"
> -		"(event_name, cpu, secs, nsecs, pid, comm), end=\"\")\n\n");
> -
> -	fprintf(ofp, "def get_dict_as_string(a_dict, delimiter=' '):\n"
> -		"\treturn delimiter.join"
> -		"(['%%s=%%s'%%(k,str(v))for k,v in sorted(a_dict.items())])\n");
> -
> -	fclose(ofp);
> -
> -	fprintf(stderr, "generated Python script: %s\n", fname);
> -
> -	return 0;
> -}
> -#else
> -static int python_generate_script(struct tep_handle *pevent __maybe_unused,
> -				  const char *outfile __maybe_unused)
> -{
> -	fprintf(stderr, "Generating Python perf-script is not supported."
> -		"  Install libtraceevent and rebuild perf to enable it.\n"
> -		"For example:\n  # apt install libtraceevent-dev (ubuntu)"
> -		"\n  # yum install libtraceevent-devel (Fedora)"
> -		"\n  etc.\n");
> -	return -1;
> -}
> -#endif
> -
> -struct scripting_ops python_scripting_ops = {
> -	.name			= "Python",
> -	.dirname		= "python",
> -	.start_script		= python_start_script,
> -	.flush_script		= python_flush_script,
> -	.stop_script		= python_stop_script,
> -	.process_event		= python_process_event,
> -	.process_switch		= python_process_switch,
> -	.process_auxtrace_error	= python_process_auxtrace_error,
> -	.process_stat		= python_process_stat,
> -	.process_stat_interval	= python_process_stat_interval,
> -	.process_throttle	= python_process_throttle,
> -	.generate_script	= python_generate_script,
> -};
> diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
> index dc584ac316a3..c78b317978dd 100644
> --- a/tools/perf/util/trace-event-scripting.c
> +++ b/tools/perf/util/trace-event-scripting.c
> @@ -189,19 +189,10 @@ static void register_python_scripting(struct scripting_ops *scripting_ops)
>  	}
>  }
>  
> -#ifndef HAVE_LIBPYTHON_SUPPORT
>  void setup_python_scripting(void)
>  {
>  	register_python_scripting(&python_scripting_unsupported_ops);
>  }
> -#else
> -extern struct scripting_ops python_scripting_ops;
> -
> -void setup_python_scripting(void)
> -{
> -	register_python_scripting(&python_scripting_ops);
> -}
> -#endif
>  
>  #ifdef HAVE_LIBTRACEEVENT
>  static void print_perl_unsupported_msg(void)
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
