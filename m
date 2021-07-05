Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B4EC07E99
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Jul 2021 17:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BDD961960
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Jul 2021 17:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhGERzc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 5 Jul 2021 13:55:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229686AbhGERzc (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Jul 2021 13:55:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1664761970;
        Mon,  5 Jul 2021 17:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625507575;
        bh=3Qw9ctfa0uruVJSlUOjdb6ZdmXLcGb6TQEPOpFwUcBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iIsNWmb2ouUN33cJ9ZUSApq38lv3x2uSPqvqt4/HOgy1SIPu57xB3TmcO2BAFk6QI
         F4tGE9owhuJOj70wHyUJ/CvS3vy7ZB6RCBBUird5LenQKIpYHVcqoOWxDl/ffxZeSW
         T8OIWRwvVm1qFkbLY9OOU6AqcTDW4149I2pOlcV6ddJnT1UdGqtxMX6EfWpviNU5pL
         kJVlhGWBbBpYtqFskvkylx+eqMw3fac8+oXRcqmVcL08JjSnDwKapXgel0rRYZi/aS
         dSJxI1+DjQD1Jz8i8HpPaZ/Rfwn0Qu+Ca7cJDcojmR67FAABVBEnEaGpCGGqvdCO8x
         XE2RUIJOa/TPg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 96ABC40B1A; Mon,  5 Jul 2021 14:52:52 -0300 (-03)
Date:   Mon, 5 Jul 2021 14:52:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Martin Liska <mliska@suse.cz>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf annotate: fix 's' on source line when disasm is
 empty
Message-ID: <YONG9IVtBWz6tE2d@kernel.org>
References: <20210705161524.72953-1-rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210705161524.72953-1-rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Jul 05, 2021 at 06:15:25PM +0200, Riccardo Mancini escreveu:
> If the disasm is empty, 's' should fail. Instead it seemingly works,
> hiding the empty lines and causing an assertion error on the next
> time annotate is called (from within perf report).
> The problem is caused by a buffer overflow, caused by a wrong
> exit condition in annotate_browser__find_next_asm_line, which checks
> browser->b.top instead of browser->b.entries.
> 
> This patch fixes the issue, making annotate_browser__toggle_source
> fail if the disasm is empty (nothing happens to the user).
> 
> Fixes: 6de249d66d2e

Next time please make the fixes be of this form:

Fixes: 6de249d66d2e7881 ("perf annotate: Allow 's' on source code lines")

⬢[acme@toolbox perf]$ git config core.abbrev 16
⬢[acme@toolbox perf]$ git config core.abbrev
16
⬢[acme@toolbox perf]$ head -2 ~/.gitconfig 
[core]
	abbrev = 16
⬢[acme@toolbox perf]$ 

Thanks, applied.

- Arnaldo

> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/ui/browsers/annotate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index f5509a958e38..5812a2214cc1 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -350,14 +350,14 @@ static struct annotation_line *annotate_browser__find_next_asm_line(
>  	struct annotation_line *it = al;
>  
>  	/* find next asm line */
> -	list_for_each_entry_continue(it, browser->b.top, node) {
> +	list_for_each_entry_continue(it, browser->b.entries, node) {
>  		if (it->idx_asm >= 0)
>  			return it;
>  	}
>  
>  	/* no asm line found forwards, try backwards */
>  	it = al;
> -	list_for_each_entry_continue_reverse(it, browser->b.top, node) {
> +	list_for_each_entry_continue_reverse(it, browser->b.entries, node) {
>  		if (it->idx_asm >= 0)
>  			return it;
>  	}
> -- 
> 2.23.0
> 

-- 

- Arnaldo
