Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0359C6FA8F
	for <linux-perf-users@archiver.kernel.org>; Wed, 30 Aug 2023 02:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjH3CYq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 29 Aug 2023 22:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241698AbjH3CYO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 29 Aug 2023 22:24:14 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF195CD2;
        Tue, 29 Aug 2023 19:24:10 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-79266c8617eso179629139f.3;
        Tue, 29 Aug 2023 19:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693362250; x=1693967050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mstyt0rJV9jATAHbCU7sV0Q1Sdf6cQfb/l6RWW5e8sw=;
        b=F3RbpGQfUI/v3CPNcvQKAMMjMnyXIqwhu+Zl7oSBm9UAk51gqqXFpi/pSgUXywjaal
         c3Yn4GFj/209Y5NsMyobpQJVQZfXtb0JpoN2LZWqTW2zcIUqMweghy8mf/8SWuVdVc9K
         5Xjg5Q3o8B04wgMaZPQK3N7k/NzXQspvSvWQ5j808bpQt8wi0tJbFAIhp9JyUi0EUro+
         wxc4gJUFSQLby6hMQJ3rZ1iyyEhXqEfkCPPrfD1Wc5rHZCFCaJijqCaxAHXvQwHDV+Lf
         zaS6dVxWLA5FRLAGBBSOugLuJw+qb3j1GQagdSBKSLvr9dmY7T2OcXWpnY2QuZvzadFG
         aQpA==
X-Gm-Message-State: AOJu0Ywic1SV0pwaUCeiu9hotjmP2/GBXd4lvigNNtiWGeskjBp/A7jk
        1lpYxpbegFVMmC8hNp1eiJb0pGfb5aFD84XYpp8=
X-Google-Smtp-Source: AGHT+IHnLxqWmkF13kvBfmjhF+wdReYl0t+LQDTGqJAgNHr8lNUsiOCr507OhgX6/BYB8jrMPDh3sSZsuvXf2HsAXhQ=
X-Received: by 2002:a05:6602:218a:b0:795:fa0:c15 with SMTP id
 b10-20020a056602218a00b007950fa00c15mr1318108iob.6.1693362250119; Tue, 29 Aug
 2023 19:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230830000545.1638964-1-irogers@google.com>
In-Reply-To: <20230830000545.1638964-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 29 Aug 2023 19:23:58 -0700
Message-ID: <CAM9d7ciUho=P8AnSq6inUudw15d8e=epke-XQFkpx5wuDgtikw@mail.gmail.com>
Subject: Re: [PATCH v1] perf pmu: Avoid uninitialized use of alias->str
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Ian,

On Tue, Aug 29, 2023 at 5:05 PM Ian Rogers <irogers@google.com> wrote:
>
> alias is allocated with malloc allowing uninitialized memory to be
> accessed. The initialization of str was moved late after it could have
> been updated by a JSON event, however, this create a potential for an
> uninitialized use. Fix this by assigning str to NULL early. Testing on
> ARM (Raspberry Pi) showed a memory leak in the same code so add a
> zfree.
>
> Fixes: f63a536f03a2 ("perf pmu: Merge JSON events with sysfs at load time")
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/pmu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index cde33e01959a..b3f8f3f1e900 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -532,6 +532,7 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
>         if (!alias)
>                 return -ENOMEM;
>
> +       alias->str = NULL;
>         INIT_LIST_HEAD(&alias->terms);
>         alias->scale = 1.0;
>         alias->unit[0] = '\0';
> @@ -593,6 +594,7 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
>                         ret += scnprintf(newval + ret, sizeof(newval) - ret,
>                                          "%s=%s", term->config, term->val.str);
>         }
> +       zfree(&alias->str);
>         alias->str = strdup(newval);
>         if (!pe)
>                 pmu->sysfs_aliases++;
> --
> 2.42.0.rc2.253.gd59a3bf2b4-goog
>
