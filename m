Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B32013957E;
	Thu, 28 Aug 2025 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363924; cv=none; b=QIchLcpNkafHypHtqlG2o0bkIzofOa9PcRyrl7T9UOqC2muuyoCFdRak3WcVEb1/ro7S0SW0u1dnQ+ZOKdFia0D/FuJo7PFFUbsPwVCgu0/fSZ0vkWkNm8qZayW9U3D30r3iBkwfYKHZIXPNXxZ7R9r3DW8VuAoXPopQHee00YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363924; c=relaxed/simple;
	bh=fCVOV/aa9kx2YHBGI2L4+nLbGmu/QgZ/y4517/LJAMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+YxYvawtnCpns+WGESwbfXlw4YLW1zrDnrgyBtBkMhWaaK9YrL+TAM4sl18gMNAueyCqj+R4TrJFtVSA9dxAAaD9BdAI4zvSMm3cUFWz83GLieff00YECMbxcLEUa8XAvsQxVuuAHfUkYTIEmPn1+yiJgwdpLXy3u6q9n8MOuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0bgw7Qr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0bgw7Qr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CCFC4CEEB;
	Thu, 28 Aug 2025 06:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756363924;
	bh=fCVOV/aa9kx2YHBGI2L4+nLbGmu/QgZ/y4517/LJAMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z0bgw7Qr3AD2hv+fsiJGK8Ys6ytPdZ7CMfQua6XlwiwoBuwGF0scXSJqL7UxqTSbS
	 +lhEMGZojY5wQpppzYa9rkNolKrSZ5ikVGA5hhYSygWZSYiBD3ErGekt6ao27wELb8
	 oL7FNWkSj+SrI7gpEJ56hrqqHSR5JCVtWu3r0HE5gNCNqcgB74gyCNuB5IwjVH3ezL
	 3Q51xbTuMPb3c1rA/2d7W09u0R8mKU/3sMyWiVi6Ic5AxjpuEu0gzlX3Xuj/UlbyQu
	 OQ/jcKSxHmC0NSS3CJn1+05V/S12KsKjS2s5tqDy58HqLUsUiBacUqCkVnC7W6/raN
	 sHuFtgg2u0tsQ==
Date: Wed, 27 Aug 2025 23:52:02 -0700
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
Subject: Re: [PATCH v2 01/10] perf dwarf-aux: Use signed variable types in
 match_var_offset
Message-ID: <aK_8kt5Yf9MDoPdu@google.com>
References: <20250825195412.223077-1-zecheng@google.com>
 <20250825195412.223077-2-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825195412.223077-2-zecheng@google.com>

On Mon, Aug 25, 2025 at 07:54:03PM +0000, Zecheng Li wrote:
> match_var_offset compares address offsets to determine if an access
> falls within a variable's bounds. The offsets involved for those
> relative to base registers from DW_OP_breg can be negative.
> 
> The current implementation uses unsigned types (u64) for these offsets,
> which rejects almost all negative values.

Right, I thought it cannot get negative offsets except for stack access
(e.g. fbreg).  But it turns out that container_of() trick can generate
them with optimizing compilers.

> 
> Change the signature of match_var_offset to use signed types (s64). This
> ensures correct behavior when addr_offset or addr_type are negative.
> 
> Signed-off-by: Zecheng Li <zecheng@google.com>

I've confirmed it produced slightly better results on my test sets.

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/dwarf-aux.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 559c953ca172..920054425578 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1388,18 +1388,19 @@ struct find_var_data {
>  #define DWARF_OP_DIRECT_REGS  32
>  
>  static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
> -			     u64 addr_offset, u64 addr_type, bool is_pointer)
> +			     s64 addr_offset, s64 addr_type, bool is_pointer)
>  {
>  	Dwarf_Die type_die;
>  	Dwarf_Word size;
> +	s64 offset = addr_offset - addr_type;
>  
> -	if (addr_offset == addr_type) {
> +	if (offset == 0) {
>  		/* Update offset relative to the start of the variable */
>  		data->offset = 0;
>  		return true;
>  	}
>  
> -	if (addr_offset < addr_type)
> +	if (offset < 0)
>  		return false;
>  
>  	if (die_get_real_type(die_mem, &type_die) == NULL)
> @@ -1414,11 +1415,11 @@ static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
>  	if (dwarf_aggregate_size(&type_die, &size) < 0)
>  		return false;
>  
> -	if (addr_offset >= addr_type + size)
> +	if ((u64)offset >= size)
>  		return false;
>  
>  	/* Update offset relative to the start of the variable */
> -	data->offset = addr_offset - addr_type;
> +	data->offset = offset;
>  	return true;
>  }
>  
> -- 
> 2.51.0.261.g7ce5a0a67e-goog
> 
