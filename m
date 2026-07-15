Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AEF318146
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123590; cv=none; b=d3Pbjo7NNxyq0lktEX4Ln0Ad7by8OguFX2BJ23u6PJagREDw0rGJbfNdU9abUjxen28dkp+WIZysblNpMMP3C9bL2Xnxa87Te9uYhVuxvd3Ax0yTftFP0eND0oj7n8ElmD1KaSaeG+EeCLaRBDERxcsy90ZVvbG+FzyZl09cOTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123590; c=relaxed/simple;
	bh=mzjzkCyBfGXtZWM05+2fSad95AM6/alt7iaTw9EnZmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b0/8atSiFkemZLVKyrKmi3bFR2xQxQmddL2JheySqT6Mr7b51Z8eMjgYbzt8YcRdYqjv4GL2QnCKaikHKD62bvHOTnDo99hIjNyIkszw2wvK1kMrV22mzao4330rFXIrTZuAtOuRODtb1zdsuqiOe6C6GiXd8gYpev3PjjEKTis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ws8CsPe4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ws8CsPe4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784123587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B9v88XYbtqchrXAjMzOyW9d575sKuY0HNs6VKDi/j5E=;
	b=Ws8CsPe4n1lba56Q6h8keitC3110LzJwnV/z3+UM4kmF5pmEUJoSf18EYClde3kmYdjZpn
	ODcB6EdtthMnQYCANtjQUQ34gKuuRVqOc4V2eKp0THEx44yeqxjP3oNp02pYgjGPkvyXmf
	pvUN8xke4s4kyFgCXPgWTQQsjdGceHs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-g3kV9EczPlGghdquWAfMWw-1; Wed,
 15 Jul 2026 09:53:02 -0400
X-MC-Unique: g3kV9EczPlGghdquWAfMWw-1
X-Mimecast-MFC-AGG-ID: g3kV9EczPlGghdquWAfMWw_1784123580
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A755E1955E87;
	Wed, 15 Jul 2026 13:53:00 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.22.80.235])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 675CE1956089;
	Wed, 15 Jul 2026 13:52:58 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: rostedt@goodmis.org,
	acme@kernel.org,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v5 0/5] Enable perf tracing for unprivileged users
Date: Wed, 15 Jul 2026 09:52:21 -0400
Message-ID: <20260715135231.338535-2-ashelat@redhat.com>
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

