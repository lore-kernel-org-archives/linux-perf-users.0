Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB9AC05027
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Jan 2023 11:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjATLzc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Jan 2023 06:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjATLzc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Jan 2023 06:55:32 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4968CAD11
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jan 2023 03:55:31 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-4a2f8ad29d5so68397757b3.8
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jan 2023 03:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LGUFEKthnZjILBFCytlrPmrYxG6D69epGzRfZxBEyS0=;
        b=cxQQFl4eFrIlcyAXeEsa1KFWkvg+N5IRVttPk1ycqGnImWxeF5rdVnIVaMnroHhYsK
         rspaXuKTxDIlnQtTxl8ogy+KgzNhQaZYxnLCbeeNMGtkoSsOQKc4qLAwJkkbiA7O8gE5
         ZYV0rQl1T/tOsqca2MNNeCtj3lydaStQyWyXCK330nFxpWbmlnD8EGOP1sQ6ZlQiR+Dt
         3HLnrTJysJnCDnifomUncKv8nesllwG9PGug+uFZ3eytiSOhRoz+NYeP00HxmwM8MVX/
         TQL5fkuDe+N6WVsqEYvt1viDBYyFoEKQEfvk2+pHSCH8tuS5CHtOwfxYRV17wetCS2ox
         VpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LGUFEKthnZjILBFCytlrPmrYxG6D69epGzRfZxBEyS0=;
        b=DX4USDunAQwP67+O4sApjwuRd0PpgrIXR7EH4mNTTTlFiKKwUNxsOHPOiruZaomQB4
         nHIYJc9VNov+ac4QiAa4BZfXzk1UtJf5z/HXvhA49HSygYTZpxrsUtKEo7gV4acgYxiE
         djecQvWM5Cz22BqgZIKjG++t03IsRzjfcWddlNDjIi8WZs5ZPTavigqmuJ89a4/XT3mJ
         DkcAhWnbmyuD94oSK2NyTZcoefRTmKuexKXy13vJHbg0B0GZbXcUpNHsA6oXo7Jnbwb5
         uM4N+EJJ7R4P6mP/AMuju8zca4QtD7VAA8BV/eNf/UgV0jgjq638EkgEoN8T5MmkRZoy
         uT0A==
X-Gm-Message-State: AFqh2krqNfbqQNg0hjR0szcZ6TPxZZaWJehvOanUdw1bAO+ofdfbkJPW
        ByYISjzxdhITuGw5M+6+1fhWCrx3cyUgZ3woDzsNHKYwd5M=
X-Google-Smtp-Source: AMrXdXtqRHXeBg3N4hkTtM1cm9zU93nagcitg2HrIVMvNNDQIyKZtEtf8rAD1HmCkAoiLc627NX02XADKUvGJ3Nx7yg=
X-Received: by 2002:a81:ac02:0:b0:4fc:c9ee:b460 with SMTP id
 k2-20020a81ac02000000b004fcc9eeb460mr478418ywh.495.1674215730253; Fri, 20 Jan
 2023 03:55:30 -0800 (PST)
MIME-Version: 1.0
From:   Yegor Yefremov <yegorslists@googlemail.com>
Date:   Fri, 20 Jan 2023 12:55:19 +0100
Message-ID: <CAGm1_kv1AiMfq489W5ig05Zqq52Z5zmOxQPrjhb0ci=TSQtPkw@mail.gmail.com>
Subject: Profiling ftdi_sio driver
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

HI,

I have network performance degradation on TI's am335x platform when
enabling the low_latency flag on a number of FTDI ports.

When I start perf to record minicom's activity, I see no traces of the
musb or ftdi_sio drivers:

perf record -o /tmp/perf.data -p 315 -gR -- sleep 10

But when I examine the perf.data with -D option, I can see that such
events were recorded. What do I need to see this info in the call
graph?

Regards,
Yegor
