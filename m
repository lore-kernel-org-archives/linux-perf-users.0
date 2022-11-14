Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF1DC433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Nov 2022 18:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbiKNSVm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Nov 2022 13:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236568AbiKNSVi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Nov 2022 13:21:38 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4085B1F9CC
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Nov 2022 10:21:37 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id l14so19818047wrw.2
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Nov 2022 10:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3fM3xvJMAJZPiLtedRbSJTxYZ++wPBK4zKGdWqxdh5g=;
        b=snxPpEkxEmcPnaT/ZJtgeLLhQnKgtiAPw/hOzamIRbmoD16BuPOdlPoN7trs1trm+e
         fHygPn2DX58zVFLrj/eUPU66cE4I7LJp2+H5H/9/7iZ1jI8cnwSAc/oYyx8cti2XwAfN
         l9t2XuP+nBhpYJKqOBmCJP6EfYLDcXBxFCF7MJBttafLecCCvHcSEgdCLwAZnfIFLJms
         CZacYGUTBbXbpKHr/LqXHaZhbEPZSiHIG48u7bN7DGBY1NK+mtNAzzblrDjmmwb9yu0s
         JbjUFvZRsdO7CTjrZXcZYXfEnUxadbkktlmQNZ9jJpjv5DmJ3+75lO36tmBKOLmmPvys
         W4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fM3xvJMAJZPiLtedRbSJTxYZ++wPBK4zKGdWqxdh5g=;
        b=IhM020uO1Yk75a2npW4uLTobxpYezNOy7FZ6PU0b1zc2/GebTTIVOQ/Qs+tUOSia3J
         PCg4oxR2U1GM3IqmF7/wNvYKGhWugVfpRtpVZyM4iYabCQD9/uneb7W6GJvdeCMmTCH0
         Oqgrh3k0mcsseF+LWXjw0Q6eeBGrQ8QmHE6qYkSf6oOaEOOqYTpi7eGN0SOX1KiucNay
         GgjDonEmt312TWbhc0hRJc1RV91Lr8I3AzOzT0g61AV5B7tJR45YWcIlCy1fa0/ubz2p
         74elXK/Lq6R6VDhv8J8sYLbtg9j0kNBV+iO72/8GE3cxyw23vAns51ecoMpoStzRcwwt
         AEoA==
X-Gm-Message-State: ANoB5pmrjV2ZqExVydwmqzXSNgOUgyxW9+CZL+YxJ+RH9nVvd3oR+rv0
        DyGx9j5L7ZkV0UXlnrdegxCNuzU9pU5ncUB67wRPVQ==
X-Google-Smtp-Source: AA0mqf4+qzWMSkeNTKJ6hLea3l6MnDkMx4pVEYeNxv0fvdpHk4uCO1xtEq2dBJLki53Ew9bBrtKqjNjSY5DeN/KCbyk=
X-Received: by 2002:adf:ea82:0:b0:236:62d6:f586 with SMTP id
 s2-20020adfea82000000b0023662d6f586mr8359122wrm.40.1668450095599; Mon, 14 Nov
 2022 10:21:35 -0800 (PST)
MIME-Version: 1.0
References: <20221112032244.1077370-1-namhyung@kernel.org> <20221112032244.1077370-12-namhyung@kernel.org>
In-Reply-To: <20221112032244.1077370-12-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Nov 2022 10:21:22 -0800
Message-ID: <CAP-5=fV6bzkyxf=Uw3ugA_W=v-M=eLGueMXWQj20HzCfUAJ18Q@mail.gmail.com>
Subject: Re: [PATCH 11/11] perf stat: Add missing separator in the CSV header
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Nov 11, 2022 at 7:23 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> It should have a comma after 'cpus' for socket and die aggregation mode.
> The output of the following command shows the issue.
>
>   $ sudo perf stat -a --per-socket -x, --metric-only -I1 true
>
> Before:
>                   +--- here
>                   V
>    time,socket,cpusGhz,insn per cycle,branch-misses of all branches,
>        0.000908461,S0,8,0.950,1.65,1.21,
>
> After:
>    time,socket,cpus,GHz,insn per cycle,branch-misses of all branches,
>        0.000683094,S0,8,0.593,2.00,0.60,
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 96bb7a42fd41..a316807255cd 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -828,8 +828,8 @@ static int aggr_header_lens[] = {
>
>  static const char *aggr_header_csv[] = {
>         [AGGR_CORE]     =       "core,cpus,",
> -       [AGGR_DIE]      =       "die,cpus",
> -       [AGGR_SOCKET]   =       "socket,cpus",
> +       [AGGR_DIE]      =       "die,cpus,",
> +       [AGGR_SOCKET]   =       "socket,cpus,",
>         [AGGR_NONE]     =       "cpu,",
>         [AGGR_THREAD]   =       "comm-pid,",
>         [AGGR_NODE]     =       "node,",
> --
> 2.38.1.493.g58b659f92b-goog
>
