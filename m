Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795743555;
	b=mPFNFLZzl8z4iZR9x+lSaH/vxb0mEJQ6JEkC27kDM2mSUS/BPOzYMYVWU7BhSO7br6/P
	 Zzqk8iviia2+fR0MjUjkwh6Lp6B4UC8Bv9R0NhjYjNOpN8Uz8r36p9Ink83y2fmkbz8Cd
	 eyHrPjcIeQCLTtONSnYC/3n4FJPXdIgYaHOwFGJHZ3nTMZwvS5smC4nxt4hI3PrQ8rizI
	 /e/SmlKzUE5wl0Jo1swZC0i3BmcuB0wEyo9MhU7HfcrBgNKd9i1uXQYVSI+nfac+dq/XG
	 06sJX2Y76nr0cVwy0W/zCvbEONjl+DdQ/QyigbG36J7idxcl6iQPJDMWsJGjxEXiVkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795743555;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=d8h6wRRwTscVlIyAgavXAucLih33keY98ET8SKCPwEw=;
	b=Bq87EF721Skx025b6JVpIo3/pu/3Fp9bBbbCFLhjdF661A9XRWzUF3sADLsz3p3LX3aC
	 6u61z+0X8LQE1LRWnjfwYNpeLfZ2NTpoNo+0fn/DfitAKLGfGBkviOM9BBd55RqopLH7k
	 rNgFqoP8z/v4wgCX1tORt2c5cIGHTBiDzxREadqEOjJeieUpggatl4jct22WRx824aep2
	 YxyzU2KXPYMPZwUCBREnK0jN/CbahgYJ1J8eC/kScc0wnOXHE4RWOywjtpUzf8cJsnSxd
	 JUQbyCmJ2Rn9yRMLT4OehKG0tuuJGz+l6rWCebGQIbjCzZ06rdTHjRnXDPh9hopnCTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="H/fwD8kh";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524D6606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 01:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H/fwD8kh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457721F00898;
	Fri, 27 Nov 2026 01:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795743555;
	bh=d8h6wRRwTscVlIyAgavXAucLih33keY98ET8SKCPwEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H/fwD8khAkCaOgIIVgTcR1CGStv7Nlo4WpWMslngI9cgdSnl1TSpf9YbLELiATFUh
	 jCE34K3AM2O/y0GxOHU8E0LShuZ7hiGxW18wFVRJIlCBSSND1M2uozlWDGml1PP1dL
	 6uihtGDUlN9j/GFfQ2SMJGhewI2cKEbcI/fGsjaReI7TIL/gCRCXzaHKZ/nOVGAD84
	 flFzHZttQcwvHYcbCmpvptKosLOvJUFcUjgnxZwDBBkJ3WpSe5D92h7aAsHgcNBcee
	 HKFkKZOSUW3yDv3uTRuW9vlsO14+Y+Qfvfwkur9OmKfvvmLLmB0iaeTn0DETWQZkTu
	 btiCGi3XBc/Sg==
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
Subject: [PATCH v2 18/18] perf tests report: Exercise the TUI browsers
Date: Thu, 26 Nov 2026 22:38:01 -0300
Message-ID: <20261127013801.14841-19-acme@kernel.org>
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

Run report and annotate on a pty and press the help, zoom and source
keys, then check that the screens were drawn.  Needs python and
libslang.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/report_tui.sh | 120 +++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100755 tools/perf/tests/shell/report_tui.sh

diff --git a/tools/perf/tests/shell/report_tui.sh b/tools/perf/tests/shell/report_tui.sh
new file mode 100755
index 0000000000000000..bc96e1452ee93b97
--- /dev/null
+++ b/tools/perf/tests/shell/report_tui.sh
@@ -0,0 +1,120 @@
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
+			# The browser may exit before all keys are consumed,
+			# which closes the pty and makes os.write() raise EIO.
+			try:
+				os.write(fd, keys[:1])
+			except OSError:
+				break
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
+# One user-space event keeps perf.data from opening the multi-event
+# selection menu on hybrid systems; -q on report suppresses startup
+# dialogs such as the kptr_restrict warning that would eat a key.
+if ! perf record -q -e cpu-clock:u -o "${perfdata}" -- perf test -w noploop 1; then
+	echo "TUI record [Failed: perf record failed]"
+	cleanup
+	exit 1
+fi
+
+run_tui "report" "q" "Overhead" perf report -q --tui -i "${perfdata}"
+run_tui "report help" "?qq" "Help" perf report -q --tui -i "${perfdata}"
+run_tui "report dso zoom" "dq" "Overhead" perf report -q --tui -i "${perfdata}"
+run_tui "report thread zoom" "tq" "Overhead" perf report -q --tui -i "${perfdata}"
+run_tui "annotate" "q" "Percent" perf annotate --tui -i "${perfdata}"
+# noploop is built without debug info, so 's' opens the "no source code"
+# warning and the first 'q' only dismisses it; the second one quits.
+run_tui "annotate source" "sqq" "Percent" perf annotate --tui -i "${perfdata}"
+
+cleanup
+exit $err
-- 
2.56.0

