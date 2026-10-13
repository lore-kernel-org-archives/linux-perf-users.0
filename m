Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF3152ED50
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 18:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791915990; cv=none; b=RpPgHVysDj2N/3UhkE/0OfcpAEcnh9PPFuo5AWINRnZbO3faw/Npnk/2HQEjBCz9Tt3wYLzhG296/Rk/gRzT5GsgQ42tyD9WkN5GMIK+sVC5hA1uk7tf/jyr0PPpGMcF5icpXxNVSB5Z0to/t18w+oxBd/5ROobOm77FMuPzoI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791915990; c=relaxed/simple;
	bh=NQ3N+KtF1s0lIIfEoQjD3h9bq8byinBG0GY1189Km5c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EbihV9EC7oRGdP2oNKhK+MK/YBtNz1NHCQWy6tZb0gDIHatcrCrJ3mHF+VXyO26/TNmvybJCKHrSTfYYkzjugi1x2udSN74sA2X1aWu8vo3FCHUXVYDtICKgr+uxxwFX9GlxIt2xmNnJ7NbqgSHWkid7RPHy0FVcFe0xUCA2qp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X2VSdB8w; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X2VSdB8w"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so8887273eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 11:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791915988; x=1792520788; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NgKWIghaSLwHkVze9bXo1k3NgwY+M5W7+3Wd5vtJHbY=;
        b=X2VSdB8wKoJn0Lt/Ozikfg3rYfkYpyv3gN+44dHs64GAhu08PJLQpXwFul4WsmPq82
         At8X3/pjHcnMr2TF2Yqc7VMsS7iOxf/DNjUe7t3/NrenpoC67I90mB3P5Rv32weMiu/e
         41l7moqfNbq1wc/wszU7znFm8z+Af9jTZETBDIgUj/PGV1p+fYOG1E0zrGygs1XVAr6r
         NsipMvXs2hoJb0JIu7nruQesMZWtBho3ONsLJUovoKB9PpO6SoJ1pEwyQTM8jjZru4aM
         W41XLoaKidFHAX6bzJI3XsJ5yimI1U9WU+2LOrbytRNYHTQjEnnO9CPP3zyB6ZBUGVbf
         UfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791915988; x=1792520788;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NgKWIghaSLwHkVze9bXo1k3NgwY+M5W7+3Wd5vtJHbY=;
        b=hb5PhVqdt9veQ+d1xQFMgsMYAv6c+qKuEo2cRKObNdfz/SGnbbdFKRUsOP5Ty42x1m
         okkEIuZHhpqtBHT+eqR2h7688NVdEWjV1fmcEYOP4TIJSIzl9iZwMPiynUUDm7KAWwEl
         oXfdNqMZ+qIxk5rioeAnhKSgX16KMXSH9A/dnjOTvaR7T1UzkVdzAw+UuaJNzLUTLB7n
         3i8uTAfHzfENKlaHNzEGVUpMpdaLie2E+O61Oe6nVDIlT3eW1QiwnOou8M7up+w3PVqZ
         UEKCCK6X34pvsAdzUNtG0jcRXLxp+xRa33w6jAqStJqPk/l7do5YnssTu4LsIajQ2Lph
         t/FA==
X-Forwarded-Encrypted: i=1; AKwUvBx9TJjyvXfGi7liE6SVFtlZAWqc4bmTXaTbjctVKLgvzJcluQNykQh1SzBxFDXYO3n9Ultx/wem/P/K8Epr7pcn@vger.kernel.org
X-Gm-Message-State: AFq9FYLJkSRHZU3NKT0fjCA8Bkq6jr41mKzauiSg/kVTCon9J8oXfZnt
	lgB73b+fV1S1BVxp5jCW8U94svmb9eeJOQbBvCe/LSz/bGTrXJN1P++PzbdzyTq/8g5FSMNd/yv
	QysJZSMCmtA==
