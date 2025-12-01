Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4E0253B42
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 20:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764622521; cv=none; b=E7MiyTk+sk7yCyAyX68c3gNMooMTZ/qTa+Hl3VYk3LvUQq3RK7kGaeq+8SZOsyNFzt6rIT3yxxJOLUipocasnpX96ZaT2oLT1ldYvO6iSsSMEdeJsocmkPi7BbQXnl3Btue+KztWBxSG4XSw7ik7beSLOW+Pp6AbJ5sFytSXROM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764622521; c=relaxed/simple;
	bh=ZSxrOdUDV2fsiZ8VTAoHybN58iPShWXHilNcC1eOP9c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=oGjkgINQuzLnE0nDvp/PBtmscqGx57IUyhGty9OckgXw7btg1Z/zF4llR46W9bWBniW8teB5g5g2s1Yk//ylOBQDoU9QpSmBEmF2OLH5m0v8tDbuGVGiGLr5y7/GfDo5NLXteUIYgZGOqWqaeb8pzUc1neKVe+tJnifdlJN68tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T+snBJLN; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T+snBJLN"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b6097ca315bso6744024a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 12:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764622518; x=1765227318; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CM4WlM3X7MrnLioK5/Fb9PLY7pS2paWGYqO8IZMvjl0=;
        b=T+snBJLNwzOKpEO3egsltT6gbaTW7afXQzbRwKrR8DshTxxuCwrBxdLW0rLZUiLkjw
         Cyj3vp7Elc+wDJykWAzEwiZzOO0Ir/5lfQb7FuEeGBzaOcavG9Li6YP1kBCmUFviqKvl
         EZ7UqIbVaI0+zFMQ7974DL7QTq3qpY1lg62jPDkHx6cNBA4fga3HcrzJh1Xms9Q+g6HN
         thfB3wGrDZwMujp2X+YvA2iD4pkDY/46WMg+5hgvK+PrmcdJeF5AvabTCsR2Qc2n9LCw
         HlLbT+FK5MJuH2Om7egKdamnGC37aA462AHyv9SyPCu6qirdbUE5if+yxeyW2YeWxy1z
         mpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764622518; x=1765227318;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CM4WlM3X7MrnLioK5/Fb9PLY7pS2paWGYqO8IZMvjl0=;
        b=Mmkkvv9gtaAyB14lMXVHhbRVx70K1pgn4lMd0hQSH3pnkFEMp0VoyZm7y3ZsFyoyMa
         QaPuMb0fLCVmyXqZ5dxMFHmDIvrxfXWCBte+ho0NfxxdTtSSflHjFaRD1d0cBb8HSgbR
         OFcLVpTOP6ekMJgd97vsNilmz9Vtsmoz2zkPjSlv2v9e28GqAPmc9D4bE38a30P/dySk
         mAiPgwNaiM2nBcqezoYyBXZza8Xwo3mYDqtoQrZbe8JcC75/GRNsPSZLYSx/uDdHEnsF
         jHK0EUslNTpaWQC4RGdj3MJ/TdY8y5o0ZiEQ6Ii9TWT8FUFFATBZQBLBRpd3jL46lHVv
         kgAg==
X-Forwarded-Encrypted: i=1; AJvYcCWEfbabjPZCJOMec7dPTkK5NBUFGCNck6yagPeX1FZbKf3bHu+g5zim6pbbKnxnDSrrtS0OF/wfUpq0fyYLcolw@vger.kernel.org
X-Gm-Message-State: AOJu0YyMn5xvvqxTGsNendYC27uqSGuDoEa9ac2gyNuYiNTnZCvNih/g
	AN7d4HRfAtc92n8k8NiixnZ/2MZ03r7HQfK+sBeSH+w980PxHdFkanlX1gIBoNOQeRtSgAOoro8
	lr2My6NxA2A==
