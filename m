Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78AD3FFAA7
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 17:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422159; cv=none; b=FyJh1C9Q5QKMDw0aLeBIt5pR1CMYEL93iZpq8dJ3AWkT6zQgWkTk+eF1QjaPdGUK57kGcVuCT263PRTQqnl40Bb0cnl5GvA2cY2cYE6qK2G5hXkJ8Dv/0r9Voo9sJYOvH3dDknTT19RelT1NAcAlMS/UeVZxtt0pvINz5aDEV/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422159; c=relaxed/simple;
	bh=zUAboRjv+nKT8yvV7u6WoCaVogvhU8CL+snSVAiLZq8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cqHB4CG3opmck25UWlRY8T6qrn8/W9W40QcP19THgLSk9oo/VAaLXca5AJRD4z4smFsL8DN8yH1zZn6vehXVMgv9gMRs/GJUsEfl5P3TXmBLnsJ7TAZNE5G4/D0L4aG4chrn99CnIJ22UCrOeinKAGC5qcfrLUrzhSrsZPnkXxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LgUzhFX6; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LgUzhFX6"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85a298cd62so2010141a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 10:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780422153; x=1781026953; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YS1KYl95XZgOSIRp7IcvZmmvZ4lzrJ5WzypMZzK+z2c=;
        b=LgUzhFX6xTNv2m53+wrB8o/SMY7wI6+lYKg2RoGj+t8dhY92+rnVwBNmJIXq1M4Mzt
         CUsnHwS8M98EaFASBH5qLw9IllNRJvCOyQ2bSPCnpuDoooXNhYsWIJSystrW3kWq01dP
         O7K+WM5kCq7scubq38AtkELuACvUwSLMQqymTVenERFsKmSuLakAFRtn8ZTx/+ARwdts
         pUKZZlaz/H/RhBqPxVJMXRxIGaNXc6kUPyaIXcD1aVz//aZfB14YLQ3y39fs+XhCL8ON
         94X55JyDzmNwocT9UzPBzc5jOuyrLPoN/rc1twcrymDEevaaZgdwZC6pOPBxV6L+5pmk
         IIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780422153; x=1781026953;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YS1KYl95XZgOSIRp7IcvZmmvZ4lzrJ5WzypMZzK+z2c=;
        b=jf6e4MQAmFw0Pxl2BJqJtkSqzWyFwUuWyPHJKtn9323kModqKN/eh0/H2aDjIRjJqR
         6WIovld65ZycMuKexIbL0SIzHgMeTHVGrKIjbAXZ7o9/mBQfJC8+le1Ou9ECygzDaH9N
         bngLQMcT+VaE/joIx2AME+fojscTWcN60Emb+h6UnlAMfoTNO3foMCh+TBDe1BQ2z27x
         6rjuppsX1LS8OGwXBDQOW0K4rUXUBKtEEAs3/Ri69/khRP00xC0jbfLqt+MDP79J7asu
         iuqIA6rYl1+vJDRJX4bHAGwD4ItjWRCTgr1loNl4SJhPJh1FCD6vc0yqGcuoudK0lu5Y
         JS3w==
X-Forwarded-Encrypted: i=1; AFNElJ+HKeSDSIFnmNbhnSU6g12rAoDrcGp0GxADJ2pO/zh2mhkqsuuCdrb+LZK58h3mJ4s8N9qDCshvw+9MWUivkIMl@vger.kernel.org
X-Gm-Message-State: AOJu0YzYFnxxwOdV3khxTMh62QmIW7+t3vmwgl9zIuaFEvWUCEUmHmeu
	587P0BEPL+RumUlxMlHw0VXXK0KwnP9pOHJnyUfizPIz7J1xKmVv3TCT5R+mo7UIHqgcGto8Iw5
	oYSBY5Hoaxg==
X-Received: from pgq7.prod.google.com ([2002:a63:1047:0:b0:c82:7907:76fe])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6cc9:b0:3b4:871a:5aaa
 with SMTP id adf61e73a8af0-3b4943a1810mr537994637.26.1780422152689; Tue, 02
 Jun 2026 10:42:32 -0700 (PDT)
Date: Tue,  2 Jun 2026 10:41:27 -0700
In-Reply-To: <20260602174129.3192312-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602073132.2653307-1-irogers@google.com> <20260602174129.3192312-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602174129.3192312-17-irogers@google.com>
Subject: [PATCH v8 16/18] perf test: Remove /usr/bin/cc dependency from Intel
 PT shell test
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

In test_intel_pt.sh, the test script compiled two external C programs at
runtime using /usr/bin/cc (a thread loop workload and a JIT self-
modifying workload). Relying on external C compilers inside shell tests
frequently causes failures in continuous integration environments.

Create a built-in 'jitdump' workload and switch test_intel_pt.sh to use
'perf test -w thloop' and 'perf test -w jitdump'. Also add multi-
architecture compatibility without external C compiler dependencies, the
workload instruction arrays dynamically encode CHK_BYTE into opcodes
across x86, ARM32, ARM64, RISC-V, PowerPC, MIPS, LoongArch, and s390x.

