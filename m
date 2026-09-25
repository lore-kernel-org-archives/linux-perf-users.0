Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C319D47F778;
	Fri, 25 Sep 2026 11:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790334701; cv=none; b=dHNFA/+xuUg+tWVxUO7rwYSA0klUWM9cRtusy64gFJBSrBsVs+p2apfRtZ1H/y6SVDtSk4t64Mr0mTFQNaXqWuLuBbDKuqWuh+YJIu7bUbPmlN9OEml2R6mjcUelAQRf3kWiR0k1QvZuxvJClkLJnXs7JXy+KLDPzZgIOp2PNak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790334701; c=relaxed/simple;
	bh=KGClkuKaUup4lCgi0hiMD2W62qNnYOQ5xSa3Rbyi+3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MztDp1HmGcuo8yVIYhh85FtfecAj+/H2HC2HQBgDv9eVCe/JeyjoU+VhfQCYMk1BtRUo1mgAiBmp9rGa2cIkvTEm9/MlgPnfg2mbtPVssp0W30ho6nI50U50WyufEtcw1aIOjFiFw3pYrCVJHYQQG6buKjbaLY2WUDDGVvoV8+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcQ8lQEy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcQ8lQEy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B07A1F000FF;
	Fri, 25 Sep 2026 11:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790334699;
	bh=7AfOVXhNr6aVAS93mjjDI1zHRc5gJSUYX5m1TeHMjbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UcQ8lQEyVJJseW0HcSUKhkWo7UXHZl5Kd253Eeky/jbi/l1ESUSi7MzSPvOdvQ8xA
	 sU8NoSmHM8SgRyEp8wJD6c0rEpj4DPJWe1gxilagy3b6RRr5lMo5KZAo6epy36PoRC
	 qAzncL0VFKpgLImY18w3QHCH3p294DIU9rbhK9tGeMCNNgWpPWtgEZ+OBkXmjrkXON
	 AeON+IUgUIIaHgIl6FmObMzP/+Lb1TT5vw1p7c577omkRjdZQGmfmnrvUVvgbYiSYm
	 Hqsa1hX/s0FEZCVmAmfE7jC6k4XEG1iKBx/eDbg0ZcrYWjksnV1ZRFVe7XsZ2pRn43
	 nl6xkLd9bGqDQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Jinchao Wang <wangjinchao600@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v18 03/11] perf/hw_breakpoint: Add register_wide_hw_breakpoint_cpuslocked() API
Date: Fri, 25 Sep 2026 20:11:29 +0900
Message-ID: <179033468904.136630.17162448537904534428.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179033464327.136630.864883694296882051.stgit@devnote2>
References: <179033464327.136630.864883694296882051.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add register_wide_hw_breakpoint_cpuslocked() which registers a wide
hardware breakpoint across all online CPUs while caller holds
cpus_read_lock(). This allows callers who need to perform additional
setup under cpus_read_lock() without releasing it to avoid races with
CPU hotplug and without triggering recursive lockdep warnings.

Refactor register_wide_hw_breakpoint() as a wrapper around
register_wide_hw_breakpoint_cpuslocked().

Assisted-by: LLM
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/hw_breakpoint.h |    9 +++++++++
 kernel/events/hw_breakpoint.c |   38 ++++++++++++++++++++++++++++++++------
 2 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index bf65c7fffd99..65efe55fef14 100644
--- a/include/linux/hw_breakpoint.h
+++ b/include/linux/hw_breakpoint.h
@@ -76,6 +76,11 @@ register_wide_hw_breakpoint_cpu(struct perf_event_attr *attr,
 				void *context,
 				int cpu);
 
+extern struct perf_event * __percpu *
+register_wide_hw_breakpoint_cpuslocked(struct perf_event_attr *attr,
+				       perf_overflow_handler_t triggered,
+				       void *context);
+
 extern struct perf_event * __percpu *
 register_wide_hw_breakpoint(struct perf_event_attr *attr,
 			    perf_overflow_handler_t triggered,
@@ -123,6 +128,10 @@ register_wide_hw_breakpoint_cpu(struct perf_event_attr *attr,
 				void *context,
 				int cpu)		{ return NULL; }
 static inline struct perf_event * __percpu *
+register_wide_hw_breakpoint_cpuslocked(struct perf_event_attr *attr,
+				       perf_overflow_handler_t triggered,
+				       void *context)		{ return NULL; }
+static inline struct perf_event * __percpu *
 register_wide_hw_breakpoint(struct perf_event_attr *attr,
 			    perf_overflow_handler_t triggered,
 			    void *context)		{ return NULL; }
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 69bfb17b87c4..5627ad97600a 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -832,27 +832,30 @@ void unregister_hw_breakpoint(struct perf_event *bp)
 EXPORT_SYMBOL_GPL(unregister_hw_breakpoint);
 
 /**
- * register_wide_hw_breakpoint - register a wide breakpoint in the kernel
+ * register_wide_hw_breakpoint_cpuslocked - register a wide breakpoint with cpus locked
  * @attr: breakpoint attributes
  * @triggered: callback to trigger when we hit the breakpoint
  * @context: context data could be used in the triggered callback
  *
+ * Same as register_wide_hw_breakpoint(), but caller must hold cpus_read_lock().
+ *
  * @return a set of per_cpu pointers to perf events
  */
 struct perf_event * __percpu *
-register_wide_hw_breakpoint(struct perf_event_attr *attr,
-			    perf_overflow_handler_t triggered,
-			    void *context)
+register_wide_hw_breakpoint_cpuslocked(struct perf_event_attr *attr,
+				       perf_overflow_handler_t triggered,
+				       void *context)
 {
 	struct perf_event * __percpu *cpu_events, *bp;
 	long err = 0;
 	int cpu;
 
+	lockdep_assert_cpus_held();
+
 	cpu_events = alloc_percpu(typeof(*cpu_events));
 	if (!cpu_events)
 		return ERR_PTR_PCPU(-ENOMEM);
 
-	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		bp = perf_event_create_kernel_counter(attr, cpu, NULL,
 						      triggered, context);
@@ -863,7 +866,6 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 
 		per_cpu(*cpu_events, cpu) = bp;
 	}
-	cpus_read_unlock();
 
 	if (likely(!err))
 		return cpu_events;
@@ -871,6 +873,30 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 	unregister_wide_hw_breakpoint(cpu_events);
 	return ERR_PTR_PCPU(err);
 }
+EXPORT_SYMBOL_GPL(register_wide_hw_breakpoint_cpuslocked);
+
+/**
+ * register_wide_hw_breakpoint - register a wide breakpoint in the kernel
+ * @attr: breakpoint attributes
+ * @triggered: callback to trigger when we hit the breakpoint
+ * @context: context data could be used in the triggered callback
+ *
+ * @return a set of per_cpu pointers to perf events
+ */
+struct perf_event * __percpu *
+register_wide_hw_breakpoint(struct perf_event_attr *attr,
+			    perf_overflow_handler_t triggered,
+			    void *context)
+{
+	struct perf_event * __percpu *cpu_events;
+
+	cpus_read_lock();
+	cpu_events = register_wide_hw_breakpoint_cpuslocked(attr, triggered,
+							    context);
+	cpus_read_unlock();
+
+	return cpu_events;
+}
 EXPORT_SYMBOL_GPL(register_wide_hw_breakpoint);
 
 /**

