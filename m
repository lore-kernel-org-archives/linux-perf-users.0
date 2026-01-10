Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41582D0C9D
	for <linux-perf-users@vger.kernel.org>; Sat, 10 Jan 2026 08:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768033625; cv=none; b=MO4H2/wzL45PFBb/KPujrZINeO+KYBtY6IcZgzJt0R3DWNCUMO3TpyJC0eQOwyI10QnkmEQfSh0eR00e+VovvIs772PiM/iDkNmvShVMZvdAs0BBG+4oKokkngqpyZwi3vs6kFJwuHdk9ErzWCLU9WjerQj7QGiSg5DIenlFOHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768033625; c=relaxed/simple;
	bh=1ak4EbbMn2mQ7CCM9fvd52UG+g8mxf3+0yQa0DXyMds=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=fQbXOxplA6mj7xfIgEQg1eCqkug3ZBSliVtJf4vphCB5dQGPMv24mQGVIOEu02IuaTQuNI/qoJOwf+hF7GnDXQ6f67CB2A7mdx5nPsTebq9fHrZkvDu/DXl+oGbCLqDTpDOsSScyhJWnUOuAnetd1byv0R0JQ3VsAdqqtFye8yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dgDdODT0; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dgDdODT0"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b0530846d3so4371573eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 10 Jan 2026 00:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768033623; x=1768638423; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MUdZ4k1ahmP8CtZagsnpANZxLnDzWZojx1CZUgRO8ME=;
        b=dgDdODT0VsmGl8FLIHygN/yHzqEKOjwf3CK79Z93BrMjfi3memNgHkyt4OpyW5Nx0P
         KVL4wV3KkqFqqlkIwGkP68wF0RXmML8CF8/m2Zk4tHCltAqLaZzjfkr+qvfewkwDbjBO
         lrEN/MfmeSM83ukFGZ/dtpKHOu5jIIcC/2gYzCbS3DBSpGXlZACIJDwV+pM2xkgbF3bV
         pZSSZt6JTFmRMi2ylcDiFrHirQQ1WtMcjvY/BBb+EXb8eBBQzJo2sRpDcFeWcuLeZAaW
         7T8KeeSlGvet2Yg3ZreNsWVuh6edHAiqU5GisznqgtHEQpodj1aVOV6WO1HAt1Gz8X7Z
         YvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768033623; x=1768638423;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MUdZ4k1ahmP8CtZagsnpANZxLnDzWZojx1CZUgRO8ME=;
        b=kCDgti6KJyJu+QFC3fBWrOxGKf6+SA/h+CXNxtkMBXu9KiGSzJ/njEt7v2LaOUivY3
         /qw6zFRemtDKVbIV5/Z/nYuHa7AG13YnUpGSTkfNjH2IB05T8psaJctvGq/W3yHOJx/v
         oRFzn/334U1W5kq8ZXxb48lo+VMQzUrAZz0lHR8S47H33fz5DbwnUlan5oO4cCBGhlyA
         EYR/TcMQJ3BXIyt1lLXtoytpE0Ixr0pK3Hs9xFjEPjHVSX8Nax2QWeefZcqvVDZ9poxs
         BbvCFmdq3ANZOmiie7+t2ySdSSbdcMLkkiyChyZJgUwFG3y+vS5BI9/hefAL34F1hcqN
         Bw1w==
X-Forwarded-Encrypted: i=1; AJvYcCUsqaHpogiZsSY6jY5UeXIpwyP9tL8xCjIFsBXzVPyx6oQgjaIspGfmy19zkCEM3UA08lTOli5zim5W2AnqW6yr@vger.kernel.org
X-Gm-Message-State: AOJu0YwEza3CvgvEdSLGg7kIT4lGEVB9VvcSjcHHNKMGCJ63n6ttYjHB
	R7fJjtQL8ZVlJl7OOQtdQiF80k64W02cdMXBwcQ+U8Pc+niAQ5lXpfGeV0/aYM1ts6GWmxJXgTj
	8Bv+8NNMoCw==
X-Google-Smtp-Source: AGHT+IHnM4MaVa+q7KSOMhFrMKvLlkzVXa88DDSnqd30d1k+/9yAo4vxHBFBec8pCEv7xylM0FAy1QFJZ8uw
X-Received: from dyjl17.prod.google.com ([2002:a05:7300:2691:b0:2ac:1eee:fda8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2b14:b0:2ae:5f28:eafc
 with SMTP id 5a478bee46e88-2b17d2b0c26mr9076824eec.27.1768033622677; Sat, 10
 Jan 2026 00:27:02 -0800 (PST)
Date: Sat, 10 Jan 2026 00:26:41 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260110082647.1487574-1-irogers@google.com>
Subject: [PATCH v2 0/6] Add a libdw addr2line implementation
From: Ian Rogers <irogers@google.com>
To: Tony Jones <tonyj@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

addr2line is a performance bottleneck in perf, add a libdw based
implementation that avoids forking addr2line and caches the decoded
debug information.

Allow the addr2line implementation to be picked via the configuration
file or --addr2line-style with `perf report`.

Test/fix that inline callchains are properly displayed by perf script.

v2: Fix bias issue with libdwfl functions. Use cu_walk_functions_at
    from perf's dwarf-aux to fully walk inline functions. Add testing
    that inlined functions are shown in the perf script srcline
    callchain information. Add configurability as to which addr2line
    style to use.

v1: https://lore.kernel.org/lkml/20251122093934.94971-1-irogers@google.com/

Ian Rogers (6):
  perf addr2line: Add a libdw implementation
  perf addr2line.c: Rename a2l_style to cmd_a2l_style
  perf srcline: Add configuration support for the addr2line style
  perf callchain: Fix srcline printing with inlines
  perf test workload: Add inlineloop test workload
  perf test: Test addr2line unwinding works with inline functions

 tools/perf/builtin-report.c                 |  10 ++
 tools/perf/tests/builtin-test.c             |   1 +
 tools/perf/tests/shell/addr2line_inlines.sh |  47 +++++++
 tools/perf/tests/tests.h                    |   1 +
 tools/perf/tests/workloads/Build            |   2 +
 tools/perf/tests/workloads/inlineloop.c     |  52 +++++++
 tools/perf/util/Build                       |   1 +
 tools/perf/util/addr2line.c                 |  20 +--
 tools/perf/util/config.c                    |   4 +
 tools/perf/util/dso.c                       |   2 +
 tools/perf/util/dso.h                       |  11 ++
 tools/perf/util/evsel_fprintf.c             |   8 +-
 tools/perf/util/libdw.c                     | 148 ++++++++++++++++++++
 tools/perf/util/libdw.h                     |  60 ++++++++
 tools/perf/util/srcline.c                   | 116 +++++++++++++--
 tools/perf/util/srcline.h                   |   3 +
 tools/perf/util/symbol_conf.h               |  10 ++
 17 files changed, 476 insertions(+), 20 deletions(-)
 create mode 100755 tools/perf/tests/shell/addr2line_inlines.sh
 create mode 100644 tools/perf/tests/workloads/inlineloop.c
 create mode 100644 tools/perf/util/libdw.c
 create mode 100644 tools/perf/util/libdw.h

-- 
2.52.0.457.g6b5491de43-goog