X-Google-Smtp-Source: AGHT+IHzasUWwoOoaBGRKrbmTLPwNDgHZhXRK6AamdUEgKNV5PIGt1TasBJ+i8LlW5NAIHXjG29VZyv13epx
X-Received: from dlbtp11.prod.google.com ([2002:a05:7022:3b8b:b0:119:49ca:6ba3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3898:b0:11b:7e61:57d5
 with SMTP id a92af1059eb24-11c9d60eac9mr25543419c88.2.1764622517699; Mon, 01
 Dec 2025 12:55:17 -0800 (PST)
Date: Mon,  1 Dec 2025 12:54:59 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251201205509.195451-1-irogers@google.com>
Subject: [PATCH v2 00/10] perf: Refactor/add fallbacks for reading build-id
 and debuglink
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, tanze <tanze@kylinos.cn>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Andi Kleen <ak@linux.intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This cleans up some tech debt mentioned in the thread:
https://lore.kernel.org/lkml/aQt66zhfxSA80xwt@gentoo.org/

The perf tool has fallbacks for objdump but not in the case of
build-id and debuglink reading. Refactor the code so that in the case
of read_build_id it now looks like:

```
...
int filename__read_build_id(const char *filename, struct build_id *bid)
{
	struct kmod_path m = { .name = NULL, };
	char path[PATH_MAX];
	int err, fd;

	if (!filename)
		return -EFAULT;

	if (!is_regular_file(filename))
		return -EWOULDBLOCK;

	err = kmod_path__parse(&m, filename);
	if (err)
		return -1;

	if (m.comp) {
		int error = 0;

		fd = filename__decompress(filename, path, sizeof(path), m.comp, &error);
		if (fd < 0) {
			pr_debug("Failed to decompress (error %d) %s\n",
				 error, filename);
			return -1;
		}
		lseek(fd, 0, SEEK_SET);
		filename = path;
	} else {
		fd = open(filename, O_RDONLY);
		if (fd < 0) {
			pr_debug("Failed to open %s\n", filename);
			return -1;
		}
	}

	err = libbfd__read_build_id(fd, filename, bid);
	if (err == 0)
		goto out;

	err = libelf__read_build_id(fd, filename, bid);
	if (err == 0)
		goto out;

	err = sym_min__read_build_id(fd, filename, bid);
out:
	close(fd);
	if (m.comp)
		unlink(filename);
	return err;
}
...
```

That is what was previously symbol-elf decompression code is now made
common for all cases of reading. The handling of "is_regular_file" is
now common. There is a clear fallback from libbfd to libelf to the
symbol-minimal (sym_min) versions of the functions.

To support this there is refactoring of code into a perf-libelf.c
file, to follow patterns established for the capstone, LLVM and libbfd
code.

v2: Rebase, resolving merge conflict with James' removal of the block
    argument:
    https://lore.kernel.org/lkml/20251121-james-perf-non-block-v1-1-6ab2702ab573@linaro.org/
    Add a patch fixing an issue with return values from
    filename__read_build_id. Some tweaks to the PPC arch__sym_update
    patch commit message and make it 64-bit only. Change the
    sysfs__read_build_id code combining the libelf and minimal
    implementations but avoiding the memory read overhead, avoiding a
    potential buffer overrun if the descsz was particularly large in a
    build ID note, avoid reads and just using seeks.

v1: https://lore.kernel.org/lkml/20251123023225.8069-1-irogers@google.com/

Ian Rogers (10):
  perf symbol: Reduce scope of elf__needs_adjust_symbols
  perf symbol: Reduce scope of arch__sym_update
  perf symbol: Move libelf code to its own file/header
  perf symbol: Remove unused includes
  perf symbol: Move dso__load_bfd_symbols out of symbol.h
  perf symbol: Use fallbacks with filename__read_build_id
  perf symbol: Use fallbacks for filename__read_debuglink
  perf symbol: Make a common sysfs__read_build_id
  perf dso: Move type helpers out of symbol and use fallbacks
  perf symbol: Fix ENOENT case for filename__read_build_id

 tools/perf/arch/powerpc/util/sym-handling.c   |   7 -
 tools/perf/builtin-annotate.c                 |  47 +--
 tools/perf/builtin-buildid-cache.c            |   6 +-
 tools/perf/builtin-c2c.c                      |  58 +--
 tools/perf/builtin-diff.c                     |  22 +-
 tools/perf/builtin-inject.c                   |  19 +-
 tools/perf/builtin-kmem.c                     |  41 ++-
 tools/perf/builtin-kwork.c                    |   9 +-
 tools/perf/builtin-mem.c                      |  16 +-
 tools/perf/builtin-report.c                   |  76 ++--
 tools/perf/builtin-sched.c                    |  50 ++-
 tools/perf/builtin-script.c                   |  89 ++---
 tools/perf/builtin-timechart.c                |  34 +-
 tools/perf/builtin-top.c                      |  85 +++--
 tools/perf/builtin-trace.c                    |  82 ++---
 .../scripts/python/Perf-Trace-Util/Context.c  |  11 +-
 tools/perf/tests/code-reading.c               |   1 +
 tools/perf/tests/hists_cumulate.c             |   1 +
 tools/perf/tests/hists_filter.c               |   1 +
 tools/perf/tests/hists_link.c                 |   1 +
 tools/perf/tests/hists_output.c               |   1 +
 tools/perf/tests/mmap-thread-lookup.c         |   1 +
 tools/perf/tests/pe-file-parsing.c            |   5 +-
 tools/perf/util/Build                         |   6 +-
 tools/perf/util/annotate-data.c               |   7 +-
 tools/perf/util/auxtrace.h                    |   1 +
 tools/perf/util/block-info.c                  |  11 +-
 tools/perf/util/build-id.c                    |  28 +-
 tools/perf/util/callchain.c                   |   1 +
 tools/perf/util/cs-etm.c                      |   1 +
 tools/perf/util/data-convert-json.c           |  30 +-
 tools/perf/util/db-export.c                   |  16 +-
 tools/perf/util/dlfilter.c                    |  11 +-
 tools/perf/util/dlfilter.h                    |   1 +
 tools/perf/util/dso.c                         |  57 +--
 tools/perf/util/event.c                       |  41 ++-
 tools/perf/util/evsel_fprintf.c               |  14 +-
 tools/perf/util/hist.c                        |  29 +-
 tools/perf/util/intel-pt.c                    |  35 +-
 tools/perf/util/kvm-stat.h                    |   5 +-
 tools/perf/util/libbfd.c                      |   9 +-
 tools/perf/util/libbfd.h                      |  12 +-
 tools/perf/util/machine.c                     |  34 +-
 tools/perf/util/perf-libelf.c                 | 235 ++++++++++++
 tools/perf/util/perf-libelf.h                 |  58 +++
 tools/perf/util/print_insn.c                  |  14 +-
 tools/perf/util/probe-event.c                 |   1 +
 tools/perf/util/probe-finder.c                |   1 +
 .../util/scripting-engines/trace-event-perl.c |   1 +
 .../scripting-engines/trace-event-python.c    |   1 +
 tools/perf/util/symbol-elf.c                  | 338 +-----------------
 tools/perf/util/symbol-minimal.c              | 166 +++++----
 tools/perf/util/symbol-minimal.h              |  13 +
 tools/perf/util/symbol.c                      | 107 +++++-
 tools/perf/util/symbol.h                      |  44 +--
 tools/perf/util/symbol_fprintf.c              |   1 +
 tools/perf/util/thread-stack.c                |  12 +-
 tools/perf/util/thread.c                      |  18 +-
 tools/perf/util/unwind-libdw.c                |  15 +-
 59 files changed, 1079 insertions(+), 958 deletions(-)
 create mode 100644 tools/perf/util/perf-libelf.c
 create mode 100644 tools/perf/util/perf-libelf.h
 create mode 100644 tools/perf/util/symbol-minimal.h

-- 
2.52.0.158.g65b55ccf14-goog

