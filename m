Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD880C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 20:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CDEA61168
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 20:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237839AbhIVVAX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 17:00:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40667 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237786AbhIVVAX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 17:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632344332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hws5eDqR+f2bTbX+cn5+y2+RLzs8dFQl3RKjAF5zxFE=;
        b=UIt5MCVPJAmAdBwpbypUkD8nAdYWmecQhCV4oLid+Brwszg0ykoIEBy7+tnss5vdXYqVYH
        kex+zHK/mJFNlCMSLFoUAaNcEW9Qwoak7lgZh1LvIfxWpLlRfJn+OBLNbTHuaiQ+8W6zFz
        FOLQFSZCJeQ550R8asUecjl5LW8jj6E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-cZK0KnDBMiOB4Ti7TBTReQ-1; Wed, 22 Sep 2021 16:58:51 -0400
X-MC-Unique: cZK0KnDBMiOB4Ti7TBTReQ-1
Received: by mail-wr1-f69.google.com with SMTP id x7-20020a5d6507000000b0015dada209b1so3264103wru.15
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Sep 2021 13:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hws5eDqR+f2bTbX+cn5+y2+RLzs8dFQl3RKjAF5zxFE=;
        b=Ij8vafW42AdgMh1X6aMliiJuS+VImlKvLQT+F1HjwjMCXM19OWouxaGbA2XesTEdnE
         mqpmatZc+UgldCJCKoPFlAPNwFtbHNL7BU5SQYnTm3TojD0NHG5O0PBYOeiIDoAQpa8f
         /Xx+suuh/w1ebdNY9afp7GSG5gWfNPR8/UbB7XPY7xEnaTnKDz37ql8OvePTJwqWYntm
         m4iyVS9I+/cmZMyqh+Sjn7iXoWVpGKMQBoi3cDG8yCj2NZ/okShjf0om0qxK8w4823CD
         o4I2chsk8fWStLqU0kOJ9X60IvcQFj34rFDGIleIv1TOuXTbrENppoFdEUmSH3JPwAie
         tEDA==
X-Gm-Message-State: AOAM5317TuI1ZCGZhDglysfLN2UO74Yn6gsHu6/Tp3sfeUl9LKXFH/94
        wEis6JYNJZ5IOIkErjKB2tCgTS7LAm/A5lINoPWgJ+UHK9bSeoisQ3dJmJnf7D5YdkspJHG6Cwz
        wL86XK+e2yvlV0219i2jKVKqYzv2RGA==
X-Received: by 2002:adf:ded1:: with SMTP id i17mr1079664wrn.83.1632344330224;
        Wed, 22 Sep 2021 13:58:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzX0qj99H3uabhF3988CIOB5pZ+vp3ItuvU1Q6aMmQV0NnazNCvW6h4PM/2iXwod18nE3Stqw==
X-Received: by 2002:adf:ded1:: with SMTP id i17mr1079646wrn.83.1632344330023;
        Wed, 22 Sep 2021 13:58:50 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id c185sm3320676wma.8.2021.09.22.13.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:58:49 -0700 (PDT)
Date:   Wed, 22 Sep 2021 22:58:47 +0200
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
Subject: Re: [PATCH v8 3/8] perf expr: Modify code layout
Message-ID: <YUuZBwiW/0M7yosQ@krava>
References: <20210918063513.2356923-1-irogers@google.com>
 <20210918063513.2356923-4-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918063513.2356923-4-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Sep 17, 2021 at 11:35:08PM -0700, Ian Rogers wrote:
> No functional change. Alter whitespace. Use helper macros that will be
> made more complex in a later change.

please split into more patches, with the spacing changes
it's not easy to check there's no functional change

