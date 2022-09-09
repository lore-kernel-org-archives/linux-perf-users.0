Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F46FECAAA1
	for <linux-perf-users@archiver.kernel.org>; Fri,  9 Sep 2022 13:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiIINaU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 9 Sep 2022 09:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiIINaT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 9 Sep 2022 09:30:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424734BD13;
        Fri,  9 Sep 2022 06:30:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02C7EB824F7;
        Fri,  9 Sep 2022 13:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B36DC433D7;
        Fri,  9 Sep 2022 13:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662730215;
        bh=EEGq+IdvooaP0lFaWFPxgnWqvDpi0mvAYTKZobEYsM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T3BTj5RdZWBa7U0ALppB4kpbvJVVC81AisTt8jG+FshRpNrilwNM3F/TJKSjQ5a86
         39biMVyb+9mOyRo7zM+5a7a+oBP3SdA5gqnBp89tclmSgDZ3ojcLHoSyt6f12AujhG
         dfvPlSVZIW+dwgLzkQZdOv+7XhhyMaqFxx7FdwmIkZh0L0MJal1uJFDSQiCXpEohce
         vc9GrRkIn5CNLXDxhrjTteeJ2Y83+nCGBuZno0NY8bhj0KHOMBEKfd0No4K6Mxzp+R
         PZ3jD2I7babtKxUIYy4Zijg6M1FHWU9QrxPEbAet8RgEaRREfsuFlTHdTKiuEFNVeR
         qauUQ9u/QF0WQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9E596404A1; Fri,  9 Sep 2022 10:30:12 -0300 (-03)
Date:   Fri, 9 Sep 2022 10:30:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, atrajeev@linux.vnet.ibm.com,
        eranian@google.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Remove unused declarations
Message-ID: <Yxs/5FvhOKg4i9lb@kernel.org>
References: <20220909044542.1087870-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909044542.1087870-1-cuigaosheng1@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Sep 09, 2022 at 12:45:40PM +0800, Gaosheng Cui escreveu:
> This series contains a few cleanup patches, to remove unused
> declarations which have been removed. Thanks!

Thanks, applied.

- Arnaldo

 
> Gaosheng Cui (2):
>   perf sort: remove hist_entry__sort_list and sort__first_dimension
>     declaration
>   perf tools: remove perf_pmu_lex declaration
> 
>  tools/perf/util/pmu.y  | 2 --
>  tools/perf/util/sort.h | 2 --
>  2 files changed, 4 deletions(-)
> 
> -- 
> 2.25.1

-- 

- Arnaldo
