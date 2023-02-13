Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62270C636CC
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Feb 2023 18:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjBMSeh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Feb 2023 13:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjBMSeg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Feb 2023 13:34:36 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E345FFF
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Feb 2023 10:34:34 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-15fe106c7c7so16188471fac.8
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Feb 2023 10:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SRt21gjhPwtBAHDBr6zXtaiS+CL4W3PobBT4eAbNNt0=;
        b=noItEXGCXajB+1ZbDSfMWsPWiE5RPQnt2Yc539bihio00GUgOG6h3gJdWs7JxQggDF
         yp5GLKuC+3bW1O6tndOZssS8HQsOiOaaveCjxAhcJKTAmup1lN8cMVZjZaz49B36HzUW
         84qjHzHVeQBi/fAXhnmyDrHJYPrJopBQaOa7MbfrAikZtGSN4GSVr1dfelKqNDWGQdAb
         pARhBo44o+DbuLTcX1U8fRIXim7yFLVxx4seXELUeUfqHa1Pw1Lit3oYKHswRGxMq4CN
         2NHrMA6iQFvBe2wy6pCMER+gdoqTdWvURuto6Xg28sstC8VVhu7IKVrrHyUEnyMK61HV
         pKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SRt21gjhPwtBAHDBr6zXtaiS+CL4W3PobBT4eAbNNt0=;
        b=cgu/WTaWjH6ZvRTlNDU39Ax/TcUsTwPh96gyWydgCbhgBHNAVlyYQoobRh52fQqNfa
         OB82oZFcI0TTyMLvjeYdnGoq/yn+aUEzYDV1oqFBfegCfuycv2V+OvjHrHcKOtC7ScoT
         7R7jAJy7NqLZwkFOzp3aWUtcklIav6ABc9h+CICWu38HDakymPMI46a1y0YTsxs3Z4m1
         Acc+lryi1jClS/fjBZKayamn+YzD3DK9O8FFINbX5OeM2RBIrdSAl7cGthuukNTb3J56
         GhJS2Zz6hDX3YCJF24Klc7EQIE9GEWZrcr5MQ76kXNkBBcbmD4bSc/oFShoV3ylfDfTq
         KNjA==
X-Gm-Message-State: AO0yUKXt6kb6YZU3k82+v2whTE36o+eh7SCrRWve3TgqkSX4TMQYW8FG
        flm1VcyV6dwb6/ZzDb0KWWirywlsE6gTFSRymrlkIdhoUEeufQ==
X-Google-Smtp-Source: AK7set9pE7rHk1/EJXpDlzkCP9TUJhft+cGTJ8mkbmncxAlJuQ6QFaaYQJrL6kf0N6hPgI/4blXSiPKUVzpwIoSvQFk=
X-Received: by 2002:a05:6870:63ac:b0:16e:18e6:811a with SMTP id
 t44-20020a05687063ac00b0016e18e6811amr226342oap.175.1676313273710; Mon, 13
 Feb 2023 10:34:33 -0800 (PST)
MIME-Version: 1.0
From:   Iti Shree <itishree1999@gmail.com>
Date:   Mon, 13 Feb 2023 18:33:58 +0000
Message-ID: <CAO3P5YQ-BU+fmhQo98SAKdc96qMEsim4nNvMRiBmsW0YSUYjQg@mail.gmail.com>
Subject: brstack information with perf-intel-pt?
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,
I am trying to get brstack information in perf.data with intel-pt
flag. I am passing following command for the following: perf record -e
intel-pt// -m, 32768

When I try to check if brstack is present in the gathered data with :
perf script -F pid, ip, brstack -i pt-perf.data I can only see pid and
ip information.

I can seem to find branching information with --itrace=b however I was
wondering if there is any way I can get brstack information decoded
into perf.data when I use intel-pt flag similar to what I get with
default perf record?

Best regard,
Iti
