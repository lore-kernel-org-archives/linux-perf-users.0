From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 1/2] perf Makefile: fix GNU-only grep usage
Date: Tue, 26 Aug 2014 15:46:32 +0900
Message-ID: <87sikjbvef.fsf@sejong.aot.lge.com>
References: <53FB9040.8060802@barfooze.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE7Q.lge.com ([156.147.1.151]:36195 "EHLO
	lgemrelse7q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889AbaHZGqe (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 26 Aug 2014 02:46:34 -0400
In-Reply-To: <53FB9040.8060802@barfooze.de> (John Spencer's message of "Mon,
	25 Aug 2014 21:36:32 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: John Spencer <maillist-linux@barfooze.de>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

Hi John,

You'd better to CC the lkml (linux-kernel@vger.kernel.org) for the perf
patches to get reviewed by other developers.  I'm copying to the list
this time.


On Mon, 25 Aug 2014 21:36:32 +0200, John Spencer wrote:
> From efa79d5b7bc750369332a3a34442573af7b1b35c Mon Sep 17 00:00:00 2001
> From: John Spencer <maillist-linux@barfooze.de>
> Date: Mon, 25 Aug 2014 21:24:30 +0200
> Subject: [PATCH 1/2] perf Makefile: fix GNU-only grep usage
>
> this makes it work with non-GNU grep's as well.
>
> Signed-off-by: John Spencer <maillist-linux@barfooze.de>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


>
> ---
>  tools/perf/config/utilities.mak | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/config/utilities.mak b/tools/perf/config/utilities.mak
> index 4d985e0..7076a62 100644
> --- a/tools/perf/config/utilities.mak
> +++ b/tools/perf/config/utilities.mak
> @@ -132,7 +132,7 @@ endef
>  #
>  # Usage: bool-value = $(call is-absolute,path)
>  #
> -is-absolute = $(shell echo $(shell-sq) | grep ^/ -q && echo y)
> +is-absolute = $(shell echo $(shell-sq) | grep -q ^/ && echo y)
>  
>  # lookup
>  #
