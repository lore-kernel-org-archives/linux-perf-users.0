Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3912BC4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 14:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 101BF61106
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 14:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240681AbhHTOOT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 10:14:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235032AbhHTOOS (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Aug 2021 10:14:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91E4C610FF;
        Fri, 20 Aug 2021 14:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629468820;
        bh=nLRJd2BhPGg9x5pL4Sm4XdH/2597fudaoCp7mLsY0TY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fCrKTzf8Uuqw7spFPDmtpk/PXKoqRrk/tfMb0JspaII+WxB4lDECM0OwjfPmh9qty
         55W/OmUQs8cZbg/52TdDk8pd9uaJNC+nXT2+iSmMl57QFxZDW2AHDHohR+bGUhBUQj
         f9yIRokHTymxNeQQJrmEih6CsVpHrtwVH7Ygx1LGy1W+1dvlhvp5uwn8k7N2sO5wTa
         c+aoxU1pJCA+F5D1WpUZjMpohReAqs9kgH5AhF0/gx9A3j2JfxdwEIf1LmOzn5fWzX
         KIY566rVzXimtaXQzXFG+UHbSoR/qCkc9AkIM8ORsTDbdUv/rn/caWjWQbunMLR0Aw
         zgnrEud+bfzHA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 027754007E; Fri, 20 Aug 2021 11:13:36 -0300 (-03)
Date:   Fri, 20 Aug 2021 11:13:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>, Song Liu <song@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf config: fix caching and memory leak in
 perf_home_perfconfig
Message-ID: <YR+4kOwuIoPsz2Rw@kernel.org>
References: <20210820130817.740536-1-rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820130817.740536-1-rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Aug 20, 2021 at 03:08:17PM +0200, Riccardo Mancini escreveu:
> Acaict, perf_home_perfconfig is supposed to cache the result of
> home_perfconfig, which returns the default location of perfconfig for
> the user, given the HOME environment variable.
> However, the current implementation calls home_perfconfig every time
> perf_home_perfconfig is called (so no caching is actually performed),
> replacing the previous pointer, thus also causing a memory leak.
> 
> This patch adds a check of whether either config or failed is set and,
> in that case, directly returns config without calling home_perfconfig at
> each invocation.
> 
> Cc: Jiri Olsa <jolsa@kernel.org>
> Fixes: f5f03e19ce14fc31 ("perf config: Add perf_home_perfconfig function")
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/util/config.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index 63d472b336de21d4..6ab670cdf512507e 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
> @@ -581,6 +581,9 @@ const char *perf_home_perfconfig(void)
>  	static const char *config;
>  	static bool failed;
>  
> +	if (config || failed)
> +		return config;
> +
>  	config = failed ? NULL : home_perfconfig();

humm, why keep the above failed test then?

>  	if (!config)
>  		failed = true;

I.e. please check this:


diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 63d472b336de21d4..4fb5e90d7a57ae48 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -581,7 +581,10 @@ const char *perf_home_perfconfig(void)
 	static const char *config;
 	static bool failed;
 
-	config = failed ? NULL : home_perfconfig();
+	if (failed || config)
+		return config;
+
+	config = home_perfconfig();
 	if (!config)
 		failed = true;
 
