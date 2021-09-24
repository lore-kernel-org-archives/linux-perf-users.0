Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1ED8C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Sep 2021 19:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85074610FD
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Sep 2021 19:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346281AbhIXTKq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 24 Sep 2021 15:10:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhIXTKp (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 24 Sep 2021 15:10:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BA0961250;
        Fri, 24 Sep 2021 19:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632510552;
        bh=NwQH74aMnB1PseISd4nMEqKkBEsFOJREMogXH7iIssg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hlu/Pa10JGKN29fzEH0MrHdzCSzryn+RX2/diyZD2sEj6kkL0zCANjSzexgBpNlLq
         Crwn1rq2ZvIHSv6gyVFII+5mOpLUgvKI/yxCJIXguL4Xf4P/GMp3Xi0AJgHzOnOq3F
         m8UfPZD9kOREdnCPlANolYb/9QNVrGnYEZ29pYAiQRWhTNIaycBoLXpiGmFW8BY3F9
         XxMzn1PleDeMVLEJzzxNuXwlMRtpuB94YHYQ/F7Bz3sMY87s28EIKX27GdrocWY68V
         TWS65FVBjtuzvYDVbVTg1YWdd4N+KNmKmP4otSA8bhCvfZ3TK3WkVAZHJZHAMMtR92
         Qg0bdSZtptX6g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0AB5A410A1; Fri, 24 Sep 2021 16:09:10 -0300 (-03)
Date:   Fri, 24 Sep 2021 16:09:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH v3 1/2] perf test: Workload test of metric and
 metricgroups
Message-ID: <YU4iVcVc6uYAWft4@kernel.org>
References: <20210917184240.2181186-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917184240.2181186-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Sep 17, 2021 at 11:42:39AM -0700, Ian Rogers escreveu:
> Test every metric and metricgroup with 'true' as a workload. For
> metrics, check that we see the metric printed or get unsupported. If the
> 'true' workload executes too quickly retry with 'perf bench internals
> synthesize'.
> 
> v3. Fix test condition (thanks to Paul A. Clarke <pc@us.ibm.com>). Add a
>     fallback case of a larger workload so that we don't ignore "<not
>     counted>".
> v2. Switched the workload to something faster.

Hi John, does your Reviewed-by stands for v3 too?

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  .../perf/tests/shell/stat_all_metricgroups.sh | 12 ++++++++++
>  tools/perf/tests/shell/stat_all_metrics.sh    | 22 +++++++++++++++++++
>  2 files changed, 34 insertions(+)
>  create mode 100755 tools/perf/tests/shell/stat_all_metricgroups.sh
>  create mode 100755 tools/perf/tests/shell/stat_all_metrics.sh
> 
> diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
> new file mode 100755
> index 000000000000..de24d374ce24
> --- /dev/null
> +++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
> @@ -0,0 +1,12 @@
> +#!/bin/sh
> +# perf all metricgroups test
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +for m in $(perf list --raw-dump metricgroups); do
> +  echo "Testing $m"
> +  perf stat -M "$m" true
> +done
> +
> +exit 0
> diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
> new file mode 100755
> index 000000000000..7f4ba3cad632
> --- /dev/null
> +++ b/tools/perf/tests/shell/stat_all_metrics.sh
> @@ -0,0 +1,22 @@
> +#!/bin/sh
> +# perf all metrics test
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +for m in $(perf list --raw-dump metrics); do
> +  echo "Testing $m"
> +  result=$(perf stat -M "$m" true 2>&1)
> +  if [[ ! "$result" =~ "$m" ]] && [[ ! "$result" =~ "<not supported>" ]]; then
> +    # We failed to see the metric and the events are support. Possibly the
> +    # workload was too small so retry with something longer.
> +    result=$(perf stat -M "$m" perf bench internals synthesize 2>&1)
> +    if [[ ! "$result" =~ "$m" ]]; then
> +      echo "Metric '$m' not printed in:"
> +      echo "$result"
> +      exit 1
> +    fi
> +  fi
> +done
> +
> +exit 0
> -- 
> 2.33.0.464.g1972c5931b-goog

-- 

- Arnaldo
