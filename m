Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39F42FBDEB
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 22:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758234130; cv=none; b=LjvaSfsvMnYK/wEzpaQ0UxQL9ZlruceGOw60vsMfEc5gD4vlUoCxsxXJ5oaJ3a/FljV5EOoe2UTCjOMxng+CmBPH63r0o6rKnscJuY/K36Rljb911eiJVcBfrLAFqJqLyirr47UniuzkBr9xiNgQ42djhMPBxBw3KjEch+qQsCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758234130; c=relaxed/simple;
	bh=B1qncqkGZBlGmoRjWSdOLv2hw8gFwrEhONtGaXyf8dg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=RiG2JsvdHsyssyJwymQIIZxmUfjKHf98GOi/RROHvXhGzlSMWzUd8nA9xfW2xl77TjZCXmCzQ3VfwCKkkWOsDHdUALhTMykgq/3ksx7zVFCjVmIss8NYJkCELf5SHnSNZsuk8JFecYMg6Bm4gGhlvfFF2pgQ9ajL02BCEDTSGTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j76WnC9L; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j76WnC9L"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e6e71f7c6so1421029b3a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 15:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758234128; x=1758838928; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bKYJvBahvbkcM2QwKRyULEXALXOTmp7qcHJNyKe9Ay8=;
        b=j76WnC9LapzL/aoJ4uRXcqAFx09djFjEJAAAT9m1mkRAkhNNPLsiLJCzUOQ6UYpkdV
         r0a/3hjPcdydaLUyIH9Y2nzMREUMoIiks3vxt/6b6Jr2G8zAoYLCLLvEPvaHijOALvET
         v6YlnmDoIfmSyxlMcf5uhpeU+3lMkwUxpNfsjaotsyBg2c+zH3zDV1OM2/HSV7D/K2mL
         ceaZ4avrIQdRjgYUYnEskzYPhlLksQtdrOphll8U+TaLQjHWXDAEZDD2nI+QvYNprw2B
         in72+dW643zkiF4W96Gol0B4FTXYITK73a/s5eU3y9JEbMF7EPUhBHK3oq+77eLg8DvH
         ETrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758234128; x=1758838928;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bKYJvBahvbkcM2QwKRyULEXALXOTmp7qcHJNyKe9Ay8=;
        b=LlFHLIJv0RAA8mvOL36pxARxrWM9ifQ4F+RWSu7OaRUPvVvae25GOuWpwWp+6ajhCc
         I3qPy8EjR+nmkSfTNK47KVLg6f7ZvADQ8bCdJnaxYpavIrrnW4nJtslsMBvItMlpXPUQ
         9HMhUvvEKcrTr3LkPHu7RolvQTFe8niPvKqIAw1s7+uUP29mfdGI8aBwAcSaH5cgKm9E
         /pXUKRQUUPM4k0LjLyWVTB6OZhY203CkEYY7RiIf9oJxr0LgtXHKG4nU24AAeDfKUI89
         GqCmaEedwj39WdxPclp/piyu3z81rkm1XSHcPM7dgmOwvs2Z9ebp06Te3YXY+46RGHWi
         RoVg==
X-Forwarded-Encrypted: i=1; AJvYcCXiiw4ZTYEgkW3OAEt9Sb74fFq2JKDHa4blCIrGvABkejtwhQIruJyAaLg+QEJX9J367GN5HPaNExiwoL7I16Fy@vger.kernel.org
X-Gm-Message-State: AOJu0YyFfhFqg5bV4UFcfjXkcP7ies8Cf4CFsCmOPlZeZN1iufBzKQCT
	nKzKdtgc5mb23FsbkSdez0sfSHh/1u3y5sG9ED2/WAWjs48/0QvYpWbtXIJ4gvIKG1meXmVe14F
	/0B5MJmkdyw==
