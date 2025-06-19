Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BF628BA89
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Jun 2025 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750350169; cv=none; b=FhzTZRCBdiNYoHwHpW4PtF+S9W1CrMmTAmJLpYeMNH1TEiX7YQ0vpkRs9jpPVgSBZ2n20ODTkb9GI2v3RmJTTDutnNcooYSotiIYbXIu1IF2qUdt7MHungprD0izva91h/LuwT/C94ja1s4LsNZnUfVGKtNzraK8GFY2sRoL+Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750350169; c=relaxed/simple;
	bh=KpOr4LYgQkKAnj5l0bPhgEmwu33YxMtIIwabtUV5rss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxKc+2rw20AZIf9rtTxNF9AGzxF59PPq4SE7pbu8dB0RrRveiamEdAA2DD+38s93F6Ch1F+WUDpFvOGp7mQZlO5OQ2C2E6YiySPnfObcdjHyGaYkuXUrf+sleP/8GZWIWkR6R2tEH7cIoDCieSAKbUzuc2LDHG6LjZCaFv7grZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56773113E;
	Thu, 19 Jun 2025 09:22:27 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E56733F66E;
	Thu, 19 Jun 2025 09:22:46 -0700 (PDT)
Date: Thu, 19 Jun 2025 17:22:44 +0100
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
Subject: Re: [PATCH 01/12] drivers/perf: arm_spe: Store event reserved bits
 in driver data
Message-ID: <20250619162244.GH794930@e132581.arm.com>
References: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-0-6faecf0a8775@arm.com>
 <20250613-arm_spe_support_hitm_overhead_v1_public-v1-1-6faecf0a8775@arm.com>
 <3a833298-10a1-4c6a-8a90-6836c47a1dcb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a833298-10a1-4c6a-8a90-6836c47a1dcb@linaro.org>

On Thu, Jun 19, 2025 at 12:28:27PM +0100, James Clark wrote:

[...]

> > @@ -77,6 +77,7 @@ struct arm_spe_pmu {
> >   	u16					pmsver;
> >   	u16					min_period;
> >   	u16					counter_sz;
> > +	u64					pmsevfr_res0;
> 
> IMO this is a premature optimization and we shouldn't store things that are
> only transformations of some other already stored value. It becomes another
> thing to worry about when it's valid to read and to potentially keep it up
> to date etc.
> 
> It's just one new one now, but eventually you end up with tons of them and
> then someone forgets to update a dependent one when the parent value changes
> and it makes a mess.
> 
> And arm_spe_pmu_event_init() isn't even a particularly hot path.

Makes sense. I will drop this one.

Thanks for suggestions!

Leo
