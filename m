Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F39C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 15:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9069E61181
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 15:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbhIVP2n (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 11:28:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23312 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232318AbhIVP2n (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 11:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632324433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=ENj3oJSjYPyEonU+jbY+dIDbTZ0CqB0nd+EJMpZI1gs=;
        b=gX5YreRq/Il4vVkSufHYw41bQfJy8eaoWAu3b2dtGIkQ2QoFzQKCL0H5oX1j5kCmuGkAIk
        zASdaGmfckG6H3ozlU4WC0p/Yzv78kfn+dxgizRTEh8vGwC5U6Piu+kmWXebgYlap+7P0o
        QPz/FtCRA/jMkFhDVpcr/SiyhvRr69o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-zFAM5vFgN-OU-LWngXhkZg-1; Wed, 22 Sep 2021 11:27:11 -0400
X-MC-Unique: zFAM5vFgN-OU-LWngXhkZg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9410F1023F61;
        Wed, 22 Sep 2021 15:27:10 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23721970E3;
        Wed, 22 Sep 2021 15:27:08 +0000 (UTC)
From:   Michael Petlan <mpetlan@redhat.com>
To:     linux-perf-users@vger.kernel.org, acme@kernel.org
Cc:     jolsa@kernel.org
Subject: [PATCH] perf tests vmlinux-kallsyms: ignore hidden symbols
Date:   Wed, 22 Sep 2021 17:27:06 +0200
Message-Id: <20210922152706.23655-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Certain kernel symbols are purposely hidden from kallsyms. The function
is_ignored_symbol() from scripts/kallsyms.c decides if a symbol should
be hidden or not.

The perf test "vmlinux symtab matches kallsyms" fails in case perf finds
some of the hidden symbols in its machine image and can't match them to
kallsyms.

Let's add a filter to check if a symbol not found isn't one of these
before failing the test.

The function is_ignored_symbol() has been copied from scripts/kallsyms.c
and needs to be updated along with the original.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/tests/vmlinux-kallsyms.c | 102 ++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 193b7c91b4e2..4f884aabc7f4 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -3,6 +3,7 @@
 #include <linux/rbtree.h>
 #include <inttypes.h>
 #include <string.h>
+#include <ctype.h>
 #include <stdlib.h>
 #include "dso.h"
 #include "map.h"
@@ -14,6 +15,102 @@
 
 #define UM(x) kallsyms_map->unmap_ip(kallsyms_map, (x))
 
+static bool is_ignored_symbol(const char *name, char type)
+{
+	/* Symbol names that exactly match to the following are ignored.*/
+	static const char * const ignored_symbols[] = {
+		/*
+		 * Symbols which vary between passes. Passes 1 and 2 must have
+		 * identical symbol lists. The kallsyms_* symbols below are
+		 * only added after pass 1, they would be included in pass 2
+		 * when --all-symbols is specified so exclude them to get a
+		 * stable symbol list.
+		 */
+		"kallsyms_addresses",
+		"kallsyms_offsets",
+		"kallsyms_relative_base",
+		"kallsyms_num_syms",
+		"kallsyms_names",
+		"kallsyms_markers",
+		"kallsyms_token_table",
+		"kallsyms_token_index",
+		/* Exclude linker generated symbols which vary between passes */
+		"_SDA_BASE_",		/* ppc */
+		"_SDA2_BASE_",		/* ppc */
+		NULL
+	};
+
+	/* Symbol names that begin with the following are ignored.*/
+	static const char * const ignored_prefixes[] = {
+		"$",			/* local symbols for ARM, MIPS, etc. */
+		".LASANPC",		/* s390 kasan local symbols */
+		"__crc_",		/* modversions */
+		"__efistub_",		/* arm64 EFI stub namespace */
+		"__kvm_nvhe_",		/* arm64 non-VHE KVM namespace */
+		"__AArch64ADRPThunk_",	/* arm64 lld */
+		"__ARMV5PILongThunk_",	/* arm lld */
+		"__ARMV7PILongThunk_",
+		"__ThumbV7PILongThunk_",
+		"__LA25Thunk_",		/* mips lld */
+		"__microLA25Thunk_",
+		NULL
+	};
+
+	/* Symbol names that end with the following are ignored.*/
+	static const char * const ignored_suffixes[] = {
+		"_from_arm",		/* arm */
+		"_from_thumb",		/* arm */
+		"_veneer",		/* arm */
+		NULL
+	};
+
+	/* Symbol names that contain the following are ignored.*/
+	static const char * const ignored_matches[] = {
+		".long_branch.",	/* ppc stub */
+		".plt_branch.",		/* ppc stub */
+		NULL
+	};
+
+	const char * const *p;
+
+	for (p = ignored_symbols; *p; p++)
+		if (!strcmp(name, *p))
+			return true;
+
+	for (p = ignored_prefixes; *p; p++)
+		if (!strncmp(name, *p, strlen(*p)))
+			return true;
+
+	for (p = ignored_suffixes; *p; p++) {
+		int l = strlen(name) - strlen(*p);
+
+		if (l >= 0 && !strcmp(name + l, *p))
+			return true;
+	}
+
+	for (p = ignored_matches; *p; p++) {
+		if (strstr(name, *p))
+			return true;
+	}
+
+	if (type == 'U' || type == 'u')
+		return true;
+	/* exclude debugging symbols */
+	if (type == 'N' || type == 'n')
+		return true;
+
+	if (toupper(type) == 'A') {
+		/* Keep these useful absolute symbols */
+		if (strcmp(name, "__kernel_syscall_via_break") &&
+		    strcmp(name, "__kernel_syscall_via_epc") &&
+		    strcmp(name, "__kernel_sigtramp") &&
+		    strcmp(name, "__gp"))
+			return true;
+	}
+
+	return false;
+}
+
 int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	int err = -1;
@@ -169,6 +266,11 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 			 * such as __indirect_thunk_end.
 			 */
 			continue;
+		} else if (is_ignored_symbol(sym->name, sym->type)) {
+			/*
+			 * Ignore hidden symbols, see scripts/kallsyms.c for the details
+			 */
+			continue;
 		} else {
 			pr_debug("ERR : %#" PRIx64 ": %s not on kallsyms\n",
 				 mem_start, sym->name);
-- 
2.18.4

