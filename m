Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF3FC48BD1
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Jun 2021 08:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B714613B3
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Jun 2021 08:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhFKIez (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Jun 2021 04:34:55 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:46989 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhFKIez (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Jun 2021 04:34:55 -0400
Received: by mail-pf1-f177.google.com with SMTP id u126so3853966pfu.13
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Jun 2021 01:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cAB/UwhAHDGmcVhvAUE+9+s9TWealeOysnGvocg2cfM=;
        b=XvMSWmDKiDxG6Qw243JTJkuBudsy1ozJ9c441W80PQroqDHCyikMm5WWM+Gi5Klh1M
         u6cDujtRq9g1bM8UMtxnNIbbYbysn5+VBhIbHfTqjQ7Jxpqt/zXTorLt2D59V0LXYWj6
         UAX6TGsPGnzzy3wUTfKLbFonLfUcv+50N9Pu2muJhSflis8PEOSmrQiTCis+CAPXaHM+
         Sc1fDLo7SPOs5/KivpzpN3cbICC+LeRAT/tXFv0b14vNrh+Qc73sSG3KNf8BIWif4nh8
         Jd1qg2+YpDVLeWraB+hxF3c6+p7OX3FDPqJzyW1qu4zagM2H3ytN2JrJirPj/QKHkwpk
         zN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cAB/UwhAHDGmcVhvAUE+9+s9TWealeOysnGvocg2cfM=;
        b=phEDyuZGHnSKBiKLpqbw8mrlmm8xmA2VtoK9WrsGaNaa4DAhZCmY/exLSwS4So8DPF
         SdnCYdNNFO1jOl8l1nqtfTWh77GSumIrODmQsMw2qbleczcUfGdEFaZBraTdIs24aiym
         rzV+QRMxfb7Gdv1XGFXBSdc5FoE8YXJnR1wu+2URcXw0OJC1ASWUnrc4UR0aGuDn5cZh
         gKHOFbL4H7zxdtgLJEE+2uL6m73y9nqrJNnDRtlmvwewHGDazDRcw7Cyc6ZOTpFv46TD
         9pP8xh+2RD3ur2lseZVXl7ozGKk+oRzZdr+Zcf9Yh1up1KIx3eZQaacyITuFTCx5+Vry
         IUCQ==
X-Gm-Message-State: AOAM5310xOo7CcWU1oJoMBfRcmxjMKHOUKLxi7Z/xmb2qzT+dcJyL1/u
        FqzD8m5cex4+2kYl/bM/F147aP8zKkW61eFvbJ+KmA==
X-Google-Smtp-Source: ABdhPJy6qA08ZUc5JrfN+X7cl1GtOw/GCKpz1T4TlfuBTrwMPPxoSU+x4B07O8Bdden1WqHiwwMmsNCqUbT6tOBxMsI=
X-Received: by 2002:a63:c1e:: with SMTP id b30mr2541490pgl.118.1623400317368;
 Fri, 11 Jun 2021 01:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210528161552.654907-1-leo.yan@linaro.org> <CAOYpmdEvkSZaei-_SWrUC4YJ7rOUOoOaxM7+qc6dw=P+b_ivgA@mail.gmail.com>
 <5cf3effb-fccc-9385-6328-6d1e2e5ccdf3@arm.com>
In-Reply-To: <5cf3effb-fccc-9385-6328-6d1e2e5ccdf3@arm.com>
From:   Denis Nikitin <denik@google.com>
Date:   Fri, 11 Jun 2021 01:31:41 -0700
Message-ID: <CAOYpmdE=pSaDGOm+4iCh611DXVD766eCr5dACQ+TgOnSO=4EOA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] coresight: Fix for snapshot mode
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Suzuki,

On Thu, Jun 10, 2021 at 9:04 AM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
[...]
>
> Are you able to confirm if the patch 3 alone fixes the above issue ?
> I am not convinced that Patch 1 is necessary.
>

Yes. "perf cs-etm: Remove callback cs_etm_find_snapshot()" alone fixes
the issue.

- Denis

> Suzuki
