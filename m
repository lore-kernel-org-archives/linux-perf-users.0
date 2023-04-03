Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988DDC77B62
	for <linux-perf-users@archiver.kernel.org>; Mon,  3 Apr 2023 20:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjDCUgB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 3 Apr 2023 16:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjDCUgA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Apr 2023 16:36:00 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E1CE4C
        for <linux-perf-users@vger.kernel.org>; Mon,  3 Apr 2023 13:35:59 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5411f21f849so303946077b3.16
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Apr 2023 13:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680554159;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ZpvT7eg+vnKBOtbR4gyzujxSYd+w2LU6qjFGnUoH2c=;
        b=LfoPDA5u65dk3vqeRPg+ldS+aRLRAKOfR2FpRYH44NGfiZrwrsRWuJmLocR6GzwBs1
         6uW+/Myl4qjYjlm0yA3EGoDWqy5q6q/vth12JBalyqd+KFjdpTnmBgvkNH3yOygawqbp
         8Z+ybme7SQvSeclDh6zQPUJ+wGd+3yTM/eT0665AlUqjUelm4c07g3hnyTLoFRGzs7PC
         sMOPR+ud7A1rnchvUyGiOgpnNTENpAjmGzOaAyGYob8AoqfAMaF6w+410Vt/tGbDVd5Q
         KfmjtgvD/mDksvhniCyzDe9GMvVuvGY/VAzBOLEIYYvRTj2RN5UyaMPx4+I6GHiypGya
         bpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680554159;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ZpvT7eg+vnKBOtbR4gyzujxSYd+w2LU6qjFGnUoH2c=;
        b=MO6Wyx2se0EAcSSR9wKmmuyX7HvJxXZmC7lo8mVKNLr75tQw5MTXy/xVDs00Q1y4Xc
         g9AtO6Gjammahlyli2w2yOKmO6Iec2fpHBTNzGpog+D3s6Wq3ZlWTk32ojkYbBpInZZy
         ptkt3M25cbrWaUNBx55jPnSotl00H5ge53yTzAg13o8sxXo5788TOzmFdTkfkRAl0Cwu
         FV50MQpu+Ea0a0hr/9ee2b9r0UH2KXdpL9zzgUYjHqjt1keT9tDs8yFQUb/3qlAhQZQs
         EZOzN/FFe4KIv59atQstsaHOd42yGxRUGXDmY+ZmMebBLsMXMJXZqKgFDVVV7NM+z7oB
         y4XQ==
X-Gm-Message-State: AAQBX9c5gki3MHAuTDwYOq+oJrfO0HHSI9/bVr9hcvdUrcMNv2R14A4g
        z9YRo90R4wvEoOt3bp1VlOF++Oq3gSMn
X-Google-Smtp-Source: AKy350bBH9X6343eBptzG9EmcKtn8P8OkiUVau9jIyEKqwbQbn5XnX6F4krIK+2iysu5sDzrtqAo+b0pPK4M
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9dc:a977:817d:341])
 (user=irogers job=sendgmr) by 2002:a25:e047:0:b0:b77:3f5a:8a53 with SMTP id
 x68-20020a25e047000000b00b773f5a8a53mr271301ybg.12.1680554158838; Mon, 03 Apr
 2023 13:35:58 -0700 (PDT)
Date:   Mon,  3 Apr 2023 13:35:45 -0700
Message-Id: <20230403203545.1872196-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v2] perf jit: Fix a few memory leaks
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
        Brian Robbins <brianrob@linux.microsoft.com>,
        Yuan Can <yuancan@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

As reported by leak sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/genelf_debug.c | 45 +++++++++++++++++++++-------------
 tools/perf/util/jitdump.c      |  7 +++++-
 2 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/genelf_debug.c b/tools/perf/util/genelf_debug.c
index dd40683bd4c0..8786c366566e 100644
--- a/tools/perf/util/genelf_debug.c
+++ b/tools/perf/util/genelf_debug.c
@@ -87,6 +87,12 @@ buffer_ext_init(struct buffer_ext *be)
 	be->max_sz = 0;
 }
 
