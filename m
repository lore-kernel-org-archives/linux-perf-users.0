Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BBFC64E7B
	for <linux-perf-users@archiver.kernel.org>; Mon, 30 Nov 2020 14:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 544C620725
	for <linux-perf-users@archiver.kernel.org>; Mon, 30 Nov 2020 14:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgK3Oe3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 30 Nov 2020 09:34:29 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38967 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgK3Oe2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 30 Nov 2020 09:34:28 -0500
Received: by mail-lf1-f65.google.com with SMTP id j205so22023095lfj.6;
        Mon, 30 Nov 2020 06:34:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8YkcOXBhPRFIqBGIfVEc2ybUnI8ZtfJ9QAi+Wv6+Psc=;
        b=eUKKdJN115G6LIkcsT9YTnt1IsviXnTmsRK1d5Wq0jqI37fFTWYyELnMtO+vPgxNAh
         bSCyCbj4dqT+vvq+bGZO26HdkTXh32BcxDwx1pq4UeXPLo68Y7AE33ckcy6YArI6SKts
         xfzCp7l4CmLkSz/R/2CWuAOdlBfb9MEX3suj1T8LbmyyBzGw2RLxhSbE+vPn3N7ps1W6
         pgrhSnmVh3BcCrr6FM5LJxL6k183Sv64/QsR44WZNl/kkYePqHDoQQuS3ZF3Plk7yTkX
         WRL6CJUrdIJCV7Bt6gIak+0mbJoQGiLshKbjOc0eC1lpYG7uSw9VHjcdqCwJh85tsi2s
         8/sw==
X-Gm-Message-State: AOAM531LHY+NBzA6Ym17NFU5hM1lX3NOCkdB4aVlFUaOlhFio8c/PoGS
        EB/sIHMdnSvOfPfslq/pHouYa1/6Bl5wnLOdrLA=
X-Google-Smtp-Source: ABdhPJwlG6QMaNGMPb2gPkPlyqGaKbiUhwbKmXSmogtb7ZahR6PluAlOGCFNc3sjNtliHP+BdCrmwGC3Zh2JnMhjVeE=
X-Received: by 2002:a19:4154:: with SMTP id o81mr8986318lfa.540.1606746826174;
 Mon, 30 Nov 2020 06:33:46 -0800 (PST)
MIME-Version: 1.0
References: <20201126141328.6509-1-james.clark@arm.com>
In-Reply-To: <20201126141328.6509-1-james.clark@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 30 Nov 2020 23:33:34 +0900
Message-ID: <CAM9d7cgVkiRMiSVO25s0DMYE7q8_Uc7Xn8E4kXf6CUbNy86_hQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/12] perf tools: fix perf stat with large socket IDs
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

On Thu, Nov 26, 2020 at 11:13 PM James Clark <james.clark@arm.com> wrote:
>
> Changes since v5:
>   * Fix test for cpu_map__get_die() by shifting id before testing.
>   * Fix test for cpu_map__get_socket() by not using cpu_map__id_to_socket()
>     which is only valid in CPU aggregation mode.
>
> James Clark (12):
>   perf tools: Improve topology test
>   perf tools: Use allocator for perf_cpu_map
>   perf tools: Add new struct for cpu aggregation
>   perf tools: Replace aggregation ID with a struct
>   perf tools: add new map type for aggregation
>   perf tools: drop in cpu_aggr_map struct
>   perf tools: Start using cpu_aggr_id in map
>   perf tools: Add separate node member
>   perf tools: Add separate socket member
>   perf tools: Add separate die member
>   perf tools: Add separate core member
>   perf tools: Add separate thread member

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

>
>  tools/perf/builtin-stat.c      | 128 ++++++++++++------------
>  tools/perf/tests/topology.c    |  64 ++++++++++--
>  tools/perf/util/cpumap.c       | 171 ++++++++++++++++++++++-----------
>  tools/perf/util/cpumap.h       |  55 ++++++-----
>  tools/perf/util/stat-display.c | 102 ++++++++++++--------
>  tools/perf/util/stat.c         |   2 +-
>  tools/perf/util/stat.h         |   9 +-
>  7 files changed, 337 insertions(+), 194 deletions(-)
>
> --
> 2.28.0
>
