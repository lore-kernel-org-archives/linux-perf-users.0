Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3311E51E1
	for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 06:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748328126; cv=none; b=uNce9A3mzsjw8TKQ62ib68CxADjL+levczBkeFnwaFrVTq9yCoWsgLmxz6jwG7HdFrMiLGHM/zJr3oiw/Tgnooe37KGKPhX1WrTsuJ+ixd0mikuUQJnu38SWwtk8t2lNJSOMG6jfAsWxUSPw6wRDmW2wwk1jP8pmZ1YgWyIKqyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748328126; c=relaxed/simple;
	bh=NMfGD3GqX5rWPL+e9Fs2kfhUd9zmV28MY+ZVcAIECHA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=nT/jadsSS8yyl/vZ6hKAQ+2u3AE9ByMB6B1ZLSPXtqzZEmHBAdw5gJNLdzArbuEkQ+JOK3eXeNH2NBa/vBBWD+KUUQ245m9Wrc2dhJmrucWe8AtyPcHty+ZulwuZrnYtaohv+J3hqcKqBHSYl9KOkMsv8fgNTOpDmLWh4ploc4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zYiTU3O6; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zYiTU3O6"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74292762324so2000079b3a.0
        for <linux-perf-users@vger.kernel.org>; Mon, 26 May 2025 23:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748328124; x=1748932924; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kcV28N5+sBWjxRZkVWUHsu8deeFtQ4ZFy7tqc4CjbTQ=;
        b=zYiTU3O6CB0dB5hU32mlwV/8wpP6HmFS5keLJGQbZ5zBa7GniJrvqjelEXET1hvPWJ
         fd0hoemDA/AwSXK//3sdrwIdT5+6ovZHZQQfncBu6GVX4VXTvYAfFgyas/mNzT4Y6U95
         p1Vo0ZE0x/MA4lSm7wOMBUXu8ozakSiNbGQSeBwLrHEge9PfLZx7bP97qy5M8H1Dg7kA
         bGUsOztNERI+Z74T5n+0nx1rwFgHXIU36MR1RsTCKrFY8wx3LatdnoFP1ujRRdhr9JZq
         PXl/3kvOFMreddK3fwjjfzFIizlr/i7ti9rAJB8LGug4p5RuONpKNIPCqVk/o0O89rpQ
         gxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748328124; x=1748932924;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kcV28N5+sBWjxRZkVWUHsu8deeFtQ4ZFy7tqc4CjbTQ=;
        b=qjG/dgDC4S3yeVYtN9/yEgy+Jd2lepvYyCdTlo8zlbxLsHuusnzBG6CiAxOHsBXvJt
         /wmFEeCaQXlgNGBNPpUSeI2XeL7w40laAzsVm9YR5GQ0mwuvmuvMoz1CF95do6E3/qR/
         vY2DeKmD+X9fwZUs1VoABF6kyOVHA/9IXbGJxjJlDmUmkX2Zb24nLkRF4cjlgxn0xBcR
         GHpQbe/QeaO9z3jfuDDSq8EJ4fZv5+G0fpa+wCTa7WYk23YburtLFTG5P4irWuvQAe5c
         SMM9BJhbMdDxk5WeJrcrpPpjFfFCKUXaWZ+TjUUa7F5Pt4EWf60iDnHgQA9itoxPy+R9
         nLPw==
X-Forwarded-Encrypted: i=1; AJvYcCVSrFAngeuaq22bAFQhXgy6DkR0wjVuC8BNeFANMoUorDzos8hLVrSC5RwOdN4L8r9Ls67dHN1eLrGbiVfAmefF@vger.kernel.org
X-Gm-Message-State: AOJu0YzYLqoY4m7Yik8MzvAPJW4a//czH3sTGJTmY1VyaY13e4cptr9R
	kDSq2HckgzKKf3ZmprTm/CVIY0nRvwz/TZmyjV5TDK6XOhWeoV4Y0ISDc+K2wrVfc6ZRQkinfzR
	/TlIINdGaEQ==
X-Google-Smtp-Source: AGHT+IGUN0fzVTWfN5BSgaJmYPqCEB1x73YKDQNWO3sa567CFbM07VnpKZotlJY8dhXy0AXzIRWeiHbPcWWi
X-Received: from pfbfb3.prod.google.com ([2002:a05:6a00:2d83:b0:736:9d24:ae31])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3cc3:b0:740:a85b:7554
 with SMTP id d2e1a72fcca58-745fde777d1mr17188534b3a.2.1748328123817; Mon, 26
 May 2025 23:42:03 -0700 (PDT)
