Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7709C3CAA31
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 02:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790648394; cv=none; b=PSJ/+ovSDrZlv/qP1frt+60aztDF20mEXpD/QqcJNJHiurO8NWEbifDCfucmH63Hgc4/uh+xxJOLJIVhXh1HYiHDao17Vmhxqs4ZvAmL/ArieE9vZLRpttldK9peqA6EU+FhH94FKIzGdxRKdYxRw98XTUwIVKDKpZstBS51CdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790648394; c=relaxed/simple;
	bh=huabu+RxgYWn508JxJzFACq545qIjmrzr3ISmqOOuD0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=izOHNK7SizsazrnimNXhh5KBeyoulBi0gJFduNr2yUfvscRILXQbShdHH3hculczxzsy/Tr7FtLEVPJjHMIl6a+fNfcKsySRZhHdgSSP2vjlaNPhY+cAxxauKnxIF5PViKA+UFviW/ogbXLb6g6I6rdb9i+c+KVqZNOqH3nMNxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bTnFP19R; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bTnFP19R"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33baaba6371so13907958eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 19:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790648382; x=1791253182; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yv5diHZMF/3Y8pazLLa8+vi3Vu4ucUVcQqFcEImBeHs=;
        b=bTnFP19RSRg8I7wDNMcYpq2wsyIdt6+4axLbXweD+89zWBf44ubX+PD0XnnbJ1vF3O
         7OAIbeL7P0Ez8TqPvf1xA7o4VOuH/roAi17JeTxsLTnm+ODqBbT8/biZptCVPzIvQ0jN
         cUp8pDtOMIOhTbhqg4chiSNdszYRcZp5DriwLM7eaKKXKSxrh1YWPhjGVm1tU+p6gZcS
         0elWFFudju69QwxV/M7kf+AXDgCXPCndHybp8UE907yfBNbjj4ROy6cCXaGvy7Xg6Ufr
         0WxtyxXh9D8uwA2zjOWXZc892HKo9kjKU9UMpWYGQwQ5vv9fIMydWH7Pfm3d2FeciXhi
         OXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790648382; x=1791253182;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yv5diHZMF/3Y8pazLLa8+vi3Vu4ucUVcQqFcEImBeHs=;
        b=dOIp+ZKP8srBrzlaDt+0nUnTNfPjbOGxl5SGmF/OpZmYWGSLrcRGgH4XXcG7tDZb6N
         Dz96rXdDa12VyKYmo6Re5rRdgHlmZkjcI3TU4ojRtTACnnAYRu6G3Kxbm1cIHMpV9St4
         PlmhIV8/sylhI2DjlJIN1U/zZi/jv2WVPWpUTfNKWhuwl+3D9LAfaqGI/6oHnLdmV5/7
         vc/TnJyJixTB29q6lKFZ3+HaGyIqCUXSkxZrCNdmVYgFqFZZWurHeEYGMrSPQLcFp/ju
         VSH7xGcG68KViXWtmRn+qhNjg+vricxjAS9PIMQ591ynpOwNIxPnOTe7SvcoFL4DS4WC
         Izsw==
X-Forwarded-Encrypted: i=1; AKwUvBzjK3zedZMtGB3GD/g+3cR2YlFly9m142GTzHd6bLEa/Oow4yxor7ZKtfx6sipKdoBBPSSmVX47LxezrcWXWsYW@vger.kernel.org
X-Gm-Message-State: AFq9FYLrxmboYCSZlrHNky0DZWgq6qflYLtVtpioipUkfO9z7QUFEjKO
	lJFobdESO0M+B69DYHkTsYTPndsTIjvtNo+tqipSj4u1lDeNuX3N4Ks7ilE3CamtfM4+vLi1lgw
	P+vWn5A1w8A==
