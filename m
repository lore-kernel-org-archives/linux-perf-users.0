Return-Path: <SRS0=rwtg=IE=vger.kernel.org=linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9588C433E0
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Mar 2021 13:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B917565018
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Mar 2021 13:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhCFNWX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 6 Mar 2021 08:22:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:50252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230427AbhCFNWS (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 6 Mar 2021 08:22:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E595C65017;
        Sat,  6 Mar 2021 13:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615036938;
        bh=1Spf0DijXQCIkDTm0HNj0q6u+VGaEcXYWi+dm81ZkSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tU9UWnSsjA5pegp0TCTXKZ/TK6B6ggeXML3mGbklo+c4z2Er2Tp2H2hc9HU1Ech/3
         R9onPMtiM1nT3m4EKntIQBjKRsSJbm0zCKCIfuIhqpmoFeVw9SnAu6XMOIHZteUzSh
         zVpKT0UsE+hx2+o526uGfek0wacX5fJcvr8+0I1By7mx2Mb/h+DZubco+GwHk3E0nG
         EB7eiIlQtRGZemXG0IhdxPpvphaBtFwqjXO/N6gujJNjwGazvfeyWEKQHiOT+yQtvG
         KHMorri5h1vOLj+hl572Xem3hoZdcreYTkf05FJMxOETrAqtwUzK7oluy4PdM7OdgT
         XTOoycLncw98w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0657040647; Sat,  6 Mar 2021 10:22:13 -0300 (-03)
Date:   Sat, 6 Mar 2021 10:22:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf config: add annotate.demangle{,_kernel}
Message-ID: <YEOCBeicraSekpIt@kernel.org>
References: <deb2af9e-25dd-ac72-29f4-ab90c2b24237@suse.cz>
 <YDVcZJscuKIgShsm@kernel.org>
 <a4e687b9-f611-1b24-ae7c-2ecd93c42ea8@suse.cz>
 <c96aabe7-791f-9503-295f-3147a9d19b60@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c96aabe7-791f-9503-295f-3147a9d19b60@suse.cz>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Feb 26, 2021 at 11:08:12AM +0100, Martin Liška escreveu:
> On 2/26/21 11:03 AM, Martin Liška wrote:
> > On 2/23/21 8:49 PM, Arnaldo Carvalho de Melo wrote:
> > > Please consider making this configurable (if not already) via
> > > ~/.perfconfig, 'perf config', sure in a followup patch.
> > 
> > I'm doing that in the following patch.
> 
> The patch contained a typo, fixed in the V2.



Thanks, applied.

And expanded that commit log a bit:

Author: Martin Liska <mliska@suse.cz>
Date:   Fri Feb 26 11:01:24 2021 +0100

    perf config: Add annotate.demangle{,_kernel}
    
    Committer notes:
    
    This allows setting this in from the command line:
    
      $ perf config annotate.demangle
      $ perf config annotate.demangle=yes
      $ perf config annotate.demangle
      annotate.demangle=yes
      $ cat ~/.perfconfig
      # this file is auto-generated.
      [report]
            sort-order = srcline
      [annotate]
            demangle = yes
      $
      $
      $ perf config annotate.demangle_kernel
      $ perf config annotate.demangle_kernel=yes
      $ perf config annotate.demangle_kernel
      annotate.demangle_kernel=yes
      $ cat ~/.perfconfig
      # this file is auto-generated.
      [report]
            sort-order = srcline
      [annotate]
            demangle = yes
            demangle_kernel = yes
      $
    
    Signed-off-by: Martin Liška <mliska@suse.cz>
    Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    Link: https://lore.kernel.org/r/c96aabe7-791f-9503-295f-3147a9d19b60@suse.cz
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo

 
> Martin
> 
> > 
> > Thanks,
> > Martin
> 

> From a29a6d3ae717f19774a430ccf9a63a452376f359 Mon Sep 17 00:00:00 2001
> From: Martin Liska <mliska@suse.cz>
> Date: Fri, 26 Feb 2021 11:01:24 +0100
> Subject: [PATCH] perf config: add annotate.demangle{,_kernel}
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Signed-off-by: Martin Liška <mliska@suse.cz>
> ---
>  tools/perf/Documentation/perf-config.txt | 6 ++++++
>  tools/perf/util/annotate.c               | 4 ++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
> index 153bde14bbe0..154a1ced72b2 100644
> --- a/tools/perf/Documentation/perf-config.txt
> +++ b/tools/perf/Documentation/perf-config.txt
> @@ -393,6 +393,12 @@ annotate.*::
>  
>  		This option works with tui, stdio2 browsers.
>  
> +	annotate.demangle::
> +		Demangle symbol names to human readable form. Default is 'true'.
> +
> +	annotate.demangle_kernel::
> +		Demangle kernel symbol names to human readable form. Default is 'true'.
> +
>  hist.*::
>  	hist.percentage::
>  		This option control the way to calculate overhead of filtered entries -
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 80542012ec1b..e35d56608986 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -3142,6 +3142,10 @@ static int annotation__config(const char *var, const char *value, void *data)
>  		opt->use_offset = perf_config_bool("use_offset", value);
>  	} else if (!strcmp(var, "annotate.disassembler_style")) {
>  		opt->disassembler_style = value;
> +	} else if (!strcmp(var, "annotate.demangle")) {
> +		symbol_conf.demangle = perf_config_bool("demangle", value);
> +	} else if (!strcmp(var, "annotate.demangle_kernel")) {
> +		symbol_conf.demangle_kernel = perf_config_bool("demangle_kernel", value);
>  	} else {
>  		pr_debug("%s variable unknown, ignoring...", var);
>  	}
> -- 
> 2.30.1
> 


-- 

- Arnaldo
