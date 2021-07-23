Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491FDC4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jul 2021 09:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F9E460EE2
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jul 2021 09:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbhGWIXY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jul 2021 04:23:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229771AbhGWIXY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jul 2021 04:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627031037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=071YMIsZLb6Id4EnNdDxwdb4wbXfO+C3Xyos6nFl9xs=;
        b=Orn8HlW09qcpT1f4CxJ40ygyIeOlCfCrONxfy/J8yIj8fGiwDkWCmtkM2PFP0bKUnB+zH2
        JSs0K23SBiZehGH5xzg38qlWDOoiqjg8FKkknNGULZ0DygcPb0S9F8i41oVEARxpa/TXXk
        EbCCPLuwOvDfM5p+9/WCrwJvpZ264Eo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-eJp8M1x0OpuBq_he-oweqQ-1; Fri, 23 Jul 2021 05:03:55 -0400
X-MC-Unique: eJp8M1x0OpuBq_he-oweqQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FA04101C8A0;
        Fri, 23 Jul 2021 09:03:55 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.36.110.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D96F960C81;
        Fri, 23 Jul 2021 09:03:53 +0000 (UTC)
From:   Michael Petlan <mpetlan@redhat.com>
To:     linux-perf-users@vger.kernel.org, jolsa@redhat.com
Cc:     acme@kernel.org
Subject: [PATCH] perf tests vmlinux-kallsyms: ignore hidden symbols
Date:   Fri, 23 Jul 2021 11:03:51 +0200
Message-Id: <20210723090351.6621-1-mpetlan@redhat.com>
In-Reply-To: <20210708122805.2832-1-mpetlan@redhat.com>
References: <20210708122805.2832-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Symbols containing particular prefixes are purposely hidden from kallsyms.
The prefixes are listed in scripts/kallsyms.c, using ignored_prefixes[]
string array. The perf test "vmlinux symtab matches kallsyms" fails in
case perf finds some of the hidden symbols in its machine image and can't
match them to kallsyms.

Let's add a filter to check if a symbol not found isn't one of these before
failing the test.

The ignored_prefixes[] array has been copied from scripts/kallsyms.c and
needs to be updated along with the original.

v2: Fixed formatting issues.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/tests/vmlinux-kallsyms.c | 42 +++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 193b7c91b4e2..fb9696bbf6f3 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -14,6 +14,42 @@
 
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
+	while (*prefix)
+		if (*prefix++ != *string++)
+			return 0;
+
+	return 1;
+}
+
+static int should_be_hidden(const char *sym_name)
+{
+	int i;
+
+	for (i = 0; ignored_prefixes[i] != NULL; i++)
+		if (has_prefix(ignored_prefixes[i], sym_name))
+			return 1;
+
+	return 0;
+}
+
 int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	int err = -1;
@@ -169,6 +205,12 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
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