Some minor include fixes for util/jitdump.h.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c         |   1 +
 tools/perf/tests/shell/test_intel_pt.sh | 169 +------------------
 tools/perf/tests/tests.h                |   1 +
 tools/perf/tests/workloads/Build        |   1 +
 tools/perf/tests/workloads/jitdump.c    | 210 ++++++++++++++++++++++++
 tools/perf/util/jitdump.h               |   3 +-
 6 files changed, 217 insertions(+), 168 deletions(-)
 create mode 100644 tools/perf/tests/workloads/jitdump.c

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 37b91f4e9273..b64fc2204f22 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -161,6 +161,7 @@ static struct test_workload *workloads[] = {
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
index 9bcf1dbb0663..bf8ff7d54727 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -244,6 +244,7 @@ DECLARE_WORKLOAD(datasym);
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
index 000000000000..01cbbbd564e8
--- /dev/null
+++ b/tools/perf/tests/workloads/jitdump.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "util/jitdump.h"
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+#include <time.h>
+
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include "../tests.h"
+
+#ifndef HAVE_GETTID
+#include <sys/syscall.h>
+static inline pid_t gettid(void)
+{
+	return (pid_t)syscall(SYS_gettid);
+}
+#endif
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
+		.flags =
+#if defined(__x86_64__) || defined(__i386__)
+			JITDUMP_FLAGS_ARCH_TIMESTAMP,
+#else
+			0,
+#endif
+	};
+	char filename[256];
+	int fd;
+	FILE *f;
+	void *m;
+
+	snprintf(filename, sizeof(filename), "jit-%d.dump", getpid());
+	/* Securely open using O_CREAT | O_EXCL to prevent symlink attacks. */
+	fd = open(filename, O_CREAT | O_EXCL | O_RDWR, 0644);
+	if (fd < 0) {
+		pr_err("Failed to open jitdump '%s': %s\n", filename, strerror(errno));
+		return NULL;
+	}
+	f = fdopen(fd, "w+");
+	if (!f) {
+		pr_err("Failed to associate stream with fd for '%s'\n", filename);
+		close(fd);
+		unlink(filename);
+		return NULL;
+	}
+	/* Create an MMAP event for the jitdump file. That is how perf tool finds it. */
+	m = mmap(0, getpagesize(), PROT_READ | PROT_EXEC, MAP_PRIVATE, fileno(f), 0);
+	if (m == MAP_FAILED) {
+		pr_err("mmap failed: %s\n", strerror(errno));
+		fclose(f);
+		unlink(filename);
+		return NULL;
+	}
+	munmap(m, getpagesize());
+
+	if (fwrite(&header, sizeof(header), 1, f) != 1) {
+		pr_err("Error writing jitdump header\n");
+		fclose(f);
+		unlink(filename);
+		return NULL;
+	}
+	return f;
+}
+
+static int write_jitdump(FILE *f, void *addr, const void *dat, size_t sz, uint64_t *idx)
+{
+	const char *sym = "jit_workload";
+	size_t sym_len = strlen(sym) + 1;
+	struct jr_code_load rec = {
+		.p.id = JIT_CODE_LOAD,
+		.p.total_size = sizeof(rec) + sym_len + sz,
+		.p.timestamp = get_timestamp(),
+		.pid = getpid(),
+		.tid = gettid(),
+		.vma = (unsigned long)addr,
+		.code_addr = (unsigned long)addr,
+		.code_size = sz,
+		.code_index = ++*idx,
+	};
+
+	if (fwrite(&rec, sizeof(rec), 1, f) != 1 ||
+	    fwrite(sym, sym_len, 1, f) != 1 ||
+	    fwrite(dat, sz, 1, f) != 1)
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
+	uint8_t dat[] = {
+		(CHK_BYTE << 5) & 0xff, (CHK_BYTE >> 3) & 0xff, 0x80, 0x52,
+		0xc0, 0x03, 0x5f, 0xd6
+	};
+#elif defined(__riscv)
+	/* Code to execute: li a0, CHK_BYTE ; ret */
+	uint8_t dat[] = {
+		0x13, 0x05, (CHK_BYTE << 4) & 0xff, (CHK_BYTE >> 4) & 0xff,
+		0x67, 0x80, 0x00, 0x00
+	};
+#elif defined(__powerpc__)
+	/* Code to execute: li r3, CHK_BYTE ; blr */
+	uint32_t dat[] = { 0x38600000 | (CHK_BYTE & 0xffff), 0x4e800020 };
+#elif defined(__s390x__)
+	/* Code to execute: lhi %r2, CHK_BYTE ; br %r14 */
+	uint8_t dat[] = { 0xa7, 0x28, (CHK_BYTE >> 8) & 0xff, CHK_BYTE & 0xff, 0x07, 0xfe };
+#elif defined(__arm__)
+	/* Code to execute: mov r0, #CHK_BYTE ; bx lr */
+	uint8_t dat[] = {
+		CHK_BYTE & 0xff, 0x00, 0xa0, 0xe3,
+		0x1e, 0xff, 0x2f, 0xe1
+	};
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
+	/* Reachable fallback check for unsupported architectures right at start. */
+	if (sizeof(dat) == 0) {
+		pr_err("JITDUMP workload not supported on this architecture\n");
+		return 1;
+	}
+
+	/* Get a memory page to store executable code. */
+	addr = mmap(0, getpagesize(), PROT_READ | PROT_WRITE | PROT_EXEC,
+		    MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (addr == MAP_FAILED) {
+		pr_err("Failed to map 1 -rwx page\n");
+		return 1;
+	}
+
+	f = open_jitdump();
+	if (!f) {
+		pr_err("Failed to open JITDUMP\n");
+		munmap(addr, getpagesize());
+		return 1;
+	}
+	/* Copy executable code to executable memory page. */
+	memcpy(addr, dat, sizeof(dat));
+	/* Synchronize the Instruction and Data caches. */
+	__builtin___clear_cache(addr, (char *)addr + sizeof(dat));
+
+	/* Record it in the jitdump file */
+	if (write_jitdump(f, addr, dat, sizeof(dat), &idx) == 0) {
+		int (*fn)(void) = addr;
+
+		/* Call the function. */
+		ret = fn() - CHK_BYTE;
+	}
+	close_jitdump(f);
+	munmap(addr, getpagesize());
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
2.54.0.1013.g208068f2d8-goog

