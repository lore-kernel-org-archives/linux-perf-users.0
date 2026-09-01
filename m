Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80C83242D8;
	Tue,  1 Sep 2026 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223801; cv=none; b=YcUL/WHN98MvF7wW8+7Cx5sAkwjHpKQxDukesLL7zcXGYJtS8PZUaRE6pk+xzo/uvBayokhaStOvpdhA5fp0Lxkb5NpYp065YKUOTsdcNc/xPxKiEKb+qxwjx4v2fl34SMB/AfZ43e/gnil9BBh4wquih63ngGm310cKVqAXeOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223801; c=relaxed/simple;
	bh=tWL3HvHco2HDuBsJag+unRfyL+Yd2xIq3e039GrmFxo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NCyoBOnONuH0mRrROJTXda1smjEHSHh7/l/h0CeB4ZHaGbUoBtr7ELhtG+fWq4QrbMkXhKm/dgECy/NtOHuu2h1SK+0jMQt0eXKHBQxslHs3ce4o6CPeSTSNKJR3FgiBQwgJG1UwZuye0DFgnHHTsrOsv6S20sgZaD1DkT/u9tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5bvLsYN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5bvLsYN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5821F000E9;
	Tue,  1 Sep 2026 00:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788223799;
	bh=p+d0+QGpYQAr/aEJje/3/qNkkDjXqlWgLKSNJQd1hHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=e5bvLsYNggbEpU5MyN8OB/rcrtPKvVCX8SUsNuKd03s0ySgctH+kvb1RB+QSzli2U
	 P9JTyICbSI16oU7/KG4RKtOKyIdT+xgbMjuNkmAmb4JPU1Tv+2ZJKgpEa6uuv85AQW
	 IUndJZsZPfIDZE+Jfbi+wGP420mnmbsswNFuTMVA+QLerw8ul7krrfuIRrTzz3tqAa
	 H9viHdAdqtU4ezRFUZU//ybDhkrWTvekthxC4zYqukU8LIauARqcT1kX4fek3GN8wM
	 7syeNx6n9YxXj2kT7vgCDipWWV32k3QEH51mu+PJPpE26DhnsSvZEA5m0x39AURgBn
	 N/bWMYhfK5tFA==
Date: Tue, 1 Sep 2026 09:49:55 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andi Kleen <ak@kernel.org>
Cc: linux-kernel@vger.kernel.org, mhiramat@kernel.org, oleg@redhat.com,
 peterz@infradead.org, tglx@kernel.org, x86@kernel.org, jolsa@kernel.org,
 linux-perf-users@vger.kernel.org, adrian.hunter@intel.com
Subject: Re: [RFC v1 01/19] uprobes: guard trace cleanup against error
 pointers
Message-Id: <20260901094955.eccd14a89176e3f09d93b731@kernel.org>
In-Reply-To: <20260831150651.1134594-2-ak@kernel.org>
References: <20260831150651.1134594-1-ak@kernel.org>
	<20260831150651.1134594-2-ak@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 08:04:37 -0700
Andi Kleen <ak@kernel.org> wrote:

> Sashiko pointed out the some of the scope cleanups for free_uprobe
> could get an error pointer. Handle this case in free_uprobe
> to prevent a crash.
> 
> On the other hand the macro doesn't need the guard because
> free_uprobe itself already does the check.
> 
> Assisted-by: omp:gpt-5.6-luna sashiko
> Signed-off-by: Andi Kleen <ak@kernel.org>

This looks good to me. Let me pick this to probes/fixes independently.

Thanks!

> ---
>  kernel/trace/trace_uprobe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 861d857adadb..22cc3c8181b8 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -368,7 +368,7 @@ alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret)
>  
>  static void free_trace_uprobe(struct trace_uprobe *tu)
>  {
> -	if (!tu)
> +	if (IS_ERR_OR_NULL(tu))
>  		return;
>  
>  	path_put(&tu->path);
> @@ -533,7 +533,7 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
>  	return ret;
>  }
>  
> -DEFINE_FREE(free_trace_uprobe, struct trace_uprobe *, if (_T) free_trace_uprobe(_T))
> +DEFINE_FREE(free_trace_uprobe, struct trace_uprobe *, free_trace_uprobe(_T))
>  
>  /*
>   * Argument syntax:
> -- 
> 2.54.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
