Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85A63E008F
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 08:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178109; cv=none; b=XT2intgvRhid6iX2czISrsDAWRXNMchG+BxWJAYKvBv7+xs+hjkztojeJtayYh+QqzMHOcS7f5HFd02wK8dJCPXNMkwNvB3nARBzCRc0+7GuzO7FuiwzNXxDBHylKgO7KsI8Zk2l7D5Rcm+7t9hrg7TqCyjcqR4mSQ/3UOhEr6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178109; c=relaxed/simple;
	bh=+6gp8yfai+uxpqgcxeToB9CYrEFLyfpayL8J6jGIoFs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tp1Kgr6c8YbJwQcNPdILpkNaQYn6E/a5vDSn3c0GLnmjDpiEx+hywRKD0BEmJKqxQIB2ZidwWAm/xkbdDBYFEL9cWCgxmzcqrfFIIDpy56aIIji5cYKymN+VteCFNygGUcsUq64ZhWLciqGkqblPz4FTYshWFWzZm6FF6u9hGV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZagQf6gr; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZagQf6gr"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2f2d983d109so13964401eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 01:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779178107; x=1779782907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aPWyRtquvqWVelvytxhvKzZsaScKR5SEy0nS0buWW8A=;
        b=ZagQf6grVBkzanSpmDj7yKUDfqX3iDya6UFRyGR04+Ff8V6soHxCwZMxG1vZojM1zN
         1Yk342zxOJSDTXEBTsZ69gnoujc7ULOspAwAWUknD3zw4wbD4QR9ZwimepnAJm1FC1Z4
         lLuA9mF8yK0B08o/+Kl3U/8HNVAH0SnxfEuQ+59GQ8XCiBXyXZXxsINQML8s2SXbX0aJ
         onQtqREOTJdAsPce9Cgpg+goDV7gvOndbmMOlZu0W7pAj6ET2LPWV2FV6G6KTNrrvd5A
         p0xp9W+kF1kCTXdSlGHx8OBnCKp8/2snoXfSk3rpsGpS/moNdDcT+2LY4fdtK0sjjDpV
         shHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779178107; x=1779782907;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aPWyRtquvqWVelvytxhvKzZsaScKR5SEy0nS0buWW8A=;
        b=WCG6a6VvXWf+wg1cjeoiCntf+lR+wPj++DvKUbbIOFDCMDLnBSnpFYXiNM0s+7y5Cd
         FMj9s/hi/kSOx4vH+zoE/RjQu5Bq0hrOaE9sRni150DH6QsYbgWX7qVfkEYpcZwJrGkV
         bp2GTn20+8uuSaYLu19DD1ecw3D3VsmMkZH6PT4yNLTBZQyJlG5Ywih0sqMdhIWHq3ih
         XQimB+UOSNlywkd/GL8fQ6SdvF6Ydj6aOcaxxba6fK8a68i99uW6mCmXplI+FAWiAnix
         EArF4PoYzJMqanP1oLqYHf35mJWSzkBoVVbgB1RexpDXpCQXn6ZaXMdUutaPlPmjDgmp
         q56w==
X-Forwarded-Encrypted: i=1; AFNElJ+j3MvS+xBQuQiIxOFOrDaE9/Tm86ii0VbGAm6b/fVmH9a2mctLgkqN7zGjCZGJfqMOarnlqq1khRfFOZ3gVhdp@vger.kernel.org
X-Gm-Message-State: AOJu0YxtMw6NN+5tOGCEum4EbaPdsDuiNvCjxv9wCKzVuljzG9PSyXRS
	AHLN4yNvn+ef8+O4fDI01GYNfJZoryVHQnE8xptUioWDMkvRz89X01pyj5E0HSY+952RIytoPUT
	HZwK5AcLHpA==
X-Received: from dybvt10.prod.google.com ([2002:a05:7301:78ca:b0:2f9:60de:2717])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a145:b0:2d9:6373:ad22
 with SMTP id 5a478bee46e88-30398172c1emr8869709eec.12.1779178106908; Tue, 19
 May 2026 01:08:26 -0700 (PDT)
