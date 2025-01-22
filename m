Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79322190674
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 06:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737527028; cv=none; b=uoPhQLs4JUGiKNVOO+a+o2umMB9M2D+19Vb8Cdhe1qrOibM/0/xM/Ip9/GcT8RRctiNZDF4Ir8C7RNP1ixQvF1IGsU5sNOLKyleXR/0kFb2a9CwSSiwfoArqVOI5dVI3SyKY4noZdmZriId2kRQ23BVGXypR80+TOdDx0iq74kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737527028; c=relaxed/simple;
	bh=csE5eO77txt/1tgULDwPBlUQn51ePKLm4FAc5Dc7JmA=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=A8icU9yqFH1gsnNASwXHkRRZLKmHADaBYYE6suVIyUlFVUUfH7BD2prHVnth/Xjz8UdabUCvl92/HyLP9f4POLrMIii8pyitdJtF5wgASwgCUe5RftDcOkXOZ5qBTjhmepIqs/MYs9Ad0RjRnhKorvSBqUn3goLIaNufvAw9RIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E+4mQt4P; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E+4mQt4P"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3c61a11a40so17032339276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jan 2025 22:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737527024; x=1738131824; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nMZxZB2QjSpIDp5wnSfQlTa2w8/qiOlFxFu++p/vc3s=;
        b=E+4mQt4P5QlmNdiyZmx1/XDx804TQET26wYwuQ7i4UJtxNntHj4DbzGQfMy97D/7M5
         jgg7Fxoh3d/ToXll6hHxuSlVWiuxsh3tF94pLrrBmw8wYGD2E5GC2NFR8FuyHbSWLs3L
         DZKmhHEbYWsXfPMapd17WDES9Ma8smboC+JQYUy7UUC1ZchXbjGS2Sm1KPZQYu9wHSVg
         +6MS+xXV+XWGO0Db06I7RZvxBVE/GfgP7ogejG2hOhWPhT64lQhShW7Q+hDmuq7oZGTD
         BwCJ5ZWoNhGZWfjrRQHn4UG3jchsoDZHMVawiOcOS3rDOlrK90Pfr9TwZQr5UlE2ghyG
         Uj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737527024; x=1738131824;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nMZxZB2QjSpIDp5wnSfQlTa2w8/qiOlFxFu++p/vc3s=;
        b=rY7JA8v2xCw4Wl578moh9LVs30MY2Jv8jMwOlpFwojsKx4rGQJMJkOkpFrJHNPU84t
         NYyt086sc9xd+PnioSbdkzLLesOSaKHy80HWCoDPK48Mbx22GDg85lYKPcedM07WzMDp
         I0y1qBVHFYwB0Mg+FK9yraQtl2eRBxFYuqWmwIn1RNpyU8abnZB+Kk3xEOSE9nw/bHFT
         20RZLibzqO6ZNHeqpHHrmbXluyfV2v5OmN9iWl1Nf3dtsZwQf5b8OvK2lAEKbQt0OZpz
         qe1sycAlCw5pI5yNGjC3O1FJgqMS0mc3ioPrk6H62HflmCt0qtBfKp1mNqkd7Wfp7tRK
         Asiw==
X-Forwarded-Encrypted: i=1; AJvYcCVkb71WLm/YlbFq42KfJyzIty6YsnztizPShEsMzxPzLYnGJQd/VQAXDmXmvxtFxW6DwlnzpeidY5KTn4xdeTDb@vger.kernel.org
X-Gm-Message-State: AOJu0YwjlasKGF0rNBjIO1l9oSM1PrikTtxiGHC2bkXMPMLt0Aou4VA9
	Bu9OxNWE8LxKtosSLI7KSGUZGEO/NqFTWFnAHIcX5i+YH51Du5A9AJNmSx3pBbioCHUWebIN+AJ
	S3+mJKw==
