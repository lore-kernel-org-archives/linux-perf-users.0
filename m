Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE621A841F;
	Wed, 11 Dec 2024 22:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733955671; cv=none; b=qoDPeu+Sc5nF69hU7h+eIV1iJQM6jezVjvq/NrvyyhmoiMfr9lw8kmJzcB67Xh33Hel5lxQnrNl9E9kEenOfETYPLQEXwCHbi0EBGa0Q5EabJYbnJm9B9Z5/VCTTx8B4MTBf+7l8nTtrp8DAV2/mOzhvRsF9VgnSK9NG03eY9FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733955671; c=relaxed/simple;
	bh=2aWjkE72XNSGas1TDBOKmfPrJHgAjt2hlTgdtD23gs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HXyowGXPMZeuxq87EZB8TPdT45wj9X/gmbimE9+GdtW54xMfj0kUBIv+jG+ztHp/TMWMPy6HNJ+C4paoYnGWXKc1X56JdaYsZXEM+fvRiYKEsg6O84v8cHvyGSHV5vqLeKlM4ZdxVTohBj4kRk1fG7YvEyM/P1Bl3TBdT1TZ7UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFT22pza; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFT22pza"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02700C4CED2;
	Wed, 11 Dec 2024 22:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733955671;
	bh=2aWjkE72XNSGas1TDBOKmfPrJHgAjt2hlTgdtD23gs4=;
	h=From:To:Cc:Subject:Date:From;
	b=ZFT22pzasaQ2Tpwxv7BRL/FyrY7WIMD9EBtMomgqqnidD5cJS3QGYqpuI+n5imHyP
	 MyqXAKUKc7d5rENV8mIqjva29FoLyY4d3c+NxhDITa1S+y2rmjM/wHGR7Yjo4lu3Eg
	 3wCfaQ+7cRzh4p7tmCCwPD1KDwgqp6ndQ/gVoeKme7Lzyz9goQAaefaEtd7P6dVWuN
	 S0sIVsWos066jVOEHhraP4YSEGRzAw0cwBHGFUAmpuyn8yHh/BVAeOT9C7/zZjKEBB
	 oeef/uqLDZS7OiTCJapx4Dfhas5nbMjvNYDR3pDrKSYTsm0XRneVbCStPnwMereUx9
	 OgcFENAMhg8BQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [RFC/PATCH] perf trace: Add --syscall-period option
Date: Wed, 11 Dec 2024 14:21:10 -0800
Message-ID: <20241211222110.2430610-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This option is to implement the event sampling for system calls.
The period is given in msec as it shows the time in msec.

  # perf trace -C 0 --syscall-period 100 sleep 1
           ? (         ): fleetspeakd/1828559  ... [continued]: futex())                                            = -1 ETIMEDOUT (Connection timed out)
       0.050 (100.247 ms): gnome-shell/572531 recvmsg(fd: 10<socket:[3355761]>, msg: 0x7ffef8b39d20)                = 40
     100.357 (100.149 ms): pipewire-pulse/572245 read(fd: 5<anon_inode:[eventfd]>, buf: 0x7ffc0b9dc8f0, count: 8)      = 8
     200.553 (100.268 ms): NetworkManager/3424 epoll_wait(epfd: 19<anon_inode:[eventpoll]>, events: 0x5607b85bb880, maxevents: 6) = 0
     300.876 (         ): mon/4932 poll(ufds: 0x7fa392784df0, nfds: 1, timeout_msecs: 100)            ...
     400.901 ( 0.025 ms): TaskCon~ller #/620145 futex(uaddr: 0x7f3fc596fa00, op: WAKE|PRIVATE_FLAG, val: 1)           = 0
     300.876 (100.123 ms): mon/4932  ... [continued]: poll())                                             = 0 (Timeout)
     500.901 ( 0.012 ms): evdefer/2/2335122 futex(uaddr: 0x5640baac5198, op: WAKE|PRIVATE_FLAG, val: 1)           = 0
     602.701 ( 0.017 ms): Compositor/1992200 futex(uaddr: 0x7f1a51dfdd40, op: WAKE|PRIVATE_FLAG, val: 1)           = 0
     705.589 ( 0.017 ms): JS Watchdog/947933 futex(uaddr: 0x7f4cac1d4240, op: WAKE|PRIVATE_FLAG, val: 1)           = 0
     812.667 ( 0.027 ms): fix/1985151 futex(uaddr: 0xc0008f7148, op: WAKE|PRIVATE_FLAG, val: 1)             = 1
     912.807 ( 0.017 ms): Xorg/572315 setitimer(value: 0x7ffc375d6ba0)                                      = 0

The timestamp is kept in a per-cpu array and the allowed task is saved
in a hash map.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-trace.txt       |  6 ++
 tools/perf/builtin-trace.c                    |  5 ++
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 67 ++++++++++++++++++-
 3 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index 6e0cc50bbc13fc7f..9f338a8c5357a67e 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -241,6 +241,12 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
 	printing using the existing 'perf trace' syscall arg beautifiers to map integer
 	arguments to strings (pid to comm, syscall id to syscall name, etc).
 
