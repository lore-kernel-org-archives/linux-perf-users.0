Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C6F3396E6;
	Mon, 19 Jan 2026 07:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768809479; cv=none; b=JoSMt628ccwffGX/cu1Gf3EaTbsPXBCQbnlUUtKlbcdoH8viFh4uQFDGvm6jFpBcknGu7Haz65+TRYbsxrgvVRv/OZjvghGL7s0ru1UBoNzFEmpe8yy2BDL38MHv7DKDS4TjY0retyeqVPrgmuy0GuWxB+4IUJubnsP89YCQN1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768809479; c=relaxed/simple;
	bh=EgEarnNCNoWw5WMlH/rxxknFABUcg4Vn0fitElKXhf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VThjqQeIjkQSZnMLnlOrZDUL3ZWPQUjR1phlK2Us0A5aJcX3cB+ou7Uvj/wtub2rnzJuiaPy+x42k7SSRtejxTal8LGbhU+pVZ08WtysA8YWlG2iCCnwijLSm/MMbVraj9M8BcK+yhen4ZpRqbcjmykBhsILSZXcuFx1mMV7O+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y9XVSiAn; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y9XVSiAn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768809477; x=1800345477;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EgEarnNCNoWw5WMlH/rxxknFABUcg4Vn0fitElKXhf0=;
  b=Y9XVSiAn8mHKqn0RX9ZHQkr73qM6RdSVSWOTx6FKznNlRoMJs01MfSWr
   eZgabvG9tyZSne0qpc7j9BllCLCbOigEF7gn/DY6F2HDV0bWXWeJ0Wj/R
   Z/G871FITCD9t8aYXV6ISMHQcGhdlfub9gxByFe62rhb8v6ATcdJ7zWHG
   2dXijNmK+LPP7l11nqfAEGi1C7F9a0Toq0LXkNpA8YXShr+MHdczvd7WL
   OUrn2osVjcXl0oAw1zo106bX5PDS20QipmHx3L8ZrrOAMuXtnfITEaoFx
   lOCSphZARlClEDEbBPyEdNt7TFikOHCgalRHvCNSYPNVbAs+TkiZNWsCZ
   w==;
X-CSE-ConnectionGUID: denhMLcXTi2BB+JFalZJNw==
X-CSE-MsgGUID: +b0qpyZdRwSkBu9z1AiucQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="69918933"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="69918933"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:57:52 -0800
X-CSE-ConnectionGUID: CeuIcRSQTRaz2uj5ckl8Bw==
X-CSE-MsgGUID: X4q3YgRaSduSOq+MtqoD2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="205418121"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:57:49 -0800
Message-ID: <ebc19c7f-191e-4e94-bc58-6f431ad5fff6@linux.intel.com>
Date: Mon, 19 Jan 2026 15:57:45 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] perf/amd/ibs: Enable streaming store filter
To: Ravi Bangoria <ravi.bangoria@amd.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>, x86@kernel.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Manali Shukla <manali.shukla@amd.com>,
 Santosh Shukla <santosh.shukla@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
References: <20260116033450.965-1-ravi.bangoria@amd.com>
 <20260116033450.965-11-ravi.bangoria@amd.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260116033450.965-11-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/16/2026 11:34 AM, Ravi Bangoria wrote:
