Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449D4C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 13:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D69960F59
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 13:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbhKKNp1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 08:45:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:45764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhKKNp0 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 08:45:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00BBC60E54;
        Thu, 11 Nov 2021 13:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636638157;
        bh=xbyNbhfFZh8bf5Xgeyx/3szm9ZpS4wWq2zUv6um8UBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=biuEtUe+gPi56iq9wHF7RgRFWu4BU/vBK1gKB/1ZwmHYwz9AIa0bUwh4reMpD0iNQ
         VeDK19pcg7RW0wVrhrRIU71+lr0OC9bmE0VNEsbbjj7kpeug+GtY6hhS2rjObyv3hU
         2eU3UEV1eQnmQ5y+L/fpPgt5q+wzMUy/Wy9XL09uBHTGzYFMlLa70JL9J4HBgWSXHe
         /m/xGpRKPsXkwRyVYOITZmDfEcc6epqFyU4wy3d/bR735rxg/iTL/vX/WqkStjZ+ra
         4hl2kV2kIsA7VR6CfHUss6G7y0pnNHFTHvg3LeTS6xPpW0sXnDIYtbeTnB5/+y4v5I
         rgr3q3kpkD75Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 54344410A1; Thu, 11 Nov 2021 10:42:30 -0300 (-03)
Date:   Thu, 11 Nov 2021 10:42:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
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
Message-ID: <YY0dxuHTPTuQH+4B@kernel.org>
References: <20211111002109.194172-1-irogers@google.com>
 <20211111002109.194172-8-irogers@google.com>
 <YYzSgNNWDkymfYi5@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYzSgNNWDkymfYi5@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Nov 11, 2021 at 09:21:20AM +0100, Jiri Olsa escreveu:
> On Wed, Nov 10, 2021 at 04:21:08PM -0800, Ian Rogers wrote:
> > This will facilitate sharing in a follow-on change.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/expr.y | 60 ++++++++++++++++++++++++------------------
> >  1 file changed, 34 insertions(+), 26 deletions(-)
> > 
> > diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> > index ba6c6dbf30c8..d90addf9b937 100644
> > --- a/tools/perf/util/expr.y
> > +++ b/tools/perf/util/expr.y
> > @@ -3,6 +3,7 @@
> >  #define YYDEBUG 1
> >  #include <assert.h>
> >  #include <math.h>
> > +#include <stdlib.h>
> >  #include "util/debug.h"
> >  #define IN_EXPR_Y 1
> >  #include "expr.h"
> > @@ -82,6 +83,38 @@ static struct ids union_expr(struct ids ids1, struct ids ids2)
> >  	return result;
> >  }
> >  
> > +static struct ids handle_id(struct expr_parse_ctx *ctx, char *id,
> > +			    bool compute_ids)
> > +{
> > +	struct ids result;
> 
> nit, missing extra line in here
> 
> other than that for the whole patchset:
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

I'll fix that
 
> thanks,
> jirka
> 
> > +	if (!compute_ids) {
> > +		/*
> > +		 * Compute the event's value from ID. If the ID isn't known then
> > +		 * it isn't used to compute the formula so set to NAN.
> > +		 */
> > +		struct expr_id_data *data;
> > +
> > +		result.val = NAN;
> > +		if (expr__resolve_id(ctx, id, &data) == 0)
> > +			result.val = expr_id_data__value(data);
> > +
> > +		result.ids = NULL;
> > +		free(id);
> > +	} else {
> > +		/*
> > +		 * Set the value to BOTTOM to show that any value is possible
> > +		 * when the event is computed. Create a set of just the ID.
> > +		 */
> > +		result.val = BOTTOM;
> > +		result.ids = ids__new();
> > +		if (!result.ids || ids__insert(result.ids, id)) {
> > +			pr_err("Error creating IDs for '%s'", id);
> > +			free(id);
> > +		}
> > +	}
> > +	return result;
> > +}
> > +
> >  /*
> >   * If we're not computing ids or $1 and $3 are constants, compute the new
> >   * constant value using OP. Its invariant that there are no ids.  If computing
> > @@ -167,32 +200,7 @@ expr: NUMBER
> >  	$$.val = $1;
> >  	$$.ids = NULL;
> >  }
> > -| ID
> > -{
> > -	if (!compute_ids) {
> > -		/*
> > -		 * Compute the event's value from ID. If the ID isn't known then
> > -		 * it isn't used to compute the formula so set to NAN.
> > -		 */
> > -		struct expr_id_data *data;
> > -
> > -		$$.val = NAN;
> > -		if (expr__resolve_id(ctx, $1, &data) == 0)
> > -			$$.val = expr_id_data__value(data);
> > -
> > -		$$.ids = NULL;
> > -		free($1);
> > -	} else {
> > -		/*
> > -		 * Set the value to BOTTOM to show that any value is possible
> > -		 * when the event is computed. Create a set of just the ID.
> > -		 */
> > -		$$.val = BOTTOM;
> > -		$$.ids = ids__new();
> > -		if (!$$.ids || ids__insert($$.ids, $1))
> > -			YYABORT;
> > -	}
> > -}
> > +| ID		{ $$ = handle_id(ctx, $1, compute_ids); }
> >  | expr '|' expr { BINARY_LONG_OP($$, |, $1, $3); }
> >  | expr '&' expr { BINARY_LONG_OP($$, &, $1, $3); }
> >  | expr '^' expr { BINARY_LONG_OP($$, ^, $1, $3); }
> > -- 
> > 2.34.0.rc1.387.gb447b232ab-goog
> > 

-- 

- Arnaldo
