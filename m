Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C065733E;
	Tue,  7 Apr 2026 06:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775545138; cv=none; b=e5/1BfgK5j4I+Vd9qhog+TsrIc9Fhdzv8CLCtAT8FjBFiK4YxK9+sYvvzKRGZi1oEulzVl7RdjLcMWDtprKOjN7egJcFBPT81gCupxs6Hkx0TGF4TKur2t6KvJRVgXWiknxzrNwFTMaVjDN6sxGiQNVCUPeJRzOKk2mJdnE2Tj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775545138; c=relaxed/simple;
	bh=g7bkjH66o4SeSNHDvgXzoUbrOwo6ZCxKoLQk02t+TQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXYGzNYkmI584Q/QXOBs6GaCZIyTgJi2EIEAJQ0XIxo2cLhvbT1TUG+MkPr3kcWaVQ4Md+4yrKEMu4FHgapIZbBJZbS83TKcU094BzPkS3VApzs3n8pptzKK8oFkOazZcJ6U/xyZK21GB4r3qqHpaCQmw0el7ItnsPng6KgUcuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSwF8f7x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSwF8f7x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D28C116C6;
	Tue,  7 Apr 2026 06:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775545137;
	bh=g7bkjH66o4SeSNHDvgXzoUbrOwo6ZCxKoLQk02t+TQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rSwF8f7xbRNG4PllD0FQ8BwsNIpo5Oy8FJcY39oDva/0c9TDy4mo8qn7CtJbLizSC
	 i4NfA4g3ejDe92BhHITJL8LlvI9Tc6qAlSu2sXWLxNysNQZyN99xgIVhgH5qZT9oqB
	 wI1V/FhZHggE0ewVuZQd66wcK1MXa0afGOzhaHQ7AwiR+4OgEHHhF8XEDVMdoGL6g8
	 k9Z+c8bOSdgd5It6wq+JS6rNi32nnz2DQ1aIEWxcKECplchF8hobyFd/gs7ntgk8An
	 vcmy9PndjbDDsY7qMe7pMlCVLzdY9P9FHY7Yf0AFFyvahn0zz2QKx5UvgBdt4QSA9l
	 C1gtS0+5Eh1rw==
Date: Mon, 6 Apr 2026 23:58:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>, Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 03/16] perf annotate-arm64: Generalize
 arm64_mov__parse to support standard operands
Message-ID: <adSrL-iZna3pyDrY@z2>
References: <20260403094800.1418825-1-wutengda@huaweicloud.com>
 <20260403094800.1418825-4-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260403094800.1418825-4-wutengda@huaweicloud.com>

On Fri, Apr 03, 2026 at 09:47:47AM +0000, Tengda Wu wrote:
> The current arm64_mov__parse() implementation strictly requires the
> operand to contain a symbol suffix in the "<symbol>" format. This
> causes the parser to fail for standard instructions that only contain
> raw immediates or registers without symbolic annotations.
> 
> Refactor the function to make symbol matching optional. The parser now
> correctly extracts the target operand and only attempts to parse the
> "<symbol>" suffix if it exists. This change also introduces better
> handling for whitespace and comments, and adds support for multi-register
> check via arm64__check_multi_regs(), ensuring compatibility with a
> wider range of arm64 instruction formats.
> 
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  .../perf/util/annotate-arch/annotate-arm64.c  | 85 ++++++++++++++-----
>  1 file changed, 65 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
> index 33080fdca125..4c42323b0c18 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> @@ -14,12 +14,38 @@ struct arch_arm64 {
>  	regex_t jump_insn;
>  };
>  
> +static bool arm64__check_multi_regs(const char *op)
> +{
> +	char *comma = strchr(op, ',');
> +
> +	while (comma) {
> +		char *next = comma + 1;
> +
> +		next = skip_spaces(next);
> +
> +		/*
> +		 * Check the first valid character after the comma:
> +		 * - If it is '#', it indicates an immediate offset (e.g., [x1, #16]).
> +		 * - If it is an alphabetic character, it is highly likely a
> +		 *   register name (e.g., x, w, s, d, q, v, p, z).
> +		 * - Special cases: Alias and control registers like sp, xzr,
> +		 *   and wzr all start with an alphabetic character.
> +		 */
> +		if (*next && *next != '#' && isalpha(*next))
> +			return true;

It seems you check any alphabet charactor after a comma for multi-regs.
Does that mean the first component before the comma should be another
register?

> +
> +		comma = strchr(next, ',');
> +	}
> +
> +	return false;
> +}
> +
>  static int arm64_mov__parse(const struct arch *arch __maybe_unused,
>  			    struct ins_operands *ops,
>  			    struct map_symbol *ms __maybe_unused,
>  			    struct disasm_line *dl __maybe_unused)
>  {
> -	char *s = strchr(ops->raw, ','), *target, *endptr;
> +	char *s = strchr(ops->raw, ','), *target, *endptr, *comment, prev;
>  
>  	if (s == NULL)
>  		return -1;
> @@ -31,29 +57,48 @@ static int arm64_mov__parse(const struct arch *arch __maybe_unused,
>  	if (ops->source.raw == NULL)
>  		return -1;
>  
> -	target = ++s;
> +	target = skip_spaces(++s);
> +	comment = strchr(s, arch->objdump.comment_char);
> +
> +	if (comment != NULL)
> +		s = comment - 1;
> +	else
> +		s = strchr(s, '\0') - 1;

An interesting use of strchr().  Oh, I found the strchr(3) man page
also mentions that it's a supported use case.  TIL.


> +
> +	while (s > target && isspace(s[0]))
> +		--s;
> +	s++;
> +	prev = *s;
> +	*s = '\0';
>  	ops->target.raw = strdup(target);
> +	*s = prev;
> +
>  	if (ops->target.raw == NULL)
>  		goto out_free_source;
>  
> -	ops->target.addr = strtoull(target, &endptr, 16);
> -	if (endptr == target)
> -		goto out_free_target;
> -
> -	s = strchr(endptr, '<');
> -	if (s == NULL)
> -		goto out_free_target;
> -	endptr = strchr(s + 1, '>');
> -	if (endptr == NULL)
> -		goto out_free_target;
> -
> -	*endptr = '\0';
> -	*s = ' ';
> -	ops->target.name = strdup(s);
> -	*s = '<';
> -	*endptr = '>';
> -	if (ops->target.name == NULL)
> -		goto out_free_target;
> +	ops->target.multi_regs = arm64__check_multi_regs(ops->target.raw);
> +
> +	/* Parse address followed by symbol name, e.g. "addr <symbol>" */
> +	if (strchr(target, '<') != NULL) {
> +		ops->target.addr = strtoull(target, &endptr, 16);
> +		if (endptr == target)
> +			goto out_free_target;

Hmm.. shouldn't this part be executed regardless of presence of a symbol
name?

> +
> +		s = strchr(endptr, '<');
> +		if (s == NULL)
> +			goto out_free_target;

It'd be safer to check `if (*skip_spaces(endptr) == '<')` rather than
strchr().


> +		endptr = strchr(s + 1, '>');
> +		if (endptr == NULL)
> +			goto out_free_target;

I'm afraid C++ programs can have symbols with <> for templates.
Probably strrchr() would work.

Thanks,
Namhyung

> +
> +		*endptr = '\0';
> +		*s = ' ';
> +		ops->target.name = strdup(s);
> +		*s = '<';
> +		*endptr = '>';
> +		if (ops->target.name == NULL)
> +			goto out_free_target;
> +	}
>  
>  	return 0;
>  
> -- 
> 2.34.1
> 
