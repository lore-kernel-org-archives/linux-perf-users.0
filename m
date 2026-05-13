Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E12D3CC7C5
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 23:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713543; cv=none; b=G6qBqTsdw+q2iudaIDyY7uicn+IPPSprQ0IFyRdi/IJKyKkqSjxgFwZePKmcTgUyo4Sd0vnCD8EaI588hHA+hxdLfzfxkCB2UJyudd4YfppWWGA8IfOM665DdyjKj5gpI0FdHJbMYjx6iqK23JdYTJLw6dOPS8qqJAC4BRCDuLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713543; c=relaxed/simple;
	bh=lrxOYwozsiPLRUododmVYWeExJATDiZWhItCSH9e+y8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PTDCEtAJ68vspg/Eh6yRJpdas5XyymkaH3wc5FP/Lz2l5wwle2qk0tK4j0pQVk0CW7aTKBAfg6REJMCER/rL6jkAACSKHZi2SOfRCUxPltzeGytxIgaWthV3j/kYj1VoUH4WZrIasg2X8fSxLLQ/86Zk12zMULGliZBS4fyT7YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uYXOBbD3; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uYXOBbD3"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2fe1cf409a1so6750391eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 16:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778713533; x=1779318333; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+vs1VarXG7cwJLREQN0F4CXZRhuk7w5c3D/cET186dk=;
        b=uYXOBbD3ymPZyhAdlKDcDJhVQke2KMK3y38s9DubuvnZcjJm3ayKQfRKhQzRk+vC/0
         PC2UXMrsX+2rpYiGmaBsArmYqpSaVF6xJI7eXi3BrXFOIRmo5W/CU3YfwW+0TD1/OfOM
         PwDdl9/4JiDOsXz+UzmeUh58IJDrDsPIFSziyYGXj0axd/upVSeC63x0+x2mLv2zgq17
         koBOM7KvY6tEDMSgh2QJCR11g7Cvz0exiVY/r25dQ7Xer1oJ+UPb375iFinL8OvRuVTm
         Ov8b1wx4qPcHOiddPHoZD80rT33wXdNh++JPL4nfHNzbRxz5pc9LPbdAYPKmmwn1ekgQ
         50ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778713533; x=1779318333;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vs1VarXG7cwJLREQN0F4CXZRhuk7w5c3D/cET186dk=;
        b=NDJDZKGqAei6KvTGrKhOoZ8yLRaJYVUHEY1E6AVthSSsTQ8GNMR1gkUXHhPuuPlYsU
         byQ4kQYK1hkcZBqmJD8cv32GUHQmdYfMbVpDhfxuh4nWisaQZYcnCFPCuIcrMvtrPgWu
         3L6O9K/trZxAaFz/4d+o1P9QivG17Z5FLBdFBB3EnDs267zFCDFi6SprgSzW7USjb4Ky
         7tpgsvdeUWW75qWH2gPnCx+a00EyjJLfa/sbB5sopfus/GTzXH91v9tPEzziYV6e6n4C
         FYx3Tiir/V3GpCQ4pGCOMOv3A+pamVTCK6naVNw9KwF9WTkBN48Tg2GhShBUvIkliBPG
         OsKA==
X-Forwarded-Encrypted: i=1; AFNElJ/0hYpznaEj6E1r4R18hgWmEfml4cLWH/32aZHqFpJClwoTzJurasPJmO5RnGwLldN2IxGFiJ+f4TK38j/hrFOK@vger.kernel.org
X-Gm-Message-State: AOJu0YyDzMvzGP4BVJtvUiI8NmMKvla4Zy2CwopHdGrzAZPUqZIZTaYj
	lzsNUNpow+Jbthg9/fq1axdaPTL5Vo3Ekza0YkEEAi7ojwCmLQtXLxr7onoDusPeW6JOSyjO9RD
	ycJQ82mWSyg==
