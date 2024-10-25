Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E972161F0
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 19:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884078; cv=none; b=OLEFsNruV6rQIQpzrurW3pMT1G+174+Hnjbbnc2+rOT+9L7fwZnB1QHn5FHdYPwhOq9QHJouTAEi4UG2gUpoUvGvXy1j6DNBwqa49qSjb8KkDx5zDae4UywuYmecXJodEWHo/9Xe3+r+SQ2J8AcglwCVYbywlWTO4H0bx1nZVYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884078; c=relaxed/simple;
	bh=a/TWGbFbTJx44iMbNWHvC+ORfVhj4jJLy3uVR1nphIU=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=omxxhLvNEuuehn0EmyNy0JumycxCKjdDbbECiOJ5DV386pDAVFv7gaqHptqMqHbGj6P+XpPa8gVE6naZkJtiskfBJgDcrvamUPq5MwWAPV4SA+dFr3uAfFRoxl0KJnti4//F3TB4u/FXAVInTEH33MD8ZjcWkTfWlGgfMKVcWeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4kAFwroR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4kAFwroR"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e0082c1dd0so50017267b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 12:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729884074; x=1730488874; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jxmJGIq4H32hm0DkPvECpN1AE+jYT8LlOkAl+AswmRY=;
        b=4kAFwroRJvwaGLCH75dkgDZlqhjZHhZAo9b+5EuEJlx1PgTDmka3iTv6vsCuXYZi3a
         JGV5egxe//g/nPZQW6XDXG+ePr8EZUu+ItyeS7PK/DLBfPCKgxaHKv8d7Ar8DGF59vva
         YBppNB/GN927dic9KyMy+Tq6Ov+63cnbq1Zue6I9XqqX+CIvwpen5rrU5ISfOWD9DhAT
         rxTtuveXCJ1x4qi0KRV94UQzZ7jhFQxvMCW5tSzSIxqE7e2FEmxOPt45wbax0bxZ1Ky9
         s4kaklXPQF7BUw+r4o+hBDPivVzAcrKDbe2JSiR2pyLuuD2D1fM1+ufR5KUudu8CByZk
         E6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729884074; x=1730488874;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jxmJGIq4H32hm0DkPvECpN1AE+jYT8LlOkAl+AswmRY=;
        b=CNqh6jMxOLK9m+/SyCr6ZDd3xpB39/V+7A+r3bFyRqhExovfo/AozCfK9UaEJ7r1nM
         9jg6r5pqr6cE+La8IbSGlJfcKM7dDRVY3Qzwjl44WxWJqeYLEKrQodCl6T6J9SXnzXT+
         HYjgSGta8dymPLKK5BhNGxI6ZWi9LKRDuoKEw5ylO7AV2MlrO4oiysx9XSRV9DrEomkd
         oQ7ILEexuQimpN0fmyBTTo+gurZ0ScIFaPCN48LQrsm1l3HNcz0lSt0jbyaCcZG8i2Te
         3vf/x1skZYSOsx7rf9n7uFdoE1Ju+lLyr9yFCCYGrYWLEYgZU+MfMwYOwsdR1p4DWkyG
         5UGA==
X-Forwarded-Encrypted: i=1; AJvYcCVuNnsKszoqBju1M1cw1cEzjSkvX7mAsIbVFxvGSbCmqWb6yx3QyNL7WtGby8ExJxo+T74emX3KfWvOmP62Uip8@vger.kernel.org
X-Gm-Message-State: AOJu0Yzep7ZH3GFiVannsw1bhj9gxN0D9Dq5sG907HtxI2cLrDUNaMQM
	39JZlEQGt+tSYHH/qyiVVDsimKuZ12ONH3B5NENBglOHzly9Pk18MupM4Q9oelvMEHW7NL4qciA
	u6Tc6Hw==
