Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36030ECAAD8
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Sep 2022 18:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiIPS2x (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 16 Sep 2022 14:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiIPS2w (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Sep 2022 14:28:52 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC8CB72B8;
        Fri, 16 Sep 2022 11:28:48 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-11e9a7135easo53319419fac.6;
        Fri, 16 Sep 2022 11:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zi1Bcco3wttFztQb7EEIQxAraREvY1fhjOcV7AduqQA=;
        b=InTLDbhaTclTTIcawx5+Omo47pM+nBex0K5dneDPxi1daCqePGdw/x4EyE/nVtM+1m
         Lv/EIiK6MIPyxNehcpiLC1UzoiahUxu+KoS7he7di3Nm4a5SYRW0rqXz4fKKqVwVRPM6
         kyeE6w4PiL5Ub4s6dGfj78L8FxPpI+7wLlRaHtUOKAF4iYgoJLcMJCpSCHHlrFNUNQUW
         Un+iTyj/50ORXO0I4yJ70ljBaHkSBn2XPGBEMl0TODDNmOvJWBAzYmwSBBRFXS69RFSW
         /9bH+UY1HeRO5BalzqRfbb0jsWhE0MeFFtWZj0srwYxWFP13tnHz3RVLeotCmXMhCSzJ
         DKbw==
X-Gm-Message-State: ACrzQf3RemKcx6vZg2jkra+dcD3kFKpO9ZeOQTfik7e9K/zK7nwIGo5+
        dGqIsCINv6QZNjaTeFVr+omKt3SBOCvLXkf/Zny/Yve0
X-Google-Smtp-Source: AMsMyM6Gt/OveS0+hy3cvyZwJzsJtpB4g7r8DX03Z7lVkFPK14eMTjFW1Bl7Rou4e2n3TlKYXBprEZzjrQ+mqrmkOcU=
X-Received: by 2002:a05:6870:45a9:b0:10a:9ebc:63ab with SMTP id
 y41-20020a05687045a900b0010a9ebc63abmr3518844oao.209.1663352927308; Fri, 16
 Sep 2022 11:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220915122612.81738-1-adrian.hunter@intel.com>
In-Reply-To: <20220915122612.81738-1-adrian.hunter@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 16 Sep 2022 11:28:35 -0700
Message-ID: <CAM9d7chkt13mLFfFhYZJpHHYi83-f-BxdGs1Eyw8sF9X9BX2jQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] perf tools: Fixes for mixing per-thread and per-cpu mmaps
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Sep 15, 2022 at 5:26 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Hi
>
> Here are a couple more small fixes.
>
>
> Adrian Hunter (2):
>       perf record: Fix cpu mask bit setting for mixed mmaps
>       libperf evlist: Fix polling of system-wide events

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


>
>  tools/lib/perf/evlist.c     | 5 +++--
>  tools/perf/builtin-record.c | 2 ++
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
>
> Regards
> Adrian
