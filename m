Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB7113B780;
	Thu, 27 Jun 2024 22:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719527878; cv=none; b=SNWv88I3rZcr1/vNEXQ+S082QSyPiz8SWf5UPyTKCObqhCCATEGeNukL1prtQ9A/wSY2D++3HNrY/L3BvHGa2WBlRt5qiNmEKbttkz3gfO/7Dtd/axRxJY94SbwkeveoqoOt1N/b4jOy5oo5blyN2vOXNXbkykN7yqjXatJMDyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719527878; c=relaxed/simple;
	bh=itBV6HI5oi4kurURWybWSk7VegMTlxHOqv+b0J6M/Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmZz46CsengHy8j2quFNT7N8WYKjGAtj4oWNWm7bYNJcDtDqJU9ew/+pH53KLjNS6twjw40cZmk7fnLGeaWhuFf6yVuQoe9aMFsTHAn316UzaiYa0VckrOVehIqyL+wG8w750P4eRrtUxK1vmZG2zYpu5MzvunmNnnAaRWwIkzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2N+9Z2m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2N+9Z2m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556ABC2BBFC;
	Thu, 27 Jun 2024 22:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719527878;
	bh=itBV6HI5oi4kurURWybWSk7VegMTlxHOqv+b0J6M/Co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e2N+9Z2mMTu6u6ZowAUe+YVmWa8ZzO/uJsoJ6k1PjJ6bHU5dJQWEpyCx70+S+QDWG
	 Uyl942O2b8rjHZSv2E7l03/KxA6j1X40sc0t4gounub0K+diJ9UrtbV3odyIdO+WJv
	 S+IW/OiPGLx9rO646HKu0AsOfNmqT/hgA2S0M0SxLrwiqnjsAFnrIU3H4fendf6WxW
	 s2FH87RBurgdJ2uDPaeSO6VlgnIDb3G3w5t7uBeg+y71jWbUEySU+ulRvyCnjO5ISr
	 NJUp59c1o3k9pVIY8fQgv7kznCD2UA2FfFNy6fL3Ned5hVdeugE9QJvCFHXSyiXhWm
	 GnxXFNIKwlH7Q==
Date: Thu, 27 Jun 2024 15:37:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Kajol Jain <kjain@linux.ibm.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf arm-spe: Support multiple Arm SPE PMUs
Message-ID: <Zn3pw2oeV-8xmqGt@google.com>
References: <20240623133437.222736-1-leo.yan@arm.com>
 <20240623133437.222736-2-leo.yan@arm.com>
 <CAP-5=fWgGR-L6V5RNNpTHdHyT0wTOqKd3CQ8xQSQDAJ1D2edYA@mail.gmail.com>
 <86fd1484-7b9a-4da3-8e1d-91e5881df832@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86fd1484-7b9a-4da3-8e1d-91e5881df832@arm.com>

Hello Leo,

On Tue, Jun 25, 2024 at 05:49:16PM +0100, Leo Yan wrote:
> Hi Ian,
> 
> On 6/24/24 17:16, Ian Rogers wrote:
> > On Sun, Jun 23, 2024 at 6:34 AM Leo Yan <leo.yan@arm.com> wrote:
> > > 
> > > A platform can have more than one Arm SPE PMU. For example, a system
> > > with multiple clusters may have each cluster enabled with its own Arm
> > > SPE instance. In such case, the PMU devices will be named 'arm_spe_0',
> > > 'arm_spe_1', and so on.
> > > 
> > > Currently, the tool only supports 'arm_spe_0'. This commit extends
> > > support to multiple Arm SPE PMUs by detecting the substring 'arm_spe'.
> > > 
> > > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > > ---
> > >   tools/perf/arch/arm/util/pmu.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
> > > index 8b7cb68ba1a8..29cfa1e427ed 100644
> > > --- a/tools/perf/arch/arm/util/pmu.c
> > > +++ b/tools/perf/arch/arm/util/pmu.c
> > > @@ -27,7 +27,7 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
> > >                  pmu->selectable = true;
> > >                  pmu->is_uncore = false;
> > >                  pmu->perf_event_attr_init_default = arm_spe_pmu_default_config;
> > > -               if (!strcmp(pmu->name, "arm_spe_0"))
> > > +               if (strstr(pmu->name, "arm_spe"))
> > 
> > Why not use strstarts?
> 
> Indeed, strstarts() is better, will spin for this.
> 
> Thank for suggestion.

Probably we need to check the last underscore too to prevent potential
name clashes..

Thanks,
Namhyung

