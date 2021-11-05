Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F8AC433FE
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 Nov 2021 17:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47DAC61354
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 Nov 2021 17:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbhKERMd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 Nov 2021 13:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbhKERMd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 Nov 2021 13:12:33 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EAEC061714
        for <linux-perf-users@vger.kernel.org>; Fri,  5 Nov 2021 10:09:52 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id u22-20020a170902a61600b00141ab5dd25dso5366682plq.5
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Nov 2021 10:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ebj2WK+oB90JtYQv1UeSvn+F6A5sFqeL5jB3UEsJ7rQ=;
        b=ZVuxLCbTuG+lOnhYFy3FerRbBhAm93Irn6d5Q+N6DecHcTnGvfNWuebm8755qoCd7r
         ocHzOGyqA84thrvee7xII80kS6L86ukXY3IsyCmay2anJPhygJn3HFDvasWjnf8IBcWn
         eCyforMPff8hV/gQBO7VqBjV56H6WNm37cGiJCShYAa9IynPSFuGjHY+Tb7A0XV6dXhQ
         KadExOlIS6YOTVW4FTpivxPz8JXh1TxRgBHrToMoM5ZDhxFj8gzyjcG2JMqI/7/z6fY6
         uiyBl4nTVb1lqb2YPqwl/PaLwSSBivvgEZAezi+P/P33N7vbopTfX/59RFetxpQxuQxk
         Myzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ebj2WK+oB90JtYQv1UeSvn+F6A5sFqeL5jB3UEsJ7rQ=;
        b=bsb18xzDtVMx/bf1V6t/zKiP9hzLjUTXXZIpxmNLehe4y+QptjB9rB98fTO0/hDYGm
         TgSRwupEPO8yklhyhjeJsPV6e522PbCwmVrvz+OO1IpXDwKfjN0ITZytxZtf34puS+Np
         1G6YcgUDjvWIVrW+YNNDqfjE3lpl+VHmb1MIUrCpA4pDnYAKVAdbIu3PS3cqmppaz0f8
         fM0LTSC5gkFNxMO0+8vAeM/TCFeyatzgNzJX5buyg0zklY0yoyRfUKhtTTnp2Yjtjhah
         5ppUv9C/dtaUMcsov6w8L8yPWx19XnsSnzqNnaGpWDoFtHf5OKM9rf4VIhzCirfaTvhe
         0XKg==
X-Gm-Message-State: AOAM532AViTYIkv2i9PLVjtPdL65ABqYBhUf90PPCXl3BBzRWeh53+Us
        Ef3TmyvdLcZYGIKgo8mTV8O3EZnnZYJ7
X-Google-Smtp-Source: ABdhPJwVK2gURX9qu7r31seER2+KEWkIVqSbQ7fl6yOkCgAcXQ3s2gLQ+yKzK7SKqqgUFj9/NVdx+F73UIlq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4cee:beb8:1744:5207])
 (user=irogers job=sendgmr) by 2002:a17:90a:1548:: with SMTP id
 y8mr32371391pja.151.1636132192443; Fri, 05 Nov 2021 10:09:52 -0700 (PDT)
Date:   Fri,  5 Nov 2021 10:09:38 -0700
In-Reply-To: <20211105170943.3479315-1-irogers@google.com>
Message-Id: <20211105170943.3479315-3-irogers@google.com>
Mime-Version: 1.0
References: <20211105170943.3479315-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH 2/7] perf cputopo: Update to use pakage_cpus
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Song Liu <song@kernel.org>, Wan Jiabing <wanjiabing@vivo.com>,
        Yury Norov <yury.norov@gmail.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

core_siblings_list is the deprecated topology name for
package_cpus_list, update the code to try the non-deprecated path first.
Adjust variable names to match topology name.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cputopo.c | 26 ++++++++++++++++----------
 tools/perf/util/cputopo.h | 11 +++++++++--
 tools/perf/util/header.c  |  6 +++---
 3 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index ec77e2a7b3ca..f72a7de19e02 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -14,7 +14,9 @@
 #include "env.h"
 #include "pmu-hybrid.h"
 
