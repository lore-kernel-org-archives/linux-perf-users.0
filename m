Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E46515995
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 18:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790965626; cv=none; b=EZJ8r+slZKWvsiNHIHdRSriiGxwo/wKrl0qjIYuKZBs7Z9RM33ZPth+o7IHo49k27CG9SNNPmEEEDl144FgjeBb5iNSb39SLNIRQqmiyo17+J953ynRPcO4W4WddFtNIjhB2eh9r1da7j00K10lsVBadAuJeVZGGsiakNz2AwUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790965626; c=relaxed/simple;
	bh=Ppsm2iwCwEiXBncYOr0kj+K4ygWswKzoOM3THLkaBOc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=gBI7SZUaktPqj+XNNfag4fOwVejUJD56MNQ4n1QJq7yiEaLhJuLdwKqbreohSuGjOrzV0Kyu4wX9ysRL9Nf8gHhM5Ba50vt3vO5D+j6fcWCcNSREOdXz/3w4X1oVLQE0H8/2DoF47GWYu+QWh7z1DMdsoQvymtB5OPlSsqKa6rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L8L9GbeW; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L8L9GbeW"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1416f32fe11so9386072c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 11:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790965616; x=1791570416; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xJeoSrG1sFQbzoddGzDwymqwtwNEzCJZbEVP4wJuqFQ=;
        b=L8L9GbeWlcXjK1Ej1RGFPbkdzL2XG9M3H9JHuXrHEuWg28tXQQXRpfxx5Lfz4sIPzv
         Zhwe9td/2sAF3BqRk9H/XeRtnUheEjaiBZuj9kMbSxY2g3DaM/g2ZSRPmXFrPmB2vh+G
         caZGY0z5h12+wT2Chd3SB1K7eTZFGzuQ8IBJXzoxA0wQBs9RFI18Wlqha7SWYy7yc5Es
         JMjW1oz9kwhSsac0OZEh8bm5n5Vg8JImmCnnDZltpbD4bmzJRMEdw06prlcTH0cbXtjf
         pWwMIid1P+XigqtUBOQW5ZmiRVlEcYp82tjaQBwTYsIhcDzEh2W9E78Vpf7biIBHBDxc
         EOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790965616; x=1791570416;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xJeoSrG1sFQbzoddGzDwymqwtwNEzCJZbEVP4wJuqFQ=;
        b=QWR3gnrVYd7dMp3qaRRR273SGHzC2SrGT8q3rmogMZWNSoQMbh5vQTK7Dw5cEaTN2D
         +A2Qinb4oYjmvHdw0/VsiVwUsI9zj/GbGsAh1MNw3a4J9VmWKo9mxQS5SyWB8j4CEz4w
         G+ceLJ1nWSK5GKtByhJ5ROOGspVNSDfOmx5JrJtWhNEWbDcqhkCCwzgqfzxSB4aB+Hvo
         ZbeRNWVY7iZ4+313daLsre9hvcalNaVOJWzaem/V69vWjF2FWD8XxGbdS3zIVCOmLEW3
         xRmo41iQjkFmC5jbJ72NIk5UmylcChPxYsTLt4uRrJb5c8vdqReS0ucQU+zyFHdU26d1
         Hefw==
X-Forwarded-Encrypted: i=1; AKwUvBycpGRRsouAYJHHB9HV1+5hYbZgO9H0I75Y0Cqz7gprrO0HNivu/CwmkkQupbQFNvakQBDfAdxvLOD9N+Cw55My@vger.kernel.org
X-Gm-Message-State: AFuF++nIeJhOxJ/nWeecZuTunjzZMkryHDkKdLPBH3ZfwySc3rZZjROs
	DxdWOHYO+Mh7E43X95zWZ0P9gbLMTI0kONjMco1B6lxvxNWgP6edYpKDX6TmE3hA+fRzXo1/JBB
	bMpqLPi8qNA==
