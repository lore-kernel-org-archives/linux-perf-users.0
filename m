Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6571EEE6
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 02:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781319317; cv=pass; b=NAfqeo+wvukcOc8qBvkmOuMuxoQLQAIYYH9iqux7Hfp/Vd10rwFmmqayvoMzqGN4VFcSjFvAs4C+ktiIHY1+QfpHnu47PO939fJODC08OyY+Opc3CoPRqxtPVd/PgEAzt1BOCDDUB5sVBQtcRv+z8F1qaeI8J0l6VRpmxnAMdMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781319317; c=relaxed/simple;
	bh=ad3SbjGCaa31bvl9sG5xb6UWIq32p/V+RgfAfCgZCDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZCs2smexNFtunZfVMTeAldVLt56OTWZCtBMEU1Y0UB+OwAmcNbwuE3NEAQaPL8yqK+PljxvTc8h0zGW8mNtLXAb+uJcp2pzNo9j7SIPrIm6jO9pXJek/IOV+YgHPKer9i1w3UQKTPDr3y0CUuHX5FRKDjIeDqtRGzgKthxOFC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aOSlgFXf; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aOSlgFXf"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf22c18ad3so45325ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 19:55:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781319315; cv=none;
        d=google.com; s=arc-20240605;
        b=FbGZT6UzmQHdXKAbsHXnwxSqxdsons9EMq1U+CfYNRBrOIUTcgpQF2p02dXIc2Kdpr
         ygfiyhg1iygwT6F2ugAz5VwH7g07sq6AGbSpZNd/siPQ1PVpeWHxMvjADPmUMqUcmQ6v
         Qp40ltztIKNuVUJqi7EME0Wes1C84TXU8FmhWyGmcPW5imJi2EwxiotlneI1glYT6YWU
         ia99NiYxBLtLQDt9v5PvOYtEVqzWK1GVw6KuyikDPqCrIVeSQbC0v0hfJ9Nekn+wOlqd
         2gBtvss3mTQJNSkOOrBmtejJrc1i77HTuEA5M2Vtm0b5eWQYUBfTyLRD9ErHgbtbzMU7
         VP9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/rTx5TMw6ALulkVOK2k/68wHu3vnZZH9YmR3AgZW1iQ=;
        fh=XL9MLvmLxsMqRFVda7XZ79K/NI67XTIZ/A/1pCTvdo0=;
        b=GqpQIhWQ/6WH8obNRf4NlDHAlPNE5gCykOacFNRNjHEnVfBonfzp1ejMtMDvfijevQ
         U3v4b/lhVjMu8u7ZRrmDlFHImJHSFnFwnVhhGBOOR3jclDKGicxmem6tmi3M5WAZN2LH
         2tQ/w0ahYruARNpCFtbFiMwgsGJ7JjY9IWOlke57Xp2KRKJ74c8jxBoVoGu9spZpAPL1
         qt6Ka2fiEHkJc2QqjsazFGtguueaiz6WaVyf+GAQgLqHybh3H0JnKEmreVMEHSHNa6gD
         BLQwMrmM8mbaRhJneUdSSvVkxKbTNxR6TXWPiK/lXH8CY7kzur48koKxzAP/alI4CmCo
         Br2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781319315; x=1781924115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rTx5TMw6ALulkVOK2k/68wHu3vnZZH9YmR3AgZW1iQ=;
        b=aOSlgFXf8+F5pG61PatB1qhKgEWstYxBofyVb9PvqFkRsaDqLFlDk9Fvw0+53kvu3h
         /RyXlsHXkDTGPeg7fBb6OdtVg6Oww+zx+GuWvc7dWlcsDy14po+NEzWut1UF64xsAXxI
         wMUBDHRTdVK2X2RJhGkVl7uTGKWadAoIXwm1mOaBdFryE4kTDNv8CVCJU9LZ1kdHLCe9
         kiA5vMJMPWDEX9sjR8QjlG3HXyHOzlT7Y3zYJioe151I/6tVReFM0LnpUC2CtMWiZU6k
         xbtVO4oTCg82uCT0GNGemRbPdAhomb0oLOgYTfujnu0wW26bsHT9rMmYywXbpQD/wJ+K
         XuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781319315; x=1781924115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/rTx5TMw6ALulkVOK2k/68wHu3vnZZH9YmR3AgZW1iQ=;
        b=suYtOjdOowh6Ib3bVwbeRh2ASbv37p0Mg281aacqHdMwJpMbYYWN85rberHtlX3A5A
         Yw/Qbtrvh/TvzlU5RCARyhuDUZIK004eDsm5kv6e6hRKVMqsYdrvg/hHxt1RsdhYaWjt
         tIxRkWVrftgf7m4sWT2vI5ulJUmwR30l7NrcPvTXdn6DwlshBw+trNPm7p/IwSHHsc4A
         UUX8Uy899HwSk5bpRsKwkZ8J/jjMNXi9aD1Sf+f2KDBRdcJUI3e8Xw7wMe0nHZSmYYYU
         dPiAA4wWil28GsqD0stbaNi8uiBm+Edn04kzx1YTa1OLZjoFKX4JAs3B2QUnHEQiCD7k
         1vsQ==
