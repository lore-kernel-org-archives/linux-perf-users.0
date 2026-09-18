Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0051366DD3;
	Fri, 18 Sep 2026 01:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789693326; cv=none; b=psXvEPZUDeG6OEReUxiCSQVx8tbufUkcTkc+X+siIEeaDAq9Pa4uP38lR9oVLGrKj7paX9Wz+XvEmkcKOC26t80MaorN0E7JQs3p7ZkdcT6yDKWb7OtnvO0ZqaqNOUIoK7pnasVHe/WnXcGAdSup962NAe6qs7TZkA9sRJkJ/+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789693326; c=relaxed/simple;
	bh=KOYsY0A2ilgDJNb+czbGiVPMvCHkcIK7zmz5QdGcwwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BjgKtDZ0IkMvWUM1OVLr9libOxNri7O7VyVOh8DTK2ix9WpK3NNVHMfDa2sH8SfcwsjG+/XeW5nh+77gQuN1FMhBkALa6JrcuDxQQGj10BQxFnW8BVO6LRtzRvdOdfJ3dRlk3IpWcdiuw8nLoW/QEX4r3SM1LUJQcKD8mKncD+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kcuSQ45Z; arc=none smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kcuSQ45Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789693320; x=1821229320;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KOYsY0A2ilgDJNb+czbGiVPMvCHkcIK7zmz5QdGcwwQ=;
  b=kcuSQ45ZVXfr+KweXMaZZC/0qGfcUoKspAapNr3QjOu57VjA9z6gup05
   4IS8YI85qPmmVXmmDfdrGBmEF+fEOGLSEnKpbqjLRDqDUujv2xNPS/QoH
   OYEMIOWfA+FWNwbYqrtFuhfrD/jLVpfnW3xqZoeEnpIE1ntfMHjI08hQy
   0xLyuL1/1wrz0p0bsOw0lxJByMmadQ/LkAYvSylRnaKjmqD99M/yrmNcZ
   QU5c2rcWnyZK11iHckBXyxopBXxNKUpu7CfYOonffNrNPbDmW8xKHURv5
   ySYSD4gI2MDJj6H3WGsxwqdKVlDEBQUNpvfcqEUkrDthUXfx1jyuSviSC
   Q==;
X-CSE-ConnectionGUID: 9H1ie881SNSibLvi1lKAkQ==
X-CSE-MsgGUID: sEBLZnY+QNiO1YUftfPeqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="686154"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="686154"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 18:01:57 -0700
X-CSE-ConnectionGUID: WoCsRXZ+QO6TlwSqPDAdoQ==
X-CSE-MsgGUID: zkjOhlhLTFKyx3M20/++5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269831659"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 18:01:53 -0700
Message-ID: <01b0627d-6109-4d80-9da7-a061eb47dd03@linux.intel.com>
Date: Fri, 18 Sep 2026 09:01:42 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/6] perf tools: Show memory region in perf-c2c
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
References: <20260916163127.318885-1-thomas.falcon@intel.com>
 <20260916163127.318885-5-thomas.falcon@intel.com>
 <a48ec747-c2d3-496a-9e4e-210352973652@linux.intel.com>
 <7c3de3662c5ea2e746a664b51bb88d7eef8d4b16.camel@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <7c3de3662c5ea2e746a664b51bb88d7eef8d4b16.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/18/2026 1:37 AM, Falcon, Thomas wrote:
