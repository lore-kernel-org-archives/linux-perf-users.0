Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795743541;
	b=gxADLPZ5IUimbIY/TruH7p4Swq6zDYJstcM4t3lFZ3GkDgbihnHaL8kNCX4T0CpmBqrk
	 UBw1BjD9yfLe75FZ6i8+zOpdXIRexCk09fNRIdX30l40FQNaX4KFSEqWTZzUfKXL2Vd7C
	 w0pzUD/02gAfB9B1tkxZoeYhpc+Z/9YfrpMtSVacJ82+u+ixdXsNXxzJbZbFYXD43lqfL
	 rTQXlOz+CJKUjb5pAL4O09SMjKY6xDvOnO/A+9CgYb5fMR3XEJyAxJ7bWLae19StNduhc
	 1uZgNomtDwZmDYEqZZ42ZsvNGAYBLLtufp3f9wkuATegeYtBJ07sNRtZMdQqCCgSKLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795743541;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=18P4UZhgtKtJUki+IsA5FD0ygckA34Mg1yHBZZTxTgM=;
	b=kOb6RTjsuSsvaBR5xKV5YdvY/bXxN53ApyR/k8ktEvtFbk4P1VQtNQVK3BHt/Xy8fF7k
	 /w202AuTwSGPoYAE9leFVp3dEhLSQo1ryBVLbMF9k5Mj+PlQnQ1xpPtyuQewOpz2qXrge
	 psa7yMYMJ/PxLcJ3I/vY0SURT1eCsGe1pGsSJCJVS40Xag3zMzeeaNvYMeI8PDOQsu55X
	 aHnda5rBIc+QKkPN8Eb7I1Jj2UrwA/u6Zpc6i6PhsD00+lH12AAyR8ftNFCwefImKWJCy
	 3YMcsFiSyJhZqmvFzXaJsM8/8JbhJSIX0cklu473JmUsbio6TJ/dmrUA1ao9SuF4MwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XnbqhNaJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D85E606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 01:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XnbqhNaJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C71B1F00897;
	Fri, 27 Nov 2026 01:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795743540;
	bh=18P4UZhgtKtJUki+IsA5FD0ygckA34Mg1yHBZZTxTgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XnbqhNaJRTRGZSyRb+SyIj4xsQEbVOtySzozd7Sj1snJgN3M0ay6dlroyWtiNrFc5
	 8lT63fQ0LVPtqxcql65LZq44qMGpXElhsTfpji+TSj7P+4cMz4T6s0gv93iq9eDo9F
	 ft76bwyyce7hfHHU0UoAy0uLCAXLS1JHnn26NRUVFQ5KQesw1MIO9xRRE4hyU4w0kB
	 p6y39Hm92eNmLWYSEpKecaKezjzq5D77BAMq2nDld7aavPFfckB05pNDwsRgrjOvA1
	 7JB5Wt4oonWaxLlnEsak4N96JWdmBMP4As7wCoO+/9BYWvAbfdZ3Hy+MaIM07B7Q/l
	 nnVZCyHiq2j7g==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 14/18] perf tests kmem: Add a basic perf kmem test
Date: Thu, 26 Nov 2026 22:37:57 -0300
Message-ID: <20261127013801.14841-15-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127013801.14841-1-acme@kernel.org>
References: <20261127013801.14841-1-acme@kernel.org>
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

Exercise the slab and page allocators, their sort, caller and
allocation views, the live page stats and the time filter.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/kmem.sh | 222 +++++++++++++++++++++++++++++++++
 1 file changed, 222 insertions(+)
 create mode 100755 tools/perf/tests/shell/kmem.sh

