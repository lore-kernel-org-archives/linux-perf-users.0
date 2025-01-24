Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45C417C;
	Fri, 24 Jan 2025 05:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737695780; cv=none; b=XdA+QzRAnXgxlaYN0CS2wOSZhrKt5tIOHMa8fvPhvSxFnn+AKtImaLVPyo0ceH4JoR2zSRysNQj+laOxQy1K38m+0HgekSSHDDWteLArRntlfoKwD2OyvyCd6bUj3PzgnRuAsGanZlMHu2CsutvGEPHUDnOSsGOLfNJztxJ3gd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737695780; c=relaxed/simple;
	bh=mVDrOz1ViYJ0lI/iIS0Gfw41BPU5v7fccCdnOdfHvJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+0A50lldkcCXu8zmGu43EFskATFeqmRIrKCdwvDFMXhBjCVn9FvccU/eLgwbr+DecB9nFVUN3nZrf+BmYINrdc5zbybWXQQVGRLbIRfhZLeZ367w77mFMmGbnKsSXerF0uKTRXGfiOBrq3gIwK7UuEGgMn5nhsr4LFJdWw62hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a6p8eRKN; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a6p8eRKN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737695779; x=1769231779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mVDrOz1ViYJ0lI/iIS0Gfw41BPU5v7fccCdnOdfHvJY=;
  b=a6p8eRKNa+NRfnXItrz38CssUTwKQCFz6sP2wvqQUBJ2Ri2CUUfGYAUe
   Z9xDOURDW7ABBGSWkXYbA/pF+bYClsnfOz5bWrlw84rnDWrNBb2wTmHWK
   Q+FtXWcqgAZwxlyz9nB0+BArR7baHqtpK5MBsT7maBcebNwnnG35kUtx6
   FFcSF4LC8CeLtAkSS4hRkCgJiBtj9jml9F9g7nUruqUBri4swlqPQUdes
   Fa7rf+e1FmlN5hCqVu9wcOxozndM4f8VJz7fDz5Jt4F7RJDQlsxCsDRLj
   6oDVVy/tOKMVJRMaa+6aE28GHYgIzWITUfDH8GBTBCmTS3j5BQwVowgut
   Q==;
X-CSE-ConnectionGUID: gqcY2MOjQmiEqEnUc9dNaQ==
X-CSE-MsgGUID: pyBjaUvyT96hBGHQjZHy/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="48728538"
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; 
   d="scan'208";a="48728538"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 21:16:18 -0800
X-CSE-ConnectionGUID: QfEGZ+8uSpipBTqmwWZCpQ==
X-CSE-MsgGUID: ObsqJISoSQm8sIEjJIhQ7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; 
   d="scan'208";a="107674859"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 21:16:18 -0800
Date: Thu, 23 Jan 2025 21:16:17 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [PATCH 13/20] perf/x86/intel: Add SSP register support for
 arch-PEBS
Message-ID: <Z5MiIWZhXpUwQgnG@tassilo>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
 <20250123140721.2496639-14-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123140721.2496639-14-dapeng1.mi@linux.intel.com>

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index f40b03adb5c7..7ed80f01f15d 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -646,6 +646,16 @@ int x86_pmu_hw_config(struct perf_event *event)
>  			return -EINVAL;
>  	}
>  
> +	/* sample_regs_user never support SSP register. */
> +	if (unlikely(event->attr.sample_regs_user & BIT_ULL(PERF_REG_X86_SSP)))
> +		return -EINVAL;

Why not? It's somewhere.

