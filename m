Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A16C32771
	for <linux-perf-users@archiver.kernel.org>; Sun, 25 Sep 2022 01:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiIYBMp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 24 Sep 2022 21:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiIYBMo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 24 Sep 2022 21:12:44 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D27D367AC
        for <linux-perf-users@vger.kernel.org>; Sat, 24 Sep 2022 18:12:43 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id bh13so3575429pgb.4
        for <linux-perf-users@vger.kernel.org>; Sat, 24 Sep 2022 18:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=cJzXVCVoc18ABdRcUIsWy2aVUz4QJ6reHu2nO0fOZDw=;
        b=VsbU1C9pj6PrOh7Tpac41c4wwewHJBSRM+9UaR/sO1w9OZnFfCpEg/NcPxW8/rqcRP
         iJPZhhOw3inT2PMKTaJTrmS2xGVeE/MG7AIjiRkdgJ1GZdM6y2vuV565zipUw0y0KZeP
         SV2T5GF372quFshJgZ1uLqpppaA/y52hq2C7svKhpvLLAPHBlLW/lsE/jgwbcVO3m4yY
         MecAri6bE00rb8iLtuZP/qk6gUeMZJHKO3UXP3VT+Rlrlw2mGy5xMbmbXtkutHjVxRR0
         tTqCtwXvnIbdYF16cJRKrqCcF54sPjqTx1FYYsrDws0n8RZfoJtBH4EdiPvyMGrc+kcb
         jwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=cJzXVCVoc18ABdRcUIsWy2aVUz4QJ6reHu2nO0fOZDw=;
        b=g2ElvHHv0VGNcecsFA1gL6ceqn5hvUZwj6R9s2pyrJByTicvEykA0214O80EUu9UqN
         K6nHfU/rmdsyN7em98F2U/wQzLToEIiMx2XIlL/g78U8Uw5L4rbRJyjnXJ+0XHLks3Cf
         ktlZtj5sPp+Fcp/PLM/RLdCb0adM708DqoINeEjBl4uVacZeA0FdbTemAp0gNDTOMLDk
         hMCwtS0AdeT/rD14drQ0ScRcmtyAiCY60nci9CN/BDUv1oQl3+DIsZpSC+b806CF2Xth
         fccMkHY4FVQskyoKpH4KKpcUhXT9Qd5E4UlY3xxtNH5Bg+IWuFdsmRdYMIpvfrqCs0c2
         34xQ==
X-Gm-Message-State: ACrzQf3/8eAHKxkdw6Yv4XtKy2eVPWvXlWHxaG8dt6yAszfiULjxN2G/
        KT2jNqBWlQT65K3wC15OSWKZ/w==
X-Google-Smtp-Source: AMsMyM45145g4oP/BJtlAILxr4h2nhF9pI91GUbxNO76xHDs20ASf5chPRKMDKkDmWvmxFeq3lNTgQ==
X-Received: by 2002:a05:6a00:4106:b0:548:9e0e:f13b with SMTP id bu6-20020a056a00410600b005489e0ef13bmr16645834pfb.0.1664068362624;
        Sat, 24 Sep 2022 18:12:42 -0700 (PDT)
Received: from leoy-huanghe ([39.144.40.86])
        by smtp.gmail.com with ESMTPSA id c36-20020a631c24000000b0043ae1797e2bsm7818324pgc.63.2022.09.24.18.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 18:12:42 -0700 (PDT)
Date:   Sun, 25 Sep 2022 09:12:37 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf record: Fix segmentation fault in
 record__read_lost_samples()
Message-ID: <Yy+rBbzvoTWOI+SJ@leoy-huanghe>
References: <20220924113346.1110909-1-leo.yan@linaro.org>
 <CAM9d7ci2RJOTz08eGRgLMVpS0TmwN=q=UNA_Z3wbSHCC2pMygQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ci2RJOTz08eGRgLMVpS0TmwN=q=UNA_Z3wbSHCC2pMygQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Namhyung,

On Sat, Sep 24, 2022 at 09:52:09AM -0700, Namhyung Kim wrote:

[...]

> > In the unprivileged mode perf fails to open PMU event, the function
> > record__open() returns error and "session->evlist" is NULL; this leads
> > to segmentation fault when iterates "session->evlist" in the function
> > record__read_lost_samples().
> >
> > This patch checks "session->evlist" in record__read_lost_samples(), if
> > "session->evlist" is NULL then the function directly bails out to avoid
> > segmentation fault.
> >
> > Fixes: a49aa8a54e86 ("perf record: Read and inject LOST_SAMPLES events")
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> Thanks for the fix and sorry for the inconvenience.
> Actually I sent the same fix a few weeks ago.
> 
> https://lore.kernel.org/r/20220909235024.278281-1-namhyung@kernel.org

Thanks a lot for the info and fix.  The patch in above link looks good
to me!  Please ignore this one.

Leo
