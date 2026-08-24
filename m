Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42863815FA;
	Mon, 24 Aug 2026 21:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787605450; cv=none; b=Ilc/wTjD5qVvFufpJK3TXU3a5B8vFYW445XMVkM6xtvytwy8J7JVfixrQLWvx/EEYdXI5pnVjkHzSGooqWC5tL4gxy6bxqQykI6u5bMYuNSrZ4mjNvxsn7L3Nt5H/O0ItriaduENAwh60pxIlzEdh5zywBuLlJuFHSp7b3N7Oec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787605450; c=relaxed/simple;
	bh=gDka1lYtby+/2XMrp9XtRhjX6G7a4rlmKVOg9FzCKRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpipOB69W3VS63vetM2HcGKeoBVE4r/jVKUKKmzlw5nF2HOj+CdYxoJjaPpjKe9MQfxzUXcHPV2oUpTVNjlbxpr9HxI++19/15Kz7gm8MsoEWAjtkHgZkcToHWlklGrK0evyUZj2oAGPzMOHNcuEE7xDB0qQVcM3Cg+NEJxYTjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtgZWZn9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtgZWZn9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB26B1F000E9;
	Mon, 24 Aug 2026 21:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787605448;
	bh=iPfvAyQ2MkYzmauJcubULxub5OKNZUixZBuctb9mAec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MtgZWZn9TM9rqvVQhbX2LFYm0QsujXn+xwBzNdPzD5aaqcJyetYOMMQwBKktNsAuf
	 4R2sPMD3aghLahEyH3LG+ccLZD0q0mfhDTTiNsr+rF2y2GXDNbUh6AbSy8zuRDtVOL
	 HU6g6tQo4ohTFhur6dgPn87hogmZCL19x4k0wWjoNhSNUjvr2uEs12mgICm1+Ge8Zh
	 Dh3b6DhLxH7As6N9DSDGXHOkBooZgu8OMFJ9iLQQqWk3D2xTjx07gx1bfV+TwCJtmy
	 6UcEgMfQUJnH/zS4gUJ5GOVsrz8x6JYpnA+BCWnA5+iDBrtWCP3dNomx7xNRbaZ1be
	 xy8l+nrFU+FtQ==
Date: Mon, 24 Aug 2026 14:04:06 -0700
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
Subject: Re: [PATCH 2/3] perf dwarf-aux: Add C++ class, inheritance and
 vtable helpers
Message-ID: <aoyxxgALuI_ljpQI@google.com>
References: <20260821050207.4517-1-yzhao62@ncsu.edu>
 <20260821050207.4517-3-yzhao62@ncsu.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260821050207.4517-3-yzhao62@ncsu.edu>

On Fri, Aug 21, 2026 at 01:02:06AM -0400, Yanbo Zhao wrote:
> Add DWARF helper functions for C++ virtual function support:
> - cu_get_language() and cu_is_cplusplus() to detect source language.
> - die_get_base_class() and die_get_vtable_index() for virtual table
>   inspection.
> - die_get_parent() to retrieve enclosing scopes.
> - die_find_member_by_offset() and die_find_virtual_func() to locate
>   class members and virtual function DIEs.
> - die_is_vptr_member() to check if a member is a virtual table pointer.
> - Define DW_AT_vtable_elem_index and DW_LANG_C_plus_plus_17/20
>   fallbacks for older elfutils that lack these DWARF 5 constants.
> 
> Signed-off-by: Yanbo Zhao <yzhao62@ncsu.edu>
> ---
>  tools/perf/util/dwarf-aux.c | 192 ++++++++++++++++++++++++++++++++++++
>  tools/perf/util/dwarf-aux.h |  24 +++++
>  2 files changed, 216 insertions(+)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 88ba0ec23a68..e991eed963a8 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -12,6 +12,19 @@
>  #include "dwarf-regs.h"
>  #include "strbuf.h"
>  #include "string2.h"
> +#include "symbol.h"
> +
> +#ifndef DW_AT_vtable_elem_index
> +#define DW_AT_vtable_elem_index 0x8c
> +#endif

I'm not sure about this.  My system has dwarf.h with the following.

 DW_AT_vtable_elem_location = 0x4d,

 DW_AT_loclists_base = 0x8c,

> +
> +/* Added in DWARF 5, may be missing in older elfutils */
> +#ifndef DW_LANG_C_plus_plus_17
> +#define DW_LANG_C_plus_plus_17 0x2a
> +#endif
> +#ifndef DW_LANG_C_plus_plus_20
> +#define DW_LANG_C_plus_plus_20 0x2b
> +#endif

Also, these are enum constants, not macros.  So it won't be defined even
on recent versions.  And there are DW_LANG_C_plus_plus_23 (0x3a) too.

