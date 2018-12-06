From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 36/75] perf tests ARM: Disable breakpoint tests 32-bit
Date: Thu,  6 Dec 2018 18:25:23 -0300
Message-ID: <20181206212602.20474-37-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Will Deacon <will.deacon@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

The breakpoint tests on the ARM 32-bit kernel are broken in several
ways.

The breakpoint length requested does not necessarily match whether the
function address has the Thumb bit (bit 0) set or not, and this does
matter to the ARM kernel hw_breakpoint infrastructure. See [1] for
background.

[1]: https://lkml.org/lkml/2018/11/15/205

As Will indicated, the overflow handling would require single-stepping
which is not supported at the moment. Just disable those tests for the
ARM 32-bit platforms and update the comment above to explain these
limitations.

Co-developed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20181203191138.2419-1-f.fainelli@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/bp_signal.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index a467615c5a0e..910e25e64188 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -291,12 +291,20 @@ int test__bp_signal(struct test *test __maybe_unused, int subtest __maybe_unused
 
 bool test__bp_signal_is_supported(void)
 {
-/*
- * The powerpc so far does not have support to even create
- * instruction breakpoint using the perf event interface.
- * Once it's there we can release this.
- */
-#if defined(__powerpc__) || defined(__s390x__)
+	/*
+	 * PowerPC and S390 do not support creation of instruction
+	 * breakpoints using the perf_event interface.
+	 *
+	 * ARM requires explicit rounding down of the instruction
+	 * pointer in Thumb mode, and then requires the single-step
+	 * to be handled explicitly in the overflow handler to avoid
+	 * stepping into the SIGIO handler and getting stuck on the
+	 * breakpointed instruction.
+	 *
+	 * Just disable the test for these architectures until these
+	 * issues are resolved.
+	 */
+#if defined(__powerpc__) || defined(__s390x__) || defined(__arm__)
 	return false;
 #else
 	return true;
-- 
2.19.2
