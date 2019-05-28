From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/14] perf test vmlinux-kallsyms: Ignore aliases to _etext when searching on kallsyms
Date: Tue, 28 May 2019 14:50:17 -0300
Message-ID: <20190528175020.13343-12-acme@kernel.org>
References: <20190528175020.13343-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190528175020.13343-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Song Liu <songliubraving@fb.com>, Stanislav Fomichev <sdf@google.com>, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

No need to search for aliases for the symbol that marks the end of the
kernel text segment, the following patch will make such symbols not to
be found when searching in the kallsyms maps causing this test to fail.

So as a prep patch to avoid breaking bisection, ignore such symbols.

Tested-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Link: https://lkml.kernel.org/n/tip-qfwuih8cvmk9doh7k5k244eq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/vmlinux-kallsyms.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 7691980b7df1..f101576d1c72 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -161,9 +161,16 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 
 				continue;
 			}
-		} else
+		} else if (mem_start == kallsyms.vmlinux_map->end) {
+			/*
+			 * Ignore aliases to _etext, i.e. to the end of the kernel text area,
+			 * such as __indirect_thunk_end.
+			 */
+			continue;
+		} else {
 			pr_debug("ERR : %#" PRIx64 ": %s not on kallsyms\n",
 				 mem_start, sym->name);
+		}
 
 		err = -1;
 	}
-- 
2.20.1
