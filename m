Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C71C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Nov 2021 23:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA15610FC
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Nov 2021 23:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhKJXzD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 Nov 2021 18:55:03 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:33641 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbhKJXzD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Nov 2021 18:55:03 -0500
Received: by mail-lf1-f45.google.com with SMTP id bu18so9992368lfb.0;
        Wed, 10 Nov 2021 15:52:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+nKdcp1TUX0xwsKzzso7GogPgPSJJ3oZHCpyiunn6r0=;
        b=cuIpLBTQRoIbuZv2//15Lw+LmlAKDNZnjvtZ70E+nWc9h0vCpM6zlnSbvBios/qMbb
         TPV2GqDTQ2W7phUrUhECesvxGZIATCGGaolwpsm4oS3yDPkrXelKh5807hEPkjeMxZBV
         keRvsvsYs5OB5ZkMimO3iYxt6lYHHcOi01DTZWlqdci6mBfSYmILYFpDj49SkUrXPT7o
         XfNZiL3a1w8rLiPRD9YA2DPbwVjvmb+ZC1TCgLmRYMTJK876YzqP/xhiG7PYsxst7sNT
         xsOPpjV3WAxGkPwrsJQPHi2tB9k32EYWOuoNWpUZ7C87KhdJVLyXqTOYYFUXqeRcSqAg
         rPiQ==
X-Gm-Message-State: AOAM530UY0+2vgYtpSJzXXH2LCGHTQg0wFXXz05QNXZMGX65KSWuZv1q
        lexFAyoHkhMlNEOK6TPhxHVz0qdu4L/RXlnPKEI=
X-Google-Smtp-Source: ABdhPJyse7KNiO/ZZZESkZFi9JeAfu4BDjDxewSLRhAwXYuWGd9bCcoGB/SDAK77C+VN3E9oGk4LXD85jlugOS8vJrY=
X-Received: by 2002:a05:6512:b8c:: with SMTP id b12mr2706877lfv.99.1636588333775;
 Wed, 10 Nov 2021 15:52:13 -0800 (PST)
MIME-Version: 1.0
References: <20211109163009.92072-1-german.gomez@arm.com>
In-Reply-To: <20211109163009.92072-1-german.gomez@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 10 Nov 2021 15:52:02 -0800
Message-ID: <CAM9d7cgya96juY8+2CsMZztvU73Y-U0wS4=46An4+=3CSdd3mQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] perf arm-spe: Add snapshot mode support
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

On Tue, Nov 9, 2021 at 8:30 AM German Gomez <german.gomez@arm.com> wrote:
>
> This patchset adds snapshot mode support for arm-spe.
>
>   - [PATCH 1/3] implements the minimal callbacks to support recording in
>     snapshot mode.
>   - [PATCH 2/3] implements the find_snapshot callback in order to handle
>     wrap-arounds in the AUX buffer.
>   - [PATCH 3/3] adds a test for spe snapshot mode.
>
> ---
>
> Changes since v1:
>   - Added acme@kernel.org to the recipients list as I forgot to include
>     him in the original patchset [1].
>   - Removed [PATCH 1/5] and [PATCH 2/5] in order to keep patches
>     semantically relevant.
>   - Updated test script test_arm_spe.sh because it wasn't working on
>     distributions that use dash shell v0.5.10 (ubuntu 20) [2].
>
> [1] https://lore.kernel.org/all/20210916154635.1525-1-german.gomez@arm.com/
> [2] https://lore.kernel.org/all/fd65eb63-d4ca-2105-74cb-c717ad2eb7d3@arm.com/
>
> German Gomez (3):
>   perf arm-spe: Add snapshot mode support
>   perf arm-spe: Implement find_snapshot callback
>   perf arm-spe: Snapshot mode test

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

>
>  tools/perf/arch/arm64/util/arm-spe.c   | 275 +++++++++++++++++++++++++
>  tools/perf/tests/shell/test_arm_spe.sh |  89 ++++++++
>  2 files changed, 364 insertions(+)
>  create mode 100755 tools/perf/tests/shell/test_arm_spe.sh
>
> --
> 2.25.1
>
