Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5935216E11
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 17:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567796; cv=none; b=aoUsbApL6q9lSHvqAN2WyL/kDgaIV78YI8eXiuE9IcwUIN+u8qlXgWQi6NZcomlbTwZ/wA0I+qOTG7vmsfYr1JGhS2NRG2bRV8/aS/pHx5VvmqOCl4BvntXEVQvTTgI3yaZdOt3gK7XDMHQcRASSPxlPowO3bIXlV+rQLhpEoRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567796; c=relaxed/simple;
	bh=9VN6QjInjpqpeMllAh6JGaiVUlDwgMRGIx3r+D/S8Ko=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=hJCM+xI84A8+LEWdXnD49TE1UWdm0H5IdIvD7yO57v5rBRVC3T9N370pARjxQc1BcYOCMlYllYOgan3YrQEi2PY/sD3cY0UpM+Zq9cJr81WMZoeK6rk1qMLxYQvAAQlvtL0JmLvom+tOkx7Thcwu8iJ2H1qXSqr1k+7Wp0zUUNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N/myvM9H; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N/myvM9H"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e549c458692so11832147276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 09:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737567793; x=1738172593; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z9uCPHRntHbZ9KmMQl+SuBXWGQGzkHWS/clQSy2B2wo=;
        b=N/myvM9HY50KHeSQAy6fzb6Pdc7HB8dHn3eEjR4fCazr3kPsLc2hdBWrJ9DaximKDk
         mh76OnCe/LtYxLpETyjGLMG9wLP7JB1LXcJYDitjPqD/8wEoThc88f74dFYtoQnG8LFf
         6+Vmeq18AvHvARYag6+W9V0SVZz685e8R41shuhV+9qFC7j8q8Xl4r3Vwe5v3U/QWLfT
         cP2bN1Dx5HQrOBNe1mFzW3psNJHX6GFVPGc9ZnrcwVWiE/LUXgyc42aW2FOSBeuckjoS
         u6Hl7GI/Xf/gBnAS+y1glgKAZOatR49uBWDX8pgSAbSHxRda/+suCqEQQ5ePCzUZR1If
         eZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737567793; x=1738172593;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z9uCPHRntHbZ9KmMQl+SuBXWGQGzkHWS/clQSy2B2wo=;
        b=JQTz0FMUo9FABjS2Vf3+wxjF4nZRFccD9ErOjViK/yeLYh9/OHAqgTXvK6OX7aPwIm
         BLfvTaBeoYtEcIh58Yvrr5q0gsKZZxz1W8PPtVhY7lGfdwqqYFrGuRBS1d8XDgwVG+0o
         mfnvtBHc+agQeQRJYPZgwa4s6QLHeH8j/EdHahPOGIE8l09Qf5x45Vi2SH78mLAf0mdW
         mwDxVPz6QpUoUq14wDQdHbovOIGZFGdPbcm8bARHR59wr5dtG/zu8eU/oG8uN+rur7vq
         I7oOLlDDmsMZenF3YGDJYjZbyQ+k6+mRnU2Xff3KtyUnFETAaaPLe/3/eqURIraO4Eq1
         /rEA==
X-Forwarded-Encrypted: i=1; AJvYcCV/KZgIf0U/Pa/l7zy5votHLy8kr8ftQcGC+f7CWqW6jM4mc6K/QzUNYQXM6u58/OVDXpq+Fb8hj2oGE7V038Z5@vger.kernel.org
X-Gm-Message-State: AOJu0YxiyDdfh3U5G43y7FzAPMDU2GbWPt+vyf97ccjY7+/XrcndRJU+
	cD0QfBZo711MxzwAnEfBZ1kGzx1H6VpAiVOFOOw42wmZLDTj6HoUK0xV+2Hj8vlCvY0gLIzlrlu
	KM/KngQ==
X-Google-Smtp-Source: AGHT+IFh6plgusKalIV+rt0enhRru7sGKX4DpTeUM13POHq5b3JfO6EFuKYapMGo4BFswUSO5bdUEJn66ggI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a05:690c:8087:b0:6f5:53f7:9d40 with SMTP
 id 00721157ae682-6f6eb512461mr327917b3.0.1737567792811; Wed, 22 Jan 2025
 09:43:12 -0800 (PST)
Date: Wed, 22 Jan 2025 09:42:50 -0800
Message-Id: <20250122174308.350350-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Subject: [PATCH v3 00/18] Support dynamic opening of capstone/llvm remove BUILD_NONDISTRO
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Linking against libcapstone and libLLVM can be a significant increase
in dependencies and file size if building statically. For something
like `perf record` the disassembler and addr2line functionality won't
be used. Support dynamically loading these libraries using dlopen and
then calling the appropriate functions found using dlsym.

BUILD_NONDISTRO is used to build perf against the license incompatible
libbfd and libiberty libraries. As this has been opt-in for nearly 2
years, commit dd317df07207 ("perf build: Make binutil libraries opt
in"), remove the code to simplify the code base.

The patch series:
1) does some initial clean up;
2) moves the capstone and LLVM code to their own C files,
3) simplifies a little the capstone code;
4) adds perf_ variants of the functions that will either directly call
   the function or use dlsym to discover it;