> On Thu, 2026-09-17 at 14:04 +0800, Mi, Dapeng wrote:
>> On 9/17/2026 12:31 AM, Thomas Falcon wrote:
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
>>> Shared Data Cache Line Table     (176 entries, sorted on Total HITMs)
>>>        ------------------------ Cacheline -----------------------      Tot  ------- Load Hitm -------    Total    Total    Total
>>> Index             Address                    Region  Node  PA cnt     Hitm    Total  LclHitm  RmtHitm  records    Loads   Stores
>>>     0  0xffffffff98c58ec0                       N/A     0    1208    4.06%       97       97        0     1602     1602        0
>>> ...
>>>   145  0xff332b267b5b3880                     Mem-0     0       1    0.13%        3        3        0       12       12        0
>>>   146  0xff332b267b6b3880        Local-shared-cache     0       1    0.13%        3        3        0       11       11        0
>>>   147  0xff332b267b9b3880                       N/A     0       1    0.13%        3        3        0        8        8        0
>>>   148  0xff332b267ba33880        Other-shared-cache     0       1    0.13%        3        3        0        7        7        0
>>>   149  0xff332b267bab3880        Local-shared-cache     0       1    0.13%        3        3        0        6        6        0
>>>   150  0xff332b267bbb3880                       N/A     0       1    0.13%        3        3        0        8        8        0
>>>   151  0xff332b267bd33880    Local-non-shared-cache     0       1    0.13%        3        3        0       11       11        0
>>>   152  0xff332b267be33880                       N/A     0       3    0.13%        3        3        0       10       10        1
>>>   153  0xff332b267bf33880    Local-non-shared-cache     0       1    0.13%        3        3        0       10       10        0
>>>
>>> [1]: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.intel.com/
>>>
>>> Assisted-by: Sashiko:gemini-3.1-pro-preview
>>> Assisted-by: GitHub-Copilot:claude-opus-4-8
>>> Reviewed-by: Ian Rogers <irogers@google.com>
>>> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>> Co-developed-by: Thomas Falcon <thomas.falcon@intel.com>
>>> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
>>> ---
>>> v10: only update mem_region for real cache/memory regions so N/A samples
>>>      don't overwrite a valid region; add #include <stdio.h> for asprintf
>>>      (Sashiko)
>>> v9: Update perf-c2c to include cache region reporting (Dapeng Mi)
>>> v8: Update developer tags and commit message with real example
>>>     output (Dapeng Mi)
>>> v7: fix output_str allocation error handling which introduced
>>>     a memory leak (Sashiko)
>>> v6: rebased onto 7.3-rc1
>>> v5: make the cacheline header span and ui_quirks() width
>>>     fixup depend on memory-region availability (Namhyung Kim)
>>> v4: correctly handle output_str memory allocation failure
>>> v3: make memory region reporting conditional on feature bit
>>> ---
>>>  tools/perf/builtin-c2c.c | 129 +++++++++++++++++++++++++++++++++++----
>>>  tools/perf/util/c2c.h    |   1 +
>>>  2 files changed, 119 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
>>> index 6b64c0d6b24f..ad3b63acd0ee 100644
>>> --- a/tools/perf/builtin-c2c.c
>>> +++ b/tools/perf/builtin-c2c.c
>>> @@ -14,6 +14,7 @@
>>>  #include <inttypes.h>
>>>  #include <stdlib.h>
>>>  #include <string.h>
>>> +#include <stdio.h>
>>>  
>>>  #include <asm/bug.h>
>>>  #include <linux/compiler.h>
>>> @@ -72,6 +73,7 @@ struct perf_c2c {
>>>  
>>>  	bool			 show_src;
>>>  	bool			 show_all;
>>> +	bool			 show_mem_region;
>>>  	bool			 use_stdio;
>>>  	bool			 stats_only;
>>>  	bool			 symbol_full;
>>> @@ -248,6 +250,18 @@ static void c2c_he__set_node(struct c2c_hist_entry *c2c_he,
>>>  	}
>>>  }
>>>  
>>> +static void c2c_he__set_mem_region(struct c2c_hist_entry *c2c_he,
>>> +				   unsigned int mem_region)
>>> +{
>>> +	if (WARN_ONCE(mem_region > PERF_MEM_REGION_MEM7,
>>> +		      "WARNING: invalid memory region ID\n"))
>>> +		return;
>>> +
>>> +	/* Update mem_region only if it really accesses cache/memory */
>>> +	if (mem_region >= PERF_MEM_REGION_L_SHARE)
>>> +		c2c_he->mem_region = mem_region;
>> This reminds me whether we should avoid the real memory region is
>> overwritten by cache region. Since an address could be sampled multiple
>> times, sometimes it hits in cache and sometimes it misses the cache and
>> need to really access the memory. Keeping the memory region ID if there is
>> makes users know exactly where the address belongs to.
> Would you prefer something like this?
>
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index ad3b63acd0ee..8acf6f632156 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -257,8 +257,14 @@ static void c2c_he__set_mem_region(struct c2c_hist_entry *c2c_he,
>                       "WARNING: invalid memory region ID\n"))
>                 return;
>  
> -       /* Update mem_region only if it really accesses cache/memory */
> -       if (mem_region >= PERF_MEM_REGION_L_SHARE)
> +       /*
> +        * Update mem_region only if it really accesses memory.
> +        * Do not overwrite a memory region with a cache region.
> +        */
> +
> +       if (mem_region >= PERF_MEM_REGION_MMIO ||
> +           (mem_region >= PERF_MEM_REGION_L_SHARE &&
> +            !(c2c_he->mem_region >= PERF_MEM_REGION_MMIO)))
>                 c2c_he->mem_region = mem_region;
>  }

