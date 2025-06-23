Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F554A1A;
	Mon, 23 Jun 2025 01:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750641665; cv=none; b=gJWwN9gHxixKUzvHZC7Ni/wyfJ+R0vkNyrUkKDIz8fu0uJx22MwLRbItFH0IUiLEW6XIzgz7RAjc+EmYoCKzSmhA4JLubyPxg8oZjK1KOSQQNQmY5Kne1VdUrf4k/90MlHiTP+mcw/hAp6pZeCsg+onNLEpvA7B6zRYpncxG55Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750641665; c=relaxed/simple;
	bh=YQo4j3x15T7v26HfoJzITPbZxEGaTgh1N/4jWR7KL5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tvk617HbgNanDY1xfREbQkREj5msFOOCAHb1exLFzx2btdE0fpgCFAqgFt56PFgI6p6G92A7YJe0OT6Exc76pnNLMgkccu9WceoLzyTVSSeuRkcVPZM/SvUhN1IUEI3QJAhubmszR7PuQNmuHMtx6pWIcqNQQwCw0/SUOqHcKYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W7g18+th; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W7g18+th"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750641664; x=1782177664;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YQo4j3x15T7v26HfoJzITPbZxEGaTgh1N/4jWR7KL5Q=;
  b=W7g18+thUrtvRjnCzK6ZBMtNV8FbNEoGXLYl6QeGy2DwV+4f9yRXVBC7
   /m0ZQD68Qkwr1MB04b8czgF+1Mbf6gFvM9CDFowqZiV/vi35bKkWwKTAg
   dGLeQfRYL5G7PWan0y2sskGwSBjx0h/qPcgS8eZZFQUsYAuKchcVBEwWY
   JefezHWmAV6GUfW2vH+9q5dfHsiDb1uwIYIZup4ADrk6cQi3ADf90ASLj
   c52pY8T84Q+kIiqrSLbPFdSIcX2eFyosavK1TUb0c1zQB2vQDqgTAUkBx
   e7dJhYuGRgXUL/EkjTUYrTiKIDsnjcdf9CCyoxg75NdBqjA36RUSm3t35
   w==;
X-CSE-ConnectionGUID: RusfnFiMRwuBWBqpAmDQPg==
X-CSE-MsgGUID: hl3wGX28RLu2LZ1LtqZaFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52706796"
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="52706796"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 18:21:03 -0700
X-CSE-ConnectionGUID: xS0/ds86QJKLnXSoTZZlsQ==
X-CSE-MsgGUID: TRe9/i/ISFek+zEgcFZ7qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="150931104"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.144]) ([10.124.245.144])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 18:20:59 -0700
Message-ID: <72e5e711-9dac-4727-9035-98e1e2a90de4@linux.intel.com>
Date: Mon, 23 Jun 2025 09:20:57 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 09/13] perf/x86/intel: Setup PEBS data configuration
 and enable legacy groups
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
 <20250620103909.1586595-10-dapeng1.mi@linux.intel.com>
 <20250621092718.GU1613376@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250621092718.GU1613376@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 6/21/2025 5:27 PM, Peter Zijlstra wrote:
> On Fri, Jun 20, 2025 at 10:39:05AM +0000, Dapeng Mi wrote:
>> Different with legacy PEBS, arch-PEBS provides per-counter PEBS data
>> configuration by programing MSR IA32_PMC_GPx/FXx_CFG_C MSRs.
>>
>> This patch obtains PEBS data configuration from event attribute and then
>> writes the PEBS data configuration to MSR IA32_PMC_GPx/FXx_CFG_C and
>> enable corresponding PEBS groups.
>>
>> Please notice this patach only enables XMM SIMD regs sampling for
> What's a patach? :-)

Oh, should be "patch". Thanks. 👍


