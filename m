Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2514A49F117;
	Mon, 14 Sep 2026 20:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418370; cv=none; b=U5m3PeS8FosT0JUW10jAMVtETbOOaMkwUknjClsjUaNmWviKxF9H2hLwCt8ScXKhs4IOgdRsFzCdnT2aNR6O5YgIjCoT5cbMUWsrr/wW0n0pGNsLJArTBS2Qlq+Pxvg9tZPx3wSKG/pdMkFPU7eeUUrZXb1D/n9s4FrmuQoGqo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418370; c=relaxed/simple;
	bh=SZMm5JhQ3rtHkXCtk3Gm/t2hXaWp+vV6LZCMC/mAxg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uS1+W5FGmi1L+pPQ/i+Q+8maJDuQalQz+6iy+/lH/8kFDWFPSXvPjUX5ZRHVqcF9iFXEV80w2FhMPPsLthPAObPuaQwLEK5+LSgD+mhQkdFr5+NiTwUN80bhdPVLpUXAgfpV9XmnS7P+hr+Mm746JixhLh57Ce49HWqRX+kamEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIBhjAjC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIBhjAjC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9B41F000FF;
	Mon, 14 Sep 2026 20:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789418368;
	bh=F3aAjzg9LQumCCuRdvQcl6jJ04MArf3JAXzxMo6Hu0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RIBhjAjCgk+ZccEVJPUZghu1iYaNFl20qME8Fdl1JBY1PhiI5wc7h4LagA1abugcm
	 4l2KOvgjwAh5v+ccbQrjmtiNBVTL0GGmTqZa9bWMxJb9z2q60k0k94QlIabfiSo9KG
	 mIzCQwReSSS+URw9bWkfM02xMmMo5ooupNgI96IP5SEKoMsdcAVCoUIsRWiwDNthwX
	 S6lZtRtY/ydqVm4gveFmHo85/jGAXBK5hS95Jzd24TFVlVfwkQKsjTotml8MiLFs2y
	 wD/4N7WR10UW8Vw+1Vvbw1NL0L+QQhxhQ7mtkFCDx1AukHJWsb6nwO13tEo0Rc1oW3
	 tMANTBH4VddHw==
Date: Mon, 14 Sep 2026 13:39:26 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Zecheng Li <zli94@ncsu.edu>,
	Yanbo Zhao <yzhao62@ncsu.edu>,
	Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v2 3/4] perf annotate-date: Allow out-of-size access for
 flex-array types
Message-ID: <aqhbflQOLmWz3RMM@google.com>
References: <20260914064535.1671939-1-namhyung@kernel.org>
 <20260914064535.1671939-4-namhyung@kernel.org>
 <5d51668c-3646-402f-83b4-7f6ee4a415e7@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5d51668c-3646-402f-83b4-7f6ee4a415e7@huaweicloud.com>

