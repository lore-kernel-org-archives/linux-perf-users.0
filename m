Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD5231B10B;
	Mon,  3 Nov 2025 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183157; cv=none; b=jXnivC7Q+G7buoN2WhHHfo/tNl+S0dphF438j/9aKHNq7L8DPfSEk9RAyOIf++X+4eEChUcGSbnhgNvt3kj/QZtDv9qzzRjWrZmyE756XgTwSn7qoV3nn38svI2pqa6vfbtudePCSbWsPfKLGlczxWnZAP3E7EfIvIPBQsXoW+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183157; c=relaxed/simple;
	bh=bqBgRB7rkcR32TlDYtgJPpXAg7EMKp4wB8pN9vCXBMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuhcC8pMVk2A/CLTe0WG/b9tpWnIL1TunVP3zWVk6f/xpCFgnjREPSf5A1NubPQqR1mpkffD3FhiTnUvMYkXMIhEo+UbVpdItjjKwpkqlIV7Aznnrwr+9u/oXek7q8mYQxRBKw4IDrcTrXpq7GCGYmFH/zc2bry6ksQjqIPFHfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E171A1D14;
	Mon,  3 Nov 2025 07:19:06 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A83C3F66E;
	Mon,  3 Nov 2025 07:19:14 -0800 (PST)
Date: Mon, 3 Nov 2025 15:19:12 +0000
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: Add James Clark as a perf tools reviewer
Message-ID: <20251103151912.GW281971@e132581.arm.com>
References: <aQjCEfiFLJwApdlj@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQjCEfiFLJwApdlj@x1>

On Mon, Nov 03, 2025 at 11:54:09AM -0300, Arnaldo Carvalho de Melo wrote:
> Just FYI, I'm carrying this on the perf tools tree.
> 
> James Clark has been actively reviewing patches and contributing
> to perf tools. Reflect this by adding him as a reviewer in the
> MAINTAINERS file.
> 
> Reviewed-by: James Clark <james.clark@linaro.org>
> Acked-by: Ingo Molnar <mingo@kernel.org>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Well deserved, James. Congrats!

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f6cda468095de127..13a80d4a8b6b67dd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20157,6 +20157,7 @@ R:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
>  R:	Jiri Olsa <jolsa@kernel.org>
>  R:	Ian Rogers <irogers@google.com>
>  R:	Adrian Hunter <adrian.hunter@intel.com>
> +R:	James Clark <james.clark@linaro.org>
>  L:	linux-perf-users@vger.kernel.org
>  L:	linux-kernel@vger.kernel.org
>  S:	Supported
> -- 
> 2.51.0
> 
