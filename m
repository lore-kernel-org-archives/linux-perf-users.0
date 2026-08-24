Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BDC38E8A9;
	Mon, 24 Aug 2026 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787603745; cv=none; b=aHYVpI/CFHLv2TB3tQISFGGyosKCjit2kUXS3Lilr4C5t/x0LGTo3uUkdMkdrWhsfokVC8t1IUEpSoHDve2R5OW1SKqw6FphqhvMlVrpiO/4iOsuXxkfIVdxX7unVRuWsejJC4OFMIAjpaaA/WGr58QYeY8s/pKMr0gUxuMQUJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787603745; c=relaxed/simple;
	bh=rWngIgQzNaE9lYMrIM6syp3jYqhxZpN4l4I0A0pMK54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOLsvHrVXC13b5sF5RzxDPsKryctTELw531VReOqTG9Wa99eeBP4rqAm5SNURDhKBSLez7Wv+BFJW9akIN2ceSoG6Bav52KqUgbHaKQTmo80hu5nQpmeAEPpXv+MDlFCa9A7ALrcij+8d+1B88GYhzfyQ+8xLwpf1TAFMlvB++8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJnofquH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJnofquH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE7B1F000E9;
	Mon, 24 Aug 2026 20:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787603742;
	bh=1uvfcipTeywuwBvWG7fWjuh1CocA+I14rRFF3OXycMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EJnofquHqS8Sx0Qz1NFrGWP6ykpiZIIxDSW56I+Qwyt0wuuiKOkjbc0QX2EX9HRJ/
	 XUYNNzMVhwW9bAjiAqetKidP9l49uIj0kG3MeR6liHpbHkDSxUfXSnnV0MtY0WG17S
	 NneS5h/eo3kIgJ2I/AfaLU8WhU4Jn+u92VlNhx24K+gUJ9k1G4DhpK5oB6HWdNy0/4
	 2ymMHe5fvLs9+bATjZ2bPeLcfLnrQqN6memJxZLkKdm0Idmbv2Rg3L5AiH0SIgZT2+
	 W08be9kYbBk2IzhJbLG2/I7TCy9d8m5dAPuOa0dE+WmM/Wnb9MCcdpi6P0+3Lp2caK
	 URo/Q5rn6n+0Q==
Date: Mon, 24 Aug 2026 13:35:41 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Yanbo Zhao <yzhao62@ncsu.edu>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Zecheng Li <zli94@ncsu.edu>,
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] perf dwarf-aux: Add die_is_compound_type() to handle
 C++ class types
Message-ID: <aoyrHe2MBOf4ocqn@google.com>
References: <20260821050207.4517-1-yzhao62@ncsu.edu>
 <20260821050207.4517-2-yzhao62@ncsu.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260821050207.4517-2-yzhao62@ncsu.edu>

Hello,

On Fri, Aug 21, 2026 at 01:02:05AM -0400, Yanbo Zhao wrote:
> Introduce the die_is_compound_type() helper which checks for
> DW_TAG_structure_type, DW_TAG_union_type, and DW_TAG_class_type, and
> convert all the existing open-coded struct/union tag checks to use it:
> - die_get_member_type() in dwarf-aux.c.
> - __add_member_cb(), is_compound_type(), and set_stack_state() in
>   annotate-data.c.

I think this part is fine.

> 
> Also accept DW_TAG_inheritance in the member lookup callbacks
> (__die_find_member_offset_cb() and __add_member_cb()) so that member
> lookup by offset descends into C++ base class subobjects.
> 
> This extends the existing member type resolution and data type
> profiling state handling to C++ classes with inheritance without
> changing behavior for C struct/union types.

But this part is a little unclear.  Can you please share an example
DWARF of a class that has inherited members?  It'd be helpful for others
to understand why it needs to handle the tag in the same way.

Thanks,
Namhyung