X-Google-Smtp-Source: AGHT+IGyVyZpa+TsJ31qkvSyn/bfX+ssskli1JTbTQJdQOR6kUCT2UtSkRRnK/WsF8nvoUuZaQhOwxbAcvJh
X-Received: from pfblo12.prod.google.com ([2002:a05:6a00:3d0c:b0:77e:40c7:d12e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e1b:b0:76e:99fc:dde7
 with SMTP id d2e1a72fcca58-77e4eaa9a5amr1230546b3a.22.1758234127950; Thu, 18
 Sep 2025 15:22:07 -0700 (PDT)
Date: Thu, 18 Sep 2025 15:22:00 -0700
In-Reply-To: <20250918222202.1353854-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918222202.1353854-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250918222202.1353854-2-irogers@google.com>
Subject: [PATCH v2 1/3] perf test: Don't leak workload gopipe in PERF_RECORD_*
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Chun-Tse Shao <ctshao@google.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The test starts a workload and then opens events. If the events fail
to open, for example because of perf_event_paranoid, the gopipe of the
workload is leaked and the file descriptor leak check fails when the
test exits. To avoid this cancel the workload when opening the events
fails.

Before:
```
$ perf test -vv 7
  7: PERF_RECORD_* events & perf_sample fields:
--- start ---
test child forked, pid 1189568
Using CPUID GenuineIntel-6-B7-1
------------------------------------------------------------
perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  config                           0xa00000000 (cpu_atom/PERF_COUNT_HW_CPU_CYCLES/)
  disabled                         1
------------------------------------------------------------
sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8
sys_perf_event_open failed, error -13
------------------------------------------------------------
perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  config                           0xa00000000 (cpu_atom/PERF_COUNT_HW_CPU_CYCLES/)
  disabled                         1
  exclude_kernel                   1
------------------------------------------------------------
sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 3
------------------------------------------------------------
perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  config                           0x400000000 (cpu_core/PERF_COUNT_HW_CPU_CYCLES/)
  disabled                         1
------------------------------------------------------------
sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8
sys_perf_event_open failed, error -13
------------------------------------------------------------
perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  config                           0x400000000 (cpu_core/PERF_COUNT_HW_CPU_CYCLES/)
  disabled                         1
  exclude_kernel                   1
------------------------------------------------------------
sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 3
Attempt to add: software/cpu-clock/
..after resolving event: software/config=0/
cpu-clock -> software/cpu-clock/
------------------------------------------------------------
perf_event_attr:
  type                             1 (PERF_TYPE_SOFTWARE)
  size                             136
  config                           0x9 (PERF_COUNT_SW_DUMMY)
  sample_type                      IP|TID|TIME|CPU
  read_format                      ID|LOST
  disabled                         1
  inherit                          1
  mmap                             1
  comm                             1
  enable_on_exec                   1
  task                             1
  sample_id_all                    1
  mmap2                            1
  comm_exec                        1
  ksymbol                          1
  bpf_event                        1
  { wakeup_events, wakeup_watermark } 1
------------------------------------------------------------
sys_perf_event_open: pid 1189569  cpu 0  group_fd -1  flags 0x8
sys_perf_event_open failed, error -13
perf_evlist__open: Permission denied
---- end(-2) ----
Leak of file descriptor 6 that opened: 'pipe:[14200347]'

---- unexpected signal (6) ----
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
    #0 0x565358f6666e in child_test_sig_handler builtin-test.c:311
    #1 0x7f29ce849df0 in __restore_rt libc_sigaction.c:0
    #2 0x7f29ce89e95c in __pthread_kill_implementation pthread_kill.c:44
    #3 0x7f29ce849cc2 in raise raise.c:27
    #4 0x7f29ce8324ac in abort abort.c:81
    #5 0x565358f662d4 in check_leaks builtin-test.c:226
    #6 0x565358f6682e in run_test_child builtin-test.c:344
    #7 0x565358ef7121 in start_command run-command.c:128
    #8 0x565358f67273 in start_test builtin-test.c:545
    #9 0x565358f6771d in __cmd_test builtin-test.c:647
    #10 0x565358f682bd in cmd_test builtin-test.c:849
    #11 0x565358ee5ded in run_builtin perf.c:349
    #12 0x565358ee6085 in handle_internal_command perf.c:401
    #13 0x565358ee61de in run_argv perf.c:448
    #14 0x565358ee6527 in main perf.c:555
    #15 0x7f29ce833ca8 in __libc_start_call_main libc_start_call_main.h:74
    #16 0x7f29ce833d65 in __libc_start_main@@GLIBC_2.34 libc-start.c:128
    #17 0x565358e391c1 in _start perf[851c1]
  7: PERF_RECORD_* events & perf_sample fields                       : FAILED!
```

After:
```
$ perf test 7
  7: PERF_RECORD_* events & perf_sample fields                       : Skip (permissions)
```

Fixes: 16d00fee7038 ("perf tests: Move test__PERF_RECORD into separate object")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/perf-record.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index d895df037707..efbd9cd60c63 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -130,6 +130,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 	if (err < 0) {
 		pr_debug("sched__get_first_possible_cpu: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
+		evlist__cancel_workload(evlist);
 		goto out_delete_evlist;
 	}
 
@@ -141,6 +142,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 	if (sched_setaffinity(evlist->workload.pid, cpu_mask_size, cpu_mask) < 0) {
 		pr_debug("sched_setaffinity: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
+		evlist__cancel_workload(evlist);
 		goto out_delete_evlist;
 	}
 
@@ -152,6 +154,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 	if (err < 0) {
 		pr_debug("perf_evlist__open: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
+		evlist__cancel_workload(evlist);
 		goto out_delete_evlist;
 	}
 
@@ -164,6 +167,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 	if (err < 0) {
 		pr_debug("evlist__mmap: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
+		evlist__cancel_workload(evlist);
 		goto out_delete_evlist;
 	}
 
-- 
2.51.0.470.ga7dc726c21-goog

