Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C47FC64ED6
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Feb 2023 21:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjB0Vmz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 27 Feb 2023 16:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjB0Vmx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 27 Feb 2023 16:42:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9892422F;
        Mon, 27 Feb 2023 13:42:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83AAFB80D9A;
        Mon, 27 Feb 2023 21:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23671C433D2;
        Mon, 27 Feb 2023 21:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677534168;
        bh=XdvhKAZNwBj8e9elHvQSuhkRlbQ2LLpDgNtffZnQFWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Agz4zbDyBLaLkryl9xedMsq1U3IRpXLyoILaeYYWAwIoQDER81nwqI403s+GWq7z2
         U6Zv7prEseOrZGAjuxfm5O8Xx3vfXQuLhttk9gM5oT4Xx8iPkfYG7SATY2decIC+q2
         WxHQfz3kRsb0EKVRy6iOBevQJSH63xGwT19cd+AhlB98vIMzRhSN7rbmVohF8F4hXn
         kgCyQ3NJ5Y+Pcc0q+Mg8ZWGJ9q66qf3IUicvtpkIita7U8keSKCbYtLE5B/XTfpyvd
         PH4Na2mME1GWC47IQ8q11y6yry67GlQy4qtYHc4kDIzN8Zh1V+rVLSEvkLy1Y2t2DY
         UhZ06LevR9mZA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5CEC84049F; Mon, 27 Feb 2023 18:42:46 -0300 (-03)
Date:   Mon, 27 Feb 2023 18:42:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>
Subject: Re: [PATCH v1 0/3] Update Alderlake and IcelakeX events
Message-ID: <Y/0j1qdJdma/TC1B@kernel.org>
References: <20230223055306.296179-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223055306.296179-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Feb 22, 2023 at 09:53:03PM -0800, Ian Rogers escreveu:
> Update Alderlake and IcelakeX events to v1.19.
> 
> Developed on the perf-tools-next branch of:
> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git

Thanks, applied.

- Arnaldo

 
> Ian Rogers (3):
>   perf vendor events intel: Update alderlake to v1.19
>   perf vendor events intel: Update alderlaken to v1.19
>   perf vendor events intel: Update icelakex to v1.19
> 
>  .../pmu-events/arch/x86/alderlake/memory.json |  8 +++++
>  .../arch/x86/alderlake/pipeline.json          | 10 ++++++
>  .../arch/x86/alderlaken/memory.json           |  7 +++++
>  .../pmu-events/arch/x86/icelakex/cache.json   |  8 +++++
>  .../arch/x86/icelakex/floating-point.json     | 31 +++++++++++++++++++
>  .../arch/x86/icelakex/pipeline.json           | 10 ++++++
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |  6 ++--
>  7 files changed, 77 insertions(+), 3 deletions(-)
> 
> -- 
> 2.39.2.637.g21b0678d19-goog
> 

-- 

- Arnaldo