> 
> Signed-off-by: Yanbo Zhao <yzhao62@ncsu.edu>
> ---
>  tools/perf/util/annotate-data.c | 29 ++++++-----------------------
>  tools/perf/util/dwarf-aux.c     | 17 ++++++++++++-----
>  tools/perf/util/dwarf-aux.h     |  3 +++
>  3 files changed, 21 insertions(+), 28 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 4e4c58764082..ee6bd2d0012d 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -230,9 +230,9 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
>  	Dwarf_Word size, loc, bit_size = 0;
>  	Dwarf_Attribute attr;
>  	struct strbuf sb;
> -	int tag;
> +	int tag = dwarf_tag(die);
>  
> -	if (dwarf_tag(die) != DW_TAG_member)
> +	if (tag != DW_TAG_member && tag != DW_TAG_inheritance)
>  		return DIE_FIND_CB_SIBLING;
>  
>  	member = zalloc(sizeof(*member));
> @@ -292,15 +292,8 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
>  	INIT_LIST_HEAD(&member->children);
>  	list_add_tail(&member->node, &parent->children);
>  
> -	tag = dwarf_tag(&die_mem);
> -	switch (tag) {
> -	case DW_TAG_structure_type:
> -	case DW_TAG_union_type:
> +	if (die_is_compound_type(&die_mem))
>  		die_find_child(&die_mem, __add_member_cb, member, &die_mem);
> -		break;
> -	default:
> -		break;
> -	}
>  	return DIE_FIND_CB_SIBLING;
>  }
>  
> @@ -464,9 +457,7 @@ static const char *match_result_str(enum type_match_result tmr)
>  
>  static bool is_compound_type(Dwarf_Die *type_die)
>  {
> -	int tag = dwarf_tag(type_die);
> -
> -	return tag == DW_TAG_structure_type || tag == DW_TAG_union_type;
> +	return die_is_compound_type(type_die);
>  }
>  
>  /* returns if Type B has better information than Type A */
> @@ -584,7 +575,6 @@ struct type_state_stack *find_stack_state(struct type_state *state,
>  void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
>  			    Dwarf_Die *type_die, int ptr_offset)
>  {
> -	int tag;
>  	Dwarf_Word size;
>  
>  	if (kind == TSR_KIND_POINTER) {
> @@ -605,17 +595,10 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
>  		return;
>  	}
>  
> -	tag = dwarf_tag(type_die);
> -
> -	switch (tag) {
> -	case DW_TAG_structure_type:
> -	case DW_TAG_union_type:
> +	if (die_is_compound_type(type_die))
>  		stack->compound = (kind != TSR_KIND_PERCPU_POINTER);
> -		break;
> -	default:
> +	else
>  		stack->compound = false;
> -		break;
> -	}
>  }
>  
>  struct type_state_stack *findnew_stack_state(struct type_state *state,
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index d7160f87ac7d..88ba0ec23a68 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -60,6 +60,14 @@ const char *cu_get_comp_dir(Dwarf_Die *cu_die)
>  	return dwarf_formstring(&attr);
>  }
>  
> +bool die_is_compound_type(Dwarf_Die *type_die)
> +{
> +	int tag = dwarf_tag(type_die);
> +
> +	return tag == DW_TAG_structure_type || tag == DW_TAG_union_type ||
> +	       tag == DW_TAG_class_type;
> +}
> +
>  /* Unlike dwarf_getsrc_die(), cu_getsrc_die() only returns statement line */
>  static Dwarf_Line *cu_getsrc_die(Dwarf_Die *cu_die, Dwarf_Addr addr)
>  {
> @@ -2053,7 +2061,7 @@ static int __die_find_member_offset_cb(Dwarf_Die *die_mem, void *arg)
>  	Dwarf_Word offset = (long)arg;
>  	int tag = dwarf_tag(die_mem);
>  
> -	if (tag != DW_TAG_member)
> +	if (tag != DW_TAG_member && tag != DW_TAG_inheritance)
>  		return DIE_FIND_CB_SIBLING;
>  
>  	/* Unions might not have location */
> @@ -2104,7 +2112,7 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset,
>  
>  	tag = dwarf_tag(type_die);
>  	/* If it's not a compound type, return the type directly */
> -	if (tag != DW_TAG_structure_type && tag != DW_TAG_union_type) {
> +	if (!die_is_compound_type(type_die)) {
>  		Dwarf_Word size;
>  
>  		if (dwarf_aggregate_size(type_die, &size) < 0)
> @@ -2119,7 +2127,7 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset,
>  
>  	mb_type = *type_die;
>  	/* TODO: Handle union types better? */
> -	while (tag == DW_TAG_structure_type || tag == DW_TAG_union_type) {
> +	while (die_is_compound_type(&mb_type)) {
>  		member = die_find_child(&mb_type, __die_find_member_offset_cb,
>  					(void *)(long)offset, die_mem);
>  		if (member == NULL)
> @@ -2130,8 +2138,7 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset,
>  
>  		tag = dwarf_tag(&mb_type);
>  
> -		if (tag == DW_TAG_structure_type || tag == DW_TAG_union_type ||
> -		    tag == DW_TAG_array_type) {
> +		if (die_is_compound_type(&mb_type) || tag == DW_TAG_array_type) {
>  			Dwarf_Word loc;
>  
>  			/* Update offset for the start of the member struct */
> diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> index 161f0bf980b6..855c45fec5bb 100644
> --- a/tools/perf/util/dwarf-aux.h
> +++ b/tools/perf/util/dwarf-aux.h
> @@ -23,6 +23,9 @@ const char *cu_find_realpath(Dwarf_Die *cu_die, const char *fname);
>  /* Get DW_AT_comp_dir (should be NULL with older gcc) */
>  const char *cu_get_comp_dir(Dwarf_Die *cu_die);
>  
> +/* Check if DIE is a compound type (structure, union, or class) */
> +bool die_is_compound_type(Dwarf_Die *type_die);
> +
>  /* Get a line number and file name for given address */
>  int cu_find_lineinfo(Dwarf_Die *cudie, Dwarf_Addr addr,
>  		     const char **fname, int *lineno);
> -- 
> 2.25.1
> 