X-Google-Smtp-Source: AGHT+IG60UugzYBREg+paR2N6L0qRUzYk2crmXXQBA6PUb8cKEHp+lzwKsr+m64d+LqM4aPKsO9r3xdCH+jJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5d42:c43e:5e08:3a85])
 (user=irogers job=sendgmr) by 2002:a05:690c:6ac6:b0:6e3:2f0b:b595 with SMTP
 id 00721157ae682-6e9d8b171afmr167647b3.5.1729884074430; Fri, 25 Oct 2024
 12:21:14 -0700 (PDT)
Date: Fri, 25 Oct 2024 12:20:59 -0700
Message-Id: <20241025192109.132482-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 00/10] Run tests in parallel showing number of tests running
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

v5: Make width robust to signal delivery (Namhyung). Minor signal
    print message tweaks and test kill value.

v4: Add patch to sort exclusive tests last, this allows for increasing
    test numbers as requested by Namhyung.

v3: Mark additional shell tests as "(exclusive)" to avoid issues with
    shared resources suggested by Namhyung. Add dependent signal
    handler change so that kill/ctrl-C don't leave lots of processes,
    previously sent here:
    https://lore.kernel.org/lkml/20241017052137.225514-1-irogers@google.com/

v2: Fix inaccurate remaining counts when running specific
    tests. Rename "remaining" to "active" to better reflect the
    testing behavior. Move the exclusive flag to test cases and not
    entire suites. Add more "(exclusive)" flags to test as
    suggested-by James Clark. Remove "(exclusive)" flag from test
    descriptions to keep the command line output more concise. Add
    James Clark's tested-by.

Ian Rogers (10):
  tools subcmd: Add non-waitpid check_if_command_finished()
  perf test: Display number of active running tests
  perf test: Reduce scope of parallel variable
  perf test: Avoid list test blocking on writing to stdout
  perf test: Tag parallel failing shell tests with "(exclusive)"
  perf test: Add a signal handler around running a test
  perf test: Run parallel tests in two passes
  perf test: Make parallel testing the default
  perf test: Add a signal handler to kill forked child processes
  perf test: Sort tests placing exclusive tests last

 tools/lib/subcmd/run-command.c                |  33 ++
 tools/perf/tests/builtin-test.c               | 408 ++++++++++++------
 .../tests/shell/coresight/asm_pure_loop.sh    |   2 +-
 .../shell/coresight/memcpy_thread_16k_10.sh   |   2 +-
 .../coresight/thread_loop_check_tid_10.sh     |   2 +-
 .../coresight/thread_loop_check_tid_2.sh      |   2 +-
 .../shell/coresight/unroll_loop_thread_10.sh  |   2 +-
 tools/perf/tests/shell/list.sh                |   5 +-
 .../tests/shell/perftool-testsuite_report.sh  |   2 +-
 tools/perf/tests/shell/probe_vfs_getname.sh   |   2 +-
 .../shell/record+script_probe_vfs_getname.sh  |   2 +-
 tools/perf/tests/shell/record.sh              |   2 +-
 tools/perf/tests/shell/record_lbr.sh          |   2 +-
 tools/perf/tests/shell/record_offcpu.sh       |   2 +-
 tools/perf/tests/shell/stat_all_pmu.sh        |   2 +-
 tools/perf/tests/shell/stat_bpf_counters.sh   |   2 +-
 tools/perf/tests/shell/test_arm_coresight.sh  |   2 +-
 .../tests/shell/test_arm_coresight_disasm.sh  |   2 +-
 tools/perf/tests/shell/test_arm_spe.sh        |   2 +-
 tools/perf/tests/shell/test_data_symbol.sh    |   2 +-
 tools/perf/tests/shell/test_intel_pt.sh       |   2 +-
 .../perf/tests/shell/test_stat_intel_tpebs.sh |   2 +-
 .../tests/shell/trace+probe_vfs_getname.sh    |   2 +-
 tools/perf/tests/task-exit.c                  |   9 +-
 tools/perf/tests/tests-scripts.c              |   7 +-
 tools/perf/tests/tests.h                      |   9 +
 tools/perf/util/color.h                       |   1 +
 27 files changed, 367 insertions(+), 145 deletions(-)

-- 
2.47.0.163.g1226f6d8fa-goog

