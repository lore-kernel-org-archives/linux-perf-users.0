Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E11E46AA9E;
	Thu, 24 Sep 2026 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270956; cv=none; b=pP9kpj2N15XFvbaWlQ0fpNPqjIOPNuMrKQ1gpZWC4d4+ulGcXDv6NaovNq2oc23XQYpVJiVXKBYkiFUjkqQM5lzyhhI+hHzU8Pgj6xmQjc3+XfEx61jmlqoZOxD7kfh4BX76Hot6V+7L+yXxNiUKpeO7Uddq08Grd3WjCEjmdNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270956; c=relaxed/simple;
	bh=IHU9w772yCTiVPJjSs681edq+Dwh8xdTHldYAmzImnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHduTrnBYxcXMzAIe86290UR5brxyildE4jA3ntaioSkhw9uQ+kLn3vWVpmbpgRfftIMP7DeFpMj1I+HQDvXszYTLRORnatpz0Z6zJ1tent6BNTVnXUpgpbBTw9YzqeRJ+mDdi5NI0SVJSOhoqSqiuu33nSVXIozzvJhfC66Z7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+Ww1Ali; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+Ww1Ali"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0D21F00893;
	Thu, 24 Sep 2026 17:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790270953;
	bh=5sP4lyHpb+OJAHofWxdv09rRmJtIwDdpvt2+tnBSymk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b+Ww1AlimJaKgstNc9Wf8tB0ALSNd7OVnPf7vpGHkuhVUmrNw+hNyc7r9XvrccEXH
	 2CQ669/ZJa9v3h/RBClGHaPhnI+okHB4nTb1zSIq19vns7BhkNNECZQIpEKCISsliR
	 9OsgzL8gMfwra9deN10NhMpI5Pi+wmFwz3ejZTY+qx+1zIAihxy+OvHk4nKr5WG153
	 uFF65kgW5PFEMI95D45TElnQ2uBVgSWKpn87pHvJWdbt4R9R1Nt2rHLVEngWOcFL1U
	 s5qOlJ16fkfRqXUzv3hzEtnEIJN2GsxVbL33UY7nR9pk+l3DXoqrcjzS+TT9ndGwYz
	 mNku3Qd02BdWw==
Date: Thu, 24 Sep 2026 19:29:10 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Thomas Falcon <thomas.falcon@intel.com>, sashiko-bot@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v12 4/6] perf tools: Show memory region in perf-c2c
 subcommand
Message-ID: <arVd5uRfZWRzpaaE@x2>
References: <20260923161043.95C171F000FF@smtp.kernel.org>
 <20260923170903.48388-1-thomas.falcon@intel.com>
 <20260923170903.48388-5-thomas.falcon@intel.com>
 <a2f2063b-b491-4f65-9e42-1c3dfa1902c7@linux.intel.com>
 <arVdq-jyFVdX5QNa@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arVdq-jyFVdX5QNa@x2>

On Thu, Sep 24, 2026 at 07:28:13PM +0200, Arnaldo Carvalho de Melo wrote:
> On Thu, Sep 24, 2026 at 08:23:42AM +0800, Mi, Dapeng wrote:
> > Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> 
> Is this needed since you're the author of the patch? I'm keeping just
> the Signed-off-by,

I'll keep it since I saw a Co-developed-by tag, meaning maybe there were
changes after you initially created this patch...

