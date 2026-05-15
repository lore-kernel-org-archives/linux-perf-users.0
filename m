Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AF237DAA6
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 19:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874124; cv=none; b=caDjOXyx7faRiMzytnD3nbG5ycE2YARqAyOtuHySPPGuhlimhlY3I1ChQO8lpMvqIXDRMCKQn6NFRrswc+KQtKivwSJGm5WjZ/4LRiJH0ORsku2kRgjhT+wVrpfzWK2x80sNlRYwt1NheRNGUlqrolQ+YXPDZGLuxysTdNOdqKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874124; c=relaxed/simple;
	bh=G4CqAYKsY3Wc2t7gyTbD4Gv39XASTXHXqs798KAVaOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I7ZffZzMG9+aJ6+6A7FDW49JotabMMhb1PD5Z9KYe0/4GBZbvNpyrTbAWDv7TUYRMClNDrWLjSAJjrHHPMWs3Q9zVXBEwdOTViipgNBGz40L2yAIKOX/32E5+1AG5NAaM2XpZZ/+Tdvv6LUSqkGV8tKxPY/FAvbw++kQIBYUug4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KiPnS4dp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KiPnS4dp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778874121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vSQPe0r2nBMN4k24aUYGad00zpFOKV9doRFflow+NpE=;
	b=KiPnS4dprD3M29+iwux3oA2wMJDAzGm5nitTWAsOjiycHR4QGjBXb4fp0uBHJMPtcfdsNy
	8nCUSRffVHgoPFDmIJfVa6wGmgCFqevblnPPJVhKEXUZ0qv8ImYwVNNtdW3wn+CNzR2Mi3
	F7uSuHubfCwSDpiru/2NKEz+vw35SVU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-ey5hywcXOVqykllHUuFPrw-1; Fri,
 15 May 2026 15:41:56 -0400
X-MC-Unique: ey5hywcXOVqykllHUuFPrw-1
X-Mimecast-MFC-AGG-ID: ey5hywcXOVqykllHUuFPrw_1778874114
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F25E51956094;
	Fri, 15 May 2026 19:41:53 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.22.80.109])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63FB11956053;
	Fri, 15 May 2026 19:41:50 +0000 (UTC)
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
Subject: [PATCH v4 0/3] Enable perf tracing for unprivileged users
Date: Fri, 15 May 2026 15:40:04 -0400
Message-ID: <20260515194010.93725-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Enable users to use perf-trace to trace their own processes, like strace
but without the overhead of ptrace(). Ensure that users cannot access
other users' or systemwide tracing data.

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

Anubhav Shelat (3):
  perf evsel: don't set PERF_SAMPLE_IP for unprivileged tracepoints
  perf: enable unprivileged syscall tracing with perf trace
  tracefs: make root directory world-traversable

 fs/tracefs/inode.c              |  2 +-
 kernel/events/core.c            | 28 +++++++++++++++++++++++++---
 kernel/trace/trace_event_perf.c | 21 ++++++++++++++++++++-
 kernel/trace/trace_events.c     | 16 ++++++++++++++--
 tools/perf/util/evsel.c         | 14 +++++++++++++-
 5 files changed, 73 insertions(+), 8 deletions(-)

-- 
2.54.0

