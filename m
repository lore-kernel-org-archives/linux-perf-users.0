Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964CAC001DF
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Aug 2023 12:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjHAMzM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Aug 2023 08:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjHAMzM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Aug 2023 08:55:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AFCE6
        for <linux-perf-users@vger.kernel.org>; Tue,  1 Aug 2023 05:55:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B68166158F
        for <linux-perf-users@vger.kernel.org>; Tue,  1 Aug 2023 12:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB33C433C8;
        Tue,  1 Aug 2023 12:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690894510;
        bh=2OboamuruQm9uoo48zh/bkp/pG8cFjXpkYustQ17vPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c9sB1a0CyggZ54PUS4hZc+WQPZBxYzgh94xi1diVnYk58d7RkjvbJV3usvzdk/Hjm
         7tryfHiosuURWcmzWpTRLTqsD74DdvEPbXU/0ZwYgIkWxdxztUU++7J1e2t2sgD/QW
         l/ui9SlGb8ynHpiSL8guZ4KKBVqg8+VFW6883peISftatn1qtbH7ttIf8cKKyqPQXC
         M8N6WVZU5xlJ7IB/iwSsvdaDT0hSjLcBgc4gDDTk6IYzzjO3Og2DO707V+wa84CkzQ
         LVcA7NQmRCkewrgHayuLvW35f+EfM0UPipCIKaJvma9JVDUu3f6e++nU+akX/Tr5iL
         1JX0y1urvIgLA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2714F40096; Tue,  1 Aug 2023 09:55:07 -0300 (-03)
Date:   Tue, 1 Aug 2023 09:55:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf probe: Show correct error about @symbol for uprobe
Message-ID: <ZMkAq5yx3+EiQNkF@kernel.org>
References: <169055397023.67089.12693645664676964310.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169055397023.67089.12693645664676964310.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Jul 28, 2023 at 11:19:30PM +0900, Masami Hiramatsu (Google) escreveu:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since @symbol variable access is not supported by uprobe event, it must be
> correctly warn user instead of kernel version update.

Thanks, less cryptic now, applied.

But is that just a matter of writing code to support reading global
variables from an uprobe?

- Arnaldo

 
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Closes: https://lore.kernel.org/all/ZLWDEjvFjrrEJODp@kernel.org/
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  tools/perf/util/probe-event.c |   13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 6e2110d605fb..c1ded85fe859 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -2800,13 +2800,18 @@ static void warn_uprobe_event_compat(struct probe_trace_event *tev)
>  	if (!tev->uprobes || tev->nargs == 0 || !buf)
>  		goto out;
>  
> -	for (i = 0; i < tev->nargs; i++)
> -		if (strglobmatch(tev->args[i].value, "[$@+-]*")) {
> -			pr_warning("Please upgrade your kernel to at least "
> -				   "3.14 to have access to feature %s\n",
> +	for (i = 0; i < tev->nargs; i++) {
> +		if (strchr(tev->args[i].value, '@')) {
> +			pr_warning("%s accesses a variable by symbol name, but that is not supported for user application probe.\n",
> +				   tev->args[i].value);
> +			break;
> +		}
> +		if (strglobmatch(tev->args[i].value, "[$+-]*")) {
> +			pr_warning("Please upgrade your kernel to at least 3.14 to have access to feature %s\n",
>  				   tev->args[i].value);
>  			break;
>  		}
> +	}
>  out:
>  	free(buf);
>  }
> 

-- 

- Arnaldo
