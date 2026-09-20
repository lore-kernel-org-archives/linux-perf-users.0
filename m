Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DEE3C2BAF;
	Sun, 20 Sep 2026 02:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789871673; cv=none; b=hHzKaL5pxoxqM273Lbf9jWgyL3Uz+d6zI9dy0ucl7oeD301QBNYXKuuNd9ObPQgjS48PJjZuDreDSO8VbwNQ+yksnAlEywR9W8XNIWeT4NKCo+0l9QzmM10x/dx+27OyX6mq0c7Ldu/spFn4OMFRqAtWxr+hQHfzV37+M/Tc2Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789871673; c=relaxed/simple;
	bh=4VCBXfJVofxyyT0RDxutQE8DtQhSmd5uEOtKwOdl87Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gZkumcn0mOHmUTs5xAVlpj5qI9E8PGwJMKDIDJwS5mY8qKbfs/pTHj+MJ47CdY141V8QpSAMUoaQytV2qcuDaCYE9G9Q4RDb+FfY54fFffJYPJUg8n9CN3eVPgfPSWwP32fggcNRdsybKGQCK0YA7W4z96DYIVJtwh6eBoyiQSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeWmulbs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeWmulbs"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 203A8C2BCF5;
	Sun, 20 Sep 2026 02:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789871673;
	bh=4VCBXfJVofxyyT0RDxutQE8DtQhSmd5uEOtKwOdl87Y=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=qeWmulbsbM5Pan6zMb1SNMO1D3wG2bdhdm9W9SZ2xWRpZTbljJYeoRNTn+1vKDZUH
	 eQ2n3qLGV3hH99kHi0ObJuJp3CQeJElBjqBE1zfmYyk3tkc0u1CopWExkLh+OAUsXp
	 IvM/RNLqsfU2czYWI+cqPfyXPNuEhPknKGh6zZKelolG3WSAiHsg/pzWePZ6lTSinm
	 oPIU4bgETh39yGfgpqr9sa5IjYUkKBMLDY5oWByUrxW5fvFXsuorttxIjDBptmZiMd
	 d8P+GB4d3ejvtMv5E8NhC8iLexxcAtWUsPlTRAiTju/Alf7t3lvAAW2kRqFfT62Dvc
	 x8EPD7tFLZWkQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEB3C982E1;
	Sun, 20 Sep 2026 02:34:32 +0000 (UTC)
From: Alireza Haghdoost via B4 Relay <devnull+haghdoost.uber.com@kernel.org>
Subject: [PATCH v2 0/4] perf script: Bounded and lazy symbol loading
Date: Sat, 19 Sep 2026 19:33:55 -0700
Message-Id: <20260919-perf-symbol-memory-send-v2-0-495b8f00ad7c@uber.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0Jm7Zi2RAiuvAdhAe1UaiwlHSASw
 t0teACXL/nvvw2YoiOGe7ZBpMWxC0MCdclA9+3wJHQmMSihClHJG44ULfLqu/BGTz7EFZkGg1R
 qq1vZ6txUkOwxknWf87lufsxz9yI9HXfHonc8Jf1ML/LY/a8sEgVKk+eFICWtKB9zR/Gqg4dm3
 /cvB1OQm88AAAA=
X-Change-ID: 20260915-perf-symbol-memory-send-e7cfca1ac3d9
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andriin@fb.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alireza Haghdoost <haghdoost@uber.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4316; i=haghdoost@uber.com;
 h=from:subject:message-id;
 bh=4VCBXfJVofxyyT0RDxutQE8DtQhSmd5uEOtKwOdl87Y=;
 b=owEBiQJ2/ZANAwAIAVNlBDxl2ALYAcsmYgBqr0Y2Q9+6RUrJJinzBl358kmTMnP+Mu+455/Ye
 Iqx72Y1iRmJAk8EAAEIADkWIQS5+sFL3gX/8PrA0S1TZQQ8ZdgC2AUCaq9GNhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQU2UEPGXYAtjUOA/+MTMiVz2HbgFHwNRXgnlndYPSfcC4Dzb
 9YEZu/BDN9qZyEMDy4tt4F/BazhhS2tlpIdjVwroeWEycB3q+9eoNCoJBY/IN/r1/8ADYjVtiWr
 JpS6V12/FWWsWtY72e8sfdp6uCQYrNL+aNprYof3DPOzFux9ELGW8pINDeAVc40U4Q8WyzELTBL
 X6c7hrisctaQydtIvMTS+7updRX/jSTIrMapVcJtQKhFL1C2ljuHC28ht6yGXS047IVa61LAyh+
 il72MkyORST+m/MllAHBk4Ki6Sn5N7XEjzMHAQV3AAd8YArbfcZDyAsBTRG8E0OV2N6/rvhPeR7
 j1wK9Bp8B5hEeITztXHBnObzo8ru5kMCKT/P5lby8Mq0ZOCLKr1VVh4yMQd6SNuoZdUZFvNUBx1
 4Y0J38O/wu9IG89gQPdloXi8YK9aydhSnY1ItcmVBnU4aFq04JyCbphMw8ZRdHWBjCP6wlBFPx1
 v9FJsdImn7BqrBOq66d9GWzqYKKMEAXfR/7Y/AX59wy69UMfzjrtbNE36yXub3afVmI4XNnG5Dt
 YVNWToEcL4gXtPlg8YyYj7+XynNjiBFsMCrwzXrMp6CWp62dRJkLBWKLNS304C2lLGodKKztUnX
 Z4+jX34eFCoiwq99aY8SIyxRzGbkX9p18PT/iPugcfPwRSktbFm0=
