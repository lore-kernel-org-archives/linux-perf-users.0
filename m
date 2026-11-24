Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546032;
	b=FXJmM4iRr5+SqFqeStFgzTbmL4rQ+kH8LNlDjBcqBuXIC5xDg/Sp42zLnCfw17ETDNK6
	 a+aA61grn/KahyRY9mCBr3KtPSgpl37hV0uprCKWZKFczPnN3MDMVkhrAviXyARjxCH8l
	 CppDOVpR2rnwI11b8acS1m3s1ipvelPqaFLFeAB6iiZC7RzqtbM+mxy/JoCJ1G/aHdsfp
	 7ILnlBh2jfvC/aimX8/cdbj5YeALxgll8593R7pKdAtL4VBQh3pxZyUnOwzXs0/d2HW1Z
	 pdzY4Q6B0dLhTaa+HQb62BBWxbYfbGZS25ZfJYsdnWwNUavy9PQlOmxX0Irq+UUcVfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546032;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6xTTBhS+4bcTEIFO7M0OnF7MPPzj3Z/Kwl7dMn2zlIA=;
	b=HYBSRrjmbIJAk5NY5fMUOTdnacCqy1/Qh7rU6gmOl4D0qmnGLPZR1XzaRWIVL2ubR/Zh
	 FpovTjG+OzZ56xq6uP/jxtv8Ft9zFtEmrhdm7drJXKbH7D9UORMEVOolvs8zvLq8S2vVF
	 UDM+TMirr7aSwZ+bDiGS6+mIKdRzhnFfwXBpwzA9WTAVMxj0JeOAkgkmjWbtvQkYJcKTS
	 CBygbudDewnb7LlhMw6NbKz/VCbt8KDhoXaXZquehOLr1QhAjkyC+NYymanu8dMkmpDW3
	 l7Re2mAwaurYMN6j7jaBYnCzmTIUJC8/lgpBV7jJp+M7rswC3KWbgaN0WpW2tU5GkBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AEO5dd1U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D182606A323;
	Tue, 24 Nov 2026 18:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AEO5dd1U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEE31F000C0;
	Tue, 24 Nov 2026 18:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795546031;
	bh=6xTTBhS+4bcTEIFO7M0OnF7MPPzj3Z/Kwl7dMn2zlIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AEO5dd1Uc1eahD9g9MUNfcXNbA0V1xM48EsJGWhrykz6D26hc5zusM9nBFk7B3L4A
	 c385WjdSaNVYTC17PgYHxoQCdfdHMpRbuvbZHzuZgVOxAfCSBO0VBZ6W6iLWyfNxHR
	 08YRFFsiUnCFK/nNJ57R/r8v+fr2d8HtaxENr1z3LZM2HYHfEYH9wOHHY/vq37iRl5
	 l1oSeN2vcxsyqe7o9IWscBENzr28/2IRLcV72NXOdCbeW+pae4/9eh8QC4u4G5TN2e
	 KhMD2kXnf2il0dCoP8YQaqCZxA2101BZl/NNZyQvLDTxYs0w8yoSEZqKcelHPPko6I
	 uA8YD/w5LrS3w==
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
Subject: [PATCH v1 17/17] perf tests report: Exercise the TUI browsers
Date: Tue, 24 Nov 2026 15:46:04 -0300
Message-ID: <20261124184604.24983-18-acme@kernel.org>
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

Run report and annotate on a pty and press the help, zoom and source
keys, then check that the screens were drawn.  Needs python and
libslang.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/report_tui.sh | 112 +++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100755 tools/perf/tests/shell/report_tui.sh

diff --git a/tools/perf/tests/shell/report_tui.sh b/tools/perf/tests/shell/report_tui.sh
new file mode 100755
index 0000000000000000..bf5ff1c4c3f6ff7f
--- /dev/null
+++ b/tools/perf/tests/shell/report_tui.sh
@@ -0,0 +1,112 @@
+#!/bin/bash
+# perf report and annotate TUI tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+# shellcheck source=lib/setup_python.sh
+. "$(dirname "$0")/lib/setup_python.sh"
+
+if ! perf check feature -q libslang; then
+	echo "[Skip] No libslang support"
+	exit 2
+fi
+
+err=0
+tmpdir=$(mktemp -d /tmp/__perf_test_tui.XXXXXX)
+perfdata="${tmpdir}/perf.data"
+tui_keys="${tmpdir}/tui_keys.py"
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
+# The TUI needs a terminal, so run it on a pty and feed it the keys a
+# user would press.
+cat > "${tui_keys}" <<'PY'
+import fcntl, os, pty, select, struct, sys, termios, time
+
+outfile = sys.argv[1]
+keys = sys.argv[2].encode()
+cmd = sys.argv[3:]
+
+pid, fd = pty.fork()
+if pid == 0:
+	os.environ["TERM"] = "xterm"
+	os.execvp(cmd[0], cmd)
+
+fcntl.ioctl(fd, termios.TIOCSWINSZ, struct.pack("HHHH", 40, 120, 0, 0))
+
+start = time.time()
+next_key = start + 1.5
+deadline = start + 20
+with open(outfile, "wb") as out:
+	while True:
+		now = time.time()
+		if now > deadline:
+			os.kill(pid, 9)
+			sys.exit(2)
+		if keys and now >= next_key:
+			os.write(fd, keys[:1])
+			keys = keys[1:]
+			next_key = now + 0.7
+		r, _, _ = select.select([fd], [], [], 0.1)
+		if r:
+			try:
+				chunk = os.read(fd, 65536)
+			except OSError:
+				break
+			if not chunk:
+				break
+			out.write(chunk)
+			out.flush()
+
+_, status = os.waitpid(pid, 0)
+sys.exit(os.waitstatus_to_exitcode(status))
+PY
+
+run_tui() {
+	local desc="$1" keys="$2" expect="$3"
+
+	shift 3
+	echo "TUI ${desc}"
+	if ! "${PYTHON}" "${tui_keys}" "${tmpdir}/${desc}.out" "${keys}" "$@"; then
+		echo "TUI ${desc} [Failed: TUI exited with an error]"
+		err=1
+		return
+	fi
+	if ! grep -qa "${expect}" "${tmpdir}/${desc}.out"; then
+		echo "TUI ${desc} [Failed: missing '${expect}']"
+		err=1
+		return
+	fi
+	echo "TUI ${desc} [Success]"
+}
+
+echo "TUI record"
+if ! perf record -q -o "${perfdata}" -- perf test -w noploop 1; then
+	echo "TUI record [Failed: perf record failed]"
+	cleanup
+	exit 1
+fi
+
+run_tui "report" "q" "Overhead" perf report --tui -i "${perfdata}"
+run_tui "report help" "?qq" "Help" perf report --tui -i "${perfdata}"
+run_tui "report dso zoom" "dq" "Overhead" perf report --tui -i "${perfdata}"
+run_tui "report thread zoom" "tq" "Overhead" perf report --tui -i "${perfdata}"
+run_tui "annotate" "q" "Percent" perf annotate --tui -i "${perfdata}"
+# noploop is built without debug info, so 's' opens the "no source code"
+# warning and the first 'q' only dismisses it; the second one quits.
+run_tui "annotate source" "sqq" "Percent" perf annotate --tui -i "${perfdata}"
+
+cleanup
+exit $err
-- 
2.56.0

