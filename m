Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7510D32A3D7
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767901072; cv=pass; b=S/yVl9aI8vkg1ZRdDafzxHGjFL67W9pWaP9eq1XrKmGOAE6Bm0p5k9qrw6UgvMLFjPIqh97vnctsLC+Rxdtw11yJGPNVK68Ws1MSjd6LTUdhfCrV6IHzNr85B5m7ShYdetEre5ggNNPNuLLvp0fY30BC+LgiO2KWjLh4/jkbKEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767901072; c=relaxed/simple;
	bh=3F05JeJl7rwSnRvTUYWzrChGJEAfNALLUbv3QKBMQ8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=AHEpgOI7NHZlL/7loeM9HCe8rdSzG8nxAc3S5x9u+vEX8Sc2Zob4CLHnoMg02W7pvpq/MBQmpZFO9UMDlflWWRQZYcHTO1RauwzG6s+yXV7arzhum6JlJqwFmEGdDG0MLA3G71pRne5sbVDXtnR3oYOLv8ldFb1Ob+rRnp7N4W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ztjj5fPP; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ztjj5fPP"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0d06cfa93so13265ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:37:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767901070; cv=none;
        d=google.com; s=arc-20240605;
        b=EJZL8vlVzjoBjHb3RqupnMNyY8riMKu1dLShse1JXI2VkbBSi4r/pN/GIibwROdU2j
         Fr/sTz591TMmOJBicnbrYiazqp8dxFsOr5jRa9H8qNk4WmAczrEdu1NOxDwDB95c56gM
         rrrEoX5fp8cEeDEVgIlkNO0eRnMhL7MxpO080qepRGWmEep5ZZLjA6iEbIgZGln8VXIh
         Csz6tuYrAChch2hJAVg93eSUVIBzFcxMenputWFpXkrpKaeFLEFi9ITgLUtaC99lBViX
         mAuwhJ+Cu9ywUpOhkxR+ewvKcXh9EinxbiLqDsrRYEaV6LBhPg7TkUit3OWccVr+2ZfM
         VFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A8W/EX6sAHZzJCqyq2qUwINyEX9jF9aPEWQFlWac3Z8=;
        fh=lo1YkRzwQLbmK9V6bNiXiuIq+PkfJc7j2MKR0DrT00A=;
        b=isM0go6dNXOj664DMcnkucV0B84EHhqZ2dOTjood3rea2cf7sxIn6Fqp4K82nOLbAp
         Pl5EKsILPfY/KznX1IZ3gE9SUm3+ftoWshh9sD/hu6P0ayCAp5HmtWZRpdyh++xz5ZHa
         2DBGSnOE6sg6ElwGGaTIPwELsjE+SVBBvsfW+Q/docAJWH/cLFrfDnrlgfhFchaV3ej3
         TdoBkdjUzmaebbj/RXiqdJrYLy8V3yY/3it9NILz1jgffGCQGOZ44NliNnkBpGw3Q+SF
         SgkOUio5nowyarq+eC9cFLzZiuq/WzEbcZ8hYtcGX3qNLzK1bya34EBJAmqJAv1FR2V+
         u8tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767901070; x=1768505870; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8W/EX6sAHZzJCqyq2qUwINyEX9jF9aPEWQFlWac3Z8=;
        b=Ztjj5fPPnVdFb3Id0+VtXtejXI2GYadlgBFQQ71eUOLeaNAAHa2iNNpvIidr5AaZBG
         e1ZCdl8FZtRX1z60v9f/G/K0Ua9mmxFX9D2o1WWC/WXCJbcTEFG/+IKC0HBxeKxtOXqg
         +a2eqbyUMjfnFsp1ZINUNRihCYbpQmgIjHXItx2ivm2ToAg09L2j7Su8V06jSmgUODb4
         44JI7ECKCjkvVMBTRPrVFMvH54v1U4ftBghRvP6peoycEe7iOmgVls8ixRpVySF6gOEg
         YL5oSqKh9vS4k9wqnHdlvKFDM858vOuhilnTjjtk052yPOju262ea0yxacnkvM7g05m4
         UtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767901070; x=1768505870;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A8W/EX6sAHZzJCqyq2qUwINyEX9jF9aPEWQFlWac3Z8=;
        b=SErlUXpwjFclFsU4eC1BknFl7kwYZafPy2VQbrsJ588GvT5/EjZXSYqJa+9kqc0mnA
         knOZx2BdBRKpyX26N+3uVJF+wBZq8bB3trQp5Nd3+I24E/Y0RNOHbNZc9KF/IQLSMSF5
         NHk30JHjryPDixREVMKelTyN1BqwzCIoYP2dwu5j0C1xXknvQfReVeLXcNCGY5fHv/BQ
         8iH3HOLJYMHPutJFSX8z1rVvSiiZUWqVG8qS4lKZsIboBamx2eY0fkyT4baLx+KBXm3D
         aj7FfzYudL67uEMm91nHiEmyBZDaRSPnSzcyorZAzaeNNjZ8atBxu2WwfGPJvOC1etp7
         sLuw==
