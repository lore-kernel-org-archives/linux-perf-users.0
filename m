Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41FFEB64DA
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 Jul 2023 01:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjGMBQo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 12 Jul 2023 21:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjGMBQm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 Jul 2023 21:16:42 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E99127
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2023 18:16:41 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-401d1d967beso94831cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2023 18:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689211000; x=1691803000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSajZfL2Fg0+J9rUBR1X7rs0ogrromMkaV9GMdpQR6o=;
        b=XlqLAMO8KVLs1TgPlknrE6np08aOXrPRvw+L2tMV9m7sq4cerUQI28bzwucqz4ZvKR
         5Qh2oEcw0Zo/mjU/R8lxQs2TcTqzi6ZxHRubE5t8HMI/rM1VLEKlU66qEhA5wq41Ruw8
         cbKpyduCN4YEVU41hb5FI+kLzjRE3gIaa601AD/53TZI+zDXk2wB7SmilloNJDq/P8rx
         RaYucwWdy/fOEvIrv2fOmzn+7Rkc9SELBzkG3pmiS6U73oQ0qpobN80vF3Hu4pzoG43Z
         9CEv57kaChhbKa0Gm2oTKyOXwSo2HOeB7uRvxCR3GlnwXBpaCtzs2D9g46/gLuAfnNK+
         CNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689211000; x=1691803000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSajZfL2Fg0+J9rUBR1X7rs0ogrromMkaV9GMdpQR6o=;
        b=Xo+GHHAz77Dr2kT8o4gTug5rJY+hJxViK3YJsKIqEk83Y/+0h6Xt9FsO9PdBpW4Bo0
         zH+GUo59IiIl6dTPsWQPy6WuW55eq7y+G0yEHMD9jNfNn74ChE8pKWMdlfPeXJFXIJfc
         e7NgFUxheJxBTLdOsTMPW78MJs5cv/GVMba354AXuhaycU0MfR/efVGjUMaYlBH8k66k
         gudTT+XlPCsIjz4J3UfDt43UoeWzwa21qCkwHaW/epZ5YU8Szw/mHQ9Zlp+8yeo3GkGv
         JSqPYRnabVEFbv5kMy1Qnju/grUmFE0Zl4sKtlt1f1RKjVTqjSE858fu1AHckev1oGX9
         iIqg==
X-Gm-Message-State: ABy/qLYOIPIQMdnkPeXZPJL8J6WsHluQefgnPeAz1mQ0dQW/0/WCDfgH
        44NCsQsnYCHC8XxIG1rp5W9Kn+FyYiro0gIEYm9ucVTofhNjMZWs8T//Gw==
X-Google-Smtp-Source: APBJJlHgGYB6bDXnHoALNNfwk4u4ow9Nn1d4x5+8cXY/amZiok4oGbJ2v94RKPuDwgASCfqSsRhVT8uRXOFTtnAzD10=
X-Received: by 2002:a05:622a:178a:b0:3f9:56c:1129 with SMTP id
 s10-20020a05622a178a00b003f9056c1129mr357429qtk.5.1689211000179; Wed, 12 Jul
 2023 18:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230613164145.50488-1-atrajeev@linux.vnet.ibm.com> <20230613164145.50488-18-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20230613164145.50488-18-atrajeev@linux.vnet.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 12 Jul 2023 18:16:28 -0700
Message-ID: <CAP-5=fUYTjPjL0c_R6F=RTOaRtbOvctVubvn6S1hxLYd5g1o3A@mail.gmail.com>
Subject: Re: [PATCH 17/17] perf tests task_analyzer: skip tests if no
 libtraceevent support
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     acme@kernel.org, jolsa@kernel.org, namhyung@kernel.org,
        ravi.bangoria@amd.com, john.g.garry@oracle.com,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, Aditya Gupta <adityag@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jun 13, 2023 at 10:04=E2=80=AFAM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
> From: Aditya Gupta <adityag@linux.ibm.com>
>
> Test "perf script task-analyzer tests" fails in environment with missing
> libtraceevent support, as perf record fails to create the perf.data
> file, which further tests depend on.
>
> Instead, when perf is not compiled with libtraceevent support, skip those
> tests instead of failing them, by checking the output of `perf
> record --dry-run` to see if it prints the error "libtraceevent is
> necessary for tracepoint support"
>
> For the following output, perf compiled with: `make NO_LIBTRACEEVENT=3D1`
>
> Before the patch:
>
> 108: perf script task-analyzer tests                                 :
> test child forked, pid 24105
> failed to open perf.data: No such file or directory  (try 'perf record' f=
irst)
> FAIL: "invokation of perf script report task-analyzer command failed" Err=
or message: ""
> FAIL: "test_basic" Error message: "Failed to find required string:'Comm'.=
"
> failed to open perf.data: No such file or directory  (try 'perf record' f=
irst)
> FAIL: "invokation of perf script report task-analyzer --ns --rename-comms=
-by-tids 0:random command failed" Error message: ""
> FAIL: "test_ns_rename" Error message: "Failed to find required string:'Co=
mm'."
> failed to open perf.data: No such file or directory  (try 'perf record' f=
irst)
> <...>
> perf script task-analyzer tests: FAILED!
>
> With this patch, the script instead returns 2 signifying SKIP, and after
> the patch:
>
> 108: perf script task-analyzer tests                                 :
> test child forked, pid 26010
> libtraceevent is necessary for tracepoint support
> WARN: Skipping tests. No libtraceevent support
> test child finished with -2
> perf script task-analyzer tests: Skip
>
> Fixes: e8478b84d6ba ("perf test: add new task-analyzer tests")
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>  tools/perf/tests/shell/test_task_analyzer.sh | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/te=
sts/shell/test_task_analyzer.sh
> index b094eeb3bf66..59785dfc11f8 100755
> --- a/tools/perf/tests/shell/test_task_analyzer.sh
> +++ b/tools/perf/tests/shell/test_task_analyzer.sh
> @@ -44,9 +44,20 @@ find_str_or_fail() {
>         fi
>  }
>
> +# check if perf is compiled with libtraceevent support
> +skip_no_probe_record_support() {
> +       perf record -e "sched:sched_switch" -a -- sleep 1 2>&1 | grep "li=
btraceevent is necessary for tracepoint support" && return 2

Fwiw, another way to detect build options used in other shell tests is:
perf version --build-options | grep HAVE_LIBTRACEEVENT | grep -q OFF && ret=
urn 2

Thanks,
Ian

> +       return 0
> +}
> +
>  prepare_perf_data() {
>         # 1s should be sufficient to catch at least some switches
>         perf record -e sched:sched_switch -a -- sleep 1 > /dev/null 2>&1
> +       # check if perf data file got created in above step.
> +       if [ ! -e "perf.data" ]; then
> +               printf "FAIL: perf record failed to create \"perf.data\" =
\n"
> +               return 1
> +       fi
>  }
>
>  # check standard inkvokation with no arguments
> @@ -134,6 +145,13 @@ test_csvsummary_extended() {
>         find_str_or_fail "Out-Out;" csvsummary "${FUNCNAME[0]}"
>  }
>
> +skip_no_probe_record_support
> +err=3D$?
> +if [ $err -ne 0 ]; then
> +       echo "WARN: Skipping tests. No libtraceevent support"
> +       cleanup
> +       exit $err
> +fi
>  prepare_perf_data
>  test_basic
>  test_ns_rename
> --
> 2.39.1
>
