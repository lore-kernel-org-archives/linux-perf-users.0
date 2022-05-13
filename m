Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95542C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 May 2022 18:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383323AbiEMSdB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 13 May 2022 14:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383352AbiEMSdA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 May 2022 14:33:00 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D677828E3B
        for <linux-perf-users@vger.kernel.org>; Fri, 13 May 2022 11:32:58 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id t12so4617006vkt.5
        for <linux-perf-users@vger.kernel.org>; Fri, 13 May 2022 11:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UFf5Q+rPZWFlwxbruD9mEK3GGUJ5TDV+dFP9Ogo+EEY=;
        b=nmRRtC83/FAP/XCofwyh9YtCWj24sUP7ZHPXBO4+gp3Qsj4xnqTuGQkgYm51zkVlE1
         bnaQXVkreD/u27e7d6c2f/NaYoXesUMcal397EsLm6IloZzshUWIiBniyzHaLF6FJ99/
         A3QY610WzlPl3Hhic4Nur8/VNFGwOH3/1bHFcca6Jnhb7IgBY2MtaEDJlP/gT9FlQVfm
         04zkq/xWEAehEymHgiz/w9z7ESizM4iToF++RTyQT9QlhWjJ9Zy7tyWDJKilT9ytL9lu
         DGlutkahdBnxVbc9NYyz/0jS5e2iG76yesrqTrbOEAM42/+7HwhSCMLD0O8NJZCJH5R8
         MUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UFf5Q+rPZWFlwxbruD9mEK3GGUJ5TDV+dFP9Ogo+EEY=;
        b=ZscJRGN7aZChjRAECMF1Dl/j9MgAuOWAbj3IYxwwDbT4HiiV5aRk1WLHpjtmBPp+Xb
         xzePcU7fEOLOaydFydRPE+jbj3zj6eb08KHf75aucn/xsOY9P1nlCTLgliViKGBYfcUg
         //uJqPXR/zursU9c6S3ONtOb2Dgubo3Uw4vrZ8++piC5S2XGa0tA+S2W7C/l7Jc2v0YO
         EQ66WZaV7EcK+7ZIGUrXcCRvHAcbKtNPeFreZzukvu8rhm5OdR+cGb6aj+LuBD3U6ldB
         7kKlfRAz9vnQh6lHHVIeG/UCL7DLpRtPZi4e+/nxWq7uwzq6PZpGDzPs1uWd92Z2Wz/7
         muGQ==
X-Gm-Message-State: AOAM532KRLlNR1Ru6trf3TBGbP2fGm2uPA7/3Eod0Ok7v4GQqnG0KZ1E
        R+ETmANeGpbQKftbIN/ipu7L0q0OVEjJWEdxiG3mpRXpJQ2y4g==
X-Google-Smtp-Source: ABdhPJx7MS1mGT06m/TZc33QRflyBrwzQPiiU9PrGQlrymD/eEqsWLY7m+a09rLOoqeE5sqfIW2M4EKnmu5mTftpzkk=
X-Received: by 2002:a1f:9fc4:0:b0:345:5848:4f44 with SMTP id
 i187-20020a1f9fc4000000b0034558484f44mr2919556vke.2.1652466777767; Fri, 13
 May 2022 11:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220511115438.84032-1-atrajeev@linux.vnet.ibm.com> <be9726bc462d3b00243bd2161fb8e153b919db1e.camel@linux.vnet.ibm.com>
In-Reply-To: <be9726bc462d3b00243bd2161fb8e153b919db1e.camel@linux.vnet.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 13 May 2022 11:32:45 -0700
Message-ID: <CAP-5=fX7XXHUzQvKQf-bmWxkJpMUTaRSca8oOo4w-3TgF_mHYQ@mail.gmail.com>
Subject: Re: [PATCH V2] tools/perf/tests: Skip perf BPF test if clang is not present
To:     Disha Goel <disgoel@linux.vnet.ibm.com>
Cc:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org,
        jolsa@kernel.org, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        kjain@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, May 12, 2022 at 11:16 PM Disha Goel <disgoel@linux.vnet.ibm.com> wrote:
