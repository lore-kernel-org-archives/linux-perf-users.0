Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB06C37B016
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 08:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228854; cv=none; b=klsWD6lT+NSTIrsMV4KevnlmOnXXIm0xI7ia/GiSP56JUViFO5JID6m/PLPWpxoEinCMFR4qArxzNo4cnWpBLUZEM3noTSVDyuHheXr9K88eQ9GarlGR9GXhvSkuqGJzWbMvd+HH4zGlNsD+M9gEoQyQ40vQ9rjFcNTEqhYsRAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228854; c=relaxed/simple;
	bh=Z8D+qM431HsXWc1YNqj99LLyhdkm8N/ae1FrxA5N6BY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CQIDLWIS2368dTDEigd4VlvZ3nHpcmHzOUEr9lHT42gK5NYIuvYKTn1s4eKzaAlIwAzA6CwgBmD7xi5RvH7cqK9Xb3WGelggCM+OfvH6bBmIDgO743HlrBh30MnKbLpPirziXSSDS+9MpFqN7vPCSF/dZdM5FIQeg3jE9aspb68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cvbpJXcx; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cvbpJXcx"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dfe06b670so2429809c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 08 May 2026 01:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778228852; x=1778833652; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A27AztoNl+avrYoTBWqtdGCjC1bpNa6apm2lkAYTrUY=;
        b=cvbpJXcxOeCvlwRDXomHJy768+PVFSDnCaXyUh1Rpj9xMLeTwW0SW4JX05jMWd8/Y4
         5fuQ0vfNvoMw/MOT+PQAXbehRjWc+6mwHxCTx5kJudajQ6fpK+MflNIlHONtIxNb0HQZ
         Gz9mmA975CCFpt4bIixzSWz7QdR8QUSBI52gZrimzE+Q8OJPnpQtB9qDLAkeTfR6LNBX
         VOZqEtuPgNRFmNS1VBD2lcD2lIUILPeYU7VVGbE9F/S7U+y5RNlCGkCmcoYM6ogyPWSP
         WEDJF0hoKVrOwhehh7MEIRGxWeHY9FyblovlBgzD90vgHYi2jGVkRt9guqGTUsReA/tr
         kasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778228852; x=1778833652;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A27AztoNl+avrYoTBWqtdGCjC1bpNa6apm2lkAYTrUY=;
        b=Ztx7boi7Q/YRMiTtGP6ZYwQCUjNubjsXHxp0pttZOJi/cOBPYY0vMZ89bjfgnLq20s
         v4LA+Nuhir67h7IVYoxM2x8bA0hWPHWBgD8xZOta6kShzjHJL0QV4vQaSrReQkY3eOoc
         TkQ7TXlDaE9tGQw3EcTACRdhQivj6VkI4UuqpI6VRpRAbkP7cwSFNfkYQeRZ7vEYpmYZ
         crjvoaj+JSPtEgYgcO3BtY22ybhM2ebqQahr4tGBkWtycdivjLyKC88ptgm6yTwTnHaj
         Ckv3p6d83K4qDg3Y2kUVtMfSwZEQDAKepDIeIKNJ5K+SeWPzzWgdg0jvsFGtB+Tj9Mnl
         4Vlw==
X-Forwarded-Encrypted: i=1; AFNElJ9k9ghHrk4j1qsOiwFVA8o6f9uZmZiKmb4xdUIqNIj/5HuuLrehBswgGCLqOJ6UdTbUIJSHj1xyaS+TckCBrSHA@vger.kernel.org
X-Gm-Message-State: AOJu0YydTJ3xzpOLJOMgE8jyRwKb+e4EHq/MNyptbpgQsNdHRTDBJh0s
	/EXuFvfBVTufXiwZfw9b3Ca1XG7CNjqJv6JKBfijuu5S1KUyPXZzdLlqWrB9wr7sBYn3XVRCo70
	EL4dce4rhXQ==