> IBS OP on future hardware supports recording samples only for instructions
> that does streaming store. Like the existing IBS filters, samples pointing
> to instruction which does not cause streaming store are discarded and IBS
> restarts internally.
>
> Example:
>
>   $ perf record -e ibs_op/strmst=1/ -- <workload>
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/events/amd/ibs.c      | 50 ++++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/amd/ibs.h |  3 +-
>  2 files changed, 52 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index a768a82d7ad2..0331bcd82272 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -34,6 +34,7 @@ static u32 ibs_caps;
>  
>  /* attr.config1 */
>  #define IBS_OP_CONFIG1_LDLAT_MASK		(0xFFFULL <<  0)
> +#define IBS_OP_CONFIG1_STRMST_MASK		(    1ULL << 12)
>  
>  #define IBS_FETCH_CONFIG1_FETCHLAT_MASK		(0x7FFULL <<  0)
>  
> @@ -292,6 +293,14 @@ static bool perf_ibs_fetch_lat_event(struct perf_ibs *perf_ibs,
>  	       (event->attr.config1 & IBS_FETCH_CONFIG1_FETCHLAT_MASK);
>  }
>  
> +static bool perf_ibs_strmst_event(struct perf_ibs *perf_ibs,
> +				  struct perf_event *event)
> +{
> +	return perf_ibs == &perf_ibs_op &&
> +	       (ibs_caps & IBS_CAPS_STRMST_RMTSOCKET) &&
> +	       (event->attr.config1 & IBS_OP_CONFIG1_STRMST_MASK);
> +}
> +
>  static int perf_ibs_init(struct perf_event *event)
>  {
>  	struct hw_perf_event *hwc = &event->hw;
> @@ -416,6 +425,15 @@ static int perf_ibs_init(struct perf_event *event)
>  		hwc->extra_reg.config |= fetchlat << 1;
>  	}
>  
> +	if (perf_ibs_strmst_event(perf_ibs, event)) {
> +		u64 strmst = event->attr.config1 & IBS_OP_CONFIG1_STRMST_MASK;
> +
> +		strmst >>= 12;

The right shift can be directly merged into previous sentence, and better
define some macro instead of use these magic numbers.


> +
> +		hwc->extra_reg.reg = perf_ibs->msr2;
> +		hwc->extra_reg.config |= strmst << 3;
> +	}
> +
>  	/*
>  	 * If we modify hwc->sample_period, we also need to update
>  	 * hwc->last_period and hwc->period_left.
> @@ -706,6 +724,8 @@ PMU_EVENT_ATTR_STRING(ldlat, ibs_op_ldlat_cap, "1");
>  PMU_EVENT_ATTR_STRING(dtlb_pgsize, ibs_op_dtlb_pgsize_cap, "1");
>  PMU_EVENT_ATTR_STRING(fetchlat, ibs_fetch_lat_format, "config1:0-10");
>  PMU_EVENT_ATTR_STRING(fetchlat, ibs_fetch_lat_cap, "1");
> +PMU_EVENT_ATTR_STRING(strmst, ibs_op_strmst_format, "config1:12");
> +PMU_EVENT_ATTR_STRING(strmst, ibs_op_strmst_cap, "1");
>  
>  static umode_t
>  zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr, int i)
> @@ -719,6 +739,12 @@ ibs_fetch_lat_is_visible(struct kobject *kobj, struct attribute *attr, int i)
>  	return ibs_caps & IBS_CAPS_FETCHLAT ? attr->mode : 0;
>  }
>  
> +static umode_t
> +ibs_op_strmst_is_visible(struct kobject *kobj, struct attribute *attr, int i)
> +{
> +	return ibs_caps & IBS_CAPS_STRMST_RMTSOCKET ? attr->mode : 0;
> +}
> +
>  static umode_t
>  ibs_op_ldlat_is_visible(struct kobject *kobj, struct attribute *attr, int i)
>  {
> @@ -767,6 +793,11 @@ static struct attribute *ibs_op_dtlb_pgsize_cap_attrs[] = {
>  	NULL,
>  };
>  
> +static struct attribute *ibs_op_strmst_cap_attrs[] = {
> +	&ibs_op_strmst_cap.attr.attr,
> +	NULL,
> +};
> +
>  static struct attribute_group group_fetch_formats = {
>  	.name = "format",
>  	.attrs = fetch_attrs,
> @@ -808,6 +839,12 @@ static struct attribute_group group_ibs_op_dtlb_pgsize_cap = {
>  	.is_visible = ibs_op_dtlb_pgsize_is_visible,
>  };
>  
> +static struct attribute_group group_ibs_op_strmst_cap = {
> +	.name = "caps",
> +	.attrs = ibs_op_strmst_cap_attrs,
> +	.is_visible = ibs_op_strmst_is_visible,
> +};
> +
>  static const struct attribute_group *fetch_attr_groups[] = {
>  	&group_fetch_formats,
>  	&empty_caps_group,
> @@ -853,6 +890,11 @@ static struct attribute *ibs_op_ldlat_format_attrs[] = {
>  	NULL,
>  };
>  
> +static struct attribute *ibs_op_strmst_format_attrs[] = {
> +	&ibs_op_strmst_format.attr.attr,
> +	NULL,
> +};
> +
>  static struct attribute_group group_cnt_ctl = {
>  	.name = "format",
>  	.attrs = cnt_ctl_attrs,
> @@ -877,6 +919,12 @@ static struct attribute_group group_ibs_op_ldlat_format = {
>  	.is_visible = ibs_op_ldlat_is_visible,
>  };
>  
> +static struct attribute_group group_ibs_op_strmst_format = {
> +	.name = "format",
> +	.attrs = ibs_op_strmst_format_attrs,
> +	.is_visible = ibs_op_strmst_is_visible,
> +};
> +
>  static const struct attribute_group *op_attr_update[] = {
>  	&group_cnt_ctl,
>  	&group_op_l3missonly,
> @@ -884,6 +932,8 @@ static const struct attribute_group *op_attr_update[] = {
>  	&group_ibs_op_ldlat_cap,
>  	&group_ibs_op_ldlat_format,
>  	&group_ibs_op_dtlb_pgsize_cap,
> +	&group_ibs_op_strmst_cap,
> +	&group_ibs_op_strmst_format,
>  	NULL,
>  };
>  
> diff --git a/arch/x86/include/asm/amd/ibs.h b/arch/x86/include/asm/amd/ibs.h
> index 3ee5903982c2..b940156b7d23 100644
> --- a/arch/x86/include/asm/amd/ibs.h
> +++ b/arch/x86/include/asm/amd/ibs.h
> @@ -99,7 +99,8 @@ union ibs_op_data2 {
>  			rmt_node:1,	/* 4: destination node */
>  			cache_hit_st:1,	/* 5: cache hit state */
>  			data_src_hi:2,	/* 6-7: data source high */
> -			reserved1:56;	/* 8-63: reserved */
> +			strm_st:1,	/* 8: streaming store */
> +			reserved1:55;	/* 9-63: reserved */
>  	};
>  };
>  
