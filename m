Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0050DC46467
	for <linux-perf-users@archiver.kernel.org>; Mon, 16 Jan 2023 06:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjAPGBD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 16 Jan 2023 01:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjAPGBB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 Jan 2023 01:01:01 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA6CAA
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Jan 2023 22:01:01 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id j34-20020a05600c1c2200b003da1b054057so7111879wms.5
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Jan 2023 22:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fSYMSZYQbmhaWaDGzPbCvqjfCdPDVqsG1KD282UM/jo=;
        b=P1e10780iLuVAE74lAO0GA0wvE9gPO2Yv5fHoZmugNiZB8a7+3Wkp7vciY5IanI4LG
         sWJftG6wcfzC+xFEuDV/MCqzNnLUWhAXhC9+e5Wq+92JwdDdYSIolKHIWg0z5h8R71u5
         d4H6hpB/COkIalt0wRJntSwJnv2L/QP+cBBtrAjlYO0eB7MYs5a8GmE1cIBBUO9sOotY
         emlEPXraQsZ1jKd/28Brh4t68RbpN2AWMIxzcVLiiIeuylZnDF7XBCfxBWbrf4WuDc1f
         HcHhbOIdB6f+b8gu+GVj+3YKUD4kc8A9OTphe81Oln8MqxSiSKhgUIEvPLYYc0gnX78H
         mQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSYMSZYQbmhaWaDGzPbCvqjfCdPDVqsG1KD282UM/jo=;
        b=bm99AORP+f9/5XY62uZeUfcIncRNPGcSFtr96h72T2vIIb7xRVjCH6R1EXGv91zShW
         tP05X1UAkO7QB6X7DR3BSMIEmH7US859NfR/HDJJjs4uXYx3n2bQJLEl7lf5JlDi2MtU
         /0nUSvsDNxOg3SDShflooRDbDXe2ou6MJJz5OJfgsYZi/KxDWAhVWmJOUO7KkAITn2qi
         p0G9PUSqViB0HXfo0YD1dK+tCTIredBm6r6ExWvfHREWJXJR069lUhWF/oCGQJXjGJwa
         x1j/HT/Cd22GemT5kuDrGMLBIVfltM3hXL+rgmsnOJwau7n3nnmc7xRJoB4oTBH2wVse
         0Fjw==
X-Gm-Message-State: AFqh2krj4SivsbMRnoe+J7d5remsJBHpqgjA7qk8NRNh3RpGPTKdt8wK
        jTkG+TaqYEbEBD3dy9slMQA+QMDE4TrMy9qSYpm7veUi/bXNSg==
X-Google-Smtp-Source: AMrXdXvco1yNqtdR3Mn9xbyetkhMY703c/ArNTKauEXmBF0GfIp+t70iaT76VqvDwIOq/wC/yazMTuUyDBjGTO9hHSA=
X-Received: by 2002:a05:600c:3b04:b0:3d0:50c4:432c with SMTP id
 m4-20020a05600c3b0400b003d050c4432cmr4510926wms.67.1673848859551; Sun, 15 Jan
 2023 22:00:59 -0800 (PST)
MIME-Version: 1.0
References: <20230116012143.432435-1-qinyu32@huawei.com>
In-Reply-To: <20230116012143.432435-1-qinyu32@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 15 Jan 2023 22:00:47 -0800
Message-ID: <CAP-5=fV255AszHQAYFWjcEWkPCORyD35_4O+2Uxt0+4o2FyXjQ@mail.gmail.com>
Subject: Re: [PATCH] perf docs: fix a typo in perf probe doc
To:     qinyu <qinyu32@huawei.com>
Cc:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-perf-users@vger.kernel.org, hewenliang4@huawei.com,
        linfeilong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Jan 15, 2023 at 5:15 PM qinyu <qinyu32@huawei.com> wrote:
>
> fix a minor typo in perf probe doc.
>
> Fixes: 631c9def804b ("perf probe: Support --line option to show probable source-code lines")
> Signed-off-by: qinyu <qinyu32@huawei.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Documentation/perf-probe.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf-probe.txt b/tools/perf/Documentation/perf-probe.txt
> index 7f8e8ba3a..5c43a6edc 100644
> --- a/tools/perf/Documentation/perf-probe.txt
> +++ b/tools/perf/Documentation/perf-probe.txt
> @@ -222,7 +222,7 @@ probe syntax, 'SRC' means the source file path, 'ALN' is start line number,
>  and 'ALN2' is end line number in the file. It is also possible to specify how
>  many lines to show by using 'NUM'. Moreover, 'FUNC@SRC' combination is good
>  for searching a specific function when several functions share same name.
> -So, "source.c:100-120" shows lines between 100th to l20th in source.c file. And "func:10+20" shows 20 lines from 10th line of func function.
> +So, "source.c:100-120" shows lines between 100th to 120th in source.c file. And "func:10+20" shows 20 lines from 10th line of func function.
>
>  LAZY MATCHING
>  -------------
> --
> 2.33.0
>
