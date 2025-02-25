Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EDD18DB04;
	Tue, 25 Feb 2025 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740516268; cv=none; b=kt44mWrAQRJvMLpnhOGhhTKk8FjjLnxMsuCj/iFJxPEOkwQO8olXwHhRyvWM7O9ArL/RhkGgO/jhlPJUsb2cCZvdQDV9iFACNWZimNpTBOTBo5DNsEYh0rRxGWRnuY4/nqPPNMzpTuyP/bpXBbUzOtnqNbkEE8tGWlY0AdXRRrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740516268; c=relaxed/simple;
	bh=8c+cC5lywIS30v3vT3waAuhItMGBSfA5Du7xRmhoqJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1EqR+T5Sq9Swv9QbNzWtEeW5BdDPczqoD26HMh7F26Gwlm9DgVXq14XStB1zUkCDjJLjdiRaz6GIkJD8HVm7o9mgGzFJqXMEMskJJ2bKmXOjS6d0aalDJorJrbAojxYcerm0LQbgHilij+YneJaXfRkPjN8+YYm4PT9lS4Pv6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TtofTuYC; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TtofTuYC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740516268; x=1772052268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8c+cC5lywIS30v3vT3waAuhItMGBSfA5Du7xRmhoqJI=;
  b=TtofTuYC8LTfNGj6QFrbhrCreWjDfaWnwbwL572Yo/8s53MvnFl/XRia
   +yF47CVI//9yWJmL6vM405RRt2pI5Hvj0Opx3seQrIjzWaEC4NZ+1YnBO
   xwGPiVKoMr4+HHNzVZqPcWPnRCRZoii8OfGtoErEjNlq34mTkNeF2Ekq5
   sZK7BF98X9AvKKQr2vjThe+GW+JGez/ufgfAMrUbtipjBBxV25acOQg3G
   uEGor3ZlcP0vB9d7OAoPoxvafMRnF+nZIt8T/VYl0itrj1LcDNkdZIKdf
   hQfvIasa9vrg2/B547DraWnMnsU4xFElPgQIy1C7pSHOF7AO+GNGNoB36
   w==;
X-CSE-ConnectionGUID: 7bY/PndMQ6ecYitA4NRbJw==
X-CSE-MsgGUID: CSYu7yPAQhe6lJXYZd5EBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="52740926"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="52740926"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 12:44:27 -0800
X-CSE-ConnectionGUID: rSzZ/ZARSoCY8G+f2OuarA==
X-CSE-MsgGUID: 1dsOlILYT4+fQu0/yxq8WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="153674298"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 12:44:27 -0800
Date: Tue, 25 Feb 2025 12:44:25 -0800
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
Subject: Re: [Patch v2 15/24] perf/x86/intel: Add SSP register support for
 arch-PEBS
Message-ID: <Z74rqf5V6bfTZxhG@tassilo>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-16-dapeng1.mi@linux.intel.com>
 <20250225115450.GO11590@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225115450.GO11590@noisy.programming.kicks-ass.net>

On Tue, Feb 25, 2025 at 12:54:50PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 18, 2025 at 03:28:09PM +0000, Dapeng Mi wrote:
> 
> > @@ -651,6 +651,16 @@ int x86_pmu_hw_config(struct perf_event *event)
> >  			return -EINVAL;
> >  	}
> >  
> > +	/* sample_regs_user never support SSP register. */
> > +	if (unlikely(event->attr.sample_regs_user & BIT_ULL(PERF_REG_X86_SSP)))
> > +		return -EINVAL;
> 
> We can easily enough read user SSP, no?

Not for multi record PEBS.

Also technically it may not be precise.

-andi
