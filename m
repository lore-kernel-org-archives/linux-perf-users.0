From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/29] perf script: Fix LBR skid dump problems in brstackinsn
Date: Thu,  3 Jan 2019 09:45:47 -0300
Message-ID: <20190103124609.29672-8-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

This is a fix for another instance of the skid problem Milian recently
found [1]

The LBRs don't freeze at the exact same time as the PMI is triggered.
The perf script brstackinsn code that dumps LBR assembler assumes that
the last branch in the LBR leads to the sample point.  But with skid
it's possible that the CPU executes one or more branches before the
sample, but which do not appear in the LBR.

What happens then is either that the sample point is before the last LBR
branch. In this case the dumper sees a negative length and ignores it.
Or it the sample point is long after the last branch. Then the dumper
sees a very long block and dumps it upto its block limit (16k bytes),
which is noise in the output.

On typical sample session this can happen regularly.

This patch tries to detect and handle the situation. On the last block
that is dumped by the LBR dumper we always stop on the first branch. If
the block length is negative just scan forward to the first branch.
Otherwise scan until a branch is found.

The PT decoder already has a function that uses the instruction decoder
to detect branches, so we can just reuse it here.

Then when a terminating branch is found print an indication and stop
dumping. This might miss a few instructions, but at least shows no
runaway blocks.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>
Link: http://lkml.kernel.org/r/20181120050617.4119-1-andi@firstfloor.org
[ Resolved conflict with dd2e18e9ac20 ("perf tools: Support 'srccode' output") ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c                     | 17 ++++++++++++++++-
 tools/perf/util/dump-insn.c                     |  8 ++++++++
 tools/perf/util/dump-insn.h                     |  2 ++
 .../intel-pt-decoder/intel-pt-insn-decoder.c    |  8 ++++++++
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 3728b50e52e2..88d52ed85ffc 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1073,9 +1073,18 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 
 	/*
 	 * Print final block upto sample
+	 *
+	 * Due to pipeline delays the LBRs might be missing a branch
+	 * or two, which can result in very large or negative blocks
+	 * between final branch and sample. When this happens just
+	 * continue walking after the last TO until we hit a branch.
 	 */
 	start = br->entries[0].to;
 	end = sample->ip;
+	if (end < start) {
+		/* Missing jump. Scan 128 bytes for the next branch */
+		end = start + 128;
+	}
 	len = grab_bb(buffer, start, end, machine, thread, &x.is64bit, &x.cpumode, true);
 	printed += ip__fprintf_sym(start, thread, x.cpumode, x.cpu, &lastsym, attr, fp);
 	if (len <= 0) {
@@ -1084,7 +1093,6 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 			      machine, thread, &x.is64bit, &x.cpumode, false);
 		if (len <= 0)
 			goto out;
-
 		printed += fprintf(fp, "\t%016" PRIx64 "\t%s\n", sample->ip,
 			dump_insn(&x, sample->ip, buffer, len, NULL));
 		if (PRINT_FIELD(SRCCODE))
@@ -1096,6 +1104,13 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 				   dump_insn(&x, start + off, buffer + off, len - off, &ilen));
 		if (ilen == 0)
 			break;
+		if (arch_is_branch(buffer + off, len - off, x.is64bit) && start + off != sample->ip) {
+			/*
+			 * Hit a missing branch. Just stop.
+			 */
+			printed += fprintf(fp, "\t... not reaching sample ...\n");
+			break;
+		}
 		if (PRINT_FIELD(SRCCODE))
 			print_srccode(thread, x.cpumode, start + off);
 	}
diff --git a/tools/perf/util/dump-insn.c b/tools/perf/util/dump-insn.c
index 10988d3de7ce..2bd8585db93c 100644
--- a/tools/perf/util/dump-insn.c
+++ b/tools/perf/util/dump-insn.c
@@ -13,3 +13,11 @@ const char *dump_insn(struct perf_insn *x __maybe_unused,
 		*lenp = 0;
 	return "?";
 }
+
+__weak
+int arch_is_branch(const unsigned char *buf __maybe_unused,
+		   size_t len __maybe_unused,
+		   int x86_64 __maybe_unused)
+{
+	return 0;
+}
diff --git a/tools/perf/util/dump-insn.h b/tools/perf/util/dump-insn.h
index 0e06280a8860..650125061530 100644
--- a/tools/perf/util/dump-insn.h
+++ b/tools/perf/util/dump-insn.h
@@ -20,4 +20,6 @@ struct perf_insn {
 
 const char *dump_insn(struct perf_insn *x, u64 ip,
 		      u8 *inbuf, int inlen, int *lenp);
+int arch_is_branch(const unsigned char *buf, size_t len, int x86_64);
+
 #endif
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
index 54818828023b..1c0e289f01e6 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
@@ -180,6 +180,14 @@ int intel_pt_get_insn(const unsigned char *buf, size_t len, int x86_64,
 	return 0;
 }
 
+int arch_is_branch(const unsigned char *buf, size_t len, int x86_64)
+{
+	struct intel_pt_insn in;
+	if (intel_pt_get_insn(buf, len, x86_64, &in) < 0)
+		return -1;
+	return in.branch != INTEL_PT_BR_NO_BRANCH;
+}
+
 const char *dump_insn(struct perf_insn *x, uint64_t ip __maybe_unused,
 		      u8 *inbuf, int inlen, int *lenp)
 {
-- 
2.19.2
