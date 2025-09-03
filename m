Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0C01E1E12;
	Wed,  3 Sep 2025 15:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913659; cv=none; b=kEMvQVQ2xKytN+xd1LyqEdR9cGwJ4sVmvoRQwAPqikcHPkr7kdNSaONMGCSJ2VUuObBhCSJp5rF8HC2NbeKd1vL9OmemKOM1ocS0QYndBf13WsgW0cjoOSR9deMjlrgB9HATDbOekZHl0eAZ2ZMESW9lO9vVV70KASeQGnGqvuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913659; c=relaxed/simple;
	bh=wBet7mCa9VG8LA9BJWwoQmQ7KaYw25zY4cKiQVpM2hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnoS0BqLVbcq8f9ZHhCgj7mtjU5YMmpTuyCG/aNBRXVWESor19XgtavX8gXXzmXZoPWGRZodIQpk9SYTRmE0qGKra/knUkIdhYTveBxChOnNNPVCTHw95Z9mrCB+HWhU7GWcbWZQrJHHiAsCxOvtcfhTgvT0Q58Yx0WjQRgBJ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXHnucGW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXHnucGW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538A2C4CEE7;
	Wed,  3 Sep 2025 15:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756913658;
	bh=wBet7mCa9VG8LA9BJWwoQmQ7KaYw25zY4cKiQVpM2hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nXHnucGWb58rN60JPQdQfI4H0ByFbMqVmXO+mMFihjJ47cqY2oqUoGX5vrxrE5p9B
	 +3lx+tsW6sHJ3U4uNCMX9OlWsNnnGUCMDqNWHHnnbwoKPFPDC51J7tPJGCVSeAqVQS
	 kA0JcndCynWf5jqBiPXoW+wwAtQp8vJxO+JeApgkRWhNIhOzw4m4BGxrG8VG0Ofg5d
	 T9fro74z+KpxOLoCf8mxNLYz9yVFPtwTTi22kzn7qAKVz8Zp3w0aGut/OYzqA/X6OW
	 7EXzhR+xVo7G8PUNmRerSmvAk2hUJ7UvX8ZKvgP71ujYlhPfXcAQk3jRFCJvTOPzb5
	 WwXfBysENFX4A==
Date: Wed, 3 Sep 2025 12:34:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2 v6.17-rc] perf tools: read_build_id() blocking
 argument fixes
Message-ID: <aLhf9wc3_1OIFGkZ@x1>
References: <20250903-james-perf-read-build-id-fix-v1-0-6a694d0a980f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-james-perf-read-build-id-fix-v1-0-6a694d0a980f@linaro.org>

On Wed, Sep 03, 2025 at 04:15:25PM +0100, James Clark wrote:
> The function now takes an argument for O_NONBLOCK. The first fix seems
> straightforward. The second one is _probably_ fine, but I can't really
> see any easy way to fix it because libbfd handles all its own IO. Maybe
> we need to compile in both versions of read_build_id() and only call the
> libbfd one on regular files? Or maybe in that specific use case it
> doesn't care, the commit message for adding libbfd there mentioned Wine
> PE binaries.

I noticed that yesterday and have this in the tmp.perf-tools-next
(thought that had sent to the list but didn't) branch:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/?h=tmp.perf-tools-next&id=4bfe653aa3fefd429671aa27413a1124fe65b9d1

But since this affects 6.17, even being opt-in, I think it should go
there together with other patches that Namhyung is collecting in
perf-tools.

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo

> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
> James Clark (2):
>       perf tests: Fix "PE file support" test build
>       perf symbols: Fix HAVE_LIBBFD_BUILDID_SUPPORT build
> 
>  tools/perf/tests/pe-file-parsing.c | 4 ++--
>  tools/perf/util/symbol-elf.c       | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> ---
> base-commit: 07d9df80082b8d1f37e05658371b087cb6738770
> change-id: 20250903-james-perf-read-build-id-fix-0ef6fbce0432
> 
> Best regards,
> -- 
> James Clark <james.clark@linaro.org>
