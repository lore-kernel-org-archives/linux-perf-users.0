Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F284FC4320A
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 11:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F93610FF
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 11:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbhHILPz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 07:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbhHILPv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 07:15:51 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB31C0617A1
        for <linux-perf-users@vger.kernel.org>; Mon,  9 Aug 2021 04:15:31 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id lw7-20020a17090b1807b029017881cc80b7so7801732pjb.3
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Aug 2021 04:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u/h6y01vhaIboCmoU5QTv0ntWs0BLu7zaNEJjRy0DS4=;
        b=hkyAS0RhMsAa7LD1MUeZEUEA6CJRhXoRGGkq6d3F/54q7BhmZASfdVQkwasll/kw/F
         SOlyMLOFqZnh8DJsZGVsmPrQNJoy7r5Pn6+5mB7m8wBMq8/T5iw4lpJIXPriz+L/s3Ta
         CUMoKKCINcM90LBQz+WzRu0ZljJj6Kc68I9BhgoVQEJLyNaPTaYetVpHcANKcsXqPpOp
         aT0ZBXoKMZ9+ieE6wuiUHu7x9QLwSQ2MDDFyzhE+3nsBXnD2/KwhT06slkS/XlqVYk6m
         Rsb1U5aIIiDhb/3A58reek7T5dSubzZKW8upKdfCAJmV3FVf7LmaQvzRKlDW9cPjKM+b
         OHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u/h6y01vhaIboCmoU5QTv0ntWs0BLu7zaNEJjRy0DS4=;
        b=Rb+Jn+KdhtIVmS26l4SNBxEetHoMcMKCcux2YbU2KvnmYxXy6F7+JMGglmlSge8rv+
         45Q5y4PRETj15+FzqCNNx7mFmohaOWPzCqVrvZOtMF1+4S+b92sZQya3Ndv1FteOo8ML
         3uULJzozDtv2e0VFoEViVFFRGaS9E7APfO/nGVe+5WRX6f3JvP6iH8ggTDs4LBLlC2hP
         ahgcuCcUE1SXfdjrf6HJUhzUYqV39tq1Udoi/+MnuWYZPYSz7WCLio++CIWfuSjINTK4
         3kwoEGW+EDVQ7DUYtnZSQ9+6JuzWTRcku0seQt8M6SkW9Pt19WB3IpXpYWKf81v6lWaK
         7k7g==
X-Gm-Message-State: AOAM5329UE2H0t4QPrHkIgdMXD+lk40l+u/5ktQy8JnMBT6lMEZYPAOe
        B8zWKDUw0cBTrnE0NVzMAn0szw==
X-Google-Smtp-Source: ABdhPJzqhcGgIWjxWcNcl2NY9IEGS+ZexPGs38I6dKh/kL4UUSiskPXmu4C2WEkQ/2bALqJpxIqNBQ==
X-Received: by 2002:a63:fd51:: with SMTP id m17mr56716pgj.395.1628507731152;
        Mon, 09 Aug 2021 04:15:31 -0700 (PDT)
Received: from localhost ([210.0.159.74])
        by smtp.gmail.com with ESMTPSA id 81sm20460136pfv.185.2021.08.09.04.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 04:15:30 -0700 (PDT)
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
Subject: [PATCH v5 5/9] perf auxtrace: Use WRITE_ONCE() for updating aux_tail
Date:   Mon,  9 Aug 2021 19:14:03 +0800
Message-Id: <20210809111407.596077-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809111407.596077-1-leo.yan@linaro.org>
References: <20210809111407.596077-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Use WRITE_ONCE() for updating aux_tail, so can avoid unexpected memory
behaviour.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/perf/util/auxtrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index cc1c1b9cec9c..79227b8864cd 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -480,7 +480,7 @@ static inline void auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
 	/* Ensure all reads are done before we write the tail out */
 	smp_mb();
 #if BITS_PER_LONG == 64 || !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
-	pc->aux_tail = tail;
+	WRITE_ONCE(pc->aux_tail, tail);
 #else
 	do {
 		old_tail = __sync_val_compare_and_swap(&pc->aux_tail, 0, 0);
-- 
2.25.1

