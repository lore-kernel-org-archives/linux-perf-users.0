Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ED1277029
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777879801; cv=none; b=kPl2DiVIoCPNr/Bb8yrXiKQufV/eiqLbdsuFhraOBo+xU17Hi+ezI3OkbMnZyCqOvrNBtNOTNrGm8e+ATw8ikGd1EGs/L1fqNd+DKtLGJKXSF4vETyRR7uKdBdNQfs4bEOQ9CdPQIPD5YdrGdZuyS3K3SwUpqDupR+RnQjlBMUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777879801; c=relaxed/simple;
	bh=swcwIM33MHiXaGvwNY27uwlffr4tzLlRKzZ3o82SPDM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Igyx0AkgjZcN3uLEbuGTB+F6PBKRdtxMc5pziKB1rDnCMi/fBHR78PO7nUMz01e67GSRghEMfqd6XGRt5c3oiwRFkRrfWpAW0IMx2kuOhXncaII3X2VOEs3y1nAQNT1I56z87qujf5SRkN7wJIfr+7jRdaZrCroatzq00ddF1oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U3tC6dBf; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U3tC6dBf"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12db37213daso3361510c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 04 May 2026 00:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777879799; x=1778484599; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4uAoFqZ+0tIFsYmFHwu39o/6D5JThe4QGEhKyOADF78=;
        b=U3tC6dBfZzg8BjDttGoNohVdNDArb+nrIhVcdhLK8ipI6Z6VquXObeXx8MduhEWY74
         yVSjSuxvj+dV1BMB8gPbPWUAsrz24X7Nz41k/fW1Q2/6ynH5bxcSf/mfZuYpll8kAopE
         QJFyT8+QLN59YEU7jPwJtoxFwn9nnTutZ91FbcTnmKUlI6USm+zBHOHc8K4Vd7iN1EVo
         pMXdFW6wh9SLl/mwZG81f7r/VG23FOzRVokRVIUSAvNzKDS3Gis9GCHYCQaZK8yxNYbd
         abcmlL+X0iPm329MCaXnXtb4TYA4dbXgjTQFAiaUjviAe50B1k0nlzDgXscISngfwbH8
         Jv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777879799; x=1778484599;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4uAoFqZ+0tIFsYmFHwu39o/6D5JThe4QGEhKyOADF78=;
        b=kBXmR0Wl/a9QdIuOG+Vnx1R3w9A2ZpTSbMekiMRfvl/5toaOwQ5DSvtjHJ3lQLQm+/
         XtbO6w+N9BMTWDcYWWy9RT7HJy8ohf1PZ7nW+jhAbOO6XBwHL1CDQKGYYkrUHyqbviex
         TsQpYkUwsE1Qiqqv/pnWwNlymietboKR40Wq16H1pJ8CF/71BTSol4PMmLUPN1J2GbbO
         DwPj9BT/YH8PnUFSM0ZJNZfWBjbNmMXAFQYhVTz9u6u0Lk6/GtkWiPBcytZTtNKMLk5k
         rUVorVFWe7f1h1Cs/ek913mQm06QwwNTINa18cCYurPCv5k2oHYKvALFAcmdOF0Rt2Za
         6hhQ==
X-Forwarded-Encrypted: i=1; AFNElJ/n34y7tiEpY1XYTclIgRTUPf51F+dt+Hj0Gni23NO3gsRgBuTz9PV0UXxIvKf4yvB7AaldeOyrmWjiw7MRdcck@vger.kernel.org
X-Gm-Message-State: AOJu0YxBPIEP3la/trQR597Znb4sfLhu85dFWrb3kLqez3WBKU49D17X
	2l+in0aNcN87P2r/LblpEctLmkcS/3QzYjPvSaPnwL9FytYKCYa4IJd2awevZMzWkm2OStEIRG7
	aYpbqV0UVkg==
