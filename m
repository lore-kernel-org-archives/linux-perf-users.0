Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD6F500953;
	Mon, 12 Jan 2026 05:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768195872; cv=none; b=OEHY4VU4wM/CoAgxB7D+Y5xtfGg4xXBghE6KfHCSwRB9WC59KNhqPmmNMADGWRzrAF6rbBZXB5ogqzOBc+evJn5bN43wSxRSpxDsEoeEXYJpBBzxne8g7NCtFiyZS26vKMxh3XAtLqqXjsRtTZMK1NoXvMNCgLxzJ27AMsYtEs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768195872; c=relaxed/simple;
	bh=COZ3xx86/SVIs4LN5457s78oLtyT3q3n/KIeCDy+AhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1O1q4lL2WEesRLU13E5RUANkzEWYXQmbUadlGkHt8pH2YN8JqEhHmpI7FnPvgoaWifaS4BnayC9nkxPQtsoI/DRwutH6KzdFlUpXm1/NcF46OBhVNv3ZlqyjXnalFIGmfsi9oLTBslw9PFxhLqBOrlCaby75VKiw9V8YN00hZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EoP6oZYb; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EoP6oZYb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768195871; x=1799731871;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=COZ3xx86/SVIs4LN5457s78oLtyT3q3n/KIeCDy+AhY=;
  b=EoP6oZYbcuFD7lAM3fUcIao5VRUyB6kKq1Kjh+xBo1T6rxi1/JKVixfA
   yonkL1GfXiEduoJIXVEsM3sfjNznJC6tAHhq9H2IQf9JdLmP5cdOMUvs4
   LyzZoRP0mJqkBJsfJiDgl6D9VaPD3y2eea2A6LJrIWW3MQQdGXOMdnmUW
   k6PBv0bMNbdFesWXLwHQPCOplWiYgee/swlqybofftJmtjckaWiFI+KAK
   hkPn/D6T0hNd49ZNnvSqmIjuTryJ7Kv9d9rEMJ6XmQWeJXqEcZ3ERALR7
   +bovl1V1/5sTIS1YeO+5+WhW6tGMfN8cl++hntfPbA79G4y3nmylPlf9e
   w==;
X-CSE-ConnectionGUID: GStJhZEGT5W1+y/HEmGE0Q==
X-CSE-MsgGUID: u26r8HhZRKe8qxZwoMCdfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="80831724"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="80831724"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 21:31:10 -0800
X-CSE-ConnectionGUID: EyM0M1K0Sz+pWMhKocmk4Q==
X-CSE-MsgGUID: oTo8+11DRM6MO+ljdzzXUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="204284667"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 21:31:09 -0800
Message-ID: <b79ba06d-ec06-4f8f-85cf-72ea6080b041@linux.intel.com>
Date: Mon, 12 Jan 2026 13:31:06 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/core: make nr_addr_filters attribute static
To: Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: mingo@redhat.co, peterz@infradead.org, namhyung@kernel.org
References: <20260109122732.388307-1-ben.dooks@codethink.co.uk>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260109122732.388307-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/9/2026 8:27 PM, Ben Dooks wrote:
> The 'dev_attr_nr_addr_filters' attribute is not exported
> outside of the kernel/events/core.c file so make it static
> to avoid the following sparse warning:
>
> kernel/events/core.c:12170:1: warning: symbol 'dev_attr_nr_addr_filters' was not declared. Should it be static?
>
> Fixes: 6e855cd4f4b52 ("perf/core: Let userspace know if the PMU supports address filters")
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index dad0d3d2e85f..b79f9be8f074 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -12167,7 +12167,7 @@ static ssize_t nr_addr_filters_show(struct device *dev,
>  
>  	return sysfs_emit(page, "%d\n", pmu->nr_addr_filters);
>  }
> -DEVICE_ATTR_RO(nr_addr_filters);
> +static DEVICE_ATTR_RO(nr_addr_filters);
>  
>  static struct idr pmu_idr;
>  

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


