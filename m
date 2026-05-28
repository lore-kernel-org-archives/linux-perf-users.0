Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5145324B2D;
	Thu, 28 May 2026 22:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780007845; cv=none; b=qYLlF/OF2PcDY5dsbpVjzq/PsqOBpoHqQDxh1VWxtIgqBcvVQpwclX4ocqF7xbtw/jmosmYJ0bEPDXVXXU6CiFj6as/USXElL4/G/T4/KpCrrXLjiUilTuX+ec8zN1QWosmeeteuI+wDCXikIZVMutoXsLRTOfxU3V+0qlQ50C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780007845; c=relaxed/simple;
	bh=RV2x5AkFfcryy1BM3yvJw52wW0KcSPhUJgB9mYxoqdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JD2Pzt9siujm2X6Gps3BB4lPH8rzqS7SXE3ZGO9NgdDmzxj4fbAK5b9MZr2rv+bfD1wXPnyZnTFFn05LRV7b3k/8QWxh3XNvDaAr/vbIIhCopMfwid7UCvK6qikA29bZ8Qvmd1wHf+KkFzDcb1eVpSuySw3Tmi/di4XsyI7oV7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcRVAD8t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcRVAD8t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF0B1F000E9;
	Thu, 28 May 2026 22:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780007844;
	bh=EhdSBskIFJznI2esoKNo8H73lzaVWrF+RRm2Ts0Dw1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bcRVAD8tfHLI2n1WGPURKavVww9Fzj88rubQIhIgNs8pIeikIcbavjdukSHSlHHQ8
	 xBJ32DEIlbzbxYarlXSV+vjnb4VQ17v8020ZXzLBxj3ukJbHgqZBBAoMdFFC+K/U7i
	 7A87erEL3rTJQym3BLwvDON4e/WurGh76GACAZhDdU0t7AwUZba+FOCDuub3Shc73G
	 OGqxMmTXVP//vD+r2+Gqa1dceBVyccXLRoVUvNKnJv2Ht9SQSLZh880VxHoglB15UW
	 ezabcwlTuD9dOA0GAFwCZprKJirZ1EQUp+e2Vjne4Zs4CzwBcljpgmWEm2ZfCyl18r
	 i8F4LSc1pX/xg==
Date: Thu, 28 May 2026 19:37:19 -0300
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
Message-ID: <ahjDn2xmnJbIc9Dm@x1>
References: <20260526211806.1193848-1-acme@kernel.org>
 <ahZDggzXoHvbnhog@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahZDggzXoHvbnhog@x1>

On Tue, May 26, 2026 at 10:06:10PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, May 26, 2026 at 06:17:36PM -0300, Arnaldo Carvalho de Melo wrote:
> > perf.data validation and hardening (29 patches)
> > 
> > A crafted or corrupted perf.data file can cause out-of-bounds
> > reads/writes, infinite loops, heap overflows, and segfaults in perf
> > report, perf script, perf inject, perf timechart, and perf kwork.
> > This series adds defense-in-depth validation for file parsing:
> 
> The analysis about Sashiko's remaining comments is below, unless someone
> has something not related by Sashiko, I'll merge this tomorrow and
> continue processing the other outstanding patches.

Merged into perf-tools-next,

- Arnaldo
 
> ● Here's the v4 sashiko.dev review triage — 13 of 29 patches got reviews:
> 
>   Patches with findings:
> 
>   Patch: 02 (peek_event bounds)
>   Findings: 1 High: mmap_size - page_offset underflow
>   Verdict: Pre-existing — reader__init() validates data_size, page_offset can't exceed mmap_size
>   ────────────────────────────────────────
>   Patch: 04 (zstd compress)
>   Findings: 1 Critical + 3 High: multi-record header overflow, AIO data_size, flush return, decompress pos
>   Verdict: All pre-existing — the Critical is about process_header() aggregate size, and the decompress issue is fixed later in patch 05
>   ────────────────────────────────────────
>   Patch: 05 (zstd decompress)
>   Findings: 1 High: O_NONBLOCK missing on file opens
>   Verdict: Pre-existing — not introduced by this patch, unrelated to zstd
> 
> This one IIRC Ian sent a patch for review-prompts, merged recently that
> will make its way to Sashiko and will stop being flagged as a problem:
> 
>   "kernel/subsystem/perf.md: Remove section describing non-blocking IO"
>   https://github.com/masoncl/review-prompts/commit/261d73261dbb11f38ff9c653da3608b162741e03
> 
>   ────────────────────────────────────────
>   Patch: 08 (swap infra)
>   Findings: 2 High: mmap2 prot/flags not swapped, event_update union not swapped
>   Verdict: Both pre-existing — correct observations for follow-up series
>   ────────────────────────────────────────
>   Patch: 10 (HEADER_ATTR)
>   Findings: same as v3 — already triaged
>   Verdict:
>   ────────────────────────────────────────
>   Patch: 11 (nr validation)
>   Findings: 1 Medium: native path aborts vs swap path skips on bad THREAD_MAP
>   Verdict: Valid observation — but intentional: native path returns -EINVAL to catch corruption, swap path skips to keep session alive.
>   ────────────────────────────────────────
>   Patch: 12 (build_id_swap)
>   Findings: same as v3 — already fixed in v4
>   Verdict:
>   ────────────────────────────────────────
>   Patch: 15 (BPF_METADATA)
>   Findings: 1 High new: double-fetch of header.size in swap path; 2 High pre-existing: TOCTOU on native path
>   Verdict: The double-fetch is valid for swap but swap runs on MAP_PRIVATE (writable copy), so no concurrent modification possible.
>   ────────────────────────────────────────
>   Patch: 24 (compressed hardening)
>   Findings: 1 Medium: double-fetch of event->header.size in tool.c
>   Verdict: Same TOCTOU pattern
>   ────────────────────────────────────────
>   Patch: 26 (CPU bounds)
>   Findings: 1 High: global clamp corrupts data for >4096 CPUs
>   Verdict: Known limitation — memory [[MAX_NR_CPUS dynamic allocation]] TODO
>   ────────────────────────────────────────
>   Patch: 28 (READ_ONCE snapshot)
>   Findings: 4 High: incomplete TOCTOU fix, type confusion, array count re-reads
>   Verdict: All pre-existing MAP_SHARED TOCTOU. The full fix would be MAP_PRIVATE, noted as follow-up
>   ────────────────────────────────────────
>   Patch: 29 (shell test)
> 
>   Fixed and sent the diff in response to Sashiko's review e-mail.
> 
>   Summary: 1 new actionable issue in v4. All the other findings are
>   either pre-existing (documented in the cover letter), already fixed in
>   this version, or intentional design decisions. The mmap2 prot/flags
>   and event_update union swap gaps (patch 08) are valid pre-existing
>   bugs for a follow-up series.
> 
> -------------------------------------------------------------------------
