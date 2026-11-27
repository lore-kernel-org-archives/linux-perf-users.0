Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795743510;
	b=jIbtDnnTK4tVpRc+MnMtMT0l+n4fOiga2ammM5lXlDiwb4AaHAjlA7AtzGZB1cdYshYC
	 IyaJjVCX51XAQAp/Mw3nExwKYRfSscT1gJOMUoIm11qgAMfxiQVJrA/cF8TXmUF7XBs3c
	 4H3+X4dHaunH+nD1rqisnzgIxeHDBRt24kuDa8twLWGmHkafflSEDESJCD7+wAH89695Z
	 g3ryuztYpaL5YPyc+OybC3gsRZUXrhHf9ov05t8i55c2oLbbpo3EyfWo7mLhQdDHTaI9L
	 6HekpX8e0sQfpNEtXWZoaaH6AKmBbfcPWsOPRaeCTPUdLprvr7D74FunRdDhDnhgqjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795743510;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/rqvI9oY8p3KhwXqn/mLDDtq3SqbBetp3DYPIyXLjeI=;
	b=makc+cBB3bzXLVZdcGiphDMjpGSHWRvmyQzhSE79Tskg7RkAcpP9HwqbGgBY9d75T1BV
	 GCzDO+RBdWM0an1qwsPPCpmmf6rr9WDzGGC/KQxQkCJw4Wdri6pMy766ZsWcLyUZp0iqx
	 6Nd0JGZqNf2t9l+aFjyG3BDpjb5x7SB4wmi7yryx/O2dRDtvr6zZkvgZwPCXmMxAQXxGn
	 gZbyLE8Mhj9jC9rnx/t0afBrCcPhPp0+foz1pR/BwlqrZ6jIFIBM0IzpenFo1NoxZgeqg
	 hEZqNrtuG8k36ZShDOmQ105dNTR1qXnO92ggOmpx82hIOktEOULIQe2Yi+LigmdLfQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eOOyXgqi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35996606A32D
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 01:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eOOyXgqi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091251F00897;
	Fri, 27 Nov 2026 01:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795743510;
	bh=/rqvI9oY8p3KhwXqn/mLDDtq3SqbBetp3DYPIyXLjeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eOOyXgqiLku5eGcDfTfYBuLLdrztu3NaKtSANwDQNxjLnqiRM5l0+WifZcGhTD3QC
	 1vaSAlaUm1DjhtQaAqij2DimTtZzeVYhfq/UscvMil0kvzslmOQIUgwoG14/OjU2o3
	 RpbPMhbeOq5ngispqzgQkFbr+Pg9EjxX/Vs9+XhjIEywICS4yJZyE+o6+rlg+RZGFU
	 cIKC8jwNpvZyzv4SkjN/QAjv7F5UCv++Zd8jqMLrCrUNX14bYePe9G6ljmWzt2Rycg
	 vazmN3v9JxkNJDgD+z07Mrgd6xPDWSiGpHlXn+j6pgLeSs7oGUQwGnftPINu1snbP0
	 8K4OzpXXBDKXw==
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
Subject: [PATCH v2 05/18] perf tests config: Exercise the config file and list options
Date: Thu, 26 Nov 2026 22:37:48 -0300
Message-ID: <20261127013801.14841-6-acme@kernel.org>
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

