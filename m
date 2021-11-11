Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209E9C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 17:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC67B61268
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 17:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhKKR0Y (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 12:26:24 -0500
Received: from mail-lf1-f47.google.com ([209.85.167.47]:38763 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhKKR0Y (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 12:26:24 -0500
Received: by mail-lf1-f47.google.com with SMTP id bi37so10855265lfb.5;
        Thu, 11 Nov 2021 09:23:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=89eWb+BbvalK+w5Mc6cUfBs8kDWrHjXvg4EaZ2R2HWg=;
        b=UykTfzlxX+W9awqVG9buZvx83XZPT9XaS7ndztGZqAv9HNQ2+e6t6dqoT4gl95hUga
         jjv+DPISrBsH6Pmk9hQoGKOES5e/ll5U+KKxSe4M+TK5mQrw10fqANY5LDwJxgSm9YDX
         Jaga8xoWWqCAAymkeTHouSy0/SjSkJoyemWdBRQJ9MmF3raMoFmORREWOSTecGkecArk
         l1GOrCu7COGszRWSx0deXLv9cLoAq0H3qW6LPiQYA2dJ6xF2SZ457gGm3A5CfOpf1Yqk
         G9VsyniNBcB0QDurseR2LAE3wZ2Tg2w891ab5Od5RtCyPjR3B8LXdhh0iSoXJ2YDrqaz
         Jk/A==
X-Gm-Message-State: AOAM533g6fK9aGO+IVTFWv1Anj4y9EigCtvWowqVl3dGFY8XX8f0T0so
        OntIuPsEoPIwXneAwmlnn9jwdfEC4Cko1Vjn+Is=
X-Google-Smtp-Source: ABdhPJz9fENr/SPGizW9fDv9mUizjaQ2xLA8gD00TBkzy3s2mS45eIFUywGUQe6AFKZQMoRMXpXOSHikIcTzyDxwfCI=
X-Received: by 2002:a05:6512:22c3:: with SMTP id g3mr7922212lfu.528.1636651413501;
 Thu, 11 Nov 2021 09:23:33 -0800 (PST)
MIME-Version: 1.0
References: <20211111133625.193568-1-german.gomez@arm.com> <20211111133625.193568-5-german.gomez@arm.com>
In-Reply-To: <20211111133625.193568-5-german.gomez@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 11 Nov 2021 09:23:22 -0800
Message-ID: <CAM9d7chUkk-e0-giLH_moiEri2N28+G1cE-F3+JsXHK89vDJWg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] perf arm-spe: Support hardware-based PID tracing
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Nov 11, 2021 at 5:36 AM German Gomez <german.gomez@arm.com> wrote:
>
> If Arm SPE traces contain CONTEXT packets with TID info, use these
> values for tracking tid of samples. Otherwise fall back to using context
> switch events and display a message warning the user of possible timing
> inaccuracies [1].
>
> [1] https://lore.kernel.org/lkml/f877cfa6-9b25-6445-3806-ca44a4042eaf@arm.com/
>
> Signed-off-by: German Gomez <german.gomez@arm.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
