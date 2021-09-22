Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE54C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 06:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0720560FE6
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 06:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhIVGLx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 02:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbhIVGLw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 02:11:52 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52DCC061575
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Sep 2021 23:10:23 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id i13so1574202ilm.4
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Sep 2021 23:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WTKIbbjFL5ftDzChEKJxowEkuCqEUnULj5SPRAYGqOw=;
        b=ILHxf5m9/JRUXUVqxjW2cpR336Y944E94LJ9P/wflh81dxI0nAdxunFv0oWkbKHU4R
         J8nNkm4FND6Y4f7FeCTNq9m1elJAC9oc9nMhVPBP8Wq9VWNntqPzm6CgiUbIY7aptlyt
         VwSEOWfGWnq1cRxjZ5YcEvEhSvCiohNkvxkr42f2Bjen9LzbYeubitOtyNcG/OBYykFB
         BviHliu7rMpMVTpAFtOdhsLNRl+1HABL9rX0hn7YEGQa1MBTJ7FDx8zh4uwHiYde7tMR
         U60r0uT5EpP+Xg3zEjyGi1IIUAiwb0RbwvUZI3NPyCZ246p9ldyEGeR0oIXLpbRhV0Lg
         0Y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WTKIbbjFL5ftDzChEKJxowEkuCqEUnULj5SPRAYGqOw=;
        b=LKE5OuJ2tPKqb1aoD1x7tLqmFwGDi1NcumtwXouB4KH0UGALGsliB8F/KUDYYuz7zE
         /lHi3ZG5nOU99PNkhb+pFUulS04a3QRyQOYRZuh7Cq42SBtfs95LsX2r/24h63z5bCsc
         msGIva3chF6CozWMJNwByAWBNK5TMAbiZmqvcLqzM01OfOEVEHUQO27Ssrd+CEf5kpiU
         FXpcHxOL//TYz59sZTvNP37m+ou7s80ErhFRM+HfKnSCs19I0Xm7V0MDlE70WBPHUBF8
         2pMswouPJRVYoXbl5/onRYSMnueg7UHsbXnROXEuNmA+CBUkliLw3paPMIRkY4jy9cA6
         hD+Q==
X-Gm-Message-State: AOAM531KrOU1/PpaCyKtWHTL9bmMe+EFJIx1n+E/oCWsqAItYPOY4xdE
        Bl5fKQSvEDY7mZR1FjT4ybMhd1PtDDAoWi4k/dGCZA==
X-Google-Smtp-Source: ABdhPJwdqii1i9QOW/yQoNS4IeczINy7TiOmNS9Za+DRw4dTg4b5epQnlg6pVtORboW9u/OXAsxWeIQEk6DpjtaWjOo=
X-Received: by 2002:a92:c605:: with SMTP id p5mr23755994ilm.53.1632291022789;
 Tue, 21 Sep 2021 23:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210921131009.390810-1-james.clark@arm.com> <20210921131009.390810-3-james.clark@arm.com>
In-Reply-To: <20210921131009.390810-3-james.clark@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 21 Sep 2021 23:10:10 -0700
Message-ID: <CAP-5=fVF+LVFFHiBYfCesRmPiy7n2qZyTpMoH1eizQYMG9dPCw@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf tests: Improve temp file cleanup in test_arm_coresight.sh
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, leo.yan@linaro.com,
        linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Sep 21, 2021 at 6:10 AM James Clark <james.clark@arm.com> wrote:
>
> Cleanup perf.data.old files which are also dropped by perf, handle
> sigint and propagate it to the parent in case the test is run in a bash
> while loop and don't create the temp files if the test will be skipped.
>
> Signed-off-by: James Clark <james.clark@arm.com>


Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian


>
> ---
>  tools/perf/tests/shell/test_arm_coresight.sh | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
> index c9eef0bba6f1..6de53b7ef5ff 100755
> --- a/tools/perf/tests/shell/test_arm_coresight.sh
> +++ b/tools/perf/tests/shell/test_arm_coresight.sh
> @@ -9,8 +9,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Leo Yan <leo.yan@linaro.org>, 2020
>
> -perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> -file=$(mktemp /tmp/temporary_file.XXXXX)
>  glb_err=0
>
>  skip_if_no_cs_etm_event() {
> @@ -22,13 +20,20 @@ skip_if_no_cs_etm_event() {
>
>  skip_if_no_cs_etm_event || exit 2
>
> +perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +file=$(mktemp /tmp/temporary_file.XXXXX)
> +
>  cleanup_files()
>  {
>         rm -f ${perfdata}
>         rm -f ${file}
> +       rm -f "${perfdata}.old"
> +       trap - exit term int
> +       kill -2 $$
> +       exit $glb_err
>  }
>
> -trap cleanup_files exit
> +trap cleanup_files exit term int
>
>  record_touch_file() {
>         echo "Recording trace (only user mode) with path: CPU$2 => $1"
> --
> 2.28.0
>
