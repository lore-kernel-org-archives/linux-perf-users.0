Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795545986;
	b=cx5YRlxq363hriOnHX5R8UtSvhA4qju1WLsp4ovLhRRvgxC3X6iJ/pwfX6rIHMUvLBic
	 FZz0gdxJxDiWxrj8Jg1i23N9Qu1uhELjd2jQdy+mHXkMmq0XwvK7Ot5EqT2dk2dpPIDRO
	 oWMUMdDzXdNX5BDkaTMkxSnw6mDHVbFvL7MV0ZY/6jZXaPDZyYMwzsAVyou/iACrpsv0h
	 BiLLlhEcKebJ5a6eaNJkc3ZpLG8mStlZO2xQ5nRtiH9D7GNKX6507ROtT8fB/tUoInEIn
	 2Igp4X/SgiRYI/RdOWJAkXCBK9t29f1gnWkA82QL3SGNNbOOnYt90OzdvdAMBgMCHWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795545986;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/rqvI9oY8p3KhwXqn/mLDDtq3SqbBetp3DYPIyXLjeI=;
	b=ssUd8qyXc98woyzNQuJurXHtyCVZFfb22F64ZhNPm66I5pwLO+BHlW2O8434/cZ+DZIe
	 6yJ8WgKkphpFT+K1fO9Gi6155hMPrxoaMNXbhVE3WJx0E4xthnfF0Bsri1TJ8eYB1KxyA
	 3v0B83y4DXMLTsstgWtsoxvLkAWtJZMQ5PM++J19bCfTJehZUpYoIMCv3u1bux5LjciNe
	 aqQfJYP8s9wH3kmVLfo7rQXqKvQ+JGVc+o0+kP/W6OC8BE6KNigTZLDNHRh55LRUWpx9Q
	 IAhZgC3mdELvT6DOm2R8HDnUOzDzGuFnu3vfw0L1YVTJlZV8qmpr2K7BM28NxdRzPAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dpLZSyJR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651C9606A32C;
	Tue, 24 Nov 2026 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dpLZSyJR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A141F00A01;
	Tue, 24 Nov 2026 18:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795545985;
	bh=/rqvI9oY8p3KhwXqn/mLDDtq3SqbBetp3DYPIyXLjeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dpLZSyJRAjzFSoqVaRVB3dfnnOUFBcZm2Z7jLO31L6fCJgzu+rF3GOLhytiaBcLPI
	 +F3QKnb20jnQePlwRffwjT32cEE1nXd2ZwDJaiTzRaY/bHFshGK3iJOI0KXJUnHFFE
	 qAdhRG09+Gmyl+PFTuoL6TJslv1kaXStvhlEKmAPdoFjOPB6y646sLju0xEIoT29He
	 qRkrmZ9fOlEQbwtz5bijt9l83P4VZOStS7iq/IrFPY5afjfFwXeXzPKGuXH4A5DIHc
	 CXsBL2RS9PFYmbyoyh9TjgKm+gheUuEFZ8Qj4MGvFjJ/mOg043EM62a8MtUe9+VCw8
	 jHZahd3857w2g==
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
Subject: [PATCH v1 04/17] perf tests config: Exercise the config file and list options
Date: Tue, 24 Nov 2026 15:45:51 -0300
Message-ID: <20261124184604.24983-5-acme@kernel.org>
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

Set, read back, update and list two variables under a private HOME,
and check the --user/--system conflict and the invalid key errors.
perf test exports PERF_CONFIG=/dev/null to the shell tests, unset it
so perf config uses the private file.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/config.sh | 134 +++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100755 tools/perf/tests/shell/config.sh

diff --git a/tools/perf/tests/shell/config.sh b/tools/perf/tests/shell/config.sh
new file mode 100755
index 0000000000000000..fc035bbec2e2ea18
--- /dev/null
+++ b/tools/perf/tests/shell/config.sh
@@ -0,0 +1,134 @@
+#!/bin/bash
+# perf config tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+err=0
+tmpdir=$(mktemp -d /tmp/__perf_test_config.XXXXXX)
+out="${tmpdir}/out"
+
+# perf test exports PERF_CONFIG=/dev/null to the shell tests, use a
+# private HOME instead so the file written here is the one being read.
+unset PERF_CONFIG
+export HOME="${tmpdir}"
+
+cleanup() {
+	rm -rf "${tmpdir}"
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
+test_config_empty() {
+	echo "Empty config test"
+	if ! perf config --user --list > "${out}" 2>&1; then
+		echo "Empty config [Failed: perf config --user --list failed]"
+		cat "${out}"
+		err=1
+		return
+	fi
+	if [ -s "${out}" ]; then
+		echo "Empty config [Failed: unexpected output]"
+		cat "${out}"
+		err=1
+		return
+	fi
+	echo "Empty config [Success]"
+}
+
+test_config_set_get() {
+	echo "Config set and get test"
+	if ! perf config report.show-nr-samples=true call-graph.print-limit=5; then
+		echo "Config set [Failed: perf config failed]"
+		err=1
+		return
+	fi
+	if [ ! -s "${HOME}/.perfconfig" ]; then
+		echo "Config set [Failed: no config file]"
+		err=1
+		return
+	fi
+
+	if ! perf config --user report.show-nr-samples | grep -qx "report.show-nr-samples=true"; then
+		echo "Config get [Failed: wrong report.show-nr-samples]"
+		err=1
+		return
+	fi
+	if ! perf config --user call-graph.print-limit | grep -qx "call-graph.print-limit=5"; then
+		echo "Config get [Failed: wrong call-graph.print-limit]"
+		err=1
+		return
+	fi
+
+	if ! perf config --user --list > "${out}" 2>&1 ||
+	   ! grep -qx "report.show-nr-samples=true" "${out}" ||
+	   ! grep -qx "call-graph.print-limit=5" "${out}"; then
+		echo "Config list [Failed: missing variables]"
+		cat "${out}"
+		err=1
+		return
+	fi
+	if ! perf config --list > "${out}" 2>&1 ||
+	   ! grep -qx "report.show-nr-samples=true" "${out}"; then
+		echo "Config list [Failed: missing user variable in the merged view]"
+		cat "${out}"
+		err=1
+		return
+	fi
+
+	if ! perf config report.show-nr-samples=false; then
+		echo "Config update [Failed: perf config failed]"
+		err=1
+		return
+	fi
+	if ! perf config report.show-nr-samples | grep -qx "report.show-nr-samples=false"; then
+		echo "Config update [Failed: value not updated]"
+		err=1
+		return
+	fi
+	echo "Config set and get test [Success]"
+}
+
+test_config_errors() {
+	echo "Config error test"
+	if perf config --user --system --list > "${out}" 2>&1; then
+		echo "Config error [Failed: --user --system succeeded]"
+		cat "${out}"
+		err=1
+		return
+	fi
+	if ! grep -q "only one config file at a time" "${out}"; then
+		echo "Config error [Failed: missing file option error]"
+		cat "${out}"
+		err=1
+		return
+	fi
+
+	if perf config nosection > "${out}" 2>&1; then
+		echo "Config error [Failed: invalid variable succeeded]"
+		cat "${out}"
+		err=1
+		return
+	fi
+	if ! grep -q "does not contain a section name" "${out}"; then
+		echo "Config error [Failed: missing invalid variable error]"
+		cat "${out}"
+		err=1
+		return
+	fi
+	echo "Config error test [Success]"
+}
+
+test_config_empty
+test_config_set_get
+test_config_errors
+
+cleanup
+exit $err
-- 
2.56.0

