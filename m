Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EA9C4320A
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 18:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7073E603E7
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 18:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbhHJSKI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:10:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237594AbhHJSHw (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 10 Aug 2021 14:07:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 979BB60232;
        Tue, 10 Aug 2021 18:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628618845;
        bh=/g6ozYTrIQ3TnzVClN0eljl5LiwiAdtEdh9sszUkg7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ROgvkOI7XfKbj8MfRi3cd6SLMnbp5afjAJz9YMNAIO0t7jWw4l9TF4EY+HOfdHbXD
         s78Wq+SVzA3XJ8cZAIoJ/XGNdiUzQyPyjds6HDOJxCOcp/51D9+ZkxWtMg+8jiQD9l
         WXWKiIvDG1w8ZEA+pbhfFzJLv09xerhTtcTG/2GhcSojqBSLaTQke/FCLWB+kqR7KP
         IWR41zSZz0P9Svn4bNMwTY0fyVrkqj5gdc8Po7S8KRdYwOrE+GSCgF4VonXDOfUIS8
         9h5rhfchLqd2DkxgwR6630A/Coq0zpGIDx6otTdOfl8yYKh+tlgWuNWBvGm4wZas7u
         wYr/eyIT2zcoQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1DF90403F2; Tue, 10 Aug 2021 15:07:22 -0300 (-03)
Date:   Tue, 10 Aug 2021 15:07:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, irogers@google.com
Subject: Re: [PATCH 0/6] perf events update for CascadeLake server and
 SkyLake server
Message-ID: <YRLAWhHWX3oa0iyt@kernel.org>
References: <20210810020508.31261-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210810020508.31261-1-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Aug 10, 2021 at 10:05:02AM +0800, Jin Yao escreveu:
> - Update JSON core/uncore events and metrics for CascadeLake Server.
> - Update JSON core/uncore events and metrics for SkyLake Server.
> 
> The patch series can be found at (in case broken by mailing system potentially):
> https://github.com/yaoj/perf-clx-events.git
> branch: perf/core

Hey, can you keep just one repository and then create branches?

$ git remote -v

yaoj	https://github.com/yaoj/icx-events.git (fetch)
yaoj	https://github.com/yaoj/icx-events.git (push)
yaoj-perf	https://github.com/yaoj/perf-intel-events.git (fetch)
yaoj-perf	https://github.com/yaoj/perf-intel-events.git (push)

And now:

⬢[acme@toolbox perf]$ https://github.com/yaoj/perf-clx-events.git

:-)

Applying from the git tree now.

- Arnaldo

 
> Jin Yao (6):
>   perf vendor events intel: Update core event list for CascadeLake
>     Server
>   perf vendor events intel: Update uncore event list for CascadeLake
>     Server
>   perf vendor events: Update metrics for CascadeLake Server
>   perf vendor events intel: Update core event list for SkyLake Server
>   perf vendor events intel: Update uncore event list for SkyLake Server
>   perf vendor events: Update metrics for SkyLake Server
> 
>  .../arch/x86/cascadelakex/cache.json          | 5468 ++++++++---------
>  .../arch/x86/cascadelakex/clx-metrics.json    |  253 +-
>  .../arch/x86/cascadelakex/floating-point.json |   48 +-
>  .../arch/x86/cascadelakex/frontend.json       |  550 +-
>  .../arch/x86/cascadelakex/memory.json         | 5444 ++++++++--------
>  .../arch/x86/cascadelakex/other.json          | 4146 ++++++-------
>  .../arch/x86/cascadelakex/pipeline.json       | 1046 ++--
>  .../arch/x86/cascadelakex/uncore-memory.json  |   21 +-
>  .../arch/x86/cascadelakex/uncore-other.json   |  161 +-
>  .../arch/x86/cascadelakex/virtual-memory.json |  256 +-
>  .../pmu-events/arch/x86/skylakex/cache.json   | 1724 +++---
>  .../arch/x86/skylakex/floating-point.json     |   56 +-
>  .../arch/x86/skylakex/frontend.json           |  580 +-
>  .../pmu-events/arch/x86/skylakex/memory.json  | 1300 ++--
>  .../pmu-events/arch/x86/skylakex/other.json   |  104 +-
>  .../arch/x86/skylakex/pipeline.json           | 1068 ++--
>  .../arch/x86/skylakex/skx-metrics.json        |  247 +-
>  .../arch/x86/skylakex/uncore-memory.json      |    9 -
>  .../arch/x86/skylakex/uncore-other.json       |  171 +-
>  .../arch/x86/skylakex/virtual-memory.json     |  288 +-
>  20 files changed, 11531 insertions(+), 11409 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 

- Arnaldo
