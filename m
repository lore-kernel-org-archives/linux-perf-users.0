Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1E91B8EA0;
	Fri, 16 Aug 2024 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723820323; cv=none; b=ebNwL7mlz8rQpJpdEe8/z4gnspAxVcK+v4WBI2n1Jhlja1VitO9iSHa04U64vfI+rEE+x/JutFs511jS1qXhUpOEc4lFhJd+LuU74wtwu9ySfGmMNtqJQ6OflINF6OPo/bbR6qGFpuYXJ6GxcyBCZcbznN50Uqzr9BpJEK7PLnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723820323; c=relaxed/simple;
	bh=h2Mxlym2VPEMV8Ydic1LoJsLPgznB/klNI53OAeg7C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ywsb4DXn7xrThZiQkkBhsoN/bq0exwGKjHfAG1mFYcd22P+1LEZ0zjLuaojhWY/VDPfOzdJnDz49NMAzGrN9Ch5BvbZ/NZ2ZUi0GLLdfuRo1iEq90hy1TOgd7p3TDA4MwYnHYrsB1e/+w/h5lQ/tmRCBqWqLBP7jJpDP/YSnKmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCiT0ipJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCiT0ipJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8609C32782;
	Fri, 16 Aug 2024 14:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723820323;
	bh=h2Mxlym2VPEMV8Ydic1LoJsLPgznB/klNI53OAeg7C8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DCiT0ipJa2L3qpLxaa6VyFiUew1sdUBgmQnxB5FE7ST5vZPaynG2NFiQY69UJOto4
	 Bgyy4npmxKoOlrfdEp8huKBaH9ZEtTUJDNrecTEqFUPxH75H/yYxA1KpxMkQcUAzyJ
	 it8srxaSjqUqq8AXXdwcgV1/9O+Zbe+XbiCbgws3xv//eV1SXkA4pHRJD4wgBAwqx5
	 E+qqQHTI/yyfYPjgWU5nS1LpMteorFv64d++nAoQOFIOxF3opDuW4nIo12hkTgeExP
	 P/wBNX6/zUK4DF8ZORPzMbnZLcgFpUgesj6Vib47IDB6fX+LSHsxKCP6hLshnUwI0D
	 /yafgLppdwX8w==
Date: Fri, 16 Aug 2024 11:58:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] perf trace: Change some comments
Message-ID: <Zr9pH1MC3L7Vr1-X@x1>
References: <20240815013626.935097-1-howardchu95@gmail.com>
 <20240815013626.935097-3-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815013626.935097-3-howardchu95@gmail.com>

On Thu, Aug 15, 2024 at 09:36:18AM +0800, Howard Chu wrote:
> Change them from '//' to '/* */'

You didn't state why you did it, is it to follow coding styles? IIRC //
is acceptable.

- Arnaldo
 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/builtin-trace.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index d6ca541fdc78..97076b962688 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -957,17 +957,16 @@ static bool syscall_arg__strtoul_btf_type(char *bf, size_t size, struct syscall_
>  	if (btf == NULL)
>  		return false;
>  
> -	if (arg->fmt->type == NULL) {
> -		// See if this is an enum
> +	/* See if this is an enum */
> +	if (arg->fmt->type == NULL)
>  		syscall_arg_fmt__cache_btf_enum(arg->fmt, btf, type);
> -	}
>  
> -	// Now let's see if we have a BTF type resolved
> +	/* Now let's see if we have a BTF type resolved */
>  	bt = arg->fmt->type;
>  	if (bt == NULL)
>  		return false;
>  
> -	// If it is an enum:
> +	/* If it is an enum: */
>  	if (btf_is_enum(arg->fmt->type))
>  		return syscall_arg__strtoul_btf_enum(bf, size, arg, val);
>  
> -- 
> 2.45.2
> 