X-Received: from dlbps10.prod.google.com ([2002:a05:7023:88a:b0:12d:d43c:4120])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4181:b0:123:34e8:aec2
 with SMTP id a92af1059eb24-131964bab24mr5944072c88.1.1778228851266; Fri, 08
 May 2026 01:27:31 -0700 (PDT)
Date: Fri,  8 May 2026 01:27:20 -0700
In-Reply-To: <20260506004546.3140141-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260506004546.3140141-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508082726.2795191-1-irogers@google.com>
Subject: [PATCH v6 0/6] perf tools: Add inject --aslr feature and prerequisite
 robustness fixes
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, gmx@google.com, 
	james.clark@linaro.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch series introduces the new 'perf inject --aslr' feature to
remap virtual memory addresses or drop physical memory event leaks
when profile record data is shared between machines. Bundled with this
feature are three independent, critical bug fixes inside core event
dispatching and map tracking tools that harden perf session analysis
against dynamic crashes, concurrent lookup data races, and callchain
mapping failures.

Core Feature: 'perf inject --aslr' (Patches 4, 5, and 6)

Transferring perf.data files across environments introduces a
potential leak of virtual address footprints, weakening Address Space
Layout Randomization (ASLR) on the originating machine. To mitigate
this, we introduce the --aslr flag into perf inject. Unknown or
unhandled events are dropped conservatively, while handled samples and
branch loops undergo systematic virtual memory offset obfuscation.

Events carrying virtual memory layouts are conservatively
remap-processed or dropped, while zero-address-risk lifecycle metadata
records (such as namespaces, cgroups, and BPF program info) are
intentionally delegated to preserve comprehensive downstream trace
tool analysis compatibility.

The ASLR tracking tool virtualizes process and machine namespaces
using 'struct machines' to safely isolate host mappings from
unprivileged KVM guest address spaces. Memory space layouts are
tracked globally per process context to ensure linear, continuous
space allocations across successive mapping runs.  The topological
invariant coordinate dso + invariant (start - pgoff) is tracked to
uniquely index binary section frameworks, providing complete collision
safety against separate overlapping shared-invariant libraries while
remaining perfectly immune to boundary shifts or split fragmentations.

To remain strictly conservative and guarantee security, the tool
scrubs breakpoint addresses (bp_addr) from all synthesized stream
headers, completely drops PERF_RECORD_TEXT_POKE events to prevent
absolute immediate pointer operands leaks, and drops unsupported
complex payloads (such as user register stacks, raw tracepoints, and
hardware AUX tracing frames).

Verification is reinforced in Patch 5 with a comprehensive POSIX shell
suite ('inject_aslr.sh'), hardened against SIGPIPE signal exits with
stream consuming awk loops and robust 'set -o pipefail'
assertions. The suite utilizes a highly dense, system-call intensive
VFS byte block loop workload (dd count=500) to guarantee deterministic
hardware timer interrupts sampling streams inside kernel privilege
states.

Prerequisite Bug Fixes (Patches 1, 2, and 3)

During development, three core event delegation and map indexing
issues were identified and resolved to prevent crashes, live-locks,
and data-loss during analysis:

1. perf sched: 'timehist' registers standard MMAP, COMM, EXIT, and
   FORK stubs, but completely omitted registering MMAP2
   callbacks. Because modern environments output maps primarily via
   MMAP2 frames, this caused timehist sessions to silently drop shared
   library mappings, causing dynamic callchain symbol resolutions to
   fail. Patch 1 corrects this by properly registering
   perf_event__process_mmap2.

2. perf tool: Patch 2 fixes missing copies of schedstat callbacks
   inside delegated wrapper tools (which caused segfaults on NULL
   stubs) and properly initializes/copies the
   'dont_split_sample_group' grouping parameters to prevent stack
   garbage from triggering silent non-leader events drops during split
   deliver streams.

