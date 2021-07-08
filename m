Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E47C07E96
	for <linux-perf-users@archiver.kernel.org>; Thu,  8 Jul 2021 12:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CEBD61396
	for <linux-perf-users@archiver.kernel.org>; Thu,  8 Jul 2021 12:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhGHMay (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 8 Jul 2021 08:30:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58280 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230451AbhGHMay (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 8 Jul 2021 08:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625747291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=M3pf7AINhA0/YUje0546FnNXtaiPCPJvZtZDuTcV52s=;
        b=XJlyaHhXaQDF0KujffkL4L0MhgORCFqLHqFZupwUV57sN7178djqb1zYsi0LPdFdvlqiUm
        uw/JoAPEvOPEFfGBcC8zYYlWygWEvGoc/73WJOQJFHkWvzZ+87wXh3MFLyM6GdNU8AF3E4
        bpHg+W6BX6JRc3jtS5Og+9weyslS1gk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-isRh_MHJOZq8LZsq1fyg4g-1; Thu, 08 Jul 2021 08:28:10 -0400
X-MC-Unique: isRh_MHJOZq8LZsq1fyg4g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B483D80006E;
        Thu,  8 Jul 2021 12:28:09 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.40.208.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 796B46267C;
        Thu,  8 Jul 2021 12:28:08 +0000 (UTC)
From:   Michael Petlan <mpetlan@redhat.com>
To:     linux-perf-users@vger.kernel.org, acme@kernel.org
Cc:     jolsa@redhat.com
Subject: [PATCH] perf tests vmlinux-kallsyms: ignore hidden symbols
Date:   Thu,  8 Jul 2021 14:28:05 +0200
Message-Id: <20210708122805.2832-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Symbols containing particular prefixes are purposely hidden from kallsyms.
The prefixes are listed in scripts/kallsyms.c, using ignored_prefixes[]
string array. The perf test "vmlinux symtab matches kallsyms" fails in case
perf finds some of the hidden symbols in its machine image and can't match
them to kallsyms.

Let's add a filter to check if a symbol not found isn't one of these before
failing the test.

The ignored_prefixes[] array has been copied from scripts/kallsyms.c and needs
to be updated along with the original.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/tests/vmlinux-kallsyms.c | 41 +++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 193b7c91b4e2..11cd276ec8fd 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -14,6 +14,41 @@
 
 #define UM(x) kallsyms_map->unmap_ip(kallsyms_map, (x))
 
+/* Symbol names that begin with the following are ignored. (a copy from scripts/kallsyms.c) */
+static const char * const ignored_prefixes[] = {
+	"$",			/* local symbols for ARM, MIPS, etc. */
+	".LASANPC",		/* s390 kasan local symbols */
+	"__crc_",		/* modversions */
+	"__efistub_",		/* arm64 EFI stub namespace */
+	"__kvm_nvhe_",		/* arm64 non-VHE KVM namespace */
+	"__AArch64ADRPThunk_",	/* arm64 lld */
+	"__ARMV5PILongThunk_",	/* arm lld */
+	"__ARMV7PILongThunk_",
+	"__ThumbV7PILongThunk_",
+	"__LA25Thunk_",		/* mips lld */
+	"__microLA25Thunk_",
+	NULL
+};
+
+static int has_prefix(const char *prefix, const char *string)
+{
+	while(*prefix)
+        if(*prefix++ != *string++)
+            return 0;
+
+	return 1;
+}
+
+static int should_be_hidden(const char *sym_name)
+{
+	int i;
+	for(i = 0; ignored_prefixes[i] != NULL; i++)
+		if(has_prefix(ignored_prefixes[i], sym_name))
+			return 1;
+
+	return 0;
+}
+
 int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	int err = -1;
@@ -169,6 +204,12 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 			 * such as __indirect_thunk_end.
 			 */
 			continue;
+		} else if (should_be_hidden(sym->name)) {
+			/*
+			 * Ignore hidden symbols, see scripts/kallsyms.c for the ignored_prefixes[]
+			 * array
+			 */
+			continue;
 		} else {
 			pr_debug("ERR : %#" PRIx64 ": %s not on kallsyms\n",
 				 mem_start, sym->name);
-- 
2.18.4

