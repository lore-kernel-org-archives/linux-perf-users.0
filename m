Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D714C432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 18:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0314C61008
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 18:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhHaSpy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 14:45:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229483AbhHaSpv (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 14:45:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95D2D60FF2;
        Tue, 31 Aug 2021 18:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630435495;
        bh=IWw13YnK9rW1CKWgDL11yNR61oOp+iBIT8indqr3iGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bpk668iWJmNVqL5ZBx+tRbvzuKrwQ4OoASsSwqNTDThTxEYQ1+CKxW7pcCjiUyx3g
         +vDU+Z6pfmNrNV3yt9yOdCrW1BO5GtyU/5qYemUP+XE5d+lmzhMQFoOk6Eclv0FgXg
         kl+c6oadqi3XRfKGojpBYgP8bGLljNGwnmLWDCXSa7WswmBMlKqG9Yur8lGpS7vB6S
         b2IdR4rsOyUtLnw3cEQ8pic0dCF7lj1sjMji8RrqhzSGTwABRUPXQR0Mu7cS+X0ivT
         zxXqSmHKT39hddwGqHb631iWlC8/Upy9xCIvXjuUh7soJ04BFoi3JpzHiFjKPXMxBy
         qnovK6eHeKG4w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A4C7A4007E; Tue, 31 Aug 2021 15:44:52 -0300 (-03)
Date:   Tue, 31 Aug 2021 15:44:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v1 31/37] tools lib/subcmd: add OPT_UINTEGER_OPTARG
 option type
Message-ID: <YS54pArzp3mKKZzM@kernel.org>
References: <cover.1629490974.git.rickyman7@gmail.com>
 <c46749b3dff796729078352ff164d363457a3587.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c46749b3dff796729078352ff164d363457a3587.1629490974.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Aug 21, 2021 at 11:19:37AM +0200, Riccardo Mancini escreveu:
> This patch adds OPT_UINTEGER_OPTARG, which is the same as OPT_UINTEGER,
> but also makes it possible to use the option without any value, setting
> the variable to a default value, d.

Thanks, applied, just to erode a bit the patch kit.

- Arnaldo

 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/lib/subcmd/parse-options.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/lib/subcmd/parse-options.h b/tools/lib/subcmd/parse-options.h
> index d2414144eb8c9927..41b9b942504d398e 100644
> --- a/tools/lib/subcmd/parse-options.h
> +++ b/tools/lib/subcmd/parse-options.h
> @@ -133,6 +133,7 @@ struct option {
>  #define OPT_SET_PTR(s, l, v, h, p)  { .type = OPTION_SET_PTR, .short_name = (s), .long_name = (l), .value = (v), .help = (h), .defval = (p) }
>  #define OPT_INTEGER(s, l, v, h)     { .type = OPTION_INTEGER, .short_name = (s), .long_name = (l), .value = check_vtype(v, int *), .help = (h) }
>  #define OPT_UINTEGER(s, l, v, h)    { .type = OPTION_UINTEGER, .short_name = (s), .long_name = (l), .value = check_vtype(v, unsigned int *), .help = (h) }
> +#define OPT_UINTEGER_OPTARG(s, l, v, d, h)    { .type = OPTION_UINTEGER, .short_name = (s), .long_name = (l), .value = check_vtype(v, unsigned int *), .help = (h), .flags = PARSE_OPT_OPTARG, .defval = (intptr_t)(d) }
>  #define OPT_LONG(s, l, v, h)        { .type = OPTION_LONG, .short_name = (s), .long_name = (l), .value = check_vtype(v, long *), .help = (h) }
>  #define OPT_ULONG(s, l, v, h)        { .type = OPTION_ULONG, .short_name = (s), .long_name = (l), .value = check_vtype(v, unsigned long *), .help = (h) }
>  #define OPT_U64(s, l, v, h)         { .type = OPTION_U64, .short_name = (s), .long_name = (l), .value = check_vtype(v, u64 *), .help = (h) }
> -- 
> 2.31.1

-- 
