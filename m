Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60A1C433FE
	for <linux-perf-users@archiver.kernel.org>; Fri, 21 Oct 2022 00:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiJUABw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 20 Oct 2022 20:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiJUABu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 20 Oct 2022 20:01:50 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33891F040A
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Oct 2022 17:01:49 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bk15so2060327wrb.13
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Oct 2022 17:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tVxqnzg2CQoXzM/FEJLJ4vB8d+PRNtldamw8EejWJiM=;
        b=WzRWLOfmifnX8e1gqHJc6StZxrr62W+fIUIanHn/GRcVFvbLOKPxXKA8HpBO+GwFym
         7Ze3y/pWGfhkDmBeUvkuliRZxVBYSpbH67b96ly9NBv3VKR+WJAEvLmhDEvt/LNpFLhA
         m/qoMViQr5IMTkt2rsnGEFSwDuLG9JtC3WjaUGacfgjUFwNAkgrQ+RwqSunVXAGaiS/p
         mFDIyKw6UuL8J3iezA5UlhxpiTDDtrUvT8/Dd/R+eBNjeO1AmBkctjFBcFmWm/QKCYXD
         ZcvyvVW3hObLcc7hmg6BiYJCuBGoasOmYUw7CcRhoGlsxB1tFHxM8f843FCe2qJsL6xF
         Zt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVxqnzg2CQoXzM/FEJLJ4vB8d+PRNtldamw8EejWJiM=;
        b=XskRbNseklzLM0SbOvzaxXcON8JoCM/dCxavSwl0LkATmy2qWQxn3w9iYv7lcU+Xf1
         j4AaR/nihd30bhxLuPoxL455uVsFiVxOnexFW596LUa4sfzDb4Cg5bv0JUc2PDpkKedz
         RwmerzvSVgHSjWJONWiVcnkTVSSLYkB8Pn/19Qw+N++bcMOyoExBwKGWEm6G3UppeqHl
         heD9+jpFjxN9S3YM5QmRFAku57cUdMPNyZgpuwb4U/v7DdDR7b+zhIqg6o0kN1Wc/Z4Q
         2+UZfZO/8tBlTtzRxeqdio+xFEWF0wMtfmquA/Pq/RmZ/LX6UfkA5R5H3viq2vnO8ZQv
         hnTA==
X-Gm-Message-State: ACrzQf1ZxZx23yotNN52hH0r+yB2fJK/l4ULUvTRHm9PDegX6Y8Y/O4/
        ilogkFaNypy5cvI44f0ONqPIjmUtUJztpE7/dn3dbg==
X-Google-Smtp-Source: AMsMyM5DL6pO4cZtMef+uj1ttL5V4D6aZYbBxqgnivzV6zY32D4jZYX/yn6Zip7TVuA5pCjpQo6lab4jkRRtkd0kZV4=
X-Received: by 2002:a5d:4c92:0:b0:236:4b97:6828 with SMTP id
 z18-20020a5d4c92000000b002364b976828mr2255308wrs.300.1666310508197; Thu, 20
 Oct 2022 17:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20221020172643.3458767-1-namhyung@kernel.org> <20221020172643.3458767-7-namhyung@kernel.org>
In-Reply-To: <20221020172643.3458767-7-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 20 Oct 2022 17:01:36 -0700
Message-ID: <CAP-5=fW0eS9C+K1DqXRJmU9nz02EpVxUSoJfWpYmMskBp8=gZQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] perf test: Add target workload test in perf record tests
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
> Add a subtest which profiles the given workload on the command line.
> As it's a minimal requirement, test should run ok so it doesn't skip
> the test even if it failed to run the perf record.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/record.sh | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 345764afb745..c59d1459c960 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -174,11 +174,29 @@ test_system_wide() {
>    echo "Basic --system-wide mode test [Success]"
>  }
>
> +test_workload() {
> +  echo "Basic target workload test"
> +  if ! perf record -o "${perfdata}" ${testprog} 2> /dev/null
> +  then
> +    echo "Workload record [Failed record]"
> +    err=1
> +    return
> +  fi
> +  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
> +  then
> +    echo "Workload record [Failed missing output]"
> +    err=1
> +    return
> +  fi
> +  echo "Basic target workload test [Success]"
> +}
> +
>  build_test_program
>
>  test_per_thread
>  test_register_capture
>  test_system_wide
> +test_workload
>
>  cleanup
>  exit $err
> --
> 2.38.0.135.g90850a2211-goog
>