X-Developer-Key: i=haghdoost@uber.com; a=openpgp;
 fpr=B9FAC14BDE05FFF0FAC0D12D5365043C65D802D8
X-Endpoint-Received: by B4 Relay for haghdoost@uber.com/default with
 auth_id=764
X-Original-From: Alireza Haghdoost <haghdoost@uber.com>
Reply-To: haghdoost@uber.com

perf script loads the entire ELF symbol table of every DSO that appears
in a sample, allocating each symbol into an rb-tree held until process
exit. Therefore, a large enough profile turns symbol loading into an
OOM kill.
This is not scalable for profiling a large cgroup with a lot of large
binaries on a production system with limited free memory.

This series adds two independent, opt-in mechanisms and a leading
regression fix they build on:

  [1/4] Fix a broken "#ifdef ELF_C_READ_MMAP" guard so perf actually
        mmaps ELF files instead of malloc'ing section data. This is a
        standalone regression fix that is introduced by 22dd1ac91a77.

  [2/4] --max-symbol-bytes <size>: a byte budget on struct symbol
        allocations (and the lazy index) enforced at the ELF symbol
        loader, degrading to [unknown] with a warning past the cap.
        An unbounded profile doesn't just risk OOM-killing itself. It
        also forces memory pressure on the whole host, pushing the kernel
        to reclaim from co-located latency-sensitive processes. Capping
        it lets the user bound that footprint up front and choose the
        trade-off explicitly.

  [3/4] --lazy-load-symbols: build a compact per-DSO sorted index and
        resolve only the sampled addresses, reading names through the DSO
        data cache at lookup time. On the production fixture, peak RssAnon
        drops from 265 MiB to 39 MiB (6.8x) and wall time from 3.1 s to
        1.85 s (1.7x). Memory optimizations usually cost time; this one
        does not because lazy loading skips a lot of calloc and demangle
        calls.

  [4/4] Shell and unit tests for both options.

Lazy loading handles the common userspace ELF symtab/dynsym path. Eager
loading remains available for dense coverage and for PPC64 .opd and
.gnu_debugdata.

Changes in v2:

- Replace direct pread() name reads with the exact symbol source's DSO data
  cache, preserving split-debuginfo offsets and descriptor reopen behavior.
- Drop the byte-identical-output claim and retain eager loading for PPC64
  .opd and .gnu_debugdata.
- Make the symbol budget atomic and strict, account complete name lengths,
  accept a bare 0 as unlimited, and keep partial zero-sized ranges from
  covering omitted symbols.
- Align lazy lookup with eager duplicate and IFUNC selection, PLT clipping,
  and name-sorted materialization.
- Move option documentation into the feature patches. Add unit and shell
  coverage for cache reopen, truncated names, budget truncation, and skip
  handling.

Link: https://lore.kernel.org/all/20260915-perf-symbol-memory-send-v1-0-1d3360e21f07@uber.com/
---
Alireza Haghdoost (4):
      perf symbols: Fix broken ELF_C_READ_MMAP fallback guard
      perf script: Add --max-symbol-bytes to bound ELF symbol memory
      perf script: Add --lazy-load-symbols for lazy symbol loading
      perf test: Test lazy symbol loading and symbol memory limits

 tools/perf/Documentation/perf-script.txt           |  28 +
 tools/perf/arch/powerpc/util/sym-handling.c        |   5 +-
 tools/perf/builtin-script.c                        |  44 ++
 tools/perf/tests/Build                             |   1 +
 tools/perf/tests/builtin-test.c                    |   1 +
 tools/perf/tests/shell/script_lazy_load_symbols.sh | 278 ++++++++
 .../tests/shell/script_lazy_load_symbols_skip.sh   |  26 +
 tools/perf/tests/symbol-bytes.c                    | 340 ++++++++++
 tools/perf/tests/tests.h                           |   1 +
 tools/perf/util/dso.c                              |  63 +-
 tools/perf/util/dso.h                              |  49 ++
 tools/perf/util/map.c                              |  30 +-
 tools/perf/util/symbol-elf.c                       | 733 ++++++++++++++++++++-
 tools/perf/util/symbol-minimal.c                   |  17 +
 tools/perf/util/symbol.c                           | 140 +++-
 tools/perf/util/symbol.h                           |  24 +-
 tools/perf/util/symbol_conf.h                      |   2 +
 17 files changed, 1723 insertions(+), 59 deletions(-)
---
base-commit: aa18964dd64511305de0711fed912054da6f5d18
change-id: 20260915-perf-symbol-memory-send-e7cfca1ac3d9

Best regards,
--  
Alireza Haghdoost <haghdoost@uber.com>


