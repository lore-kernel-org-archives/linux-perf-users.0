Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54829361969;
	Thu, 10 Sep 2026 02:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789006766; cv=none; b=mW8Nki9TJnAJfqUjkGz6+OuRU9liPSvcIRxl3wSbtDaXN9lTNLe1MEUjL+LqCVxdRAbn7AAjMqgroa0KuNAwqVV33wP987EHXcLRy1ognpmtpCRaXi/uuA9scxDnWurHuls4/59bLmIt9TDrGzs+wM/aRDtOrNtGJeqlpq8tjuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789006766; c=relaxed/simple;
	bh=tmxVQMhY31lolHquX62B9fChfy5vw5GThBOuEyiP3dY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9VZGHVNJfK54LTLf6Ojp3SwguDGwAC8RaV+gsY/pBfcmv/JeoN+CCYSQ+9Su5f6eq1gbX78VJ5GXqwpXrLhw348YwvMpPaILG+NL+RoeQX06aqiTDfHnzDDKGAywOmJqelu2P+5FvFlNDq9RQWeHqKNASu6UTNAN8A74QkROsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ATyR7+kW; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ATyR7+kW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789006765; x=1820542765;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tmxVQMhY31lolHquX62B9fChfy5vw5GThBOuEyiP3dY=;
  b=ATyR7+kWUBYl/jZfUwlTQhisl7i/QwyqUCKoR78P2IpaumPHyNUm5kXl
   n9J2AbtyxewlwPmc/RYAEUjeC8+OgElzQ9IjbTAXYZbhEkYQR6tuYEVLZ
   DqpOWmKZEqVA69HNlvGVqdScRS8bJPtSBzMuzqkoHW7Ud4XNK7dK4rX3M
   kxr7l/+Ekspfh/2M4tc92Veb8wb8r//K9yIIQa1jG7yXywuiLssRZvYZx
   Cg+7QOhmKJ2JWWowLfp1NB7dGSTCj7g/wwaybsMFG5TKbP1wD7bwFqMnx
   +BKgmA8/LFpHCeT6DFhRIG0vUhuD56KoQdd3LtzU7ORRg36iXk2tZvwtw
   A==;
X-CSE-ConnectionGUID: h9rc5J7sSfW+kJsvPkK0rw==
X-CSE-MsgGUID: on2GosgEQ5aVaQg4ABLNpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89292317"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="89292317"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 19:19:24 -0700
X-CSE-ConnectionGUID: 6jc+Om+CQ02dRbwm/6jVKA==
X-CSE-MsgGUID: 63o+/I3NQ8+dnQI1jTV8vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="275256373"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 19:19:20 -0700
Message-ID: <576e1f9e-9ba9-4dc6-b60d-3fed31c66997@linux.intel.com>
Date: Thu, 10 Sep 2026 10:19:17 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/6] perf tools: Show memory region in perf-c2c
 subcommand
To: Thomas Falcon <thomas.falcon@intel.com>,
 Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>
References: <20260909160218.174928-1-thomas.falcon@intel.com>
 <20260909160218.174928-5-thomas.falcon@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260909160218.174928-5-thomas.falcon@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/10/2026 12:02 AM, Thomas Falcon wrote:
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> Add memory region field to the cacheline list view to help users
> identify the memory region to which the cacheline belongs. The memory
> region field was included with the introduction of support for the
> Off-module Response facility (OMR) [1] in Intel's Diamond Rapids and
> Nova Lake architectures.
>
> An example of the new perf c2c output including the memory region
> field is shown below:
>
> Shared Data Cache Line Table     (112 entries, sorted on Total HITMs)
>        --------------- Cacheline --------------      Tot  ------- Load Hitm -------    Total    Total    Total
> Index             Address  Region  Node  PA cnt     Hitm    Total  LclHitm  RmtHitm  records    Loads   Stores
>     0  0xff1b7032a1e8c5c0  N/A        1      47    2.25%       50       44        6     1024     1023        1
>     1  0xff1b6ff3255bb880  N/A        0      11    1.62%       36       34        2       96       93        4
>     2  0xff1b70328e3b9880  N/A        1      13    1.49%       33       33        0      100       91        9
>     3  0xff1b70328b023800  N/A        1       1    1.40%       31       14       17       52       48        4
>     4  0xff1b70328e3b9c00  N/A        1       1    1.31%       29       27        2       67       33       34
>     5  0xff1b70328b0237c0  N/A        1       1    1.26%       28       10       18      154      150        4
>     6  0xff1b6ff3255bbc00  N/A        0       1    1.13%       25       25        0       48       25       23
>     7  0xff1b6ff3255bba40  N/A        0       1    0.99%       22       22        0       46       23       23
>     8  0xff3ab9ba50255c80  N/A      N/A       0    0.77%       17       15        2       35       35        0
>     9  0xff3ab9ba503e3040  N/A      N/A       0    0.77%       17       11        6       37       37        1
>    10  0xff1b703289e88f40  N/A        1      33    0.72%       16        9        7       69       63        6
>    11  0xff1b70328e3b9a40  N/A        1       1    0.68%       15       15        0       43       17       26
>    12  0xff1b7032c9fd6a40  N/A        1      15    0.68%       15       15        0       57       54        4
>    13  0xff1b7032a1e8c980  N/A        1      27    0.54%       12       11        1      761      761        0
>    14  0xff1b70727ffd57c0  N/A        1       7    0.54%       12       12        0      219      218        1
>    15  0xffffffffaefe2380  N/A        1       1    0.50%       11        8        3       14       14        0
>
> Note: DMR simics does not support memory regions. Since the output is
> captured on SPR, the memory region field shows "N/A" for all cachelines.

