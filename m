Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB443207
	for <linux-perf-users@vger.kernel.org>; Sun, 23 Nov 2025 02:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763865151; cv=none; b=sMAvmzMUUXBHMh68bgivG/9ZDyjHUI0YxfELKVqkcf5OerAHZ+osQ9eoHDc+WkfIlNUMf03c2rxrrqhLalNxmzK+zeh2FrJkL4/ARW/igaswPSBjVAAyOUUkwF5ekHoPUs5HBPTV5QQ/xQb0mMCICE2PLBZq6+8dxKXAWAjW3Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763865151; c=relaxed/simple;
	bh=GQ6E2o42ySv4npqucIrF42DXoAXQ8Irw8Zi7CuGn/Kg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=YPNtoh0O/KyoCfOPvqCgpDo7hyTeZhzlCojBNFLHRk5LF0VxGj8Ih52fQd/5Sk8tQJNi//l7kKsr3yfpvlkINr6uK2+pNalq7b6PUUU6d8fkBaoclnuscEc2A0kx+wq89cfWv4Zr0G+RYfxpRcwdUxl7uXlVj0ud0mbNk8lAe9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U09uxgca; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U09uxgca"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297f587dc2eso79575875ad.2
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 18:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763865149; x=1764469949; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XMwSNu71qAXwuCKpGVJwB1UJ2pDS9YmjGMRSsQyaJ48=;
        b=U09uxgcaHsAI2afoKjXFikbIOWN9dnV24KtpjYeyJP2Cf4TeqOU+9CeGQM8VJspgPe
         ocu+6vfPbncfyUd08WX4KazysAu2LpAVrhvVZDX3IQWpbSlqXIjzqbKLjf+MwN1pq3Of
         kKmvbcomH5CNhqRYiRN7srFJ3CBm8jrDXSRBV39abWfubmZvT3mmtExHDFNbSjXWitBZ
         eiUO/DP+wUTtbPXhEHmrVUJzgAVCabpfS7qwZ7D06BKKVNoAMDWuU0Z7WJyT6fnUFPlo
         juUGObFarIYGcbu2V1d8x9sVvi5Rz3nfVnyZAo6mrfFIMGACcEhuFaQ8ZNOyDAKnSB9Z
         BBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763865149; x=1764469949;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XMwSNu71qAXwuCKpGVJwB1UJ2pDS9YmjGMRSsQyaJ48=;
        b=Km1PKa4p1xVxgnHmIsB02eIyn6E0QzXF/rwY1KYZCwxykpmoW6cHTnvFmvnNOhve1X
         +UFh6gEzly/cAwNBmLLULSVQ+SVrJrpdEcrH5y1cF/AD+VcaaNhMXGNZESNpJlnwPMyf
         if0tnkeYT2tUBrj+l2IFNwC4SJd2pTpPMiHjl7TJUGLKI/ZOGcGolvbBnl6LvzoY8LTn
         A0sQ4ttOdD9iI0cw2JS3bN38nEKxy/JcyGJ6o/PFoSf/HyVAxiVdF0+gU2MkGXHv2FAf
         5OmFXVa4/e1yDdZxv5dMkoPXeryNeVrcrMuvLUxV2wSZbxcPW/SdxC0tlgfFWvj+njSK
         0Ogw==
X-Forwarded-Encrypted: i=1; AJvYcCVwsVZbIDU+RRlOidri8a6buebODSODdwwLWXAnRspyPSuG4BuhrCwpFztSHbmi76c1dLyHwYJl6v5OcLYbs5B9@vger.kernel.org
X-Gm-Message-State: AOJu0YxYNZnUhVjb6T+HdV7L4rJstcHJYYfST8rr/QHu0nD6GvV7KlhT
	+P57WtOMKMR+aS4e4Ma9iuyOuAJJp5ET3r4eb7vFJjw/dl5VbUr2MqJbwoTHJSp8etGzCKjWOiO
	B8BwZP9bAYw==
