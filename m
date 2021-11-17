Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB76AC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 14:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B816C61BFA
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 14:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238113AbhKQOKT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 Nov 2021 09:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhKQOKS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 Nov 2021 09:10:18 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10853C061570
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Nov 2021 06:07:20 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 7so6561281oip.12
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Nov 2021 06:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZKI8nFkBZ809K78BP8XN2WIPmfawnsA2haGWJ5EUF2U=;
        b=CLYTQIRYgo58EhTlJFLjBW7Z3IzIMiGHvbCR8Gte1LGdPz1H3PLYCPLqttw9h3qk1c
         1S9DTzqW6Od9d7QaEZ4gB06b2+XJy2qxBHbJOX+bEQHEty6B1X5aO1qBTWCBYft/TPYR
         Sf0+OGR0vHx2dhZ+Rju75nFNP+47AeZ2o4ihbfDknphUZGupx0/WNPnE1N8/BXG4mjTN
         2/WVQZonWySOWI8++joQxKzek4lg7QNDLXaUae6hXhnlk8MmahEHy+pc5Wpzjtd3Uovi
         VGqyoDVW4kSB3Ycng8hLDgzzaUmM+lNgPGeYfweUdKAiduUz0hlyJFAtoVi614HEPo0C
         GE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZKI8nFkBZ809K78BP8XN2WIPmfawnsA2haGWJ5EUF2U=;
        b=oKEKZBXaUvJKQVROPs3fMpUVEY6gqkJ8MbzLYqbDPJxbfES1u1WtxiYSzZDNFN9egz
         SSo7McXvDOH40HiCO1rwh9odmk/Y5urrq9H3q5rf2iIYM1jmchn4dE19nDgS1Epq4ze2
         EL9w+ZAd3j1+gFti7VuQK4H/+jxTQARMxLR1antHC2AQv2qCb4BTey/M2XAEDxugnDo3
         WYeEbtQmklSYERBDFHKrV2WX+JmnAaPSypnb7B2yKZdenSxshvBjaDibgMQiX3gisRbO
         DBJ+NPKntHcaAczCEIY5/aR9ta/t/s7RH3Yv7FKRCFP6d/vyHaPZWT8y80J/kRD4jYZ7
         jSdg==
X-Gm-Message-State: AOAM532BeTsDf9HWULyT2LttBW224qoaPGulA881CaCD6tOEi3XL24Kf
        XgC1pwrd7JboO0e49Dip85yPQ4IWFz5IsWSGmpUVLw==
X-Google-Smtp-Source: ABdhPJwqDgU6tcT6tOY+iRbQRcl7E1Ru7pv08RkQMd8Cl2YNwWk7WhpZF80SVvicWXV0dOpj4vAMM4C8OjioJqkmY2M=
X-Received: by 2002:a05:6808:118c:: with SMTP id j12mr14255739oil.65.1637158039276;
 Wed, 17 Nov 2021 06:07:19 -0800 (PST)
MIME-Version: 1.0
References: <00000000000053692705d05a17c1@google.com> <YYpoCOBmC/kJWfmI@elver.google.com>
In-Reply-To: <YYpoCOBmC/kJWfmI@elver.google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 17 Nov 2021 15:07:07 +0100
Message-ID: <CANpmjNNR32aoFK4B6wErLvgbo3mADH5MLRt797brzA0Vtifm1g@mail.gmail.com>
Subject: Re: [PATCH] perf: Ignore sigtrap for tracepoints destined for other tasks
To:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com
Cc:     syzbot <syzbot+23843634c323e144fd0b@syzkaller.appspotmail.com>,
        andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, 9 Nov 2021 at 13:22, Marco Elver <elver@google.com> wrote:
> syzbot reported that the warning in perf_sigtrap() fires, saying that
> the event's task does not match current:
>
>  | WARNING: CPU: 0 PID: 9090 at kernel/events/core.c:6446 perf_pending_event+0x40d/0x4b0 kernel/events/core.c:6513
[...]
> This happened because the 'sched_wakeup' tracepoint also takes a task
> argument passed on to perf_tp_event(), which is used to deliver the
> event to that other task.
>
> Since we cannot deliver synchronous signals to other tasks, skip an event if
> perf_tp_event() is targeted at another task and perf_event_attr::sigtrap is
> set, which will avoid ever entering perf_sigtrap() for such events.
[...]

Hmm, I made the mistake of sending this in the merge-window.
Any comments?

Thanks,
-- Marco
