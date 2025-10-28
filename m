Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05A83596FB;
	Tue, 28 Oct 2025 23:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761693068; cv=none; b=VGoKlucgTFUr1jqSBhu8yoOtbKXDLbkVHERbvw9NWqpmWr5xHjYBym+NAYGFrCwlSopIiQibBH1gjbUzS90C7nl+/mnsv8Vwp5vqciMvvtvTIMillPwTddQtjUfKNtslH45qMsx1sXDN0Xr4cUP5qXm6QNjuN+z+bzJOYaSLauo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761693068; c=relaxed/simple;
	bh=WLsBwXREdr0DyUqjdCg2PWKUh9JaCW/A96J4RdAFlf4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=CvPZljyF+nMyux8Xj9lC7bdQOKEat04SfAM14XlHoR3iJhXAtkpwlKQKHtq4y3yF7PbjbsEoNTX7K90z4KXxlWRBREpKxzfNJxL9Qg3WYDQ58rj1YWqjGbMrp5+kh/3RKRXA+XH7wtfdii9sNq9CPXHR/drGFRjuzhQA2npk68A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6ep1J5R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6ep1J5R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4954AC116B1;
	Tue, 28 Oct 2025 23:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761693068;
	bh=WLsBwXREdr0DyUqjdCg2PWKUh9JaCW/A96J4RdAFlf4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=p6ep1J5RFKLOizMslwbFGSSaCij/hxdsUSEToSe+eexDfZASXEs4h096u5BdA3EIg
	 m0+u4N3i2eIGQUhFdFyPbckQ1gHl5hUbRzhmefun5sRbmFEtt4UePG43TA4f5e5qLM
	 zLBlUU6eir3pOiYV+ND6vA5trK4RFbLJgzcVdPKIGzKC1B/NVf7jD0biC9g+icbOv5
	 6MAOnlrD0cl9mtAcFVm/tKTwtDPrn113rZqpZoxMOZBaytSuj0VNltUIPug7UHNXyr
	 /lQse05rm/v+4FhbX0/CDE9vP82EIcfeTFHkHHqjVAp3nky6B3SA51FPTpKArOWSzJ
	 +fM8/aJifTU9g==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vDsqx-00000004qqD-2PPU;
	Tue, 28 Oct 2025 19:11:47 -0400
Message-ID: <20251028231147.429583335@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 28 Oct 2025 19:11:17 -0400
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
Subject: [PATCH v5 03/13] perf: tracing: Simplify perf_sysenter_enable/disable() with guards
References: <20251028231114.820213884@kernel.org>
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
 kernel/trace/trace_syscalls.c | 48 ++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 528ac90eda5d..42d066d8c0ab 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -1049,22 +1049,21 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 
 static int perf_sysenter_enable(struct trace_event_call *call)
 {
-	int ret = 0;
 	int num;
 
 	num = ((struct syscall_metadata *)call->data)->syscall_nr;
 
-	mutex_lock(&syscall_trace_lock);
-	if (!sys_perf_refcount_enter)
-		ret = register_trace_sys_enter(perf_syscall_enter, NULL);
-	if (ret) {
-		pr_info("event trace: Could not activate syscall entry trace point");
-	} else {
-		set_bit(num, enabled_perf_enter_syscalls);
-		sys_perf_refcount_enter++;
+	guard(mutex)(&syscall_trace_lock);
+	if (!sys_perf_refcount_enter) {
+		int ret = register_trace_sys_enter(perf_syscall_enter, NULL);
+		if (ret) {
+			pr_info("event trace: Could not activate syscall entry trace point");
+			return ret;
+		}
 	}
-	mutex_unlock(&syscall_trace_lock);
-	return ret;
+	set_bit(num, enabled_perf_enter_syscalls);
+	sys_perf_refcount_enter++;
+	return 0;
 }
 
 static void perf_sysenter_disable(struct trace_event_call *call)
@@ -1073,12 +1072,11 @@ static void perf_sysenter_disable(struct trace_event_call *call)
 
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
@@ -1155,22 +1153,21 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
 
 static int perf_sysexit_enable(struct trace_event_call *call)
 {
-	int ret = 0;
 	int num;
 
 	num = ((struct syscall_metadata *)call->data)->syscall_nr;
 
-	mutex_lock(&syscall_trace_lock);
-	if (!sys_perf_refcount_exit)
-		ret = register_trace_sys_exit(perf_syscall_exit, NULL);
-	if (ret) {
-		pr_info("event trace: Could not activate syscall exit trace point");
-	} else {
-		set_bit(num, enabled_perf_exit_syscalls);
-		sys_perf_refcount_exit++;
+	guard(mutex)(&syscall_trace_lock);
+	if (!sys_perf_refcount_exit) {
+		int ret = register_trace_sys_exit(perf_syscall_exit, NULL);
+		if (ret) {
+			pr_info("event trace: Could not activate syscall exit trace point");
+			return ret;
+		}
 	}
-	mutex_unlock(&syscall_trace_lock);
-	return ret;
+	set_bit(num, enabled_perf_exit_syscalls);
+	sys_perf_refcount_exit++;
+	return 0;
 }
 
 static void perf_sysexit_disable(struct trace_event_call *call)
@@ -1179,12 +1176,11 @@ static void perf_sysexit_disable(struct trace_event_call *call)
 
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


