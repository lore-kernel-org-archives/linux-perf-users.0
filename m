Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BB8EB64D8
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Jun 2023 20:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjFPUhw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 16 Jun 2023 16:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjFPUhv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Jun 2023 16:37:51 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF213AA5
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Jun 2023 13:37:49 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3f9a81da5d7so62121cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Jun 2023 13:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686947869; x=1689539869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaWZAOYq9Kz+9I2rgSdZyzJkt4bwO6CIJObyuxXrsHk=;
        b=i84PUsAizzUSJ+I0fhdEyeE7PIh8vQ+ME3lGoIHMXeMSSTH15j1W+NTeAk60gbjrpo
         FthamMcN45HSyYjMwK60VazmXAaaEnB2+j/JzbSunlJmUrn3PVyaZe7YhNOzzmA5cwmr
         loDQbdhRGT80iDR/qBUhdLRR09AIrwYTzPQtRGw7iqk46WlhcqntOrfL7A185IrKsevd
         odgV5jvc90k8/8gkOK6R1jk9W4O8HEEvtG7q3+GkTMapY6J8114iJ+zFsLP/1watHsHN
         37CRKJ2A6CliCez4wi8nL8/CMlOQqQ+3qdctFAcxitxVkLuch+vUNtaiR9qqKlUEexvY
         WD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686947869; x=1689539869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QaWZAOYq9Kz+9I2rgSdZyzJkt4bwO6CIJObyuxXrsHk=;
        b=Gg2FHkDwzdWlfuBHkc+8bdbdc53P9ZY+OmptnWTgWaUfC6AQu7ZYL4HITubY7DMD9t
         8uV3TFThsHVoerkRtZmr8EaZo9szsWUxfqpt62gt05+KkuGl7aOpvpkORbOKEffoFIVH
         RbBFaOQ/1cxFz9zjwok32cHkLU0WpBIuohDf/OztvFUawc0LaeZ/qSUp2xRmUtHBO5Ax
         RwILpAPHBSoA48eApODNPc5hKCA8yQhDbrMl+D4TcMIV2/2ZqimJxDEvL6RltSKiZqqT
         xcI1NHHMJm8cTKwR0+L1GHGfBVllyINVFaH2gv6dbyR455a50OHQI+h0q/TxSP/pR7mX
         dEPg==
X-Gm-Message-State: AC+VfDwpw0DSZb9UTJKMjvM2UpNqC4wI5dwxct+zBOzBRw9Alho0vSUC
        7TClnKRMLElhSG+WakBHiM28XUTamx4sAuo7W53X6w==
X-Google-Smtp-Source: ACHHUZ40HrYcnoK4CGXFjzBr80ourtV091ZlZtRSVYrio5xnaZTqaHSFo3Z6gsW0TercQW+GgffUlmuKxKsPKQj+x1w=
X-Received: by 2002:a05:622a:44:b0:3f9:f877:1129 with SMTP id
 y4-20020a05622a004400b003f9f8771129mr569817qtw.29.1686947868680; Fri, 16 Jun
 2023 13:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <202306161546.17ace7b9-oliver.sang@intel.com>
In-Reply-To: <202306161546.17ace7b9-oliver.sang@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 16 Jun 2023 13:37:36 -0700
Message-ID: <CAP-5=fWxEjvK+ed-FFLuKT=AThhS_nH1ejOw=of7Shnu8oH-dw@mail.gmail.com>
Subject: Re: [linux-next:master] [perf parse] 70c90e4a6b: perf-test.perf_hw_event_sample_group.group_sampe_cpu-cycles_cache-misses_and_cpu-cycles_cache-misses_instructions_HAS_FIX_NO_NMI_R1.fail
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ingo Molnar <mingo@redhat.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Perry Taylor <perry.taylor@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Samantha Alt <samantha.alt@intel.com>,
        Stephane Eranian <eranian@google.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Weilin Wang <weilin.wang@intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 16, 2023 at 1:15=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "perf-test.perf_hw_event_sample_group.group_sam=
pe_cpu-cycles_cache-misses_and_cpu-cycles_cache-misses_instructions_HAS_FIX=
_NO_NMI_R1.fail" on:

Failure is a memory leak that I believe was fixed in:
https://lore.kernel.org/r/20230608232823.4027869-20-irogers@google.com

Thanks,
Ian

> commit: 70c90e4a6b2fbe775b662eafefae51f64d627790 ("perf parse-events: Avo=
id scanning PMUs before parsing")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> [test failed on linux-next/master 925294c9aa184801cc0a451b69a18dd0fe7d847=
d]
>
> in testcase: perf-test
> version: perf-test-x86_64-git-1_20220520
> with following parameters:
>
>         type: lkp
>         group: group-00
>
> test-description: The internal Perf Test suite.
>
>
> compiler: gcc-12
> test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapp=
hire Rapids) with 256G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202306161546.17ace7b9-oliver.san=
g@intel.com
>
>
>
> Test Case group_sampe_cpu-cycles_cache-misses_and_cpu-cycles_cache-misses=
_instructions_NO_FIX_HAS_NMI_R1 FAILED!
>
>
> besides, we also observed below difference between this commit and its pa=
rent
>
> 442eeb77044705f2 70c90e4a6b2fbe775b662eafefa
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :6          100%           6:6     perf-test.perf_hw_event_sam=
ple_group.group_sampe_cpu-cycles_cache-misses_and_cpu-cycles_cache-misses_i=
nstructions_HAS_FIX_NO_NMI_R1.fail
>            :6          100%           6:6     perf-test.perf_hw_event_sam=
ple_group.group_sampe_cpu-cycles_cache-misses_and_cpu-cycles_cache-misses_i=
nstructions_NO_FIX_HAS_NMI_R1.fail
>            :6          100%           6:6     perf-test.perf_hw_event_sam=
ple_group.group_sampe_cpu-cycles_instructions_k_HAS_FIX_NO_NMI_R1.fail
>            :6          100%           6:6     perf-test.perf_hw_event_sam=
ple_group.group_sampe_cpu-cycles_instructions_k_NO_FIX_HAS_NMI_R1.fail
>
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in=
 this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file =
for lkp run
>         sudo bin/lkp run generated-yaml-file
>
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
>
