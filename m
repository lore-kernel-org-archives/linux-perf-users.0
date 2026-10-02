Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253543B14A3
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790965626; cv=none; b=M32i7tIqahXCx1euG5swROCStvCESCpRRtsEgSXZKTsp8/ulAz6ny9/VCJAcJfWZbK2DCKwHuaVceeMsALdlrHAozJMlKnRy164qaM5BOakfqs+H4VHAtW5kGvTnaFgqfTz8Qhos7HOcyTpNkUqJSzkIEQ4C7hjOUSQr7t9dj3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790965626; c=relaxed/simple;
	bh=O+793EYzWG7A1sVMPetiitPJYOso2r5fE8XdxoCpWgs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=JtKuTbyh8wABeaFqZ/ZOg8VT2pnPyXOf7Ou7dyX5w6y+LZy9tL1PwlF98aANPOnL9YmQyzHSy4jwOKOFD6q7hv8r+djvnzpefxCTi990lJoqJaLctbWWXyIPrOV278b+OUUe6ZEGk/1YSBXyZoAhevAXVeSUo91evp/GX3pYcuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZFlRGcVM; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZFlRGcVM"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-34e676375d9so1678750eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 11:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790965622; x=1791570422; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vhsP25SZqvK9XFkqYvF32ff+yaKbJyS/GLSj/MRONbU=;
        b=ZFlRGcVMlJ7deej+ZrMGm53H+QfrBQr/3gTxOvoboi3FPvPMPl6K+Ai84RiUGNjxk1
         u3/UNlJ8JF8irvzXy+n2kq5m2oQLHe9BejkL7aEXRCGvgRemHNF0pywe0/gdhQSYEmFE
         q7KJo6gwGpKWJuLKemdysh4C8A4oQvEgMdq8v9J8jGf68cUQfKeUCBjzrbShNZVIY8nV
         fGOeUv+Ndy+AaWGV5D0RMSh4qiyvtsnIf9mUcrLfAyHzBtc2e8Pdnjx6LhKd0m9SEWuY
         /OjMcZ2oF8AVKK1Oxh7F+MkoAKn+XmaIioO+p05FZvOBCUDqa1Cvk7w80aNx+1MPxta0
         ehRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790965622; x=1791570422;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vhsP25SZqvK9XFkqYvF32ff+yaKbJyS/GLSj/MRONbU=;
        b=vxr7AJyQbHQulHwxi+vdyh0SxOrfw1wWEP8slpjY7P2OLyk1QcR+MgIgL46CRUKehk
         4z3N9TpZ6Ic60I84LK070YiwCZrhjx4/8VoGP9HFY5TPZf1ibrvTaTIQXxbRWRp+irb8
         hwGAZaMgJw1FMxNO5KNOj290ATbrH1DUTPEHXqCgsB4YdWL3BLfGR179R4K5xKZtlIyR
         FiaXDoehEuozhoUM7r6nbQefC01TubX/19PWYUxh08AVfZhwo4QTbzLt/rf1JuXYR6nz
         5bn02e8ayZ9R2Pt2dz/FqZOFIVFi3haeC9/07JBleKpK+BoD3CArYxFD1phGfZe2/7gg
         fQVg==
X-Forwarded-Encrypted: i=1; AKwUvBw/F4C2tG4WnoNONMHyHiWRd988MWBkVnqw2wXr26fz0PxqszBL7tjuZuARZG7ACgw9hFyLrgHoSUfP/wtYpH8V@vger.kernel.org
X-Gm-Message-State: AFuF++laE5my67H+SHXePLAlK2mvCQDzJ1mHMrmWyuqf6WV1vLfBiSmL
	c75hJuEpgoZHis4vX0OxqFHMmM8NvF8eFPouKRfL42KBZLr/16LOqf2qm2mTv+UAVxpsRinJaH9
	eqDt/2T7sBw==