>
>
>
> -----Original Message-----
> From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> To: acme@kernel.org, jolsa@kernel.org
> Cc: mpe@ellerman.id.au, linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com, irogers@google.com
> Subject: [PATCH V2] tools/perf/tests: Skip perf BPF test if clang is not present
> Date: Wed, 11 May 2022 17:24:38 +0530
>
> Perf BPF filter test fails in environment where "clang"
>
> is not installed.
>
>
> Test failure logs:
>
>
> <<>>
>
>  42: BPF filter                    :
>
>  42.1: Basic BPF filtering         : Skip
>
>  42.2: BPF pinning                 : FAILED!
>
>  42.3: BPF prologue generation     : FAILED!
>
> <<>>
>
>
> Enabling verbose option provided debug logs which says
>
> clang/llvm needs to be installed. Snippet of verbose logs:
>
>
> <<>>
>
>  42.2: BPF pinning                  :
>
>  --- start ---
>
> test child forked, pid 61423
>
> ERROR: unable to find clang.
>
> Hint: Try to install latest clang/llvm to support BPF.
>
>         Check your $PATH
>
>
> <<logs_here>>
>
>
> Failed to compile test case: 'Basic BPF llvm compile'
>
> Unable to get BPF object, fix kbuild first
>
> test child finished with -1
>
>  ---- end ----
>
> BPF filter subtest 2: FAILED!
>
> <<>>
>
>
> Here subtests, "BPF pinning" and "BPF prologue generation"
>
> failed and logs shows clang/llvm is needed. After installing
>
> clang, testcase passes.
>
>
> Reason on why subtest failure happens though logs has proper
>
> debug information:
>
> Main function __test__bpf calls test_llvm__fetch_bpf_obj by
>
> passing 4th argument as true ( 4th arguments maps to parameter
>
> "force" in test_llvm__fetch_bpf_obj ). But this will cause
>
> test_llvm__fetch_bpf_obj to skip the check for clang/llvm.
>
>
> Snippet of code part which checks for clang based on
>
> parameter "force" in test_llvm__fetch_bpf_obj:
>
>
> <<>>
>
> if (!force && (!llvm_param.user_set_param &&
>
> <<>>
>
>
> Since force is set to "false", test won't get skipped and
>
> fails to compile test case. The BPF code compilation needs
>
> clang, So pass the fourth argument as "false" and also skip
>
> the test if reason for return is "TEST_SKIP"
>
>
> After the patch:
>
>
> <<>>
>
>  42: BPF filter                    :
>
>  42.1: Basic BPF filtering         : Skip
>
>  42.2: BPF pinning                 : Skip
>
>  42.3: BPF prologue generation     : Skip
>
> <<>>
>
>
> Fixes: ba1fae431e74 ("perf test: Add 'perf test BPF'")
>
> Signed-off-by: Athira Rajeev <
>
> atrajeev@linux.vnet.ibm.com
>
> >
>
> ---
>
> Changelog:
>
>  Addressed review comments from Arnaldo by adding
>
>  reason for skipping of testcase.
>
>
>  tools/perf/tests/bpf.c | 10 ++++++----
>
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
>
> Tested the patch on powerpc and powernv, perf BPF test works fine with the patch.
>
> Tested-by: Disha Goel <disgoel@linux.vnet.ibm.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
>
> index 57b9591f7cbb..17c023823713 100644
>
> --- a/tools/perf/tests/bpf.c
>
> +++ b/tools/perf/tests/bpf.c
>
> @@ -222,11 +222,11 @@ static int __test__bpf(int idx)
>
>
>   ret = test_llvm__fetch_bpf_obj(&obj_buf, &obj_buf_sz,
>
>         bpf_testcase_table[idx].prog_id,
>
> -       true, NULL);
>
> +       false, NULL);
>
>   if (ret != TEST_OK || !obj_buf || !obj_buf_sz) {
>
>   pr_debug("Unable to get BPF object, %s\n",
>
>   bpf_testcase_table[idx].msg_compile_fail);
>
> - if (idx == 0)
>
> + if ((idx == 0) || (ret == TEST_SKIP))
>
>   return TEST_SKIP;
>
>   else
>
>   return TEST_FAIL;
>
> @@ -364,9 +364,11 @@ static int test__bpf_prologue_test(struct test_suite *test __maybe_unused,
>
>  static struct test_case bpf_tests[] = {
>
>  #ifdef HAVE_LIBBPF_SUPPORT
>
>   TEST_CASE("Basic BPF filtering", basic_bpf_test),
>
> - TEST_CASE("BPF pinning", bpf_pinning),
>
> + TEST_CASE_REASON("BPF pinning", bpf_pinning,
>
> + "clang isn't installed or environment missing BPF support"),
>
>  #ifdef HAVE_BPF_PROLOGUE
>
> - TEST_CASE("BPF prologue generation", bpf_prologue_test),
>
> + TEST_CASE_REASON("BPF prologue generation", bpf_prologue_test,
>
> + "clang isn't installed or environment missing BPF support"),
>
>  #else
>
>   TEST_CASE_REASON("BPF prologue generation", bpf_prologue_test, "not compiled in"),
>
>  #endif
