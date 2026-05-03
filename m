Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B064D37B019;
	Sun,  3 May 2026 23:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777851230; cv=none; b=T1yp7VkFf36neLrLNCbnMvlxPWt/juBFgQPH8NYy4XiGRs/8MGLxQpQwcdfE/C/3SGZz+rB+QECEfySmZcoiq0apCnGG8zKTsgT7540M549s5cFZHCROY0IGCt57QnxXsj0AW+vN4HRVOPkc6AzBEMUEv+USHjc5nDJOIpBg61o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777851230; c=relaxed/simple;
	bh=t0vDYehw8utDg3VfUaTimTf023bH0vvnmq2cF0rWiQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLYKBj8tg1JoAVLfFh+jzipPu8Xj1ItCmsU8B09jn1uIobCnNHRgPxWDsjdbwx1HaHCYtFegtqhiL1LEhUEU+PNGzi2W3by5Y1vCGRICXJRyKabVe+Q4uEhtuIOOXSiv+COEGxz5x3AedNJgvaj9lq98q2qx+Iha3ZINhKQguc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCK8Ww1g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCK8Ww1g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75A7C2BCB4;
	Sun,  3 May 2026 23:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777851230;
	bh=t0vDYehw8utDg3VfUaTimTf023bH0vvnmq2cF0rWiQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mCK8Ww1gbBDZQWaNZdzmhEFiucgzQ83lwbdmQUNG6vYCPGL2xBBcg0wSM+WbV+Myi
	 3ETUp/IU146rGW+bGv41vUlIBLtlIZoiDy0xnb/gbUFkxYy/Wvm9qHgXm58TccpsSo
	 mGJbPXR55K5vUewek5Nb4F11GBZIQvcd+TRgPLAe3w4NGRH5zw62fJG/yi4FJGIBPI
	 KtrNb4Azt0SfuUM217YTfYwAEpQz73xdgKUuD0Yg7ztXljrSrxNfzVeTWUkhe18dmj
	 h9S2pXyfDmlxeC2IFiaSYkSUO3J6biPBSZ0EMIb4cKkpPG8zxhWHeT+o6OMGdJPdo8
	 TQX3Yt9qHXwPA==
Date: Sun, 3 May 2026 16:33:48 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Zecheng Li <zli94@ncsu.edu>,
	Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] perf dwarf-aux: Fix libdw segmentation fault in
 cu_walk_functions_at
Message-ID: <affbXNN3HLMeiYdO@z2>
References: <20260503003552.1063540-1-irogers@google.com>
 <20260503171032.1559338-1-irogers@google.com>
 <20260503171032.1559338-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260503171032.1559338-2-irogers@google.com>

On Sun, May 03, 2026 at 10:10:27AM -0700, Ian Rogers wrote:
> A segmentation fault was observed in `libdw` when running `perf kmem`
> with `--page stat` on some workloads. The crash occurred deep inside
> `libdw` (specifically in `dwarf_child` and `dwarf_diename`) when
> processing DWARF information.
> 
> The root cause was improper error handling of `dwarf_getfuncs` in
> `die_find_realfunc` and `die_find_tailfunc`.
> 
> `dwarf_getfuncs` returns:
>  - `0` on success (when all functions have been processed).
>  - A positive offset if the callback aborts early (e.g., via
>    `DWARF_CB_ABORT` when a match is found).
>  - `-1` on error.
> 
> The original code used `if (!dwarf_getfuncs(...)) return NULL;`. On
> error (`-1`), `!-1` evaluates to `0` (false), bypassing the error
> check. Execution then proceeded as if a match was found, returning
> uninitialized stack memory (`die_mem`) to the caller
> (`cu_walk_functions_at`). When `cu_walk_functions_at` passed this
> uninitialized memory to `libdw` via `dwarf_diename`, it caused a
> segmentation fault.
> 
> Fix this by correcting the error check to `if (dwarf_getfuncs(...) <= 0)`.
> 
> Fixes: e0d153c69040 ("perf-probe: Move dwarf library routines to dwarf-aux.{c, h}")
> Fixes: d4c537e6bf86 ("perf probe: Ignore tail calls to probed functions")
> Assisted-by: Gemini-CLI:Google Gemini 3
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/dwarf-aux.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 92db2fccc788..109a166a6d19 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -171,7 +171,6 @@ int cu_walk_functions_at(Dwarf_Die *cu_die, Dwarf_Addr addr,
>  	}
>  
>  	return ret;
> -
>  }
>  
>  /**
> @@ -620,7 +619,7 @@ Dwarf_Die *die_find_tailfunc(Dwarf_Die *cu_die, Dwarf_Addr addr,
>  	ad.addr = addr;
>  	ad.die_mem = die_mem;
>  	/* dwarf_getscopes can't find subprogram. */
> -	if (!dwarf_getfuncs(cu_die, __die_search_func_tail_cb, &ad, 0))
> +	if (dwarf_getfuncs(cu_die, __die_search_func_tail_cb, &ad, 0) <= 0)
>  		return NULL;
>  	else
>  		return die_mem;
> @@ -659,7 +658,7 @@ Dwarf_Die *die_find_realfunc(Dwarf_Die *cu_die, Dwarf_Addr addr,
>  	ad.addr = addr;
>  	ad.die_mem = die_mem;
>  	/* dwarf_getscopes can't find subprogram. */
> -	if (!dwarf_getfuncs(cu_die, __die_search_func_cb, &ad, 0))
> +	if (dwarf_getfuncs(cu_die, __die_search_func_cb, &ad, 0) <= 0)
>  		return NULL;
>  	else
>  		return die_mem;
> -- 
> 2.54.0.545.g6539524ca2-goog
> 
