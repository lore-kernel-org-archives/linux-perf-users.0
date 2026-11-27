Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795743517;
	b=OpEtkPGy5djS4GD6rlne/Uu9kkezSxnQMk2BGoAeInPbqTfgzCYky6ZzHRtY2/BYolUb
	 f7vZnb/QPmDaKiuwGtA/XabMmIXMLdqw+4dgrdnzoGNSvRdaeVOCILIAYtOgXzRYSegfR
	 ymRRVhLQIlzYqeymRO5otP8cPiCG1kTaDRu62Lf/M3uMvVfiesp2O3fjt2zZQr9SEqfzs
	 032mC3q76rIYCZrdjFnWB7xMpM1nD2tdboEUCYplqKpBksSqJcU6XICZJcfAB3EFkYpQ3
	 B7QDOkY1eNhY7/ihHK1JIbv/CpBJ0qIa/k7wTfZC+cfPWQ7n7HqlkgDgKkp1ykQMbzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795743517;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BbadLLGfGSDUCv2OVLyxa3dTZ2tCp8g6kSw/c36a5Dg=;
	b=RMPLrH0iMegn1xdQZp5g+xchi4fNU/QprjDKi8AEjvLCf1/WTniyAKzxONZGUt8Hffaa
	 miUqtNXI+ojKNaw+anSkyVO6Iu6g9CElMs8ay0geimhvuQUYhgq2pLHy5uHdiumL7kCOs
	 BRxiLaTkBf1GjzJlUtcJJuJH974W9B3dv3bKDl1ve9Mx59CSjvb64smWAe47fmArm/qvn
	 C1aoleWll1a03cNSq2FZJKgBU5ehfYj5mvM3IpjniPBOxCvI2/2TgzWJisfR8bnmaV+wS
	 ozc21PZYkp2JGCkJ73WmVF2qZff5KQeJPn9OwoKYzxZIWmegUFUmB0QD/nvFzGezptA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pzv6XHTe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAE7606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 01:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pzv6XHTe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227A71F0089F;
	Fri, 27 Nov 2026 01:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795743517;
	bh=BbadLLGfGSDUCv2OVLyxa3dTZ2tCp8g6kSw/c36a5Dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pzv6XHTeArmm8nDLbm4MwSjSkZ12Bf6yRo981bCx3x/bBafmK4RwHhtIAXRfqD5AR
	 W6gKjUwMT0q4k7kqOK2xaI+52jt1pKBSaHmpoIeuuqV0x3xPn40LtgDl5brT6cnLBT
	 jr1IjC2LHYgdAAFxxiaQTk2YNN2PRD5wo7tFz9urNUCBNOEhG3EDcWuv/pAq60j2XN
	 JRNhhhzi6LydEqhRU6hEoX2ErMs9YCovm3jCC+ibJ7cw+iYOrpAZhjYKn46FJ0JRf6
	 3gM477HD/3GrtdRPSejVaO6UR4SsRuSoq8SLKxvIPJSoChN5HsX9NRQ2o+R/+7yoh8
	 7yQxxdcg2glrA==
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
Subject: [PATCH v2 07/18] perf tests sort: Exercise the report and diff sort keys
Date: Thu, 26 Nov 2026 22:37:50 -0300
Message-ID: <20261127013801.14841-8-acme@kernel.org>
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

Record a workload and report it sorted by the common keys, then diff
the file against itself with the same keys, checking that the workload
symbol still shows up.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/sort.sh | 77 ++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100755 tools/perf/tests/shell/sort.sh

diff --git a/tools/perf/tests/shell/sort.sh b/tools/perf/tests/shell/sort.sh
new file mode 100755
index 0000000000000000..12dbdbc1edfd0045
--- /dev/null
+++ b/tools/perf/tests/shell/sort.sh
@@ -0,0 +1,77 @@
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
+sort_keys="pid,comm,dso,symbol,cpu,srcline,period,time,socket,weight,transaction,srcfile,cgroup"
+# The "type" sort key turns on data type profiling, which perf rejects
+# outright when built without DWARF support.
+if perf check feature -q dwarf; then
+	sort_keys="${sort_keys},type"
+fi
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

