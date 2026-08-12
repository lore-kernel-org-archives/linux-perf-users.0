Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ADE3EB81D;
	Wed, 12 Aug 2026 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786524219; cv=none; b=A21ZKARbzYW9eMR+coNQP95KscURPfDG5pHhW1t6nitPL0X82pwBhMHfaxM/2zxXcQo5ZzxzYZNEwNHpgSwE/w5WlQp7lcRkRbM0gtmERf7pWupYFEPakU7K8A21UtDaWis8ZXKYPuRljaLbX/Hha30xE3DDhhpQR11K+rWlOMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786524219; c=relaxed/simple;
	bh=hi9YehzdxlZUitA53TFdwDOJhezPj1AX/dQk9fooc60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxOMnH/rV5bsAE47IAWXCz9vYsDZcFjS5MUtyaaNeWszctHO3OoKp2j7tHND7ZylDcoL4k+PMQ6uBWL6tbOnnFeuSvtiXEPxXgxPGxkUYs6l8tioTC6ZFClzS1qyg02BWW4L+WgrUdw24w+ga7UW7j/2imi+rb+w1Mzb8MkFaME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FouuAoe+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FouuAoe+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4D41F000E9;
	Wed, 12 Aug 2026 08:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786524217;
	bh=5FV0AeUFih37sUUWotPoyPZzaKjm1XffDeTRnRdX0a4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FouuAoe+d8EJaiG7wLZk7In7Jk/eF1uP5tuuMiKUkgFrYQRXpqZw1mXR1fqht5Z7S
	 xa+BfVM/aG5prVKqUTsa4nrJxcF6buZSLDmlf48EPUYFdHBwHeoCB+7yzJFjL9lWE4
	 cTLxuYO7vvog5cikfJ+P9FwDa7u+aSbhqOzA0LP7Fph7dbnoPwl5Sv+k5VvJ6D8pz8
	 hGejVAdwGUB6Ynu9ZvmdBT4P+Ukgh0mMYGQRqcNuhg6TEm4FWRwxd01YImWZhQurPF
	 sfc2+a6QeE3eFz0gH5zLflshjxlp/kxwHvxm0uS9NJMA5xHKJkK1/fmlMDLQO0jiHP
	 4VpFGYbX1eXxg==
Date: Wed, 12 Aug 2026 17:43:32 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Jiebin Sun <jiebin.sun@intel.com>
Cc: acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org,
	mark.rutland@arm.com, dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com, tianyou.li@intel.com,
	wangyang.guo@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/9] perf c2c: add column rendering for function view
Message-ID: <anwyNEKi0wSHEuOI@google.com>
References: <20260810052647.588867-1-jiebin.sun@intel.com>
 <20260810052647.588867-4-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810052647.588867-4-jiebin.sun@intel.com>

On Mon, Aug 10, 2026 at 01:26:41PM +0800, Jiebin Sun wrote:
> Add renderers for the function view's Cycles %, Store count, and
> hierarchy identity columns. The identity column renders the read-side
> function, contending writer, or cacheline, with indentation for the
> hierarchy level. Also add width and header helpers, estimated-cycle
> calculation, comparators, and the dimension table that ties them together.
> 
> Clamp the identity renderer's returned length to its local buffer before
> using it for pointer and padding calculations. This handles snprintf-style
> would-have-been lengths without changing normal output.
> 
> The next patch connects these dimensions to the view's HPP lists, so the
> symbols used only there are temporarily marked __maybe_unused.
> 
> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Falcon <thomas.falcon@intel.com>
> Reviewed-by: Tianyou Li <tianyou.li@intel.com>
> Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
> ---
[SNIP]
> +/*
> + * Store count shown in the column: a level-3 cacheline leaf shows its parent
> + * level-2 writer's stores on that line, not all stores on the line. A level-2
> + * writer shows the sum across its level-3 cachelines. A level-1 reader shows
> + * the sum across all included writers on the cachelines it reads; this is not
> + * the reader function's own store count and is not additive across readers.
> + */
> +static u64 hist_entry__displayed_stores(struct hist_entry *he)
> +{
> +	struct c2c_hist_entry *c2c_he = container_of(he, struct c2c_hist_entry, he);
> +	struct rb_node *nd;
> +	u64 stores = 0;
> +
> +	/* Level-2/3 entries already aggregate the stores they represent. */
> +	if (he->parent_he)
> +		return c2c_he->stats.store;
> +
> +	for (nd = rb_first_cached(&he->hroot_out); nd; nd = rb_next(nd)) {
> +		struct hist_entry *child = rb_entry(nd, struct hist_entry, rb_node);
> +		struct c2c_hist_entry *child_c2c;
> +
> +		child_c2c = container_of(child, struct c2c_hist_entry, he);

Can it be simplified like this?

		struct c2c_hist_entry *child_c2c = rb_entry(nd, struct c2c_hist_entry, he.rb_node);

Thanks,
Namhyung


> +		stores += child_c2c->stats.store;
> +	}
> +	return stores;
> +}
