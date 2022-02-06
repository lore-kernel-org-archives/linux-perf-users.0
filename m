Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C04C433EF
	for <linux-perf-users@archiver.kernel.org>; Sun,  6 Feb 2022 11:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbiBFLzV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 6 Feb 2022 06:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiBFLzV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 6 Feb 2022 06:55:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00EBC06173B;
        Sun,  6 Feb 2022 03:55:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56C9160F73;
        Sun,  6 Feb 2022 11:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A88BC340E9;
        Sun,  6 Feb 2022 11:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644148519;
        bh=6UwOzeb2qQfqFj/MwgP86Azy8PMxef6xzEjION0SYXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xdnr9vbrzT4tRsxUt6tx+1/+4jticjls/ATNn7bdmBdh7CGNCz0H8IU1yTZieGiZf
         qfNgq7ddvBxdrpkOYdaF4uYQ9VRKjuQ0d/6wVHnZnhNOtxnqXq52LOmoOrSZIkMmSN
         tGbhHtZdY4HhBeqtVUsVqDK91wPv8kdFiBwSk0VMCbwkkh40IUfJ1259jl3N2GZUqT
         4NQe9QopiwQIBFZ6BVcNpsQsffEecR/QHuH+9XSpBg7GT09dHeYLTjyX34e0Kk6ISa
         FTk/sXLWVXE3OY6NZI0fFT4fn0VLkJdGAPD0XrljPDrOcE6smTQk31yBXF2+lQzpbE
         h9cYUmzPdirxA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BAEB0404A6; Sun,  6 Feb 2022 08:55:17 -0300 (-03)
Date:   Sun, 6 Feb 2022 08:55:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>, vineet.singh@intel.com,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        asaf.yaffe@intel.com, kshipra.bopardikar@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf stat: Fix display of grouped aliased events.
Message-ID: <Yf+3JfzBsH0Z/aNY@kernel.org>
References: <20220205010941.1065469-1-irogers@google.com>
 <e3bf95b1-bb9a-91be-1816-59c96c4e2024@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3bf95b1-bb9a-91be-1816-59c96c4e2024@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Feb 04, 2022 at 05:48:20PM -0800, Andi Kleen escreveu:
> 
> On 2/4/2022 5:09 PM, Ian Rogers wrote:
> > An event may have a number of uncore aliases that when added to
> > the evlist are consecutive. If there are multiple uncore events
> > in a group then parse_events__set_leader_for_uncore_aliase will
> > reorder the evlist so that events on the same PMU are
> > adjacent. collect_all_aliases assumes that aliases are in blocks
> > so that only the first counter is printed and all others are
> > marked merged. The reordering for groups breaks the assumption
> > and so all counts are printed. This change removes the assumption
> > from collect_all_aliases that the events are in blocks and
> > instead processes the entire evlist.
> 
> Looks good to me.
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Thanks, applied.

- Arnaldo

