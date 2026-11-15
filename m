Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794706877;
	b=FzT6c52FCKID9+wqpE3y2iNP/GWMOz3h/2wF4Tt9kX2QWta203BsLfToTuV8oOWqLrBV
	 QZ9R621LAFD5+BokAuerSdqm/PFGALQUebJWFKIv2NQuze8Ul7iUKQ6f5etcLZjBzZ70k
	 Wso+wOY7n1bkNNZy1d+HUocgLGbx4a5EIakKhJg/Vk4t4dQ9DImXExSm5420Ay1uS4h16
	 SWICFEeWgbCYITV8YUDEjv7vK7OpGaPhCAPskfTXZ8Dr23Qv6tl/BltnxY+E49lQF82Jt
	 pAS45igV80BFoN4Ecr/lYBFiVclEDJ+xcKBc5ay578o8NZRkKTup4XFX7HX23GE2Dog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794706877;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qJO4kLQ2oFohaKYGKRUH5C5nj+/4FqKu4KyxvgvlyAA=;
	b=T19pTtM0eoYoLtkJ0qx5tbwPdCGDfBH7bC+A0dBgx00nlE2FtuxYD9Z/4VzuJAZwjFLb
	 4OGLx+nZZ8k0MBQiG3FphNuk9rILs59juQAYW2KyPkvrzkMWDnu75/R0I2GgXRVM6DPGE
	 xCAVwl5IfhOY6s7kHlUZQnzphgaQHGvuE7+AcGkvacclWRyw76GX2lXICrSyELGKToqkF
	 XeGts6z9H5WkCht5O96xtyQnzV5VLjC8soPClBf7dGnMz5JHGLbryE/3UTYM+1st/8bxL
	 /AEtkLfoXtiC93QkM1xDLaM0867Q5vd7VSJj9kER92Kbnxr/q0qj7KPeQqz/a4TCLjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cweDYkXx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC25B606A32F;
	Sun, 15 Nov 2026 01:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cweDYkXx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40DF1F000C5;
	Sun, 15 Nov 2026 01:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794706877;
	bh=qJO4kLQ2oFohaKYGKRUH5C5nj+/4FqKu4KyxvgvlyAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cweDYkXxPM04e4Wvb762PpW12xVebg8tT7J0sHQlbw/FcQcyC7uvCKUE+EOjHYPEo
	 NCRU+4iW7pDY3lD1+k4slx0qu6caKRriPRuJsCxBmdgBzBylPc22vpHjFxKmycIuRW
	 klOVXa+wbFmOwMevjCtx9AGH9Uhg2inIghDiFzQpICbQUUMfKI7xv0pj1S0rk0eU4A
	 PmNTJ58Iv/XTnFyLdDFQ6sFiMueKKSTYVf4f2L6dXtwFOUgKIklPyoFQCTT60N80bL
	 h5x/RVKjnGOTZZIUGUsF4/uUmCgVa+Q1R6xK+ha7RMLGbjYmwD926btLkwBXRZfOrU
	 C3+9ygxN89Vvw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v3 03/12] perf annotate-data: Resolve DW_OP_addrx global variables
Date: Sat, 14 Nov 2026 22:40:51 -0300
Message-ID: <20261115014102.2879372-4-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115014102.2879372-1-acme@kernel.org>
References: <20261115014102.2879372-1-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clang emits DW_AT_location with DW_OP_addrx for global variables in
DWARF 5, gcc emits DW_OP_addr.  The address index was not resolved, so
those variables were not found by address; the by-name fallback also
missed the ones in .bss past the file backed end of the last segment.

Resolve the index with dwarf_getlocation_attr() + dwarf_formaddr() and
use the resulting address in the by-address lookup and in the global
variable cache.  The new global_data workload keeps a zero initialized
struct in .bss and its test checks that the accesses are annotated: when
perf is built with clang and DWARF 5 it goes through DW_OP_addrx, with
gcc through DW_OP_addr.  The test skips on 32-bit PIE builds, which
load globals through the GOT, something the resolver does not follow.

