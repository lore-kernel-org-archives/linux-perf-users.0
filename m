Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22C51F7575;
	Tue, 18 Nov 2025 23:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763507951; cv=none; b=EBrWxc1hPWP5XiqNleImBt0/0S96mWLMU/PURgh++QBSvloSg2qgU5JAQo0+QwmUbKiJLnH4t/cLjFwzeop6QqjqxPBzH4bhb+hlKhI4AJj9SLg/kD09GVEFRrCebVokLPezW7XezB6bbPMZ+qdC1/Pe4EjimFjhL9q+kLkuge8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763507951; c=relaxed/simple;
	bh=Tx2ttj0SiijrBecv7SJgYHcj16qh0ZjLnawjZ00nlkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8dRL3B7S3u5J9pBSwf3LwDzYNX97pRuDuW/QZSp2YkzBCXJzh8nstSq4JgFZlc2EdUjyCNbaK+Z3AgyjItu62lRj44sGIRWPTDH7xpyZPPneOicI492YJGEJ6FoNitf8UYn7OF0c/xnhnYAzFwpUtS4IK92I/VnrOfmzN1C/1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R6W9irJj; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R6W9irJj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763507950; x=1795043950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tx2ttj0SiijrBecv7SJgYHcj16qh0ZjLnawjZ00nlkw=;
  b=R6W9irJj6SrzB7JRLqC4wXMmry833TnnXht394YeZKuSLUd9S+OERz7m
   U6DC3/z4pb6glFXegFwE4O3grk0Z78LAHrQdS5rHcSpeV7LohjARpkJao
   Uvl3FzEbVUnRUibLyqw4V+++b4QLbfi+R7KGH2bcZOlQPPiPqmhFbjhW6
   puyReq71yE6RZmalfyA/UeSoupmCmmbCEIGqx50Jz5Zux0VLCzzQd2HrG
   l9uHEQftxq6y4Q3AV37xlIASS0pTTdm9bbvWrTTDydY0mKXilNg8ur1DQ
   5zrmT98OGmSsudoE1nYFVr98+O77W5eQqamJyYL5PWHNB5Yp/0PAPkIaU
   g==;
X-CSE-ConnectionGUID: c+4fqpfnSmKyl/eCgVhFwg==
X-CSE-MsgGUID: vUE+E6BJRMiPaTRXYiJWRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76896111"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="76896111"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 15:19:08 -0800
X-CSE-ConnectionGUID: 7T45Qrm6TpePfTxpLFZEiQ==
X-CSE-MsgGUID: wrb1CVCUQhaDcNaHNemiSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="190686139"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 15:19:08 -0800
Date: Tue, 18 Nov 2025 15:19:06 -0800
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
Subject: Re: [PATCH v5 3/3] perf stat: Add no-affinity flag
Message-ID: <aRz-6jQf9GH4JROi@tassilo>
References: <20251118211326.1840989-1-irogers@google.com>
 <20251118211326.1840989-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118211326.1840989-4-irogers@google.com>

On Tue, Nov 18, 2025 at 01:13:26PM -0800, Ian Rogers wrote:
> Add flag that disables affinity behavior. Using sched_setaffinity to
> place a perf thread on a CPU can avoid certain interprocessor
> interrupts but may introduce a delay due to the scheduling,
> particularly on loaded machines. Add a command line option to disable
> the behavior. This behavior is less present in other tools like `perf
> record`, as it uses a ring buffer and doesn't make repeated system
> calls.

Like i wrote earlier a much better fix for starvation is to use 
real-time priority instead of the old IPI storms this flag 
is bringing back.

-Andi
