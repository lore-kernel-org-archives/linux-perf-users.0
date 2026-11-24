Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546018;
	b=eECwy2k9aBmfFbq5uFSEVvcjW6Vv+GX+aLfslsLA/nYu+5N9VJ2skcefOhn77R1jsKe8
	 0aRbWR6fSc8Fiagw4Cj+iMBDz5XHa9lelxdI7x5a6JvelKGljmE6V0HFYofvw6rHzAd4f
	 r8Ke1PI/3gvawtG6PGhr8q/AD72aV1+ujkEUAaqVo0ZHuhLX9twz4BwFrImF5OQQl6+BO
	 rZLQ5lU+sNgXi5RCtAVh3VJo4cJ1d9LdmLFh26pA0ydBR8Qmvi/x1jtkpePnatW1NnvU8
	 ojZ1lYTCSyNvv6T/Y+D2hAUsl1XApuyJHen0dTH4VgQpUKzCAdgvNCJE3J5qxfH4JLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546018;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gKD2HkOoh61vJCND6jeEnkJckojhoM+4u+QYcPLXs8Y=;
	b=UOsxks/j++Nn7qQ03NoiFojcUpTBKBMw09gQK4wxpT190w4pF+OAtb7gD9WTM/8KSGLA
	 QzHFXnhJVwlPxK+R2IxRX+cvUya3ptpoZKA7vMsBfWsI2cfzGNQE5OYwEKryo995Pkvm0
	 N5scgmGPZzGpF9YN/cIRiQHTpRoHbgtJMG02KbvyhyDSr4iQJhIYfEsXRAX79qd2Mfyfj
	 aFUDC2VwaG7V77EzivUVRk96xZr/+QFC8HSLYeavn2fcavPVw0qKsdYjJRJ992DR+RfEV
	 qKf4igBo7l4JaCAkwBFGpwFoDvZ2YONInIFcVE0beTW8q08akvnXIH1iHRCxDb+q01w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RzHzv1bf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93C5606A31E;
	Tue, 24 Nov 2026 18:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RzHzv1bf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28611F000E1;
	Tue, 24 Nov 2026 18:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795546017;
	bh=gKD2HkOoh61vJCND6jeEnkJckojhoM+4u+QYcPLXs8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RzHzv1bfdT7fMNGHBg+nt4+Lkvd45dy1IZUGYmdNThIPjfCCbRJK5DfZ51ujzdYv3
	 2KZnSYGl+avR07DsD95jOLMYCyPpiCxoXlyEe6bdU2BivEUjmajPWYnOcZuefak9uK
	 zlNuN5yU6Jm8wSCo6KAx0m6ZYIk/3Xy4PJnmnMEkNWB3ZTVtYy/rspB4T5J8undGd+
	 hULGqXOH50ONZ6qSHgAnHnmIw5CNSiTR1l+s57nDGL4JPqUszwoBO/wcQ9D6tP4DAD
	 j+u+Fqs73vUQTPDb0Ahv0/iidCsLOxIpF31+Ex2eTR7mjxzDyuhevIY0Y2aa/ni3wa
	 eGhQhge5HT0NA==
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
Subject: [PATCH v1 13/17] perf tests kmem: Add a basic perf kmem test
Date: Tue, 24 Nov 2026 15:46:00 -0300
Message-ID: <20261124184604.24983-14-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124184604.24983-1-acme@kernel.org>
References: <20261124184604.24983-1-acme@kernel.org>
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
 tools/perf/tests/shell/kmem.sh | 215 +++++++++++++++++++++++++++++++++
 1 file changed, 215 insertions(+)
 create mode 100755 tools/perf/tests/shell/kmem.sh

diff --git a/tools/perf/tests/shell/kmem.sh b/tools/perf/tests/shell/kmem.sh
new file mode 100755
index 0000000000000000..c1eda5b2261f77ec
--- /dev/null
+++ b/tools/perf/tests/shell/kmem.sh
@@ -0,0 +1,215 @@
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

