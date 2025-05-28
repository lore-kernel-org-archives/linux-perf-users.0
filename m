Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E30111AD;
	Wed, 28 May 2025 18:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748455360; cv=none; b=jc4bJgIYNA7NXzoqrv+6X7yKgqCrPX09JCNOkxzFj5oahhwcqPFtHgAOTdkQZJrVAsqRchSdrmxjQCEGHSxBqa/EMKdATCQzyhjy5g97Au7XXslq6SVhvohJKQ+y07gicUFFSgk3rbKk8ht/v3qzgphsKp0fxR8119s+62VCQeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748455360; c=relaxed/simple;
	bh=7/N7kn9RRXKq6KqqskQq3WvBRPAvJG2NaFJSdCXo8LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLvAEDfsHp7nD2AU/tVWafGXl6OfJMTMDocYQbUrhw/4WbYEm47odcNjs4yW7TAL1NvAiVWfPskp6RJhHcQbvRIvqYASeLTmxc+pYltUR379BRA1oOvHquzSv8deYnGqcaNv2tgaRTLqaN4LyJsmSBJuG2DikX9tmp2+9u1s5q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhqpWeCZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhqpWeCZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677B7C4CEE3;
	Wed, 28 May 2025 18:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748455359;
	bh=7/N7kn9RRXKq6KqqskQq3WvBRPAvJG2NaFJSdCXo8LQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GhqpWeCZes79lHl8+Um6pC3HgwPQKhZM2/CZGQxxSuOyck59xHzjdiujxHpUIsl2s
	 xzh/YWnvj3MB5dslZx/xjzntBYRjah2OufArbZp9hJuVCvHL/H93AmSrRdsW73olYS
	 0eYyBMVcDxtJSrsZWBtWmu1k6DP+46iS+7uyfWidWGLMNJLt0Ba0wZ46S8J5xY9asi
	 RPwgGE2qmANUNf3MsMXGoAFjUQ4sgVfCOzUmx+1s6r0FafT0LSNbEcLLqGaZc0/Thm
	 aJLSoqZR29XsVEmhm3SNbBYIlQ6SozUvTKUE5FotvkUBvFRkWJDLM9cN8gPkadF5nu
	 oGo0gK4MuHZGQ==
Date: Wed, 28 May 2025 11:02:36 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Various asan and test fixes
Message-ID: <aDdPvCIYmSPXmBJG@google.com>
References: <20250528032637.198960-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250528032637.198960-1-irogers@google.com>

On Tue, May 27, 2025 at 08:26:30PM -0700, Ian Rogers wrote:
> When testing removing perf_env with asan I noticed a number of test
> failures either because of asan issues or because of building with
> NO_LIBELF=1 and NO_LIBBPF=1 to avoid false memory leaks. Address these
> issues so that real test failures stand out.
> 
> v2: Fix wrong elf size use in filename__read_build_id fix. Add
>     thread__comm_lock fix.
> 
> Ian Rogers (7):
>   perf symbol: Fix use-after-free in filename__read_build_id
>   perf test demangle-java: Don't segv if demangling fails
>   perf symbol: Move demangling code out of symbol-elf.c
>   perf intel-tpebs: Avoid race when evlist is being deleted
>   perf test intel-pt: Skip jitdump test if no libelf
>   perf test trace_summary: Skip --bpf-summary tests if no libbpf
>   perf thread: Avoid recursively taking thread__comm_lock

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  tools/perf/tests/demangle-java-test.c   |   5 +
>  tools/perf/tests/shell/test_intel_pt.sh |   5 +
>  tools/perf/tests/shell/trace_summary.sh |   6 +
>  tools/perf/util/demangle-cxx.h          |   2 +
>  tools/perf/util/intel-tpebs.c           |  12 +-
>  tools/perf/util/symbol-elf.c            |  86 ------------
>  tools/perf/util/symbol-minimal.c        | 175 ++++++++++--------------
>  tools/perf/util/symbol.c                |  87 ++++++++++++
>  tools/perf/util/thread.c                |  17 ++-
>  9 files changed, 198 insertions(+), 197 deletions(-)
> 
> -- 
> 2.49.0.1238.gf8c92423fb-goog
> 
