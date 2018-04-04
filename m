From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/17] perf tools: Add 'perf -vv' as an alias to 'perf version --build-options'
Date: Tue,  3 Apr 2018 23:21:49 -0300
Message-ID: <20180404022158.12190-9-acme@kernel.org>
References: <20180404022158.12190-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180404022158.12190-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

We keep having bug reports that when users build perf on their own, but
they don't install some needed libraries such as libelf,
libbfd/libibery.

The perf can build, but it is missing important functionality.

This patch provides a new option '-vv' for perf which will print the
compiled-in status of libraries.

The 'perf -vv' is mapped to 'perf version --build-options'.

For example:

$ ./perf -vv

perf version 4.13.rc5.g6727c5
                 dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
    dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                 glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
                  gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
              libaudit: [ OFF ]  # HAVE_LIBAUDIT_SUPPORT
                libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
    libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT

v3:

One bug is found in v2. It didn't process the option like '-vabc'
correctly. Fix this bug.

v2:

Use a global variable version_verbose to record the number of 'v'.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1522402036-22915-6-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/perf.c | 6 ++++++
 tools/perf/perf.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 1b3fc8ec0fa2..1659029d03fc 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -190,6 +190,12 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			break;
 		}
 
+		if (!strcmp(cmd, "-vv")) {
+			(*argv)[0] = "version";
+			version_verbose = 1;
+			break;
+		}
+
 		/*
 		 * Check remaining flags.
 		 */
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 8fec1abd0f1f..a1a97956136f 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -84,6 +84,7 @@ struct record_opts {
 struct option;
 extern const char * const *record_usage;
 extern struct option *record_options;
+extern int version_verbose;
 
 int record__parse_freq(const struct option *opt, const char *str, int unset);
 #endif
-- 
2.14.3
