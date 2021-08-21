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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36E9C4338F
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A5A061186
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238468AbhHUJWw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238216AbhHUJWP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:22:15 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACD8C06114C;
        Sat, 21 Aug 2021 02:20:26 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g21so17635262edw.4;
        Sat, 21 Aug 2021 02:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QInwCOuO2ckUJlld3UzzWnV+R3RPjh8yWuOELi0NyEQ=;
        b=f+GGTOdmQ56JFw+99caC9CxgbqDRllsngG7xH0A54iDf3Iggd+oPiexWzubco4j7Pa
         YzH4JuoSKdbMx2eLnvZGZTR2RGm9XrHeJuAjhXBJ9gAoGFpacA17ygDKum5PG+q8bzk5
         2sygZTXSFlWHO4PyvuUgmcn3OHmYZ7SMi53CwwfXaBvISEpkhelp39rUB90jeHQD0c4y
         8UQY/7CjM01f4CBMy08tYuFVmhUe8VmmL7tkGkCMM4ZwEsFb78WOcrCU62Rq6jRF+kxv
         Cy82xQot62x3/fU65XdjbNg6+Ma1azNJX6PJZEhzMFatzugymXwEjgLJzkikGoi5g3q4
         KObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QInwCOuO2ckUJlld3UzzWnV+R3RPjh8yWuOELi0NyEQ=;
        b=nWCjaV3JJYdjG0zydvC+jctgeg60sAFMRMsuGdD4C+9zMesAw4A86+nnGMzwQWJqZp
         zNBvxn0av3LE1UDp17Zd1A1ThUbfJN4xXZjTr1SX6yUWX7v9yBFTUkwoA/n9hvgDWpgJ
         1+VERGrVGdc12a9HgAlt2wg952iopNLncGUYiye9MbLhk95t6geSDecTbeIg6XYbCgHh
         /OGANaz8x+a1CZ5uQRSgio+qs+ZOSBhJciI6ZEYmgYk0wh4utvezN1GF7KbOnla49g66
         gklbSz4ysb3ytDvUY+z7iKz1mKdVqMJVpJ5a9EvydkisadhWhvVngNcOxzfNcNidqJ//
         Wm6g==
X-Gm-Message-State: AOAM530AdI7s5A88I9aRL9pBNsiVJMwg8bsfK6EstjosegBxhMYHMvVq
        i/fWL4y86BQFwB1+RJYT6YY=
X-Google-Smtp-Source: ABdhPJw1SvoUmyQKhMERoQNYecOdUDpzkTxbqNBSikW1lrmB4QjUyjajuRSr6cptZDKzh+So31wk7g==
X-Received: by 2002:a05:6402:10d9:: with SMTP id p25mr26451432edu.51.1629537624769;
        Sat, 21 Aug 2021 02:20:24 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:20:24 -0700 (PDT)
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
Subject: [RFC PATCH v1 29/37] perf evlist: add custom fallback to evlist__open
Date:   Sat, 21 Aug 2021 11:19:35 +0200
Message-Id: <6109f52f83bbb9d6782969a5e6fc66f5cab7abd8.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds the function evlist__open_custom, which makes it possible
to provide a custom fallback mechanism to evsel__open.
This function will be used in record__open in the following patch.
This could also be used to adapt perf-stat way of opening to the new
multithreaded mechanism.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/evlist.c | 27 +++++++++++++++++++++------
 tools/perf/util/evlist.h |  9 +++++++++
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 3472038d719ec7d4..22b9607dcc637a2d 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1405,15 +1405,20 @@ static int evlist__create_syswide_maps(struct evlist *evlist)
 	return err;
 }
 
-static int evlist__open_singlethreaded(struct evlist *evlist)
+static int evlist__open_singlethreaded(struct evlist *evlist,
+					struct evlist_open_custom_fallback *cust_fb)
 {
 	struct evsel *evsel;
 	int err;
 
 	evlist__for_each_entry(evlist, evsel) {
+try_again:
 		err = evsel__open(evsel, evsel->core.cpus, evsel->core.threads);
-		if (err < 0)
+		if (err < 0) {
+			if (cust_fb && cust_fb->func(cust_fb, evlist, evsel, err))
+				goto try_again;
 			return err;
+		}
 	}
 
 	return 0;
@@ -1469,7 +1474,8 @@ static void evlist__open_multithreaded_func(struct work_struct *_work)
 	}
 }
 
-static int evlist__open_multithreaded(struct evlist *evlist)
+static int evlist__open_multithreaded(struct evlist *evlist,
+				struct evlist_open_custom_fallback *cust_fb)
 {
 	int cpu, cpuid, cpuidx, thread, err;
 	struct evlist_open_work *works;
@@ -1567,6 +1573,9 @@ static int evlist__open_multithreaded(struct evlist *evlist)
 		if (evsel__detect_missing_features(evsel))
 			goto reprepare;
 
+		if (cust_fb && cust_fb->func(cust_fb, evlist, evsel, err))
+			goto reprepare;
+
 		// no fallback worked, return the error
 		goto out;
 	}
@@ -1579,7 +1588,8 @@ static int evlist__open_multithreaded(struct evlist *evlist)
 	return err;
 }
 
-int evlist__open(struct evlist *evlist)
+int evlist__open_custom(struct evlist *evlist,
+			struct evlist_open_custom_fallback *cust_fb)
 {
 	int err;
 
@@ -1596,9 +1606,9 @@ int evlist__open(struct evlist *evlist)
 	evlist__update_id_pos(evlist);
 
 	if (perf_singlethreaded)
-		err = evlist__open_singlethreaded(evlist);
+		err = evlist__open_singlethreaded(evlist, cust_fb);
 	else
-		err = evlist__open_multithreaded(evlist);
+		err = evlist__open_multithreaded(evlist, cust_fb);
 
 	if (err)
 		goto out_err;
@@ -1610,6 +1620,11 @@ int evlist__open(struct evlist *evlist)
 	return err;
 }
 
+int evlist__open(struct evlist *evlist)
+{
+	return evlist__open_custom(evlist, NULL);
+}
+
 int evlist__prepare_workload(struct evlist *evlist, struct target *target, const char *argv[],
 			     bool pipe_output, void (*exec_error)(int signo, siginfo_t *info, void *ucontext))
 {
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index b0c2da0f9755b2d1..cb753b4c4e70b4ba 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -161,6 +161,15 @@ void evlist__mmap_consume(struct evlist *evlist, int idx);
 int evlist__open(struct evlist *evlist);
 void evlist__close(struct evlist *evlist);
 
+struct evlist_open_custom_fallback;
+typedef bool (*evlist_open_custom_fallback_fn)(struct evlist_open_custom_fallback *fallback,
+					struct evlist *evlist, struct evsel *evsel, int err);
+struct evlist_open_custom_fallback {
+	evlist_open_custom_fallback_fn func;
+};
+int evlist__open_custom(struct evlist *evlist, struct evlist_open_custom_fallback *cust_fb);
+
+
 struct callchain_param;
 
 void evlist__set_id_pos(struct evlist *evlist);
-- 
2.31.1

