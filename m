Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424E71E7660;
	Mon, 14 Sep 2026 02:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789354389; cv=none; b=bJkcyBBbi/5pl/0GlM8qkRldgPb1qaeIsIDVRBLtLg8mmp8ObOBe9GWDX/QwnLpeBjlzGZjdrIHuFySlAv+FZJLdRjvxHF5S2dnFM/jOouckdznZ/vFfsuBFheB8unvGf394vPNnjkIz4zxMqpny9K8k0Cvl7+5nT12rrtl1rjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789354389; c=relaxed/simple;
	bh=IFFPvxzokibPXB367pLLouYL6uGDLIMXvpaXrY55m54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DzBrP6GpHsOFUVi4SQ+swJS4uq1FAGbeAMxbs7zQc1U1s7JPRz5erX4HJbINQ2C+ID7ieM97ySYn/7TzIyrvwbG96oef5jvImRJVM49ZnmWI67W4saZRjRQ3CBPDM/Wt3tdzqA6CAU5FP79aWFP0fOdtToXm0v8BrAEQYsUjeUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CP+ekiaS; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CP+ekiaS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789354387; x=1820890387;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IFFPvxzokibPXB367pLLouYL6uGDLIMXvpaXrY55m54=;
  b=CP+ekiaSI2J6RWWRGOraRvc9UxNsE9lkszDoZWQ/FcnnX0Nh1xkevThx
   c+jSC6pe2ENVaxeDqhGsCHWd7OatO7cecCV/eH6XIXZLI4eaZl7Nu5cgM
   ClixIHz2Ej2L/OhuYKWEbm63wb0YsuYEGKwLc7/QdXAjYD4H+ZHI/3N3K
   tEQmkdymHES2RvjKmYbnrA9rUjZCK/hq7k5B1sPmWu2nyEMJkLjBxLlHG
   4EQzPFUAOC7e1ViH/gN7ORa4LBeb0Fl/RdFQo+HckxzoQTo15SWpJGcHG
   CS9+lbfKSEkI/0zucmXS3S48f1bj6fVTzIZ5WpR+lg/20ODWBLM2pgIBT
   w==;
X-CSE-ConnectionGUID: eVLSZos7QqynG4WpbJvmKA==
X-CSE-MsgGUID: prtq4RScTMWKlCQI6HsEkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="100037009"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="100037009"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 19:53:07 -0700
X-CSE-ConnectionGUID: QEQ1xgNSSIy6O9ikDM7PzQ==
X-CSE-MsgGUID: GlaXlsrJS6Oc/zLq/KcAXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="273033343"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 19:53:02 -0700
Message-ID: <49aae020-d5c3-4519-8e99-e65a5b5c5cf5@linux.intel.com>
Date: Mon, 14 Sep 2026 10:52:59 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/6] perf tools: Show memory region in perf-c2c
 subcommand
To: "Falcon, Thomas" <thomas.falcon@intel.com>,
 "acme@kernel.org" <acme@kernel.org>
Cc: "Rogers, Ian" <irogers@google.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "james.clark@linaro.org" <james.clark@linaro.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "Hunter, Adrian" <adrian.hunter@intel.com>,
 "namhyung@kernel.org" <namhyung@kernel.org>,
 "jolsa@kernel.org" <jolsa@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260910194324.98002-1-thomas.falcon@intel.com>
 <20260910194324.98002-5-thomas.falcon@intel.com>
 <6221da3e-38a7-48c2-9588-25338ce7d915@linux.intel.com>
 <8a7ba749c9f190ddcf41bab861ac2f1282774628.camel@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <8a7ba749c9f190ddcf41bab861ac2f1282774628.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/11/2026 11:58 PM, Falcon, Thomas wrote:
> On Fri, 2026-09-11 at 08:50 +0800, Mi, Dapeng wrote:
>> On 9/11/2026 3:43 AM, Thomas Falcon wrote:
>>> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>>
>>> Add memory region field to the cacheline list view to help users
>>> identify the memory region to which the cacheline belongs. The memory
>>> region field was included with the introduction of support for the
>>> Off-module Response facility (OMR) [1] in Intel's Diamond Rapids and
>>> Nova Lake architectures.
>>>
>>> An example of the new perf c2c output including the memory region
>>> field is shown below:
>>>
>>> Shared Data Cache Line Table     (181 entries, sorted on Total HITMs)
>>>        --------------- Cacheline --------------      Tot  ------- Load Hitm -------    Total    Total    Total
>>> Index             Address  Region  Node  PA cnt     Hitm    Total  LclHitm  RmtHitm  records    Loads   Stores
>>>     0  0xffffffffa1658ec0     0x0     0    1302    4.13%      103      103        0     1707     1707        0
>>>     1  0xffffffffa16a9100     0x0     0     991    3.73%       93       93        0     1580     1580       19
>>>     2  0xffffffffa16a91c0     0x0     0      37    3.05%       76       76        0      384      384        4
>>>     3  0xffffffffa0607a00     0x0     0       1    2.65%       66       66        0     1146     1146        5
>>>     4  0xffffffffa16a9200     0x0     0       1    1.72%       43       43        0      174      174        3
>>>     5  0xffffffffa0607a80     0x0     0       1    1.16%       29       29        0      439      439       12
>>>     6  0xffffffffa16aadc0     0x0     0       1    0.72%       18       18        0      158      158        3
>>>     7  0xff30ea3c37934640     N/A     0      51    0.64%       16       16        0       60       60        8
>>>     8  0xff30ea3c373b4640     N/A     0      64    0.48%       12       12        0       69       69       11
>>>     9  0xff30ea3c387b4640     0x0     0      56    0.48%       12       12        0       59       59        9
>>>    10  0xff30ea3c37db4640     N/A     0      49    0.44%       11       11        0       50       50       10
>> It looks good. Thanks.
>>
>>
>>> [1]: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.intel.com/
>>>
>>> Assisted-by: Sashiko:gemini-3.1-pro-preview
>>> Assisted-by: GitHub-Copilot:claude-opus-4-8
>>> Codeveloped-by: Thomas Falcon <thomas.falcon@intel.com>
>> The tag name should be "Co-developed-by" instead of "Codeveloped-by".
>> Besides, the tag should be moved to the place where is after my SoB and
>> before your SoB. :)
> Ah, sorry about that, I will fix it up soon. See further comments below...
>
> ...
>
>>> +static int
>>> +dcacheline_node_mem_region(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
>>> +			   struct hist_entry *he)
>>> +{
>>> +	int width = c2c_width(fmt, hpp, he->hists);
>>> +	struct c2c_hist_entry *c2c_he;
>>> +	unsigned int mem_region;
>>> +	char buf[20];
>>> +
>>> +	c2c_he = container_of(he, struct c2c_hist_entry, he);
>>> +	mem_region = c2c_he->mem_region;
>>> +
>>> +	if (mem_region == PERF_MEM_REGION_NA)
>>> +		scnprintf(buf, sizeof(buf),  "N/A");
>>> +	/* mem_region could only be >= PERF_MEM_REGION_MMIO */
>>> +	else if (mem_region == PERF_MEM_REGION_MMIO)
>>> +		scnprintf(buf, sizeof(buf), "MMIO");
>>> +	else
>>> +		scnprintf(buf, sizeof(buf), "0x%x",
>>> +			  mem_region - PERF_MEM_REGION_MEM0);
>>> +
>>> +	return scnprintf(hpp->buf, hpp->size, "%*s", width, buf);
>>> +}
>> It seems the previous comment is missed? 
>>
>> "Is the mem-region column print guarded by HEADER_MEMORY_RANGES as well?"
>>
>> I'm not quite sure about this, please double check. Thanks.
> Sorry, I missed your two comments below your first regarding developer tags.
>
> If you refer to this change below, dcacheline_mem_region is printed only if c2c.show_mem_region (perf_header__has_feat(&session->header, HEADER_MEMORY_RANGES)) == true, otherwise it is not included in
> output_str. I will update perf-c2c to include cache regions as well to be more consistent with perf-script in a new version and fix the tag mistakes.

Thanks. We need to ensure dcacheline_mem_region is printed only when the
header exists. Other it would cause misleading for users.

If we plan to add cache region in the "region" column, we could need to add
"mem" prefix before the memory region ID which avoids the ambiguity.
Besides, we'd better change the region id to decimal format after adding
the "mem" prefix. 



