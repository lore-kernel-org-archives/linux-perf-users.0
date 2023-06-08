Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA71C7EE23
	for <linux-perf-users@archiver.kernel.org>; Thu,  8 Jun 2023 23:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237276AbjFHXbY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 8 Jun 2023 19:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237598AbjFHXan (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 8 Jun 2023 19:30:43 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0275230E1
        for <linux-perf-users@vger.kernel.org>; Thu,  8 Jun 2023 16:30:06 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-569fee67d9dso25003977b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jun 2023 16:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686267006; x=1688859006;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pl84Wb/J0XwyUQzqil2jyo7Ij9NgOb19MY5gzo850pI=;
        b=xnSakeo5Yb7wwdtDMtyb7HVmj8YIuug35kGbTZONK5jWOa3frI8ut/fr93Fc8/JTwX
         kvPVpJEjW0sAh9sgPXMO7hyOJi/3vdDxkAi+slwHAwCqrDu0YARCS7yvVlRIkeo5nA06
         C15nsVuVNrmKDz9sWZFnqATC9K8cVorJcxIOokWO13z2/1LDCTGY/s1RQBTMMhreyVgg
         83aqZxGUcA1c/VNd055oUlTQF1Lva5eiYUU+EMHdqdWbR/KXkbdHAGtQFr9pIqdCSeqs
         LmvvrblYw88CmiAOK+DgWcGAsQbyYkW6/SP95piwYMv/4lRiHtmDhC7d3H3k9+1MYT+n
         Mfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686267006; x=1688859006;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pl84Wb/J0XwyUQzqil2jyo7Ij9NgOb19MY5gzo850pI=;
        b=Kgq+r6jF5ZEjOAvVG8ipJbybc9SYLLBhBEuRZrL6u1DVIbspTCNqq4Nu27qjuKKsch
         AdVvp8D6bmqNJixgx9krUqz8Nb64DlumPBN4ohR7j0dEG++R+ArFZ/lec6p7HjchKfTy
         9AIYeLMnYHWwbMbe6w59HIS9D//JeEtXFfRGToL5e5vyb8EOgpfBayYfOI3nFPRvg45H
         IzOcQ7uv0kPcdQ3XCGyPaKtX6LRFYF5SO72W0dD8yUQvpr/IO8C318HDJkNpyZ1AfMNP
         M0dr0hV3YnhNH4MvXEHlED1If50t0Fu2TRv9cvAtirkQSwTIhkNrFhRPR1UvDbvQUlpI
         oOOw==
X-Gm-Message-State: AC+VfDz8sUvqtYwkWkV2SZ0kOEv+Z3gqsHS8wvogWs2rLo+P20f5wfDi
        GOfJRF3fyoVVEIVw1z+52GZ4EtFKKA+g
X-Google-Smtp-Source: ACHHUZ6XZQubQMzg154P6DYDd+lHosdgRP3GkxT70tkfupa8BerI7CJLgpzGAucDVJ4zIZScOONMhWdG/Fqr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a05:690c:2e0f:b0:569:ea0e:b450 with SMTP
 id et15-20020a05690c2e0f00b00569ea0eb450mr590468ywb.5.1686267005998; Thu, 08
 Jun 2023 16:30:05 -0700 (PDT)
Date:   Thu,  8 Jun 2023 16:28:19 -0700
In-Reply-To: <20230608232823.4027869-1-irogers@google.com>
Message-Id: <20230608232823.4027869-23-irogers@google.com>
Mime-Version: 1.0
References: <20230608232823.4027869-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 22/26] perf top: Add exit routine for main thread
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

Add exit_process_thread that reverses init_process_thread. This avoids
leak sanitizer reporting memory leaks.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 99010dfa5760..c363c04e16df 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -392,7 +392,7 @@ static void prompt_percent(int *target, const char *msg)
 
 static void perf_top__prompt_symbol(struct perf_top *top, const char *msg)
 {
-	char *buf = malloc(0), *p;
+	char *buf = NULL, *p;
 	struct hist_entry *syme = top->sym_filter_entry, *n, *found = NULL;
 	struct hists *hists = evsel__hists(top->sym_evsel);
 	struct rb_node *next;
@@ -1227,6 +1227,14 @@ static void init_process_thread(struct perf_top *top)
 	cond_init(&top->qe.cond);
 }
 
+static void exit_process_thread(struct perf_top *top)
+{
+	ordered_events__free(&top->qe.data[0]);
+	ordered_events__free(&top->qe.data[1]);
+	mutex_destroy(&top->qe.mutex);
+	cond_destroy(&top->qe.cond);
+}
+
 static int __cmd_top(struct perf_top *top)
 {
 	struct record_opts *opts = &top->record_opts;
@@ -1357,6 +1365,7 @@ static int __cmd_top(struct perf_top *top)
 	cond_signal(&top->qe.cond);
 	pthread_join(thread_process, NULL);
 	perf_set_singlethreaded();
+	exit_process_thread(top);
 	return ret;
 }
 
-- 
2.41.0.162.gfafddb0af9-goog

