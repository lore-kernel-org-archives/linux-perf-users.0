Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB09C11F64
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 16:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7AB3613E3
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 16:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhGAQ1t (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Jul 2021 12:27:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229664AbhGAQ1t (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Jul 2021 12:27:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7841B61002;
        Thu,  1 Jul 2021 16:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625156718;
        bh=ZmaGe0iXayTRZaJF/nPOquGquNqVUil8wsuyblDFl4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jddlJiix0SdqH9jrizHCWh/mUHvPmjro7TrFB/wNP+yEcUs4kxSTzDTgefVuyIY5H
         KYhUHwtDSs5yH15LLMiQyCm5NbkIHk/qQQ6jeRu5nxsBZwlofCb/XTXOqu4rUgv0Gg
         FPTRGgplyRrD/3cN919VbqYW+aJNMrCnAum5uWYwyKBXRZg/CqGAh0ex9yNSnA+cK3
         pQ/ywFH8kBBDuQPoYAT5eA80cBZcs75oPEws5tYmvXbnEOBCxaLfYmK1pHSWT353Eb
         CH9MSaD5uko4gYVJ3WmCLnZJHbBA3qTaIAYmtwN3SaFuiQuRU9e0z7Ep/1TpHj/Ge0
         gk1L5zbFlFCKQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2D55140B1A; Thu,  1 Jul 2021 13:25:14 -0300 (-03)
Date:   Thu, 1 Jul 2021 13:25:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <James.Clark@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Daniel Kiss <daniel.kiss@arm.com>,
        Denis Nikitin <denik@google.com>
Subject: Re: [PATCH v2 2/3] perf cs-etm: Remove callback
 cs_etm_find_snapshot()
Message-ID: <YN3sas8tWPfWjFqE@kernel.org>
References: <20210701093537.90759-1-leo.yan@linaro.org>
 <20210701093537.90759-3-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701093537.90759-3-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 01, 2021 at 05:35:36PM +0800, Leo Yan escreveu:
> The callback cs_etm_find_snapshot() is invoked for snapshot mode, its
> main purpose is to find the correct AUX trace data and returns "head"
> and "old" (we can call "old" as "old head") to the caller, the caller
> __auxtrace_mmap__read() uses these two pointers to decide the AUX trace
> data size.
> 
> This patch removes cs_etm_find_snapshot() with below reasons:
> 
> - The first thing in cs_etm_find_snapshot() is to check if the head has
>   wrapped around, if it is not, directly bails out.  The checking is
>   pointless, this is because the "head" and "old" pointers both are
>   monotonical increasing so they never wrap around.
> 
> - cs_etm_find_snapshot() adjusts the "head" and "old" pointers and
>   assumes the AUX ring buffer is fully filled with the hardware trace
>   data, so it always subtracts the difference "mm->len" from "head" to
>   get "old".  Let's imagine the snapshot is taken in very short
>   interval, the tracers only fill a small chunk of the trace data into
>   the AUX ring buffer, in this case, it's wrongly to copy the whole the
>   AUX ring buffer to perf file.
> 
> - As the "head" and "old" pointers are monotonically increased, the
>   function __auxtrace_mmap__read() handles these two pointers properly.
>   It calculates the reminders for these two pointers, and the size is
>   clamped to be never more than "snapshot_size".  We can simply reply on
>   the function __auxtrace_mmap__read() to calculate the correct result
>   for data copying, it's not necessary to add Arm CoreSight specific
>   callback.

Thanks, applied.

- Arnaldo

