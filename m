Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA568C7EE25
	for <linux-perf-users@archiver.kernel.org>; Thu,  8 Jun 2023 23:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbjFHXap (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 8 Jun 2023 19:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237334AbjFHXaN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 8 Jun 2023 19:30:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC31A30FB
        for <linux-perf-users@vger.kernel.org>; Thu,  8 Jun 2023 16:29:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-babb79a17b8so1672539276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jun 2023 16:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686266991; x=1688858991;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HiAGlNZo6LXveOEFDnkkT89wkMT4puWq+yhAGi6vKP8=;
        b=u+3QXdLeECEvsv94B0MruS/YOXHDhV0YcI12nIU2fPum5/LYqTXJMF1kvVgDLAhd69
         TB+RJB7OC/HHWpeh7KmqrHAPzNPPTDPs/OmNWO/o2KRujpqU/fSwzhmFr09RuWuqyC/T
         BzZ0/9JGdYaugJO93/OcTlcUa5DARHOIMgR1ocJWkQzbY1sSYakwLv32CJlgOR6HBARC
         gz455L472xGEXQfKqdk8T6z6OfDB3KCJWYfUVI/PGvFTO5mLQXvHOBkfeWWeIOYweQM1
         /mrxG3oQpV1hhk+hqqFyeAEW0j9hksyd5d3ot94/g5G8yPxOtDBBg8z3j82W+cBjX+b7
         8aNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686266991; x=1688858991;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HiAGlNZo6LXveOEFDnkkT89wkMT4puWq+yhAGi6vKP8=;
        b=jFtQf70HF1wBCMnx5dYbXK+/gJfpRVoIdWzZft0GqVw4RHV0TtDuSl8danWF+HRrwB
         50uG7hA49VyyDaXrJNqvfb5EexgN1E8k7QAgHccJdZohbtN1ba7aJ2C+fr01XeC4INn6
         //RAKod8m1eXVvIfYj4tnJW6nVzn22DOgwC3epQzsT4qVGyn18OITklSpiz7yGc0QIxi
         BnmTsMNJloPzx7DbWZzmaqJ+m5URs5u0n1sQZeMHwJBcoji6+fTLn7lHuZZksiz7OLu+
         xBFtDPyA2c783oBXpIxap/Ln+narUc3jIdXz5TIRg+YkfJbs1cAeDKOeympYcP1x7BPY
         CEfA==
X-Gm-Message-State: AC+VfDwmkv/+mTfu5EnlCvjhojvkDFwmhLc8fnDCmssT50co/LlYcVrI
        2Al+1tpyAPD9OKxWr2pFelNH9NGZtOTn
X-Google-Smtp-Source: ACHHUZ4V8g7YSjAMhsnMLI/N9elrTcMGdXKg6JQGvTOe1tUTMtyI07H4+/X7cQCtnKGmMy/p1PmmgQPPI/lf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a25:588:0:b0:ba8:3e2d:58f8 with SMTP id
 130-20020a250588000000b00ba83e2d58f8mr611466ybf.5.1686266991630; Thu, 08 Jun
 2023 16:29:51 -0700 (PDT)
Date:   Thu,  8 Jun 2023 16:28:13 -0700
In-Reply-To: <20230608232823.4027869-1-irogers@google.com>
Message-Id: <20230608232823.4027869-17-irogers@google.com>
Mime-Version: 1.0
References: <20230608232823.4027869-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 16/26] perf symbol-elf: Correct holding a reference
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

If a reference is held, don't put it as this will confuse reference
count checking.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol-elf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 63882a4db5c7..e6493d1cc251 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1389,11 +1389,11 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 			/* Ensure maps are correctly ordered */
 			if (kmaps) {
 				int err;
+				struct map *tmp = map__get(map);
 
-				map__get(map);
 				maps__remove(kmaps, map);
 				err = maps__insert(kmaps, map);
-				map__put(map);
+				map__put(tmp);
 				if (err)
 					return err;
 			}
-- 
2.41.0.162.gfafddb0af9-goog

