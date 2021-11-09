Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF24C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 10:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83AC86112D
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 10:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243246AbhKIKpB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 05:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240799AbhKIKpA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Nov 2021 05:45:00 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E14C061764
        for <linux-perf-users@vger.kernel.org>; Tue,  9 Nov 2021 02:42:15 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id s13so22054912uaj.11
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Nov 2021 02:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=UDmyX8ymZld6UPKP7CixHiCjmoY10TK2bwO06+fl+hw=;
        b=hoJl741bA0pq423Shx5hsia2O5uKINpP6ChaZU4FEdW/Of5FBztTWhchDKxfYVPmyv
         th90A2GWEEqHZWVxS1GIv4b/yy/8qiofoFC4Z9RgyfgF98wItAdMB7TkekyxUGtKRzRx
         uzFcuhLoSjl0RFHv/au4nfMYN+7e0boM0sazFWLi3tNMc2/FxxhkXnz2zVFokIgmSaIq
         mT1TPdVN2l7qfcimWiUwyXWZxGc6wj/ApU/oeqpjAiUwIqrRhcCcUdLkc4jfjHciLefE
         j4a6gB+d0oLR9ixkBhGISf2l1U/cwdZoFfjF6u1lFqBG+2F8xDQdxUzHXKVoax7emkq3
         A6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=UDmyX8ymZld6UPKP7CixHiCjmoY10TK2bwO06+fl+hw=;
        b=n+lmR3bH7z+01B/Y6oUcZyc7EU809PiYh+J6x8ZIUPYq7picqjrujNJg/MowrkBhYD
         T8QVmNWpTyQi29k1HrZ+/SerUXd5bZDGA4CUiBWmeYAqBO9xlNIusnTQs6wVZjwA4gS6
         Te4dc+iPiKIp03DUVbZ2s7msqapQMFF6bpi+P8OqmwS5lrseb7Ohp+0gQdIHK32pHo5G
         kislDJRPLmvbM5x7o3wOmhrE6FZQB+QCl7tqoKO/02KbIlJUHcxWz0b9wF1RA2GAlsIS
         3hhMrUISmqLCwtcVKgLyTMv2YGuO0nDEMo4sg3aitDhSTQn+vFQ0aTrQKJ+9tlHmjei3
         Hl8Q==
X-Gm-Message-State: AOAM531UCPnlfmYixGLIVJrSR1sac0RIcyBUeRqA412UFafGhhE/5eW0
        779kE5bmESAtH2TbyrPVr8CcJ2Xb9MCV9kvGZwm5eY3Ej1U=
X-Google-Smtp-Source: ABdhPJwfVp4ooKjdvzyiZRpyWzGGT4TgRvUC9e6JMGJAI56VcBeWcN9JpJNpoMisxo+Nkn6cp0nN+v4W2pJDMXGCnrA=
X-Received: by 2002:a05:6102:5489:: with SMTP id bk9mr10460831vsb.37.1636454534398;
 Tue, 09 Nov 2021 02:42:14 -0800 (PST)
MIME-Version: 1.0
References: <CAL+bK4PgSAYVDHt+F_RzPfPXH7iCUpVAohbbuV0uKnjJhhfEHA@mail.gmail.com>
 <CAL+bK4PbXYObP=sEpGGMeAAo6dU0iow1N9TgQqyBt+-M6Jwi5w@mail.gmail.com>
In-Reply-To: <CAL+bK4PbXYObP=sEpGGMeAAo6dU0iow1N9TgQqyBt+-M6Jwi5w@mail.gmail.com>
From:   Neven Sajko <nsajko@gmail.com>
Date:   Tue, 9 Nov 2021 10:41:48 +0000
Message-ID: <CAL+bK4N6gpQqCEO9L9kSU2n37B=P9j0AQez3SSzevqUhYZ2+vA@mail.gmail.com>
Subject: Re: symbol lookup error: ./libperf-gtk.so: undefined symbol: callchain_param
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, 9 Nov 2021 at 10:22, Neven Sajko <nsajko@gmail.com> wrote:
>
> On Tue, 9 Nov 2021 at 09:53, Neven Sajko <nsajko@gmail.com> wrote:
> >
> > I built perf from linux git master with GTK2=1 on my Archlinux, but
> > I'm having trouble actually running the GTK2 UI.
> >
> > When I run LD_PRELOAD=./libperf-gtk.so ./perf annotate --gtk, perf
> > exits with this error:
> > ./perf: symbol lookup error: ./libperf-gtk.so: undefined symbol: callchain_param
> >
> > Any suggestions?
>
> Now that I think about how this is actually supposed to work, I guess
> that using LD_PRELOAD was wrong.
>
> However, I still can't get the GTK2 GUI to start up: I tried both
> using and empty  LD_LIBRARY_PATH (to make dlopen look in the current
> directory) and copying libperf-gtk.so to /lib. Both of those attempts
> resulted in:
> GTK browser requested but could not find libperf-gtk.so

FTR, the same issue appears when perf is built from the 5.14.16 tarball.