Currently we have DMR HW, so we'd better post the real output on DMR, which
would be more valuable. 


>
> [1]: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.intel.com/
>
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Assisted-by: GitHub-Copilot:claude-opus-4-8
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Thomas, I suppose you have done some changes for this patch. If so, please
add your "Co-developed-by" tag. :)


> ---
> v7: fix output_str allocation error handling which introduced
>     a memory leak (Sashiko)
>
> v6: rebased onto 7.3-rc1
>
> v5: make the cacheline header span and ui_quirks() width
>     fixup depend on memory-region availability (Namhyung Kim)
>
> v4: correctly handle output_str memory allocation failure
>
> v3: make memory region reporting conditional on feature bit
> ---
>  tools/perf/builtin-c2c.c | 98 +++++++++++++++++++++++++++++++++++-----
>  tools/perf/util/c2c.h    |  1 +
>  2 files changed, 88 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 715b75d42f2a..e37c1a3a4ca5 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -71,6 +71,7 @@ struct perf_c2c {
>  
>  	bool			 show_src;
>  	bool			 show_all;
> +	bool			 show_mem_region;
>  	bool			 use_stdio;
>  	bool			 stats_only;
>  	bool			 symbol_full;
> @@ -247,6 +248,18 @@ static void c2c_he__set_node(struct c2c_hist_entry *c2c_he,
>  	}
>  }
>  
> +static void c2c_he__set_mem_region(struct c2c_hist_entry *c2c_he,
> +				   unsigned int mem_region)
> +{
> +	if (WARN_ONCE(mem_region > PERF_MEM_REGION_MEM7,
> +		      "WARNING: invalid memory region ID\n"))
> +		return;
> +
> +	/* Update mem_region only if it really accesses memory */
> +	if (mem_region >= PERF_MEM_REGION_MMIO)
> +		c2c_he->mem_region = mem_region;
> +}

Currently we only print the real memory regions and ignore the L3 cache
regions for "c2c report" view, but the perf script would print all regions
regardless of it's a cache region or a memory region. I'm thinking if we
should print all other L3 related cache regions for  "c2c report" view as
well.  

IMO, It seems better to keep a consistent memory region view for both c2c
and script report. Besides, it should be valuable to let users know more
cache region information for c2c report, like the L3 cache hit comes from
local or remote peer.