- Arnaldo
> > 
> > On 9/24/2026 1:09 AM, Thomas Falcon wrote:
> > > From: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > >
> > > Add memory region field to the cacheline list view to help users
> > > identify the memory region to which the cacheline belongs. The memory
> > > region field was included with the introduction of support for the
> > > Off-module Response facility (OMR) [1] in Intel's Diamond Rapids and
> > > Nova Lake architectures.
> > >
> > > An example of the new perf c2c output including the memory region
> > > field is shown below:
> > >
> > > # Index             Address  Region  Node  PA cnt     Hitm    Total  LclHitm  RmtHitm  records    Loads
> > > # .....  ..................  ......  ....  ......  .......  .......  .......  .......  .......  .......
> > > #
> > >       0  0xffffffff84eb0040     N/A     0    1205   23.25%      544      544        0     1677     1677
> > >       1  0xffffffff84f03a80     N/A     0       1   18.12%      424      424        0      585      585
> > > [...]
> > >      19  0xffffffff845bc840   Mem-0     0      13    0.30%        7        7        0       31       31
> > >      20  0xff3bbba284520a00     N/A     0      10    0.26%        6        6        0       11       11
> > >      21  0xff3bbbe0bc833500     N/A     0      24    0.26%        6        6        0       30       30
> > >
> > > [1]: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.intel.com/
> > >
> > > Assisted-by: Sashiko:gemini-3.1-pro-preview
> > > Assisted-by: GitHub-Copilot:claude-opus-4-8
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> > > Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > > Co-developed-by: Thomas Falcon <thomas.falcon@intel.com>
> > > Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> > > ---
> > > v11: perf-c2c: revert to only recording a real memory region for a
> > >      cacheline
> > > v10: only update mem_region for real cache/memory regions so N/A samples
> > >      don't overwrite a valid region; add #include <stdio.h> for asprintf
> > >      (Sashiko)
> > > v9: Update perf-c2c to include cache region reporting (Dapeng Mi)
> > > v8: Update developer tags and commit message with real example
> > >     output (Dapeng Mi)
> > > v7: fix output_str allocation error handling which introduced
> > >     a memory leak (Sashiko)
> > > v6: rebased onto 7.3-rc1
> > > v5: make the cacheline header span and ui_quirks() width
> > >     fixup depend on memory-region availability (Namhyung Kim)
> > > v4: correctly handle output_str memory allocation failure
> > > v3: make memory region reporting conditional on feature bit
> > > ---
> > >  tools/perf/builtin-c2c.c | 114 +++++++++++++++++++++++++++++++++++----
> > >  tools/perf/util/c2c.h    |   1 +
> > >  2 files changed, 104 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> > > index 6b64c0d6b24f..a42423ca990d 100644
> > > --- a/tools/perf/builtin-c2c.c
> > > +++ b/tools/perf/builtin-c2c.c
> > > @@ -14,6 +14,7 @@
> > >  #include <inttypes.h>
> > >  #include <stdlib.h>
> > >  #include <string.h>
> > > +#include <stdio.h>
> > >  
> > >  #include <asm/bug.h>
> > >  #include <linux/compiler.h>
> > > @@ -72,6 +73,7 @@ struct perf_c2c {
> > >  
> > >  	bool			 show_src;
> > >  	bool			 show_all;
> > > +	bool			 show_mem_region;
> > >  	bool			 use_stdio;
> > >  	bool			 stats_only;
> > >  	bool			 symbol_full;
> > > @@ -248,6 +250,18 @@ static void c2c_he__set_node(struct c2c_hist_entry *c2c_he,
> > >  	}
> > >  }
> > >  
> > > +static void c2c_he__set_mem_region(struct c2c_hist_entry *c2c_he,
> > > +				   unsigned int mem_region)
> > > +{
> > > +	if (WARN_ONCE(mem_region > PERF_MEM_REGION_MEM7,
> > > +		      "WARNING: invalid memory region ID\n"))
> > > +		return;
> > > +
> > > +	/* Update mem_region only if it really accesses memory */
> > > +	if (mem_region >= PERF_MEM_REGION_MMIO)
> > > +		c2c_he->mem_region = mem_region;
> > > +}
> > > +
> > >  static void compute_stats(struct c2c_hist_entry *c2c_he,
> > >  			  struct c2c_stats *stats,
> > >  			  u64 weight)
> > > @@ -306,6 +320,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
> > >  	struct addr_location al;
> > >  	struct mem_info *mi = NULL;
> > >  	struct callchain_cursor *cursor;
> > > +	unsigned int mem_region;
> > >  	int ret;
> > >  
> > >  	addr_location__init(&al);
> > > @@ -333,6 +348,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
> > >  	}
> > >  
> > >  	c2c_decode_stats(&stats, mi);
> > > +	mem_region = mem_info__data_src(mi)->mem_region;
> > >  
> > >  	he = hists__add_entry_ops(&c2c_hists->hists, &c2c_entry_ops,
> > >  				  &al, NULL, NULL, mi, NULL,
> > > @@ -349,6 +365,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
> > >  	c2c_he__set_cpu(c2c_he, sample);
> > >  	c2c_he__set_node(c2c_he, sample);
> > >  	c2c_he__set_evsel(c2c_he, evsel);
> > > +	c2c_he__set_mem_region(c2c_he, mem_region);
> > >  
> > >  	hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
> > >  
> > > @@ -402,6 +419,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
> > >  		c2c_he__set_cpu(c2c_he, sample);
> > >  		c2c_he__set_node(c2c_he, sample);
> > >  		c2c_he__set_evsel(c2c_he, evsel);
> > > +		c2c_he__set_mem_region(c2c_he, mem_region);
> > >  
> > >  		hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
> > >  		ret = hist_entry__append_callchain(he, sample);
> > > @@ -540,6 +558,45 @@ dcacheline_node_count(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> > >  	return scnprintf(hpp->buf, hpp->size, "%*lu", width, c2c_he->paddr_cnt);
> > >  }
> > >  
> > > +static int
> > > +dcacheline_node_mem_region(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> > > +			   struct hist_entry *he)
> > > +{
> > > +	int width = c2c_width(fmt, hpp, he->hists);
> > > +	struct c2c_hist_entry *c2c_he;
> > > +	unsigned int mem_region;
> > > +	char buf[20];
> > > +
> > > +	c2c_he = container_of(he, struct c2c_hist_entry, he);
> > > +	mem_region = c2c_he->mem_region;
> > > +
> > > +	switch (mem_region) {
> > > +	case PERF_MEM_REGION_NA:
> > > +	case PERF_MEM_REGION_RSVD:
> > > +		scnprintf(buf, sizeof(buf), "N/A");
> > > +		break;
> > > +	case PERF_MEM_REGION_MMIO:
> > > +		scnprintf(buf, sizeof(buf), "MMIO");
> > > +		break;
> > > +	case PERF_MEM_REGION_MEM0:
> > > +	case PERF_MEM_REGION_MEM1:
> > > +	case PERF_MEM_REGION_MEM2:
> > > +	case PERF_MEM_REGION_MEM3:
> > > +	case PERF_MEM_REGION_MEM4:
> > > +	case PERF_MEM_REGION_MEM5:
> > > +	case PERF_MEM_REGION_MEM6:
> > > +	case PERF_MEM_REGION_MEM7:
> > > +		scnprintf(buf, sizeof(buf), "Mem-%d",
> > > +			  mem_region - PERF_MEM_REGION_MEM0);
> > > +		break;
> > > +	default:
> > > +		scnprintf(buf, sizeof(buf), "N/A");
> > > +		break;
> > > +	}
> > > +
> > > +	return scnprintf(hpp->buf, hpp->size, "%*s", width, buf);
> > > +}
> > > +
> > >  static int offset_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> > >  			struct hist_entry *he)
> > >  {
> > > @@ -1360,6 +1417,14 @@ static struct c2c_dimension dim_dcacheline_node = {
> > >  	.width		= 4,
> > >  };
> > >  
> > > +static struct c2c_dimension dim_dcacheline_mem_region = {
> > > +	.header		= HEADER_LOW("Region"),
> > > +	.name		= "dcacheline_mem_region",
> > > +	.cmp		= empty_cmp,
> > > +	.entry		= dcacheline_node_mem_region,
> > > +	.width		= 6,
> > > +};
> > > +
> > >  static struct c2c_dimension dim_dcacheline_count = {
> > >  	.header		= HEADER_LOW("PA cnt"),
> > >  	.name		= "dcacheline_count",
> > > @@ -1791,6 +1856,7 @@ static struct c2c_dimension dim_dcacheline_num_empty = {
> > >  
> > >  static struct c2c_dimension *dimensions[] = {
> > >  	&dim_dcacheline,
> > > +	&dim_dcacheline_mem_region,
> > >  	&dim_dcacheline_node,
> > >  	&dim_dcacheline_count,
> > >  	&dim_offset,
> > > @@ -2854,8 +2920,11 @@ static int ui_quirks(void)
> > >  	/* Fix the zero line for dcacheline column. */
> > >  	buf = fill_line(chk_double_cl ? "Double-Cacheline" : "Cacheline",
> > >  				dim_dcacheline.width +
> > > +				(c2c.show_mem_region ?
> > > +					dim_dcacheline_mem_region.width : 0) +
> > >  				dim_dcacheline_node.width +
> > > -				dim_dcacheline_count.width + 4);
> > > +				dim_dcacheline_count.width +
> > > +				(c2c.show_mem_region ? 6 : 4));
> > >  	if (!buf)
> > >  		return -ENOMEM;
> > >  
> > > @@ -3107,7 +3176,8 @@ static int perf_c2c__report(int argc, const char **argv)
> > >  	OPT_END()
> > >  	};
> > >  	int err = 0;
> > > -	const char *output_str, *sort_str = NULL;
> > > +	const char *sort_str = NULL;
> > > +	char *output_str = NULL;
> > >  	struct perf_env *env;
> > >  
> > >  	annotation_options__init();
> > > @@ -3272,9 +3342,16 @@ static int perf_c2c__report(int argc, const char **argv)
> > >  		goto out_mem2node;
> > >  	}
> > >  
> > > -	if (c2c.display != DISPLAY_SNP_PEER)
> > > -		output_str = "cl_idx,"
> > > +	c2c.show_mem_region = perf_header__has_feat(&session->header,
> > > +						HEADER_MEMORY_RANGES);
> > > +	if (c2c.show_mem_region)
> > > +		dim_dcacheline.header.line[0].span = 3;
> > > +
> > > +	if (c2c.display != DISPLAY_SNP_PEER) {
> > > +		if (asprintf(&output_str,
> > > +			     "cl_idx,"
> > >  			     "dcacheline,"
> > > +			     "%s"
> > >  			     "dcacheline_node,"
> > >  			     "dcacheline_count,"
> > >  			     "percent_costly_snoop,"
> > > @@ -3286,10 +3363,17 @@ static int perf_c2c__report(int argc, const char **argv)
> > >  			     "ld_fbhit,ld_l1hit,ld_l2hit,"
> > >  			     "ld_lclhit,lcl_hitm,"
> > >  			     "ld_rmthit,rmt_hitm,"
> > > -			     "dram_lcl,dram_rmt";
> > > -	else
> > > -		output_str = "cl_idx,"
> > > +			     "dram_lcl,dram_rmt",
> > > +			     c2c.show_mem_region ?
> > > +			     "dcacheline_mem_region," : "") < 0) {
> > > +			err = -ENOMEM;
> > > +			goto out_mem2node;
> > > +		}
> > > +	} else {
> > > +		if (asprintf(&output_str,
> > > +			     "cl_idx,"
> > >  			     "dcacheline,"
> > > +			     "%s"
> > >  			     "dcacheline_node,"
> > >  			     "dcacheline_count,"
> > >  			     "percent_costly_snoop,"
> > > @@ -3301,7 +3385,13 @@ static int perf_c2c__report(int argc, const char **argv)
> > >  			     "ld_fbhit,ld_l1hit,ld_l2hit,"
> > >  			     "ld_lclhit,lcl_hitm,"
> > >  			     "ld_rmthit,rmt_hitm,"
> > > -			     "dram_lcl,dram_rmt";
> > > +			     "dram_lcl,dram_rmt",
> > > +			     c2c.show_mem_region ?
> > > +			     "dcacheline_mem_region," : "") < 0) {
> > > +			err = -ENOMEM;
> > > +			goto out_mem2node;
> > > +		}
> > > +	}
> > >  
> > >  	if (c2c.display == DISPLAY_TOT_HITM)
> > >  		sort_str = "tot_hitm";
> > > @@ -3315,7 +3405,7 @@ static int perf_c2c__report(int argc, const char **argv)
> > >  	err = c2c_hists__reinit(&c2c.hists, output_str, sort_str, perf_session__env(session));
> > >  	if (err) {
> > >  		pr_err("Failed to reinitialize hists\n");
> > > -		goto out_mem2node;
> > > +		goto out_str;
> > >  	}
> > >  
> > >  	ui_progress__init(&prog, c2c.hists.hists.nr_entries, "Sorting...");
> > > @@ -3324,17 +3414,19 @@ static int perf_c2c__report(int argc, const char **argv)
> > >  	hists__output_resort_cb(&c2c.hists.hists, &prog, resort_shared_cl_cb);
> > >  	err = hists__iterate_cb(&c2c.hists.hists, resort_cl_cb, perf_session__env(session));
> > >  	if (err)
> > > -		goto out_mem2node;
> > > +		goto out_str;
> > >  
> > >  	ui_progress__finish();
> > >  
> > >  	if (ui_quirks()) {
> > >  		pr_err("failed to setup UI\n");
> > > -		goto out_mem2node;
> > > +		goto out_str;
> > >  	}
> > >  
> > >  	perf_c2c_display(session);
> > >  
> > > +out_str:
> > > +	free(output_str);
> > >  out_mem2node:
> > >  	mem2node__exit(&c2c.mem2node);
> > >  out_session:
> > > diff --git a/tools/perf/util/c2c.h b/tools/perf/util/c2c.h
> > > index 53f024e25d99..f04e78e1a2e3 100644
> > > --- a/tools/perf/util/c2c.h
> > > +++ b/tools/perf/util/c2c.h
> > > @@ -33,6 +33,7 @@ struct c2c_hist_entry {
> > >  	unsigned long		*nodeset;
> > >  	struct c2c_stats	*node_stats;
> > >  	unsigned int		 cacheline_idx;
> > > +	unsigned int		 mem_region;
> > >  
> > >  	struct compute_stats	 cstats;
> > >  
