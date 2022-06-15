Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0779BC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Jun 2022 16:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346142AbiFOQoP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Jun 2022 12:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244316AbiFOQoO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Jun 2022 12:44:14 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABADB381
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jun 2022 09:44:13 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id p13so21555694ybm.1
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jun 2022 09:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=YILZ/lpdYL8q8SMLlrQ9hybhLVqs/MpFWvmJucIseyM=;
        b=JhSN3LDQSW8OZHIATRduKtO5uOExaO4OGPJIjEkmIarZGJD7y5uRz9XPWADAiMjJIt
         3/4hf0CkGm0XKX28jVIXlxhJNGLVTTU62chPIupy4SZZ7pPbeYSUnkjwIfak5z+S421g
         rTruLGm5TJr/2/oSdW64RtVcfwegsRZQIxJL3AkWKRVJ1vUn07aZiNmXFasEZyflalpq
         wHYFBk/VgKghYgd2cuArtcd6G1va9rJOgDwmsBqZziAHGT2gA/vhXCz08OxwJVp0ycEL
         kN4cpcZbDq3g0ji4WQFqTS6MG167yTlX81YqJtAjkhnm8ystX7ZO3UZ1W91fSJFkOJdX
         BVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YILZ/lpdYL8q8SMLlrQ9hybhLVqs/MpFWvmJucIseyM=;
        b=2UC8KYiQBZMuc69j7h/v3P4cXXsFMW7Pj6LPdc2ZCn55kBRIlvIPtvo8NXbvGMcJSS
         ydHUStiZjOapcK/Fz/Y7FBBax1bHgG6TUZEdgkmur9vqMojt+R5qGwbvRIJZA6T2nZAj
         PMRHuNomBRPpF/cP1XYi2tIzbFQDc5EOvul7m4bjStI7lfIcq3lDLfuWg+c9jx9aeKAU
         6wOUM/vdmq12qaalOCGu1dP9A3kOrwfQbSwb2EVkRmBm4tYPirE+AOcDlv+mZ7oBQBZP
         QLoP0+hk2jujhCr763EsbIaX2P/eO/GOGtsreQ2SYWAlnZxrW7+6L+eBWZ70WD6gDRwe
         N/PA==
X-Gm-Message-State: AJIora81W6quw2E4I5QnQ7qmsUIrPbdyurxbnNX0Jed4Ap708fns5Vsu
        52UiETnQ28EeFFejLRPugGtQIZ8IAW1ge9+34TeLfc3KrVg=
X-Google-Smtp-Source: AGRyM1uY4EmGG3eRrbn2yOlO9rTc5AD+Tjhy9AqrCvO0a9khb6YojXHow9Mq51pod5yE2oCg+lWb8rWt37XUWEeIWmk=
X-Received: by 2002:a05:6902:140a:b0:663:896e:4a86 with SMTP id
 z10-20020a056902140a00b00663896e4a86mr839663ybu.574.1655311452840; Wed, 15
 Jun 2022 09:44:12 -0700 (PDT)
MIME-Version: 1.0
From:   Kyle Huey <me@kylehuey.com>
Date:   Wed, 15 Jun 2022 09:44:01 -0700
Message-ID: <CAP045AqOtn4dbMNnTvNB=2WNVKVRTeshm1jVk2kYPsA9Vmj=jw@mail.gmail.com>
Subject: Why isn't the augmented_raw_syscalls functionality included in `perf
 trace` by default?
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Printing of filenames especially is a massive improvement over the
output of plain `perf trace`.  Is there a reason this isn't included
in the main `perf trace` command?

- Kyle
