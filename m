Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A9EC38A2D
	for <linux-perf-users@archiver.kernel.org>; Fri, 21 Oct 2022 22:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJUWAV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 21 Oct 2022 18:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiJUWAU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 21 Oct 2022 18:00:20 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950AB17EF26
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Oct 2022 15:00:17 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l32so3127640wms.2
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Oct 2022 15:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fhok6/NjJ3lgD3XSBtpHWBa7hONW7Sg42t3Fv6voOSo=;
        b=gBIUjVTnBXjaaKpxrLw94mlXTaYQ3ZH7oz/RzFj9itX/WbjkVcA64/mmNzzHVRB7lv
         RTV0y4Zm6OkRZV6cH9p/gwAZByZRqVK/BMK2NJLQknvk3yrDUOWybyk+XdPDxjsPRGbb
         +pzUFJlUgyL+UMYC65SQyqOBh7i2s090yJUmu6hXTod5qVAvFo+yvsXViLPyg4bdswtv
         VoeXkfYlE1jH9X9Uf73hSCiCXNSk8UMcGy4zC8Mwf7llo25/OMAHdBtoP/13KdynurKg
         ZoKYWnS1vStTZ547Mq+UY3aXfPDXbt/9D3asXA/eORYpkii4ElIck/wJ5Nis1kQzmTo8
         nA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fhok6/NjJ3lgD3XSBtpHWBa7hONW7Sg42t3Fv6voOSo=;
        b=Rojg+Kv5Fxo7i6v7L/kancCOrWUV4jroddgLgfJXmIZkSp4W6O0AvdlDq8w2OwRlJr
         Umu27a5siNwJJcs8++wcCyTfZBvXSvKhehzKSZrqB7kAD5b3o72BJFzFF7Pc32zT1IdD
         StrHvFNW+URcUeTyq33s4lq87W/YEe+ujzVsWlMO+29bzgHSo/5oSTXvr8IZz8rEqlZo
         ImApyFCW02/UifHSM+78K2c1zcqfzXxdSIzKqDlMm0hNVq0T9lRHPo2kZKKiReTw+ogp
         rLscupR9el81xYbFIbPhw7YRbKmjX3VNjoPKzIOQRYiBhYO5fxUDNa/+mAw0mbOb0/dI
         Zvbw==
X-Gm-Message-State: ACrzQf1dZXLDhXlTwO1qoglHxHrg7bsKZKyK/EUTAQ92L0Pzrpi87bLS
        bsndiNlw+ThrN3lEUTC55eB5nDycshM13ymeRfBm6w==
X-Google-Smtp-Source: AMsMyM5zNI8Ni6t5s+a+q7ics0RkH7FIO0TJeg+pf0/1RO1KQi9sA28ISvNDGkBgOnuYVaTgczyfkr7YTnFMQQ9DrSI=
X-Received: by 2002:a05:600c:19cc:b0:3c6:fbb9:caab with SMTP id
 u12-20020a05600c19cc00b003c6fbb9caabmr16233710wmq.182.1666389616002; Fri, 21
 Oct 2022 15:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221021181055.60183-1-namhyung@kernel.org>
In-Reply-To: <20221021181055.60183-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 21 Oct 2022 15:00:04 -0700
Message-ID: <CAP-5=fWaqhZu0sUTgBogpeOxF1gf=V0CZjQ=2NDJEbVB-Cvjew@mail.gmail.com>
Subject: Re: [PATCH v2] perf test: Do not fail Intel-PT misc test w/o libpython
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Ammy Yi <ammy.yi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Oct 21, 2022 at 11:11 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The virtuall LBR test uses a python script to check the max size of

nit: virtual

> branch stack in the Intel-PT generated LBR.  But it didn't check whether
> python scripting is available (as it's optional).
>
> Let's skip the test if the python support is not available.
>
> Fixes: f77811a0f625 ("perf test: test_intel_pt.sh: Add 9 tests")
> Cc: Ammy Yi <ammy.yi@intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/test_intel_pt.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
> index 4c0aabbe33bd..f5ed7b1af419 100755
> --- a/tools/perf/tests/shell/test_intel_pt.sh
> +++ b/tools/perf/tests/shell/test_intel_pt.sh
> @@ -526,6 +526,12 @@ test_kernel_trace()
>  test_virtual_lbr()
>  {
>         echo "--- Test virtual LBR ---"
> +       # Check if python script is supported
> +       libpython=$(perf version --build-options | grep python | grep -cv OFF)
> +       if [ "${libpython}" != "1" ] ; then
> +               echo "SKIP: python scripting is not supported"
> +               return 2
> +       fi
>
>         # Python script to determine the maximum size of branch stacks
>         cat << "_end_of_file_" > "${maxbrstack}"
> --
> 2.38.0.135.g90850a2211-goog
>
