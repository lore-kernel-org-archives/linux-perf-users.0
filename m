Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79811C63777
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Nov 2020 21:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 074F72224A
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Nov 2020 20:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhQTndSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgKSU7d (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 Nov 2020 15:59:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32962 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725877AbgKSU7b (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 Nov 2020 15:59:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605819570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mQDn227FOLYTj1NnWVddaoSoMMFQi8p5BGQiUaGgnMQ=;
        b=RhQTndSBlw3NO9kv9w678bFspthJwRf+hW6oAXIVIN5UVavtOvY93A+R6zLu/QFc5ACFkV
        d5vAL9sMN+ed4wPZf4KTgU/66Oiif0K5Wh8980htpSrNsQvoH/DHCCq6AzWWHr9lrYZK63
        WdG+K2YpWAEu2BhxQyFj9BLGjVnbVuI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-C_BBrDslO5m6cmcfDl4vTQ-1; Thu, 19 Nov 2020 15:59:26 -0500
X-MC-Unique: C_BBrDslO5m6cmcfDl4vTQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 579B7801B14;
        Thu, 19 Nov 2020 20:59:24 +0000 (UTC)
Received: from krava (unknown [10.40.192.83])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0186F60BE2;
        Thu, 19 Nov 2020 20:59:20 +0000 (UTC)
Date:   Thu, 19 Nov 2020 21:59:20 +0100
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
        Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 5/5] perf metric: Don't compute unused events.
Message-ID: <20201119205920.GM1475102@krava>
References: <20201118050335.2347358-1-irogers@google.com>
 <20201118050335.2347358-6-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118050335.2347358-6-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Nov 17, 2020 at 09:03:35PM -0800, Ian Rogers wrote:

SNIP

> +			ids__free($1.ids);
> +			ids__free($3.ids);
> +		}
> +	} else {
> +		$$.val = NAN;
> +		$$.ids = ids__union($1.ids, $3.ids);
> +	}
> +}
> +| expr '*' expr
> +{
> +	if (!compute_ids || (isfinite($1.val) && isfinite($3.val))) {
> +		$$.val = $1.val * $3.val;
> +		$$.ids = NULL;
> +		if (compute_ids) {
> +			ids__free($1.ids);
> +			ids__free($3.ids);
> +		}
> +	} else {
> +		$$.val = NAN;
> +		$$.ids = ids__union($1.ids, $3.ids);
> +	}
> +}
> +| expr '/' expr
> +{
> +	if (fpclassify($3.val) == FP_ZERO) {
> +		pr_debug("division by zero\n");
> +		YYABORT;
> +	} else if (!compute_ids || (isfinite($1.val) && isfinite($3.val))) {
> +		$$.val = $1.val / $3.val;
> +		$$.ids = NULL;

hum, I'm confused with this.. compute_ids with finite values?
why do we erase ids then? also val should be NAN then, no?
could you please put in some comment with reasoning?

thanks,
jirka

