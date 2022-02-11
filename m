Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38503C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Feb 2022 10:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348967AbiBKKfH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Feb 2022 05:35:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349013AbiBKKfC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Feb 2022 05:35:02 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58CCEBC
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Feb 2022 02:34:53 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id g205-20020a2552d6000000b0061e1843b8edso16801058ybb.18
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Feb 2022 02:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ecm5CSvtzvsHI0TIuBDEh7P+YgW7Azf4QGGIL0a03dA=;
        b=ce3krB8NWFrMRSeIoRtXFyDqw+VdlqaX8EyuhBwsn7rZFYxmQn47aFdro6MH+a/JTt
         fDRvncKB/nlulI0bkpNYRUF2OX1ZM96b3gr871zVWEyQf/GchXiN9bLWYfCOGbRasERO
         M5hTFtzVgtruzkluKQZI8m40A9Z6tD7vFHeQ6L3xV1vDU11uJYQrOFOjKni5QSfzF0Iu
         2DByeSUTF44bWN1ZXa+5e/LWGBczxgaDk+V5k2CQ5YnmgWlcJ6XKIOIV9UuAbI0Q4GFB
         PK8Ai4dkdze5svyyUPmQfyRtbKoNrZGUrRMCV2OdFfg3NYQzOQiTSuvqhnQ1YuS+BEXT
         cjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ecm5CSvtzvsHI0TIuBDEh7P+YgW7Azf4QGGIL0a03dA=;
        b=hbaK7d7r9G4OjCIek4YY/slkquNfQrw03d6n7BhBATtGXyFMDIHZuA4yQNSlNK5gDj
         QNqoHirKS0CwQQtMsJfs1N/c4AjjiUHEWb+mSWqGsn31iBG6fKYKv00qK1MSC9QwePqK
         7HPCqGXMrh0QQTLgM1g/pyT6Ry3SzDceMS9FZkIgngkXNljuefDUNV5/KK44F3ewfOa0
         jyY/LDfNK9hA2cHNcik+DQtf0Kneo+Y8Sn5EOVrwQTqvCdBudzkKMrpO/h3ubWcNUE2e
         pkasxqtazB89rYmcifJZjMjrLOetHlE0nHJfGfrqs8nurfIWji9heekQizXm0BtOSbnq
         QWcg==
X-Gm-Message-State: AOAM533AK7gJeMbil94FYWOIOgFfcd/0DRqvCbuqJn+S/bE1cZZQ5xOA
        R1CjecuNdX9+z/eUcXP8QiswETkvmGnu
X-Google-Smtp-Source: ABdhPJzwDDMxcDGeVt6Ot3wjxv84puS5i6/ff6OWe5GeOpC2qsVX0//v6k7U/o5k7ZQ4HVQhOOqxRkLdBAY2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2d98:3ad9:1d8a:fb9b])
 (user=irogers job=sendgmr) by 2002:a25:35c2:: with SMTP id
 c185mr645352yba.617.1644575692875; Fri, 11 Feb 2022 02:34:52 -0800 (PST)
