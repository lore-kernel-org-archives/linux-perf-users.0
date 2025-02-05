Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CA81DD874
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Feb 2025 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738772909; cv=none; b=AXjxkP8eKihf5rOoUlVXORDuJ5koNpJvB5wdvz331wIE0cPSRQjabmMMzHCm/tdw+37rVtTbV469ZABW9RaSKdgc7dsGSqWP5m3gxGZz8m4VWhgslpyTy5HiFIPPGPw0iN2nD0a6pM4D4Mxd2b2OYH/mQPk+cUY7Lzm+/CZGK/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738772909; c=relaxed/simple;
	bh=MamaATQdTalfGdQR+h9SJfw/z4U5K7o2gveVzje5DOU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sp0Gl2MX/LhBkUdKIwiLe9M/u7u3o5mFk0lpA1bmvJQtKxgOENgyXp9FX9GTZW2MgJekRc/mmJ39OCRR/0ST9n/ZQ51m4j6dNVbzi3fio7dRhOk4mfEbs4X+h/3CQPNc7gxgmneW04r/PS2x8qHhfe/v3Zzlk1il2hyFV0nDcx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iNZSv/p2; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iNZSv/p2"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43623bf2a83so55184565e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Feb 2025 08:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738772906; x=1739377706; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zrrPcw6IxhSNPEcJDdwHOtrOMn6vN5ihcUD5Xkj3Slk=;
        b=iNZSv/p2sHdCpLWoZrxU2Qj37NOLL1DCActA/LHz1IE4pdOzyJqSJiIYmEDq/u2m1B
         oQ6PqNEkEzrvSy1+p7iItZvzK3fSFOuSvhi46/QBXPPV3hJnqY7Kx0LHHpqVtfVYvAu7
         b0a4+M95CqTIJGMmB7e2+2Lop5gVBFMjCX/eI0rBGvPR2GUxkXyClvhfZzX2Lsu0PyDK
         Q2/WzsqUrVUR3tDui97V/JiQED0GrQ2R3/Sp7V6g7aa7oH8GKfRWNkKeLzULn/umFRpy
         IiF+YBej4wHdDEl4DJSSNrRY4GTYqQqD+KmeBo5E6cd3ir5J5tUAExS7jlT22ulk3j6p
         kLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738772906; x=1739377706;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zrrPcw6IxhSNPEcJDdwHOtrOMn6vN5ihcUD5Xkj3Slk=;
        b=FP+fpJH3H3krZDz8ZqSUrf/v6CBiMSlucODXyOo3WcqSEkcWTpZlWPKzBMIQkxWhfB
         PmhTByOlmFNLZzp2QJFEnywfAJsGhjUSHsev9kIv3+VoWFauR6JFZyLGcmWncB0bafXW
         DCVPpRMgXeGUl0/Cx0TXuAO+LZ3PJd396TSrGYMHiEkzdDk8+O29E2c/OvcF1F2hPAmy
         rCSt6mfiMvYD0enK4LFli/11fPEBRGfuuysyKr3x2b2O+0CMApF9+UTYsl1PuAB34PYA
         uM2EyQnHhMJKOpiOXEoI+RjIGZPJaYbSCPf7vHpsGXRmll4f/xKQlBTBCOL7YYebofrF
         kjTQ==
X-Gm-Message-State: AOJu0YzHPYDCSo69AxSjOYCmd+01Xb2j0aHdQm7pNwYjPEHd3MahGXfL
	w9D48+uHarEVkhyAvv2hQmUcDGzf/YS1XJFNLmZuMqEkHB4PgJ/HWoyAAfeW+P+QkhZYmh95A+t
	rxAOYJg==
X-Google-Smtp-Source: AGHT+IH3dn5CPlW8+VHVN83qmUxZVwMcmyP97Y8KQc5AkN+zqQOj60d00l2kAUS3hrHuxknaFCsInLQYPSrg
X-Received: from wrse2.prod.google.com ([2002:adf:fc42:0:b0:38d:a75a:da22])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:5886:0:b0:38d:b2b8:fadd
 with SMTP id ffacd0b85a97d-38db48e61b8mr2512993f8f.32.1738772905961; Wed, 05
 Feb 2025 08:28:25 -0800 (PST)
