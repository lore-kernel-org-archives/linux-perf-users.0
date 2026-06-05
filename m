Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407D2212566
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 06:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780639578; cv=none; b=hqgPjz+WsMYXeesTmuBg+Hg3h7lV6xHRl14j8teSyDCz+maqHCylTA7m5BvfwSbC8dihLvCwhhjuhTzf+yP+6FpNn7vIWY4vXwoLad7UB81f8Kx6N3kF3fG2u1z2+ndy4TX4oUrN+yR4doXJH4QVm9AcfYbxOAsGR4wu9AskMeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780639578; c=relaxed/simple;
	bh=YmRJYa9tnV9W/p/d/fVpaKsqWaOWw+VYRIkEOl1kXao=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jz4L3btdjxNAbw7B4tIkW9gi0UzM9mz8EethOCZiF+X9PsHq97HePAFEzPi8YcScfS4FjFWQrb4zru8G15H5iAXjKuQxyJc2zR7DbHPfuKRUC6kKzKw5I6Fd8UKLFAveE8vof87vlCZha9exxN9sT63bVB1Y6j0D+j1DJlYHeR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B4Q9ID3y; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B4Q9ID3y"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-3074d4102a9so1284637eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Jun 2026 23:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780639576; x=1781244376; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RLDzqoAhJHGWy0IaWlTQOPcDKqvuE8yyG/YnkFaABUY=;
        b=B4Q9ID3yJe4oywKyOE2XsE6hw8KLHg+GKs+caCD9mOF6atWdx8G9gtwzyRcheGP4xB
         OHjqtR/XNMSsi3pzh1/PQaayigBh6QwbVSAvLFEt6T/0DHZrX7sxemyQpXEKr60SiVAU
         9Xq+JqcmL2aox3tQ4e1C8zf9y8KvqfaB5vVBSKeFyFdLW/7a/mkqwj4oGkuU8/4LRf0t
         b/eUdcfJ5knYooVQbZx4ezxAtRBCRyRHRRgFtOAVjxDvlURXpdKQzp9Fjp61Qp9R64eX
         UpG669wiA6Fbj2J5Fpw7cqF7FB42BgPK1aL48LA6T1l4Zmg/n6Uzvpx6H/HFdgwmfxu0
         RsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780639576; x=1781244376;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RLDzqoAhJHGWy0IaWlTQOPcDKqvuE8yyG/YnkFaABUY=;
        b=OjSoKQX7XeFYrUOdVTq8pQ5zBvYXBh6Xjj/VQ7lL7A+hnyHIqjMstQVznyZ6q0OGiN
         I2kzGiOL8YAEd57UfS4Au2owe9Mp/yuTrEzIICMMqDFxLhBcgKhLrRS77qlXaRE5g5fH
         meuAzdxKtwGgjLYzTWCC3BRbP/Hi1cd1sttVcid5haI8p15IyNSsWTYWkbXYWHgYy9Q4
         56pNfVvJN4G7G4uinbZfKeFcl/tPYoXGENoil+/mO65hhJI7GWMzgH7fx3LZEmfUeGgk
         uFoLI/Yp5qucO+ocmJD+xVhcHRamRPPPAC4UulEmSYJcD5yUuKyIrKRMIsHbdgypPJE8
         YXdA==
X-Forwarded-Encrypted: i=1; AFNElJ/QT8hnZdvcbS3/tUYY9wf6dfdx0aApvHpDGuiQU0giwd+jWMqrhXiNRKROzOloqSEOXekBaYWchEtmCnKDGp+V@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzn9Ul+k7FD5b/7Kev7Q1wUr+rOgVejwgZp7b4a9ZF8bX86Lw7
	tyVOFkVbkXgsixdEyIcn4krGsb1zrCO/GmxEnR86C3ZuvwVC3dj10roeV2CyroxjIfx5OQk6F9+
	tPPibJZKpdA==
