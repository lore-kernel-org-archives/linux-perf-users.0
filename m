Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83969C4742C
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Nov 2020 23:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F9722258
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Nov 2020 23:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgKMXea (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 13 Nov 2020 18:34:30 -0500
Received: from mga09.intel.com ([134.134.136.24]:44689 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgKMXea (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 Nov 2020 18:34:30 -0500
IronPort-SDR: 1//bveH8+fBGIX8kKf2nRGUGjIG4EXreFCfFBuyEgslsTwQ+vYFf3/WxvVUAR5unLYr1wWQWsD
 vEVAlHWl2+Jw==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="170716667"
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="170716667"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 15:34:24 -0800
IronPort-SDR: fa3kPOnzQAgpAoEortaPsAhrXIvRuAfgH62hMjKJpNE/meWsHqhaxcRRkRL4uywqoW3g85k0Tu
 RnIM5iw4nJJw==
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="542842902"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 15:34:17 -0800
Date:   Fri, 13 Nov 2020 15:34:15 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 5/5] perf metric: Don't compute unused events.
Message-ID: <20201113233415.GJ894261@tassilo.jf.intel.com>
References: <20201113001651.544348-1-irogers@google.com>
 <20201113001651.544348-6-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113001651.544348-6-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The patch does a lot of stuff and is hard to review.

The earlier patches all look good to me.

>  
>  static int
>  __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
> -	      int start, int runtime)
> +	      bool compute_ids, int runtime)
>  {
>  	struct expr_scanner_ctx scanner_ctx = {
> -		.start_token = start,

Okay so why do we not need that anymore?

This should probably be a separate change.

I'm not sure about the NaN handling. Why can't you use some 
other value (perhaps 0 with some special case for division) 

After all the computed values of the dead branch shouldn't 
be used anyways, so I don't think we need the extra NaN 
ceremony everywhere.

The only thing that really matters is to track that the event
is not added and not resolved.

I think it would be a lot simpler if we changed the IF syntax.
The problem right now is that the condition is after the first
expression, so you can't use global state with an early reduction
to track if the if branch is dead or not.

If we used the C style cond ? a : b  it could be

cond { set flag } '?' expr  { reset flag } : expr { reset flag }

scanner checks flag and ignores the event if false

This would need changing the JSON files but that should be easy enough
with a script.

Or maybe at some point need to bite the bullet and build
an AST, but for now we probably can get away of not doing it.


-Andi
