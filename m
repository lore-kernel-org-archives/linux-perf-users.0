Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1972515E5DC
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 19:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874132; cv=none; b=Aszy5d1cabZU4xlXdA0QOv3eek6b5bvQc7ob3OR9Qrg6wtSF8OJSPoIeqFX19Mzmkg2FbzyfHnhy4DUE+NEZByGgD3g/fmLnzP/7Lj0Vwe9lsXhgi45pS4b1PyDn3R7U7WeAHFFSQqmHjrbGQxLlxo6A8x5gp5/sc8brRU2XnmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874132; c=relaxed/simple;
	bh=RZzinb8wPxlvXfXvn9/c2jxj5+Q9BtBLM+Amx3gxCBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fpjxe6fOIPfWX6OhwIbsPna/yc4JWLXlhrgkLWRfzRzJ8obMaaQ7W8KQ97l6Znz2P5Tt3F4rTW6ATAU7mddR89K7dc3G6kC9tJMwHoxuWVOhVlUtqYvuzQn/8n6TEnTJ8GIhbav9nKoy0z9DcVxJ56d/IbkHScTX2yD0KZh/QKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CpnfoDRP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpnfoDRP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778874130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HmfrO3S2sd5h9l3v0OdWSyyvWkGpnH45ni/babXstNc=;
	b=CpnfoDRPOGspOqb16QnGslPAdYnglMY7XkzK5x1IwuOe2G5Zk7yatMM+/rSZpcLuWVT0UZ
	tBvZHacoV2hYRC3u/epfEImJg9fFILg4paxUDAzijxT6xKcgx15PwHr0yCiOfUQYkBJy6Y
	pf1l2ue9d4VnfjL7VAv538yXGcYoHTk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-68pOIMEBPo21rWCBkHY1Kw-1; Fri,
 15 May 2026 15:42:04 -0400
X-MC-Unique: 68pOIMEBPo21rWCBkHY1Kw-1
X-Mimecast-MFC-AGG-ID: 68pOIMEBPo21rWCBkHY1Kw_1778874122
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D10CF18002D6;
	Fri, 15 May 2026 19:42:01 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.22.80.109])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 448661956053;
	Fri, 15 May 2026 19:41:59 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: mpetlan@redhat.com,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Falcon <thomas.falcon@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v4 2/3] perf: enable unprivileged syscall tracing with perf trace
Date: Fri, 15 May 2026 15:40:06 -0400
Message-ID: <20260515194010.93725-4-ashelat@redhat.com>
In-Reply-To: <20260515194010.93725-2-ashelat@redhat.com>
References: <20260515194010.93725-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Allow unprivileged users to trace their own processes' syscalls using
perf trace, similar to strace without the intrusive overhead of ptrace().

Currently, perf trace requires CAP_PERFMON or paranoid level ≤ 1 even
though the kernel has existing infrastructure (TRACE_EVENT_FL_CAP_ANY)
specifically designed to mark syscall tracepoints as safe for
unprivileged access. To fix this:

1. Loosen the condition in perf_event_open() which requires privileges
   for all events with exclude_kernel=0. This allows perf_event_open() to
   bypass the paranoid check for task-attached tracepoint events. Ensure
   that sample types which can expose kernel addresses to unprivileged
   users are blocked. Ensure the PERF_SECURITY_KERNEL LSM hook is
   preserved.

2. Make the format and id tracefs files world-readable only for tracepoints
   with TRACE_EVENT_FL_CAP_ANY, allowing unprivileged users to see syscall
   tracepoint ids without exposing sensitive information.

3. Add a check to perf_trace_event_perm() to block PERF_SAMPLE_IP on
   kernel tracepoints for unprivileged users to prevent KASLR bypass. We do
   this here rather than in kaddr_leak because perf_trace_event_perm() can
   distinguish between kernel tracepoints and uprobe tracepoints, where the
   IP is a safe user space address and is necessary for uprobe
   functionality.

4. Restrict pure counting events (no PERF_SAMPLE_RAW) to
   TRACE_EVENT_FL_CAP_ANY tracepoints preventing unprivileged users from
   counting internal kernel tracepoints while preserving current
   behavior for exclude_kernel=1 events.

Example usage after this change:
  $ perf trace ls          # works as unprivileged user
  $ perf trace             # system-wide, still requires privileges
  $ perf trace -p 1234     # requires ptrace permission on pid 1234

