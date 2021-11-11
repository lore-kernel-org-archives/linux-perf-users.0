Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88308C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 17:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63A6C6135E
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 17:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbhKKRxS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 12:53:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:52998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232777AbhKKRxS (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 12:53:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7B9F61354;
        Thu, 11 Nov 2021 17:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636653029;
        bh=frnJL8rMQBfLGsaaB5AufD4oZhLEe6wwdZ1n+yY57dA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pv0OJg4SeZObrkWflQJzZ4a03alqd4atxAnvkh5X1CKckfGzZ6y+dN9G7jR2zFqvu
         iu7s3FvipJYxI2XTqy+/oOmXZkfBB5nmvy6H13oNyCUUyWc9VwZrEhkI9eb3QXjHbr
         5yfw3nIR1BAm47sBavYo8rTgrEPCf4hm90f5k3mQHL9RCpfaidN76jtyqDgZUrgEgh
         R32efve0lAIx2CecWhTTLKdTJ8Eb3laA1nCeTadsKdtbmPkYM4UUJTBO2rIXmbxyHe
         1hatout/ROESaQWXSjW1eVy+NG3uPj8BxtQGca8cYzg4m212jmUyF56L+7Mdox/IK2
         YPWXbZr1e86NA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2B147410A1; Thu, 11 Nov 2021 14:50:26 -0300 (-03)
Date:   Thu, 11 Nov 2021 14:50:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/perf/design: Synchronize the definition of enum
 perf_hw_id with code
Message-ID: <YY1X4gO/yydGu+11@kernel.org>
References: <20211109090147.56978-1-likexu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109090147.56978-1-likexu@tencent.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Nov 09, 2021 at 05:01:47PM +0800, Like Xu escreveu:
> From: Like Xu <likexu@tencent.com>
> 
> We're not surprised that there are tons of Linux users who
> only read the documentation to learn about the kernel.
> 
> Let's update the perf part for common hardware events
> since three new *generic* hardware events were added.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>  tools/perf/design.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/design.txt b/tools/perf/design.txt
> index a42fab308ff6..aa8cfeabb743 100644
> --- a/tools/perf/design.txt
> +++ b/tools/perf/design.txt
> @@ -106,6 +106,9 @@ enum perf_hw_id {
>  	PERF_COUNT_HW_BRANCH_INSTRUCTIONS	= 4,
>  	PERF_COUNT_HW_BRANCH_MISSES		= 5,
>  	PERF_COUNT_HW_BUS_CYCLES		= 6,
> +	PERF_COUNT_HW_STALLED_CYCLES_FRONTEND	= 7,
> +	PERF_COUNT_HW_STALLED_CYCLES_BACKEND	= 8,
> +	PERF_COUNT_HW_REF_CPU_CYCLES		= 9,
>  };
>  
>  These are standardized types of events that work relatively uniformly
> -- 
> 2.33.0

-- 

- Arnaldo
