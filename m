Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133302F3C19;
	Wed, 27 May 2026 01:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779843975; cv=none; b=qrumc7hQtK8wkFFs/J1f8UZ5Bjm0RF1k68LwSJR0n4o4yZY1c6GBjU76JgAWHeXmy8s/WQU9XDz7ajfrzTet6/J76v6jiOaYmO3J2o5S5TqZZxmaCrSWU3pDH1koMhiOLn2/o0haY+M266xISvCSQ624zRK87ztZlseMPG4ASUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779843975; c=relaxed/simple;
	bh=4lI1MlztfpcnNh5gTr9RSE7/NKM4r3LfOXewvUhBR8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVsYTiKWuEPr24i3MG+BybPKPFvYaBYKdJvT9Y68NgzRhknMqHZNGQijhqn0tL+FdxIrHkEPFdgPsOVt2TAQUY1Q0T0Z6mJOk2BnVK+VFsLrhefHZVY7mLsjF2Js9pPvm5FRPYLpSBaQaoH/rVjFcaMfU7xNmz1y4wVU0PIqTyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKvr1bC0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKvr1bC0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1667E1F000E9;
	Wed, 27 May 2026 01:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779843973;
	bh=/Qd6lLV2dXPRY+w3B+aDWuZARTiqLWw5NdOh0D0Zt3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TKvr1bC0uuiP5otNnt/VM7IoDpp/erJDAfuzUS6BHGXpFdz2+UkJ+28Zfe2I/sjYg
	 dOm/MWPYZBX3SLwze8xxCk+6i37hLmqtG303EvGVkYP4ikVSEFHfB4GgI9lwTRYQhw
	 WoiYFyyFVKOI7i2ya35v2dfbcSb6s0a0y9aja5hyUN4DMlWEXMhJlGK42Igi4Uk0I/
	 u/+Erl2hpWRKL3SprWgcULJsEAdotj2M+c7Jc+07zSLKet2Y3nyni2PrZ7mJBXbzx+
	 4D1Hnj+fQ9gjmogc0dy8JLH1jIw7P+3ix3OOujNeHtNjPqSpt6dtlBxXI8aAuRpyNV
	 xK25pg3tXSAYA==
Date: Tue, 26 May 2026 22:06:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCHES v4 00/29] perf: Harden perf.data parsing against
 crafted/corrupted files
Message-ID: <ahZDggzXoHvbnhog@x1>
References: <20260526211806.1193848-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260526211806.1193848-1-acme@kernel.org>

On Tue, May 26, 2026 at 06:17:36PM -0300, Arnaldo Carvalho de Melo wrote:
> perf.data validation and hardening (29 patches)
> 
> A crafted or corrupted perf.data file can cause out-of-bounds
> reads/writes, infinite loops, heap overflows, and segfaults in perf
> report, perf script, perf inject, perf timechart, and perf kwork.
> This series adds defense-in-depth validation for file parsing:

The analysis about Sashiko's remaining comments is below, unless someone
has something not related by Sashiko, I'll merge this tomorrow and
continue processing the other outstanding patches.

● Here's the v4 sashiko.dev review triage — 13 of 29 patches got reviews:

  Patches with findings:

  Patch: 02 (peek_event bounds)
  Findings: 1 High: mmap_size - page_offset underflow
  Verdict: Pre-existing — reader__init() validates data_size, page_offset can't exceed mmap_size
  ────────────────────────────────────────
  Patch: 04 (zstd compress)
  Findings: 1 Critical + 3 High: multi-record header overflow, AIO data_size, flush return, decompress pos
  Verdict: All pre-existing — the Critical is about process_header() aggregate size, and the decompress issue is fixed later in patch 05
  ────────────────────────────────────────
  Patch: 05 (zstd decompress)
  Findings: 1 High: O_NONBLOCK missing on file opens
  Verdict: Pre-existing — not introduced by this patch, unrelated to zstd

This one IIRC Ian sent a patch for review-prompts, merged recently that
will make its way to Sashiko and will stop being flagged as a problem:

  "kernel/subsystem/perf.md: Remove section describing non-blocking IO"
  https://github.com/masoncl/review-prompts/commit/261d73261dbb11f38ff9c653da3608b162741e03

  ────────────────────────────────────────
  Patch: 08 (swap infra)
  Findings: 2 High: mmap2 prot/flags not swapped, event_update union not swapped
  Verdict: Both pre-existing — correct observations for follow-up series
  ────────────────────────────────────────
  Patch: 10 (HEADER_ATTR)
  Findings: same as v3 — already triaged
  Verdict:
  ────────────────────────────────────────
  Patch: 11 (nr validation)
  Findings: 1 Medium: native path aborts vs swap path skips on bad THREAD_MAP
  Verdict: Valid observation — but intentional: native path returns -EINVAL to catch corruption, swap path skips to keep session alive.
  ────────────────────────────────────────
  Patch: 12 (build_id_swap)
  Findings: same as v3 — already fixed in v4
  Verdict:
  ────────────────────────────────────────
  Patch: 15 (BPF_METADATA)
  Findings: 1 High new: double-fetch of header.size in swap path; 2 High pre-existing: TOCTOU on native path
  Verdict: The double-fetch is valid for swap but swap runs on MAP_PRIVATE (writable copy), so no concurrent modification possible.
  ────────────────────────────────────────
  Patch: 24 (compressed hardening)
  Findings: 1 Medium: double-fetch of event->header.size in tool.c
  Verdict: Same TOCTOU pattern
  ────────────────────────────────────────
  Patch: 26 (CPU bounds)
  Findings: 1 High: global clamp corrupts data for >4096 CPUs
  Verdict: Known limitation — memory [[MAX_NR_CPUS dynamic allocation]] TODO
  ────────────────────────────────────────
  Patch: 28 (READ_ONCE snapshot)
  Findings: 4 High: incomplete TOCTOU fix, type confusion, array count re-reads
  Verdict: All pre-existing MAP_SHARED TOCTOU. The full fix would be MAP_PRIVATE, noted as follow-up
  ────────────────────────────────────────
  Patch: 29 (shell test)

  Fixed and sent the diff in response to Sashiko's review e-mail.

  Summary: 1 new actionable issue in v4. All the other findings are
  either pre-existing (documented in the cover letter), already fixed in
  this version, or intentional design decisions. The mmap2 prot/flags
  and event_update union swap gaps (patch 08) are valid pre-existing
  bugs for a follow-up series.

-------------------------------------------------------------------------