Date: Wed,  5 Feb 2025 17:27:39 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <cover.1738772628.git.dvyukov@google.com>
Subject: [PATCH v5 0/8] perf report: Add latency and parallelism profiling
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"

There are two notions of time: wall-clock time and CPU time.
For a single-threaded program, or a program running on a single-core
machine, these notions are the same. However, for a multi-threaded/
multi-process program running on a multi-core machine, these notions are
significantly different. Each second of wall-clock time we have
number-of-cores seconds of CPU time.

Currently perf only allows to profile CPU time. Perf (and all other
existing profilers to the be best of my knowledge) does not allow to
profile wall-clock time.

Optimizing CPU overhead is useful to improve 'throughput', while
optimizing wall-clock overhead is useful to improve 'latency'.
These profiles are complementary and are not interchangeable.
Examples of where latency profile is needed:
 - optimzing build latency
 - optimizing server request latency
 - optimizing ML training/inference latency
 - optimizing running time of any command line program

CPU profile is useless for these use cases at best (if a user understands
the difference), or misleading at worst (if a user tries to use a wrong
profile for a job).

This series add latency and parallelization profiling.
See the added documentation and flags descriptions for details.

Brief outline of the implementation:
 - add context switch collection during record
 - calculate number of threads running on CPUs (parallelism level)
   during report
 - divide each sample weight by the parallelism level
This effectively models that we were taking 1 sample per unit of
wall-clock time.

We still default to the CPU profile, so it's up to users to learn
about the second profiling mode and use it when appropriate.

Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Changes in v5:
 - fixed formatting of latency field in --stdout mode
 - added description of --latency flag in Documentation flags

Changes in v4:
 - added "Shrink struct hist_entry size" commit
 - rebased to perf-tools-next HEAD

Changes in v3:
 - rebase and split into patches
 - rename 'wallclock' to 'latency' everywhere
 - don't enable latency profiling by default,
   instead add record/report --latency flag

Dmitry Vyukov (8):
  perf report: Add machine parallelism
  perf report: Add parallelism sort key
  perf report: Switch filtered from u8 to u16
  perf report: Add parallelism filter
  perf report: Add latency output field
  perf report: Add --latency flag
  perf report: Add latency and parallelism profiling documentation
  perf hist: Shrink struct hist_entry size

 .../callchain-overhead-calculation.txt        |   5 +-
 .../cpu-and-latency-overheads.txt             |  85 ++++++++++++++
 tools/perf/Documentation/perf-record.txt      |   4 +
 tools/perf/Documentation/perf-report.txt      |  54 ++++++---
 tools/perf/Documentation/tips.txt             |   3 +
 tools/perf/builtin-record.c                   |  20 ++++
 tools/perf/builtin-report.c                   |  39 +++++++
 tools/perf/ui/browsers/hists.c                |  27 +++--
 tools/perf/ui/hist.c                          | 104 ++++++++++++------
 tools/perf/util/addr_location.c               |   1 +
 tools/perf/util/addr_location.h               |   7 +-
 tools/perf/util/event.c                       |  11 ++
 tools/perf/util/events_stats.h                |   2 +
 tools/perf/util/hist.c                        |  90 ++++++++++++---
 tools/perf/util/hist.h                        |  32 +++++-
 tools/perf/util/machine.c                     |   7 ++
 tools/perf/util/machine.h                     |   6 +
 tools/perf/util/sample.h                      |   2 +-
 tools/perf/util/session.c                     |  12 ++
 tools/perf/util/session.h                     |   1 +
 tools/perf/util/sort.c                        |  69 +++++++++++-
 tools/perf/util/sort.h                        |   3 +-
 tools/perf/util/symbol.c                      |  34 ++++++
 tools/perf/util/symbol_conf.h                 |   8 +-
 24 files changed, 531 insertions(+), 95 deletions(-)
 create mode 100644 tools/perf/Documentation/cpu-and-latency-overheads.txt


base-commit: 8ce0d2da14d3fb62844dd0e95982c194326b1a5f
-- 
2.48.1.362.g079036d154-goog

