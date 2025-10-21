Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF8020DD75;
	Tue, 21 Oct 2025 00:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761007932; cv=none; b=SBFtNaB4/wXwTuoAhE1Os5GK/1ayfimvfo2oIrWVMSv5hExCWjiyw709Qn7BT1H16e2PoKPtoL/Q9Z0jcY99zPqnKEM5s/NXtBMTZw4NReZrOnRV0ZKHRECdZ1tE1qojbprjFKythgQk0pSgCnCMnQpn0vaVk2acKKLqMxDNB40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761007932; c=relaxed/simple;
	bh=FtPSkh9WMwl4wkrtIAn1asLiI0u6fA3/6q3EIYkcjNI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=iloxs/lwrmcy0CO+93EVNmCoxPtTRtH2IVcg6KpFiwM/EsNZ/Y33/MA5WjM3ePlu24K9ZtRa7th65nClspXqAaGdaOu0GCaZHhnUVoNp6dV2+JnOzohbfNoWC7ciU75oWaUI59QKA9u4w78RH1LLIoVNty7FxyH/cMuDIJNwj+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjoqYaRG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjoqYaRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1706EC19424;
	Tue, 21 Oct 2025 00:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761007932;
	bh=FtPSkh9WMwl4wkrtIAn1asLiI0u6fA3/6q3EIYkcjNI=;
	h=Date:From:To:Cc:Subject:References:From;
	b=NjoqYaRG5k0XWeKlLts8wyhRxfS3YJdy0tQOEKi7QQbQsuQb8UENo/wbtaRUhFZw0
	 SlMPmvxfXicAjatSU22bssVKJXq/CHHUuPDK9khFbs7u/ghnt9QwUmgv0URqGYvVPU
	 iNQVDq8xKQfVT/k9bAUi+wqmGvGKEMzX2stOkMGmQEzhiA5bQoMN1mHaNOLVGZLdGq
	 lIK/q/XMO3UbX3LcoKXx40rv87FVb2FeS5cVLtFjj+7cGnPrbeYQPGO04vMATcqPoe
	 dwuwPM4t496N1OHKIVi8/6PnjBEP/qzgnAG3hPOow1NO9sGId0sLhc7ge/FxfXwrpp
	 jOahTOckirAAg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vB0c4-0000000206O-3n9i;
	Mon, 20 Oct 2025 20:52:32 -0400
Message-ID: <20251021005232.758121204@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 20 Oct 2025 20:51:58 -0400
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
Subject: [PATCH v4 03/13] perf: tracing: Simplify perf_sysenter_enable/disable() with guards
References: <20251021005155.705735078@kernel.org>
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
Changes since v3: https://lore.kernel.org/20251015173548.540984239@kernel.org

- Fixed return value of perf_sysenter_enable() and perf_sysexit_enable()
  to not return undefined value (kernel test robot)

 kernel/trace/trace_syscalls.c | 48 ++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 98670006ebeb..de2b6e285fc5 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -1009,22 +1009,21 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 
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
@@ -1033,12 +1032,11 @@ static void perf_sysenter_disable(struct trace_event_call *call)
 
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
@@ -1115,22 +1113,21 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
 
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
@@ -1139,12 +1136,11 @@ static void perf_sysexit_disable(struct trace_event_call *call)
 
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


