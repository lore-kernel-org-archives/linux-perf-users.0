Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A6F149C50;
	Wed,  9 Oct 2024 05:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728451851; cv=none; b=kWN9+ylpeb0xoMEjf1f68n3lC44iP6lAv97dPYtZhXFNGrLSqhrjzo+kwkrhX+1Uj+GTOyFXaIVB6DYoRpOVW1JngC15p+IGuWNdTcnE9pKeJC6LgQJ8+xZ1oMHhoaUQskz58/twN83/gutgUPOj77gk5gVUmfuzVgvSV4HfGCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728451851; c=relaxed/simple;
	bh=QHulExaFOuxw8+6LaqnNQ6LnWBqWhPfCVcT9XPDlQmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7Ci7sCEw+RTKXfns8csg370Rl+GqNID6k6ZbRt8DDjSIzGRGmqwOo1UbqY5HVZ8hYcKu+k3w+520kAZeDlwsupHTJib6ZnsZ+03RD7QfS6ymxYBfzzatDxroRAQV02QzBQxqRehtw05V6CRwDK99yTW+Afa3tT8ycO5ex6YbVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tia7IjaJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tia7IjaJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE067C4CEC5;
	Wed,  9 Oct 2024 05:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728451851;
	bh=QHulExaFOuxw8+6LaqnNQ6LnWBqWhPfCVcT9XPDlQmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tia7IjaJFREUgH9EA63f+4O8v141LmlZbaavXqT+3CDo2LZ9H8uKV02D9VoTlB2bB
	 jgmXpOTNcfwnIjVfd3n2eiS21vuqHtmXwo8d20P4PKVZ2aNEOUOGullTElXy1YIGbf
	 yF7LpFCxZBCOK+Nh/lXDP/IWW6Dl+vzEGii0MMrGx7kfCYP06LINoW7lydLW+H0maX
	 lG6WqnE40A4oy7f8zrcAr7yu+Sl+TVnItp54KCijyPxcCnAXowF9PIUzQbjPKlB/qj
	 sYojpYJmfVHF5Lzb5fOUBHvw4bKvtciVgkR15zOuu9z++qxkKXwC7umnxj7WQ7stb4
	 JpPtFn6//oZtA==
Date: Tue, 8 Oct 2024 22:30:49 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: linux@treblig.org, kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf callchain: Remove unused callchain_branch_counts
Message-ID: <ZwYVCTsf8p3v22HQ@google.com>
References: <20241006012204.373803-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241006012204.373803-1-linux@treblig.org>

On Sun, Oct 06, 2024 at 02:22:04AM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> callchain_branch_counts() was added in 2016 by commit
> 3dd029ef9401 ("perf report: Calculate and return the branch flag counting")
> but unused.
> 
> Remove it and it's helpers.

Kan, are you ok with this?

Thanks,
Namhyung

> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  tools/perf/util/callchain.c | 71 -------------------------------------
>  tools/perf/util/callchain.h |  4 ---
>  2 files changed, 75 deletions(-)
> 
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 0c7564747a14..11435b72afbe 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -1266,77 +1266,6 @@ int callchain_node__fprintf_value(struct callchain_node *node,
>  	return 0;
>  }
>  
> -static void callchain_counts_value(struct callchain_node *node,
> -				   u64 *branch_count, u64 *predicted_count,
> -				   u64 *abort_count, u64 *cycles_count)
> -{
> -	struct callchain_list *clist;
> -
> -	list_for_each_entry(clist, &node->val, list) {
> -		if (branch_count)
> -			*branch_count += clist->branch_count;
> -
> -		if (predicted_count)
> -			*predicted_count += clist->predicted_count;
> -
> -		if (abort_count)
> -			*abort_count += clist->abort_count;
> -
> -		if (cycles_count)
> -			*cycles_count += clist->cycles_count;
> -	}
> -}
> -
> -static int callchain_node_branch_counts_cumul(struct callchain_node *node,
> -					      u64 *branch_count,
> -					      u64 *predicted_count,
> -					      u64 *abort_count,
> -					      u64 *cycles_count)
> -{
> -	struct callchain_node *child;
> -	struct rb_node *n;
> -
> -	n = rb_first(&node->rb_root_in);
> -	while (n) {
> -		child = rb_entry(n, struct callchain_node, rb_node_in);
> -		n = rb_next(n);
> -
> -		callchain_node_branch_counts_cumul(child, branch_count,
> -						   predicted_count,
> -						   abort_count,
> -						   cycles_count);
> -
> -		callchain_counts_value(child, branch_count,
> -				       predicted_count, abort_count,
> -				       cycles_count);
> -	}
> -
> -	return 0;
> -}
> -
> -int callchain_branch_counts(struct callchain_root *root,
> -			    u64 *branch_count, u64 *predicted_count,
> -			    u64 *abort_count, u64 *cycles_count)
> -{
> -	if (branch_count)
> -		*branch_count = 0;
> -
> -	if (predicted_count)
> -		*predicted_count = 0;
> -
> -	if (abort_count)
> -		*abort_count = 0;
> -
> -	if (cycles_count)
> -		*cycles_count = 0;
> -
> -	return callchain_node_branch_counts_cumul(&root->node,
> -						  branch_count,
> -						  predicted_count,
> -						  abort_count,
> -						  cycles_count);
> -}
> -
>  static int count_pri64_printf(int idx, const char *str, u64 value, char *bf, int bfsize)
>  {
>  	return scnprintf(bf, bfsize, "%s%s:%" PRId64 "", (idx) ? " " : " (", str, value);
> diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
> index 86ed9e4d04f9..d7741fa9e9de 100644
> --- a/tools/perf/util/callchain.h
> +++ b/tools/perf/util/callchain.h
> @@ -298,10 +298,6 @@ void free_callchain(struct callchain_root *root);
>  void decay_callchain(struct callchain_root *root);
>  int callchain_node__make_parent_list(struct callchain_node *node);
>  
> -int callchain_branch_counts(struct callchain_root *root,
> -			    u64 *branch_count, u64 *predicted_count,
> -			    u64 *abort_count, u64 *cycles_count);
> -
>  void callchain_param_setup(u64 sample_type, const char *arch);
>  
>  bool callchain_cnode_matched(struct callchain_node *base_cnode,
> -- 
> 2.46.2
> 
