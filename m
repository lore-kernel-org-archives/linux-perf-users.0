Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D04C43603
	for <linux-perf-users@archiver.kernel.org>; Tue, 11 May 2021 08:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 449B061432
	for <linux-perf-users@archiver.kernel.org>; Tue, 11 May 2021 08:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhEKI1r (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 11 May 2021 04:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhEKI1p (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 11 May 2021 04:27:45 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27D0C061574
        for <linux-perf-users@vger.kernel.org>; Tue, 11 May 2021 01:26:38 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id i13so15655612pfu.2
        for <linux-perf-users@vger.kernel.org>; Tue, 11 May 2021 01:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fa+2ltcDEPwkPDfIHcTKZuy0/HUg90dSSL9do71Mi80=;
        b=qhIGNjiOHObdA23pa8t/oqmzE8bVqoQoWvcqps09WqR73y+oOgWlAcNyEK41xTfC9C
         YTc85TrPUe6gYBX0v10iAKU7LTSmBCG4Fv74z2tG7FB+Z4B59uDG9Dj+6dV+yK8u9EmK
         YFel7KdLFa01mmTkMqlaPjIjsciJWvmabyI361CWJ5vqSZ/acyNfpOJkBvfXN5wmsgdw
         EP2yQlvGwntXD0gk2Tg4pJFbWqSMbkETpBEk7KSwX6AchU8iwPhwB/owzblGBCSou8qJ
         kZYCEuR9pm4hH4tvoMYNC9En0TEb3+4BZhv2+w08BVelF7wnnF0ceI9TPbq/398fl2BQ
         +eQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fa+2ltcDEPwkPDfIHcTKZuy0/HUg90dSSL9do71Mi80=;
        b=q6prmSxcCaeCk6vDFZAa8wrsh67C3U9trF3M5mDbTdVSe9EQW21VjhcnKfmU3gACfb
         vJh8dFj2fwSr1p1sCWFu6xKqbuXIXkcU4+nSHEmVOjpl3XQkNjeBP4EnZUarxRUtBWaj
         I6wvrok5lTqTYLcWH9gKgfWtaCtKmU8WMd13NCU3494CWtErmvXOPXVe8aZfZjbtzp4V
         c8td6qfdWP76MVpeqp0magmwMk3YOKKoJwAD0v3dQi9u1Yjqm5H+tWk0lOb1cD4bmX2u
         M07Crt4qWGUP8Y6QkyA0O6OUzJi35E8SNruRXNMTok7AnMeMOI2wL3g0EjQq0QltqrRa
         gjsA==
X-Gm-Message-State: AOAM5306JDXn4VWYcOvWEZpZYPCyk7slP1k+yN7x2p+CFeJiN9yDDTx4
        jE/Tot3My9WJSGmMauAQCEuYQQ==
X-Google-Smtp-Source: ABdhPJz0e1glZlykLvQX+TD/ZmOHUdRyDZNDiJVoUoXdKA6dEhMaARNsyyBs+2ac7mb7OmNyBv3F6A==
X-Received: by 2002:a65:550e:: with SMTP id f14mr1593762pgr.160.1620721598262;
        Tue, 11 May 2021 01:26:38 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-18-166-63-222.ap-east-1.compute.amazonaws.com. [18.166.63.222])
        by smtp.gmail.com with ESMTPSA id js6sm1714615pjb.0.2021.05.11.01.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 01:26:37 -0700 (PDT)
Date:   Tue, 11 May 2021 16:26:31 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Denis Nikitin <denik@google.com>
Cc:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Al Grant <al.grant@arm.com>,
        Branislav Rankov <branislav.rankov@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        anshuman.khandual@arm.com, Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] perf cs-etm: Handle valid-but-zero timestamps
Message-ID: <20210511082631.GD8273@leoy-ThinkPad-X240s>
References: <20210507095814.17933-1-james.clark@arm.com>
 <3926c523-3fdb-66de-8b9c-b68290a5053e@arm.com>
 <20210510053904.GB4835@leoy-ThinkPad-X240s>
 <CAOYpmdFYs8=FzpiA-mMNZ=L8B9GRXLfQuEnMeDsvWeeKg2PWtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOYpmdFYs8=FzpiA-mMNZ=L8B9GRXLfQuEnMeDsvWeeKg2PWtA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Denis,

On Tue, May 11, 2021 at 01:06:03AM -0700, Denis Nikitin wrote:
> Hi Leo,
> 
> > Just remind, as Mike has mentioned that if the timestamp is zero, it
> > means the hardware setting for timestamp is not enabled properly.  So
> > for system wide or per CPU mode tracing, it's better to double check
> > what's the reason the timestamp is not enabled properly.
> 
> The bug is confirmed by HW verification.

Yeah.

> > IIUC, this patch breaks the existed rational in the code.  Let's think
> > about there have 4 CPUs, every CPU has its own AUX trace buffer, and
> > when decode the trace data, it will use 4 queues to track the packets
> > and every queue has its timestamp.
> >
> >   CPU0: cs_etm_queue -> ... -> packet_queue->timestamp
> >   CPU1: cs_etm_queue -> ... -> packet_queue->timestamp
> >   CPU2: cs_etm_queue -> ... -> packet_queue->timestamp
> >   CPU3: cs_etm_queue -> ... -> packet_queue->timestamp
> >
> > The issue is if all CPUs' timestamp are zero, it's impossible to find
> > a way to synthesize samples in the right time order.
> 
> Is it really impossible or it just can lead to incorrect decoding?

Thanks for correcting.  Just clarifying: with this change, perf can
decode and synthesize samples, but the sequence of samples is not
time-based ordering.

> I verified the profiles generated with zero timestamps and this patch
> on Trogdor (8 CPU cores) and I don't see any significant difference
> in the quality of the AutoFDO profiles.
> 
> If mixed packets don't cause errors in reconstructing the branches
> but instead mess up with their timeline then it probably won't matter
> for AutoFDO which just collects statistics of the branches.
> What do you think?

Understand.

CoreSight trace data can be used for two purposes: tracing and
profiling.  For AutoFDO profiling, it's okay for with zero timestamps
based on your conclusion; on the other hand, the change can introduce
confusion if any user wants to use CoreSight for tracing and review the
program flow (like use "perf script") command.

The change in this patch is valid for me, but it's better to connect
with a new option (like "--force-aux-ts-zero" mentioned in my another
replying), this can allow users to explictly to force AUX trace
timestamp as zero (or in other word, users can use this option to ignore
AUX timestamp if the timestamp is not reliable).

Thanks,
Leo