diff --git a/tools/perf/tests/shell/kmem.sh b/tools/perf/tests/shell/kmem.sh
new file mode 100755
index 0000000000000000..196f1a723930161b
--- /dev/null
+++ b/tools/perf/tests/shell/kmem.sh
@@ -0,0 +1,222 @@
+#!/bin/bash
+# perf kmem tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+# Root permissions required for tracing events.
+if [ "$(id -u)" != 0 ]; then
+	echo "[Skip] No root permission"
+	exit 2
+fi
+
+# Without libtraceevent cmd_kmem is a stub that fails instead of
+# reporting the tracepoints below as unavailable.
+if ! perf check feature -q libtraceevent; then
+	echo "[Skip] No libtraceevent support"
+	exit 2
+fi
+
+if [ ! -e /sys/kernel/tracing/events/kmem/kmalloc ] &&
+   [ ! -e /sys/kernel/debug/tracing/events/kmem/kmalloc ]; then
+	echo "[Skip] No kmem tracepoints"
+	exit 2
+fi
+
+err=0
+slabdata=$(mktemp /tmp/__perf_test_kmem.slab.XXXXX)
+pagedata=$(mktemp /tmp/__perf_test_kmem.page.XXXXX)
+out=$(mktemp /tmp/__perf_test_kmem.out.XXXXX)
+
+cleanup() {
+	rm -f "${slabdata}" "${slabdata}".old
+	rm -f "${pagedata}" "${pagedata}".old
+	rm -f "${out}"
+
+	trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+	echo "Unexpected signal in ${FUNCNAME[1]}"
+	cleanup
+	exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+fail() {
+	echo "$1 [Failed: $2]"
+	cat "${out}"
+	err=1
+}
+
+test_kmem_record() {
+	echo "Kmem record"
+	perf kmem record -o "${slabdata}" -- sleep 1
+	echo "Kmem record [Success]"
+}
+
+test_kmem_slab_stat() {
+	echo "Kmem slab stat"
+	if ! perf kmem -i "${slabdata}" stat > "${out}" 2>&1; then
+		fail "Kmem slab stat" "perf kmem stat failed"
+		return
+	fi
+	if ! grep -q "SUMMARY (SLAB allocator)" "${out}"; then
+		fail "Kmem slab stat" "missing summary"
+		return
+	fi
+	echo "Kmem slab stat [Success]"
+}
+
+test_kmem_slab_stat_options() {
+	echo "Kmem slab stat options"
+	if ! perf kmem -i "${slabdata}" --sort hit,bytes --line 5 stat > "${out}" 2>&1; then
+		fail "Kmem slab stat options" "perf kmem stat failed"
+		return
+	fi
+	if ! grep -q "SUMMARY (SLAB allocator)" "${out}"; then
+		fail "Kmem slab stat options" "missing summary"
+		return
+	fi
+	echo "Kmem slab stat options [Success]"
+}
+
+test_kmem_page_record() {
+	echo "Kmem page record"
+	perf kmem --page record -c 1000 -o "${pagedata}" -- sleep 1
+	echo "Kmem page record [Success]"
+}
+
+test_kmem_page_stat() {
+	echo "Kmem page stat"
+	if ! perf kmem --page -i "${pagedata}" stat > "${out}" 2>&1; then
+		fail "Kmem page stat" "perf kmem stat failed"
+		return
+	fi
+	if ! grep -q "SUMMARY (page allocator)" "${out}"; then
+		fail "Kmem page stat" "missing summary"
+		return
+	fi
+	echo "Kmem page stat [Success]"
+}
+
+test_kmem_page_stat_options() {
+	echo "Kmem page stat options"
+	if ! perf kmem --page -i "${pagedata}" --sort order,gfp --line 5 stat > "${out}" 2>&1; then
+		fail "Kmem page stat options" "perf kmem stat failed"
+		return
+	fi
+	if ! grep -q "SUMMARY (page allocator)" "${out}"; then
+		fail "Kmem page stat options" "missing summary"
+		return
+	fi
+	echo "Kmem page stat options [Success]"
+}
+
+test_kmem_slab_alloc() {
+	echo "Kmem slab alloc stats"
+	if ! perf kmem -i "${slabdata}" --alloc --sort bytes --line 5 stat > "${out}" 2>&1; then
+		fail "Kmem slab alloc stats" "perf kmem stat failed"
+		return
+	fi
+	if ! grep -q "SUMMARY (SLAB allocator)" "${out}"; then
+		fail "Kmem slab alloc stats" "missing summary"
+		return
+	fi
+	echo "Kmem slab alloc stats [Success]"
+}
+
+test_kmem_page_caller() {
+	echo "Kmem page caller stats"
+	if ! perf kmem --page -i "${pagedata}" --caller --sort bytes --line 5 stat > "${out}" 2>&1; then
+		fail "Kmem page caller stats" "perf kmem stat failed"
+		return
+	fi
+	if ! grep -q "SUMMARY (page allocator)" "${out}"; then
+		fail "Kmem page caller stats" "missing summary"
+		return
+	fi
+	echo "Kmem page caller stats [Success]"
+}
+
+test_kmem_page_caller_raw() {
+	echo "Kmem page caller raw ip stats"
+	if ! perf kmem --page -i "${pagedata}" --caller --raw-ip --sort callsite --line 5 stat > "${out}" 2>&1; then
+		fail "Kmem page caller raw ip stats" "perf kmem stat failed"
+		return
+	fi
+	if ! grep -q "SUMMARY (page allocator)" "${out}"; then
+		fail "Kmem page caller raw ip stats" "missing summary"
+		return
+	fi
+	echo "Kmem page caller raw ip stats [Success]"
+}
+
+test_kmem_page_alloc() {
+	echo "Kmem page alloc stats"
+	if ! perf kmem --page -i "${pagedata}" --alloc --sort bytes --line 5 stat > "${out}" 2>&1; then
+		fail "Kmem page alloc stats" "perf kmem stat failed"
+		return
+	fi
+	if ! grep -q "SUMMARY (page allocator)" "${out}"; then
+		fail "Kmem page alloc stats" "missing summary"
+		return
+	fi
+	echo "Kmem page alloc stats [Success]"
+}
+
+test_kmem_page_live() {
+	echo "Kmem page live stats"
+	if ! perf kmem --page --live -i "${pagedata}" --sort page --line 5 stat > "${out}" 2>&1; then
+		fail "Kmem page live stats" "perf kmem stat failed"
+		return
+	fi
+	if ! grep -q "SUMMARY (page allocator)" "${out}"; then
+		fail "Kmem page live stats" "missing summary"
+		return
+	fi
+	echo "Kmem page live stats [Success]"
+}
+
+test_kmem_slab_caller() {
+	echo "Kmem slab caller stats"
+	if ! perf kmem -i "${slabdata}" --caller --sort callsite --line 5 stat > "${out}" 2>&1; then
+		fail "Kmem slab caller stats" "perf kmem stat failed"
+		return
+	fi
+	if ! grep -q "SUMMARY (SLAB allocator)" "${out}"; then
+		fail "Kmem slab caller stats" "missing summary"
+		return
+	fi
+	echo "Kmem slab caller stats [Success]"
+}
+
+test_kmem_time_filter() {
+	echo "Kmem time filter"
+	if ! perf kmem -i "${slabdata}" --time 0, stat > "${out}" 2>&1; then
+		fail "Kmem time filter" "perf kmem stat failed"
+		return
+	fi
+	if ! grep -q "SUMMARY (SLAB allocator)" "${out}"; then
+		fail "Kmem time filter" "missing summary"
+		return
+	fi
+	echo "Kmem time filter [Success]"
+}
+
+test_kmem_record
+test_kmem_slab_stat
+test_kmem_slab_stat_options
+test_kmem_slab_alloc
+test_kmem_slab_caller
+test_kmem_time_filter
+test_kmem_page_record
+test_kmem_page_stat
+test_kmem_page_stat_options
+test_kmem_page_caller
+test_kmem_page_caller_raw
+test_kmem_page_alloc
+test_kmem_page_live
+
+cleanup
+exit $err
-- 
2.56.0

