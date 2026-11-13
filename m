Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583590;
	b=KChsXhd3ycobsjEliPMAUD5qwUwhsgvjmdQVbS0j3q/c9oxkARGaW3jLX84FeQ0WxFAq
	 cLif7jrZM9XGBOE3SYpfYKHYjoLxUQmVwu1DGVFq9RNapJsFNuNTt8lU+A8x1VDBGay8I
	 QvVV4EqhOi7aKgM1dpqp6/tkKB0rUcD07AK0+mdNmbfPkrv2MpUz1E46gs6pjldtSvG56
	 cvAAb3PIY+tHW/rAjRkMlTtxv7WpR49cGknhHkdBexi2mfsdzBVmdnDbtGq1PsHfTTFFf
	 FOUbMBhz5op2dMvXpGj+hl+doeeUoMzkJGR9UrqgUZBGV6cLBsmzyW6V1Se3aMVaNXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583590;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=v8Jwfiwdi/JZLZTgp5PUDL2TPb5Av+rVYP8Q+4+NSg4=;
	b=mFG50EUVrEgsXPcJqtshGutqNtYgjC3QOqIcLu/9vI7An4jcVa2aCyRuAkXkMnL4HYo+
	 dJinSUBDxo/gCKNmMoY/d2ZcEhKmaLMLKXxFGZy4aAnANFzWaGGcMfOtowcPh//sMYjly
	 toTRSSM+14dCPNpY/RqWwk89EAWHtnpsh6BT4Y2Ham2KrAimGlj2rjm0VvQWx/vKJK5yr
	 ZDKb30agG0YJh4A2pcqWn3v9eDPAWbLTemkJ19jqjc3+9rRpWKxgmnw7bvI5r44TOijUn
	 ANIkBnd8Ch7PzvEAqozN8OxNRdOdwZh06GxymYqtvfssmUV4+D9DfOlch/7yo0W2AaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dAurdsDa;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D062606A890
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 15:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D062606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dAurdsDa
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso1628735eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 07:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794583589; x=1795188389; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v8Jwfiwdi/JZLZTgp5PUDL2TPb5Av+rVYP8Q+4+NSg4=;
        b=dAurdsDajLROEH12EuqyR6MIrlICTOX1HB0fEOHji6HR4o+DqYhJFl3cFQ2AelIulD
         6zTptcVG9pDRViXSntSd2sTOi/aFlNlqnA8MpwIonJp4ImFwR4nNH9KY1abadi2Ujbw6
         +nijtGkvsT0SdiU1OrLTNYJgGxuKf8BaQ9OYq+4A7WAWI7YVC/GF2hkHMyvA0UCnnqZW
         JEDHNqX8O0u5wcv6aUL88A1CUjDLgNJIv6aKR4mPw7ckgbAAohsYpq3dxv1jgwIULVA5
         qKnLEXjdZI/2dxr1evz4iCdS0Hz2rUtA7YAxTK3QHr+zGP0em9Nt00HDcznEeA7VbOS8
         edng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794583589; x=1795188389;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v8Jwfiwdi/JZLZTgp5PUDL2TPb5Av+rVYP8Q+4+NSg4=;
        b=eTRjWE67+5iUBykZvNSPKf64R5Qoqv70T74BFXvI78+gLnY8YgMx2zD0tf3KPJAXMJ
         jOeZqgSbcHfSDak9SWmUb+/mz5meX8jysqkEGYXRU0Spqnk7mEfFI1TUy0w3fCAwMOXr
         wZz3MljtCGCYLFFb7bBAvGZOSIppybaO6i8s8ILvhcBZf7H3XpeTFrekJdfIBlMLwizp
         GTJn0n7N5Ko7Kyxn9hYyJZz3Z1rz8MRd0yGmZ1yB76IergNEAdN6Up9dKFHK34mw7cPt
         0i0laOX1RxxY8F5c/cyWjHIM+H+ltal79OQTktSWOfblV+YgVTBdDDGBkKxKTbLEYdys
         fSaQ==
X-Forwarded-Encrypted: i=1; AL+hErHgJuVWNwMamudJl4BThXbfun64YBrEXqfNfRT/OhuO1MJ0N2VdoqWeTYF1v4+8NuL98tE+k0cG7jyRAU7Yp/dg@vger.kernel.org
X-Gm-Message-State: APuU4Z/HEhoZathzE5fnPweb9OIcc+m6tsACbEM77MeZTcrPmz8DtFWd
	ene2Rfs+xovDz8RPlnRRdLAVowMIcClPXyYzDUUN3XRv9SgyXk5SL6popAhkrfaliaeNvNyP95a
	oArZCP+o7wA==
