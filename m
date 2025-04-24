Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABD4284678;
	Thu, 24 Apr 2025 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745512588; cv=none; b=pbTwiWr2gQT1OSABxaMRuBJ8lp9XlCSC4BJofWMjJe7dJbM5vJzjND6+qOhEjJgxiVXhSIy112mHWLOKSWoGshTj5XlykbKB6Bh3DQfic0FOAVywTj9EtXtlPxmABNS3Axo1lYTCfmvF+zc4rpoR+2GTYiX9adr5K/vOdpnk6MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745512588; c=relaxed/simple;
	bh=/aFBj7Kxk31NC+0W0dcWgkBSWzJZGteQmjhthFxkdJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbWbC2d5Ut2Zz3kpuJOf9QSBfSNFoDkTlVZJcc+5xVzdokrvzpQEReZp1YuBZLHPFbkgO8dGtigGJOuIchi/IXRoQuRVrILHcdZhV1rYJzsHIyUQJz+lSDv9cpQsj7MUUWnBLOl7LpV3mbp23YYXEU8Is+Gie7Uyd6cJs0C/T+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Bi9sw7Gz; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bi9sw7Gz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c4BwVslkenmPGY5taqQK2WCuZ2MwdKKhFW5xSNVMK0c=; b=Bi9sw7GzJYYNvK7mIbPfZVpAR9
	sH6IKzasdnNElit0CFTjX2dp2Mah+KO8yaEUrfFFnZyRUuaN57fZ07H9xeCl7wMHBh1rbaNbSAOb1
	toSxHIGlBEtfzdl1ya95RBngfUr4X8e1groVZQkpqHZJlY6B7z+ugW4XPVYYnGycNAPV4lrVre1lV
	A3QWrTkeeZIFJYwDkr2DxtvyM/ZFoZW4hV0pPDAQiJXkzu6qfkJFD4/5JcOb3KPivdZLY7ow5ZeZQ
	wMSTZYoEe/DLElZp8byeKDaRm6BoFPDBH/osu7E0zcqUJgrYSkTRG7Fww7y42gA2T5+zeaMHvX0F3
	S6n9hW/g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u7zYW-0000000BrR2-0yVU;
	Thu, 24 Apr 2025 16:36:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CAEE6300642; Thu, 24 Apr 2025 18:36:07 +0200 (CEST)
Date: Thu, 24 Apr 2025 18:36:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>, Weinan Liu <wnliu@google.com>,
	Blake Jones <blakejones@google.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>
Subject: Re: [PATCH v5 11/17] perf: Simplify get_perf_callchain() user logic
Message-ID: <20250424163607.GE18306@noisy.programming.kicks-ass.net>
References: <20250424162529.686762589@goodmis.org>
 <20250424162633.048002581@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424162633.048002581@goodmis.org>

On Thu, Apr 24, 2025 at 12:25:40PM -0400, Steven Rostedt wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Simplify the get_perf_callchain() user logic a bit.  task_pt_regs()
> should never be NULL.
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/events/callchain.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> index abf258913ab6..bba7f8540ade 100644
> --- a/kernel/events/callchain.c
> +++ b/kernel/events/callchain.c
> @@ -246,22 +246,20 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>  
>  	if (user) {
>  		if (!user_mode(regs)) {
> -			if  (current->mm)
> -				regs = task_pt_regs(current);
> -			else
> -				regs = NULL;
> +			if (!current->mm)
> +				goto exit_put;
> +			regs = task_pt_regs(current);

I'm thinking this might be one of those is-kthread test written as
has-mm, and they're broken.

Notably things like the io-uring kthreads do have mm.

>  		}
>  
> -		if (regs) {
> -			if (add_mark)
> -				perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
> +		if (add_mark)
> +			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
>  
> -			start_entry_idx = entry->nr;
> -			perf_callchain_user(&ctx, regs);
> -			fixup_uretprobe_trampoline_entries(entry, start_entry_idx);
> -		}
> +		start_entry_idx = entry->nr;
> +		perf_callchain_user(&ctx, regs);
> +		fixup_uretprobe_trampoline_entries(entry, start_entry_idx);
>  	}
>  
> +exit_put:
>  	put_callchain_entry(rctx);
>  
>  	return entry;
> -- 
> 2.47.2
> 
> 
