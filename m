Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14344C4321E
	for <linux-perf-users@archiver.kernel.org>; Wed, 30 Nov 2022 18:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiK3SVB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 30 Nov 2022 13:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiK3SUn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 30 Nov 2022 13:20:43 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15A4900F4
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Nov 2022 10:19:02 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bs21so28466121wrb.4
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Nov 2022 10:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fgu8phfMhKqBmtg33wW3nBetrVGXeqIPlKFIzQyzHSE=;
        b=ox0llSKbUV33fVKayZ94bqh6RIiowGJSjB4lHoLTXWoY2LU97rN03LY2+LpiYKjeL/
         D9jPWzVdlXrhznZlJ1aWOpRYnPrabNfPcqyIYAp9zGyo0CH14h78qgtV2gTBcHNn5kCZ
         CmSZEzdZ+qiQ05FA2vQKfm5P+yd0apR2NNeoZwq0u0DzJhBY0QOimZyXOFTZVuNqCB9+
         LAixtDEorDow7ulWNhzFJLUYMPRPhdahTbclh9FuW6JXo0TfSQA8tnS+N5ogjKSrl9RQ
         nnD6owBMqyfpv8PdVhlxbp53JfnsO43JK9aJOTJhcj/Gk7mSEgwy4t6xR6AGB2WBcw9g
         dRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fgu8phfMhKqBmtg33wW3nBetrVGXeqIPlKFIzQyzHSE=;
        b=lWP+j6epGw8IrED5MTc6xMA5SjS6xGdzVsKLDwAatxPw6IRiHR6DgoJDyl+jbjg83z
         1OPXedTLDG9M7jyS0vAvEFCMka86Lev/aMOhdusiQW71rTWZkkNVPV58MtLcouGCUGhv
         0Ec//gic8YaB71dvMYagfHIPoTNiyD1cuA6iJ+g68dU4AbzP0gXKKre67r6ksGRMvf0z
         9girFPGYCRrcpsv85kau/zjmKvsaV0GP4vA4+RSVoRl52zPTkxt3GQBswV7OHLcFmjRT
         rO+mkTLqQexYD0EPBuwy2CVgDON+NT8n7M+dEY7sanv8zR3o2Z9prVCn7L8oJOS6VAMJ
         GZQA==
X-Gm-Message-State: ANoB5pk6FMlWtPDiELSPsHHFY+GUOe8irttT/qVYBD+abpPjgFaEd3HA
        AykW++7B/fSPLpY7ZChhdeuwZiimPvschs/1q8UR+w==
X-Google-Smtp-Source: AA0mqf7q8VTTrzTKldEos1qVFeXlA/uLx7N/l/591H87s4Rq0SRrdvmhSWW92FWA4Hloe92km3yhOweWjeOdf68dmYk=
X-Received: by 2002:a5d:4a8c:0:b0:242:165e:7a79 with SMTP id
 o12-20020a5d4a8c000000b00242165e7a79mr10250216wrq.343.1669832341136; Wed, 30
 Nov 2022 10:19:01 -0800 (PST)
MIME-Version: 1.0
References: <20221130111521.334152-1-james.clark@arm.com>
In-Reply-To: <20221130111521.334152-1-james.clark@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 30 Nov 2022 10:18:49 -0800
Message-ID: <CAP-5=fXAhs-xgOo9GPH-w5f1QxNBCt5pdzpC5Cr7K+ovPzdgzw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf tests: Fix "perf stat JSON output linter" test
 for new output
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Nov 30, 2022 at 3:15 AM James Clark <james.clark@arm.com> wrote:
>
> Commit c4b41b83c250 ("perf stat: Rename "aggregate-number" to
> "cpu-count" in JSON") renamed a field, so update the tests to reflect
> this.
>
> This fixes the following failure:
>
>   $ sudo ./perf test "json output" -vvv
>    96: perf stat JSON output linter                                    :
>   --- start ---
>   test child forked, pid 327720
>   Checking json output: no args [Success]
>   Checking json output: system wide [Success]
>   Checking json output: interval [Success]
>   Checking json output: event [Success]
>   Checking json output: per thread [Success]
>   Checking json output: per node Test failed for input:
>   ...
>   Traceback (most recent call last):
>     File "./tools/perf/tests/shell/lib/perf_json_output_lint.py", line 93, in <module>
>       check_json_output(expected_items)
>     File "./tools/perf/tests/shell/lib/perf_json_output_lint.py", line 78, in check_json_output
>       raise RuntimeError(f'Unexpected key: key={key} value={value}')
>   RuntimeError: Unexpected key: key=cpu-count value=16
>   test child finished with -1
>   ---- end ----
>   perf stat JSON output linter: FAILED!
>
> Fixes: c4b41b83c250 ("perf stat: Rename "aggregate-number" to "cpu-count" in JSON")
> Signed-off-by: James Clark <james.clark@arm.com>

Namhyung mentioned reverting change c4b41b83c250, in which case
merging this would break the test again. I think the revert is better.

Thanks,
Ian

> ---
>  tools/perf/tests/shell/lib/perf_json_output_lint.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> index d90f8d102eb9..9c073e257d33 100644
> --- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
> +++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> @@ -54,7 +54,7 @@ def check_json_output(expected_items):
>            raise RuntimeError(f'wrong number of fields. counted {count} expected {expected_items}'
>                               f' in \'{line}\'')
>    checks = {
> -      'aggregate-number': lambda x: isfloat(x),
> +      'cpu-count': lambda x: isfloat(x),
>        'core': lambda x: True,
>        'counter-value': lambda x: is_counter_value(x),
>        'cgroup': lambda x: True,
> --
> 2.25.1
>
