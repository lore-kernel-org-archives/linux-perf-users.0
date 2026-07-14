Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39148377AB4
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 18:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054377; cv=none; b=cAj+nM1u73Kc8qUkj3uiCszolUSV143vgGLgMT1oUq0ZdmoEUlzqj6HdiNaYOeWpydvJ0kvTNr8AKBzE5cVdIfns8JK3TIC3+XraQAoFPiVKgwHmhoHBZ2xktn5f9vRkBzUZrPgCVfQxL5ni6abxm9m6DRrJXe5XuOWqz4iRjIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054377; c=relaxed/simple;
	bh=mzjzkCyBfGXtZWM05+2fSad95AM6/alt7iaTw9EnZmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gSo0ssoRZFR/aWf5CQtgnn6HIlm+0e+dtidrJc/j3x5hPPjUxnCBA55ld2adjpoJpJOjkJJ9oIByXu1oVKNviJ0rRXfuccdjhCuJ68R4BOzrNSiSp8k6694e11L4cGxaRUG+uvKSUTDLGUkYD2lylHjoCl6+SJdJai2dNaXn9PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fm0cZkLS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fm0cZkLS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784054365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B9v88XYbtqchrXAjMzOyW9d575sKuY0HNs6VKDi/j5E=;
	b=fm0cZkLSRnCYFmemPRB1nHuPuKKosK6GZvBVYKFz+LY8YbIQZ+GY8CFAQdvhSYF76SbeYM
	oxZc5G0R+dPgYwUylrtDyHe33h94iI06lumajwa3M1k5wXacNQ35ZVPV2UDG41y2Rwt4Dv
	qKhF1ZSqfPN/lLKlgmgkUSeWWzJZAdo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-ddLhVtOlNs2Q7GILTxkq7g-1; Tue,
 14 Jul 2026 14:39:20 -0400
X-MC-Unique: ddLhVtOlNs2Q7GILTxkq7g-1
X-Mimecast-MFC-AGG-ID: ddLhVtOlNs2Q7GILTxkq7g_1784054358
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB90E1955F75;
	Tue, 14 Jul 2026 18:39:17 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.22.65.227])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9707019560A3;
	Tue, 14 Jul 2026 18:39:15 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v5 0/5] Enable perf tracing for unprivileged users
Date: Tue, 14 Jul 2026 14:39:04 -0400
Message-ID: <20260714183903.295381-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Enable users to use perf-trace to trace their own processes, like strace
but without the overhead of ptrace(). Ensure that users cannot access
other users' or systemwide tracing data.

Changes in v5:
- Move event_define_fields() before directory creation. If
  event_define_fields() fails then we don't need to cleanup whatever
  dirs were created. 
- New read-only eventfs file system with the same structure as
  /sys/kernel/tracing/events/ to handle files read by unprivileged
  users.
- Allow unprivileged users to fall back to /sys/kernel/events/ when they
  cannot access /sys/kernel/tracing/events/.
- Factor out reused code into helper function that checks if a
  tracepoint should be restricted in commit 5.

Changes in v4:
- Preserve security_perf_event_open(PERF_SECURITY_KERNEL) LSM hook in
  the tp_bypass path.
- Lift the PERF_SAMPLE_IP check out of the tp_bypass path above the
  PERF_SAMPLE_RAW branch so it applies to counting and sampling. This
  also allows us to ensure PERF_SAMPLE_IP is set for uprobes.
- Block counting path for TRACE_EVENT_FL_CAP_ANY for unprivileged users
  with sysctl_perf_event_paranoid > 1.

Changes in v3:
- Don't set PERF_SAMPLE_IP for unprivileged tracepoints. This allows us
  to exclude PERF_SAMPLE_IP from kaddr_leak without weakening KASLR.
- Mount tracefs as world-traversable so users can access eventfs
  directories.

Anubhav Shelat (5):
  eventfs: define event fields before directory creation
  tracefs: add read-only eventfs filesystem at /sys/kernel/events
  perf tools: fall back to eventfs for unprivileged event discovery
  perf evsel: don't set PERF_SAMPLE_IP for unprivileged tracepoints
  perf: enable unprivileged syscall tracing with perf trace

 fs/tracefs/event_inode.c           |  61 ++++++++++++++++++
 fs/tracefs/inode.c                 |  95 ++++++++++++++++++++++++++-
 fs/tracefs/internal.h              |   3 +
 include/linux/trace_events.h       |   1 +
 include/linux/tracefs.h            |   4 ++
 include/uapi/linux/magic.h         |   1 +
 kernel/events/core.c               |  28 +++++++-
 kernel/trace/trace.h               |   2 +
 kernel/trace/trace_event_perf.c    |  28 +++++++-
 kernel/trace/trace_events.c        | 100 +++++++++++++++++++++++++++--
 tools/lib/api/fs/fs.c              |  10 +++
 tools/lib/api/fs/fs.h              |   1 +
 tools/lib/api/fs/tracing_path.c    |  52 +++++++++++++--
 tools/lib/api/fs/tracing_path.h    |   1 +
 tools/perf/util/evsel.c            |  14 +++-
 tools/perf/util/tp_pmu.c           |   5 +-
 tools/perf/util/trace-event-info.c |  19 +++---
 17 files changed, 395 insertions(+), 30 deletions(-)

-- 
2.54.0

