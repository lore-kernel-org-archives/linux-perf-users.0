Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E696B20C038
	for <linux-perf-users@vger.kernel.org>; Sun, 11 Jan 2026 04:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768104826; cv=none; b=j2RanvYrLq2bMqlbbZV/dt8JWW0sm0luKV2J91gxsZN6WmIGExlrDjxhmOcUdaKEVDC8c5xHhSutjmhzeMqgUUaCq/zs/ef+iJHPgFDDis+gR8CSeIXo6a/x2Vnv1P555FmhuQF3G0PNBdcVs6OTOJ2/Yy5LY2/wnDx9xYk5XAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768104826; c=relaxed/simple;
	bh=Nja/m0h4RQ2UaQT/fyWyV2Uryol8/H0qxxPOlVJFZQg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=jtrJ0/lPKgA5AwHgYa9wsEtnTxP5W7mrPMYUdEYuM/U5JFUFTPOvDIq/42de7Ti2657pe/GvYD8AtN2HAAOrDaNE3o6iVqdEypxCjp4Y2n62TdSPqOJsy/ZG3u+VJ45gf5Iam3W9jXgBuxz3ct5541IXIgWJSZeIl6nCQVxi9+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eIr7i1b0; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eIr7i1b0"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-11f3b5411c7so14261101c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 10 Jan 2026 20:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768104824; x=1768709624; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zDNmCj4/FzILJ1EEl7OfNsUV1E0gc4gk1ndlLX5FrCk=;
        b=eIr7i1b05bKSeQ62mr+y6aRshB9w2sPFyLEkFaLzBLZvGB9IEkVSSGaOKFVI2c/O/M
         Tmxp+Tl4EOQxxd6fovHd9Sc+wA1bi75CjNoXXrdorfj8GSzugIogYQxEJ4IfR+5sUn43
         1f6ZTbJfrX88mmd9U8EMBO6FoEIsvGciccXiKyG61ZOGsODzYL7t4GxAGoWm3ZA7U1te
         6VHUg4awsICIJTAv1jrVdv1U53GMA8xmhnRoW3QSm9lfM3I5ZczkkkfAJYbaebxxOBZ3
         zz3cBDGqzNimYEH1v7BUgPb06CwlCo0ZHNq8bd4aCXLQSefEmqnuMWl3NwhF6Ush+0w1
         GZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768104824; x=1768709624;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zDNmCj4/FzILJ1EEl7OfNsUV1E0gc4gk1ndlLX5FrCk=;
        b=w/gCCeWaneKfguoXg5SsMVW6GcFGeHheBUplaK1QBotDf9xme3zRvaYvkFDD/kizxV
         g5H9TR+OXk5RnuoA6J+563vP+bD14TOuUCAqIS6gEb9yL5D8Z+/92dzfGImYLe68in/N
         UnaZI5/hyFXP9BZtg3jbm9eIaBgsbbrOZ4xv1CicwVv9RnkoYArQrt60x4k2DS9M7zqX
         wFmBM2ZjZztplJEidG9Fkm5ceb4+J/l4S5fUJWR29VsONGj7QA7XeyNufKi7Ch5/B68k
         R4MZQygboJJiUmv32OloXisfiEijhm+peA4F0tqlppnz9pBXk7udg3RHP9QTBxtWag9o
         CAqA==
X-Forwarded-Encrypted: i=1; AJvYcCVMGEXP/LQhYPp8X3pCocheB9J8t7GtWDAZXrXCPijX2cWmjfKE1gKwZmUzvpWJVj7IWpJiYBOEBBwf8PSYTeqB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/EauoNq8rzChokHAZSyYHFqBBOM3MpIpQx02HLE4lu/hk/IqC
	KE46AS60iiL2dOcc2klMPyrAsqe4gfPWFMC/43a8OX7yORCxazZZEAU7oicRrNaLmix33dLqck4
	QhFMCYva5yw==
