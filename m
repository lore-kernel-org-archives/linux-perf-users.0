Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C30C4332F
	for <linux-perf-users@archiver.kernel.org>; Thu, 20 Oct 2022 23:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJTXob (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJTXo3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 20 Oct 2022 19:44:29 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC97611162
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Oct 2022 16:44:26 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j7so2117330wrr.3
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Oct 2022 16:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l8+bpSsSM29uvKB9yhvqF2P3Y/EvB9KhDMV5DKiLMeg=;
        b=HwApiV25u97jgY5tcdykxHIALxKtfLwpzsTiSDbMD39DiW8gtNtbKSyHc+erK+uvy3
         IqyPwwWQ256XIjMC+5SVYpZD9RTKU1yzc4g1EvadMAi1gx9qiXrXGmKC/cNttHLkM/sw
         IVakHqctix9Y/tm80eZ/MOVgmCH2WKg/TF8KO9nfeVbomUTqmgDidUUxKcpa4dOFY4zp
         yjI7q6ct4nerpubjMvZk7BUBJTwNSRSStX9WM7KcmpsmiM+T/sjy+FqEkdckYEDF7XE6
         Qw5eJHpHN9bEBmAUceYA/XmKi+qYfmck4zb38TgX+25aDkLq6SVtfoRm/gKY+TlAzs2Z
         uYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l8+bpSsSM29uvKB9yhvqF2P3Y/EvB9KhDMV5DKiLMeg=;
        b=z7ooOQOBndwowLNzDxBcbpK5BeF3cj3KmINmnsZqGR9mV1XGgjKwfgY0q8AdsI9kR1
         1inUCrnwfXvPY1MbIRIMqieM8JLYROddxfMHrcPyD28uc7A+esSbFl16WWHn0EVwAr5R
         ig4lAIft8UJ3k1AHVUaYmIvPF1GrNGcJY41M37WsLc067PDqB4ochoNb52Hc4M6poW9T
         ce0LImOibQW0ZpJVGBmrFYPK560Hv6cDprKBCp2D8EqTeZBMI0P/oooOApucPkWnARYv
         UN/6XCNjjtRwSrPjpFJpyniUxCsN0xsn70iksSseSYPLYSO5iVHFqB+PCq84YajayuXF
         YHkg==
X-Gm-Message-State: ACrzQf3e9laLfkL/BJ2LuntokvZc+rSq2LeFaeJrCJWx1h6RMRcwNiwR
        xmyD2f0Ywn0Qb6NDmpXWr7bSI+33hTJf608blXHbIA==
X-Google-Smtp-Source: AMsMyM5kRkmtVfi1zNhkyd6DLtpbcmuur0WfSqDe4oDduAdiz2XDPaMp09Ruu8USgyt6pHhlG9q3y78T/Y0V2HH7O/I=
X-Received: by 2002:a5d:4c92:0:b0:236:4b97:6828 with SMTP id
 z18-20020a5d4c92000000b002364b976828mr2228410wrs.300.1666309464991; Thu, 20
 Oct 2022 16:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221020192917.3542757-1-namhyung@kernel.org>
In-Reply-To: <20221020192917.3542757-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 20 Oct 2022 16:44:12 -0700
Message-ID: <CAP-5=fXxckG+-WK6_QSvrTZiczXdcc=42_42hE0DfK4_5wmXxw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Do not fail Intel-PT misc test w/o libpython
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

On Thu, Oct 20, 2022 at 12:29 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The virtuall LBR test uses a python script to check the max size of
> branch stack in the Intel-PT generated LBR.  But it didn't check whether
> python scripting is available (as it's optional).
>
> Let's skip the test if the python support is not available.
>
> Fixes: f77811a0f625 ("perf test: test_intel_pt.sh: Add 9 tests")
> Cc: Ammy Yi <ammy.yi@intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/shell/test_intel_pt.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
> index 4c0aabbe33bd..e66b7d977462 100755
> --- a/tools/perf/tests/shell/test_intel_pt.sh
> +++ b/tools/perf/tests/shell/test_intel_pt.sh
> @@ -526,6 +526,12 @@ test_kernel_trace()
>  test_virtual_lbr()
>  {
>         echo "--- Test virtual LBR ---"
> +       # Check if python script is supported
> +       libpython=$(ldd $(which perf) | grep -c python)
> +       if [ "${libpython}" != "1" ] ; then

Perhaps use -vv (taking care not to match "on" against "python"):

if perf -vv|grep libpython|grep -q " on"; then

Thanks,
Ian

> +               echo "SKIP: python scripting is not supported"
> +               return 2
> +       fi
>
>         # Python script to determine the maximum size of branch stacks
>         cat << "_end_of_file_" > "${maxbrstack}"
> --
> 2.38.0.135.g90850a2211-goog
>