X-Forwarded-Encrypted: i=1; AFNElJ9h2NtMcAybKW1tNCfnkp636gk8RC+oCke8LxdgqmuOq10bhhSU/qW0a+SNabxrgy0k6nqzKlI9C3B23jwLylHH@vger.kernel.org
X-Gm-Message-State: AOJu0YylET2j2NvRCrc1B7jp2OwHrjQsC8pQYcJAYrz2IMn86nv/+Y5W
	bi8XwO6sQeCjuOl4rV+Lzs1BOQSLVswL17j6+Gsn7wKY7xGf/cg7POHCk/AhaDMJA4HjUPyPqrd
	gCmKYSxbxlk7Cx/Mmvp1n/r5TSIBemfW01GFBdLWoOJ8GRhODranrdtVL
X-Gm-Gg: Acq92OHt/lHXZbDySLJjMUWoqCR3kI9KsdMSEW7K8dAUNjWDyzwu64EXpP0Yt+BaZNd
	moGyvP6tyFaV+SwWQedYjVDN0lXZIv4vfbdoAMz4KuL2Ez9TmhfPA8ziwCuj+Na3A5alw/106Gs
	lpKj92yWVxE46naGKRk5r8pQ2LL4TTpl1/3f61zVJ4GdKwt+iIzIxGaF3TgJI7nk2/qkwFrsbOx
	nfZYzLZ/tEZcnBPBBC5ecg93YfYwTy5t7o/aLDu6uwozLlu7S4PVn2pVYknfi5XixYupWm8HT2q
	RUfdd1hB
X-Received: by 2002:a17:903:b4f:b0:2c0:defb:557e with SMTP id
 d9443c01a7336-2c665e33ef3mr704165ad.1.1781319314792; Fri, 12 Jun 2026
 19:55:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608054841.3856224-1-irogers@google.com> <20260611164122.3974068-1-irogers@google.com>
 <CAP-5=fW9uYdD9fB2ZbF0QVb-N=mVtn6yU8d5=+pacJ_v60OFGg@mail.gmail.com> <aiyjmah8Pnr8ObQr@x1>
In-Reply-To: <aiyjmah8Pnr8ObQr@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 12 Jun 2026 19:55:03 -0700
X-Gm-Features: AVVi8CfDDGh8rAaugdCwvdNU1I25eoBkKQjG9L6Wr7xj66Js_9FtMMOOkE_DpJE
Message-ID: <CAP-5=fUDKcHRLPQd70sVwdQCY5aVU=v6eNyMQvNXrxa80a7jag@mail.gmail.com>
Subject: Re: [PATCH v20 0/5] perf tools: Add inject --aslr feature
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: james.clark@linaro.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	gmx@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 5:26=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Jun 11, 2026 at 11:29:02AM -0700, Ian Rogers wrote:
> > On Thu, Jun 11, 2026 at 9:41=E2=80=AFAM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > This patch series introduces the new 'perf inject --aslr' feature to
> > > remap virtual memory addresses or drop physical memory event leaks
> > > when profile record data is shared between machines. Bundled with thi=
s
> > > feature is a bug fix inside the core map tracking tool that hardens
> > > perf session analysis against concurrent lookup data races.
> > >
> > > Detailed Mechanism of MMAP Mapping and ASLR virtual Address Allocatio=
n:
> > >
> > > The ASLR tool virtualizes the address space of the recorded processes=
 by
