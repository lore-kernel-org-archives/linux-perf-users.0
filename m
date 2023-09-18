Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2401BC46CA1
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Sep 2023 12:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241926AbjIRM16 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Sep 2023 08:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241999AbjIRM10 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Sep 2023 08:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC27619B
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Sep 2023 05:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695039963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=xHDYR+wGQEASAiKM2fgv+T4YO3Rxcm4SsNxf49p4pIw=;
        b=VdZ2zoaC/XScUoaWcq9PvyzNHPXv19KtL7g2KcDDOCCuSM5AExBU13wWg+G/9UkGaqnH31
        4TdyKimTVksXzBKe2C6xeOloGtzo+GwZ6Up5racC3N5cQITWy3/4rYmxoAPj3OflCZd63O
        gEW2q4y+S29oEI3nikK+gaskdcL3YAw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-J1MPjFXUOHuwsF474-w_5w-1; Mon, 18 Sep 2023 08:26:00 -0400
X-MC-Unique: J1MPjFXUOHuwsF474-w_5w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24AB2802E5A;
        Mon, 18 Sep 2023 12:26:00 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A777492B16;
        Mon, 18 Sep 2023 12:25:57 +0000 (UTC)
From:   Michael Petlan <mpetlan@redhat.com>
To:     linux-perf-users@vger.kernel.org, acme@redhat.com,
        ravi.bangoria@amd.com
Cc:     peterz@infradead.org, vmolnaro@redhat.com, irogers@google.com,
        kan.liang@linux.intel.com, maddy@linux.ibm.com,
        adrian.hunter@intel.com
Subject: [PATCH] perf test: Remove event_group test for events in multiple PMUs
Date:   Mon, 18 Sep 2023 14:25:52 +0200
Message-Id: <20230918122552.15217-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The test fails on various environments, since not all the combinations
of events in a group work. Based on fact, that perf contains code that
re-organizes events in groups (and also removes groups when it does not
make sense), I assume that there is no rule an arbitrary combination of
arbitrary events *should* be supported.

When an uncore event is grouped together with cycles and cs (a sw event):
    # perf stat -e '{uncore_cbox_0/clockticks/,cs,cycles}'
 >  WARNING: events were regrouped to match PMUs
 >  WARNING: grouped events cpus do not match.
 >  Events with CPUs not matching the leader will be removed from the group.
    anon group { uncore_cbox_0/clockticks/, cs }
    ^C
