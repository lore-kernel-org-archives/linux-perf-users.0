Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F076C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Feb 2022 17:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243820AbiBQRlM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 17 Feb 2022 12:41:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243814AbiBQRlM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 17 Feb 2022 12:41:12 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FDC2B3ACE
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Feb 2022 09:40:57 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2d07ae0b1c5so40119747b3.5
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Feb 2022 09:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xG7+45oqf2NS1ULMFZPBvVQbomZLDhmCLViBMWlu/5k=;
        b=hz0dRrKJ7PWqiodgggDAx7ROzkgUjtT6NmpVRxtVC0QGo4NeVEVB+VN8NLY0fNtCgt
         wzyYrGNpB+1/XQkvDm99hmXwydVFpwj/3e50GVor5HYxdiuqYMAtLXy35cJtPAE5O4hU
         ZlPQUm7v+e3K0QcJ+Zqzw+ojAU4xWZCsCwEttSE2Jejij1E/NqBgXXNugSl0kuEBo4Xc
         A+N2nZgn8yz4JqWgL4BIma/aSVex/ZKBdtImt9SNh9RlanaM7KXKElEDZK2z8mddp48V
         NjkVYIzvKFZGoR31t2+/F23ouE/xGT4rHAewpWqe4VAJ8gg7QMB8SA9AHAkEPjuUrTuQ
         1V4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xG7+45oqf2NS1ULMFZPBvVQbomZLDhmCLViBMWlu/5k=;
        b=ToWs3/TQLX/SjcXJdguS5bRliztKJn8YMtl4hVTGKCzDKMh3h/0Su5sOUwJ/Gh7krm
         BSWm8N+coNWgliHYjRncBcBTt75bKXDg9Oa6h7PPuPbLGQevjIvZf8X3JXGxJyQF3E4Y
         eZEXPyi4vogK4UxzMXPfJ5yi6D8CXMXAQXOS4WzfYCzb5bweE5BBjHZrLxPulofyhEfT
         pepYpH081A2TIO3h+qdZq2vc4KmePn037ux3tOiCgkgjkxQhGBM8tOnARD3qRSOOnrv/
         F/VfUjnlduDuDthzIERDb9xf2vvn1uihLcbxc76/nmZ6x/tQlDa4LtLf/s27jMC+VOPf
         r1RA==
X-Gm-Message-State: AOAM531l7OK+n8cpqOn6/DbEWhHN/VrDWfijqxbkdYlGC/kNq5mXcHJc
        oECT7EOGWdsxQTSV1pOeHEtHQTg41Xd/oD0uHc+quQ==
X-Google-Smtp-Source: ABdhPJwwvBrGab+ahjvONXUZlOncszsPm0JyUwad3a8Qevmv31Bpy7OktCb6OFGKSZ+G4L3pvPjfzXQpuycf9DGgoNI=
X-Received: by 2002:a0d:ee41:0:b0:2d2:f0aa:d3ba with SMTP id
 x62-20020a0dee41000000b002d2f0aad3bamr3808690ywe.512.1645119656516; Thu, 17
 Feb 2022 09:40:56 -0800 (PST)
MIME-Version: 1.0
References: <1645114959-119064-1-git-send-email-john.garry@huawei.com>
 <CANpmjNOO6yxF+xXoatR==uvSaEwsWyZ=n7ExEM_=OJaDYBCeSw@mail.gmail.com> <f7782f09-7f12-b957-a1b2-d0673ec1304c@huawei.com>
In-Reply-To: <f7782f09-7f12-b957-a1b2-d0673ec1304c@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 17 Feb 2022 18:40:45 +0100
Message-ID: <CANpmjNOO-fsU7PP_PqeT53_N=xmNruiT3mvE0e1y=EtKJUfFGg@mail.gmail.com>
Subject: Re: [PATCH] perf test: Skip Sigtrap test for arm+aarch64
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        leo.yan@linaro.org, dvyukov@google.com, will@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        irogers@google.com, Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 17 Feb 2022 at 18:34, John Garry <john.garry@huawei.com> wrote:
[...]
> >> -#if defined(__powerpc__) || defined(__s390x__)
> >> +#if defined(__powerpc__) || defined(__s390x__) || \
> >> +       defined(__arm__) || defined(__aarch64__)
> >>   #define BP_ACCOUNT_IS_SUPPORTED 0
> >>   #else
> >>   #define BP_ACCOUNT_IS_SUPPORTED 1
> >
> > This is now equivalent to BP_SIGNAL_IS_SUPPORTED
> > tools/perf/tests/tests.h -- and different from the original
> > BP_ACCOUNT_IS_SUPPORTED (and makes me wonder why
> > BP_SIGNAL_IS_SUPPORTED wasn't just used from the beginning). Perhaps
> > just use BP_SIGNAL_IS_SUPPORTED.
> >
>
> We currently have BP_ACCOUNT_IS_SUPPORTED defined now in 2x locations:
>
> tests/sigtrap.c
> tests/bp_account.c
>
> bp_account works for arm64, and we don't want to skip that test. So, as
> long as the macro meaning is appropriate, we can reuse
> BP_SIGNAL_IS_SUPPORTED for sigtrap.c

BP_ACCOUNT seems to say something about the "breakpoint accounting /
measuring" test. BP_SIGNAL is about the tests that want to use
breakpoints to generate signals.

So it's very much appropriate to use BP_SIGNAL here if, as we have
discovered regardless how they're generated in response to
breakpoints, are broken on arm/arm64. On the day arm/arm64 decides to
fix signals, I'm assuming all tests being skipped with
BP_SIGNAL_IS_SUPPORTED can be re-enabled (or so we hope).

Thanks,
-- Marco
