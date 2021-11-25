Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D680C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 25 Nov 2021 21:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351308AbhKYVgJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 25 Nov 2021 16:36:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244962AbhKYVeI (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 Nov 2021 16:34:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA2F3610D1;
        Thu, 25 Nov 2021 21:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637875857;
        bh=BZ2XRrPuxKdfNaEoH/zDFQqwXwupV+aI8Q7TqqkjnnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ikYRx3FDzFKyzSH3hD8lm5xuhQgVPMZiaBKYafBPJfIv5Mx9wShXOG6u/tldl9Wxj
         2JZtavx55eeNNVfntKC2kJN4GhViymCXY0kS9qS1fQk7bbNYKnXTB0cV5dTWhv/ASf
         4ACTAVf8s2rfPJPAUf7xc+gfawImhpzb0mrgqH5JBkbojqv3SdLYC87W+26XQUk1BJ
         PuYtgsFrv19X86sHCm418+hzcxvj1K/FECbP4OdEI+gSSg7v9Io/OhBFtYHgJ3TTZv
         drXhtbR8G1B6Fa93CtfgtqywRUAIsFABx0LRNlF7vlb0IOZXSn3mtIFKGtUtrz/1lk
         5+7MrQNGwUF/Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C343640002; Thu, 25 Nov 2021 18:30:52 -0300 (-03)
Date:   Thu, 25 Nov 2021 18:30:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH v2 2/4] perf tools: Fix SMT not detected
Message-ID: <YaAAjHUXqY8pkiOA@kernel.org>
References: <20211124001231.3277836-1-irogers@google.com>
 <20211124001231.3277836-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124001231.3277836-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Nov 23, 2021 at 04:12:29PM -0800, Ian Rogers escreveu:
> sysfs__read_int returns 0 on success, and so the fast read path was
> always failing.
> 
> Fixes: bb629484d924 (perf tools: Simplify checking if SMT is active.)
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf/urgent.

- Arnaldo

> ---
>  tools/perf/util/smt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
> index 20bacd5972ad..34f1b1b1176c 100644
> --- a/tools/perf/util/smt.c
> +++ b/tools/perf/util/smt.c
> @@ -15,7 +15,7 @@ int smt_on(void)
>  	if (cached)
>  		return cached_result;
>  
> -	if (sysfs__read_int("devices/system/cpu/smt/active", &cached_result) > 0)
> +	if (sysfs__read_int("devices/system/cpu/smt/active", &cached_result) >= 0)
>  		goto done;
>  
>  	ncpu = sysconf(_SC_NPROCESSORS_CONF);
> -- 
> 2.34.0.rc2.393.gf8c9666880-goog

-- 

- Arnaldo
