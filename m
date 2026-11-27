Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795743552;
	b=I7iaHNAUnD1DF+cMoHjjLiISqmrA27NtWQMNZzzVBe6lRmWXeimzbloNdZlANYbdPnbk
	 TyRrh7lKzH1TFsczf83A89GKh/rx7clmRZqiEZZjjjLfagtNXDJT75nt0h3rYDKmpbkoE
	 pA1fw2BTP+wRSkq1K1BFx0J8sjiukezLEhBvjIrBpKwm96r3hv/R7B5I70IUyltWyPoY4
	 Jfewym4Vg+lvCHlIlLXs1/L7joF8ZOTiQOnCnqjiZJsEIgIZM3oFF85Ai7QLcfh15WQde
	 APYJHa4RRG7HqkDKOJi7D6A829JkwU0XoMxN/9E5rEf+7g0K9uUdmzVG02+xAALDmqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795743552;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fKXJvfCDBO7ruc1QH74xpnA7D+7y5u6KjAfV3mv542k=;
	b=X/kYIeY72/mr39BFvIjXYQfOMofqzAsHLMQFUKpec8jddWJWcVxVcguRFVmHVXtjs4HM
	 yp4qGsYXL5zpRG448ozEW2p4DKyxDgTlPkxPWYslg7I9z2GD4Yo6AfOw+76VDG8G0zJAb
	 ZbIM6CQ2r+xcAmY1qfFtYT3hzHUQ2pgaQlYEYVtE3uiDv6nSwsjvKU5GPKQ9F/HgJBebK
	 LpzkcVM6IttbH2yarZ3QxTSbEBreWbZcSmT5pOBjzlsqWEVL9QYbmVvOHyixDhn2q6Ybu
	 bLmsRxxon5YfzqnBJmZl8eSxZL05I3mWWYD5qNem9efzzr0uqTAEsaTbgSV9v88Oo+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxWjpjbh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20428606A31E
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 01:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxWjpjbh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C672A1F0089B;
	Fri, 27 Nov 2026 01:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795743551;
	bh=fKXJvfCDBO7ruc1QH74xpnA7D+7y5u6KjAfV3mv542k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bxWjpjbhqq9DzJB0phQcAvE+ERI4SWTA0H+39Iwx8XuH0tl11dejKC4TqvqyOjqAp
	 fxRtFqhedx0sK4miwhLAc7KskiTWnitl9ziOeS8/MtyDH6LtmQH4uQbnDpsmGHg8ei
	 obiwSOJSQm3ywjrK2wIqJj3E/eQTeNIgiXdFbX8MwUWErUlQJ/qW3yrCDb2r6v/dzt
	 lWx4yMHZw7v3lKV1sVVFNV+P+UCFJGE7lklQJaqJsYu7mwpdK2tPczRlgjtzVa9g1x
	 jY+jqkbU+EP8i6ybxtp1+NRkyluBuhdhPBrv4LtZOBdV8JbL8exJ6HYeYjXZpc0utW
	 sA3PBAkeaYT/g==
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
Subject: [PATCH v2 17/18] perf tests probe: Exercise the variable and line listing
Date: Thu, 26 Nov 2026 22:38:00 -0300
Message-ID: <20261127013801.14841-18-acme@kernel.org>
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

Show the variables, source lines and probe-able functions of a kernel
function, and check the missing argument error.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/probe_vars.sh | 87 ++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100755 tools/perf/tests/shell/probe_vars.sh

diff --git a/tools/perf/tests/shell/probe_vars.sh b/tools/perf/tests/shell/probe_vars.sh
new file mode 100755
index 0000000000000000..bacf055d84bd92cb
--- /dev/null
+++ b/tools/perf/tests/shell/probe_vars.sh
@@ -0,0 +1,87 @@
+#!/bin/bash
+# perf probe variable and line listing tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+. "$(dirname $0)"/lib/probe.sh
+
+skip_if_no_perf_probe || exit 2
+
+err=0
+out=$(mktemp /tmp/__perf_test_probe_vars.out.XXXXX)
+
+cleanup() {
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
+run_probe() {
+	local desc="$1" expect="$2"
+
+	shift 2
+	echo "Probe ${desc}"
+	if ! perf probe "$@" > "${out}" 2>&1; then
+		echo "Probe ${desc} [Failed: perf probe failed]"
+		cat "${out}"
+		err=1
+		return
+	fi
+	if [ -n "${expect}" ] && ! grep -q "${expect}" "${out}"; then
+		echo "Probe ${desc} [Failed: missing '${expect}']"
+		cat "${out}"
+		err=1
+		return
+	fi
+	echo "Probe ${desc} [Success]"
+}
+
+# The variable and line listings need debug info, skip when the kernel
+# was built without it.
+if ! perf probe -V schedule > "${out}" 2>&1; then
+	echo "Probe variable listing [Skipped: no debug info for schedule]"
+	cleanup
+	exit 2
+fi
+
+run_probe "vars" "Available variables at schedule" -V schedule
+run_probe "vars long option" "Available variables at schedule" --vars schedule
+run_probe "vars offset" "Available variables at schedule" -V schedule+0
+
+# -V only reads DWARF, while -L also opens the C source file at the path
+# recorded in the debug info, which may not be installed.
+if perf probe -L schedule > "${out}" 2>&1; then
+	run_probe "line" "schedule" -L schedule
+	run_probe "line long option" "schedule" --line schedule
+else
+	echo "Probe line listing [Skipped: no kernel source for schedule]"
+fi
+
+if [ "$(id -u)" = 0 ]; then
+	run_probe "funcs" "schedule" --funcs
+	run_probe "funcs filter" "schedule" --funcs "sched*"
+else
+	echo "Probe funcs [Skipped: needs root to read the kernel symbols]"
+fi
+
+echo "Probe missing add argument"
+if perf probe -a > "${out}" 2>&1; then
+	echo "Probe missing add argument [Failed: accepted no argument]"
+	err=1
+else
+	if ! grep -q "Usage:" "${out}"; then
+		echo "Probe missing add argument [Failed: missing usage]"
+		err=1
+	fi
+fi
+
+cleanup
+exit $err
-- 
2.56.0

