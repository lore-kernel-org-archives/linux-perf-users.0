Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7521FC7EE25
	for <linux-perf-users@archiver.kernel.org>; Thu,  8 Jun 2023 23:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbjFHXaV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 8 Jun 2023 19:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237653AbjFHXaG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 8 Jun 2023 19:30:06 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AF93A85
        for <linux-perf-users@vger.kernel.org>; Thu,  8 Jun 2023 16:29:50 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5689bcc5f56so15339477b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jun 2023 16:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686266989; x=1688858989;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/2LYKvHE8++IbYuq2taMyw/mM4bdVG+zrMSa7VFSz/Q=;
        b=TzbIJ3uKa81+rbLJkY63DCqEspBrctev4zihyaioZdgdzF2s9eiAawlQ2rtBvTpcK4
         OKa438YpLrFDHiUgPR8wQIWLAw5Fa7+9vO/XqxYqscHc2eARkG/XHu4aNtjwjqfC5fdf
         o4p8ANN0LoHEJF0BdH019q3qRdUASdoVJofuu+Jeca0kfZbD4N8TTyI9R71fQrI2G7Jy
         5LpwsrNkjW/VPcvOEIzeEiTSVVfZ9n4v+9eWDO1AODUSRvYnWqsQcvfvhN6yCirSMo5u
         hX9Pr7weJ4y1KL9S6Nuw4QY2+/48Ury50XWQINKQlXClBzfcxY1s9p+n19rFEtcTyE2H
         rCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686266989; x=1688858989;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/2LYKvHE8++IbYuq2taMyw/mM4bdVG+zrMSa7VFSz/Q=;
        b=RPX55jBv84ZDpuf6Q7kQka/f5ZGfnwwKr2WmZDdHYLkc2wsfK1SuckNLgwLvwJMMxs
         7x/ZuOLWtqdFupwNJYiqMwWnB5ByZaKe7LIhhkE4AkMOjMWpvaAtZjVcWCferaCx8tNF
         7TJ6YR8zYjyhjQTyx+7meDjjFVNbT+6CHHjS0gh96ZQirXEJv7wZKeKatTFp00LKGkCO
         ZpARZwamnB6GRc8lOU0qkVt7zGClZPiSrDSP0gTxk/DfX3sYCZQEVDVyDNt2DSkEszf8
         dVkZ3oTL6paEE6fBJuPI/e00al+8G636UCTl9+zw5Nx16SZo9vJeDoeSLcNuN3s9+uoF
         A+OQ==
X-Gm-Message-State: AC+VfDzIDdyv+Y6tg+bPm0tgwe3VoMvyElvAkop97z4V6eQzl342m3IR
        HoMnj9jfUlz3qM1Obubz58oCLtzaWcla
X-Google-Smtp-Source: ACHHUZ5fZsV7EmshvlIw+kk99S5h/NVh0r5rwl0Jo3LCmFqB69mG7iqRhyVa6eIIBq1xAgoAmjMk5CkQjnrI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a05:690c:702:b0:565:ebd4:304d with SMTP id
 bs2-20020a05690c070200b00565ebd4304dmr639592ywb.4.1686266989075; Thu, 08 Jun
 2023 16:29:49 -0700 (PDT)
Date:   Thu,  8 Jun 2023 16:28:12 -0700
In-Reply-To: <20230608232823.4027869-1-irogers@google.com>
Message-Id: <20230608232823.4027869-16-irogers@google.com>
Mime-Version: 1.0
References: <20230608232823.4027869-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 15/26] perf jit: Fix two thread leaks
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
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
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

As reported by leak sanitizer with reference count checking.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/jitdump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 2380b41a4caa..6b2b96c16ccd 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -800,6 +800,7 @@ static void jit_add_pid(struct machine *machine, pid_t pid)
 	}
 
 	thread__set_priv(thread, (void *)true);
+	thread__put(thread);
 }
 
 static bool jit_has_pid(struct machine *machine, pid_t pid)
@@ -811,6 +812,7 @@ static bool jit_has_pid(struct machine *machine, pid_t pid)
 		return false;
 
 	priv = thread__priv(thread);
+	thread__put(thread);
 	return (bool)priv;
 }
 
-- 
2.41.0.162.gfafddb0af9-goog