(the CPU used is Haswell (Intel, family 6, model 60)

The test uses perf_event_open() syscall and bypasses the algorithms
perf tool uses to prevent scheduling invalid groups.

Remove the test-case then.

Fixes: 9d9b22bedad1 ("perf test: Add event group test for events in multiple PMUs")

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/tests/Build          |   1 -
 tools/perf/tests/builtin-test.c |   1 -
 tools/perf/tests/event_groups.c | 136 --------------------------------
 tools/perf/tests/tests.h        |   1 -
 4 files changed, 139 deletions(-)
 delete mode 100644 tools/perf/tests/event_groups.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 63d5e6d5f165..4244837eb210 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -57,21 +57,20 @@ perf-y += genelf.o
 perf-y += api-io.o
 perf-y += demangle-java-test.o
 perf-y += demangle-ocaml-test.o
 perf-y += pfm.o
 perf-y += parse-metric.o
 perf-y += pe-file-parsing.o
 perf-y += expand-cgroup.o
 perf-y += perf-time-to-tsc.o
 perf-y += dlfilter-test.o
 perf-y += sigtrap.o
-perf-y += event_groups.o
 perf-y += symbols.o
 
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
 perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 endif
 
 CFLAGS_attr.o         += -DBINDIR="BUILD_STR($(bindir_SQ))" -DPYTHON="BUILD_STR($(PYTHON_WORD))"
 CFLAGS_python-use.o   += -DPYTHONPATH="BUILD_STR($(OUTPUT)python)" -DPYTHON="BUILD_STR($(PYTHON_WORD))"
 CFLAGS_dwarf-unwind.o += -fno-optimize-sibling-calls
 
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 0ad18cf6dd22..cab1f5c00c88 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -114,21 +114,20 @@ static struct test_suite *generic_tests[] = {
 	&suite__api_io,
 	&suite__maps__merge_in,
 	&suite__demangle_java,
 	&suite__demangle_ocaml,
 	&suite__parse_metric,
 	&suite__pe_file_parsing,
 	&suite__expand_cgroup_events,
 	&suite__perf_time_to_tsc,
 	&suite__dlfilter,
 	&suite__sigtrap,
-	&suite__event_groups,
 	&suite__symbols,
 	NULL,
 };
 
 static struct test_suite **tests[] = {
 	generic_tests,
 	arch_tests,
 };
 
 static struct test_workload *workloads[] = {
diff --git a/tools/perf/tests/event_groups.c b/tools/perf/tests/event_groups.c
deleted file mode 100644
index ccd9d8b2903f..000000000000
--- a/tools/perf/tests/event_groups.c
+++ /dev/null
@@ -1,136 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <string.h>
-#include <unistd.h>
-#include <stdio.h>
-#include "linux/perf_event.h"
-#include "tests.h"
-#include "debug.h"
-#include "pmu.h"
-#include "pmus.h"
-#include "header.h"
-#include "../perf-sys.h"
-
-/* hw: cycles, sw: context-switch, uncore: [arch dependent] */
-static int types[] = {0, 1, -1};
-static unsigned long configs[] = {0, 3, 0};
-
-#define NR_UNCORE_PMUS 5
-
-/* Uncore pmus that support more than 3 counters */
-static struct uncore_pmus {
-	const char *name;
-	__u64 config;
-} uncore_pmus[NR_UNCORE_PMUS] = {
-	{ "amd_l3", 0x0 },
-	{ "amd_df", 0x0 },
-	{ "uncore_imc_0", 0x1 },         /* Intel */
-	{ "core_imc", 0x318 },           /* PowerPC: core_imc/CPM_STCX_FIN/ */
-	{ "hv_24x7", 0x22000000003 },    /* PowerPC: hv_24x7/CPM_STCX_FIN/ */
-};
-
-static int event_open(int type, unsigned long config, int group_fd)
-{
-	struct perf_event_attr attr;
-
-	memset(&attr, 0, sizeof(struct perf_event_attr));
-	attr.type = type;
-	attr.size = sizeof(struct perf_event_attr);
-	attr.config = config;
-	/*
-	 * When creating an event group, typically the group leader is
-	 * initialized with disabled set to 1 and any child events are
-	 * initialized with disabled set to 0. Despite disabled being 0,
-	 * the child events will not start until the group leader is
-	 * enabled.
-	 */
-	attr.disabled = group_fd == -1 ? 1 : 0;
-
-	return sys_perf_event_open(&attr, -1, 0, group_fd, 0);
-}
-
-static int setup_uncore_event(void)
-{
-	struct perf_pmu *pmu = NULL;
-	int i, fd;
-
-	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
-		for (i = 0; i < NR_UNCORE_PMUS; i++) {
-			if (!strcmp(uncore_pmus[i].name, pmu->name)) {
-				pr_debug("Using %s for uncore pmu event\n", pmu->name);
-				types[2] = pmu->type;
-				configs[2] = uncore_pmus[i].config;
-				/*
-				 * Check if the chosen uncore pmu event can be
-				 * used in the test. For example, incase of accessing
-				 * hv_24x7 pmu counters, partition should have
-				 * additional permissions. If not, event open will
-				 * fail. So check if the event open succeeds
-				 * before proceeding.
-				 */
-				fd = event_open(types[2], configs[2], -1);
-				if (fd < 0)
-					return -1;
-				close(fd);
-				return 0;
-			}
-		}
-	}
-	return -1;
-}
-
-static int run_test(int i, int j, int k)
-{
-	int erroneous = ((((1 << i) | (1 << j) | (1 << k)) & 5) == 5);
-	int group_fd, sibling_fd1, sibling_fd2;
-
-	group_fd = event_open(types[i], configs[i], -1);
-	if (group_fd == -1)
-		return -1;
-
-	sibling_fd1 = event_open(types[j], configs[j], group_fd);
-	if (sibling_fd1 == -1) {
-		close(group_fd);
-		return erroneous ? 0 : -1;
-	}
-
-	sibling_fd2 = event_open(types[k], configs[k], group_fd);
-	if (sibling_fd2 == -1) {
-		close(sibling_fd1);
-		close(group_fd);
-		return erroneous ? 0 : -1;
-	}
-
-	close(sibling_fd2);
-	close(sibling_fd1);
-	close(group_fd);
-	return erroneous ? -1 : 0;
-}
-
-static int test__event_groups(struct test_suite *text __maybe_unused, int subtest __maybe_unused)
-{
-	int i, j, k;
-	int ret;
-	int r;
-
-	ret = setup_uncore_event();
-	if (ret || types[2] == -1)
-		return TEST_SKIP;
-
-	ret = TEST_OK;
-	for (i = 0; i < 3; i++) {
-		for (j = 0; j < 3; j++) {
-			for (k = 0; k < 3; k++) {
-				r = run_test(i, j, k);
-				if (r)
-					ret = TEST_FAIL;
-
-				pr_debug("0x%x 0x%lx, 0x%x 0x%lx, 0x%x 0x%lx: %s\n",
-					 types[i], configs[i], types[j], configs[j],
-					 types[k], configs[k], r ? "Fail" : "Pass");
-			}
-		}
-	}
-	return ret;
-}
-
-DEFINE_SUITE("Event groups", event_groups);
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index f33cfc3c19a4..d30a99d60ba5 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -136,21 +136,20 @@ DECLARE_SUITE(jit_write_elf);
 DECLARE_SUITE(api_io);
 DECLARE_SUITE(demangle_java);
 DECLARE_SUITE(demangle_ocaml);
 DECLARE_SUITE(pfm);
 DECLARE_SUITE(parse_metric);
 DECLARE_SUITE(pe_file_parsing);
 DECLARE_SUITE(expand_cgroup_events);
 DECLARE_SUITE(perf_time_to_tsc);
 DECLARE_SUITE(dlfilter);
 DECLARE_SUITE(sigtrap);
-DECLARE_SUITE(event_groups);
 DECLARE_SUITE(symbols);
 
 /*
  * PowerPC and S390 do not support creation of instruction breakpoints using the
  * perf_event interface.
  *
  * ARM requires explicit rounding down of the instruction pointer in Thumb mode,
  * and then requires the single-step to be handled explicitly in the overflow
  * handler to avoid stepping into the SIGIO handler and getting stuck on the
  * breakpointed instruction.
-- 
2.18.4

