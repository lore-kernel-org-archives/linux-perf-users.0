Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C632F3623;
	Thu,  8 Jan 2026 22:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767910061; cv=none; b=eYR5qD1wRhG7AjWrarZ1PDzGAKlWCvKouxbIVt49mVyf0XDnC+/DnWy0KlmZVmmIYsEJzHobd8+ua53JfhyCZQ1PuSqVSTuAwcnnnYupbVsgfstDtvFWPuvyQGs9ay1T6WtyP09uVVULqfWbGhLH3V+jlEu07YZBdHAr9YSS1Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767910061; c=relaxed/simple;
	bh=XA1F8ZQy3SAZM8CQ9bPudZSO/2AYK/jiVqRKHtV+8qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgAsJtLMvu05IO8/7e7ZyTRFf8oo2quUvIGSY1Jrtcih8gdBQrE5qVTjdTi++/j4W+jnogls7vRXCfZFiAEDFFITV3/8gygGVmsXEfdA9Kx7Fzb5nje6Jnqa2u7rNXOtEky3EZ5r6NRZQCcR65ilZj6fYpjyKp6gItvKlAjk9Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=knXdA+HA; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="knXdA+HA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767910061; x=1799446061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XA1F8ZQy3SAZM8CQ9bPudZSO/2AYK/jiVqRKHtV+8qI=;
  b=knXdA+HA2PMpTtjzZfx/1BIy+kR8DSJR1Kbrxyu+baQK+8FiXPu+zco9
   Vsaj58Wi9rBOOGm+GqCzLskyAaDiCZIpLLgFKOccxtcAjXVfksBw34lMG
   KBBzfHqtpYeIANuOLpEdJAFI1uT9qR9DhsN6b6iceXEIdjMZA8/cnFDvW
   IOjtmAxmB5flTyDOBJcWEEC6T+9DFMB0g0bbqhRjK4kjGvHiMa+ZBs6wy
   1nKsLgmlKyQJZwccX3FffYlxn7beCdU0cOGJP7G64cqGWopFLE6mTMdhD
   wDJuUvdqhe2KO1dje7mRTbm9neucnzyaAQ1Lpv4tVDtFwogdxh8cTXwnG
   A==;
X-CSE-ConnectionGUID: 7mj8TJBfQTCuMwa6sYsTWg==
X-CSE-MsgGUID: lGpvgo9DTAOBU79zb+/F0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="80744729"
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="80744729"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 14:07:40 -0800
X-CSE-ConnectionGUID: JdCq2IGRTPCNQCw6C/Cn8w==
X-CSE-MsgGUID: Nv+RPMReSfKPsqw2tsXFow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="240807445"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 14:07:39 -0800
Date: Thu, 8 Jan 2026 14:07:35 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v6 3/3] perf stat: Add no-affinity flag
Message-ID: <aWAqpy1LU-uWvXEZ@tassilo>
References: <20260108212652.768875-1-irogers@google.com>
 <20260108212652.768875-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108212652.768875-4-irogers@google.com>

On Thu, Jan 08, 2026 at 01:26:52PM -0800, Ian Rogers wrote:
> Add flag that disables affinity behavior. Using sched_setaffinity to
> place a perf thread on a CPU can avoid certain interprocessor
> interrupts but may introduce a delay due to the scheduling,
> particularly on loaded machines. Add a command line option to disable
> the behavior. This behavior is less present in other tools like `perf
> record`, as it uses a ring buffer and doesn't make repeated system
> calls.

I thought we had agreed that this change isn't needed?

-Andi
