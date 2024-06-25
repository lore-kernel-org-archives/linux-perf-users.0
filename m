Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96F8172786
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 17:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336370; cv=none; b=FrvlNF/fu/EbZbBrmIo60+LVfDIl6mCb/r+gn4+L7u19VtO3SCIKb3S+iLp7c7z2J81RQDzSJS62RQlgqfo0c6UiCWJDaKYdMrWyBnRn6/oI+jaEXYNSOUwSVs9qmQRJE1YewPvGO0Ag/YRYVMC8LxRsGb+C44u7BxOyNq69ve8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336370; c=relaxed/simple;
	bh=TrmRoFkxPHiSFwRVBLcMy/pj2dmbw+zglqCdx72VKXs=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=a1QM8s4XjEUHbZ2NgqgFRQ0QXT+ZDxcSpWUNiELZnwr9jiWWrAnr6lJyuqQgvEWSAx29LZoJCboIcpRIwkpy87PY5DyyU4mJNVlFTMI17XNpVbb1c1zAbNqmiF+OUsG7EvyRncxwkR/J+LcRiWhch+F+JJGOnrbzGQX9zjGsl0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bf9fc11o; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bf9fc11o"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-64399573fd3so86217127b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 10:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336368; x=1719941168; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fBtNvIbgeXhFX/mpmhNLQiRrqYWtpqiLi29bwI4m2nc=;
        b=Bf9fc11oDl22Wkze4kZKvUw9ZJyLIMrZvr8NDVK/w2w6ndeMIWN2CkD9dOxDEUB3ys
         ePjtWXJpDvAFPuXiIncbiCQZLv6eJ7VmMoAQi9SnZish1L9+JzHzQ7bWMahu/lhOaPoB
         kJupQaOJV1udtcLxZeXaMkCCiyHbQAr8kfFgafZpnNhTIgZkwYVQxpgAb2ecFvW2gFa0
         UQYqG4eLS5Gb8RFbPC17MNsZUpmt6ZCY+GWUfImyC/hk1GF51TxXtLUW/723oHal0Jzm
         BMyGmSAAx0q/4foA7KbVfe2qyYomKlj+nytftSJKS6n2+e5EjpngsAzpnxyTcMuO3cwJ
         cBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336368; x=1719941168;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fBtNvIbgeXhFX/mpmhNLQiRrqYWtpqiLi29bwI4m2nc=;
        b=HiKXw71TdPpTiwIpYaNQ1wjxcH33HXsFlu4Dze/7WBRtMChwojZf8OZevMhaudDSZV
         nc5JzHfSCyjYMMPuTbNGZXndMmxbvq8kgX5Tyd6AXl3hakiP3z1hrLbx8WkVXOMtk3bj
         lKvERsLLP7w5vUPlwUm9SOaVifNchnOcMfwQlt9wX1YN58toRHHeS5XaYXSpQr8u651V
         WGFgm6LTgqeoG7C6/vYD9tvhBPU6FHodByUMiHgHl6Z/X0rIgpzEYr0sqxR4tn1vREAM
         VxtxTA0c/ni9bExmcP2qQsj7c6Ig0rgl83QXFNtymrC66MNPnN7Y8Y/noLGhAdgsC5FQ
         GNMg==
X-Forwarded-Encrypted: i=1; AJvYcCVAKPURYVORM/zWKxs90S1sXbm8Fjj5T0+Gu96sDgvRsbyvgRbSQXQ/rsvZX1n+REaJYDGwWp53MqNfcB3SIJkRoFucwRTzVFzkx+NqVZyBBw==
X-Gm-Message-State: AOJu0YxNIxz+a7+UjlNv8SXxkfHEgtB55dn2ma+tXNrlACf6Ypuev96S
	h8pAZvvGldaIbCOuvz6txFHuGNmxzZladBbdIVodgJGYOabmAh0STi++vtjDEyQOwvn+UvxmJvA
	RzVlryA==
X-Google-Smtp-Source: AGHT+IENrGELXvRDCJiRLBdPp2h3dHb67HAIy3m65ItxGzzGqUmFAw/zmAvgosPietAoOpog2VycAm0oqsZU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:690c:ecd:b0:61d:4701:5e66 with SMTP id
 00721157ae682-643ab455a9dmr5525947b3.2.1719336367698; Tue, 25 Jun 2024
 10:26:07 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:25:37 -0700
Message-Id: <20240625172603.900667-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 00/26] Constify tool pointers
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

struct perf_tool provides a set of function pointers that are called
through when processing perf data. To make filling the pointers less
cumbersome, if they are NULL perf_tools__fill_defaults will add
default do nothing implementations.

