Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019426;
	b=lcMX/DDJ1JZk51Bxldt0e/bHylpD5IhaM0ZuFcLyBxe0INR2CntqT1MEz70U5kT4QHUi
	 H30cNPMfjPyJOZLduDLLK4o4QEGXVYEYB3gr+wAHQgrfqGgLQVr/GZcYsfv0u0U54mps8
	 mjPsSfvrmbEaKaByNUjdszJJs0pynq70vXEF+3eHjEIQ8+07C4Cw2BdHsSA6ba76MzrfN
	 WciNRnnm5vy/XO7HR7yWAU3Unv0Z957K55LP1lCnr21mk9GlQKJ+2PHNZOqW+6Xkk5wRd
	 eyXEPZ7ifQyys4Bs1n66rN9nw4uhhGDgY+VCQreg9YyUm7a9OjfeJHDUDwZrFbYQcGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=OWO/4pb+xROsjF0+5i909plVTiV5kvL03eZF9ypm+2s=;
	b=PMI17d7/JtIzHKv8qwrrCgDyTE+zRzBM2Lf/ANI2V3P1LGweBIoAIgXMOkVqGP9eNfdJ
	 e/u8xNhypCm5J5WczsvODOAGjB3SMxMarEwUVHJWptkjIcSWRIR+/wPpXM6b6NIEpp3Yk
	 E6sSPog6PEeSp8kuGvFWLMmhW0GbyyP8RpAfLVqpVu3hHPVYpABuMEGk57AzlCq6VCc2q
	 4fwXa2kteB4cVSIuVg0u5lGzB0yWe+z3hEO+Jnqk6V64RbwlWAZSCTIx1aefv91NIf/do
	 c2KMgdPsZ/NTlIpOnY+IaNAhTauEScjudoWtE3YvkjRmbnzAprGXa/6C8+yQJYQ+kNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=g2me5mkO;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD99606C3E0
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBD99606C3E0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=g2me5mkO
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so1080230f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795019422; x=1795624222; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OWO/4pb+xROsjF0+5i909plVTiV5kvL03eZF9ypm+2s=;
        b=g2me5mkOBerovjVEh71SOT7VMFd1szCgDeCLsxRmWUDl/UBtaKFhxJsM7H9+rv4Vtx
         G9NP7HoPN73LJuCU15v/ePO/KVl7NLt7Oc2/LcF9o5pn+KIzMUfUxkbfaMpHD9ceqgd1
         f6GsvH9ndqodcj1nkZoaps5W+EK1dMCrX+OufNAH8zrgcPImylUEgZr5zMAjGKBpuuKb
         roVbkoDZ691uG7vywX5nb1SaRo8dgdI6G63tlfsW+ow3wViGrioFZa8VU3sR+uIowq7R
         7foHzCpJKMfnWzMleE+Gnb52PumOmm4QCCaor6byqs5atbougaCGKZGieu7H0gQe6h4+
         MC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019422; x=1795624222;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OWO/4pb+xROsjF0+5i909plVTiV5kvL03eZF9ypm+2s=;
        b=mGGfgxK+D8q/ZZryv68J/niIkf+Zp21PYsBSFqcw48JiV46f7mxr/JJ8tC/YzoBkQw
         Nzi8FnpXDQIj26AsDpeGbJQT/rvyfpiYM09Lx0EqEFMQVRJrkn0PRNWi4E2xQfBDTiGW
         WPKZAM6SyCgs+v7cy+25YKzxpECDPogImGkfFOM5APvakNjViCCJQc+y+Akl42w2ZKF0
         Dd/uMT+nxv11+XdgBFA8afvmiWw/1ihGXGTxEnOnYZVCkMdxnbHN1EU9ySnnngelajJO
         70hd1XjSjoSsdUI8ZePYiGki+nkbkw7/f4bf93IoSCwugT6qwHUJK3bKODFdP6XSgziE
         nLew==
X-Gm-Message-State: APuU4Z+qrU0RJFwRwIKJArhvTnFWbgmUvszJcWzFuk1XGZvQD3S2r1EA
	FR+i1d54Ylog4e+eXoY6DwUVUBigs723Rz89U9uBcDiEB3cotccQqq7itAaT7ExU9iQ=
