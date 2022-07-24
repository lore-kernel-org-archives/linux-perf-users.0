Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F65C433EF
	for <linux-perf-users@archiver.kernel.org>; Sun, 24 Jul 2022 06:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiGXGA3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 24 Jul 2022 02:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbiGXGA0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 24 Jul 2022 02:00:26 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F23813D24
        for <linux-perf-users@vger.kernel.org>; Sat, 23 Jul 2022 23:00:25 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id o12so7730157pfp.5
        for <linux-perf-users@vger.kernel.org>; Sat, 23 Jul 2022 23:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FMzC+sDhG88M55FlEFZSmk/W9b9O2exUBS8ELGOOwbI=;
        b=m/CAQYimVf1if5/iN4j9OObyDuMH02KfXenpyEwJjaW/lwMNZmKCs8evsbtZ9AX+TC
         L3KNZhY8r3CLJZKy5c37I5yolFlAoyk+rOJxMiGYkBQsIBIpqpyANun4ZQx5h9KEEsnn
         Fr+npRsNApUDXb0qggA5WMENw7wu98vXtuJeaxeSOPICFQqK2XUvBuzQhB3yW5VLFRKr
         my3AdB5llTwkb9N1WZvHxJMohJH9BuT5fADdt0H5E/e1OzqWFnqeVXYkle7njap7Zgzk
         KH1P7VmKu4IT+SH8uS46pyZ1ynL8gRkU4refwxiK4YxSSb9kLXghSDm2LZzoAgJ8O5ZF
         /mkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FMzC+sDhG88M55FlEFZSmk/W9b9O2exUBS8ELGOOwbI=;
        b=l3UCJE45rjffqcgzPsjwmFzBYOMIM0Z+c2tDyBUzZ+0sC8TTxinGwaXuTHrH93/xXa
         dcX0bzFA52nnhE8yqVkTbuWhTYr8b4usy8h2ncYTKaKNUu9KhyVZtGztI29ppguIvckV
         /6QFt0M04mRzF8spxAbnQqa1ELnc3XV0Ie19iE+doKsVf1BNIm2JzXsM4Wpni4XoB4Y7
         Csr3Qid04xyc2UJzV1nAT8lqYu5SsBmRJrg72Ijt9kSxbV5wbeUeqlEaQ+7F7iR/nwMs
         75FykLJYTIpudtm2j5hQPc3QSUcbFf9EsVu7n6OXavmrbNX+K54oEOW9So+U4bayO9I5
         EPYQ==
X-Gm-Message-State: AJIora9q6FdMlnS+wRipLw0B+M/9ELoR/0xbZSKbcx2a8qc4GViFm/aB
        j8lC6aY3schnrhIrSe1goOyy3g==
X-Google-Smtp-Source: AGRyM1vSGNkgQlC2X3AoZH/uNyq5YoxHZ3t0nHFE2VEEN5tnzhscAqsZxYjM8wF+NauGxaNj9nqNGw==
X-Received: by 2002:a62:4e04:0:b0:52b:30f5:59b8 with SMTP id c4-20020a624e04000000b0052b30f559b8mr7253962pfb.37.1658642425112;
        Sat, 23 Jul 2022 23:00:25 -0700 (PDT)
Received: from localhost (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id in2-20020a17090b438200b001ec85441515sm6308961pjb.24.2022.07.23.23.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 23:00:24 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Fangrui Song <maskray@google.com>,
        Chang Rui <changruinj@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 2/2] perf symbol: Skip symbols if SHF_ALLOC flag is not set
Date:   Sun, 24 Jul 2022 14:00:13 +0800
Message-Id: <20220724060013.171050-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220724060013.171050-1-leo.yan@linaro.org>
References: <20220724060013.171050-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Some symbols are observed the 'st_value' field are zeros.  E.g.
libc.so.6 in Ubuntu contains a symbol '__evoke_link_warning_getwd' which
resides in the '.gnu.warning.getwd' section.

Unlike normal sections, such kind of sections are used for linker
warning when a file calls deprecated functions, but they are not part of
memory images, the symbols in these sections should be dropped.

This patch checks the section attribute SHF_ALLOC bit, if the bit is not
set, it skips symbols to avoid spurious ones.

Suggested-by: Fangrui Song <maskray@google.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/symbol-elf.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index ef6ced5c5746..b3be5b1d9dbb 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1255,6 +1255,17 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 
 		gelf_getshdr(sec, &shdr);
 
+		/*
+		 * If the attribute bit SHF_ALLOC is not set, the section
+		 * doesn't occupy memory during process execution.
+		 * E.g. ".gnu.warning.*" section is used by linker to generate
+		 * warnings when calling deprecated functions, the symbols in
+		 * the section aren't loaded to memory during process execution,
+		 * so skip them.
+		 */
+		if (!(shdr.sh_flags & SHF_ALLOC))
+			continue;
+
 		secstrs = secstrs_sym;
 
 		/*
-- 
2.25.1

