Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6602FC433DB
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Feb 2021 18:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08D9B64E63
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Feb 2021 18:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbhBQS0Z (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 Feb 2021 13:26:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:33206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231562AbhBQS0Y (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 Feb 2021 13:26:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BC9164E5F;
        Wed, 17 Feb 2021 18:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613586343;
        bh=+fVkBu800M04O2PuUDftIhfqw4KoBuaiI9SLennii9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A2N8WcYs1ES5YIl2d2xGUxnuyo8B4PyjagwJ+qV4fwmbHmqwVduYv9EpjgO8pHag/
         F1bhc0Xny6Qb7XGTFAUCUOILsTkN2bNBQPReaBbwd+nWNBeZcY2uyoN491aqdyQ5T6
         zmgwDAS925yQ88FvuQAi0gqrMXIiHVbejX+tWfwCifppshlu/xmTMS9/iJpuKlIqs8
         N+Q9bIzRFQhzS1XvBD4OG9J3o7PSQrxGoTnkePC0xwzUjwQzlYf8uUN5WE2il7lPDY
         Bo7jv80CG2mxmtpFJN8JiuBqYKvhSZAtc5UwD9JXySCzad79htdxAU/IQJfhfEAydd
         yn8oiOzmg6L7A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 54DA040CD9; Wed, 17 Feb 2021 15:25:40 -0300 (-03)
Date:   Wed, 17 Feb 2021 15:25:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf annotate: do not jump after 'k' is pressed
Message-ID: <YC1fpJIJFFfrNLUI@kernel.org>
References: <65416cff-4eb6-713c-a174-2aa43fa64332@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65416cff-4eb6-713c-a174-2aa43fa64332@suse.cz>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Feb 15, 2021 at 01:45:25PM +0100, Martin Liška escreveu:
> Do not jump when 'k' is pressed, the cursor show stay where it is.
> Right now, it jumps to the currently selected hot instruction.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Martin Liška <mliska@suse.cz>
> ---
>  tools/perf/ui/browsers/annotate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index bd77825fd5a1..35b82caf8090 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -759,7 +759,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
>  			continue;
>  		case 'k':
>  			notes->options->show_linenr = !notes->options->show_linenr;
> -			break;
> +			continue;
>  		case 'H':
>  			nd = browser->curr_hot;
>  			break;
> -- 
> 2.30.0
> 

-- 

- Arnaldo
