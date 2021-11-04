Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE53C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 02:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24E65611C4
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 02:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhKDCiY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 Nov 2021 22:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhKDCiX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 3 Nov 2021 22:38:23 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A595AC061714;
        Wed,  3 Nov 2021 19:35:46 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id w23-20020a4a9d17000000b002bb72fd39f3so1454231ooj.11;
        Wed, 03 Nov 2021 19:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JrSbi7yceXbT6d12EbYqGSwgkyXAE5np80NJ5omtIzY=;
        b=FBmJZadqmgv8CsvnpS397JTFeBF1CXthSjScp+YLDLuxD+s+4jVwabBG0dyb7YU+KZ
         CLjkwQVc+WtfXFk660gXTDwuvHvGNXfxQlgVhTSgBA0m29ksEAzulUyoCRwaOIfaBQMK
         JZqMtKl4h/dHGmddnLFu+qjJdN1cBrw6H10zJlwkzL61O9H8RZMpeN5g0sG8EuhwF8Nz
         SkU2abBtZq1ZN/uDWZFH65XjF3eGpcOtvB/ptF0uvvB29u9ptXrUgmaBxOk3O+Q64E+r
         Rky90+97vGfhjxa05Nx5SGqoyDceVKf/9awqrD8oj03EEkEPYVE8Xpkzz8XCE9X0oPJ9
         P/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JrSbi7yceXbT6d12EbYqGSwgkyXAE5np80NJ5omtIzY=;
        b=mcSdAq/Ud34KTUC/9mq0f6T+p0Dt6n5gxO3zNDPb/O4lhjKZZ+IKx3OFgvgUurbklh
         SG95RofQAJa1uvkErWTA6sw8+4qmMwHDCHIOijZmleqpMCE4qtvzyj4/1s031IS7gWRw
         1nlP59LR+SlT/d1O49974oclpZwZB1fqmGcR1c7aWOtuVyPIe4SUVSGLpaXvTwoxTZih
         GzcZ5I0WsqRjYRPZPbL6J+QkjaY6k4W7ukyigRxDjgf/gcheiOX9NZW8PPWC/CPbwZ2M
         3v6M8BkjA+y4maNC2GNu9ZJaxHfeA5NgvKs+uULqyR/dNhtRT2LqZDxFrelP8LkvVFPK
         V8ew==
X-Gm-Message-State: AOAM531/hPgWJFbWbgNR43qFULdrRWUViguFNYcXq5m0uo0Obczg/cHs
        ozU2obE7oyT6tNs17dK7lGY8cZJKLOpAqjzQQlM=
X-Google-Smtp-Source: ABdhPJwgC6GERXI+T4b953pOq7So1ExoKH10nLhGYakrJWCbFOOc9lrR2lKgIC4ZLvmlYOYIq5JRbdAulpzjFql0NXA=
X-Received: by 2002:a4a:b307:: with SMTP id m7mr1625105ooo.83.1635993346065;
 Wed, 03 Nov 2021 19:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211103091716.59906-1-likexu@tencent.com>
In-Reply-To: <20211103091716.59906-1-likexu@tencent.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Thu, 4 Nov 2021 10:35:35 +0800
Message-ID: <CANRm+Cwo+oEoA4pCy-r5FnUdvY+oxAys0FNm7JHVHCCHW1rxWA@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/vlbr: Add c->flags to vlbr event constraints
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, 3 Nov 2021 at 17:17, Like Xu <like.xu.linux@gmail.com> wrote:
>
> From: Like Xu <likexu@tencent.com>
>
> Just like what we do in the x86_get_event_constraints(), the
> PERF_X86_EVENT_LBR_SELECT flag should also be propagated
> to event->hw.flags so that the host lbr driver can save/restore
> MSR_LBR_SELECT for the special vlbr event created by KVM or BPF.
>
> Reported-by: Wanpeng Li <wanpengli@tencent.com>
> Fixes: 097e4311cda9 ("perf/x86: Add constraint to create guest LBR event without hw counter")
> Signed-off-by: Like Xu <likexu@tencent.com>

Tested-by: Wanpeng Li <wanpengli@tencent.com>
