Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51918C636D4
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Feb 2023 16:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjBOQIk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Feb 2023 11:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjBOQIe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Feb 2023 11:08:34 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB75B3B0C5
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Feb 2023 08:08:33 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id co8so15932921wrb.1
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Feb 2023 08:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EaaYKvifs5/XPz/Up3NUWNbyTIr26a1o0EiTmg6eKpE=;
        b=qlFYFp4IIgyhBDPuwv5IRIcI39sgv54AkLvrVnd7qatTm0FEZPkHmhUP09eHDWz892
         OmQMs6oPA5QP+SBpBKqLva7P6essILiEgggFMPHabsBIHG5KRLWSAcPFg+D7VKNpHMm4
         PUFvBx8aoXGY8Fg9vqh+/H+ZI7QdmWeN0/NQa1ZIRrfb8/GAyH4Cd9ugFEYHDQIypJ3e
         cFmpHFvQ3GaXQ61ZvuKlG7T9J0xlByhgUafO9xHHMJPL1JMqsmPzkrtuxJxUui6132Lt
         ozJ1KRorb7N68npr6OQZYbxJAz8zK9XWTkdRaNjxfX1ux6PqRT/Igd3obVkWR5dBl3GK
         2svw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EaaYKvifs5/XPz/Up3NUWNbyTIr26a1o0EiTmg6eKpE=;
        b=cGiWDPby94LoZJXNzFBihLL87bw+6lkKPLpvVSPO9Mk6d2FLFboDyly0gMs93boYXX
         V3BJL/qsW6HJevFQMk4a3i5q+mmSVPk7d4IK+dwyrXxtxvR/L8liwpuvztEGrps7CtqE
         bf5kfQ/9+EDh/b9TLvzoY+D57r6dyJo6r3KwxtP7nxkU9fLfjYeOc9auSeFE5DH2JQW+
         5TKMk3k1P/P0cFFVqzHmTA6qQKv2QBUNVav/yYFHvBxaNOIMZb+Fmj4bpJdeW7RBvdbD
         /YzFbj9ya0hHku81D+t3CQXNBF5CXcNFCpS0mDbcoX6GtcoAxujSjuYs3Iy2sOtKxrko
         ETvw==
X-Gm-Message-State: AO0yUKX6AEovHbKguMIQDb3YAYGt1DMjqPIeSzDCbuYNc+YapZig2U3l
        vBIq621p11pm4V9LoNGqfv/A6XJa7kn8vz0MOLCjnu+cG6lAcmSm3cc=
X-Google-Smtp-Source: AK7set9oZTUHZ85e+Dy7ZzDz3afu+aZYDANsm5QI+W07eXpr6GkYCCklY2OCazeDPEQGnlS3wUsniRuKLsjLGD0H5Fc=
X-Received: by 2002:a5d:4f01:0:b0:2c5:5574:3784 with SMTP id
 c1-20020a5d4f01000000b002c555743784mr59871wru.188.1676477312011; Wed, 15 Feb
 2023 08:08:32 -0800 (PST)
MIME-Version: 1.0
References: <20230215093827.124921-1-kjain@linux.ibm.com>
In-Reply-To: <20230215093827.124921-1-kjain@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 15 Feb 2023 08:08:20 -0800
Message-ID: <CAP-5=fWZxs432h_Vohe0WXaCATiUrTugpMzbYpKMseJpuj0h-g@mail.gmail.com>
Subject: Re: [PATCH v2] tools/perf/tests: Change true workload to sleep
 workload in all metric test for system wide check
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        rnsastry@linux.ibm.com, disgoel@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Feb 15, 2023 at 1:38 AM Kajol Jain <kjain@linux.ibm.com> wrote:
>
> Testcase stat_all_metrics.sh fails in powerpc:
>
> 98: perf all metrics test : FAILED!
>
> Logs with verbose:
>
> [command]# ./perf test 98 -vv
>  98: perf all metrics test                                           :
>  --- start ---
> test child forked, pid 13262
> Testing BRU_STALL_CPI
> Testing COMPLETION_STALL_CPI
>  ----
> Testing TOTAL_LOCAL_NODE_PUMPS_P23
> Metric 'TOTAL_LOCAL_NODE_PUMPS_P23' not printed in:
> Error:
> Invalid event (hv_24x7/PM_PB_LNS_PUMP23,chip=3/) in per-thread mode, enable system wide with '-a'.
> Testing TOTAL_LOCAL_NODE_PUMPS_RETRIES_P01
> Metric 'TOTAL_LOCAL_NODE_PUMPS_RETRIES_P01' not printed in:
> Error:
> Invalid event (hv_24x7/PM_PB_RTY_LNS_PUMP01,chip=3/) in per-thread mode, enable system wide with '-a'.
>  ----
>
> Based on above logs, we could see some of the hv-24x7 metric events fails,
> and logs suggest to run the metric event with -a option.
> This change happened after the commit a4b8cfcabb1d ("perf stat: Delay metric
> parsing"), which delayed the metric parsing phase and now before metric parsing
> phase perf tool identifies, whether target is system-wide or not. With this
> change, perf_event_open will fails with workload monitoring for uncore events
> as expected.
>
> The perf all metric test case fails as some of the hv-24x7 metric events
> may need bigger workload with system wide monitoring to get the data.
> Fix this issue by changing current system wide check from true workload to
> sleep 0.01 workload.
>
> Result with the patch changes in powerpc:
>
> 98: perf all metrics test : Ok
>
> Reviewed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Tested-by: Disha Goel <disgoel@linux.ibm.com>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>

Tested-by: Ian Rogers <irogers@google.com>

The mention of a4b8cfcabb1d  can be moved to a Fixes tag so that this
is backported.

Thanks,
Ian

> ---
> Changelog:
>
> v1->v2:
> - Addressed review comments from Ian, by changing true workload
>   to sleep workload in "perf all metric test". Rather then adding
>   new system wide check with perf bench workload.
> - Added Reviewed-by, Tested-by and Suggested-by tags.
>
>  tools/perf/tests/shell/stat_all_metrics.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
> index 6e79349e42be..22e9cb294b40 100755
> --- a/tools/perf/tests/shell/stat_all_metrics.sh
> +++ b/tools/perf/tests/shell/stat_all_metrics.sh
> @@ -11,7 +11,7 @@ for m in $(perf list --raw-dump metrics); do
>      continue
>    fi
>    # Failed so try system wide.
> -  result=$(perf stat -M "$m" -a true 2>&1)
> +  result=$(perf stat -M "$m" -a sleep 0.01 2>&1)
>    if [[ "$result" =~ "${m:0:50}" ]]
>    then
>      continue
> --
> 2.39.1
>