5) adds BPF JIT disassembly support to LLVM and capstone disassembly;
6) removes the BUILD_NONDISTRO code, reduces scope and removes what's possible;
7) adds fallback to srcline's addr2line so that llvm_addr2line is
   tried first and then the forked command tried next, moving the code
   for forking out of the main srcline.c file in the process.

The addr2line LLVM functionality is written in C++. To avoid linking
against libLLVM for this, a new LIBLLVM_DYNAMIC option is added where
the C++ code with the libLLVM dependency will be built into a
libperf-llvm.so and that dlsym-ed and called against. Ideally LLVM
would extend their C API to avoid this.

The libbfd BPF disassembly supported source lines, this wasn't ported
to the capstone and LLVM disassembly.

v3: Add srcline addr2line fallback trying LLVM first then forking a
    process. This came up in conversation with Steinar Gunderson
    <sesse@google.com>.
    Tweak the cover letter message to try to address Andi Kleen's
    <ak@linux.intel.com> feedback that the series doesn't really
    achieve anything.
v2: Add mangling of the function names in libperf-llvm.so to avoid
    potential infinite recursion. Add BPF JIT disassembly support to
    LLVM and capstone. Add/rebase the BUILD_NONDISTRO cleanup onto the
    series from:
    https://lore.kernel.org/lkml/20250111202851.1075338-1-irogers@google.com/
    Some other minor additional clean up.

Ian Rogers (18):
  perf build: Remove libtracefs configuration
  perf map: Constify objdump offset/address conversion APIs
  perf capstone: Move capstone functionality into its own file
  perf llvm: Move llvm functionality into its own file
  perf capstone: Remove open_capstone_handle
  perf capstone: Support for dlopen-ing libcapstone.so
  perf llvm: Support for dlopen-ing libLLVM.so
  perf llvm: Mangle libperf-llvm.so function names
  perf dso: Move read_symbol from llvm/capstone to dso
  perf dso: Support BPF programs in dso__read_symbol
  perf llvm: Disassemble cleanup
  perf dso: Clean up read_symbol error handling
  perf build: Remove libbfd support
  perf build: Remove libiberty support
  perf build: Remove unused defines
  perf disasm: Remove disasm_bpf
  perf disasm: Make ins__scnprintf and ins__is_nop static
  perf srcline: Fallback between addr2line implementations

 tools/perf/Documentation/perf-check.txt |   1 -
 tools/perf/Makefile.config              |  90 +--
 tools/perf/Makefile.perf                |  35 +-
 tools/perf/builtin-check.c              |   1 -
 tools/perf/builtin-script.c             |   2 -
 tools/perf/tests/Build                  |   1 -
 tools/perf/tests/builtin-test.c         |   1 -
 tools/perf/tests/make                   |   4 +-
 tools/perf/tests/pe-file-parsing.c      | 101 ----
 tools/perf/tests/tests.h                |   1 -
 tools/perf/util/Build                   |   6 +-
 tools/perf/util/addr2line.c             | 439 ++++++++++++++
 tools/perf/util/addr2line.h             |  20 +
 tools/perf/util/annotate.h              |   1 -
 tools/perf/util/capstone.c              | 682 +++++++++++++++++++++
 tools/perf/util/capstone.h              |  24 +
 tools/perf/util/config.c                |   2 +-
 tools/perf/util/demangle-cxx.cpp        |  22 +-
 tools/perf/util/disasm.c                | 632 +------------------
 tools/perf/util/disasm.h                |   5 +-
 tools/perf/util/disasm_bpf.c            | 195 ------
 tools/perf/util/disasm_bpf.h            |  12 -
 tools/perf/util/dso.c                   |  98 +++
 tools/perf/util/dso.h                   |   4 +
 tools/perf/util/llvm-c-helpers.cpp      | 120 +++-
 tools/perf/util/llvm-c-helpers.h        |  24 +-
 tools/perf/util/llvm.c                  | 484 +++++++++++++++
 tools/perf/util/llvm.h                  |  21 +
 tools/perf/util/map.c                   |  19 +-
 tools/perf/util/map.h                   |   6 +-
 tools/perf/util/print_insn.c            | 117 +---
 tools/perf/util/srcline.c               | 772 +-----------------------
 tools/perf/util/srcline.h               |   7 +-
 tools/perf/util/symbol-elf.c            |  95 ---
 tools/perf/util/symbol.c                | 135 -----
 tools/perf/util/symbol.h                |   4 -
 36 files changed, 2020 insertions(+), 2163 deletions(-)
 delete mode 100644 tools/perf/tests/pe-file-parsing.c
 create mode 100644 tools/perf/util/addr2line.c
 create mode 100644 tools/perf/util/addr2line.h
 create mode 100644 tools/perf/util/capstone.c
 create mode 100644 tools/perf/util/capstone.h
 delete mode 100644 tools/perf/util/disasm_bpf.c
 delete mode 100644 tools/perf/util/disasm_bpf.h
 create mode 100644 tools/perf/util/llvm.c
 create mode 100644 tools/perf/util/llvm.h

-- 
2.48.1.262.g85cc9f2d1e-goog

