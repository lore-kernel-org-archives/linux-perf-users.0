Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05012C3DA7A
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Jan 2023 14:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbjAFO0A (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Jan 2023 09:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbjAFOZw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Jan 2023 09:25:52 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E0243E67
        for <linux-perf-users@vger.kernel.org>; Fri,  6 Jan 2023 06:25:50 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id h66-20020a252145000000b0071a7340eea9so1987947ybh.6
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Jan 2023 06:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kC1oBRAXE838EyqcFtArpyyQWxtXQZCkq8gbe8hpVg4=;
        b=DQbR51Biav8RW8cOre9crR/Cih3nKjqFKDEeGB3Vzb6WLdeL6VgDdEY0m9IzEDCgrN
         cpAKhqH/MyXqYXG58AMkrIMXmqOH9z1eFuRMnCKzMvISBKAJH+V9UESk4I5TAuvNYXEk
         0vHO4JLod2K+wj6DvdrtkZcdxfMvdsDMRzYMnpqZ98BOvclvUDCDI4bh72+5iOY4O+DX
         R1cMezttAzMW0x/PXmONyk0cmTVL7Ohf+gaRYzCZRwWjzu9ZtuYYU+cHiv/EHb/6fL7D
         lREvj57YppLZcivTMT7ICPNvpU2ba2yERIkGPY2Vq1wbOYbveGs+I2+CJBR7QrAOINNZ
         fIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kC1oBRAXE838EyqcFtArpyyQWxtXQZCkq8gbe8hpVg4=;
        b=l4PjDMTJmvyGsYI9MerZn5RRD1+zClMi84GY4WU5OT49GEDUSUVX0kkUBlrCSkeDXM
         uWpsgWfHQIzPdaKSeidZ2dhE2SaONvOAUtpfWG9V+QUVeGZirl4niH/hD5nrheqq62C5
         iSKfTFDpLzdcpe5R/JNTTo0WW8VUMrx/GdjD3uNarH8XMrFUelFCLojn6i8uo1ks+OFW
         r3Kh74sl12WJ+R65xvGT7febC/rYyNrXUgL01gwCl9sKIw5F8EqHIo/cHoVThlDnZ9j3
         8Yi90ws5xwZKnyWFxx877DwEZctTX2QEl0iUU7V231RNJNLGIwICYz8dYTo1KUyxVeIV
         1XoA==
X-Gm-Message-State: AFqh2ko6lICMyDq5XWCln75zrpz1NuiF44zIj7fkSGiM75yVnsCcWY7b
        A1P+G4BX+cRYYbuqL5MpDftM6d/ABctR
X-Google-Smtp-Source: AMrXdXssgHQfc2+9CJD0DISmI/eT1XOavZLaNqX+X6gT55ye+JxJrY74HJ53cDxcXjh9CaNg2Q33jZsFN+Pd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b317:a30:653a:18e5])
 (user=irogers job=sendgmr) by 2002:a81:9281:0:b0:391:ea94:ec9b with SMTP id
 j123-20020a819281000000b00391ea94ec9bmr149767ywg.57.1673015149991; Fri, 06
 Jan 2023 06:25:49 -0800 (PST)
Date:   Fri,  6 Jan 2023 06:25:36 -0800
Message-Id: <20230106142537.607399-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v2 1/2] perf build: Properly guard libbpf includes
From:   Ian Rogers <irogers@google.com>
To:     Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, acme@kernel.org, irogers@google.com,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Including libbpf header files should be guarded by
HAVE_LIBBPF_SUPPORT. In bpf_counter.h, move the skeleton utilities
under HAVE_BPF_SKEL.

Fixes: d6a735ef3277 ("perf bpf_counter: Move common functions to bpf_counter.h")
Reported-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c    |  2 +
 tools/perf/util/bpf_counter.h | 85 ++++++++++++++++++-----------------
 2 files changed, 46 insertions(+), 41 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 86e06f136f40..d21fe0f32a6d 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -16,7 +16,9 @@
 
 #include "util/record.h"
 #include <api/fs/tracing_path.h>