> > > intercepting MMAP and MMAP2 events to build a consistent translation
> > > database, which is subsequently used to rewrite sample addresses.
> > >
> > > It maintains two primary lookup databases using hash maps:
> > > 1. 'remap_addresses': Maps an original mapping key to its new remappe=
d
> > >    base address. The key uses topological invariant coordinates:
> > >    (machine, dso, invariant). The invariant is computed as (start - p=
goff)
> > >    for DSO-backed mappings. This invariant remains constant even when
> > >    perf's internal overlap-resolution splits a VMA into fragmented
> > >    pieces, ensuring split maps resolve consistently back to the same
> > >    remapped base.
> > > 2. 'top_addresses': Tracks the allocation state per process (machine,=
 pid).
> > >    It maintains 'remapped_max' (the highest allocated address in the
> > >    virtualized space).
> > >
> > > For each MMAP/MMAP2 event:
> > > - We look up the DSO and invariant key in 'remap_addresses'. If found=
, we
> > >   reuse the translation, preserving the offset within the mapping.
> > > - If not found, we allocate a new remapped address space:
> > >   - We use thread__find_map to look up the mapping immediately preced=
ing
> > >     the new one in the original address space (at start - 1). If
> > >     the preceding
> > >     mapping was also remapped, we place the new mapping
> > >     contiguously after it in the remapped space. This preserves
> > >     contiguity of split mappings (e.g., symbols split by HugeTLB,
> > >     or anonymous .bss segments adjacent to initialized data).
> > >   - If no contiguous mapping is found, we insert a 1-page gap from
> > >     the highest allocated address (remapped_max) to prevent accidenta=
l
> > >     merging of unrelated VMAs.
> > > - The event's start address (and pgoff for kernel maps) is rewritten,
> > >   and the event is delegated to the output writer.
> > >
> > > To remain strictly conservative and guarantee security, the tool
> > > scrubs breakpoint addresses (bp_addr) from all synthesized stream
> > > headers, completely drops PERF_RECORD_TEXT_POKE events to prevent
> > > absolute immediate pointer operands leaks, and drops unsupported
> > > complex payloads (such as user register stacks, raw tracepoints, and
> > > hardware AUX tracing frames).
> > >
> > > Verification is reinforced with shell test ('inject_aslr.sh').
> > >
> > > Prerequisite Bug Fix (Patch 1). During development, a core map
> > > indexing issue was identified and resolved to prevent concurrent
> > > lookup data races during session analysis.
> > >
> > > Changes since v19:
> > > - Patch 1: Group lock and unlock operations inside maps__mutate_mappi=
ng() into
> > >   a single conditional block to resolve Clang 15 -Wthread-safety-anal=
ysis
> > >   compilation errors.
> > > - Patch 5: Skip kernel-based ASLR test cases (test_kernel_aslr and
> > >   test_kernel_report_aslr) on ARM architectures (aarch64 and arm*) to
> > >   bypass high latency constraints and symbolization inconsistencies.
> > >
> > > Changes since v18:
> > > - Patch 2 & 3: Squashed the bounds checking boundary fixes into the "=
Strip
> > >   sample registers" patch. The array bounds checking now correctly us=
es
> > >   'orig_sample_type' to traverse the event payload, preventing heap
> > >   corruption when dealing with events that have had their registers
> > >   stripped by the ASLR tool pipeline.
> > > - Patch 2 & 3: Rebased the commit series to properly isolate the samp=
le
> > >   address remapping logic from the register stripping logic.
> > > - Patch 2 & 3: Expanded commit messages to extensively document the
> > >   cross-endian behavior of 'perf inject'. Because 'perf inject' effec=
tively
> > >   acts as an endianness converter (writing a host-endian PERF_MAGIC a=
nd
> > >   flushing events exactly as they sit in memory after being byte-swap=
ped
> > >   by perf_event__all64_swap), all injected events must be perfectly
> > >   constructed in the host's native endianness. Specifically,
> > >   perf_event__all64_swap byte-swaps the raw 64-bit payloads, which ca=
uses
> > >   32-bit sequential fields like PERF_SAMPLE_TID (containing pid and t=
id)
> > >   to have their ordering reversed in memory (e.g., [BE_pid][BE_tid] b=
ecomes
> > >   [LE_tid][LE_pid]). The ASLR tool's sample construction logic was
> > >   expanded to explicitly unpack these fields and repack them sequenti=
ally
> > >   via unions to guarantee a strictly host-endian layout that resolves
> > >   these inversion anomalies. Similarly, branch stack flags (which are
> > >   modified in-place to host-endian bitfields by the parser) are copie=
d
> > >   directly to the newly synthesized event, and 'needs_swap=3Dfalse' i=
s explicitly
> > >   used when re-parsing the synthesized event to prevent erroneous dou=
ble
> > >   swapping.
> > > - Series: Verified cross-endian robustness via the sashiko analyzer.
> > >
> > > Changes since v17:
> > > - Patch 2: Reordered ksymbol deletion logic to ensure
> > >   `perf_event__process_ksymbol` deletes the map *after* the
> > >   `aslr_tool__findnew_mapping` translates the unregister offsets.
> > > - Patch 2: Changed `aslr_tool__delete` to cleanly handle guest machin=
e
> > >   deletion memory leaks.
> > > - Patch 2: Resolved read-only segfaults on memory-mapped perf.data
> > >   headers during attribute stripping by using deep copies in
> > >   `perf_event__repipe_attr`.
> > > - Patch 2: Fixed user space remap invariant logic to include
> > >   `(start - map__start(al.map))` preventing negative overflows on mod=
ule
> > >   offset boundaries.
> > > - Patch 3: Removed duplicate `bswap_64` payload byte-swapping inside =
the
> > >   array logic, allowing the host endianness macros `COPY_U64()` to
> > >   handle it dynamically.
> > > - Patch 3: Fixed LBR branch sample starvation by explicitly reading b=
ranch
> > >   counters instead of dropping the entire sample.
> > > - Patch 5: Fixed test flakiness by grepping out physical hex addresse=
s
> > >   `0x[0-9a-f]{8,}` instead of matching exact address strings.
> > > - Patch 5: Parameterized temp reports and updated test to scale with
> > >   `/dev/urandom` continuous random reads.
> > > - Patch Series: Added Signed-off-by tags uniformly and Assisted-by ta=
gs to
> > >   track assistance.
> > >
> > > Changes since v16:
> > > - Patch 2: Refactored inline ASLR stripping logic out of builtin-inje=
ct.c
> > >   and into dedicated helpers (aslr_tool__strip_attr_event and
> > >   aslr_tool__strip_evlist) in aslr.c to better separate concerns.
> > > - Patch 2: Fixed guest machine allocation memory leak in
> > >   aslr_tool__delete() where machines__exit() explicitly skipped freei=
ng
> > >   the guest processes tree.
> > > - Patch 3: Fixed bounds-check violations during cross-endian parsing =
inside
> > >   aslr_tool__process_sample() by correctly applying bswap_64() to raw
> > >   offsets, iteration counts, sizes, and addresses prior to logical
> > >   evaluation when orig_needs_swap is active.
> > > - Patch 4: Fixed pipe mode parser misalignment bug by safely fetching
> > >   needs_swap from the initialized evsel rather than blindly intercept=
ing
> > >   HEADER_ATTR events prior to session parsing.
> > > - Patch 4: Resolved checkpatch.pl line length warnings in the bswap_6=
4
> > >   endianness swapping logic.
> > > - Patch Series: Reordered the final two patches. "perf aslr: Strip
> > >   sample registers" is now Patch 4, and "perf test: Add inject ASLR
> > >   test" is now Patch 5. This ensures the register stripping logic
> > >   is fully introduced before the comprehensive shell tests validate i=
t,
> > >   preventing bisectability test failures and easing merge conflicts.
> > > - Patch 5: Fixed "User registers stripping test" starvation when run =
as
> > >   root by explicitly using '-e cycles:u' during recording, preventing
> > >   the ring buffer from overflowing with kernel samples.
> > >
> > > Changes since v15:
> > > - Patch 2: Added bounds checking for event->header.size before writin=
g
> > >   to breakpoint fields to avoid heap buffer overflow on older ABI eve=
nts.
> > > - Patch 2: Fixed asymmetric calculation bug in aslr_tool__findnew_map=
ping()
> > >   where pgoff for anonymous kernel memory was not properly subtracted=
 upon
