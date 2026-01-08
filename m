Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F741B4223;
	Thu,  8 Jan 2026 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767900939; cv=none; b=TDXP2GmfGo5xfpSxYXEPkQm7Z5AmHd9k2cFhKBEEz61BD3ICpW0yYXijI9NAtu33jFU9KqVjG2S7Xe7N7R0qaKUZJ6vY5RuLimFtUQv0Lu/cdTt11tifcPwAowe9lS5TD2RA732S+KSYneSBQZ2TiOEuoiv33ivpis80QwXraNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767900939; c=relaxed/simple;
	bh=P/hhm74R6/i1k9NstC7busUW2XXRSZAXhCEns54OewM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6kie3g9R+4GiZ7w3LqsaDoiVzJgAQpCUOEo8zUBIYpv7VVvFrXh/Z5KNUxbbKfuH99Undp4Zf6WRLi+AjP3GeO0rY/8brtKLROYb7p/AnAaiWjftabofKnCGeOnz/BXZVk+QRlHIi1NM/cobHeVKMI6PboQ+vkyfaLERWnfO24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XPqulEbx; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XPqulEbx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767900937; x=1799436937;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P/hhm74R6/i1k9NstC7busUW2XXRSZAXhCEns54OewM=;
  b=XPqulEbxCFR5hY71WIZXX9RzrsPuc9na7eO/LYkwM8epOZxsg3GnhInt
   p/1b5o7v9j30MEgcUcsHivDNKorYAlyjFPD5m2bch2oONqeNRoluBBtAA
   8qY+AyYEsL0jCkgnwmR82iEe17/Khgq3v78eIxup1WpGvL1Ql4CR7KZxe
   qGd16L6eRo6CZilUjS5lRB7LI8Ro3fLldIhje4YLX4d21IwRGnkQtmoFg
   6TzPXW6rSgaYopFm76IneFewblHZJw56r9SO9HnzENzBEX670xnylrCdp
   RQo/yY4VJKVcG5Nh+w0f9Zb/6i2N7U6ILmC709zOrm9trTK6SyueAvV+V
   A==;
X-CSE-ConnectionGUID: AfXAh177QuS8QynDPmTgGw==
X-CSE-MsgGUID: 6VWJkx4kTWGfz/nLcXeXPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="69361015"
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="69361015"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 11:35:37 -0800
X-CSE-ConnectionGUID: hfO5zLnqT7GXZa9AZsZjiA==
X-CSE-MsgGUID: chn7lWtgS8i2uz9JcFwc5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="207817603"
Received: from unknown (HELO [10.241.241.30]) ([10.241.241.30])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 11:35:36 -0800
Message-ID: <18cc180b-7ce0-46d1-a6f6-af9368f3cc40@intel.com>
Date: Thu, 8 Jan 2026 11:35:36 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] perf/x86/intel: Add core PMU support for Novalake
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20251120053431.491677-1-dapeng1.mi@linux.intel.com>
 <20251120053431.491677-6-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20251120053431.491677-6-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/19/2025 9:34 PM, Dapeng Mi wrote:
> This patch enables core PMU support for Novalake, covering both P-core
> and E-core. It includes Arctic Wolf-specific counters, PEBS constraints,
> and the OMR registers table.
> 
> Since Coyote Cove shares the same PMU capabilities as Panther Cove, the
> existing Panther Cove PMU enabling functions are reused for Coyote Cove.
> 
> For detailed information about counter constraints, please refer to
> section 16.3 "COUNTER RESTRICTIONS" in the ISE documentation.
> 
> ISE: https://www.intel.com/content/www/us/en/content-details/869288/intel-architecture-instruction-set-extensions-programming-reference.html
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c | 99 ++++++++++++++++++++++++++++++++++++
>  arch/x86/events/intel/ds.c   | 11 ++++
>  arch/x86/events/perf_event.h |  2 +
>  3 files changed, 112 insertions(+)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 9f2a93fe23df..a3a1e6e670f8 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -232,6 +232,29 @@ static struct event_constraint intel_skt_event_constraints[] __read_mostly = {
>  	EVENT_CONSTRAINT_END
>  };
>  
> +static struct event_constraint intel_arw_event_constraints[] __read_mostly = {
> +	FIXED_EVENT_CONSTRAINT(0x00c0, 0), /* INST_RETIRED.ANY */
> +	FIXED_EVENT_CONSTRAINT(0x003c, 1), /* CPU_CLK_UNHALTED.CORE */
> +	FIXED_EVENT_CONSTRAINT(0x0300, 2), /* pseudo CPU_CLK_UNHALTED.REF */
> +	FIXED_EVENT_CONSTRAINT(0x013c, 2), /* CPU_CLK_UNHALTED.REF_TSC_P */
> +	FIXED_EVENT_CONSTRAINT(0x0073, 4), /* TOPDOWN_BAD_SPECULATION.ALL */
> +	FIXED_EVENT_CONSTRAINT(0x019c, 5), /* TOPDOWN_FE_BOUND.ALL */
> +	FIXED_EVENT_CONSTRAINT(0x02c2, 6), /* TOPDOWN_RETIRING.ALL */
> +	INTEL_UEVENT_CONSTRAINT(0x01b7, 0x1),
> +	INTEL_UEVENT_CONSTRAINT(0x02b7, 0x2),
> +	INTEL_UEVENT_CONSTRAINT(0x04b7, 0x4),
> +	INTEL_UEVENT_CONSTRAINT(0x08b7, 0x8),

Should be these?

INTEL_UEVENT_CONSTRAINT(0x03b7, 0x4),
INTEL_UEVENT_CONSTRAINT(0x04b7, 0x8),

