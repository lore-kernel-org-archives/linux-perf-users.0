Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BFEC0015E
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Aug 2023 18:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbjHOSJx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Aug 2023 14:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238264AbjHOSJk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Aug 2023 14:09:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF74E106;
        Tue, 15 Aug 2023 11:09:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 445CD653DD;
        Tue, 15 Aug 2023 18:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F85C433C7;
        Tue, 15 Aug 2023 18:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692122978;
        bh=qKBDYXEsLAiqhhXTOyN5Rg5B1VHjDt+sAODeVHKcrY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iVwgRhXKMByL5SSCpROf5pwdgD6EnlmgvA5wNbCdiI17Ywl7RhJCUod2OzRasc6Cu
         wrFVRJsB1akVw7TFbXBI8WN+bcb1BW16KLgQf8FAMBgFyx00WW4syQxZDxWQEyXtw0
         NlS7DwREtJdM0UXoYYaBZLHpY46/Qh/k3yIXW7ApSSzsVPP1oxg1lQlzACXmxzvLA2
         TkmzNhjeCgYJGyNjOB3Tn8e3By12hia6Bp0RGZkuWHgei4CJ8JvKwiCDRHI4hdGn0Z
         5oO6ODIfyP/PDfvLduSDisU3EWOnHDAXYrAQuB+7Ddi9840T4Qk6ho9UqxUWwg90V1
         M05PnPQbbuz8w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0FB66404DF; Tue, 15 Aug 2023 15:09:36 -0300 (-03)
Date:   Tue, 15 Aug 2023 15:09:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, irogers@google.com,
        john.g.garry@oracle.com, renyu.zj@linux.alibaba.com,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: Re: [PATCH v5 1/6] perf: cs-etm: Don't duplicate FIELD_GET()
Message-ID: <ZNu/X/zt1RkXiJbL@kernel.org>
References: <20230811144017.491628-1-james.clark@arm.com>
 <20230811144017.491628-2-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811144017.491628-2-james.clark@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Aug 11, 2023 at 03:39:18PM +0100, James Clark escreveu:
> linux/bitfield.h can be included as long as linux/kernel.h is included
> first, so change the order of the includes and drop the duplicate macro.

Applied this one, to reduce the patch series size.

- Arnaldo
 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/cs-etm.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 1419b40dfbe8..9729d006550d 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -6,10 +6,11 @@
>   * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
>   */
>  
> +#include <linux/kernel.h>
> +#include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/coresight-pmu.h>
>  #include <linux/err.h>
> -#include <linux/kernel.h>
>  #include <linux/log2.h>
>  #include <linux/types.h>
>  #include <linux/zalloc.h>
> @@ -281,17 +282,6 @@ static int cs_etm__metadata_set_trace_id(u8 trace_chan_id, u64 *cpu_metadata)
>  	return 0;
>  }
>  
> -/*
> - * FIELD_GET (linux/bitfield.h) not available outside kernel code,
> - * and the header contains too many dependencies to just copy over,
> - * so roll our own based on the original
> - */
> -#define __bf_shf(x) (__builtin_ffsll(x) - 1)
> -#define FIELD_GET(_mask, _reg)						\
> -	({								\
> -		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
> -	})
> -
>  /*
>   * Get a metadata for a specific cpu from an array.
>   *
> -- 
> 2.34.1
> 

-- 

- Arnaldo
