Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546004;
	b=PUJOu9e8CsJmMduMYi7KlPrCGzQvoROvM32K0G0zpSR8wD/Ab7Cg8pt9eLzWrklFiJOO
	 lYvBipSzlrvWH3wrEVBCxpQKN2A1AP7VIIhJR8ZY0lLd1fMaqhGuO12JVkrvVNmEtBeGK
	 G/casCwVZsjJe9x17tSkpFSepFyCJ4bz5Qx43hn0gkIn6SDlOOC0VLs3BMxF/oFlQBQNi
	 ioVpViA0m9zT0IQBRAEf3+D1O5xaik3qCOq/u5tAt0ImzZTuJymihGgsqfNTTyy05Z8Rn
	 8XP1ZjiS5SXQNvH8xUSPSVrHRXEL63nKa+BBbcCyGX8n1Qtd/Aok8nz1Txqi5HGPdPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546004;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HKtUl8lQS/u5o1CBDlfjhiQeXLYe80v0D+KP8U4X184=;
	b=G+M9wHrlq48A0k2BcMDkdpFNSP+i7aUGEdvHiiEq5l6m6G1S9GWJVN7FdAFF0uZxTRux
	 F2OCBuk7vGyazMLt7gQVTLV771ZIaXIP3abJGWe4bKIPp+YeCzhgiA9XT41mpwL4FnWQe
	 B4nAbHXTVOc+EprGXBPIGWJ8k8qhJcvY+eec5fzUg2fT2UqiEFuOYOmx3MdNeGUx/IJQb
	 X5Y3bky3eKireKAOt3MyHFlFsamIs1XLwdGNBzswTdPvPlO5aCsTSm3NEGwgwN3jYCn6K
	 2/KNe4qpa5sWd7C6XjUkppIQDT7oRz0/lCYvOIHENxOUVpP3IanD8dj0Hp0mMfGaluQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TAxkNGxb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C526606A31E;
	Tue, 24 Nov 2026 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TAxkNGxb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF0C1F000D0;
	Tue, 24 Nov 2026 18:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795546003;
	bh=HKtUl8lQS/u5o1CBDlfjhiQeXLYe80v0D+KP8U4X184=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TAxkNGxbAVb1rLJG3d8QifAv720z8JZLuzI4SFfN7lDTHAgi87vOei6L4tAuCf2Dl
	 TBtSivqF8vhjWD5Gy7GfMrIf2UEN5pi0zZv21AbIirN3me7Sh4a5//hMB+OAyQRvhj
	 urplnt4+vbZ3hDZNWjTZuTofjAZMf3wFSIKPVYIxnCxqs6e8kqkVONk+r2YIm44U7S
	 44wItduMIKhR7Cw8bZ1OdK6NiWZylQ1E+7ez1hHohWKxIRJIh1ILFq3OSRI+GAYAvg
	 pC5tQLsq7uqcyky7+DTgFwKtEX3moL5iRy3mp7fhdtlJUxUZsY5mLGIcHFT4E2bkuG
	 c/r98gDuTspkg==
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
Subject: [PATCH v1 09/17] perf tests report: Exercise the output and format options
Date: Tue, 24 Nov 2026 15:45:56 -0300
Message-ID: <20261124184604.24983-10-acme@kernel.org>
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

