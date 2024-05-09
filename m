Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D473213A3EF;
	Thu,  9 May 2024 01:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715217102; cv=none; b=XgEUA8Ctxm2HKI63R2eDfX1i3D2VYHmk/XJesyse6RmsuY5yOb3Jz4PgCzDNFrLtWumatie+LNiP0psnTvUlQf/kdmzm5EAmfyXZ/ndquMqHkJHM0imZ7zpmGMPWMGGQ5Gc6fvBzV6QBFDIdv4d+qqw92lPFv3/xWTcvAWNfAc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715217102; c=relaxed/simple;
	bh=3+R0pCEKlThoL5hIISvVv/GIFqbCo1l2qCt0ONSsQWw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qjEUcYBmjtvncEtdWOtpogcOHsHWiJXdMICffe/D/Wz2YAgFlzfTslZGHqvwSQ0vPxpo0drRXvMDwxpAmb19i3QXoUXoqzey6vPi65a/06gvsz6BDWwHH8Rk8g8tTuI0Mh5/hHfNa1m8yLNpKk43OMGjnjLXF+un7/26WGLL3ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOw8Z3Rn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOw8Z3Rn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF7AC113CC;
	Thu,  9 May 2024 01:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715217102;
	bh=3+R0pCEKlThoL5hIISvVv/GIFqbCo1l2qCt0ONSsQWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oOw8Z3RnOmLh8zUevgyrTVy8JpBljKOS/WwdQ1vMzmoNfyy5j047nugQI/BFipREW
	 RpGPu+0e6pJ7uG3DgzaG0//StbqYa1Njgm3kweFJyeuY9aXUgk8Oe1QJvdpefwsDgx
	 lGxYoFfp/DHq2OHuVOiz/tFkRBG43kU9VkM7/4InTqN48hWdZ+X9xQqSEQvzWzhW+0
	 CS0QO7e1ZivY4aQpe+as21qp1N/vKgF2xfREykFaTbD0anhPOCbMEKyzg42ATMy2iu
	 1wPr5d8KbWn9gz0wgK4QXWb99JAwhDB26ZZKKypxB/C6j1VNh+LLxlRvYNlheVwwaj
	 hjt56fgSVIrwQ==
Date: Thu, 9 May 2024 10:11:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, leo.yan@linux.dev, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf dwarf-aux: Fix build with HAVE_DWARF_CFI_SUPPORT
Message-Id: <20240509101136.5b0e0f2bf8df640fc2e65624@kernel.org>
In-Reply-To: <20240508141458.439017-1-james.clark@arm.com>
References: <20240508141458.439017-1-james.clark@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 May 2024 15:14:57 +0100
James Clark <james.clark@arm.com> wrote:

> check_allowed_ops() is used from both HAVE_DWARF_GETLOCATIONS_SUPPORT
> and HAVE_DWARF_CFI_SUPPORT sections, so move it into the right place so
> that it's available when either are defined. This shows up when doing
> a static cross compile for arm64:
> 
>   $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- LDFLAGS="-static" \
>     EXTRA_PERFLIBS="-lexpat"
> 
>   util/dwarf-aux.c:1723:6: error: implicit declaration of function 'check_allowed_ops'
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Fixes: 55442cc2f22d ("perf dwarf-aux: Check allowed DWARF Ops")
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/dwarf-aux.c | 56 ++++++++++++++++++-------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index c0a492e65388..c9584563cd56 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1215,6 +1215,34 @@ static int offset_from_dwarf_op(Dwarf_Op *op)
>  	}
>  	return -1;
>  }
> +
> +static bool check_allowed_ops(Dwarf_Op *ops, size_t nops)
> +{
> +	/* The first op is checked separately */
> +	ops++;
> +	nops--;
> +
> +	/*
> +	 * It needs to make sure if the location expression matches to the given
> +	 * register and offset exactly.  Thus it rejects any complex expressions
> +	 * and only allows a few of selected operators that doesn't change the
> +	 * location.
> +	 */
> +	while (nops) {
> +		switch (ops->atom) {
> +		case DW_OP_stack_value:
> +		case DW_OP_deref_size:
> +		case DW_OP_deref:
> +		case DW_OP_piece:
> +			break;
> +		default:
> +			return false;
> +		}
> +		ops++;
> +		nops--;
> +	}
> +	return true;
> +}
>  #endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT || HAVE_DWARF_CFI_SUPPORT */
>  
>  #ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
> @@ -1395,34 +1423,6 @@ static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
>  	return true;
>  }
>  
> -static bool check_allowed_ops(Dwarf_Op *ops, size_t nops)
> -{
> -	/* The first op is checked separately */
> -	ops++;
> -	nops--;
> -
> -	/*
> -	 * It needs to make sure if the location expression matches to the given
> -	 * register and offset exactly.  Thus it rejects any complex expressions
> -	 * and only allows a few of selected operators that doesn't change the
> -	 * location.
> -	 */
> -	while (nops) {
> -		switch (ops->atom) {
> -		case DW_OP_stack_value:
> -		case DW_OP_deref_size:
> -		case DW_OP_deref:
> -		case DW_OP_piece:
> -			break;
> -		default:
> -			return false;
> -		}
> -		ops++;
> -		nops--;
> -	}
> -	return true;
> -}
> -
>  /* Only checks direct child DIEs in the given scope. */
>  static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
>  {
> -- 
> 2.34.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
