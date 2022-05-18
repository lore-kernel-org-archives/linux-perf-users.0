Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180B7C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 May 2022 04:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiEREUj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 18 May 2022 00:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiEREUi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 May 2022 00:20:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763DC6393
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 21:20:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 135-20020a25058d000000b0064dd6bc9cfdso861241ybf.23
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 21:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LvpJiUnSFpCiFAKE98nz9J5XPUyrNRc2U9N5mJnm5Hg=;
        b=Oju5r4aDWZ9Zqud5nYsTAl9JheS1ktMe0jzOrH9p2XeVTlhAYnaTONZuQnfO+3bjYp
         X12uYnhd/xGMi6E9AoSxjGdshhG1nM2sP2HCK8KnCu6Qdv1eLHfGgchPUcUgMzrMzm20
         hQ2pXes2b6MoGLLnjMAWEcCYiB8/Poy7ITRbwbIoX4qU4sLyZUF+ZcZ8m/Tg75C61Nw7
         W7867SE05iBb4gL3GcZ9Ro5E527A/V1EdYVfuvZikEFN8anOJ+r0b27zabd+GC0Qt3NF
         sD+xZrmcBXLBQ0lwBW0oc1lFNkPi+yTU4z1BD+LvMGfrJ3AKw/PUDMGl87JZTnaVO5HT
         f6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LvpJiUnSFpCiFAKE98nz9J5XPUyrNRc2U9N5mJnm5Hg=;
        b=lrxWlGkx3YgCiODV2fzmvG5zFJPPAzUDOkhYwCRzmkK/G6SRpbB1Knr37Z/C0cFXAs
         S997rnBDSn/Uxdpgo3Nmdk5ub6UGojRaXViZf+WsU4veqieZveVXmaOLA8VpRnZoiKGl
         OHNpvrU9/fHMPYlI9CKUZHwKn8V7a2FEI4Owf/Qq3dfyy48qcggLWLu1SF5kX2of+tRQ
         epTeukvDY5jjb7k3cmCOSH9MBRmPLp2L/WaXuWgoQL0iIiJe1XolRVS+PEST1SryLSDM
         NgxWvUXDrQLS4Q2tUqHYtwJBPbg/RQwjogvEhrsJiM+vR3dmmC1j+hpiMqut0pQ8bQEA
         XSYw==
X-Gm-Message-State: AOAM530H5tZBR2edc49vZ7lEm7WTYsuWzwVtgrzonyzpzmh8P8TuqFxM
        BpWxo5z1/U6syA2QjGbyqur6kE6wr911
X-Google-Smtp-Source: ABdhPJxa786aBoSAGP95NfMFnlI9dLOPTNSKBMoSDyj9KewGk9Xm9VagNfnviFtvuciptpIl68JDMEXQG9Go
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:a5a1:af73:fe09:fd5])
 (user=irogers job=sendgmr) by 2002:a25:bd05:0:b0:64d:6ee0:f503 with SMTP id
 f5-20020a25bd05000000b0064d6ee0f503mr17703514ybk.415.1652847635670; Tue, 17
 May 2022 21:20:35 -0700 (PDT)
Date:   Tue, 17 May 2022 21:20:20 -0700
In-Reply-To: <20220518042027.836799-1-irogers@google.com>
Message-Id: <20220518042027.836799-2-irogers@google.com>
Mime-Version: 1.0
References: <20220518042027.836799-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2 1/8] perf test: Skip reason for suites with 1 test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Marco Elver <elver@google.com>,
        John Garry <john.garry@huawei.com>,
        Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

When a suite has just 1 subtest, the subtest number is given as -1 to
avoid indented printing. When this subtest number is seen for the skip
reason, use the reason of the first test.

Reviewed-by: John Garry <john.garry@huawei.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index fac3717d9ba1..33fcafa0fa79 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -137,10 +137,10 @@ static bool has_subtests(const struct test_suite *t)
 
 static const char *skip_reason(const struct test_suite *t, int subtest)
 {
-	if (t->test_cases && subtest >= 0)
-		return t->test_cases[subtest].skip_reason;
+	if (!t->test_cases)
+		return NULL;
 
-	return NULL;
+	return t->test_cases[subtest >= 0 ? subtest : 0].skip_reason;
 }
 
 static const char *test_description(const struct test_suite *t, int subtest)
-- 
2.36.0.550.gb090851708-goog

