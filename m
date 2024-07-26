Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119D21EB5B;
	Fri, 26 Jul 2024 14:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004867; cv=none; b=Ppv6dHhNTP28unMLUkerKLYjuHQcszg+iFRqdHS6I1ggRibL2hCfuSjdaDV44U3MPl/P7pDjL9jY7AHOnx9D/MD3ym1LFSHHbAAjUUXNpYo+SbE94NjVrzQKnZIjvUuEt0wjwnU4EvR1fytPcKw+qWKxSgmJjEc6y8URj/d64c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004867; c=relaxed/simple;
	bh=Hd1JL23dFGnnsdWDCsLGIwCVYvzc8IgxEpr1AwQ/8yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Icw19nsTgJUs6wRHBDyOilWPqf/AzrwSFos/t+EXpmj95D4myWT+oDouRd/bP6UHH0sKXQQJKAK5IetAYD9TXsBHUwL/mER45pZkrrfiFT84fzvYh+ltKvmbM1kI8h/F09fqwGU8nJd6iD/Di+gQ98xOwp41PJKyK01slUcpEI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/gaqAEG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/gaqAEG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B00DC32782;
	Fri, 26 Jul 2024 14:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722004866;
	bh=Hd1JL23dFGnnsdWDCsLGIwCVYvzc8IgxEpr1AwQ/8yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k/gaqAEGz71trf62Ions1brmcum60sa9P9+4cGUhvDRYEG1tqVQ8owmjg/LrtTvmy
	 yxrgTQgoiM4DfV//wsgnpBjwj+gFRSIgPgMxYyNdWT3ih3wYlJBYp9ss3pwemfLA3l
	 KqqgaS9yG9SFs7VgiFp9kYT1SnpYXc9fhWOXcnowmSOTjMhYiIrfTLH2ECQZ6jrnKj
	 5VOISAaL4VKHUl2ZxD6rOdLXUXhnOUS+/eIUJ4FAcpRif1z/5moMGrF/nza9MEMtcV
	 JXPQDId8MRJvnyi21nwCwZvBcHZ4veChE7xkWxp/EQW6OaXhMr0/UPvr4+b05f0yDI
	 w6Hd0FsBPhh5g==
Date: Fri, 26 Jul 2024 11:41:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V9 02/13] perf/core: Add aux_pause, aux_resume,
 aux_start_paused
Message-ID: <ZqO1gBIYnLiDpQWv@x1>
References: <20240715160712.127117-1-adrian.hunter@intel.com>
 <20240715160712.127117-3-adrian.hunter@intel.com>
 <20240718093846.GJ26750@noisy.programming.kicks-ass.net>
 <14cd68b2-eeee-42e3-87a6-c12d3814bd51@intel.com>
 <20240718115126.GK26750@noisy.programming.kicks-ass.net>
 <20240718125849.GI28838@noisy.programming.kicks-ass.net>
 <ef63885b-f762-4398-beff-c695b24304e6@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef63885b-f762-4398-beff-c695b24304e6@intel.com>

On Thu, Jul 18, 2024 at 06:06:16PM +0300, Adrian Hunter wrote:
> On 18/07/24 15:58, Peter Zijlstra wrote:
> > On Thu, Jul 18, 2024 at 01:51:26PM +0200, Peter Zijlstra wrote:
> > 
> >> OK, let me do that and make a few more edits and see if I can stare at
> >> that next patch some.
> > 
> > I pushed out a stack of patches into queue.git perf/core
> > Could you please double check I didn't wreck anything?
> 
> Looks fine, and seems to work OK in a brief test.
> 
> Thank you! :-)

So should I go ahead and pick the tooling patches since the kernel bits
are merged?

- Arnaldo
