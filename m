Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2855DC77B7C
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 May 2023 23:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjEEXoG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 May 2023 19:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjEEXoF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 May 2023 19:44:05 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5585FE0;
        Fri,  5 May 2023 16:44:03 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-b9a6f17f2b6so16535570276.1;
        Fri, 05 May 2023 16:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683330243; x=1685922243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VWVwxZIs17EWQgN1pMsqtqITHwPVpRT/J8MlrKIuf0=;
        b=C2MUZgswslksx+JUOU1qPojPDLZMWut1Kkg0eQCooDH5b2YNyEpUBUda4UDAzkBSBq
         ZdNttltoCOZ4pq3Iyv9erC0ipGaJ8d+9kY8AzbclJgjM+DM5jerVzYGAyd0HydFHrcWJ
         3Wk0EiytStcGohcv5bs/SxCYBuj9QyWxJFkcQNNqwKityZ6KQEkbp6jBv1bu9jPkaHkL
         fQaApvZGR+Z27ICj464baUERG/SGkkaYzwtpE/HRNz9jgLeGHAXtMliF/IE9Uzxx4seL
         eo0gHHkikiQBCbHMaT8rUSUEaEU1oXuhSieYAo0PlekonPoVTaQMnweHPFGDgXt8Y4OU
         +H+A==
X-Gm-Message-State: AC+VfDzbpiqv3tTWWhtogazfgklKCemcVJY+olWzamZKV22ljg7h2NMj
        Io0f42jVZijgIqHsg1WAk46yKoZ03u676yAzLOM=
X-Google-Smtp-Source: ACHHUZ6t7vln0PDR6zfyAtsdsfhDAr3DtC9YEHncbwx3EogvaxvcUX9cVuniMmYDEdAimDdVXZRwT7xXfzZWxHQGs9I=
X-Received: by 2002:a25:4f57:0:b0:b9e:2ef0:de90 with SMTP id
 d84-20020a254f57000000b00b9e2ef0de90mr5369318ybb.17.1683330242744; Fri, 05
 May 2023 16:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <83d6c6c05c54bf00c5a9df32ac160718efca0c7a.1683280603.git.sandipan.das@amd.com>
 <6a5429879764e3dac984cbb11ee2d95cc1604161.1683280603.git.sandipan.das@amd.com>
In-Reply-To: <6a5429879764e3dac984cbb11ee2d95cc1604161.1683280603.git.sandipan.das@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 5 May 2023 16:43:51 -0700
Message-ID: <CAM9d7cinMnb03jU=ZzEbPhBkbd7-rL1CMaQ41ZBnaD2ysqDVBA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Add stat test for record and script
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        terrelln@fb.com, ravi.bangoria@amd.com, ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, May 5, 2023 at 3:03 AM Sandipan Das <sandipan.das@amd.com> wrote:
>
> When using the global aggregation mode, running perf script after perf
> stat record can result in a segmentation fault as seen with commit
> 8b76a3188b85 ("perf stat: Remove unused perf_counts.aggr field"). Add a
> basic test to the existing suite of stat-related tests for checking if
> that workflow runs without erroring out.
>
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/tests/shell/stat.sh | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
> index 2c1d3f704995..b154fbb15d54 100755
> --- a/tools/perf/tests/shell/stat.sh
> +++ b/tools/perf/tests/shell/stat.sh
> @@ -28,6 +28,18 @@ test_stat_record_report() {
>    echo "stat record and report test [Success]"
>  }
>
> +test_stat_record_script() {
> +  echo "stat record and script test"
> +  if ! perf stat record -o - true | perf script -i - 2>&1 | \
> +    grep -E -q "CPU[[:space:]]+THREAD[[:space:]]+VAL[[:space:]]+ENA[[:space:]]+RUN[[:space:]]+TIME[[:space:]]+EVENT"
> +  then
> +    echo "stat record and script test [Failed]"
> +    err=1
> +    return
> +  fi
> +  echo "stat record and script test [Success]"
> +}
> +
>  test_stat_repeat_weak_groups() {
>    echo "stat repeat weak groups test"
>    if ! perf stat -e '{cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles}' \
> @@ -93,6 +105,7 @@ test_topdown_weak_groups() {
>
>  test_default_stat
>  test_stat_record_report
> +test_stat_record_script
>  test_stat_repeat_weak_groups
>  test_topdown_groups
>  test_topdown_weak_groups
> --
> 2.34.1
>
