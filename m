Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C9BC433EF
	for <linux-perf-users@archiver.kernel.org>; Sun,  1 May 2022 18:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349658AbiEASPe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 1 May 2022 14:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349569AbiEASPd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 1 May 2022 14:15:33 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3F6BE05
        for <linux-perf-users@vger.kernel.org>; Sun,  1 May 2022 11:12:06 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id a14-20020a7bc1ce000000b00393fb52a386so9101269wmj.1
        for <linux-perf-users@vger.kernel.org>; Sun, 01 May 2022 11:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=G4HcF6wKFm/ylz0uJ8szLwtvNM8PQrC+7fSPzMXSh5o=;
        b=nmL+ezpo4jXh1X6e0ABW05f3V//xlF6rHUH5pANgiuVcjMHVir0OSjqZ90UVUzHHea
         nZk3hIKZOxMerTyrCh+VJO/jaheXrjHS0ExtAGzcsvhEJFfkB7B3wAQ45ObCdwGJQWrV
         r6HjfpY7s72ve3EnODQORbB3rSTbqz9eRuoHI0Jy+PydhNuhuX52EpdYH/eJiEGoUV8a
         +hBV2VkuoqCTR11RIU+jOYL6W4TMkkt6gA+Cd3suGUuyT/pj1+sefBgtMWHwmQrHwOrq
         y7pcpamQHb+0J/Fr0mYwrTMtN8qUYnbwdksGeNlszBOOFzzPuskbBSs+pe60kGCnw/3V
         EyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=G4HcF6wKFm/ylz0uJ8szLwtvNM8PQrC+7fSPzMXSh5o=;
        b=bxDpqI5v/YIu/DXwu+DUj6dYy6fKqfpPUIxWNO5t5TvMTTwgQhHx+jaRXknS2BN9m2
         worvARi0vEDUpJh0LbCVI7mxcRDjHDT6vqSwwj1qQuxzV1XMb+CeSebeJxKUmlVTypud
         8JZ2jZ9SK3fceNXHkJkjFMokn3E0aw8fWBMVcB8PWhOikSFWTe+KmEF53MKcTmZm/Sir
         WKiyCjUyrDqA5gW7sz8jQhh3jrEbKdUQdn4GXoX53zRPEZG/qg7d66loMv/u8pjv1ShI
         FGTZqLf1ijq/mAvRmpS1uPOcW6ZeCzOgK2t5xRV47ojrqs0Iamt/2zqT6edjJ2pqFNrY
         fsDw==
X-Gm-Message-State: AOAM531+ttgX9oJVg80ZYd79qeWBKgnkdE4mrMe/EcqWen27QlatgrYY
        PNQCyz3tC3WijonDQ+GoG7+RQ9izCC4GK3VNeCJleI3s7sveVQ==
X-Google-Smtp-Source: ABdhPJynlq7AnBti1C7bkGbG6lG879VJKwNABalEtnGZgdnfBGt3KYrfsC5GOxIFW908bOat0ttaBP4VNnyUoDnfDmU=
X-Received: by 2002:a05:600c:27c6:b0:394:783:2077 with SMTP id
 l6-20020a05600c27c600b0039407832077mr12450992wmb.182.1651428723710; Sun, 01
 May 2022 11:12:03 -0700 (PDT)
MIME-Version: 1.0
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 1 May 2022 11:11:51 -0700
Message-ID: <CAP-5=fWkxtm5-Ebwkh4pzA83prvuAJ5yy6CKQYatdkKWu3Tgeg@mail.gmail.com>
Subject: Linux Perf Tool Office Hours
To:     linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

We have multiple Google summer-of-code applicants this year, and we'd
like to have a forum where they can discuss their proposal, work,
problems, etc. with the wider developer community. As such we're
proposing to set up biweekly office hours. It could be that these
office hours provide useful for other discussions too. To work out the
best time and video conference tool for this I've created an anonymous
Google form:

https://forms.gle/WCN19uMjp15bNRJV6

Please help determine the best time and tool by entering what works
best for you.

Thanks!
Ian
