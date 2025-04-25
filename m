Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695AD191;
	Fri, 25 Apr 2025 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745591510; cv=none; b=tAjHoB6pNhCaFc2VgA4yrK9mYKhVIIvI8glHAlljkthaw8VBPcCSlH+GF9ycfNpUGLJVhw3iHsfp8Qvlw30nLpaCLmPd6pn0llz8zZBwfoH1lIlT7nRL6AMZBCzkgtnVeSlmKEWX4mhU3klYKNcfDnQmukmNLjQOprdJwUR7SlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745591510; c=relaxed/simple;
	bh=UHdGkzvg9C+rC/4JDTJ4Eo9xVcjMOcIroVQ+uX2ZkKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLt6soEe1Fl+K5NPfwosU66XPvuHrNrXaLpiD+IyrQuQrncYyam7+8Db6wVlsb5ES2d1ITRIYVnbwig/NEMbCD1tMhOQ0j9+NlGD4WFP7D390wABZyJ9Wo1iX0OV0pVUOQmXtK0AW85SEDWp2nkxRWONNZSzb/1zmdjp1r25/Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ww7C8ZsK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ww7C8ZsK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF68BC4CEE4;
	Fri, 25 Apr 2025 14:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745591510;
	bh=UHdGkzvg9C+rC/4JDTJ4Eo9xVcjMOcIroVQ+uX2ZkKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ww7C8ZsKD4tFuPg33urvoD8Mi6HYfO7igLvyI8H6RSA+gIkc++dDqq5zwJEOQWHv6
	 IC7d8VGyWZdvJm/a1ysitlAuoZvSUSKnA8tUTRLYTqGqUZlC/66wTgYdFKmvcB09WQ
	 JHu2Hz4tsMcsqLBs7/hJ84NaBVkqZRg+Ng2ZK3iELEQ0YdAhmBGLowiP8ydjfSU8AD
	 Gswte8ufcefAjWDm8BldtUiC8ufT+5PjueQr7huk9eppcvR5bB7mukIuc1ukAqq/PV
	 sJQS1l5L8RtXewhBkUFiTG5rQvslDb2q470IL1jFRf7OuhVVhsP7ifDS0+ayhA/T5N
	 XR90PTymwnXwQ==
Date: Fri, 25 Apr 2025 11:31:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Junhao He <hejunhao3@huawei.com>, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, james.clark@linaro.org, leo.yan@arm.com,
	john.g.garry@oracle.com, will@kernel.org, mike.leach@linaro.org,
	yangyicong@hisilicon.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] perf vendor events arm64: Fill up Desc field for
 Hisi hip08 hha pmu
Message-ID: <aAuc0xx-WqVKH0d3@x1>
References: <20250418070812.3771441-1-hejunhao3@huawei.com>
 <20250418070812.3771441-2-hejunhao3@huawei.com>
 <20250425120654.00007e4c@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425120654.00007e4c@huawei.com>

On Fri, Apr 25, 2025 at 12:06:54PM +0100, Jonathan Cameron wrote:
> On Fri, 18 Apr 2025 15:08:10 +0800
> Junhao He <hejunhao3@huawei.com> wrote:
> 
> > In the same PMU, when some JSON events have the "BriefDescription" field
> > populated while others do not, the cmp_sevent() function will split these
> > two types of events into separate groups. As a result, when using perf
> > list to display events, the two types of events cannot be grouped together
> > in the output.
> > 
> > before patch:
> >  $ perf list pmu
> >  ...
> >  uncore hha:
> >    hisi_sccl1_hha2/sdir-hit/
> >    hisi_sccl1_hha2/sdir-lookup/
> >  ...
> >  uncore hha:
> >    edir-hit
> >       [Count of The number of HHA E-Dir hit operations. Unit: hisi_sccl1_hha2]
> >  ...
> > 
> > after patch:
> >  $ perf list pmu
> >  ...
> >  uncore hha:
> >    edir-hit
> >       [Count of The number of HHA E-Dir hit operations. Unit: hisi_sccl1_hha2]
> >    sdir-hit
> >       [Count of The number of HHA S-Dir hit operations. Unit: hisi_sccl1_hha2]
> >    sdir-lookup
> >       [Count of the number of HHA S-Dir lookup operations. Unit: hisi_sccl1_hha2]
> >  ...
> > 
> > Signed-off-by: Junhao He <hejunhao3@huawei.com>
> > Reviewed-by: James Clark <james.clark@linaro.org>
> One trivial comment inline that might be good to tidy up.

These can come as a follow up patch, I think.

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Applied.

- Arnaldo
