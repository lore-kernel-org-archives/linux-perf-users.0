Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B65E285CBA;
	Wed, 11 Feb 2026 02:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770777432; cv=none; b=hF+uVmtpw+kr05PqTh3fOQ1RrtmsqKviLgxRUc92D+sTnFXagbOczwBBbDsesiMWPlyN8P1t83iAUmJJqdulacVCQzHSsoo0y0gYqXO+7zglQ/UI/xI/teehHjSQr1ZXkn4c+9EbOMffmVugC28g/lqy6V/iOo/MS5vPE72FTPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770777432; c=relaxed/simple;
	bh=VoQ28d/aoYcNpkhFRYOqsTuaXnWxIm+nz2Hkln1N8D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=br1BDcipFnHRqO4/n4/mFlUrFa2hTtIZTUye37oe76eBJyArgQ1kdnak5ffMy4YrMQRJ+xJH9uwcyyJQ1J53qZCpiH/JD1IzOMMdo4UYtisX9MCI1S1KBnSw4rNcVv/6hkjhvIyH232Pr3q5kExpCrc1vSgP0YCXXxn+Lf1ehCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxiFfFp5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxiFfFp5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E6CC116C6;
	Wed, 11 Feb 2026 02:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770777431;
	bh=VoQ28d/aoYcNpkhFRYOqsTuaXnWxIm+nz2Hkln1N8D8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TxiFfFp58GOa/IlZiAv0VLu8ipsIwPCqlTaXfzxD2QjnqhXgBl/8mFDXPygPV+vBC
	 paFnjVbo2a44XbCS3xoIzoftck+8boeif3dHo9PHHV45G4C8mz0mm0wsnMCzyl3BJd
	 HTyTuqQopJNcptpL05AaOGKihwXNvfUMo+2uT/jBg5K83vCUlVfOQBkm/F7jzQhBNR
	 nmAEdYBMaj7OsvbZWEHrqSHDCfpCXxo83k5csVncY195r+v5zKJrx2nrq1RI+BHu/P
	 /TqXKcbZBgar6GJHB1CvuFV3lS6yj5jsoiOZex6iCyKNJ6S6sXBs081zTXGlEJx+Jq
	 2WiWJdj8hKY0g==
Date: Tue, 10 Feb 2026 18:37:09 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Zecheng Li <zli94@ncsu.edu>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, xliuprof@google.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 07/11] perf annotate-data: Handle global variable
 access with const register
Message-ID: <aYvrVUTEr53gtkV9@google.com>
References: <20260127020617.2804780-1-zli94@ncsu.edu>
 <20260127020617.2804780-8-zli94@ncsu.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260127020617.2804780-8-zli94@ncsu.edu>

On Mon, Jan 26, 2026 at 09:05:00PM -0500, Zecheng Li wrote:
> When a register holds a constant value (TSR_KIND_CONST) and is used with
> a negative offset, treat it as a potential global variable access
> instead of falling through to CFA (frame) handling.
> 
> This fixes cases like array indexing with computed offsets:
> 
>     movzbl -0x7d72725a(%rax), %eax   # array[%rax]
> 
> Where %rax contains a computed index and the negative offset points to a
> global array. Previously this fell through to the CFA path which doesn't
> handle global variables, resulting in "no type information".
> 
> The fix redirects such accesses to check_kernel which calls
> get_global_var_type() to resolve the type from the global variable
> cache. We could also treat registers with integer types to the global
> variable path, but this requires more changes.

I'm thinking of how we can support user binaries with this code pattern.
For now, I think it's ok for the kernel, but at least we need to check
if dso__kernel(map__dso(dloc->ms->map)) is not zero (DSO_SPACE__USER).

Thanks,
Namhyung

> 
> Signed-off-by: Zecheng Li <zli94@ncsu.edu>
> ---
>  tools/perf/util/annotate-data.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 970238bc81b7..177aa6634504 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -1230,6 +1230,10 @@ static enum type_match_result check_matching_type(struct type_state *state,
>  		return PERF_TMR_BAIL_OUT;
>  	}
>  
> +	if (state->regs[reg].kind == TSR_KIND_CONST) {
> +		if (dloc->op->offset < 0 && reg != state->stack_reg && reg != dloc->fbreg)
> +			goto check_kernel;
> +	}
>  check_non_register:
>  	if (reg == dloc->fbreg || reg == state->stack_reg) {
>  		struct type_state_stack *stack;
> -- 
> 2.52.0
> 
