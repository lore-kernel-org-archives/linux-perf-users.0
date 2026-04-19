Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B7A2E7F2C
	for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 23:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643165; cv=none; b=BFlNZwHwPdMwpoFXZtmQokSmKW05lM5CiplQTlGjWfZi/jx0us5vNGS6KtjP9yhE7UluACeRKTbmL0qmOvqZq0AxJx6leMCDxN4FLS6QQTK5XlCfinGmpP0+3esFV0SeUR0jaFSr2IJWH34axaFsX85zS4mvt+PWhbf+tJi5ky4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643165; c=relaxed/simple;
	bh=St3t8/YcFQ+c9Yoxwudpj8FodMhCVdbroZZ+Kc5S/DM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pFnZenQiloTNTwVF8HU3mJOBh/aVYtQIUKNhXSGM0pFm7B2m2WztavJO5f6qHCJe6ztlI9JA56eewN5j5QWBw7T11l+rqWvhYsKDFxJdG0mNtnqt5XLvE8GvJ/HcN/xLPyqGD14goB6n64TqrnkK5f3sFcajqrl2pdYAq4A1ZI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t61ZjxRY; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t61ZjxRY"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2cc75e79b97so2085166eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 16:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643161; x=1777247961; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CQ4QzCp9az2D/3bdnBhSlK69MH7xeY0dfO4aLuVaNPw=;
        b=t61ZjxRYni7YkYcEIqB3KkSilaMy0rOYo7o9qqNEkrPzRFlwvTV+sC4HxZlbSK0NCE
         UHAgXL4lI4AmlRPODWN92FOZeSvH5PfDUGccaqxPzGJ/1b62jh2RtuF4zLubcQgSfgni
         LGTZpXdXjnk+Gs3grafoNPw95FHFZt93WTIr6pPG11rmLmmpmKONRnVwVhEraxrEPW06
         Zbq5EJUcTXqd6l5/+0YrIct3+0ICbGaytMw59qooaevI5yysMSpbjUNXWP02qwdihhaI
         6v+RUJu+YnI7hqbQcIK/laizg1hrNEEBtNsIKL3+00iAPYDfOEqu8JfPrKOm6Bhd73SQ
         FAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643161; x=1777247961;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CQ4QzCp9az2D/3bdnBhSlK69MH7xeY0dfO4aLuVaNPw=;
        b=DEudT+3fGlPs287FAi5gcLIXnENGfY2FaMSK8Hk43kbPGPktMZtF2jrKt2QrSOe3UK
         GbB+6P2SYypdovPYMCSVuogor0SOWawGhyQWk2FePM69UX0Xlto6dHsYz2VQYCM27slG
         pjBQtIQoyqq4CdF4z0dO+rGUnzWijepH4Si+FpKEwjfp+339JLBWDKJVRrfJwLyTA9DJ
         92+Ht+O/EJIdZB29ZAGJI0kag28PG8/u9wXLe/mF1Dqi1HNFKXjIJcacoV3rNAAH/bhI
         1Sg42ObXi7ZWStthMoDQ2Mf/HJjwnzIXaD8pwrdLQE6z5xFttmR+dCx46Irsy2ZVMAqZ
         4T9A==
X-Forwarded-Encrypted: i=1; AFNElJ83CRmrwPyi8a8BfDTXif5M18e4FAR2B0LoBZOUwRPRredeCGT1KX1W7PM+8WOidkj5F7jezd0R6ZO4pdVuLO6i@vger.kernel.org
X-Gm-Message-State: AOJu0YyhEX64QzQPvTKcD+M5++pWqUBMhSz79uPcAbeVxH/xpv3oSrem
	2eVby7TsqzC2fFRsnKGKLAT3qCkOxBG4IvM8ynZKLxCJ3BTSMln7QCBN4jk82IpiDov7yCOXXI1
	57tb49oM61A==
X-Received: from dycol2.prod.google.com ([2002:a05:7301:db82:b0:2dd:8e19:2d13])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:5784:b0:2de:c5ca:c1f3
 with SMTP id 5a478bee46e88-2e465293dfdmr5689180eec.4.1776643160998; Sun, 19
 Apr 2026 16:59:20 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:12 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-1-irogers@google.com>
