Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9D127466;
	Tue, 22 Apr 2025 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745331033; cv=none; b=Ha9RsK4/DQbHv43LmErLEnZ+NPYe6JFLMu3XbcUfVKD5fT9UYUBvBUuVDklzvIZT9eVPD1WgxO5OrxTPwS7/IAhrWfLXZd4yipmMHVlqzVFE33gPUxo3wXO1HefJIdyfdaZoWHL/gRKYZJOplBljIkkwVENB2LaEmsBVtF1r/EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745331033; c=relaxed/simple;
	bh=yDwVPeSL5vw/XBQ/Mqxz+U25iJhOC81+UGwFUpORofs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INYzHonA9F2emRBWPk1v6GjjWncTwPE5H4AexmtYxIUBFheI04IU3ABx/81q6ZGQlu44e+R929n8VFIDyMa36XsvAhdoabMqI4pjdnUQkwQleSCSWJTqD/FxbiLI3L6pmskKkT9do6z4pTiP5IGQef6DUsDGX5V9mOm7hlFSg08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E38D6152B;
	Tue, 22 Apr 2025 07:10:26 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1D853F66E;
	Tue, 22 Apr 2025 07:10:30 -0700 (PDT)
Date: Tue, 22 Apr 2025 15:10:26 +0100
From: Leo Yan <leo.yan@arm.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: James Clark <james.clark@linaro.org>, Yabin Cui <yabinc@google.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>
Subject: Re: [PATCH 1/2] perf: Allow non-contiguous AUX buffer pages via PMU
 capability
Message-ID: <20250422141026.GH28953@e132581.arm.com>
References: <20250421215818.3800081-1-yabinc@google.com>
 <20250421215818.3800081-2-yabinc@google.com>
 <48640298-effa-42d4-9137-a18a51637f03@linaro.org>
 <aAeQcgmL-iqGbG_g@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAeQcgmL-iqGbG_g@gmail.com>

On Tue, Apr 22, 2025 at 02:49:54PM +0200, Ingo Molnar wrote:

[...]

> > Hi Yabin,
> > 
> > I was wondering if this is just the opposite of 
> > PERF_PMU_CAP_AUX_NO_SG, and that order 0 should be used by default 
> > for all devices to solve the issue you describe. Because we already 
> > have PERF_PMU_CAP_AUX_NO_SG for devices that need contiguous pages. 
> > Then I found commit 5768402fd9c6 ("perf/ring_buffer: Use high order 
> > allocations for AUX buffers optimistically") that explains that the 
> > current allocation strategy is an optimization.
> > 
> > Your change seems to decide that for certain devices we want to 
> > optimize for fragmentation rather than performance. If these are 
> > rarely used features specifically when looking at performance should 
> > we not continue to optimize for performance? Or at least make it user 
> > configurable?
> 
> So there seems to be 3 categories:
> 
>  - 1) Must have physically contiguous AUX buffers, it's a hardware ABI. 
>       (PERF_PMU_CAP_AUX_NO_SG for Intel BTS and PT.)
> 
>  - 2) Would be nice to have continguous AUX buffers, for a bit more 
>       performance.
> 
>  - 3) Doesn't really care.
> 
> So we do have #1, and it appears Yabin's usecase is #3?

In Yabin's case, the AUX buffer work as a bounce buffer.  The hardware
trace data is copied by a driver from low level's contiguous buffer to
the AUX buffer.

In this case we cannot benefit much from continguous AUX buffers.

Thanks,
Leo
