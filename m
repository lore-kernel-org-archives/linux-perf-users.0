Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826C51CF7D0
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 22:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728684247; cv=none; b=hSvtmLOvNHN8jBLxrQx9fRXAlWrCLNi6IMcaZa/wrv6SAyMqj+7Z1pit3ZEdxFaX0ycJBFxVQGWfdIZuG0Du4b6H5ApbRT9zm0VTVhMjein+InweCJKanaW6htZCa7IF/kT/EehYSJVM6xIGdP85A1R7QbaRHaMqY1EVVGGKWF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728684247; c=relaxed/simple;
	bh=pj+tIFhO/r6lPX3jXVKvD6dGzB1WeKlzT565/6lQCtE=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=fsRiRcecIBouxz5dMiQQKX3Kep16GHbNuFuyzOlOf5uGMQ5HsvvGkOw8EWIRZ4y84zHG20DCOjdNNNvnbhF0UL/rZrlULrAiLoaJ+6p1NFSUw8q4BiAs57P+nsQxBPrsr94Amqca9sBR3wOiiMmeyVDW6Ww1H42pchZU81rx5qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hgot9SLq; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hgot9SLq"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e290a9a294fso3853100276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 15:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728684244; x=1729289044; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w/MZivQ7r1tdwpDnFtMBphLBJG9TSs0ALU4e/RPdpNw=;
        b=Hgot9SLqswZzBcz0MrE0iR6Wr33ksiHgfxUKGeee2W3oO77qyHc6W1pNBSSL/esGau
         KPdOXdR0cIU+x3ZSgMiHgVGX1mZdJRlV9/mb3hOIQGYEBMVFSfp2naytcr6xYny7TPA5
         zTE1FmEpMnLwvoHo68ta/G3Oxktw+SRJ80ecjv8kVFXMgpw0wD7qIJhA9ZkIqtLkCYUY
         JSr1gW0iCrKKGXgActuSpTPb6xkiHnbQ44yXTs4o6mLVJ3fgtdeX7ev7Bj8a3UB6F43+
         2DSVhvW6tEoD4CRj7V/9xMM9LfBV73VdjG47/0zW6J52IApmr4nbNJm/Y9FU7VOVmiFW
         h5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728684244; x=1729289044;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w/MZivQ7r1tdwpDnFtMBphLBJG9TSs0ALU4e/RPdpNw=;
        b=SjLoS6+YMjEPTrpxBuC9V9JU2RC/qvFQUZGMG+2Vp0dglk6P7ZG59dVGPfUdqOO/zC
         rjCjM31bKa/hgUskQZTe50YjgozjPku53s0EXdIcraUgONQ1KUgZ+joB57ZnAobO8XzN
         CVXQ/7CYiD59L6chV63FgWE7cTAQn7YtTZK1V4HDtMaLM7rUcz9Ruix4rXEAPokiG032
         v2z0NEqPjjcumxldsPZ/Nnxdor+oj8IQ+nMLU/1eHSrsbU30EnZwwMlRvMZriCCyhp4c
         kiQk+5E1PBCKSwPQJoEk5DHbVTRhKsOGnNI/VhTH/Dl9kSiMhf9yKneIls5uiKMqZVBP
         cEQg==
X-Forwarded-Encrypted: i=1; AJvYcCVV866LskUSm7ZOapWIagvMN2gWBHmsi7yqoufLnRua4tg0Ig/bW1jBBJQeLxsEt5qyxdu1OQhwQFKH3UhA7CXG@vger.kernel.org
X-Gm-Message-State: AOJu0YwAOzu4+1fod6a3+Cyu1nCkRAaXmkg1SqvvPJ//AE3Ly0/A4WdV
	sideKE3Q6nFgy8Bq6Ra7mlaw0llT7INoS6eR9+rlkEqblh84bGiAZdB43ix3I++bq42QHd3KI9t
	C8k8+oA==