Subject: [PATCH v1 00/58] perf: Reorganize scripting support
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alice Rogers <alice.mei.rogers@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Blake Jones <blakejones@google.com>, Changbin Du <changbin.du@huawei.com>, 
	Gautam Menghani <gautam@linux.ibm.com>, Wangyang Guo <wangyang.guo@intel.com>, 
	Pan Deng <pan.deng@intel.com>, Zhiguo Zhou <zhiguo.zhou@intel.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Zecheng Li <zli94@ncsu.edu>, tanze <tanze@kylinos.cn>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	"Tycho Andersen (AMD)" <tycho@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Sun Jian <sun.jian.kdev@gmail.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Ricky Ringler <ricky.ringler@proton.me>, Qinxin Xia <xiaqinxin@huawei.com>, 
	Aditya Bodkhe <adityab1@linux.ibm.com>, Chun-Tse Shao <ctshao@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Chen Ni <nichen@iscas.ac.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The `perf script` command has long supported running Python and Perl
scripts by embedding `libpython` and `libperl`. This approach has
several drawbacks:
 - overhead by creating Python dictionaries for every event (whether
   used or not),
 - complex build dependencies on specific Python/Perl versions,
 - complications with threading due to perf being the interpreter,
 - no clear way to run standalone scripts like ilist.py.

This series takes a different approach with some initial
implementation posted as an RFC last October:
https://lore.kernel.org/linux-perf-users/20251029053413.355154-1-irogers@google.com/
with the motivation coming up on the mailing list earlier:
https://lore.kernel.org/lkml/CAP-5=fWDqE8SYfOLZkg_0=4Ayx6E7O+h7uUp4NDeCFkiN4b7-w@mail.gmail.com/

The changes remove the embedded `libpython` and `libperl` support from
`perf` entirely. Instead, they expand the existing `perf` Python
module to provide full access to perf data files and events, allowing
scripts to be run as standalone Python applications.

To demonstrate the benefits, we ported all existing Python and Perl
scripts to use the new Python session API. The performance improvement
is dramatic. For example, porting `mem-phys-addr.py`:

Before (using embedded libpython in `perf script`):
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

After (using standalone Python script with `perf` module):
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

This is a roughly 35x speedup!

The change is large (10583 insertions, 15882 deletions) due to porting
all existing perl and python code to the new API. Gemini was used to
achieve this and to improve the code quality. Removing support may be
controversial, however, the first 52 patches are additive and merging
those would allow us to focus on the remaining 6 patches that finalize
the new `perf script` behavior.

