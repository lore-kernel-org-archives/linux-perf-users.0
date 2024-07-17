Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD085B05E;
	Wed, 17 Jul 2024 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721233801; cv=none; b=N/zGOhsIilCJdP51hArvyvfqIMGodzXNcNoFKEoDYN/S21E1NQeXQcpS8aM8NgRQY746vZLvjO4XAMcT6wrZFXJYS1VGQdGknho2kNsCB5s8VfsO0LCN8enliwZIkn4SbjQCDPng2sred3sDdg3pMPsx9xDYNFGqeaP35veXLK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721233801; c=relaxed/simple;
	bh=G4C7zJdDwQfHvRTHcH043Nse5RmNU65ddUTUDmBR80Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTVmq0blziRLLIraWACh/ppS6JWM878Li7ZUQc4XwyA4R3mZh6YKVJz8yZqvl43/2blNIozJk567gUAcMl0tjsQe50OhTqQoNjhAwBTlcSzwFVhjp1jnuQ4UsynRMz3qJLKkfC9cq+OytKGnwFG8tAL/faQ4W8itiKrQVM0oyqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZQw2Yf47; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZQw2Yf47"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w8eQajHoKAwFnMWecxFYJF8m0SV9pIZvxXPgSFXMqWU=; b=ZQw2Yf47jXRMk6yvzw8zZ4LJO7
	jZre9UUzYVRzuhbYpsztSnPdahd+w5SFL6eXMpwaZ3fAaa2xv0He9c/36/GIoPsvx05FNQTyh14hh
	9U1mlNlKbc8kmcLPDo8RqQvxLHguwNNzydvZewJt5dUnAKhH8/p3W0Tj9yLaDQ0cmx/D+9WW8pZG2
	sJxHV7ye7U6gKwIfYzBn3v6fEG+M4mk2X90V0bW9TAnXmGYHyyyv5TlBYxLi9z6ciiUML0lFoHLoN
	w5a0k0PmVwJuXsQltfvzjDPuo0i4KYzzI6ErCeDDPTVjlNPTN8IboLYS2vXv9ipzaWZ6hSzOpC76V
	9ztYO88w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU7XQ-00000002MSz-3eHO;
	Wed, 17 Jul 2024 16:29:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7EEBA300362; Wed, 17 Jul 2024 18:29:56 +0200 (CEST)
Date: Wed, 17 Jul 2024 18:29:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, x86@kernel.org,
	Rui Zhang <rui.zhang@intel.com>,
	Artem Bityutskiy <artem.bityutskiy@intel.com>,
	Wendy Wang <wendy.wang@intel.com>
Subject: Re: [PATCH tip rebase] perf/x86/intel/cstate: Add pkg C2 residency
 counter for Sierra Forest
Message-ID: <20240717162956.GI26750@noisy.programming.kicks-ass.net>
References: <20240612080835.306254-1-zhenyuw@linux.intel.com>
 <20240717031609.74513-1-zhenyuw@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717031609.74513-1-zhenyuw@linux.intel.com>

On Wed, Jul 17, 2024 at 11:16:09AM +0800, Zhenyu Wang wrote:
> Package C2 residency counter is also available on Sierra Forest.
> So add it support in srf_cstates.
> 
> Cc: Rui Zhang <rui.zhang@intel.com>
> Cc: Artem Bityutskiy <artem.bityutskiy@intel.com>
> Cc: Wendy Wang <wendy.wang@intel.com>
> Tested-by: Wendy Wang <wendy.wang@intel.com>
> Fixes: 3877d55a0db2 ("perf/x86/intel/cstate: Add Sierra Forest support")
> Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
> ---
> 
> Hi, Peter
> 
> This refresh resolved conflicts in comment against current tip tree.
> Please help to apply.

Ok, I have it now. I'll try and stick it into perf/urgent once -rc1
rolls around.

> 
>  arch/x86/events/intel/cstate.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
> index be58cfb012dd..9f116dfc4728 100644
> --- a/arch/x86/events/intel/cstate.c
> +++ b/arch/x86/events/intel/cstate.c
> @@ -64,7 +64,7 @@
>   *			       perf code: 0x00
>   *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
>   *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL,
> - *						RPL,SPR,MTL,ARL,LNL
> + *						RPL,SPR,MTL,ARL,LNL,SRF
>   *			       Scope: Package (physical package)
>   *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
>   *			       perf code: 0x01
> @@ -693,7 +693,8 @@ static const struct cstate_model srf_cstates __initconst = {
>  	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
>  				  BIT(PERF_CSTATE_CORE_C6_RES),
>  
> -	.pkg_events		= BIT(PERF_CSTATE_PKG_C6_RES),
> +	.pkg_events		= BIT(PERF_CSTATE_PKG_C2_RES) |
> +				  BIT(PERF_CSTATE_PKG_C6_RES),
>  
>  	.module_events		= BIT(PERF_CSTATE_MODULE_C6_RES),
>  };
> -- 
> 2.45.2
> 
