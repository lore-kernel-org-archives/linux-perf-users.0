Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CA933260D;
	Thu, 30 Jul 2026 05:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785390617; cv=none; b=HPyzOFwK8aU4iYg+Re0/LxySezaI8EGRLBkJjbC4593XBhJTTY7xRAy9X5ebkHhuOahbp4mh3zR6jdp2w/RJCxVqMoBNtTJbicyA400GhhzTiXChXG9aBVDAdRE6kk1olLi9HOZe3EQKyG6Y41EmxEnLwujEicoYkjkoGi8BEIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785390617; c=relaxed/simple;
	bh=sUWO/P9zoluSONJIC6TXXpLPN3Yx3ze03/xnLC1PbkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OThqya6TKtPJ+aqiGoMn+/ZZJW5lrwkJX5Fj6pgG2FKwy2QW1IiTGrQEKBAnuiSbhkcGmKJrjhOJXH9x2d+K3UD8zp0CepqyyGsk+i2gbsylQnV+mGXiY1ICGZz6mai+UVYoHu/r+fCM7V0vf6L09o388u5n6ZDn6YdzBdkGwvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mJQwqy0n; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mJQwqy0n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785390616; x=1816926616;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sUWO/P9zoluSONJIC6TXXpLPN3Yx3ze03/xnLC1PbkM=;
  b=mJQwqy0nuNEtC1sUzDEe0hggd+4KMhErTZ6Al+zNvReYtIwQZ4QPCkFV
   mvlDcwVqftZ2whxtSe6sTN6spCDDksnBkGUmpHSoyoMgBPYdHxlaxLtdX
   tQOTuV36hv8WfQPPoa8IFXGapHhPylGNuH8LQXg4DD/xzdg1KrG7zENLb
   IVgZEXDH+8VTH/NFat5HeYyAGEZQax5bPF81XGzMC5KotpUCj/j+UAfwy
   eZtv8IXyIkN2pTzGXB0rAyAT2ReoY7T/QxF90xhCATexr0IEt7xHwj80f
   Dpo93wikmL1/KqWBBvCXod31I2IRrDHuepr0Cpqt6sQBcEsoXn3Jhuxwg
   Q==;
X-CSE-ConnectionGUID: AaOR7lNJRNGPO7D98bjytg==
X-CSE-MsgGUID: 8seNGeEMRNSSO+rIW5wmVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86019609"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="86019609"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 22:50:16 -0700
X-CSE-ConnectionGUID: XlrJoBM5TjyFBNZvTh+aTA==
X-CSE-MsgGUID: C1zO73eZSKehy59ohiEKQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="258426092"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.178]) ([10.124.241.178])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 22:50:13 -0700
Message-ID: <e078b96b-b228-4597-a5bc-4789264474b4@linux.intel.com>
Date: Thu, 30 Jul 2026 13:50:10 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] perf tools: Show memory region in perf-c2c
 subcommand
To: Namhyung Kim <namhyung@kernel.org>,
 Thomas Falcon <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>
References: <20260714004359.179451-1-thomas.falcon@intel.com>
 <20260714004359.179451-4-thomas.falcon@intel.com>
 <amjkL7PBbHJpr9HV@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <amjkL7PBbHJpr9HV@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/29/2026 1:17 AM, Namhyung Kim wrote:
> On Mon, Jul 13, 2026 at 07:43:56PM -0500, Thomas Falcon wrote:
>> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>> Add memory region field to the cacheline list view to help users
>> identify the memory region to which the cacheline belongs. The memory
>> region field was included with the introduction of support for the
>> Off-module Response facility (OMR) [1] in Intel's Diamond Rapids and
>> Nova Lake architectures.
>>
>> An example of the new perf c2c output including the memory region
>> field is shown below:
>>
>> Shared Data Cache Line Table     (112 entries, sorted on Total HITMs)
>>        --------------- Cacheline --------------      Tot  ------- Load Hitm -------    Total    Total    Total
>> Index             Address  Region  Node  PA cnt     Hitm    Total  LclHitm  RmtHitm  records    Loads   Stores
>>     0  0xff1b7032a1e8c5c0  N/A        1      47    2.25%       50       44        6     1024     1023        1
>>     1  0xff1b6ff3255bb880  N/A        0      11    1.62%       36       34        2       96       93        4
>>     2  0xff1b70328e3b9880  N/A        1      13    1.49%       33       33        0      100       91        9
>>     3  0xff1b70328b023800  N/A        1       1    1.40%       31       14       17       52       48        4
>>     4  0xff1b70328e3b9c00  N/A        1       1    1.31%       29       27        2       67       33       34
>>     5  0xff1b70328b0237c0  N/A        1       1    1.26%       28       10       18      154      150        4
>>     6  0xff1b6ff3255bbc00  N/A        0       1    1.13%       25       25        0       48       25       23
>>     7  0xff1b6ff3255bba40  N/A        0       1    0.99%       22       22        0       46       23       23
>>     8  0xff3ab9ba50255c80  N/A      N/A       0    0.77%       17       15        2       35       35        0
>>     9  0xff3ab9ba503e3040  N/A      N/A       0    0.77%       17       11        6       37       37        1
>>    10  0xff1b703289e88f40  N/A        1      33    0.72%       16        9        7       69       63        6
>>    11  0xff1b70328e3b9a40  N/A        1       1    0.68%       15       15        0       43       17       26
>>    12  0xff1b7032c9fd6a40  N/A        1      15    0.68%       15       15        0       57       54        4
>>    13  0xff1b7032a1e8c980  N/A        1      27    0.54%       12       11        1      761      761        0
>>    14  0xff1b70727ffd57c0  N/A        1       7    0.54%       12       12        0      219      218        1
>>    15  0xffffffffaefe2380  N/A        1       1    0.50%       11        8        3       14       14        0
>>
>> Note: DMR simics does not support memory regions. Since the output is
>> captured on SPR, the memory region field shows "N/A" for all cachelines.
> My concern is that it increase the length of data and makes it harder to
> read.  Can it be conditional on the feature bit?

Sure. 

>
> Also I'm curious if a cacheline can belong to different regions.  In
> that case, will it have multiple entries in the output?

Suppose it's possible, let's double check.


