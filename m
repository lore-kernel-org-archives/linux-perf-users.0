From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/43] perf build: Display EXTRA features for VF=1 build
Date: Tue, 23 Jan 2018 10:12:17 -0300
Message-ID: <20180123131251.28197-10-acme@kernel.org>
References: <20180123131251.28197-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180123131251.28197-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

Display the state of the rest of the features (FEATURE_TESTS_EXTRA) on a
'make VF=1' build. These features are detected manually by perf's
Makefile.config so they can't be displayed with the main list, but only
after we're done in Makefile.config.

  $ make VF=1
    BUILD:   Doing 'make -j4' parallel build

  Auto-detecting system features:
  ...                         dwarf: [ on  ]
  ...            dwarf_getlocations: [ on  ]
  ...                         glibc: [ on  ]
  ...                          gtk2: [ on  ]

SNIP

  ...                       timerfd: [ on  ]
  ...                  sched_getcpu: [ on  ]
  ...                           sdt: [ on  ]
  ...                         setns: [ on  ]

extra features:
  ...                        bionic: [ OFF ]
  ...                    compile-32: [ on  ]
  ...                   compile-x32: [ OFF ]
  ...                cplus-demangle: [ on  ]
  ...                         hello: [ OFF ]
  ...                 libbabeltrace: [ on  ]
  ...                       liberty: [ on  ]
  ...                     liberty-z: [ on  ]
  ...         libunwind-debug-frame: [ OFF ]
  ...     libunwind-debug-frame-arm: [ OFF ]
  ... libunwind-debug-frame-aarch64: [ OFF ]

SNIP

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180109092646.GB11520@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 12dec6ea5ed2..92265b32dddd 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -947,6 +947,10 @@ define print_var_code
 endef
 
 ifeq ($(VF),1)
+  # Display EXTRA features which are detected manualy
+  # from here with feature_check call and thus cannot
+  # be partof global state output.
+  $(foreach feat,$(FEATURE_TESTS_EXTRA),$(call feature_print_status,$(feat),))
   $(call print_var,prefix)
   $(call print_var,bindir)
   $(call print_var,libdir)
-- 
2.14.3