+static void
+buffer_ext_exit(struct buffer_ext *be)
+{
+	free(be->data);
+}
+
 static inline size_t
 buffer_ext_size(struct buffer_ext *be)
 {
@@ -487,28 +493,28 @@ jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries
 	Elf_Scn *scn;
 	Elf_Shdr *shdr;
 	struct buffer_ext dl, di, da;
-	int ret;
+	int ret = -1;
 
 	buffer_ext_init(&dl);
 	buffer_ext_init(&di);
 	buffer_ext_init(&da);
 
-	ret = jit_process_debug_info(code_addr, debug, nr_debug_entries, &dl, &da, &di);
-	if (ret)
-		return -1;
+	if (jit_process_debug_info(code_addr, debug, nr_debug_entries, &dl, &da, &di))
+		goto out;
+
 	/*
 	 * setup .debug_line section
 	 */
 	scn = elf_newscn(e);
 	if (!scn) {
 		warnx("cannot create section");
-		return -1;
+		goto out;
 	}
 
 	d = elf_newdata(scn);
 	if (!d) {
 		warnx("cannot get new data");
-		return -1;
+		goto out;
 	}
 
 	d->d_align = 1;
@@ -521,7 +527,7 @@ jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries
 	shdr = elf_getshdr(scn);
 	if (!shdr) {
 		warnx("cannot get section header");
-		return -1;
+		goto out;
 	}
 
 	shdr->sh_name = 52; /* .debug_line */
@@ -536,13 +542,13 @@ jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries
 	scn = elf_newscn(e);
 	if (!scn) {
 		warnx("cannot create section");
-		return -1;
+		goto out;
 	}
 
 	d = elf_newdata(scn);
 	if (!d) {
 		warnx("cannot get new data");
-		return -1;
+		goto out;
 	}
 
 	d->d_align = 1;
@@ -555,7 +561,7 @@ jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries
 	shdr = elf_getshdr(scn);
 	if (!shdr) {
 		warnx("cannot get section header");
-		return -1;
+		goto out;
 	}
 
 	shdr->sh_name = 64; /* .debug_info */
@@ -570,13 +576,13 @@ jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries
 	scn = elf_newscn(e);
 	if (!scn) {
 		warnx("cannot create section");
-		return -1;
+		goto out;
 	}
 
 	d = elf_newdata(scn);
 	if (!d) {
 		warnx("cannot get new data");
-		return -1;
+		goto out;
 	}
 
 	d->d_align = 1;
@@ -589,7 +595,7 @@ jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries
 	shdr = elf_getshdr(scn);
 	if (!shdr) {
 		warnx("cannot get section header");
-		return -1;
+		goto out;
 	}
 
 	shdr->sh_name = 76; /* .debug_info */
@@ -601,9 +607,14 @@ jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries
 	/*
 	 * now we update the ELF image with all the sections
 	 */
-	if (elf_update(e, ELF_C_WRITE) < 0) {
+	if (elf_update(e, ELF_C_WRITE) < 0)
 		warnx("elf_update debug failed");
-		return -1;
-	}
-	return 0;
+	else
+		ret = 0;
+
+out:
+	buffer_ext_exit(&dl);
+	buffer_ext_exit(&di);
+	buffer_ext_exit(&da);
+	return ret;
 }
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 0e033278fa12..28e49502db5e 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -235,9 +235,11 @@ jit_open(struct jit_buf_desc *jd, const char *name)
 	 */
 	strcpy(jd->dir, name);
 	dirname(jd->dir);
+	free(buf);
 
 	return 0;
 error:
+	free(buf);
 	funlockfile(jd->in);
 	fclose(jd->in);
 	return retval;
@@ -523,7 +525,7 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
 
 	ret = perf_event__process_mmap2(tool, event, &sample, jd->machine);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = jit_inject_event(jd, event);
 	/*
@@ -532,6 +534,8 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
 	if (!ret)
 		build_id__mark_dso_hit(tool, event, &sample, NULL, jd->machine);
 
+out:
+	free(event);
 	return ret;
 }
 
@@ -874,6 +878,7 @@ jit_process(struct perf_session *session,
 	}
 
 	nsinfo__put(jd.nsi);
+	free(jd.buf);
 
 	return ret;
 }
-- 
2.40.0.348.gf938b09366-goog

