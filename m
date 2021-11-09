Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888A1C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 10:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B2236115B
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 10:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245285AbhKIKZZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 05:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239354AbhKIKZY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Nov 2021 05:25:24 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE06C061764
        for <linux-perf-users@vger.kernel.org>; Tue,  9 Nov 2021 02:22:38 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id i6so37449389uae.6
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Nov 2021 02:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=wBDH4hamRBmyS7o/t1O3fXp6GXKgdNEUjWFR40H4BKQ=;
        b=L1gBsWvQQgDW64Y9ps/owii6K56m/FezuVgNKNJePSnvpOZGqGU7l/XbUohmPdjgPC
         caOsiwJnz/iEVzwrjJRxBRwgtUOBA6XfwhDMDYbGHlwjnqMVL5XwBiJFq5LcEyblGMvp
         v+oj+k24r7qfI1aSkAt5id3lPxIKguUTcNs5rUdHkobzex3vOKR/lvQVPpNeoDBWiySC
         Gak2ugeQPrUuAD/u/sgsslDcgFYYHjBVa4gvHK+qzuGQgpuGkZ598wjGVRPf4znMMOeL
         qTu6sYte+t7/0wr2OVB2MblRBTz2gfXKJtod1H1ScOD2bsPPEp4f4my6ECPJP2oIAzjG
         VuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=wBDH4hamRBmyS7o/t1O3fXp6GXKgdNEUjWFR40H4BKQ=;
        b=4MHUuZOyE5f5M7sdGZ9EsAGQyjk0pYcSAhQTSNCR+m5UGjXBOhe4AaswYaySILcv5U
         P9O3amLiM3DQSLAgVjZTnNVDcfpTVOFk1G6TB2WzVrqNUUI1tak2w4nY4NMmawJJytc6
         gNrypx+P3qnisy62E/y+ePwnI9uBtcGehdYxz26P64jbdiRjMy5gO+mo23rfJrZdgte4
         e5q7wmOl3U9mVM2E61YBX2o/5GFUfbK6eqAprgL0GtH8wXXSbEIqsewaa7TFodxb6ZeV
         6VDrAWxiq9wlsIaIPuLH0wMjz7dawBcrNdFq3eRjve/UFmO+1Xktb+HVFy4xg/8uE0zQ
         h9AQ==
X-Gm-Message-State: AOAM531UFK0FMYn1zUU3F1d9O26j4uXprYWY0ViLsTfe8nfHj6SuXU6x
        Z6r+lhQG+fRIiWl68p+qns2rRdUlTSGVPy2sl7xhNyo0E08=
X-Google-Smtp-Source: ABdhPJyv2Xo94NoQBauA3vN4RsxOtoFWMniRYYgrNYz0MIN8Z3DBqTqSpv/Qt7DzTTBu1tEo9a0xwZ3iczIRUhwgWCQ=
X-Received: by 2002:ab0:3154:: with SMTP id e20mr8793525uam.14.1636453358217;
 Tue, 09 Nov 2021 02:22:38 -0800 (PST)
MIME-Version: 1.0
References: <CAL+bK4PgSAYVDHt+F_RzPfPXH7iCUpVAohbbuV0uKnjJhhfEHA@mail.gmail.com>
In-Reply-To: <CAL+bK4PgSAYVDHt+F_RzPfPXH7iCUpVAohbbuV0uKnjJhhfEHA@mail.gmail.com>
From:   Neven Sajko <nsajko@gmail.com>
Date:   Tue, 9 Nov 2021 10:22:12 +0000
Message-ID: <CAL+bK4PbXYObP=sEpGGMeAAo6dU0iow1N9TgQqyBt+-M6Jwi5w@mail.gmail.com>
Subject: Re: symbol lookup error: ./libperf-gtk.so: undefined symbol: callchain_param
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, 9 Nov 2021 at 09:53, Neven Sajko <nsajko@gmail.com> wrote:
>
> I built perf from linux git master with GTK2=1 on my Archlinux, but
> I'm having trouble actually running the GTK2 UI.
>
> When I run LD_PRELOAD=./libperf-gtk.so ./perf annotate --gtk, perf
> exits with this error:
> ./perf: symbol lookup error: ./libperf-gtk.so: undefined symbol: callchain_param
>
> Any suggestions?

Now that I think about how this is actually supposed to work, I guess
that using LD_PRELOAD was wrong.

However, I still can't get the GTK2 GUI to start up: I tried both
using and empty  LD_LIBRARY_PATH (to make dlopen look in the current
directory) and copying libperf-gtk.so to /lib. Both of those attempts
resulted in:
GTK browser requested but could not find libperf-gtk.so

Thanks,
Neven
