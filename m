Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81B0C46467
	for <linux-perf-users@archiver.kernel.org>; Sat, 14 Jan 2023 22:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjANWkp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 14 Jan 2023 17:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjANWkp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 14 Jan 2023 17:40:45 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F049BA5FE
        for <linux-perf-users@vger.kernel.org>; Sat, 14 Jan 2023 14:40:43 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id z5so23101050wrt.6
        for <linux-perf-users@vger.kernel.org>; Sat, 14 Jan 2023 14:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYgARAkWs9iZ0B/4FRwpMpPs9S0XV3huLCtOhLAUC8Y=;
        b=Ds1XNBqgWBP3mtifRGvLh1owkfZbiDW4h5dggRxSHpmJ9J2KOfn/ZCCvW0yQYjw7t2
         BrB0oOoRzRcraQqleGmC+Mfg3hVBklyxNEiR38vK7o35DUoOnVHsDOLoGoetmLvmvGXP
         Dc5qNQRLBi6JMugRudC6hv7Ei7YlQCQ2jVXeYk0xl7KzfmjHgEJDK7n9gIPtgpwbreqi
         2rEySAnXmZ5CT5v6V45TREUuqDoQe3nmLgAb7HvWyPO8LunM1+DlK8f8choZ4DB2FNcO
         OR1PSQ4yGCrITZaDbs495MdLLHG75+cv4jb21A6M966VabvXDlr4+glAmt9yJmEdZbzQ
         fwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYgARAkWs9iZ0B/4FRwpMpPs9S0XV3huLCtOhLAUC8Y=;
        b=byDS7lQXnRk+AR8PTOqcqbSZNb8TlsImCdQx/TnlTtBGMlinCiNK+s/GxzQkyWfa2x
         Z9qttY41LN8FZMwfWlyxFZ11QCBZb6+oEOMjaLqUzFpLAxpGcrBq6q03PEPUVm1unFjN
         WMbuyokhEV9eB/v5Uv/oiwgklA+mie0KJCOvsfo8VauA6/lKSND+tWyQySyfG3+hlvSu
         BcWAyoKs082xGD8iTcusGRpTCtRHi8q+ImNcsc1tyXpYGuJSv86RCgyD4LCyekYqLWla
         /elpGmR1JQQj86VW7mlX8sflvCMez1JM2IKSVy68E8GrrJ2if27h7Dpprf56cL+H5frJ
         ipyw==
X-Gm-Message-State: AFqh2kpqKtVFr1i73kzHdzBYuEfn1ywDBuJTwJmKVh3OrMSvVT/BRdJK
        aGlvHRDcndolUBVZdV/0N6EsG/sXQiPzK27ZwgpoKQ==
X-Google-Smtp-Source: AMrXdXvXNemnyUUfmSCSvj4wkjdakrffiCb1jSHQJNLz46dk53LCwcZ/W7SXiBwaW6CZIwIMd2/h1+8oNAvijZD9DWo=
X-Received: by 2002:a5d:614d:0:b0:2bc:7ed4:cd50 with SMTP id
 y13-20020a5d614d000000b002bc7ed4cd50mr964423wrt.40.1673736042305; Sat, 14 Jan
 2023 14:40:42 -0800 (PST)
MIME-Version: 1.0
References: <1673601740-122788-1-git-send-email-renyu.zj@linux.alibaba.com>
 <d33086a5-233f-f591-c9da-5f1a2e8aaf54@oracle.com> <7498a6b1-01d0-0e12-82d3-c75250e09161@linux.alibaba.com>
In-Reply-To: <7498a6b1-01d0-0e12-82d3-c75250e09161@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 14 Jan 2023 14:40:30 -0800
Message-ID: <CAP-5=fVQC=cBxN_-23KRRQGpQieMt1CA2N1UL60X9SXobV3x8w@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] Add metrics for neoverse-n2-v2
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jan 13, 2023 at 8:32 AM Jing Zhang <renyu.zj@linux.alibaba.com> wro=
te:
>
>
>
> =E5=9C=A8 2023/1/13 =E4=B8=8B=E5=8D=885:59, John Garry =E5=86=99=E9=81=93=
:
> > On 13/01/2023 09:22, Jing Zhang wrote:
> >> Changes since v6:
> >> - Split patch #1 into 3 smaller patches as suggested by Ian.
> >> - Change perf_pmu__get_slots into perf_pmu__cpu_slots_per_cycle,
> >>    per John's suggestion;
> >> - Return NAN instead of 0 in perf_pmu__cpu_slots_per_cycle weak
> >>    function, per John's suggestion;
> >> - Factor out pmu_core__find_same function, per John's suggestion.
> >> - Link:https://urldefense.com/v3/__https://lore.kernel.org/all/1673017=
529-1429208-1-git-send-email-renyu.zj@linux.alibaba.com/__;!!ACWV5N9M2RV99h=
Q!LhBq67uDCOsz1k7ZF4aQPHF0Bp8FsMr-ZNgCnBSUKF4qJTFODfnkId7lw_NXqB4qZUCpu-jbY=
8z8LTckoqFGz2Q8bA$
> >
> > This looks fine. But for this code:
> >
> > On 13/01/2023 09:22, Jing Zhang wrote:
> >> +double perf_pmu__cpu_slots_per_cycle(void)
> >> +{
> >> +    char path[PATH_MAX];
> >> +    unsigned long long slots =3D 0;
> >
> > I would prefer if this returned NAN (and not 0) for when we can't find =
a pmu or the value from ./caps/slots is zero, but I am not going to get too=
 hung up on that.
> >
>
> Ok, I like this way too.
>
> > For series:
> >
> > Reviewed-by: John Garry <john.g.garry@oracle.com>
>
> Thank you very much indeed!

Aside a naming nit in 1/9 for series:

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
