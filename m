Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88911EB5F8;
	Wed,  6 May 2026 00:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778028857; cv=none; b=EXSxkn7HCvifGsi4dNVCmucZhnhm1lYToF0EPqyHAS7OcDMLv5JSJ/K8LuvgTunBnFxuBQSB91mbW2S1zjXgkGxWQHh52SBCoyOdSSNQW4P2hY+MhO6RFbbjQ/YhrpW4dq6dNflFg6VNj5Vl+iR5WRAhUmOxLWKtWxNAc6v7k2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778028857; c=relaxed/simple;
	bh=tmj5TICtSTE9qWHnoYGRaKx1eiyFc8S8PNzLUajGWYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbpNvfsiIKSKf+lq904EbP7XHDsfkrVc1+RgWD98eIudaM9MOrHZACVCTYmbOXRlosRXNX5jPh8CP4FAcRQLY5NfCrwy+Jx+IMsJ7yGXqmr88G2XGspKCGq3hk+L1X69/3f90mnE0RAHp6g2wnKKS//J6wX9GmSRGEsBTv2CNKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYNNSFnC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYNNSFnC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0545BC2BCB4;
	Wed,  6 May 2026 00:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778028857;
	bh=tmj5TICtSTE9qWHnoYGRaKx1eiyFc8S8PNzLUajGWYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NYNNSFnCBduvY23FDZesF/Sm2Exuw2IP226e5L7LMO1dWQNg/hQ9e5NX00EvRZ69N
	 0OYLwIKNqhqVeKrvgYBNxqXTODyrkPzUBGkfhvgtKiQ7zzOOyE3cwlEJRdcYC532vq
	 YVfTYGFnhCwwVyHHOgLWKGxp4xAcOY6Pud67ce5rGFPJkLHEpGxYXbRM5XGAmDSYPp
	 95G+lqHyizkChYQDCtaY4WCwjgWBWaTfhEP7eKXju2H+4iQBSWFv/y/EBss3Xy+7xu
	 uGecbimBBQBkVP2W374AWaQwR+tZAqXnQqEdcrl7x7vccy6vR2TC4ABz+3ZmBmIkPZ
	 aCb13+rcyw2nA==
Date: Tue, 5 May 2026 21:54:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Zecheng Li <zli94@ncsu.edu>,
	Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/9] [PATCH v5 0/9] perf DWARF: Fix libdw API contract
 violations and crashes
Message-ID: <afqRNoxQXJCVPHZS@x1>
References: <20260503171032.1559338-1-irogers@google.com>
 <20260504081227.2203848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504081227.2203848-1-irogers@google.com>

On Mon, May 04, 2026 at 01:12:18AM -0700, Ian Rogers wrote:
> This patch series addresses a number of DWARF/libdw error-handling
> bugs and contract violations, preventing several real Userspace
> segmentation faults and memory/FD leaks.

> In v5, the series has been extensively restructured and polished based on 
> comprehensive review feedback on v4, focusing on history granularity, 
> bisectability, and defensive styling:

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