This change refactors struct perf_tool to have an init function that
provides the default implementation. The special use of NULL and
perf_tools__fill_defaults are removed. As a consequence the tool
pointers can then all be made const, which better reflects the
behavior a particular perf command would expect of the tool and to
some extent can reduce the cognitive load on someone working on a
command.

Ian Rogers (26):
  perf tool: Constify tool pointers
  perf tool: Move fill defaults into tool.c
  perf tool: Add perf_tool__init
  perf kmem: Use perf_tool__init
  perf buildid-list: Use perf_tool__init
  perf kvm: Use perf_tool__init
  perf lock: Use perf_tool__init
  perf evlist: Use perf_tool__init
  perf record: Use perf_tool__init
  perf c2c: Use perf_tool__init
  perf script: Use perf_tool__init
  perf inject: Use perf_tool__init
  perf report: Use perf_tool__init
  perf stat: Use perf_tool__init
  perf annotate: Use perf_tool__init
  perf sched: Use perf_tool__init
  perf mem: Use perf_tool__init
  perf timechart: Use perf_tool__init
  perf diff: Use perf_tool__init
  perf data convert json: Use perf_tool__init
  perf data convert ctf: Use perf_tool__init
  perf auxevent: Add explicit dummy tool initialization
  perf test event_update: Ensure tools is initialized
  perf kwork: Use perf_tool__init
  perf tool: Remove perf_tool__fill_defaults
  perf session: Constify tool

 tools/perf/arch/x86/util/event.c    |   4 +-
 tools/perf/bench/synthesize.c       |   2 +-
 tools/perf/builtin-annotate.c       |  44 ++--
 tools/perf/builtin-buildid-list.c   |  10 +
 tools/perf/builtin-c2c.c            |  33 ++-
 tools/perf/builtin-diff.c           |  30 ++-
 tools/perf/builtin-evlist.c         |  10 +-
 tools/perf/builtin-inject.c         | 159 +++++++------
 tools/perf/builtin-kmem.c           |  20 +-
 tools/perf/builtin-kvm.c            |  19 +-
 tools/perf/builtin-kwork.c          |  33 ++-
 tools/perf/builtin-lock.c           |  41 ++--
 tools/perf/builtin-mem.c            |  37 +--
 tools/perf/builtin-record.c         |  49 ++--
 tools/perf/builtin-report.c         |  67 +++---
 tools/perf/builtin-sched.c          |  50 ++--
 tools/perf/builtin-script.c         | 106 ++++-----
 tools/perf/builtin-stat.c           |  26 +--
 tools/perf/builtin-timechart.c      |  25 +-
 tools/perf/builtin-top.c            |   2 +-
 tools/perf/builtin-trace.c          |   4 +-
 tools/perf/tests/cpumap.c           |   6 +-
 tools/perf/tests/dlfilter-test.c    |   2 +-
 tools/perf/tests/dwarf-unwind.c     |   2 +-
 tools/perf/tests/event_update.c     |   9 +-
 tools/perf/tests/stat.c             |   6 +-
 tools/perf/tests/thread-map.c       |   2 +-
 tools/perf/util/Build               |   1 +
 tools/perf/util/arm-spe.c           |   9 +-
 tools/perf/util/auxtrace.c          |  12 +-
 tools/perf/util/auxtrace.h          |  20 +-
 tools/perf/util/bpf-event.c         |   4 +-
 tools/perf/util/build-id.c          |  34 +--
 tools/perf/util/build-id.h          |   8 +-
 tools/perf/util/cs-etm.c            |   9 +-
 tools/perf/util/data-convert-bt.c   |  34 ++-
 tools/perf/util/data-convert-json.c |  47 ++--
 tools/perf/util/event.c             |  54 +++--
 tools/perf/util/event.h             |  38 ++--
 tools/perf/util/header.c            |   6 +-
 tools/perf/util/header.h            |   4 +-
 tools/perf/util/hisi-ptt.c          |   6 +-
 tools/perf/util/intel-bts.c         |   9 +-
 tools/perf/util/intel-pt.c          |  10 +-
 tools/perf/util/jitdump.c           |   4 +-
 tools/perf/util/s390-cpumsf.c       |   7 +-
 tools/perf/util/session.c           | 342 ++--------------------------
 tools/perf/util/session.h           |   6 +-
 tools/perf/util/synthetic-events.c  |  80 +++----
 tools/perf/util/synthetic-events.h  |  70 +++---
 tools/perf/util/tool.c              | 294 ++++++++++++++++++++++++
 tools/perf/util/tool.h              |  18 +-
 tools/perf/util/tsc.c               |   2 +-
 53 files changed, 945 insertions(+), 981 deletions(-)
 create mode 100644 tools/perf/util/tool.c

-- 
2.45.2.741.gdbec12cfda-goog

