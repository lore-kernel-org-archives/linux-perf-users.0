Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BFE19E7ED;
	Tue, 25 Feb 2025 20:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740516133; cv=none; b=BbUSTDcJ6Rp8etFgN45mNQhF2tUMisklKTBENjGaq+Z3+cakSCdrA2gvs+B2zPjcUGRE/FqLdR0VuWbqKx15y030lYrCWVVtIS2ySJsSUcIiB5Ah49S+SENKcew5uNtXOGuJREzlmXno7mzgFWdEEXBS2qp/0GJd9tYQcxMHtd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740516133; c=relaxed/simple;
	bh=ckhYU8LrPAZ/0anr7Gf4neqYQxH3wNd17cE78QPhJ+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcecdktijOrW48VHzOYbBfpTJajSGVpXGK8Mt6DKn5ZQQWLy7rVTowOxc5jvo1D9/OXx1kaFpCOIS36h6rPcs6ITKVn68HkYX1P3enxPJc165vsfPTpHvYf7h2kCE0omlgkuMSIQnuB5yZtbiLhPoKRNXqIIu4jQiudfuU8Grew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AtWr8I2Y; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AtWr8I2Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740516132; x=1772052132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ckhYU8LrPAZ/0anr7Gf4neqYQxH3wNd17cE78QPhJ+k=;
  b=AtWr8I2YTiwL4pR+/WAm5qg6FV83HoE+Mj/Sbznc5JGmWxpRNBlHaj+w
   Ro2Au0eHbZciuw7gtCbtt96mbaAVqOXhX7j8SuUcIVfvVFD8W9KK5SxFk
   GAHVUwHBDSQs2WZv8UcEQlx0VxBbgSxw3rTQ7RMfsT0qXzeCQCtL/MjrX
   gydeCHnEBf9qmiSKpczk31l7c/Mkmsx6ZUUMobFMdQMlcDdDeKkVO9QzV
   namPierl0fYNZrPmpuL5ExkGGVwWNrwHNaXhfSANNXl0oo5wZcsbeVr0Y
   0jujk8NKroImumaSd1cRZqOgtBZd5XeqnbDJtmHHnMAlwmyTY7WlfyFQX
   g==;
X-CSE-ConnectionGUID: AuGaBBqpR3i41nJnl/nXuQ==
X-CSE-MsgGUID: pdeG4R/JRditPRDhx/gDhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41471084"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="41471084"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 12:42:10 -0800
X-CSE-ConnectionGUID: BA4QflZnTj+m7DiH8XxtHg==
X-CSE-MsgGUID: C9UBZuBdRoi+xcIt/OjHtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116992546"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 12:42:10 -0800
Date: Tue, 25 Feb 2025 12:42:09 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v2 10/24] perf/x86/intel: Process arch-PEBS records or
 record fragments
Message-ID: <Z74rIURjU6cweJDo@tassilo>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-11-dapeng1.mi@linux.intel.com>
 <20250225103927.GJ11590@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225103927.GJ11590@noisy.programming.kicks-ass.net>

> >  
> > +	/*
> > +	 * Arch PEBS sets bit 54 in the global status register
> > +	 */
> > +	if (__test_and_clear_bit(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT,
> > +				 (unsigned long *)&status)) {
> 
> Will arch_pebs hardware ever toggle bit 62?

No it won't.

-Andi
