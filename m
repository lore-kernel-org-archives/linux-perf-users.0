Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9120C21E3BF
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 04:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729052677; cv=none; b=djYSWnilrvU4vYzHWdMqV3jMDu+0B7LAYq9RCc9537FKXhZG+8JIWIHoCsCEC5D6aSuLFpbDPTrYy1TLJ6yc4kAfq4ZkLOjcCslhQi4fIcVmaZh0KqiYyHlbqVP5DXKNF8uz+WkV+Xsb0iyqqA/Yg98QBEHzk2RMT1hs5iOj0QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729052677; c=relaxed/simple;
	bh=RWUEru6N6eaAX85aSyMOVXf+OYOS3hC3lVWQ1UjMUR0=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=kfYU0V5h7IPGig5sNpbtpeE2dradHQSmxRXTkq0BEBQ7WaDmEWHgm27+mCd71WGu+aK5JpAKr2ACbeViuR5MwUHONxpRsKbT0NDzGne97W1xTiYRoRWdBtikkmpwN+ufgM5CiIg/q6kerbT+Bf00yMyFLtrvGxK/3iv8mSxe/7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mxO0JlbE; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mxO0JlbE"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6dbbeee08f0so8247827b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Oct 2024 21:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729052674; x=1729657474; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=id/FsNXa1o9e1S6YPM3p4EXOTEwtrmgwen7d4lxrTKg=;
        b=mxO0JlbEmJCTE1hk4oLjri4i1q1oWt8JKqaQNK3ZVm1cGiMnTqV9DL3tgYwOD1wIAF
         RosljzFn2B68ma98Pxc33UAQyFLCauQMzxdOPrOrYg2q8VKSeVy19pRt9StV0GyAPfYv
         umyJVF7u5A4QEBsBTZ3hWWKA4m45K/GHmA/BpvT+j+BasDwFIS/f/blmQ5H47lSXqisJ
         xUtLXS12NLPtbFfv4rv8FRDZxbkAzHX8zECti1KZ6xd0LgnpOHPGxbK4oDKK24NDQpSX
         IrIY2EJvnurjctbfkaqLYkW56cDl+Xj15UR+LvOf6U7X7TBm0JGXw1PQG2OY93FDQ2SJ
         2knQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729052674; x=1729657474;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=id/FsNXa1o9e1S6YPM3p4EXOTEwtrmgwen7d4lxrTKg=;
        b=MQbXtOEC2X/xehjyY6rCGyMGdENWlga9QL2oWdbAQmF1qqNGtYTaw0B1E9WmFhFQRI
         mG4npXGGp/BXq/g13TOgWlrC7STzK6y+J5/QbtMciVZL6zH+ySXnYMRWv1p3cV07ICA8
         UKwzpxG45C1Rh8T+eIIJSiZXxNd1/Psj4CUD6BBf2etx2JK6rS6uQ+w66kjFIV4ptk9G
         wwKiPnnlk4Re/584LTcdaeC2KUi/qxc6tUch1r8DK8c7C0MvzFFxpH/TdbGDGu5Q4sE0
         Wach4Z4mVjSWBrM65iXkhF0QZoguu/bIismP98p7wwLsbce+kdNGjTO+vfSShwpai6OX
         Ai9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUCyaYJcfXx3yjXeOsqmXIyBRNIRPzNdFRRWhqJ8SQ9zJslHEQ7DAKDz229Z6DeJ6Zm9Fr7kdD3ktPfP5pcoK1@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/izUYtqjOaRhKtGxC0ptiau63+5UJUfoDmaN1CHmsWQzx63Co
	+CSy6nuHQ15xFnVHOmo/bd8NQpHsHYdEgxoJRhoozVLNpw+MzMGsymVwWZOcGJMQALx24Se+QYA
	BtjO4XQ==
X-Google-Smtp-Source: AGHT+IHEPj1/Qc9D8i7jBVTBzFfpmfxFlw8KSlo7/n948wALaWSNIFurK9Se3BGYAYptWfPufJ2Ejl471VdX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a05:690c:3587:b0:6e2:a355:7b5c with SMTP
 id 00721157ae682-6e3d3aa32femr714997b3.5.1729052674298; Tue, 15 Oct 2024
 21:24:34 -0700 (PDT)