Date:   Fri, 11 Feb 2022 02:34:06 -0800
In-Reply-To: <20220211103415.2737789-1-irogers@google.com>
Message-Id: <20220211103415.2737789-14-irogers@google.com>
Mime-Version: 1.0
References: <20220211103415.2737789-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v3 13/22] perf namespaces: Add functions to access nsinfo
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
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jin Yao <yao.jin@linux.intel.com>,
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
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Having functions to access nsinfo reduces the places where reference
counting checking needs to be added.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c  |  2 +-
 tools/perf/builtin-probe.c   |  2 +-
 tools/perf/util/build-id.c   |  4 +--
 tools/perf/util/jitdump.c    | 10 ++++----
 tools/perf/util/map.c        |  4 +--
 tools/perf/util/namespaces.c | 50 ++++++++++++++++++++++++++++--------
 tools/perf/util/namespaces.h | 10 ++++++--
 tools/perf/util/symbol.c     |  8 +++---
 8 files changed, 63 insertions(+), 27 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index bede332bf0e2..f7917c390e96 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -354,7 +354,7 @@ static struct dso *findnew_dso(int pid, int tid, const char *filename,
 		nnsi = nsinfo__copy(nsi);
 		if (nnsi) {
 			nsinfo__put(nsi);
-			nnsi->need_setns = false;
+			nsinfo__clear_need_setns(nnsi);
 			nsi = nnsi;
 		}
 		dso = machine__findnew_vdso(machine, thread);
diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index c31627af75d4..f62298f5db3b 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -217,7 +217,7 @@ static int opt_set_target_ns(const struct option *opt __maybe_unused,
 			return ret;
 		}
 		nsip = nsinfo__new(ns_pid);
-		if (nsip && nsip->need_setns)
+		if (nsip && nsinfo__need_setns(nsip))
 			params.nsi = nsinfo__get(nsip);
 		nsinfo__put(nsip);
 
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index e32e8f2ff3bd..7a5821c87f94 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -706,7 +706,7 @@ build_id_cache__add(const char *sbuild_id, const char *name, const char *realnam
 		if (is_kallsyms) {
 			if (copyfile("/proc/kallsyms", filename))
 				goto out_free;
-		} else if (nsi && nsi->need_setns) {
+		} else if (nsi && nsinfo__need_setns(nsi)) {
 			if (copyfile_ns(name, filename, nsi))
 				goto out_free;
 		} else if (link(realname, filename) && errno != EEXIST &&
@@ -730,7 +730,7 @@ build_id_cache__add(const char *sbuild_id, const char *name, const char *realnam
 				goto out_free;
 			}
 			if (access(filename, F_OK)) {
-				if (nsi && nsi->need_setns) {
+				if (nsi && nsinfo__need_setns(nsi)) {
 					if (copyfile_ns(debugfile, filename,
 							nsi))
 						goto out_free;
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 917a9c707371..a23255773c60 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -382,15 +382,15 @@ jit_inject_event(struct jit_buf_desc *jd, union perf_event *event)
 
 static pid_t jr_entry_pid(struct jit_buf_desc *jd, union jr_entry *jr)
 {
-	if (jd->nsi && jd->nsi->in_pidns)
-		return jd->nsi->tgid;
+	if (jd->nsi && nsinfo__in_pidns(jd->nsi))
+		return nsinfo__tgid(jd->nsi);
 	return jr->load.pid;
 }
 
 static pid_t jr_entry_tid(struct jit_buf_desc *jd, union jr_entry *jr)
 {
-	if (jd->nsi && jd->nsi->in_pidns)
-		return jd->nsi->pid;
+	if (jd->nsi && nsinfo__in_pidns(jd->nsi))
+		return nsinfo__pid(jd->nsi);
 	return jr->load.tid;
 }
 
@@ -779,7 +779,7 @@ jit_detect(char *mmap_name, pid_t pid, struct nsinfo *nsi)
 	 * pid does not match mmap pid
 	 * pid==0 in system-wide mode (synthesized)
 	 */
-	if (pid && pid2 != nsi->nstgid)
+	if (pid && pid2 != nsinfo__nstgid(nsi))
 		return -1;
 	/*
 	 * validate suffix
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index dfa5f6b7381f..166c84c829f6 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -139,7 +139,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 
 		if ((anon || no_dso) && nsi && (prot & PROT_EXEC)) {
 			snprintf(newfilename, sizeof(newfilename),
-				 "/tmp/perf-%d.map", nsi->pid);
+				 "/tmp/perf-%d.map", nsinfo__pid(nsi));
 			filename = newfilename;
 		}
 
@@ -156,7 +156,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 			nnsi = nsinfo__copy(nsi);
 			if (nnsi) {
 				nsinfo__put(nsi);
-				nnsi->need_setns = false;
+				nsinfo__clear_need_setns(nnsi);
 				nsi = nnsi;
 			}
 			pgoff = 0;
diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index 48aa3217300b..dd536220cdb9 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -76,7 +76,7 @@ static int nsinfo__get_nspid(struct nsinfo *nsi, const char *path)
 		if (strstr(statln, "Tgid:") != NULL) {
 			nsi->tgid = (pid_t)strtol(strrchr(statln, '\t'),
 						     NULL, 10);
-			nsi->nstgid = nsi->tgid;
+			nsi->nstgid = nsinfo__tgid(nsi);
 		}
 
 		if (strstr(statln, "NStgid:") != NULL) {
@@ -108,7 +108,7 @@ int nsinfo__init(struct nsinfo *nsi)
 	if (snprintf(oldns, PATH_MAX, "/proc/self/ns/mnt") >= PATH_MAX)
 		return rv;
 
-	if (asprintf(&newns, "/proc/%d/ns/mnt", nsi->pid) == -1)
+	if (asprintf(&newns, "/proc/%d/ns/mnt", nsinfo__pid(nsi)) == -1)
 		return rv;
 
 	if (stat(oldns, &old_stat) < 0)
@@ -129,7 +129,7 @@ int nsinfo__init(struct nsinfo *nsi)
 	/* If we're dealing with a process that is in a different PID namespace,
 	 * attempt to work out the innermost tgid for the process.
 	 */
-	if (snprintf(spath, PATH_MAX, "/proc/%d/status", nsi->pid) >= PATH_MAX)
+	if (snprintf(spath, PATH_MAX, "/proc/%d/status", nsinfo__pid(nsi)) >= PATH_MAX)
 		goto out;
 
 	rv = nsinfo__get_nspid(nsi, spath);
@@ -166,7 +166,7 @@ struct nsinfo *nsinfo__new(pid_t pid)
 	return nsi;
 }
 
-struct nsinfo *nsinfo__copy(struct nsinfo *nsi)
+struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
 {
 	struct nsinfo *nnsi;
 
@@ -175,11 +175,11 @@ struct nsinfo *nsinfo__copy(struct nsinfo *nsi)
 
 	nnsi = calloc(1, sizeof(*nnsi));
 	if (nnsi != NULL) {
-		nnsi->pid = nsi->pid;
-		nnsi->tgid = nsi->tgid;
-		nnsi->nstgid = nsi->nstgid;
-		nnsi->need_setns = nsi->need_setns;
-		nnsi->in_pidns = nsi->in_pidns;
+		nnsi->pid = nsinfo__pid(nsi);
+		nnsi->tgid = nsinfo__tgid(nsi);
+		nnsi->nstgid = nsinfo__nstgid(nsi);
+		nnsi->need_setns = nsinfo__need_setns(nsi);
+		nnsi->in_pidns = nsinfo__in_pidns(nsi);
 		if (nsi->mntns_path) {
 			nnsi->mntns_path = strdup(nsi->mntns_path);
 			if (!nnsi->mntns_path) {
@@ -193,7 +193,7 @@ struct nsinfo *nsinfo__copy(struct nsinfo *nsi)
 	return nnsi;
 }
 
-void nsinfo__delete(struct nsinfo *nsi)
+static void nsinfo__delete(struct nsinfo *nsi)
 {
 	zfree(&nsi->mntns_path);
 	free(nsi);
@@ -212,6 +212,36 @@ void nsinfo__put(struct nsinfo *nsi)
 		nsinfo__delete(nsi);
 }
 
+bool nsinfo__need_setns(const struct nsinfo *nsi)
+{
+        return nsi->need_setns;
+}
+
+void nsinfo__clear_need_setns(struct nsinfo *nsi)
+{
+        nsi->need_setns = false;
+}
+
+pid_t nsinfo__tgid(const struct nsinfo  *nsi)
+{
+        return nsi->tgid;
+}
+
+pid_t nsinfo__nstgid(const struct nsinfo  *nsi)
+{
+        return nsi->nstgid;
+}
+
+pid_t nsinfo__pid(const struct nsinfo  *nsi)
+{
+        return nsi->pid;
+}
+
+pid_t nsinfo__in_pidns(const struct nsinfo  *nsi)
+{
+        return nsi->in_pidns;
+}
+
 void nsinfo__mountns_enter(struct nsinfo *nsi,
 				  struct nscookie *nc)
 {
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index 9ceea9643507..567829262c42 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -47,12 +47,18 @@ struct nscookie {
 
 int nsinfo__init(struct nsinfo *nsi);
 struct nsinfo *nsinfo__new(pid_t pid);
-struct nsinfo *nsinfo__copy(struct nsinfo *nsi);
-void nsinfo__delete(struct nsinfo *nsi);
+struct nsinfo *nsinfo__copy(const struct nsinfo *nsi);
 
 struct nsinfo *nsinfo__get(struct nsinfo *nsi);
 void nsinfo__put(struct nsinfo *nsi);
 
+bool nsinfo__need_setns(const struct nsinfo *nsi);
+void nsinfo__clear_need_setns(struct nsinfo *nsi);
+pid_t nsinfo__tgid(const struct nsinfo  *nsi);
+pid_t nsinfo__nstgid(const struct nsinfo  *nsi);
+pid_t nsinfo__pid(const struct nsinfo  *nsi);
+pid_t nsinfo__in_pidns(const struct nsinfo  *nsi);
+
 void nsinfo__mountns_enter(struct nsinfo *nsi, struct nscookie *nc);
 void nsinfo__mountns_exit(struct nscookie *nc);
 
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 266c65bb8bbb..e8045b1c8700 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1784,8 +1784,8 @@ static int dso__find_perf_map(char *filebuf, size_t bufsz,
 
 	nsi = *nsip;
 
-	if (nsi->need_setns) {
-		snprintf(filebuf, bufsz, "/tmp/perf-%d.map", nsi->nstgid);
+	if (nsinfo__need_setns(nsi)) {
+		snprintf(filebuf, bufsz, "/tmp/perf-%d.map", nsinfo__nstgid(nsi));
 		nsinfo__mountns_enter(nsi, &nsc);
 		rc = access(filebuf, R_OK);
 		nsinfo__mountns_exit(&nsc);
@@ -1797,8 +1797,8 @@ static int dso__find_perf_map(char *filebuf, size_t bufsz,
 	if (nnsi) {
 		nsinfo__put(nsi);
 
-		nnsi->need_setns = false;
-		snprintf(filebuf, bufsz, "/tmp/perf-%d.map", nnsi->tgid);
+		nsinfo__clear_need_setns(nnsi);
+		snprintf(filebuf, bufsz, "/tmp/perf-%d.map", nsinfo__tgid(nnsi));
 		*nsip = nnsi;
 		rc = 0;
 	}
-- 
2.35.1.265.g69c8d7142f-goog

