Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F80FC432BE
	for <linux-perf-users@archiver.kernel.org>; Mon, 30 Aug 2021 21:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06E0260F3A
	for <linux-perf-users@archiver.kernel.org>; Mon, 30 Aug 2021 21:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237509AbhH3VcR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:32:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237366AbhH3VcQ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 30 Aug 2021 17:32:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C27560E77;
        Mon, 30 Aug 2021 21:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630359082;
        bh=XjZOh4Hv2zb7hGf/NrcwcMDg03lMgBiQ/Dvhy5f69cs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O87Y9M222z90PZTgBJOtPH707TTqMuqh8s+RqLXHbZAdZlkSFppP2Wfi9eSfgiCZz
         urfhCQlyfhaVnL5RcMg7nbO7HBmKnxHNRW7nGCdx7bu6ytdK5ikvOOQB9vFaXtCqui
         fK5g5d+2KkKEzVZmfJsmpB3PdRmQb/sDIlWC2Jyut5CbTzI27lkSeOK9qR2rLvOw0o
         lkdhgPZrfIDn+SlQul+CZTTV1fkGnIXvueEWqRJqZfs35NYlk3+PqGWJjEWsQLPiSZ
         4aH+UFLGkXAE8gvPsEvp/P/zdeqbUK2YMfEXkdFPe69aYegnzhqx020/ZAMlaOUOtb
         C1jOZ1RzuOjQQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 931E34007E; Mon, 30 Aug 2021 18:31:20 -0300 (-03)
Date:   Mon, 30 Aug 2021 18:31:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: Re: [PATCH v2 0/2] perf: Support compat mode for AUX ring buffer
Message-ID: <YS1OKOTMMEiAwPfj@kernel.org>
References: <20210829102238.19693-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210829102238.19693-1-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sun, Aug 29, 2021 at 06:22:36PM +0800, Leo Yan escreveu:
> This patch set is to address the comments in the patch set v1 [1] and
> updates the patches.
> 
> Changes from v1:
> - Added Adrian's review tag for patch 01;
> - Refined comment in patch 01 (James);
> - Added James' review and test tag for patch 02.
> 
> [1] https://lore.kernel.org/patchwork/cover/1473936/

Thanks, applied.

- Arnaldo

 
> 
> Leo Yan (2):
>   perf auxtrace: Add compat_auxtrace_mmap__{read_head|write_tail}
>   perf auxtrace arm: Support
>     compat_auxtrace_mmap__{read_head|write_tail}
> 
>  tools/perf/arch/arm/util/auxtrace.c | 32 +++++++++++
>  tools/perf/util/auxtrace.c          | 88 +++++++++++++++++++++++++++--
>  tools/perf/util/auxtrace.h          | 22 +++++++-
>  3 files changed, 135 insertions(+), 7 deletions(-)
> 
> -- 
> 2.25.1

-- 

- Arnaldo
