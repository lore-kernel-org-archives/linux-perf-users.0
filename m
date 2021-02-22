Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D91C433E6
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 Feb 2021 22:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A01E64E25
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 Feb 2021 22:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhBVWLk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 Feb 2021 17:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbhBVWLf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 Feb 2021 17:11:35 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F58C06174A
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Feb 2021 14:10:54 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id u4so8336395lfs.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Feb 2021 14:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BBkjWiCKDwxxyhkLkU0CXVeC0iCvJ041DtGGGn17nrk=;
        b=Q+vHXymAuG0dmicU7e8Sv9nKyrbu3R1a5j7rcu8wI/vlsV07t3962X9ArHRNmm3Ny9
         8YDpq8h1Fwgc7iqpjMeC2DwLWKLApEpisfWe2e1mQzfO83B5ZTgDZ0iRiOTMScLLhcSA
         4t/I8p1eh/zpEr/RbKweUg0vSrEipqwu8t4Bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BBkjWiCKDwxxyhkLkU0CXVeC0iCvJ041DtGGGn17nrk=;
        b=tRSbuahoyOTCx7zbCqf6Y4YYkoeVBhCJ/+znVj1rFnmnHhMRLqL/hceXHUIRk/k1Go
         t48Ulf7F/kjF4DXPU20w/Tq3AjhPAy39u1iqlRPwST3OlP+p1n3CFJovmLszZjqNl4Dh
         QeP0GPVj3xP2xqv9pDntDXSXiJgmyIVBvkqe6MVlXjAUf+BecpJF+Jf/8QksqR1qsKH4
         reP0HSy3ZOdZA0Fd66CXt1Go6q6zqREhG3ygm95whTxTvgahE8MSSKXbzzvja5zB1wjz
         +OXznzS7oK8/MA3bYimvPqG7P/o7z8n8nwZF4MoYG++jWSNOO7cQdNhWaYmboeQLQTHk
         3f8w==
X-Gm-Message-State: AOAM5327CiTNgrd4j32IbnezowZ/k6IZIVuOU3blpUz4A/nEDrwy5c0a
        YR8AFRxZdW3qFcRqEtLAD6cwcFYGkXNB2g==
X-Google-Smtp-Source: ABdhPJwfgTIU9jKgkxahwIQugDRJg1+/mDpeGIw4Y6DXGi9IDYcaBXm9/cZ9OqJZ5Bffp9CAgeA9Qw==
X-Received: by 2002:a05:6512:3442:: with SMTP id j2mr15394336lfr.73.1614031851402;
        Mon, 22 Feb 2021 14:10:51 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id u25sm2382219ljo.98.2021.02.22.14.10.50
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 14:10:50 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id d3so8175227lfg.10
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Feb 2021 14:10:50 -0800 (PST)
X-Received: by 2002:a19:8186:: with SMTP id c128mr14681033lfd.377.1614031465521;
 Mon, 22 Feb 2021 14:04:25 -0800 (PST)
MIME-Version: 1.0
References: <20210219194619.1780437-1-acme@kernel.org>
In-Reply-To: <20210219194619.1780437-1-acme@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Feb 2021 14:04:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=whgmx7FLSoYu0+6TnFjex_uYMN9=15m=6BkZn0HyREisA@mail.gmail.com>
Message-ID: <CAHk-=whgmx7FLSoYu0+6TnFjex_uYMN9=15m=6BkZn0HyREisA@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v5.12
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Dmitry Safonov <dima@arista.com>,
        Hans-Peter Nilsson <hp@axis.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Jianlin Lv <Jianlin.Lv@arm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kees Kook <keescook@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        Mike Leach <mike.leach@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Feb 19, 2021 at 11:46 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Test results at the end of this message.

Thanks, I appreciate the changed format,

              Linus
