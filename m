Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49DF69D2B;
	Fri,  4 Jul 2025 01:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751592264; cv=none; b=sIr7qPq0XGGCnNXYkcIRc3AHLIYK3xkXq8S33QXJqD+qkj4IOc/v4i2Xl7rzshyysQEd71jod6pKh+q+oLAD4fbYEfjARoucooDpNz1M9e35Me/iAFoNYQP6pP3ELyWsxa0N71ySlblPISAegxYox0ijsHfhZP9KDscKs7q9/AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751592264; c=relaxed/simple;
	bh=dF36egqC/t2Swga4rX79wblR0NNsN4HUYIsDhe3oWS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=odN1PQrR2GFTld6PfMnCUHlhn5ysAtiAM3hX7oXVU/YDa0LY+564KGtucaM8sFhDZKi5SLPO8CWfuPds9qA+7GpGvc9rP2Hw2l7411089IYtfnECo+330XkBVusVQ9r8z2VrBDdIqg2OOiKWWeVFWfWCGTkUCvxxYkZTtaAZrQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+xoCV4U; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+xoCV4U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751592263; x=1783128263;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=dF36egqC/t2Swga4rX79wblR0NNsN4HUYIsDhe3oWS0=;
  b=J+xoCV4UDs6wq5B2WiPSvtJWqKzH/YBNCNU1nyGepQfXZfwugQncLtY4
   SujzEGd0Nk2dJSpFNsOcOLfPfYkiryItRYlQMxXEZoYOsTnard22ko9GG
   5VIObvj0RvxDHSl2TWKxOrOhPjg/Tgr5lUwUfCTjLfpLKo+LV1vtGcXX3
   6nmuq0uy1fisWSfNXRqBeHTIr5jgDQ7UaGNp8uMUdZdJJSDkuk3aCxrWl
   +dY1/PyRPvN7F7KVvdPQ3mn7i46jsvyAsoko296y8XU+yEWFjj8ou5NaR
   A/05SBq0zha6GASBEkgNvwte4SsNI5nFsuFTv1rtfQc8l5zLH0WTIpxZC
   A==;
X-CSE-ConnectionGUID: rMmRfCRRSZeDYmJ8zZUVyg==
X-CSE-MsgGUID: XED7nto7RuO+ygebL6jLGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="71498396"
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="71498396"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 18:24:22 -0700
X-CSE-ConnectionGUID: OT13baZBRiyfMFCrs+NEQw==
X-CSE-MsgGUID: fudoJxoTTUmUV1hLMRkX7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="153932051"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.37]) ([10.124.240.37])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 18:24:19 -0700
Message-ID: <b77f58ac-17ac-4397-b1de-d6a8ac9793c3@linux.intel.com>
Date: Fri, 4 Jul 2025 09:24:17 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/4] perf: Support Panther Lake uncore
To: kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, irogers@google.com,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20250703165614.606446-1-kan.liang@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250703165614.606446-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/4/2025 12:56 AM, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Changes since V2:
> - Rebase on the later tip.git
>   rdmsrl_safe_on_cpu -> rdmsrq_safe_on_cpu
>
> Starting from the Panther Lake, the uncore discovery table mechanism is
> also introduced into the client platforms. The difference is that the
> portal of the global discovery table is retrieved from an MSR, rather
> than MMIO space.
>
> The first two patches provide a generic support for the extension of the
> uncore discovery table mechanism.
> The rest patches enable the uncore PMU on Panther Lake.
>
> Kan Liang (4):
>   perf/x86/intel/uncore: Support MSR portal for discovery tables
>   perf/x86/intel/uncore: Support customized MMIO map size
>   perf/x86/intel/uncore: Add Panther Lake support
>   perf/x86/intel/uncore: Add iMC freerunning for Panther Lake
>
>  arch/x86/events/intel/uncore.c           |  7 ++
>  arch/x86/events/intel/uncore.h           |  2 +
>  arch/x86/events/intel/uncore_discovery.c | 89 ++++++++++++++++++------
>  arch/x86/events/intel/uncore_discovery.h |  7 ++
>  arch/x86/events/intel/uncore_snb.c       | 79 +++++++++++++++++++++
>  arch/x86/events/intel/uncore_snbep.c     |  4 +-
>  6 files changed, 166 insertions(+), 22 deletions(-)

The whole series looks good to me. Thanks.


