Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90942332638
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123611; cv=none; b=dkwBmqrWFIjc5ozC3CXqWsJco61/F1klgb95NZxZCLKdopZ02G03t/bUMh6mlfolPuTv73/3dZHDgihCNI2tHPENa4Eh3EpvX9jOGb7ilqEaWTfCdR//4vmgXOLpj2ouW3Qm/cbaBtRPPXGmuGCi2MqjFb9I2waQ11U/XZtXtAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123611; c=relaxed/simple;
	bh=5ZugrS/XkaD0h/4ZRtq6FyU9FkKZDK9GPMwpyXNA5Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mpoSmr/NGmlE4+k9b2E8wHTiZhGy1yEOr27t+FajLe54LyDp/pbfTJHMm0CmFtbu9xgpBVrOUoOoYzY9SDWsgJcuj42BAu7ig4uYwVOdBdlrDVvdvhvVAPIHBw14IEmlSHRt3L74zvWp3ZDKx9V7CAX1IhN1+kcV+TSo/XHQ+p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A5fb1kc/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5fb1kc/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784123607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LvmLOXpC1CRK/A3/t0yO20cykVDTPKJzzMQZeRym+Ns=;
	b=A5fb1kc/G4P/hLSLshxdoHaXVKH8qJ7jLMyhI79LbzD9se+CFaogm7U+ugv/YICfy6uNGi
	8jCsPsEkKYUDOEYfaIAHloqwtJyxU3EW/8jxF6otFmDkHRkdG9QTsJkdIXuVjU6rBW7VCr
	Wr4dBSqZ6cPJh09v6c69lm9prJLJ1fk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-vVvQ4nMhMeauDqWgIyhMJA-1; Wed,
 15 Jul 2026 09:53:23 -0400
X-MC-Unique: vVvQ4nMhMeauDqWgIyhMJA-1
X-Mimecast-MFC-AGG-ID: vVvQ4nMhMeauDqWgIyhMJA_1784123600
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8BDE18002CC;
	Wed, 15 Jul 2026 13:53:20 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.22.80.235])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A07B195608E;
	Wed, 15 Jul 2026 13:53:18 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: rostedt@goodmis.org,
	acme@kernel.org,
	peterz@infradead.org,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v5 5/5] perf: enable unprivileged syscall tracing with perf trace
Date: Wed, 15 Jul 2026 09:52:26 -0400
Message-ID: <20260715135231.338535-7-ashelat@redhat.com>
In-Reply-To: <20260715135231.338535-2-ashelat@redhat.com>
References: <20260715135231.338535-2-ashelat@redhat.com>
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
perf trace, similar to strace without the overhead of ptrace().

Currently, perf trace requires CAP_PERFMON or paranoid level ≤ 1 even
though the kernel has existing infrastructure (TRACE_EVENT_FL_CAP_ANY)
designed to mark syscall tracepoints as safe for unprivileged access.
To fix this:

1. Loosen the condition in perf_event_open() which requires privileges
   for all events with exclude_kernel=0. This allows perf_event_open() to
   bypass the paranoid check for task-attached tracepoint events. Ensure
   that sample types which can expose kernel addresses to unprivileged
   users are blocked. Ensure the PERF_SECURITY_KERNEL LSM hook is
   preserved.

2. Add a check to perf_trace_event_perm() to block PERF_SAMPLE_IP on
   kernel tracepoints for unprivileged users to prevent KASLR bypass. We do
   this here rather than in kaddr_leak because perf_trace_event_perm() can
   distinguish between kernel tracepoints and uprobe tracepoints, where the
   IP is a safe user space address and is necessary for uprobe
   functionality.

3. Restrict pure counting events (no PERF_SAMPLE_RAW) to
   TRACE_EVENT_FL_CAP_ANY tracepoints preventing unprivileged users from
   counting internal kernel tracepoints while preserving current
   behavior for exclude_kernel=1 events.

Example usage after this change:
  $ perf trace ls          # works as unprivileged user
  $ perf trace             # system-wide, still requires privileges
  $ perf trace -p 1234     # requires ptrace permission on pid 1234

Assisted-by: CLAUDE:claude-opus-4 Apogee
Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 kernel/events/core.c            | 28 +++++++++++++++++++++++++---
 kernel/trace/trace_event_perf.c | 28 +++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 954c36e28101..48bfff07ae02 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13910,9 +13910,31 @@ SYSCALL_DEFINE5(perf_event_open,
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
index 5b272856e5ab..a264154b460e 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -24,6 +24,16 @@ typedef typeof(unsigned long [PERF_MAX_TRACE_SIZE / sizeof(unsigned long)])
 /* Count the events in use (per event id, not per instance) */
 static int	total_ref_count;
 
+/* Check if perf tracepoint is restricted for unprivileged users */
+static bool perf_tp_is_restricted(struct perf_event *p_event)
+{
+	if (p_event->attr.exclude_kernel)
+		return false;
+	if (sysctl_perf_event_paranoid <= 1 || perfmon_capable())
+		return false;
+	return true;
+}
+
 static int perf_trace_event_perm(struct trace_event_call *tp_event,
 				 struct perf_event *p_event)
 {
@@ -72,9 +82,25 @@ static int perf_trace_event_perm(struct trace_event_call *tp_event,
 			return -EINVAL;
 	}
 
+	/*
+	 * PERF_SAMPLE_IP on kernel tracepoints exposes a kernel text
+	 * address, weakening KASLR. Block for unprivileged users unless
+	 * the tracepoint is a uprobe (userspace IP, safe to expose).
+	 */
+	if ((p_event->attr.sample_type & PERF_SAMPLE_IP) &&
+	    !(tp_event->flags & TRACE_EVENT_FL_UPROBE) &&
+	    perf_tp_is_restricted(p_event))
+		return -EACCES;
+
 	/* No tracing, just counting, so no obvious leak */
-	if (!(p_event->attr.sample_type & PERF_SAMPLE_RAW))
+	if (!(p_event->attr.sample_type & PERF_SAMPLE_RAW)) {
+		/* Prevent unprivileged users from counting kernel tracepoints */
+		if (perf_tp_is_restricted(p_event) &&
+		    !(p_event->attach_state == PERF_ATTACH_TASK &&
+		      (tp_event->flags & TRACE_EVENT_FL_CAP_ANY)))
+			return -EACCES;
 		return 0;
+	}
 
 	/* Some events are ok to be traced by non-root users... */
 	if (p_event->attach_state == PERF_ATTACH_TASK) {
-- 
2.54.0

