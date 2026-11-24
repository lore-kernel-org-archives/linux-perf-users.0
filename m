Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795545993;
	b=qyEW2IMbZAM6zSu4IupsofhaKt3kBZAJfe7dfTluA2DGe5+Mokwgehv+bF+h2Z8iD0Ii
	 XqmiKhmGQutULaIeVbo1UD+JjXgI4uFwPed4RS2eoZcu9vKnvK67PMFSTo2LrkC6QS2xX
	 waOgmjvVYhh4CRwDoHVunEO4ZUZvySnl1fTs1VgU0HQVLqrFzJfLZzIvHmGkBGRJJrH1c
	 5ABzg5UYpVUggZ/2YsxR9KJEJs+8W0TrrWldO5lwplarPiD+cIOAgm3gMJ2vYaS718Xof
	 +JqKAgoo0AQPC2Q+BgaVtpl2Uq3EvcuEwiSvj7Ifc8XZ9D+vfov8qBEoQ+KOHpvX+bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795545993;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zxf7yuG/32ECs6I6CfKboQ68QJSMItcbsedlvpzxchs=;
	b=UKxhNr+RfW34Yf50Fk0L3KDiINgFxq6o7TWTzgjMayycPQFSiNxL1mGswNbJt2RfVKTM
	 1Hf+I2PY8BPSwg6QPBauSwR4WYJkADaLqY1Kkha5GSmZOsx0Q9gVYQ5vi/oKYDLkIvvuk
	 DS7KG7eOGrZtP6FwpjKGwpvoQr0Wqh7IXdINmbb3WRIutJEu8u9CwQXoHrO9jUAp7EB+j
	 QNHUkevlk7b+/0WQEj1VXWv4HF3YYcMV4eVG5WWn7VpbT3+twezf5mmCsHbeaX6thFsmy
	 ZOXJtqz0TRDeMJr1uWULTIrV5Vp7MGcpjMyQXMNp/OMlp/ch6AQcU8lt/eFc6bEzV1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yroafgjl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C06F606A31E;
	Tue, 24 Nov 2026 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yroafgjl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BEF1F000D4;
	Tue, 24 Nov 2026 18:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795545993;
	bh=zxf7yuG/32ECs6I6CfKboQ68QJSMItcbsedlvpzxchs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YroafgjldIwxtCFbMD4T9bgizrvseaobm4dh/yy1cB8sLKSLC6jwfsGMQcT1beUWA
	 6+tsmWyTklJa95MiyDrHPSxSTMFFpOmxdrgu0ur2iJP6DYn499gILz2WGXhU/tqQ6v
	 +dyJrROMAnAN+7FZ8yQlZmZl0x8GFAvnhfgr3hSjUfNopXy0quO8HudHTnSq/UaTu+
	 8LljAVc0VZBfMMl5qrO9v54BtalULcJ2oSJKVR1/mPaa1k5+hLPqoPybTq24iNQUnd
	 /uvUUsFYISfrZwa8zRHkphDQKyEJYDjbwHVZ1vQLQ+t3h6AIfcTVN5lnmx4S2Ek5zz
	 NSp8nR4UNkGgw==
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
Subject: [PATCH v1 06/17] perf tests sort: Exercise the report and diff sort keys
Date: Tue, 24 Nov 2026 15:45:53 -0300
Message-ID: <20261124184604.24983-7-acme@kernel.org>
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

Record a workload and report it sorted by the common keys, then diff
the file against itself with the same keys, checking that the workload
symbol still shows up.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/sort.sh | 72 ++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100755 tools/perf/tests/shell/sort.sh

diff --git a/tools/perf/tests/shell/sort.sh b/tools/perf/tests/shell/sort.sh
new file mode 100755
index 0000000000000000..19f42ded2b895317
--- /dev/null
+++ b/tools/perf/tests/shell/sort.sh
@@ -0,0 +1,72 @@
+#!/bin/bash
+# perf report and diff sort key tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+shelldir=$(dirname "$0")
+# shellcheck source=lib/perf_has_symbol.sh
+. "${shelldir}"/lib/perf_has_symbol.sh
+
+testprog="perf test -w thloop"
+testsym="test_loop"
+sort_keys="pid,comm,dso,symbol,cpu,srcline,period,time,socket,weight,transaction,type,srcfile,cgroup"
+
+skip_test_missing_symbol "${testsym}"
+
+perfdata=$(mktemp /tmp/__perf_test_sort.perf.data.XXXXX)
+out=$(mktemp /tmp/__perf_test_sort.out.XXXXX)
+err=0
+
+cleanup() {
+	rm -f "${perfdata}" "${perfdata}".old
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
+test_report_sort() {
+	echo "perf report sort keys test"
+	perf record -o "${perfdata}" --sample-cpu ${testprog}
+	if ! perf report -i "${perfdata}" --stdio -q -s "${sort_keys}" > "${out}" 2>&1; then
+		echo "perf report sort keys test [Failed: perf report failed]"
+		cat "${out}"
+		err=1
+		return
+	fi
+	if ! grep -q "${testsym}" "${out}"; then
+		echo "perf report sort keys test [Failed missing ${testsym}]"
+		err=1
+		return
+	fi
+	echo "perf report sort keys test [Success]"
+}
+
+test_diff_sort() {
+	echo "perf diff sort keys test"
+	if ! perf diff -s "${sort_keys}" "${perfdata}" "${perfdata}" > "${out}" 2>&1; then
+		echo "perf diff sort keys test [Failed: perf diff failed]"
+		cat "${out}"
+		err=1
+		return
+	fi
+	if ! grep -q "${testsym}" "${out}"; then
+		echo "perf diff sort keys test [Failed missing ${testsym}]"
+		err=1
+		return
+	fi
+	echo "perf diff sort keys test [Success]"
+}
+
+test_report_sort
+test_diff_sort
+
+cleanup
+exit $err
-- 
2.56.0