> +
>  static void compute_stats(struct c2c_hist_entry *c2c_he,
>  			  struct c2c_stats *stats,
>  			  u64 weight)
> @@ -305,6 +318,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>  	struct addr_location al;
>  	struct mem_info *mi = NULL;
>  	struct callchain_cursor *cursor;
> +	unsigned int mem_region;
>  	int ret;
>  
>  	addr_location__init(&al);
> @@ -332,6 +346,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>  	}
>  
>  	c2c_decode_stats(&stats, mi);
> +	mem_region = mem_info__data_src(mi)->mem_region;
>  
>  	he = hists__add_entry_ops(&c2c_hists->hists, &c2c_entry_ops,
>  				  &al, NULL, NULL, mi, NULL,
> @@ -348,6 +363,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>  	c2c_he__set_cpu(c2c_he, sample);
>  	c2c_he__set_node(c2c_he, sample);
>  	c2c_he__set_evsel(c2c_he, evsel);
> +	c2c_he__set_mem_region(c2c_he, mem_region);
>  
>  	hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
>  
> @@ -401,6 +417,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>  		c2c_he__set_cpu(c2c_he, sample);
>  		c2c_he__set_node(c2c_he, sample);
>  		c2c_he__set_evsel(c2c_he, evsel);
> +		c2c_he__set_mem_region(c2c_he, mem_region);
>  
>  		hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
>  		ret = hist_entry__append_callchain(he, sample);
> @@ -539,6 +556,30 @@ dcacheline_node_count(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
>  	return scnprintf(hpp->buf, hpp->size, "%*lu", width, c2c_he->paddr_cnt);
>  }
>  
> +static int
> +dcacheline_node_mem_region(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> +			   struct hist_entry *he)
> +{
> +	int width = c2c_width(fmt, hpp, he->hists);
> +	struct c2c_hist_entry *c2c_he;
> +	unsigned int mem_region;
> +	char buf[20];
> +
> +	c2c_he = container_of(he, struct c2c_hist_entry, he);
> +	mem_region = c2c_he->mem_region;
> +
> +	if (mem_region == PERF_MEM_REGION_NA)
> +		scnprintf(buf, sizeof(buf),  "N/A");
> +	/* mem_region could only be >= PERF_MEM_REGION_MMIO */
> +	else if (mem_region == PERF_MEM_REGION_MMIO)
> +		scnprintf(buf, sizeof(buf), "MMIO");
> +	else
> +		scnprintf(buf, sizeof(buf), "0x%x",
> +			  mem_region - PERF_MEM_REGION_MEM0);
> +
> +	return scnprintf(hpp->buf, hpp->size, "%*s", width, buf);
> +}

Is the mem-region column print guarded by HEADER_MEMORY_RANGES as well?

Thanks.


> +
>  static int offset_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
>  			struct hist_entry *he)
>  {
> @@ -1359,6 +1400,14 @@ static struct c2c_dimension dim_dcacheline_node = {
>  	.width		= 4,
>  };
>  
> +static struct c2c_dimension dim_dcacheline_mem_region = {
> +	.header		= HEADER_LOW("Region"),
> +	.name		= "dcacheline_mem_region",
> +	.cmp		= empty_cmp,
> +	.entry		= dcacheline_node_mem_region,
> +	.width		= 6,
> +};
> +
>  static struct c2c_dimension dim_dcacheline_count = {
>  	.header		= HEADER_LOW("PA cnt"),
>  	.name		= "dcacheline_count",
> @@ -1790,6 +1839,7 @@ static struct c2c_dimension dim_dcacheline_num_empty = {
>  
>  static struct c2c_dimension *dimensions[] = {
>  	&dim_dcacheline,
> +	&dim_dcacheline_mem_region,
>  	&dim_dcacheline_node,
>  	&dim_dcacheline_count,
>  	&dim_offset,
> @@ -2853,8 +2903,11 @@ static int ui_quirks(void)
>  	/* Fix the zero line for dcacheline column. */
>  	buf = fill_line(chk_double_cl ? "Double-Cacheline" : "Cacheline",
>  				dim_dcacheline.width +
> +				(c2c.show_mem_region ?
> +					dim_dcacheline_mem_region.width : 0) +
>  				dim_dcacheline_node.width +
> -				dim_dcacheline_count.width + 4);
> +				dim_dcacheline_count.width +
> +				(c2c.show_mem_region ? 6 : 4));
>  	if (!buf)
>  		return -ENOMEM;
>  
> @@ -3106,7 +3159,8 @@ static int perf_c2c__report(int argc, const char **argv)
>  	OPT_END()
>  	};
>  	int err = 0;
> -	const char *output_str, *sort_str = NULL;
> +	const char *sort_str = NULL;
> +	char *output_str = NULL;
>  	struct perf_env *env;
>  
>  	annotation_options__init();
> @@ -3271,9 +3325,16 @@ static int perf_c2c__report(int argc, const char **argv)
>  		goto out_mem2node;
>  	}
>  
> -	if (c2c.display != DISPLAY_SNP_PEER)
> -		output_str = "cl_idx,"
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
>  
>  	if (c2c.display == DISPLAY_TOT_HITM)
>  		sort_str = "tot_hitm";
> @@ -3314,7 +3388,7 @@ static int perf_c2c__report(int argc, const char **argv)
>  	err = c2c_hists__reinit(&c2c.hists, output_str, sort_str, perf_session__env(session));
>  	if (err) {
>  		pr_err("Failed to reinitialize hists\n");
> -		goto out_mem2node;
> +		goto out_str;
>  	}
>  
>  	ui_progress__init(&prog, c2c.hists.hists.nr_entries, "Sorting...");
> @@ -3323,17 +3397,19 @@ static int perf_c2c__report(int argc, const char **argv)
>  	hists__output_resort_cb(&c2c.hists.hists, &prog, resort_shared_cl_cb);
>  	err = hists__iterate_cb(&c2c.hists.hists, resort_cl_cb, perf_session__env(session));
>  	if (err)
> -		goto out_mem2node;
> +		goto out_str;
>  
>  	ui_progress__finish();
>  
>  	if (ui_quirks()) {
>  		pr_err("failed to setup UI\n");
> -		goto out_mem2node;
> +		goto out_str;
>  	}
>  
>  	perf_c2c_display(session);
>  
> +out_str:
> +	free(output_str);
>  out_mem2node:
>  	mem2node__exit(&c2c.mem2node);
>  out_session:
> diff --git a/tools/perf/util/c2c.h b/tools/perf/util/c2c.h
> index 53f024e25d99..f04e78e1a2e3 100644
> --- a/tools/perf/util/c2c.h
> +++ b/tools/perf/util/c2c.h
> @@ -33,6 +33,7 @@ struct c2c_hist_entry {
>  	unsigned long		*nodeset;
>  	struct c2c_stats	*node_stats;
>  	unsigned int		 cacheline_idx;
> +	unsigned int		 mem_region;
>  
>  	struct compute_stats	 cstats;
>  
