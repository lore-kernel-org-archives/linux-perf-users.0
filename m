Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1091487FB
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Feb 2024 23:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708127715; cv=none; b=q0+n0/m2m4/P74z/iKas+DaWhriCY0hVONm/yViL41cJrLghfI91Nviv2D7gb3O1vFK5uNl7UkKO1buHvPgnthc+D1Cy5DUKMRUhVefHy6cgNV0DyRpZndXTET98Wszn7HmxWT7S830H9PZEoeC7dYSCAflto88uVN87mXEHl4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708127715; c=relaxed/simple;
	bh=1Dvtya1H7/PzNMqdtVJUl8hBgvbrmgnqki4J5eyi26c=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=aDk2qx1AnDlO9mYO1hDejfxV+CEuo2mOSblB76ApgIL24VQnquUesuSDMkPrrZQt2VgPERJDNZeFbsFyvGJZgaRAFKdC105g4QSpPt2KNYeHBXGwJKr6bz8qChAaS6+E9jZ21vMVGLPUop6M1Sj2m4M7MLqcgWdZdvx8ePuTBbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bzBfo8QJ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bzBfo8QJ"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60665b5fabcso39126417b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Feb 2024 15:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708127712; x=1708732512; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QBl8zgtekWPhTI5Bs2qcCKwIbqRGQ//OBxDNQEaVnho=;
        b=bzBfo8QJpzn1By3LMJZsELSoCDcddZwgB8ZPp4ZcOptyOoiQJkOBtt1GMXAo2dkyqM
         eL2id5WuZwVoBz1LTV5Ev+oMLKPHXG8XWA3jP54Rv+ng2KInBbFhDcINI4IUzBVURTlq
         WpS9GDgQCBIYPj3o0aa+d24e9nva2wVrgo/r2MFPc0E+XdUFPR1w/pLmzy0wrGheezLV
         ZrY6rt4pmqd/60sVd29qIU5Dg5WbWn/xYHki8WcWyAvfzuNm66j2/KqT6WLQHrAjCJky
         rbT5uevgEEMNsczT59YK84u9j4FFr+1YnWn+E1eLFBC2ZEcAb5murXDhnQ9aZLeOAY0O
         Ta8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708127712; x=1708732512;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QBl8zgtekWPhTI5Bs2qcCKwIbqRGQ//OBxDNQEaVnho=;
        b=qerKAj0STgXazGa19g07fMMRiid3DqZeF1lV1lQJotxbgIdZDKfzNJcyr88PPrj5qC
         BrsyUyWg/ltWr9HIeb2EAzSMLyDlL23aE/PGVz3A1lxzWuRlC6f3ampHKTwqWgETymxp
         jh3EuCp5eeqowAKZ5nhFKLxxra8IpBWZglGhQqnhqQ6+sv+U6xJEkJei5xk+gYM57KlQ
         hQSUWOEdvvobV+gOcokBlr1rHX2nGstMmMBixeJCA3YNxRCE2oPjRpkA8xrKNlm2AVH8
         MrRb3kGu7ezFl9jOGa+nRLhVc6vWFsIx7BFXcfCPr5EzOChMbjHLbSy13/WKtXbugO8X
         V3aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmDKPRo/csJhnB2CIsjIFyLUYq8SQkWiQTeoZEhfmGZXieAB1SBEHMas0HaIKvjbngTttf6ISK5DOQbNnYD0uiEq9a1LjFnxFDnGLqLYdMXw==
X-Gm-Message-State: AOJu0YxOPFn/6YWbS49sv0KMbk7xGB8FvWaV+YwOLYGMQFcxvaYEvhvz
	TEPGtkvw9EggQuAoLvJy9dWJyukjGqFfSAnK6eBOi9+HKIdajqMQQxgJI1y6cvfXQLYPPgYfgY5
	eeIiKow==
X-Google-Smtp-Source: AGHT+IEMz+3RYNoGBF343NN7VH7kEkTuo9e+7EPD1rOracd954OtISvpyHGwVvDYBFvc29zPAHCM8qIzo6wC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4b5c:352:4272:e34e])
 (user=irogers job=sendgmr) by 2002:a05:6902:1005:b0:dc7:59d9:7b46 with SMTP
 id w5-20020a056902100500b00dc759d97b46mr224264ybt.3.1708127712581; Fri, 16
 Feb 2024 15:55:12 -0800 (PST)
Date: Fri, 16 Feb 2024 15:51:54 -0800
Message-Id: <20240216235203.229256-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v5 0/8] Run tests in parallel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

If command line option '-p' is provided, start/fork all tests in the
main thread and then gather them in order at the end. On a laptop test
time was reduced from 5 minutes 21 seconds to 1 minute 50 seconds. The
option isn't default as the test shows up perf and test flakes.

The '-v' option is modified so that 'perf test -v' will give verbose
output only from failing tests.

v5 - fix a -Wunused-result
v4 - fix bug in width computation.
v3 - fix a crash if shell test directory isn't found, remove merged patch.
v2 - fix parallel test output/verbose issue
v1 - initial PoC

Ian Rogers (8):
  perf thread_map: Skip exited threads when scanning /proc
  perf list: Add scandirat compatibility function
  perf tests: Avoid fork in perf_has_symbol test
  tools subcmd: Add a no exec function call option
  perf test: Rename builtin-test-list and add missed header guard
  perf tests: Use scandirat for shell script finding
  perf tests: Run time generate shell test suites
  perf tests: Add option to run tests in parallel

 tools/lib/subcmd/run-command.c                |   2 +
 tools/lib/subcmd/run-command.h                |   2 +
 tools/perf/tests/Build                        |   2 +-
 tools/perf/tests/builtin-test-list.c          | 207 ----------
 tools/perf/tests/builtin-test-list.h          |  12 -
 tools/perf/tests/builtin-test.c               | 378 ++++++++++--------
 tools/perf/tests/shell/lib/perf_has_symbol.sh |   2 +-
 tools/perf/tests/tests-scripts.c              | 256 ++++++++++++
 tools/perf/tests/tests-scripts.h              |   9 +
 tools/perf/util/print-events.c                |  12 +-
 tools/perf/util/thread_map.c                  |   9 +-
 tools/perf/util/util.c                        |  19 +
 tools/perf/util/util.h                        |   8 +
 13 files changed, 508 insertions(+), 410 deletions(-)
 delete mode 100644 tools/perf/tests/builtin-test-list.c
 delete mode 100644 tools/perf/tests/builtin-test-list.h
 create mode 100644 tools/perf/tests/tests-scripts.c
 create mode 100644 tools/perf/tests/tests-scripts.h

-- 
2.44.0.rc0.258.g7320e95886-goog

