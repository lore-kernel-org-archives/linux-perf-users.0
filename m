Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E87921E098
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Jun 2025 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750350246; cv=none; b=LT9QrIwfMMjVHhWJxaV4uXQIdsuuFZEBRiqgylOXdBFnx0b39JBcRXzNdJE4I6EwnhZru5Uv3r5mhUo00lHiTPClTuLMg6ILfroxezbJehrOpwZCqTY/9WHeJSxhL0NH1ohxOwC21W8oFfBGkj80bn6qXz78MHOQs05UErQ9X2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750350246; c=relaxed/simple;
	bh=GXIfsnXDemuV63mMSaan2HuVkmH5cBSNRiN6HOVL1zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGWlKeBnSSo9fxfo0fC01iRMV3lVY6+G0RMw1UO2UPp7I3VqFSSktZyTJtkdlc9qARf5OVzfZQkMmD7NdfYgspY54pzSsRDXhwfiM9BQkXlIOXa42KHTgxmqzAjnHz79ILPjD9nu/qYSmviql0a52Hu5l4MNl83RKfyyuGXhcAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D349C113E;
	Thu, 19 Jun 2025 09:23:44 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70F503F66E;
	Thu, 19 Jun 2025 09:24:04 -0700 (PDT)
Date: Thu, 19 Jun 2025 17:24:02 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 02/12] drivers/perf: arm_spe: Expose events capability
Message-ID: <20250619162402.GI794930@e132581.arm.com>
References: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-0-6faecf0a8775@arm.com>
 <20250613-arm_spe_support_hitm_overhead_v1_public-v1-2-6faecf0a8775@arm.com>
 <3431e6e3-a80b-4ce0-94c4-56739a5ed2d9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3431e6e3-a80b-4ce0-94c4-56739a5ed2d9@linaro.org>

On Thu, Jun 19, 2025 at 12:32:16PM +0100, James Clark wrote:

[...]

> > @@ -165,6 +168,7 @@ static struct attribute *arm_spe_pmu_cap_attr[] = {
> >   	SPE_CAP_EXT_ATTR_ENTRY(ernd, SPE_PMU_CAP_ERND),
> >   	SPE_CAP_EXT_ATTR_ENTRY(count_size, SPE_PMU_CAP_CNT_SZ),
> >   	SPE_CAP_EXT_ATTR_ENTRY(min_interval, SPE_PMU_CAP_MIN_IVAL),
> > +	SPE_CAP_EXT_ATTR_ENTRY(events, SPE_PMU_CAP_EVENTS),
> 
> Would "event_filters" be a better name? Technically an SPE version can
> support a filter but the event itself might not be implemented.

Good point!  Will update in next spin.

Thanks,
Leo
