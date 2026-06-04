Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8BF3BBFA6;
	Thu,  4 Jun 2026 22:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780610926; cv=none; b=VAeQGjECY9KkUN8O1nk5oNgTwTELQRFKZ7Xx2kyzbyH4AFR/BEh7bbXNv5baGaV/O1JHtWthvUT18o0ICPIimtm4eNNkGK/W5y6ner8hPIAPsNSPEEM/0HYymuUXCouq+ekCTy3a6qpP8Q/IFzdg63mO4vnr8SZfwUl85olD5f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780610926; c=relaxed/simple;
	bh=ghh7mm9g1Epm2/LRCf+ge7NyRZq1lLVGCM9h9x7IDXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CX6eA3jWxMYnnbBrWgyxffPYvgDjuRaJhQi6QOe0ST67u/kI4u7yP7xaV4qFw7qMdXIlM2cRN7gjTZsXJsTgSBQnJK8EFUFqVQdac6mGcQjP2+UwQIubBCUy+NqB+p0uVbV7xc008ZosSV6ZsGIeQb3P2Q3gPsozPNK/TAKqe/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qt7D3Lgz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qt7D3Lgz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D3D1F00893;
	Thu,  4 Jun 2026 22:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780610925;
	bh=Y5W5EMghLOBnmqiUqhNCRZOzjhmN9ZbfJbymyAHAbsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qt7D3LgzlOCQtkEmel1jkHfVijRMW2TXZvqoG9aD4DJhdZfBVH6tmix2bScd+QPqs
	 rj1ngc6q27xLZFiCqX84b5euiGJnCBY18TfGEipYHP7dh7XufgdjKZmD6GRI3q8njF
	 udzUwMVZ8JFSNZJFGsWh1pA7mcij6xNMmWGJvrzxeUADMtqXKeHatI0q5FvCBmw7ov
	 cI/MeLBd1IbiF2scO+eRnUj8QZwlyO9vtWA7PEnNZeDr+cgsfuRfiNwoZyW8b5rAeI
	 kzSZdDl6sbsj7oXBEOBc1OYsAFWrMvTt0lsPT7apFrcMWBW90QlOkHoUiHOyMxY7HJ
	 n9DQC81YKbQcA==
Date: Thu, 4 Jun 2026 15:08:43 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCHES v2 0/4] perf tools: Fix OOB reads, NULL deref, and
 resource leaks
Message-ID: <aiH3a_gI7S-pUTke@google.com>
References: <20260604204921.1707333-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260604204921.1707333-1-acme@kernel.org>

On Thu, Jun 04, 2026 at 05:49:15PM -0300, Arnaldo Carvalho de Melo wrote:
> Hi,
> 
> Four pre-existing bugs found by sashiko-bot during AI-assisted review
> of the perf-data-validation hardening series.  All are independent of
> that series -- they are latent bugs in surrounding code exposed during
> review.
> 
>   1. test_bit(sample->cpu, cpu_bitmap) reads out of bounds when
>      PERF_SAMPLE_CPU is absent (sample->cpu == (u32)-1) in annotate,
>      diff, report, and sched timehist.
> 
>   2. Thread reference leak in perf sched latency_switch_event() -- one
>      error path does 'return -1' instead of 'goto out_put'.
> 
>   3. NULL pointer dereference in perf sched latency_runtime_event() --
>      thread_atoms_search() called before the NULL check on the thread
>      returned by machine__findnew_thread().
> 
>   4. Heap buffer overflow in perf sched map --compact mode --
>      comp_cpus allocated based on host CPU count but indexed using a
>      MAX_CPUS-sized bitmap, overflowing when analyzing recordings from
>      machines with more CPUs than the host.  Also fixes the sizeof
>      mismatch from the int-to-struct perf_cpu type change, removes the
>      now-dead sysconf(_SC_NPROCESSORS_CONF) initialization, and fixes
>      an off-by-one in the non-compact path where max_cpu (0-based
>      index) was used as cpus_nr (count) without adding 1.
> 
> All four require crafted or unusual perf.data inputs to trigger.
> Verified with gcc and clang builds, checkpatch, and perf test.
> 
> Changes in v2:
>   - Patch 4: fix off-by-one in non-compact path — max_cpu.cpu is a
>     0-based index, needs + 1 when used as cpus_nr (count).
>     Reported by sashiko-bot.
> 
> Arnaldo Carvalho de Melo (4):
>   perf tools: Guard test_bit from out-of-bounds sample CPU
>   perf sched: Fix thread reference leak in latency_switch_event
>   perf sched: Fix NULL dereference in latency_runtime_event
>   perf sched: Fix comp_cpus heap overflow with cross-machine recordings

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  tools/perf/builtin-annotate.c |  3 ++-
>  tools/perf/builtin-diff.c     |  3 ++-
>  tools/perf/builtin-report.c   |  3 ++-
>  tools/perf/builtin-sched.c    | 18 ++++++++++--------
>  4 files changed, 16 insertions(+), 11 deletions(-)
> 
> Developed with AI assistance (Claude/sashiko), tagged in commits.
> 
> Thanks a lot,
> 
> - Arnaldo
