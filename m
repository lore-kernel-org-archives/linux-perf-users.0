Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB84CC4338F
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 Aug 2021 19:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B73406109E
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 Aug 2021 19:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhHKTBa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 11 Aug 2021 15:01:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34555 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229802AbhHKTB3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 11 Aug 2021 15:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628708465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1unfFbOZLAIxVPI4mcVVIhRUq595frKfj6cy+G8EMzQ=;
        b=WqcYK/2IZpjuMAadyvT7vBr4TLGMqheciahOjUVP9Ju8ZUZ+7HZoy/Wsu1Fofnfz+fldYH
        RIvx+9mc6Pt679uEGG7tfF3he32W/1A4UZq/vkbQ6w42pKgyTQKX2dsY4KuCW+CpcmKeDA
        VlMsnM0GfYjjgHLTekHo+UYFPv1y7uQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-_aS19FXuOzuBHJ_bf0wUgg-1; Wed, 11 Aug 2021 15:01:03 -0400
X-MC-Unique: _aS19FXuOzuBHJ_bf0wUgg-1
Received: by mail-ej1-f70.google.com with SMTP id h13-20020a1709062dcdb02905aec576a827so1063557eji.23
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Aug 2021 12:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1unfFbOZLAIxVPI4mcVVIhRUq595frKfj6cy+G8EMzQ=;
        b=Ea6BVcpNH6O+St6draFKlnoIv5mzDeZhtoQNEWL2x8MGZZvMd0iPnO7S2ccY6fduap
         nGuxYq4tEAs2vTBsk3ngsIf7tU4mRTfl4xNi/loT37rJLN96iz50m35fXJhsPvGh7xX/
         w9yRrAzTVGVjCh+brYkEwyZFnTYx9R1CC68w2nqHHKTW3oxEHG0sVjMnHNgeHa+jeTp4
         eaGjxWFPyznscxafqtLHHMn9dUiBYh8lqGFG+eQmy46d2DRpf7mjBpk3a9HPzdQ9Mr+S
         /sUQKfAOEL3v4Hn3KfV2NLfEFmPNb/gkwQlnHArmIeAX5z+nnrQui3ABdsNy2DMfiorA
         lytg==
X-Gm-Message-State: AOAM531ztpjzp+7CpY5rYDufIHiv5/KurPLtPAIW+KyZ2XJMyqJ3s7iG
        R9azwuAZVxnMhTwuDVi7WAu7b2PYSe8kVXFYmWvWMxP7MD4OSggEBsYz3vNg7PHo03nr/I3bRgq
        Z/SPr/wpe73eYs8lwaDHPRNoJEPJnOw==
X-Received: by 2002:a17:906:3c45:: with SMTP id i5mr3229ejg.336.1628708462456;
        Wed, 11 Aug 2021 12:01:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxT3yECiOK8DRTNO1gNIEUJRuEfepqRl4VoWaBoHMA6ltlbpth3eFKdBD6qCLeLTooj+HJrYg==
X-Received: by 2002:a17:906:3c45:: with SMTP id i5mr3195ejg.336.1628708462158;
        Wed, 11 Aug 2021 12:01:02 -0700 (PDT)
Received: from krava ([83.240.61.5])
        by smtp.gmail.com with ESMTPSA id b3sm94293ejb.7.2021.08.11.12.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 12:01:01 -0700 (PDT)
Date:   Wed, 11 Aug 2021 21:01:00 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 0/3] perf tool: Enable cpu list for hybrid
Message-ID: <YRQebER3uDUkJogC@krava>
References: <20210723063433.7318-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723063433.7318-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jul 23, 2021 at 02:34:30PM +0800, Jin Yao wrote:
> The perf-record and perf-stat have supported the option '-C/--cpus'
> to count or collect only on the list of CPUs provided. This option
> needs to be supported for hybrid as well.
> 
> v4:
> ---
> Rename evlist__use_cpu_list to evlist__fix_hybrid_cpus
> Add comments to evlist__fix_hybrid_cpus.

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> v3:
> ---
> Rebase to latest perf/core branch.
> 
> v2:
> ---
> Automatically map to hybrid pmu.
> 
> For example,
> 
> If cpu0-7 are 'cpu_core' and cpu9-11 are 'cpu_atom',
> 
>   # perf stat -e cycles -C0,11 -- sleep 1
>   WARNING: use 0 in 'cpu_core' for 'cycles', skip other cpus in list.
>   WARNING: use 11 in 'cpu_atom' for 'cycles', skip other cpus in list.
> 
>    Performance counter stats for 'CPU(s) 0,11':
> 
>            1,914,704      cpu_core/cycles/
>            2,036,983      cpu_atom/cycles/
> 
>          1.005815641 seconds time elapsed
> 
> It automatically selects cpu0 for cpu_core/cycles/, selects cpu11 for
> cpu_atom/cycles/, also with some warnings output.
> 
> Jin Yao (3):
>   libperf: Add perf_cpu_map__default_new()
>   perf tools: Create hybrid flag in target
>   perf tools: Enable on a list of CPUs for hybrid
> 
>  tools/lib/perf/cpumap.c              |  5 ++
>  tools/lib/perf/include/perf/cpumap.h |  1 +
>  tools/perf/builtin-record.c          |  7 +++
>  tools/perf/builtin-stat.c            |  6 +++
>  tools/perf/util/evlist-hybrid.c      | 73 ++++++++++++++++++++++++++++
>  tools/perf/util/evlist-hybrid.h      |  1 +
>  tools/perf/util/evlist.c             |  3 +-
>  tools/perf/util/pmu.c                | 35 +++++++++++++
>  tools/perf/util/pmu.h                |  4 ++
>  tools/perf/util/target.h             |  1 +
>  10 files changed, 135 insertions(+), 1 deletion(-)
> 
> -- 
> 2.17.1
> 

