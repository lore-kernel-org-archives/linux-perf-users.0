Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081A11D6DA9;
	Sat, 10 Jan 2026 01:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768008699; cv=none; b=uebnUylX3NytoqU5QVoOpae3gXAg8pTKrr+4TshDPCevzjUl6wYtQeXxIQWVepKgTTk9wOdIfMsdsFltUc7tK0U70vymt6obW2w+0rueR1dBiAtUfjAh5kLUgWlnC+eSgGD4M/z00bvZDL7SanJjU/F7RYDVPKoPt1Ytzv/aB1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768008699; c=relaxed/simple;
	bh=j4ocz4TFt1K5C8m5VlbQHwev4UykY1VgC2Fb53Rhw9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bE4CV6vvTLjXG00mhWiBf5m+IKixHCaB3ia5nGq33HAaih9S/6mY3Us37P/5HxLbVD58L0jQ3YkZ2vIA4R/GmDcwYvoOngmE9Hk5xlXMwQ55cR2O4FPm9xBbGsE61VEsryWkOWEaqSyZp72v9oDgrtAEVH6Fv7J07iretYoNEks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHRInVVd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHRInVVd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E153C4CEF1;
	Sat, 10 Jan 2026 01:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768008698;
	bh=j4ocz4TFt1K5C8m5VlbQHwev4UykY1VgC2Fb53Rhw9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NHRInVVdOuId9f4LHGGO3sSr98n26A85UzM4Qj4KvGoaMlxildRn8vVmaqIc6X6LJ
	 PWoIe91qujC8eFhNIIWm8/lH893yRi9GhJHcNjqcjtOr+Guome2ehTICS0pbLtM0zX
	 N55KpQAEmPFlmfxnUyu4mIxna0N+55ym3+VjOSOdG3vYJRGGeous5Cc3J75S1JNpQZ
	 37p3d/MDeq44BMO/znypqXRkJ5ldohCOVID6lBZwu+dj6BYx/00da9AN5jvd3/d1vP
	 mtBlKsNwz672My30lU9m0QTUvaWaEuGl/DlbzEwVswB7RI7Eu1uJsW3u10wUEZkSu7
	 cG/n1Lf+qAStg==
Date: Fri, 9 Jan 2026 17:31:36 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1] perf help: Move common_cmds into builtin-help
Message-ID: <aWGr-JUBZd2YHgkH@google.com>
References: <20251204211143.572382-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251204211143.572382-1-irogers@google.com>