+--syscall-period::
+	Trace a system call in the given period (in msec).  This implements
+	sampling for syscalls in order to reduce the monitoring overhead.
+	For example, setting the sysall period to 100 (msec) means it will
+	sample a syscall and next one after 100 msec.
+
 
 PAGEFAULTS
 ----------
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 3c46de1a8d79bfe6..789eb0ffd5f90b61 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -185,6 +185,7 @@ struct trace {
 	} stats;
 	unsigned int		max_stack;
 	unsigned int		min_stack;
+	unsigned long		sample_period_ms;
 	int			raw_augmented_syscalls_args_size;
 	bool			raw_augmented_syscalls;
 	bool			fd_path_disabled;
@@ -5219,6 +5220,7 @@ int cmd_trace(int argc, const char **argv)
 		     "start"),
 	OPT_BOOLEAN(0, "force-btf", &trace.force_btf, "Prefer btf_dump general pretty printer"
 		       "to customized ones"),
+	OPT_ULONG(0, "syscall-period", &trace.sample_period_ms, "syscall sampling period in ms"),
 	OPTS_EVSWITCH(&trace.evswitch),
 	OPT_END()
 	};
@@ -5326,6 +5328,9 @@ int cmd_trace(int argc, const char **argv)
 				bpf_program__set_autoattach(prog, /*autoattach=*/false);
 		}
 
+		if (trace.sample_period_ms)
+			trace.skel->rodata->sample_period = trace.sample_period_ms * NSEC_PER_MSEC;
+
 		err = augmented_raw_syscalls_bpf__load(trace.skel);
 
 		if (err < 0) {
diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 4a62ed593e84edf8..12272620dcd73700 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -113,6 +113,22 @@ struct pids_filtered {
 	__uint(max_entries, 64);
 } pids_filtered SEC(".maps");
 
+struct sample_timestamp {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__type(key, int);
+	__type(value, __u64);
+	__uint(max_entries, 1);
+} sample_timestamp SEC(".maps");
+
+struct sample_filtered {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, pid_t);
+	__type(value, bool);
+	__uint(max_entries, MAX_CPUS);
+} sample_filtered SEC(".maps");
+
+const volatile __u64 sample_period;
+
 struct augmented_args_payload {
 	struct syscall_enter_args args;
 	struct augmented_arg arg, arg2; // We have to reserve space for two arguments (rename, etc)
@@ -428,6 +444,44 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
 	return bpf_map_lookup_elem(pids, &pid) != NULL;
 }
 
+static bool sample_filter__allow_enter(__u64 timestamp, pid_t pid)
+{
+	int idx = 0;
+	__u64 *prev_ts;
+	bool ok = true;
+
+	/* default behavior */
+	if (sample_period == 0)
+		return true;
+
+	prev_ts = bpf_map_lookup_elem(&sample_timestamp, &idx);
+
+	if (prev_ts) {
+		if ((*prev_ts + sample_period) > timestamp)
+			return false;
+		*prev_ts = timestamp;
+	} else {
+		bpf_map_update_elem(&sample_timestamp, &idx, &timestamp, BPF_ANY);
+	}
+
+	bpf_map_update_elem(&sample_filtered, &pid, &ok, BPF_ANY);
+
+	return true;
+}
+
+static bool sample_filter__allow_exit(pid_t pid)
+{
+	/* default behavior */
+	if (sample_period == 0)
+		return true;
+
+	if (!bpf_map_lookup_elem(&sample_filtered, &pid))
+		return false;
+
+	bpf_map_delete_elem(&sample_filtered, &pid);
+	return true;
+}
+
 static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 {
 	bool augmented, do_output = false;
@@ -526,7 +580,9 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 SEC("tp/raw_syscalls/sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
+	pid_t pid = getpid();
 	struct augmented_args_payload *augmented_args;
+
 	/*
 	 * We start len, the amount of data that will be in the perf ring
 	 * buffer, if this is not filtered out by one of pid_filter__has(),
@@ -537,7 +593,10 @@ int sys_enter(struct syscall_enter_args *args)
 	 * initial, non-augmented raw_syscalls:sys_enter payload.
 	 */
 
-	if (pid_filter__has(&pids_filtered, getpid()))
+	if (pid_filter__has(&pids_filtered, pid))
+		return 0;
+
+	if (!sample_filter__allow_enter(bpf_ktime_get_ns(), pid))
 		return 0;
 
 	augmented_args = augmented_args_payload();
@@ -561,9 +620,13 @@ int sys_enter(struct syscall_enter_args *args)
 SEC("tp/raw_syscalls/sys_exit")
 int sys_exit(struct syscall_exit_args *args)
 {
+	pid_t pid = getpid();
 	struct syscall_exit_args exit_args;
 
-	if (pid_filter__has(&pids_filtered, getpid()))
+	if (pid_filter__has(&pids_filtered, pid))
+		return 0;
+
+	if (!sample_filter__allow_exit(pid))
 		return 0;
 
 	bpf_probe_read_kernel(&exit_args, sizeof(exit_args), args);
-- 
2.47.0.338.g60cca15819-goog

