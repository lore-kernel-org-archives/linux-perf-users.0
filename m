Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4C5C432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 18:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34CD26103D
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 18:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239094AbhHaSrV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 14:47:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36444 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238832AbhHaSrU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 14:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630435585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KFTC6adULqk7VN0qCgAsbieqFmciNW3ydRZqflVPMts=;
        b=TJycxKv2WZY4KN1N0CMt/HpAULPZST2RKizbBWRUlRl8xs5RLUaaVV7lIik5uwMQxrEL8g
        Lhcjv4Ay8IJVoPAiSdCalaav5f3E14AHeKsgLokIOvDK1ykKKmZVVbycIMOF6cOcf9o5Ul
        5p/9ZyKWht0nvy3R/gxXDB55TRcGhgY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-UHfBeK4GNcOWPOHdYl3Caw-1; Tue, 31 Aug 2021 14:46:23 -0400
X-MC-Unique: UHfBeK4GNcOWPOHdYl3Caw-1
Received: by mail-ej1-f69.google.com with SMTP id q15-20020a17090622cf00b005c42d287e6aso160069eja.18
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Aug 2021 11:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KFTC6adULqk7VN0qCgAsbieqFmciNW3ydRZqflVPMts=;
        b=DdmsD/1VrDjy3NGuyX1FytXAQ6ACm0VHaYAn9MmclVNFrSZz0J7Ypx0WRdJ5DxU5lt
         JfOA5x68vRmueC4R7ylNKzmZT2keKiSRgOWRGmmocrqFnzu4Apn8SeQPWvDKZZIPtkCj
         lHheGpHWQVhhex/QUPPvBzlzG3Tt/aeB2CHkCEJzV3TEUBS5S8o+MG0Gr5SzmWeGrBRJ
         AaCLE64yBEXwUpfP5GK1QpY9kzzTCdzX62IG/pYavL4m/ZDSt+z7SbW8U/Q6V2cSc6bq
         CnOIyiWVvGTZEUPhdhPCRXDegRYYiHQT/PeswoH/7BhUQ6jY2qdC0gK7S4yQDV1Igyl3
         U4nQ==
X-Gm-Message-State: AOAM533JHRzXPUDimlRzJ2hS2RUSDXgzZ+wDCIn0rjdt1YqowlnsuErm
        p/T0WWMZDkwsMBK9ucMEuW2WzKQ0q5L1xLcgYCcIbVn4FhHnXsqpO5W1ffud4iPtigxnUt7sgyt
        lbRD0gpKzzOXwOg3Ax4w/gm75S/Tqsg==
X-Received: by 2002:a17:906:11cc:: with SMTP id o12mr30580120eja.277.1630435582542;
        Tue, 31 Aug 2021 11:46:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwQDAVi2QgXcyDuwQXWHY9pp9GrWfMeCiqqRl8dCtXdHiNQV3cBFcP9rp5G8PhwWs6QJjOvw==
X-Received: by 2002:a17:906:11cc:: with SMTP id o12mr30580105eja.277.1630435582389;
        Tue, 31 Aug 2021 11:46:22 -0700 (PDT)
Received: from krava ([2a00:102a:4005:bb4:e4bf:9f13:dbe6:2d14])
        by smtp.gmail.com with ESMTPSA id q11sm9869708edv.73.2021.08.31.11.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 11:46:21 -0700 (PDT)
Date:   Tue, 31 Aug 2021 20:46:19 +0200
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
Subject: Re: [RFC PATCH] perf test: Workload test of metric and metricgroups
Message-ID: <YS52wU9r9U/x4lkb@krava>
References: <20210819055629.1059168-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819055629.1059168-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Aug 18, 2021 at 10:56:29PM -0700, Ian Rogers wrote:
> Test every metric and metricgroup with perf bench as a workload.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/stat_all_metricgroups.sh | 12 ++++++++++++
>  tools/perf/tests/shell/stat_all_metrics.sh      | 16 ++++++++++++++++
>  2 files changed, 28 insertions(+)
>  create mode 100755 tools/perf/tests/shell/stat_all_metricgroups.sh
>  create mode 100755 tools/perf/tests/shell/stat_all_metrics.sh
> 
> diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
> new file mode 100755
> index 000000000000..f0b7bda17970
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
> +  perf stat -M "$m" perf bench internals synthesize
> +done
> +
> +exit 0
> diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
> new file mode 100755
> index 000000000000..767396e81121
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
> +  result=$(perf stat -M "$m" perf bench internals synthesize)

good test, but takes forever.. running 'true' should be enough for the test?

jirka

> +  if [[ "$result" =~ "$m" ]]; then
> +    echo "Metric not printed: $m"
> +    exit 1
> +  fi
> +done
> +
> +exit 0
> -- 
> 2.33.0.rc1.237.g0d66db33f3-goog
> 