X-Received: from dybuo16.prod.google.com ([2002:a05:7301:c010:b0:34b:5f61:c1a4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4201:b0:33b:ea8c:811b
 with SMTP id 5a478bee46e88-3426fbbeb5dmr11886883eec.5.1790648381673; Mon, 28
 Sep 2026 19:19:41 -0700 (PDT)
Date: Mon, 28 Sep 2026 19:19:10 -0700
In-Reply-To: <20260929021913.56010-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929021913.56010-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929021913.56010-7-irogers@google.com>
Subject: [PATCH v1 6/9] perf test: Reduce overhead and contention in Python
 shell tests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When all Python shell tests run concurrently during 'perf test' under
heavy load:
1. Unfiltered 'perf list' initializes all hardware PMUs and metrics in
   each test process; use 'perf list tracepoint' when checking for
   tracepoint events.
2. Running 'perf record' without '-B -N --no-bpf-event' synthesizes BPF
   events across the system and caches build-ids into ~/.debug; add
   '-B -N --no-bpf-event' to all Python shell test recordings.
3. Drop '-a' in test_check_perf_trace_python.sh,
   test_rw_by_file_python.sh, test_rw_by_pid_python.sh,
   test_rwtop_python.sh, and test_syscall_counts_by_pid_python.sh where
   only a single child workload ('dd' or 'sleep') is tested, avoiding
   system-wide /proc synthesis and ringbuffer contention.
4. Add '-W 1' to 'ping -c 1' in test_net_dropmonitor_python.sh and
   test_netdev_times_python.sh, and narrow 'compaction:*' to
   'compaction:mm_compaction_begin,compaction:mm_compaction_end' in
   test_compaction_times_python.sh.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/test_check_perf_trace_python.sh   | 8 +++++---
 tools/perf/tests/shell/test_compaction_times_python.sh   | 8 +++++---
 .../tests/shell/test_event_analyzing_sample_python.sh    | 3 ++-
 tools/perf/tests/shell/test_flamegraph_python.sh         | 5 +++--
 tools/perf/tests/shell/test_futex_contention_python.sh   | 7 ++++---
 tools/perf/tests/shell/test_gecko_python.sh              | 3 ++-
 tools/perf/tests/shell/test_mem_phys_addr_python.sh      | 8 +++++---
 tools/perf/tests/shell/test_net_dropmonitor_python.sh    | 9 +++++----
 tools/perf/tests/shell/test_netdev_times_python.sh       | 6 +++---
 tools/perf/tests/shell/test_powerpc_hcalls_python.sh     | 4 ++--
 tools/perf/tests/shell/test_rw_by_file_python.sh         | 5 +++--
 tools/perf/tests/shell/test_rw_by_pid_python.sh          | 4 ++--
 tools/perf/tests/shell/test_rwtop_python.sh              | 4 ++--
 tools/perf/tests/shell/test_sched_migration_python.sh    | 4 ++--
 tools/perf/tests/shell/test_stackcollapse_python.sh      | 2 +-
 .../tests/shell/test_syscall_counts_by_pid_python.sh     | 6 +++---
 tools/perf/tests/shell/test_syscall_counts_python.sh     | 5 +++--
 tools/perf/tests/shell/test_task_analyzer.sh             | 3 ++-
 tools/perf/tests/shell/test_wakeup_latency_python.sh     | 7 ++++---
 19 files changed, 58 insertions(+), 43 deletions(-)

diff --git a/tools/perf/tests/shell/test_check_perf_trace_python.sh b/tools/perf/tests/shell/test_check_perf_trace_python.sh
index 92cc7b1f0033..baf55945d429 100755
--- a/tools/perf/tests/shell/test_check_perf_trace_python.sh
+++ b/tools/perf/tests/shell/test_check_perf_trace_python.sh
@@ -45,10 +45,11 @@ test_file_mode() {
 	echo "Testing check-perf-trace.py..."
 
 	events=""
-	if perf list | grep -q "irq:softirq_entry"; then
+	tp_list=$(perf list tracepoint)
+	if echo "$tp_list" | grep -q "irq:softirq_entry"; then
 		events="irq:softirq_entry"
 	fi
-	if perf list | grep -q "kmem:kmalloc"; then
+	if echo "$tp_list" | grep -q "kmem:kmalloc"; then
 		if [ -n "$events" ]; then
 			events="$events,kmem:kmalloc,kmem:kfree"
 		else
@@ -62,7 +63,8 @@ test_file_mode() {
 	fi
 
 	# Generate events
-	if ! perf record -e "$events" -a -o "${temp_data}" -- sleep 0.5 >/dev/null 2>&1; then
+	if ! perf record -B -N --no-bpf-event -e "$events" -o "${temp_data}" \
+		-- sh -c "sleep 0.1" >/dev/null 2>&1; then
 		echo "Skipping test, perf record failed"
 		exit 2
 	fi
diff --git a/tools/perf/tests/shell/test_compaction_times_python.sh b/tools/perf/tests/shell/test_compaction_times_python.sh
index 50397afaafed..3f5a71e52388 100755
--- a/tools/perf/tests/shell/test_compaction_times_python.sh
+++ b/tools/perf/tests/shell/test_compaction_times_python.sh
@@ -44,15 +44,17 @@ test_file_mode() {
 	echo "Testing compaction-times.py..."
 
 	# Check for any compaction events to see if kernel supports it
-	if ! perf list | grep -q "compaction:mm_compaction_begin"; then
+	if ! perf list tracepoint | grep -q "compaction:mm_compaction_begin"; then
 		echo "Skipping test, compaction tracepoints not found"
 		exit 2
 	fi
 
 	# Generate some events
-	# We might not naturally trigger compaction in 0.5s sleep, but the script
+	# We might not naturally trigger compaction in 0.1s sleep, but the script
 	# should parse the empty or sparse file correctly without crashing.
-	if ! perf record -e "compaction:*" -a -o "${temp_data}" -- sleep 0.5 >/dev/null 2>&1; then
+	if ! perf record -B -N --no-bpf-event \
+		-e "compaction:mm_compaction_begin,compaction:mm_compaction_end" \
+		-a -o "${temp_data}" -- sleep 0.1 >/dev/null 2>&1; then
 		echo "Skipping test, perf record failed"
 		exit 2
 	fi
diff --git a/tools/perf/tests/shell/test_event_analyzing_sample_python.sh b/tools/perf/tests/shell/test_event_analyzing_sample_python.sh
index a7a8ded003db..5f0a41080acf 100755
--- a/tools/perf/tests/shell/test_event_analyzing_sample_python.sh
+++ b/tools/perf/tests/shell/test_event_analyzing_sample_python.sh
@@ -39,7 +39,8 @@ test_file_mode() {
 	echo "Testing event_analyzing_sample.py..."
 
 	# Generate some events
-	if ! perf record -o "${temp_data}" -- perf test -w noploop >/dev/null 2>&1; then
+	if ! perf record -B -N --no-bpf-event -o "${temp_data}" \
+		-- perf test -w noploop >/dev/null 2>&1; then
 		echo "Skipping test, perf record failed"
 		exit 2
 	fi
diff --git a/tools/perf/tests/shell/test_flamegraph_python.sh b/tools/perf/tests/shell/test_flamegraph_python.sh
index 86313c72f53e..787d6bbdf04a 100755
--- a/tools/perf/tests/shell/test_flamegraph_python.sh
+++ b/tools/perf/tests/shell/test_flamegraph_python.sh
@@ -60,7 +60,8 @@ test_file_mode() {
 	echo "Testing flamegraph.py..."
 
 	# Generate some events with callchains
-	if ! perf record -g -o "${temp_data}" -- perf test -w noploop >/dev/null 2>&1; then
+	if ! perf record -B -N --no-bpf-event -g -o "${temp_data}" \
+		-- perf test -w noploop >/dev/null 2>&1; then
 		echo "Skipping test, perf record -g failed (permissions or lack of support)"
 		exit 2
 	fi
@@ -75,7 +76,7 @@ test_file_mode() {
 
 	# Run the script in pipe ('-') mode and validate JSON output
 	rm -f "${temp_json}"
-	if ! perf record -g -o - -- perf test -w noploop 2>/dev/null | \
+	if ! perf record -B -N --no-bpf-event -g -o - -- perf test -w noploop 2>/dev/null | \
 		perf script flamegraph -i - -f json -o "${temp_json}" >/dev/null; then
 		echo "Pipe stdin JSON mode test failed."
 		err=1
diff --git a/tools/perf/tests/shell/test_futex_contention_python.sh b/tools/perf/tests/shell/test_futex_contention_python.sh
index a8846ed68ac2..41ce8470a75f 100755
--- a/tools/perf/tests/shell/test_futex_contention_python.sh
+++ b/tools/perf/tests/shell/test_futex_contention_python.sh
@@ -89,14 +89,15 @@ EOF
 test_file_mode() {
 	echo "Testing futex-contention.py..."
 	# Some systems might not have syscalls:sys_enter_futex
-	if ! perf list | grep -q syscalls:sys_enter_futex; then
+	if ! perf list tracepoint | grep -q syscalls:sys_enter_futex; then
 		echo "Skipping file mode test, syscalls:sys_enter_futex not found"
 		return
 	fi
 
 	# Generate some futex events
-	if ! perf record -e syscalls:sys_enter_futex,syscalls:sys_exit_futex -a -o "${temp_data}" \
-		-- sleep 0.5 2>/dev/null; then
+	if ! perf record -B -N --no-bpf-event \
+		-e syscalls:sys_enter_futex,syscalls:sys_exit_futex -a -o "${temp_data}" \
+		-- sleep 0.1 2>/dev/null; then
 		echo "Skipping file mode test (record failed)"
 		return
 	fi
diff --git a/tools/perf/tests/shell/test_gecko_python.sh b/tools/perf/tests/shell/test_gecko_python.sh
index de1d7fcf88b7..18e9f5cd2ab0 100755
--- a/tools/perf/tests/shell/test_gecko_python.sh
+++ b/tools/perf/tests/shell/test_gecko_python.sh
@@ -39,7 +39,8 @@ test_file_mode() {
 	echo "Testing gecko.py..."
 
 	# Generate some events with callchains
-	if ! perf record -g -o "${temp_data}" -- perf test -w noploop >/dev/null 2>&1; then
+	if ! perf record -B -N --no-bpf-event -g -o "${temp_data}" \
+		-- perf test -w noploop >/dev/null 2>&1; then
 		echo "Skipping test, perf record -g failed (permissions or lack of support)"
 		exit 2
 	fi
diff --git a/tools/perf/tests/shell/test_mem_phys_addr_python.sh b/tools/perf/tests/shell/test_mem_phys_addr_python.sh
index 451692d5e089..cbb9f572be9d 100755
--- a/tools/perf/tests/shell/test_mem_phys_addr_python.sh
+++ b/tools/perf/tests/shell/test_mem_phys_addr_python.sh
@@ -78,10 +78,12 @@ test_file_mode() {
 	echo "Testing mem-phys-addr.py file mode..."
 
 	# Generate memory access events (try unprivileged user-space first, then system-wide)
-	if ! perf record --phys-data -d -o "${temp_data}" \
+	if ! perf record -B -N --no-bpf-event --phys-data -d -o "${temp_data}" \
 	     -- perf test -w datasym >/dev/null 2>&1 && \
-	   ! perf record -d -o "${temp_data}" -- perf test -w datasym >/dev/null 2>&1 && \
-	   ! perf record -d -a -o "${temp_data}" -- sleep 0.2 >/dev/null 2>&1; then
+	   ! perf record -B -N --no-bpf-event -d -o "${temp_data}" \
+	     -- perf test -w datasym >/dev/null 2>&1 && \
+	   ! perf record -B -N --no-bpf-event -d -a -o "${temp_data}" \
+	     -- sleep 0.1 >/dev/null 2>&1; then
 		echo "Skipping file mode record test, perf record -d not supported"
 		return 0
 	fi
diff --git a/tools/perf/tests/shell/test_net_dropmonitor_python.sh b/tools/perf/tests/shell/test_net_dropmonitor_python.sh
index 05056a897bc9..2e37994418fc 100755
--- a/tools/perf/tests/shell/test_net_dropmonitor_python.sh
+++ b/tools/perf/tests/shell/test_net_dropmonitor_python.sh
@@ -42,11 +42,12 @@ temp_out=$(mktemp /tmp/perf.out.XXXXXX)
 echo "Testing net_dropmonitor.py..."
 
 # Create a perf.data file. Force dropping a packet if tracepoint is available!
-if ! perf record -e skb:kfree_skb -o "${temp_data}" -a \
-	-- ping -c 1 255.255.255.255 >/dev/null 2>&1; then
-	if ! perf record -e skb:kfree_skb -o "${temp_data}" \
+if ! perf record -B -N --no-bpf-event -e skb:kfree_skb -o "${temp_data}" -a \
+	-- ping -c 1 -W 1 255.255.255.255 >/dev/null 2>&1; then
+	if ! perf record -B -N --no-bpf-event -e skb:kfree_skb -o "${temp_data}" \
 		-- sleep 0.1 >/dev/null 2>&1; then
-		if ! perf record -o "${temp_data}" -- uname >/dev/null 2>&1; then
+		if ! perf record -B -N --no-bpf-event -o "${temp_data}" \
+			-- uname >/dev/null 2>&1; then
 			echo "Skipping test, cannot record perf events"
 			exit 2
 		fi
diff --git a/tools/perf/tests/shell/test_netdev_times_python.sh b/tools/perf/tests/shell/test_netdev_times_python.sh
index 393bf446efb2..0d8d10a42cab 100755
--- a/tools/perf/tests/shell/test_netdev_times_python.sh
+++ b/tools/perf/tests/shell/test_netdev_times_python.sh
@@ -85,9 +85,9 @@ then
 fi
 
 # Create a perf.data file. Force dropping a packet if tracepoint is available!
-if ! perf record -e skb:kfree_skb -a -o "${temp_data}" \
-	-- ping -c 1 127.0.0.1 >/dev/null 2>&1; then
-	perf record -e cycles -o "${temp_data}" \
+if ! perf record -B -N --no-bpf-event -e skb:kfree_skb -a -o "${temp_data}" \
+	-- ping -c 1 -W 1 127.0.0.1 >/dev/null 2>&1; then
+	perf record -B -N --no-bpf-event -e cycles -o "${temp_data}" \
 		-- perf test -w noploop >/dev/null 2>&1 || \
 		{ echo "Skipping test, perf record failed"; exit 2; }
 fi
diff --git a/tools/perf/tests/shell/test_powerpc_hcalls_python.sh b/tools/perf/tests/shell/test_powerpc_hcalls_python.sh
index 19569c6d3613..b140ccf00ffa 100755
--- a/tools/perf/tests/shell/test_powerpc_hcalls_python.sh
+++ b/tools/perf/tests/shell/test_powerpc_hcalls_python.sh
@@ -67,8 +67,8 @@ if ! grep -q "H_REMOVE.*1.*1500.*1500.*1500" "${temp_out}"; then
 fi
 
 # Create a perf.data file if powerpc hcall tracepoints are available on this host.
-if ! perf record -e powerpc:hcall_entry,powerpc:hcall_exit -a -o "${temp_data}" \
-	-- perf test -w noploop >/dev/null 2>&1; then
+if ! perf record -B -N --no-bpf-event -e powerpc:hcall_entry,powerpc:hcall_exit \
+	-a -o "${temp_data}" -- perf test -w noploop >/dev/null 2>&1; then
 	echo "Skipping live record test, powerpc hcall tracepoints not available"
 	exit 0
 fi
diff --git a/tools/perf/tests/shell/test_rw_by_file_python.sh b/tools/perf/tests/shell/test_rw_by_file_python.sh
index f121597f418f..e3c538c3ace3 100755
--- a/tools/perf/tests/shell/test_rw_by_file_python.sh
+++ b/tools/perf/tests/shell/test_rw_by_file_python.sh
@@ -37,8 +37,9 @@ temp_out=$(mktemp /tmp/perf.out.XXXXXX)
 echo "Testing rw-by-file.py..."
 
 # Create a perf.data file. Try to get tracepoint data.
-if perf list | grep -q "syscalls:sys_enter_read"; then
-	perf record -e syscalls:sys_enter_read,syscalls:sys_enter_write -a -o "${temp_data}" \
+if perf list tracepoint | grep -q "syscalls:sys_enter_read"; then
+	perf record -B -N --no-bpf-event -e syscalls:sys_enter_read,syscalls:sys_enter_write \
+		-o "${temp_data}" \
 		-- dd if=/dev/urandom of=/dev/null bs=1M count=10 >/dev/null 2>&1 || \
 		{ echo "Skipping test, perf record failed"; exit 2; }
 else
diff --git a/tools/perf/tests/shell/test_rw_by_pid_python.sh b/tools/perf/tests/shell/test_rw_by_pid_python.sh
index 41eaa29097a2..cd93c1d9714c 100755
--- a/tools/perf/tests/shell/test_rw_by_pid_python.sh
+++ b/tools/perf/tests/shell/test_rw_by_pid_python.sh
@@ -41,10 +41,10 @@ temp_out=$(mktemp /tmp/perf.out.XXXXXX)
 echo "Testing rw-by-pid.py..."
 
 # Create a perf.data file. Try to get tracepoint data.
-if perf list | grep -q "syscalls:sys_enter_read"; then
+if perf list tracepoint | grep -q "syscalls:sys_enter_read"; then
 	ev="syscalls:sys_enter_read,syscalls:sys_exit_read"
 	ev="${ev},syscalls:sys_enter_write,syscalls:sys_exit_write"
-	perf record -e "$ev" -a -o "${temp_data}" \
+	perf record -B -N --no-bpf-event -e "$ev" -o "${temp_data}" \
 		-- dd if=/dev/urandom of=/dev/null bs=1M count=10 >/dev/null 2>&1 || \
 		{ echo "Skipping test, perf record failed"; exit 2; }
 else
diff --git a/tools/perf/tests/shell/test_rwtop_python.sh b/tools/perf/tests/shell/test_rwtop_python.sh
index 05897e384702..d33807923c92 100755
--- a/tools/perf/tests/shell/test_rwtop_python.sh
+++ b/tools/perf/tests/shell/test_rwtop_python.sh
@@ -41,10 +41,10 @@ temp_out=$(mktemp /tmp/perf.out.XXXXXX)
 echo "Testing rwtop.py..."
 
 # Create a perf.data file. Try to get tracepoint data.
-if perf list | grep -q "syscalls:sys_enter_read"; then
+if perf list tracepoint | grep -q "syscalls:sys_enter_read"; then
 	ev="syscalls:sys_enter_read,syscalls:sys_exit_read"
 	ev="${ev},syscalls:sys_enter_write,syscalls:sys_exit_write"
-	perf record -e "$ev" -a -o "${temp_data}" \
+	perf record -B -N --no-bpf-event -e "$ev" -o "${temp_data}" \
 		-- dd if=/dev/urandom of=/dev/null bs=1M count=10 >/dev/null 2>&1 || \
 		{ echo "Skipping test, perf record failed"; exit 2; }
 else
diff --git a/tools/perf/tests/shell/test_sched_migration_python.sh b/tools/perf/tests/shell/test_sched_migration_python.sh
index 75465bcd3791..714275b0e492 100755
--- a/tools/perf/tests/shell/test_sched_migration_python.sh
+++ b/tools/perf/tests/shell/test_sched_migration_python.sh
@@ -44,10 +44,10 @@ echo "Testing sched-migration.py..."
 ev="sched:sched_switch,sched:sched_migrate_task"
 ev="${ev},sched:sched_wakeup_new,sched:sched_wakeup"
 has_sched=1
-if ! perf record -e "$ev" -a -o "${temp_data}" \
+if ! perf record -B -N --no-bpf-event -e "$ev" -a -o "${temp_data}" \
 	-- sleep 0.1 >/dev/null 2>&1; then
 	has_sched=0
-	perf record -e cycles -o "${temp_data}" \
+	perf record -B -N --no-bpf-event -e cycles -o "${temp_data}" \
 		-- perf test -w noploop >/dev/null 2>&1 || \
 		{ echo "Skipping test, perf record failed"; exit 2; }
 fi
diff --git a/tools/perf/tests/shell/test_stackcollapse_python.sh b/tools/perf/tests/shell/test_stackcollapse_python.sh
index ce0f80407eec..2048734c5e0d 100755
--- a/tools/perf/tests/shell/test_stackcollapse_python.sh
+++ b/tools/perf/tests/shell/test_stackcollapse_python.sh
@@ -37,7 +37,7 @@ echo "Testing stackcollapse.py..."
 
 # Create a perf.data file with callchains. Use a busy workload rather than
 # sleep, as an idle system may not generate any samples at all.
-perf record -g -o "${temp_data}" \
+perf record -B -N --no-bpf-event -g -o "${temp_data}" \
 		-- perf test -w noploop >/dev/null 2>&1 || \
 		{ echo "Skipping test, perf record failed"; exit 2; }
 
diff --git a/tools/perf/tests/shell/test_syscall_counts_by_pid_python.sh b/tools/perf/tests/shell/test_syscall_counts_by_pid_python.sh
index 45bbdc554c8f..300289fe33b4 100755
--- a/tools/perf/tests/shell/test_syscall_counts_by_pid_python.sh
+++ b/tools/perf/tests/shell/test_syscall_counts_by_pid_python.sh
@@ -43,14 +43,14 @@ temp_out=$(mktemp /tmp/perf.out.XXXXXX)
 test_file_mode() {
 	echo "Testing syscall-counts-by-pid.py..."
 	# Some systems might not have raw_syscalls:sys_enter
-	if ! perf list | grep -q raw_syscalls:sys_enter; then
+	if ! perf list tracepoint | grep -q raw_syscalls:sys_enter; then
 		echo "Skipping test, raw_syscalls:sys_enter not found"
 		exit 2
 	fi
 
 	# Generate some syscall events
-	perf record -e raw_syscalls:sys_enter -a -o "${temp_data}" \
-		-- sleep 0.5 >/dev/null 2>&1 || \
+	perf record -B -N --no-bpf-event -e raw_syscalls:sys_enter -o "${temp_data}" \
+		-- sh -c "sleep 0.1; sleep 0.05" >/dev/null 2>&1 || \
 		{ echo "Skipping test, perf record failed"; exit 2; }
 
 	if ! perf script syscall-counts-by-pid -i "${temp_data}" > "${temp_out}"; then
diff --git a/tools/perf/tests/shell/test_syscall_counts_python.sh b/tools/perf/tests/shell/test_syscall_counts_python.sh
index 310e05d399f9..86463f14391b 100755
--- a/tools/perf/tests/shell/test_syscall_counts_python.sh
+++ b/tools/perf/tests/shell/test_syscall_counts_python.sh
@@ -43,13 +43,14 @@ temp_out=$(mktemp /tmp/perf.out.XXXXXX)
 test_file_mode() {
 	echo "Testing syscall-counts.py..."
 	# Some systems might not have raw_syscalls:sys_enter (e.g. stripped kernels or permissions)
-	if ! perf list | grep -q raw_syscalls:sys_enter; then
+	if ! perf list tracepoint | grep -q raw_syscalls:sys_enter; then
 		echo "Skipping test, raw_syscalls:sys_enter not found"
 		exit 2
 	fi
 
 	# Generate some syscall events
-	if ! perf record -e raw_syscalls:sys_enter -o "${temp_data}" -- sleep 0.5 2>/dev/null; then
+	if ! perf record -B -N --no-bpf-event -e raw_syscalls:sys_enter -o "${temp_data}" \
+		-- sh -c "sleep 0.1; sleep 0.05" 2>/dev/null; then
 		echo "perf record failed (permissions?), skipping file mode test."
 		exit 2
 	fi
diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/tests/shell/test_task_analyzer.sh
index f99a637a6099..f53fa4a27c79 100755
--- a/tools/perf/tests/shell/test_task_analyzer.sh
+++ b/tools/perf/tests/shell/test_task_analyzer.sh
@@ -60,7 +60,8 @@ skip_no_probe_record_support() {
 
 prepare_perf_data() {
 	# 1s should be sufficient to catch at least some switches
-	perf record -e sched:sched_switch -a -o "${perfdata}" -- sleep 1 > /dev/null 2>&1
+	perf record -B -N --no-bpf-event -e sched:sched_switch -a -o "${perfdata}" \
+		-- sleep 1 > /dev/null 2>&1
 	# check if perf data file got created in above step.
 	if [ ! -e "${perfdata}" ]; then
 		printf "FAIL: perf record failed to create \"${perfdata}\" \n"
diff --git a/tools/perf/tests/shell/test_wakeup_latency_python.sh b/tools/perf/tests/shell/test_wakeup_latency_python.sh
index cb2571449168..b43a86996be2 100755
--- a/tools/perf/tests/shell/test_wakeup_latency_python.sh
+++ b/tools/perf/tests/shell/test_wakeup_latency_python.sh
@@ -41,9 +41,9 @@ temp_out=$(mktemp /tmp/perf.out.XXXXXX)
 echo "Testing wakeup-latency.py..."
 
 # Create a perf.data file. Try to get tracepoint data.
-if perf list | grep -q "sched:sched_wakeup"; then
+if perf list tracepoint | grep -q "sched:sched_wakeup"; then
 	ev="sched:sched_wakeup,sched:sched_wakeup_new,sched:sched_switch"
-	perf record -e "$ev" -a -o "${temp_data}" \
+	perf record -B -N --no-bpf-event -e "$ev" -a -o "${temp_data}" \
 		-- sleep 0.1 >/dev/null 2>&1 || \
 		{ echo "Skipping test, perf record failed"; exit 2; }
 else
@@ -70,7 +70,8 @@ else
 fi
 
 # Also test zero-wakeups / unhandled events path to verify division-by-zero protection
-if perf record -e cycles -o "${temp_data}" -- perf test -w noploop >/dev/null 2>&1; then
+if perf record -B -N --no-bpf-event -e cycles -o "${temp_data}" \
+	-- perf test -w noploop >/dev/null 2>&1; then
 	if ! perf script wakeup-latency -i "${temp_data}" > "${temp_out}" || \
 	   ! grep -q "avg_wakeup_latency (ns): N/A" "${temp_out}"; then
 		echo "wakeup-latency zero-wakeups guard test failed"
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

