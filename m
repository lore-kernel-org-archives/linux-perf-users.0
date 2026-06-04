Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA20492528
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780594139; cv=none; b=neofAiA23c+ecsQkRVtq2mg7IVCRghxWe5W8NcdkWepKxxsacLJLzPJzISWBYnixio7QZSp/rmwV/8rFAPV0IKwACNhZCJ/Q5bUamKPXCrqNE/T3d35vOvjeWEkLcUBO5z9hKcTmkz8ze/H2Utu3ra0nuOHkYKCvcHJsY/gbDDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780594139; c=relaxed/simple;
	bh=H++s7WLFe3DQ1BShKSqXE5ikoMf2nKAOEt0v4XNUQ4U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yw1KLjOAbrwtg8pPmJ/0btlK1jSVQ/cIVnS2IsTKTjfCPVt/7csO8CNIR45gBDHinnSOnnPkdVUopamPBbGnYbrOY78ZvpUVToZ6G95wgHW+mfSQVNPWSH38oKTMW/xCEHVFcnYot7SjKewvOCn7WFZM9/iJrOkBAxxdxoRrjbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qB2yPxCG; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qB2yPxCG"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137eff27f36so1158158c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Jun 2026 10:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780594137; x=1781198937; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Al06XNj3tj8u0HWjKM9JzhjoiNy4HbLAt6wKTFMpfPc=;
        b=qB2yPxCGYnkjerUZYF++SuBH+nwIP4EfJbBDYztLUOnM+9wPEneHfjC8gSOcMrL3WD
         O8fUZKkaVA/AzHtFI8ebm5qtskZqa2RXWsbza8vvYmBd2BIGn9OCPHbDix5IOv2VY63w
         JP3zFIcCAtAou9KGv/ZGVVGRuYiN9lqQJAVsmWABX3CZX/9VKHQzlsS5mbRpy4o5VrMy
         hhUWghVl1YGwdAjgp9b9wp18EU3VE0I09OM8lfoJEQuBVGqKDgSPJ166rqgpLaJuQCPk
         zHz73fy1pP0VczwGsNyfbFRVbmV4SywXTRcjJrT40n7Yj8pLB3LI6ViBxXAfK7wgzEd3
         S/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780594137; x=1781198937;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Al06XNj3tj8u0HWjKM9JzhjoiNy4HbLAt6wKTFMpfPc=;
        b=EAMOgZWtjsEkvP56A1OjMqNVBP6S6QUpJNnLM0JBypfQdOVXN5QGAJpY4EGynI/sc6
         /dHnCH6/G1gK3p5ToNsKrSKuRXnZEpPry7gggPIkTX8crtqqk9sM65OmWtCCjz4oE7NJ
         FfKgcNriwdVUwPrZoUsQV5uf+Ebq1sms687luecnpGq0YzIrGZh0j/srF9zOmnvKsFfP
         GaQdw0Uve8pCSqxursHnD/s/hegHamZIVIxnRQE+GBR0UsBSCYRIqhrP9oLNWYKRfFma
         FlyvVp8CeQmDouki+4U0GqUwLVG69jlznHPq8LPIp+LLS1ih5ukMD/fWp1PbNlnc59PC
         3Mxw==
X-Forwarded-Encrypted: i=1; AFNElJ80Nx1KW1nNffWYtjwifls7xes7Kfzlyx2W4idWWBJ0ftczLhtWWZsIVG7sCgd3W+aKrNjajH/5TgxII81Lfm2a@vger.kernel.org
X-Gm-Message-State: AOJu0YzRU3gyBu+G32w5GFwzeqlJ13USz/e10RN6QcBFGUh8xfCr2ryI
	/pvnzlWn0vAqfMzUxOwPdqtH2qHu/F/LKsAC7m+0Ww1E/X0jbkRwbJm0Q9/jrroe3Y2HXahC5+u
	3BdLYQvUOng==
X-Received: from dlbep4.prod.google.com ([2002:a05:7022:1084:b0:132:d312:88dc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:271c:b0:134:ff2e:a71c
 with SMTP id a92af1059eb24-13806684f0amr16635c88.9.1780594136401; Thu, 04 Jun
 2026 10:28:56 -0700 (PDT)
Date: Thu,  4 Jun 2026 10:28:45 -0700
In-Reply-To: <20260520063050.3917261-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260520063050.3917261-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604172850.683329-1-irogers@google.com>
Subject: [PATCH v9 0/5] perf tools: Add inject --aslr feature, early maps
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
   base address. The key uses a topological invariant coordinates:
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

Changes since v8:

- Split the large "Add aslr tool" commit into two patches:
  - Patch 2: Add ASLR tool infrastructure and MMAP tracking
  - Patch 3: Implement sample address remapping
- Address Sashiko and internal feedback.


Ian Rogers (5):
  perf maps: Add maps__mutate_mapping
  perf inject/aslr: Add ASLR tool infrastructure and MMAP tracking
  perf inject/aslr: Implement sample address remapping
  perf test: Add inject ASLR test
  perf aslr: Strip sample registers

 tools/perf/builtin-inject.c           |   70 +-
 tools/perf/tests/shell/inject_aslr.sh |  517 ++++++++++
 tools/perf/util/Build                 |    1 +
 tools/perf/util/aslr.c                | 1263 +++++++++++++++++++++++++
 tools/perf/util/aslr.h                |   41 +
 tools/perf/util/machine.c             |   32 +-
 tools/perf/util/maps.c                |   77 ++
 tools/perf/util/maps.h                |    3 +
 tools/perf/util/symbol-elf.c          |   41 +-
 tools/perf/util/symbol.c              |   17 +-
 10 files changed, 2029 insertions(+), 33 deletions(-)
 create mode 100755 tools/perf/tests/shell/inject_aslr.sh
 create mode 100644 tools/perf/util/aslr.c
 create mode 100644 tools/perf/util/aslr.h

-- 
2.54.0.1032.g2f8565e1d1-goog

