Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.230
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795313014;
	b=lm0JBwrIfiEEeK8OoSPG21Y7RpR3TAAubBV9w/t78DxMERHl12mHBw5YmebukrH+V7X3
	 13EVYEXSPJ5ijkRv3ZeQfPlgAmbXV1+MD3QvbsclnxU0xVWoPxf/UVCfbP2/bdlk/bxjx
	 cTOG4lfOpH2RgIGp2UVyAHL5V0oTJGXQ0thO5CxOmEyUpZO6DnW6fLo0Byxhef0pqUQi6
	 EtfKXQEObUNdereNcUt5PDuoVwZLQeRXRYEjw/WGLdd9XN/5cDb5IDO3Ma4mJAW8rAvTf
	 SR1U+XJMaFC+SiagiMoaodS2QB7tKUZxdXbfuZf80O9IOktvjimfpRoEJiGOMGXjjEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795313014;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:To:Cc:
	 X-Mailer;
	bh=JmQdp4UGb+4XNZjBkF8MFhkAgJLRWXap7M+W5jPNqT8=;
	b=wg/cxsAhC5itjSPPVdBDaMKAKL99LD42t8qv4PBLhUv5SZVHr4Nh9/3gJfMAAkutTycN
	 01ZnKlDmyZ73fuaXWvb0quEwEIonBBYRm3fGHtEh/hQtb0EedKvzvSJuO3HbcXZ8PghA6
	 qb1e/BPETAsvvbRkQJN3NJclehkLDPRSqvOMJbm5VplB8H2nxE3ZLHNsiO+03LG+PEzmN
	 1vuUN6aGKmd9eNCHRfU5csrCucmQ2ajTBgL38x3166aIUuxKIhosOMl3r5jo39IZ19mfp
	 Zxev0iZKH1qTSCtPNGv+5VdsYFliNYD0u7jjy7GfLwOhHZdKaV+N/hLTvEM+7+FIYjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RQ0ccTkP;
	arc=none smtp.remote-ip=91.218.175.230
Received: from mta0.migadu.com (out-230.mta0.migadu.com [91.218.175.230])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591E2606A320
	for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 02:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 591E2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RQ0ccTkP
X-Envelope-To: linux-perf-users@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QHMV94eY1Lw126QXv9qve/RmD9iTfi2UbMdXPwF6mRY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795313011; v=1; x=1795917811;
 b=RQ0ccTkPmPlzWaaDJexHzOjTps52REn53hrZn7YZ2FbgDinXIxkQFhzppU+BtsWf9nP8Y0J6
 LyyYWtKTR3pnBLkOjIOLVnid550tY9j3Ll/D6wAaeXESMK6S+JpKM9LmBsPzymw7oYw570lHB7a
 bF/NXk3kuQjerLgrNBB2v/7k=
X-Envelope-To: linux-perf-users@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 55510332c1b80ae4;
	Sun, 22 Nov 2026 02:03:31 +0000
X-Mizu-Trace-ID: 55510332c1b80ae4
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Sat, 21 Nov 2026 21:03:24 -0500
Subject: [PATCH] perf/core: Skip cgroup attach IPIs while perf_sched_events
 is disabled
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261121-feat-perf-cgroup-attach-ipi-v1-1-a0e6d3cce8d1@linux.dev>
X-B4-Tracking: v=1; b=H4sIAGtNAmsC/x3MSwqEMAwA0KtI1gZs/M14FXFR2lSz0ZJ2BkG8u
 8Xl27wLEqtwgqm6QPkvSY69wNQVuM3uK6P4YqCGBmOowcA2Y2QN6FY9fhFtztZtKFGQPtS1Y+8
 7/22hDFE5yPnu83LfD5HJGQVtAAAA
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>
X-Mailer: b4 0.13.0

The perf_event controller is implicitly enabled on cgroup v2, so moving
tasks to another cgroup calls perf_cgroup_attach(). For every migrated
thread, it calls task_function_call(), which sends a synchronous IPI to
the CPU the thread last ran on, so that a CPU counting cgroup events
switches to the new cgroup if the thread is running there.

Without cgroup events, no CPU tracks a cgroup and perf_cgroup_switch()
returns right away, yet every thread still costs an IPI. Moving a
process with hundreds of threads, such as an inference server, then
takes milliseconds, all with cgroup_threadgroup_rwsem held for writing,
which blocks fork() and exit() on the whole system.

Return early when perf_sched_events is disabled. A cgroup event enables
it and waits for a grace period before it is installed. With a full
barrier before the key check, the grace period orders the cgroup changes
of the migrated tasks before the installation, so the event picks up the
new cgroup of the task running on its CPU.

Moving a process with sleeping threads between two cgroups 100 times,
20 ms apart, while another process forks and reaps children in a loop,
base and patched kernels alternating over 2 rounds of 3 runs, median of
the 6 runs and range in parentheses. Each move also waits about 7 ms for
a grace period to take cgroup_threadgroup_rwsem. Median time per move:

  threads        before (ms)       after (ms)   change
        1      7.8 (7.3-7.9)    7.9 (7.8-7.9)      +1%
       16      8.8 (8.6-9.1)    7.9 (7.8-7.9)     -11%
      128   14.0 (13.7-14.7)    7.9 (7.8-8.0)     -44%
      512   25.1 (24.5-26.1)   9.9 (9.8-10.0)     -61%

99th percentile of fork() and waitpid() in the other process:

  threads        before (ms)      after (ms)   change
        1      3.8 (3.5-5.3)   3.6 (3.5-3.7)      -5%
       16      4.1 (3.8-5.0)   3.7 (3.6-3.8)     -11%
      128     9.8 (9.5-10.1)   3.7 (3.6-3.8)     -63%
      512   21.6 (20.8-22.7)   4.8 (4.7-4.9)     -78%

Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
 kernel/events/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e870f12c3ad81..a5a9161bab31c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -15617,6 +15617,17 @@ static void perf_cgroup_attach(struct cgroup_taskset *tset)
 	struct task_struct *task;
 	struct cgroup_subsys_state *css;
 
+	/*
+	 * A cgroup event enables perf_sched_events and waits for a grace
+	 * period in account_event() before it is installed, so with the key
+	 * disabled no CPU tracks a cgroup yet. Order the cgroup changes of the
+	 * migrated tasks before the key check, pairing with that grace period,
+	 * so that the event picks up the new cgroup of the running task.
+	 */
+	smp_mb();
+	if (!static_branch_unlikely(&perf_sched_events))
+		return;
+
 	cgroup_taskset_for_each(task, css, tset)
 		task_function_call(task, __perf_cgroup_move, task);
 }

---
base-commit: 5f22fb20497f4983094131f00a734362300d22d2
change-id: 20261120-feat-perf-cgroup-attach-ipi-2824375d4d93

Best regards,
-- 
Qiliang Yuan <qiliang.yuan@linux.dev>