> > >   insertion, causing the lookup addition to overflow.
> > > - Patch 2: Added detailed comments documenting the symmetric lookup a=
nd
> > >   insertion math for unmapped and mapped memory blocks.
> > > - Patch 5: Add missing kprobe and uprobe scrubbing of config1 and
> > >   config2 during aslr_tool__strip_evlist() to strictly conform with
> > >   repipe constraints.
> > >
> > > Changes since v14:
> > > - Patch 2: Removed unnecessary vertical whitespace in builtin-inject.=
c.
> > > - Patch 2: Added comments explaining why pgoff is assigned for
> > >   anonymous memory maps to prevent ASLR leaks.
> > > - Patch 2: Removed orig_last_end tracking and refactored contiguous m=
apping
> > >   detection to use thread__find_map(..., start - 1, ...) based on Gab=
riel's
> > >   feedback.
> > > - Patch 2: Scrub kprobe/uprobe event config1 and config2 fields to pr=
event
> > >   address leaks.
> > > - Patch 2: Overwrite pgoff with the remapped start address for anonym=
ous
> > >   mappings (detected via is_anon_memory and is_no_dso_memory).
> > > - Patch 3: Fix C90 mixed declaration error for orig_needs_swap.
> > > - Patch 3: Temporarily disable evsel->needs_swap during the secondary
> > >   evsel__parse_sample() call to prevent branch stack double-swapping =
bugs.
> > >
> > > Changes since v13:
> > > - Patch 2: Added a NULL check for env before calling
> > >   perf_env__kernel_is_64_bit(env) to prevent potential segfaults if t=
he
> > >   recorded environment has no headers.
> > > - Patch 5: Fixed sample_size and id_pos going out of sync during
> > >   aslr_tool__strip_evlist() and aslr_tool__restore_evlist(). Instead =
of
> > >   using evsel__reset_sample_bit(), which was acting as a no-op due to
> > >   early bit clearing and corrupted sample_size, the tool now directly
> > >   updates sample_type and recomputes sample_size/id_pos dynamically.
> > >   Added orig_sample_size to aslr_evsel_priv to correctly restore the
> > >   state.
> > >
> > > Changes since v12:
> > > - Patch 2: Fixed potential NULL pointer dereference in
> > >   remap_addresses__hash() when handling unmapped memory events (key->=
dso
> > >   is NULL) under REFCNT_CHECKING.
> > > - Patch 2: Dynamically detect machine architecture bitness via
> > >   perf_env__kernel_is_64_bit() to select appropriate kernel_space_sta=
rt
> > >   boundaries, avoiding 64-bit address injection on 32-bit platforms.
> > >
> > > Changes since v11:
> > > - Patch 1: Fixed struct dso name accessor in maps.c by using
> > >   dso__name() instead of ->name.
> > > - Patch 2: Fixed hash function in aslr.c to hash the underlying
> > >   dso pointer using RC_CHK_ACCESS to support reference count checking=
.
> > >
> > > Changes since v10:
> > > - Patch 1: Added explicit tracking array logic in maps__load_maps()
> > >   to correctly accumulate valid maps (skipping NULL entries after
> > >   failures) and safely return the exact populated count, resolving
> > >   out-of-bounds pointer iteration panics.
> > > - Patch 3: Fixed endianness bug during cross-endian sample parsing
> > >   by passing evsel->needs_swap instead of false to __evsel__parse_sam=
ple
> > >   in aslr.c, ensuring correct 32-bit field byte unswapping for packed
> > >   fields. Refactored evsel__parse_sample to take a needs_swap argumen=
t
> > >   via __evsel__parse_sample.
> > > - Patch 4: Fixed inject_aslr.sh exit code handling in trap functions
> > >   to capture and propagate the correct pipeline failure status code
> > >   instead of unconditionally returning success or failing the test.
> > >
> > > Changes since v9:
> > > - Patch 1: Added `-ENOMEM` error check inside
> > >   `maps__find_symbol_by_name()` and return `NULL` early. Added map
> > >   sorting state invalidation on early return in `maps__load_maps()`.
> > > - Patch 2: Fixed encapsulation by using `thread__maps()` and
> > >   `thread__pid()` accessors in `aslr_tool__findnew_mapping()`. Added
> > >   `pr_warning_once` warning when raw auxtrace data is dropped.
> > > - Patch 3: Fixed encapsulation by using `thread__maps()` and
> > >   `thread__pid()` accessors in `aslr_tool__remap_address()`. Wrapped
> > >   `evsel__parse_sample()` to temporarily disable `needs_swap` to avoi=
d
> > >   branch stack endianness corruption on cross-endian files. Fixed ISO
> > >   C90 warning for declaration-after-statement for `orig_needs_swap`.
> > > - Patch 4: Fixed duplicate cleanup by explicitly removing trap
> > >   handlers (`trap - EXIT TERM INT`) inside the `cleanup()` function.
> > > - Patch 5: Fixed heap corruption by adding size bounds checking befor=
e
> > >   writing to `sample_regs_user` and `sample_regs_intr` fields. Added
> > >   missing register mask clearing logic for the `itrace` synthesis pat=
h
> > >   of `perf_event__repipe_attr()`.
> > >
> > > Ian Rogers (5):
> > >   perf maps: Add maps__mutate_mapping
> > >   perf inject/aslr: Add ASLR tool infrastructure and MMAP tracking
> > >   perf inject/aslr: Implement sample address remapping
> > >   perf aslr: Strip sample registers
> > >   perf test: Add inject ASLR test
> >
> > The sashiko reviews are at:
> > https://sashiko.dev/#/patchset/20260611164122.3974068-1-irogers%40googl=
e.com
> >
> > To summarize:
> >
> > Patch 2:
> >  * TOCTOU if underlying event buffer mmaps change. Not an issue as
> > rewriting a perf.data file while it is being read is out of scope.
> >
> > Patch 3:
> >  * Mapping addresses to 0 for unknown mappings is criticized but the
>
> Why not then have some unknown mappings hashmap that will assign a
> random, unique address on a address range that doesn't overlap with any
> of the other maps?
>
> Zero has special meaning, mapping some non-zero address to it introduces
> confusion when what we want is to just make sure that we don't leak
> addresses?

