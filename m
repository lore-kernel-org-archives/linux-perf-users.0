Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5571BC7EE2E
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 May 2023 18:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbjEZSfp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 May 2023 14:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243066AbjEZSfK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 May 2023 14:35:10 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C06E57
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 11:34:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba81b238ee8so2294098276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 11:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685126082; x=1687718082;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZlCp8PAHlNCmunobQkdPrQHDqUHTnoSBSsPrysF0mwY=;
        b=Plkd/xuqK7M9SwlLAM21/d2FaIm8z5gDewz3SZdNEOECc+gV7lFjw6+UKO10fmBMZB
         pIXWE5awCZwwtkj1BDl0EmV/jGe2DVd34bup9DBTV9CgoWd5eeg+AbMzKlerhNR7X/Gw
         705gC8RpQCNguftIohd3ITPASIdqZ3kZbzcMgE28J3d3Ucwo/ZMCZke1RsbUoVXb0caA
         1vdqJ9f5BW4pqGgv/GFN30r/jEQnHeCvvO6RpFr+ppnBAyIBQIqTPKDgaeFxhAKwZVKu
         ny4EnnAWZ0rbuqFG19Kx2w6R+3Eqg4AEaVFkyrlT/mdtSGwWjLf8PD5ulwuJj1DfqdQb
         6/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126082; x=1687718082;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlCp8PAHlNCmunobQkdPrQHDqUHTnoSBSsPrysF0mwY=;
        b=K19UZZHJc2SvDd5YKskCU5x74iLMiPatOuzhVUGNef8HD5KoZRh0qCTQ6WCIqkL24z
         8XMEynAJ5iqceoE2lLt0FbgQNdu9Pr7O0xU9tHf2nmcvFxokIzo9iLWspuLYgypncHkW
         atyjPAOTrnUeJwVDkglgnWjQS7HqH5B+VG9pvuqGJqCA1D1IihNzkm1R0Ue7AFk0fPge
         k8TLINzJdBvQRgqRKAW5E3fs/ra2SbvYe4HJ9MZDry0s+cfiOsbHy/4uYtUanQLGcqlm
         oHxqn3KfoJp78sG8enTaKL/ybmArz+tF7BMln2SU+9IvEE88VfkkMqaewgrz7ysduEPr
         9VmQ==
X-Gm-Message-State: AC+VfDyE2eDssRNVxCdPtxh96AUYYbL1xX85B6WAWjHCJYYTkOOLo5jA
        btiLfvnAO8MuDlQKpqXQaLs+TAGA6Pg9
X-Google-Smtp-Source: ACHHUZ6QAA72EtRyWFuSRwlWtGxsChIoyKoEFA62TrkZKniW/edvWdeG+Lum4DcHWumM9PH4R0IeDIbeBU87
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:fc1c:0:b0:bac:7086:c9b2 with SMTP id
 v28-20020a25fc1c000000b00bac7086c9b2mr992311ybd.12.1685126082416; Fri, 26 May
 2023 11:34:42 -0700 (PDT)
Date:   Fri, 26 May 2023 11:33:59 -0700
In-Reply-To: <20230526183401.2326121-1-irogers@google.com>
Message-Id: <20230526183401.2326121-15-irogers@google.com>
Mime-Version: 1.0
References: <20230526183401.2326121-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2 14/16] tools api fs: Dynamically allocate cgroupfs mount
 point cache
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

Move the cgroupfs_cache_entry 4128 byte array out of .bss.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/fs/cgroup.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/lib/api/fs/cgroup.c b/tools/lib/api/fs/cgroup.c
index 1573dae4259d..250629a09423 100644
--- a/tools/lib/api/fs/cgroup.c
+++ b/tools/lib/api/fs/cgroup.c
@@ -14,7 +14,7 @@ struct cgroupfs_cache_entry {
 };
 
 /* just cache last used one */
-static struct cgroupfs_cache_entry cached;
+static struct cgroupfs_cache_entry *cached;
 
 int cgroupfs_find_mountpoint(char *buf, size_t maxlen, const char *subsys)
 {
@@ -24,9 +24,9 @@ int cgroupfs_find_mountpoint(char *buf, size_t maxlen, const char *subsys)
 	char *p, *path;
 	char mountpoint[PATH_MAX];
 
-	if (!strcmp(cached.subsys, subsys)) {
-		if (strlen(cached.mountpoint) < maxlen) {
-			strcpy(buf, cached.mountpoint);
+	if (cached && !strcmp(cached->subsys, subsys)) {
+		if (strlen(cached->mountpoint) < maxlen) {
+			strcpy(buf, cached->mountpoint);
 			return 0;
 		}
 		return -1;
@@ -91,8 +91,13 @@ int cgroupfs_find_mountpoint(char *buf, size_t maxlen, const char *subsys)
 	free(line);
 	fclose(fp);
 
-	strncpy(cached.subsys, subsys, sizeof(cached.subsys) - 1);
-	strcpy(cached.mountpoint, mountpoint);
+	if (!cached)
+		cached = calloc(1, sizeof(*cached));
+
+	if (cached) {
+		strncpy(cached->subsys, subsys, sizeof(cached->subsys) - 1);
+		strcpy(cached->mountpoint, mountpoint);
+	}
 
 	if (mountpoint[0] && strlen(mountpoint) < maxlen) {
 		strcpy(buf, mountpoint);
-- 
2.41.0.rc0.172.g3f132b7071-goog

