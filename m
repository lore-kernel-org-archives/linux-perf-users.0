Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC353C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 20:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A397861381
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 20:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242794AbhI1U5x (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 16:57:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55153 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242764AbhI1U5w (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Sep 2021 16:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632862572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=avud/PKF18tViJbM+ksOVnSjneWrBRMxvlVl+1jrICI=;
        b=gKPlkr+twXDMkjWs9ghsURF+pUTm8bmNH2RCPbR01frjcCnGlQ3W8YpBeB/hy3DK1l5FUp
        psS4JnuRWRmNIVM0PRnc/RqgwWEWXV3hgXN/pyBuwPY/bpO+cdwrI04/17eZRvGkeC2TcV
        0ceoQ3+ZkVgm3lTeg0gRGyuCgBFkiB8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-sawqqeJVM2KWZYvtSG-Y0g-1; Tue, 28 Sep 2021 16:56:11 -0400
X-MC-Unique: sawqqeJVM2KWZYvtSG-Y0g-1
Received: by mail-ed1-f71.google.com with SMTP id r11-20020aa7cfcb000000b003d4fbd652b9so1531edy.14
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Sep 2021 13:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=avud/PKF18tViJbM+ksOVnSjneWrBRMxvlVl+1jrICI=;
        b=ZrCe3SSPHqV9P7YRrkX1FYI+/SjZ08yfZQ3rzy6I5XkdDNcVlIzr790SSsIDnNMwsz
         vh3+WUkD9izb/Bw42qzvdRYaEMjcXFxwz4XOIiDnzcNOdmAStRG3EuWE3iHAUM8BLP6v
         +FpBHMTbmq3QXAfvcBsq38WEXc+2u8lojD9GbBocfy8CUUHrEJnY94yALPGieb7Je61Z
         hQ/SAeZ6dub/lxmD9voeCGyTWDnjApq4HHpYrU+sKfT595Z2COTt8gXfjhUHP4qVxJtm
         0piiPcyVbWGJ2nKorYfDWFukPRQw7qXwSCJ2ZcO4BiVvuVRKkBgE3vI2wTMGpCsef0+X
         paXw==
X-Gm-Message-State: AOAM532X/eE14+ug6MwIGzuvpSTA9oVx8ft375J9SgNW1KJZ1b26KLlo
        z5giFBCgpWkgLJSzXGIv1cmSdYQOQ0qDr08hDpKNOyqXD4mX/1MlwjZknbm+m4esTqhXRKYN3as
        d8kjrqIwA9W1wQgOCP1okHMcFB4MCWQ==
X-Received: by 2002:a05:6402:1503:: with SMTP id f3mr10295216edw.24.1632862569911;
        Tue, 28 Sep 2021 13:56:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpuxFQvp4wBjULizt7Tt8oVwlJZzYE0pAlD1HyjxcSk6o48RnWuQ5wb4k0qiJTY/khrZ1sfQ==
X-Received: by 2002:a05:6402:1503:: with SMTP id f3mr10295176edw.24.1632862569635;
        Tue, 28 Sep 2021 13:56:09 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id cr9sm118857edb.17.2021.09.28.13.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 13:56:09 -0700 (PDT)
Date:   Tue, 28 Sep 2021 22:56:05 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>
Subject: Re: [PATCH v9 10/13] perf expr: Merge find_ids and regular parsing
Message-ID: <YVOBZRKnPD2jWQf0@krava>
References: <20210923074616.674826-1-irogers@google.com>
 <20210923074616.674826-11-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923074616.674826-11-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Sep 23, 2021 at 12:46:13AM -0700, Ian Rogers wrote:
> Add a new option to parsing that the set of IDs being used should be
> computed, this means every action needs to handle the compute_ids and
> regular case. This means actions yield a new ids type is a set of ids or
> the value being computed. Use the compute_ids case to replace find IDs
> parsing.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/expr.c |   9 +--
>  tools/perf/util/expr.h |   1 -
>  tools/perf/util/expr.l |   9 ---
>  tools/perf/util/expr.y | 176 ++++++++++++++++++++++++++++++-----------
>  4 files changed, 136 insertions(+), 59 deletions(-)
> 
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 81101be51044..db2445677c8c 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -314,10 +314,9 @@ void expr__ctx_free(struct expr_parse_ctx *ctx)
>  
>  static int
>  __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
> -	      int start, int runtime)
> +	      bool compute_ids, int runtime)
>  {
>  	struct expr_scanner_ctx scanner_ctx = {
> -		.start_token = start,
>  		.runtime = runtime,
>  	};
>  	YY_BUFFER_STATE buffer;
> @@ -337,7 +336,7 @@ __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
>  	expr_set_debug(1, scanner);
>  #endif
>  
> -	ret = expr_parse(val, ctx, scanner);
> +	ret = expr_parse(val, ctx, compute_ids, scanner);
>  
>  	expr__flush_buffer(buffer, scanner);
>  	expr__delete_buffer(buffer, scanner);
> @@ -348,13 +347,13 @@ __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
>  int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
>  		const char *expr, int runtime)
>  {
> -	return __expr__parse(final_val, ctx, expr, EXPR_PARSE, runtime) ? -1 : 0;
> +	return __expr__parse(final_val, ctx, expr, /*compute_ids=*/false, runtime) ? -1 : 0;
>  }
>  
>  int expr__find_ids(const char *expr, const char *one,
>  		   struct expr_parse_ctx *ctx, int runtime)
>  {
> -	int ret = __expr__parse(NULL, ctx, expr, EXPR_OTHER, runtime);
> +	int ret = __expr__parse(NULL, ctx, expr, /*compute_ids=*/true, runtime);
>  
>  	if (one)
>  		expr__del_id(ctx, one);
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index 4ed186bd1f13..b20513f0ae59 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -26,7 +26,6 @@ struct expr_parse_ctx {
>  struct expr_id_data;
>  
>  struct expr_scanner_ctx {
> -	int start_token;
>  	int runtime;
>  };
>  
> diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> index 13e5e3c75f56..702fdf6456ca 100644
> --- a/tools/perf/util/expr.l
> +++ b/tools/perf/util/expr.l
> @@ -91,15 +91,6 @@ symbol		({spec}|{sym})+
>  %%
>  	struct expr_scanner_ctx *sctx = expr_get_extra(yyscanner);
>  
> -	{
> -		int start_token = sctx->start_token;
> -
> -		if (sctx->start_token) {
> -			sctx->start_token = 0;
> -			return start_token;
> -		}
> -	}
> -
>  d_ratio		{ return D_RATIO; }
>  max		{ return MAX; }
>  min		{ return MIN; }
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index 78cbe377eb0e..6aeead54760a 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -1,6 +1,7 @@
>  /* Simple expression parser */
>  %{
>  #define YYDEBUG 1
> +#include <assert.h>
>  #include <math.h>
>  #include "util/debug.h"
>  #include "smt.h"
> @@ -12,15 +13,31 @@
>  
>  %parse-param { double *final_val }
>  %parse-param { struct expr_parse_ctx *ctx }
> +%parse-param { bool compute_ids }
>  %parse-param {void *scanner}
>  %lex-param {void* scanner}
>  
>  %union {
>  	double	 num;
>  	char	*str;
> +	struct ids {
> +		/*
> +		 * When creating ids, holds the working set of event ids. NULL
> +		 * implies the set is empty.
> +		 */
> +		struct hashmap *ids;
> +		/*
> +		 * The metric value. When not creating ids this is the value
> +		 * read from a counter, a constant or some computed value. When
> +		 * creating ids the value is either a constant or BOTTOM. NAN is
> +		 * used as the special BOTTOM value, representing a "set of all
> +		 * values" case.
> +		 */
> +		double val;
> +	} ids;
>  }
>  
> -%token ID NUMBER MIN MAX IF ELSE SMT_ON D_RATIO EXPR_ERROR EXPR_PARSE EXPR_OTHER
> +%token ID NUMBER MIN MAX IF ELSE SMT_ON D_RATIO EXPR_ERROR
>  %left MIN MAX IF
>  %left '|'
>  %left '^'
> @@ -32,65 +49,109 @@
>  %type <num> NUMBER
>  %type <str> ID
>  %destructor { free ($$); } <str>
> -%type <num> expr if_expr
> +%type <ids> expr if_expr
> +%destructor { ids__free($$.ids); } <ids>
>  
>  %{
>  static void expr_error(double *final_val __maybe_unused,
>  		       struct expr_parse_ctx *ctx __maybe_unused,
> +		       bool compute_ids __maybe_unused,
>  		       void *scanner,
>  		       const char *s)
>  {
>  	pr_debug("%s\n", s);
>  }
>  
> +/*
> + * During compute ids, the special "bottom" value uses NAN to represent the set
> + * of all values. NAN is selected as it isn't a useful constant value.
> + */
> +#define BOTTOM NAN
> +
> +static struct ids union_expr(struct ids ids1, struct ids ids2)
> +{
> +	struct ids result = {
> +		.val = BOTTOM,
> +		.ids = ids__union(ids1.ids, ids2.ids),

should we check for error in here?

jirka

> +	};
> +	return result;
> +}
> +
>  #define BINARY_LONG_OP(RESULT, OP, LHS, RHS)				\
> -	RESULT = (long)LHS OP (long)RHS;
> +	if (!compute_ids) {						\
> +		RESULT.val = (long)LHS.val OP (long)RHS.val;		\
> +		RESULT.ids = NULL;					\
> +	} else {							\
> +	        RESULT = union_expr(LHS, RHS);				\
> +	}
>  
>  #define BINARY_OP(RESULT, OP, LHS, RHS)					\
> -	RESULT = LHS OP RHS;
> +	if (!compute_ids) {						\
> +		RESULT.val = LHS.val OP RHS.val;			\
> +		RESULT.ids = NULL;					\
> +	} else {							\
> +	        RESULT = union_expr(LHS, RHS);				\
> +	}
>  
>  %}
>  %%
>  
> -start:
> -EXPR_PARSE all_expr
> -|
> -EXPR_OTHER all_other
> -
> -all_other: all_other other
> -|
> -
> -other: ID
> +start: if_expr
>  {
> -	expr__add_id(ctx, $1);
> -}
> -|
> -MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
> -|
> -'<' | '>' | D_RATIO
> +	if (compute_ids)
> +		ctx->ids = ids__union($1.ids, ctx->ids);
>  
> -all_expr: if_expr			{ *final_val = $1; }
> +	if (final_val)
> +		*final_val = $1.val;
> +}
> +;
>  
>  if_expr: expr IF expr ELSE expr
>  {
> -	$$ = $3 ? $1 : $5;
> +	if (!compute_ids) {
> +		$$.ids = NULL;
> +		if (fpclassify($3.val) == FP_ZERO) {
> +			$$.val = $5.val;
> +		} else {
> +			$$.val = $1.val;
> +		}
> +	} else {
> +		$$ = union_expr($1, union_expr($3, $5));
> +	}
>  }
>  | expr
>  ;
>  
>  expr: NUMBER
>  {
> -	$$ = $1;
> +	$$.val = $1;
> +	$$.ids = NULL;
>  }
>  | ID
>  {
> -	struct expr_id_data *data;
> -
> -	$$ = NAN;
> -	if (expr__resolve_id(ctx, $1, &data) == 0)
> -		$$ = expr_id_data__value(data);
> -
> -	free($1);
> +	if (!compute_ids) {
> +		/*
> +		 * Compute the event's value from ID. If the ID isn't known then
> +		 * it isn't used to compute the formula so set to NAN.
> +		 */
> +		struct expr_id_data *data;
> +
> +		$$.val = NAN;
> +		if (expr__resolve_id(ctx, $1, &data) == 0)
> +			$$.val = expr_id_data__value(data);
> +
> +		$$.ids = NULL;
> +		free($1);
> +	} else {
> +		/*
> +		 * Set the value to BOTTOM to show that any value is possible
> +		 * when the event is computed. Create a set of just the ID.
> +		 */
> +		$$.val = BOTTOM;
> +		$$.ids = ids__new();
> +		if (!$$.ids || ids__insert($$.ids, $1, ctx->parent))
> +			YYABORT;
> +	}
>  }
>  | expr '|' expr { BINARY_LONG_OP($$, |, $1, $3); }
>  | expr '&' expr { BINARY_LONG_OP($$, &, $1, $3); }
> @@ -102,31 +163,47 @@ expr: NUMBER
>  | expr '*' expr { BINARY_OP($$, *, $1, $3); }
>  | expr '/' expr
>  {
> -	if ($3 == 0) {
> -		pr_debug("division by zero\n");
> -		YYABORT;
> +	if (!compute_ids) {
> +		if (fpclassify($3.val) == FP_ZERO) {
> +			pr_debug("division by zero\n");
> +			YYABORT;
> +		}
> +		$$.val = $1.val / $3.val;
> +		$$.ids = NULL;
> +	} else {
> +		$$ = union_expr($1, $3);
>  	}
> -	$$ = $1 / $3;
>  }
>  | expr '%' expr
>  {
> -	if ((long)$3 == 0) {
> -		pr_debug("division by zero\n");
> -		YYABORT;
> +	if (!compute_ids) {
> +		if (fpclassify($3.val) == FP_ZERO) {
> +			pr_debug("division by zero\n");
> +			YYABORT;
> +		}
> +		$$.val = (long)$1.val % (long)$3.val;
> +		$$.ids = NULL;
> +	} else {
> +		$$ = union_expr($1, $3);
>  	}
> -	$$ = (long)$1 % (long)$3;
>  }
>  | D_RATIO '(' expr ',' expr ')'
>  {
> -	if ($5 == 0) {
> -		$$ = 0;
> +	if (!compute_ids) {
> +		$$.ids = NULL;
> +		if (fpclassify($5.val) == FP_ZERO) {
> +			$$.val = 0.0;
> +		} else {
> +			$$.val = $3.val / $5.val;
> +		}
>  	} else {
> -		$$ = $3 / $5;
> +		$$ = union_expr($3, $5);
>  	}
>  }
>  | '-' expr %prec NEG
>  {
> -	$$ = -$2;
> +	$$.val = -$2.val;
> +	$$.ids = $2.ids;
>  }
>  | '(' if_expr ')'
>  {
> @@ -134,15 +211,26 @@ expr: NUMBER
>  }
>  | MIN '(' expr ',' expr ')'
>  {
> -	$$ = $3 < $5 ? $3 : $5;
> +	if (!compute_ids) {
> +		$$.val = $3.val < $5.val ? $3.val : $5.val;
> +		$$.ids = NULL;
> +	} else {
> +		$$ = union_expr($3, $5);
> +	}
>  }
>  | MAX '(' expr ',' expr ')'
>  {
> -	$$ = $3 > $5 ? $3 : $5;
> +	if (!compute_ids) {
> +		$$.val = $3.val > $5.val ? $3.val : $5.val;
> +		$$.ids = NULL;
> +	} else {
> +		$$ = union_expr($3, $5);
> +	}
>  }
>  | SMT_ON
>  {
> -	$$ = smt_on() > 0 ? 1.0 : 0.0;
> +	$$.val = smt_on() > 0 ? 1.0 : 0.0;
> +	$$.ids = NULL;
>  }
>  ;
>  
> -- 
> 2.33.0.464.g1972c5931b-goog
> 

