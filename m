Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DABCC4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 19:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ECC46101E
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 19:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbhHITzx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 15:55:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229516AbhHITzw (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 15:55:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E8AC61004;
        Mon,  9 Aug 2021 19:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628538931;
        bh=h38kA6LOuzAFaILxGztC5PTCtdY/I8ZAjz7AUGXz+M8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fxxrjy+yUSqzlJYGXW4SC4vF4yTzp74wH+kDFKspE5H8vMrbeqwKFHmtmt7vi/SW7
         0qc0/7HTLSJDAQRKsXM4xcqXv/zq4QOeqcg2QTWcLbINO7SyoRoU60POTRdgmO2lj2
         ZSmBO/9W7k4G9NmcSorqNqbjpnSKyEyWRa4V19U1YR/L4tad24rgodr4ETv1Ar8E8z
         4YvYZsTD4trUEB0HTZ35SLcnxJuAaMtRH7mrzlV18Yx2lBao+dibo2IT5ebZRoHrru
         a0+F5JIIgi9LTaY5tHGgYW22vnRsxT/0JRZv1rOGjfWrf8s71Sj1tm4SmgqUiPpbQP
         WJUVzy1+IJihA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E4FB9403F2; Mon,  9 Aug 2021 16:55:28 -0300 (-03)
Date:   Mon, 9 Aug 2021 16:55:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script python: fix unintended underline
Message-ID: <YRGIMJlG/HPh3y4U@kernel.org>
References: <20210806204502.110305-1-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806204502.110305-1-stephen.s.brennan@oracle.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Aug 06, 2021 at 01:45:01PM -0700, Stephen Brennan escreveu:
> The text ranging from "subsystem__event_name" to
> "raw_syscalls__sys_enter()" is interpreted by asciidoc as a pair of
> unconstrained text formatting markers. The result is that the manual
> page displayed this text as underlined, and the HTML pages displayed
> this text as italicized. Escape the first double-underscore to prevent
> this.
> 
> https://docs.asciidoctor.org/asciidoc/latest/syntax-quick-reference/

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>  tools/perf/Documentation/perf-script-python.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf-script-python.txt b/tools/perf/Documentation/perf-script-python.txt
> index 5e43cfa5ea1e..0250dc61cf98 100644
> --- a/tools/perf/Documentation/perf-script-python.txt
> +++ b/tools/perf/Documentation/perf-script-python.txt
> @@ -167,7 +167,7 @@ below).
>  
>  Following those are the 'event handler' functions generated one for
>  every event in the 'perf record' output.  The handler functions take
> -the form subsystem__event_name, and contain named parameters, one for
> +the form subsystem\__event_name, and contain named parameters, one for
>  each field in the event; in this case, there's only one event,
>  raw_syscalls__sys_enter().  (see the EVENT HANDLERS section below for
>  more info on event handlers).
> -- 
> 2.30.2
> 

-- 

- Arnaldo
