Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CE1170A26
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Jan 2025 19:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736622123; cv=none; b=u6jetLS8yWC/R+YlqSMEmpXlQyAUN3j7AQwtRNo00p34iZNevZtzaoTpZLOBkqtd8pqhhxZk5F8oj1Rf0qgw01u7MgoH/f4AwaIPx5N1o8ml8ixkxJrt5Um3ADkIlIhdTcczDEBcoKpLn4nFUPGlahbwxD5SFtftgYHMVegcGx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736622123; c=relaxed/simple;
	bh=HQI56t3Xk8Nax12U4SiUvZLhRcgZJYblQDi4Y8nSSCc=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=jdgTQef3uiW9c3G1i4oyN+MQmCDNygrT+JW7wjBCNf8VFvnnpsA5uT0eyie3tY4HWxqqCgFxKFLYNDaoLOp1F+CJsa03S7hWbtDGpcqlKRUBkP2b1/OVuPEWUk+0T1QdE2SUM3UREAgR78Xs/TAXwa/pClxuVCKRDRDeHP/jhD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rIj02wUT; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rIj02wUT"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e5505f613e5so6232298276.0
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Jan 2025 11:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736622120; x=1737226920; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d3A0USpCKcPm+oZI+s4cg9x83Pq7450iM+zG1Swbqbk=;
        b=rIj02wUTSrD4sjkgtRQoPj3DT8Tatmib/rMJjqxU3VMbZVKFTos4cSK7tzKyU9PsFC
         BgpUhFl5tHwI8FVHONGKjbU/3vcfxUPwf5z7RrEcTDTh0IYc2zZm8JItyujbcrAYll3D
         ofUvJT7QLJAnO/bpq9NsGmxat25wpAcVC9sirUq5g2S5HAHxk+l2xdJOS1nJMd1JGKpj
         Dh5TtBatRh7zTRLpIe2axZX8H0dkR1MRmIPvTgTZgsYw++ZqzoK+e0RWCh5WoDGjqkR9
         AVpTQpB1PdEyvs//l1n+g5NNFa3KA7epLCGYsQYEnTJYbp38pjNjn6uCYu1fyE0ruDxH
         uYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736622120; x=1737226920;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d3A0USpCKcPm+oZI+s4cg9x83Pq7450iM+zG1Swbqbk=;
        b=I177iubuj45/7/vh6UhrvmBUHRL7GzyUK0d1T1PvN8iwwdgHIrRm2tpvij56teEnYG
         XW+NJMXDAA5oIcM+FqxO5ZnPV0AYF/Pzxb3bYhB7BHw6OoNZPc7qS8aB5rGvsqKAg78W
         uABOO7lirNqRC8qhMa0J8wacn5hXCAnnIt5WFjo95oRYGWtg5kmbQwzSutjPshuT1mEE
         cbMLN2a+F797kubgljkb+/13ls6XxhZE+Q3ViD5AL8WYD30/K9UIANANhdDnJGQ9c/4i
         RgFegN+bU4UFtaZ5tNLnK09O+tnwEEb7wwryJVTn3wvgpZS/O8nZAsR7amhvTNi97+d0
         PydA==
X-Forwarded-Encrypted: i=1; AJvYcCU8bC4jodIJ1kOGE66CwnQCnj6dR6AFHHi675Sseir3LuZSAKtTI7vm9O2RASJe3jY2nGbtA7RvM0GMhBzy6xqs@vger.kernel.org
X-Gm-Message-State: AOJu0YwQDc+wvMt9QxrNex1+A7eVEQL2jFAOrKHMmHid2iouVelyUEGc
	AxL53pp1tPAL1sqochJ7K9H6uRD1AFn4qPG62sgCSxXz4B3+cdrosemWdX5yVSQD48tMR41A0sM
	vWIFYAA==
X-Google-Smtp-Source: AGHT+IHLje0K1WCz/tc+8OQHrck+cCflLVO6F1nUn/pT2VCgo83pDFeyqJv+hHmPuifgoVC4IrBhJx2v3ZxQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8807:d7c5:bb27:35fc])
 (user=irogers job=sendgmr) by 2002:a0d:d282:0:b0:6ee:6f60:e564 with SMTP id
 00721157ae682-6f543f586demr396197b3.3.1736622119780; Sat, 11 Jan 2025
 11:01:59 -0800 (PST)
Date: Sat, 11 Jan 2025 11:01:33 -0800
Message-Id: <20250111190143.1029906-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 00/10] Move uid filtering to BPF filters
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Hao Ge <gehao@kylinos.cn>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Tengda Wu <wutengda@huaweicloud.com>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rather than scanning /proc and skipping PIDs based on their UIDs, use
BPF filters for uid filtering. The /proc scanning in thread_map is
racy as the PID may exit before the perf_event_open causing perf to
abort. BPF UID filters are more robust as they avoid the race. Add a
helper for commands that support UID filtering and wire up. Remove the
non-BPF UID filtering support.

Ian Rogers (10):
  perf bench evlist-open-close: Reduce scope of 2 variables
  perf parse-events filter: Use evsel__find_pmu
  perf target: Separate parse_uid into its own function
  perf parse-events: Add parse_uid_filter helper
  perf record: Switch user option to use BPF filter
  perf top: Switch user option to use BPF filter
  perf trace: Switch user option to use BPF filter
  perf bench evlist-open-close: Switch user option to use BPF filter
  perf target: Remove uid from target
  perf thread_map: Remove uid options

 tools/perf/bench/evlist-open-close.c        | 76 ++++++++++++---------
 tools/perf/builtin-ftrace.c                 |  1 -
 tools/perf/builtin-kvm.c                    |  2 -
 tools/perf/builtin-record.c                 | 26 +++----
 tools/perf/builtin-stat.c                   |  4 +-
 tools/perf/builtin-top.c                    | 22 +++---
 tools/perf/builtin-trace.c                  | 25 ++++---
 tools/perf/tests/backward-ring-buffer.c     |  1 -
 tools/perf/tests/event-times.c              |  8 +--
 tools/perf/tests/keep-tracking.c            |  2 +-
 tools/perf/tests/mmap-basic.c               |  2 +-
 tools/perf/tests/openat-syscall-all-cpus.c  |  2 +-
 tools/perf/tests/openat-syscall-tp-fields.c |  1 -
 tools/perf/tests/openat-syscall.c           |  2 +-
 tools/perf/tests/perf-record.c              |  1 -
 tools/perf/tests/perf-time-to-tsc.c         |  2 +-
 tools/perf/tests/switch-tracking.c          |  2 +-
 tools/perf/tests/task-exit.c                |  1 -
 tools/perf/tests/thread-map.c               |  2 +-
 tools/perf/util/bpf-filter.c                |  2 +-
 tools/perf/util/evlist.c                    |  3 +-
 tools/perf/util/parse-events.c              | 25 ++++---
 tools/perf/util/parse-events.h              |  1 +
 tools/perf/util/python.c                    | 10 +--
 tools/perf/util/target.c                    | 54 ++-------------
 tools/perf/util/target.h                    | 15 +---
 tools/perf/util/thread_map.c                | 32 +--------
 tools/perf/util/thread_map.h                |  6 +-
 tools/perf/util/top.c                       |  4 +-
 tools/perf/util/top.h                       |  1 +
 30 files changed, 135 insertions(+), 200 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog

