Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A59308F02;
	Fri,  6 Feb 2026 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770394180; cv=none; b=FTIOeYEwD1ChQlaSrBZda0qN0HDJY1oAaCFS/JTl3BYCUT1eR48JFgFGZn+iEf3/4qYiMiSGvCVaex1psusFl4ABednMZObIJzZLWIAQCaN4tZzFwDcYAByNOrzqdbi4t8r4UBISSkILvozTgHmSYWH1W4eLi0AKoRCqabpj6i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770394180; c=relaxed/simple;
	bh=7G7u7GANv8O4iW4MUwJOeZ1Ay9djYWjowqwNK29KR2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7W9q7XTYetjtPClrv2T9bSLvDREL1mFELGZ2WrzP3sB4Laq4KKJ6CNonBSXYJYEKTTPJ0Su/vML2GOtSCk5R07Fr8FuijWpGtbnFryAmjpWewCOK8wPpduzD1vym5CG/Yl3zGnIP8pwLsD1aVfVX+rbEnC1DcsyKO1tApoI0iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D4D3339;
	Fri,  6 Feb 2026 08:09:33 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36A773F632;
	Fri,  6 Feb 2026 08:09:39 -0800 (PST)
Date: Fri, 6 Feb 2026 16:09:36 +0000
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf tests: build-test coverage for NO_JEVENTS=1
Message-ID: <20260206160936.GG3529712@e132581.arm.com>
References: <20260205183603.459363-1-irogers@google.com>
 <20260206085349.GD3529712@e132581.arm.com>
 <aYYBzYULHaHzMW4n@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYYBzYULHaHzMW4n@x1>

On Fri, Feb 06, 2026 at 11:59:25AM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Feb 06, 2026 at 08:53:49AM +0000, Leo Yan wrote:
> > On Thu, Feb 05, 2026 at 10:36:02AM -0800, Ian Rogers wrote:
> > > Leo reported the NO_JEVENTS=1 build being broken and this highlighted
> > > it being missing from the build-test, add it.
> > 
> > To be clear, I did not say the build is broken.
> > 
> > The issue I reported is that `perf stat` is broken, both with
> > NO_JEVENTS=1 enabled and without that configuration.
> > 
> > With updating the commit log, this patch LGTM:
> 
> I did it and will apply the Reviewed-by to patch 2/2 too, ok?

Yes, this is fine for me.

Just remind, in patch 02, based on test, we only need to apply the
change in metricgroup__parse_groups() for removing the "!table" check.

The change for metricgroup__has_metric_or_groups() is not quite right,
as we should keep the searching metrics with
pmu_metrics_table__default().

Thanks,
Leo
