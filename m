Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C04AC04A68
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Jul 2022 22:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbiG0WTm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 27 Jul 2022 18:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbiG0WTm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 27 Jul 2022 18:19:42 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F5B2C4
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Jul 2022 15:19:41 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n185so23845wmn.4
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Jul 2022 15:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=yCr11cc2cGlBClTJEdtWr4/tXJe6s6bIn6ihGlQRKbY=;
        b=PMavLUs8lkZWJEqU8hUawt+zxmvR2ynXIR5hnVfHU7kyiJneQRoFcnuBXmgl/Hvl/3
         WUzSCH+g+jUuFi/VlUEcSzOQqAJzgthPjgtLDY7+QX6aEiK/wX5Frq0HPWlgfLhn1ldZ
         qDICnUi8vqtbmBVtXG7DhcaS/swJIaDucItC3aRaAbkbYFVdN/VA0ShgpR1BbJrMEZL0
         ULAwxtOqRErppzFikP3E/mRP2sv8yLT/jYDcU0/4IHxUbYReS2Agyh6zTSJU2OgOs0vY
         uks6PCKn69UW8AmFjRcLRHpB17XRJN9UsyvRuF2wYu+fuTFyoFIt53XJc2IqxMivlaP/
         DvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=yCr11cc2cGlBClTJEdtWr4/tXJe6s6bIn6ihGlQRKbY=;
        b=mCMqzhaM8Ck577CarmSZcGxUvf3jRgiNWr9zYMQ5suxoYhjf5CkWu1JeBjIihTQauc
         cRfFC/geG1F1PvnbFdYaW35qnC6Eik/eaSWOE8u3xZsBLyqSokxaDWBP3Ah/JyvrflGk
         ndLUHCoOAeIM+9vB+KgdO7ELyZSzWno1d248GoE6AU18NAIoiILxVIKjhpzG9WoaM26r
         ZBtmMWQfNgKocYfNl2N8+rmLEOm80T9oFKFqSSzd33E02J4GL2SyUQ4Z9Z5yJKJofw8G
         dNOJqeNcduDIZQ62GNxM6gMSEJ4ZPtG0HrhsXExqQZboFLiv+D/QhonOgPu3SiUsbDyt
         pmJw==
X-Gm-Message-State: AJIora+SX80zGm7433c2+5AfGxFMfo380C0QL5AWuQ0zdomt05XfGDXl
        +3xVcPpPav1yYZV0NK0WfipRXmPU8hZtz++rjTr+OqnSC2H9tg==
X-Google-Smtp-Source: AGRyM1uOnytkKUqHRpklbH5mWeFIPG2OxujwwFUInPcTyg9Sj0jCZ7Xn8pB7ej+wzLpwWZHPM+fWPl5TQpH13FOP9zA=
X-Received: by 2002:a7b:c8d3:0:b0:3a2:fe0d:ba2e with SMTP id
 f19-20020a7bc8d3000000b003a2fe0dba2emr4610322wml.115.1658960378743; Wed, 27
 Jul 2022 15:19:38 -0700 (PDT)
MIME-Version: 1.0
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 27 Jul 2022 15:19:26 -0700
Message-ID: <CAP-5=fULY-KGYLwdYZgZanC8z9rqxXFm94k9zTKzDH40i_EjUA@mail.gmail.com>
Subject: July 28th - Skipping office hours
To:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

Since May [1] we've been running office hours to give GSoC
contributors, Linux perf users and developers a chance to talk. Given
we're in peak holiday season, and there aren't any agenda items, I'm
going to cancel tomorrow's bi-weekly office hours. Please send agenda
items for the next office hours on August 11th.

Thanks,
Ian

[1] https://lore.kernel.org/linux-perf-users/CAP-5=fWkxtm5-Ebwkh4pzA83prvuAJ5yy6CKQYatdkKWu3Tgeg@mail.gmail.com/
