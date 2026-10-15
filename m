Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E174F93C3;
	Thu, 15 Oct 2026 23:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792105330; cv=none; b=QsoAuLP9QiQzEqyQH54EMVw8ghrqPK34bwCih/5lfRHmmsucvYobFN2ZlT4JcZIDpwSsoPR6rKfkhhpGuRwGEduqzyDGUAVVxmvLIMj6dVHYTyrNAjJ/HPdwSk1XhhxxGNnnfGHe8MmK1pvZkgXHjlfDitPXSV1tv7bZbYoLXQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792105330; c=relaxed/simple;
	bh=pD55dgVjHaFVKcqkjCBF2Gu+rEnnqHBYIHEq/vwYmjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYLLLK98I2a5ZUasZ817e5BsEsHkUjBQW9+liQ3n+EWJn9VQh8PLYB1l9UaxsTZMzaMxkagyy86pgIkM24JmLVJNfOADkwELB/QNu4/rs9Hxq7oyR7VCqtgvr1qurKFKbxO9mHzvF4+kkd/E0ub6gIjLw1A0m4hGpKqhayBxc/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6n9eP5y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6n9eP5y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A162A1F000C4;
	Thu, 15 Oct 2026 23:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792105328;
	bh=hFN+/f66McsHGnHm+RvAerLiTUbbMxTpXa/PXMqiJ90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N6n9eP5yHFszaUAWxkkwmjuRm6VvoUFeY0e75L69NGREkOTSqXZyVZOUXicv+RaJC
	 FDFA1whBnczbY3vQOLmZLgrV64A4kDhuLSpIkwpK1iRl3TxiQW3kHNEvLcxsTlUNHb
	 sVYeuwSHEpA7jB0UzekGLMZ1zJ5ozMlhz1qetSQREyktGWuv6WHfsIk+gB3KGLwd1J
	 C7IbDJoPDesg+DC0AXe4ceQiwKSYYUUZKatWqbEq28Ao5geCFR0VlDOd/KYrC5m3sq
	 4picjI9UrLJwtz1KWDtvxlzkR3TbFgQjwl8G+2MopseJ2FT0f070qfzuaGT2YxjOW8
	 psLtoR+QQ4I0A==
Date: Thu, 15 Oct 2026 16:02:06 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: james.clark@linaro.org, xueshuai@linux.alibaba.com,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>, Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v7 06/15] perf annotate-arm64: Support store instruction
 tracking
Message-ID: <atFbbrGdobp83fgA@google.com>
References: <cover.1791629326.git.wutengda@huaweicloud.com>
 <eb44bbf4b74555bc43f3659f4733faff403debbf.1791629326.git.wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb44bbf4b74555bc43f3659f4733faff403debbf.1791629326.git.wutengda@huaweicloud.com>

On Tue, Oct 13, 2026 at 01:28:04PM +0000, Tengda Wu wrote:
> Extend update_insn_state_arm64() to handle standard store instructions
> (str, stur, stlr, stp). Exclusive stores (e.g., stxr, stxp) are omitted
> as they exhibit different operand semantics.
> 
> Unlike load instructions, a store instruction sets a value in the struct
> within the memory where the destination register resides, and does not
> alter its type. Therefore, no processing is required for the transfer.

But the target location also can be stack which requires type info,
right?  Oh, I think you have a patch later to handle that.

Thanks,
Namhyung

> 
> The only point to note is that store instructions support pre-index and
> post-index addressing modes, so calling adjust_reg_index_state() is still
> necessary to handle their addressing.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  .../perf/util/annotate-arch/annotate-arm64.c  | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
> index fb48bf95b32f..54d9928b536f 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> @@ -661,6 +661,20 @@ static void update_load_insn_state(struct type_state *state,
>  	adjust_reg_index_state(state, dloc, dl, src);
>  }
>  
> +/*
> + * Match standard store variants (str, stur, stlr, stp) that follow
> + * straightforward store semantics: source registers on the left (read-only)
> + * and memory target on the right. Excludes exclusive stores (stxr, stxp, etc.)
> + * which have status/result register side effects.
> + */
> +static bool is_standard_store_insn(const char *name)
> +{
> +	return !strncmp(name, "str", 3)  ||  /* str, strb, strh */
> +	       !strncmp(name, "stur", 4) ||  /* stur, sturb, sturh */
> +	       !strncmp(name, "stlr", 4) ||  /* stlr, stlrb, stlrh */
> +	       !strncmp(name, "stp", 3);     /* stp */
> +}
> +
>  static void update_insn_state_arm64(struct type_state *state,
>  				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
>  				    struct disasm_line *dl)
> @@ -742,6 +756,17 @@ static void update_insn_state_arm64(struct type_state *state,
>  	/* Memory to register transfers */
>  	if (is_standard_load_insn(dl->ins.name))
>  		update_load_insn_state(state, dloc, dl, src, dst);
> +	/* Register to memory transfers */
> +	else if (is_standard_store_insn(dl->ins.name)) {
> +		/*
> +		 * Ignore transfers since it'd set a value in a struct
> +		 * and won't change the type.
> +		 *
> +		 * Needs to update the pre-index and post-index addressing
> +		 * modes for the destination register.
> +		 */
> +		adjust_reg_index_state(state, dloc, dl, dst);
> +	}
>  }
>  #endif
>  
> -- 
> 2.34.1
> 
