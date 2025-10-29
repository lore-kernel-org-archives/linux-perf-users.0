Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF852DC336
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 05:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716060; cv=none; b=KaPMX3JiM/rtnE8SqGsQeIjyelgK+L03WGj02TileOa1ww7CRKANCZo3JD0FoGeeMhzO/9IRNfWAAEneDZcjGVYkIAD6r6rdzJkBoguXFqE/FFdKSXCpR6iUAnK3/HOFwAK4xJ0i7KvXGrbH1x8oOwm1PJNuhTVwKey6NrOWpVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716060; c=relaxed/simple;
	bh=NJ+hTolWc4xkY7BMglYVo4imVv7Wplrz6gOXCSJq2Ds=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=dvs8586PrlprjWK1xTnrUCvD4Ki5XFzk96shefa2p6AzXFVTy585j4/e4156b+JnC14WFXIf2HIIgldowJv4LbSHeB6U2Huh8JZGoWL2HAjG3eQe3dOkH7giqOTKjVs7QYAXGTUffvYS+9XZgNnKzvp+rS6dSsFYoEZzab1U2G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VUgmMN2t; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VUgmMN2t"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3307af9b55eso5169179a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Oct 2025 22:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761716059; x=1762320859; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EskCADth3YkVR5hqBOBJMx3UfzeP9v/HlYYqFyqmjNg=;
        b=VUgmMN2tb2M6ZCpc4JwlUMmLEVha2ZCABlkGmSOOAVyHXxMKcOTHv79LSLvl0yD6Ac
         U+1WchxrTnA2YoeXCaHE+zEPKMmUn4vz8MPg7mBMqUAjWdrLDG7JecvtG3+z1+o/JWpx
         fooXXC+11/ZXbEDwj81zwx8FNa06p3fhB71J2P0/kKJ5DkA39RsiyEpLWwyJWPm1eYRw
         CukP6u2xfJ1EXMV0yHJwKKyy47r8lU961qibzJB5rk32BCZnXqKmOTXlIyjnAWSBcUX6
         ROsqZlyQWEMr6hlXOj6rxkCKlNgWQxGIv5ODI8Hgj+fE9AtCAgzNY+xGEoJUmXvwmTdd
         EtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761716059; x=1762320859;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EskCADth3YkVR5hqBOBJMx3UfzeP9v/HlYYqFyqmjNg=;
        b=WvzJQgRCIAHFSSe8t7IXohWblz4MO5VnWIvKr3uBQDVPSw32iKrgv55da/v2f/jK6h
         pNs/QqaUZP2hsLaF8lU0EWXZ3LFfCuAVokEcdvuNjIngyPWh4k9I0zVF3+k61nqu/Hmx
         pIsfLh20A7aOJ2G+OLgO2eQUfQWXFv/qHqCDH4rtxo6HvBRadwi8z8o9H1tI6R17T5OZ
         ltDxX3LPsxvEXXhdu9yy5IiDTWI9AWJQ9HVRBvu9vqf2DLE5oAYGxDcX49KHQ03nTFg2
         cWvxRwXHKh3Gsr7hMHJeYq+760sUNyOxC6cfV7aOrNTasyIxQl1wRcD9ecBsPR/K2Kvd
         CUWA==
X-Forwarded-Encrypted: i=1; AJvYcCXHKvkB0ELtqA2gz6S2ZaV0SdTVR/HcMPHZPM+rUk9GzijA2gShnZ1Jy7z0EFCriTMiR4lCpmk99/rzUs66VPb1@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn2xW1t22S9dWltS0jqVn8QYPRmXBefTAqgAxqK3mTOk24QOX/
	b15g9ZIGentonZvgfWKaf6BV5Fahm+NDoKJypxZxvXwGhLhWaRIJRqZau7ZzQXD0IaFWKJRKH1q
	GcHZGCEjoqw==
X-Google-Smtp-Source: AGHT+IFPNXoSGhjR7OA9Vl3X20TTJL+tNHDOIMRqTV+avvu9i2EoGYohtUBzaMR+zCMk/654e3znpCZDBHZq
X-Received: from pjtf19.prod.google.com ([2002:a17:90a:c293:b0:33b:da89:9788])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:38cb:b0:32e:389b:8762
 with SMTP id 98e67ed59e1d1-3403a0d852fmr1778390a91.0.1761716058566; Tue, 28
 Oct 2025 22:34:18 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:33:58 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029053413.355154-1-irogers@google.com>
