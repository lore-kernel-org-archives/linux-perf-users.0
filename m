Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795743528;
	b=aRSWY18onMLLvPnI6ytgX9Df2Ont278n4eh+eODblIXlpkBtAumjZh4nW0kfLAdTvAHk
	 Ti3IhQTZpru/9KWw+kyA+G5PxaNsOAdgXU8vX1o39+3Em6uM1GtPpd4tbrgnQSZOYbwZM
	 YdjQHm+NXwftFHO39PofYh8turURUS86uS3rifd0r0Xq82koDrvYhEbdHGHEeioO3DqY/
	 2/cfpW8aZR56LK6tLllw3M5ji2qZU6frBfdXErHPAEsbk6q0Uw+HV0TUCDpJwfCe2jl9X
	 IF2pssYDk38/vVRx8zTnT3WZHSM8A8zyLtl+51uR6zSVipKuSgOy/7hoit0F2uafrEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795743528;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HKtUl8lQS/u5o1CBDlfjhiQeXLYe80v0D+KP8U4X184=;
	b=ZlOtGm67Fz8QR3KMZzgN9A+BPMf8588ucFTWMlcxIJQNeSzco6tZq/K04/3nyZFQhn6f
	 aCWpt0GVOMKQG+Fn7ahYWInXtpnpFgMnXB5yTgJ1MHXUZJr8d45L5jsL5/5W5KO14S6QQ
	 LMCgVdljfQHp62a6UjvGzvWLTyk4i5nRUBwEteMG3QDK1B53RwymM0H8Q0U2zTJrhaAca
	 LqpUPE91JQZSqQ57noPKOTD8JfBgaEcOGp8R9txlbElsJh+9X9ovMiFVTeswWVgqnss2e
	 2NfcLx7wyuH8e+gGB3hAONuls1PnFPUSo2UYGOHlsgh83YCaP16OYAL9kK9Wxu6FzqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F2eqgbrA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C911606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 01:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F2eqgbrA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0602E1F000C1;
	Fri, 27 Nov 2026 01:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795743527;
	bh=HKtUl8lQS/u5o1CBDlfjhiQeXLYe80v0D+KP8U4X184=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F2eqgbrAoKE9Uwy44W1WhWMEcnO7A9tC30D/CaG2HfvlD6Qw+M5g2+mOmwg1sMoiy
	 WRS397Qt0Pcav/gANQnoFnQn1m1EUJEVXQklFiwJ4pxiD8wp6zWP/HsU6Z0St6RVls
	 tR+vjh9CEDx/aKZhwlseAmlcHudzwLYWguLoA3ORbknbk2fo6jG9Spb8XMkNulkjri
	 07Au8SzGR9pgEczAaqcg/dV0cdEuea8ersBF7zjLEfwcJROomex2C6vYhjPXc2OTyq
	 vsR8Az3pGYyIEkgbdV82kUyj+y1sfU88/HpW7OAt8zeamcBH3W9NhvKLcL1uqATGom
	 HVj6bkg1ldRpA==
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
Subject: [PATCH v2 10/18] perf tests report: Exercise the output and format options
Date: Thu, 26 Nov 2026 22:37:53 -0300
Message-ID: <20261127013801.14841-11-acme@kernel.org>
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

Cover the Samples column -n adds, the field list, the field separator
and the fixed column widths, each checked in the header it prints, and
--no-children, checked against a file recorded with call graphs, where
the Children column it removes is visible.  --disable-order is checked
by the rejection it triggers together with a latency field.  The
options that change nothing in this output, -U, --percentage, --inline
and --full-source-path, run as a check that perf takes them and still
prints the table.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/report_options.sh | 122 +++++++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100755 tools/perf/tests/shell/report_options.sh