thanks,
jirka

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/expr.y | 149 +++++++++++++++++++++++------------------
>  1 file changed, 85 insertions(+), 64 deletions(-)
> 
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index 41c9cd4efadd..51f4f0aa1955 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -2,23 +2,10 @@
>  %{
>  #define YYDEBUG 1
>  #include <math.h>
> -#include <stdio.h>
> -#include "util.h"
>  #include "util/debug.h"
> -#include <stdlib.h> // strtod()
> +#include "smt.h"
>  #define IN_EXPR_Y 1
>  #include "expr.h"
> -#include "smt.h"
> -#include <string.h>
> -
> -static double d_ratio(double val0, double val1)
> -{
> -	if (val1 == 0) {
> -		return 0;
> -	}
> -	return  val0 / val1;
> -}
> -
>  %}
>  
>  %define api.pure full
> @@ -33,11 +20,7 @@ static double d_ratio(double val0, double val1)
>  	char	*str;
>  }
>  
> -%token EXPR_PARSE EXPR_OTHER EXPR_ERROR
> -%token <num> NUMBER
> -%token <str> ID
> -%destructor { free ($$); } <str>
> -%token MIN MAX IF ELSE SMT_ON D_RATIO
> +%token ID NUMBER MIN MAX IF ELSE SMT_ON D_RATIO EXPR_ERROR EXPR_PARSE EXPR_OTHER
>  %left MIN MAX IF
>  %left '|'
>  %left '^'
> @@ -46,6 +29,9 @@ static double d_ratio(double val0, double val1)
>  %left '-' '+'
>  %left '*' '/' '%'
>  %left NEG NOT
> +%type <num> NUMBER
> +%type <str> ID
> +%destructor { free ($$); } <str>
>  %type <num> expr if_expr
>  
>  %{
> @@ -57,6 +43,12 @@ static void expr_error(double *final_val __maybe_unused,
>  	pr_debug("%s\n", s);
>  }
>  
> +#define BINARY_LONG_OP(RESULT, OP, LHS, RHS)				\
> +	RESULT = (long)LHS OP (long)RHS;
> +
> +#define BINARY_OP(RESULT, OP, LHS, RHS)					\
> +	RESULT = LHS OP RHS;
> +
>  %}
>  %%
>  
> @@ -78,49 +70,78 @@ MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/
>  '<' | '>' | D_RATIO
>  
>  all_expr: if_expr			{ *final_val = $1; }
> -	;
> -
> -if_expr:
> -	expr IF expr ELSE expr { $$ = $3 ? $1 : $5; }
> -	| expr
> -	;
> -
> -expr:	  NUMBER
> -	| ID			{
> -					struct expr_id_data *data;
> -
> -					$$ = NAN;
> -					if (expr__resolve_id(ctx, $1, &data) == 0)
> -						$$ = expr_id_data__value(data);
> -
> -					free($1);
> -				}
> -	| expr '|' expr		{ $$ = (long)$1 | (long)$3; }
> -	| expr '&' expr		{ $$ = (long)$1 & (long)$3; }
> -	| expr '^' expr		{ $$ = (long)$1 ^ (long)$3; }
> -	| expr '<' expr		{ $$ = $1 < $3; }
> -	| expr '>' expr		{ $$ = $1 > $3; }
> -	| expr '+' expr		{ $$ = $1 + $3; }
> -	| expr '-' expr		{ $$ = $1 - $3; }
> -	| expr '*' expr		{ $$ = $1 * $3; }
> -	| expr '/' expr		{ if ($3 == 0) {
> -					pr_debug("division by zero\n");
> -					YYABORT;
> -				  }
> -				  $$ = $1 / $3;
> -	                        }
> -	| expr '%' expr		{ if ((long)$3 == 0) {
> -					pr_debug("division by zero\n");
> -					YYABORT;
> -				  }
> -				  $$ = (long)$1 % (long)$3;
> -	                        }
> -	| '-' expr %prec NEG	{ $$ = -$2; }
> -	| '(' if_expr ')'	{ $$ = $2; }
> -	| MIN '(' expr ',' expr ')' { $$ = $3 < $5 ? $3 : $5; }
> -	| MAX '(' expr ',' expr ')' { $$ = $3 > $5 ? $3 : $5; }
> -	| SMT_ON		 { $$ = smt_on() > 0; }
> -	| D_RATIO '(' expr ',' expr ')' { $$ = d_ratio($3,$5); }
> -	;
>  
> -%%
> +if_expr: expr IF expr ELSE expr
> +{
> +	$$ = $3 ? $1 : $5;
> +}
> +| expr
> +;
> +
> +expr: NUMBER
> +{
> +	$$ = $1;
> +}
> +| ID
> +{
> +	struct expr_id_data *data;
> +
> +	$$ = NAN;
> +	if (expr__resolve_id(ctx, $1, &data) == 0)
> +		$$ = expr_id_data__value(data);
> +
> +	free($1);
> +}
> +| expr '|' expr { BINARY_LONG_OP($$, |, $1, $3); }
> +| expr '&' expr { BINARY_LONG_OP($$, &, $1, $3); }
> +| expr '^' expr { BINARY_LONG_OP($$, ^, $1, $3); }
> +| expr '<' expr { BINARY_OP($$, <, $1, $3); }
> +| expr '>' expr { BINARY_OP($$, >, $1, $3); }
> +| expr '+' expr { BINARY_OP($$, +, $1, $3); }
> +| expr '-' expr { BINARY_OP($$, -, $1, $3); }
> +| expr '*' expr { BINARY_OP($$, *, $1, $3); }
> +| expr '/' expr
> +{
> +	if ($3 == 0) {
> +		pr_debug("division by zero\n");
> +		YYABORT;
> +	}
> +	$$ = $1 / $3;
> +}
> +| expr '%' expr
> +{
> +	if ((long)$3 == 0) {
> +		pr_debug("division by zero\n");
> +		YYABORT;
> +	}
> +	$$ = (long)$1 % (long)$3;
> +}
> +| D_RATIO '(' expr ',' expr ')'
> +{
> +	if ($5 == 0) {
> +		$$ = 0;
> +	} else {
> +		$$ = $3 / $5;
> +	}
> +}
> +| '-' expr %prec NEG
> +{
> +	$$ = -$2;
> +}
> +| '(' if_expr ')'
> +{
> +	$$ = $2;
> +}
> +| MIN '(' expr ',' expr ')'
> +{
> +	$$ = $3 < $5 ? $3 : $5;
> +}
> +| MAX '(' expr ',' expr ')'
> +{
> +	$$ = $3 > $5 ? $3 : $5;
> +}
> +| SMT_ON
> +{
> +	$$ = smt_on() > 0 ? 1.0 : 0.0;
> +}
> +;
> -- 
> 2.33.0.464.g1972c5931b-goog
> 

