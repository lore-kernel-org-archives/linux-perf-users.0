Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD668C77B7F
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 May 2023 02:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjEIC7D (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 May 2023 22:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjEIC7C (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 May 2023 22:59:02 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D427283
        for <linux-perf-users@vger.kernel.org>; Mon,  8 May 2023 19:58:55 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1aaf21bb42bso37442335ad.2
        for <linux-perf-users@vger.kernel.org>; Mon, 08 May 2023 19:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683601134; x=1686193134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vyLj8HoVtfi4u1IfIfS6SKhJKc2AXFWhk5oxVikC/mQ=;
        b=T6QDiZzxsNNqW9dRgau/daPxt4FhkYs/ITGlQI+zGtIZhiA1yEAzgoUxaPr17QQTxB
         T2wOKECfJ8djM9wqroh20f+GmXIREVlfas6dSHHnnm5MGpu95hx4HmiCqyx2/8sPT/bg
         R/tMyLihWPoQg4iXsuBjyTx0SbjSGyCewtiXr3yORNoYtYtnbNR/98B5pogjIP16q0bp
         2VHuET4Q1daNAIp5nSumoTrXsyVBllUcUJOrA6t1Eo6QFLxMpHnphjLBTrzaGNsqcqAj
         b2umWICM7EmxusxFCNVIWIPL4LcV1y+VPsbZtrbrKQkuZ90lJqNf0Jj3+44nWWXE2wsr
         Yztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683601134; x=1686193134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyLj8HoVtfi4u1IfIfS6SKhJKc2AXFWhk5oxVikC/mQ=;
        b=juCY+e2gMDn+65aHOPGjPThkbByfla5twjnc079gT8kdv1ny1ExcIs0VadsF5wEjFS
         c2bOAvMjyXgaGzzO0sov7KBoWdbNhRaq0t7s6SH5ltNle7CweM5d3GegAPfXg3mgIUFS
         oL9fSaOGDCBmkGgjwlHviunX9R/JxpGZT4oZKwwS3pkSW662FB97INB3S6fgDcI522Io
         BniMNwNFOwhX5xLbMNuFrqjhPlzavmUn5FOSBSG0KR5hDlk2LJrEe1WiE/PDJe2NMUc0
         h63eGgYMgDK5DJtlVT9RqqA+ApzjQvM1R/05rDsSO2U1GpNLQ7LYpqK8AnzUFDsd9Bjt
         b8gQ==
X-Gm-Message-State: AC+VfDyGiixvQ2soFVPuxYiDB8HpuuAUigGvQ6+F/+LI55Jy3dZRlE9c
        srSoR7JiDf+nLVGGo69YEZ4s1Q==
X-Google-Smtp-Source: ACHHUZ5SGln/XR0RFcFjgz3GCNY/xB4lMkhVYaT5SM3anUrKBg8HdtL+v97rbfQYe8vYr8U7wtW4yA==
X-Received: by 2002:a17:902:a508:b0:1a9:baa4:8677 with SMTP id s8-20020a170902a50800b001a9baa48677mr12244693plq.11.1683601134308;
        Mon, 08 May 2023 19:58:54 -0700 (PDT)
Received: from leoy-yangtze.lan (211-75-219-209.hinet-ip.hinet.net. [211.75.219.209])
        by smtp.gmail.com with ESMTPSA id t1-20020a17090a448100b00246cc751c6bsm2228984pjg.46.2023.05.08.19.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 19:58:53 -0700 (PDT)
Date:   Tue, 9 May 2023 10:58:46 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf arm: Fix include path
Message-ID: <20230509025846.GD3374705@leoy-yangtze.lan>
References: <20230508213128.3622268-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508213128.3622268-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Ian,

On Mon, May 08, 2023 at 02:31:28PM -0700, Ian Rogers wrote:
> Change "../cs-etm.h" to just "cs-etm.h" as ../cs-etm.h doesn't exist.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/arm/util/pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
> index 860a8b42b4b5..46154c226fbb 100644
> --- a/tools/perf/arch/arm/util/pmu.c
> +++ b/tools/perf/arch/arm/util/pmu.c
> @@ -12,7 +12,7 @@
>  #include "arm-spe.h"
>  #include "hisi-ptt.h"
>  #include "../../../util/pmu.h"
> -#include "../cs-etm.h"

This code is a bit tricky.  Here it deliberately uses "../cs-etm.h" to
avoid including the header file in the same folder, alternatively, the
compiler option "-I/home/leoy/Work/linux/tools/perf/util/include" will
lead the C file to include "tools/perf/util/include/../cs-etm.h".

> +#include "cs-etm.h"

So with this change, perf will fail to build actually :)

We need to change to:

  #include "../../../util/cs-etm.h"

With above change:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

Thanks for code improvement!

>  struct perf_event_attr
>  *perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
> -- 
> 2.40.1.521.gf1e218fcd8-goog
> 
