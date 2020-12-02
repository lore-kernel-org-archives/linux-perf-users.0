Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1896C64E8A
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Dec 2020 02:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 911B921D7E
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Dec 2020 02:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgLBCIM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Dec 2020 21:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgLBCIM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Dec 2020 21:08:12 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CDCC0613CF
        for <linux-perf-users@vger.kernel.org>; Tue,  1 Dec 2020 18:07:32 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id v92so211233ybi.4
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Dec 2020 18:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=CjwbtncPbogbIDD0Gg+rLiO4d1+jiP/isiqdMbl8Qv0=;
        b=uohgXlFa6vgFpYEfgkgQvWYYdM0JwyPgGuWN9qiWk4cqWoqKhFk3lWoIJjf+SEWV4f
         WJJdh1wMSLRWSBlFCUhvQU71GKUyBBeaLzsbumGpYfaUan5nHPP5xXvruRdQRvnVhEjm
         ZITHKH4/bZGoM2Q2MCrcqpNjTKHfEVi200KZ6HKZq2MLe7o/nWKzsU61cwK2qiTVSPJt
         8bAoYolSo4TZvijmqIAGoaYazsVAdhoKU6/Da35h3W7rLNInJ3o1G7XoifbetTieDGRk
         vSIge7oyQgz/xVvcQYq+gVpBJoROSxILhWZqAyBRLOoggkbPHGRYgrQzpfph6GJBBqAd
         gR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=CjwbtncPbogbIDD0Gg+rLiO4d1+jiP/isiqdMbl8Qv0=;
        b=Cz5jOU3ae6iQe+9v5E9Nvqd2V/4wsEfLV+9sEqt4lCfsTXInrO0l5GUII5Y2KWWtHE
         6BRW8/DTjd7KRkgtJhmQVEaYR35NH7PTx8X7ye4fbY1JxzWQdb9zuvZhvfa0rwADILID
         hv9zat3rL/AmUBq9JuCgMV4iFvIcSFJVFpw3OeaNFGiXf/NseDVJtcLo+4JaQxyFBo4a
         ydr8BcYYaxDD2prULGF2RHXzaTjeoEIWm7VCTzqiwSOAv/uU5EuGOKo1yfX8ULbaOWd0
         S54c6gaGRICCjCOIrJQx5auQ43Oowm4ba54iWxoWD9Se/1HK6MnR8gA34EYweC47hFMS
         0NgQ==
X-Gm-Message-State: AOAM531ob2IB8GCmFNKbfHO8dimBstcLMFxe/uyVNCa6D/ShBjiRa9cx
        Y/mLqUUIUxeBy9rUPDebyXnI81Fz5RodieaEvTT5V8hqVx9Sl3mt
X-Google-Smtp-Source: ABdhPJwRBIHnBdVGbE3eZOmidN/EzJbQxDjso5IGFFukx4A5Mjt2e4guflik6wrfE1fANYPQ6Idw+e3bmWZ5UDge3bo=
X-Received: by 2002:a25:905:: with SMTP id 5mr589606ybj.44.1606874851342; Tue,
 01 Dec 2020 18:07:31 -0800 (PST)
MIME-Version: 1.0
References: <CAAmvLXs_RUTPd_O7iXVrcD_L25G77zFPUX1KM=gW3_A2dhyB1A@mail.gmail.com>
 <CAAmvLXua-7y+DSRSegH9dVt8hEQEOvDou8O1Mfe-xAzfRc180Q@mail.gmail.com>
 <CAAmvLXsjgwMy84_Nm2YmbgS1TZEa_DD+A4YnvvhRQRz2J53uJg@mail.gmail.com>
 <CAAmvLXv25yobsSSt57kZB-wYh7wxSKkz_qrSSGuVUDriQHZdbw@mail.gmail.com> <CAAmvLXtqyxUBEGPxP6pUspHTk_SdzbM00H=tUX+sdCCN6iLWAw@mail.gmail.com>
In-Reply-To: <CAAmvLXtqyxUBEGPxP6pUspHTk_SdzbM00H=tUX+sdCCN6iLWAw@mail.gmail.com>
From:   =?UTF-8?B?7ZWc66+47ISg?= <mesunyyam@gmail.com>
Date:   Tue, 1 Dec 2020 18:05:55 -0800
Message-ID: <CAAmvLXtPpqyun9goLw1JeQw0+s-6Y6WUdmH_qj4HiWW9FDTAPQ@mail.gmail.com>
Subject: Asking about PMU tool issues
To:     linux-perf-users@vger.kernel.org, pmu-tools@halobates.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello, I am Miseon Han.

Currently, I am using jevents of PMU-tools for testing and gathering
addresses of memory accesses.

However, I have an issue that the number of gathered addresses is too
small even if the memory footprint size of the target is quite large.
I opened issues in pmu-tools/issues of github site - issue number 364
In the page, more details are written.

Could you help me to solve this issue?
