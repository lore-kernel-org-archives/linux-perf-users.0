Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299FE480DDC
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 07:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769067097; cv=none; b=i2vrUqJmjsRgCnpLJ2s0z+qlTaIljXJQCVpw5bntaIuneo/FPTymvI4uSqD5nwhpLkQg5tz++Nt7jc9yDEJgwDucLsEBM7h3SsO506xZ8AkhGbEfRrDHE22o0GZpALv4Q8NXB44M2aLyXhRz7mqhwRvS2TdhU51+NgzIW8QND5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769067097; c=relaxed/simple;
	bh=FP4pcvY55K9wZ5FOq0M3Pn6GxDefhP9XQZkhy9GIH8M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=hZhuiLcCrd52cGYHCv4K2SSFAoef71SmWGfX34g3jkbRhSfnZqZybBVMODSr4Jn3xDD6WVAIQlH+/ERbtmDSsv36YIBgbRVktJQ0CwkU4YZJuRIYAzPuo9oTPu9QGOXkjVqcaltNBl3321I/5VniRm8s6fpCELkpJ6EbNoW0MxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JxwQVKQg; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JxwQVKQg"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29f1f79d6afso7536995ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 23:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769067090; x=1769671890; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2R1FRhbsKavEIm7ZjwPShbYdeLpx11RnJSbV1m2ZXYk=;
        b=JxwQVKQgEw3N6Y0qSnjfXwxs18nx3xKxpW2OroB+0BVz8qw1QN6xNPlpHby+3lwESz
         qUqA++kCh7IZCA1V6mImqRgPO2sGz6/b0SLgiI6uKUuRVpvcpxyQAJoS+uhc+4V21uJo
         Qtiq/gN3sXnfhl9jft7iQMNWAZlCYZUEfrkQd0D6UfmWu5C5DxnFgMs3VKVBgvWAnbOi
         /9U5glZWha0Uy3gHtPzqRZlmB+iTjQ63NDCGHJQHKPfhfAsDMxYoMI2a+AJqFbLb88MF
         FwK6xl7enO2Z1wqbilH7p+udOYG1rsboXez1O1bs6vgR240omyt+/CFwD6TPt5aXL2cj
         uiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769067090; x=1769671890;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2R1FRhbsKavEIm7ZjwPShbYdeLpx11RnJSbV1m2ZXYk=;
        b=YzsUuOk/q0ENbpnHdY0r5BX41yjihfmQwBFZfGkXCXctkPD8+BkRr8JlNwpeHnoMYE
         fnnJ7FtZiFW9DCluDYmZuYv1nXhjEVlBVjiB07u2SEs3ZfNKQ9ngmmh2UwBhIWbRF/qQ
         XThyC8nOcRJ+YLipYVzid2bfCXl2vOhkZ8RaFQLG5Nc4Vyyisr7cPze3eWtimFMKutYp
         Qvpnv5Ldar8RjMSuarwRpzJx/8jNARphIQqG2d1bAm023nq31ehjZuC0SjFoki9/f2/3
         z0jWj+EJ6hZ/BJkxbDev/bmuQNK1o1kyiA7H6G8TqUNrSDOQNBcvo3qrNq3UBhkCYyzO
         b60w==
X-Forwarded-Encrypted: i=1; AJvYcCUMYvFb1FcuFCmOzoDBk3aE7hvVE4CxckQVkcX2b/MnX/5deajfUSODjSmuJo1KAOw5ZfdJPSe5qvKx9nH0s8gk@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0UcVPXXzjVKmAokmE/ug9yhF1KMMW9PaeolZnU0vmiGtezpcd
	1gQXzMrSeqgTPgll+MTT5cb+o8Dzy2LTL1QoMGe2TGR9LwiEES2kv3N1K8E5hvnK4pw3Zj6+5nQ
	A2jWkdNTzMA==
