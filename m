Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7337DC4320E
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46D3A60F25
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240627AbhHaTXQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 15:23:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231634AbhHaTXQ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 15:23:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 449E160234;
        Tue, 31 Aug 2021 19:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630437740;
        bh=i1Y1hbT/RZr4nx6BdPpIbKxSIJvrWrIGnl09XjmbwrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BT9a29McinkaEPxJSYihIRCbncF/2ez4ztp1fuytYb1LpHiNyaEdYcYmcy3yRg1xf
         /30XDjHFoAh4Bx9kP90BULDT3FiPaTYhov+ExVCYV5tUbSMn8WhKRQqO+IB+jRJSF2
         u04d1g0/9hdavW6FocQWFJYhjnXW8R5aY9yJM4WYe8kTLv9nWx9Vrb+GN8ueu2emOR
         k9ZfZfONJWg6lK6VN8TiMlU6c7w9b7NjgBOlctI3GuzVRVyjrw3t5XLSnJCQ4TwyhU
         saSQ5aodm9AZ3J6SV3QHrjqERvAHFi8velP5wB60FoZetUp+hNrh0iAEyay1/LWpSb
         yKh6SBooUKhxQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 20C934007E; Tue, 31 Aug 2021 16:22:18 -0300 (-03)
Date:   Tue, 31 Aug 2021 16:22:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v1 05/37] perf util/mmap: add missing bitops.h header
Message-ID: <YS6Baiyjlw7vpwp7@kernel.org>
References: <cover.1629490974.git.rickyman7@gmail.com>
 <c5b91ee432a2e28e7f16337c740b43b4d0b0e86c.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5b91ee432a2e28e7f16337c740b43b4d0b0e86c.1629490974.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Aug 21, 2021 at 11:19:11AM +0200, Riccardo Mancini escreveu:
> MMAP_CPU_MASK_BYTES uses the BITS_TO_LONGS macro, which is defined in
> linux/bitops.h.
> However, this header is not included directly, but gets imported
> indirectly in files using the macro.
> This patch adds the missing include.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/util/mmap.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
> index b4923e587fd7749c..8e259b9610f83c96 100644
> --- a/tools/perf/util/mmap.h
> +++ b/tools/perf/util/mmap.h
> @@ -6,6 +6,7 @@
>  #include <linux/refcount.h>
>  #include <linux/types.h>
>  #include <linux/ring_buffer.h>
> +#include <linux/bitops.h>
>  #include <stdbool.h>
>  #include <pthread.h> // for cpu_set_t
>  #ifdef HAVE_AIO_SUPPORT
> -- 
> 2.31.1

-- 

- Arnaldo
