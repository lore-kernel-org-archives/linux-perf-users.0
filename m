Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A535E16A956
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Oct 2024 05:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230451; cv=none; b=eX6ENfKwgQX+psn/cvvJSGmxQvbqU3G26xMak2BAc78PZPsshqUTD3sQXEhQ+qkpnz+Mru7Y0xZTlHauJ1t7E3o/XFkQhst3uywY9koUSA8WrbUxQFEH1sylYwvj1McVtKT5Vzvj2aHR3KhZybIlDcNiV2lQoc2ovwTwdASFTnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230451; c=relaxed/simple;
	bh=Be9XG85+7HH1poiSwiKb5Q0p1njOYAcmV4hvbUMH2pw=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=F8mF7btmCrul5aJKiW6FKUf6is7ThVeAyBevxJ2Vt7jRmqoK2+gnYQ3RFlCl4YB/NHdd6fBPQuNoeE3y2fRnvv54/k8iEKwZAGM2+DGCxRF5xCP+bClFjhfCEvZNkkHyV5iuzFoTqqFV98BPgRRKqa+sw2fwmQpyftxVgzMDUWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RaaSsAW+; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RaaSsAW+"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2946a143efso2322182276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 22:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729230449; x=1729835249; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VrQeD5sru+L6xsNKe/FlD8yMmpNuX81cs9n3mjgfW1s=;
        b=RaaSsAW+epgTl0H2h7pR5GzMSzQdfqTlW+P19EEyTGrgbBD8AiyVjydbe5JAluDm35
         RUPkBR8N+S5sB7wZB+i6Ds62Qpx/uKT8p2LxwevytAjXu1nC8lK1pffmxwT3L2di8qsY
         OQ/5W3ql7CRUak7+J4h89zcKHRIMgqLHcUTtDueTZzzyhvh91FjTDb0c6DSL0sZUhfNM
         t3cyKm3f3VmAse5MwCnSWdg/Ql6Su1PDXi/7WHnfLJtc+jAxaRYvOXNmdHcTQ5zcubYn
         vQVGDpdEILUeOljAvTljosJsLfokjT8ERupyJKEuZYnF8AJTQSsGkIhZ/ZetXLU/W31l
         ZwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729230449; x=1729835249;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VrQeD5sru+L6xsNKe/FlD8yMmpNuX81cs9n3mjgfW1s=;
        b=HmfHRN5rUSqtwtUsV6/d408tOPEXvkKScEIHsOuurRQ6YXRPQ+vfAE8XNq+WOciyi3
         6/TiY9DTof9CxsntOmP1ZEpHpx5hqm+GTHiK0oLyqRYS61zC8AyTSuYdC1IvYj1ifbfN
         8G8/MufNAU0F53AFf6ZznPxAoNWoCAChhOSk/q8wX5dkNvU5kBItZPNHBQHGjU7KiMkP
         WS1+ibaK5ZEhqpVAl//H+ghNfmXS+/pJ1u3WdYXpFLbElhKIQjLaBwDfch8I29sKRu25
         wtx7e4nG/yFup9OtayZrQwS32On+C5Bas+mJE9XB9NtxTWhrAsnw8KcRXc6ACfEOn/Xo
         0+RA==
X-Forwarded-Encrypted: i=1; AJvYcCUm8OelZdz1i7iCRPAFyUT/umEff7ZzEe+sZFEYFEyihqn0KWUelsd6WhDZYEBFi7oXczvsIdBoorILsMT7gjvB@vger.kernel.org
X-Gm-Message-State: AOJu0Yy682wE40en7Tqaum9+PpGb2sQATsBMMcstqoY4/lLb9168PEgq
	s6BPuq4LRuLWyGBBSoplNoj+t5h8XTrf2OHzkz12ogkHHzDVb5FK8lw92F9AOnTfIIij1WpWNeD
	Agk376Q==
X-Google-Smtp-Source: AGHT+IGvMxo4IadnWSZnubeWMpuJOJ/5tIo85LiRdyaxo/4QBcuMEWS68hP1qt6QarMqEQAZZouDD/gt0Fme
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:30c5:9d92:bcd:7977])
 (user=irogers job=sendgmr) by 2002:a25:844c:0:b0:e20:2da6:ed77 with SMTP id
 3f1490d57ef6-e2bb3268464mr3521276.5.1729230448659; Thu, 17 Oct 2024 22:47:28
 -0700 (PDT)
Date: Thu, 17 Oct 2024 22:47:10 -0700
Message-Id: <20241018054719.1004128-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 0/9] Run tests in parallel showing number of tests running
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

Ian Rogers (9):
  tools subcmd: Add non-waitpid check_if_command_finished()
  perf test: Display number of active running tests
  perf test: Reduce scope of parallel variable
  perf test: Avoid list test blocking on writing to stdout
  perf test: Tag parallel failing shell tests with "(exclusive)"
  perf test: Add a signal handler around running a test
  perf test: Run parallel tests in two passes
  perf test: Make parallel testing the default
  perf test: Add a signal handler to kill forked child processes

 tools/lib/subcmd/run-command.c                |  33 ++
 tools/perf/tests/builtin-test.c               | 304 ++++++++++++------
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
 27 files changed, 293 insertions(+), 115 deletions(-)

-- 
2.47.0.105.g07ac214952-goog