X-Google-Smtp-Source: AGHT+IEjdPs6yTN0q32XZWt3awRHs1FP3Tong+0smaqfivJgs8yGKw7PxPi31X3WsIaJP3Ru7bXGU8Mf4WS6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8144:56f:2e1e:4db])
 (user=irogers job=sendgmr) by 2002:a25:5f44:0:b0:e28:8f62:e735 with SMTP id
 3f1490d57ef6-e2919d71b86mr2999276.1.1728684243824; Fri, 11 Oct 2024 15:04:03
 -0700 (PDT)
Date: Fri, 11 Oct 2024 15:03:46 -0700
Message-Id: <20241011220354.756798-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 0/8] Run tests in parallel showing number of tests running
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

Avoid waitpid so that stdout/stderr aren't destroyed prior to wanting
to read them for display. When running on a color terminal, display
the number of running tests (1 if sequential). To avoid previous
flicker, only delete and refresh the display line when it changes. An
earlier version of this code is here:
https://lore.kernel.org/lkml/20240701044236.475098-1-irogers@google.com/

Add a signal handler for perf tests so that unexpected signals are
displayed and test clean up is possible.

In perf test add an "exclusive" flag that causes a test to be run with
no other test. Set this flag manually for C tests and via a
"(exclusive)" in the test description for shell tests. Add the flag to
shell tests that may fail when run with other tests.

Change the perf test loop to run in two passes. For parallel
execution, the first pass runs all tests that can be run in parallel
then the 2nd runs remaining tests sequentially. This causes the
"exclusive" tests to be run last and with test numbers moderately out
of alignment.

Change the default to be to run tests in parallel. Running tests in
parallel brings the execution time down to less than half.

v2: Fix inaccurate remaining counts when running specific
    tests. Rename "remaining" to "active" to better reflect the
    testing behavior. Move the exclusive flag to test cases and not
    entire suites. Add more "(exclusive)" flags to test as
    suggested-by James Clark. Remove "(exclusive)" flag from test
    descriptions to keep the command line output more concise. Add
    James Clark's tested-by.

Ian Rogers (8):
  tools subcmd: Add non-waitpid check_if_command_finished()
  perf test: Display number of active running tests
  perf test: Reduce scope of parallel variable
  perf test: Avoid list test blocking on writing to stdout
  perf test: Tag parallel failing shell tests with "(exclusive)"
  perf test: Add a signal handler around running a test
  perf test: Run parallel tests in two passes
  perf test: Make parallel testing the default

 tools/lib/subcmd/run-command.c                |  33 +++
 tools/perf/tests/builtin-test.c               | 274 ++++++++++++------
 .../tests/shell/coresight/asm_pure_loop.sh    |   2 +-
 .../shell/coresight/memcpy_thread_16k_10.sh   |   2 +-
 .../coresight/thread_loop_check_tid_10.sh     |   2 +-
 .../coresight/thread_loop_check_tid_2.sh      |   2 +-
 .../shell/coresight/unroll_loop_thread_10.sh  |   2 +-
 tools/perf/tests/shell/list.sh                |   5 +-
 .../tests/shell/perftool-testsuite_report.sh  |   2 +-
 tools/perf/tests/shell/record.sh              |   2 +-
 tools/perf/tests/shell/record_lbr.sh          |   2 +-
 tools/perf/tests/shell/record_offcpu.sh       |   2 +-
 tools/perf/tests/shell/stat_all_pmu.sh        |   2 +-
 tools/perf/tests/shell/test_arm_coresight.sh  |   2 +-
 .../tests/shell/test_arm_coresight_disasm.sh  |   2 +-
 tools/perf/tests/shell/test_arm_spe.sh        |   2 +-
 tools/perf/tests/shell/test_intel_pt.sh       |   2 +-
 .../perf/tests/shell/test_stat_intel_tpebs.sh |   2 +-
 tools/perf/tests/task-exit.c                  |   9 +-
 tools/perf/tests/tests-scripts.c              |   7 +-
 tools/perf/tests/tests.h                      |   9 +
 tools/perf/util/color.h                       |   1 +
 22 files changed, 258 insertions(+), 110 deletions(-)

-- 
2.47.0.rc1.288.g06298d1525-goog

