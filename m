Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE1D515982
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 18:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790965630; cv=none; b=lvWvmIuheg2jAqe5fAhCMcMCL0yhBprLzcqGtLadrdsEDL2/N2gLLs+rzcjizYqEQ6NHN+T6hHtPXSmeraP4fuyQmkg5A1VYrunC7XwXh0O6/UP63ct68/IiBPDyrx6tKdfX0IlCF2d3qQ3KOP6tVMf1367a5BrcQciDBtEY/So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790965630; c=relaxed/simple;
	bh=VjbeaIMkDGkkC/gGn3LkmJGz5W0OV7OTXY8pLZMTifw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=J4RYu/0SHlMGsEH40tvnH1HcVIj9xt92xeZ89I0TIErVOX0HcGIiI+wzl8xJBkaCQgQQVaLct16lS2dBnoqwhZ+rtPqs/OdQTxqUqU6EiKkc/A3VCNNshFaITyRToSODLtIDo+I1T5BVvAyTlMfzYppQnkuie7IJF5p0okO0sto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eJriWhDh; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eJriWhDh"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-139b62317d0so8284949c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 11:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790965627; x=1791570427; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UmwR1WzFCYPEGeSyAT5ZyeChuVuCW43YZnOiA3h4KMw=;
        b=eJriWhDh9xXBzRVzPZxJiSDTTq/l4dCA0upxAYTp01dHzQu4HXRhTxQwaPlI43lrGR
         m4hGp0wg1INQCr6E4zi6B7lou9cRCTdxpXFNtABk6jmdO9TGv4TjmdivXO4/UpHHlhys
         29WVJlF/dzSuNC78X1LQoRvDD5cg6R+VFYKFl36saMTCM8rGrUHXb0XhPg/7XPcNOmh9
         r0iquYQ9Zi1ipsHUkAfFvAxDe3hEQg/4LnewR2RE/vzZd52cDwNb2Bz0n6QU9gRfMY+f
         +EIPYYod9Sday4GWrWqWzjM5mDri2w3175HUfVy7OgOXFXEKA1jwrzL9T4TC5fR9Ctq6
         N6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790965627; x=1791570427;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UmwR1WzFCYPEGeSyAT5ZyeChuVuCW43YZnOiA3h4KMw=;
        b=Xq5PByhAG/i0xl+wJhKZLH2/k6sHBe1eV3ebAZsS0InEBTQIwHbPe5jT9rqPNNVa+O
         mIn50RjP3EmfOlFoClyiggIMFn5mDXcXCPqR11KNzYTpuFCFLdAx1e5hJMG8jmTd+PR9
         bblL1PCm1Shg5QcuXy7TnFsgYs2JqoyvswWtp676wWBFyxKuFNWtsu9/F8hRw/u745As
         g/FCTtsE4tYaJCulTYYo2rn00HQFHlRxtgiGIDfsVKIfxlh/+1zfICWYo8GYrTFfx0HL
         ORjxiJ4tVOxo3rB5g7F0buVpFzp4wJcB9etzl9Lonl9sQZxzk3jbea+Funq4je+G8xwf
         X8RQ==
X-Forwarded-Encrypted: i=1; AKwUvBzHaH9ws1y/HMZ4BWWiveUTyPm432RDMEzQtxYo4cECpiGJZd6QCyJaKv1ygyEG7t/RbPVfOIcInNxEBfC3+0O3@vger.kernel.org
X-Gm-Message-State: AFuF++lBxLbmMT1OmX+BUBjaOrVXu9jxl9zTi7+MwokPZg2Zr3INJw+W
	NjRY+S0v2FGP8gvKNlvaUHTVPbPVZa+2tnt9yeJ4CeUG/jhLUlVVZ+foWDuPwhsebHvJ0rzKSPJ
	JTMXsKNZtyw==
X-Received: from dlbdt14.prod.google.com ([2002:a05:7022:258e:b0:144:bcd9:aa06])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:5e07:b0:149:f2b3:ef78
 with SMTP id a92af1059eb24-14f5c9d88bdmr3468787c88.32.1790965626860; Fri, 02
 Oct 2026 11:27:06 -0700 (PDT)
Date: Fri,  2 Oct 2026 11:26:20 -0700
In-Reply-To: <20261002182624.3259797-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261002182624.3259797-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002182624.3259797-12-irogers@google.com>
Subject: [PATCH v1 11/13] perf test: Add a test for perf timechart --tui
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