X-Google-Smtp-Source: AGHT+IFesCcSUy5QR6NwPlyI9//F17lW3wX3r/cz01SIvg7MVkFwQV5BfyGn58F73PrknjQthN5LEM/A3L1B
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a05:690c:6101:b0:6f6:d314:49c9 with SMTP
 id 00721157ae682-6f6eb949eefmr515577b3.8.1737527024453; Tue, 21 Jan 2025
 22:23:44 -0800 (PST)
Date: Tue, 21 Jan 2025 22:23:15 -0800
Message-Id: <20250122062332.577009-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Subject: [PATCH v2 00/17] Support dynamic opening of capstone/llvm remove BUILD_NONDISTRO
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
in dependencies and size of memory footprint. For something like `perf
record` the disassembler and addr2line functionality won't be
used. Support dynamically loading these libraries using dlopen and
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
6) removes the BUILD_NONDISTRO code, reduces scope and removes what's possible.

The addr2line LLVM functionality is written in C++. To avoid linking
against libLLVM for this, a new LIBLLVM_DYNAMIC option is added where
the C++ code with the libLLVM dependency will be built into a
libperf-llvm.so and that dlsym-ed and called against. Ideally LLVM
would extend their C API to avoid this.

The libbfd BPF disassembly supported source lines, this wasn't ported
to the capstone and LLVM disassembly.

v2: Add mangling of the function names in libperf-llvm.so to avoid
    potential infinite recursion. Add BPF JIT disassembly support to
    LLVM and capstone. Add/rebase the BUILD_NONDISTRO cleanup onto the
    series from:
    https://lore.kernel.org/lkml/20250111202851.1075338-1-irogers@google.com/
    Some other minor additional clean up.

Ian Rogers (17):
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

 tools/perf/Documentation/perf-check.txt |   1 -
 tools/perf/Makefile.config              |  90 +---
 tools/perf/Makefile.perf                |  35 +-
 tools/perf/builtin-check.c              |   1 -
 tools/perf/builtin-script.c             |   2 -
 tools/perf/tests/Build                  |   1 -
 tools/perf/tests/builtin-test.c         |   1 -
 tools/perf/tests/make                   |   4 +-
 tools/perf/tests/pe-file-parsing.c      | 101 ----
 tools/perf/tests/tests.h                |   1 -
 tools/perf/util/Build                   |   5 +-
 tools/perf/util/annotate.h              |   1 -
 tools/perf/util/capstone.c              | 682 ++++++++++++++++++++++++
 tools/perf/util/capstone.h              |  24 +
 tools/perf/util/demangle-cxx.cpp        |  22 +-
 tools/perf/util/disasm.c                | 632 +---------------------
 tools/perf/util/disasm.h                |   5 +-
 tools/perf/util/disasm_bpf.c            | 195 -------
 tools/perf/util/disasm_bpf.h            |  12 -
 tools/perf/util/dso.c                   |  98 ++++
 tools/perf/util/dso.h                   |   4 +
 tools/perf/util/llvm-c-helpers.cpp      | 120 ++++-
 tools/perf/util/llvm-c-helpers.h        |  24 +-
 tools/perf/util/llvm.c                  | 489 +++++++++++++++++
 tools/perf/util/llvm.h                  |  24 +
 tools/perf/util/map.c                   |  19 +-
 tools/perf/util/map.h                   |   6 +-
 tools/perf/util/print_insn.c            | 117 +---
 tools/perf/util/srcline.c               | 306 +----------
 tools/perf/util/srcline.h               |   6 +
 tools/perf/util/symbol-elf.c            |  95 ----
 tools/perf/util/symbol.c                | 135 -----
 tools/perf/util/symbol.h                |   4 -
 33 files changed, 1552 insertions(+), 1710 deletions(-)
 delete mode 100644 tools/perf/tests/pe-file-parsing.c
 create mode 100644 tools/perf/util/capstone.c
 create mode 100644 tools/perf/util/capstone.h
 delete mode 100644 tools/perf/util/disasm_bpf.c
 delete mode 100644 tools/perf/util/disasm_bpf.h
 create mode 100644 tools/perf/util/llvm.c
 create mode 100644 tools/perf/util/llvm.h

-- 
2.48.0.rc2.279.g1de40edade-goog

