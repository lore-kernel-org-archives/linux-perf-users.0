Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436D5C77B7E
	for <linux-perf-users@archiver.kernel.org>; Thu, 25 May 2023 07:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239420AbjEYHMq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 25 May 2023 03:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239101AbjEYHMS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 May 2023 03:12:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06A6E7A
        for <linux-perf-users@vger.kernel.org>; Thu, 25 May 2023 00:12:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba8337a5861so620179276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 25 May 2023 00:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684998732; x=1687590732;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TpVpkWx/imTLr00+GTEXOikPom8bv+ZS7bO2wV57MhQ=;
        b=ZI9YPnE7qzrf4v6f+4zTWZMVj+saUiQ+EL1pEZ5JGh+ACoc3fTXdI063HcauKL4I87
         52sOiKV576htS4W7uIXo/K6XtSaFRi5eDFgjw+UW384XvR5VObuags4MY+lrz3CTau7g
         hqQ8MZ6CbG/dQPdneqTkyRVZoEeCZV5DjuvN8WTK0/z+HAKlTJoFZDQAfHixW8MvWCe4
         8ETSjjIayFzNYxcThELrlwF2P7b0HluQnQQgKT9Sd2jc2C8Vf31w4wt5X0B/CLGA5X2x
         UeM6q/Goi6F6rPIO8oHJ1BwjHi3nS8Q3JhKIfSUOnDZFywFMYER1RFETapM17azFgky4
         FWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684998732; x=1687590732;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TpVpkWx/imTLr00+GTEXOikPom8bv+ZS7bO2wV57MhQ=;
        b=ig88QASnsPZV1cZ9/QAzbmbmPzLyldMXi8ufI9bSyvUcd4XuAbicnY8Gxvv/Ae/kV6
         pK7xVRPupiocE+9tH5bo+FF8oCz5Z+H19k8MBVnlrlw3c2/YW/rtgB6KLcS13MLzwT3/
         ccwT+oBwB1HNKdSoSEMDy3ZqARaIVot0Z4SaoycBNp+S8WB6C/LnoWIUSa4aFYyX3U9I
         0oQWumZuG13S9aEYuzUeIwpfHtHDJgNhHpD3E0cZZBU9dhYDpSN7kV3LD970jw1oOosE
         qnT6thcTfDLU5Z8EPZW36nESya6h6FSAu/EcezJiR5lSAva8CYNv5MQWxyx2j5OQvvvl
         h43g==
X-Gm-Message-State: AC+VfDydbjLChO38RIV6N8Gxj7sMhJ74bgilAAdoy2hdNM7fimEiNSwT
        fMVvUpqAyAmB4my1bBBljcrjfEKQenIR
X-Google-Smtp-Source: ACHHUZ4FhRQ9GF1LL7ag+4vEDk4EggmhjC5bOe2EKtfFPgW4t1biKjtiQOAoMMTb5I/RPH0pA4bjTNsi+zo6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a25:d68d:0:b0:ba7:8628:93e2 with SMTP id
 n135-20020a25d68d000000b00ba7862893e2mr1543082ybg.4.1684998732197; Thu, 25
 May 2023 00:12:12 -0700 (PDT)
Date:   Thu, 25 May 2023 00:11:23 -0700
In-Reply-To: <20230525071133.2066610-1-irogers@google.com>
Message-Id: <20230525071133.2066610-7-irogers@google.com>
Mime-Version: 1.0
References: <20230525071133.2066610-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 06/16] tools api fs: Avoid large static PATH_MAX arrays
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
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Change struct fs to have a pointer to a dynamically allocated array
rather than an array. This reduces the size of fs__entries from 24,768
bytes to 240 bytes. Read paths into a stack allocated array and
strdup. Fix off-by-1 fscanf %<num>s in fs__read_mounts caught by
address sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/fs/fs.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index 82f53d81a7a7..22d34a0be8b4 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -88,7 +88,7 @@ static const char * const bpf_fs__known_mountpoints[] = {
 struct fs {
 	const char		*name;
 	const char * const	*mounts;
-	char			 path[PATH_MAX];
+	char			*path;
 	bool			 found;
 	bool			 checked;
 	long			 magic;
@@ -151,17 +151,23 @@ static bool fs__read_mounts(struct fs *fs)
 	bool found = false;
 	char type[100];
 	FILE *fp;
+	char path[PATH_MAX + 1];
 
 	fp = fopen("/proc/mounts", "r");
 	if (fp == NULL)
-		return NULL;
+		return false;
 
 	while (!found &&
 	       fscanf(fp, "%*s %" STR(PATH_MAX) "s %99s %*s %*d %*d\n",
-		      fs->path, type) == 2) {
+		      path, type) == 2) {
 
-		if (strcmp(type, fs->name) == 0)
+		if (strcmp(type, fs->name) == 0) {
+			free(fs->path);
+			fs->path = strdup(path);
+			if (!fs->path)
+				return false;
 			found = true;
+		}
 	}
 
 	fclose(fp);
@@ -188,8 +194,11 @@ static bool fs__check_mounts(struct fs *fs)
 	ptr = fs->mounts;
 	while (*ptr) {
 		if (fs__valid_mount(*ptr, fs->magic) == 0) {
+			free(fs->path);
+			fs->path = strdup(*ptr);
+			if (!fs->path)
+				return false;
 			fs->found = true;
-			strcpy(fs->path, *ptr);
 			return true;
 		}
 		ptr++;
@@ -227,10 +236,12 @@ static bool fs__env_override(struct fs *fs)
 	if (!override_path)
 		return false;
 
+	free(fs->path);
+	fs->path = strdup(override_path);
+	if (!fs->path)
+		return false;
 	fs->found = true;
 	fs->checked = true;
-	strncpy(fs->path, override_path, sizeof(fs->path) - 1);
-	fs->path[sizeof(fs->path) - 1] = '\0';
 	return true;
 }
 
-- 
2.40.1.698.g37aff9b760-goog

