Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAA3C07E9B
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jul 2021 19:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A969D61C6D
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jul 2021 19:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhGFTKm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Jul 2021 15:10:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231696AbhGFTKm (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Jul 2021 15:10:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B3A461C6C;
        Tue,  6 Jul 2021 19:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625598483;
        bh=MjH1pdpU6zd+3cbzssyYOuUlfBCKTP3izuXWlT48B+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=egTtBvRXYsoMcyWWRJlWB0QsvJol9J5F44R7NnLcxoRcjOH4VaUHeX4tjZZBC09Kz
         /1W/2x8JBFqkl/1t4EqaDxg46XS3VuCy1fxRMDI6+NzmpzebkFJXpBBngZFAV2BEki
         LAMGGHkgFHTbLfjOrdEw9+m/bSGqM2mIYxkM+DLje+T5kQzycIbH4nojFDwh+akPkp
         8PMwVxQMQHsKQiE0ALCRPVTR/OBHi5KI52smHRT5+CDP2dJiRg3qCKngWeepVV/aHG
         rC+uWtL0rBSczD6omOSBBew6uomS7+9zH4/fxzqtZT/oyEhK5y+LydhLFxFodxOhf/
         R4OeC0epltR0Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4844A40B1A; Tue,  6 Jul 2021 16:08:00 -0300 (-03)
Date:   Tue, 6 Jul 2021 16:08:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Justin M. Forbes" <jforbes@fedoraproject.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmforbes@linuxtx.org
Subject: Re: [PATCH] Fix the perf trace link location
Message-ID: <YOSqEDU+MjOS29fd@kernel.org>
References: <20210706185952.116121-1-jforbes@fedoraproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706185952.116121-1-jforbes@fedoraproject.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jul 06, 2021 at 01:59:51PM -0500, Justin M. Forbes escreveu:
> The install perf_dlfilter.h patch included what seems to be
> a typo in the Makefile.perf, which changed the location of the trace
> link from '$(DESTDIR_SQ)$(bindir_SQ)/trace' to
> '$(DESTDIR_SQ)$(dir_SQ)/trace' This reverts it back to the correct
> location.

Thanks, applied!

- Arnaldo
 
> Fixes: 0beb218315e06 ("perf build: Install perf_dlfilter.h")
> Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
> ---
>  tools/perf/Makefile.perf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index c9e0de5b00c1..a1b9be78a1e0 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -923,7 +923,7 @@ install-tools: all install-gtk
>  	$(call QUIET_INSTALL, binaries) \
>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'; \
>  		$(INSTALL) $(OUTPUT)perf '$(DESTDIR_SQ)$(bindir_SQ)'; \
> -		$(LN) '$(DESTDIR_SQ)$(bindir_SQ)/perf' '$(DESTDIR_SQ)$(dir_SQ)/trace'; \
> +		$(LN) '$(DESTDIR_SQ)$(bindir_SQ)/perf' '$(DESTDIR_SQ)$(bindir_SQ)/trace'; \
>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(includedir_SQ)/perf'; \
>  		$(INSTALL) util/perf_dlfilter.h -t '$(DESTDIR_SQ)$(includedir_SQ)/perf'
>  ifndef NO_PERF_READ_VDSO32
> -- 
> 2.31.1
> 

-- 

- Arnaldo