+#ifdef HAVE_LIBBPF_SUPPORT
 #include <bpf/bpf.h>
+#endif
 #include "util/bpf_map.h"
 #include "util/rlimit.h"
 #include "builtin.h"
diff --git a/tools/perf/util/bpf_counter.h b/tools/perf/util/bpf_counter.h
index 4dbf26408b69..9113c8bf5cb0 100644
--- a/tools/perf/util/bpf_counter.h
+++ b/tools/perf/util/bpf_counter.h
@@ -4,9 +4,12 @@
 
 #include <linux/list.h>
 #include <sys/resource.h>
+
+#ifdef HAVE_LIBBPF_SUPPORT
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
 #include <bpf/libbpf.h>
+#endif
 
 struct evsel;
 struct target;
@@ -42,6 +45,47 @@ int bpf_counter__read(struct evsel *evsel);
 void bpf_counter__destroy(struct evsel *evsel);
 int bpf_counter__install_pe(struct evsel *evsel, int cpu_map_idx, int fd);
 
+static inline __u32 bpf_link_get_id(int fd)
+{
+	struct bpf_link_info link_info = { .id = 0, };
+	__u32 link_info_len = sizeof(link_info);
+
+	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
+	return link_info.id;
+}
+
+static inline __u32 bpf_link_get_prog_id(int fd)
+{
+	struct bpf_link_info link_info = { .id = 0, };
+	__u32 link_info_len = sizeof(link_info);
+
+	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
+	return link_info.prog_id;
+}
+
+static inline __u32 bpf_map_get_id(int fd)
+{
+	struct bpf_map_info map_info = { .id = 0, };
+	__u32 map_info_len = sizeof(map_info);
+
+	bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
+	return map_info.id;
+}
+
+/* trigger the leader program on a cpu */
+static inline int bperf_trigger_reading(int prog_fd, int cpu)
+{
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
+			    .ctx_in = NULL,
+			    .ctx_size_in = 0,
+			    .flags = BPF_F_TEST_RUN_ON_CPU,
+			    .cpu = cpu,
+			    .retval = 0,
+		);
+
+	return bpf_prog_test_run_opts(prog_fd, &opts);
+}
+
 #else /* HAVE_BPF_SKEL */
 
 #include <linux/err.h>
@@ -87,45 +131,4 @@ static inline void set_max_rlimit(void)
 	setrlimit(RLIMIT_MEMLOCK, &rinf);
 }
 
-static inline __u32 bpf_link_get_id(int fd)
-{
-	struct bpf_link_info link_info = { .id = 0, };
-	__u32 link_info_len = sizeof(link_info);
-
-	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
-	return link_info.id;
-}
-
-static inline __u32 bpf_link_get_prog_id(int fd)
-{
-	struct bpf_link_info link_info = { .id = 0, };
-	__u32 link_info_len = sizeof(link_info);
-
-	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
-	return link_info.prog_id;
-}
-
-static inline __u32 bpf_map_get_id(int fd)
-{
-	struct bpf_map_info map_info = { .id = 0, };
-	__u32 map_info_len = sizeof(map_info);
-
-	bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
-	return map_info.id;
-}
-
-/* trigger the leader program on a cpu */
-static inline int bperf_trigger_reading(int prog_fd, int cpu)
-{
-	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
-			    .ctx_in = NULL,
-			    .ctx_size_in = 0,
-			    .flags = BPF_F_TEST_RUN_ON_CPU,
-			    .cpu = cpu,
-			    .retval = 0,
-		);
-
-	return bpf_prog_test_run_opts(prog_fd, &opts);
-}
-
 #endif /* __PERF_BPF_COUNTER_H */
-- 
2.39.0.314.g84b9a713c41-goog

