Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BCA81AA8;
	Sat, 30 Aug 2025 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756536540; cv=none; b=TKHq8xoHBDmFAzLf/6Py3P5aGvZ1Oe/c4uN6tB3jz+AFm0rwkht3ngop+D3p2n0d2EKXHNCSZFFh+OfHU9viOEVGd9uMxifjyBFwhn7/hlam70m6TCvPwVUr9tceB+O8NBbPHgqbULQoNz5bvtcF5uQi56wuaEKD0AntjvWKzEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756536540; c=relaxed/simple;
	bh=Zxw0cs55pthG9E4mXE0qyKc9hk5+L3/wsvW8MBCRfg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOgirwGyI76GQe9LJFxAWxzzN25VcRigXI1w/DuEgm9oDbFp9sGULPF0+Q86eJYExLaGqf3FqMz5ti+ltWMtu6K+2eUu/O5nDxfcmSOQhJwL3aYsGxxzL+ObJMuOK4kHWYAGvaNYIN8EU8Y/BK+tPFqb7t+04HIC4Cg34dMgQZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFujK+Z0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFujK+Z0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CF5C4CEEB;
	Sat, 30 Aug 2025 06:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756536540;
	bh=Zxw0cs55pthG9E4mXE0qyKc9hk5+L3/wsvW8MBCRfg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RFujK+Z0mwy/iKDDj1JYlBUf3/5RsfqGr9A12gHIw+2ERS3CjjBB22zB0zgIasmUX
	 ovnTJiuY2fx9OSbunAlXCVkZVfjc/AJkOLKa2Egf6P5IDgOiEGCJjL5Y/4TvUapDbd
	 kdYRaLl1p9gzDFqAjJ5fpYNiBzlZ1lCu7IXBrWt44tfyh20QnHmedX7hVy4CwLJPW6
	 je6IMjBD0iC03PjX891pUx+J/XQ6q8cg7j/dIQTDk3kuaeae8wveLrX0M9TT80b9S9
	 0xYbT2Lg5M0PAB6tT8751Wm4hy7uoVKa8f5EIMubjvIaF55JGyTjY+p5Uw0xtVgAL2
	 jJZRVwpiwkA+Q==
Date: Fri, 29 Aug 2025 23:48:58 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Zecheng Li <zecheng@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/10] perf dwarf-aux: Find pointer type to a type
Message-ID: <aLKe2mdHGS_diq4h@google.com>
References: <20250825195412.223077-1-zecheng@google.com>
 <20250825195412.223077-6-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825195412.223077-6-zecheng@google.com>

On Mon, Aug 25, 2025 at 07:54:07PM +0000, Zecheng Li wrote:
> Implement die_find_pointer_to_type that searches for the pointer type to
> a given type in the CU. There's no guarantee that a pointer DIE exists
> for every possible base type. Compilers only generate DIEs for types
> actually used or defined. Returns NULL if no pointer type is found.
> 
> It prepares the support for tracking LEA instructions. When we load the
> effective address from a stack position to a register, the register now
> holds a pointer type to the type at that stack position.
> 
> The performance could be improved by adding a cache for the pointer
> types. Currently its impact on the annotation time for vmlinux is low.

I'm afraid the cache hit ratio can be low, but I have no data.  Anyway
can you please share the difference of annotation time before and after
this patchset?  It'd be nice if you have numbers for a large perf.data.

Thanks,
Namhyung

> 
> Signed-off-by: Zecheng Li <zecheng@google.com>
> ---
>  tools/perf/util/dwarf-aux.c | 69 +++++++++++++++++++++++++++++++++++++
>  tools/perf/util/dwarf-aux.h |  4 +++
>  2 files changed, 73 insertions(+)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 6fd2db5d9381..6e8877ff2172 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -2117,3 +2117,72 @@ Dwarf_Die *die_deref_ptr_type(Dwarf_Die *ptr_die, int offset,
>  
>  	return die_get_member_type(&type_die, offset, die_mem);
>  }
> +
> +struct find_pointer_type_data {
> +	/* DIE offset of the type we want to point to */
> +	Dwarf_Off target_type_offset;
> +	Dwarf_Die *found_die;
> +};
> +
> +static int __die_find_pointer_to_type_cb(Dwarf_Die *die_mem, void *arg)
> +{
> +	struct find_pointer_type_data *data = arg;
> +	Dwarf_Attribute type_attr;
> +	Dwarf_Die type_die;
> +	Dwarf_Off ref_type_offset;
> +
> +	if (dwarf_tag(die_mem) != DW_TAG_pointer_type)
> +		return DIE_FIND_CB_CONTINUE;
> +
> +	if (!dwarf_attr(die_mem, DW_AT_type, &type_attr))
> +		return DIE_FIND_CB_SIBLING;
> +
> +	/* Get the DIE this pointer points to */
> +	if (!dwarf_formref_die(&type_attr, &type_die))
> +		return DIE_FIND_CB_SIBLING;
> +
> +	ref_type_offset = dwarf_dieoffset(&type_die);
> +
> +	if (ref_type_offset != 0 && ref_type_offset == data->target_type_offset) {
> +		/* This die_mem is a pointer to the target type */
> +		if (data->found_die)
> +			*data->found_die = *die_mem;
> +		return DIE_FIND_CB_END;
> +	}
> +
> +	return DIE_FIND_CB_SIBLING;
> +}
> +
> +/**
> + * die_find_pointer_to_type - Find a DIE for a pointer to a given type
> + * @cu_die: The compilation unit to search within.
> + * @target_type: The DIE of the type you want to find a pointer to.
> + * @result_die: Buffer to store the found DW_TAG_pointer_type DIE.
> + *
> + * Scans the children of the @cu_die for a DW_TAG_pointer_type DIE
> + * whose DW_AT_type attribute references the @target_type.
> + *
> + * Return: @result_die if found, NULL otherwise.
> + */
> +Dwarf_Die *die_find_pointer_to_type(Dwarf_Die *cu_die, Dwarf_Die *target_type,
> +				   Dwarf_Die *result_die)
> +{
> +	struct find_pointer_type_data data;
> +	Dwarf_Die search_mem;
> +
> +	if (!cu_die || !target_type || !result_die)
> +		return NULL;
> +
> +	data.target_type_offset = dwarf_dieoffset(target_type);
> +	if (data.target_type_offset == 0) {
> +		pr_debug("Target type DIE has no offset\n");
> +		return NULL;
> +	}
> +	data.found_die = result_die;
> +
> +	if (die_find_child(cu_die, __die_find_pointer_to_type_cb, &data, &search_mem))
> +		return result_die;
> +
> +	return NULL;
> +}
> +
> diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> index cd481ec9c5a1..f20319eb97a9 100644
> --- a/tools/perf/util/dwarf-aux.h
> +++ b/tools/perf/util/dwarf-aux.h
> @@ -158,6 +158,10 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset, Dwarf_Die *die_m
>  /* Return type info where the pointer and offset point to */
>  Dwarf_Die *die_deref_ptr_type(Dwarf_Die *ptr_die, int offset, Dwarf_Die *die_mem);
>  
> +/* Find a DIE for a pointer to a given type */
> +Dwarf_Die *die_find_pointer_to_type(Dwarf_Die *cu_die, Dwarf_Die *target_type,
> +				   Dwarf_Die *result_die);
> +
>  /* Get byte offset range of given variable DIE */
>  int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf);
>  
> -- 
> 2.51.0.261.g7ce5a0a67e-goog
> 