diff --git a/tools/perf/tests/shell/report_options.sh b/tools/perf/tests/shell/report_options.sh
new file mode 100755
index 0000000000000000..7e2bdaca656ce5b2
--- /dev/null
+++ b/tools/perf/tests/shell/report_options.sh
@@ -0,0 +1,122 @@
+#!/bin/bash
+# perf report option tests
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
+
+skip_test_missing_symbol "${testsym}"
+
+perfdata=$(mktemp /tmp/__perf_test_report_opts.perf.data.XXXXX)
+cgdata=$(mktemp /tmp/__perf_test_report_opts.cg.data.XXXXX)
+perfout=$(mktemp /tmp/__perf_test_report_opts.perf.out.XXXXX)
+err=0
+
+cleanup() {
+	rm -f "${perfdata}" "${perfdata}".old
+	rm -f "${cgdata}" "${cgdata}".old
+	rm -f "${perfout}"
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
+check_report() {
+	local desc="$1" expect="$2"
+
+	shift 2
+	echo "Report ${desc}"
+	if ! perf report -i "${perfdata}" --stdio "$@" > "${perfout}" 2>&1
+	then
+		echo "Report ${desc} [Failed: perf report failed]"
+		err=1
+		return
+	fi
+	if ! grep -qE "${expect}" "${perfout}"
+	then
+		echo "Report ${desc} [Failed: missing '${expect}']"
+		cat "${perfout}"
+		err=1
+		return
+	fi
+	echo "Report ${desc} [Success]"
+}
+
+# The call graph data, for --no-children: 'absent', when set, must not
+# be found in the output
+check_cg_report() {
+	local desc="$1" expect="$2" absent="$3"
+
+	shift 3
+	echo "Report ${desc}"
+	if ! perf report -i "${cgdata}" --stdio "$@" > "${perfout}" 2>&1
+	then
+		echo "Report ${desc} [Failed: perf report failed]"
+		err=1
+		return
+	fi
+	if [ -n "${absent}" ] && grep -qE "${absent}" "${perfout}"
+	then
+		echo "Report ${desc} [Failed: still has '${absent}']"
+		err=1
+		return
+	fi
+	if ! grep -qE "${expect}" "${perfout}"
+	then
+		echo "Report ${desc} [Failed: missing '${expect}']"
+		cat "${perfout}"
+		err=1
+		return
+	fi
+	echo "Report ${desc} [Success]"
+}
+
+perf record -q -e cpu-clock --sample-cpu -o "${perfdata}" ${testprog}
+
+# -n adds a Samples column, -t, joins the header fields with commas,
+# -w pads them to the given width.  -U, --percentage, --inline and
+# --full-source-path change nothing in this output: every entry
+# resolves to a symbol, nothing is filtered and no source lines are
+# printed, so they run to check that perf takes them and still prints
+# the table.
+check_report "nr samples" "Overhead[[:space:]]+Samples" -n
+check_report "hide unresolved" "^# Overhead" -U
+check_report "fields" "^ *perf " -F comm,dso,symbol,period
+check_report "percentage" "^# Overhead" --percentage absolute
+check_report "field separator" "^# Overhead," -t,
+check_report "inline" "^# Overhead" --inline
+check_report "full source path" "^# Overhead" --full-source-path
+check_report "column widths" "^# {2,}Overhead" -w 20,20,20,20,20,20
+
+# --disable-order is rejected together with a latency field, which
+# tells that the option reached the event ordering code
+echo "Report disable order"
+if ! perf report -i "${perfdata}" --stdio -F latency --disable-order 2>&1 | \
+	grep -q "incompatible with --disable-order"
+then
+	echo "Report disable order [Failed: missing the rejection]"
+	err=1
+else
+	echo "Report disable order [Success]"
+fi
+
+# Recording call graphs adds a Children column, --no-children must
+# remove it while keeping the entries
+perf record -q --call-graph fp -e cpu-clock --sample-cpu -o "${cgdata}" ${testprog}
+check_cg_report "children column" "Children" ""
+check_cg_report "no children" "${testsym}" "Children" --no-children
+
+cleanup
+exit $err
-- 
2.56.0

