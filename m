From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH] perf: Fix timechart idle box drawings
Date: Sat, 22 Jan 2011 22:37:43 -0200
Message-ID: <20110123003743.GB17936@ghostprotocols.net>
References: <1295620209-13859-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:61489 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab1AWAht (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 22 Jan 2011 19:37:49 -0500
Received: by yib18 with SMTP id 18so915191yib.19
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Jan 2011 16:37:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1295620209-13859-1-git-send-email-trenn@suse.de>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Thomas Renninger <trenn@suse.de>, mingo@elte.hu, Arjan van de Ven <arjan@infradead.org>, linux-perf-users@vger.kernel.org

Em Fri, Jan 21, 2011 at 03:30:08PM +0100, Thomas Renninger escreveu:
> Without this patch eye of gnome and firfox will draw the
> boxes black.
> Compare with the other box declartions, looks
> like some typos slipped in which get fixed with this
> patch.
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> CC: arjan@infradead.org
> CC: mingo@elte.hu
> CC: linux-perf-users@vger.kernel.org

Arjan,

	Are you OK with this? Can I have your acked-by for it?

- Arnaldo


>  tools/perf/util/svghelper.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
> index b3637db..8ee5d11 100644
> --- a/tools/perf/util/svghelper.c
> +++ b/tools/perf/util/svghelper.c
> @@ -455,9 +455,9 @@ void svg_legenda(void)
>  		return;
>  
>  	svg_legenda_box(0,	"Running", "sample");
> -	svg_legenda_box(100,	"Idle","rect.c1");
> -	svg_legenda_box(200,	"Deeper Idle", "rect.c3");
> -	svg_legenda_box(350,	"Deepest Idle", "rect.c6");
> +	svg_legenda_box(100,	"Idle","c1");
> +	svg_legenda_box(200,	"Deeper Idle", "c3");
> +	svg_legenda_box(350,	"Deepest Idle", "c6");
>  	svg_legenda_box(550,	"Sleeping", "process2");
>  	svg_legenda_box(650,	"Waiting for cpu", "waiting");
>  	svg_legenda_box(800,	"Blocked on IO", "blocked");
> -- 
> 1.7.3.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
