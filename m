Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971B41A9FA4
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 06:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779258661; cv=none; b=okxBcIYnoBFlLHJyHj26PNVVpBmiYGfCapSmuGLX/Acx2HtjADCZmNOYcj44WdQzr+GEkbH1rRMfkyMW+B9c8MjVYhoyHQZKAZj1WoSyep8NE6KenRjX/wf98qfeglWjnrbENyC1C3SKkkkSyBZtITfyeXrKPW1yRspC9Mm9Fio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779258661; c=relaxed/simple;
	bh=uIgPVaoRzXn4rjTxPgt6yydiFuM6CBHOPfEjsGqtSZI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WaknJ6EXdV0XxrB9Nr/nM26QcEXiX6Oy0MP7FP8U1QX1y96sQO8VtzDd+wPoqpOIXWIegyn6qjjKrksI0XjA3nUoIYnO0LoOliymsn+LHhnaEmqSuswbq+3n6dLd5vKO/ocZQ4g2DkNtX4VuVp924z6XoguR7xMagnBqBKYY/0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cwk0AGBk; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cwk0AGBk"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bda35eab74so3567904eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 23:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779258659; x=1779863459; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ADZqVfKYmfcuXk1IE4jPKRKAaJCXE0RU0cvNEROx66M=;
        b=cwk0AGBkea9qai2BixDRvQnli9XvYEqzr+mrYaeqv8LHNrEqlFgkEBPyH6dM9eHWm9
         J/KMc+wcSUDsoczx6ecuO0QsS5MpOu9lHP3VnO4Yd8QhtpdGogIdBEy8d1bX+E8/XMNd
         LWZFR9uad2hoYSRLB0gw8mqtVzcbF8IpAaFENBG9Na/frsfdDu0jiC2ViV/uhxBpCgD9
         oL4ReQiKWL7Qc1ffFT2lEc4N4I5xipPL1dmV9s+XTFJHxW8al3NLSWPg+oNi1+pEPsdr
         DssTJAYtjPjCynW5poq/JGZdTKOnUrF2js0dBcB5wUiDvV5+Z0e2T9Z4Sm70iBz4rKI4
         EqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779258659; x=1779863459;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ADZqVfKYmfcuXk1IE4jPKRKAaJCXE0RU0cvNEROx66M=;
        b=NVgr6qGtFe2U1l0n/6zX41sWTdR3q+kF6U8T6AjyhMjNQDLOrV2qnClFRMl4GIJDRA
         kFGNvyCFDk9jtQThgJ7IWItMNHPeczZyOT6XIOZ8JMf6H/7xnFCJYk80FiQNs2XXuRx7
         0MyK+1CfzZ3ae1RemH6si/Zb1oeUkn/c1IUPW3k/jgt0QbfVZTVI5cNYVkCFr5lDwDoX
         K0NgIQOX0bB0T0CrJyYWWwboWJfw7ZEhom1r+vCtrBCj3RW5ONSRXln8KX/kN9HmGnDU
         SmQz6za9DQ7/JVY7oIC8JsSfwVJPVc7BzLASFRXqjJjmjuxg03nBNqGeFL70sysSJDNM
         MclQ==
X-Forwarded-Encrypted: i=1; AFNElJ82bodbTzIA6Bcp1+cHibkxoKppCzt1ABmKa8QWoWMWLBQ/UgsSXWTr0BLzNxWJgHYtO3LDeDtgCFYWEKP0+nj+@vger.kernel.org
X-Gm-Message-State: AOJu0YwOgjcQts6uvI1q+LEokak5VPo+Vu61mqUBAHHBwgwSieYPgrh8
	ezdOn2ktx3PsGS+Z/dwBgeKFL08CmNDiOXU5y62kUI4i1VyCWm0oHKkT/r61c13DrIv5Lrp+xQz
	tUs5JY406hA==
X-Received: from dybor14.prod.google.com ([2002:a05:7301:1f0e:b0:2f2:fc0:8869])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2c8c:b0:2c0:df3b:ec1e
 with SMTP id 5a478bee46e88-3026188af43mr11215173eec.11.1779258658423; Tue, 19
 May 2026 23:30:58 -0700 (PDT)
Date: Tue, 19 May 2026 23:30:46 -0700
In-Reply-To: <20260519080824.3329601-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519080824.3329601-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260520063050.3917261-1-irogers@google.com>
Subject: [PATCH v8 0/4] perf tools: Add inject --aslr feature, early maps
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

Changes since v7:

- Minor nits cleaned up.

- Concurrency & Locking (Patch 1): Add a detailed doc comment block
  above maps__mutate_mapping() documenting the recursive down_write()
  deadlock risk during lazy symbol loading. Harden maps__load_maps() to
  return immediately when nr_maps == 0, avoiding spurious -ENOMEM
  returns.

- Deadlock-Free Preloading (Patch 2): Replace upfront preloading with
  dynamic, discovery-driven preloading of host and guest kernel/module
  maps using machine->priv tracking in util/aslr.c, completely
  bypassing lazy symbol loading deadlock risks during event loops.

- Symbol Offset Preservation (Patch 2): Fix the address translation
  offset truncation bug inside aslr_tool__findnew_mapping() to perfectly
  preserve the internal symbol address offset relative to map__start(),
  fully resolving relocation symbol truncations.

- Trace Ingestion Decoupling (Patch 4): Decouple attributes stripping
  from trace ingestion parsing. Keep evsel->core.attr completely
  unmodified in-memory during ingestion, and apply format stripping
  dynamically inside pipe repiping and post-processing file header
  serialization. Implement temporary sample size and attributes overrides
  inside aslr_tool__process_sample() to safely parse repacked events
  via evsel__parse_sample().

Ian Rogers (4):
  perf maps: Add maps__mutate_mapping
  perf inject/aslr: Add aslr tool to remap/obfuscate virtual addresses
  perf test: Add inject ASLR test
  perf aslr: Strip sample registers

 tools/perf/builtin-inject.c           |   70 +-
 tools/perf/tests/shell/inject_aslr.sh |  518 ++++++++++
 tools/perf/util/Build                 |    1 +
 tools/perf/util/aslr.c                | 1248 +++++++++++++++++++++++++
 tools/perf/util/aslr.h                |   38 +
 tools/perf/util/machine.c             |   32 +-
 tools/perf/util/maps.c                |   76 ++
 tools/perf/util/maps.h                |    3 +
 tools/perf/util/symbol-elf.c          |   41 +-
 tools/perf/util/symbol.c              |   17 +-
 10 files changed, 2012 insertions(+), 32 deletions(-)
 create mode 100755 tools/perf/tests/shell/inject_aslr.sh
 create mode 100644 tools/perf/util/aslr.c
 create mode 100644 tools/perf/util/aslr.h

-- 
2.54.0.631.ge1b05301d1-goog