>  
>  /**
>   * cu_find_realpath - Find the realpath of the target file
> @@ -60,6 +73,37 @@ const char *cu_get_comp_dir(Dwarf_Die *cu_die)
>  	return dwarf_formstring(&attr);
>  }
>  
> +Dwarf_Word cu_get_language(Dwarf_Die *cu_die)
> +{
> +	Dwarf_Attribute attr;
> +	Dwarf_Word lang;
> +
> +	if (dwarf_attr(cu_die, DW_AT_language, &attr) == NULL)
> +		return 0;
> +
> +	if (dwarf_formudata(&attr, &lang) != 0)
> +		return 0;
> +
> +	return lang;
> +}

If it's not used elsewhere, probably better to make it static.

> +
> +bool cu_is_cplusplus(Dwarf_Die *cu_die)
> +{
> +	Dwarf_Word lang = cu_get_language(cu_die);
> +
> +	switch (lang) {
> +	case DW_LANG_C_plus_plus:
> +	case DW_LANG_C_plus_plus_03:
> +	case DW_LANG_C_plus_plus_11:
> +	case DW_LANG_C_plus_plus_14:
> +	case DW_LANG_C_plus_plus_17:
> +	case DW_LANG_C_plus_plus_20:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  bool die_is_compound_type(Dwarf_Die *type_die)
>  {
>  	int tag = dwarf_tag(type_die);
> @@ -68,6 +112,90 @@ bool die_is_compound_type(Dwarf_Die *type_die)
>  	       tag == DW_TAG_class_type;
>  }
>  
> +static int __die_find_inheritance_cb(Dwarf_Die *die_mem, void *arg)
> +{
> +	int tag = dwarf_tag(die_mem);
> +
> +	if (tag == DW_TAG_inheritance) {
> +		*(Dwarf_Die *)arg = *die_mem;
> +		return DIE_FIND_CB_END;
> +	}
> +
> +	return DIE_FIND_CB_SIBLING;
> +}
> +
> +Dwarf_Die *die_get_base_class(Dwarf_Die *class_die, Dwarf_Die *base_die, int *offset)
> +{
> +	Dwarf_Die inherit_die;
> +	Dwarf_Attribute attr;
> +	Dwarf_Word loc;
> +
> +	if (die_find_child(class_die, __die_find_inheritance_cb,
> +			   &inherit_die, &inherit_die) == NULL)
> +		return NULL;
> +
> +	if (__die_get_real_type(&inherit_die, base_die) == NULL)
> +		return NULL;
> +
> +	if (dwarf_attr_integrate(&inherit_die, DW_AT_data_member_location, &attr) &&
> +	    dwarf_formudata(&attr, &loc) == 0) {

As Sashiko said, you need to handle other formats.


> +		*offset = loc;
> +	} else {
> +		*offset = 0;
> +	}
> +
> +	return base_die;
> +}
> +
> +int die_get_vtable_index(Dwarf_Die *func_die, int *index)

It'd be great to clarify what it returns.  It's not clear to me what the
index means here.  Is it for an index of the @func_die in the vtable of
the current class?

> +{
> +	Dwarf_Attribute attr;
> +	Dwarf_Word idx;
> +
> +	/* Try DW_AT_vtable_elem_index first (DWARF 5+) */
> +	if (dwarf_attr(func_die, DW_AT_vtable_elem_index, &attr) &&
> +	    dwarf_formudata(&attr, &idx) == 0) {
> +		*index = idx;
> +		return 0;
> +	}
> +
> +	/* Fallback to DW_AT_vtable_elem_location (older DWARF) */
> +	if (dwarf_attr(func_die, DW_AT_vtable_elem_location, &attr)) {

According to the Sashiko review, it would return a byte offset instead
of an index.  If so, it should be converted for consistency.


> +		Dwarf_Op *expr;
> +		size_t expr_len;
> +
> +		/* Compile often emits it as a simple constant expression or block */
> +		if (dwarf_getlocation(&attr, &expr, &expr_len) == 0 && expr_len > 0) {
> +			if (expr[0].atom == DW_OP_constu) {
> +				*index = expr[0].number;
> +				return 0;
> +			}
> +			if (expr[0].atom >= DW_OP_lit0 && expr[0].atom <= DW_OP_lit31) {
> +				*index = expr[0].atom - DW_OP_lit0;
> +				return 0;
> +			}
> +		}
> +	}
> +
> +	return -1;
> +}
> +
> +Dwarf_Die *die_get_parent(Dwarf_Die *die, Dwarf_Die *parent_die)
> +{
> +	Dwarf_Die *scopes = NULL;
> +	int n = dwarf_getscopes_die(die, &scopes);
> +
> +	if (n <= 1) {
> +		free(scopes);
> +		return NULL;
> +	}
> +
> +	/* scopes[0] is the DIE itself, scopes[1] is the parent */
> +	*parent_die = scopes[1];
> +	free(scopes);
> +	return parent_die;
> +}