Fixes: d60469d7c0e5c4e8 ("perf dwarf-aux: Add die_find_variable_by_addr()")
Fixes: d7d60803a790b716 ("perf dwarf-aux: Add die_collect_global_vars()")
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c            |  1 +
 tools/perf/tests/shell/data_type_global.sh | 70 ++++++++++++++++++++++
 tools/perf/tests/tests.h                   |  1 +
 tools/perf/tests/workloads/Build           |  2 +
 tools/perf/tests/workloads/global_data.c   | 55 +++++++++++++++++
 tools/perf/util/annotate-data.c            |  4 ++
 tools/perf/util/dwarf-aux.c                | 42 +++++++++++--
 7 files changed, 170 insertions(+), 5 deletions(-)
 create mode 100755 tools/perf/tests/shell/data_type_global.sh
 create mode 100644 tools/perf/tests/workloads/global_data.c

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 86698b86657f45b0..299e07bd16a5a53f 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -199,6 +199,7 @@ static struct test_workload *workloads[] = {
 	&workload__deterministic,
 	&workload__callchain,
 	&workload__false_sharing,
+	&workload__global_data,
 
 #ifdef HAVE_RUST_SUPPORT
 	&workload__code_with_type,
diff --git a/tools/perf/tests/shell/data_type_global.sh b/tools/perf/tests/shell/data_type_global.sh
new file mode 100755
index 0000000000000000..7db2e898a41657bc
--- /dev/null
+++ b/tools/perf/tests/shell/data_type_global.sh
@@ -0,0 +1,70 @@
+#!/bin/bash
+# perf data type profiling test for a global variable
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+perfout=$(mktemp /tmp/__perf_test.perf.out.XXXXX)
+
+cleanup()
+{
+	rm -f "$perfdata" "$perfout"
+	trap - EXIT TERM INT
+}
+
+trap_cleanup()
+{
+	echo "Unexpected signal in ${FUNCNAME[1]}"
+	cleanup
+	exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+if ! perf check feature -q dwarf; then
+	echo "Skip: no DWARF (libdw) support"
+	cleanup
+	exit 2
+fi
+
+# 32-bit PIE loads globals through the GOT, which the resolver does not follow
+if [ "$(getconf LONG_BIT)" = 32 ] &&
+   [ "$(od -An -tx1 -j16 -N2 "$(command -v perf)" | awk '{print $1}')" = 03 ]; then
+	echo "Skip: 32-bit PIE uses GOT-relative global accesses"
+	cleanup
+	exit 2
+fi
+
+# No point in recording if the PMU cannot do memory events.
+if perf mem record -o /dev/null -- true 2>&1 | \
+		grep -q "failed: no PMU supports the memory events"; then
+	cleanup
+	exit 2
+fi
+if ! perf mem record -o /dev/null -- true 2>/dev/null; then
+	echo "Skip: cannot record memory events on this PMU"
+	cleanup
+	exit 2
+fi
+
+if ! perf mem record -o "$perfdata" -- perf test -w global_data 1 > /dev/null 2>&1; then
+	echo "FAIL: perf mem record"
+	cleanup
+	exit 1
+fi
+
+if ! perf annotate --code-with-type -i "$perfdata" --stdio \
+		--percent-limit 1 > "$perfout" 2>/dev/null; then
+	echo "FAIL: perf annotate"
+	cleanup
+	exit 1
+fi
+
+if ! grep -q "# data-type: struct conn" "$perfout"; then
+	echo "FAIL: global variable in .bss not resolved"
+	cleanup
+	exit 1
+fi
+
+echo "global variable resolved"
+cleanup
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 8c399840a735910d..bbd23dd7e0455a9d 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -272,6 +272,7 @@ DECLARE_WORKLOAD(context_switch_loop);
 DECLARE_WORKLOAD(deterministic);
 DECLARE_WORKLOAD(callchain);
 DECLARE_WORKLOAD(false_sharing);
+DECLARE_WORKLOAD(global_data);
 
 #ifdef HAVE_RUST_SUPPORT
 DECLARE_WORKLOAD(code_with_type);
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index 43cc4da6fb0786de..03017aaaaa0bec32 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -17,6 +17,7 @@ perf-test-y += context_switch_loop.o
 perf-test-y += deterministic.o
 perf-test-y += callchain.o
 perf-test-y += false_sharing.o
+perf-test-y += global_data.o
 
 ifeq ($(CONFIG_RUST_SUPPORT),y)
     perf-test-y += code_with_type.o
@@ -35,3 +36,4 @@ CFLAGS_deterministic.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_named_threads.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_callchain.o        = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_false_sharing.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
+CFLAGS_global_data.o      = -g -O0 -fno-inline -U_FORTIFY_SOURCE
diff --git a/tools/perf/tests/workloads/global_data.c b/tools/perf/tests/workloads/global_data.c
new file mode 100644
index 0000000000000000..63da5300c5d92387
--- /dev/null
+++ b/tools/perf/tests/workloads/global_data.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A zero initialized global struct, so it lands in .bss, past the file
+ * backed end of the last segment.  clang describes its address with
+ * DW_OP_addrx in DWARF 5, gcc with DW_OP_addr.
+ *
+ * 'perf mem record' of this workload followed by 'perf annotate
+ * --code-with-type' (see tests/shell/data_type_global.sh) resolves the
+ * accesses to struct conn.
+ */
+#include <signal.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <linux/compiler.h>
+#include "../tests.h"
+
+struct conn {
+	int saddr;
+	int daddr;
+	long bytes;
+};
+
+static volatile struct conn conn;
+static volatile unsigned long conn_sink;
+static volatile sig_atomic_t done;
+
+static void sighandler(int sig __maybe_unused)
+{
+	done = 1;
+}
+
+static int global_data(int argc, const char **argv)
+{
+	unsigned long sum = 0;
+	int i = 0;
+	int sec = 1;
+
+	if (argc > 0)
+		sec = atoi(argv[0]);
+
+	signal(SIGINT, sighandler);
+	signal(SIGALRM, sighandler);
+	alarm(sec);
+
+	while (!done) {
+		conn.saddr = i;
+		conn.daddr = i + 1;
+		sum += conn.bytes;
+		i++;
+	}
+	conn_sink = sum;
+	return 0;
+}
+
+DEFINE_WORKLOAD(global_data);
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index dd9c1d7b2da8be8a..d8d00646ef63b30f 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -140,6 +140,10 @@ static void pr_debug_location(Dwarf_Die *die, u64 pc, int reg)
 		case DW_OP_addr:
 			pr_info("address=%#lx\n", (long)ops->number);
 			break;
+		case DW_OP_addrx:
+		case DW_OP_GNU_addr_index:
+			pr_info("address index=%#lx\n", (long)ops->number);
+			break;
 		default:
 			pr_info("unknown: code=%#x, number=%#lx\n",
 				ops->atom, (long)ops->number);
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 48a11c95a67686e4..5db7458f01116a4e 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -14,6 +14,11 @@
 #include "strbuf.h"
 #include "string2.h"
 
+/* DWARF 5 address index, libdw's dwarf_getlocations() returns it unresolved */
+#ifndef DW_OP_addrx
+#define DW_OP_addrx 0xa1
+#endif
+
 /**
  * cu_find_realpath - Find the realpath of the target file
  * @cu_die: A DIE(dwarf information entry) of CU(compilation Unit)
@@ -1629,6 +1634,31 @@ Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
 	return result;
 }
 
+/*
+ * Get the absolute address of a location expression that consists of a
+ * single address, either DW_OP_addr or DW_OP_addrx.  libdw leaves the
+ * DWARF 5 address index unresolved, it has to be looked up in .debug_addr.
+ */
+static bool die_get_location_addr(Dwarf_Attribute *attr, Dwarf_Op *ops,
+				  Dwarf_Addr *addr)
+{
+	if (ops->atom == DW_OP_addr) {
+		*addr = ops->number;
+		return true;
+	}
+
+	if (ops->atom == DW_OP_addrx) {
+		Dwarf_Attribute addr_attr;
+
+		if (dwarf_getlocation_attr(attr, ops, &addr_attr) != 0)
+			return false;
+
+		return dwarf_formaddr(&addr_attr, addr) == 0;
+	}
+
+	return false;
+}
+
 /* Only checks direct child DIEs in the given scope */
 static int __die_find_var_addr_cb(Dwarf_Die *die_mem, void *arg)
 {
@@ -1647,11 +1677,13 @@ static int __die_find_var_addr_cb(Dwarf_Die *die_mem, void *arg)
 		return DIE_FIND_CB_SIBLING;
 
 	while ((off = dwarf_getlocations(&attr, off, &base, &start, &end, &ops, &nops)) > 0) {
-		if (ops->atom != DW_OP_addr)
+		Dwarf_Addr addr;
+
+		if (!die_get_location_addr(&attr, ops, &addr))
 			continue;
 
 		if (check_allowed_ops(ops, nops) &&
-		    match_var_offset(die_mem, data, data->addr, ops->number,
+		    match_var_offset(die_mem, data, data->addr, addr,
 				     /*is_pointer=*/false))
 			return DIE_FIND_CB_END;
 	}
@@ -1777,7 +1809,7 @@ static int __die_collect_global_vars_cb(Dwarf_Die *die_mem, void *arg)
 	Dwarf_Die type_die;
 	int tag = dwarf_tag(die_mem);
 	Dwarf_Attribute attr;
-	Dwarf_Addr base, start, end;
+	Dwarf_Addr base, start, end, addr;
 	Dwarf_Op *ops;
 	size_t nops;
 	struct die_var_type *vt;
@@ -1792,7 +1824,7 @@ static int __die_collect_global_vars_cb(Dwarf_Die *die_mem, void *arg)
 	if (dwarf_getlocations(&attr, 0, &base, &start, &end, &ops, &nops) <= 0)
 		return DIE_FIND_CB_SIBLING;
 
-	if (ops->atom != DW_OP_addr)
+	if (!die_get_location_addr(&attr, ops, &addr))
 		return DIE_FIND_CB_SIBLING;
 
 	if (!check_allowed_ops(ops, nops))
@@ -1808,7 +1840,7 @@ static int __die_collect_global_vars_cb(Dwarf_Die *die_mem, void *arg)
 	vt->die_off = dwarf_dieoffset(&type_die);
 	vt->die_tag = dwarf_tag(&type_die);
 	vt->from_alt = !die_same_file(die_mem, &type_die);
-	vt->addr = ops->number;
+	vt->addr = addr;
 	vt->end = 0;
 	vt->has_range = false;
 	vt->reg = -1;
-- 
2.56.0

