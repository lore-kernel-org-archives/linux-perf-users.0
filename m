Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5AE17BA5;
	Thu, 28 Nov 2024 20:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732825405; cv=none; b=Zoq2VDj0iyT/DaCgDxxifd2Jefj7TjZS7qw1/clC1hxtx4v/K+HFeYDVF3HVVeNMeK7hKQw9WlaV2qRvVS0KyCDwuHSiNvn47H7nPUw1qbHeJjtdr2PZrARcl/M+hCj21ufZC35GQvT4pejdvQzs7DFzI3pLYnecteRD+IQH/9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732825405; c=relaxed/simple;
	bh=mM64QnCJiC6n/sRiA3ZMl7Eg9eQMsjFpUlXOy9T5aoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6prJswDnftAxysvX2X3kkVAaVqfWr3U5LAFVmrhI82L9GAUYCjruXu1B2JsyvA99Par9Qy2mcl+OpaWrO0Ia8nIfHg3t2jdcqeALxdkDRzmaYaJHBcs1dDjI/2iuEb38u6mSqyxqsnE34jhaYaxCo7IlTAtag545jvXPyxOjx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPUWs+Xa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPUWs+Xa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98E9C4CECE;
	Thu, 28 Nov 2024 20:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732825404;
	bh=mM64QnCJiC6n/sRiA3ZMl7Eg9eQMsjFpUlXOy9T5aoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PPUWs+XaML/Wj/iyxm7w8JwcskM8Bu4bSKaKZFNZtcP0mKbfZpE73e4jrwWs148Dg
	 PjepTjr5Ueud6QseOz0dd+5zKk+QW1W4LLdvr/HL54dqy6J2Fughg+mjkh3YDbtqHv
	 exeHFYfgaOud8kvdggva0cK8RlTMzFe3tOFBFYHRuehVEWudXqi4Y6/w1psT1n4FUn
	 wjdDqJa9RgXDCDk7uMKhaZQ3FaKLNgFHaUJ3eCyItORqgLtcAXil2npT2Mv1PFRyct
	 K1LT/Fi+Qm30R8/xJK1aEm+E8LjQGS/MOxZSL8AAsLQdCAIy7UzhppclTazlqTIkn5
	 PiIQXe1xi336A==
Date: Thu, 28 Nov 2024 17:23:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yang Jihong <yangjihong@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, james.clark@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 02/12] perf event action: Add parsing const expr support
Message-ID: <Z0jROJ7JPTjmeZly@x1>
References: <20241128133553.823722-1-yangjihong@bytedance.com>
 <20241128133553.823722-3-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128133553.823722-3-yangjihong@bytedance.com>

On Thu, Nov 28, 2024 at 09:35:43PM +0800, Yang Jihong wrote:
> Event action requires constant expression parsing support,
> which include constant integer and constant string.
> 
> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
> ---
>  tools/perf/util/parse-action.c | 27 +++++++++++++++++++++++++++
>  tools/perf/util/parse-action.h |  5 +++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/tools/perf/util/parse-action.c b/tools/perf/util/parse-action.c
> index 01c8c7fdea59..391546bf3d73 100644
> --- a/tools/perf/util/parse-action.c
> +++ b/tools/perf/util/parse-action.c
> @@ -4,6 +4,9 @@
>   * Actions are the programs that run when the sampling event is triggered.
>   * The action is a list of expressions separated by semicolons (;).
>   * Each action is an expression, added to actions_head node as list_head node.
> + *
> + * Supported expressions:
> + *   - constant:

This seems incomplete, what should come after the :?

the patch description, at the beginning of this message has more details
than here.

>   */
>  
>  #include "util/debug.h"
> @@ -115,7 +118,31 @@ void event_actions__free(void)
>  	(void)event_actions__for_each_expr_safe(do_action_free, NULL, false);
>  }
>  
> +static struct evtact_expr_ops *expr_const_ops_list[EVTACT_EXPR_CONST_TYPE_MAX] = {
> +};
> +
> +static int expr_const_set_ops(struct evtact_expr *expr, u32 opcode)
> +{
> +	if (opcode >= EVTACT_EXPR_CONST_TYPE_MAX) {
> +		pr_err("expr_const opcode invalid: %u\n", opcode);
> +		return -EINVAL;
> +	}
> +
> +	if (expr_const_ops_list[opcode] == NULL) {
> +		pr_err("expr_const opcode not supported: %u\n", opcode);
> +		return -ENOTSUP;
> +	}

Since expr_const_ops_list[EVTACT_EXPR_TYPE_CONST] is NULL, this will
always fail?

> +
> +	expr->ops = expr_const_ops_list[opcode];
> +	return 0;
> +}
> +
> +static struct evtact_expr_class expr_const = {
> +	.set_ops = expr_const_set_ops,
> +};
> +
>  static struct evtact_expr_class *expr_class_list[EVTACT_EXPR_TYPE_MAX] = {
> +	[EVTACT_EXPR_TYPE_CONST]   = &expr_const,
>  };
>  
>  int parse_action_expr__set_class(enum evtact_expr_type type,
> diff --git a/tools/perf/util/parse-action.h b/tools/perf/util/parse-action.h
> index 71a0a166959e..47bd75264dee 100644
> --- a/tools/perf/util/parse-action.h
> +++ b/tools/perf/util/parse-action.h
> @@ -9,9 +9,14 @@
>  #include "evlist.h"
>  
>  enum evtact_expr_type {
> +	EVTACT_EXPR_TYPE_CONST,
>  	EVTACT_EXPR_TYPE_MAX,
>  };
>  
> +enum evtact_expr_const_type {
> +	EVTACT_EXPR_CONST_TYPE_MAX,
> +};
> +
>  struct evtact_expr;
>  struct evtact_expr_ops {
>  	int (*new)(struct evtact_expr *expr, void *data, int size);
> -- 
> 2.25.1
