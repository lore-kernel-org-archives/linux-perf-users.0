Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC41C43CEED
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787074197; cv=none; b=O4ctp9qEI173F4NQLsTuPqccyvH5cP3C0mm834Qy3FOWh8EukfwYphBj5JAdl5xr0KDVnK669KIDdEm6kMVlXlpPwZb1hatTyoJRNF6xkBGuUxhHqeJbjoapFyowpVAJHZnID+4GSPdUsHtOLpj+eL4fz7Q0xbcX4jFqdK/toRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787074197; c=relaxed/simple;
	bh=FReUGVJIxUhU9k49Iq0QbRMnGIvvkApsthuZ397FvwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wr9GEPTHbFaU6ZmZIBOiZmsbTNknQQy61VcqSmqo+jZJRJalNGbjCKhqqt3QVzdzFyhecD9hWvoy3XeM1RwrkOzM/OykXSHodd2NTzx0IWFDLcEW//G6pQIk0wLgwwC7aEogLGcfgjSB9AkWvhleqM+REM7eskutVeija4CD8z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n62ydiZq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n62ydiZq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787074195; x=1818610195;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FReUGVJIxUhU9k49Iq0QbRMnGIvvkApsthuZ397FvwI=;
  b=n62ydiZqUe8N0G08/y+6xvbY8tfDhlriayO3EWa9zt9G0rgXaFjWhxB/
   CcZULYAThYCZuRJuqixg0SC9NF+UQQZ/S1v0827iaHXFXB2/r9/OFeDnn
   dIHvbz4gS41lL4vRipdnNpEbQt+Zl/tZzk+Za7Nv8OdjCZtrtMmUYj1Fb
   1xlIyoZf2SJzdkUZFwz/C/izFum0iOx3l6zEnY3g7+Em6O6rFI/+GKx4J
   j6YQv3i4FtCc9i1KhtmeSyWVI0UAJAxgCl2snqWu6lFjSCnYMiHRkjPWM
   lSXfBQEEkZxr3o/fQraWBkWlBYKthiLnregfrg9jhRvg14MeCMVp48nKs
   w==;
X-CSE-ConnectionGUID: 6/B+rfwCSSu47U5JR3NT1g==
X-CSE-MsgGUID: wFxerRo9R16aFxHqPGDsMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="86692829"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="86692829"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 10:29:54 -0700
X-CSE-ConnectionGUID: +m99TwzyQLKu2ipVu6si/w==
X-CSE-MsgGUID: USFgGRUDSPaQKppUzDja1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="268797405"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 10:29:54 -0700
Date: Tue, 18 Aug 2026 10:29:52 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Ian Rogers <irogers@google.com>
Cc: Andi Kleen <andi@firstfloor.org>, namhyung@kernel.org, acme@kernel.org,
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@kernel.org>
Subject: Re: [PATCH v1] perf top: Merge hybrid common events
Message-ID: <aoSWkMjxuz3hYr7C@tassilo>
References: <20260813132519.4099508-1-andi@firstfloor.org>
 <CAP-5=fW112qVVdZGNpdRH0n-B2at4ENDjjNv4Hdehn5bEB9BSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fW112qVVdZGNpdRH0n-B2at4ENDjjNv4Hdehn5bEB9BSA@mail.gmail.com>

> Thanks Andi, I agree with the frustration. For an event like
> instructions I would like things merged. Does merging make sense for
> cycles given the different clock frequencies of p-cores and e-cores?

Frequencies are always per core anyways, even on non hybrid systems.

> Should the e-core cycles be scaled for this reason as there are fewer
> cycles within a second compared to a p-core?

No.

> 
> Perhaps we need a new json field to describe the hybrid merge-ability
> of events, say enabled on events like instructions or cache misses.
> Note the legacy events now have JSON descriptions:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/arch/common/common/legacy-hardware.json?h=perf-tools-next

Makes sense. At least for architectural events it's easy.
But I'll also defer it for now.


> 
> It would be nice if this were a generic feature and not just for perf top.

Makes sense, but I would also defer that to a future version.
The utility code is already partly factored out for reuse.


-Andi
