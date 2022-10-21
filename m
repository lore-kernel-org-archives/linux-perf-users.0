Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A3FC43219
	for <linux-perf-users@archiver.kernel.org>; Fri, 21 Oct 2022 00:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiJUACt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 20 Oct 2022 20:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJUACs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 20 Oct 2022 20:02:48 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDAE22E8C4
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Oct 2022 17:02:46 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bv10so2159924wrb.4
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Oct 2022 17:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g0tXLeeeAU3F8Jn7158QLbBdSreE5CWF4BGqfvBib/E=;
        b=W8BszXRc3L9rOZMbFio2HR17eURTaVCmPO1K97+HvYdLlUJ+PB50lDJ5EcsqGpJ0wI
         6NRovIuu1hIS0QbInAt8ulY3XPKBN8HwBv0Vgljw3SoWfh915TiDxh5sMSENWrAp/qvF
         vsH5aD9qtG1LCMM4TWScmDKFMzDLZ/rvrkh3QVNdYMRn39gqGAorBAqLIMSwQ7N4NHy/
         QjPd4eB9N14ks6mLB5aJav/5LKioPKC2FqvY5e8larY/lU1diyhySw9lyQEpO4xVwCXd
         ILKzcOzXX7RlpaTbIlxvdaj6N+QsXYlzM573nn4WV0pqXR9MjRR/n5yn9v+Jwz5yT2+Y
         o+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g0tXLeeeAU3F8Jn7158QLbBdSreE5CWF4BGqfvBib/E=;
        b=KpkKOGTWYloFtSkzWaD6V1lTY1RpuE6k/OBwoq3Z8WQzTjrHKYDqUsHnUTDrlzm9ao
         w9fganFP7AnJoVHY8r8wT9zJwKyd8Lcil1/VhBnQ4ElXIxXBy4Rov7iQhLpynJcE+45E
         A/DVGVDV2lkhxxntTGnLNxzY9W0nxUZ8aCzvJ/z/8uQQEmiEg9lWGqztUN0up+H4DYnM
         HBSLTw68u5XpC1H+v1WWF8L7YPGbH3z2Yru/u9GaxV0rQD8AUvF55+C1b7cU+zj/S7gI
         Cjnj6bO7IAHKIsB4CL8yNd2C82YlZIcCf7ZebOoT0uKnbGMgnUXTRQw8YuZexMuxoFOm
         xyvw==
X-Gm-Message-State: ACrzQf3OTQlTJsgbAqdMC57GY7CmRXaEYz2hz9BzHWA15NHA+hwM+75y
        8TAvZ63fijSrLZxqt5BGLhT4sARYrKi2TuL4ZH9w5g==
X-Google-Smtp-Source: AMsMyM7wiItTvNOVVnd6tmij9VOFr3KQYEZYNqcGGG/7i26+pUy2oXOVyp4qXX7Pe0Fw/r6B8zN/Du4+Q7FZkfi4qNI=
X-Received: by 2002:adf:e711:0:b0:236:2f7f:4f08 with SMTP id
 c17-20020adfe711000000b002362f7f4f08mr3389855wrm.375.1666310565290; Thu, 20
 Oct 2022 17:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221020172643.3458767-1-namhyung@kernel.org> <20221020172643.3458767-8-namhyung@kernel.org>
In-Reply-To: <20221020172643.3458767-8-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 20 Oct 2022 17:02:33 -0700
Message-ID: <CAP-5=fXJcS6GoPePdT1PKAY3D7JpEQuBt2=YUgY2u+7Vv30K0g@mail.gmail.com>
Subject: Re: [PATCH 7/8] perf test: Test record with --threads option
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Oct 20, 2022 at 10:26 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The --threads option changed the perf record behavior significantly, so
> it'd be nice if we test it separately.  Add --threads options with
> different argument in each test supported and check the result.
>
> Also update the cleanup routine because threads recording produces data
> in a directory.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/record.sh | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index c59d1459c960..01aa9531b369 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -13,8 +13,8 @@ testprog=$(mktemp /tmp/__perf_test.prog.XXXXXX)
>  testsym="test_loop"
>
>  cleanup() {
> -  rm -f "${perfdata}"
> -  rm -f "${perfdata}".old
> +  rm -rf "${perfdata}"
> +  rm -rf "${perfdata}".old
>
>    if [ "${testprog}" != "true" ]; then
>      rm -f "${testprog}"
> @@ -171,6 +171,19 @@ test_system_wide() {
>      err=1
>      return
>    fi
> +  if ! perf record -aB --synth=no -e cpu-clock,cs --threads=cpu \
> +    -o "${perfdata}" ${testprog} 2> /dev/null
> +  then
> +    echo "System-wide record [Failed record --threads option]"
> +    err=1
> +    return
> +  fi
> +  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
> +  then
> +    echo "System-wide record [Failed --threads missing output]"
> +    err=1
> +    return
> +  fi
>    echo "Basic --system-wide mode test [Success]"
>  }
>
> @@ -188,6 +201,19 @@ test_workload() {
>      err=1
>      return
>    fi
> +  if ! perf record -e cpu-clock,cs --threads=package \
> +    -o "${perfdata}" ${testprog} 2> /dev/null
> +  then
> +    echo "Workload record [Failed record --threads option]"
> +    err=1
> +    return
> +  fi
> +  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
> +  then
> +    echo "Workload record [Failed --threads missing output]"
> +    err=1
> +    return
> +  fi
>    echo "Basic target workload test [Success]"
>  }
>
> --
> 2.38.0.135.g90850a2211-goog
>