X-Received: from dybir8.prod.google.com ([2002:a05:7300:c8c8:b0:304:ebf6:da3b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2c01:b0:304:ba84:a0cc
 with SMTP id 5a478bee46e88-3077b33261cmr1087398eec.33.1780639576052; Thu, 04
 Jun 2026 23:06:16 -0700 (PDT)
Date: Thu,  4 Jun 2026 23:06:05 -0700
In-Reply-To: <20260604172850.683329-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604172850.683329-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605060610.1529996-1-irogers@google.com>
Subject: [PATCH v10 0/5] perf tools: Add inject --aslr feature, early maps
 loading, and decoupling fixes
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, gmx@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch series introduces the new 'perf inject --aslr' feature to
remap virtual memory addresses or drop physical memory event leaks
when profile record data is shared between machines. Bundled with this
feature is a bug fix inside the core map tracking tool that hardens
perf session analysis against concurrent lookup data races.

Detailed Mechanism of MMAP Mapping and ASLR virtual Address Allocation:

The ASLR tool virtualizes the address space of the recorded processes by
intercepting MMAP and MMAP2 events to build a consistent translation
database, which is subsequently used to rewrite sample addresses.

It maintains two primary lookup databases using hash maps:
1. 'remap_addresses': Maps an original mapping key to its new remapped
   base address. The key uses topological invariant coordinates:
   (machine, dso, invariant). The invariant is computed as (start - pgoff)
   for DSO-backed mappings. This invariant remains constant even when
   perf's internal overlap-resolution splits a VMA into fragmented
   pieces, ensuring split maps resolve consistently back to the same
   remapped base.
2. 'top_addresses': Tracks the allocation state per process (machine, pid).
   It maintains 'remapped_max' (the highest allocated address in the
   virtualized space) and 'orig_last_end' (the end address of the last
   processed original mapping).

For each MMAP/MMAP2 event:
- We look up the DSO and invariant key in 'remap_addresses'. If found, we
  reuse the translation, preserving the offset within the mapping.
- If not found, we allocate a new remapped address space:
  - If the new mapping is contiguous to the previous one in the original
    address space (start == orig_last_end), we place it contiguously in
    the remapped space. This is critical to preserve the contiguity of
    mappings for downstream merging (e.g. symbols split by HugeTLB, or
    anonymous .bss segments adjacent to initialized data).
  - If not contiguous, we insert a 1-page gap (using page_size) from the
    previous maximum allocated address to prevent accidental merging of
    unrelated VMAs.
- The event's start address (and pgoff for kernel maps) is rewritten,
  and the event is delegated to the output writer.

To remain strictly conservative and guarantee security, the tool
scrubs breakpoint addresses (bp_addr) from all synthesized stream
headers, completely drops PERF_RECORD_TEXT_POKE events to prevent
absolute immediate pointer operands leaks, and drops unsupported
complex payloads (such as user register stacks, raw tracepoints, and
hardware AUX tracing frames).

Verification is reinforced with shell test ('inject_aslr.sh').

Prerequisite Bug Fix (Patch 1). During development, a core map
indexing issue was identified and resolved to prevent concurrent
lookup data races during session analysis.

Changes since v9:
- Patch 1: Added `-ENOMEM` error check inside
  `maps__find_symbol_by_name()` and return `NULL` early. Added map
  sorting state invalidation on early return in `maps__load_maps()`.
- Patch 2: Fixed encapsulation by using `thread__maps()` and
  `thread__pid()` accessors in `aslr_tool__findnew_mapping()`. Added
  `pr_warning_once` warning when raw auxtrace data is dropped.
- Patch 3: Fixed encapsulation by using `thread__maps()` and
  `thread__pid()` accessors in `aslr_tool__remap_address()`. Wrapped
  `evsel__parse_sample()` to temporarily disable `needs_swap` to avoid
  branch stack endianness corruption on cross-endian files. Fixed ISO
  C90 warning for declaration-after-statement for `orig_needs_swap`.
- Patch 4: Fixed duplicate cleanup by explicitly removing trap
  handlers (`trap - EXIT TERM INT`) inside the `cleanup()` function.
- Patch 5: Fixed heap corruption by adding size bounds checking before
  writing to `sample_regs_user` and `sample_regs_intr` fields. Added
  missing register mask clearing logic for the `itrace` synthesis path
  of `perf_event__repipe_attr()`.

Ian Rogers (5):
  perf maps: Add maps__mutate_mapping
  perf inject/aslr: Add ASLR tool infrastructure and MMAP tracking
  perf inject/aslr: Implement sample address remapping
  perf test: Add inject ASLR test
  perf aslr: Strip sample registers

 tools/perf/builtin-inject.c           |   79 +-
 tools/perf/tests/shell/inject_aslr.sh |  518 ++++++++++
 tools/perf/util/Build                 |    1 +
 tools/perf/util/aslr.c                | 1269 +++++++++++++++++++++++++
 tools/perf/util/aslr.h                |   41 +
 tools/perf/util/machine.c             |   32 +-
 tools/perf/util/maps.c                |   80 ++
 tools/perf/util/maps.h                |    3 +
 tools/perf/util/symbol-elf.c          |   41 +-
 tools/perf/util/symbol.c              |   17 +-
 10 files changed, 2048 insertions(+), 33 deletions(-)
 create mode 100755 tools/perf/tests/shell/inject_aslr.sh
 create mode 100644 tools/perf/util/aslr.c
 create mode 100644 tools/perf/util/aslr.h

-- 
2.54.0.1032.g2f8565e1d1-goog

