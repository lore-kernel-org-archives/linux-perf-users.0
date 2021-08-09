Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F66C432BE
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 11:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1899E610E9
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 11:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbhHILQE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 07:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbhHILP5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 07:15:57 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDB0C061799
        for <linux-perf-users@vger.kernel.org>; Mon,  9 Aug 2021 04:15:37 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gz13-20020a17090b0ecdb0290178c0e0ce8bso852778pjb.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Aug 2021 04:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k/q65VvlktCRuMJPvsqheulen+ZLOVhxOqA8asKS2Cc=;
        b=fVmq/EPMOL/7lKcV6uCKPWZ+YzqR3pqSxh/Rt2iIvEuzEBmub6HE0LzU5PMzibr5VN
         gS2P96PsqMNbuuJets3nfhz/Bt2ObNqN1jZ8CGRN8wpJa8bS9WuE9qw9Kfkr+uwng5rb
         4lZCVZysvLI0UK0Uvclw71FuCVYgeSJ09+lQRZBXbJyY6byfrOqellL6s19LWEZOodXR
         ZXQH14xPHvdQjmlVIcV35bMW+Mu36IeZdun800kgxx3OQziUQD7rv4e8Lueci9bH5Yfz
         hbYtw9yIOyl8U8jJr3EA4NhpGGtN7Srk8+MvELUhwKr8f86FVV8XIRyGyqK6+0zgSrhf
         6oHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k/q65VvlktCRuMJPvsqheulen+ZLOVhxOqA8asKS2Cc=;
        b=g83izQiZ4Py0kUUBCjGksQ6RmtJ3LA5Ab/jI4ouLLr8rN3LcUCXaUCDgCiWVd9775j
         6s++p74eD2Zc8Tk4UvN7QeNLkem/64dTaa11p9gkf83umhppeu6qHhAiaLYBaGBw+CeG
         GIFIlURVEIj3dBRCLK0YkVpkPWePw5S604W+hJgD0EJuker/7KDfpX6W9UW/lFB2nCND
         NjdzCwpJA4FL4j63C9/JeOgRzSVduUBsw3ae8AoziYLb9X1apW5vhkshhelaxIUIsqsX
         VzDcU0GAmhpGLrvBN0j/96WvkWFXA2gIFgChKn4nGy9ER0ZkuuaXkYLpo8a2TeGlYgV2
         N2Fw==
X-Gm-Message-State: AOAM533/koTb6+EC6+aeD79gakpPZJhqBMFNTyepkq+QwHeltHnTDu3q
        CdGCexqDnw4tWaI+dh4YT6Zw7w==
X-Google-Smtp-Source: ABdhPJw9CpYqLuDyohPtrga+jIFqKboy0RuRhAA9uTFErlSpkoCPnVw5ioNaFEzaRJrjlx3HquqTqA==
X-Received: by 2002:a17:902:e04e:b029:12c:def4:56a3 with SMTP id x14-20020a170902e04eb029012cdef456a3mr19102486plx.76.1628507736998;
        Mon, 09 Aug 2021 04:15:36 -0700 (PDT)
Received: from localhost ([210.0.159.74])
        by smtp.gmail.com with ESMTPSA id r13sm22691227pgi.78.2021.08.09.04.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 04:15:36 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Song Liu <songliubraving@fb.com>, x86@kernel.org,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 7/9] perf auxtrace: Remove auxtrace_mmap__read_snapshot_head()
Date:   Mon,  9 Aug 2021 19:14:05 +0800
Message-Id: <20210809111407.596077-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809111407.596077-1-leo.yan@linaro.org>
References: <20210809111407.596077-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Since the function auxtrace_mmap__read_snapshot_head() is exactly same
with auxtrace_mmap__read_head(), whether the session is in snapshot mode
or not, it's unified to use function auxtrace_mmap__read_head() for
reading AUX buffer head.

And the function auxtrace_mmap__read_snapshot_head() is unused so this
patch removes it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/auxtrace.c | 13 +++++--------
 tools/perf/util/auxtrace.h | 10 ----------
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index cb19669d2a5b..2dcf3d12ba32 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1686,14 +1686,11 @@ static int __auxtrace_mmap__read(struct mmap *map,
 	union perf_event ev;
 	void *data1, *data2;
 
-	if (snapshot) {
-		head = auxtrace_mmap__read_snapshot_head(mm);
-		if (auxtrace_record__find_snapshot(itr, mm->idx, mm, data,
-						   &head, &old))
-			return -1;
-	} else {
-		head = auxtrace_mmap__read_head(mm);
-	}
+	head = auxtrace_mmap__read_head(mm);
+
+	if (snapshot &&
+	    auxtrace_record__find_snapshot(itr, mm->idx, mm, data, &head, &old))
+		return -1;
 
 	if (old == head)
 		return 0;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 4f9176368134..d68a5e80b217 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -440,16 +440,6 @@ struct auxtrace_cache;
 
 #ifdef HAVE_AUXTRACE_SUPPORT
 
-static inline u64 auxtrace_mmap__read_snapshot_head(struct auxtrace_mmap *mm)
-{
-	struct perf_event_mmap_page *pc = mm->userpg;
-	u64 head = READ_ONCE(pc->aux_head);
-
-	/* Ensure all reads are done after we read the head */
-	smp_rmb();
-	return head;
-}
-
 static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
 {
 	struct perf_event_mmap_page *pc = mm->userpg;
-- 
2.25.1