X-Received: from dlii2.prod.google.com ([2002:a05:7022:4182:b0:12d:b65b:1fb3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:698a:b0:11b:9b9f:426b
 with SMTP id a92af1059eb24-12dfd82f255mr4549852c88.20.1777879798807; Mon, 04
 May 2026 00:29:58 -0700 (PDT)
Date: Mon,  4 May 2026 00:29:33 -0700
In-Reply-To: <20260504035125.1851720-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504035125.1851720-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504072937.2103453-1-irogers@google.com>
Subject: [PATCH v4 0/4] perf tools: Add inject --aslr feature and prerequisite
 robustness fixes
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, gmx@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series introduces the new 'perf inject --aslr' feature to remap
virtual memory addresses or drop physical memory event leaks when profile
record data is shared between machines. Bundled with this feature are two
independent, critical bug fixes inside core event dispatching tools that
harden perf session analysis against dynamic crashes and callchain mapping
failures.

Core Feature: 'perf inject --aslr' (Patches 3 and 4)

Transferring perf.data files across environments introduces a potential leak
of virtual address footprints, weakening Address Space Layout Randomization
(ASLR) on the originating machine. To mitigate this, we introduce the --aslr
flag into perf inject. Unknown or unhandled events are dropped conservatively,
while handled samples and branch loops undergo systematic virtual memory offset
obfuscation.

To ensure comprehensive memory and error-path safety, the ASLR tool implements:
- Machine namespaces ('struct machines') to safely interleave host mappings and
  unprivileged KVM guest virtual address mappings.
- Resolves VMA split map failures (caused by overlap fixups during map
  insertions) consistently by anchoring mappings on DSO and memory
  invariants.
- Guards against integer overflows in branch stack loops via
  subtraction-based bounds arithmetic.
- Prevents heap buffer overflows by computing safe word limits on
  userspace stacks and dynamic hardware tracing (AUX) sizes.
- Prevents key collisions/ABA lookups by correctly managing DSO
  reference counts (dso__get/put).
- Cleans up error paths to avoid inconsistent hashmap mappings on
  OOM failures.
- Optimizes performance by removing redundant hot-path memory
  allocations.
- Cleanly advances session readers past dropped auxtrace streams
  using pipe-stream I/O skip helpers.
- Scrubs breakpoint addresses (bp_addr) from output event headers
  and dynamically synthesized events for pipes via a custom pipe
  repipe wrapper to prevent unscrubbed address leakage.
- Remaps kernel memory maps linearly to maintain secure base
  obfuscation bounds.
- Hardens guest cpumode lookups against corrupting host/guest user and
  kernel mapping boundaries during sample fallback searches.
- Synchronizes ksymbol map tracking invariants using precise VMA
  offset math rather than raw addresses to prevent unique base leaks
  on every function symbol.
- Blocks trailing heap padding byte data leakage vectors in userspace
  stacks and AUX tracking frames via targeted tail-word clearing.

Verification is reinforced in Patch 4 with a new comprehensive POSIX shell
suite ('inject_aslr.sh'), hardened against SIGPIPE signal exits with stream
consuming awk loops and robust 'set -o pipefail' assertions. The suite includes
a new dedicated scenario validating pipe stdout injection attribute stability.

Prerequisite Bug Fixes (Patches 1 and 2)

During development, two core event delegation issues were identified and
resolved to prevent crashes and data-loss during analysis:

1. perf sched: 'timehist' registers standard MMAP, COMM, EXIT, and FORK stubs,
   but completely omitted registering MMAP2 callbacks. Because modern environments
   output maps primarily via MMAP2 frames, this caused timehist sessions to silently
   drop shared library mappings, causing dynamic callchain symbol resolutions to
   fail. Patch 1 corrects this by properly registering perf_event__process_mmap2.

2. perf tool: Patch 2 fixes missing copies of schedstat callbacks inside delegated
   wrapper tools (which caused segfaults on NULL stubs) and properly initializes/copies
   the 'dont_split_sample_group' grouping parameters to prevent stack garbage from 
   triggering silent non-leader events drops during split deliver streams.

Changes since v3:
- Feature integration: Pass a dedicated 'perf_event__aslr_repipe' callback to
  perf_event__synthesize_for_pipe() to scrub synthesized breakpoint attributes.
- Feature core: Loop through and scrub event evlist breakpoint attributes right
  before writing file headers in __cmd_inject().
- Feature core: Linearize kernel map base obfuscation and remove redundant pgoff
  delta adjustments that leaked kernel layout calculations.
- Feature core: Fix host/guest cpumode mappings in sample fallback lookups.
- Feature core: Sync ksymbol tracking keys onto VMA offset invariants.
- Feature core: Zero out trailing padding word bytes in user stacks and AUX blocks.
- Validation suite: Add 'test_pipe_out_report_aslr' validation case.
- Validation suite: Upgrade kernel report checks to strict sorted line-by-line diffs.
- Style: Wrap all commit description lines to under 75 columns and fix code formatting.

Ian Rogers (4):
  perf sched: Add missing mmap2 handler in timehist
  perf tool: Fix missing schedstat delegates and dont_split_sample_group
    in delegate_tool
  perf inject/aslr: Add aslr tool to remap/obfuscate virtual addresses
  perf test: Add inject ASLR test

 tools/perf/builtin-inject.c           |   52 +-
 tools/perf/builtin-sched.c            |    1 +
 tools/perf/tests/shell/inject_aslr.sh |  459 ++++++++++
 tools/perf/util/Build                 |    1 +
 tools/perf/util/aslr.c                | 1161 +++++++++++++++++++++++++
 tools/perf/util/aslr.h                |   10 +
 tools/perf/util/tool.c                |    6 +
 7 files changed, 1689 insertions(+), 1 deletion(-)
 create mode 100755 tools/perf/tests/shell/inject_aslr.sh
 create mode 100644 tools/perf/util/aslr.c
 create mode 100644 tools/perf/util/aslr.h

-- 
2.54.0.545.g6539524ca2-goog