X-Received: from plkq20.prod.google.com ([2002:a17:902:edd4:b0:2a7:885f:d4c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b4f:b0:2a7:683c:afd0
 with SMTP id d9443c01a7336-2a7683cb263mr75816465ad.14.1769067090015; Wed, 21
 Jan 2026 23:31:30 -0800 (PST)
Date: Wed, 21 Jan 2026 23:31:16 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122073127.375139-1-irogers@google.com>
Subject: [PATCH v1 00/11] perf annotate arch clean up
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Zecheng Li <zecheng@google.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Suchit Karunakaran <suchitkarunakaran@gmail.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

2 initial memory leak fix patches for perf annotate.

Move the disasm.c #included arch files into a new util/annotate-arch
directory. Make the code compile standalone. Try to better encapsulate
architecture specific code within the files and with a
arch__new_<arch> function that allows additional data to be associated
with the struct arch using the standard container_of trick.

Make the lookup of struct arch use the ELF machine gather from a
thread rather than an evsel. For example, the evsel can't determine
the difference between EM_386 and EM_X86_64 so generally the latter
has currently been used. This means the dwarf registers are off as
register 1 is CX with EM_386 and DX with EM_X86_64. To facilitate this
change map_symbol is refactored to use a struct thread rather than a
struct maps, the maps being obtainable from the thread.

To make in and out arguments clearer, for safety, etc. try to constify
struct arch and its related structs.

Ian Rogers (11):
  perf maps: Fix reference count leak in maps__find_ams
  perf annotate: Fix args leak of map_symbol
  perf disasm: Constify use of struct arch
  perf disasm: Constify use of struct ins_op
  perf disasm: Constify use of struct ins
  perf disasm: Rework the string arch__is to use the ELF machine
  perf disasm: Don't include C files from the arch directory
  perf disasm: Refactor ins__is_call/jump to avoid exposing arch ins_ops
  perf map_symbol: Switch from holding maps to holding thread
  perf disasm: Refactor arch__find and initialization of arch structs
  perf disasm: Minor layout tweaks for struct arch

 tools/perf/arch/arc/annotate/instructions.c   |  11 -
 .../perf/arch/riscv64/annotate/instructions.c |  36 --
 tools/perf/ui/browsers/annotate.c             |   6 +-
 tools/perf/ui/browsers/hists.c                |   3 +-
 tools/perf/util/Build                         |   1 +
 tools/perf/util/addr_location.c               |   4 -
 tools/perf/util/addr_location.h               |   1 -
 tools/perf/util/annotate-arch/Build           |  11 +
 tools/perf/util/annotate-arch/annotate-arc.c  |  18 +
 .../annotate-arch/annotate-arm.c}             |  48 +-
 .../annotate-arch/annotate-arm64.c}           |  59 +--
 .../annotate-arch/annotate-csky.c}            |  29 +-
 .../annotate-arch/annotate-loongarch.c}       |  57 ++-
 .../annotate-arch/annotate-mips.c}            |  29 +-
 .../annotate-arch/annotate-powerpc.c}         | 125 +++++-
 .../util/annotate-arch/annotate-riscv64.c     |  41 ++
 .../annotate-arch/annotate-s390.c}            |  59 ++-
 .../annotate-arch/annotate-sparc.c}           |  26 +-
 .../annotate-arch/annotate-x86.c}             |  89 ++--
 tools/perf/util/annotate-data.c               |  12 +-
 tools/perf/util/annotate-data.h               |   2 +-
 tools/perf/util/annotate.c                    |  88 ++--
 tools/perf/util/annotate.h                    |  10 +-
 tools/perf/util/callchain.c                   |  12 +-
 tools/perf/util/capstone.c                    |  18 +-
 tools/perf/util/db-export.c                   |   1 -
 tools/perf/util/disasm.c                      | 424 +++++++-----------
 tools/perf/util/disasm.h                      |  95 ++--
 tools/perf/util/event.c                       |   2 -
 tools/perf/util/hist.c                        |  18 +-
 tools/perf/util/llvm.c                        |   8 +-
 tools/perf/util/machine.c                     |  13 +-
 tools/perf/util/map_symbol.c                  |   5 +-
 tools/perf/util/map_symbol.h                  |   3 +-
 tools/perf/util/maps.c                        |   1 +
 tools/perf/util/sort.c                        |   2 +-
 tools/perf/util/unwind-libdw.c                |   2 +-
 tools/perf/util/unwind-libunwind-local.c      |   2 +-
 38 files changed, 752 insertions(+), 619 deletions(-)
 delete mode 100644 tools/perf/arch/arc/annotate/instructions.c
 delete mode 100644 tools/perf/arch/riscv64/annotate/instructions.c
 create mode 100644 tools/perf/util/annotate-arch/Build
 create mode 100644 tools/perf/util/annotate-arch/annotate-arc.c
 rename tools/perf/{arch/arm/annotate/instructions.c => util/annotate-arch/annotate-arm.c} (59%)
 rename tools/perf/{arch/arm64/annotate/instructions.c => util/annotate-arch/annotate-arm64.c} (70%)
 rename tools/perf/{arch/csky/annotate/instructions.c => util/annotate-arch/annotate-csky.c} (67%)
 rename tools/perf/{arch/loongarch/annotate/instructions.c => util/annotate-arch/annotate-loongarch.c} (66%)
 rename tools/perf/{arch/mips/annotate/instructions.c => util/annotate-arch/annotate-mips.c} (59%)
 rename tools/perf/{arch/powerpc/annotate/instructions.c => util/annotate-arch/annotate-powerpc.c} (73%)
 create mode 100644 tools/perf/util/annotate-arch/annotate-riscv64.c
 rename tools/perf/{arch/s390/annotate/instructions.c => util/annotate-arch/annotate-s390.c} (70%)
 rename tools/perf/{arch/sparc/annotate/instructions.c => util/annotate-arch/annotate-sparc.c} (85%)
 rename tools/perf/{arch/x86/annotate/instructions.c => util/annotate-arch/annotate-x86.c} (93%)

-- 
2.52.0.457.g6b5491de43-goog

