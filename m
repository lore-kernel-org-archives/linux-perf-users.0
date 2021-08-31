Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1093C432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8082260FC0
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240951AbhHaTrR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 15:47:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44474 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239416AbhHaTrR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 15:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630439181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JbsDcQi9+tbyXZDR5CIqGrD1csX+7PF4JUplNCUvRk4=;
        b=hnhMrsrjFH6LiMQqEatHK7ldJB6i9SvZ9w/fovpcOO+c7ZwCXpq76VUcSUj5N+KpzfCgpE
        ZhfcV9D4GyroU9GGSPDMLap3UDyOm+q0P505KJxVS6VkS0/eOtZ53FEhi7ZT1Pu/BCpP41
        r/DJn8ys86JK9oDuFot1568OzYPB0k4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-3oH5AXuxNzeOqngTF5Fxkg-1; Tue, 31 Aug 2021 15:46:19 -0400
X-MC-Unique: 3oH5AXuxNzeOqngTF5Fxkg-1
Received: by mail-wr1-f69.google.com with SMTP id v6-20020adfe4c6000000b001574f9d8336so177818wrm.15
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Aug 2021 12:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JbsDcQi9+tbyXZDR5CIqGrD1csX+7PF4JUplNCUvRk4=;
        b=l9rxZ0mGTmtrExjW2uKvDpCczsK5d3+qpyS0qqr00iPWj0tPhHSfjzgsAw3OmoIkwO
         QEyVbH/H84IZh+QXk3SZfb+faCf/4bM2hLDYPnOkLOueqYIsNSoRyInstGST9nI1vZ0N
         WRMPdFQPITIIwLw9CQEAfRTYGHTSNz+EHuuuGvpHAPHr2NhiS/+UkpZ6UvdKG6Fg9Bnw
         s9gnomETNsOfBRynUxZLWclErDS649Oey1eNIU30Y0fB+0TtoWX7ylEtWFKo2eGgK8aS
         Uxgrc4VN05+UAQPmnT6wYfk4JtuhdJur7bpOtiUR1DkSBPDrW3CWtDaaKXPilLsz0uOF
         TyjA==
X-Gm-Message-State: AOAM531XHhp3aiuTAEnccCbTf0CJNARga6w+6VecWH2pP0WlwBdmjm2K
        5oAx3YD8coSZvEUJl33nC3k2JgYUWXLKqsaDvd+LUtzySiffbz0j+0EOPGe8fu6/RNSbK62cecn
        H12iQRfn7Fxy56qjFxRZWYTgfTJhj7w==
X-Received: by 2002:a1c:4a:: with SMTP id 71mr5973749wma.87.1630439178731;
        Tue, 31 Aug 2021 12:46:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJlafOLCXOjX2PtuQJHG2n6VBGGXk0m1mXJS3MwTC2N4+ljO0WY609pknsPhvUXYHcVpBPQg==
X-Received: by 2002:a1c:4a:: with SMTP id 71mr5973732wma.87.1630439178528;
        Tue, 31 Aug 2021 12:46:18 -0700 (PDT)
Received: from krava ([94.113.247.3])
        by smtp.gmail.com with ESMTPSA id s205sm3396242wme.4.2021.08.31.12.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 12:46:18 -0700 (PDT)
Date:   Tue, 31 Aug 2021 21:46:10 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Claire Jensen <cjense@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, yao.jin@linux.intel.com, song@kernel.org,
        andi@firstfloor.org, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, james.clark@arm.com,
        alexander.antonov@linux.intel.com, changbin.du@intel.com,
        liuqi115@huawei.com, irogers@google.com, eranian@google.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        clairej735@gmail.com
Subject: Re: [PATCH v2 1/1] Add field checking tests for perf stat JSON
 output.
Message-ID: <YS6HAvjCxq4kDk5z@krava>
References: <20210813220936.2105426-1-cjense@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813220936.2105426-1-cjense@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Aug 13, 2021 at 10:09:37PM +0000, Claire Jensen wrote:
> Counts number of fields to make sure expected fields are present.
> 
> Signed-off-by: Claire Jensen <cjense@google.com>
> ---
>  .../tests/shell/lib/perf_json_output_lint.py  |  48 ++++++++
>  tools/perf/tests/shell/stat+json_output.sh    | 114 ++++++++++++++++++
>  2 files changed, 162 insertions(+)
>  create mode 100644 tools/perf/tests/shell/lib/perf_json_output_lint.py
>  create mode 100644 tools/perf/tests/shell/stat+json_output.sh

this one needs to have exec priv, right?

> 
> diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> new file mode 100644
> index 000000000000..45d9163e7423
> --- /dev/null

SNIP

> diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/tests/shell/stat+json_output.sh
> new file mode 100644
> index 000000000000..8a772badae45
> --- /dev/null
> +++ b/tools/perf/tests/shell/stat+json_output.sh
> @@ -0,0 +1,114 @@
> +#!/bin/bash
> +# perf stat JSON output linter
> +# SPDX-License-Identifier: GPL-2.0
> +# Checks various perf stat JSON output commands for the
> +# correct number of fields.
> +
> +set -e
> +set -x
> +
> +pythonchecker=$(dirname $0)/lib/perf_json_output_lint.py
> +file="/proc/sys/kernel/perf_event_paranoid"
> +paranoia=$(cat "$file" | grep -o -E '[0-9]+')
> +
> +check_no_args()
> +{
> +	perf stat -j sleep 1 2>&1 | \

hum, is this based on some other change? I don't see -j option in perf stat

jirka

> +	python $pythonchecker --no-args
> +}
> +
> +if [ $paranoia -gt 0 ];
> +then
> +	echo check_all_cpus test skipped because of paranoia level.
> +else
> +	check_all_cpus()
> +	{
> +		perf stat -j -a 2>&1 sleep 1 | \
> +		python $pythonchecker --all-cpus
> +	}

SNIP

