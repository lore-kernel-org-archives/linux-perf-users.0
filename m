Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D501DDC0B;
	Thu, 21 Aug 2025 01:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755741105; cv=none; b=jkmeYjzO45vSjIHrSQdpjh9LJyG+rjfXZE6GtqNYW338nYuW2VyFFYdM3fRnDe0eCDOTKoJapun4ItXW7hz2PpcGzraYQvkPHbOJcu1qiNZUYDrS69NUwGoNaFwj0Fi4B6DJ3OPjTrzyARNXdO3rqnP0Egn75jDdUO8JqurMk3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755741105; c=relaxed/simple;
	bh=4AKDPWqATzK1Hsj9qLvg8hUknNHF8JNcg5P0w4J1UCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZ1eyob5gFkHuglZGY+/XE73K8Yf24w87wLhTQGU2/ibVcmMcf5KNGLfwoYsRU6EFkIxndbGd47UfMfdKWVWbb7kHDOLP2dsifJATrxkJkEaUfD0mkpa8lFJFWbtPiGjlqD3W2j/qqwjPT4KSDh9pV10YwPi/t5pdp1MJ4+xMIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GzJwQksa; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GzJwQksa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755741103; x=1787277103;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4AKDPWqATzK1Hsj9qLvg8hUknNHF8JNcg5P0w4J1UCE=;
  b=GzJwQksaBjxw8jVF9vcnhokpRnwQoReT6ZN50z5NE95REMVl+GtSaC0y
   uuwguJuAOeKG0k/aM7IQNxa4GxsminkXWVT8mczmdyQq9G2Inif8s6toJ
   QKGvYo0r+lCF0LP2XORXQJoQ7f1AOvAEzRwuzx4hqWnYYZvk97OaT9QVo
   8A/lonHwL4M8sX1PIh3goxVP/Z33XXiebAgKiVPZtgfC2+ZQw423PQ8Rm
   8xK7iWVDaQwQJ97KPQfKtPPyvxVpgj8ZuSS0GdQ4t2T+jgm198hn5Jfix
   ZkeRQM0W1qrwoZvHijtg5HyPNZtXJ9Ax6SbVA3rlpSE4ES53++OVmOQIB
   w==;
X-CSE-ConnectionGUID: bI4kJQrYQEmVw7iXpawabQ==
X-CSE-MsgGUID: Js1e3nMtQxOOFWzgy/Sg2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="68290614"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="68290614"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 18:51:40 -0700
X-CSE-ConnectionGUID: T8b1BdI7TIiBzajZQD/6hA==
X-CSE-MsgGUID: AWjOEuNzQ7mcc38JzYs6WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="168537534"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 18:51:33 -0700
Date: Wed, 20 Aug 2025 18:51:30 -0700
From: Andi Kleen <ak@linux.intel.com>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [Patch v3 3/7] perf/x86: Check if cpuc->events[*] pointer exists
 before accessing it
Message-ID: <aKZ7omM0-3i72hfr@tassilo>
References: <20250820023032.17128-1-dapeng1.mi@linux.intel.com>
 <20250820023032.17128-4-dapeng1.mi@linux.intel.com>
 <aKVD4ATXW4LmhDJm@tassilo>
 <aedbcbb5-f0b4-4bf6-bc33-c8c3bf3f20bc@linux.intel.com>
 <aKVgyV4XWfJGR6uK@tassilo>
 <fab2a035-5ab3-4e24-bd3e-760a4b9be5e8@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fab2a035-5ab3-4e24-bd3e-760a4b9be5e8@linux.intel.com>

On Wed, Aug 20, 2025 at 01:54:17PM +0800, Mi, Dapeng wrote:
> 
> On 8/20/2025 1:44 PM, Andi Kleen wrote:
> >> Andi, I didn't fully get the exact meaning about the "log" here. When
> >> throttle is triggered, perf_event_throttle() has already called
> >> perf_log_throttle() to log the throttle event although only for the group
> >> leader. Is it enough?
> > Throttle normally doesn't involve data loss, just less samples. But this
> > is data loss, so it's an overflow.
> 
> IIUC, there should be no data loss, the unprocessed PEBS records of these
> throttled events would be still processed eventually by calling
> intel_pmu_drain_pebs_buffer() when stopping the event.

Makes sense. Thanks,
-Andi
