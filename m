Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546028;
	b=OeLC7jnE8+VcEmS7yADJAqmq3pRNzOvmB0PGioD9YVJ0d5F0w3TIn82QlKg+rnfRhvwR
	 GqkUP2ailYRhMBYbOenl0ur7gzzH6NeMviSkUDALDu/b9d8fHkwydANaJNRyRNYm/z7Qf
	 uyzMEpYv4w9rgj3dlNJFi6IVpGciDG2CqxmV01uvBpXpX4A8WWk4PVtUoz6sZHlNj6LCs
	 Z7Oqk76QU6niT5ngGPlSicf2nIMkpiXUYYIHIjOf54SzB22J+rB0Le+8jWmuAu7mcYzlR
	 lY2HhQKtuqND/HEw+9F22XUhUM4p9v3BXU0byIM2F0m/5EefuzthFKttLeXd9POmoLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546028;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WsHZ5eb0Yw7l0zlODkEZR0xt0Wth70zsrzuiAwMKuEE=;
	b=JnPbvrw/uiuVGwvl4yf8ZDTZVJEZyJti627syAJAKAT+7V8VGIxUruTv0HINdW81b3x5
	 VRQEKnLhc0XP5Zmvl8Mrc5Mr//L0Kv1J0amTYQl3XnbpLsDr6WStIkf8LZVS+odltO3a1
	 xjIFO9G/0dTnizh3tXjRUWN8y3s/WyLiiJmGvInXuD2YdYpXdzUvzqsfIg6SeVcA4wRdq
	 j3Vc1jFMpedRsPs7q5eIUyAtpJl+Sz2zzjQdFxXFZP7fDqI6Y5mGHjSMSTt65r7ClJMeO
	 62dbzIX3ULpZjrBgzHIPRFFMsTi7IVIVR86Oo6o8/c174I5G0Onxx3dF6aK/y+P7MdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cvYNt1m0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2849606A321;
	Tue, 24 Nov 2026 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cvYNt1m0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840BC1F000C4;
	Tue, 24 Nov 2026 18:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795546028;
	bh=WsHZ5eb0Yw7l0zlODkEZR0xt0Wth70zsrzuiAwMKuEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cvYNt1m05N6eA0byMzEhuYccKhBkvxboYxesXcWp01CB1EArI1uT5S553kQYQx/ED
	 /BRGme80duWwKW0QjOm1R48eb6sS7tqeSVeSX3XMfTa/dEfahCSjXEM0qacD4YudwM
	 eUaoBen+/lQm+HUasYK3HfNVn2t0oevf+uiCncREh6vQb6dyu082G9p3RgHKtvNEry
	 iQoaNidAp/5NVTSNy3xiY7fPUMsiGCRWpReFbJVXdvKB3CKzTqlvFRQlyRQWGkhC8t
	 2uRC3C+Ll5ihKmSio0QI6cNMknwb0SlD4EWT8ZT8Tu7cmXTLCclSmiqtE/XcF/A2IX
	 MGfDON/rGFwAA==
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
Subject: [PATCH v1 16/17] perf tests probe: Exercise the variable and line listing
Date: Tue, 24 Nov 2026 15:46:03 -0300
Message-ID: <20261124184604.24983-17-acme@kernel.org>
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

Show the variables, source lines and probe-able functions of a kernel
function, and check the missing argument error.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/probe_vars.sh | 80 ++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100755 tools/perf/tests/shell/probe_vars.sh

diff --git a/tools/perf/tests/shell/probe_vars.sh b/tools/perf/tests/shell/probe_vars.sh
new file mode 100755
index 0000000000000000..1e9476635b1ebc75
--- /dev/null
+++ b/tools/perf/tests/shell/probe_vars.sh
@@ -0,0 +1,80 @@
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
+run_probe "line" "schedule" -L schedule
+run_probe "line long option" "schedule" --line schedule
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

