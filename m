From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/28] perf test: Auto bump rlimit(MEMLOCK) for BPF test sake
Date: Mon, 15 Jul 2019 18:11:34 -0300
Message-ID: <20190715211200.10984-3-acme@kernel.org>
References: <20190715211200.10984-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190715211200.10984-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

I noticed that the 'perf test bpf' was failing:

  # perf test bpf
  41: BPF filter                                            :
  41.1: Basic BPF filtering                                 : Skip
  41.2: BPF pinning                                         : Skip
  41.3: BPF prologue generation                             : Skip
  41.4: BPF relocation checker                              : Skip
  # ulimit -l
  64
  #

Using verbose mode we get just a line bout -EPERF being returned from
libbpf's bpf_load_program_xattr(), that ends up being used in 'perf
test bpf' initial program loading capability query:

  Missing basic BPF support, skip this test: Operation not permitted

Not that informative, but on a separate problem when creating BPF maps
bumping rlimit(MEMLOCK) helped, so I tried it here as well, works:

  # ulimit -l 128
  # perf test bpf
  41: BPF filter                                            :
  41.1: Basic BPF filtering                                 : Ok
  41.2: BPF pinning                                         : Ok
  41.3: BPF prologue generation                             : Ok
  41.4: BPF relocation checker                              : Ok
  #

So use the recently added rlimit__bump_memlock() helper:

  # ulimit -l 64
  # perf test bpf
  41: BPF filter                                            :
  41.1: Basic BPF filtering                                 : Ok
  41.2: BPF pinning                                         : Ok
  41.3: BPF prologue generation                             : Ok
  41.4: BPF relocation checker                              : Ok
  # ulimit -l
  64
  #

I.e. the bumping of memlock is restricted to the 'perf test' instance,
not changing the global value.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-b9fubkhr4jm192lu7y8hgjvo@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 66a82badc1d1..c3bec9d2c201 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -21,6 +21,7 @@
 #include <subcmd/parse-options.h>
 #include "string2.h"
 #include "symbol.h"
+#include "util/rlimit.h"
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <subcmd/exec-cmd.h>
@@ -727,6 +728,11 @@ int cmd_test(int argc, const char **argv)
 
 	if (skip != NULL)
 		skiplist = intlist__new(skip);
+	/*
+	 * Tests that create BPF maps, for instance, need more than the 64K
+	 * default:
+	 */
+	rlimit__bump_memlock();
 
 	return __cmd_test(argc, argv, skiplist);
 }
-- 
2.21.0