Date: Mon, 26 May 2025 23:41:42 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250527064153.149939-1-irogers@google.com>
Subject: [PATCH v1 00/11] Remove global perf_env
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Graham Woodward <graham.woodward@arm.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Weilin Wang <weilin.wang@intel.com>, Michael Petlan <mpetlan@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Chun-Tse Shao <ctshao@google.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

The global perf_env is used to hold host information, but it is also
used as a fallback in a number of cases where the information may be
bogus. Restructure the code so that the perf_env of the session is
accessed. When necessary a locally scoped host perf_env is created and
used.

Cleaning up the inconsistency was requested by Kan Liang in:
https://lore.kernel.org/lkml/c56c9e23-cf6e-4040-aee8-da13d5157dcf@linux.intel.com/

Ian Rogers (11):
  perf session: Add accessor for session->header.env
  perf session: Add an env pointer for the current perf_env
  perf evlist: Change env variable to session
  perf header: Clean up use of perf_env
  perf test: Avoid use perf_env
  perf top: Make perf_env locally scoped
  perf session: Add host_env argument to perf_session__new
  perf bench synthesize: Avoid use of global perf_env
  perf machine: Explicitly pass in host perf_env
  perf auxtrace: Pass perf_env from session through to mmap read
  perf env: Remove global perf_env

 tools/perf/bench/synthesize.c         |  30 +++--
 tools/perf/builtin-annotate.c         |   4 +-
 tools/perf/builtin-buildid-cache.c    |   2 +-
 tools/perf/builtin-buildid-list.c     |   5 +-
 tools/perf/builtin-c2c.c              |  16 ++-
 tools/perf/builtin-inject.c           |   5 +-
 tools/perf/builtin-kallsyms.c         |  21 ++-
 tools/perf/builtin-kmem.c             |   2 +-
 tools/perf/builtin-kvm.c              |   4 +-
 tools/perf/builtin-kwork.c            |   2 +-
 tools/perf/builtin-lock.c             |   4 +-
 tools/perf/builtin-mem.c              |   2 +-
 tools/perf/builtin-record.c           |  30 +++--
 tools/perf/builtin-report.c           |  14 +-
 tools/perf/builtin-sched.c            |   8 +-
 tools/perf/builtin-script.c           |  16 ++-
 tools/perf/builtin-stat.c             |  23 ++--
 tools/perf/builtin-timechart.c        |   2 +-
 tools/perf/builtin-top.c              |  40 ++++--
 tools/perf/builtin-trace.c            |  26 ++--
 tools/perf/perf.c                     |   3 -
 tools/perf/tests/code-reading.c       |   6 +-
 tools/perf/tests/dlfilter-test.c      |  51 ++++----
 tools/perf/tests/dwarf-unwind.c       |  10 +-
 tools/perf/tests/mmap-thread-lookup.c |   6 +-
 tools/perf/tests/symbols.c            |   8 +-
 tools/perf/tests/topology.c           |  39 +++---
 tools/perf/ui/browser.h               |   4 +-
 tools/perf/ui/browsers/header.c       |   4 +-
 tools/perf/ui/browsers/hists.c        |   2 +-
 tools/perf/util/amd-sample-raw.c      |   2 +-
 tools/perf/util/arm-spe.c             |   2 +-
 tools/perf/util/auxtrace.c            |  13 +-
 tools/perf/util/auxtrace.h            |   6 +-
 tools/perf/util/bpf-event.c           |   2 +-
 tools/perf/util/branch.c              |   2 +-
 tools/perf/util/data-convert-bt.c     |  16 +--
 tools/perf/util/data-convert-json.c   |  36 +++---
 tools/perf/util/env.c                 |   3 +-
 tools/perf/util/env.h                 |   2 -
 tools/perf/util/evlist.h              |   2 +-
 tools/perf/util/evsel.c               |  12 +-
 tools/perf/util/evsel.h               |   1 +
 tools/perf/util/header.c              | 180 +++++++++++++++-----------
 tools/perf/util/machine.c             |   8 +-
 tools/perf/util/machine.h             |   4 +-
 tools/perf/util/probe-event.c         |   5 +-
 tools/perf/util/s390-cpumsf.c         |   2 +-
 tools/perf/util/sample-raw.c          |   7 +-
 tools/perf/util/sample-raw.h          |   2 +-
 tools/perf/util/session.c             |  17 ++-
 tools/perf/util/session.h             |   9 +-
 tools/perf/util/tool.c                |   2 +-
 53 files changed, 424 insertions(+), 300 deletions(-)

-- 
2.49.0.1151.ga128411c76-goog