X-Received: from dybtm1.prod.google.com ([2002:a05:7300:f0c1:b0:358:cd5e:4e5c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:4706:b0:34e:3ce1:39f8
 with SMTP id 5a478bee46e88-3537e021d3cmr18888848eec.18.1791915987312; Tue, 13
 Oct 2026 11:26:27 -0700 (PDT)
Date: Tue, 13 Oct 2026 11:24:48 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013182458.1234616-1-irogers@google.com>
Subject: [PATCH v1 00/10] tools/perf: Adopt kernel compiler-context-analysis.h annotations
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

The perf tool previously added Clang thread-safety annotations in
tools/perf/util/mutex.h (GUARDED_BY, LOCKABLE, EXCLUSIVE_LOCK_FUNCTION,
UNLOCK_FUNCTION, etc.). Since then, the Linux kernel has adopted a
unified set of static context analysis macros and attributes in
include/linux/compiler-context-analysis.h (context_lock_struct,
__guarded_by, __acquires, __releases, __must_hold, etc.).

This series makes tools/include/linux/compiler-context-analysis.h
functional by synchronizing it and the required compiler_types.h helpers
with the kernel headers, converts tools/perf from its custom mutex.h
macros to the kernel-style compiler-context-analysis.h annotations, and
expands context analysis coverage across comm, dso/dsos, thread/threads,
config, intel-tpebs, env, and maps. In the process, it fixes an unlocked
__dsos__add() call in __machine__addnew_vdso(), an unlocked read of
tpebs_reader_thread in tpebs_stop(), and adds a read-lock fast path to
dsos__findnew_id().

Ian Rogers (10):
  compiler-context-analysis: Avoid unused parameter warning in
    _context_unsafe_alias()
  tools headers compiler: Synchronize compiler_types.h with the kernel
    sources
  tools headers: Synchronize linux/compiler-context-analysis.h with the
    kernel sources
  perf mutex: Use kernel style compiler-context-analysis.h annotations
  perf build: Enable additional Clang thread-safety flags
  perf comm: Add __guarded_by annotations to struct comm_strs
  perf dso: Fix unlocked __dsos__add() in vdso and expand lock
    annotations
  perf thread: Expand context analysis annotations to threads and
    namespaces_lock
  perf config, intel-tpebs, env: Add __guarded_by and __must_hold
    annotations
  perf maps: Add context analysis annotations

 include/linux/compiler-context-analysis.h     |   2 +-
 .../include/linux/compiler-context-analysis.h | 518 ++++++++++++++++--
 tools/include/linux/compiler-gcc.h            |  55 +-
 tools/include/linux/compiler.h                |  50 +-
 tools/include/linux/compiler_types.h          | 206 ++++++-
 tools/perf/Makefile.config                    |   5 +-
 tools/perf/builtin-sched.c                    |  16 +-
 tools/perf/builtin-top.c                      |   4 +-
 tools/perf/check-headers.sh                   |   1 +
 tools/perf/tests/dso-data.c                   |   4 +
 tools/perf/util/annotate.c                    |   4 +-
 tools/perf/util/annotate.h                    |   8 +-
 tools/perf/util/bpf-event.h                   |   5 +-
 tools/perf/util/comm.c                        |  10 +-
 tools/perf/util/config.c                      |  39 +-
 tools/perf/util/dso.c                         |  89 ++-
 tools/perf/util/dso.h                         |  12 +-
 tools/perf/util/dsos.c                        |  29 +-
 tools/perf/util/dsos.h                        |   9 +-
 tools/perf/util/env.c                         |   1 +
 tools/perf/util/env.h                         |  19 +-
 tools/perf/util/intel-tpebs.c                 |  86 ++-
 tools/perf/util/libbfd.c                      |   4 +-
 tools/perf/util/maps.c                        | 122 +++--
 tools/perf/util/mutex.c                       |   4 +-
 tools/perf/util/mutex.h                       |  90 +--
 tools/perf/util/rwsem.c                       |   8 +-
 tools/perf/util/rwsem.h                       |  10 +-
 tools/perf/util/thread.c                      |  10 +-
 tools/perf/util/thread.h                      |  30 +-
 tools/perf/util/threads.c                     |   4 +
 tools/perf/util/threads.h                     |   6 +-
 tools/perf/util/vdso.c                        |   2 +-
 33 files changed, 1050 insertions(+), 412 deletions(-)

-- 
2.56.0.385.gd3acb90ef8-goog

