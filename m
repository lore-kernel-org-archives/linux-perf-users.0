Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC7FC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Apr 2022 04:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiDFEjZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Apr 2022 00:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380177AbiDEVgc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 5 Apr 2022 17:36:32 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C267DFDE5
        for <linux-perf-users@vger.kernel.org>; Tue,  5 Apr 2022 13:49:03 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k23so269731wrd.8
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Apr 2022 13:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=oWIp/3tqPbJNmUdJn8rJboecyzXbYWqKK9ROvTUHRy4=;
        b=XWMMMxKV/XPWNBRA1ysjNKJiwYlHEsl2Y31z79U5CmD8dgxp0GP8/+Zl08TUh+76Mw
         8xHHS5yHZXCzVL+VYYP/zXZktPi3G8RzyGHipFea0Fp2nkAVqG3HRihFwpq6bBKFitns
         f22bvHpEi7+6YWP5hOJzp8QVk/iEPUdCZTSaaXKiqIWkx0a4bQZaj/vl9j/0H41F28mn
         9L00yAFlqA0Vfd32RlJF48NUh/TpOdig0e4Ca304O4Nsrfcvz9A1kIt9IFf5kVe10Zqd
         w1W+xMBjopTR1fYqYQsWpEewd1UbjLqG9FOhaD0CgySGZvD9lLYcvBKWR02VrBEYFHSS
         d1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oWIp/3tqPbJNmUdJn8rJboecyzXbYWqKK9ROvTUHRy4=;
        b=4hcZeH6QXztcdPgkPtaUoNquNNtMhZ4FLhhxBLGyrZWeF9O25+d9wzqPSbtW7V/Q+1
         sVPyeDdJ65GfZxLyfgSWqbfBBz3VC+3c0IyAqrjdcU34I1lMMWosLuPjlCRRkwWwAnVl
         a27HGgD0nBpanFtTedS19LdiKLboqYcjT7k7qJEZyJ+ZLzKnxMWUhKN92HPTTG0cw3IK
         M5fy/uYPKcPU/bthojPWqrZftdLqd9wQVnBZDAFGIpQIQMbizz0P1T3ucLjVZIhOf0YE
         hAfOaabmb95c6It/HgGxsaphOOE9BFZijqyUkdHqpIbDD5TCJYUuhr2zOo6HNFBAH9R8
         YtIA==
X-Gm-Message-State: AOAM533kGaWDyjOtw2Q6CvSfA53KsidC9vg+4gZA/EohdADcq5Q9zX5T
        v3OMP9+chBCm68y7ge73fxxdxTV0vvc4Xy3YmMO/99G+pb9fMQ==
X-Google-Smtp-Source: ABdhPJyCMEvkPVBuWgnayLDAzHr8pwPRiX88yNtcIggdpuGfgeWWiVsbIr/0ZeLMAQndgLL2FLZEq9QARXbTjFUSLVk=
X-Received: by 2002:adf:f6c4:0:b0:206:1581:dabc with SMTP id
 y4-20020adff6c4000000b002061581dabcmr4111480wrp.375.1649191739948; Tue, 05
 Apr 2022 13:48:59 -0700 (PDT)
MIME-Version: 1.0
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 5 Apr 2022 13:48:47 -0700
Message-ID: <CAP-5=fWKkK5ExyPRrH4HnRPB4bkMF5HE9bzBjGmisH_EEFkGBQ@mail.gmail.com>
Subject: GSoC 2022: Applications open for contributors
To:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

A reminder that if you are interested, or know someone who might be
interested, in doing a perf related Google summer-of-code project the
deadline to apply is April 19th. Applications opened yesterday! More
details at:

https://wiki.linuxfoundation.org/gsoc/2022-gsoc-perf

Thanks,
Ian
