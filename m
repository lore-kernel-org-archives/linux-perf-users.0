Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83CEC636CA
	for <linux-perf-users@archiver.kernel.org>; Sun, 18 Jul 2021 13:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A91461182
	for <linux-perf-users@archiver.kernel.org>; Sun, 18 Jul 2021 13:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbhGRNks (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 18 Jul 2021 09:40:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233673AbhGRNks (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 18 Jul 2021 09:40:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8987A6109E;
        Sun, 18 Jul 2021 13:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626615469;
        bh=22IdLRo2Hl7ken55mYV+S6Vdb2ptV3yDujoEGq0jFQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qaSzDmyubg1Vi7DlSqcs8LPjmKUjwbXuH8UziOiZ+x2kwy9es5PL1aGklnN5+WE5M
         rq4KvYWqgmnBDYJGXOtqc1b/b/Y5tct8QbgMyRAyHV1xtSEOi8QCI4qfzKXewGpuPS
         fyMZzVKHyYGa1Ce6rDekpVnGOv3iFDHtgrhkcabYdu5Ukr95oHluu4lF2siIchf89l
         fIjlLq33J8r9TshaIcA/g1Baw1BMfKqPqvfmulx8U21O60x5R9l+gCRlOo7GTrbzCJ
         Eta/y1eyE9Uu3gmlr1dnjBiynbxObeTcX6f7obb2JBdKXgkp8nyg7PpHG1cDbwfQWo
         nAdMRJvuLlYtA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2F548403F2; Sun, 18 Jul 2021 10:37:46 -0300 (-03)
Date:   Sun, 18 Jul 2021 10:37:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, laoar.shao@gmail.com, rostedt@goodmis.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf sched: Fix record failed when CONFIG_SCHEDSTATS is
 not set
Message-ID: <YPQuqlhPP/mCKDu3@kernel.org>
References: <20210713112358.194693-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713112358.194693-1-yangjihong1@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jul 13, 2021 at 07:23:58PM +0800, Yang Jihong escreveu:
> The tracepoints trace_sched_stat_{wait, sleep, iowait} are not exposed to user
> if CONFIG_SCHEDSTATS is not set, "perf sched record" records the three events.
> As a result, the command fails to be executed.
> 
> Before:
> 
>   #perf sched record sleep 1
>   event syntax error: 'sched:sched_stat_wait'
>                        \___ unknown tracepoint
> 
>   Error:  File /sys/kernel/tracing/events/sched/sched_stat_wait not found.
>   Hint:   Perhaps this kernel misses some CONFIG_ setting to enable this feature?.
> 
>   Run 'perf list' for a list of valid events
> 
>    Usage: perf record [<options>] [<command>]
>       or: perf record [<options>] -- <command> [<options>]
> 
>       -e, --event <event>   event selector. use 'perf list' to list available events
> 
> Solution:
>   Check whether schedstat tracepoints are exposed. If no, these events are not recorded.

Thanks, applied.

- Arnaldo