X-Gm-Gg: AZFdTZcfjLfegiSuXJKVGv3RyAEOULerdGW4PJIM0xxi0IimS0zjpX+M6AVKaLQl9Fp
	VJdFcfhHVr2n1N/Y92d1kv3+N4cM9uBoLJOrg/o+XZr7ncMGUf6ODJTtIYZWddq7mELqSIQJakG
	lR+erZ5wIGIOcgmk99mXBAWdFj/3EAsvphtUUjUEp2rV9jR+ecEqMUZeOY2F16qBzjpyIyGY922
	V4M79CzE5C2rkj+JtYAkQGwSyIdd7oQ7MyHjOfBTFWQyhk5gqz09TAkZ1vVVYqcCKr7v6/q5Kvj
	b16koqYblqnskT320BQm0KQNDaLi0WlfVHo3oeDs5m9sHEh6R3gGz+D8CGhhB6ypN0FynTTS6aS
	2EU8a+9T3mPYXI5ovrCwY1GoDqTTrdNsCdhFJqbg0owuhQIsr7sIvmaN+BkY2nkxp1tfqUB6LHq
	zgRWjj1qZj/A1POAl53voId8zQrMXkI+GaKackYdupprUgJqUMM6kRU0mHtS/s/S6aXEoicEc57
	0utX6C5nFscZPhzvRomvW8pI1QYW4dodWqgyguugN9BBAWvXn7eFrqli/w8U65SDxML+4qhgZ5y
	AN7oAEo4JxCK2eDH4r8AZE0o8J5KAnTi
X-Received: by 2002:a05:6000:184d:b0:4a6:4862:28fc with SMTP id ffacd0b85a97d-4a648622a17mr7753290f8f.7.1795019422213;
        Wed, 18 Nov 2026 08:30:22 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c23bsm4980927f8f.12.2026.11.18.08.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:30:21 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 18 Nov 2026 16:29:53 +0000
Subject: [PATCH 31/34] perf test cs-etm: Add a Java JIT source-line test
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-james-coresight-jit-v1-31-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
In-Reply-To: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, 
 Leo Yan <leo.yan@arm.com>, Amir Ayupov <aaupov@fb.com>, 
 Suyash Mahar <smahar@meta.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Record a deterministic Java workload using the JVMTI agent and check
that the decoded source lines match the expected sequence.

Alternate fresh class loaders and request garbage collection to
encourage address re-use so that we can test if trace timestamps match
up to jitdump events.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Makefile.perf                          |  4 +-
 tools/perf/tests/shell/coresight/java-jit.sh      | 65 ++++++++++++++++++
 tools/perf/tests/shell/coresight/lib/PerfJit.java | 82 +++++++++++++++++++++++
 3 files changed, 150 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b74b534e1153..53c10e8e4556 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -992,7 +992,9 @@ install-tests: all install-gtk
 		$(INSTALL) tests/shell/base_report/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/base_report'; \
 		$(INSTALL) tests/shell/base_report/*.txt '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/base_report'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight' ; \
