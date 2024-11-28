Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C5B142624;
	Thu, 28 Nov 2024 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732825537; cv=none; b=HYDBUv2Va4zZhQBB4GuJQA3NkdwZ8y4mdBWHd1B7ixgMn6f0ap8T7sKmADQ4xi6D1B5FqdTUs8ufp5mUXcXYiv1m0jxQV8/IKpo6mmdvuXs5FkD8lYgtotgDWVEJY7aFR9hevgL15pBJZzU9BBgxsqxqybvoxonSdTsxmtGev4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732825537; c=relaxed/simple;
	bh=wg2OdLiGxNOlS6DPM8bmGhpyvOvwSsmizKT6Gumf8jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIwWDVhHwRzzfdHR7MfBbWe/Sh8Dvf0QUkG1B2JtqK149QyiKQ29oRHl5ZckGodXGdjGayp20kXwsph9QduSwxt2Tp0IpV7S9HGUWx8nS6tuUHgBbZo5gnXPg2ftERWS5sWaslp9zjPsSwoOXQRg7BjDQ0tqVvQbV3G+J1Y/cpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbCXxZKc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbCXxZKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6FBC4CECE;
	Thu, 28 Nov 2024 20:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732825536;
	bh=wg2OdLiGxNOlS6DPM8bmGhpyvOvwSsmizKT6Gumf8jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gbCXxZKcEw7+HSPCd4WVnTUqnxyg58O0Lxa4yO8CvKusB2pFnCC/RQhQol+bG5gxJ
	 a42PnXK6W8U6TRvz6Qi60enClLtCgg8/DnaLHKTL5tnZ1NAddhVLm2a+mzBNEFZHVF
	 YQu7756Z61kZfILaPStkgVWHCFmv0+2BdInXFppayTRVltd8C5DWNwnlQbGytqlucn
	 87H98heX+ognpcu+rNa2s5OiP2DEwfRrbYSZYqCTj6p14e+On4CTx7D5IaZUqh/JR+
	 I/tUbFJSQBCLHQTrhAcFmZKwVXCtKhPpjXO+bC/XTfEKERgGB4Qu+C591qBffxmXEW
	 B3pc+620VpBig==
Date: Thu, 28 Nov 2024 17:25:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yang Jihong <yangjihong@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, james.clark@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 03/12] perf event action: Add parsing const integer expr
 support
Message-ID: <Z0jRvSlEZveQFVh7@x1>
References: <20241128133553.823722-1-yangjihong@bytedance.com>
 <20241128133553.823722-4-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128133553.823722-4-yangjihong@bytedance.com>

On Thu, Nov 28, 2024 at 09:35:44PM +0800, Yang Jihong wrote:
> Support parsing of constant integer expression.
> 
> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
> ---
>  tools/perf/util/parse-action.c | 52 ++++++++++++++++++++++++++++++++++
>  tools/perf/util/parse-action.h |  1 +
>  tools/perf/util/parse-action.l | 19 +++++++++++++
>  tools/perf/util/parse-action.y | 13 ++++++++-
>  4 files changed, 84 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-action.c b/tools/perf/util/parse-action.c
> index 391546bf3d73..3b10cf9f99b3 100644
> --- a/tools/perf/util/parse-action.c
> +++ b/tools/perf/util/parse-action.c
> @@ -7,6 +7,7 @@
>   *
>   * Supported expressions:
>   *   - constant:
> + *     - integer

And now there are alignment differences and no : ?

