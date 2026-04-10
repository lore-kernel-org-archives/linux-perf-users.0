Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCCF271450
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 13:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775828155; cv=none; b=jSkjziaIIafYlphjIiY4MtCjpG6NG9GBdUKpEifhrK4gYwHFf+3+vBK62ICHFJkVs0VbfM5qJvaZx7TtT7Wg/kFCyWQGwHZT5Jt+j//it1ZHkjm8dXZyjs7stQVnDGg5h1d9See0GYErMKUMWd09TTX7uEtuTsj9QBNMLfN19xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775828155; c=relaxed/simple;
	bh=qzFDBlW38Y9drkwi3zJmnsk/zi2a2A6uLtHX7FlJS9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fLAoqOtDV8wfAf60lJe/8gtwxItj45EmdW7iUMSE3+g70a2iPYn8lEszmyAHdNjrQIk4XQ+wTnqi+SQuFVKTO5fauzxiRXG520iqs4IBfiqhQu2EqxyRwjUw7w4OqDBPYkj2j+B7vce36GzbdTxufSh4WmW5U5A1hKrNCeFcD9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h9w+/RG9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9w+/RG9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775828152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xtIpjYDOHdSv0lZJ3NJBv+5doRQrU2DW+0WPWnC9oQw=;
	b=h9w+/RG9J2OhiHbWGL3h2/ORCCMwYS9AiFO3RGyOce8TOM4L4kGxEN8iP59xILkT6QZJxY
	JbGf1rjPNZD2NdDB7+aiMKL72w1gfZUWsmFHCn4fTvej7EJRNKpicG8WlcIDFlvCWMAofV
	iPTuVmjDHXXfkFIEVZkmVYp58i+ThNM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-7b17dJy5NN6MgbR4JAz4OA-1; Fri,
 10 Apr 2026 09:35:49 -0400
X-MC-Unique: 7b17dJy5NN6MgbR4JAz4OA-1
X-Mimecast-MFC-AGG-ID: 7b17dJy5NN6MgbR4JAz4OA_1775828147
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F7451956080;
	Fri, 10 Apr 2026 13:35:46 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.74.64.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD8FC1955F2E;
	Fri, 10 Apr 2026 13:35:38 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: mpetlan@redhat.com,
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
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v2] perf: enable unprivileged syscall tracing with perf trace
Date: Fri, 10 Apr 2026 09:35:28 -0400
Message-ID: <20260410133529.21947-1-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Allow unprivileged users to trace their own processes' syscalls using
perf trace, similar to strace without the intrusive overhead of ptrace().

Currently, perf trace requires CAP_PERFMON or paranoid level ≤ 1 even
though the kernel has existing infrastructure (TRACE_EVENT_FL_CAP_ANY)
specifically designed to mark syscall tracepoints as safe for
unprivileged access. To fix this:

1. Loosen the condition in perf_event_open() which requires priviliges
for all events with exclude_kernel=0. This allows perf_event_open() to
bypass the paranoid check for task-attached tracepoint events. Ensure
that sample types which can expose kernel addresses to unprivileged
users are blocked.

2. Make the format and id tracefs files world-readable only for tracepoints
with TRACE_EVENT_FL_CAP_ANY, allowing unprivileged users to see syscall
tracepoint ids without exposing sensitive information.

Also add a check to perf_trace_event_perm() to ensure only TRACE_EVENT_FL_CAP_ANY
events can be traced.

Example usage after this change:
  $ perf trace ls          # works as unprivileged user
  $ perf trace             # system-wide, still requires privileges
  $ perf trace -p 1234     # requires ptrace permission on pid 1234

Assisted-by: Claude:claude-sonnet-4.5
Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
Changes in v2:
- Add check to block sample types that bypass KASLR, suggested by
  sashiko.
- Link to v1: https://lore.kernel.org/linux-perf-users/20260408123947.23779-2-ashelat@redhat.com/
---
 kernel/events/core.c            | 22 +++++++++++++++++++---
 kernel/trace/trace_event_perf.c | 12 +++++++++++-
 kernel/trace/trace_events.c     |  8 ++++++--
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 89b40e439717..db8c674704b2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13834,9 +13834,25 @@ SYSCALL_DEFINE5(perf_event_open,
 		return err;
 
 	if (!attr.exclude_kernel) {
-		err = perf_allow_kernel();
-		if (err)
-			return err;
+		bool tp_bypass = false;
+
+		if (attr.type == PERF_TYPE_TRACEPOINT && pid != -1) {
+			/*
+			 * Block sample types that expose kernel addresses to
+			 * prevent KASLR bypass
+			 */
+			u64 kaddr_leak = PERF_SAMPLE_CALLCHAIN |
+					 PERF_SAMPLE_BRANCH_STACK |
+					 PERF_SAMPLE_ADDR;
+
+			tp_bypass = !(attr.sample_type & kaddr_leak);
+		}
+
+		if (!tp_bypass) {
+			err = perf_allow_kernel();
+			if (err)
+				return err;
+		}
 	}
 
 	if (attr.namespaces) {
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index a6bb7577e8c5..e8347df7ede5 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -73,8 +73,18 @@ static int perf_trace_event_perm(struct trace_event_call *tp_event,
 	}
 
 	/* No tracing, just counting, so no obvious leak */
-	if (!(p_event->attr.sample_type & PERF_SAMPLE_RAW))
+	if (!(p_event->attr.sample_type & PERF_SAMPLE_RAW)) {
+		/*
+		 * Only allow CAP_ANY tracepoints for unprivileged
+		 * task-attached events in case kernel context is exposed.
+		 */
+		if (!p_event->attr.exclude_kernel && !perfmon_capable()) {
+			if (!(p_event->attach_state == PERF_ATTACH_TASK &&
+			      (tp_event->flags & TRACE_EVENT_FL_CAP_ANY)))
+				return -EACCES;
+		}
 		return 0;
+	}
 
 	/* Some events are ok to be traced by non-root users... */
 	if (p_event->attach_state == PERF_ATTACH_TASK) {
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 249d1cba72c0..6250b2529376 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3051,7 +3051,9 @@ static int event_callback(const char *name, umode_t *mode, void **data,
 	struct trace_event_call *call = file->event_call;
 
 	if (strcmp(name, "format") == 0) {
-		*mode = TRACE_MODE_READ;
+		*mode = (call->flags & TRACE_EVENT_FL_CAP_ANY) ?
+			(TRACE_MODE_READ | 0004) :
+			TRACE_MODE_READ;
 		*fops = &ftrace_event_format_fops;
 		return 1;
 	}
@@ -3087,7 +3089,9 @@ static int event_callback(const char *name, umode_t *mode, void **data,
 #ifdef CONFIG_PERF_EVENTS
 	if (call->event.type && call->class->reg &&
 	    strcmp(name, "id") == 0) {
-		*mode = TRACE_MODE_READ;
+		*mode = (call->flags & TRACE_EVENT_FL_CAP_ANY) ?
+		(TRACE_MODE_READ | 0004) :
+		TRACE_MODE_READ;
 		*data = (void *)(long)call->event.type;
 		*fops = &ftrace_event_id_fops;
 		return 1;
-- 
2.53.0

