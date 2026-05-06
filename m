Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5DB17A31E
	for <linux-perf-users@vger.kernel.org>; Wed,  6 May 2026 00:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778028359; cv=none; b=DvhQV81Qsywakf+vlwojYxMRuPg2H4HYfFHAaALcvSp4cqCy9k03jC19yRgED6VgHC9fDRmDNsgp+X3f9Y6B6lOXwCFnfOkYl4sRLsUgUvjQuURzN3SmxqZ1YU7GjbEEL4nP+6Zrv/WvXIMKJGO8ZJlV6NAwtonWBr8YhKfIhKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778028359; c=relaxed/simple;
	bh=0KPI4hvXbu1xEMK7ccRV58LtQ26TzpwBKLo0sG6R1ss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gyhjQGQc7kibJePC+dHYovTQsSsnvihy4L0oQ3csCogwVgFap4vzXu2Fc/c+rhIDjRyrTQIuUJ0r1CSAyT5rzb3KXFAQTBfz/TO7HrwoadCKRwdRlgSt1W8AiR12zRTICp2x5dnIOpMMJLw/jdoDpioas1fOwaqOu8mYJ9Q8uko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MHGYTsSH; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MHGYTsSH"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-131371497a1so3745430c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 05 May 2026 17:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778028357; x=1778633157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JErR3lDOrpASLTyYbfw63GCeu20aTZI/VsDc1Aajn6E=;
        b=MHGYTsSHa/MyGAFmLfj61z3RCyzwQh2Im9j2BRJULPahIqarmZqH1i29gw5QTcD2lb
         bJEtvhKeo2pTHIxzSTqJMVd0jt67P/PjmZbgUjim/HW+80dMEybJspQAXM/E6TuGGolW
         Ui/bGz0irsUupTjomaNTaAShbPqLMHqNqkPNxAnhDPYSLMxEjFh6bYevhZEvN21gzF4l
         cwLxFJJnkzikKiLYXdsYiVv39drfXrGjrOl6u9rGFku601WoRcTusmJydKvcAAIdVSzh
         PFjwTJOTdVgbgkhSNbBOAh5hPVAdAXnwK3Q281RPsQySXC9rk83LAdJnE3wVG405xSTb
         keXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778028357; x=1778633157;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JErR3lDOrpASLTyYbfw63GCeu20aTZI/VsDc1Aajn6E=;
        b=fxJy5pDTTMuhApW71/P8lVOETLJ15przjsoJFPH/j+ePQ2KGXq6OKWrdIPUHFGWVGb
         Cb1UPJGWhxbVoecUCys+uKZ+HRKphiszM5FETk4o4HQpXRDbFWGrYYXray1uMAlwFjn6
         87asD0lE2VDJZv+bX86Jbj6Opn9rxQrhWEy8363zbEwLqN3gLqnrKrWNR+MNqu0SF/ot
         lVXZIPLY9L3uzDyyPW0Y2kQevt6JGPIavrEqZqVQdcvk0WvCGVhOJwhZs8PQhozBPHtH
         YInUP+gFACwGk4w1bYUH0ofQo3kHIdKkH8x/EYWvM9hM5p7d2kTirDri8+O5n6eFmlx9
         oQUQ==
X-Forwarded-Encrypted: i=1; AFNElJ9pVBtaMV1l5GJ1melqdeY+hRC95oLwxEtQCdkR3VCORXzucD5DVrSMOOthCLXWNqqyHct9fhcngcdg+5cE0gwR@vger.kernel.org
X-Gm-Message-State: AOJu0YxMejRjp2XYS0ROcL+LS77PXEiEZoRg/dcxyVnVPmL9WuLD8fC/
	nkuaUiiXRDmhKnUycrlzPeRnpvv/gMLApDO4wcPbqBj8goSbrb995f5Fstkrbe65E8X7IKA7+w0
	fXJCcDww45g==
X-Received: from dlbep12.prod.google.com ([2002:a05:7022:108c:b0:12d:c585:f600])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3d05:b0:11b:ec5f:1c37
 with SMTP id a92af1059eb24-1318e914d3dmr803839c88.18.1778028356454; Tue, 05
 May 2026 17:45:56 -0700 (PDT)
Date: Tue,  5 May 2026 17:45:41 -0700
In-Reply-To: <20260504072937.2103453-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504072937.2103453-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260506004546.3140141-1-irogers@google.com>
Subject: [PATCH v5 0/5] perf tools: Add inject --aslr feature and prerequisite
 robustness fixes
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, gmx@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch series introduces the new 'perf inject --aslr' feature to remap
virtual memory addresses or drop physical memory event leaks when profile
record data is shared between machines. Bundled with this feature are three
independent, critical bug fixes inside core event dispatching and map tracking
tools that harden perf session analysis against dynamic crashes and callchain
mapping failures.

