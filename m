Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027BBC433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Nov 2022 18:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbiKNSS0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Nov 2022 13:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238349AbiKNSSH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Nov 2022 13:18:07 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922D42EF32
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Nov 2022 10:17:36 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bs21so19805309wrb.4
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Nov 2022 10:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ReBzsBimdpveLsy+Lkg8Fji3O2Fl/6cfbARc8AiQfvs=;
        b=NMN/xH8R+SLKUOKCqztbFprqD4QQFBZBIMsn2qSQwp5gh0JsF10UlcY1OBJC4qgOlW
         7ximjAX4ZJ6Gj3x9e/4ZiPRTdZteuQiDYVTKAPoRSJO5XhpPfT626xd3g1n5IOx29b5G
         V16b2eg/y3XsLMUg53LRs8XdHewdUHf5ujP23Dt2kscw4jNXyTBimpkdCIdGUC+IF3sW
         z76Zt86/kfvLdSld/bSODvQbEnDL+6WEm5YCP1QdfBEyNj4hxsglk82oU0B3cpRRX9UW
         Ytipd0OsoPd+NuUHeMKLd2xmztnyptsPnSkC18B0ZMYosLJcWXTYo+yI9FHGXZJ/jxaZ
         rkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ReBzsBimdpveLsy+Lkg8Fji3O2Fl/6cfbARc8AiQfvs=;
        b=franngAonU4NbtVPBgCR+l+eB2RXi0dToDGzo78Zuny8q0uqXB5riOvqLe+1oaVYRw
         EDp91/F1wRinVk7OAkrYoxSmxmleR+e6kmLeYNbF+a5x63MmT557Q3z84jocTWi1rfX9
         lFj3zRrM0Fx7LJKSNMgVBP79C+SYNhdRgzpCW+8iLsNuBS+VgzW3eO7dhm4oN9HRstPu
         mxQMhFwcqUrqGziZuWYMifEBlxdokaEbPPZ011rquGTcJsjnx1O/keepo6IC47XEGcCG
         L6rw1pMR0zUnkHCthP4W2qFCrzNZ0m20CM16lAQWsIzDHM+15G+qy6yI5zPXbGm7RIJR
         6qOw==
X-Gm-Message-State: ANoB5plmUJi4jmtMocynm7vF1u95Qn5In9hotdnuhOFjFeqIizwm3Llp
        7IJ1p2la+7tHtDptGOo0XdnQdRhtZanBv4e05f+SEA==
X-Google-Smtp-Source: AA0mqf4j2XZu4W7wXvD7hTiCUa5tk5anNfQoyv5Q23/o/kY8GrZvi3Lo4Tpw1PP0IkdLpHg/OlFk8Nyg865KgGd6n1k=
X-Received: by 2002:adf:a492:0:b0:22d:d4c:e99c with SMTP id
 g18-20020adfa492000000b0022d0d4ce99cmr8270139wrb.582.1668449854955; Mon, 14
 Nov 2022 10:17:34 -0800 (PST)
MIME-Version: 1.0
References: <20221112032244.1077370-1-namhyung@kernel.org> <20221112032244.1077370-2-namhyung@kernel.org>
In-Reply-To: <20221112032244.1077370-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Nov 2022 10:17:22 -0800
Message-ID: <CAP-5=fWwnnRDDyf+DknFYU4aYeagXeemXOK9X-yP9Tax+bVnNA@mail.gmail.com>
Subject: Re: [PATCH 01/11] perf stat: Fix crash with --per-node --metric-only
 in CSV mode
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

On Fri, Nov 11, 2022 at 7:22 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The following command will get segfault due to missing aggr_header_csv
> for AGGR_NODE:
>
>   $ sudo perf stat -a --per-node -x, --metric-only true
>
> Fixes: 86895b480a2f ("perf stat: Add --per-node agregation support")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 657434cd29ee..ea41e6308c50 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -534,7 +534,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>                         [AGGR_CORE] = 2,
>                         [AGGR_THREAD] = 1,
>                         [AGGR_UNSET] = 0,
> -                       [AGGR_NODE] = 0,
> +                       [AGGR_NODE] = 1,
>                 };
>
>                 pm = config->metric_only ? print_metric_only_csv : print_metric_csv;
> @@ -819,6 +819,7 @@ static int aggr_header_lens[] = {
>         [AGGR_SOCKET] = 12,
>         [AGGR_NONE] = 6,
>         [AGGR_THREAD] = 24,
> +       [AGGR_NODE] = 6,
>         [AGGR_GLOBAL] = 0,
>  };
>
> @@ -828,6 +829,7 @@ static const char *aggr_header_csv[] = {
>         [AGGR_SOCKET]   =       "socket,cpus",
>         [AGGR_NONE]     =       "cpu,",
>         [AGGR_THREAD]   =       "comm-pid,",
> +       [AGGR_NODE]     =       "node,",
>         [AGGR_GLOBAL]   =       ""
>  };
>
> --
> 2.38.1.493.g58b659f92b-goog
>