X-Received: from dlbrj21.prod.google.com ([2002:a05:7022:f415:b0:146:40d5:dd5c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:465c:b0:14e:61bb:ec3d
 with SMTP id a92af1059eb24-14f5bef522cmr3565144c88.16.1790965621526; Fri, 02
 Oct 2026 11:27:01 -0700 (PDT)
Date: Fri,  2 Oct 2026 11:26:18 -0700
In-Reply-To: <20261002182624.3259797-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261002182624.3259797-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002182624.3259797-10-irogers@google.com>
Subject: [PATCH v1 09/13] perf test: Add a test for the treport script
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Alice Rogers <alice.mei.rogers@gmail.com>, Changbin Du <changbin.du@huawei.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, tanze <tanze@kylinos.cn>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Alice Rogers <alice.mei.rogers@gmail.com>

Test launching treport through perf script, the error for a file that
isn't a perf.data file, drive the textual app headless checking the
profile matches one built without the UI and exercising the key
bindings, and that quitting while loading stops the background load.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Alice Rogers <alice.mei.rogers@gmail.com>
Co-developed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/test_treport_python.sh | 247 ++++++++++++++++++
 1 file changed, 247 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_treport_python.sh

diff --git a/tools/perf/tests/shell/test_treport_python.sh b/tools/perf/tests/shell/test_treport_python.sh
new file mode 100755
index 000000000000..155993b8be79
--- /dev/null
+++ b/tools/perf/tests/shell/test_treport_python.sh
@@ -0,0 +1,247 @@
+#!/bin/bash
+# perf script treport test
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+shelldir=$(dirname "$0")
+# shellcheck source=lib/setup_python.sh
+. "${shelldir}"/lib/setup_python.sh
+
+if ! "$PYTHON" -c 'import perf' > /dev/null 2>&1; then
+	echo "Skipping test, perf python module not found"
+	exit 2
+fi
+
+if ! "$PYTHON" -c 'import textual' > /dev/null 2>&1; then
+	echo "Skipping test, python textual library not found"
+	exit 2
+fi
+
+err=0
+perfdata=
+output=
+badfile=
+
+cleanup() {
+	[ -n "${perfdata}" ] && rm -f "${perfdata}"*
+	rm -f "${output}" "${badfile}"
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
+perfdata=$(mktemp /tmp/__perf_treport_test.perf.data.XXXXX)
+output=$(mktemp /tmp/__perf_treport_test.output.XXXXX)
+badfile=$(mktemp /tmp/__perf_treport_test.bad.XXXXX)
+
+test_plumbing() {
+	echo "treport plumbing test"
+	# A missing input file should be reported by the script launched
+	# through perf script, this doesn't need a terminal.
+	if perf script treport -i "${perfdata}.missing" > "${output}" 2>&1; then
+		echo "treport plumbing test [Failed: missing file not an error]"
+		err=1
+		return
+	fi
+	if ! grep -q "not found" "${output}"; then
+		echo "treport plumbing test [Failed: script not launched]"
+		cat "${output}"
+		err=1
+		return
+	fi
+	echo "treport plumbing test [Success]"
+}
+
+test_bad_file() {
+	echo "treport bad file test"
+	echo "not a perf.data file" > "${badfile}"
+	# The app starts before the file is read, so the error is reported by
+	# the app exiting with a failure.
+	if ! "$PYTHON" - "${badfile}" > "${output}" 2>&1 <<'EOF'
+import asyncio
+import sys
+import treport
+
+async def run() -> None:
+    app = treport.ReportApp(sys.argv[1])
+    async with app.run_test(size=(120, 40)) as pilot:
+        for _ in range(100):
+            if app.return_code is not None:
+                break
+            await pilot.pause(0.1)
+    if app.return_code != 1:
+        raise RuntimeError(f"Unexpected return code {app.return_code}")
+    print("bad file ok")
+
+asyncio.run(run())
+EOF
+	then
+		echo "treport bad file test [Failed: exception]"
+		cat "${output}"
+		err=1
+		return
+	fi
+	if ! grep -q "bad file ok" "${output}"; then
+		echo "treport bad file test [Failed: unexpected output]"
+		cat "${output}"
+		err=1
+		return
+	fi
+	echo "treport bad file test [Success]"
+}
+
+record() {
+	# A software event with callchains that doesn't need privileges.
+	perf record -e task-clock -g -o "${perfdata}" -- perf test -w noploop \
+		> /dev/null 2>&1
+}
+
+test_headless_ui() {
+	echo "treport headless UI test"
+	# Drive the textual app without a terminal, check the profile shown
+	# matches one built without the UI and exercise the key bindings.
+	if ! "$PYTHON" - "${perfdata}" > "${output}" 2>&1 <<'EOF'
+import asyncio
+import sys
+import treport
+
+def labels(tree, tnode, out):
+    for child in tnode.children:
+        out.append(str(child.label))
+        if child.is_expanded:
+            labels(tree, child, out)
+    return out
+
+async def run() -> None:
+    expected = treport.ProfileBuilder()
+    expected.read(sys.argv[1])
+    if not expected.root.children:
+        raise RuntimeError("No samples in the profile")
+
+    # The app starts before the profile is built in a background thread.
+    app = treport.ReportApp(sys.argv[1])
+    async with app.run_test(size=(120, 40)) as pilot:
+        for _ in range(600):
+            if app.loaded:
+                break
+            await pilot.pause(0.1)
+        if not app.loaded:
+            raise RuntimeError("Timed out loading data")
+        await pilot.pause()
+        if app.sub_title.startswith("Loading") or "samples" not in app.sub_title:
+            raise RuntimeError(f"Unexpected sub-title: {app.sub_title}")
+        totals = {name: node.value for name, node in app.root.children.items()}
+        want = {name: node.value for name, node in expected.root.children.items()}
+        if totals != want:
+            raise RuntimeError(f"Profile {totals} differs from {want}")
+        tree = app.query_one(treport.ProfileTree)
+        shown = labels(tree, tree.root, [])
+        if not any("noploop" in label for label in shown):
+            raise RuntimeError(f"noploop not shown in: {shown}")
+        await pilot.press("down", "down", "enter", "up", "enter")
+        tabs = app.query_one(treport.TabbedContent)
+        tabs.active = "flame"
+        await pilot.pause()
+        await pilot.press("down", "down", "right", "enter", "escape", "up", "left")
+        await pilot.pause()
+        print("headless UI ok")
+
+asyncio.run(run())
+EOF
+	then
+		echo "treport headless UI test [Failed: exception]"
+		cat "${output}"
+		err=1
+		return
+	fi
+	if ! grep -q "headless UI ok" "${output}"; then
+		echo "treport headless UI test [Failed: unexpected output]"
+		cat "${output}"
+		err=1
+		return
+	fi
+	echo "treport headless UI test [Success]"
+}
+
+test_cancel() {
+	echo "treport cancel test"
+	# Quitting while loading should stop the background thread without a
+	# "processing failed" error from the session.
+	if ! "$PYTHON" - "${perfdata}" > "${output}" 2>&1 <<'EOF'
+import asyncio
+import sys
+import time
+import treport
+
+# Check for cancellation often and slow processing each sample so that the
+# load can't finish before it is cancelled.
+treport.ProfileBuilder.PROGRESS_INTERVAL = 1
+process_event = treport.ProfileBuilder.process_event
+
+def slow_process_event(self, sample) -> None:
+    time.sleep(0.001)
+    process_event(self, sample)
+
+treport.ProfileBuilder.process_event = slow_process_event
+
+async def run() -> None:
+    app = treport.ReportApp(sys.argv[1])
+    async with app.run_test(size=(120, 40)) as pilot:
+        for _ in range(100):
+            loading = app.loading
+            if loading is not None and loading.nr_samples > 0:
+                break
+            await pilot.pause(0.1)
+        if loading is None or app.loaded:
+            raise RuntimeError("Background load not in progress")
+        await pilot.press("ctrl+q")
+    for _ in range(100):
+        if app.loading is None:
+            break
+        time.sleep(0.1)
+    if app.loading is not None:
+        raise RuntimeError("Background load didn't stop")
+    if not loading.cancelled or app.loaded:
+        raise RuntimeError("Background load wasn't cancelled")
+    print("cancel ok")
+
+asyncio.run(run())
+EOF
+	then
+		echo "treport cancel test [Failed: exception]"
+		cat "${output}"
+		err=1
+		return
+	fi
+	if ! grep -q "cancel ok" "${output}" || grep -q "processing failed" "${output}"; then
+		echo "treport cancel test [Failed: unexpected output]"
+		cat "${output}"
+		err=1
+		return
+	fi
+	echo "treport cancel test [Success]"
+}
+
+test_plumbing
+test_bad_file
+
+if ! record; then
+	echo "Skipping remaining tests, failed to record samples"
+	if [ $err -eq 0 ]; then
+		err=2
+	fi
+	cleanup
+	exit $err
+fi
+
+test_headless_ui
+test_cancel
+
+cleanup
+exit $err
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

