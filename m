Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233D7221708;
	Thu, 24 Apr 2025 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745490520; cv=none; b=WiF4+ZYE8CmI/v/TY/UBHbWtHIqCEWekHSfKtZdDGABcv+XQt01o9myO3BhTYnoLWE1GmwrCP4gf3fK5lNCdvxb5UXtnAHFe6KuknFuE8Q56oNAML8vG2g0cSUvjVa1s6/xWXwVNdSe/MjlIrFDWlaNdDUPMRoJbkATjyD4j6h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745490520; c=relaxed/simple;
	bh=hDXblrx03//vB6PiCv/UU8OYzAZhW2FSLB1aHzqgNWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIAa2HACvCUizxOTtrqf9NerK6JAuIJyz/79yKRkkN9Zvn9T0nfpa/kX9oF1W6fqtmFhcnoO80FnHbHxNbSUL6XRX2dLIfNxD+s1tNVk0O4lhKyNY/HpTIoWgTRRyswboZk+edXs5mIrkf3XsiHz8tRnPHI0y7Yl0H3SgotODG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74C551063;
	Thu, 24 Apr 2025 03:28:33 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E4A93F66E;
	Thu, 24 Apr 2025 03:28:37 -0700 (PDT)
Date: Thu, 24 Apr 2025 11:28:32 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, arnd@linaro.org,
	Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix arm64 build by generating unistd_64.h
Message-ID: <20250424102832.GL28953@e132581.arm.com>
References: <20250417-james-perf-fix-gen-syscall-v1-1-1d268c923901@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417-james-perf-fix-gen-syscall-v1-1-1d268c923901@linaro.org>

On Thu, Apr 17, 2025 at 02:55:50PM +0100, James Clark wrote:
> Since pulling in the kernel changes in commit 22f72088ffe6 ("tools
> headers: Update the syscall table with the kernel sources"), arm64 is
> no longer using a generic syscall header and generates one from the
> syscall table. Therefore we must also generate the syscall header for
> arm64 before building Perf.
> 
> Add it as a dependency to libperf which uses one syscall number. Perf
> uses more, but as libperf is a dependency of Perf it will be generated
> for both.
> 
> Future platforms that need this will have to add their own syscall-y
> targets in libperf manually. Unfortunately the arch specific files that
> do this (e.g. arch/arm64/include/asm/Kbuild) can't easily be imported
> into the Perf build. But Perf only needs a subset of the generated files
> anyway, so redefining them is probably the correct thing to do.
> 
> Fixes: 22f72088ffe6 ("tools headers: Update the syscall table with the kernel sources")
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>
