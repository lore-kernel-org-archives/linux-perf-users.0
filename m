Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B791C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 11 Jan 2022 18:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346389AbiAKSqz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 11 Jan 2022 13:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345929AbiAKSqy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 11 Jan 2022 13:46:54 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB23C06173F
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Jan 2022 10:46:54 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id 19so141939ioz.4
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Jan 2022 10:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2hbXHVCLNGmYtpg85HRQj1tStndWpfHPlukM67GllcY=;
        b=PT7z42l9TocW0rBRoMNHny1aXx9qnV4VC/bduNOMV1uM84VQGJVqnX5lcR9VagMYAw
         I0E2UyKIur6ocvM9WyuX0gxyhAhZRNlzWPACPY/+8wrxLGmThPCcZ03zBy0xT1YAg2Z5
         veYdBeqwntFzyIKqsHUOqeIl/wB16tM9Q4RDcfJJWqrRj3mnKqdPM1Q+fSThdO9l3pDZ
         CzTrfuHtm3A1TqePhus9QVI/k/CrVJJA/fuzYZLA5zol/6587EnlJChEMD/vBmxAvqoa
         TTI1dip4H9cQqXGKzj1fDb6omPu4ph2vjoKBblTFXtOgPU+8B7OotpsniRSBVUn855ax
         ttXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2hbXHVCLNGmYtpg85HRQj1tStndWpfHPlukM67GllcY=;
        b=cFNxyQsqRGASFLxEqr2emDrShJHRgCG91jUzKlO1dHbXcljz2cKYLaITROhAYyVx0p
         8PxVKU/g4ltbIk1wz41ckpXGC7DDHnffZFGVIuPRz9tYPRPeXrGH+BR2YuVY/aVhaGl1
         aSlqSgKbL7gKK+tIdLbtMwaE66LvcDV/JTF1EiUkePDNxmOhIOEQIog61XctdGy9ciT1
         z/B+PTlATTHvcNvdgizEjYihlYh3ILGv1Xoj5RXnAmYxk14mmCsjnLtJImWmirIFBYSI
         5PMQ1uPmADpP0fduYFK2j8uMk+07ZFfXouiSIlZWMGeUaOei2CxF/E99QQMB72qx1g8E
         bEWQ==
X-Gm-Message-State: AOAM533bP1TZkCSHNRIcQTd3nwjsVohVG1AqhECNPaqbkzhaKfX4rrgF
        MrIJYOQCDW6QpgCgEfegjg9wQPQrSIwP5qmPrYZzPQ==
X-Google-Smtp-Source: ABdhPJyzFsWOVvDV15+T62OelOrluGd6cLRTECTNoFDVCLTUjNK3SFCT5CQrIA0zAG3J2JESN9VGPl3PW2msrBTB2xw=
X-Received: by 2002:a5d:944a:: with SMTP id x10mr2890515ior.18.1641926813572;
 Tue, 11 Jan 2022 10:46:53 -0800 (PST)
MIME-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com> <20220105061351.120843-6-irogers@google.com>
 <64d64526-7d3e-0c31-f43e-f03810f72ac2@huawei.com>
In-Reply-To: <64d64526-7d3e-0c31-f43e-f03810f72ac2@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 11 Jan 2022 10:46:41 -0800
Message-ID: <CAP-5=fW2JzePV=rQG=Ww1Omub0_r2gi38FUVyaG+a3L=44R9XA@mail.gmail.com>
Subject: Re: [PATCH v4 05/48] perf stat: Switch to cpu version of cpu_map__get
To:     John Garry <john.garry@huawei.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com,
        eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jan 10, 2022 at 11:04 AM John Garry <john.garry@huawei.com> wrote:
>
> On 05/01/2022 06:13, Ian Rogers wrote:
> > Avoid bugs where the wrong index is passed with the cpu_map.
>
> nit: Don't you mean possible bugs?

You are right. I'll watch myself doing this in the future.

Thanks,
Ian

> >
> > Reviewed-by: James Clark <james.clark@arm.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