-		$(INSTALL) tests/shell/coresight/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
+		$(INSTALL) tests/shell/coresight/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'; \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight/lib'; \
+		$(INSTALL) tests/shell/coresight/lib/*.java -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight/lib'
 
 install-bin: install-tools install-tests
 
diff --git a/tools/perf/tests/shell/coresight/java-jit.sh b/tools/perf/tests/shell/coresight/java-jit.sh
new file mode 100755
index 000000000000..cb6099efa899
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/java-jit.sh
@@ -0,0 +1,65 @@
+#!/bin/bash
+# CoreSight Java JIT source lines and code address reuse (exclusive)
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+set -o pipefail
+
+script_dir=$(dirname "$0")
+
+# Requires a HotSpot JDK (11+) and libperf-jvmti with line number support.
+perf list pmu | grep cs_etm > /dev/null || exit 2
+# Require TRBE so that the trace always has virtual timestamps.
+if ! ls /sys/bus/coresight/devices/trbe* > /dev/null 2>&1; then
+	echo "No TRBE sinks, skipping"
+	exit 2
+fi
+command -v java > /dev/null || exit 2
+command -v javac > /dev/null || exit 2
+command -v timeout > /dev/null || exit 2
+for lib in "${LIBJVMTI:-}" \
+	"$(dirname "$(readlink -f "$(type -P perf)")")/libperf-jvmti.so" \
+	"${PREFIX:-/usr}/lib64/libperf-jvmti.so" "${PREFIX:-/usr}/lib/libperf-jvmti.so"; do
+	if [ -f "$lib" ]; then
+		LIBJVMTI=$(readlink -f "$lib")
+		break
+	fi
+done
+[ -f "${LIBJVMTI:-}" ] || { echo "SKIP: missing libperf-jvmti.so"; exit 2; }
+
+tmpdir=$(mktemp -d /tmp/__perf_test.coresight_java_jit.XXXXX)
+trap '[ "$?" -eq 0 ] && rm -rf "$tmpdir" || echo "Java JIT test files retained in $tmpdir"' EXIT
+trap 'exit 1' TERM INT
+
+javac -g --release 11 -d "$tmpdir" "$script_dir/lib/PerfJit.java"
+mkfifo "$tmpdir/ctl" "$tmpdir/ack"
+export JITDUMPDIR="$tmpdir" JITDUMP_USE_ARCH_TIMESTAMP=1
+
+# Compile only run(), and collect trace only while it executes.
+# A small code cache and class unloading encourage address reuse.
+timeout 60s perf record \
+	-o "$tmpdir/data" -e cs_etm//u -D -1 -m ,8M \
+	--control "fifo:$tmpdir/ctl,$tmpdir/ack" -- \
+	java -Xbatch -XX:-TieredCompilation -XX:CompileThreshold=100 \
+	-XX:+UnlockDiagnosticVMOptions -XX:+DebugNonSafepoints \
+	'-XX:CompileCommand=compileonly,PerfJit$*::run' \
+	-XX:ReservedCodeCacheSize=4m -XX:+UseSerialGC \
+	-agentpath:"$LIBJVMTI" -cp "$tmpdir" PerfJit "$tmpdir/ctl" "$tmpdir/ack"
+
+perf inject --jit -b \
+	-i "$tmpdir/data" -o "$tmpdir/injected.data"
+
+perf script \
+	-i "$tmpdir/injected.data" --itrace=i1i -F ip,srcline \
+	--symbols 'PerfJit$First.run(),PerfJit$Second.run()' > "$tmpdir/script"
+
+# The workload runs eight pairs of First.run() and Second.run().
+awk '/\/\/ TRACE$/ { lines = lines "PerfJit.java:" NR "\n" }
+     END { for (i = 0; i < 8; i++) printf "%s", lines }' \
+	"$script_dir/lib/PerfJit.java" > "$tmpdir/expected"
+
+# Ignore entry/return lines and retain the order of the marked Java lines.
+sed -n 's/^.*PerfJit\.java:/PerfJit.java:/p' "$tmpdir/script" | uniq > "$tmpdir/lines"
+grep -Fxf "$tmpdir/expected" "$tmpdir/lines" > "$tmpdir/actual" || true
+diff -u "$tmpdir/expected" "$tmpdir/actual"
+echo "Java JIT source lines match the expected sequence"
diff --git a/tools/perf/tests/shell/coresight/lib/PerfJit.java b/tools/perf/tests/shell/coresight/lib/PerfJit.java
new file mode 100644
index 000000000000..30b22e952bd4
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/lib/PerfJit.java
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+import java.io.FileInputStream;
+import java.io.FileWriter;
+import java.io.InputStream;
+import java.util.Arrays;
+
+public class PerfJit {
+    public static class First implements Runnable {
+        public static volatile int value;
+        public void run() {
+            value += 1; // TRACE
+            value += 2; // TRACE
+            value += 3; // TRACE
+            value += 0; // Give the last checked line a DWARF end address.
+        }
+    }
+
+    public static class Second implements Runnable {
+        public static volatile int value;
+        public void run() {
+            value += 4; // TRACE
+            value += 5; // TRACE
+            value += 6; // TRACE
+            value += 0; // Give the last checked line a DWARF end address.
+        }
+    }
+
+    static FileWriter control;
+    static FileInputStream ack;
+
+    static void command(String command) throws Exception {
+        if (control != null) {
+            control.write(command + "\n");
+            control.flush();
+            // perf writes sizeof("ack\n"), including the trailing NUL.
+            byte[] reply = new byte[5];
+            if (ack.readNBytes(reply, 0, reply.length) != reply.length ||
+                !Arrays.equals(reply, new byte[] {'a', 'c', 'k', '\n', 0}))
+                throw new Exception("Missing perf control ack");
+        }
+    }
+
+    static void phase(String name, int repeats) throws Exception {
+        byte[] code;
+        try (InputStream in = PerfJit.class.getResourceAsStream("PerfJit$" + name + ".class")) {
+            code = in.readAllBytes();
+        }
+        // A fresh loader allows this class and its compiled code to be reclaimed.
+        Class<?> block = new ClassLoader(null) {
+            Class<?> load() { return defineClass(null, code, 0, code.length); }
+        }.load();
+        Runnable work = (Runnable) block.getConstructor().newInstance();
+        for (int i = 0; i < 20000; i++)
+            work.run();
+        command("enable");
+        for (int i = 0; i < repeats; i++)
+            work.run();
+        command("disable");
+    }
+
+    public static void main(String[] args) throws Exception {
+        if (args.length >= 2) {
+            control = new FileWriter(args[0]);
+            ack = new FileInputStream(args[1]);
+        }
+        int rounds = args.length >= 3 ? Integer.parseInt(args[2]) : 8;
+        int repeats = args.length >= 4 ? Integer.parseInt(args[3]) : 1;
+        // Warm up the FIFO path before enabling trace for the first method.
+        command("disable");
+        for (int i = 0; i < rounds * 2; i++) {
+            phase(i % 2 == 0 ? "First" : "Second", repeats);
+            for (int gc = 0; gc < 3; gc++) {
+                System.gc();
+                Thread.sleep(20);
+            }
+        }
+        if (control != null) {
+            control.close();
+            ack.close();
+        }
+    }
+}

-- 
2.43.0

