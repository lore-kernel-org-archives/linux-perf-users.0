Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C9AC83F12
	for <linux-perf-users@archiver.kernel.org>; Wed, 30 Aug 2023 00:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239265AbjH3AFz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 29 Aug 2023 20:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241295AbjH3AFw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 29 Aug 2023 20:05:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD63B1BB
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Aug 2023 17:05:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59263889eacso69590607b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Aug 2023 17:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693353949; x=1693958749; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2UDc2NK3XlTUwXsReE+naes966j+l1MiNSkWpg4Kd34=;
        b=VPmM2wXi7jGNvYmPpEraraopuW2tLna96+tYWV8JErzKHpSqmIVOtGSYyuPne80+q4
         EX6UWlSM57dELr77wx6PPHmgfQ73OL5tGJuYxXggqSh7URKzSKFk6mjqpt9bQSIKx+ec
         xkHo9zwCNjxMATnxpn6GnjLVsTAUbqSr8n3FVgMSv9R3QRyW7iryulLyzBKOwKzBqoic
         5lAh4ZtJj3i5IMFLbscMsVrtY86XfCNWXCo7+i1EqoSndnqUueNdrl+fJwGAzpMCz5Mn
         MtxA6zGKAUtYLRuJHcP4NGq3N18a0Am1S2fl9vASQfKz859+b7+d2ukmSEjmJf7ZMAwB
         K+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693353949; x=1693958749;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2UDc2NK3XlTUwXsReE+naes966j+l1MiNSkWpg4Kd34=;
        b=Dlkn8JTGWW/iCZcVmP0CT5q7QwbQbv+pqXhAH4CpUAWKahsN2xnaueFID9iYQd0gsc
         GfgAfKyQh4GBbWL1k0ji8mljFij9HEluJiL+LRO4GRGGX148FLePVM8asKXVirZIWZZO
         HQ+lT/h35xGjoSQS1QD/uV85HR1XG3kKhmqRSYzSiMsK6L4DI+GclEe+LpP9A0BzFRJu
         UwZsiqzF4eTJrViHWad1b+m60pUv4mYN34PSqcKR/s9NEeHtSK5ePKGonA0OuqNsMzJ2
         RupNwd7anAYm+HXwx1IWMW7vjzZnjmQV9aZtVxZx0v5jNVbF/mmNo/kAqCxqM2O4HJX6
         T3jg==
X-Gm-Message-State: AOJu0YyLJn/OM18pyvNGwAEgGXMImupOlAyQVpIpDDn+GxWRvijguTa7
        pptKaN9Y5WejkYQn8AhT8KvBsArZfuiD
X-Google-Smtp-Source: AGHT+IEJh99y0GSLoGMM96YsdXu2S3vQccr3hi26MSzWpxQlhPxea8QqIJkEwtT6IcAiOEeezLyrQ5grsLd2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:d623:3cd7:ecbc:8798])
 (user=irogers job=sendgmr) by 2002:a81:bd41:0:b0:576:b244:5a4e with SMTP id
 n1-20020a81bd41000000b00576b2445a4emr16748ywk.10.1693353949201; Tue, 29 Aug
 2023 17:05:49 -0700 (PDT)
Date:   Tue, 29 Aug 2023 17:05:45 -0700
Message-Id: <20230830000545.1638964-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v1] perf pmu: Avoid uninitialized use of alias->str
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

alias is allocated with malloc allowing uninitialized memory to be
accessed. The initialization of str was moved late after it could have
been updated by a JSON event, however, this create a potential for an
uninitialized use. Fix this by assigning str to NULL early. Testing on
ARM (Raspberry Pi) showed a memory leak in the same code so add a
zfree.

Fixes: f63a536f03a2 ("perf pmu: Merge JSON events with sysfs at load time")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index cde33e01959a..b3f8f3f1e900 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -532,6 +532,7 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 	if (!alias)
 		return -ENOMEM;
 
+	alias->str = NULL;
 	INIT_LIST_HEAD(&alias->terms);
 	alias->scale = 1.0;
 	alias->unit[0] = '\0';
@@ -593,6 +594,7 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 			ret += scnprintf(newval + ret, sizeof(newval) - ret,
 					 "%s=%s", term->config, term->val.str);
 	}
+	zfree(&alias->str);
 	alias->str = strdup(newval);
 	if (!pe)
 		pmu->sysfs_aliases++;
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

