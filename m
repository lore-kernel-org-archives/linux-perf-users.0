Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E14C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 03:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F60B60FC1
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 03:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhKLDyb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 22:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhKLDyb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 22:54:31 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337D3C061766
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Nov 2021 19:51:41 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id pg9-20020a17090b1e0900b001a689204b52so4068474pjb.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Nov 2021 19:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dZYNpRCmI52Lfxv1Kj3qct987pZvSTrOpR4mQ6ymhN8=;
        b=i4cNwQvus/YiDhCC0IHfXGa/XH/0Y8aRqnRNARp5wYC6gEoRAsfbCApJl6NZFokkWe
         5FGwevkhG6yYNvjl0duKyRom/0IGy7ViK5bBbGRhU+cjW3aUvDJljeCDxIDDfw8lWjk3
         dbL9rqA/Mfq862JdU9h67Zt6pkJxSIxUQvW6PQr51ffojmbkdUo1oOKMBYR46LLCooez
         SrxbNcw9Z45F/RHZLGI7McH954PM+X+NWFLiG7H5RDbbI5b96/XN9N6E6vPI0DWnZHoI
         a+ZWxtTOc1vAwfY+1JCYB4xqO4YJl5GTftIawP8AGxraZw/mUzYlZK0b4iGEbrG86Rti
         ssAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dZYNpRCmI52Lfxv1Kj3qct987pZvSTrOpR4mQ6ymhN8=;
        b=XTfT0Q02WrjrNAHVAcvdtKfZ5bOEH1jBIfti0zfuxwuj+UCe5qXi6HFJupxwwak5Yl
         nDEXqOPRTpQx3rRIYSfRw3NPdS+IdGiLl8PKiz/yWrK91XSu/PZZCVRKM/CaCs0NeUNe
         2VbX94glWsgBqGWzDs0mexe4mdJNyb6zHTAwaLxhW+OW48iTIrnt/OfO1ViNdwmoiaQO
         dTAuNM6xa7Y9cAMt9v06m1vcVMD2WeyDZUyXe8u/tNv4GLRbCbfMdbkUb5JXrZWBRgl/
         IAQMHI/RQl8I8EY7SahMAUplEYwYs3LJItqed7p8F6ebeJ/xa2NsCCze2upA2JMXWrRx
         Rjfw==
X-Gm-Message-State: AOAM533vZRgZju1e586nSkCPY6JrMuuU4t3s2snyub6yWEI+fVJey0qu
        Bzu/mkwxXSszS5JtYUjJrC4QBH1X+Q4+
X-Google-Smtp-Source: ABdhPJz+k3+zNqvB/iPXMR9Ncht2dhzxLGzJA6paC6lYLz7qyPX3/tUCCwv/Qwz2Cii71Hhwbj4dEICz7VYQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:5ce9:74ca:7ed9:75f2])
 (user=irogers job=sendgmr) by 2002:a63:2683:: with SMTP id
 m125mr7988050pgm.277.1636689100511; Thu, 11 Nov 2021 19:51:40 -0800 (PST)
Date:   Thu, 11 Nov 2021 19:51:22 -0800
Message-Id: <20211112035124.94327-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH 1/3] perf symbols: Add documentation to struct symbol.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Refactor some existing comments and then infer the rest.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 166196686f2e..3586fa549f44 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -40,22 +40,33 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
 			     GElf_Shdr *shp, const char *name, size_t *idx);
 #endif
 
-/** struct symbol - symtab entry
- *
- * @ignore - resolvable but tools ignore it (e.g. idle routines)
+/**
+ * A symtab entry. When allocated this may be preceded by an annotation (see
+ * symbol__annotation), a browser_index (see symbol__browser_index) and rb_node
+ * to sort by name (see struct symbol_name_rb_node).
  */
 struct symbol {
 	struct rb_node	rb_node;
+	/** Range of symbol [start, end). */
 	u64		start;
 	u64		end;
+	/** Length of the string name. */
 	u16		namelen;
+	/** ELF symbol type as defined for st_info. E.g STT_OBJECT or STT_FUNC. */
 	u8		type:4;
+	/** ELF binding type as defined for st_info. E.g. STB_WEAK or STB_GLOBAL. */
 	u8		binding:4;
+	/** Set true for kernel symbols of idle routines. */
 	u8		idle:1;
+	/** Resolvable but tools ignore it (e.g. idle routines). */
 	u8		ignore:1;
+	/** Symbol for an inlined function. */
 	u8		inlined:1;
+	/** Architecture specific. Unused except on PPC where it holds st_other. */
 	u8		arch_sym;
+	/** Has symbol__annotate2 been performed. */
 	bool		annotate2;
+	/** The name of length namelen associated with the symbol. */
 	char		name[];
 };
 
-- 
2.34.0.rc1.387.gb447b232ab-goog

