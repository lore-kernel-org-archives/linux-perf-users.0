Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A40FEACD;
	Wed, 20 Aug 2025 03:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755661283; cv=none; b=nl6AlhkCUFXGQrxv1YxVgwvh/cr4IYwVhYh/WjfdaGX1gW6SZbL2e6cQrQ6pA6/HCXZqpiSvWyir/SMDVSYsHgxZEWm+WHM7yK57BSyTuIC5/vEnabRYUUty+FlmVP3ax0+iACfPCAdIwOX+OmUL8+eiJfo5pFOMuz7B+WEe+KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755661283; c=relaxed/simple;
	bh=BYtBIItxQ8/8NKbDlgKsXdYMcCsN52tFIR92Wi3omMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOS5jFWVmw2moZQwN5nxyzArSc3OcjedkyZZqydYxhpE3USs1XNVsK2uaoZa5V/IhrgK3tCyIO4UPd44LaJXfNFprYsVcZbZemZbzY0OzsG0Ez9jk7swCctNagTJ6Om7EMwsZt/UD65ZOuu/gvOJWK0c/LEIatbOcxjXYBkJ5qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T7XnulBD; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T7XnulBD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755661283; x=1787197283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BYtBIItxQ8/8NKbDlgKsXdYMcCsN52tFIR92Wi3omMc=;
  b=T7XnulBDeQu/mgLI9Ix++XixNJuma0l33vZ1HTfWn9VHTl4PirInO1Z9
   g5jOndNIFHyoSl1iTySRkMn8S5B6+SpchSuB2HRmHBFJ4gHPYDADiX1cP
   N+VBXHp3z/n472/VUsCnYSNLKEgcd2eZ0Z6ATyr0z+iKm1yZPOGNYRKgk
   +4Jg+LweRZPKcFEhhAqpZDq8s9sS8sWbH4Mj/bxE//oMFEnulYz7rR5QD
   MCmdtCF9fJQQ0W3w6HhfyWuR467scs5LTX+VMDoxI1bXLxrY6YVnaurz2
   /s5V6ZAeTar/cmBhaB2XD3LSRSw5h7NjQhAsEMwFNYB9g1eqvwRA8N3bs
   g==;
X-CSE-ConnectionGUID: iw7eY7PxQX+q1RTsJI7gzg==
X-CSE-MsgGUID: fs2+yQOZTcm+7VyofhyBxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57872701"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57872701"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 20:41:22 -0700
X-CSE-ConnectionGUID: SDIcRT6JRzOSnsnCMWbh5A==
X-CSE-MsgGUID: aupXOxlORO6M6xh0h/SX5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167240343"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 20:41:22 -0700
Date: Tue, 19 Aug 2025 20:41:20 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
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
Message-ID: <aKVD4ATXW4LmhDJm@tassilo>
References: <20250820023032.17128-1-dapeng1.mi@linux.intel.com>
 <20250820023032.17128-4-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820023032.17128-4-dapeng1.mi@linux.intel.com>

>  		event = cpuc->events[bit];
> +		/*
> +		 * perf_event_overflow() called by below __intel_pmu_pebs_last_event()
> +		 * could trigger interrupt throttle and clear all event pointers of the
> +		 * group in cpuc->events[] to NULL. So need to re-check if cpuc->events[*]
> +		 * is NULL, if so it indicates the event has been throttled (stopped) and
> +		 * the corresponding last PEBS records have been processed in stopping
> +		 * event, don't need to process it again.
> +		 */
> +		if (!event)
> +			continue;

Then we silently ignore the overflow. Would be better to log at least an overflow
packet or something like that.

-Andi

