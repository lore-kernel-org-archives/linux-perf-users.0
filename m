Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EA1C07E99
	for <linux-perf-users@archiver.kernel.org>; Fri,  9 Jul 2021 16:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31AFE613CA
	for <linux-perf-users@archiver.kernel.org>; Fri,  9 Jul 2021 16:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhGIQh4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 9 Jul 2021 12:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhGIQh4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 9 Jul 2021 12:37:56 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49EBC0613DD;
        Fri,  9 Jul 2021 09:35:11 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h8so1419401eds.4;
        Fri, 09 Jul 2021 09:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tQVonobh9dEWViCupkTvvzo+E7fxVjP7o2OOWiVB+Hw=;
        b=AHXL2iVjVJS4yxCtwy4e+Z6lbW8mAqOYVFO1kOuzbR31sEFXPAGUQM6yRV4G44Cp6I
         WmY9Vp9SFuoJvulaX6X2cxh7iWWx5lDEXUu0aZZSE4F7F1F5mjq/+0AxpNjfPqTBDtcx
         4guH7Hl80pHp7fBk5WsPjnpE+uE//33Oh7rKEwSYOlv+ktRJUvtvM/Nai3CMiwr+nntu
         crawwmaySoGLFkAPJ7DCHDm1VD4qTNffJ5hgOMzRCYadVIdykQVuy7aVCWREib2rJkUd
         poTOFnYU8OneJVyZ1awUO4Fu1oKF9twnO1Mr1kaR/iRRAwSl3eeuh9XvkHL/bgL1NO06
         uNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tQVonobh9dEWViCupkTvvzo+E7fxVjP7o2OOWiVB+Hw=;
        b=dIpDxglM1ENkHaU9YleG6Xh0O0qSFKdksIw7N7oUv6SVVt2KbOGm9RNNFXMT9nM133
         vAd1P6UFr893KyTuOJPn/6poE7VolpJtEOd/mzHcT00wrffiKNLwtxTAszulL039oRJ9
         R2fL44fpJNU1LMr696vg5IjQymRx4JfzhdrKDZlWqtxLeZzqU5piC/0QTZdIFkn3fPKS
         a7laSBeDP+E+A1PL1yQXxy2t1aWYz5bN7+uS61G5kNsoIDGyB1Np1xmd8i9ECw6EcVqy
         Kk5WxUtbUTOqCez5kmBUXUiXWtqHmcdJMAkecyKAB3QwfacGdEfVk88Si2jF42ybDyki
         2bXw==
X-Gm-Message-State: AOAM532Px7lBAAque7cS9Yr9heIhVVj1/2mjOOzjw70jVVw958uPqdO6
        mm9zMj0rslOM8tXjLCFThGc=
X-Google-Smtp-Source: ABdhPJwHCLANmMv7DUjkqrjvz3LdqyK2TMEM/4yhWBPFbIN8h9t7ERgdRSTaBVXj/EJn1tDigm4KLA==
X-Received: by 2002:a05:6402:50d3:: with SMTP id h19mr37507219edb.344.1625848509907;
        Fri, 09 Jul 2021 09:35:09 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id b25sm3341899edv.9.2021.07.09.09.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 09:35:09 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Remi Bernon <rbernon@codeweavers.com>,
        Fabian Hemmer <copy@copy.sh>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf test: add missing free for scandir-returned dirent entities
Date:   Fri,  9 Jul 2021 18:34:53 +0200
Message-Id: <20210709163454.672082-1-rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reported a memory leak for items of the entlist returned from scandir.
In fact, scandir returns a malloc'd array of malloc'd dirents.
This patch adds the missing (z)frees.

Fixes: da963834fe6975a1 ("perf test: Iterate over shell tests in alphabetical order")
Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/tests/builtin-test.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 41e3cf6bb66c68e8..5e6242576236325c 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -26,6 +26,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <subcmd/exec-cmd.h>
+#include <linux/zalloc.h>
 
 static bool dont_fork;
 
@@ -540,7 +541,7 @@ static int shell_tests__max_desc_width(void)
 {
 	struct dirent **entlist;
 	struct dirent *ent;
-	int n_dirs;
+	int n_dirs, e;
 	char path_dir[PATH_MAX];
 	const char *path = shell_tests__dir(path_dir, sizeof(path_dir));
 	int width = 0;
@@ -564,8 +565,9 @@ static int shell_tests__max_desc_width(void)
 		}
 	}
 
+	for (e = 0; e < n_dirs; e++)
+		zfree(&entlist[e]);
 	free(entlist);
-
 	return width;
 }
 
@@ -596,7 +598,7 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width)
 {
 	struct dirent **entlist;
 	struct dirent *ent;
-	int n_dirs;
+	int n_dirs, e;
 	char path_dir[PATH_MAX];
 	struct shell_test st = {
 		.dir = shell_tests__dir(path_dir, sizeof(path_dir)),
@@ -629,6 +631,8 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width)
 		test_and_print(&test, false, -1);
 	}
 
+	for (e = 0; e < n_dirs; e++)
+		zfree(&entlist[e]);
 	free(entlist);
 	return 0;
 }
@@ -730,7 +734,7 @@ static int perf_test__list_shell(int argc, const char **argv, int i)
 {
 	struct dirent **entlist;
 	struct dirent *ent;
-	int n_dirs;
+	int n_dirs, e;
 	char path_dir[PATH_MAX];
 	const char *path = shell_tests__dir(path_dir, sizeof(path_dir));
 
@@ -752,8 +756,11 @@ static int perf_test__list_shell(int argc, const char **argv, int i)
 			continue;
 
 		pr_info("%2d: %s\n", i, t.desc);
+
 	}
 
+	for (e = 0; e < n_dirs; e++)
+		zfree(&entlist[e]);
 	free(entlist);
 	return 0;
 }
-- 
2.23.0