>
> Tom
>
> -	if (c2c.display != DISPLAY_SNP_PEER)
> -		output_str = "cl_idx,"perf_header__has_feat(&session->header,
> +						HEADER_MEMORY_RANGES);
> +	c2c.show_mem_region = perf_header__has_feat(&session->header,
> +						HEADER_MEMORY_RANGES);
> +	if (c2c.show_mem_region)
> +		dim_dcacheline.header.line[0].span = 3;
> +
> +	if (c2c.display != DISPLAY_SNP_PEER) {
> +		if (asprintf(&output_str,
> +			     "cl_idx,"
>  			     "dcacheline,"
> +			     "%s"
>  			     "dcacheline_node,"
>  			     "dcacheline_count,"
>  			     "percent_costly_snoop,"
> @@ -3285,10 +3346,17 @@ static int perf_c2c__report(int argc, const char **argv)
>  			     "ld_fbhit,ld_l1hit,ld_l2hit,"
>  			     "ld_lclhit,lcl_hitm,"
>  			     "ld_rmthit,rmt_hitm,"
> -			     "dram_lcl,dram_rmt";
> -	else
> -		output_str = "cl_idx,"
> +			     "dram_lcl,dram_rmt",
> +			     c2c.show_mem_region ?
> +			     "dcacheline_mem_region," : "") < 0) {
> +			err = -ENOMEM;
> +			goto out_mem2node;
> +		}
> +	} else {
> +		if (asprintf(&output_str,
> +			     "cl_idx,"
>  			     "dcacheline,"
> +			     "%s"
>  			     "dcacheline_node,"
>  			     "dcacheline_count,"
>  			     "percent_costly_snoop,"
> @@ -3300,7 +3368,13 @@ static int perf_c2c__report(int argc, const char **argv)
>  			     "ld_fbhit,ld_l1hit,ld_l2hit,"
>  			     "ld_lclhit,lcl_hitm,"
>  			     "ld_rmthit,rmt_hitm,"
> -			     "dram_lcl,dram_rmt";
> +			     "dram_lcl,dram_rmt",
> +			     c2c.show_mem_region ?
> +			     "dcacheline_mem_region," : "") < 0) {
> +			err = -ENOMEM;
> +			goto out_mem2node;
> +		}
> +	}
>>
>>> +
>>>  static int offset_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
>>>  			struct hist_entry *he)
>>>  {
>>> @@ -1359,6 +1400,14 @@ static struct c2c_dimension dim_dcacheline_node = {
>>>  	.width		= 4,
>>>  };
>>>  
>>> +static struct c2c_dimension dim_dcacheline_mem_region = {
>>> +	.header		= HEADER_LOW("Region"),
>>> +	.name		= "dcacheline_mem_region",
>>> +	.cmp		= empty_cmp,
>>> +	.entry		= dcacheline_node_mem_region,
>>> +	.width		= 6,
>>> +};
>>> +
>>>  static struct c2c_dimension dim_dcacheline_count = {
>>>  	.header		= HEADER_LOW("PA cnt"),
>>>  	.name		= "dcacheline_count",
>>> @@ -1790,6 +1839,7 @@ static struct c2c_dimension dim_dcacheline_num_empty = {
>>>  
>>>  static struct c2c_dimension *dimensions[] = {
>>>  	&dim_dcacheline,
>>> +	&dim_dcacheline_mem_region,
>>>  	&dim_dcacheline_node,
>>>  	&dim_dcacheline_count,
>>>  	&dim_offset,
>>> @@ -2853,8 +2903,11 @@ static int ui_quirks(void)
>>>  	/* Fix the zero line for dcacheline column. */
>>>  	buf = fill_line(chk_double_cl ? "Double-Cacheline" : "Cacheline",
>>>  				dim_dcacheline.width +
>>> +				(c2c.show_mem_region ?
>>> +					dim_dcacheline_mem_region.width : 0) +
>>>  				dim_dcacheline_node.width +
>>> -				dim_dcacheline_count.width + 4);
>>> +				dim_dcacheline_count.width +
>>> +				(c2c.show_mem_region ? 6 : 4));
>>>  	if (!buf)
>>>  		return -ENOMEM;
>>>  
>>> @@ -3106,7 +3159,8 @@ static int perf_c2c__report(int argc, const char **argv)
>>>  	OPT_END()
>>>  	};
>>>  	int err = 0;
>>> -	const char *output_str, *sort_str = NULL;
>>> +	const char *sort_str = NULL;
>>> +	char *output_str = NULL;
>>>  	struct perf_env *env;
>>>  
>>>  	annotation_options__init();
>>> @@ -3271,9 +3325,16 @@ static int perf_c2c__report(int argc, const char **argv)
>>>  		goto out_mem2node;
>>>  	}
>>>  
>>> -	if (c2c.display != DISPLAY_SNP_PEER)
>>> -		output_str = "cl_idx,"
>>> +	c2c.show_mem_region = perf_header__has_feat(&session->header,
>>> +						HEADER_MEMORY_RANGES);
>>> +	if (c2c.show_mem_region)
>>> +		dim_dcacheline.header.line[0].span = 3;
>>> +
>>> +	if (c2c.display != DISPLAY_SNP_PEER) {
>>> +		if (asprintf(&output_str,
>>> +			     "cl_idx,"
>>>  			     "dcacheline,"
>>> +			     "%s"
>>>  			     "dcacheline_node,"
>>>  			     "dcacheline_count,"
>>>  			     "percent_costly_snoop,"
>>> @@ -3285,10 +3346,17 @@ static int perf_c2c__report(int argc, const char **argv)
>>>  			     "ld_fbhit,ld_l1hit,ld_l2hit,"
>>>  			     "ld_lclhit,lcl_hitm,"
>>>  			     "ld_rmthit,rmt_hitm,"
>>> -			     "dram_lcl,dram_rmt";
>>> -	else
>>> -		output_str = "cl_idx,"
>>> +			     "dram_lcl,dram_rmt",
>>> +			     c2c.show_mem_region ?
>>> +			     "dcacheline_mem_region," : "") < 0) {
>>> +			err = -ENOMEM;
>>> +			goto out_mem2node;
>>> +		}
>>> +	} else {
>>> +		if (asprintf(&output_str,
>>> +			     "cl_idx,"
>>>  			     "dcacheline,"
>>> +			     "%s"
>>>  			     "dcacheline_node,"
>>>  			     "dcacheline_count,"
>>>  			     "percent_costly_snoop,"
>>> @@ -3300,7 +3368,13 @@ static int perf_c2c__report(int argc, const char **argv)
>>>  			     "ld_fbhit,ld_l1hit,ld_l2hit,"
>>>  			     "ld_lclhit,lcl_hitm,"
>>>  			     "ld_rmthit,rmt_hitm,"
>>> -			     "dram_lcl,dram_rmt";
>>> +			     "dram_lcl,dram_rmt",
>>> +			     c2c.show_mem_region ?
>>> +			     "dcacheline_mem_region," : "") < 0) {
>>> +			err = -ENOMEM;
>>> +			goto out_mem2node;
>>> +		}
>>> +	}
>>>  
>>>  	if (c2c.display == DISPLAY_TOT_HITM)
>>>  		sort_str = "tot_hitm";
>>> @@ -3314,7 +3388,7 @@ static int perf_c2c__report(int argc, const char **argv)
>>>  	err = c2c_hists__reinit(&c2c.hists, output_str, sort_str, perf_session__env(session));
>>>  	if (err) {
>>>  		pr_err("Failed to reinitialize hists\n");
>>> -		goto out_mem2node;
>>> +		goto out_str;
>>>  	}
>>>  
>>>  	ui_progress__init(&prog, c2c.hists.hists.nr_entries, "Sorting...");
>>> @@ -3323,17 +3397,19 @@ static int perf_c2c__report(int argc, const char **argv)
>>>  	hists__output_resort_cb(&c2c.hists.hists, &prog, resort_shared_cl_cb);
>>>  	err = hists__iterate_cb(&c2c.hists.hists, resort_cl_cb, perf_session__env(session));
>>>  	if (err)
>>> -		goto out_mem2node;
>>> +		goto out_str;
>>>  
>>>  	ui_progress__finish();
>>>  
>>>  	if (ui_quirks()) {
>>>  		pr_err("failed to setup UI\n");
>>> -		goto out_mem2node;
>>> +		goto out_str;
>>>  	}
>>>  
>>>  	perf_c2c_display(session);
>>>  
>>> +out_str:
>>> +	free(output_str);
>>>  out_mem2node:
>>>  	mem2node__exit(&c2c.mem2node);
>>>  out_session:
>>> diff --git a/tools/perf/util/c2c.h b/tools/perf/util/c2c.h
>>> index 53f024e25d99..f04e78e1a2e3 100644
>>> --- a/tools/perf/util/c2c.h
>>> +++ b/tools/perf/util/c2c.h
>>> @@ -33,6 +33,7 @@ struct c2c_hist_entry {
>>>  	unsigned long		*nodeset;
>>>  	struct c2c_stats	*node_stats;
>>>  	unsigned int		 cacheline_idx;
>>> +	unsigned int		 mem_region;
>>>  
>>>  	struct compute_stats	 cstats;
>>>  