X-Google-Smtp-Source: AGHT+IHPGH30YGuRkWW/yJF/LJPq70FjhtMk/91ZNsIeiJ+ce80VG9Unk6hTi6Ov0vkfRjIlLvNnptK1Kl/4
X-Received: from dyx22.prod.google.com ([2002:a05:693c:8216:b0:2a4:6f7f:e6f0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:51fc:b0:2a4:3593:645a
 with SMTP id 5a478bee46e88-2a71910148amr3277736eec.10.1763865149084; Sat, 22
 Nov 2025 18:32:29 -0800 (PST)
Date: Sat, 22 Nov 2025 18:32:16 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251123023225.8069-1-irogers@google.com>
Subject: [PATCH v1 0/9] perf: Refactor/add fallbacks for reading build-id and debuglink
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, tanze <tanze@kylinos.cn>, 
	Aditya Bodkhe <aditya.b1@linux.ibm.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Andi Kleen <ak@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
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
int filename__read_build_id(const char *filename, struct build_id *bid, bool block)
{
        struct kmod_path m = { .name = NULL, };
        char path[PATH_MAX];
        int err, fd;

        if (!filename)
                return -EFAULT;

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
                block = true;
        } else {
                fd = open(filename, block ? O_RDONLY : (O_RDONLY | O_NONBLOCK));
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
...
```

That is what was previously symbol-elf decompression code is now made
common for all cases of reading. The handling of the block argument is
now common. There is a clear fallback from libbfd to libelf to the
symbol-minimal (sym_min) versions of the functions.

To support this there is refactoring of code into a perf-libelf.c
file, to follow patterns established for the capstone, LLVM and libbfd
code.

These changes conflict with James' removal of the block argument:
https://lore.kernel.org/lkml/20251121-james-perf-non-block-v1-1-6ab2702ab573@linaro.org/
I think we should do that change. It would be easy to apply that
change on these changes as rather than updating 3 functions, only 1
function needs updating.

Ian Rogers (9):
  perf symbol: Reduce scope of elf__needs_adjust_symbols
  perf symbol: Reduce scope of arch__sym_update
  perf symbol: Move libelf code to its own file/header
  perf symbol: Remove unused includes
  perf symbol: Move dso__load_bfd_symbols out of symbol.h
  perf symbol: Use fallbacks with filename__read_build_id
  perf symbol: Use fallbacks for filename__read_debuglink
  perf symbol: Use fallbacks for sysfs__read_build_id
  perf dso: Move type helpers out of symbol and use fallbacks

 tools/perf/arch/powerpc/util/sym-handling.c   |   7 -
 tools/perf/builtin-annotate.c                 |  47 +--
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
 tools/perf/util/libbfd.c                      |   4 +-
 tools/perf/util/libbfd.h                      |  15 +-
 tools/perf/util/machine.c                     |  34 +-
 tools/perf/util/perf-libelf.c                 | 286 +++++++++++++++
 tools/perf/util/perf-libelf.h                 |  65 ++++
 tools/perf/util/print_insn.c                  |  14 +-
 tools/perf/util/probe-event.c                 |   1 +
 tools/perf/util/probe-finder.c                |   1 +
 .../util/scripting-engines/trace-event-perl.c |   1 +
 .../scripting-engines/trace-event-python.c    |   1 +
 tools/perf/util/symbol-elf.c                  | 337 +-----------------
 tools/perf/util/symbol-minimal.c              |  95 +++--
 tools/perf/util/symbol-minimal.h              |  13 +
 tools/perf/util/symbol.c                      | 108 +++++-
 tools/perf/util/symbol.h                      |  44 +--
 tools/perf/util/symbol_fprintf.c              |   1 +
 tools/perf/util/thread-stack.c                |  12 +-
 tools/perf/util/thread.c                      |  18 +-
 tools/perf/util/unwind-libdw.c                |  15 +-
 58 files changed, 1085 insertions(+), 931 deletions(-)
 create mode 100644 tools/perf/util/perf-libelf.c
 create mode 100644 tools/perf/util/perf-libelf.h
 create mode 100644 tools/perf/util/symbol-minimal.h

-- 
2.52.0.rc2.455.g230fcf2819-goog

