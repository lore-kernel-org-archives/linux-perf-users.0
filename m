Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD19C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Nov 2021 22:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbhKWWvf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Nov 2021 17:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbhKWWve (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Nov 2021 17:51:34 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C97C061714
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Nov 2021 14:48:25 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id d27-20020a25addb000000b005c2355d9052so1080851ybe.3
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Nov 2021 14:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=r7AhAqgjV2rKTWwkAzKHbn6CM2swTuumTBUvYfOAdxA=;
        b=ZgVd9XTPz7nDwBpf1v6JnKCnSivUNdHsi3cr1pyS4WrhRUVI/pLBE5topWef+eIVbr
         DPOLJ1UvI8lGcbK9qqB2MSpXpYI9DuEg8dUopYbpaQn8e4z1MiQnwsC3kDgeCR2VfMLf
         /rBPx/HeWInbOyOJGuJFJye6RUbm0Al0Nc/DLSUSSVumWVuL05EpTaD7CrnbucRfJdT8
         p322GXCEQSY4AEt9GoUOIXKc5FhFgXHHvtBaOI8b73iDwLkEJ7jMlafGHDQVKr8A6cX8
         qvDZrbZGuU6v/bytURBO3RGhglKLmpxYduq2ObzhqAsxrJq7GWBK4vw8GYaCcdDZcmuL
         FTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=r7AhAqgjV2rKTWwkAzKHbn6CM2swTuumTBUvYfOAdxA=;
        b=Fm3yvRoMsE77ueZicDV5ra7WjMNZyjp1epgMBPSXr1g4lyipaO0jOpnasqyvQtva4O
         KjicT+EKMVBsZocLvBkkT3YaG6xynywSKlp/cBSmfAz0zZ538Z4i3FbkOlnmAm6B3Isd
         V/jzL3iFvc7jdZizdB2XilbcDusJbKWUgB7fUFOR+cdl0Pu9r9mrH/h4KHpp8IMeY23j
         5bcbL3WQC47LV0f+oVgTT6wegC1dfz582z/VwXzklqW+QJ1ZCCtbpsoLAJkeaDNpOvij
         G12vu56H2kXhGKzBPK0MXC3cQH3XNXeuMMChGo/3Soa9z8f5GIddpcOTC5u8SW60Dm83
         +4dA==
X-Gm-Message-State: AOAM531sErKwa5kvZHvSgtySR3So+e+9kJ7qN+2VnSn9RI5uBqPPXdus
        cFC5vu8HHaXyGLjYwtq/EWwDdc6EzwAy
X-Google-Smtp-Source: ABdhPJxam15LwRrevFaVgC2Lj9OBCN3w/yYA4YqlDr3OMiYJWOAxiwp2EwqoBGkORLzaDhtuFVUlnV4FfWbW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:dbab:a6fe:1e3a:91fa])
 (user=irogers job=sendgmr) by 2002:a25:bacd:: with SMTP id
 a13mr11424123ybk.216.1637707705207; Tue, 23 Nov 2021 14:48:25 -0800 (PST)
Date:   Tue, 23 Nov 2021 14:48:19 -0800
Message-Id: <20211123224821.3258649-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH 1/3] perf expr: Add debug logging for literals
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Useful for diagnosing problems with metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 1d532b9fed29..cdbab4f959fe 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -395,12 +395,17 @@ double expr_id_data__source_count(const struct expr_id_data *data)
 double expr__get_literal(const char *literal)
 {
 	static struct cpu_topology *topology;
+	double result = NAN;
 
-	if (!strcmp("#smt_on", literal))
-		return smt_on() > 0 ? 1.0 : 0.0;
+	if (!strcmp("#smt_on", literal)) {
+		result =  smt_on() > 0 ? 1.0 : 0.0;
+		goto out;
+	}
 
-	if (!strcmp("#num_cpus", literal))
-		return cpu__max_present_cpu();
+	if (!strcmp("#num_cpus", literal)) {
+		result = cpu__max_present_cpu();
+		goto out;
+	}
 
 	/*
 	 * Assume that topology strings are consistent, such as CPUs "0-1"
@@ -415,13 +420,21 @@ double expr__get_literal(const char *literal)
 			return NAN;
 		}
 	}
-	if (!strcmp("#num_packages", literal))
-		return topology->package_cpus_lists;
-	if (!strcmp("#num_dies", literal))
-		return topology->die_cpus_lists;
-	if (!strcmp("#num_cores", literal))
-		return topology->core_cpus_lists;
+	if (!strcmp("#num_packages", literal)) {
+		result = topology->package_cpus_lists;
+		goto out;
+	}
+	if (!strcmp("#num_dies", literal)) {
+		result = topology->die_cpus_lists;
+		goto out;
+	}
+	if (!strcmp("#num_cores", literal)) {
+		result = topology->core_cpus_lists;
+		goto out;
+	}
 
 	pr_err("Unrecognized literal '%s'", literal);
-	return NAN;
+out:
+	pr_debug2("literal: %s = %f\n", literal, result);
+	return result;
 }
-- 
2.34.0.rc2.393.gf8c9666880-goog

