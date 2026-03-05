Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6DC3358B0;
	Thu,  5 Mar 2026 20:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772742374; cv=none; b=QI1Z+pZVKdVDiFQ5VeNAj/4V5EoWCdVkn+rjMpSFMw1hDGsDvW4KCZEizVr9LP+2EET7M068QAHmMLSV5bXrlecQcfcQ9fb/S5gUYPbqKOWgqXSYBRrtA2UWdifBbwBZY/wGIxHB//8AzRO7/8AkgeuD+Py7VtTaWDuZ+YCqyHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772742374; c=relaxed/simple;
	bh=2Bk6m5Efv2QmDFJXvb68ZdhtEToQ0SX6n2XtCgflANU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ojm2oNc0Bq7LkCZ7yTxv1NzpVj6YIOvBQXCPVH+es1hntoZ+h3AC5vfV3mj6RTBoH+xI5V+2BzUas3/iVXyqzeyV58CjGJnDROw0tRd28jptbZUkvo2qQ5OPp7Va3tnXxSbbCMr5eOHpoZuVaMWyO5xa1zK/ySvDcdW/nXc3OUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtsZpTYo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtsZpTYo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E5FC116C6;
	Thu,  5 Mar 2026 20:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772742373;
	bh=2Bk6m5Efv2QmDFJXvb68ZdhtEToQ0SX6n2XtCgflANU=;
	h=Date:From:To:Cc:Subject:From;
	b=QtsZpTYor5Kgr1wY1m8TtegTc3SzJvNZ8LF4f6CUe4T91nhG7QuBZU5DVOUIVS6b8
	 7+wbCHV8jKyMzO8i8Rgp8T5XUkF63ZCJ4XluyTtnug4l1y2FJ7jr27l6Op8fCnU6tM
	 /IZN0OiyjxtaA0ybLgEFFlAvxl+qikL74tGWZhUkJr5r2DCsAxjo7Qs+2XpIi3hAmA
	 R/HTDLKJjOaieNEC1Z941TsfQBhrqqTY2mSCbSCgBlhA+odKecAaa7aIfw5vfVheAn
	 oyMv/SckC3KvB7LGMWbAS3/czNCULHb6z2QyGBy75T9+Bn0HCYh8EIUjYwphD04rV7
	 YbgDdqnFeCQmQ==
Date: Thu, 5 Mar 2026 17:26:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Syncing include/linux/coresight-pmu.h with its copy in tools/perf
Message-ID: <aanm4oUxeJ4U34FO@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

	Right now we have this perf build warning:

  diff -u tools/include/linux/coresight-pmu.h include/linux/coresight-pmu.h

But when I try to update it it explodes, can someone in the ARM front
take a look at it?

Thanks,

- Arnaldo

⬢ [acme@toolbx perf-tools]$ m
make: Entering directory '/home/acme/git/perf-tools/tools/perf'
  BUILD:   Doing 'make -j32' parallel build
Warning: Kernel ABI header differences:
  diff -u tools/arch/x86/include/uapi/asm/svm.h arch/x86/include/uapi/asm/svm.h
  diff -u tools/include/linux/coresight-pmu.h include/linux/coresight-pmu.h
  diff -u tools/arch/x86/include/asm/amd/ibs.h arch/x86/include/asm/amd/ibs.h
  diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h

Auto-detecting system features:
...                                   libdw: [ on  ]
...                                   glibc: [ on  ]
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
  INSTALL libapi_headers
  INSTALL libperf_headers
  INSTALL libsymbol_headers
  INSTALL libbpf_headers
  INSTALL binaries
  INSTALL tests
  INSTALL libperf-jvmti.so
  INSTALL libexec
  INSTALL perf-archive
  INSTALL perf-iostat
  INSTALL python-scripts
  INSTALL dlfilters
  INSTALL perf_completion-script
  INSTALL perf-tip
