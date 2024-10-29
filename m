Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E5D42A92;
	Tue, 29 Oct 2024 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730210789; cv=none; b=id+/R2lSJR2qMSTXxqhY7zBUN6ehTD+iR7oE9IGcW7O7fkdoVMosgTEUDrFtmZf5HsTEEFd1pZ2eQjqYlQxDUMy5MJw6kr4UFMsoMrLwpHvhY3atUqo+MCkslLXMvYXOZDlq2TP9DTYKQpZcnuezXtl0FFjDSVs0fWSRnYV2L2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730210789; c=relaxed/simple;
	bh=6OmLtYtMbO/UAmjSZCJrMvRmBHe8grtlNIafRgTok4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=De1zW7dzyAOl4ivRflTsjxFJkcRM9lZlPC4/itXrVFvi/AacMkNoY9TOtRhSpBoGhel8OoQB5CfyZlw9KgYc4z54Zrv+mJW5hIETZr91wjA0TyccsS9dHYMu/5KI8SRDTSRwWoPyyxM+kz+5eC/g7nJgJHIW1zCD3DItXcgZ8VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ETO4Nxy/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ETO4Nxy/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xCAzr09NBRREJWcZsiv1oU6aqMJJWV6GYFAOG3D1i8I=; b=ETO4Nxy/kWVd4jlLjNL3+s+nH5
	9eNM9Of0JQXfY+73dFA9/rVAXGDl30emuWp+5n6vrY/6AO+a4N2vyhfO1Yrh3kjb11PPeaQ3XCcT0
	KYcTZkUb3ETzKxq03L+xNiaZmg9A0ZF8oJasXjP6zOORmyRySMhxab3bZQp98plwLJMgppekgasd/
	MICtLWwkYyz5Sb1xx0S5wCDfHkUg8Up9eE81iKDToiuinpGhCMcQPI0ODaz60xPI8AG84sbfJvMGF
	+OKMLsCTRoTIJGglLb8+l00jaww6Slh9iMirUX5WQdDoEoko/o0EgXE4kOd3zrHIKTWw2EHXOvxXQ
	OPdC1eyw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5mrO-00000009m1a-0kBF;
	Tue, 29 Oct 2024 14:06:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 30D4630073F; Tue, 29 Oct 2024 15:06:14 +0100 (CET)
Date: Tue, 29 Oct 2024 15:06:14 +0100
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
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 15/19] perf: Add deferred user callchains
Message-ID: <20241029140614.GC14555@noisy.programming.kicks-ass.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <1ce857387c781afa66efaa61eb88ff596b352500.1730150953.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ce857387c781afa66efaa61eb88ff596b352500.1730150953.git.jpoimboe@kernel.org>

On Mon, Oct 28, 2024 at 02:47:42PM -0700, Josh Poimboeuf wrote:
> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> index 2278402b7ac9..eeb15ba0137f 100644
> --- a/kernel/events/callchain.c
> +++ b/kernel/events/callchain.c
> @@ -217,7 +217,7 @@ static void fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entr
>  
>  struct perf_callchain_entry *
>  get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
> -		   u32 max_stack, bool add_mark)
> +		   u32 max_stack, bool add_mark, bool defer_user)
>  {
>  	struct perf_callchain_entry *entry;
>  	struct perf_callchain_entry_ctx ctx;
> @@ -246,6 +246,15 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>  			regs = task_pt_regs(current);
>  		}
>  
> +		if (defer_user) {
> +			/*
> +			 * Foretell the coming of PERF_RECORD_CALLCHAIN_DEFERRED
> +			 * which can be stitched to this one.
> +			 */
> +			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER_DEFERRED);
> +			goto exit_put;
> +		}
> +
>  		if (add_mark)
>  			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);

Given that the whole deferred thing doesn't handle COMPAT, this will
break thing, no?