Assisted-by: Claude:claude-sonnet-4.5
Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 kernel/events/core.c            | 28 +++++++++++++++++++++++++---
 kernel/trace/trace_event_perf.c | 21 ++++++++++++++++++++-
 kernel/trace/trace_events.c     | 16 ++++++++++++++--
 3 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7935d5663944..ff2d1e9a0b79 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13873,9 +13873,31 @@ SYSCALL_DEFINE5(perf_event_open,
 		return err;
 
 	if (!attr.exclude_kernel) {
-		err = perf_allow_kernel();
-		if (err)
-			return err;
+		bool tp_bypass = false;
+
+		/* Check unprivileged tracepoints */
+		if (attr.type == PERF_TYPE_TRACEPOINT && pid != -1) {
+			/*
+			 * Block sample types that expose kernel addresses to
+			 * prevent KASLR bypass
+			 */
+			u64 kaddr_leak = PERF_SAMPLE_CALLCHAIN |
+					 PERF_SAMPLE_BRANCH_STACK |
+					 PERF_SAMPLE_ADDR |
+					 PERF_SAMPLE_REGS_INTR;
+
+			tp_bypass = !(attr.sample_type & kaddr_leak);
+		}
+
+		if (!tp_bypass) {
+			err = perf_allow_kernel();
+			if (err)
+				return err;
+		} else {
+			err = security_perf_event_open(PERF_SECURITY_KERNEL);
+			if (err)
+				return err;
+		}
 	}
 
 	if (attr.namespaces) {
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index a6bb7577e8c5..466007ed2869 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -72,9 +72,28 @@ static int perf_trace_event_perm(struct trace_event_call *tp_event,
 			return -EINVAL;
 	}
 
+	/*
+	 * PERF_SAMPLE_IP on kernel tracepoints exposes a kernel text
+	 * address, weakening KASLR. Block for unprivileged users unless
+	 * the tracepoint is a uprobe (userspace IP, safe to expose).
+	 */
+	if ((p_event->attr.sample_type & PERF_SAMPLE_IP) &&
+	    !p_event->attr.exclude_kernel &&
+	    !(tp_event->flags & TRACE_EVENT_FL_UPROBE) &&
+	    sysctl_perf_event_paranoid > 1 && !perfmon_capable())
+		return -EACCES;
+
 	/* No tracing, just counting, so no obvious leak */
-	if (!(p_event->attr.sample_type & PERF_SAMPLE_RAW))
+	if (!(p_event->attr.sample_type & PERF_SAMPLE_RAW)) {
+		/* Prevent unprivileged users from counting kernel tracepoints */
+		if (!p_event->attr.exclude_kernel &&
+		    sysctl_perf_event_paranoid > 1 && !perfmon_capable()) {
+			if (!(p_event->attach_state == PERF_ATTACH_TASK &&
+			      (tp_event->flags & TRACE_EVENT_FL_CAP_ANY)))
+				return -EACCES;
+		}
 		return 0;
+	}
 
 	/* Some events are ok to be traced by non-root users... */
 	if (p_event->attach_state == PERF_ATTACH_TASK) {
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c46e623e7e0d..cbd07e2ec528 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3050,7 +3050,13 @@ static int event_callback(const char *name, umode_t *mode, void **data,
 	struct trace_event_call *call = file->event_call;
 
 	if (strcmp(name, "format") == 0) {
-		*mode = TRACE_MODE_READ;
+		/*
+		 * Make format tracefs file world readable for tracepoints with
+		 * TRACE_EVENT_FL_CAP_ANY
+		 */
+		*mode = (call->flags & TRACE_EVENT_FL_CAP_ANY) ?
+			(TRACE_MODE_READ | 0004) :
+			TRACE_MODE_READ;
 		*fops = &ftrace_event_format_fops;
 		return 1;
 	}
@@ -3086,7 +3092,13 @@ static int event_callback(const char *name, umode_t *mode, void **data,
 #ifdef CONFIG_PERF_EVENTS
 	if (call->event.type && call->class->reg &&
 	    strcmp(name, "id") == 0) {
-		*mode = TRACE_MODE_READ;
+		/*
+		 * Make id tracefs file world readable for tracepoints with
+		 * TRACE_EVENT_FL_CAP_ANY
+		 */
+		*mode = (call->flags & TRACE_EVENT_FL_CAP_ANY) ?
+			(TRACE_MODE_READ | 0004) :
+			TRACE_MODE_READ;
 		*data = (void *)(long)call->event.type;
 		*fops = &ftrace_event_id_fops;
 		return 1;
-- 
2.54.0

