Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1FD14A8B;
	Sun, 27 Jul 2025 00:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753575879; cv=none; b=tRfd3EJWLUahIgeMN7Qz0xnwNT0HkvXi2Y3XfN2NtaXbl9W3chEPQ9+2xJc9vU2pDEnTGb7PSEwiO3kd/4c3EFqTxnU9A5jij+hFZU9Dhsm8lmCqqRawubCYPaDUBt6Aw2PfRGkvDp7TesaOVDlJOnmBkn7a/enppf75tb/O7fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753575879; c=relaxed/simple;
	bh=QErINEHLnzOW5TIb1dbHg5ST6OfobvNV6jsJnt1NI00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrUqCREPUZljMDVLwNEsc0WEtuLo8LR2HNZiZifTwHxQ5mYHv22B65ZQ7d0FEWxVfcSuoMc+4rFdflgfzW4vD+5boF05zmUh6jvjuA9fGYUsGJQZ4ckEtLjob29qKRHVwQmhG8/q8c6J8b/fT93RhDQg4vvUDDWyUKIvmyKUshA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwLQVddo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwLQVddo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD41C4CEED;
	Sun, 27 Jul 2025 00:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753575879;
	bh=QErINEHLnzOW5TIb1dbHg5ST6OfobvNV6jsJnt1NI00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kwLQVddo5BjWn4tComYo7qMpvDiLbMUIkwzMT/LKgTymSWvwzedVCkN5FHTLFxDK2
	 NIrnzBvJRNDXo3ugga+ZE8GQQDqlBxDi2XHkL566fPql2opc5FScLp5fs16Uofkrkm
	 Vn8x6YnolWfqvZAyRptNT+b83wxDN+MNbrB0BexvQINhMHRLj/8Esm/9FIFxb6++v1
	 P+4rj2uanIeFq0oPJlzGoefP3Oy3FaZ7TeXcwYzzK6OS8EjH4txgdkkOGqBIB3GBc1
	 XzGd987/P55ujcg+SsuN22EyhzvxAoyCJuvUbZq7d4Dq4XLpX31wr+wAp1hHIddN+t
	 1BIyMP1jSDCtw==
Date: Sat, 26 Jul 2025 17:24:37 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Zecheng Li <zecheng@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, Zecheng Li <zli94@ncsu.edu>,
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/6] perf dwarf-aux: Find pointer type to a type
Message-ID: <aIVxxfiHH0JTQkpr@google.com>
References: <20250725202809.1230085-1-zecheng@google.com>
 <20250725202809.1230085-6-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250725202809.1230085-6-zecheng@google.com>

On Fri, Jul 25, 2025 at 08:28:08PM +0000, Zecheng Li wrote:
> Implement die_find_pointer_to_type that searches for the pointer type to
> a given type in the CU. There's no guarantee that a pointer DIE exists
> for every possible base type. Compilers only generate DIEs for types
> actually used or defined.

Please describe why it's necessary first.  What happens if it fails to
fine one?

Thanks,
Namhyung

> 
> The performance could be improved by adding a cache for the pointer
> types. Currently its impact on the annotation time for vmlinux is low.
> 
> Signed-off-by: Zecheng Li <zecheng@google.com>
> ---
>  tools/perf/util/dwarf-aux.c | 69 +++++++++++++++++++++++++++++++++++++
>  tools/perf/util/dwarf-aux.h |  4 +++
>  2 files changed, 73 insertions(+)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 4039dbd2b8c0..49d509839a85 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -2121,3 +2121,72 @@ Dwarf_Die *die_deref_ptr_type(Dwarf_Die *ptr_die, int offset,
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
> index 892c8c5c23fc..7e1336ff276e 100644
> --- a/tools/perf/util/dwarf-aux.h
> +++ b/tools/perf/util/dwarf-aux.h
> @@ -156,6 +156,10 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset, Dwarf_Die *die_m
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
> 2.50.1.470.g6ba607880d-goog
> 