On Thu, Dec 04, 2025 at 01:11:43PM -0800, Ian Rogers wrote:
> There's a lot of infrastructure for generating a relatively simple
> array used by one function. Move the array into the function and
> remove the supporting build logic. At the same time opportunistically
> const-ify the array.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/Makefile.perf            | 11 ++---
>  tools/perf/builtin-help.c           | 51 ++++++++++++++++++---
>  tools/perf/command-list.txt         | 36 ---------------
>  tools/perf/util/Build               | 14 ------
>  tools/perf/util/generate-cmdlist.sh | 70 -----------------------------
>  5 files changed, 49 insertions(+), 133 deletions(-)
>  delete mode 100644 tools/perf/command-list.txt
>  delete mode 100755 tools/perf/util/generate-cmdlist.sh
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 80decc7ce13c..a91c5d01f3b4 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -807,11 +807,6 @@ $(GTK_IN): FORCE prepare
>  $(OUTPUT)libperf-gtk.so: $(GTK_IN) $(PERFLIBS)
>  	$(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(filter %.o,$^) $(GTK_LIBS)
>  
> -$(OUTPUT)common-cmds.h: util/generate-cmdlist.sh command-list.txt
> -
> -$(OUTPUT)common-cmds.h: $(wildcard Documentation/perf-*.txt)
> -	$(QUIET_GEN). util/generate-cmdlist.sh > $@+ && mv $@+ $@
> -
>  $(SCRIPTS) : % : %.sh
>  	$(QUIET_GEN)$(INSTALL) '$@.sh' '$(OUTPUT)$@'
>  
> @@ -849,7 +844,7 @@ endif
>  __build-dir = $(subst $(OUTPUT),,$(dir $@))
>  build-dir   = $(or $(__build-dir),.)
>  
> -prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders \
> +prepare: $(OUTPUT)PERF-VERSION-FILE archheaders \
>  	arm64-sysreg-defs \
>  	$(syscall_array) \
>  	$(fs_at_flags_array) \
> @@ -1053,7 +1048,7 @@ cscope:
>  # However, the environment gets quite big, and some programs have problems
>  # with that.
>  
> -check: $(OUTPUT)common-cmds.h
> +check: prepare
>  	if sparse; \
>  	then \
>  		for i in *.c */*.c; \
> @@ -1296,7 +1291,7 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(
>  	$(call QUIET_CLEAN, core-progs) $(RM) $(ALL_PROGRAMS) perf perf-read-vdso32 \
>  		perf-read-vdsox32 $(OUTPUT)$(LIBJVMTI).so
>  	$(call QUIET_CLEAN, core-gen)   $(RM)  *.spec *.pyc *.pyo */*.pyc */*.pyo \
> -		$(OUTPUT)common-cmds.h TAGS tags cscope* $(OUTPUT)PERF-VERSION-FILE \
> +		TAGS tags cscope* $(OUTPUT)PERF-VERSION-FILE \
>  		$(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)util/*-flex* \
>  		$(OUTPUT)util/intel-pt-decoder/inat-tables.c \
>  		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
> diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
> index 7be6fb6df595..2692b2e40a23 100644
> --- a/tools/perf/builtin-help.c
> +++ b/tools/perf/builtin-help.c
> @@ -9,7 +9,6 @@
>  #include "util/strbuf.h"
>  #include "builtin.h"
>  #include <subcmd/exec-cmd.h>
> -#include "common-cmds.h"
>  #include <subcmd/parse-options.h>
>  #include <subcmd/run-command.h>
>  #include <subcmd/help.h>
> @@ -301,16 +300,58 @@ static struct cmdnames main_cmds, other_cmds;
>  
>  void list_common_cmds_help(void)
>  {
> -	unsigned int i, longest = 0;
> +	const struct cmdname_help {
> +		const char *name;
> +		const char *help;
> +	} common_cmds[] = {
> +		{"annotate", "Read perf.data (created by perf record) and display annotated code"},
> +		{"archive",
> +		 "Create archive with object files with build-ids found in perf.data file"},
> +		{"bench", "General framework for benchmark suites"},
> +		{"buildid-cache", "Manage build-id cache."},
> +		{"buildid-list", "List the buildids in a perf.data file"},
> +		{"c2c", "Shared Data C2C/HITM Analyzer."},
> +		{"config", "Get and set variables in a configuration file."},
> +		{"daemon", "Run record sessions on background"},
> +		{"data", "Data file related processing"},
> +		{"diff", "Read perf.data files and display the differential profile"},
> +		{"evlist", "List the event names in a perf.data file"},
> +		{"ftrace", "simple wrapper for kernel's ftrace functionality"},
> +		{"inject", "Filter to augment the events stream with additional information"},
> +		{"iostat", "Show I/O performance metrics"},
> +		{"kallsyms", "Searches running kernel for symbols"},
> +		{"kvm", "Tool to trace/measure kvm guest os"},
> +		{"list", "List all symbolic event types"},
> +		{"mem", "Profile memory accesses"},
> +		{"record", "Run a command and record its profile into perf.data"},
> +		{"report", "Read perf.data (created by perf record) and display the profile"},
> +		{"script", "Read perf.data (created by perf record) and display trace output"},
> +		{"stat", "Run a command and gather performance counter statistics"},
> +		{"test", "Runs sanity tests."},
> +		{"top", "System profiling tool."},
> +		{"version", "display the version of perf binary"},
> +	#ifdef HAVE_LIBELF_SUPPORT
> +		{"probe", "Define new dynamic tracepoints"},
> +	#endif /* HAVE_LIBELF_SUPPORT */
> +	#ifdef HAVE_LIBTRACEEVENT
> +		{"trace", "strace inspired tool"},
> +		{"kmem", "Tool to trace/measure kernel memory properties"},
> +		{"kwork", "Tool to trace/measure kernel work properties (latencies)"},
> +		{"lock", "Analyze lock events"},
> +		{"sched", "Tool to trace/measure scheduler properties (latencies)"},
> +		{"timechart", "Tool to visualize total system behavior during a workload"},
> +	#endif /* HAVE_LIBTRACEEVENT */
> +	};
> +	size_t longest = 0;
>  
> -	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
> +	for (size_t i = 0; i < ARRAY_SIZE(common_cmds); i++) {
>  		if (longest < strlen(common_cmds[i].name))
>  			longest = strlen(common_cmds[i].name);
>  	}
>  
>  	puts(" The most commonly used perf commands are:");
> -	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
> -		printf("   %-*s   ", longest, common_cmds[i].name);
> +	for (size_t i = 0; i < ARRAY_SIZE(common_cmds); i++) {
> +		printf("   %-*s   ", (int)longest, common_cmds[i].name);
>  		puts(common_cmds[i].help);
>  	}
>  }
> diff --git a/tools/perf/command-list.txt b/tools/perf/command-list.txt
> deleted file mode 100644
> index e8d2762adade..000000000000
> --- a/tools/perf/command-list.txt
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -#
> -# List of known perf commands.
> -# command name			category [deprecated] [common]
> -#
> -perf-annotate			mainporcelain common
> -perf-archive			mainporcelain common
> -perf-bench			mainporcelain common
> -perf-buildid-cache		mainporcelain common
> -perf-buildid-list		mainporcelain common
> -perf-data			mainporcelain common
> -perf-diff			mainporcelain common
> -perf-c2c			mainporcelain common
> -perf-config			mainporcelain common
> -perf-evlist			mainporcelain common
> -perf-ftrace			mainporcelain common
> -perf-inject			mainporcelain common
> -perf-iostat			mainporcelain common
> -perf-kallsyms			mainporcelain common
> -perf-kmem			mainporcelain traceevent
> -perf-kvm			mainporcelain common
> -perf-kwork			mainporcelain traceevent
> -perf-list			mainporcelain common
> -perf-lock			mainporcelain traceevent
> -perf-mem			mainporcelain common
> -perf-probe			mainporcelain full
> -perf-record			mainporcelain common
> -perf-report			mainporcelain common
> -perf-sched			mainporcelain traceevent
> -perf-script			mainporcelain common
> -perf-stat			mainporcelain common
> -perf-test			mainporcelain common
> -perf-timechart			mainporcelain traceevent
> -perf-top			mainporcelain common
> -perf-trace			mainporcelain audit
> -perf-version			mainporcelain common
> -perf-daemon			mainporcelain common
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 1c2a43e1dc68..eb77d85a9683 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -418,20 +418,6 @@ $(OUTPUT)util/list_sort.o: ../lib/list_sort.c FORCE
>  	$(call rule_mkdir)
>  	$(call if_changed_dep,cc_o_c)
>  
> -ifdef SHELLCHECK
> -  SHELL_TESTS := generate-cmdlist.sh
> -  SHELL_TEST_LOGS := $(SHELL_TESTS:%=%.shellcheck_log)
> -else
> -  SHELL_TESTS :=
> -  SHELL_TEST_LOGS :=
> -endif
> -
> -$(OUTPUT)%.shellcheck_log: %
> -	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,test)$(SHELLCHECK) "$<" > $@ || (cat $@ && rm $@ && false)
> -
> -perf-util-y += $(SHELL_TEST_LOGS)
> -
>  PY_TESTS := setup.py
>  ifdef MYPY
>    MYPY_TEST_LOGS := $(PY_TESTS:%=%.mypy_log)
> diff --git a/tools/perf/util/generate-cmdlist.sh b/tools/perf/util/generate-cmdlist.sh
> deleted file mode 100755
> index 6a73c903d690..000000000000
> --- a/tools/perf/util/generate-cmdlist.sh
> +++ /dev/null
> @@ -1,70 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -
> -echo "/* Automatically generated by $0 */
> -struct cmdname_help
> -{
> -    char name[16];
> -    char help[80];
> -};
> -
> -static struct cmdname_help common_cmds[] = {"
> -
> -sed -n -e 's/^perf-\([^ 	]*\)[ 	].* common.*/\1/p' command-list.txt |
> -sort |
> -while read cmd
> -do
> -     sed -n '
> -     /^NAME/,/perf-'"$cmd"'/H
> -     ${
> -            x
> -            s/.*perf-'"$cmd"' - \(.*\)/  {"'"$cmd"'", "\1"},/
> -	    p
> -     }' "Documentation/perf-$cmd.txt"
> -done
> -
> -echo "#ifdef HAVE_LIBELF_SUPPORT"
> -sed -n -e 's/^perf-\([^ 	]*\)[ 	].* full.*/\1/p' command-list.txt |
> -sort |
> -while read cmd
> -do
> -     sed -n '
> -     /^NAME/,/perf-'"$cmd"'/H
> -     ${
> -            x
> -            s/.*perf-'"$cmd"' - \(.*\)/  {"'"$cmd"'", "\1"},/
> -	    p
> -     }' "Documentation/perf-$cmd.txt"
> -done
> -echo "#endif /* HAVE_LIBELF_SUPPORT */"
> -
> -echo "#if defined(HAVE_LIBTRACEEVENT)"
> -sed -n -e 's/^perf-\([^ 	]*\)[ 	].* audit*/\1/p' command-list.txt |
> -sort |
> -while read cmd
> -do
> -     sed -n '
> -     /^NAME/,/perf-'"$cmd"'/H
> -     ${
> -            x
> -            s/.*perf-'"$cmd"' - \(.*\)/  {"'"$cmd"'", "\1"},/
> -	    p
> -     }' "Documentation/perf-$cmd.txt"
> -done
> -echo "#endif /* HAVE_LIBTRACEEVENT */"
> -
> -echo "#ifdef HAVE_LIBTRACEEVENT"
> -sed -n -e 's/^perf-\([^ 	]*\)[ 	].* traceevent.*/\1/p' command-list.txt |
> -sort |
> -while read cmd
> -do
> -     sed -n '
> -     /^NAME/,/perf-'"$cmd"'/H
> -     ${
> -            x
> -            s/.*perf-'"$cmd"' - \(.*\)/  {"'"$cmd"'", "\1"},/
> -            p
> -     }' "Documentation/perf-$cmd.txt"
> -done
> -echo "#endif /* HAVE_LIBTRACEEVENT */"
> -echo "};"
> -- 
> 2.52.0.223.gf5cc29aaa4-goog
> 