-#define CORE_SIB_FMT \
+#define PACKAGE_CPUS_FMT \
+	"%s/devices/system/cpu/cpu%d/topology/package_cpus_list"
+#define PACKAGE_CPUS_FMT_OLD \
 	"%s/devices/system/cpu/cpu%d/topology/core_siblings_list"
 #define DIE_SIB_FMT \
 	"%s/devices/system/cpu/cpu%d/topology/die_cpus_list"
@@ -39,8 +41,12 @@ static int build_cpu_topology(struct cpu_topology *tp, int cpu)
 	u32 i = 0;
 	int ret = -1;
 
-	scnprintf(filename, MAXPATHLEN, CORE_SIB_FMT,
+	scnprintf(filename, MAXPATHLEN, PACKAGE_CPUS_FMT,
 		  sysfs__mountpoint(), cpu);
+	if (access(filename, F_OK) == -1) {
+		scnprintf(filename, MAXPATHLEN, PACKAGE_CPUS_FMT_OLD,
+			sysfs__mountpoint(), cpu);
+	}
 	fp = fopen(filename, "r");
 	if (!fp)
 		goto try_dies;
@@ -54,13 +60,13 @@ static int build_cpu_topology(struct cpu_topology *tp, int cpu)
 	if (p)
 		*p = '\0';
 
-	for (i = 0; i < tp->core_sib; i++) {
-		if (!strcmp(buf, tp->core_siblings[i]))
+	for (i = 0; i < tp->package_cpus_lists; i++) {
+		if (!strcmp(buf, tp->package_cpus_list[i]))
 			break;
 	}
-	if (i == tp->core_sib) {
-		tp->core_siblings[i] = buf;
-		tp->core_sib++;
+	if (i == tp->package_cpus_lists) {
+		tp->package_cpus_list[i] = buf;
+		tp->package_cpus_lists++;
 		buf = NULL;
 		len = 0;
 	}
@@ -139,8 +145,8 @@ void cpu_topology__delete(struct cpu_topology *tp)
 	if (!tp)
 		return;
 
-	for (i = 0 ; i < tp->core_sib; i++)
-		zfree(&tp->core_siblings[i]);
+	for (i = 0 ; i < tp->package_cpus_lists; i++)
+		zfree(&tp->package_cpus_list[i]);
 
 	if (tp->die_sib) {
 		for (i = 0 ; i < tp->die_sib; i++)
@@ -205,7 +211,7 @@ struct cpu_topology *cpu_topology__new(void)
 
 	tp = addr;
 	addr += sizeof(*tp);
-	tp->core_siblings = addr;
+	tp->package_cpus_list = addr;
 	addr += sz;
 	if (has_die) {
 		tp->die_siblings = addr;
diff --git a/tools/perf/util/cputopo.h b/tools/perf/util/cputopo.h
index d9af97177068..4ec9cb192c3d 100644
--- a/tools/perf/util/cputopo.h
+++ b/tools/perf/util/cputopo.h
@@ -5,10 +5,17 @@
 #include <linux/types.h>
 
 struct cpu_topology {
-	u32	  core_sib;
+	/* The number of unique package_cpus_lists below. */
+	u32	  package_cpus_lists;
 	u32	  die_sib;
 	u32	  thread_sib;
-	char	**core_siblings;
+	/*
+	 * An array of strings where each string is unique and read from
+	 * /sys/devices/system/cpu/cpuX/topology/package_cpus_list. From the ABI
+	 * each of these is a human-readable list of CPUs sharing the same
+	 * physical_package_id. The format is like 0-3, 8-11, 14,17.
+	 */
+	const char **package_cpus_list;
 	char	**die_siblings;
 	char	**thread_siblings;
 };
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 1c7414f66655..212512b9feb0 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -582,12 +582,12 @@ static int write_cpu_topology(struct feat_fd *ff,
 	if (!tp)
 		return -1;
 
-	ret = do_write(ff, &tp->core_sib, sizeof(tp->core_sib));
+	ret = do_write(ff, &tp->package_cpus_lists, sizeof(tp->package_cpus_lists));
 	if (ret < 0)
 		goto done;
 
-	for (i = 0; i < tp->core_sib; i++) {
-		ret = do_write_string(ff, tp->core_siblings[i]);
+	for (i = 0; i < tp->package_cpus_lists; i++) {
+		ret = do_write_string(ff, tp->package_cpus_list[i]);
 		if (ret < 0)
 			goto done;
 	}
-- 
2.34.0.rc0.344.g81b53c2807-goog