Where is this function used?

> +
>  /* Unlike dwarf_getsrc_die(), cu_getsrc_die() only returns statement line */
>  static Dwarf_Line *cu_getsrc_die(Dwarf_Die *cu_die, Dwarf_Addr addr)
>  {
> @@ -2164,6 +2292,70 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset,
>  	return die_mem;
>  }
>  
> +Dwarf_Die *die_find_member_by_offset(Dwarf_Die *type_die, int offset, Dwarf_Die *member_die)
> +{
> +	if (!die_is_compound_type(type_die))
> +		return NULL;
> +
> +	return die_find_child(type_die, __die_find_member_offset_cb,
> +			      (void *)(long)offset, member_die);
> +}

Isn't it basically the same as die_get_member_type()?

Thanks,
Namhyung

> +
> +struct find_virtual_func_data {
> +	int index;
> +	Dwarf_Die func_die;
> +	bool found;
> +};
> +
> +static int __die_find_virtual_func_cb(Dwarf_Die *die_mem, void *arg)
> +{
> +	struct find_virtual_func_data *ad = arg;
> +	int tag = dwarf_tag(die_mem);
> +
> +	if (tag == DW_TAG_subprogram) {
> +		int idx;
> +
> +		if (die_get_vtable_index(die_mem, &idx) == 0 && idx == ad->index) {
> +			ad->func_die = *die_mem;
> +			ad->found = true;
> +			return DIE_FIND_CB_END;
> +		}
> +	}
> +
> +	if (tag == DW_TAG_inheritance) {
> +		Dwarf_Die base_type;
> +
> +		if (__die_get_real_type(die_mem, &base_type)) {
> +			if (die_find_child(&base_type,
> +					   __die_find_virtual_func_cb,
> +					   ad, &ad->func_die))
> +				return DIE_FIND_CB_END;
> +		}
> +	}
> +
> +	return DIE_FIND_CB_SIBLING;
> +}
> +
> +Dwarf_Die *die_find_virtual_func(Dwarf_Die *class_die, int index, Dwarf_Die *die_mem)
> +{
> +	struct find_virtual_func_data ad = {
> +		.index = index,
> +		.found = false,
> +	};
> +
> +	if (die_find_child(class_die, __die_find_virtual_func_cb, &ad, die_mem))
> +		return die_mem;
> +
> +	return NULL;
> +}
> +
> +bool die_is_vptr_member(Dwarf_Die *die)
> +{
> +	const char *name = dwarf_diename(die);
> +
> +	return name && strstarts(name, "_vptr");
> +}
> +
>  /**
>   * die_deref_ptr_type - Return type info for pointer access
>   * @ptr_die: a pointer type DIE
> diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> index 855c45fec5bb..0f30f44ad863 100644
> --- a/tools/perf/util/dwarf-aux.h
> +++ b/tools/perf/util/dwarf-aux.h
> @@ -23,9 +23,33 @@ const char *cu_find_realpath(Dwarf_Die *cu_die, const char *fname);
>  /* Get DW_AT_comp_dir (should be NULL with older gcc) */
>  const char *cu_get_comp_dir(Dwarf_Die *cu_die);
>  
> +/* Get source language of CU */
> +Dwarf_Word cu_get_language(Dwarf_Die *cu_die);
> +
> +/* Check if CU is C++ */
> +bool cu_is_cplusplus(Dwarf_Die *cu_die);
> +
>  /* Check if DIE is a compound type (structure, union, or class) */
>  bool die_is_compound_type(Dwarf_Die *type_die);
>  
> +/* Get base class of a class DIE */
> +Dwarf_Die *die_get_base_class(Dwarf_Die *class_die, Dwarf_Die *base_die, int *offset);
> +
> +/* Get vtable index of a virtual function */
> +int die_get_vtable_index(Dwarf_Die *func_die, int *index);
> +
> +/* Get parent DIE */
> +Dwarf_Die *die_get_parent(Dwarf_Die *die, Dwarf_Die *parent_die);
> +
> +/* Find member DIE by offset */
> +Dwarf_Die *die_find_member_by_offset(Dwarf_Die *type_die, int offset, Dwarf_Die *member_die);
> +
> +/* Find virtual function by vtable index */
> +Dwarf_Die *die_find_virtual_func(Dwarf_Die *class_die, int index, Dwarf_Die *die_mem);
> +
> +/* Check if member DIE is a vtable pointer (_vptr) */
> +bool die_is_vptr_member(Dwarf_Die *die);
> +
>  /* Get a line number and file name for given address */
>  int cu_find_lineinfo(Dwarf_Die *cudie, Dwarf_Addr addr,
>  		     const char **fname, int *lineno);
> -- 
> 2.25.1
> 