3. perf symbols: Patch 3 replaces old remove-reinsert map boundary
   update cycles with a high-performance, thread-safe transactional
   framework maps__mutate_mapping() that enforces write semaphore lock
   closures around all in-place virtual address mutations and sorting
   invalidations, completely closing concurrent lookup race condition
   windows. It explicitly executes DWARF address space cache
   invalidation (libdw__invalidate_dwfl()) to keep debugger unwinding
   frames perfectly synchronized.

Changes since v5:

- Core Concurrency Fix (Patch 3): Refactor map address boundary
  mutations across ELF loaders, proc kallsyms parsers, and dynamic
  module managers to utilize a thread-safe, synchronized transactional
  framework maps__mutate_mapping() that encapsulates mutations and
  sorting invalidations under write lock closures, eliminating
  concurrent lookup race condition windows. Cites intention-revealing
  callbacks names (remap_kernel_cb).

- Feature Exclusivity (Patch 4): Inject strict command-line validation
  checks enforcing mutual exclusivity between --aslr and
  --convert-callchain to prevent silent trace unwind failures since
  ASLR stack dropping conflicts directly with DWARF parsing needs.

- KASLR Hardening (Patch 4): Secure mmap.pgoff unconditionally for all
  host and guest kernel text mapping regions to prevent unredacted
  active KASLR base deltas leakage.

- TEXT_POKE Drops (Patch 4): Conservatively drop PERF_RECORD_TEXT_POKE
  events completely via a local static drop stub to prevent unredacted
  absolute 64-bit kernel virtual pointer immediate operands leakage.

- Parsing Invariants (Patch 4): Inject explicit array-end bounds
  validation check blocks before consuming trailing
  PERF_CONTEXT_USER_DEFERRED callchain cookies to completely eliminate
  out-of-bounds reads and parser desynchronization faults.

- Commit Records Alignment (Patch 4): Precisely clarify commit
  descriptions to reflect that zero-address metadata events are
  intentionally delegated to protect downstream trace tool processing
  backward compatibility.

- Telemetry Stabilization (Patch 5): Upgrade kernel space tracking
  workloads to utilize a dedicated system-call intensive VFS byte
  block loop workload (dd count=500) instead of purely userspace-bound
  tight loops, guaranteeing high-density kernel privilege state
  sampling streams and eliminating intermittent execution flakiness
  dropouts.

- Profile Retention Optimizer (Patch 6): Refactor sample processor to
  dynamically strip out ONLY register dump words out of sample
  payloads while shrinking output header sizes, overwriting ABI words
  to NONE, and scrubbing attributes up front. This completely rescues
  trace profiles from complete sample drop starvation, which happened
  by default on ARM64.

Ian Rogers (6):
  perf sched: Add missing mmap2 handler in timehist
  perf tool: Missing delegate_tool schedstat delegates and
    dont_split_sample_group
  perf maps: Add maps__mutate_mapping
  perf inject/aslr: Add aslr tool to remap/obfuscate virtual addresses
  perf test: Add inject ASLR test
  perf aslr: Strip sample registers

 tools/perf/builtin-inject.c           |   47 +-
 tools/perf/builtin-sched.c            |    1 +
 tools/perf/tests/shell/inject_aslr.sh |  511 ++++++++++++
 tools/perf/util/Build                 |    1 +
 tools/perf/util/aslr.c                | 1035 +++++++++++++++++++++++++
 tools/perf/util/aslr.h                |   10 +
 tools/perf/util/machine.c             |   32 +-
 tools/perf/util/maps.c                |   26 +
 tools/perf/util/maps.h                |    2 +
 tools/perf/util/symbol-elf.c          |   41 +-
 tools/perf/util/symbol.c              |   17 +-
 tools/perf/util/tool.c                |    6 +
 12 files changed, 1697 insertions(+), 32 deletions(-)
 create mode 100755 tools/perf/tests/shell/inject_aslr.sh
 create mode 100644 tools/perf/util/aslr.c
 create mode 100644 tools/perf/util/aslr.h

-- 
2.54.0.563.g4f69b47b94-goog

