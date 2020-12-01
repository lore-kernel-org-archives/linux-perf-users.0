Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C145AC8300F
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Dec 2020 00:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C3E20809
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Dec 2020 00:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDfFQThL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbgLAAtd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 30 Nov 2020 19:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731157AbgLAAtd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 30 Nov 2020 19:49:33 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010FCC0613CF
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Nov 2020 16:48:47 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id l14so264864ybq.3
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Nov 2020 16:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=6c3E0fa1pbmcYt31InrRMkzcYrUrBn/CqH5icew0Wso=;
        b=LDfFQThLdLonL80BLsVeSPHXlXc4DsMsoivwcMyUwnMZ7UngG3tNeQfHGcO6r5Ia4F
         WWjXXxpXxyNR9s/0R+XKmoYYk9uChQTi3UdxantGIe2n94QUTgZUXEMhtRyhHT3GRmkR
         wgaDFs/WVWO3ztngbM3PBwQ5v4nSpEzaJ3ywfV3kRkpb1m5PoODr7gM0YXY4nc1sfPTA
         jOEx5OFm6LFoE0slCGEnCkQAbYyB1HssACECzJ0YVZ7G2KDJMvUQxCU7/OzFYl3d9eI4
         LHIWZKFj5fCGZkM9R1TVJ6nhnxYyXh+HJWeet9oodmT7LrSWlJUrujdlD2CeNm2457sD
         MoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=6c3E0fa1pbmcYt31InrRMkzcYrUrBn/CqH5icew0Wso=;
        b=dV7lPg7zXrYd1TqR0Uy07UCOqlRExw9hO+bXC4lS+ESMtg2skKdj1ECmBRHnqSlr6l
         BcuyupYPXcKEJetJZNQMLaRCtrwRReYlS4hX/KLeCoVMTxkahPH31YkyJVK8rV13vGZb
         vZKy7N3WGbmt7MN9JcoreV9uHe5zCh0aN66ywrxfIS6WvyCB9QYzg4YMZwvA7yGAaq9v
         KMzRyb7g/gE+0+giN0NMWvhedxtBvOODrF44A7+cXylkaZ7Tw0sQC8CJbjI2+IYxMaIi
         mV+k4OHuw0pfwHs7zR9vr61y/Rk9Zavs/aaWqBQ+bM8toRlYFrqB1Wrcwt33BRnvLujL
         4D2Q==
X-Gm-Message-State: AOAM53208qyehvJeD4coz/nIABH3UumjkoE6Zb9hM63+A6U4GbHF7Cwy
        Vc/RTll175WrFJX/FytDagUkJ4CJ1ciRJyGxne4Vz8ViQAru3Q==
X-Google-Smtp-Source: ABdhPJzTbAd7o36BkTmXqes/2QoMOQiF7zoL9fQCE+UZiBiXS3hMND+IVK3//O91A+rMaY18+U7JESexgICu4co0jxc=
X-Received: by 2002:a25:db0e:: with SMTP id g14mr238620ybf.314.1606783726137;
 Mon, 30 Nov 2020 16:48:46 -0800 (PST)
MIME-Version: 1.0
References: <CAAmvLXs_RUTPd_O7iXVrcD_L25G77zFPUX1KM=gW3_A2dhyB1A@mail.gmail.com>
 <CAAmvLXua-7y+DSRSegH9dVt8hEQEOvDou8O1Mfe-xAzfRc180Q@mail.gmail.com>
 <CAAmvLXsjgwMy84_Nm2YmbgS1TZEa_DD+A4YnvvhRQRz2J53uJg@mail.gmail.com> <CAAmvLXv25yobsSSt57kZB-wYh7wxSKkz_qrSSGuVUDriQHZdbw@mail.gmail.com>
In-Reply-To: <CAAmvLXv25yobsSSt57kZB-wYh7wxSKkz_qrSSGuVUDriQHZdbw@mail.gmail.com>
From:   =?UTF-8?B?7ZWc66+47ISg?= <mesunyyam@gmail.com>
Date:   Mon, 30 Nov 2020 16:47:13 -0800
Message-ID: <CAAmvLXtqyxUBEGPxP6pUspHTk_SdzbM00H=tUX+sdCCN6iLWAw@mail.gmail.com>
Subject: Fwd: Asking about PMU tool issues
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello, I am Miseon Han.

Currently, I am using PMU-tools for testing and gathering addresses of
memory accesses.

However, I have an issue that the number of gathered addresses is too small.
I opened issues in pmu-tools/issues : github.com/andikleen/pmu-tools/issues/364
In the page, more details are written.

Could you help me to solve this issue?


Regards,
Miseon Han