X-Forwarded-Encrypted: i=1; AJvYcCULDOFtG1Rj4auC18rgNUVEU0ZQsl8P7icVdRbzdMmDVK2ScM1L1jQdyEuu0ojGdOCzi5BJSgu+YkxzOLAc9Hqc@vger.kernel.org
X-Gm-Message-State: AOJu0Yz969q6OE+aWTFY9poOxDiVQ65TZab8dKHyNHhu1DFnAT1voiYY
	rnGN7+AQJO1anP9Ljb0UBeseXr4l1XBuwQPlF20/TroG3iiXJkoM+XSct7kQNopYDPe4lDtan/l
	Eyd+zKh1uUm2qozyLmwugpgGQ6tPHu6V6sRhFKQQF
X-Gm-Gg: AY/fxX7KdfycjaqG/uv6aNa2CeiXVKFoXGFhnpEk3jc9nA3fq4lUv0WKeLwCvkvmFho
	XJQw+FuvekwzRNwykULMzrw5+qRuU24xiReUQ+fbNEdBEzxou5ofBKjd+7JHzReeDsRvEVPp7ui
	iAkGf8uQ4G4W/cXb+q/K5tSB6Lw0QM5RwDFCF5T53g/0SYDfpte4X1PpFa3Ohw3YmvtQDKdwQ2d
	3mGtDik/La/SEv5gwEgbEzqPi04T2svn70W7BtLBOM0/nIoyDmXUmfr8bJN0kllV9wL/XZulo60
	bE7D+noBNP1P/wd7d7lHyBvjBA==
X-Received: by 2002:a17:902:e881:b0:29f:20b:6d1e with SMTP id
 d9443c01a7336-2a409b1b57cmr492345ad.9.1767901069515; Thu, 08 Jan 2026
 11:37:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204211143.572382-1-irogers@google.com>