Subject: [RFC PATCH v1 00/15] Addition of session API to python module
From: Ian Rogers <irogers@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Song Liu <song@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Blake Jones <blakejones@google.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

The perf script command uses a session with process_events to call
through to the python process_events function. The event is turned
into a python dictionary, whether the entries are used or not, adding
overhead. To avoid the overhead, add a session API abstraction and
pass callbacks that can be used to perform the existing perf script
functions. The implementation is incomplete in this RFC.

In this series the mem-phys-addr.py command is ported from perf script
to using the session API. The performance before and after is:

Before:
```
$ perf mem record -a sleep 1
$ time perf script tools/perf/scripts/python/mem-phys-addr.py
Event: cpu_core/mem-loads-aux/
Memory type                                    count  percentage
 ---------------------------------------  ----------  ----------
0-fff : Reserved                                3217       100.0

real    0m3.754s
user    0m0.023s
sys     0m0.018s
```

After:
```
$ PYTHONPATH=/tmp/perf/python time python3 tools/perf/python/mem-phys-addr.py
Event: evsel(cpu_core/mem-loads-aux/)
Memory type                                    count  percentage
 ---------------------------------------  ----------  ----------
0-fff : Reserved                                3217       100.0

real    0m0.106s
user    0m0.021s
sys     0m0.020s
```

So a roughly 35x speedup, but it maybe that some of that is one time
start-up overhead of libpython which wouldn't be present for larger
perf.data files.

Before porting all the script commands and adding things like
callchain support to the python module, I wanted to get feedback. One
thing that particularly simplifies the series is adding reference
counts to evsel and evlist to avoid copying/cloning evsels created by
the session API when loading a perf.data file.

The approach of moving away from libpython and scripts was most
recently discussed as a topic in:
https://lore.kernel.org/lkml/CAP-5=fWDqE8SYfOLZkg_0=4Ayx6E7O+h7uUp4NDeCFkiN4b7-w@mail.gmail.com/

When creating the python wrapper some house keeping was done around
includes and perf_data's encapsulation.

The perf script callbacks differ from those in perf_tool, for example,
stat is the perf_tool callback is for a stat event while the scripting
ops combine things and have a stat callback associated with
stat_round. Should the session API match the tool or the script API?
The former feels better for long term, while the latter could simplify
porting perf scripts.

