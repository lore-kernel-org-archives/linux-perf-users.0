Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACD2C4338F
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6DCF61215
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbhHUJVR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbhHUJUt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:20:49 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E870C06129E;
        Sat, 21 Aug 2021 02:20:04 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id z20so25181598ejf.5;
        Sat, 21 Aug 2021 02:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y0qmvJhChn9arrJ/rGJFD9sMX4D0tlR5THiYSB7Y93g=;
        b=NclQhA3IMlz6bJJsu2lP34LymOrK3ekgCnfc8WMbX22Oc01p1iMkDmJyjnJlZ+uuT3
         KlgaIqLFalY9I70N8GnqNaW3qZQUSLa4oX2ci7lONyXJOXgRT4UyQCrtQQjhwPe67Xh7
         lgddfj25StczUQQVOyl2hRh0RWy3Ivt80op8w5qOfHhpThhM9pQoY5DvhM2F3QO1X2Q7
         CEmFcgANeoE5l5MC9TFz8PKGOe/MMOI869UFKCOfRYzTYB/pndNr/NtiaSpjlVwIZ2G8
         2vOulYtlZiWIuPbVaf3sYHtIKVkZXCPkAqxzn+VYl01gwpvE5gTYlytA/bBgBn6ncDa7
         oC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y0qmvJhChn9arrJ/rGJFD9sMX4D0tlR5THiYSB7Y93g=;
        b=rdU1xJhOOGGOL8fN+rAqJKRwl/zu/umiTQN5utolnu4DqKeht0YeenfWdLF0o9YpSL
         74NgMYi8hEee/HNpCt1hZDWtvsuZe0DuYx+32UiDatwHgBGcPbk4uR8BM1824Sf1KR9a
         97xG7LrPePt7c3p1hQP9nSh4jOKr4dANRo4goI4OvZgMkGP5tcB1HG6B9Za+8+rb2M7O
         zQY6awAmJcSkLFOE/gZ3TdZdneeE4QpO2e3lc+XJkskBqkaggPkqW0CbEcR4RMqxzYim
         asGEjNHuFVpJNMvWLoqrlfXvcCWbZBigyHBxpN/0AU+kgr9Q1lnot/i+1+IRzyZ5Su4h
         TcIA==
X-Gm-Message-State: AOAM533H+cPwatu3ezbhgKIXTclySr57jf6jQV0G0c3IjhOO/f2GXtGw
        dyo+wgen9S4UQw2U7z50I6I8FrSXLerDs5dIeQQ=
X-Google-Smtp-Source: ABdhPJzaClLRRYQ+cz6kMXL05+dfo/J4U+WeVY/rQE/+tLGc/Eh1S//eTsFpb6Fce6aNxwuCi6aaog==
X-Received: by 2002:a17:907:7291:: with SMTP id dt17mr26449106ejc.162.1629537603165;
        Sat, 21 Aug 2021 02:20:03 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:20:02 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [RFC PATCH v1 12/37] perf evlist: add multithreading to evlist__enable
Date:   Sat, 21 Aug 2021 11:19:18 +0200
Message-Id: <9a3eda98548b5db42d5a6677ed3c607928d29af9.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

In this patch, evlist__for_each_evsel_cpu is used in evlist__enable to
allow it to run in parallel.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/evlist.c | 41 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 5c82246813c51c51..fbe2d6ed8ecc8f21 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -552,37 +552,22 @@ void evlist__disable_evsel(struct evlist *evlist, char *evsel_name)
 	__evlist__disable(evlist, evsel_name);
 }
 
-static void __evlist__enable(struct evlist *evlist, char *evsel_name)
+static int __evlist__enable_evsel_cpu_fun(struct evlist *evlist __maybe_unused,
+					struct evsel *pos, int cpu, void *args)
 {
-	struct evsel *pos;
-	struct affinity affinity;
-	int cpu, i, cpu_idx;
+	char *evsel_name = args;
 
-	if (affinity__setup(&affinity) < 0)
-		return;
-
-	evlist__for_each_cpu(evlist, i, cpu) {
-		affinity__set(&affinity, cpu);
+	if (evsel__strcmp(pos, evsel_name))
+		return 0;
+	if (!evsel__is_group_leader(pos) || !pos->core.fd)
+		return 0;
+	evsel__enable_cpu(pos, cpu);
+	return 0;
+}
 
-		evlist__for_each_entry(evlist, pos) {
-			if (evsel__strcmp(pos, evsel_name))
-				continue;
-			cpu_idx = evsel__find_cpu(pos, cpu);
-			if (cpu_idx < 0)
-				continue;
-			if (!evsel__is_group_leader(pos) || !pos->core.fd)
-				continue;
-			evsel__enable_cpu(pos, cpu_idx);
-		}
-	}
-	affinity__cleanup(&affinity);
-	evlist__for_each_entry(evlist, pos) {
-		if (evsel__strcmp(pos, evsel_name))
-			continue;
-		if (!evsel__is_group_leader(pos) || !pos->core.fd)
-			continue;
-		pos->disabled = false;
-	}
+static void __evlist__enable(struct evlist *evlist, char *evsel_name)
+{
+	evlist__for_each_evsel_cpu(evlist, __evlist__enable_evsel_cpu_fun, evsel_name);
 
 	/*
 	 * Even single event sets the 'enabled' for evlist,
-- 
2.31.1

