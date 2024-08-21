Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF62763F8;
	Wed, 21 Aug 2024 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251302; cv=none; b=FWA+OQr6eu9ZJ5zaqSzs1IJgJmc2Poc0fCEfaxgf6vONs5KD0JO2MuS9gvuw9mVVBShBqajyhDeIW2jZoh8QdyhgRSSd4maTXDQ24BhMnWWbk/0LKLoaC9s8DM10KD/hBIZqwiuUtiph1ypOoi/31fzRCt3klXdr0+UwvzzxgGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251302; c=relaxed/simple;
	bh=oEh+WbZ/MxNm536FMZC9OCDojBVhbQU4HSWZzW0kttM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/o6u236XR1WZguplVgYr1R9wF5qdwvjEmgenLg3EOuSmre5Q92DWSM3h4CG2On3uX2c9HWyqTBbtP6zJYA0au9RIRLQX9RvwcFyIS+RA7UubTq8NrxCnINErbl2bMA1bMDuzMlmpK7tL9gp0r8RrlIWUoYtxWpBC4K4mcv3H7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3AmiU4z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3AmiU4z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B696FC32781;
	Wed, 21 Aug 2024 14:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724251302;
	bh=oEh+WbZ/MxNm536FMZC9OCDojBVhbQU4HSWZzW0kttM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y3AmiU4ztC04yl1eZjh2wlx6o0IQW8BJ7wv3zrik78cfN0qOaLuQCyyNwqkIAejHZ
	 AdCDQixTlauDFdthzMMglrpEj0B2ro9KR/S2iKpx18O8of9Ffcy6tXxeNlMxtVdQGv
	 d/PmcJC3D2HuUKTLnKKNCdhl9eWJC9IEWO6/sa3sVm8UK6eggxST3KuQs8NcFP2npp
	 OZr2dWnbUE9zjZ0x+e5aFLMURYCgSw0P75HvpcoroSMPcRWpHGBBj98j1hb9QvZkIJ
	 eMfiD3Ggk/ThLzXMAMu2sqV1bWtQ18HhWymy2j2MHkBZBm/NbGpMQ3yMazQhpRiv47
	 SqBXZSTYkSsTQ==
Date: Wed, 21 Aug 2024 11:41:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] perf annotate-data: Fix missing constant copy
Message-ID: <ZsX8omIZDgQyUkwU@x1>
References: <20240821065408.285548-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821065408.285548-1-namhyung@kernel.org>

On Tue, Aug 20, 2024 at 11:54:06PM -0700, Namhyung Kim wrote:
> I found it missed to copy the immediate constant when it moves the
> register value.  This could result in a wrong type inference since the
> address for the per-cpu variable would be 0 always.
> 
> Fixes: eb9190afaed6 ("perf annotate-data: Handle ADD instructions")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied the series.

- Arnaldo

> ---
>  tools/perf/arch/x86/annotate/instructions.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
> index 7b7d462c6c6b..88b5bcf2116f 100644
> --- a/tools/perf/arch/x86/annotate/instructions.c
> +++ b/tools/perf/arch/x86/annotate/instructions.c
> @@ -382,6 +382,7 @@ static void update_insn_state_x86(struct type_state *state,
>  
>  		tsr->type = state->regs[src->reg1].type;
>  		tsr->kind = state->regs[src->reg1].kind;
> +		tsr->imm_value = state->regs[src->reg1].imm_value;
>  		tsr->ok = true;
>  
>  		pr_debug_dtp("mov [%x] reg%d -> reg%d",
> -- 
> 2.46.0.184.g6999bdac58-goog
