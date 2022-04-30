Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02538C433F5
	for <linux-perf-users@archiver.kernel.org>; Sat, 30 Apr 2022 06:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382225AbiD3G1F (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 30 Apr 2022 02:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359029AbiD3G1A (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 30 Apr 2022 02:27:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00401CFE40
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Apr 2022 23:23:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d22-20020a25add6000000b00645d796034fso9173945ybe.2
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Apr 2022 23:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QbAjsSCqSFDRCvHRrmziRST5Dc++EK/823h/RlAIK5g=;
        b=Rpq1AfeufiJjUWDBocUZh5TWrWdBIcyIGdUOys38n1LCXddAZUD8/lMYA2uJRYehiv
         DJdYXSKB0Hjp0LHw9ULlY+OmkhssK/42gfA+pTnH6aD1X9Ut0J6A1CpwvqsLNiZUKztC
         NhPKS9v4ShPG2UBHIp8gp35xL9Nxz1PyCzOIOViTHGblDrrLt7QcExXLDPH4rV61CgiG
         CjmKNPwrEg+ZXczN6euaoH4tweUxuwjVdDFqbjruJo1ciq9x1Hd9kK2ZAMoWKoqI933l
         8jWtvxs93NlAFlzrxmz3QO4j2WyXZHhVH+2Rt7II1m6DbaIchOfRMjYbqaQwN3aKQ+Ye
         GpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QbAjsSCqSFDRCvHRrmziRST5Dc++EK/823h/RlAIK5g=;
        b=UFhA5nm+EPNQC7oQZMNr4XRyDtAqqkx6kUdGYC0QD91C2VqSNbJmYHXDjecnpci+4q
         JkodHae7FewUTMAgxI14RE833H4wW3S4b2i/iGRyEB1JBX3oq3xqOecjP90WsuRGgOHf
         cJbox8T2JwVrgenslr0dQWeSvJ5svU8rQtU7y2Uk3KvLzmb/t10vtfND2UhbyAOlWuj9
         J7fgq8GkfhtmuVuq4JgteeriQ1pHmNHTVc+4K8fn+WmR/ylrxQgPqHlEP54EmZupB1jO
         sZoYipJ18j3dV2cstuS2M0lg8+35zyjTD7ekIS3Kk0MacSNkvuKztTyyDT113i5yOBHN
         nQcQ==
X-Gm-Message-State: AOAM5334CXO6kI2OAH39j0qCeb95axsC+lqv2al2NqXAHMWvBoKOt/49
        TlwI2uP2T71bYLzIWItiNf/Y3OhqGpqP
X-Google-Smtp-Source: ABdhPJwWdCK9HhHKXU+Zq1v3vI46L5oK3Vj6FtMCyKhUPVl+Q23X1BMEt6F/666jhslBJLRWT0lcaV/p492J
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2481:caab:4fd5:232b])
 (user=irogers job=sendgmr) by 2002:a25:6788:0:b0:648:d8c0:2ed4 with SMTP id
 b130-20020a256788000000b00648d8c02ed4mr2483910ybc.577.1651299818209; Fri, 29
 Apr 2022 23:23:38 -0700 (PDT)
Date:   Fri, 29 Apr 2022 23:23:21 -0700
In-Reply-To: <20220430062324.1565215-1-irogers@google.com>
Message-Id: <20220430062324.1565215-4-irogers@google.com>
Mime-Version: 1.0
References: <20220430062324.1565215-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v4 3/6] perf stat: Avoid printing cpus with no counters
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

perf_evlist's user_requested_cpus can contain CPUs not present in any
evsel's cpus, for example uncore counters. Avoid printing the prefix and
trailing \n until the first valid counter is encountered.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index d9629a83aa78..13f705737367 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -948,8 +948,6 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 		struct evsel *counter;
 		bool first = true;
 
-		if (prefix)
-			fputs(prefix, config->output);
 		evlist__for_each_entry(evlist, counter) {
 			u64 ena, run, val;
 			double uval;
@@ -961,6 +959,8 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 
 			id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
 			if (first) {
+				if (prefix)
+					fputs(prefix, config->output);
 				aggr_printout(config, counter, id, 0);
 				first = false;
 			}
@@ -972,7 +972,8 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 			printout(config, id, 0, counter, uval, prefix,
 				 run, ena, 1.0, &rt_stat);
 		}
-		fputc('\n', config->output);
+		if (!first)
+			fputc('\n', config->output);
 	}
 }
 
-- 
2.36.0.464.gb9c8b46e94-goog

