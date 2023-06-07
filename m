Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFD5C7EE2F
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jun 2023 01:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240549AbjFGBpy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Jun 2023 21:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240555AbjFGBoi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Jun 2023 21:44:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADC019AB
        for <linux-perf-users@vger.kernel.org>; Tue,  6 Jun 2023 18:44:36 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bb38ef6410fso2416703276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Jun 2023 18:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686102275; x=1688694275;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fshr5jLOyahMpvACdtGm+pjjbvWJsJPp9lrbSfOHRQ4=;
        b=PqUIG6TC384eWp8yePeRY3y04FFjxR8xrrRlKe0sh94cVkvPpU1nj8UPwk5vlulYyI
         bmqDSHAP8w3Wcsbgci9MuYV4Acb87bD58mlXADcVA8yn0riFxA6sGwAbcHbwotsDaZDN
         1h1rQcVWjsLaJlCMbCFr3VFR3wj9PZ3/3vyqn8RXEB+dmVy5jOXvDhCNIXUJHDSQu2Nb
         UXQX4drjVbDTCHgiR4LX6WLpHL+t4OJ2dJ0gc/QTIyJ6dJHfWUe0z5BnMDQitwOBrkDo
         JYezMehZm8kF5/NdFzieGjoCdO+RcrMcoNkrmSqoILtxM7RLIcjfbaG0Maru1KEdWC5s
         s/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686102275; x=1688694275;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fshr5jLOyahMpvACdtGm+pjjbvWJsJPp9lrbSfOHRQ4=;
        b=N2OGto1Yi3LG+RNBKMafIS2QsGAyR7rEX/Fa+sEVRJV3eczjW3k+auW5cPc5KOXmuK
         rALEh+RYeAGMH0Lh5E/hP9XYObI3CMAprcws/SAUbYZDwrxz5YOy1tXy7XjMusoZl/N8
         pih4qXVPZgN4j1fd+LeMRgvU8nen0PnoHSckowngQE+fzGc9b0JzoPh0A7N+id5crxFK
         udPpv5XH4lw/3laeb7BHL8nQH0zLMJ9/WzVeexFUTbWHnjCQetvpl2T1LSYGg1GB02TG
         NqOHLcGjqAjezqemEzO1VI46uYe9D+vF6G+3N5CSj7Qoi8201k7YjuVjAWWsTXzdA5LX
         ryhA==
X-Gm-Message-State: AC+VfDw0EpQsMezggj0TBrouO0nlb8lHaihxJ7us43kkqAHYQfLsyCOd
        VGeic1lBIJ8Ctg2ssOXsDQp/6sTN5K3o
X-Google-Smtp-Source: ACHHUZ4dungIIgBmPrtJau2qDI0PSJma622cWj+i8l+PD1GxRjpw3bAGLjhUHn/JDRGI6ujvUT5RGVthXFg1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3c35:209f:5d38:b7a1])
 (user=irogers job=sendgmr) by 2002:a25:40d:0:b0:ba7:d142:eada with SMTP id
 13-20020a25040d000000b00ba7d142eadamr2053213ybe.7.1686102275411; Tue, 06 Jun
 2023 18:44:35 -0700 (PDT)
Date:   Tue,  6 Jun 2023 18:43:44 -0700
In-Reply-To: <20230607014353.3172466-1-irogers@google.com>
Message-Id: <20230607014353.3172466-12-irogers@google.com>
Mime-Version: 1.0
References: <20230607014353.3172466-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 11/20] perf stat: Avoid evlist leak
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        "Shawn M. Chapla" <schapla@codeweavers.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Raul Silvera <rsilvera@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yuan Can <yuancan@huawei.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        liuwenyu <liuwenyu7@huawei.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Free evlist before overwriting in "perf stat report" mode. Detected
using leak sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index c87c6897edc9..fc615bdeed4f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2427,6 +2427,7 @@ static int __cmd_report(int argc, const char **argv)
 
 	perf_stat.session  = session;
 	stat_config.output = stderr;
+	evlist__delete(evsel_list);
 	evsel_list         = session->evlist;
 
 	ret = perf_session__process_events(session);
-- 
2.41.0.rc0.172.g3f132b7071-goog

