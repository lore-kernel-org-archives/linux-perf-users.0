Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDF7C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 Nov 2021 22:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbhKSWXV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 19 Nov 2021 17:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbhKSWXV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 19 Nov 2021 17:23:21 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F6BC061574
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Nov 2021 14:20:19 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id bu11so8144933qvb.0
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Nov 2021 14:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=markhansen.co.nz; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=3rgttafRN8yJanrY1wAix8slM+oNPE68AvVTnDmPzOc=;
        b=WBrR6xUhWARJfStLDut28onkSRJCUArAPfiztK7ooGJUxP4ONrDh+zpKlogH1ddVDt
         KQBClK9TcS4t5NKB2+x3/LhPvLhty2Moop3j7aTvr+9N1EKq2D33AakuFtkMqH/2GpQ5
         SJ9A/2r0JhBWM2lD9qqnPrgvHq2LKA1SF8UGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3rgttafRN8yJanrY1wAix8slM+oNPE68AvVTnDmPzOc=;
        b=DL7j0C/f7WK0FN6ifLh2dsVShiJL561NCCuoNkOu0z6r7bo1kJkF+X0IGosBRnt9Rs
         0RihE4qQ67ydEyhFxA3WHuZQqqSOm6tFUHcrYQ7oYdHVRjhoh2PzcSrQzznRKL47AEcg
         LTddKxHhtc2SXkMrf1tcibtYDshvkw4qG+Lw7iyVO1wISMjJsSTjiQ6enLD7QQ5img25
         /WQKcTxkToVNNUl9SHNZ/i2Udpkld7pQzvUSLh7VWDfRtlLazX/pp6xmabTi7XhMjJvp
         s0PlE6w9dequxqeL3W4tyDGRzY3p10oO9Ncen3e3SjHSWNDMrvnNVkXzE0++lj9R78bX
         K7TQ==
X-Gm-Message-State: AOAM530rPD+FWcoaMkIM+KPdRlntoZM2BWNYQBNa/NEJl+1rfUj6ASIA
        9TpAMOXmztHlZYZGwqOEcl7jdeVK55P2fJWmtYNrntU8pKxUeA==
X-Google-Smtp-Source: ABdhPJyVzlv7j9ka1eMJ9/xbFqI5+zsCrvIFlqFsSBNeuOxx9pN7fdish5Ir8vQGXcCIyodQWJopUas+DmrsVmFbZAQ=
X-Received: by 2002:a05:6214:2428:: with SMTP id gy8mr76714413qvb.18.1637360418144;
 Fri, 19 Nov 2021 14:20:18 -0800 (PST)
MIME-Version: 1.0
From:   Mark Hansen <mark@markhansen.co.nz>
Date:   Sat, 20 Nov 2021 09:20:05 +1100
Message-ID: <CAM07o6RciG0DWRGMwEFUZ+j=TvmULUzYau5rexnetPdc1aPm7Q@mail.gmail.com>
Subject: Analysis UIs, and other profile data formats you can convert
 perf.data to
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi perf'ormers,

I'm trying to map the profiling ecosystem (profilers, data formats,
converters, analysis UIs, and the connections between). I'm
cataloguing these at Profilerpedia:
https://profilerpedia.markhansen.co.nz/.

Profilerpedia graphs transitive data format conversions, which will
hopefully allow users to find converters to other profile formats, to
access powerful analysis UIs that only read those other formats.

Of particular interest to this group, here's a transitive graph of
other data formats you can convert Linux perf.data to:
https://profilerpedia.markhansen.co.nz/formats/linux-perf-data/#converts-to-transitive.

It's a bit messy (scroll horizontally and click the elements to go to
their pages), but hopefully still useful.

I'd love any feedback on conversions I've missed.

Thanks,
Mark
