Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600543;
	b=PvsaTESXQeihrNhhtxtzSWk62X6jMcd40ilBaadyTLHPaHvWccBgN5jefUo0/0/HyIAM
	 40s45CHnhR9XgV6j5WQRUK067OrZwcxl/6uBu1wKFJHItGyWQSTSNt7O8wCHA6ZRPHqa+
	 6HB9WWDjpDFc8QMCm0qys/UTaBngRkvxSbebe9ANRyc0l58nEa0M2MO4+qAtmht+kbOM5
	 FuJzlCKHVQb/VMySi6ZaJpx87657cppIz9BP+g1SmUB5GSMCw/5zOAAvejPi7OZhpUsxx
	 VyxONH7Pl/7UTTBV37XbzlL4tQ16Nj8iyEo52PJSNlgY8iVr3+mg/wTInBOGAXbcG3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600543;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=W3ZRwmyeoSx2P6LJWkTE9jsMV9ncUeCi/EgPMhmK56w=;
	b=cmpCnZQB30lg/FWirMMDA31MMsHbevqA5b0Vn+u6caDi2mUmn9mkYrEz8tm+ub41Rwbw
	 7wphzBqFcZ9x9t+PZ8cL1kbsYJgl3Dh5KVSr48+KKFhYV2wmki64xK3IM2Smv8xBNJmld
	 nZcJPbzQLpVceovROb8yD60qbunsVtpPzXFEOTHLl/9MOL7ur49qIQ9MpN0hmu1QCHZKp
	 JvNrF6eyzCS45Wx4Qoc3KXm5WgW13GtVAsL/B+QtN5JAXHJxl+wwjCARENhtvJ+wrqwWJ
	 WddND5hMfGmlH/KrafJDRtpZqGzlQ3vVReJLiNE9tdABIMgb4jxsqwVCtcGW8W32ymw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PHeEh/lF";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FFB606A88F;
	Fri, 13 Nov 2026 20:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PHeEh/lF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADAB41F000C9;
	Fri, 13 Nov 2026 20:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600543;
	bh=W3ZRwmyeoSx2P6LJWkTE9jsMV9ncUeCi/EgPMhmK56w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PHeEh/lF+49moiwMlXdKgHAPQcUApJvpsLx0JAfxmD+PmzIXMAFJrA6dSC/ISfxRk
	 EQh3ps1nfgQ7bbzGJvD2l7eS0R44AZUBkoxKjO7ofAVfMUh9cMkV8oapfO61Z69uSX
	 F6t0SOLIlB/Kzjueb/e0fkBUAdS2y4a1Npmsfar0CY+QXMSceyKKGZEW3KVmHyY4mD
	 Vgpq0rNfr1osGBdiQgXAMFW7zHJYFRWBVIZGS+JrHFbb3EyKUyUs4zk8tU7n7ND3z3
	 JTB1ovnbKjFs7bcoHY2HAwcyqUYlTe4bMX4vHfBEvVcyZDhzN6Vbv97gAwx/5xG2RK
	 qeUiJf1MjQtiQ==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 02/11] perf annotate-data: Resolve DW_OP_addrx global variables
Date: Fri, 13 Nov 2026 17:08:40 -0300
Message-ID: <20261113200850.2803460-3-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113200850.2803460-1-acme@kernel.org>
References: <20261113200850.2803460-1-acme@kernel.org>
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

From: Arnaldo Carvalho de Melo <acme@redhat.com>

clang emits DW_AT_location with DW_OP_addrx for global variables in
DWARF 5, gcc emits DW_OP_addr.  The address index was not resolved, so
those variables were not found by address; the by-name fallback also
missed the ones in .bss past the file backed end of the last segment.

Resolve the index with dwarf_getlocation_attr() + dwarf_formaddr() and
use the resulting address in the by-address lookup and in the global
variable cache.  Add a test that compiles the workload with clang
-gdwarf-5 and checks that the global is annotated.

Fixes: d60469d7c0e5c4e8 ("perf dwarf-aux: Add die_find_variable_by_addr()")
Fixes: d7b60803a790b716 ("perf dwarf-aux: Add die_collect_global_vars()")
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../tests/shell/data_type_profiling_clang.sh  | 108 ++++++++++++++++++
 tools/perf/util/dwarf-aux.c                   |  42 ++++++-
 2 files changed, 145 insertions(+), 5 deletions(-)
 create mode 100755 tools/perf/tests/shell/data_type_profiling_clang.sh

diff --git a/tools/perf/tests/shell/data_type_profiling_clang.sh b/tools/perf/tests/shell/data_type_profiling_clang.sh
new file mode 100755
index 0000000000000000..8e425952d4742a2c
--- /dev/null
+++ b/tools/perf/tests/shell/data_type_profiling_clang.sh
@@ -0,0 +1,108 @@
+#!/bin/bash
+# perf data type profiling tests with clang DWARF 5
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+# clang describes the location of globals with DW_OP_addrx where gcc
+# uses DW_OP_addr, so the workload has to be built here to get that
+# encoding.
+
+command -v clang > /dev/null || exit 2
+
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+perfout=$(mktemp /tmp/__perf_test.perf.out.XXXXX)
+prog=$(mktemp /tmp/__perf_test.clang.XXXXX)
+src="${prog}.c"
+
+cleanup()
+{
+	rm -f "$perfdata" "$perfout" "$prog" "$src"
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
+cat > "$src" <<'EOF'
+#include <signal.h>
+#include <unistd.h>
+
+struct conn {
+	int saddr;
+	int daddr;
+	long bytes;
+};
+
+static volatile struct conn conn;
+static volatile sig_atomic_t done;
+
+static void stop(int sig)
+{
+	done = 1;
+}
+
+int main(void)
+{
+	unsigned long sum = 0;
+	int i = 0;
+
+	signal(SIGALRM, stop);
+	alarm(1);
+
+	while (!done) {
+		conn.saddr = i;
+		conn.daddr = i + 1;
+		sum += conn.bytes;
+		i++;
+	}
+	return sum != 0;
+}
+EOF
+
+# -fPIE keeps the accesses PC-relative on x86_64, the operand form the
+# data type resolver handles.
+if ! clang -O0 -gdwarf-5 -fPIE -pie -o "$prog" "$src"; then
+	echo "Skip: cannot build the workload with clang"
+	cleanup
+	exit 2
+fi
+
+if ! perf mem record -o "$perfdata" -- "$prog" > /dev/null 2>&1; then
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
+	echo "FAIL: struct conn not resolved, DW_OP_addrx not handled?"
+	cleanup
+	exit 1
+fi
+
+echo "DW_OP_addrx global resolved"
+cleanup
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

