Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77565EB64DD
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Jul 2023 21:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjGXVPX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Jul 2023 17:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjGXVPV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Jul 2023 17:15:21 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067A7139
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Jul 2023 14:15:20 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-63cf8754d95so8070906d6.1
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Jul 2023 14:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690233319; x=1690838119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4rysK55oB8iprX5PsN92lskw7NnrBKRNpCCq0EizyQ=;
        b=1BXELcHUXg/+rCkwfBoa14IfiR2Q6aqU9PgFbw47oz0uC3np3HFNCaFz7ScGSD5/Mq
         DQ2deQyYa6L8MreNAP/kbkznCiJ5lVuxnhfnrHFfd7TilrEZNfgf05J4hKAWXPiFXCKp
         w2saThXCYP65xSFqvvNKuNizMsmiRJkbU1CrPzPT6jgiRpEfH5PpOv1qTdGsIVNhCvAe
         Gntw2xb1FeAwbgsih7FPFGkyqFi3TaKSwJrgCjzW3MJ1FEezE8GysHleA1+80rYFJBqh
         nI1ugr89BQt/oT26XVioNDLE/paobBJMMPO2VpTFOpV8yTf+D95fnySZsTO0RH7SoWAV
         YxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690233319; x=1690838119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4rysK55oB8iprX5PsN92lskw7NnrBKRNpCCq0EizyQ=;
        b=DVP2MfMmV+AxKFbaVTWLwmett9ZtN56osotGNtCDAppGbWwhsO+n0M+i1LYAzOfqaz
         9vkfaPP/VMR9J4+U5+lonGDjwlrseoy8IeSQVsnmt1H8iU/E4mjzEesPjZbcJE/Uu/ps
         L9vDzGNYXSMNN9zZJ+ECrUpgj83GKH4DtcflIVIewuEZg389/13ozWSRxk4nC3cl0JG/
         82O7WzShr0aB4UEA8MUEt3+/a162RRbMQQ5BYh5e+o4w6N/CTvwUh0v2GdkQVp62lUcx
         k+xKXLIPGRDKc7NLTPPMVcjNEo4qQBgF7N3jaokndib25dDQr9MJ3YqVNOrbd/ci7Uoc
         oBEA==
X-Gm-Message-State: ABy/qLYwXlE55I76MfLXxXkgwIiVIwbms+7LSzRinW9yw3B74mS/diwa
        j5edI4H3ybgktLZQm1r6obrRB/VB3dKLuSmUf+gEnw==
X-Google-Smtp-Source: APBJJlGzkKPEZS/cCDJEywZijBo4Ycb4UpPFNxCPqzb5sG8S3hNQy1Vf6sw4+I8SpcgyjWOXfG3YKaJb/rNkKkoJIKU=
X-Received: by 2002:a0c:facf:0:b0:635:e4ed:b6c9 with SMTP id
 p15-20020a0cfacf000000b00635e4edb6c9mr949080qvo.24.1690233319030; Mon, 24 Jul
 2023 14:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230724201247.748146-1-irogers@google.com>
In-Reply-To: <20230724201247.748146-1-irogers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Jul 2023 14:15:07 -0700
Message-ID: <CAKwvOd=12eSPyc5ZRgm8NPMJYjj13QOxcnHtv_Y7Ws-zffyUrA@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Perf tool LTO support
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev, maskray@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jul 24, 2023 at 1:12=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Add a build flag, LTO=3D1, so that perf is built with the -flto
> flag. Address some build errors this configuration throws up.

Hi Ian,
Thanks for the performance numbers. Any sense of what the build time
numbers might look like for building perf with LTO?

Does `-flto=3Dthin` in clang's case make a meaningful difference of
`-flto`? I'd recommend that over "full LTO" `-flto` when the
performance difference of the result isn't too meaningful.  ThinLTO
should be faster to build, but I don't know that I've ever built perf,
so IDK what to expect.
--=20
Thanks,
~Nick Desaulniers
