Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F05C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Sep 2021 07:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 938AE61185
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Sep 2021 07:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbhIPHbl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 16 Sep 2021 03:31:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49170 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232254AbhIPHbk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 16 Sep 2021 03:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631777420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=257yrPQS6KeYQm5bEFKU+lS9FYHPgLAN8rTbuc9lmLw=;
        b=WVAa48lu8UkOwHYJA7/o+QgiJWq5ImFe4YIfR4Gq5VZD9UuH9PFQ4EqGMOozfOqzC00b/5
        aYc6afE8Fck8CXEhB6f0cNJeLFCWlWxQpiMCtzfLaTz3+cFvKg6L5i0fjjf4sNZoNSBvta
        lCPfVICdzNqf8UOsfZ6cJORaNYXUfN0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-rdiXGYqCNnmvzCbkmNw8rA-1; Thu, 16 Sep 2021 03:30:18 -0400
X-MC-Unique: rdiXGYqCNnmvzCbkmNw8rA-1
Received: by mail-wm1-f69.google.com with SMTP id q4-20020a1c4304000000b00306cd53b671so404202wma.1
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Sep 2021 00:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=257yrPQS6KeYQm5bEFKU+lS9FYHPgLAN8rTbuc9lmLw=;
        b=pEhX8rts6KSAevdNiQq5j+yjfVHA3eeU3F6/UmNheOAflqmqRpMm642K7gXstdMUd7
         Jt4+9mWVDpcJ44TzM+56iAo+3XWLZEgJ0eTCpRL4Uqr5sicMnAqUfiiz+Ofw+wbtqJsn
         ZH8o2OPZqFWgDrmbvETtOXkDn8Y91Pc2hZjlcax8FQazX7ktbruAFoa0UTdKtUPrysDm
         2B+mTAAT33GGKtTfwXdZH/wJP9QuykAm16+PDabbIk9htbrNYcFGTlfHVOAroIlNa/aN
         deRC3UWvO1c4xn3idsaHCzR7Txo8dO6TmxwOiIfJWGCxctQXyJG/PWOHHtav8TjExvQC
         cr5g==
X-Gm-Message-State: AOAM532+Z1EnBgii3RRUpsHSYxg+LeqUG+RgUWVviPhpqsTRNy8Fndxw
        kt/z+QCRz0plVHkZd6sMq+fl2LyBJAsl+qdNn6sLsRcd79zTEkwkFZ6BqoFGqxLCLxFVLoenCZb
        oSFenFQdTmjX4chHckGGTTEtywUU+og==
X-Received: by 2002:a1c:3bd7:: with SMTP id i206mr8431271wma.115.1631777417679;
        Thu, 16 Sep 2021 00:30:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/Q8RcskLaagNg4DGjNaPXj2RP+aICamk0pnhLgNm8IgTBGSH/sRpY2GxquQ5RQpePwlcc5A==
X-Received: by 2002:a1c:3bd7:: with SMTP id i206mr8431246wma.115.1631777417340;
        Thu, 16 Sep 2021 00:30:17 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id d2sm2371591wrc.32.2021.09.16.00.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 00:30:17 -0700 (PDT)
Date:   Thu, 16 Sep 2021 09:30:15 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH v2] perf test: Workload test of metric and metricgroups
Message-ID: <YULyhx+ZxjEIOMsi@krava>
References: <20210916060525.1890638-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916060525.1890638-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Sep 15, 2021 at 11:05:25PM -0700, Ian Rogers wrote:
> Test every metric and metricgroup with 'true' as a workload.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/tests/shell/stat_all_metricgroups.sh | 12 ++++++++++++
>  tools/perf/tests/shell/stat_all_metrics.sh      | 16 ++++++++++++++++
>  2 files changed, 28 insertions(+)
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
> index 000000000000..81b19ba27e68
> --- /dev/null
> +++ b/tools/perf/tests/shell/stat_all_metrics.sh
> @@ -0,0 +1,16 @@
> +#!/bin/sh
> +# perf all metrics test
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +for m in `perf list --raw-dump metrics`; do
> +  echo "Testing $m"
> +  result=$(perf stat -M "$m" true)
> +  if [[ "$result" =~ "$m" ]]; then
> +    echo "Metric not printed: $m"
> +    exit 1
> +  fi
> +done
> +
> +exit 0
> -- 
> 2.33.0.309.g3052b89438-goog
> 

