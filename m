Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BD233EAF3;
	Tue, 10 Feb 2026 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770714669; cv=none; b=Hst47emdqEcCrucKvDynN8lS9uvRaSNcZFX8H3B0S/RczFUt0RquUe9lsWVU6+9npYitvjoh0hm9J8FBf7E+B+BpD35bBVlhLvnSytmNDlXOBqwg4gHCQsZbsCzO7RQaePfzXSiofq+yG2hZQebByO+ryXEfQhm0pXnrRhhjTKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770714669; c=relaxed/simple;
	bh=SAFEtn0oPBQFuop8GlhhTwLocZvOngE4cToWB3SAAlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFRgSOJpQupTxyAmCl+6XreDATRCaZ/JIBN/xD+VpiTwaToyQvzgASj5/b4LhvCRgyJPWji3VgC318pPW+w/ga+zLfzDnJIqquOi6sv+UXK5dkx3+6vbXzXxjxLZJ9ZbEvb+xFpOFj5C/a9ev24/TGdb9lxDmY0L838RoRHPRRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E2EE497;
	Tue, 10 Feb 2026 01:11:01 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D3C03F740;
	Tue, 10 Feb 2026 01:11:06 -0800 (PST)
Date: Tue, 10 Feb 2026 09:11:04 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, james.clark@linaro.org,
	jolsa@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	namhyung@kernel.org, peterz@infradead.org
Subject: Re: [PATCH v1] perf metricgroup: Fix
 metricgroup__has_metric_or_groups
Message-ID: <20260210091104.GN3529712@e132581.arm.com>
References: <CAP-5=fXPsOuqr+4DZmscoWGr1VHHJci4jRGxbOtJyy_Mp9Oa9w@mail.gmail.com>
 <20260207004956.610458-1-irogers@google.com>
 <20260209092200.GK3529712@e132581.arm.com>
 <CAP-5=fV7yYP2x-4MgWFbXOH1_kHjQmYm8TCD=a3cshUDZR00LQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV7yYP2x-4MgWFbXOH1_kHjQmYm8TCD=a3cshUDZR00LQ@mail.gmail.com>

On Mon, Feb 09, 2026 at 03:06:27PM -0800, Ian Rogers wrote:
> On Mon, Feb 9, 2026 at 1:22 AM Leo Yan <leo.yan@arm.com> wrote:
> >
> > On Fri, Feb 06, 2026 at 04:49:56PM -0800, Ian Rogers wrote:
> > > Use metricgroup__for_each_metric rather than
> > > pmu_metrics_table__for_each_metric that combines the default metric
> > > table with, a potentially empty, CPUID table.
> > >
> > > Fixes: cee275edcdb1 ("perf metricgroup: Don't early exit if no CPUID table exists")
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Reviewed-by: Leo Yan <leo.yan@arm.com>
> > Tested-by: Leo Yan <leo.yan@arm.com>
> 
> Thanks! Sorry again for the earlier confusion on this.

No worries, thanks for quick fix.