X-Google-Smtp-Source: AGHT+IEjoe3J01xcu4iLlFnphMl7KzwtQ1Rf2k4lV9Uf/aciSL5Tuu+YigUD+qwFAio9rb7L4kZGR5FtVQBI
X-Received: from dlbds30.prod.google.com ([2002:a05:7022:251e:b0:11d:cde5:d78e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6a3:b0:11a:51f9:db0
 with SMTP id a92af1059eb24-121f8acf8bfmr16916667c88.11.1768104823910; Sat, 10
 Jan 2026 20:13:43 -0800 (PST)
Date: Sat, 10 Jan 2026 20:13:31 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260111041338.1817056-1-irogers@google.com>
Subject: [PATCH v3 0/7] perf: Add a libdw addr2line implementation
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

An example:
```
$ perf record --call-graph dwarf -e cycles:u -- perf test -w inlineloop 1
[ perf record: Woken up 132 times to write data ]
[ perf record: Captured and wrote 32.814 MB perf.data (4074 samples) ]
$ perf script --fields +srcline
...
perf-inlineloop 1814670 293100.228871:     640004 cpu_core/cycles/u: 
            55a11d6e61ee leaf+0x2e
  inlineloop.c:21 (inlined)
            55a11d6e61ee middle+0x2e
  inlineloop.c:27 (inlined)
            55a11d6e61ee parent+0x2e (perf)
  inlineloop.c:32
            55a11d6e629b inlineloop+0x8b (perf)
  inlineloop.c:47
            55a11d69a3bc run_workload+0x5a (perf)
  builtin-test.c:715
            55a11d69aa9f cmd_test+0x417 (perf)
  builtin-test.c:825
            55a11d6155f5 run_builtin+0xd4 (perf)
  perf.c:349
            55a11d61588d handle_internal_command+0xdd (perf)
  perf.c:401
            55a11d6159e6 run_argv+0x35 (perf)
  perf.c:445
            55a11d615d2f main+0x2cb (perf)
  perf.c:553
            7fae3d233ca7 __libc_start_call_main+0x77 (libc.so.6)
  libc_start_call_main.h:58
            7fae3d233d64 __libc_start_main_impl+0x84
  libc-start.c:360 (inlined)
            55a11d565f80 _start+0x20 (perf)
  ??:0
...
```

v3: Make the caller inline file and line number accurate in the libdw
    addr2line, rather than using the function's declared location.
    Fix reference counts in unwind-libdw. Add fixes tag for srcline
    inline printing.

v2: Fix bias issue with libdwfl functions. Use cu_walk_functions_at
    from perf's dwarf-aux to fully walk inline functions. Add testing
    that inlined functions are shown in the perf script srcline
    callchain information. Add configurability as to which addr2line
    style to use.
    https://lore.kernel.org/lkml/20260110082647.1487574-1-irogers@google.com/

v1: https://lore.kernel.org/lkml/20251122093934.94971-1-irogers@google.com/

Ian Rogers (7):
  perf unwind-libdw: Fix invalid reference counts
  perf addr2line: Add a libdw implementation
  perf addr2line.c: Rename a2l_style to cmd_a2l_style
  perf srcline: Add configuration support for the addr2line style
  perf callchain: Fix srcline printing with inlines
  perf test workload: Add inlineloop test workload
  perf test: Test addr2line unwinding works with inline functions

 tools/perf/builtin-report.c                 |  10 ++
 tools/perf/tests/builtin-test.c             |   1 +
 tools/perf/tests/shell/addr2line_inlines.sh |  47 ++++++
 tools/perf/tests/tests.h                    |   1 +
 tools/perf/tests/workloads/Build            |   2 +
 tools/perf/tests/workloads/inlineloop.c     |  52 +++++++
 tools/perf/util/Build                       |   1 +
 tools/perf/util/addr2line.c                 |  20 +--
 tools/perf/util/config.c                    |   4 +
 tools/perf/util/dso.c                       |   2 +
 tools/perf/util/dso.h                       |  11 ++
 tools/perf/util/evsel_fprintf.c             |   8 +-
 tools/perf/util/libdw.c                     | 153 ++++++++++++++++++++
 tools/perf/util/libdw.h                     |  60 ++++++++
 tools/perf/util/srcline.c                   | 116 ++++++++++++++-
 tools/perf/util/srcline.h                   |   3 +
 tools/perf/util/symbol_conf.h               |  10 ++
 tools/perf/util/unwind-libdw.c              |   7 +-
 18 files changed, 486 insertions(+), 22 deletions(-)
 create mode 100755 tools/perf/tests/shell/addr2line_inlines.sh
 create mode 100644 tools/perf/tests/workloads/inlineloop.c
 create mode 100644 tools/perf/util/libdw.c
 create mode 100644 tools/perf/util/libdw.h

-- 
2.52.0.457.g6b5491de43-goog