Core Feature: 'perf inject --aslr' (Patches 4 and 5)

Transferring perf.data files across environments introduces a potential leak
of virtual address footprints, weakening Address Space Layout Randomization
(ASLR) on the originating machine. To mitigate this, we introduce the --aslr
flag into perf inject. Unknown or unhandled events are dropped conservatively,
while handled samples and branch loops undergo systematic virtual memory offset
obfuscation.

The ASLR tracking tool virtualizes process and machine namespaces using
'struct machines' to safely isolate host mappings from unprivileged KVM guest
address spaces. Memory space layouts are tracked globally per process context to
ensure linear, continuous space allocations across successive mapping runs.

To remain strictly conservative and guarantee security, the tool scrubs
breakpoint addresses (bp_addr) from all synthesized stream headers, and drops
unsupported complex payloads (such as user register stacks, raw tracepoints,
and hardware AUX tracing frames) to completely eliminate accidental address
leakage vectors.

Verification is reinforced in Patch 5 with a comprehensive POSIX shell
suite ('inject_aslr.sh'), hardened against SIGPIPE signal exits with stream
consuming awk loops and robust 'set -o pipefail' assertions. The suite includes
a dedicated scenario validating raw 'perf inject -o -' pipe stdout generation
attribute stability.

Prerequisite Bug Fixes (Patches 1, 2, and 3)

During development, three core event delegation and map indexing issues were
identified and resolved to prevent crashes and data-loss during analysis:

1. perf sched: 'timehist' registers standard MMAP, COMM, EXIT, and FORK stubs,
   but completely omitted registering MMAP2 callbacks. Because modern environments
   output maps primarily via MMAP2 frames, this caused timehist sessions to silently
   drop shared library mappings, causing dynamic callchain symbol resolutions to
   fail. Patch 1 corrects this by properly registering perf_event__process_mmap2.

2. perf tool: Patch 2 fixes missing copies of schedstat callbacks inside delegated
   wrapper tools (which caused segfaults on NULL stubs) and properly initializes/copies
   the 'dont_split_sample_group' grouping parameters to prevent stack garbage from 
   triggering silent non-leader events drops during split deliver streams.

3. perf symbols: Patch 3 resolves a deep structural map tracking desynchronization bug
   inside symbol-elf.c by re-engineering the map removal sequence order to run
   strictly BEFORE in-place virtual address mutations, preventing absolute binary
   searches (bsearch) from failing on misaligned cache array slots.

Changes since v4:
- Core Bug Fix: Introduce a new prerequisite standalone fix patch (Patch 3) that
  re-engineers map tracking removal sequence order inside symbol-elf.c to prevent
  corrupting binary search index arrays during in-place address mutations.
- Feature Core: Refactor aslr_tool__delete to cleanly clear host/guest maps and
  structures via machines__destroy_kernel_maps() to cure all destructor leaks.
- Feature Core: Integrate the 'first_kernel_mapping' state guard to protect
  kernel module file offsets (pgoff) from corruption, preventing dynamic
  symbolization resolutions dropouts.
- Feature Integration: Move breakpoint address (bp_addr) cleaning to the core
  session memory initialization startup level, natively securing both files and
  pipes while completely stripping away redundant runtime wrapper layers.
- Validation Suite: Harden grep-v filters with || true operators to protect pipelines
  from crashing under set -o pipefail on empty inputs.
- Style: Prune out and streamline commit log text clutter into concise high-level
  architectural summary overviews.

Ian Rogers (5):
  perf sched: Add missing mmap2 handler in timehist
  perf tool: Fix missing schedstat delegates and dont_split_sample_group
    in delegate_tool
  perf symbols: Fix map removal sequence inside
    dso__process_kernel_symbol()
  perf inject/aslr: Add aslr tool to remap/obfuscate virtual addresses
  perf test: Add inject ASLR test

 tools/perf/builtin-inject.c           |   31 +-
 tools/perf/builtin-sched.c            |    1 +
 tools/perf/tests/shell/inject_aslr.sh |  459 ++++++++++
 tools/perf/util/Build                 |    1 +
 tools/perf/util/aslr.c                | 1220 +++++++++++++++++++++++++
 tools/perf/util/aslr.h                |   10 +
 tools/perf/util/symbol-elf.c          |   21 +-
 tools/perf/util/tool.c                |    6 +
 8 files changed, 1743 insertions(+), 6 deletions(-)
 create mode 100755 tools/perf/tests/shell/inject_aslr.sh
 create mode 100644 tools/perf/util/aslr.c
 create mode 100644 tools/perf/util/aslr.h

-- 
2.54.0.545.g6539524ca2-goog