In-Reply-To: <20251204211143.572382-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 8 Jan 2026 11:37:37 -0800
X-Gm-Features: AQt7F2oONJxur82hf9bltYTLcIDr1W98iX_pgtvZZRPs7M7C_AWq3W4mNzAXJWQ
Message-ID: <CAP-5=fU-pfJD+qqUNCwmiQYRYXh23gntNwbubvFRgpaRTk-15g@mail.gmail.com>
Subject: Re: [PATCH v1] perf help: Move common_cmds into builtin-help
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 1:13=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> There's a lot of infrastructure for generating a relatively simple
> array used by one function. Move the array into the function and
> remove the supporting build logic. At the same time opportunistically
> const-ify the array.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

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
>         $(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(filter %.o,$^) $(GT=
K_LIBS)
>
> -$(OUTPUT)common-cmds.h: util/generate-cmdlist.sh command-list.txt
> -
> -$(OUTPUT)common-cmds.h: $(wildcard Documentation/perf-*.txt)
> -       $(QUIET_GEN). util/generate-cmdlist.sh > $@+ && mv $@+ $@
> -
>  $(SCRIPTS) : % : %.sh
>         $(QUIET_GEN)$(INSTALL) '$@.sh' '$(OUTPUT)$@'
>
> @@ -849,7 +844,7 @@ endif
>  __build-dir =3D $(subst $(OUTPUT),,$(dir $@))
>  build-dir   =3D $(or $(__build-dir),.)
>
> -prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders \
> +prepare: $(OUTPUT)PERF-VERSION-FILE archheaders \
>         arm64-sysreg-defs \
>         $(syscall_array) \
>         $(fs_at_flags_array) \
> @@ -1053,7 +1048,7 @@ cscope:
>  # However, the environment gets quite big, and some programs have proble=
ms
>  # with that.
>
> -check: $(OUTPUT)common-cmds.h
> +check: prepare
>         if sparse; \
>         then \
>                 for i in *.c */*.c; \
> @@ -1296,7 +1291,7 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD=
)-clean $(LIBSYMBOL)-clean $(
>         $(call QUIET_CLEAN, core-progs) $(RM) $(ALL_PROGRAMS) perf perf-r=
ead-vdso32 \
>                 perf-read-vdsox32 $(OUTPUT)$(LIBJVMTI).so
>         $(call QUIET_CLEAN, core-gen)   $(RM)  *.spec *.pyc *.pyo */*.pyc=
 */*.pyo \
> -               $(OUTPUT)common-cmds.h TAGS tags cscope* $(OUTPUT)PERF-VE=
RSION-FILE \
> +               TAGS tags cscope* $(OUTPUT)PERF-VERSION-FILE \
>                 $(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)uti=
l/*-flex* \
>                 $(OUTPUT)util/intel-pt-decoder/inat-tables.c \
>                 $(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}=
.c \
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
> -       unsigned int i, longest =3D 0;
> +       const struct cmdname_help {
> +               const char *name;
> +               const char *help;
> +       } common_cmds[] =3D {
> +               {"annotate", "Read perf.data (created by perf record) and=
 display annotated code"},
> +               {"archive",
> +                "Create archive with object files with build-ids found i=
n perf.data file"},
> +               {"bench", "General framework for benchmark suites"},
> +               {"buildid-cache", "Manage build-id cache."},
> +               {"buildid-list", "List the buildids in a perf.data file"}=
,
> +               {"c2c", "Shared Data C2C/HITM Analyzer."},
> +               {"config", "Get and set variables in a configuration file=
."},
> +               {"daemon", "Run record sessions on background"},
> +               {"data", "Data file related processing"},
> +               {"diff", "Read perf.data files and display the differenti=
al profile"},
> +               {"evlist", "List the event names in a perf.data file"},
> +               {"ftrace", "simple wrapper for kernel's ftrace functional=
ity"},
> +               {"inject", "Filter to augment the events stream with addi=
tional information"},
> +               {"iostat", "Show I/O performance metrics"},
> +               {"kallsyms", "Searches running kernel for symbols"},
> +               {"kvm", "Tool to trace/measure kvm guest os"},
> +               {"list", "List all symbolic event types"},
> +               {"mem", "Profile memory accesses"},
> +               {"record", "Run a command and record its profile into per=
f.data"},
> +               {"report", "Read perf.data (created by perf record) and d=
isplay the profile"},
> +               {"script", "Read perf.data (created by perf record) and d=
isplay trace output"},
> +               {"stat", "Run a command and gather performance counter st=
atistics"},
> +               {"test", "Runs sanity tests."},
> +               {"top", "System profiling tool."},
> +               {"version", "display the version of perf binary"},
> +       #ifdef HAVE_LIBELF_SUPPORT
> +               {"probe", "Define new dynamic tracepoints"},
> +       #endif /* HAVE_LIBELF_SUPPORT */
> +       #ifdef HAVE_LIBTRACEEVENT
> +               {"trace", "strace inspired tool"},
> +               {"kmem", "Tool to trace/measure kernel memory properties"=
},
> +               {"kwork", "Tool to trace/measure kernel work properties (=
latencies)"},
> +               {"lock", "Analyze lock events"},
> +               {"sched", "Tool to trace/measure scheduler properties (la=
tencies)"},
> +               {"timechart", "Tool to visualize total system behavior du=
ring a workload"},
> +       #endif /* HAVE_LIBTRACEEVENT */
> +       };
> +       size_t longest =3D 0;
>
> -       for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
> +       for (size_t i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
>                 if (longest < strlen(common_cmds[i].name))
>                         longest =3D strlen(common_cmds[i].name);
>         }
>
>         puts(" The most commonly used perf commands are:");
> -       for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
> -               printf("   %-*s   ", longest, common_cmds[i].name);
> +       for (size_t i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
> +               printf("   %-*s   ", (int)longest, common_cmds[i].name);
>                 puts(common_cmds[i].help);
>         }
>  }
> diff --git a/tools/perf/command-list.txt b/tools/perf/command-list.txt
> deleted file mode 100644
> index e8d2762adade..000000000000
> --- a/tools/perf/command-list.txt
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -#
> -# List of known perf commands.
> -# command name                 category [deprecated] [common]
> -#
> -perf-annotate                  mainporcelain common
> -perf-archive                   mainporcelain common
> -perf-bench                     mainporcelain common
> -perf-buildid-cache             mainporcelain common
> -perf-buildid-list              mainporcelain common
> -perf-data                      mainporcelain common
> -perf-diff                      mainporcelain common
> -perf-c2c                       mainporcelain common
> -perf-config                    mainporcelain common
> -perf-evlist                    mainporcelain common
> -perf-ftrace                    mainporcelain common
> -perf-inject                    mainporcelain common
> -perf-iostat                    mainporcelain common
> -perf-kallsyms                  mainporcelain common
> -perf-kmem                      mainporcelain traceevent
> -perf-kvm                       mainporcelain common
> -perf-kwork                     mainporcelain traceevent
> -perf-list                      mainporcelain common
> -perf-lock                      mainporcelain traceevent
> -perf-mem                       mainporcelain common
> -perf-probe                     mainporcelain full
> -perf-record                    mainporcelain common
> -perf-report                    mainporcelain common
> -perf-sched                     mainporcelain traceevent
> -perf-script                    mainporcelain common
> -perf-stat                      mainporcelain common
> -perf-test                      mainporcelain common
> -perf-timechart                 mainporcelain traceevent
> -perf-top                       mainporcelain common
> -perf-trace                     mainporcelain audit
> -perf-version                   mainporcelain common
> -perf-daemon                    mainporcelain common
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 1c2a43e1dc68..eb77d85a9683 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -418,20 +418,6 @@ $(OUTPUT)util/list_sort.o: ../lib/list_sort.c FORCE
>         $(call rule_mkdir)
>         $(call if_changed_dep,cc_o_c)
>
> -ifdef SHELLCHECK
> -  SHELL_TESTS :=3D generate-cmdlist.sh
> -  SHELL_TEST_LOGS :=3D $(SHELL_TESTS:%=3D%.shellcheck_log)
> -else
> -  SHELL_TESTS :=3D
> -  SHELL_TEST_LOGS :=3D
> -endif
> -
> -$(OUTPUT)%.shellcheck_log: %
> -       $(call rule_mkdir)
> -       $(Q)$(call echo-cmd,test)$(SHELLCHECK) "$<" > $@ || (cat $@ && rm=
 $@ && false)