>
> Thanks,
> Namhyung
>
>> [1]: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.intel.com/
>>
>> Assisted-by: Sashiko:gemini-3.1-pro-preview
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
>> ---
>> Changes in v2:
>> -- Added missing new line in WARN_ONCE message in c2c_he__set_mem_region()
>> ---
>>  tools/perf/builtin-c2c.c | 56 ++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 54 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
>> index c9584dbedf77..cba2e9f21ae7 100644
>> --- a/tools/perf/builtin-c2c.c
>> +++ b/tools/perf/builtin-c2c.c
>> @@ -74,6 +74,7 @@ struct c2c_hist_entry {
>>  	unsigned long		*nodeset;
>>  	struct c2c_stats	*node_stats;
>>  	unsigned int		 cacheline_idx;
>> +	unsigned int		 mem_region;
>>  
>>  	struct compute_stats	 cstats;
>>  
>> @@ -281,6 +282,18 @@ static void c2c_he__set_node(struct c2c_hist_entry *c2c_he,
>>  	}
>>  }
>>  
>> +static void c2c_he__set_mem_region(struct c2c_hist_entry *c2c_he,
>> +				   unsigned int mem_region)
>> +{
>> +	if (WARN_ONCE(mem_region > PERF_MEM_REGION_MEM7,
>> +		      "WARNING: invalid memory region ID\n"))
>> +		return;
>> +
>> +	/* Update mem_region only if it really accesses memory */
>> +	if (mem_region >= PERF_MEM_REGION_MMIO)
>> +		c2c_he->mem_region = mem_region;
>> +}
>> +
>>  static void compute_stats(struct c2c_hist_entry *c2c_he,
>>  			  struct c2c_stats *stats,
>>  			  u64 weight)
>> @@ -339,6 +352,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>>  	struct addr_location al;
>>  	struct mem_info *mi = NULL;
>>  	struct callchain_cursor *cursor;
>> +	unsigned int mem_region;
>>  	int ret;
>>  
>>  	addr_location__init(&al);
>> @@ -366,6 +380,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>>  	}
>>  
>>  	c2c_decode_stats(&stats, mi);
>> +	mem_region = mem_info__data_src(mi)->mem_region;
>>  
>>  	he = hists__add_entry_ops(&c2c_hists->hists, &c2c_entry_ops,
>>  				  &al, NULL, NULL, mi, NULL,
>> @@ -382,6 +397,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>>  	c2c_he__set_cpu(c2c_he, sample);
>>  	c2c_he__set_node(c2c_he, sample);
>>  	c2c_he__set_evsel(c2c_he, evsel);
>> +	c2c_he__set_mem_region(c2c_he, mem_region);
>>  
>>  	hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
>>  
>> @@ -435,6 +451,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>>  		c2c_he__set_cpu(c2c_he, sample);
>>  		c2c_he__set_node(c2c_he, sample);
>>  		c2c_he__set_evsel(c2c_he, evsel);
>> +		c2c_he__set_mem_region(c2c_he, mem_region);
>>  
>>  		hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
>>  		ret = hist_entry__append_callchain(he, sample);
>> @@ -603,6 +620,29 @@ dcacheline_node_count(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
>>  	return scnprintf(hpp->buf, hpp->size, "%*lu", width, c2c_he->paddr_cnt);
>>  }
>>  
>> +static int
>> +dcacheline_node_mem_region(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
>> +			   struct hist_entry *he)
>> +{
>> +	int width = c2c_width(fmt, hpp, he->hists);
>> +	struct c2c_hist_entry *c2c_he;
>> +	unsigned int mem_region;
>> +	char buf[20];
>> +
>> +	c2c_he = container_of(he, struct c2c_hist_entry, he);
>> +	mem_region = c2c_he->mem_region;
>> +
>> +	if (mem_region == PERF_MEM_REGION_NA)
>> +		scnprintf(buf, sizeof(buf),  "N/A");
>> +	/* mem_region could only be >= PERF_MEM_REGION_MMIO */
>> +	else if (mem_region == PERF_MEM_REGION_MMIO)
>> +		scnprintf(buf, sizeof(buf), "MMIO");
>> +	else
>> +		scnprintf(buf, sizeof(buf), "0x%x", mem_region - 0x8);
>> +
>> +	return scnprintf(hpp->buf, hpp->size, "%*s", width, buf);
>> +}
>> +
>>  static int offset_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
>>  			struct hist_entry *he)
>>  {
>> @@ -1425,7 +1465,7 @@ cl_idx_empty_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
>>  	}
>>  
>>  static struct c2c_dimension dim_dcacheline = {
>> -	.header		= HEADER_SPAN("--- Cacheline ----", "Address", 2),
>> +	.header		= HEADER_SPAN("--- Cacheline ----", "Address", 3),
>>  	.name		= "dcacheline",
>>  	.cmp		= dcacheline_cmp,
>>  	.entry		= dcacheline_entry,
>> @@ -1440,6 +1480,14 @@ static struct c2c_dimension dim_dcacheline_node = {
>>  	.width		= 4,
>>  };
>>  
>> +static struct c2c_dimension dim_dcacheline_mem_region = {
>> +	.header		= HEADER_LOW("Region"),
>> +	.name		= "dcacheline_mem_region",
>> +	.cmp		= empty_cmp,
>> +	.entry		= dcacheline_node_mem_region,
>> +	.width		= 6,
>> +};
>> +
>>  static struct c2c_dimension dim_dcacheline_count = {
>>  	.header		= HEADER_LOW("PA cnt"),
>>  	.name		= "dcacheline_count",
>> @@ -1871,6 +1919,7 @@ static struct c2c_dimension dim_dcacheline_num_empty = {
>>  
>>  static struct c2c_dimension *dimensions[] = {
>>  	&dim_dcacheline,
>> +	&dim_dcacheline_mem_region,
>>  	&dim_dcacheline_node,
>>  	&dim_dcacheline_count,
>>  	&dim_offset,
>> @@ -2898,8 +2947,9 @@ static int ui_quirks(void)
>>  	/* Fix the zero line for dcacheline column. */
>>  	buf = fill_line(chk_double_cl ? "Double-Cacheline" : "Cacheline",
>>  				dim_dcacheline.width +
>> +				dim_dcacheline_mem_region.width +
>>  				dim_dcacheline_node.width +
>> -				dim_dcacheline_count.width + 4);
>> +				dim_dcacheline_count.width + 6);
>>  	if (!buf)
>>  		return -ENOMEM;
>>  
>> @@ -3319,6 +3369,7 @@ static int perf_c2c__report(int argc, const char **argv)
>>  	if (c2c.display != DISPLAY_SNP_PEER)
>>  		output_str = "cl_idx,"
>>  			     "dcacheline,"
>> +			     "dcacheline_mem_region,"
>>  			     "dcacheline_node,"
>>  			     "dcacheline_count,"
>>  			     "percent_costly_snoop,"
>> @@ -3334,6 +3385,7 @@ static int perf_c2c__report(int argc, const char **argv)
>>  	else
>>  		output_str = "cl_idx,"
>>  			     "dcacheline,"
>> +			     "dcacheline_mem_region,"
>>  			     "dcacheline_node,"
>>  			     "dcacheline_count,"
>>  			     "percent_costly_snoop,"
>> -- 
>> 2.43.0
>>