>   */
>  
>  #include "util/debug.h"
> @@ -118,7 +119,58 @@ void event_actions__free(void)
>  	(void)event_actions__for_each_expr_safe(do_action_free, NULL, false);
>  }
>  
> +static int expr_const_int_new(struct evtact_expr *expr, void *data, int size)
> +{
> +	if (data == NULL ||
> +	    (size != sizeof(int)
> +	     && size != sizeof(long) && size != sizeof(long long))) {

&& should be at the end of the previous line, just like you did with the
|| at the end of the first line

> +		pr_err("expr_const_int size invalid: %d\n", size);
> +		return -EINVAL;
> +	}
> +
> +	expr->priv = malloc(sizeof(long long));
> +	if (expr->priv == NULL) {
> +		pr_err("exp_ const_int malloc failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	if (size == sizeof(int))
> +		*(unsigned long long *)(expr->priv) = *(unsigned int *)data;
> +	else if (size == sizeof(long))
> +		*(unsigned long long *)(expr->priv) = *(unsigned long *)data;
> +	else if (size == sizeof(long long))
> +		*(unsigned long long *)(expr->priv) = *(unsigned long long *)data;
> +
> +	INIT_LIST_HEAD(&expr->opnds);
> +	return 0;
> +}
> +
> +static void expr_const_int_free(struct evtact_expr *expr)
> +{
> +	zfree(&expr->priv);
> +}
> +
> +static int expr_const_int_eval(struct evtact_expr *expr,
> +			       void *in __maybe_unused, int in_size __maybe_unused,
> +			       void **out, int *out_size)
> +{
> +	if (out != NULL)
> +		*out = expr->priv;
> +
> +	if (out_size != NULL)
> +		*out_size = sizeof(long long);
> +
> +	return 0;
> +}
> +
> +static struct evtact_expr_ops expr_const_int_ops = {
> +	.new  = expr_const_int_new,
> +	.free = expr_const_int_free,
> +	.eval = expr_const_int_eval,
> +};
> +
>  static struct evtact_expr_ops *expr_const_ops_list[EVTACT_EXPR_CONST_TYPE_MAX] = {
> +	[EVTACT_EXPR_CONST_TYPE_INT] = &expr_const_int_ops,
>  };
>  
>  static int expr_const_set_ops(struct evtact_expr *expr, u32 opcode)
> diff --git a/tools/perf/util/parse-action.h b/tools/perf/util/parse-action.h
> index 47bd75264dee..ac81278c590e 100644
> --- a/tools/perf/util/parse-action.h
> +++ b/tools/perf/util/parse-action.h
> @@ -14,6 +14,7 @@ enum evtact_expr_type {
>  };
>  
>  enum evtact_expr_const_type {
> +	EVTACT_EXPR_CONST_TYPE_INT,
>  	EVTACT_EXPR_CONST_TYPE_MAX,
>  };
>  
> diff --git a/tools/perf/util/parse-action.l b/tools/perf/util/parse-action.l
> index 3cb72de50372..9237399a11ac 100644
> --- a/tools/perf/util/parse-action.l
> +++ b/tools/perf/util/parse-action.l
> @@ -13,13 +13,32 @@
>  #include "parse-action.h"
>  #include "parse-action-bison.h"
>  
> +static int value(int base)
> +{
> +	unsigned long long num;
> +
> +	errno = 0;
> +	num = strtoul(parse_action_text, NULL, base);
> +	if (errno) {
> +		pr_err("parse_action malloc number failed\n");
> +		return ERROR;
> +	}
> +
> +	parse_action_lval.num = num;
> +	return NUMBER;
> +}
> +
>  %}
>  
> +num_dec		[0-9]+
> +num_hex		0[xX][0-9a-fA-F]+
>  space		[ \t]
>  ident		[_a-zA-Z][_a-zA-Z0-9]*
>  
>  %%
>  
> +{num_dec}	{ return value(10); }
> +{num_hex}	{ return value(16); }
>  {space}		{ }
>  
>  ";"		{ return SEMI; }
> diff --git a/tools/perf/util/parse-action.y b/tools/perf/util/parse-action.y
> index fade9d093d4a..51e77e54f157 100644
> --- a/tools/perf/util/parse-action.y
> +++ b/tools/perf/util/parse-action.y
> @@ -17,6 +17,8 @@
>  #include "util/debug.h"
>  #include "util/parse-action.h"
>  
> +#define expr_id(t, o) evtact_expr_id_encode(EVTACT_EXPR_TYPE_##t, EVTACT_EXPR_##t##_TYPE_##o)
> +
>  int parse_action_lex(void);
>  
>  static void parse_action_error(struct list_head *expr __maybe_unused,
> @@ -32,13 +34,15 @@ static void parse_action_error(struct list_head *expr __maybe_unused,
>  	char *str;
>  	struct evtact_expr *expr;
>  	struct list_head *list;
> +	unsigned long long num;
>  }
>  
> -%token IDENT ERROR
> +%token IDENT ERROR NUMBER
>  %token SEMI
>  %type <expr> action_term expr_term
>  %destructor { parse_action_expr__free($$); } <expr>
>  %type <str> IDENT
> +%type <num> NUMBER
>  
>  %%
>  
> @@ -65,6 +69,13 @@ expr_term
>  }
>  
>  expr_term:
> +NUMBER
> +{
> +	$$ = parse_action_expr__new(expr_id(CONST, INT), NULL, (void *)&$1, sizeof($1));
> +	if ($$ == NULL)
> +		YYERROR;
> +}
> +|
>  IDENT
>  {
>  	$$ = NULL;
> -- 
> 2.25.1
