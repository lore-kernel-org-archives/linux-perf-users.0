From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 2/2] perf Makefile: default WERROR to off.
Date: Tue, 26 Aug 2014 15:53:54 +0900
Message-ID: <87oav7bv25.fsf@sejong.aot.lge.com>
References: <53FB9064.1050000@barfooze.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE7Q.lge.com ([156.147.1.151]:39316 "EHLO
	lgemrelse7q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757264AbaHZGx4 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 26 Aug 2014 02:53:56 -0400
In-Reply-To: <53FB9064.1050000@barfooze.de> (John Spencer's message of "Mon,
	25 Aug 2014 21:37:08 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: John Spencer <maillist-linux@barfooze.de>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 25 Aug 2014 21:37:08 +0200, John Spencer wrote:
> From 4a72032828a6784d93f4becf723303a17d723544 Mon Sep 17 00:00:00 2001
> From: John Spencer <maillist-linux@barfooze.de>
> Date: Mon, 25 Aug 2014 21:25:43 +0200
> Subject: [PATCH 2/2] perf Makefile: default WERROR to off.
>
> Having WERROR on by default breaks build everywhere the author hasn't
> tested so far; including musl libc which warns about wrong includes.
>
> The unsuspecting user will think there's something broken and only
> if he's coureageuous enough to grep the Makefile infrastructure find
> out that he may be able to get the build working with WERROR=0.
>
> OTOH with WERROR defaulting to off, anything will work for the user
> and the maintainer can knowingly use WERROR=1 to do his test builds.

I think it's intentionally turned on to fix any warnings in the first
place.  But yes, it might miss some non-popular systems tho..

How many errors/warnings do you see on your system (musl libc?).  Any
chance to post fixes instead?

Thanks,
Namhyung


>
> Signed-off-by: John Spencer <maillist-linux@barfooze.de>
>
> ---
>  tools/perf/config/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/config/Makefile b/tools/perf/config/Makefile
> index 1f67aa0..b1d639a 100644
> --- a/tools/perf/config/Makefile
> +++ b/tools/perf/config/Makefile
> @@ -102,7 +102,7 @@ ifeq ($(call get-executable,$(BISON)),)
>  endif
>  
>  # Treat warnings as errors unless directed not to
> -ifneq ($(WERROR),0)
> +ifeq ($(WERROR),1)
>    CFLAGS += -Werror
>  endif