I don't think it is a bad idea. I think like with the ARM kernel
symbolization issue we should do it as follow up work.

> > proposed alternative doesn't hide ASLR. This will cluster things on
> > address 0 but the fix is simply to ensure no MMAPs are missing.
> >  * Cross-endian issues, but as explained previously, these are out of s=
cope.
> >
> > The clang build issue reported by James and disabling the kernel
> > testing for ARM are both in the v20 series. So I think the patches are
> > ready for review/merging.
>
> I reviewed one other patch in the series besides the above suggestion.
>
> Thanks, its an useful feature!

Thanks!
Ian

> - Arnaldo
>
> > Thanks,
> > Ian
> >
> > >  tools/perf/builtin-inject.c           |   81 +-
> > >  tools/perf/tests/shell/inject_aslr.sh |  533 ++++++++++
> > >  tools/perf/util/Build                 |    1 +
> > >  tools/perf/util/aslr.c                | 1406 +++++++++++++++++++++++=
++
> > >  tools/perf/util/aslr.h                |   44 +
> > >  tools/perf/util/evsel.c               |    6 +-
> > >  tools/perf/util/evsel.h               |   10 +-
> > >  tools/perf/util/machine.c             |   32 +-
> > >  tools/perf/util/maps.c                |  148 ++-
> > >  tools/perf/util/maps.h                |    3 +
> > >  tools/perf/util/symbol-elf.c          |   41 +-
> > >  tools/perf/util/symbol.c              |   17 +-
> > >  12 files changed, 2251 insertions(+), 71 deletions(-)
> > >  create mode 100755 tools/perf/tests/shell/inject_aslr.sh
> > >  create mode 100644 tools/perf/util/aslr.c
> > >  create mode 100644 tools/perf/util/aslr.h
> > >
> > > --
> > > 2.54.0.1099.g489fc7bff1-goog
> > >
