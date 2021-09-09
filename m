Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3903AC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 19:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DC9260FE3
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 19:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245609AbhIITob (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 15:44:31 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:40488 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245548AbhIIToa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Sep 2021 15:44:30 -0400
X-Greylist: delayed 988 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Sep 2021 15:44:30 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kdmUsEMzgIoUcgyYPS7VbfsOKQD+k9dWiAFnqsbpUnI=; b=jZ2VsHL0UfhK2AOA1zPuCwPnA0
        ylEB6vyXcgdmXj32Q64A0yFbi5OSecLfKBu6mjX6qqjfc4+d8QiyRIk+/tGWjrIcC+SJcKEmRCQPv
        kgydvb22AU5+kCrdZNlnHqt//qnkYNeXbLOMbdNrMJisuMN7EIAhW3cYgI/H4Wsiyd+k=;
Received: from [10.69.139.14] (helo=fractal7.mn.codeweavers.com)
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rbernon@codeweavers.com>)
        id 1mOPhD-0003DM-Gx; Thu, 09 Sep 2021 14:26:51 -0500
From:   Remi Bernon <rbernon@codeweavers.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Remi Bernon <rbernon@codeweavers.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf symbol: Look for ImageBase in PE file to compute .text offset
Date:   Thu,  9 Sep 2021 21:26:36 +0200
Message-Id: <20210909192637.4139125-1-rbernon@codeweavers.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Instead of using the file offset in the debug file.

This fixes a regression from 00a3423492bc90be99e529a64f13fdd80a0e8c0a,
causing incorrect symbol resolution when debug file have been stripped
from non-debug sections (in which case its .text section is empty and
doesn't have any file position).

The debug files could also be created with a different file alignment,
and have different file positions from the mmap-ed binary, or have the
section reordered.

This instead looks for the file image base, using the corresponding bfd
*ABS* symbols. As PE symbols only have 4 bytes, it also needs to keep
.text section vma high bits.

Signed-off-by: Remi Bernon <rbernon@codeweavers.com>
---

Hi!

As I'm not updating it often I only recently realized that perf had a
regression when using stripped debug info files, and all symbols from
PE files are off. This should make things better.

Cheers,

 tools/perf/util/symbol.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 77fc46ca07c0..0fc9a5410739 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1581,10 +1581,6 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
 	if (bfd_get_flavour(abfd) == bfd_target_elf_flavour)
 		goto out_close;
 
-	section = bfd_get_section_by_name(abfd, ".text");
-	if (section)
-		dso->text_offset = section->vma - section->filepos;
-
 	symbols_size = bfd_get_symtab_upper_bound(abfd);
 	if (symbols_size == 0) {
 		bfd_close(abfd);
@@ -1602,6 +1598,22 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
 	if (symbols_count < 0)
 		goto out_free;
 
+	section = bfd_get_section_by_name(abfd, ".text");
+	if (section) {
+		for (i = 0; i < symbols_count; ++i) {
+			if (!strcmp(bfd_asymbol_name(symbols[i]), "__ImageBase") ||
+			    !strcmp(bfd_asymbol_name(symbols[i]), "__image_base__"))
+				break;
+		}
+		if (i < symbols_count) {
+			/* PE symbols can only have 4 bytes, so use .text high bits */
+			dso->text_offset = section->vma - (u32)section->vma;
+			dso->text_offset += (u32)bfd_asymbol_value(symbols[i]);
+		} else {
+			dso->text_offset = section->vma - section->filepos;
+		}
+	}
+
 	qsort(symbols, symbols_count, sizeof(asymbol *), bfd_symbols__cmpvalue);
 
 #ifdef bfd_get_section
-- 
2.33.0

