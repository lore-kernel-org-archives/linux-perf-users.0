Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7691171D;
	Fri, 26 Jul 2024 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722005200; cv=none; b=g2T11i1om/w1l27oaSd+kWSWPqspn6/e4us2oAcVxzv1ym8vUV6zTCAmRJFqjJcH17ymxVZU6+kvLjMbBiMyxXVPGZhBx9o0CJkx7gEQ2j71SsWre2FecXDchFtQgz1ZWnnXUklS3FNn1Tc77tcqnfSzN1SFLYm9Z+bwed7ybLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722005200; c=relaxed/simple;
	bh=9LBcqw02wGRos/TDIsMEJykASWkmlRP7kWte1/BH/50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWnIckoqhUoPY3ir+fJc6vRUX8JK2CIzVLOrNT8EQWv/bRkwJD2cMgloqJivJlTvaUMEkWZ0mtGJMrhsze0gCWdQvuAY9WT/LJmeYUamo1s+atNba56QwjCEFBQmJd11RcmTecgQDXAv8zT2dGl9FX6MD7cXgHoRI753hQBi6iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RktiwVqW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RktiwVqW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7964C32782;
	Fri, 26 Jul 2024 14:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722005200;
	bh=9LBcqw02wGRos/TDIsMEJykASWkmlRP7kWte1/BH/50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RktiwVqWIh5eWvnG4ClbvF9u9uSrJegW78Ves0LfcIHFndaFF+4QErxwEy5HGkjJq
	 aCM6SteLpChozlI/BPsFzUchbIPe1bcqj79ziNaz4H+mxC8hkN6E1pPT/dhRrLTFgj
	 4GWm+DfnG4qt+eAEdTT5eAg9Ksxxofsq9kj/Cy/FQe8n5pRSciVchJbG3ndUp+Z+oe
	 cNuAFIGSxAXBmPdwHQxSDn/YAGKk5GJhCBuPDduYgw07fjjyuXC8Hl3LxHQp27Aw9v
	 YMfbkAUaCeCNG/kA/q3548PVsdJVLtf3gFhhpSmbE/m0d7fRiazG8/JqHqABvIY4c1
	 iPgi7ucLDAWVg==
Date: Fri, 26 Jul 2024 11:46:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@redhat.com>,
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
	Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V9 06/13] perf tools: Enable evsel__is_aux_event() to
 work for S390_CPUMSF
Message-ID: <ZqO2zOPI6H-r3Ed8@x1>
References: <20240715160712.127117-1-adrian.hunter@intel.com>
 <20240715160712.127117-7-adrian.hunter@intel.com>
 <dbfae024-c7ce-4311-9f7b-419aacc7e7d9@arm.com>
 <cb2433e2-d6a3-4d70-9b88-0047a9dd01d2@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb2433e2-d6a3-4d70-9b88-0047a9dd01d2@intel.com>

On Tue, Jul 23, 2024 at 12:09:46PM +0300, Adrian Hunter wrote:
> On 23/07/24 11:26, Leo Yan wrote:
> > On 7/15/2024 5:07 PM, Adrian Hunter wrote:
> >>
> >> evsel__is_aux_event() identifies AUX area tracing selected events.
> >>
> >> S390_CPUMSF uses a raw event type (PERF_TYPE_RAW - refer
> >> s390_cpumsf_evsel_is_auxtrace()) not a PMU type value that could be checked
> >> in evsel__is_aux_event(). However it sets needs_auxtrace_mmap (refer
> >> auxtrace_record__init()), so check that first.
> >>
> >> Currently, the features that use evsel__is_aux_event() are used only by
> >> Intel PT, but that may change in the future.
> >>
> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >> Acked-by: Ian Rogers <irogers@google.com>
> >> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> > 
> > Reviewed-by: Leo Yan <leo.yan@arm.com>
> 
> Namhyung, could we get patches 5 and 6 from this series
> applied?  They are independent and Leo's new patch set is
> dependent on patch 5.

I'm getting those two into tmp.perf-tools-next, probably should pick the
rest as peterz has the kernel bits already in his queue.git/perf/core,
right?

- Arnaldo
 
> > 
> >> ---
> >>  tools/perf/util/pmu.c | 6 +++++-
> >>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> >> index 986166bc7c78..0b38c51bd6eb 100644
> >> --- a/tools/perf/util/pmu.c
> >> +++ b/tools/perf/util/pmu.c
> >> @@ -1199,8 +1199,12 @@ void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu)
> >>
> >>  bool evsel__is_aux_event(const struct evsel *evsel)
> >>  {
> >> -       struct perf_pmu *pmu = evsel__find_pmu(evsel);
> >> +       struct perf_pmu *pmu;
> >>
> >> +       if (evsel->needs_auxtrace_mmap)
> >> +               return true;
> >> +
> >> +       pmu = evsel__find_pmu(evsel);
> >>         return pmu && pmu->auxtrace;
> >>  }
> >>
> >> --
> >> 2.34.1
> >>
> >>
