Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2644C07E95
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 18:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D35B061CB0
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 18:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhGGSWP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Jul 2021 14:22:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39940 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232503AbhGGSVZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Jul 2021 14:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625681924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LUZtc6YTxu6uc+g3cz8GTAgNxWs+3+Q4JhAXHke+bh8=;
        b=SCjxLmIc0H+rowFlX6msskRAO5THBPObNwfSZqOjwzceb8haqYaMm5UEEml8WzJo/LvIC5
        ptIhAE82BK3MM2aOFDQwDRb7QDkfoIXZM5EVjtlhgPYUU1nX+zMbWlruR4Sm/ZDNnmQP2w
        crUqj4c4DF5UJNF98R1miG2Mx7q5itA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-8tY-bZbGOlWpsu92_h018g-1; Wed, 07 Jul 2021 14:18:43 -0400
X-MC-Unique: 8tY-bZbGOlWpsu92_h018g-1
Received: by mail-wr1-f70.google.com with SMTP id m10-20020a5d64aa0000b029013370949d6bso1079981wrp.1
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jul 2021 11:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LUZtc6YTxu6uc+g3cz8GTAgNxWs+3+Q4JhAXHke+bh8=;
        b=tPLciShm8hQJyEES72QfvHccjeA4/Vd5hGPKtqtDTIwnYpWB2GIE2JFEl7Ao8y8y9k
         +RgVGqUH6nSpI/efK4UfEyi49t24cypgDbltb8DI7A5LTJfVhY6P/BixyYYVLQRuSBYC
         ocEADr645lZYE0KjSrvgS+AgPrBG8LLE0IpMch5q4nICTgQz8nTnNStlpZ+OglpkvoCa
         oGfSJOoCtDZKPjIP+l8d9X0FchLlJjaMjfgm4Rsq/AcE+ShYsHH8bcpcRREW75JniHzG
         0D4abVadsrJsI5wBBOaU06I7Zau6bOhUoqbOyvOOrLnQBVtCIpVQcRWDRVliuTOTFngA
         ffww==
X-Gm-Message-State: AOAM531vjNDlwOUBtTOr8DcsPR9YLwuWFTm4EF0PCJOEUUoDSocbP8lY
        VurJs0BPpbWljto7iSwCEkVhKvEb7yUOQ4YAfTKoi1UDRXHY1n2dwTQFK8o2jTqv6w1TL4O7wMH
        oUwthEfabdSjkGLVBIaiELcDoqh8Z0w==
X-Received: by 2002:adf:eb82:: with SMTP id t2mr29306328wrn.337.1625681922602;
        Wed, 07 Jul 2021 11:18:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxChd/l3ejyQib0minlOQI1nNvHZOrogkwK3oGggmkVVpeCgVcl9kJF3ZUdjP7i1a2esUVi8Q==
X-Received: by 2002:adf:eb82:: with SMTP id t2mr29306316wrn.337.1625681922493;
        Wed, 07 Jul 2021 11:18:42 -0700 (PDT)
Received: from krava ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id u2sm14420778wmc.42.2021.07.07.11.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 11:18:42 -0700 (PDT)
Date:   Wed, 7 Jul 2021 20:18:35 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>, nakamura.shun@fujitsu.com,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/7] libperf: Move idx to perf_evsel::idx
Message-ID: <YOXv+wlbqv4yQ9qH@krava>
References: <20210706151704.73662-1-jolsa@kernel.org>
 <20210706151704.73662-3-jolsa@kernel.org>
 <YOW+3yhgNgMOrE99@kernel.org>
 <YOXo1F8BlX07JfHC@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOXo1F8BlX07JfHC@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jul 07, 2021 at 02:48:04PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jul 07, 2021 at 11:49:03AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Jul 06, 2021 at 05:16:59PM +0200, Jiri Olsa escreveu:
> > > Moving evsel::idx to perf_evsel::idx, so we can move
> > > the group interface to libperf.
> 
> You forgot these:
> 
> $ find tools/perf/ -name "*.[ch]" | xargs grep 'evsel->idx'
> tools/perf/ui/gtk/annotate.c:							     evsel->idx + i);
> tools/perf/ui/gtk/annotate.c:						    evsel->idx);
> $

aaah we still have that :-) thanks

as I wrote earlier, I'll take what you have in tmp.perf/core and go from
there with your changes

thanks,
jirka

> 
> That running 'make -C tools/perf build-test' caught, so I'm adding this
> to this patch as well:
> 
> diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
> index a7dff77f20184f1f..c266ed4fa015842d 100644
> --- a/tools/perf/ui/gtk/annotate.c
> +++ b/tools/perf/ui/gtk/annotate.c
> @@ -135,12 +135,12 @@ static int perf_gtk__annotate_symbol(GtkWidget *window, struct map_symbol *ms,
>  				ret += perf_gtk__get_percent(s + ret,
>  							     sizeof(s) - ret,
>  							     sym, pos,
> -							     evsel->idx + i);
> +							     evesl->core.idx + i);
>  				ret += scnprintf(s + ret, sizeof(s) - ret, " ");
>  			}
>  		} else {
>  			ret = perf_gtk__get_percent(s, sizeof(s), sym, pos,
> -						    evsel->idx);
> +						    evesl->core.idx);
>  		}
>  
>  		if (ret)
> 

