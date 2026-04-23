Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527E02773E4
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 15:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957497; cv=none; b=nGE5OpFUScGLpJxWqO3c8kOkvHvdARL0ajc436+yTY3XllZ6p6VhY6ejlnAtVpz3Fs/rW6qdnGlAcpSkz3oxExUtKNLgt5MvVKN12iDTHhXvR0HiJXE2i529lUqzxKZlV3fJAdJMuzP01sMlc2LY39KjinyrfqED8CJu8+80G20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957497; c=relaxed/simple;
	bh=JlPPhvIpAf4rgWrLVvcwMPJOSr6hvZ+3+vbCMq6ZD2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jbFUz7KlyR1/TzuQzHuUhak8sk2aV3vPeu3W/U2F8IQ+0ElMKxKckFkUCVa0lqMFnCZe2xgWl+Wwx6LIPgNZ1ZeAHKHSaLJh5wUUrItanQ0WmvfkCfRNqBdLUFePv6e4pegoHL/9LHRsvnFvTw3YRrMtvpKgkpJ14HkHBVhehKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K5BuRa8t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5BuRa8t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776957495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j/Pmi72bonVmU72u81smxBl5+5RIPTx07Gpoki2CJe4=;
	b=K5BuRa8tlnaCQWIXCcnoJsp6fQx6jzvsauFdRpdVMBEIu6oMadwqhWSSfSK1vYbZXaa9U+
	CMvXplMBitaJL5ECnPiKFSLE7b9k+8C4p1Hx8Xg82ZB1aZzkEe0XHFpsbZgZQkQs1gdeDi
	EYb4Uy8IuLsqdnXi1wXPwovlgaIirOQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-EHAZrRmXMHO_2k1TXUTMyA-1; Thu,
 23 Apr 2026 11:18:11 -0400
X-MC-Unique: EHAZrRmXMHO_2k1TXUTMyA-1
X-Mimecast-MFC-AGG-ID: EHAZrRmXMHO_2k1TXUTMyA_1776957489
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D0EA1800473;
	Thu, 23 Apr 2026 15:18:09 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.74.80.103])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B59E01800357;
	Thu, 23 Apr 2026 15:17:59 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v3 0/3] Enable perf tracing for unprivileged users
Date: Thu, 23 Apr 2026 11:17:43 -0400
Message-ID: <20260423151746.16258-1-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Enable users to use perf-trace to trace their own processes, like strace
but without the overhead of ptrace(). Ensure that users cannot access
other users' or systemwide tracing data.

Changes in v3:
- Don't set PERF_SAMPLE_IP for unprivileged tracepoints. This allows us
  to exclude PERF_SAMPLE_IP from kaddr_leak without weakening KASLR.
- Mount tracefs as world-traversable so users can access eventfs
  directories.

v2: https://lore.kernel.org/lkml/20260410133529.21947-1-ashelat@redhat.com/

Anubhav Shelat (3):
  perf evsel: don't set PERF_SAMPLE_IP for unprivileged tracepoints
  perf: enable unprivileged syscall tracing with perf trace
  tracefs: make root directory world-traversable

 fs/tracefs/inode.c              |  2 +-
 kernel/events/core.c            | 23 ++++++++++++++++++++---
 kernel/trace/trace_event_perf.c | 12 +++++++++++-
 kernel/trace/trace_events.c     |  8 ++++++--
 tools/perf/util/evsel.c         |  4 +++-
 5 files changed, 41 insertions(+), 8 deletions(-)

-- 
2.53.0