X-Received: from dlzz19.prod.google.com ([2002:a05:7022:493:b0:130:760b:77ba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4582:b0:12c:8b9:7208
 with SMTP id a92af1059eb24-13436aa0c8amr3219730c88.26.1778713532524; Wed, 13
 May 2026 16:05:32 -0700 (PDT)
Date: Wed, 13 May 2026 16:04:50 -0700
In-Reply-To: <20260513230450.529380-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513230450.529380-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513230450.529380-15-irogers@google.com>
Subject: [PATCH v1 14/14] perf test: Remove /usr/bin/cc dependency from Intel
 PT shell test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

In test_intel_pt.sh, the test script compiled two external C programs at
runtime using /usr/bin/cc (a thread loop workload and a JIT self-modifying
workload). Relying on external C compilers inside shell tests frequently
causes failures in continuous integration environments.

Create a built-in 'jitdump' workload and switch test_intel_pt.sh to
use 'perf test -w thloop' and 'perf test -w jitdump'. Also add
multi-architecture compatibility without external C compiler
dependencies, the workload instruction arrays dynamically encode
CHK_BYTE into opcodes across x86, ARM32, ARM64, RISC-V, PowerPC, MIPS,
LoongArch, and s390x.

Some minor include fixes for util/jitdump.h.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c         |   1 +
 tools/perf/tests/shell/test_intel_pt.sh | 169 +-----------------------
 tools/perf/tests/tests.h                |   1 +
 tools/perf/tests/workloads/Build        |   1 +
 tools/perf/tests/workloads/jitdump.c    | 165 +++++++++++++++++++++++
 tools/perf/util/jitdump.h               |   3 +-
 6 files changed, 172 insertions(+), 168 deletions(-)
 create mode 100644 tools/perf/tests/workloads/jitdump.c

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 99f5afba1082..4e5733951c57 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -160,6 +160,7 @@ static struct test_workload *workloads[] = {
 	&workload__landlock,
 	&workload__traploop,
 	&workload__inlineloop,
+	&workload__jitdump,
 
 #ifdef HAVE_RUST_SUPPORT
 	&workload__code_with_type,
diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index 8ee761f03c38..26243ff760ec 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -21,9 +21,7 @@ tmpfile="${temp_dir}/tmp-perf.data"
 perfdatafile="${temp_dir}/test-perf.data"
 outfile="${temp_dir}/test-out.txt"
 errfile="${temp_dir}/test-err.txt"
-workload="${temp_dir}/workload"
 awkscript="${temp_dir}/awkscript"
-jitdump_workload="${temp_dir}/jitdump_workload"
 maxbrstack="${temp_dir}/maxbrstack.py"
 
 cleanup()
@@ -60,37 +58,6 @@ perf_record_no_bpf()
 	perf record --no-bpf-event "$@"
 }
 
-have_workload=false
-cat << _end_of_file_ | /usr/bin/cc -o "${workload}" -xc - -pthread && have_workload=true
-#include <time.h>
-#include <pthread.h>
-
-void work(void) {
-	struct timespec tm = {
-		.tv_nsec = 1000000,
-	};
-	int i;
-
-	/* Run for about 30 seconds */
-	for (i = 0; i < 30000; i++)
-		nanosleep(&tm, NULL);
-}
-
-void *threadfunc(void *arg) {
-	work();
-	return NULL;
-}
-
-int main(void) {
-	pthread_t th;
-
-	pthread_create(&th, NULL, threadfunc, NULL);
-	work();
-	pthread_join(th, NULL);
-	return 0;
-}
-_end_of_file_
-
 can_cpu_wide()
 {
 	echo "Checking for CPU-wide recording on CPU $1"
@@ -145,11 +112,6 @@ test_per_thread()
 
 	echo "--- Test per-thread ${desc}recording ---"
 
-	if ! $have_workload ; then
-		echo "No workload, so skipping"
-		return 2
-	fi
-
 	if [ "${k}" = "k" ] ; then
 		can_kernel || return 2
 	fi
@@ -252,9 +214,9 @@ test_per_thread()
 	}
 	_end_of_file_
 
-	$workload &
+	perf test -w thloop 30 2 &
 	w1=$!
-	$workload &
+	perf test -w thloop 30 2 &
 	w2=$!
 	echo "Workload PIDs are $w1 and $w2"
 	wait_for_threads ${w1} 2
@@ -283,139 +245,14 @@ test_jitdump()
 {
 	echo "--- Test tracing self-modifying code that uses jitdump ---"
 
-	script_path=$(realpath "$0")
-	script_dir=$(dirname "$script_path")
-	jitdump_incl_dir="${script_dir}/../../util"
-	jitdump_h="${jitdump_incl_dir}/jitdump.h"
-
         if ! perf check feature -q libelf ; then
 		echo "SKIP: libelf is needed for jitdump"
 		return 2
 	fi
 
-	if [ ! -e "${jitdump_h}" ] ; then
-		echo "SKIP: Include file jitdump.h not found"
-		return 2
-	fi
-
-	if [ -z "${have_jitdump_workload}" ] ; then
-		have_jitdump_workload=false
-		# Create a workload that uses self-modifying code and generates its own jitdump file
-		cat <<- "_end_of_file_" | /usr/bin/cc -o "${jitdump_workload}" -I "${jitdump_incl_dir}" -xc - -pthread && have_jitdump_workload=true
-		#define _GNU_SOURCE
-		#include <sys/mman.h>
-		#include <sys/types.h>
-		#include <stddef.h>
-		#include <stdio.h>
-		#include <stdint.h>
-		#include <unistd.h>
-		#include <string.h>
-
-		#include "jitdump.h"
-
-		#define CHK_BYTE 0x5a
-
-		static inline uint64_t rdtsc(void)
-		{
-			unsigned int low, high;
-
-			asm volatile("rdtsc" : "=a" (low), "=d" (high));
-
-			return low | ((uint64_t)high) << 32;
-		}
-
-		static FILE *open_jitdump(void)
-		{
-			struct jitheader header = {
-				.magic      = JITHEADER_MAGIC,
-				.version    = JITHEADER_VERSION,
-				.total_size = sizeof(header),
-				.pid        = getpid(),
-				.timestamp  = rdtsc(),
-				.flags      = JITDUMP_FLAGS_ARCH_TIMESTAMP,
-			};
-			char filename[256];
-			FILE *f;
-			void *m;
-
-			snprintf(filename, sizeof(filename), "jit-%d.dump", getpid());
-			f = fopen(filename, "w+");
-			if (!f)
-				goto err;
-			/* Create an MMAP event for the jitdump file. That is how perf tool finds it. */
-			m = mmap(0, 4096, PROT_READ | PROT_EXEC, MAP_PRIVATE, fileno(f), 0);
-			if (m == MAP_FAILED)
-				goto err_close;
-			munmap(m, 4096);
-			if (fwrite(&header,sizeof(header),1,f) != 1)
-				goto err_close;
-			return f;
-
-		err_close:
-			fclose(f);
-		err:
-			return NULL;
-		}
-
-		static int write_jitdump(FILE *f, void *addr, const uint8_t *dat, size_t sz, uint64_t *idx)
-		{
-			struct jr_code_load rec = {
-				.p.id          = JIT_CODE_LOAD,
-				.p.total_size  = sizeof(rec) + sz,
-				.p.timestamp   = rdtsc(),
-				.pid	       = getpid(),
-				.tid	       = gettid(),
-				.vma           = (unsigned long)addr,
-				.code_addr     = (unsigned long)addr,
-				.code_size     = sz,
-				.code_index    = ++*idx,
-			};
-
-			if (fwrite(&rec,sizeof(rec),1,f) != 1 ||
-			fwrite(dat, sz, 1, f) != 1)
-				return -1;
-			return 0;
-		}
-
-		static void close_jitdump(FILE *f)
-		{
-			fclose(f);
-		}
-
-		int main()
-		{
-			/* Get a memory page to store executable code */
-			void *addr = mmap(0, 4096, PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
-			/* Code to execute: mov CHK_BYTE, %eax ; ret */
-			uint8_t dat[] = {0xb8, CHK_BYTE, 0x00, 0x00, 0x00, 0xc3};
-			FILE *f = open_jitdump();
-			uint64_t idx = 0;
-			int ret = 1;
-
-			if (!f)
-				return 1;
-			/* Copy executable code to executable memory page */
-			memcpy(addr, dat, sizeof(dat));
-			/* Record it in the jitdump file */
-			if (write_jitdump(f, addr, dat, sizeof(dat), &idx))
-				goto out_close;
-			/* Call it */
-			ret = ((int (*)(void))addr)() - CHK_BYTE;
-		out_close:
-			close_jitdump(f);
-			return ret;
-		}
-		_end_of_file_
-	fi
-
-	if ! $have_jitdump_workload ; then
-		echo "SKIP: No jitdump workload"
-		return 2
-	fi
-
 	# Change to temp_dir so jitdump collateral files go there
 	cd "${temp_dir}"
-	perf_record_no_bpf -o "${tmpfile}" -e intel_pt//u "${jitdump_workload}"
+	perf_record_no_bpf -o "${tmpfile}" -e intel_pt//u perf test -w jitdump
 	perf inject -i "${tmpfile}" -o "${perfdatafile}" --jit
 	decode_br_cnt=$(perf script -i "${perfdatafile}" --itrace=b | wc -l)
 	# Note that overflow and lost errors are suppressed for the error count
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 6dcf2db02b8c..913ce79f7928 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -243,6 +243,7 @@ DECLARE_WORKLOAD(datasym);
 DECLARE_WORKLOAD(landlock);
 DECLARE_WORKLOAD(traploop);
 DECLARE_WORKLOAD(inlineloop);
+DECLARE_WORKLOAD(jitdump);
 
 #ifdef HAVE_RUST_SUPPORT
 DECLARE_WORKLOAD(code_with_type);
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index 2ef97f7affce..0eb6d99528eb 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -9,6 +9,7 @@ perf-test-y += datasym.o
 perf-test-y += landlock.o
 perf-test-y += traploop.o
 perf-test-y += inlineloop.o
+perf-test-y += jitdump.o
 
 ifeq ($(CONFIG_RUST_SUPPORT),y)
     perf-test-y += code_with_type.o
diff --git a/tools/perf/tests/workloads/jitdump.c b/tools/perf/tests/workloads/jitdump.c
new file mode 100644
index 000000000000..40662ef4f7d9
--- /dev/null
+++ b/tools/perf/tests/workloads/jitdump.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "util/jitdump.h"
+
+#include <stddef.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+#include <time.h>
+
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include <internal/lib.h> // page_size
+
+#include "../tests.h"
+
+#define CHK_BYTE 0x5a
+
+static inline uint64_t get_timestamp(void)
+{
+#if defined(__x86_64__) || defined(__i386__)
+	unsigned int low, high;
+
+	asm volatile("rdtsc" : "=a"(low), "=d"(high));
+
+	return low | ((uint64_t)high) << 32;
+#else
+	struct timespec ts;
+	int ret;
+
+	ret = clock_gettime(CLOCK_MONOTONIC, &ts);
+	if (ret)
+		return 0;
+
+	return ((uint64_t)ts.tv_sec * 1000000000) + ts.tv_nsec;
+#endif
+}
+
+static FILE *open_jitdump(void)
+{
+	struct jitheader header = {
+		.magic = JITHEADER_MAGIC,
+		.version = JITHEADER_VERSION,
+		.total_size = sizeof(header),
+		.pid = getpid(),
+		.timestamp = get_timestamp(),
+		.flags = JITDUMP_FLAGS_ARCH_TIMESTAMP,
+	};
+	char filename[256];
+	FILE *f;
+	void *m;
+
+	snprintf(filename, sizeof(filename), "jit-%d.dump", getpid());
+	f = fopen(filename, "w+");
+	if (!f) {
+		pr_err("Failed to open jitdump '%s'\n", filename);
+		return NULL;
+	}
+	/* Create an MMAP event for the jitdump file. That is how perf tool finds it. */
+	m = mmap(0, page_size, PROT_READ | PROT_EXEC, MAP_PRIVATE, fileno(f), 0);
+	if (m == MAP_FAILED)
+		pr_err("Error creating jitdump MMAP event\n");
+	else
+		munmap(m, page_size);
+
+	if (fwrite(&header, sizeof(header), 1, f) != 1) {
+		pr_err("Error writing jitdump header\n");
+		fclose(f);
+		return NULL;
+	}
+	return f;
+}
+
+static int write_jitdump(FILE *f, void *addr, const void *dat, size_t sz, uint64_t *idx)
+{
+	struct jr_code_load rec = {
+		.p.id = JIT_CODE_LOAD,
+		.p.total_size = sizeof(rec) + sz,
+		.p.timestamp = get_timestamp(),
+		.pid = getpid(),
+		.tid = getpid(),
+		.vma = (unsigned long)addr,
+		.code_addr = (unsigned long)addr,
+		.code_size = sz,
+		.code_index = ++*idx,
+	};
+
+	if (fwrite(&rec, sizeof(rec), 1, f) != 1 || fwrite(dat, sz, 1, f) != 1)
+		return -1;
+	return 0;
+}
+
+static void close_jitdump(FILE *f)
+{
+	fclose(f);
+}
+
+static int jitdump(int argc __maybe_unused, const char **argv __maybe_unused)
+{
+#if defined(__x86_64__) || defined(__i386__)
+	/* Code to execute: mov CHK_BYTE, %eax ; ret */
+	uint8_t dat[] = { 0xb8, CHK_BYTE, 0x00, 0x00, 0x00, 0xc3 };
+#elif defined(__aarch64__)
+	/* Code to execute: mov w0, #CHK_BYTE ; ret */
+	uint32_t dat[] = { 0x52800000 | (CHK_BYTE << 5), 0xd65f03c0 };
+#elif defined(__riscv)
+	/* Code to execute: li a0, CHK_BYTE ; ret */
+	uint32_t dat[] = { ((CHK_BYTE & 0xfff) << 20) | 0x513, 0x00008067 };
+#elif defined(__powerpc__)
+	/* Code to execute: li r3, CHK_BYTE ; blr */
+	uint32_t dat[] = { 0x38600000 | (CHK_BYTE & 0xffff), 0x4e800020 };
+#elif defined(__s390x__)
+	/* Code to execute: lhi %r2, CHK_BYTE ; br %r14 */
+	uint8_t dat[] = { 0xa7, 0x28, (CHK_BYTE >> 8) & 0xff, CHK_BYTE & 0xff, 0x07, 0xfe };
+#elif defined(__arm__)
+	/* Code to execute: mov r0, #CHK_BYTE ; bx lr */
+	uint32_t dat[] = { 0xe3a00000 | (CHK_BYTE & 0xff), 0xe12fff1e };
+#elif defined(__mips__)
+	/* Code to execute: addiu $v0, $zero, CHK_BYTE ; jr $ra ; nop */
+	uint32_t dat[] = { 0x24020000 | (CHK_BYTE & 0xffff), 0x03e00008, 0x00000000 };
+#elif defined(__loongarch__)
+	/* Code to execute: addi.w $a0, $zero, CHK_BYTE ; jirl $zero, $ra, 0 */
+	uint32_t dat[] = { 0x02800004 | ((CHK_BYTE & 0xfff) << 10), 0x4c000020 };
+#else
+	uint32_t dat[0];
+#endif
+	void *addr;
+	FILE *f;
+	uint64_t idx = 0;
+	int ret = 1;
+
+	/* Get a memory page to store executable code. */
+	addr = mmap(0, page_size, PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (addr == MAP_FAILED) {
+		pr_err("Failed to map 1 -wx page\n");
+		return 1;
+	}
+
+	f = open_jitdump();
+	if (!f) {
+		pr_err("Failed to open jitdump\n");
+		munmap(addr, page_size);
+		return 1;
+	}
+	/* Copy executable code to executable memory page. */
+	memcpy(addr, dat, sizeof(dat));
+	/* Record it in the jitdump file */
+	if (write_jitdump(f, addr, dat, sizeof(dat), &idx) == 0) {
+		if (sizeof(dat) > 0) {
+			int (*fn)(void) = addr;
+
+			/* Call the function. */
+			ret = fn() - CHK_BYTE;
+		} else {
+			pr_err("jitdump workload not supported on this architecture\n");
+			ret = 1;
+		}
+	}
+	close_jitdump(f);
+	munmap(addr, page_size);
+	return ret;
+}
+
+DEFINE_WORKLOAD(jitdump);
diff --git a/tools/perf/util/jitdump.h b/tools/perf/util/jitdump.h
index ab2842def83d..f57bfebb20ff 100644
--- a/tools/perf/util/jitdump.h
+++ b/tools/perf/util/jitdump.h
@@ -11,9 +11,8 @@
 #ifndef JITDUMP_H
 #define JITDUMP_H
 
-#include <sys/time.h>
-#include <time.h>
 #include <stdint.h>
+#include <string.h>
 
 /* JiTD */
 #define JITHEADER_MAGIC		0x4A695444
-- 
2.54.0.563.g4f69b47b94-goog

