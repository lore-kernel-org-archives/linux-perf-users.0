Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8698C83003
	for <linux-perf-users@archiver.kernel.org>; Thu,  8 Jun 2023 23:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbjFHXaQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 8 Jun 2023 19:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237593AbjFHX37 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 8 Jun 2023 19:29:59 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E8130D6
        for <linux-perf-users@vger.kernel.org>; Thu,  8 Jun 2023 16:29:47 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56991d8e2b0so13687977b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jun 2023 16:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686266986; x=1688858986;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y53qLEHCoCMUqnY97AKj5OPiYKzQLuS6tjfhZxn5cao=;
        b=BWtzVLrqKoYJkSLm4xm24dV+YG4tQHyElrZuiGFxyxxUpwkdM8hK6Yhml3VsH4z5Z6
         3MLwEVGcbfnE2o12xZXJpiEq2AyD0GGwb5fjRx6qe3PK/6uXhHcU+Vp0hL8QMOcSPUHb
         VWcfJCljAE445drlVaMjFp3LzmE+ldlRFKk5DiHtIgvxkMWoNAbzNMvRu2c1v6ZJlXVo
         Q/SvbwhBi9qb5VEewCYKaURAKA/gr26s2zE4cVmEEL2VuKZ9aXIv+BNsUDOrrvzn4QBG
         MIw9GfUgPmu0kUHOCZ6Vnpn7bqh4rUXtUhyfvjO/wuKjtWszxn3htihXp+h2u3rbkzVR
         Qs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686266986; x=1688858986;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y53qLEHCoCMUqnY97AKj5OPiYKzQLuS6tjfhZxn5cao=;
        b=ZCxBLKNy+M5EuVLvOjD4xSj9sLhlXfyfmMahhFLYhulnYrIfLB0P8F4+dIx/S7LpJh
         63hjsP4dKkgHGULTi0vorTJRd4ZFQNt7oYuEvKcWnkEAkiF0AQC5rjtBdbanH0QZLlb0
         AuQB5mQu57N+yPSbmK5ppf0iAnShSmlIVT7f9c9N2/LBL+zSCW7ej/tCnmt/ZPvpfQoJ
         PV0tD02vPbXSDlHnZYiqEHNHN97PYf0fuffPl/nDqFvfd7l5vANyrIwX5RGW07SSbbtO
         TCYpWoooWXjaHZiD0tU1pUFBG1DROhKCVUiLHYWYrMQQ5SiohUiErbmGO/DkZvSow9zY
         wjvg==
X-Gm-Message-State: AC+VfDzUzotML9Dh/oOLge+cjlt7zYpQQFa1pghcZVtiiDvvUTeVvsHW
        QL1hDqBXfnl0pLaykSMLeWe1POjRuXxW
X-Google-Smtp-Source: ACHHUZ5DzYfT4hI1PXDA8oBQEX/6jVDDSD3WmZq420hLxCfPkjKadqGgW4rFwIrQydNs80FcrAShZHWOaoZ8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a25:abb2:0:b0:bad:14ac:f22e with SMTP id
 v47-20020a25abb2000000b00bad14acf22emr347019ybi.5.1686266986565; Thu, 08 Jun
 2023 16:29:46 -0700 (PDT)
Date:   Thu,  8 Jun 2023 16:28:11 -0700
In-Reply-To: <20230608232823.4027869-1-irogers@google.com>
Message-Id: <20230608232823.4027869-15-irogers@google.com>
Mime-Version: 1.0
References: <20230608232823.4027869-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 14/26] perf python: Avoid 2 leak sanitizer issues
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

Leak sanitizer complains about the variable size bf allocation and
store to bf if sized 0.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/scripting-engines/trace-event-python.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index d7c99028c6e6..d96e5c0fef45 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -735,6 +735,9 @@ static void regs_map(struct regs_dump *regs, uint64_t mask, const char *arch, ch
 	unsigned int i = 0, r;
 	int printed = 0;
 
+	if (size <= 0)
+		return;
+
 	bf[0] = 0;
 
 	if (!regs || !regs->regs)
@@ -764,7 +767,7 @@ static void set_regs_in_dict(PyObject *dict,
 	 * 10 chars is for register name.
 	 */
 	int size = __sw_hweight64(attr->sample_regs_intr) * 28;
-	char bf[size];
+	char *bf = malloc(size);
 
 	regs_map(&sample->intr_regs, attr->sample_regs_intr, arch, bf, sizeof(bf));
 
@@ -775,6 +778,7 @@ static void set_regs_in_dict(PyObject *dict,
 
 	pydict_set_item_string_decref(dict, "uregs",
 			_PyUnicode_FromString(bf));
+	free(bf);
 }
 
 static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
-- 
2.41.0.162.gfafddb0af9-goog