Thanks. But after thinking twice, I suppose I made a wrong suggestion. :(

The c2c page shows the statistical results instead of a single access
result for each certain address. For a certain address, it could be
accessed multiple times, sometimes it hits cache, while sometimes it has to
access the real memory as the cache miss. My original thought is to give
user more cache region info if there is no memory region information. But
since c2c page show the summarized statistical data, it's not reasonable to
show the cache region information of the last access, it would cause
confusion and mislead users.

So the best practice could still only show memory region information here
like the old version does. The memory region can tell users which part of
memory the address belongs to.


> Tom
>> Thanks.
>>
>>
>>> +}
>>> +
>>>  static void compute_stats(struct c2c_hist_entry *c2c_he,
>>>  			  struct c2c_stats *stats,
>>>  			  u64 weight)
>>> @@ -306,6 +320,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>>>  	struct addr_location al;
>>>  	struct mem_info *mi = NULL;
>>>  	struct callchain_cursor *cursor;
>>> +	unsigned int mem_region;
>>>  	int ret;
>>>  
>>>  	addr_location__init(&al);
>>> @@ -333,6 +348,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>>>  	}
>>>  
>>>  	c2c_decode_stats(&stats, mi);
>>> +	mem_region = mem_info__data_src(mi)->mem_region;
>>>  
>>>  	he = hists__add_entry_ops(&c2c_hists->hists, &c2c_entry_ops,
>>>  				  &al, NULL, NULL, mi, NULL,
>>> @@ -349,6 +365,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>>>  	c2c_he__set_cpu(c2c_he, sample);
>>>  	c2c_he__set_node(c2c_he, sample);
>>>  	c2c_he__set_evsel(c2c_he, evsel);
>>> +	c2c_he__set_mem_region(c2c_he, mem_region);
>>>  
>>>  	hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
>>>  
>>> @@ -402,6 +419,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>>>  		c2c_he__set_cpu(c2c_he, sample);
>>>  		c2c_he__set_node(c2c_he, sample);
>>>  		c2c_he__set_evsel(c2c_he, evsel);
>>> +		c2c_he__set_mem_region(c2c_he, mem_region);
>>>  
>>>  		hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
>>>  		ret = hist_entry__append_callchain(he, sample);
>>> @@ -540,6 +558,60 @@ dcacheline_node_count(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
>>>  	return scnprintf(hpp->buf, hpp->size, "%*lu", width, c2c_he->paddr_cnt);
>>>  }
>>>  
>>> +static int
>>> +dcacheline_node_mem_region(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
>>> +			   struct hist_entry *he)
>>> +{
>>> +	int width = c2c_width(fmt, hpp, he->hists);
>>> +	struct c2c_hist_entry *c2c_he;
>>> +	unsigned int mem_region;
>>> +	char buf[30];
>>> +
>>> +	c2c_he = container_of(he, struct c2c_hist_entry, he);
>>> +	mem_region = c2c_he->mem_region;
>>> +
>>> +	switch (mem_region) {
>>> +	case PERF_MEM_REGION_NA:
>>> +	case PERF_MEM_REGION_RSVD:
>>> +		scnprintf(buf, sizeof(buf), "N/A");
>>> +		break;
>>> +	case PERF_MEM_REGION_L_SHARE:
>>> +		scnprintf(buf, sizeof(buf), "Local-shared-cache");
>>> +		break;
>>> +	case PERF_MEM_REGION_L_NON_SHARE:
>>> +		scnprintf(buf, sizeof(buf), "Local-non-shared-cache");
>>> +		break;
>>> +	case PERF_MEM_REGION_O_IO:
>>> +		scnprintf(buf, sizeof(buf), "Other-IO");
>>> +		break;
>>> +	case PERF_MEM_REGION_O_SHARE:
>>> +		scnprintf(buf, sizeof(buf), "Other-shared-cache");
>>> +		break;
>>> +	case PERF_MEM_REGION_O_NON_SHARE:
>>> +		scnprintf(buf, sizeof(buf), "Other-non-shared-cache");
>>> +		break;
>>> +	case PERF_MEM_REGION_MMIO:
>>> +		scnprintf(buf, sizeof(buf), "MMIO");
>>> +		break;
>>> +	case PERF_MEM_REGION_MEM0:
>>> +	case PERF_MEM_REGION_MEM1:
>>> +	case PERF_MEM_REGION_MEM2:
>>> +	case PERF_MEM_REGION_MEM3:
>>> +	case PERF_MEM_REGION_MEM4:
>>> +	case PERF_MEM_REGION_MEM5:
>>> +	case PERF_MEM_REGION_MEM6:
>>> +	case PERF_MEM_REGION_MEM7:
>>> +		scnprintf(buf, sizeof(buf), "Mem-%d",
>>> +			  mem_region - PERF_MEM_REGION_MEM0);
>>> +		break;
>>> +	default:
>>> +		scnprintf(buf, sizeof(buf), "N/A");
>>> +		break;
>>> +	}
>>> +
>>> +	return scnprintf(hpp->buf, hpp->size, "%*s", width, buf);
>>> +}
>>> +
>>>  static int offset_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
>>>  			struct hist_entry *he)
>>>  {
>>> @@ -1360,6 +1432,14 @@ static struct c2c_dimension dim_dcacheline_node = {
>>>  	.width		= 4,
>>>  };
>>>  
>>> +static struct c2c_dimension dim_dcacheline_mem_region = {
>>> +	.header		= HEADER_LOW("Region"),
>>> +	.name		= "dcacheline_mem_region",
>>> +	.cmp		= empty_cmp,
>>> +	.entry		= dcacheline_node_mem_region,
>>> +	.width		= 24,
>>> +};
>>> +
>>>  static struct c2c_dimension dim_dcacheline_count = {
>>>  	.header		= HEADER_LOW("PA cnt"),
>>>  	.name		= "dcacheline_count",
>>> @@ -1791,6 +1871,7 @@ static struct c2c_dimension dim_dcacheline_num_empty = {
>>>  
>>>  static struct c2c_dimension *dimensions[] = {
>>>  	&dim_dcacheline,
>>> +	&dim_dcacheline_mem_region,
>>>  	&dim_dcacheline_node,
>>>  	&dim_dcacheline_count,
>>>  	&dim_offset,
>>> @@ -2854,8 +2935,11 @@ static int ui_quirks(void)
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
>>> @@ -3107,7 +3191,8 @@ static int perf_c2c__report(int argc, const char **argv)
>>>  	OPT_END()
>>>  	};
>>>  	int err = 0;
>>> -	const char *output_str, *sort_str = NULL;
>>> +	const char *sort_str = NULL;
>>> +	char *output_str = NULL;
>>>  	struct perf_env *env;
>>>  
>>>  	annotation_options__init();
>>> @@ -3272,9 +3357,16 @@ static int perf_c2c__report(int argc, const char **argv)
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
>>> @@ -3286,10 +3378,17 @@ static int perf_c2c__report(int argc, const char **argv)
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
>>> @@ -3301,7 +3400,13 @@ static int perf_c2c__report(int argc, const char **argv)
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
>>> @@ -3315,7 +3420,7 @@ static int perf_c2c__report(int argc, const char **argv)
>>>  	err = c2c_hists__reinit(&c2c.hists, output_str, sort_str, perf_session__env(session));
>>>  	if (err) {
>>>  		pr_err("Failed to reinitialize hists\n");
>>> -		goto out_mem2node;
>>> +		goto out_str;
>>>  	}
>>>  
>>>  	ui_progress__init(&prog, c2c.hists.hists.nr_entries, "Sorting...");
>>> @@ -3324,17 +3429,19 @@ static int perf_c2c__report(int argc, const char **argv)
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
