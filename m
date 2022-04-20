Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19CCC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Apr 2022 18:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348325AbiDTSVO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Apr 2022 14:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbiDTSVN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Apr 2022 14:21:13 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E488DE9A
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Apr 2022 11:18:26 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id 63so905728uaw.10
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Apr 2022 11:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=T4OnbBIIRRLL8pDWecOv4lSPdoePf0fvnRoJftJlAto=;
        b=GjKzYl0YKgJ4yStv+yNFBVPiIDtiT+eFbi4v0pJ2IcXrsrm9fflua+J9Kh8zTVNNYv
         s1WoZIoGgXCfQGS8VhTJJDUog+WytXzX51cenSf79y6M5+5/17ESqa5ZPGYVowyMhTvg
         E/4h5ROjMQgUrJ2ftAwGMyTf27JHwarrzRPHJY5d/h+X0H1bRbmQltvCC9l2dPR7emS7
         VYyCTkwlTrZZTsXjisQ9B876T+WinDC73Sxn182g0Im/iLVHjbEMUnoz6Gk3gTKOEqpz
         fA975XfWGXaeAwt/7ZYBVRADDB7G52QCQ8wFn6te+3Jindk7YDuXRdPvYLD6ObKPJZvQ
         Dvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=T4OnbBIIRRLL8pDWecOv4lSPdoePf0fvnRoJftJlAto=;
        b=nQuvRlZTlst79uIbmuer61UmKW4D0uUgqeoJo+0gx/N2V302ZYq19z7n0NK8dA0oeu
         IPOlrp/1WxLpZ8UOTcrvWYZiin2x0E8B/3QAlZLfozbNpCQx9w5wUkOYs6683zz1BYZf
         KNB/cxK7YgKwaQG3NHn7WYc4fC8/tL5w+Gl06Zcny97n38ivDuqBlHDF34dCAA9KWRAD
         V9ULvsltaBeRuzhr2LB/wk79LeSe4H5hO90sfaV+oSjxKo2ttkt776L97sW6gqsfSbsU
         uQH70monCrZ4fq34IplILmcjQh79BlpRqksLD0K0k6jFtyZ2Oauihe9QiPecswbjmdzP
         GRpw==
X-Gm-Message-State: AOAM533oZjv4PfSo22t+cGKlEO0hRfYkVCdPlqg1IxOcgE0ZPpkIZ5TO
        jwuGtEPJakz/SXVuuuA/gorTYKAXA/7AaDsC+VjOcW0Mfi4=
X-Google-Smtp-Source: ABdhPJy6ZqH9mQXsZi66/nQ16et2NWutNVrPnTS296itstE6KA1x6Kju2SjkLhvoWs9GMuxWVnqJgUEi1Q+9VRG+S84=
X-Received: by 2002:a9f:3272:0:b0:359:eded:9c7e with SMTP id
 y47-20020a9f3272000000b00359eded9c7emr6136061uad.35.1650478705532; Wed, 20
 Apr 2022 11:18:25 -0700 (PDT)
MIME-Version: 1.0
From:   Tanusree Debnath <tanu235m@gmail.com>
Date:   Wed, 20 Apr 2022 11:18:15 -0700
Message-ID: <CAPS78pr3gdfOzNPqvv8pMna1k3XD85jNFdsWf8qwFcL4RZyS8w@mail.gmail.com>
Subject: [Feedback/Approval] Perf
To:     linux-perf-users@vger.kernel.org
Cc:     arnaldo.melo@gmail.com, mingo@redhat.com,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        peterz@infradead.org, acme@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Dear community,
Two of my patches are still pending. I would love to get them approved
or get some feedback.
Patches:
https://www.spinics.net/lists/linux-perf-users/msg18239.html
https://www.spinics.net/lists/linux-perf-users/msg18185.html

Signed-off-by: Tanusree Debnath

Thanks,
Tanusree Debnath
