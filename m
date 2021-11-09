Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB1FC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 09:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34A8161055
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 09:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242211AbhKIJ46 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 04:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242663AbhKIJ46 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Nov 2021 04:56:58 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C20C061766
        for <linux-perf-users@vger.kernel.org>; Tue,  9 Nov 2021 01:54:12 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id ay21so37315320uab.12
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Nov 2021 01:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=8EDU5BqV9W1kwYSiN4+QV4K7S9e3Q2QiXU8vlPMChi8=;
        b=KevKRfmXPXyfWJVFQxZnoBAdO2sTkoaJpsr78W3owYn6MGHwJ3RJFEpGwThTLOwSSe
         ZGZlZkFPRDbWZlME1m5JnKs9f5qgET/QN/5MJIVC6M3O59GYpZpEb+peJ0diCEFn0m8U
         l0JiWiXsk7hWEA8/GfcHNFYOt3ZXk6GaQ3Uzn6abGtJRa6ZYoY68dJegIiAf3uZ8HG2m
         gfnevyavIKzV4oyZD+Ghg5hjccR8/Ls3ehzTaiX+LoWXVjvSQD2uy9c6nToBpZKL4oLB
         AL6LzyrFYkp4qf4Vy0er53dcouq24Ga8vnw4IgurYG8bEB0zAl262TWza9CGiEdqBihY
         dv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8EDU5BqV9W1kwYSiN4+QV4K7S9e3Q2QiXU8vlPMChi8=;
        b=0Qkla/F1C+CgnDq9+49b51VYBZ2qdKsFEWJL9GaREhLhGezgKNjstu8DaAIb4uG42U
         WY9qyACMQS6FgAwLzHnALeyu2fDpKnuSmiBOPuLg0DOTP6Q9x/R+6hsQzLmGRVL98tVg
         ExjaStQG9mb+iljTIxmyhfLNqzagHFWqoubygBHqIjpkXZ4vcdYYGxiN3kAK84ofoRW4
         O2yU+xL7BC5vE5cwbgexVat3tdePWpU1vUkd6ZqkNjWafbaHl7LMSgMEGkzRNxEdAS8p
         AGiH4k5tWYd7ROx/8pd28DmEKPINApzHH1SHxBXCMGfAInNkwzqooEvn836yWlhtzDvJ
         sHJg==
X-Gm-Message-State: AOAM531ingt9qEcc9m1kYde8dZZH2fnasFcFCRZUiQrrDnkCAQHqwbpX
        tS6O90rxDrhym1IW8b+ckfXvmdrIxL/wxKJbuDRn3oxCVEc=
X-Google-Smtp-Source: ABdhPJwGj6tiYkEX6YdjAzsesBlO+Gc3hnNSuIzEeyjQzuha1ijjEo04+oHBHJ6ijZF5MFxviYpTNREjnus6e0VPxt0=
X-Received: by 2002:ab0:20d4:: with SMTP id z20mr8421941ual.23.1636451651935;
 Tue, 09 Nov 2021 01:54:11 -0800 (PST)
MIME-Version: 1.0
From:   Neven Sajko <nsajko@gmail.com>
Date:   Tue, 9 Nov 2021 09:53:46 +0000
Message-ID: <CAL+bK4PgSAYVDHt+F_RzPfPXH7iCUpVAohbbuV0uKnjJhhfEHA@mail.gmail.com>
Subject: symbol lookup error: ./libperf-gtk.so: undefined symbol: callchain_param
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

I built perf from linux git master with GTK2=1 on my Archlinux, but
I'm having trouble actually running the GTK2 UI.

When I run LD_PRELOAD=./libperf-gtk.so ./perf annotate --gtk, perf
exits with this error:
./perf: symbol lookup error: ./libperf-gtk.so: undefined symbol: callchain_param

Any suggestions?

Thanks,
Neven