> -
> -perf-util-y +=3D $(SHELL_TEST_LOGS)
> -
>  PY_TESTS :=3D setup.py
>  ifdef MYPY
>    MYPY_TEST_LOGS :=3D $(PY_TESTS:%=3D%.mypy_log)
> diff --git a/tools/perf/util/generate-cmdlist.sh b/tools/perf/util/genera=
te-cmdlist.sh
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
> -static struct cmdname_help common_cmds[] =3D {"
> -
> -sed -n -e 's/^perf-\([^        ]*\)[   ].* common.*/\1/p' command-list.t=
xt |
> -sort |
> -while read cmd
> -do
> -     sed -n '
> -     /^NAME/,/perf-'"$cmd"'/H
> -     ${
> -            x
> -            s/.*perf-'"$cmd"' - \(.*\)/  {"'"$cmd"'", "\1"},/
> -           p
> -     }' "Documentation/perf-$cmd.txt"
> -done
> -
> -echo "#ifdef HAVE_LIBELF_SUPPORT"
> -sed -n -e 's/^perf-\([^        ]*\)[   ].* full.*/\1/p' command-list.txt=
 |
> -sort |
> -while read cmd
> -do
> -     sed -n '
> -     /^NAME/,/perf-'"$cmd"'/H
> -     ${
> -            x
> -            s/.*perf-'"$cmd"' - \(.*\)/  {"'"$cmd"'", "\1"},/
> -           p
> -     }' "Documentation/perf-$cmd.txt"
> -done
> -echo "#endif /* HAVE_LIBELF_SUPPORT */"
> -
> -echo "#if defined(HAVE_LIBTRACEEVENT)"
> -sed -n -e 's/^perf-\([^        ]*\)[   ].* audit*/\1/p' command-list.txt=
 |
> -sort |
> -while read cmd
> -do
> -     sed -n '
> -     /^NAME/,/perf-'"$cmd"'/H
> -     ${
> -            x
> -            s/.*perf-'"$cmd"' - \(.*\)/  {"'"$cmd"'", "\1"},/
> -           p
> -     }' "Documentation/perf-$cmd.txt"
> -done
> -echo "#endif /* HAVE_LIBTRACEEVENT */"
> -
> -echo "#ifdef HAVE_LIBTRACEEVENT"
> -sed -n -e 's/^perf-\([^        ]*\)[   ].* traceevent.*/\1/p' command-li=
st.txt |
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
