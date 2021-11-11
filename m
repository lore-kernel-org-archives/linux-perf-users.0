Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CC7C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 08:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 449EE611AD
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 08:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhKKIYP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 03:24:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24571 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229543AbhKKIYO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 03:24:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636618885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+/JqLm4sHmyADiAMedFlu1K2pl2+HxqUB8mfzcH1h3s=;
        b=enbGkrX7kVme1PBBygsjCFjP7oKHP3Ngy4wTKHds6b2PyQEHzuhT4kKFUMvKJZ93XkEhyN
        uan5YrBD+AIJWIiMhmldZUttCdueObQP347a8VQZSlHuPvQkVcMfk2x7kxsdlfFGTdk+vd
        PDp6H58keqXCpVwtV3JynKmBPPbXObM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-MdpKl3pnM6qmU3hhoYIpGA-1; Thu, 11 Nov 2021 03:21:24 -0500
X-MC-Unique: MdpKl3pnM6qmU3hhoYIpGA-1
Received: by mail-wm1-f70.google.com with SMTP id b145-20020a1c8097000000b003335872db8dso1729771wmd.2
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Nov 2021 00:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+/JqLm4sHmyADiAMedFlu1K2pl2+HxqUB8mfzcH1h3s=;
        b=up/ilxwC9R7l8nQFSdkmNvpcJVMsPJlaXh27remptIv+U2tjl5Y3plDewom8TGUOLK
         +T4KpwlkAJ2In7JVoxzoY0HRDA/ur7uq5y7f5g8W1kNCb+skCr6rGUESv7e1woGgqO9k
         2UAmJgeidhmDhY3VdzkJtbPX7BpoD7o23k9GzdnWO0Lw97Md//8/OciJktsKxhExqrqQ
         3xAlLpf/HEinVHmfeBsiOY5uIkTlTDsxMa7PUQhQcLESv9CSXqBCkq0edxOTb3a+M9jq
         aTLDhbBEGulxGDJHiBujwx80Q6d/LRkL4WvUGGBNglx69LF5ay5v/aVmFrgHafPN8PJr
         aTqg==
X-Gm-Message-State: AOAM532SmqjmamPUWY3CiYSZHAqiJWdrRncTy9ktnyZv7EgdoeYGVgbM
        nzNTaQhjtngd9POasU9WuazWwhh6Q0QjAEkjdFfKikYERpKmj580G273cbCi34wdYsb6uzFnX0U
        5ycfbT3QosGTYCEcSF0gGdp23s8Eeiw==
X-Received: by 2002:adf:fed0:: with SMTP id q16mr6864973wrs.276.1636618883184;
        Thu, 11 Nov 2021 00:21:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzr1+n5lleP+gDrb4clqydaA2qxolVzJBakG37gHdguwLq8vV99rMRLrAQRXCvojPmI/0wUwQ==
X-Received: by 2002:adf:fed0:: with SMTP id q16mr6864940wrs.276.1636618882952;
        Thu, 11 Nov 2021 00:21:22 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id n7sm2129819wra.37.2021.11.11.00.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 00:21:22 -0800 (PST)
Date:   Thu, 11 Nov 2021 09:21:20 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Song Liu <song@kernel.org>, Wan Jiabing <wanjiabing@vivo.com>,
        Yury Norov <yury.norov@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] perf expr: Move ID handling to its own function
Message-ID: <YYzSgNNWDkymfYi5@krava>
References: <20211111002109.194172-1-irogers@google.com>
 <20211111002109.194172-8-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111002109.194172-8-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Nov 10, 2021 at 04:21:08PM -0800, Ian Rogers wrote:
> This will facilitate sharing in a follow-on change.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/expr.y | 60 ++++++++++++++++++++++++------------------
>  1 file changed, 34 insertions(+), 26 deletions(-)
> 
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index ba6c6dbf30c8..d90addf9b937 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -3,6 +3,7 @@
>  #define YYDEBUG 1
>  #include <assert.h>
>  #include <math.h>
> +#include <stdlib.h>
>  #include "util/debug.h"
>  #define IN_EXPR_Y 1
>  #include "expr.h"
> @@ -82,6 +83,38 @@ static struct ids union_expr(struct ids ids1, struct ids ids2)
>  	return result;
>  }
>  
> +static struct ids handle_id(struct expr_parse_ctx *ctx, char *id,
> +			    bool compute_ids)
> +{
> +	struct ids result;

nit, missing extra line in here

other than that for the whole patchset:

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> +	if (!compute_ids) {
> +		/*
> +		 * Compute the event's value from ID. If the ID isn't known then
> +		 * it isn't used to compute the formula so set to NAN.
> +		 */
> +		struct expr_id_data *data;
> +
> +		result.val = NAN;
> +		if (expr__resolve_id(ctx, id, &data) == 0)
> +			result.val = expr_id_data__value(data);
> +
> +		result.ids = NULL;
> +		free(id);
> +	} else {
> +		/*
> +		 * Set the value to BOTTOM to show that any value is possible
> +		 * when the event is computed. Create a set of just the ID.
> +		 */
> +		result.val = BOTTOM;
> +		result.ids = ids__new();
> +		if (!result.ids || ids__insert(result.ids, id)) {
> +			pr_err("Error creating IDs for '%s'", id);
> +			free(id);
> +		}
> +	}
> +	return result;
> +}
> +
>  /*
>   * If we're not computing ids or $1 and $3 are constants, compute the new
>   * constant value using OP. Its invariant that there are no ids.  If computing
> @@ -167,32 +200,7 @@ expr: NUMBER
>  	$$.val = $1;
>  	$$.ids = NULL;
>  }
> -| ID
> -{
> -	if (!compute_ids) {
> -		/*
> -		 * Compute the event's value from ID. If the ID isn't known then
> -		 * it isn't used to compute the formula so set to NAN.
> -		 */
> -		struct expr_id_data *data;
> -
> -		$$.val = NAN;
> -		if (expr__resolve_id(ctx, $1, &data) == 0)
> -			$$.val = expr_id_data__value(data);
> -
> -		$$.ids = NULL;
> -		free($1);
> -	} else {
> -		/*
> -		 * Set the value to BOTTOM to show that any value is possible
> -		 * when the event is computed. Create a set of just the ID.
> -		 */
> -		$$.val = BOTTOM;
> -		$$.ids = ids__new();
> -		if (!$$.ids || ids__insert($$.ids, $1))
> -			YYABORT;
> -	}
> -}
> +| ID		{ $$ = handle_id(ctx, $1, compute_ids); }
>  | expr '|' expr { BINARY_LONG_OP($$, |, $1, $3); }
>  | expr '&' expr { BINARY_LONG_OP($$, &, $1, $3); }
>  | expr '^' expr { BINARY_LONG_OP($$, ^, $1, $3); }
> -- 
> 2.34.0.rc1.387.gb447b232ab-goog
> 

