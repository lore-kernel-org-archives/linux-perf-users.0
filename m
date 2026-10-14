Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45B42C21D0
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 04:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791951782; cv=none; b=MsAWtZrusuTPJcvhG7KUqXFrBxxZimG1AsxiP1o1afPmxvyekYGKgreE4k/X4q9W3D0st0Ld05OwxmfsarH70+5LIwbwMYhYHvpOkM/e1Z7pZVloS/DPKLP2CRDvleWSZqMpm9aNtmz7jaPXikLWY41zql5cYu1PtAyacEjzmb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791951782; c=relaxed/simple;
	bh=1j01LOrWZ22oNx/TM6dPHf3vvhoxaueDfPb9xQp9oTk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mm1UIa/sVacs8Hx/fR0i6JGNOHmtzPJT0Mx/TP5u39cMjWhKeGBANhZjty5V/oHFP5lUTks2Xil/Ugz9swYZGkR9XJitPHCVQ92y72Q3VDJ/Ka/hr6p++G2IA7h3NZB+4aGhi1PO3MVDCvF6szHxGCIgx0SWW5YZhtEmttCZ5Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=egOtwxKV; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="egOtwxKV"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-35d4538fd74so2225402eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 21:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791951780; x=1792556580; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DZ4WwNkeZ9qsH02gyJr0XuTCfI7IHsaAfBJWSFA9Ets=;
        b=egOtwxKV8MTSsVjnL3Y3swKi10i8CUtwhpmwqPGC71DbT1nch9+zPRUz+SbdXbv+Iw
         cOqB5yZFwFocrdMubKMutY9pTh6Irz29e2k6rDt1n2CG2y2IJVWWNBMP1GOefMEdKSE+
         +0qgrlxHnigK6WjH1ogpPqf5ouBwdxQQyxZCyksa7AmnJ8HFIToVVEjk7OiWDmPwPZkY
         Kbb56TzcGALA4KbO0T8bCuJUP0Ihd+K9q+hZOhwC/+ioSJWVn+kt2yRLY0lFQsLPqugR
         I6HyD6OSobuSmsfXXHMd3/VZ0m/uPNnmPFUXEusWGnDeM2DnOhCY5y2l87QR9Kme1NyB
         Q9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791951780; x=1792556580;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DZ4WwNkeZ9qsH02gyJr0XuTCfI7IHsaAfBJWSFA9Ets=;
        b=q9NrZYknBtuGJ632T+4Kx+jXCaAqpXlSuX8ATVUoiUzbXHhLm+pRLyxKg5Bc0QBkc4
         10WFlncD+ncBbe1NfjTfBqzm7K3UcwM9zQa1dEko2j2q4U1qYTAe4fFitIR3ltolNV3E
         M3mEcgeYN0oR89sSREfw21iVvXz4NyKKrkJTQrCll4udkXR7AcaUYD+UR5iHaHU9pVBU
         6WdzItgy9SvPRItq1EePIBem5j+mWr++wlI4Fi+vLw8hs07NCtXEy3MrgO0/F78RerJh
         L+gOVJ2peBWJYaF7TXPDt3iJT4GX7Cxm9FHerlToywGeDpTOpIkdICIpxiabd1vry/o2
         XuyA==
X-Forwarded-Encrypted: i=1; AKwUvBzsiHX9bTfkJXh4yA75PxIrJCmLrX1Wlb50USYBNDts+GELmMWwet0REJhIz2IGkXyJdix6ZT2YpDNGiAGXIvSW@vger.kernel.org
X-Gm-Message-State: AFq9FYLlT9CTkFlIl80sN8beVk+y3l1Ukio4ye3AlwxNJW5qPtFe1S1X
	HpDXz7jSd8GKoB91FarCsR4kLjoxfwmOQq2UROSJ5Zj87AFlpbII2B35Oj/0umzkGrr2fShkp4P
	V+LLd5ptxIg==
X-Received: from dycph4.prod.google.com ([2002:a05:7300:dd44:b0:35d:1771:4816])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:77cc:b0:357:e9:dcea
 with SMTP id 5a478bee46e88-35700e9df2fmr17116037eec.15.1791951779208; Tue, 13
 Oct 2026 21:22:59 -0700 (PDT)
Date: Tue, 13 Oct 2026 21:22:47 -0700
In-Reply-To: <20261014042249.2379829-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <asDHqdVt4CKq_EoL@x2> <20261014042249.2379829-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261014042249.2379829-3-irogers@google.com>
Subject: [PATCH v2 2/2] perf test: Test perf timechart --live
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, alice.mei.rogers@gmail.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, atrajeev@linux.ibm.com, changbin.du@huawei.com, 
	dapeng1.mi@linux.intel.com, irogers@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tanze@kylinos.cn, thomas.falcon@intel.com, wutengda@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"

From: Alice Rogers <alice.mei.rogers@gmail.com>

