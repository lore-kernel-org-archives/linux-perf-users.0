Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C134BC433F5
	for <linux-perf-users@archiver.kernel.org>; Sat, 11 Sep 2021 18:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 881DE611AD
	for <linux-perf-users@archiver.kernel.org>; Sat, 11 Sep 2021 18:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhIKSii (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 11 Sep 2021 14:38:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233411AbhIKSii (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 11 Sep 2021 14:38:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAEF26101D;
        Sat, 11 Sep 2021 18:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631385445;
        bh=JUWQT8jXHeh8jLJClq6TyJR4fQGGpG7+TwtAbHqofrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m1qKBeiao77uQINYlZ7dISjjjkySJjF6XRdOHhTTmmyZDR0OtlDhMMIXcIhV47h6u
         OPYnW37IipHwEQxO3Q/Cmn2yw3dnNCEKz5XHJSLUpv9/FT7QKyEIiQhz2aUYmvrbAQ
         GgZSdBVmxgvEEqCs0Jo3+I4VVMvenPgpLpr0qfrnl+5gW2iDvghKLjV0QR3SJsJmf9
         osewv7r4dJ99053rggqsMkDu2E/7/DN0mwM31JpjWTpnEZnRpspsw2s5XZ6UHgnLpO
         C6w/zpuM7fBKx0chY8+2CObUymTjMaRkbUNlkkiu6UyZUdG7gy6fKZIP6VplVNLNg+
         H6vvX5JgPnOeg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9927D4038F; Sat, 11 Sep 2021 15:37:20 -0300 (-03)
Date:   Sat, 11 Sep 2021 15:37:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] perf tools: Ignore Documentation dependency file
Message-ID: <YTz3YFXpJ0UT3R7z@kernel.org>
References: <20210910232249.739661-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910232249.739661-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Sep 10, 2021 at 04:22:49PM -0700, Ian Rogers escreveu:
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Fixes: a81df63a5df3 ("perf doc: Fix doc.dep")
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks for the patch, but you forgot to mention _why_ we should ignore
that file, I'll try to figure out.

- Arnaldo

> ---
>  tools/perf/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
> index e555e9729758..8e0163b7ef01 100644
> --- a/tools/perf/.gitignore
> +++ b/tools/perf/.gitignore
> @@ -39,3 +39,4 @@ pmu-events/jevents
>  feature/
>  fixdep
>  libtraceevent-dynamic-list
> +Documentation/doc.dep
> -- 
> 2.33.0.309.g3052b89438-goog

-- 

- Arnaldo
