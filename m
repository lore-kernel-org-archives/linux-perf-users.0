Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C1B2EB5D2;
	Wed, 15 Oct 2025 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549740; cv=none; b=i5h4jmScsh5ZitQTRsrS0Bkhr8WrddD9qctFD7dUBw94y75zbs31gKnNNbvAMKMScJKII7zRzkWHW8SlIgL3xld9xo5Z9Sm96sE8/P+upXdaB2LLwOc/Gih19F7SWopXTkwmFovw5NjABPMnXB6K6QtkQEcCQ9QL79egtPg/oGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549740; c=relaxed/simple;
	bh=T+2SuhOA2afglVFTHOYDaZhsu+gmgdjZWQxw8xZEfCE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=hA5DJ4ngDQ/DI1W0pS+4BKi4pf2LbCxWzOcWw/l531Zlzyvz60IhwiYSDDr1OB9RJD70PidzLNzroCBR3vkNZ3Bq57xo5DCj4loN3T4Ok48xHlDCTTvx9wtsAy0Ta5p3tR4QKKVdRRHUw2DKPdZQjBG03Cz6qghWN4/7DxkOs1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvPu7RbG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvPu7RbG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA28C19422;
	Wed, 15 Oct 2025 17:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760549740;
	bh=T+2SuhOA2afglVFTHOYDaZhsu+gmgdjZWQxw8xZEfCE=;
	h=Date:From:To:Cc:Subject:References:From;
	b=RvPu7RbGBeVBCcmUojsDP2Ekoamnkw+e+bjHJzBT2lmdXwLJ6tZzJWRqG36Fmi7gm
	 1A6f0287JMoqcQTJDBnrmStBYnTHQbL+Fiy4+cIzSqjYK72cgsB7zbMhW467lXMQVG
	 3roTlH19dCKXpWnIoc2zkzI2GkvT1WWTAd7jp5DQnCzqVLZtQeTZ4DfXEF9CXsEiZq
	 mPoZ1hywnoG+gY5GODtBiRW8ijok8jrQnQsXFZFhLpOweL0N+RvhYz8gpsevvYpu7q
	 DJ6gMpDLdXo1i27mAfOTfBRyC80XdP/O0gXIo7vBnyGSUM3KAUfaI1JJpJ9tkkje7p
	 LKs/RzAE5g/3Q==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v95Pg-000000011wT-2tb2;
	Wed, 15 Oct 2025 13:35:48 -0400
Message-ID: <20251015173548.540984239@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 15 Oct 2025 13:32:17 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>,
 Tom Zanussi <zanussi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ian Rogers <irogers@google.com>,
 Douglas Raillard <douglas.raillard@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v3 03/13] perf: tracing: Simplify perf_sysenter_enable/disable() with guards
References: <20251015173214.760495866@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Use guard(mutex)(&syscall_trace_lock) for perf_sysenter_enable() and
perf_sysenter_disable() as well as for the perf_sysexit_enable() and
perf_sysexit_disable(). This will make it easier to update these functions
with other code that has early exit handling.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_syscalls.c | 42 +++++++++++++++++------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 98670006ebeb..8f3432014da4 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -1009,21 +1009,21 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 
 static int perf_sysenter_enable(struct trace_event_call *call)
 {
-	int ret = 0;
+	int ret;
 	int num;
 
 	num = ((struct syscall_metadata *)call->data)->syscall_nr;
 
-	mutex_lock(&syscall_trace_lock);
-	if (!sys_perf_refcount_enter)
+	guard(mutex)(&syscall_trace_lock);
+	if (!sys_perf_refcount_enter) {
 		ret = register_trace_sys_enter(perf_syscall_enter, NULL);
-	if (ret) {
-		pr_info("event trace: Could not activate syscall entry trace point");
-	} else {
-		set_bit(num, enabled_perf_enter_syscalls);
-		sys_perf_refcount_enter++;
+		if (ret) {
+			pr_info("event trace: Could not activate syscall entry trace point");
+			return ret;
+		}
 	}
-	mutex_unlock(&syscall_trace_lock);
+	set_bit(num, enabled_perf_enter_syscalls);
+	sys_perf_refcount_enter++;
 	return ret;
 }
 
@@ -1033,12 +1033,11 @@ static void perf_sysenter_disable(struct trace_event_call *call)
 
 	num = ((struct syscall_metadata *)call->data)->syscall_nr;
 
-	mutex_lock(&syscall_trace_lock);
+	guard(mutex)(&syscall_trace_lock);
 	sys_perf_refcount_enter--;
 	clear_bit(num, enabled_perf_enter_syscalls);
 	if (!sys_perf_refcount_enter)
 		unregister_trace_sys_enter(perf_syscall_enter, NULL);
-	mutex_unlock(&syscall_trace_lock);
 }
 
 static int perf_call_bpf_exit(struct trace_event_call *call, struct pt_regs *regs,
@@ -1115,21 +1114,21 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
 
 static int perf_sysexit_enable(struct trace_event_call *call)
 {
-	int ret = 0;
+	int ret;
 	int num;
 
 	num = ((struct syscall_metadata *)call->data)->syscall_nr;
 
-	mutex_lock(&syscall_trace_lock);
-	if (!sys_perf_refcount_exit)
+	guard(mutex)(&syscall_trace_lock);
+	if (!sys_perf_refcount_exit) {
 		ret = register_trace_sys_exit(perf_syscall_exit, NULL);
-	if (ret) {
-		pr_info("event trace: Could not activate syscall exit trace point");
-	} else {
-		set_bit(num, enabled_perf_exit_syscalls);
-		sys_perf_refcount_exit++;
+		if (ret) {
+			pr_info("event trace: Could not activate syscall exit trace point");
+			return ret;
+		}
 	}
-	mutex_unlock(&syscall_trace_lock);
+	set_bit(num, enabled_perf_exit_syscalls);
+	sys_perf_refcount_exit++;
 	return ret;
 }
 
@@ -1139,12 +1138,11 @@ static void perf_sysexit_disable(struct trace_event_call *call)
 
 	num = ((struct syscall_metadata *)call->data)->syscall_nr;
 
-	mutex_lock(&syscall_trace_lock);
+	guard(mutex)(&syscall_trace_lock);
 	sys_perf_refcount_exit--;
 	clear_bit(num, enabled_perf_exit_syscalls);
 	if (!sys_perf_refcount_exit)
 		unregister_trace_sys_exit(perf_syscall_exit, NULL);
-	mutex_unlock(&syscall_trace_lock);
 }
 
 #endif /* CONFIG_PERF_EVENTS */
-- 
2.51.0


