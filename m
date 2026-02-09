Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9E832693E;
	Mon,  9 Feb 2026 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770628931; cv=none; b=BQ1iLW3B1OTojX5XBK+fPsCTiMOTdATc9HZAPG7vM33O2aOIZ2n0pSeNOtTtBIw68U6YrVkM94qZXlW81wgduIqdM6o4Hg8c8s1eOVN87GZ8Fhv9QpKBiO4qt4FqoSe1M8C5gbDyxlcarg84js4D1mzzWLncDn/fVDBm04/ad1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770628931; c=relaxed/simple;
	bh=is6XZzdLAnGYgb4MP+BHsLzzIopClDgVLwx9rtQFUOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afu75w6yDpN/DeDwGRvs/szHqxPAY5+veC0AZv0RbFXenfSnOmnCQO/2M8qHebbgkmvJniY0330QLJXIRsNtH9syTUuIXYOYwagy5+77EdQJtgvm4TLf5/xQdiQdj+awjS2FnNZ+UKSQ8n2D5J/Q6Frn4v14Oez64xkOP9SkMVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B749339;
	Mon,  9 Feb 2026 01:21:57 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CD783F740;
	Mon,  9 Feb 2026 01:22:02 -0800 (PST)
Date: Mon, 9 Feb 2026 09:22:00 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, james.clark@linaro.org,
	jolsa@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	namhyung@kernel.org, peterz@infradead.org
Subject: Re: [PATCH v1] perf metricgroup: Fix
 metricgroup__has_metric_or_groups
Message-ID: <20260209092200.GK3529712@e132581.arm.com>
References: <CAP-5=fXPsOuqr+4DZmscoWGr1VHHJci4jRGxbOtJyy_Mp9Oa9w@mail.gmail.com>
 <20260207004956.610458-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207004956.610458-1-irogers@google.com>

On Fri, Feb 06, 2026 at 04:49:56PM -0800, Ian Rogers wrote:
> Use metricgroup__for_each_metric rather than
> pmu_metrics_table__for_each_metric that combines the default metric
> table with, a potentially empty, CPUID table.
> 
> Fixes: cee275edcdb1 ("perf metricgroup: Don't early exit if no CPUID table exists")
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Leo Yan <leo.yan@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
