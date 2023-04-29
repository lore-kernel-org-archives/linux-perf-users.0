Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6ADC77B7C
	for <linux-perf-users@archiver.kernel.org>; Sat, 29 Apr 2023 01:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347384AbjD2B7w (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Apr 2023 21:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347341AbjD2B7n (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Apr 2023 21:59:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8B759F6;
        Fri, 28 Apr 2023 18:59:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78CE56463B;
        Sat, 29 Apr 2023 01:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B596CC433D2;
        Sat, 29 Apr 2023 01:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682733554;
        bh=KmjG+Ha2oLZdWXMOG9SlZ0vpoBCQOwPNjT5M7WOr0t0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jgcaqeYE+fJURE+rgweQCzPGUooeB0JAEH6BvSDRPR6DJZlEdZ+KkRzEKopTRYO5K
         JaU/4gFQOw/Z0+x+lGVAMAQJaLLzV620NLpu3ZNkQuSJO/Do1O2jgnuYB8374pl8AG
         qs9GSbOWcZ7JFhcxUty1rGJUJH+i3f7FISjaiz6dyuHMKCBxRAV250GuzF6JNPwYq/
         46+k9iWuv+sr3YFnPlByOncUAZMcS6FzXQl/jI5UlbM8B7ErBHragdOsdhBAEDpbew
         TJUMsJjV18wGGrRiaXzMNRKx8JXBsUgXoFPf+4YMd1zf28J3Mv+eqRkYqGvrf1Ydjw
         jybsw1TJh2tEg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EB6CC403B5; Fri, 28 Apr 2023 22:59:12 -0300 (-03)
Date:   Fri, 28 Apr 2023 22:59:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tracepoint: Fix memory leak in is_valid_tracepoint()
Message-ID: <ZEx58HsdECf42Qce@kernel.org>
References: <20230421025953.173826-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421025953.173826-1-yangjihong1@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Apr 21, 2023 at 02:59:53AM +0000, Yang Jihong escreveu:
> When is_valid_tracepoint() returns 1, need to call put_events_file() to
> free `dir_path`.
> 
> Fixes: 25a7d914274d ("perf parse-events: Use get/put_events_file()")
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

Thanks, applied.

- Arnaldo

> ---
>  tools/perf/util/tracepoint.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/tracepoint.c b/tools/perf/util/tracepoint.c
> index 89ef56c43311..92dd8b455b90 100644
> --- a/tools/perf/util/tracepoint.c
> +++ b/tools/perf/util/tracepoint.c
> @@ -50,6 +50,7 @@ int is_valid_tracepoint(const char *event_string)
>  				 sys_dirent->d_name, evt_dirent->d_name);
>  			if (!strcmp(evt_path, event_string)) {
>  				closedir(evt_dir);
> +				put_events_file(dir_path);
>  				closedir(sys_dir);
>  				return 1;
>  			}
> -- 
> 2.30.GIT
> 

-- 

- Arnaldo
