Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B09439359;
	Thu, 30 Jul 2026 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785426658; cv=none; b=Y/kBUcWegEx8Oym6lrVeFQl6XRGNpXPXSMijnjSn7exsgwsrdVnG8O18S7m0IHt+gUbwwPgHsyvCzkisJmOKbMgWdUmqYoMkfFCvVxXkXOr2cP96Mkt1ckgXQROwb9YQoavMp6ZsiqM8ZqiKNXfay31OPiyUZ9bZxEspJermujM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785426658; c=relaxed/simple;
	bh=16gH9XyedG6WMa3oA+dd+japHr3epVClFalzr5C9WB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gdjrDKWM5GLgStCLNduS67PxFfRTm7oRCejZGAmcM8NRE1aB0bOEoPuw981MhbUhvmZP/VJZJ+oowfsnvNXtb5BpnXy8GRXy7+qVi6ULNciVZEh4TehG1/K8plJ2jQB3rw9r8HT5aM7JZpMakqXa50sxGrZNgIGuOTwOoaIPCLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SO9f1U76; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SO9f1U76"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785426658; x=1816962658;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=16gH9XyedG6WMa3oA+dd+japHr3epVClFalzr5C9WB0=;
  b=SO9f1U762NjIcpfkkrfErf5tlTJoqZsNMw1NBJzafgKz64yvPDw45Qim
   gBtciJwElMx27+wmZPjn2R0/bijghb2LuWq9+bPoHrW1r2bpwjhHSJKeb
   CBzNcbjnn+rY1hAMt+oh7duZKrntQiVRrQDlUbgR3Q1V1ZC823yyfXXCx
   KziyqILu4/OInpmJ1XwBuCyRozMzDVoALHwt6Ztj1faAiLsHHWAO2WYf1
   bEjfOFavOoLziliNjkdz9ZqtiiqHT0t7HFfrAAkHHEDddRfUU7ilMNGbj
   UDMAB+fPXijRUE5cM2CoAeQE7lR2EvXIhg0JZbRxcDK8dn9I4mgtS5F7a
   Q==;
X-CSE-ConnectionGUID: cuO5lKd8SZKzNRSf21/CQA==
X-CSE-MsgGUID: Dg3TSEI0SOOx2WM12u1XfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="89935729"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="89935729"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 08:50:57 -0700
X-CSE-ConnectionGUID: NQDOFKLdRmGFwI9Cm0+hxg==
X-CSE-MsgGUID: pSfnRvAjTrKbcYfnZy1bLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="259098566"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO [10.125.111.248]) ([10.125.111.248])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 08:50:56 -0700
Message-ID: <bcc6552e-2f88-41fb-947a-3a46057897be@intel.com>
Date: Thu, 30 Jul 2026 08:50:55 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] perf/cxl: Program the requested event group on
 configurable counters
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
 will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net,
 sashiko-bot@kernel.org
References: <20260729145555.3919550-1-dave.jiang@intel.com>
 <20260729145555.3919550-2-dave.jiang@intel.com>
 <20260729232927.0ebdffff@jic23-huawei>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260729232927.0ebdffff@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/29/26 3:29 PM, Jonathan Cameron wrote:
> On Wed, 29 Jul 2026 07:55:47 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> cxl_pmu_get_event_idx() sets *counter_idx for a configurable counter but
>> never sets *event_idx, so hwc->event_base stays 0 and cxl_pmu_event_start()
>> programs event group 0 regardless of the group the user requested.
>>
>> Return the matched capability's event_idx.
>>
>> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
>> Reported-by: sashiko-bot@kernel.org
>> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> One minor thing.  Otherwise LGTM
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> 
>> ---
> 
>>  drivers/perf/cxl_pmu.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
>> index 68a54d97d2a8..e77c0650a7eb 100644
>> --- a/drivers/perf/cxl_pmu.c
>> +++ b/drivers/perf/cxl_pmu.c
>> @@ -552,6 +552,8 @@ static int cxl_pmu_get_event_idx(struct perf_event *event, int *counter_idx,
>>  			return -EINVAL;
>>  
>>  		*counter_idx = i;
>> +		if (event_idx)
> Hmm. We never want to get counter_idx and not event_idx.  Perhaps
> add this check to the one for counter_idx at the top of this scope.

Ok I'll address that.

> 
>> +			*event_idx = pmu_ev->event_idx;
>>  		return 0;
>>  	}
>>  
> 