Test launching ttimechart through perf timechart --tui, the error when
there are no scheduler events, the --dump output with the -P, -T and -p
options, and drive the textual app headless exercising the views and
key bindings.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Alice Rogers <alice.mei.rogers@gmail.com>
Co-developed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../tests/shell/test_ttimechart_python.sh     | 237 ++++++++++++++++++
 1 file changed, 237 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_ttimechart_python.sh

diff --git a/tools/perf/tests/shell/test_ttimechart_python.sh b/tools/perf/tests/shell/test_ttimechart_python.sh
new file mode 100755
index 000000000000..87b91ed8fc16
--- /dev/null
+++ b/tools/perf/tests/shell/test_ttimechart_python.sh
@@ -0,0 +1,237 @@
+#!/bin/bash
+# perf timechart --tui (ttimechart.py) test
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+shelldir=$(dirname "$0")
+# shellcheck source=lib/setup_python.sh
+. "${shelldir}"/lib/setup_python.sh
+
+if ! perf check feature -q libtraceevent; then
+	echo "Skipping test, libtraceevent is disabled"
+	exit 2
+fi
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
+clockdata=
+
+cleanup() {
+	[ -n "${perfdata}" ] && rm -f "${perfdata}"*
+	[ -n "${clockdata}" ] && rm -f "${clockdata}"*
+	rm -f "${output}"
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
+perfdata=$(mktemp /tmp/__perf_ttimechart_test.perf.data.XXXXX)
+output=$(mktemp /tmp/__perf_ttimechart_test.output.XXXXX)
+clockdata=$(mktemp /tmp/__perf_ttimechart_test.clock.data.XXXXX)
+
+workload() {
+	for _ in 1 2 3 4 5; do
+		sleep 0.01
+	done
+}
+
+record() {
+	# perf timechart record is system wide and so may need privileges,
+	# fall back to recording just the workload's scheduler events.
+	if perf timechart record -o "${perfdata}" -- \
+		bash -c "$(declare -f workload); workload" > /dev/null 2>&1; then
+		return 0
+	fi
+	if perf record -R -c 1 -e sched:sched_switch -e sched:sched_wakeup \
+		-o "${perfdata}" -- bash -c "$(declare -f workload); workload" \
+		> /dev/null 2>&1; then
+		return 0
+	fi
+	return 1
+}
+
+test_plumbing() {
+	echo "perf timechart --tui plumbing test"
+	# A missing input file should be reported by the script launched
+	# through perf script, this doesn't need a terminal.
+	if perf timechart --tui -i "${perfdata}.missing" > "${output}" 2>&1; then
+		echo "perf timechart --tui plumbing test [Failed: missing file not an error]"
+		err=1
+		return
+	fi
+	if ! grep -q "not found" "${output}"; then
+		echo "perf timechart --tui plumbing test [Failed: script not launched]"
+		cat "${output}"
+		err=1
+		return
+	fi
+	echo "perf timechart --tui plumbing test [Success]"
+}
+
+test_no_events() {
+	echo "ttimechart no events test"
+	if ! perf record -e task-clock -o "${clockdata}" -- true > /dev/null 2>&1; then
+		echo "ttimechart no events test [Skipped: perf record failed]"
+		return
+	fi
+	if perf script ttimechart -i "${clockdata}" --dump > "${output}" 2>&1; then
+		echo "ttimechart no events test [Failed: expected an error]"
+		err=1
+		return
+	fi
+	if ! grep -q "no scheduler, power or I/O events" "${output}"; then
+		echo "ttimechart no events test [Failed: unexpected error message]"
+		cat "${output}"
+		err=1
+		return
+	fi
+	# The same should be reported when reading the data from a pipe.
+	if perf record -e task-clock -o - -- true 2> /dev/null | \
+		perf script ttimechart -i - --dump > "${output}" 2>&1; then
+		echo "ttimechart no events test [Failed: expected an error from a pipe]"
+		err=1
+		return
+	fi
+	if ! grep -q "no scheduler, power or I/O events" "${output}"; then
+		echo "ttimechart no events test [Failed: unexpected error message from a pipe]"
+		cat "${output}"
+		err=1
+		return
+	fi
+	echo "ttimechart no events test [Success]"
+}
+
+test_dump() {
+	echo "ttimechart dump test"
+	if ! perf script ttimechart -i "${perfdata}" --dump > "${output}" 2>&1; then
+		echo "ttimechart dump test [Failed: script failed]"
+		cat "${output}"
+		err=1
+		return
+	fi
+	if ! grep -q "^Duration: .*sched events: [1-9]" "${output}" ||
+	   ! grep -q "^CPU [0-9]*: busy" "${output}" ||
+	   ! grep -q "^Task .*Running .*Waiting .*Blocked" "${output}" ||
+	   ! grep -q "sleep" "${output}"; then
+		echo "ttimechart dump test [Failed: unexpected output]"
+		cat "${output}"
+		err=1
+		return
+	fi
+
+	# Tasks only shouldn't show CPUs, power only shouldn't show tasks.
+	perf script ttimechart -i "${perfdata}" --dump -T > "${output}" 2>&1 || true
+	if grep -q "^CPU [0-9]*: " "${output}" ||
+	   ! grep -q "^Task .*Running .*Waiting .*Blocked" "${output}"; then
+		echo "ttimechart dump test [Failed: -T output]"
+		cat "${output}"
+		err=1
+		return
+	fi
+	perf script ttimechart -i "${perfdata}" --dump -P > "${output}" 2>&1 || true
+	if grep -q "^Task .*Running .*Waiting .*Blocked" "${output}" ||
+	   ! grep -q "^CPU [0-9]*: " "${output}"; then
+		echo "ttimechart dump test [Failed: -P output]"
+		cat "${output}"
+		err=1
+		return
+	fi
+
+	# Filtering on the workload shouldn't show other tasks.
+	perf script ttimechart -i "${perfdata}" --dump -p sleep > "${output}" 2>&1 || true
+	if ! grep -q "^sleep " "${output}" || grep -q "^bash " "${output}"; then
+		echo "ttimechart dump test [Failed: -p output]"
+		cat "${output}"
+		err=1
+		return
+	fi
+	echo "ttimechart dump test [Success]"
+}
+
+test_headless_ui() {
+	echo "ttimechart headless UI test"
+	# Drive the textual app without a terminal, exercising the views and
+	# key bindings.
+	if ! "$PYTHON" - "${perfdata}" > "${output}" 2>&1 <<'EOF'
+import asyncio
+import sys
+import ttimechart as tc
+
+async def run() -> None:
+    # The app starts before the data is loaded in a background thread.
+    app = tc.TimechartApp(sys.argv[1], False, False, [])
+    async with app.run_test(size=(120, 40)) as pilot:
+        for _ in range(600):
+            if app.loaded:
+                break
+            await pilot.pause(0.1)
+        if not app.loaded:
+            raise RuntimeError("Timed out loading data")
+        await pilot.pause()
+        tabs = app.query_one(tc.TabbedContent)
+        for tab in ["cpus", "tasks", "summary"]:
+            tabs.active = tab
+            await pilot.pause()
+            await pilot.press("down", "plus", "plus", "right", "n", "p", "minus",
+                              "shift+right", "shift+left", "s", "w", "0")
+            await pilot.pause()
+        tabs.active = "summary"
+        await pilot.pause()
+        await pilot.press("enter")
+        await pilot.pause()
+        details = str(app.query_one("#details", tc.Static).render())
+        if "Cursor" not in details:
+            raise RuntimeError(f"Unexpected details: {details}")
+        print("headless UI ok")
+
+asyncio.run(run())
+EOF
+	then
+		echo "ttimechart headless UI test [Failed: exception]"
+		cat "${output}"
+		err=1
+		return
+	fi
+	if ! grep -q "headless UI ok" "${output}"; then
+		echo "ttimechart headless UI test [Failed: unexpected output]"
+		cat "${output}"
+		err=1
+		return
+	fi
+	echo "ttimechart headless UI test [Success]"
+}
+
+test_plumbing
+test_no_events
+
+if ! record; then
+	echo "Skipping remaining tests, failed to record scheduler events (permissions?)"
+	if [ $err -eq 0 ]; then
+		err=2
+	fi
+	cleanup
+	exit $err
+fi
+
+test_dump
+test_headless_ui
+
+cleanup
+exit $err
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