Date: Tue, 15 Oct 2024 21:23:59 -0700
Message-Id: <20241016042415.7552-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 00/16] Python module cleanup
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch builds upon:
https://lore.kernel.org/lkml/20241015000158.871828-1-irogers@google.com/
as those patches remove a util to test dependency assumed to be
present for "perf build: Remove test library from python shared
object."

The patch:
 - removes workarounds for Python 2 module support due to long
   deprecation and challenges in developing new code;
 - constifies variables and parameters to functions;
 - removes python.c stub code which existed due to missing functions
   that are defined in the builtin-* files, in general the builtin-*
   code is moved into util;
 - remove bench and test perf C code from the python module;
 - adds parse_events to the python perf module.

v2. Add the bottom 4 bullet points - 13 more patches.

Ian Rogers (16):
  perf python: Remove python 2 scripting support
  perf python: Constify variables and parameters
  perf python: Remove unused #include
  perf script: Move scripting_max_stack out of builtin
  perf kvm: Move functions used in util out of builtin
  perf script: Move find_scripts to browser/scripts.c
  perf stat: Move stat_config into config.c
  perf script: Move script_spec code to trace-event-scripting.c
  perf script: Move script_fetch_insn to trace-event-scripting.c
  perf script: Move perf_sample__sprintf_flags to
    trace-event-scripting.c
  perf env: Move arch errno function to only use in env
  perf lock: Move common lock contention code to new file
  perf bench: Remove reference to cmd_inject
  perf kwork: Make perf_kwork_add_work a callback
  perf build: Remove test library from python shared object
  perf python: Add parse_events function

 tools/perf/Makefile.perf                      |   7 +-
 tools/perf/bench/inject-buildid.c             |  13 +-
 tools/perf/builtin-kvm.c                      |  61 ----
 tools/perf/builtin-kwork.c                    |   3 +-
 tools/perf/builtin-lock.c                     | 137 +-------
 tools/perf/builtin-script.c                   | 303 +-----------------
 tools/perf/builtin-stat.c                     |  27 --
 tools/perf/builtin-trace.c                    |   1 -
 tools/perf/builtin.h                          |   6 -
 .../scripts/python/Perf-Trace-Util/Context.c  |  20 +-
 tools/perf/tests/stat.c                       |  16 +-
 tools/perf/trace/beauty/arch_errno_names.sh   |   3 +-
 tools/perf/ui/browsers/scripts.c              | 177 +++++++++-
 tools/perf/util/Build                         |   2 +
 tools/perf/util/bpf_kwork.c                   |   2 +-
 tools/perf/util/bpf_kwork_top.c               |   2 +-
 tools/perf/util/bpf_lock_contention.c         |   2 +-
 tools/perf/util/config.c                      |  27 ++
 tools/perf/util/dlfilter.c                    |   3 +-
 tools/perf/util/env.c                         |   2 +
 tools/perf/util/env.h                         |   2 -
 tools/perf/util/kvm-stat.c                    |  70 ++++
 tools/perf/util/kvm-stat.h                    |   3 +
 tools/perf/util/kwork.h                       |   6 +-
 tools/perf/util/lock-contention.c             | 170 ++++++++++
 tools/perf/util/lock-contention.h             |  37 +--
 tools/perf/util/path.c                        |  10 +
 tools/perf/util/path.h                        |   1 +
 tools/perf/util/python.c                      | 264 ++++-----------
 .../scripting-engines/trace-event-python.c    |  63 +---
 tools/perf/util/stat.h                        |   3 +-
 tools/perf/util/trace-event-scripting.c       | 176 ++++++++++
 tools/perf/util/trace-event.h                 |   5 +-
 33 files changed, 767 insertions(+), 857 deletions(-)
 create mode 100644 tools/perf/util/kvm-stat.c
 create mode 100644 tools/perf/util/lock-contention.c

-- 
2.47.0.rc1.288.g06298d1525-goog

