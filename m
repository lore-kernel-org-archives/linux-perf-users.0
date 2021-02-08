Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7F0C433DB
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Feb 2021 03:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5537B64E66
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Feb 2021 03:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhBHDtJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 7 Feb 2021 22:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBHDtJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 7 Feb 2021 22:49:09 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08DAC061756
        for <linux-perf-users@vger.kernel.org>; Sun,  7 Feb 2021 19:48:28 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id c18so15248475ljd.9
        for <linux-perf-users@vger.kernel.org>; Sun, 07 Feb 2021 19:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=1LlbffZc5cOH9P6UdEMc+3Aj+bZpmTWkvqNz6rS7Ezc=;
        b=Hrdf714uXsSz2V0GarHGRnM9b69NbxPGnlCvSik66larPXk+ryNaWxBfWl6yDjYgdb
         a9M2HRnM5owQHcK4tLCQzgSJNa7nqR5qA2b6JJhFEBvKBmudgdziKr6/AtPvkzjTFfyA
         PfcukGKTAs5USTGnX8znD0fNTAal97zC/FLkuVTCmLKJ9P2s0xqjztfwOPRD9C08ugmI
         lUGi5JmzneWZE/FhsF9cLVVHGMbbfgUlBz7AEi8FP0HUcERqhZX7YyshG2FkCFt+bx+H
         5GBCZgElZnCUzYs8QkDWHNZo1db/ljcZd8j8EWqm6/UODpTYdBFrsutLBHLa6uCCSu8U
         Ugmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=1LlbffZc5cOH9P6UdEMc+3Aj+bZpmTWkvqNz6rS7Ezc=;
        b=q6wVBC3Xpy29Q9uwX9erfX/BzLEfmHN5aYbJM16HXXxNTBIiTCQYcDu6618iiy2ynW
         CoISy8YYeXeghJ3ti696wSaiE4FQ/WScDEhC2RciNSrKvpJu6nrNyOQ1hEReJR0qzvgf
         Enj2CSxydi/8jGZdtDbxT36w5OlaQd3pUBB8ly9fFP58TUbz6tl5mkh3fWih3zotulEC
         +QPiig0ze/VdW3sqQoR+nFpQaEljA4wn7ZvPk10qbv4wWuB/EWej/LPevr6A/esPF7wE
         1JAZNMoh+y2CSI1XujQBkFIOe4iJBy/RNy62QlHLxkOofI1pB3w2DFcwvrCBy8r88LSp
         kaCA==
X-Gm-Message-State: AOAM530VaIF/l0a8SOCLoaInYGr1l2bhg7argp7CMOzDL3VQmv2cduup
        qAcvNGw79x+ba9adW3MUartKLPUxiX8+vUZICsLih2cjJ4s2Fd12
X-Google-Smtp-Source: ABdhPJwcRsKxhipMMKOFXo7CUJfqMgoU410DorHYaTqZ5CH2DXvpNv1OychJBMW1Uc4xBkv6iunSdsTihE8a754LscA=
X-Received: by 2002:a2e:9ac1:: with SMTP id p1mr9689871ljj.327.1612756107203;
 Sun, 07 Feb 2021 19:48:27 -0800 (PST)
MIME-Version: 1.0
From:   rainkin <rainkin1993@gmail.com>
Date:   Mon, 8 Feb 2021 11:47:51 +0800
Message-ID: <CAHb-xavRszhCbGcs0DgrdoJCHmOznHC4UzhLXxtXz=gXXk+wMQ@mail.gmail.com>
Subject: [Question] How to sample PERF_TYPE_HARDWARE
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello~

My goal is to record the number of occurring PERF_TYPE_HARDWARE events
(e.g., branches) every N events.

In my understanding, the "perf stat -e branches -I N " command is not
sampling, it is actually count model which records branches every N
millisecond. Thus perf stat does not meet my goal.

For the "perf record -e cycles -b" command, it does sampling, which
records a LBR sample every N cycles events. However, it seems that
"perf record" does not support sampling PERF_TYPE_HARDWARE.

I also look at the syscall perf_event_open, but still cannot find any
documentation about how to sample PERF_TYPE_HARDWARE.

Does anyone know how to do that=EF=BC=9FAny suggestions is helpful for me :=
)

Rainkin
