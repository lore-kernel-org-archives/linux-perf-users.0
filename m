Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19BDC7EE2F
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jun 2023 01:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240589AbjFGBqI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Jun 2023 21:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240585AbjFGBoq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Jun 2023 21:44:46 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3298B1FCE
        for <linux-perf-users@vger.kernel.org>; Tue,  6 Jun 2023 18:44:45 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-568a8704f6dso102345207b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Jun 2023 18:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686102284; x=1688694284;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wg608H21VywQV17FYEJQzmeGbvSJZFZmCrQOqYvdbrQ=;
        b=Mp6konrADVL+r/RypaI/wa9bkKBtNFGLSrryt6LQNP3gpo9rqLMzpl4NpNPFInZK5x
         2Xf/y8SE3JllYicl1RrvycyR9c+YDUN+qpZX09ZtAN8/InDBiAM3suwPKrrDd03Nu+Rw
         6z/87/U1VBLHA1S90Ti2ZbC1aGQkRk8PIxh018BaJ8e5znaiM1DkqIncYQ3EywmUi4oM
         WIGm8ZAf2LdIIT0MZUkJY2gCxw/eQDvwcGwG+BYzq7BiKqxPA+VGFNE6i8S7qL7+A+T/
         lfkDmEuIl054e2itV4FXdkmaDSeWFZDT1ZPCFXTigWURYAeoZAopUrOTKCY6ijFkvOOu
         gAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686102284; x=1688694284;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wg608H21VywQV17FYEJQzmeGbvSJZFZmCrQOqYvdbrQ=;
        b=RzbWD1lxUSB4HyYskoMWba+nD06MfaKODeTt2Cjfl19NnEsv4YBaHJbCoI6tEOOvMk
         04um2zNzqQNZl8fZ/a1BvYB8VqdvUqhHSjnWhMNowi5z7dDaGDoTOLmgAHbRYXSOukDG
         qL9Ds+I8/hH8esmqW3cqjcrub0+1gyFZQb4koeaBte43GfwffMbw3NkWN5wPbdBk4QDq
         F9oK4FENv2OT800r8xMczmu8+fX+ZsZsNmDN7htZW8EZQUfxqrkoJDlydL49V2nfzVLn
         9KRdnEyPdU+xaGm81XyyBh5IrGPyZlMJhiTgjoxbgi/Q4dDlF1CHgwGvt+5BkQI16qY+
         UERg==
X-Gm-Message-State: AC+VfDxraS/452iYqUACrshAGl9Ne5Ta8M72uO0zPsUfIBLU/JDcexs1
        TWfnoSW8X68ImEdaLKRDbym/ra1qavcx
X-Google-Smtp-Source: ACHHUZ4dmJcqnnrUfPvPiLDilO76aOm556UMNf2RdYxYeymQ/5xTB+p2huyxjiCVxRNBr/2ZTRUFrzVnJzsc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3c35:209f:5d38:b7a1])
 (user=irogers job=sendgmr) by 2002:a81:ad1c:0:b0:55d:6af3:1e2c with SMTP id
 l28-20020a81ad1c000000b0055d6af31e2cmr2025412ywh.3.1686102284355; Tue, 06 Jun
 2023 18:44:44 -0700 (PDT)
Date:   Tue,  6 Jun 2023 18:43:48 -0700
In-Reply-To: <20230607014353.3172466-1-irogers@google.com>
Message-Id: <20230607014353.3172466-16-irogers@google.com>
Mime-Version: 1.0
References: <20230607014353.3172466-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 15/20] perf jit: Fix two thread leaks
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
2.41.0.rc0.172.g3f132b7071-goog