Ian Rogers (58):
  perf inject: Fix itrace branch stack synthesis
  perf arch arm: Sort includes and add missed explicit dependencies
  perf arch x86: Sort includes and add missed explicit dependencies
  perf tests: Sort includes and add missed explicit dependencies
  perf script: Sort includes and add missed explicit dependencies
  perf util: Sort includes and add missed explicit dependencies
  perf python: Add missed explicit dependencies
  perf evsel/evlist: Avoid unnecessary #includes
  perf data: Add open flag
  perf evlist: Add reference count
  perf evsel: Add reference count
  perf evlist: Add reference count checking
  perf python: Use evsel in sample in pyrf_event
  perf python: Add wrapper for perf_data file abstraction
  perf python: Add python session abstraction wrapping perf's session
  perf python: Add syscall name/id to convert syscall number and name
  perf python: Refactor and add accessors to sample event
  perf python: Add callchain support
  perf python: Add config file access
  perf python: Extend API for stat events in python.c
  perf python: Expose brstack in sample event
  perf python: Add perf.pyi stubs file
  perf python: Add LiveSession helper
  perf python: Move exported-sql-viewer.py and parallel-perf.py to
    tools/perf/python/
  perf stat-cpi: Port stat-cpi to use python module
  perf mem-phys-addr: Port mem-phys-addr to use python module
  perf syscall-counts: Port syscall-counts to use python module
  perf syscall-counts-by-pid: Port syscall-counts-by-pid to use python
    module
  perf futex-contention: Port futex-contention to use python module
  perf flamegraph: Port flamegraph to use python module
  perf gecko: Port gecko to use python module
  perf arm-cs-trace-disasm: Port arm-cs-trace-disasm to use python
    module
  perf check-perf-trace: Port check-perf-trace to use python module
  perf compaction-times: Port compaction-times to use python module
  perf event_analyzing_sample: Port event_analyzing_sample to use python
    module
  perf export-to-sqlite: Port export-to-sqlite to use python module
  perf export-to-postgresql: Port export-to-postgresql to use python
    module
  perf failed-syscalls-by-pid: Port failed-syscalls-by-pid to use python
    module
  perf intel-pt-events: Port intel-pt-events/libxed to use python module
  perf net_dropmonitor: Port net_dropmonitor to use python module
  perf netdev-times: Port netdev-times to use python module
  perf powerpc-hcalls: Port powerpc-hcalls to use python module
  perf sched-migration: Port sched-migration/SchedGui to use python
    module
  perf sctop: Port sctop to use python module
  perf stackcollapse: Port stackcollapse to use python module
  perf task-analyzer: Port task-analyzer to use python module
  perf failed-syscalls: Port failed-syscalls to use python module
  perf rw-by-file: Port rw-by-file to use python module
  perf rw-by-pid: Port rw-by-pid to use python module
  perf rwtop: Port rwtop to use python module
  perf wakeup-latency: Port wakeup-latency to use python module
  perf test: Migrate Intel PT virtual LBR test to use Python API
  perf: Remove libperl support, legacy Perl scripts and tests
  perf: Remove libpython support and legacy Python scripts
  perf Makefile: Update Python script installation path
  perf script: Refactor to support standalone scripts and remove legacy
    features
  perf Documentation: Update for standalone Python scripts and remove
    obsolete data
  perf python: Improve perf script -l descriptions

 tools/build/Makefile.feature                  |    5 +-
 tools/build/feature/Makefile                  |   23 +-
 tools/build/feature/test-all.c                |    6 +-
 tools/build/feature/test-libperl.c            |   10 -
 tools/build/feature/test-libpython.c          |   10 -
 tools/build/feature/test-python-module.c      |   12 +
 tools/perf/Documentation/perf-check.txt       |    2 -
 tools/perf/Documentation/perf-script-perl.txt |  216 --
 .../perf/Documentation/perf-script-python.txt |  702 +-----
 tools/perf/Documentation/perf-script.txt      |   70 +-
 tools/perf/Makefile.config                    |   36 +-
 tools/perf/Makefile.perf                      |   22 +-
 tools/perf/arch/arm/util/cs-etm.c             |   36 +-
 tools/perf/arch/arm64/util/arm-spe.c          |    8 +-
 tools/perf/arch/arm64/util/hisi-ptt.c         |    2 +-
 tools/perf/arch/x86/tests/hybrid.c            |   22 +-
 tools/perf/arch/x86/tests/topdown.c           |    2 +-
 tools/perf/arch/x86/util/auxtrace.c           |    2 +-
 tools/perf/arch/x86/util/intel-bts.c          |   26 +-
 tools/perf/arch/x86/util/intel-pt.c           |   38 +-
 tools/perf/arch/x86/util/iostat.c             |    8 +-
 tools/perf/bench/evlist-open-close.c          |   29 +-
 tools/perf/builtin-annotate.c                 |    2 +-
 tools/perf/builtin-check.c                    |    3 +-
 tools/perf/builtin-ftrace.c                   |   14 +-
 tools/perf/builtin-inject.c                   |   67 +-
 tools/perf/builtin-kvm.c                      |   14 +-
 tools/perf/builtin-kwork.c                    |    8 +-
 tools/perf/builtin-lock.c                     |    2 +-
 tools/perf/builtin-record.c                   |   95 +-
 tools/perf/builtin-report.c                   |    6 +-
 tools/perf/builtin-sched.c                    |   26 +-
 tools/perf/builtin-script.c                   |  874 +++----
 tools/perf/builtin-stat.c                     |   81 +-
 tools/perf/builtin-top.c                      |  104 +-
 tools/perf/builtin-trace.c                    |   60 +-
 tools/perf/python/SchedGui.py                 |  180 ++
 tools/perf/python/arm-cs-trace-disasm.py      |  333 +++
 tools/perf/python/check-perf-trace.py         |  111 +
 tools/perf/python/compaction-times.py         |  325 +++
 tools/perf/python/counting.py                 |    1 +
 tools/perf/python/event_analyzing_sample.py   |  291 +++
 tools/perf/python/export-to-postgresql.py     |  666 +++++
 tools/perf/python/export-to-sqlite.py         |  351 +++
 .../python/exported-sql-viewer.py             |    2 +-
 tools/perf/python/failed-syscalls-by-pid.py   |  121 +
 tools/perf/python/failed-syscalls.py          |   75 +
 tools/perf/python/flamegraph.py               |  242 ++
 tools/perf/python/futex-contention.py         |   54 +
 tools/perf/python/gecko.py                    |  372 +++
 tools/perf/python/intel-pt-events.py          |  421 ++++
 tools/perf/python/libxed.py                   |  119 +
 .../{scripts => }/python/mem-phys-addr.py     |   49 +-
 tools/perf/python/net_dropmonitor.py          |  103 +
 tools/perf/python/netdev-times.py             |  469 ++++
 .../{scripts => }/python/parallel-perf.py     |    0
 tools/perf/python/perf.pyi                    |  481 ++++
 tools/perf/python/perf_live.py                |   42 +
 tools/perf/python/powerpc-hcalls.py           |  209 ++
 tools/perf/python/rw-by-file.py               |  103 +
 tools/perf/python/rw-by-pid.py                |  170 ++
 tools/perf/python/rwtop.py                    |  179 ++
 tools/perf/python/sched-migration.py          |  466 ++++
 tools/perf/python/sctop.py                    |  149 ++
 tools/perf/python/stackcollapse.py            |  120 +
 tools/perf/python/stat-cpi.py                 |  139 ++
 tools/perf/python/syscall-counts-by-pid.py    |   57 +
 tools/perf/python/syscall-counts.py           |   49 +
 tools/perf/python/task-analyzer.py            |  529 ++++
 tools/perf/python/tracepoint.py               |    1 +
 tools/perf/python/twatch.py                   |    1 +
 tools/perf/python/wakeup-latency.py           |   85 +
 tools/perf/scripts/Build                      |    4 -
 tools/perf/scripts/perl/Perf-Trace-Util/Build |    9 -
 .../scripts/perl/Perf-Trace-Util/Context.c    |  122 -
 .../scripts/perl/Perf-Trace-Util/Context.xs   |   42 -
 .../scripts/perl/Perf-Trace-Util/Makefile.PL  |   18 -
 .../perf/scripts/perl/Perf-Trace-Util/README  |   59 -
 .../Perf-Trace-Util/lib/Perf/Trace/Context.pm |   55 -
 .../Perf-Trace-Util/lib/Perf/Trace/Core.pm    |  192 --
 .../Perf-Trace-Util/lib/Perf/Trace/Util.pm    |   94 -
 .../perf/scripts/perl/Perf-Trace-Util/typemap |    1 -
 .../scripts/perl/bin/check-perf-trace-record  |    2 -
 .../scripts/perl/bin/failed-syscalls-record   |    3 -
 .../scripts/perl/bin/failed-syscalls-report   |   10 -
 tools/perf/scripts/perl/bin/rw-by-file-record |    3 -
 tools/perf/scripts/perl/bin/rw-by-file-report |   10 -
 tools/perf/scripts/perl/bin/rw-by-pid-record  |    2 -
 tools/perf/scripts/perl/bin/rw-by-pid-report  |    3 -
 tools/perf/scripts/perl/bin/rwtop-record      |    2 -
 tools/perf/scripts/perl/bin/rwtop-report      |   20 -
 .../scripts/perl/bin/wakeup-latency-record    |    6 -
 .../scripts/perl/bin/wakeup-latency-report    |    3 -
 tools/perf/scripts/perl/check-perf-trace.pl   |  106 -
 tools/perf/scripts/perl/failed-syscalls.pl    |   47 -
 tools/perf/scripts/perl/rw-by-file.pl         |  106 -
 tools/perf/scripts/perl/rw-by-pid.pl          |  184 --
 tools/perf/scripts/perl/rwtop.pl              |  203 --
 tools/perf/scripts/perl/wakeup-latency.pl     |  107 -
 .../perf/scripts/python/Perf-Trace-Util/Build |    4 -
 .../scripts/python/Perf-Trace-Util/Context.c  |  225 --
 .../Perf-Trace-Util/lib/Perf/Trace/Core.py    |  116 -
 .../lib/Perf/Trace/EventClass.py              |   97 -
 .../lib/Perf/Trace/SchedGui.py                |  184 --
 .../Perf-Trace-Util/lib/Perf/Trace/Util.py    |   92 -
 .../scripts/python/arm-cs-trace-disasm.py     |  355 ---
 .../python/bin/compaction-times-record        |    2 -
 .../python/bin/compaction-times-report        |    4 -
 .../python/bin/event_analyzing_sample-record  |    8 -
 .../python/bin/event_analyzing_sample-report  |    3 -
 .../python/bin/export-to-postgresql-record    |    8 -
 .../python/bin/export-to-postgresql-report    |   29 -
 .../python/bin/export-to-sqlite-record        |    8 -
 .../python/bin/export-to-sqlite-report        |   29 -
 .../python/bin/failed-syscalls-by-pid-record  |    3 -
 .../python/bin/failed-syscalls-by-pid-report  |   10 -
 .../perf/scripts/python/bin/flamegraph-record |    2 -
 .../perf/scripts/python/bin/flamegraph-report |    3 -
 .../python/bin/futex-contention-record        |    2 -
 .../python/bin/futex-contention-report        |    4 -
 tools/perf/scripts/python/bin/gecko-record    |    2 -
 tools/perf/scripts/python/bin/gecko-report    |    7 -
 .../scripts/python/bin/intel-pt-events-record |   13 -
 .../scripts/python/bin/intel-pt-events-report |    3 -
 .../scripts/python/bin/mem-phys-addr-record   |   19 -
 .../scripts/python/bin/mem-phys-addr-report   |    3 -
 .../scripts/python/bin/net_dropmonitor-record |    2 -
 .../scripts/python/bin/net_dropmonitor-report |    4 -
 .../scripts/python/bin/netdev-times-record    |    8 -
 .../scripts/python/bin/netdev-times-report    |    5 -
 .../scripts/python/bin/powerpc-hcalls-record  |    2 -
 .../scripts/python/bin/powerpc-hcalls-report  |    2 -
 .../scripts/python/bin/sched-migration-record |    2 -
 .../scripts/python/bin/sched-migration-report |    3 -
 tools/perf/scripts/python/bin/sctop-record    |    3 -
 tools/perf/scripts/python/bin/sctop-report    |   24 -
 .../scripts/python/bin/stackcollapse-record   |    8 -
 .../scripts/python/bin/stackcollapse-report   |    3 -
 .../python/bin/syscall-counts-by-pid-record   |    3 -
 .../python/bin/syscall-counts-by-pid-report   |   10 -
 .../scripts/python/bin/syscall-counts-record  |    3 -
 .../scripts/python/bin/syscall-counts-report  |   10 -
 .../scripts/python/bin/task-analyzer-record   |    2 -
 .../scripts/python/bin/task-analyzer-report   |    3 -
 tools/perf/scripts/python/check-perf-trace.py |   84 -
 tools/perf/scripts/python/compaction-times.py |  311 ---
 .../scripts/python/event_analyzing_sample.py  |  192 --
 .../scripts/python/export-to-postgresql.py    | 1114 ---------
 tools/perf/scripts/python/export-to-sqlite.py |  799 ------
 .../scripts/python/failed-syscalls-by-pid.py  |   79 -
 tools/perf/scripts/python/flamegraph.py       |  267 --
 tools/perf/scripts/python/futex-contention.py |   57 -
 tools/perf/scripts/python/gecko.py            |  395 ---
 tools/perf/scripts/python/intel-pt-events.py  |  494 ----
 tools/perf/scripts/python/libxed.py           |  107 -
 tools/perf/scripts/python/net_dropmonitor.py  |   78 -
 tools/perf/scripts/python/netdev-times.py     |  473 ----
 tools/perf/scripts/python/powerpc-hcalls.py   |  202 --
 tools/perf/scripts/python/sched-migration.py  |  462 ----
 tools/perf/scripts/python/sctop.py            |   89 -
 tools/perf/scripts/python/stackcollapse.py    |  127 -
 tools/perf/scripts/python/stat-cpi.py         |   79 -
 .../scripts/python/syscall-counts-by-pid.py   |   75 -
 tools/perf/scripts/python/syscall-counts.py   |   65 -
 tools/perf/scripts/python/task-analyzer.py    |  934 -------
 tools/perf/tests/backward-ring-buffer.c       |   26 +-
 tools/perf/tests/code-reading.c               |   14 +-
 tools/perf/tests/event-times.c                |    6 +-
 tools/perf/tests/event_update.c               |    4 +-
 tools/perf/tests/evsel-roundtrip-name.c       |    8 +-
 tools/perf/tests/evsel-tp-sched.c             |    4 +-
 tools/perf/tests/expand-cgroup.c              |   12 +-
 tools/perf/tests/hists_cumulate.c             |    2 +-
 tools/perf/tests/hists_filter.c               |    2 +-
 tools/perf/tests/hists_link.c                 |    2 +-
 tools/perf/tests/hists_output.c               |    2 +-
 tools/perf/tests/hwmon_pmu.c                  |   21 +-
 tools/perf/tests/keep-tracking.c              |   10 +-
 tools/perf/tests/make                         |    9 +-
 tools/perf/tests/mmap-basic.c                 |   42 +-
 tools/perf/tests/openat-syscall-all-cpus.c    |    6 +-
 tools/perf/tests/openat-syscall-tp-fields.c   |   26 +-
 tools/perf/tests/openat-syscall.c             |    6 +-
 tools/perf/tests/parse-events.c               |  139 +-
 tools/perf/tests/parse-metric.c               |    8 +-
 tools/perf/tests/parse-no-sample-id-all.c     |    2 +-
 tools/perf/tests/perf-record.c                |   38 +-
 tools/perf/tests/perf-time-to-tsc.c           |   12 +-
 tools/perf/tests/pfm.c                        |    8 +-
 tools/perf/tests/pmu-events.c                 |   11 +-
 tools/perf/tests/pmu.c                        |    4 +-
 .../perf/tests/shell/lib/perf_brstack_max.py  |   43 +
 tools/perf/tests/shell/script_perl.sh         |  102 -
 tools/perf/tests/shell/script_python.sh       |  113 -
 .../tests/shell/test_arm_coresight_disasm.sh  |   10 +-
 tools/perf/tests/shell/test_intel_pt.sh       |   35 +-
 tools/perf/tests/shell/test_task_analyzer.sh  |   71 +-
 tools/perf/tests/sw-clock.c                   |   20 +-
 tools/perf/tests/switch-tracking.c            |   10 +-
 tools/perf/tests/task-exit.c                  |   20 +-
 tools/perf/tests/time-utils-test.c            |   11 +-
 tools/perf/tests/tool_pmu.c                   |    7 +-
 tools/perf/tests/topology.c                   |    4 +-
 tools/perf/ui/browsers/annotate.c             |    2 +-
 tools/perf/ui/browsers/hists.c                |   22 +-
 tools/perf/ui/browsers/scripts.c              |    5 +-
 tools/perf/util/Build                         |    1 -
 tools/perf/util/amd-sample-raw.c              |    2 +-
 tools/perf/util/annotate-data.c               |    2 +-
 tools/perf/util/annotate.c                    |   10 +-
 tools/perf/util/auxtrace.c                    |   14 +-
 tools/perf/util/block-info.c                  |    4 +-
 tools/perf/util/bpf_counter.c                 |    2 +-
 tools/perf/util/bpf_counter_cgroup.c          |   10 +-
 tools/perf/util/bpf_ftrace.c                  |    9 +-
 tools/perf/util/bpf_lock_contention.c         |   12 +-
 tools/perf/util/bpf_off_cpu.c                 |   44 +-
 tools/perf/util/bpf_trace_augment.c           |    8 +-
 tools/perf/util/cgroup.c                      |   26 +-
 tools/perf/util/data-convert-bt.c             |    2 +-
 tools/perf/util/data.c                        |   21 +-
 tools/perf/util/data.h                        |    4 +-
 tools/perf/util/evlist.c                      |  451 ++--
 tools/perf/util/evlist.h                      |  274 +-
 tools/perf/util/evsel.c                       |  107 +-
 tools/perf/util/evsel.h                       |   35 +-
 tools/perf/util/expr.c                        |    2 +-
 tools/perf/util/header.c                      |   51 +-
 tools/perf/util/header.h                      |    2 +-
 tools/perf/util/intel-pt.c                    |    3 +-
 tools/perf/util/intel-tpebs.c                 |    7 +-
 tools/perf/util/map.h                         |    9 +-
 tools/perf/util/metricgroup.c                 |   12 +-
 tools/perf/util/parse-events.c                |   10 +-
 tools/perf/util/parse-events.y                |    2 +-
 tools/perf/util/perf_api_probe.c              |   20 +-
 tools/perf/util/pfm.c                         |    4 +-
 tools/perf/util/print-events.c                |    2 +-
 tools/perf/util/print_insn.h                  |    5 +-
 tools/perf/util/python.c                      | 1717 +++++++++++--
 tools/perf/util/record.c                      |   11 +-
 tools/perf/util/s390-sample-raw.c             |   19 +-
 tools/perf/util/sample-raw.c                  |    4 +-
 tools/perf/util/scripting-engines/Build       |    9 -
 .../util/scripting-engines/trace-event-perl.c |  773 ------
 .../scripting-engines/trace-event-python.c    | 2209 -----------------
 tools/perf/util/session.c                     |   44 +-
 tools/perf/util/sideband_evlist.c             |   40 +-
 tools/perf/util/sort.c                        |    2 +-
 tools/perf/util/stat-display.c                |    6 +-
 tools/perf/util/stat-shadow.c                 |   22 +-
 tools/perf/util/stat.c                        |   20 +-
 tools/perf/util/stream.c                      |    4 +-
 tools/perf/util/synthetic-events.c            |   17 +-
 tools/perf/util/time-utils.c                  |   12 +-
 tools/perf/util/top.c                         |    4 +-
 tools/perf/util/trace-event-parse.c           |   65 -
 tools/perf/util/trace-event-scripting.c       |  410 ---
 tools/perf/util/trace-event.h                 |   75 +-
 259 files changed, 10583 insertions(+), 15882 deletions(-)
 delete mode 100644 tools/build/feature/test-libperl.c
 delete mode 100644 tools/build/feature/test-libpython.c
 create mode 100644 tools/build/feature/test-python-module.c
 delete mode 100644 tools/perf/Documentation/perf-script-perl.txt
 create mode 100755 tools/perf/python/SchedGui.py
 create mode 100755 tools/perf/python/arm-cs-trace-disasm.py
 create mode 100755 tools/perf/python/check-perf-trace.py
 create mode 100755 tools/perf/python/compaction-times.py
 create mode 100755 tools/perf/python/event_analyzing_sample.py
 create mode 100755 tools/perf/python/export-to-postgresql.py
 create mode 100755 tools/perf/python/export-to-sqlite.py
 rename tools/perf/{scripts => }/python/exported-sql-viewer.py (99%)
 create mode 100755 tools/perf/python/failed-syscalls-by-pid.py
 create mode 100755 tools/perf/python/failed-syscalls.py
 create mode 100755 tools/perf/python/flamegraph.py
 create mode 100755 tools/perf/python/futex-contention.py
 create mode 100755 tools/perf/python/gecko.py
 create mode 100755 tools/perf/python/intel-pt-events.py
 create mode 100755 tools/perf/python/libxed.py
 rename tools/perf/{scripts => }/python/mem-phys-addr.py (84%)
 mode change 100644 => 100755
 create mode 100755 tools/perf/python/net_dropmonitor.py
 create mode 100755 tools/perf/python/netdev-times.py
 rename tools/perf/{scripts => }/python/parallel-perf.py (100%)
 create mode 100644 tools/perf/python/perf.pyi
 create mode 100755 tools/perf/python/perf_live.py
 create mode 100755 tools/perf/python/powerpc-hcalls.py
 create mode 100755 tools/perf/python/rw-by-file.py
 create mode 100755 tools/perf/python/rw-by-pid.py
 create mode 100755 tools/perf/python/rwtop.py
 create mode 100755 tools/perf/python/sched-migration.py
 create mode 100755 tools/perf/python/sctop.py
 create mode 100755 tools/perf/python/stackcollapse.py
 create mode 100755 tools/perf/python/stat-cpi.py
 create mode 100755 tools/perf/python/syscall-counts-by-pid.py
 create mode 100755 tools/perf/python/syscall-counts.py
 create mode 100755 tools/perf/python/task-analyzer.py
 create mode 100755 tools/perf/python/wakeup-latency.py
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/Build
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/Context.c
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/Context.xs
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/Makefile.PL
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/README
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/lib/Perf/Trace/Context.pm
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/lib/Perf/Trace/Core.pm
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/lib/Perf/Trace/Util.pm
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/typemap
 delete mode 100644 tools/perf/scripts/perl/bin/check-perf-trace-record
 delete mode 100644 tools/perf/scripts/perl/bin/failed-syscalls-record
 delete mode 100644 tools/perf/scripts/perl/bin/failed-syscalls-report
 delete mode 100644 tools/perf/scripts/perl/bin/rw-by-file-record
 delete mode 100644 tools/perf/scripts/perl/bin/rw-by-file-report
 delete mode 100644 tools/perf/scripts/perl/bin/rw-by-pid-record
 delete mode 100644 tools/perf/scripts/perl/bin/rw-by-pid-report
 delete mode 100644 tools/perf/scripts/perl/bin/rwtop-record
 delete mode 100644 tools/perf/scripts/perl/bin/rwtop-report
 delete mode 100644 tools/perf/scripts/perl/bin/wakeup-latency-record
 delete mode 100644 tools/perf/scripts/perl/bin/wakeup-latency-report
 delete mode 100644 tools/perf/scripts/perl/check-perf-trace.pl
 delete mode 100644 tools/perf/scripts/perl/failed-syscalls.pl
 delete mode 100644 tools/perf/scripts/perl/rw-by-file.pl
 delete mode 100644 tools/perf/scripts/perl/rw-by-pid.pl
 delete mode 100644 tools/perf/scripts/perl/rwtop.pl
 delete mode 100644 tools/perf/scripts/perl/wakeup-latency.pl
 delete mode 100644 tools/perf/scripts/python/Perf-Trace-Util/Build
 delete mode 100644 tools/perf/scripts/python/Perf-Trace-Util/Context.c
 delete mode 100644 tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py
 delete mode 100755 tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py
 delete mode 100644 tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py
 delete mode 100644 tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
 delete mode 100755 tools/perf/scripts/python/arm-cs-trace-disasm.py
 delete mode 100644 tools/perf/scripts/python/bin/compaction-times-record
 delete mode 100644 tools/perf/scripts/python/bin/compaction-times-report
 delete mode 100644 tools/perf/scripts/python/bin/event_analyzing_sample-record
 delete mode 100644 tools/perf/scripts/python/bin/event_analyzing_sample-report
 delete mode 100644 tools/perf/scripts/python/bin/export-to-postgresql-record
 delete mode 100644 tools/perf/scripts/python/bin/export-to-postgresql-report
 delete mode 100644 tools/perf/scripts/python/bin/export-to-sqlite-record
 delete mode 100644 tools/perf/scripts/python/bin/export-to-sqlite-report
 delete mode 100644 tools/perf/scripts/python/bin/failed-syscalls-by-pid-record
 delete mode 100644 tools/perf/scripts/python/bin/failed-syscalls-by-pid-report
 delete mode 100755 tools/perf/scripts/python/bin/flamegraph-record
 delete mode 100755 tools/perf/scripts/python/bin/flamegraph-report
 delete mode 100644 tools/perf/scripts/python/bin/futex-contention-record
 delete mode 100644 tools/perf/scripts/python/bin/futex-contention-report
 delete mode 100644 tools/perf/scripts/python/bin/gecko-record
 delete mode 100755 tools/perf/scripts/python/bin/gecko-report
 delete mode 100644 tools/perf/scripts/python/bin/intel-pt-events-record
 delete mode 100644 tools/perf/scripts/python/bin/intel-pt-events-report
 delete mode 100644 tools/perf/scripts/python/bin/mem-phys-addr-record
 delete mode 100644 tools/perf/scripts/python/bin/mem-phys-addr-report
 delete mode 100755 tools/perf/scripts/python/bin/net_dropmonitor-record
 delete mode 100755 tools/perf/scripts/python/bin/net_dropmonitor-report
 delete mode 100644 tools/perf/scripts/python/bin/netdev-times-record
 delete mode 100644 tools/perf/scripts/python/bin/netdev-times-report
 delete mode 100644 tools/perf/scripts/python/bin/powerpc-hcalls-record
 delete mode 100644 tools/perf/scripts/python/bin/powerpc-hcalls-report
 delete mode 100644 tools/perf/scripts/python/bin/sched-migration-record
 delete mode 100644 tools/perf/scripts/python/bin/sched-migration-report
 delete mode 100644 tools/perf/scripts/python/bin/sctop-record
 delete mode 100644 tools/perf/scripts/python/bin/sctop-report
 delete mode 100755 tools/perf/scripts/python/bin/stackcollapse-record
 delete mode 100755 tools/perf/scripts/python/bin/stackcollapse-report
 delete mode 100644 tools/perf/scripts/python/bin/syscall-counts-by-pid-record
 delete mode 100644 tools/perf/scripts/python/bin/syscall-counts-by-pid-report
 delete mode 100644 tools/perf/scripts/python/bin/syscall-counts-record
 delete mode 100644 tools/perf/scripts/python/bin/syscall-counts-report
 delete mode 100755 tools/perf/scripts/python/bin/task-analyzer-record
 delete mode 100755 tools/perf/scripts/python/bin/task-analyzer-report
 delete mode 100644 tools/perf/scripts/python/check-perf-trace.py
 delete mode 100644 tools/perf/scripts/python/compaction-times.py
 delete mode 100644 tools/perf/scripts/python/event_analyzing_sample.py
 delete mode 100644 tools/perf/scripts/python/export-to-postgresql.py
 delete mode 100644 tools/perf/scripts/python/export-to-sqlite.py
 delete mode 100644 tools/perf/scripts/python/failed-syscalls-by-pid.py
 delete mode 100755 tools/perf/scripts/python/flamegraph.py
 delete mode 100644 tools/perf/scripts/python/futex-contention.py
 delete mode 100644 tools/perf/scripts/python/gecko.py
 delete mode 100644 tools/perf/scripts/python/intel-pt-events.py
 delete mode 100644 tools/perf/scripts/python/libxed.py
 delete mode 100755 tools/perf/scripts/python/net_dropmonitor.py
 delete mode 100644 tools/perf/scripts/python/netdev-times.py
 delete mode 100644 tools/perf/scripts/python/powerpc-hcalls.py
 delete mode 100644 tools/perf/scripts/python/sched-migration.py
 delete mode 100644 tools/perf/scripts/python/sctop.py
 delete mode 100755 tools/perf/scripts/python/stackcollapse.py
 delete mode 100644 tools/perf/scripts/python/stat-cpi.py
 delete mode 100644 tools/perf/scripts/python/syscall-counts-by-pid.py
 delete mode 100644 tools/perf/scripts/python/syscall-counts.py
 delete mode 100755 tools/perf/scripts/python/task-analyzer.py
 create mode 100644 tools/perf/tests/shell/lib/perf_brstack_max.py
 delete mode 100755 tools/perf/tests/shell/script_perl.sh
 delete mode 100755 tools/perf/tests/shell/script_python.sh
 delete mode 100644 tools/perf/util/scripting-engines/Build
 delete mode 100644 tools/perf/util/scripting-engines/trace-event-perl.c
 delete mode 100644 tools/perf/util/scripting-engines/trace-event-python.c
 delete mode 100644 tools/perf/util/trace-event-scripting.c

-- 
2.54.0.rc1.513.gad8abe7a5a-goog

