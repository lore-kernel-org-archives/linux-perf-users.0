Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E96495535;
	Wed, 29 Jul 2026 13:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332215; cv=none; b=fkDNRw8xCJCUo+mz4Fb5gnRndCKjsaJy/a77KaHkU0tkpuVYeS7xiEgwrTK4zfEmG9D5lxVyQL9k4rZLznrMtGD4J4a7GH7A5yA+QNc2fH6MG1AUldtXL3vie+wAUGCHTiPQMPeDAZavW+FsC19XzWD8jKEnjr/EGGCLkn3SYJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332215; c=relaxed/simple;
	bh=JcF5jgLPEItViI1aMlbMe7iPgrnakBvzJzKgmdRqaEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pe2SXiNCznq7sq9b0xpxOFipj9aoVM01QEr284eRPtKaF8fVrz0pvGXSzf/dgJLAVZJJNO2ESqiLGAY6c+eVPNe6pPklh43twNRrYIwKX04gG4KfzGn/by60A69M2/mqtqcEWFpb9RWbp0LbP27cR39YEqh/QEkW5n2CzcoPcJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lo4D0GvU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lo4D0GvU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785332208; x=1816868208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JcF5jgLPEItViI1aMlbMe7iPgrnakBvzJzKgmdRqaEM=;
  b=Lo4D0GvU1BxIqZTaZQObEYzM5j7BMbP2Edbl+1eFILy/5RHzjt2n8gMH
   fBx1rBNEEOCCdSiOAyxZqd2Pl+n3C86eOuGAzZwxGVZekFTWMeblyQRT/
   WjiHJAKPNuoiNspv+E3lL75fqG35zIjWiOP/lcd+UegXB3+BUGVLrJRVa
   q6bFjBfjswA5P+c7tmW/ymxbdfie2OmnscDglKq0J/1SPATEOv/tAnDOS
   yb2+EUT6EAcf3un+GJtY6ZtL5jXGhEKwt0cOCl9zZweB+5Jp4pJTv32OR
   PhpakKahG/G5CAMpFfbf3FU596bWHWJfpzkqAmQo0Tcd69EaIrKRIT3DX
   w==;
X-CSE-ConnectionGUID: NfuoWnqEQWCnNhnApTUVxQ==
X-CSE-MsgGUID: cJOLDfILQpSN/9OXMUDSAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="97093718"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="97093718"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 06:36:24 -0700
X-CSE-ConnectionGUID: FFzJcIC6T9Wt9vRdV66jKg==
X-CSE-MsgGUID: 2cuftd+GS22bpskHkr6geA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="298228740"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 06:36:22 -0700
Date: Wed, 29 Jul 2026 21:36:18 +0800
From: "Lai, Yi" <yi1.lai@intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/3] perf/x86/intel/pt: Fix stop/start with no update
Message-ID: <amoB0v9X349e7YY0@ly-workstation>
References: <20260721070254.13557-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721070254.13557-1-adrian.hunter@intel.com>

On Tue, Jul 21, 2026 at 10:02:51AM +0300, Adrian Hunter wrote:
> Hi
> 
> Here is a fix for Intel PT.
> 
> There are 2 preparatory patches with no functional change intended.
> 
> The fix is to prevent nesting of perf_aux_output_begin() which
> triggers the WARNING in perf_aux_output_begin():
> 
> 	nest = READ_ONCE(rb->aux_nest);
> 	/*
> 	 * Nesting is not supported for AUX area, make sure nested
> 	 * writers are caught early
> 	 */
> 	if (WARN_ON_ONCE(nest))
> 		goto err_put;
> 
> The nesting happens when Intel PT gets throttled.  See the patch for more
> details.
> 
> 
> Adrian Hunter (3):
>       perf/x86/intel/pt: Factor out pt_config_enable()
>       perf/x86/intel/pt: Use bitwise access for PERF_HES_STOPPED
>       perf/x86/intel/pt: Fix stop/start with no update
> 
>  arch/x86/events/intel/pt.c | 96 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 65 insertions(+), 31 deletions(-)
> 
>

Applied this series on top of v7.2-rc5. After forcing perf throttling,
the WARNING in perf_aux_output_begin no longer appears.

Tested-by: Yi Lai <yi1.lai@intel.com>

 
> Regards
> Adrian