Ian Rogers (15):
  perf arch arm: Sort includes and add missed explicit dependencies
  perf arch x86: Sort includes and add missed explicit dependencies
  perf tests: Sort includes and add missed explicit dependencies
  perf script: Sort includes and add missed explicit dependencies
  perf util: Sort includes and add missed explicit dependencies
  perf python: Add add missed explicit dependencies
  perf evsel/evlist: Avoid unnecessary #includes
  perf maps: Move getting debug_file to verbose path
  perf data: Clean up use_stdio and structures
  perf python: Add wrapper for perf_data file abstraction
  perf python: Add python session abstraction wrapping perf's session
  perf evlist: Add reference count
  perf evsel: Add reference count
  perf python: Add access to evsel and phys_addr in event
  perf mem-phys-addr.py: Port to standalone application from perf script

 tools/perf/arch/arm/util/cs-etm.c           |  22 +-
 tools/perf/arch/x86/tests/hybrid.c          |   2 +-
 tools/perf/arch/x86/tests/topdown.c         |   2 +-
 tools/perf/arch/x86/util/intel-bts.c        |  14 +-
 tools/perf/arch/x86/util/intel-pt.c         |  31 +-
 tools/perf/arch/x86/util/iostat.c           |   2 +-
 tools/perf/bench/evlist-open-close.c        |  18 +-
 tools/perf/builtin-ftrace.c                 |   8 +-
 tools/perf/builtin-inject.c                 |   7 +-
 tools/perf/builtin-kvm.c                    |   4 +-
 tools/perf/builtin-lock.c                   |   2 +-
 tools/perf/builtin-record.c                 |  14 +-
 tools/perf/builtin-script.c                 | 109 ++--
 tools/perf/builtin-stat.c                   |   8 +-
 tools/perf/builtin-top.c                    |  52 +-
 tools/perf/builtin-trace.c                  |  38 +-
 tools/perf/python/mem-phys-addr.py          | 117 ++++
 tools/perf/tests/backward-ring-buffer.c     |  18 +-
 tools/perf/tests/code-reading.c             |   4 +-
 tools/perf/tests/event-times.c              |   4 +-
 tools/perf/tests/event_update.c             |   2 +-
 tools/perf/tests/evsel-roundtrip-name.c     |   8 +-
 tools/perf/tests/evsel-tp-sched.c           |   4 +-
 tools/perf/tests/expand-cgroup.c            |   8 +-
 tools/perf/tests/hists_cumulate.c           |   2 +-
 tools/perf/tests/hists_filter.c             |   2 +-
 tools/perf/tests/hists_link.c               |   2 +-
 tools/perf/tests/hists_output.c             |   2 +-
 tools/perf/tests/hwmon_pmu.c                |  14 +-
 tools/perf/tests/keep-tracking.c            |   2 +-
 tools/perf/tests/mmap-basic.c               |  31 +-
 tools/perf/tests/openat-syscall-all-cpus.c  |   6 +-
 tools/perf/tests/openat-syscall-tp-fields.c |  18 +-
 tools/perf/tests/openat-syscall.c           |   6 +-
 tools/perf/tests/parse-events.c             |   4 +-
 tools/perf/tests/parse-metric.c             |   4 +-
 tools/perf/tests/parse-no-sample-id-all.c   |   2 +-
 tools/perf/tests/perf-record.c              |  18 +-
 tools/perf/tests/perf-time-to-tsc.c         |   2 +-
 tools/perf/tests/pfm.c                      |   4 +-
 tools/perf/tests/pmu-events.c               |   6 +-
 tools/perf/tests/pmu.c                      |   2 +-
 tools/perf/tests/sw-clock.c                 |  14 +-
 tools/perf/tests/switch-tracking.c          |   2 +-
 tools/perf/tests/task-exit.c                |  14 +-
 tools/perf/tests/tool_pmu.c                 |   2 +-
 tools/perf/tests/topology.c                 |   5 +-
 tools/perf/util/bpf_counter_cgroup.c        |   2 +-
 tools/perf/util/bpf_off_cpu.c               |  28 +-
 tools/perf/util/bpf_trace_augment.c         |   7 +-
 tools/perf/util/cgroup.c                    |   6 +-
 tools/perf/util/data-convert-bt.c           |   2 +-
 tools/perf/util/data.c                      |  81 ++-
 tools/perf/util/data.h                      |  52 +-
 tools/perf/util/evlist.c                    | 100 ++--
 tools/perf/util/evlist.h                    |  23 +-
 tools/perf/util/evsel.c                     | 103 ++--
 tools/perf/util/evsel.h                     |  30 +-
 tools/perf/util/expr.c                      |   2 +-
 tools/perf/util/header.c                    |  12 +-
 tools/perf/util/map.h                       |   6 +-
 tools/perf/util/maps.c                      |   9 +-
 tools/perf/util/metricgroup.c               |   6 +-
 tools/perf/util/parse-events.c              |   4 +-
 tools/perf/util/parse-events.y              |   2 +-
 tools/perf/util/perf_api_probe.c            |  19 +-
 tools/perf/util/pfm.c                       |   2 +-
 tools/perf/util/print-events.c              |   2 +-
 tools/perf/util/print_insn.h                |   5 +-
 tools/perf/util/python.c                    | 584 +++++++++++++++-----
 tools/perf/util/record.c                    |   2 +-
 tools/perf/util/s390-sample-raw.c           |  15 +-
 tools/perf/util/session.c                   |   4 +-
 tools/perf/util/sideband_evlist.c           |  16 +-
 tools/perf/util/stat-shadow.c               |   1 +
 tools/perf/util/stat.c                      |  15 +-
 76 files changed, 1152 insertions(+), 650 deletions(-)
 create mode 100644 tools/perf/python/mem-phys-addr.py

-- 
2.51.1.851.g4ebd6896fd-goog

