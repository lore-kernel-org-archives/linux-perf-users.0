Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794806793;
	b=i0gpoA/ajsqMdQME76lPYd1bN9nD9hBs6NUrFUs86PvMcQaBgeNrecgmj8GcvE4c286p
	 FzBPTgYgytjZdI6mJH2wCT3smpKRGdyMMMLnEJLP049J6OtNStwnucucwStEoAbANGcLc
	 YPnTjIlQEIdc4na5uHHooXbtQNpnVW8ihi2UXDmfKU+UUTA7sDDOoib2L/bfJAw/nsiUS
	 PxkevJD0qaShFvqnVnjFg+EtMuI5pEMF0jRPyJaMgcjtx4GM1g99oywJ0oE3gCwg5/jwI
	 F7bEjY0dh+2o0OL1KFHm4yV7mAffSzaw/wjFCQ6S8N/2JYemT9FxvZBKLzq5rRPNUAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794806793;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pzcxF9dmdAnHsvUYbCmJEytR73WpBUV4vwbXEVq9Dg4=;
	b=J1NIABoRvzuAnzVVBE8mGdEPj45fIdy+MC4m2K9P2n8GNc5zBKnrj4uVpghuWxo7uin2
	 1SbD/4xF2rDKHuSaq83cFrPZcuk7PwHjH8FLAM7ArnwAYp/hfBr4TxQEFO900Ooix5BI8
	 onbRQHNYQ/eOaGUXnpYCMtxayW0ZEH/BbFypYxUHDmyYhgOUo1IY4Vy8iXkFHoRa1dstl
	 LaB95HyTw30wqsQ8MAhI6i3T0jWIk1zLRlacifM69oKAWaUyBIaold1f3DiSKJR4W0nkH
	 KBNheSRIvfEGufAPjy4DGUkogzGVdhC9I3N+I95BE/B8IVzMGGUpEXbGgBgRKEx/qjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mDZm05it;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD78606A31C;
	Mon, 16 Nov 2026 05:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mDZm05it
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3B81F000CA;
	Mon, 16 Nov 2026 05:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794806793;
	bh=pzcxF9dmdAnHsvUYbCmJEytR73WpBUV4vwbXEVq9Dg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mDZm05itf1gq3gomcVgG4enpqMWMw08aFKRC1rAlBtrpD7RpN3F47QbRQAAqRP4ZO
	 NZmT637NzK4+3rOkeEULyWXfIYjFz1Q6gW3adLW1Syjcj59gcgzSigp4CQD/WbbdwL
	 98U+pV2Wg6IJ+ig49GOHQNRsCqBcb7YutQ3qKkQTD6Jm+aVT5pq4EYV18dta/7zuPt
	 fgKugEKAUhH/FKtHjym755Y0pO/Gct5Uz6KjRjsUq+g8r6XNTqUoRALKMtDxnd09Dv
	 /YxAlUG6+ev11V+gy7FKJZQXlyGVsPDcZVYBU+9v5ULoaqX8AIYwXl5cABpaMx+88N
	 13RFzBjwc1pjg==
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
Subject: [PATCH v20 03/11] perf/hw_breakpoint: Add register_wide_hw_breakpoint_cpuslocked() API
Date: Mon, 16 Nov 2026 14:26:27 +0900
Message-ID: <179480678718.38065.12946617307937403078.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179480675130.38065.3086970856119381693.stgit@devnote2>
References: <179480675130.38065.3086970856119381693.stgit@devnote2>
User-Agent: StGit/0.19
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
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add register_wide_hw_breakpoint_cpuslocked() which registers a wide
hardware breakpoint across all online CPUs while caller holds
cpus_read_lock(). This allows callers who need to perform additional
setup under cpus_read_lock() without releasing it to avoid races with
CPU hotplug and without triggering recursive lockdep warnings.

Refactor register_wide_hw_breakpoint() as a wrapper around
register_wide_hw_breakpoint_cpuslocked().

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