Date: Tue, 19 May 2026 01:08:20 -0700
In-Reply-To: <20260508082726.2795191-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508082726.2795191-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260519080824.3329601-1-irogers@google.com>
Subject: [PATCH v7 0/4] perf tools: Add inject --aslr feature, early maps
 loading, and decoupling fixes
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, james.clark@linaro.org, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, gmx@google.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch series introduces the new 'perf inject --aslr' feature to
remap virtual memory addresses or drop physical memory event leaks
when profile record data is shared between machines. Bundled with this
feature is a critical bug fix inside the core map tracking tool that
hardens perf session analysis against concurrent lookup data races.

Core Feature: 'perf inject --aslr' (Patches 2, 3, and 4)

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
uniquely index binary section frameworks, providing complete
collision safety against separate overlapping shared-invariant libraries
while remaining perfectly immune to boundary shifts or split
fragmentations.

To remain strictly conservative and guarantee security, the tool
scrubs breakpoint addresses (bp_addr) from all synthesized stream
headers, completely drops PERF_RECORD_TEXT_POKE events to prevent
absolute immediate pointer operands leaks, and drops unsupported
complex payloads (such as user register stacks, raw tracepoints, and
hardware AUX tracing frames).

Verification is reinforced in Patch 3 with a comprehensive POSIX shell
suite ('inject_aslr.sh'), hardened against SIGPIPE signal exits with
stream consuming awk loops and robust 'set -o pipefail'
assertions. The suite utilizes a highly dense, system-call intensive
VFS byte block loop workload (dd count=500) to guarantee deterministic
hardware timer interrupts sampling streams inside kernel privilege
states.

Prerequisite Bug Fix (Patch 1)

During development, a core map indexing issue was identified and
resolved to prevent concurrent lookup data races during session
analysis:

1. perf symbols: Patch 1 replaces old remove-reinsert map boundary
   update cycles with a high-performance, thread-safe transactional
   framework maps__mutate_mapping() that enforces write semaphore lock
   closures around all in-place virtual address mutations and sorting
   invalidations, completely closing concurrent lookup race condition
   windows. It explicitly executes DWARF address space cache
   invalidation (libdw__invalidate_dwfl()) to keep debugger unwinding
   frames perfectly synchronized.

Changes since v6:

- Concurrency & OOM Safety (Patch 2): Avoid deadlock by early kernel
  map loading. Cache original evsel configuration before modifying it.

- Test Spacing & Pipeline wrapping (Patch 3): Wrap long shell pipelines
  inside inject_aslr.sh and remove unused global data variables.

---

Verification Status:
The entire suite compiles 100% successfully and evaluates to 100% pure, flawless green operational success across all validation check scenarios:

Test basic ASLR remapping: [Success]
Test pipe mode ASLR remapping: [Success]
Test Callchain ASLR remapping: [Success]
Test perf report consistency: [Success]
Test pipe mode perf report consistency: [Success]
Test pipe output mode perf report consistency: [Success]
Test user register stripping: [Success]

Ian Rogers (4):
  perf maps: Add maps__mutate_mapping
  perf inject/aslr: Add aslr tool to remap/obfuscate virtual addresses
  perf test: Add inject ASLR test
  perf aslr: Strip sample registers

 tools/perf/builtin-inject.c           |  115 ++-
 tools/perf/tests/shell/inject_aslr.sh |  513 +++++++++++
 tools/perf/util/Build                 |    1 +
 tools/perf/util/aslr.c                | 1155 +++++++++++++++++++++++++
 tools/perf/util/aslr.h                |   38 +
 tools/perf/util/machine.c             |   32 +-
 tools/perf/util/maps.c                |   55 ++
 tools/perf/util/maps.h                |    3 +
 tools/perf/util/symbol-elf.c          |   41 +-
 tools/perf/util/symbol.c              |   17 +-
 10 files changed, 1938 insertions(+), 32 deletions(-)
 create mode 100755 tools/perf/tests/shell/inject_aslr.sh
 create mode 100644 tools/perf/util/aslr.c
 create mode 100644 tools/perf/util/aslr.h

-- 
2.54.0.631.ge1b05301d1-goog