Extend test_ttimechart_python.sh to cover --live option validation,
LiveRecorder's perf record subprocess, control pipe and -o output file,
a synthetic live UI test exercising the rolling window, pruning,
pause/resume and zoom following, and a live workload recording test when
scheduler tracepoints are accessible.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Alice Rogers <alice.mei.rogers@gmail.com>
Co-developed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../tests/shell/test_ttimechart_python.sh     | 300 ++++++++++++++++++
 1 file changed, 300 insertions(+)

diff --git a/tools/perf/tests/shell/test_ttimechart_python.sh b/tools/perf/tests/shell/test_ttimechart_python.sh
index 87b91ed8fc16..495060586cfc 100755
--- a/tools/perf/tests/shell/test_ttimechart_python.sh
+++ b/tools/perf/tests/shell/test_ttimechart_python.sh
@@ -82,6 +82,34 @@ test_plumbing() {
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
 
@@ -115,6 +143,43 @@ test_no_events() {
 		err=1
 		return
 	fi
+	# Exercise LiveRecorder's perf record subprocess, control pipe and
+	# -o output file using task-clock when tracepoints may be unavailable.
+	rm -f "${clockdata}"
+	if ! "$PYTHON" - "${PERF_BIN:-perf}" "${clockdata}" \
+		"$(declare -f workload); workload" > "${output}" 2>&1 <<'EOF'
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
+	then
+		echo "ttimechart no events test [Failed: LiveRecorder task-clock test]"
+		cat "${output}"
+		err=1
+		return
+	fi
 	echo "ttimechart no events test [Success]"
 }
 
@@ -218,8 +283,242 @@ EOF
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
+    async with app.run_test(size=(120, 40)) as pilot:
+        for _ in range(300):
+            with app.data.lock:
+                if app.data.pruned_to > rec.origin + 3000:
+                    break
+            await pilot.pause(0.05)
+        with app.data.lock:
+            if app.data.pruned_to <= rec.origin + 3000 or 300 in app.data.tasks:
+                raise RuntimeError("Task outside the window was not pruned")
+            starts = [t.segs.starts[0] for t in app.data.tasks.values() if len(t.segs)]
+            if not starts or min(starts) < app.data.pruned_to:
+                raise RuntimeError(f"Unpruned segments: {starts} < {app.data.pruned_to}")
+        if app.window.last - app.window.first != SEC:
+            raise RuntimeError(f"Unexpected window span: {app.window}")
+
+        await pilot.press("space")
+        await pilot.pause(0.2)
+        if rec.pause_calls != [True] or "Paused" not in app.sub_title:
+            raise RuntimeError(f"Did not pause: {rec.pause_calls} {app.sub_title}")
+        frozen = app.window.last
+        await pilot.pause(0.4)
+        if app.window.last != frozen:
+            raise RuntimeError("Window moved while paused")
+        await pilot.press("space")
+        await pilot.pause(0.3)
+        if rec.pause_calls != [True, False] or not app.following:
+            raise RuntimeError("Did not resume")
+
+        await pilot.press("plus")
+        await pilot.pause(0.2)
+        if app.following:
+            raise RuntimeError("Zooming did not stop following")
+        await pilot.press("0")
+        await pilot.pause(0.2)
+        if not app.following:
+            raise RuntimeError("Resetting zoom did not resume following")
+
+        rec.finish = True
+        for _ in range(100):
+            if not app.recording:
+                break
+            await pilot.pause(0.05)
+        if app.recording or "Finished" not in app.sub_title:
+            raise RuntimeError(f"Did not finish: {app.sub_title}")
+
+    # Also test live I/O-only mode (-I).
+    io_events = tc.LiveRecorder("perf", False, False, [], None, io_only=True).events()
+    if not io_events or not all(e.startswith("syscalls:sys_") for e in io_events):
+        raise RuntimeError(f"Unexpected I/O events: {io_events}")
+    io_rec = FakeRecorder()
+
+    def fake_io_read(data, _fd):
+        now = monotonic_ns()
+        # Self I/O should be ignored in live mode.
+        own = tc.os.getpid()
+        data.process_event(Sample("syscalls:sys_enter_read", now, 0, own, fd=3))
+        data.process_event(Sample("syscalls:sys_exit_read", now + 1000, 0, own, ret=64))
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
+        if tabs.active != "io" or not io_app.io_tasks or io_app.data.io_events != 4:
+            raise RuntimeError(f"Unexpected I/O state: active={tabs.active} "
+                               f"tasks={len(io_app.io_tasks)} events={io_app.data.io_events}")
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
+	echo "ttimechart live record test [Success]"
+}
+
 test_plumbing
 test_no_events
+test_live_synthetic
 
 if ! record; then
 	echo "Skipping remaining tests, failed to record scheduler events (permissions?)"
@@ -232,6 +531,7 @@ fi
 
 test_dump
 test_headless_ui
+test_live_record
 
 cleanup
 exit $err
-- 
2.56.0.385.gd3acb90ef8-goog

