Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5D4C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Jun 2022 01:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiFXBPk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Jun 2022 21:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFXBPk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Jun 2022 21:15:40 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A79E5677C
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Jun 2022 18:15:38 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id r1so737939plo.10
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Jun 2022 18:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waymo.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=butmaP3MZLJKp7KyOl4iN5q8QhrWp2OkI+B4YSz0aIQ=;
        b=m2Uaa8d7gdEj5+DzOx974vCa3LSY3dJ9yNx1Obzfs1iOVmP1s6U0THaf8v+SRzOuyn
         XXJnl2lAmtmx6dmc7963srnUWukt95Qe52IzOb6W9R/sdL1uMfbq+SHl7cFpVbNqj2V8
         DkqYW6wHIgGTau/3R0NuBjA/znjoxP2VUNNvi4/jpp/8abWEzO//EEEyIe1mv8KfF/SY
         NF6/TkbCg3mOZv5OVv8ReORx3I2TQazBp9eOwSCvfyq8qm2e6EOF6M5/vhP0UWNCkfF4
         73AwK1NKxPZTZFDU4zJtQktI9NuimNPNKTYmRTgFdARvPQtRiOJrHIvjoyY7rIgDd8EO
         lG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=butmaP3MZLJKp7KyOl4iN5q8QhrWp2OkI+B4YSz0aIQ=;
        b=oW2uUpTA3eWUIsNweKcIXA1lH1y5NQTc2Z0pcNjdSyAShJYCwLL9QTKNrIWSJ0Y+QM
         bp/tBKfk53NqQ4AshNUOKoH9fssi9Znk1gq66UQM2lg8zRXGti4xS4o01DrzdejBEKNR
         sXXfpayNmaVxXJo9654OStrnv11iK7A1qLlpOyBXL+tS65s2hXWU+ARF3tSPir20X1+Y
         Y91dLkD2owUljwZ8x8c1W2ZMvb8WPd1Cj5r1jEcpAEuP8CKx/xwuZ5XXLlEuX4TCL4gL
         uDqYuH/vagxyZDkmutL8oL6xCRDNw10j18QYUBOpGDTfiwZ7agrnM9ThcrAYKhgK7dYl
         RqqA==
X-Gm-Message-State: AJIora9w6TAZhvFH46rCKWAVzvwl+CzifJtfei+GMv9WFcUBTp23bQmo
        ljZaFcuSIo/jniSHE1o6XDt9xxvdDKThcUFzBkeSdRfOmmw=
X-Google-Smtp-Source: AGRyM1t8B/WKBQgAmv8QmOV80ePTUDc3AKHj02++Sv/LOPagGALc81Sg8ZFNMwLwqyGXSaGvrh8e6PP5SZyW0csMBNc=
X-Received: by 2002:a17:902:7c10:b0:168:f08d:d0f with SMTP id
 x16-20020a1709027c1000b00168f08d0d0fmr42162945pll.31.1656033337135; Thu, 23
 Jun 2022 18:15:37 -0700 (PDT)
MIME-Version: 1.0
Reply-To: rsilvera@waymo.com
From:   Raul Silvera <rsilvera@waymo.com>
Date:   Thu, 23 Jun 2022 18:15:11 -0700
Message-ID: <CA+PGoB-WrXzZuCQONzyTuy69a3ND7_HmVh5FZH5T4Y9qbtBYBA@mail.gmail.com>
Subject: Using perf-inject to inject a fixed set of build-ids
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello. I have a system A where I collect perf.data files without build
ids, and want to analyze them on system B, running a different version
of Linux.

My analysis depends on build ids, so I want to use perf-inject -b on
system B to extend the files collected on system A. Currently,
perf-inject retrieves the build ids from system B and injects them on
the perf.data file from A. Instead I would like to provide a hardcoded
list of build ids to use, which I would manually collect from A.

My current thinking is to add an option, say '--known-build-ids'
specifying the build ids as a list of (path, build-id) pairs, similar
to the output of perf buildid-list. The parameter would be parsed
using strlist__new, allowing the build ids to be loaded from a file by
using the existing support for the "file://" prefix.

Does this sound like a reasonable thing to do, or are there other
mechanisms that would support my goal? If this sounds OK I can prepare
a patch for it.

Appreciate any feedback/suggestions.


Raul E. Silvera
Software Engineer
waymo.com
