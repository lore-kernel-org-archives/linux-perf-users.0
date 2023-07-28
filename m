Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A341EC001DF
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Jul 2023 15:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbjG1PdB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Jul 2023 11:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237387AbjG1Pc5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Jul 2023 11:32:57 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB77BA
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jul 2023 08:32:55 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40550136e54so343921cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jul 2023 08:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690558375; x=1691163175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNOg0EXSamEM9o3ja9MilpyYCufBJTvtg9ZDcyfGex4=;
        b=O6o6CJR+efnh2Rd1x3gBkpjz2jYaXC89CW3lvELho5JVHnA1DKuo2FqIP1Da7o9iKO
         EWC21S9tpnuD0gyX1bNHhEWRSsZyzHtquuAJGsfqkukfQKHwxEJmky+p+vqGLlOV0nTM
         PpYb/sTJjhPF1geEY+RaOQvpmc1yDbIRFypmKV2BkmtYQOCQQOnA0t+V1EqSja7gHUF6
         HhxYuMBrPVRo+MdZs2Xf6B5I5nzP7eesESk0IcXq0HfYJ1YjEXl4scPqzCXXrDWVWSrQ
         B5BGD1ri4Ng22fHC6hP2Ce2KnxtJyx6vxj4fQOdS0tWftr4O5ub1ZazbsnAfE8yNy1Fr
         /RqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690558375; x=1691163175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNOg0EXSamEM9o3ja9MilpyYCufBJTvtg9ZDcyfGex4=;
        b=Aqdje8nCXF3jD2gwsEuBtfBeKqT0gkq0kusVju4H1dbwVdFgfFc+Bq7Mg6ObVW9puW
         kOAhSkPMQxx02DR9E060sQrKeSlZ3Fe8TI8YdBAMevKNjlhY7YHUyJwD62lPekhN1AHh
         hAIo4CGfVKGlphTuZLL7Vv5pe6Agi9RAXlm4Tgxe+1lWARQvdjEHWTA1NGF7Y8tUYZKU
         hvDgV0qzVilRQEzCRDWf/PHAr5rCmBsYk5Vb9zVOB8SIPQr55YT3dpm1ZPIaC82otBRD
         jeRmGKYgE6SNpo/oa9jadT2zq9/yvYBloy3mL2AxTswbsR4IYHTlY7owaPMyOW/nMGe8
         kOew==
X-Gm-Message-State: ABy/qLY0dkzsHP/JxE0KeePhTZ3GFjydgQYZjDddgT0hYndURCpBTsSj
        AKy9QebSQ1JhU8gG2zno9GVWfS35xjYTsCFSzR0LcPd0RPudyemqmi4m/Q==
X-Google-Smtp-Source: APBJJlEkqDr3sniwwxnDwwds97PKuqSH3kZge5PvzgrBHBg9cpERp89CtG6C4FfQpRopbi35O6n1ZLB335sgClnE1o4=
X-Received: by 2002:ac8:4e8c:0:b0:403:9572:e37f with SMTP id
 12-20020ac84e8c000000b004039572e37fmr310444qtp.22.1690558374975; Fri, 28 Jul
 2023 08:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <f0508123-780b-3370-e64a-c78a350d76fa@linux.ibm.com>
In-Reply-To: <f0508123-780b-3370-e64a-c78a350d76fa@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 28 Jul 2023 08:32:43 -0700
Message-ID: <CAP-5=fVKbHc5K4LmmD0aCsB5xt_JAFBNKx7COvoSUEKQx2OzYQ@mail.gmail.com>
Subject: Re: perf test case 6 dumps core on s390 without PMU
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jul 28, 2023 at 7:30=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Using Linux 6.5.0rc3 perf test case 6 dumps core on an s390 without
> configured PMU (this can happen depending on customer machine configurati=
on).
>
> In this configuration several perf test cases fail:
>  # ./perf test 2>&1 | grep FAIL
>   6.1: Test event parsing                                : FAILED!
>  10.3: Parsing of PMU event table metrics                : FAILED!
>  10.4: Parsing of PMU event table metrics with fake PMUs : FAILED!
>  28: Use a dummy software event to keep tracking         : FAILED!
>  35: Track with sched_switch                             : FAILED!
>  66: Parse and process metrics                           : FAILED!
>  #
>
> Even worse the test case 6 dumps core:
>
>  # ./perf test -F 6
>   6: Parse event definition strings                      :
>   6.1: Test event parsing                                :
>  Segmentation fault (core dumped)
>  #

Thanks for reporting this!

> The root cause for these failures and core dump is a missing
> PMU, as can be seen by the debug output:
>    ...
>    Event test failure: test 57 'instructions:uep'
>    running test 58 '{cycles,cache-misses,branch-misses}:e'
>    No PMU found for 'cycles' <-- Here no PMU is found, because there is n=
one!
>    FAILED tests/parse-events.c:1516 wrong number of entries
>    Event test failure: test 58 '{cycles,cache-misses,branch-misses}:e'
> Here no PMU is found, because there is none!
>
>    ....
>    running test 59 'cycles/name=3Dname/'
>    No PMU found for 'name'
>    Segmentation fault (core dumped)
>
> Here the root cause in in function test__term_equal_term() variable
> evsel->name is NULL:
>
>  # gdb ./perf
> ....
> Breakpoint 1, test__term_equal_term (evlist=3D0x1542c00) at\
>                        tests/parse-events.c:1688
> (gdb) p evsel->name
> $3 =3D 0x3fff7fe3dc0 ""
> (gdb) n
>  691 TEST_ASSERT_VAL("wrong type", evsel->core.attr.type =3D=3D PERF_TYPE=
_HARDWARE);
> (gdb) n
> 1692 TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU=
_CYCLES));
> (gdb) n
> 1693 TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "name") =
=3D=3D 0);
> (gdb) n
>
> Program received signal SIGSEGV, Segmentation fault.
>
> I could fix this by checking for NULL pointer, but I have the
> feeling that there is more to it. However I do not fully understand
> the latest rework on the event handling.
>
> The other test cases listed above fail due to the same root cause,
> no PMU found.
>
> Please advise. What should all these test return when a system does
> not have any PMU defined at all?

So I was writing a response then figured out I've already fixed this
but it looks like the patch hasn't been taken yet:
https://lore.kernel.org/lkml/20230706183705.601412-1-irogers@google.com/

Arnaldo, could you take a look?

Thanks,
Ian



> Thanks a lot.
>
> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> Vorsitzender des Aufsichtsrats: Gregor Pillen
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