make: Leaving directory '/home/acme/git/perf-tools/tools/perf'
⬢ [acme@toolbx perf-tools]$   diff -u tools/include/linux/coresight-pmu.h include/linux/coresight-pmu.h
--- tools/include/linux/coresight-pmu.h	2025-06-16 13:19:13.119223002 -0300
+++ include/linux/coresight-pmu.h	2026-02-21 18:08:24.737530149 -0300
@@ -22,30 +22,6 @@
 #define CORESIGHT_LEGACY_CPU_TRACE_ID(cpu)  (0x10 + (cpu * 2))

 /*
- * Below are the definition of bit offsets for perf option, and works as
- * arbitrary values for all ETM versions.
- *
- * Most of them are orignally from ETMv3.5/PTM's ETMCR config, therefore,
- * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
- * directly use below macros as config bits.
- */
-#define ETM_OPT_BRANCH_BROADCAST 8
-#define ETM_OPT_CYCACC		12
-#define ETM_OPT_CTXTID		14
-#define ETM_OPT_CTXTID2		15
-#define ETM_OPT_TS		28
-#define ETM_OPT_RETSTK		29
-
-/* ETMv4 CONFIGR programming bits for the ETM OPTs */
-#define ETM4_CFG_BIT_BB         3
-#define ETM4_CFG_BIT_CYCACC	4
-#define ETM4_CFG_BIT_CTXTID	6
-#define ETM4_CFG_BIT_VMID	7
-#define ETM4_CFG_BIT_TS		11
-#define ETM4_CFG_BIT_RETSTK	12
-#define ETM4_CFG_BIT_VMID_OPT	15
-
-/*
  * Interpretation of the PERF_RECORD_AUX_OUTPUT_HW_ID payload.
  * Used to associate a CPU with the CoreSight Trace ID.
  * [07:00] - Trace ID - uses 8 bits to make value easy to read in file.
⬢ [acme@toolbx perf-tools]$ cp include/linux/coresight-pmu.h tools/include/linux/coresight-pmu.h
⬢ [acme@toolbx perf-tools]$ m
make: Entering directory '/home/acme/git/perf-tools/tools/perf'
  BUILD:   Doing 'make -j32' parallel build
Warning: Kernel ABI header differences:
  diff -u tools/arch/x86/include/uapi/asm/svm.h arch/x86/include/uapi/asm/svm.h
  diff -u tools/arch/x86/include/asm/amd/ibs.h arch/x86/include/asm/amd/ibs.h
  diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h

Auto-detecting system features:
...                                   libdw: [ on  ]
...                                   glibc: [ on  ]
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
  INSTALL libperf_headers
  INSTALL libapi_headers
  INSTALL libsymbol_headers
  INSTALL libbpf_headers
  CC      /tmp/build/perf-tools/util/cs-etm-decoder/cs-etm-decoder.o
  CC      /tmp/build/perf-tools/util/cs-etm.o
  LD      /tmp/build/perf-tools/util/cs-etm-decoder/perf-util-in.o
In file included from /home/acme/git/perf-tools/tools/include/linux/bits.h:5,
                 from /home/acme/git/perf-tools/tools/include/linux/bitops.h:14,
                 from util/cs-etm.c:10:
util/cs-etm.c: In function ‘cs_etm__init_pid_fmt’:
util/cs-etm.c:213:31: error: ‘ETM_OPT_CTXTID’ undeclared (first use in this function)
  213 |                 if (val & BIT(ETM_OPT_CTXTID))
      |                               ^~~~~~~~~~~~~~
/home/acme/git/perf-tools/tools/include/vdso/bits.h:7:44: note: in definition of macro ‘BIT’
    7 | #define BIT(nr)                 (UL(1) << (nr))
      |                                            ^~
util/cs-etm.c:213:31: note: each undeclared identifier is reported only once for each function it appears in
  213 |                 if (val & BIT(ETM_OPT_CTXTID))
      |                               ^~~~~~~~~~~~~~
/home/acme/git/perf-tools/tools/include/vdso/bits.h:7:44: note: in definition of macro ‘BIT’
    7 | #define BIT(nr)                 (UL(1) << (nr))
      |                                            ^~
util/cs-etm.c:218:32: error: ‘ETM4_CFG_BIT_VMID’ undeclared (first use in this function)
  218 |                 if (val & (BIT(ETM4_CFG_BIT_VMID) | BIT(ETM4_CFG_BIT_VMID_OPT)))
      |                                ^~~~~~~~~~~~~~~~~
/home/acme/git/perf-tools/tools/include/vdso/bits.h:7:44: note: in definition of macro ‘BIT’
    7 | #define BIT(nr)                 (UL(1) << (nr))
      |                                            ^~
util/cs-etm.c:218:57: error: ‘ETM4_CFG_BIT_VMID_OPT’ undeclared (first use in this function)
  218 |                 if (val & (BIT(ETM4_CFG_BIT_VMID) | BIT(ETM4_CFG_BIT_VMID_OPT)))
      |                                                         ^~~~~~~~~~~~~~~~~~~~~
/home/acme/git/perf-tools/tools/include/vdso/bits.h:7:44: note: in definition of macro ‘BIT’
    7 | #define BIT(nr)                 (UL(1) << (nr))
      |                                            ^~
util/cs-etm.c:221:36: error: ‘ETM4_CFG_BIT_CTXTID’ undeclared (first use in this function)
  221 |                 else if (val & BIT(ETM4_CFG_BIT_CTXTID))
      |                                    ^~~~~~~~~~~~~~~~~~~
/home/acme/git/perf-tools/tools/include/vdso/bits.h:7:44: note: in definition of macro ‘BIT’
    7 | #define BIT(nr)                 (UL(1) << (nr))
      |                                            ^~
util/cs-etm.c: In function ‘cs_etm__setup_timeless_decoding’:
util/cs-etm.c:2934:65: error: ‘ETM_OPT_TS’ undeclared (first use in this function)
 2934 |                                 !(evsel->core.attr.config & BIT(ETM_OPT_TS));
      |                                                                 ^~~~~~~~~~
/home/acme/git/perf-tools/tools/include/vdso/bits.h:7:44: note: in definition of macro ‘BIT’
    7 | #define BIT(nr)                 (UL(1) << (nr))
      |                                            ^~
make[4]: *** [/home/acme/git/perf-tools/tools/build/Makefile.build:95: /tmp/build/perf-tools/util/cs-etm.o] Error 1
make[3]: *** [/home/acme/git/perf-tools/tools/build/Makefile.build:158: util] Error 2
make[2]: *** [Makefile.perf:797: /tmp/build/perf-tools/perf-util-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile.perf:289: sub-make] Error 2
make: *** [Makefile:119: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf-tools/tools/perf'
⬢ [acme@toolbx perf-tools]$


