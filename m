Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11469C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 16:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEBF461262
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 16:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243117AbhJGRA6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 13:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243120AbhJGRAc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Oct 2021 13:00:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898C3C061773
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Oct 2021 09:58:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g2-20020a256b02000000b005b71ee6a855so8660477ybc.8
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Oct 2021 09:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sD97o6/X2T3R9DPG5jECD/BRBjX1KrzIYBtZ7Q6nsbo=;
        b=MAW6dNcxI7sBqod8iQLCxouyPeajlfxLO8OlzwzRxMGjIifpeNUfpq9Kzkn2Bc8bA3
         Rdj0xQ/tu/N+IWZCEQC4mcN4Ox5X3HRRhpYXEH5ue+6Fo8cOtg7/wDSLw1ffC6YQbCnr
         8qJYrDpuJgWusKzWs8YcvpAYvXh+lAlXXIH/VIfZlaw1/vKs86hxBiqms6wK1XVxWUEF
         s0feMolrc20sUWV/dnxnI0rygkaELswEIZrrVxzyFr0nx2mGqPYoh31EbSte8IYKNO3d
         Pf2Taa9FI6z4XTg9C6bIMld2/ErasV8nK+reRxoDEpiqiL8QGfLeHd1YtgOHTYsfTwSs
         PCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sD97o6/X2T3R9DPG5jECD/BRBjX1KrzIYBtZ7Q6nsbo=;
        b=NdQP88BDz45nt0O5zY9k0n/nFD7a59HGC3see11MOU6+KjqMuIdiIg16iGiXj5GF6l
         gNVxl37zJIj3dUI0Yo5ufAuV5PxBnHn3FMDFcwEfmeMBF2lR3couM0SPOXwfookxItu9
         w7g8Lp9SqtzhJkidvslctKBOIQtbyoHnMc8SxA9qwwUEb05Eg1CiKyI3sTmRKwwarApv
         5VJKS9UwP64oobpQuylPqQAciXPBQhGlURmUSW/Qb/9i4QUdhSvTYKwZYNiExu73KeTR
         OGHT3YRIkgo9rRCLk/TJuJ1FZtChQqNmYiu7JXnTXqAuA24s+d1Vhirsj6a/smO9w9FL
         7SDQ==
X-Gm-Message-State: AOAM5310lyUjYrvmeQvJXTbvJaiBv1DudIIrI1LLiP+HqbXGPhYDzOGT
        sJQhguYzjFEs0jKxjqzT/j+DJfMGQfxE
X-Google-Smtp-Source: ABdhPJxCW+kx0pbXO+OmetogQckikpKf0IFrvexuzCNpvt8JPKeOrjgU0HEk0IBRRAYLDIzU5ntPkpz5Vs2H
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:fe85:5e36:cb6f:76bc])
 (user=irogers job=sendgmr) by 2002:a25:59c6:: with SMTP id
 n189mr6611466ybb.517.1633625895411; Thu, 07 Oct 2021 09:58:15 -0700 (PDT)
Date:   Thu,  7 Oct 2021 09:56:45 -0700
In-Reply-To: <20211007165647.3514803-1-irogers@google.com>
Message-Id: <20211007165647.3514803-20-irogers@google.com>
Mime-Version: 1.0
References: <20211007165647.3514803-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 19/21] perf metric: Switch fprintf to pr_err.
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        ToastC <mrtoastcheng@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Felix Fietkau <nbd@nbd.name>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Song Liu <songliubraving@fb.com>, Fabian Hemmer <copy@copy.sh>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Denys Zagorui <dzagorui@cisco.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

There's no clear reason for the inconsistency that stems from the
initial commit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index ac60c9f1b3b5..c588243a2d53 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1172,7 +1172,7 @@ static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
 		ret = metricgroup__add_metric(p, metric_no_group, metric_list,
 					      map);
 		if (ret == -EINVAL)
-			fprintf(stderr, "Cannot find metric or group `%s'\n", p);
+			pr_err("Cannot find metric or group `%s'\n", p);
 
 		if (ret)
 			break;
-- 
2.33.0.882.g93a45727a2-goog

