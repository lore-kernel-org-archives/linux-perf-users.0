Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3033A33CD3
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Nov 2023 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6AkV1eg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6870BC433C8;
	Thu, 23 Nov 2023 14:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700750541;
	bh=mfaBvRhfODG3G//JXKw40tGCkxSfBY+Q43wy4Fkk4fI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q6AkV1egQOR4iwp/oOQIOVMdXVAh6VnMf44ZFxdWRxYcQPdOSem5/kDFtj4RqqbrR
	 DLGrlfnWEXE26WGZheblSS7JJKLf4n0QhwRzEDx05eY7gPTUcgfR+6Q+BfX6sC0avk
	 gSKAI4hu6OxQ/vheUP97V32TMhd0fdhKR38u/S4vEUHX2XmZT37oyM1SWjNddY+BTn
	 9cj7eSax0g9aTJRSYcnGHJV8PSFGcZMhmxfH/ejo7t3gB38ZWyrYg/cGJ9pymjx21p
	 mq6jPFox0f17VWk1o9s8Ohx/vhJCQ/kVoKATYEw7m+zMzyYzdskPKOau1FpBlIFeUb
	 1LKCcDV2IHuaw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 925D740094; Thu, 23 Nov 2023 11:42:18 -0300 (-03)
Date: Thu, 23 Nov 2023 11:42:18 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf auxtrace: Add 'T' itrace option for
 timestamp trace
Message-ID: <ZV9kypSaAZNvaP1X@kernel.org>
References: <20231014074513.1668000-1-leo.yan@linaro.org>
 <20231014074513.1668000-2-leo.yan@linaro.org>
 <8a2ea58f-f835-4d1a-8bd6-3a63b3b0db94@intel.com>
 <ZUlgM8pgf19UeyM9@kernel.org>
 <2940af18-8bcd-4456-a8ed-e77cade1b160@intel.com>
 <20231107094852.GA656098@leoy-yangtze.lan>
 <6fc8bc4c-abc3-45d5-a8c8-045f91adfebf@intel.com>
 <20231107141808.GD656098@leoy-yangtze.lan>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107141808.GD656098@leoy-yangtze.lan>
X-Url: http://acmel.wordpress.com

Em Tue, Nov 07, 2023 at 10:18:08PM +0800, Leo Yan escreveu:
> On Tue, Nov 07, 2023 at 12:16:25PM +0200, Adrian Hunter wrote:
> 
> [...]
> 
> > >>>> "If users know" <- how would users know?  Could the kernel
> > >>>> or tools also figure it out?
> > >>>
> > >>> Adrian, I'm trying to go all the outstanding patches, do you still have
> > >>> any issues with this series?
> > >>
> > >> No, although the question wasn't actually answered.  I presume users
> > >> just have to try the 'T' option and see if it helps.
> > > 
> > > Sometimes, users are software developers in SoC companies, they can
> > > know well for the hardware design but are confused why current
> > > implementation cannot use timestamp trace.  This is the main reason
> > > I sent this patch set.
> > > 
> > > An example hardware platform is DB410c [1], we know its CoreSight can
> > > support timestamp trace, but if without this adding option 'T', we
> > > have no chance to use it due to it its CPU arch is prior to Armv8.4.
> > 
> > perf config might be better than an itrace option, but you decide.
> 
> I understand perf config is a better approach due to users don't need
> to bother inputting options after set it once.  I will look at it and
> respin new patch set.
> 
> Thanks for suggestion!

Thanks, applied.

- Arnaldo
