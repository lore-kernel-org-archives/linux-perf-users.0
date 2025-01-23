Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882891885AD;
	Thu, 23 Jan 2025 18:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737658707; cv=none; b=aK3tjq85+VJbg1WMQ8z65q0IgFZKpmhyCMJVEU/H/i1U29jbaBiecyDpqKep3bgbLwrkj4l5cj43TEOfCwisVvHfhBFmHnketMo/qh2rvZYrOR+ZBTCSihB6xHrc6lfFv62ROfFRCZ808GDaCCXEV0cK5OZxL7kjO8Yd7or9KUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737658707; c=relaxed/simple;
	bh=ssFaE3DbKdJkn6b81JM0pBOqR/aoR4Q6YZ8zi+3ihZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCVCiIUuRUonA/mU+ijIVKqh8TpH+/BSGJzZ5hioOzzt8nb8fojN2kc815jAQvsFjdQdVfjRH6xpKvnuIJcThlV0ZAXWUjnZ1kPinGmIvWOwWNMZFXk84PpM7vHW8UaTcke9ImOeSVQf+qMa0rdAZgM1/yhqw5gRlCfmrujmJaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eHYW8mh6; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eHYW8mh6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737658706; x=1769194706;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ssFaE3DbKdJkn6b81JM0pBOqR/aoR4Q6YZ8zi+3ihZw=;
  b=eHYW8mh6vs7ucd8s61Ajh7KxFC47XZ0D6UWBrf8vSjqNhG5SO0eFvV73
   4WwGpH33hyNyBmA1rrj2KTn2OVFejF8eHswP72XyJoCmKoO3JmlwkfKC4
   puEBHDYKKYJGfPF1tbUg75B4Vlcen1gzpxiIEAn3VDXWUhUCWtWhHFbyd
   wxWMBSyYPW0m/jExlQlDQjMX1h++3LvaZaD5Nd/oC7VXbiWpXoQruzZ2e
   gixyBvJbIl5YzngLdsliwv2InH5qlYauIPo6fGbIs+t96/GQUFxoa24eN
   vOrIo0prt6qNX7M5O76e73HpI9MxBDm3+h0VBo/HqNDY+/gG8Cki6UmjW
   A==;
X-CSE-ConnectionGUID: jd5yCm/5S7KMTETEE23XFw==
X-CSE-MsgGUID: /HsyzEQIQQ+1vJecBgFV5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="38064888"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="38064888"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 10:58:25 -0800
X-CSE-ConnectionGUID: wGAL0FiFTXSmlPSCMeBB1Q==
X-CSE-MsgGUID: t/2hWCYMSoe+Rq5T5leKbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108425176"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 10:58:25 -0800
Date: Thu, 23 Jan 2025 10:58:23 -0800
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
Subject: Re: [PATCH 03/20] perf/x86/intel: Parse CPUID archPerfmonExt leaves
 for non-hybrid CPUs
Message-ID: <Z5KRT-F7MbTs6g6y@tassilo>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
 <20250123140721.2496639-4-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123140721.2496639-4-dapeng1.mi@linux.intel.com>

> +	/*
> +	 * The archPerfmonExt (0x23) includes an enhanced enumeration of
> +	 * PMU architectural features with a per-core view. For non-hybrid,
> +	 * each core has the same PMU capabilities. It's good enough to
> +	 * update the x86_pmu from the booting CPU. For hybrid, the x86_pmu
> +	 * is used to keep the common capabilities. Still keep the values
> +	 * from the leaf 0xa. The core specific update will be done later
> +	 * when a new type is online.
> +	 */
> +	if (!is_hybrid() && boot_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
> +		update_pmu_cap(NULL);

It seems ugly to have these different code paths. Couldn't non hybrid
use x86_pmu in the same way? I assume it would be a larger patch.

-Andi