X-Received: from dlnn16.prod.google.com ([2002:a05:7022:6190:b0:151:c50e:fd9d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:7e0c:b0:150:3c69:2adb
 with SMTP id a92af1059eb24-1503c692d2bmr2320768c88.2.1790965615875; Fri, 02
 Oct 2026 11:26:55 -0700 (PDT)
Date: Fri,  2 Oct 2026 11:26:16 -0700
In-Reply-To: <20261002182624.3259797-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261002182624.3259797-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002182624.3259797-8-irogers@google.com>
Subject: [PATCH v1 07/13] perf test: Add a test for the ilist script
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

Test launching ilist through perf script and perf list --tui, and drive
the textual app headless: check the tree of PMUs and metrics, search for
and select the software task-clock event checking its counters are
shown, check a failed search shows an error and select a metric. Failing
to open counters, for example for want of permissions, is tolerated as
an error dialog is shown.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/test_ilist_python.sh | 181 ++++++++++++++++++++
 1 file changed, 181 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_ilist_python.sh

diff --git a/tools/perf/tests/shell/test_ilist_python.sh b/tools/perf/tests/shell/test_ilist_python.sh
new file mode 100755
index 000000000000..83048474710d
--- /dev/null
+++ b/tools/perf/tests/shell/test_ilist_python.sh
@@ -0,0 +1,181 @@
+#!/bin/bash
+# perf script ilist and perf list --tui test
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
+output=$(mktemp /tmp/__perf_ilist_test.output.XXXXX)
+
+cleanup() {
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
+test_plumbing() {
+	echo "ilist plumbing test"
+	# The script should be found and run by perf script, --help doesn't
+	# need a terminal.
+	if ! perf script ilist --help > "${output}" 2>&1; then
+		echo "ilist plumbing test [Failed: script failed]"
+		cat "${output}"
+		err=1
+		return
+	fi
+	if ! grep -q -- "--interval" "${output}"; then
+		echo "ilist plumbing test [Failed: script not launched]"
+		cat "${output}"
+		err=1
+		return
+	fi
+	echo "ilist plumbing test [Success]"
+}
+
+test_list_tui() {
+	echo "perf list --tui plumbing test"
+	# Arguments after -- are passed to the script launched by perf list.
+	if ! perf list --tui -- --help > "${output}" 2>&1; then
+		echo "perf list --tui plumbing test [Failed: script failed]"
+		cat "${output}"
+		err=1
+		return
+	fi
+	if ! grep -q -- "--interval" "${output}"; then
+		echo "perf list --tui plumbing test [Failed: script not launched]"
+		cat "${output}"
+		err=1
+		return
+	fi
+	echo "perf list --tui plumbing test [Success]"
+}
+
+test_headless_ui() {
+	echo "ilist headless UI test"
+	# Drive the textual app without a terminal. Opening counters may fail
+	# for want of permissions, in which case an error dialog is shown.
+	if ! "$PYTHON" > "${output}" 2>&1 <<'EOF'
+import asyncio
+import ilist
+from textual.widgets import Label, Tree
+
+async def dismiss_error(app, pilot) -> bool:
+    """Close the error dialog if shown, returning whether it was."""
+    if not isinstance(app.screen, ilist.ErrorScreen):
+        return False
+    await pilot.click("#error")
+    await pilot.pause()
+    if isinstance(app.screen, ilist.ErrorScreen):
+        raise RuntimeError("Error dialog not dismissed")
+    return True
+
+async def search(pilot, text: str) -> None:
+    await pilot.press("s")
+    await pilot.pause()
+    await pilot.press(*text, "enter")
+    await pilot.pause()
+
+def find_leaf(node, cls):
+    """Find the first node whose data is of type cls."""
+    if isinstance(node.data, cls):
+        return node
+    for child in node.children:
+        found = find_leaf(child, cls)
+        if found:
+            return found
+    return None
+
+async def check_counting(app, pilot, name: str) -> None:
+    """Check the selected event is shown and counting, or that it failed to open."""
+    await pilot.pause(0.5)
+    if await dismiss_error(app, pilot):
+        print(f"{name}: failed to open")
+        return
+    shown = str(app.query_one("#event_name", Label).render())
+    if shown != name:
+        raise RuntimeError(f"Selected {shown} rather than {name}")
+    if not app.query(ilist.CounterSparkline) or not app.query("#counter_total"):
+        raise RuntimeError(f"No counters shown for {name}")
+    print(f"{name}: total {app.query_one('#counter_total', Label).render()}")
+
+async def run() -> None:
+    app = ilist.IListApp(0.1)
+    async with app.run_test(size=(120, 40)) as pilot:
+        await pilot.pause()
+        tree = app.query_one("#root", Tree)
+        top = [str(node.label) for node in tree.root.children]
+        if top != ["PMUs", "Metrics"]:
+            raise RuntimeError(f"Unexpected tree: {top}")
+        pmus = [str(node.label) for node in tree.root.children[0].children]
+        if "software" not in pmus:
+            raise RuntimeError(f"No software PMU in: {pmus}")
+
+        # Search for a software event, which exists everywhere. The search
+        # result is selected which opens the event.
+        await search(pilot, "task-clock")
+        found = app.cur_search_result
+        if not found or not isinstance(found.data, ilist.PmuEvent) or \
+           "task-clock" not in str(found.label):
+            raise RuntimeError(f"Search didn't find task-clock: {found}")
+        await check_counting(app, pilot, found.data.name())
+        if not app.query_one("#active_search", Label).display:
+            raise RuntimeError("Active search not shown")
+        await pilot.press("n", "p", "down", "up", "c")
+        await pilot.pause(0.2)
+        await dismiss_error(app, pilot)
+
+        # Searching for something that doesn't exist shows an error.
+        await search(pilot, "no-such-event-xyzzy")
+        if not await dismiss_error(app, pilot):
+            raise RuntimeError("No error for a failed search")
+
+        # Select a metric, if there are any.
+        metric = find_leaf(tree.root, ilist.Metric)
+        if metric:
+            app.expand_and_select(metric)
+            await check_counting(app, pilot, metric.data.name())
+        print("headless UI ok")
+
+asyncio.run(run())
+EOF
+	then
+		echo "ilist headless UI test [Failed: exception]"
+		cat "${output}"
+		err=1
+		return
+	fi
+	if ! grep -q "headless UI ok" "${output}"; then
+		echo "ilist headless UI test [Failed: unexpected output]"
+		cat "${output}"
+		err=1
+		return
+	fi
+	echo "ilist headless UI test [Success]"
+}
+
+test_plumbing
+test_list_tui
+test_headless_ui
+
+cleanup
+exit $err
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

