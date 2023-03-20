Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4281AC6FD1D
	for <linux-perf-users@archiver.kernel.org>; Mon, 20 Mar 2023 03:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjCTDjZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 19 Mar 2023 23:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjCTDjS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 19 Mar 2023 23:39:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E0C22039
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Mar 2023 20:39:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e11-20020a5b004b000000b00b37118ce5a7so11931138ybp.10
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Mar 2023 20:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679283539;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rHDC7UBXOWCAEPbdLzihWokj+UpLxvZZidURX978WmE=;
        b=DD409jiJybjs9fQX7q7fqtCmw5nuGC5eXy8D6ZSD5O4pmYcN72p7hTEODVgBYZEhih
         BQ8Zkql4EPpaB/c9OmfzRn1pSmg46M89b8K41d3wbmu47kPetePp5bOjXNfKJ0uMuEVZ
         RbR5wRXgwvyBsjPdXzI2qrEcdwA1LaGDzHzRu7x6Q9/UMO88nh71PpsoMZsuOtW5tz/m
         BfsDjqHvt6vwK4UyqTSn7GTf9BTLFViOVkKIfsuWxt75dvaC4f8JP84RfzUVfiA3I1Nu
         hCJB5Fwv5gfaeAYFx+rQPgC1/9V5eGmTaMDpqoo0mAIcyEDjLbgzy7q1+Ej9yM6pdkT9
         6xnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679283539;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rHDC7UBXOWCAEPbdLzihWokj+UpLxvZZidURX978WmE=;
        b=NhOc23is4cIIfAjWjTO5kx+7/UoN3it9wWDzWQOvite8KP/GTNqXGb7/Rj3gjWYk21
         VvLFTh4NvkDARDLY8uy4dA2G9W1RXr+rD2b52j1EuK0IqSCkD9qWYz3ggBcX6hRa7eQH
         WDRc1I9Ubg9Ez0L0vnjcEO9NHnNyWbigqDVn6IzKUjzx4fDbiUac3a+d3kEF7STFfnbx
         AxwHDR8klMp4arD+PdliHcNw5JwZqF9m1JLvusCPwzy+O3A9zD+GMvgmXBvVmZVTNAh/
         PJmQmSFLQQX8Yho14A+6VZGwRO1lzLNOYAn1cVwaAQ3CqV76A8qdo/YSF45lfscYiYay
         yOcw==
X-Gm-Message-State: AO0yUKVwGtmHl1KT1D4Q5nG2qokFYeFggoz5jl6ftp3gpVB1SCOeH3rF
        NsnTcAHS5RYGtZY4qPpOyJYX+yS5oH4m
X-Google-Smtp-Source: AK7set84I3Q5yq7Mc89TIl7TiUOtm8jwsNnxNmJCd6t1yy+aYw75XLnXCrbdgrXYoaHB+1L/4SUHw0NpECCk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:1895:9fa0:27f5:cb71])
 (user=irogers job=sendgmr) by 2002:a05:6902:150e:b0:b43:8424:2a4c with SMTP
 id q14-20020a056902150e00b00b4384242a4cmr4773681ybu.10.1679283539572; Sun, 19
 Mar 2023 20:38:59 -0700 (PDT)
Date:   Sun, 19 Mar 2023 20:37:51 -0700
In-Reply-To: <20230320033810.980165-1-irogers@google.com>
Message-Id: <20230320033810.980165-4-irogers@google.com>
Mime-Version: 1.0
References: <20230320033810.980165-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v4 03/22] perf tests: Add common error route for code-reading
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

A later change will enforce that the map is put on this path
regardless of success or error.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/code-reading.c | 39 +++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index cb8cd09938d5..fb67fd5ebd9f 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -236,18 +236,19 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 	const char *objdump_name;
 	char decomp_name[KMOD_DECOMP_LEN];
 	bool decomp = false;
-	int ret;
+	int ret, err = 0;
 
 	pr_debug("Reading object code for memory address: %#"PRIx64"\n", addr);
 
 	if (!thread__find_map(thread, cpumode, addr, &al) || !al.map->dso) {
 		if (cpumode == PERF_RECORD_MISC_HYPERVISOR) {
 			pr_debug("Hypervisor address can not be resolved - skipping\n");
-			return 0;
+			goto out;
 		}
 
 		pr_debug("thread__find_map failed\n");
-		return -1;
+		err = -1;
+		goto out;
 	}
 
 	pr_debug("File is: %s\n", al.map->dso->long_name);
@@ -255,7 +256,7 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 	if (al.map->dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS &&
 	    !dso__is_kcore(al.map->dso)) {
 		pr_debug("Unexpected kernel address - skipping\n");
-		return 0;
+		goto out;
 	}
 
 	pr_debug("On file address is: %#"PRIx64"\n", al.addr);
@@ -272,15 +273,18 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 					al.addr, buf1, len);
 	if (ret_len != len) {
 		pr_debug("dso__data_read_offset failed\n");
-		return -1;
+		err = -1;
+		goto out;
 	}
 
 	/*
 	 * Converting addresses for use by objdump requires more information.
 	 * map__load() does that.  See map__rip_2objdump() for details.
 	 */
-	if (map__load(al.map))
-		return -1;
+	if (map__load(al.map)) {
+		err = -1;
+		goto out;
+	}
 
 	/* objdump struggles with kcore - try each map only once */
 	if (dso__is_kcore(al.map->dso)) {
@@ -290,12 +294,12 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 			if (state->done[d] == al.map->start) {
 				pr_debug("kcore map tested already");
 				pr_debug(" - skipping\n");
-				return 0;
+				goto out;
 			}
 		}
 		if (state->done_cnt >= ARRAY_SIZE(state->done)) {
 			pr_debug("Too many kcore maps - skipping\n");
-			return 0;
+			goto out;
 		}
 		state->done[state->done_cnt++] = al.map->start;
 	}
@@ -306,7 +310,8 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 						 decomp_name,
 						 sizeof(decomp_name)) < 0) {
 			pr_debug("decompression failed\n");
-			return -1;
+			err = -1;
+			goto out;
 		}
 
 		decomp = true;
@@ -337,15 +342,16 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 				 */
 				pr_debug("objdump failed for kcore");
 				pr_debug(" - skipping\n");
-				return 0;
 			} else {
-				return -1;
+				err = -1;
 			}
+			goto out;
 		}
 	}
 	if (ret < 0) {
 		pr_debug("read_via_objdump failed\n");
-		return -1;
+		err = -1;
+		goto out;
 	}
 
 	/* The results should be identical */
@@ -355,11 +361,12 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 		dump_buf(buf1, len);
 		pr_debug("buf2 (objdump):\n");
 		dump_buf(buf2, len);
-		return -1;
+		err = -1;
+		goto out;
 	}
 	pr_debug("Bytes read match those read by objdump\n");
-
-	return 0;
+out:
+	return err;
 }
 
 static int process_sample_event(struct machine *machine,
-- 
2.40.0.rc1.284.g88254d51c5-goog

