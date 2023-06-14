Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADDEEB64D8
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jun 2023 16:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjFNQko (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Jun 2023 12:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbjFNQkS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Jun 2023 12:40:18 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF421EC
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jun 2023 09:40:17 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-33d928a268eso227895ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jun 2023 09:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686760817; x=1689352817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruP+GyZYH4LxbCyC+eS55NOUZ4Djslwx0JaDdpKV0nA=;
        b=xl+MNLTWWBgUoNFwnzqJGkdMUBpP9M39OjxechrhSjIVAXxOZN/KUacf5TY20Sv772
         l9JBQucWaC5obuBxXoe42aeTZKU3AZlKVidoQtXzU5nWwDBeJiIDvlzYEgIrIve2qiMo
         d3YnUOaD+JN2kdffImZ3PhuKkHGUlMCeRrMy3YGUiSM/MpxCOqdlo96bHNkuk6DjU9pF
         u5gTdUPPOmJicj3v092hl82TpDs7lM/uCMNTk4R3Fjt5hni6+H7PyGComKNVHjVDHoXz
         tkB3fMVTxnEXu0+mnc5EtoKfqbdJE9cVQORww7zRUut2kyixh/4pam2JINB2aYwROPw9
         b2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686760817; x=1689352817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ruP+GyZYH4LxbCyC+eS55NOUZ4Djslwx0JaDdpKV0nA=;
        b=QMj2FX6Nm5J1OsG3zoTHf1Lw4Oc3qXo9gpHGJGcN9Z2XMAwngmuIOh6lM3JrrI2CNT
         1ws+LzIbhjpeA89xur7qg/z5D8K7i2Pvs1DAFBagFIa095QS2qDrfIEkKo2pFxrmRe4Z
         4ZphvsqQS58egaf3bnOUuhHe99b3QHa6zPhV4dElrwNu7NKv6l8+uQJTCmmztxSXatt6
         jm+2UKjfmxRhRzlwfpj4PzaHaTED7653DrU9Lk0WBanhecgQ3fvwSu9gAddoBSJ16gWa
         U2XJmfGkOYqZ7jOnmxshk2FY8zPyt3wawq5j8JCehSp5yLsh83jan1/XcqSMnWdiIEru
         8x4Q==
X-Gm-Message-State: AC+VfDwfma9OZ37GkpdoxDf3kPH745jOQlpujz1JWIVWbaJEE1xZc+tz
        zpHPI9tJNSn+tde5CGZQsqDlR53P+1muaDKXt8pYTA==
X-Google-Smtp-Source: ACHHUZ4ExjVj5y92ljUlZnjZOFn5rxTIFsaGIRm2Qgu5g4Tt7LrdpcwgwQ1/+kAqzKKWJz7KKHourmLP6Nfcb/+fJP8=
X-Received: by 2002:a05:6e02:1aad:b0:33b:4a8c:2147 with SMTP id
 l13-20020a056e021aad00b0033b4a8c2147mr260935ilv.8.1686760816976; Wed, 14 Jun
 2023 09:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230614090710.680330-1-sandipan.das@amd.com>
In-Reply-To: <20230614090710.680330-1-sandipan.das@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Jun 2023 09:40:05 -0700
Message-ID: <CAP-5=fV9Fx99QmKWSqqDK23vF0dcTS+g-r-9zr6q0A2ZXWmCBw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Retry without grouping for all metrics test
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        kjain@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        barnali@linux.ibm.com, ayush.jain3@amd.com, ananth.narayan@amd.com,
        ravi.bangoria@amd.com, santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 14, 2023 at 2:07=E2=80=AFAM Sandipan Das <sandipan.das@amd.com>=
 wrote:
>
> There are cases where a metric uses more events than the number of
> counters. E.g. AMD Zen, Zen 2 and Zen 3 processors have four data fabric
> counters but the "nps1_die_to_dram" metric has eight events. By default,
> the constituent events are placed in a group. Since the events cannot be
> scheduled at the same time, the metric is not computed. The all metrics
> test also fails because of this.

Thanks Sandipan. So this is exposing a bug in the AMD data fabric PMU
driver. When the events are added the driver should create a fake PMU,
check that adding the group is valid and if not fail. The failure is
picked up by the tool and it will remove the group.

I appreciate the need for a time machine to make such a fix work. To
workaround the issue with the metrics add:
"MetricConstraint": "NO_GROUP_EVENTS",
to each metric in the json.

> Before announcing failure, the test can try multiple options for each
> available metric. After system-wide mode fails, retry once again with
> the "--metric-no-group" option.
>
> E.g.
>
>   $ sudo perf test -v 100
>
> Before:
>
>   100: perf all metrics test                                           :
>   --- start ---
>   test child forked, pid 672731
>   Testing branch_misprediction_ratio
>   Testing all_remote_links_outbound
>   Testing nps1_die_to_dram
>   Metric 'nps1_die_to_dram' not printed in:
>   Error:
>   Invalid event (dram_channel_data_controller_4) in per-thread mode, enab=
le system wide with '-a'.

This error doesn't relate to grouping, so I'm confused about having it
in the commit message, aside from the test failure.

Thanks,
Ian

>   Testing macro_ops_dispatched
>   Testing all_l2_cache_accesses
>   Testing all_l2_cache_hits
>   Testing all_l2_cache_misses
>   Testing ic_fetch_miss_ratio
>   Testing l2_cache_accesses_from_l2_hwpf
>   Testing l2_cache_misses_from_l2_hwpf
>   Testing op_cache_fetch_miss_ratio
>   Testing l3_read_miss_latency
>   Testing l1_itlb_misses
>   test child finished with -1
>   ---- end ----
>   perf all metrics test: FAILED!
>
> After:
>
>   100: perf all metrics test                                           :
>   --- start ---
>   test child forked, pid 672887
>   Testing branch_misprediction_ratio
>   Testing all_remote_links_outbound
>   Testing nps1_die_to_dram
>   Testing macro_ops_dispatched
>   Testing all_l2_cache_accesses
>   Testing all_l2_cache_hits
>   Testing all_l2_cache_misses
>   Testing ic_fetch_miss_ratio
>   Testing l2_cache_accesses_from_l2_hwpf
>   Testing l2_cache_misses_from_l2_hwpf
>   Testing op_cache_fetch_miss_ratio
>   Testing l3_read_miss_latency
>   Testing l1_itlb_misses
>   test child finished with 0
>   ---- end ----
>   perf all metrics test: Ok
>
> Reported-by: Ayush Jain <ayush.jain3@amd.com>
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---
>  tools/perf/tests/shell/stat_all_metrics.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/test=
s/shell/stat_all_metrics.sh
> index 54774525e18a..1e88ea8c5677 100755
> --- a/tools/perf/tests/shell/stat_all_metrics.sh
> +++ b/tools/perf/tests/shell/stat_all_metrics.sh
> @@ -16,6 +16,13 @@ for m in $(perf list --raw-dump metrics); do
>    then
>      continue
>    fi
> +  # Failed again, possibly there are not enough counters so retry system=
 wide
> +  # mode but without event grouping.
> +  result=3D$(perf stat -M "$m" --metric-no-group -a sleep 0.01 2>&1)
> +  if [[ "$result" =3D~ ${m:0:50} ]]
> +  then
> +    continue
> +  fi
>    # Failed again, possibly the workload was too small so retry with some=
thing
>    # longer.
>    result=3D$(perf stat -M "$m" perf bench internals synthesize 2>&1)
> --
> 2.34.1
>