X-Received: from dyz20.prod.google.com ([2002:a05:693c:4094:b0:36f:2b5:c9a7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:cc96:b0:36a:5126:a8aa
 with SMTP id 5a478bee46e88-37966a57f56mr2797665eec.27.1794583588743; Fri, 13
 Nov 2026 07:26:28 -0800 (PST)
Date: Fri, 13 Nov 2026 07:26:20 -0800
In-Reply-To: <20261113152622.1991001-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113055926.1159033-1-irogers@google.com> <20261113152622.1991001-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113152622.1991001-3-irogers@google.com>
Subject: [PATCH v8 2/2] perf test: Test perf timechart --live
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	atrajeev@linux.ibm.com, changbin.du@huawei.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tanze@kylinos.cn, thomas.falcon@intel.com, wutengda@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"

From: Alice Rogers <alice.mei.rogers@gmail.com>

Extend test_ttimechart_python.sh to cover --live option validation,
LiveRecorder's perf record subprocess, control pipe and -o output file
when system-wide recording is permitted, a synthetic live UI test
exercising the rolling window, pruning, pause/resume gaps, round-flush
framing and zoom/cursor following, and a live workload recording test
when scheduler events can be recorded system wide.

Signed-off-by: Alice Rogers <alice.mei.rogers@gmail.com>
Co-developed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../tests/shell/test_ttimechart_python.sh     | 591 ++++++++++++++++++
 1 file changed, 591 insertions(+)

diff --git a/tools/perf/tests/shell/test_ttimechart_python.sh b/tools/perf/tests/shell/test_ttimechart_python.sh
index 87b91ed8fc16..d8524f576802 100755
--- a/tools/perf/tests/shell/test_ttimechart_python.sh
+++ b/tools/perf/tests/shell/test_ttimechart_python.sh
@@ -24,6 +24,7 @@ if ! "$PYTHON" -c 'import textual' > /dev/null 2>&1; then
 fi
 
 err=0
+system_wide=0
 perfdata=
 output=
 clockdata=
@@ -57,6 +58,7 @@ record() {
 	# fall back to recording just the workload's scheduler events.
 	if perf timechart record -o "${perfdata}" -- \
 		bash -c "$(declare -f workload); workload" > /dev/null 2>&1; then
+		system_wide=1
 		return 0
 	fi
 	if perf record -R -c 1 -e sched:sched_switch -e sched:sched_wakeup \
@@ -82,6 +84,34 @@ test_plumbing() {
 		err=1
 		return
 	fi
+	if perf timechart --live -i "${perfdata}" > "${output}" 2>&1 ||
+	   ! grep -q -- "--live can't be used with -i" "${output}"; then
+		echo "perf timechart --tui plumbing test [Failed: --live with -i not rejected]"
+		cat "${output}"
+		err=1
+		return
+	fi
+	if perf timechart --live --window 0 < /dev/null > "${output}" 2>&1 ||
+	   ! grep -q -- "--window must be a positive" "${output}"; then
+		echo "perf timechart --tui plumbing test [Failed: --window 0 not rejected]"
+		cat "${output}"
+		err=1
+		return
+	fi
+	if perf timechart --tui --window 5 < /dev/null > "${output}" 2>&1 ||
+	   ! grep -q -- "require --live" "${output}"; then
+		echo "perf timechart --tui plumbing test [Failed: --window without --live]"
+		cat "${output}"
+		err=1
+		return
+	fi
+	if perf timechart --live -I -P < /dev/null > "${output}" 2>&1 ||
+	   ! grep -q -- "-I cannot be used with -P or -T" "${output}"; then
+		echo "perf timechart --tui plumbing test [Failed: -I with -P not rejected]"
+		cat "${output}"
+		err=1
+		return
+	fi
 	echo "perf timechart --tui plumbing test [Success]"
 }
 
@@ -115,6 +145,45 @@ test_no_events() {
 		err=1
 		return
 	fi
+	# Exercise LiveRecorder's perf record subprocess, control pipe and
+	# -o output file using task-clock when system-wide recording is allowed.
+	if perf record -a -e task-clock -o "${clockdata}" -- true > /dev/null 2>&1; then
+		rm -f "${clockdata}"
+		if ! "$PYTHON" - "${PERF_BIN:-perf}" "${clockdata}" \
+			"$(declare -f workload); workload" > "${output}" 2>&1 <<'EOF'
+import asyncio
+import os
+import sys
+import ttimechart as tc
+
+async def run() -> None:
+    rec = tc.LiveRecorder(sys.argv[1], False, False, ["bash", "-c", sys.argv[3]], sys.argv[2])
+    rec.events = lambda: ["task-clock"]
+    rec.start()
+    app = tc.TimechartApp("live", False, False, [], live=rec, window=5.0)
+    try:
+        async with app.run_test(size=(120, 40)) as pilot:
+            await pilot.press("space")
+            await pilot.pause(0.1)
+            await pilot.press("space")
+            for _ in range(300):
+                if app.return_code is not None:
+                    break
+                await pilot.pause(0.05)
+    finally:
+        rec.stop()
+    if app.return_code != 1 or not app.data.nr_samples or not os.path.getsize(sys.argv[2]):
+        raise RuntimeError(f"Unexpected result: rc={app.return_code} samples={app.data.nr_samples}")
+
+asyncio.run(run())
+EOF
+		then
+			echo "ttimechart no events test [Failed: LiveRecorder task-clock test]"
+			cat "${output}"
+			err=1
+			return
+		fi
+	fi
 	echo "ttimechart no events test [Success]"
 }
 
@@ -218,8 +287,529 @@ EOF
 	echo "ttimechart headless UI test [Success]"
 }
 
+test_live_synthetic() {
+	echo "ttimechart live UI test (synthetic)"
+	# Exercise live mode's rolling window, pruning, pause/resume and
+	# following with a fake recorder, which doesn't need tracepoint
+	# permissions.
+	if ! "$PYTHON" - > "${output}" 2>&1 <<'EOF'
+import asyncio
+import threading
+import time
+from time import monotonic_ns
+import ttimechart as tc
+
+SEC = 1_000_000_000
+
+class Ev:
+    def __init__(self, name):
+        self.name = name
+    def __str__(self):
+        return f"evsel({self.name})"
+
+class Sample:
+    def __init__(self, name, t, cpu, tid, **kw):
+        self.evsel = Ev(name)
+        self.sample_time = t
+        self.sample_cpu = cpu
+        self.sample_tid = tid
+        self.sample_pid = tid
+        self.sample_id = hash(name)
+        for k, v in kw.items():
+            setattr(self, k, v)
+
+class FakeRecorder:
+    def __init__(self):
+        self.origin = monotonic_ns()
+        self.data_fd = -1
+        self.flush_interval = 0.05
+        self.paused = False
+        self.pause_calls = []
+        self.stopped = threading.Event()
+        self.finish = False
+
+    def backlog(self):
+        return 0.0
+
+    def set_paused(self, paused):
+        self.paused = paused
+        self.pause_calls.append(paused)
+
+    def stop(self):
+        self.stopped.set()
+
+    def error_text(self):
+        return ""
+
+async def run() -> None:
+    rec = FakeRecorder()
+
+    def fake_read(data, _fd):
+        t0 = rec.origin
+        # Task 300 only runs at the start so pruning should drop it once the
+        # 1s window advances past t0 + 3000.
+        data.process_event(Sample("sched:sched_wakeup", t0 + 1000, 0, 1,
+                                  pid=300, comm="early", common_pid=1, common_flags=0))
+        data.process_event(Sample("sched:sched_switch", t0 + 2000, 0, 0,
+                                  prev_pid=0, prev_comm="swapper", prev_state=1,
+                                  next_pid=300, next_comm="early"))
+        data.process_event(Sample("sched:sched_switch", t0 + 3000, 0, 300,
+                                  prev_pid=300, prev_comm="early", prev_state=1,
+                                  next_pid=0, next_comm="swapper"))
+        cur = 0
+        while not rec.stopped.is_set() and not rec.finish:
+            now = monotonic_ns()
+            if rec.paused:
+                time.sleep(0.01)
+                continue
+            nxt = 100 if cur == 0 else 0
+            comm = "worker" if nxt == 100 else "swapper"
+            prev_comm = "worker" if cur == 100 else "swapper"
+            if nxt:
+                data.process_event(Sample("sched:sched_wakeup", now, 0, cur or 1,
+                                          pid=nxt, comm=comm, common_pid=cur or 1,
+                                          common_flags=0))
+            data.process_event(Sample("sched:sched_switch", now, 0, cur,
+                                      prev_pid=cur, prev_comm=prev_comm, prev_state=1,
+                                      next_pid=nxt, next_comm=comm))
+            cur = nxt
+            time.sleep(0.005)
+
+    tc.read_events = fake_read
+    app = tc.TimechartApp("live", False, False, [], live=rec, window=1.0)
+    try:
+        async with app.run_test(size=(120, 40)) as pilot:
+            for _ in range(300):
+                with app.data.lock:
+                    if app.data.pruned_to > rec.origin + 3000:
+                        break
+                await pilot.pause(0.05)
+            with app.data.lock:
+                if app.data.pruned_to <= rec.origin + 3000 or 300 in app.data.tasks:
+                    raise RuntimeError("Task outside the window was not pruned")
+                starts = [t.segs.starts[0] for t in app.data.tasks.values() if len(t.segs)]
+                if not starts or min(starts) < app.data.pruned_to:
+                    raise RuntimeError(f"Unpruned segments: {starts} < {app.data.pruned_to}")
+            if app.window.last - app.window.first != SEC:
+                raise RuntimeError(f"Unexpected window span: {app.window}")
+
+            await pilot.press("space")
+            await pilot.pause(0.2)
+            if rec.pause_calls != [True] or "Paused" not in app.sub_title:
+                raise RuntimeError(f"Did not pause: {rec.pause_calls} {app.sub_title}")
+            frozen = app.window.last
+            await pilot.pause(0.4)
+            if app.window.last != frozen:
+                raise RuntimeError("Window moved while paused")
+            await pilot.press("space")
+            await pilot.pause(0.3)
+            if rec.pause_calls != [True, False] or not app.following:
+                raise RuntimeError("Did not resume")
+
+            await pilot.press("plus")
+            await pilot.pause(0.2)
+            if app.following or app.follow_cursor:
+                raise RuntimeError("Zooming did not stop following")
+            await pilot.press("0")
+            await pilot.pause(0.2)
+            if not app.following or not app.follow_cursor:
+                raise RuntimeError("Resetting zoom did not resume following")
+            await pilot.press("left")
+            await pilot.pause(0.1)
+            if not app.following or app.follow_cursor:
+                raise RuntimeError("Moving cursor did not stop cursor following")
+            await pilot.press("0")
+            await pilot.pause(0.1)
+            if not app.follow_cursor:
+                raise RuntimeError("Resetting zoom did not resume cursor following")
+
+            rec.finish = True
+            for _ in range(100):
+                if not app.recording:
+                    break
+                await pilot.pause(0.05)
+            if app.recording or "Finished" not in app.sub_title:
+                raise RuntimeError(f"Did not finish: {app.sub_title}")
+    finally:
+        rec.stop()
+
+    # Multiple pause/resume cycles before buffered events arrive must still
+    # close states at each unrecorded gap, and pipe round tracking must detect
+    # unflushed rounds across tracing metadata.
+    gap_data = tc.TimechartData()
+    gap_data.process_event(Sample("sched:sched_switch", 1000, 0, 0,
+                                  prev_pid=0, prev_comm="swapper", prev_state=1,
+                                  next_pid=50, next_comm="runner"))
+    with gap_data.lock:
+        gap_data.mark_gap(2000)
+        gap_data.mark_gap(4000)
+    gap_data.process_event(Sample("sched:sched_switch", 2500, 0, 50,
+                                  prev_pid=50, prev_comm="runner", prev_state=1,
+                                  next_pid=0, next_comm="swapper"))
+    gap_data.process_event(Sample("sched:sched_switch", 4500, 0, 0,
+                                  prev_pid=0, prev_comm="swapper", prev_state=1,
+                                  next_pid=50, next_comm="runner"))
+    gap_data.finish()
+    if list(zip(gap_data.tasks[50].segs.starts, gap_data.tasks[50].segs.ends)) != [(2000, 2500)]:
+        raise RuntimeError(f"Unexpected gap segments: {gap_data.tasks[50].segs.starts}")
+    gap_data.prune(2000)
+    if gap_data.tasks[50].switches != 1:
+        raise RuntimeError(f"Gap prune corrupted switches: {gap_data.tasks[50].switches}")
+    gap_data.prune(2500)
+    if 50 in gap_data.tasks:
+        raise RuntimeError("Pruned task 50 should be empty")
+
+    # Verify totals, switches, blocked/waiting checkpoints, out-of-order flushes,
+    # unmerged I/O syscalls, and comm updates across exec.
+    inv = tc.TimechartData()
+    cur_comm = "perf-exec"
+    class FakeThread:
+        def comm(self):
+            return cur_comm
+    class FakeSession:
+        def find_thread(self, _tid):
+            return FakeThread()
+    inv.session = FakeSession()
+    inv.process_event(Sample("sched:sched_switch", 1000, 0, 0,
+                             prev_pid=0, prev_comm="swapper", prev_state=1,
+                             next_pid=10, next_comm="blocker"))
+    # Task 10 blocks at 2000; task 11 runs to 5000 so checkpoint extends task 10.
+    inv.process_event(Sample("sched:sched_switch", 2000, 0, 10,
+                             prev_pid=10, prev_comm="blocker", prev_state=2,
+                             next_pid=11, next_comm="other"))
+    inv.process_event(Sample("sched:sched_wakeup", 5000, 1, 11,
+                             pid=12, comm="waiter", common_pid=11, common_flags=0))
+    with inv.lock:
+        inv.checkpoint()
+        inv.prune(3000)
+    if (inv.tasks[10].state != tc.STATE_BLOCKED or
+            inv.tasks[10].totals[tc.STATE_BLOCKED] != 2000 or
+            inv.tasks[12].state != tc.STATE_WAITING):
+        raise RuntimeError(f"Blocked/waiting state lost: {inv.tasks[10].totals}")
+    # Earlier event on another CPU after checkpoint must not leak totals.
+    inv.process_event(Sample("sched:sched_switch", 4800, 0, 11,
+                             prev_pid=11, prev_comm="other", prev_state=0,
+                             next_pid=0, next_comm="swapper"))
+    inv.process_event(Sample("sched:sched_switch", 6000, 0, 11,
+                             prev_pid=11, prev_comm="other", prev_state=1,
+                             next_pid=0, next_comm="swapper"))
+    with inv.lock:
+        inv.prune(6000)
+    if 11 in inv.tasks:
+        raise RuntimeError(f"Leaked totals or switches: {inv.tasks[11].totals} "
+                           f"{inv.tasks[11].switches}")
+    # Adjacent and same-timestamp I/O syscalls must stay separate and update comm,
+    # while ignoring perf's unset ':tid' thread placeholder.
+    cur_comm = ":20"
+    inv.process_event(Sample("sched:sched_wakeup", 6500, 0, 1,
+                             pid=20, comm="launcher", common_pid=1, common_flags=0))
+    inv.process_event(Sample("syscalls:sys_enter_read", 7000, 0, 20, fd=4))
+    inv.process_event(Sample("syscalls:sys_exit_read", 7100, 0, 20, ret=4096))
+    if inv.tasks[20].comm != "launcher":
+        raise RuntimeError(f"Unset :tid placeholder overwrote comm: {inv.tasks[20].comm}")
+    cur_comm = "cat"
+    inv.process_event(Sample("syscalls:sys_enter_read", 7100, 0, 20, fd=4))
+    inv.process_event(Sample("syscalls:sys_exit_read", 7200, 0, 20, ret=4096))
+    inv.process_event(Sample("syscalls:sys_enter_read", 8000, 0, 20, fd=4))
+    inv.process_event(Sample("syscalls:sys_exit_read", 8000, 0, 20, ret=512))
+    inv.process_event(Sample("syscalls:sys_enter_read", 8000, 0, 20, fd=4))
+    inv.process_event(Sample("syscalls:sys_exit_read", 8000, 0, 20, ret=512))
+    t20 = inv.tasks[20]
+    if (len(t20.io) != 4 or t20.io_bytes != 9216 or t20.comm != "cat" or
+            t20.comms != ["launcher", "cat"]):
+        raise RuntimeError(f"Unexpected I/O task state: {len(t20.io)} {t20.io_bytes} {t20.comms}")
+    inv.process_event(Sample("sched:sched_switch", 8500, 0, 20,
+                             prev_pid=20, prev_comm="cat", prev_state=1,
+                             next_pid=0, next_comm="swapper"))
+    with inv.lock:
+        inv.prune(9000)
+    if 20 in inv.tasks:
+        raise RuntimeError(f"Leaked I/O bytes on prune: {t20.io_bytes}")
+    inv.session = None
+
+    tracker = tc.PerfPipeTracker()
+    pipe_hdr = tc.struct.pack("=QQ", tracker.PERF_MAGIC, 16)
+    td_rec = tc.struct.pack("=IHHI", tracker.HEADER_TRACING_DATA, 0, 12, 8) + b"12345678"
+    sample_rec = tc.struct.pack("=IHHQ", 9, 0, 16, 0)
+    # Feed byte-by-byte to exercise split headers.
+    for b in pipe_hdr + td_rec + sample_rec + tracker.FINISHED_ROUND_EVENT:
+        tracker.feed(bytes([b]))
+    if not tracker.at_boundary() or not tracker.unflushed_round or tracker.rounds != 1:
+        raise RuntimeError("PerfPipeTracker failed to track unflushed round")
+    tracker.feed(tracker.FINISHED_ROUND_EVENT)
+    if tracker.unflushed_round or tracker.rounds != 2:
+        raise RuntimeError("PerfPipeTracker failed to clear unflushed round")
+
+    # Also test live I/O-only mode (-I), including the shell filter quoting.
+    io_events = tc.LiveRecorder("perf", False, False, [], None, io_only=True).events()
+    if not io_events or not all(e.startswith("syscalls:sys_") for e in io_events):
+        raise RuntimeError(f"Unexpected I/O events: {io_events}")
+    orig_comm = open("/proc/self/comm", encoding="utf-8").read().strip()
+    with tc.tempfile.NamedTemporaryFile("w", delete=False) as fake_perf:
+        fake_perf.write(f"#!{tc.sys.executable}\n"
+                        "import json, os, sys\n"
+                        "sys.stderr.write(json.dumps([os.getpid(), sys.argv[1:]]) + '\\n')\n")
+        fake_perf_path = fake_perf.name
+    try:
+        tc.os.chmod(fake_perf_path, 0o755)
+        cmd_rec = tc.LiveRecorder(fake_perf_path, False, False, ["echo", "a b"], None,
+                                  io_only=True)
+        cmd_rec.start()
+        cmd_rec.proc.wait(timeout=5)
+        cmd_rec.stop()
+        if cmd_rec.backlog() != 0.0:
+            raise RuntimeError("backlog() after stop() should be 0.0")
+        import json
+        exec_pid, exec_argv = json.loads(cmd_rec.error_text())
+        expected_filt = (f'comm != "ttimechart:{tc.os.getpid() & 0xffff:x}" && '
+                         f"common_pid != {exec_pid}")
+        filt_idx = exec_argv.index("--filter")
+        if (exec_pid != cmd_rec.proc.pid or exec_argv[filt_idx + 1] != expected_filt or
+                exec_argv[-3:] != ["--", "echo", "a b"]):
+            raise RuntimeError(f"Unexpected I/O perf record argv: {exec_pid} {exec_argv}")
+        if open("/proc/self/comm", encoding="utf-8").read().strip() != orig_comm:
+            raise RuntimeError("Process comm was not restored after stop()")
+        # Verify start() cleans up if starting control_thread fails.
+        real_start = threading.Thread.start
+        calls = 0
+        def fail_second_thread(self_t):
+            nonlocal calls
+            calls += 1
+            if calls == 2:
+                raise RuntimeError("simulated thread start failure")
+            real_start(self_t)
+        threading.Thread.start = fail_second_thread
+        try:
+            fail_rec = tc.LiveRecorder(fake_perf_path, False, False, [], None, io_only=True)
+            try:
+                fail_rec.start()
+                raise RuntimeError("Expected start() to fail")
+            except RuntimeError as e:
+                if "simulated thread start failure" not in str(e):
+                    raise
+        finally:
+            threading.Thread.start = real_start
+        if (fail_rec.ctl_fd != -1 or fail_rec.wake_r != -1 or fail_rec.tee_r != -1 or
+                open("/proc/self/comm", encoding="utf-8").read().strip() != orig_comm):
+            raise RuntimeError("Failed start() left unclosed fds or unmended comm")
+    finally:
+        tc.os.unlink(fake_perf_path)
+    # Pump must preserve flush_round_target across partial record reads.
+    pump_rec = tc.LiveRecorder("perf", False, False, [], None)
+    pump_rec.wake_r, pump_rec.wake_w = tc.os.pipe()
+    tc.os.set_blocking(pump_rec.wake_r, False)
+    tc.os.set_blocking(pump_rec.wake_w, False)
+    src_r, src_w = tc.os.pipe()
+    dst_r, dst_w = tc.os.pipe()
+    pump_t = threading.Thread(target=pump_rec.pump, args=(src_r, dst_w, None), daemon=True)
+    pump_t.start()
+    try:
+        full_round = pipe_hdr + sample_rec + tracker.FINISHED_ROUND_EVENT
+        with pump_rec.round_lock:
+            pump_rec.flush_round_target = -1
+            pump_rec.flush_seq = 1
+        # Write a partial record first so tracker is not at a boundary yet.
+        tc.os.write(src_w, full_round[:20])
+        time.sleep(0.05)
+        tc.os.write(src_w, full_round[20:])
+        pump_rec.wake_pump()
+        expected_len = len(full_round) + len(tracker.FINISHED_ROUND_EVENT)
+        pumped = b""
+        deadline = time.monotonic() + 2.0
+        while len(pumped) < expected_len and time.monotonic() < deadline:
+            ready, _, _ = tc.select.select([dst_r], [], [], 0.1)
+            if ready:
+                chunk = tc.os.read(dst_r, 4096)
+                if not chunk:
+                    break
+                pumped += chunk
+        tc.os.close(src_w)
+        src_w = -1
+        pump_t.join(timeout=2)
+        if pumped != full_round + tracker.FINISHED_ROUND_EVENT:
+            raise RuntimeError(f"Pump missed split-record flush: {len(pumped)} != {expected_len}")
+    finally:
+        if src_w >= 0:
+            tc.os.close(src_w)
+        tc.os.close(src_r)
+        tc.os.close(dst_r)
+        pump_rec.close_wake_fds()
+
+    # Idle live window past last_time must not wipe open or finished states.
+    idle_rec = FakeRecorder()
+    idle_rec.origin = monotonic_ns() - 5 * SEC
+    idle_app = tc.TimechartApp("live", False, False, [], live=idle_rec, window=1.0)
+    idle_app.data.process_event(Sample("sched:sched_switch", idle_rec.origin + 1000, 0, 0,
+                                       prev_pid=0, prev_comm="swapper", prev_state=1,
+                                       next_pid=77, next_comm="quiet"))
+    idle_app.data.process_event(Sample("power:cpu_idle", idle_rec.origin + 1500, 1, 0,
+                                       cpu_id=1, state=1))
+    idle_app.data.process_event(Sample("power:cpu_frequency", idle_rec.origin + 2000, 0, 77,
+                                       cpu_id=0, state=2000000))
+    with idle_app.data.lock:
+        idle_app.data.checkpoint()
+        idle_app.live_prune()
+    if (77 not in idle_app.data.tasks or not len(idle_app.data.tasks[77].segs) or
+            not len(idle_app.data.cpus[1].cstate)):
+        raise RuntimeError("live_prune() wiped open states when idle past window")
+    idle_app.data.finish()
+    with idle_app.data.lock:
+        idle_app.live_prune()
+    if 77 not in idle_app.data.tasks or not len(idle_app.data.tasks[77].segs):
+        raise RuntimeError("live_prune() after finish() wiped tasks")
+
+    io_rec = FakeRecorder()
+
+    def fake_io_read(data, _fd):
+        now = monotonic_ns()
+        # Self I/O should be ignored in live mode without counting as samples.
+        own = tc.os.getpid()
+        data.process_event(Sample("syscalls:sys_enter_read", now, 0, own, fd=3))
+        data.process_event(Sample("syscalls:sys_exit_read", now + 1000, 0, own, ret=64))
+        # Scheduler-only tasks must be ignored when io_only is set.
+        data.process_event(Sample("sched:sched_switch", now + 1500, 0, 0,
+                                  prev_pid=0, prev_comm="swapper", prev_state=1,
+                                  next_pid=9999, next_comm="schedonly"))
+        data.process_event(Sample("sched:sched_switch", now + 1800, 0, 9999,
+                                  prev_pid=9999, prev_comm="schedonly", prev_state=1,
+                                  next_pid=0, next_comm="swapper"))
+        # Workload I/O should be recorded.
+        data.process_event(Sample("syscalls:sys_enter_read", now + 2000, 0, 4242, fd=4))
+        data.process_event(Sample("syscalls:sys_exit_read", now + 5000, 0, 4242, ret=4096))
+        data.process_event(Sample("syscalls:sys_enter_write", now + 6000, 0, 4242, fd=5))
+        data.process_event(Sample("syscalls:sys_exit_write", now + 9000, 0, 4242, ret=2048))
+
+    tc.read_events = fake_io_read
+    io_app = tc.TimechartApp("live", False, False, [], live=io_rec, window=1.0, io_only=True)
+    async with io_app.run_test(size=(120, 40)) as pilot:
+        for _ in range(100):
+            if not io_app.recording:
+                break
+            await pilot.pause(0.05)
+        await pilot.pause()
+        tabs = io_app.query_one(tc.TabbedContent)
+        if (tabs.active != "io" or not io_app.data.sched_tasks([]) or io_app.tasks or
+                len(io_app.io_tasks) != 1 or io_app.data.io_events != 4 or
+                io_app.data.nr_samples != 6):
+            raise RuntimeError(f"Unexpected I/O state: active={tabs.active} "
+                               f"tasks={len(io_app.tasks)} io_tasks={len(io_app.io_tasks)} "
+                               f"events={io_app.data.io_events} samples={io_app.data.nr_samples}")
+        import io as pyio
+        from contextlib import redirect_stdout
+        buf = pyio.StringIO()
+        with redirect_stdout(buf):
+            io_app.data.dump(False, False, [], io_only=True)
+        if "tasks: 1," not in buf.getvalue() or "schedonly" in buf.getvalue():
+            raise RuntimeError(f"Unexpected -I dump output: {buf.getvalue()}")
+        tabs.active = "summary"
+        await pilot.pause()
+        await pilot.press("enter")
+        await pilot.pause()
+        if tabs.active != "io":
+            raise RuntimeError(f"Summary enter did not activate I/O tab: {tabs.active}")
+        print("live synthetic ok")
+
+asyncio.run(run())
+EOF
+	then
+		echo "ttimechart live UI test (synthetic) [Failed: exception]"
+		cat "${output}"
+		err=1
+		return
+	fi
+	if ! grep -q "live synthetic ok" "${output}"; then
+		echo "ttimechart live UI test (synthetic) [Failed: unexpected output]"
+		cat "${output}"
+		err=1
+		return
+	fi
+	echo "ttimechart live UI test (synthetic) [Success]"
+}
+
+test_live_record() {
+	echo "ttimechart live record test"
+	if [ "${system_wide}" != 1 ]; then
+		# Live mode records system wide, like perf timechart record.
+		echo "ttimechart live record test [Skipped: can't record system wide]"
+		return
+	fi
+	rm -f "${perfdata}.live"
+	if ! "$PYTHON" - "${PERF_BIN:-perf}" "${perfdata}.live" \
+		"$(declare -f workload); workload" > "${output}" 2>&1 <<'EOF'
+import asyncio
+import sys
+import ttimechart as tc
+
+async def run() -> None:
+    rec = tc.LiveRecorder(sys.argv[1], False, False, ["bash", "-c", sys.argv[3]], sys.argv[2])
+    rec.start()
+    app = tc.TimechartApp("live", False, False, [], live=rec, window=5.0)
+    try:
+        async with app.run_test(size=(120, 40)) as pilot:
+            for _ in range(600):
+                if not app.recording:
+                    break
+                await pilot.pause(0.1)
+            if app.recording or not app.data.has_events():
+                raise RuntimeError("Live recording of workload did not complete")
+            print("live record ok")
+    finally:
+        rec.stop()
+
+asyncio.run(run())
+EOF
+	then
+		echo "ttimechart live record test [Failed: exception]"
+		cat "${output}"
+		err=1
+		return
+	fi
+	if ! perf script ttimechart -i "${perfdata}.live" --dump > "${output}" 2>&1 ||
+	   ! grep -q "^Duration: .*sched events: [1-9]" "${output}"; then
+		echo "ttimechart live record test [Failed: saved perf.data unreadable]"
+		cat "${output}"
+		err=1
+		return
+	fi
+	if perf timechart record -I -o "${perfdata}.live" -- true > /dev/null 2>&1; then
+		rm -f "${perfdata}.live"
+		if ! "$PYTHON" - "${PERF_BIN:-perf}" "${perfdata}.live" > "${output}" 2>&1 <<'EOF'
+import asyncio
+import sys
+import ttimechart as tc
+
+async def run() -> None:
+    rec = tc.LiveRecorder(sys.argv[1], False, False,
+                          ["bash", "-c", "cat /etc/hostname > /dev/null"],
+                          sys.argv[2], io_only=True)
+    rec.start()
+    app = tc.TimechartApp("live", False, False, [], live=rec, window=5.0, io_only=True)
+    try:
+        async with app.run_test(size=(120, 40)) as pilot:
+            for _ in range(600):
+                if not app.recording:
+                    break
+                await pilot.pause(0.1)
+            if app.recording or not app.data.io_events:
+                raise RuntimeError("Live I/O recording of workload did not complete")
+    finally:
+        rec.stop()
+
+asyncio.run(run())
+EOF
+		then
+			echo "ttimechart live record test [Failed: live -I exception]"
+			cat "${output}"
+			err=1
+			return
+		fi
+	fi
+	echo "ttimechart live record test [Success]"
+}
+
 test_plumbing
 test_no_events
+test_live_synthetic
 
 if ! record; then
 	echo "Skipping remaining tests, failed to record scheduler events (permissions?)"
@@ -232,6 +822,7 @@ fi
 
 test_dump
 test_headless_ui
+test_live_record
 
 cleanup
 exit $err
-- 
2.56.1.703.gf848ed807c-goog

