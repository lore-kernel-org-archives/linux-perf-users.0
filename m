Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EC338CFF4
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652103; cv=none; b=d/N53yl4ylkSNcKp1YEl4GmO7mRmwhAKA7u15X9bbTsZL7J71+DfsA6ynToKMgeUgOVq0ZoGSsIkDrHNfwJZGRhEtElRvqgJmMlSRfKXTe9M9LJH/pS42oWwVJXxf2RhMGmWZyx7g0L9a9Yem85W5N6aADo/+p0Wf+jclQqL3KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652103; c=relaxed/simple;
	bh=Iwt4Tb6hOZuRBYvyF+IF0ofToj5rdqJvUvflMnV6VU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rnT8mcMKxaw013asLID2pddnOpAfJHoIgX7f14I6Eas5Vq3dLAT/XgfHn5eIpCrIt3NXEIj4kPiqM2jHZ/6mataP5zXtyanlic9uSlDHyIdSGI053xG8HmvgdtBB6GoywoGu0lVodL4riFvjl4l8L0nqJGduB6WcbEj0uKUe1+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iFeZ0QWk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFeZ0QWk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775652100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fmfA0Hm9tvRCD5nJvyEjImPcNYwXbm+DPWKpmcQx18A=;
	b=iFeZ0QWkCTIjwNwDD8rc3hw+2Cz5f3eE/QOl848yXGJOdimqHAf20ZqM1Nv3wzwOmBrM40
	xVKqB1CuwYGiIDo4la1vwgcHrGuBt+eyqTG1/WkHr3zJiUY+DHWAlT1EQ9AtjznYX+cSuZ
	4+7lr2nDzDOvoEv92c4SGzukyBWIzwI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-13Naxm8CPQSPorcNcMyAHw-1; Wed,
 08 Apr 2026 08:41:37 -0400
X-MC-Unique: 13Naxm8CPQSPorcNcMyAHw-1
X-Mimecast-MFC-AGG-ID: 13Naxm8CPQSPorcNcMyAHw_1775652095
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34C4119560A7;
	Wed,  8 Apr 2026 12:41:34 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.74.80.247])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E59C300019F;
	Wed,  8 Apr 2026 12:41:25 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
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
Subject: [PATCH] perf: enable unprivileged syscall tracing with perf trace
Date: Wed,  8 Apr 2026 08:39:47 -0400
Message-ID: <20260408123947.23779-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Allow unprivileged users to trace their own processes' syscalls using
perf trace, similar to strace without the intrusive overhead of ptrace().

Currently, perf trace requires CAP_PERFMON or paranoid level ≤ 1 even
though the kernel has existing infrastructure (TRACE_EVENT_FL_CAP_ANY)
specifically designed to mark syscall tracepoints as safe for
unprivileged access. To fix this:

1. Loosen the condition in perf_event_open() which requires priviliges
for all events with exclude_kernel=0. This allows perf_event_open() to
bypass the paranoid check for task-attached tracepoint events.

2. Make the format and id tracefs files world-readable only for tracepoints
   with TRACE_EVENT_FL_CAP_ANY, allowing unprivileged users to see
syscall tracepoint ids without exposing sensitive information.

Example usage after this change:
  $ perf trace ls          # works as unprivileged user
  $ perf trace             # system-wide, still requires privileges
  $ perf trace -p 1234     # requires ptrace permission on pid 1234

Assisted-by: Claude:claude-sonnet-4.5
Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 kernel/events/core.c        | 2 +-
 kernel/trace/trace_events.c | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 89b40e439717..71d99ea4bea4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13833,7 +13833,7 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (err)
 		return err;
 
-	if (!attr.exclude_kernel) {
+	if (!attr.exclude_kernel && !(attr.type == PERF_TYPE_TRACEPOINT && pid != -1)) {
 		err = perf_allow_kernel();
 		if (err)
 			return err;
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

