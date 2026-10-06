Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC9525B0BD;
	Tue,  6 Oct 2026 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791317458; cv=none; b=bGzIDiiHfjU1HqdeZgKq9w2V0ufTuGG0xohWmKZ4gl9+QifXdxOjtozllnc6o9+d8NZY6tThV+DuhqmJJQ97QT2ffaBWdDVPd5ZKp4LrG2jNGJaaVs2NwthO87KcX/0EBMh30fHTRw11lu7DdJulsicEHI1sJAUJHyu8Lz01c+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791317458; c=relaxed/simple;
	bh=GqkcFvKSxmTJPCxIHSz0DpN2SuZXYND18GZHDjy+wAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9pl3x50L9mrgqHnx80t8xzlrQCNdxJ6c36gcWuZWtfLpkkPCXcw+Ti0cjw18JPAGOlV1G5X3G9qlWqp57nMRA2CRLop/Ml5kpRmh6Df+XSFDv1YtI7u7DX64dlkjtxqqPkTuQsevYEiuvuPyJau784yRwMIgXI8LgY4ntmtfZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ol1TvbVt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ol1TvbVt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A461F0089B;
	Tue,  6 Oct 2026 20:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791317457;
	bh=ag95j01BNY2rZLOMIWsMOFuuXKgvHlB3iL5p3eAlY/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ol1TvbVt+OLq1pn5LrVUXZY0z3OCNVHfUlV3eW8uEe4gvNSw/V4Eb4zeVd60F+aYy
	 IbHDvuxGlY/HepaRyOH3LOrvbn4W0PyicjM5LAG1V1kh2dHHIEDfYWAp68gacsZyOP
	 C0BGbwCZE3+FczQXDJ8nobg1KEYf2zAg+u6iYhbYbFYqMdyD/Yep5LSWvXdsCuND00
	 OBWt4T5OZHUPRzEK3++LuVLDxStmRhCa9utZNVlRTjsDs8I9j2bXlHizHEkvArBl9C
	 0MBE2/7jx39AZfJTH4wr0lPU6+fdMKHxE3nGhvprePjzO8GglX3YHWX5vlQ7Pasop6
	 7AEsIhKORjuwg==
Date: Tue, 6 Oct 2026 13:10:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Michal Pluta <michalpl2003@gmail.com>
Cc: acme@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] perf symbol: Speed up demangling of long Rust symbols
Message-ID: <asVVzyLvtkAnILEr@google.com>
References: <20260928010227.1903673-1-michalpl2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260928010227.1903673-1-michalpl2003@gmail.com>

On Mon, Sep 28, 2026 at 02:02:22AM +0100, Michal Pluta wrote:
> dso__demangle_sym() demangles Rust v0 symbols itself instead of using
> a helper like the other demanglers. When a demangled name doesn't fit
> the buffer, it grows the buffer by a fixed 32 bytes and reformats the
> whole name from scratch. The number of attempts grows with the name's
> length, so the total work is quadratic. Rust programs with deeply
> nested generics can have very long demangled names, and I noticed this
> as real time spent in perf report on perf.data recorded from launching
> Bevy and Typst.
> 
> Patch 3 is the actual optimisation, doubling the size of the buffer
> instead.  Patch 5 moves the Rust-specific logic into its own function,
> matching how the other demanglers are called.  I think the cleanup is
> worthwhile but I understand it comes down to personal taste and the
> patch can be skipped if maintainers would rather keep
> dso__demangle_sym() as is.
> 
> I used an LLM to review my patches and find the issues with the
> demangle tests and the unterminated buffer bug.
> 
> Testing:
> - 'perf test' passes, including the demangle Java, OCaml and Rust
>   suites (patch 3 adds a case for a symbol that exceeds the buffer
>   limit).
> - 'perf report' output is unchanged before and after this series on
>   every Rust binary I tried it on.
> - Built and tested on x86-64 with a 7.0 kernel.
> 
> The series is based on perf-tools-next, commit 0ae6fc78c5ce ("perf
> timechart: Remove the unused use_old_power_events variable").
> 
> Michal Pluta (5):
>   perf test demangle: Fail when demangling fails
>   perf symbol: Don't return an unterminated Rust demangle buffer
>   perf symbol: Grow the Rust demangle buffer geometrically
>   perf symbol: Shrink the demangled Rust buffer to fit
>   perf symbol: Move Rust demangling into its own function

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  tools/perf/tests/demangle-java-test.c    |  1 +
>  tools/perf/tests/demangle-rust-v0-test.c | 13 +++++
>  tools/perf/util/symbol.c                 | 60 +++++++++++++++---------
>  3 files changed, 52 insertions(+), 22 deletions(-)
> 
> 
> base-commit: 0ae6fc78c5ce0dfd18d8712a50f0fd4602eff103
> -- 
> 2.43.0
> 
