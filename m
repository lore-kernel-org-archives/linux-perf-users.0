Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040F2C8300C
	for <linux-perf-users@archiver.kernel.org>; Thu,  8 Jun 2023 23:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237283AbjFHXaI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 8 Jun 2023 19:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237276AbjFHX3r (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 8 Jun 2023 19:29:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DAC30E5
        for <linux-perf-users@vger.kernel.org>; Thu,  8 Jun 2023 16:29:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bb2fae9b286so1434263276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jun 2023 16:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686266974; x=1688858974;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lMdtNGTBh3+qqarzoiXGjMMQ5QKS2zkBmCpcE9AaZG8=;
        b=qvrNwAa6I8cb8TBsqGY45Cz9ZY5hg90lpgYn1T72mITq/cH1zTVmGZFFIfHSrQzepJ
         MDlAHp3MdRqDh7CrwO9hV6e2y+x7NM8TaojgbiBmaUcEM3FwPhq4ciB6ctzUKbpor/2l
         aPyb8HRkdWMaFXWVLuOgsDjkQjIWdlo8BNNCKX1/P80tufvQYnogwiRxMJFx81lGbKk7
         GcAkvRCWL2LQc7GTtWtVcbuYKt/hWkscrxD2oe48rtQ8W1objUdTtp2QBQNbRfCwRhHJ
         CMLcFdB/6T4HUmmcL7QoCzQvG3eb0YQOl6xXhNxG4SWvdPpyoo0dpGi5TRVHv2Rulyph
         cQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686266974; x=1688858974;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMdtNGTBh3+qqarzoiXGjMMQ5QKS2zkBmCpcE9AaZG8=;
        b=ZdBOqLo8QZ8TDRieZm2L7IVqy082kCpbbnsBwZYX3Rja2/G4pjoRmuknkUhBbiW/aZ
         Yg0a03++wFIHv42rv4NlLRkW7oAGTWFH/O48jsDED1QFvR2X5TwqpvFe3+AVlMXK1Ep0
         B5qYFlQBapWDQ1fxp6dQ9ld7ekjkDrZze6/E3QKHYiHEjr/EtHFQMGYlOxdkxhJJbUv3
         u717X1LNp9mUcZK5Ls6Uzz4+v/B7gD7HCDc9A0K88bGsxacg2+eNERhYxmA/NxouIYjs
         mcjc/mi6HW0HnV9r6feiGvm4zyf2BCQMlpjK+OaDlTr86Dyz4nysnS7fXCwzuUQLg4VD
         2UpQ==
X-Gm-Message-State: AC+VfDxdOUs18qFkrsGa+YmMbJu/fny2Q8tfIRK/RI3VpfvxeD2FBzU5
        oHteL74lobE9AjfK6+KUxNTIVI2bdXIb
X-Google-Smtp-Source: ACHHUZ7umrASYnYvCzdFpWOm1U1RbfrT9D+RXK03wWYWPutn42WIip4GkHo95/6dlPdNDq9S81nCc3kqD1Pz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a25:c585:0:b0:bad:e8b:17d4 with SMTP id
 v127-20020a25c585000000b00bad0e8b17d4mr335389ybe.7.1686266974158; Thu, 08 Jun
 2023 16:29:34 -0700 (PDT)
Date:   Thu,  8 Jun 2023 16:28:06 -0700
In-Reply-To: <20230608232823.4027869-1-irogers@google.com>
Message-Id: <20230608232823.4027869-10-irogers@google.com>
Mime-Version: 1.0
References: <20230608232823.4027869-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 09/26] perf report: Avoid thread leak
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

Caught with address sanitizer and reference count checking.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 0b091a8983a5..a31a23af5547 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -839,6 +839,7 @@ static struct task *tasks_list(struct task *task, struct machine *machine)
 		return ERR_PTR(-ENOENT);
 
 	parent_task = thread__priv(parent_thread);
+	thread__put(parent_thread);
 	list_add_tail(&task->list, &parent_task->children);
 	return tasks_list(parent_task, machine);
 }
-- 
2.41.0.162.gfafddb0af9-goog

