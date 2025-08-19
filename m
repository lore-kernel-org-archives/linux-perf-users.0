Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05A22236E3;
	Tue, 19 Aug 2025 10:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598530; cv=none; b=N8+SOPlCnMEYurAjpvYg5aYXxzC2vfiHJAMGNdRiVi2hYQIIB9HTquqFyqbPpitndS5pyg60TsKiJDwQn0DJbK7FLQ6tCgOKpy8up08CgvKHCtLsx8KgpmN40jkjImrWEhg9jL9fxu1NZc6JGB4PdDe4lChlN7YbBvVeHLaj9ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598530; c=relaxed/simple;
	bh=vpLOTu6ZuSIscsnYbHpLOnSo0w7zb/mTZyGvaB0D0Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LW6zPCQIAM4m3np0vXCqrCyrxkHXuBIgmXInTDw/8OpWZLR6aFSEICReeXDru3qEwDOA47qj7xpA79+HYKzh19MEf9LnEFLcfpy2k5aSK0A8AZPxIJ+OjSNhRgswWJPYF4HlX+Lj+SUAQW+UOka5MtWTU1v5zGrwG80GAlorOuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtQbQwan; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtQbQwan"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43B9C4CEF1;
	Tue, 19 Aug 2025 10:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755598529;
	bh=vpLOTu6ZuSIscsnYbHpLOnSo0w7zb/mTZyGvaB0D0Mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qtQbQwanw50GY2R5i426Q4AmJOuIULqWkIexyYP0lavMM714U79QUAPNF25KsZdqd
	 woUR3d/4ieMbU5F+mIBwUq6l4lLkHY7bCw+i0/6Zx8mZHeg+K1MKbmoqgRKdY6qy9y
	 SYuErEu27tyQbptl96WEu+GrnLn2ORH9icoda41EGtjQs7wc83DEc1iVDyNHRBQmg3
	 cCHMTa24ZUNpT6L+KoqjHB+iohVWV7pXlBu7eKCIP2giF3/ysBEZLlRNGqFXnq1mS0
	 tZRz47/LMeMQ1dwbg+sUdh5GH6+7ByH23X41etxnlyVNRjWkwCQocixaHUHHdBLBAe
	 eJ0J+HSA74IPg==
Date: Tue, 19 Aug 2025 11:15:22 +0100
From: Will Deacon <will@kernel.org>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm64: Sync ESR_ELx_EC_* macros in
 arm64_exception_types.h with esr.h
Message-ID: <aKROus1HA4ch9XJz@willie-the-truck>
References: <20250814151452.618765-2-ysk@kzalloc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814151452.618765-2-ysk@kzalloc.com>

On Thu, Aug 14, 2025 at 03:14:53PM +0000, Yunseong Kim wrote:
> Update perf util arm64_exception_types.h to match the exception class
> macros defined in tools/arch/arm64/include/asm/esr.h. This ensures
> consistency between perf tooling and the kernel header definitions for
> ESR_ELx_EC_* values.
> 
> Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
> ---
>  tools/perf/arch/arm64/util/arm64_exception_types.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

This looks consistent with asm/esr.h on arm64, so:

Acked-by: Will Deacon <will@kernel.org>

Will
