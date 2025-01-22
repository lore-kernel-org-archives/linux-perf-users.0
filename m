Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814082116FF;
	Wed, 22 Jan 2025 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555322; cv=none; b=qy4XPDRxeMFhagsQGwyo+unKN7JI+JD3ZRqLJvzjhRFxJata+WJAXx92vccmMKWMCIgOITiP0O1ZaJXgkhAQjiaigpBQy4Mqpou9SMhxUC0k2BRBizQMJyXR76UlKBHv3cH6TZOMbrVTrkXdUzGx/5TLHv5I3iTn/MrgD5WN53Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555322; c=relaxed/simple;
	bh=QptWjhWAqObsjMJxx8sKTiVokUKFH/D3WtSH2fjPcF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djB2adkCkva+N8AkU5o/999l//GKt4lssrSq3Y3DgQVIQvO6S+DGUOVfuE+4iUfOrP7uZTGPrAJ8p3a7485SJZCW5XJEcbFmnHSyKfs2Z1aL39xY7OUU6ut2xoeJMYBUBkDTjbRXkFTU/pjgtgLthcLjRSafDDQbElsIvoADq0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NGBp472I; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NGBp472I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vP85oDc9amdA3Gpf8A/7Xp0ysyEgGqqyvPoatHyev1M=; b=NGBp472I7NTtRA3H+/aoNBg+nU
	CnsDBtx7tquugz14Fp2URN3ICKfQDWsDnbGoDqYP/nuo4Yse/SQlowBOfumFkI12mD5TJOyvgpxnN
	zGWawOjtTQRIQnebisZLVRvvsBf7hGNb8PO6RsBeO9h5fP4D5Abvv9sPPr1F47nrLF9gnJ226Oe77
	kCEFbCXljPIa0A9YU24mGfBIRa8YsNfikm2vWjDI3UdUcGtJwEZxxL4CaZetoiaONFa8Kf1tDOhzy
	r8ZpamEyMG53PZzR0hP62TKP+08VizJLY4SJFQcP+ybMu+aACuwNjHUdhWCDwsnSP0hqu4Cgced8A
	H99gLkwQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tabVa-0000000DaUi-0Jh0;
	Wed, 22 Jan 2025 14:15:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 30A2E300677; Wed, 22 Jan 2025 15:15:05 +0100 (CET)
Date: Wed, 22 Jan 2025 15:15:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 30/39] unwind_user/deferred: Make unwind deferral
 requests NMI-safe
Message-ID: <20250122141505.GT7145@noisy.programming.kicks-ass.net>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <4ea47a9238cb726614f36a0aad2a545816442e57.1737511963.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ea47a9238cb726614f36a0aad2a545816442e57.1737511963.git.jpoimboe@kernel.org>

On Tue, Jan 21, 2025 at 06:31:22PM -0800, Josh Poimboeuf wrote:

> diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
> index 2f38055cce48..939c94abaa50 100644
> --- a/kernel/unwind/deferred.c
> +++ b/kernel/unwind/deferred.c
> @@ -29,27 +29,49 @@ static u64 ctx_to_cookie(u64 cpu, u64 ctx)
>  
>  /*
>   * Read the task context cookie, first initializing it if this is the first
> - * call to get_cookie() since the most recent entry from user.
> + * call to get_cookie() since the most recent entry from user.  This has to be
> + * done carefully to coordinate with unwind_deferred_request_nmi().
>   */
>  static u64 get_cookie(struct unwind_task_info *info)
>  {
>  	u64 ctx_ctr;
>  	u64 cookie;
> -	u64 cpu;
>  
>  	guard(irqsave)();
>  
> -	cookie = info->cookie;
> +	cookie = READ_ONCE(info->cookie);
>  	if (cookie)
>  		return cookie;
>  
> +	ctx_ctr = __this_cpu_read(unwind_ctx_ctr);
>  
> -	cpu = raw_smp_processor_id();
> -	ctx_ctr = __this_cpu_inc_return(unwind_ctx_ctr);
> -	info->cookie = ctx_to_cookie(cpu, ctx_ctr);
> +	/* Read ctx_ctr before info->nmi_cookie */
> +	barrier();
> +
> +	cookie = READ_ONCE(info->nmi_cookie);
> +	if (cookie) {
> +		/*
> +		 * This is the first call to get_cookie() since an NMI handler
> +		 * first wrote it to info->nmi_cookie.  Sync it.
> +		 */
> +		WRITE_ONCE(info->cookie, cookie);
> +		WRITE_ONCE(info->nmi_cookie, 0);
> +		return cookie;
> +	}
> +
> +	/*
> +	 * Write info->cookie.  It's ok to race with an NMI here.  The value of
> +	 * the cookie is based on ctx_ctr from before the NMI could have
> +	 * incremented it.  The result will be the same even if cookie or
> +	 * ctx_ctr end up getting written twice.
> +	 */
> +	cookie = ctx_to_cookie(raw_smp_processor_id(), ctx_ctr + 1);
> +	WRITE_ONCE(info->cookie, cookie);
> +	WRITE_ONCE(info->nmi_cookie, 0);
> +	barrier();
> +	__this_cpu_write(unwind_ctx_ctr, ctx_ctr + 1);
>  
>  	return cookie;
> -
>  }

Oh gawd. Can we please do something simple like:

	guard(irqsave)();
	cpu = raw_smp_processor_id();
	ctr = __this_cpu_read(unwind_ctx_cnt);
	cookie = READ_ONCE(current->unwind_info.cookie);
	do {
		if (cookie)
			return cookie;
		cookie = ctx_to_cookie(cpu, ctr+1);
	} while (!try_cmpxchg64(&current->unwind_info.cookie, &cookie, cookie));
	__this_cpu_write(unwind_ctx_ctr, ctr+1);
	return cookie;