On Mon, Sep 14, 2026 at 08:19:44PM +0800, Tengda Wu wrote:
> 
> 
> On 2026/9/14 14:45, Namhyung Kim wrote:
> > Structs that have a flex array will have accesses beyond its original
> > size as the array was declared as 0 sized.  For now, it just allow any
> > offset bigger than the size.  It could be refined later.
> > 
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/annotate-data.c | 63 ++++++++++++++++++---------------
> >  tools/perf/util/annotate-data.h |  2 ++
> >  2 files changed, 36 insertions(+), 29 deletions(-)
> > 
> > diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> > index aff60a630fd05b01..e8aff6a916c0afe0 100644
> > --- a/tools/perf/util/annotate-data.c
> > +++ b/tools/perf/util/annotate-data.c
> > @@ -7,6 +7,7 @@
> >  #include <errno.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> > +#include <string.h>
> >  #include <inttypes.h>
> >  #include <linux/zalloc.h>
> >  
> > @@ -248,8 +249,15 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
> >  	else
> >  		die_mem = member_type;
> >  
> > -	if (dwarf_aggregate_size(&die_mem, &size) < 0)
> > -		size = 0;
> > +	if (dwarf_aggregate_size(&die_mem, &size) < 0) {
> > +		if (dwarf_tag(&die_mem) == DW_TAG_array_type) { /* flex-array? */
> > +			die_get_real_type(&die_mem, &die_mem);
> > +			if (dwarf_aggregate_size(&die_mem, &size) < 0)
> > +				size = 0;
> > +		} else {
> > +			size = 0;
> > +		}
> > +	}
> >  
> >  	if (dwarf_attr_integrate(die, DW_AT_data_member_location, &attr)) {
> >  		if (dwarf_formudata(&attr, &loc) != 0) {
> > @@ -399,6 +407,7 @@ static struct annotated_data_type *dso__findnew_data_type(struct dso *dso,
> >  	result->self.type_name = type_name;
> >  	result->self.size = size;
> >  	INIT_LIST_HEAD(&result->self.children);
> > +	result->flex_array = die_has_flex_array(type_die);
> >  
> >  	if (symbol_conf.annotate_data_member)
> >  		add_member_types(result, type_die);
> > @@ -517,13 +526,30 @@ static bool is_better_type(Dwarf_Die *type_a, Dwarf_Die *type_b)
> >  	return false;
> >  }
> >  
> > +static enum type_match_result check_type_offset(Dwarf_Die *type_die, int offset)
> > +{
> > +	Dwarf_Word size;
> > +
> > +	/* Get the size of the actual type */
> > +	if (dwarf_aggregate_size(type_die, &size) < 0)
> > +		return PERF_TMR_NO_SIZE;
> > +
> > +	/* Minimal sanity check */
> > +	if (offset < 0)
> > +		return PERF_TMR_BAD_OFFSET;
> > +
> > +	if ((unsigned)offset >= size && !die_has_flex_array(type_die))
> > +		return PERF_TMR_BAD_OFFSET;
> > +
> > +	return PERF_TMR_OK;
> > +}
> > +
> >  /* The type info will be saved in @type_die */
> >  static enum type_match_result check_variable(struct data_loc_info *dloc,
> >  					     Dwarf_Die *var_die,
> >  					     Dwarf_Die *type_die, int reg,
> >  					     int offset, bool is_fbreg)
> >  {
> > -	Dwarf_Word size;
> >  	bool needs_pointer = true;
> >  	Dwarf_Die sized_type;
> >  
> > @@ -554,15 +580,7 @@ static enum type_match_result check_variable(struct data_loc_info *dloc,
> >  	else
> >  		sized_type = *type_die;
> >  
> > -	/* Get the size of the actual type */
> > -	if (dwarf_aggregate_size(&sized_type, &size) < 0)
> > -		return PERF_TMR_NO_SIZE;
> > -
> > -	/* Minimal sanity check */
> > -	if ((unsigned)offset >= size)
> > -		return PERF_TMR_BAD_OFFSET;
> > -
> > -	return PERF_TMR_OK;
> > +	return check_type_offset(type_die, offset);
> >  }
> >  
> >  struct type_state_stack *find_stack_state(struct type_state *state,
> > @@ -1112,7 +1130,6 @@ static enum type_match_result check_matching_type(struct type_state *state,
> >  						  struct disasm_line *dl,
> >  						  Dwarf_Die *type_die)
> >  {
> > -	Dwarf_Word size;
> >  	u32 insn_offset = dl->al.offset;
> >  	int reg = dloc->op->reg1;
> >  	int offset = dloc->op->offset;
> > @@ -1166,12 +1183,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
> >  		else
> >  			sized_type = *type_die;
> >  
> > -		/* Get the size of the actual type */
> > -		if (dwarf_aggregate_size(&sized_type, &size) < 0 ||
> > -		    (unsigned)dloc->type_offset >= size)
> > -			return PERF_TMR_BAD_OFFSET;
> > -
> > -		return PERF_TMR_OK;
> > +		return check_type_offset(&sized_type, dloc->type_offset);
> >  	}
> >  
> >  	if (state->regs[reg].kind == TSR_KIND_POINTER) {
> > @@ -1190,12 +1202,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
> >  
> >  		dloc->type_offset = dloc->op->offset + state->regs[reg].offset;
> >  
> > -		/* Get the size of the actual type */
> > -		if (dwarf_aggregate_size(type_die, &size) < 0 ||
> > -		    (unsigned)dloc->type_offset >= size)
> > -			return PERF_TMR_BAD_OFFSET;
> > -
> > -		return PERF_TMR_OK;
> > +		return check_type_offset(type_die, dloc->type_offset);
> >  	}
> >  
> >  	if (state->regs[reg].kind == TSR_KIND_PERCPU_POINTER) {
> > @@ -1209,9 +1216,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
> >  
> >  		dloc->type_offset = dloc->op->offset;
> >  
> > -		/* Get the size of the actual type */
> > -		if (dwarf_aggregate_size(type_die, &size) < 0 ||
> > -		    (unsigned)dloc->type_offset >= size)
> > +		if (check_type_offset(type_die, dloc->type_offset) != PERF_TMR_OK)
> >  			return PERF_TMR_BAIL_OUT;
> >  
> >  		return PERF_TMR_OK;
> > @@ -1839,7 +1844,7 @@ int annotated_data_type__update_samples(struct annotated_data_type *adt,
> >  			return -1;
> >  	}
> >  
> > -	if (offset < 0 || offset >= adt->self.size)
> > +	if (offset < 0 || (offset >= adt->self.size && !adt->flex_array))
> >  		return -1;
> >  
> >  	h = &adt->histograms[evsel->core.idx];
> > diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
> > index ca2096a9ee62cbfe..27b7148b64f60350 100644
> > --- a/tools/perf/util/annotate-data.h
> > +++ b/tools/perf/util/annotate-data.h
> > @@ -85,6 +85,7 @@ struct type_hist {
> >   * struct annotated_data_type - Data type to profile
> >   * @node: RB-tree node for dso->type_tree
> >   * @self: Actual type information
> > + * @flex_array: Whethere it has a flex array
> 
> Nit: typo in the comment -- Whethere should be Whether.

Will fix.

Thanks,
Namhyung

