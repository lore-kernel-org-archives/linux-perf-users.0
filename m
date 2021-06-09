Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BCDC47095
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 09:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1B1761364
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 09:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhFIJlG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 9 Jun 2021 05:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbhFIJlF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Jun 2021 05:41:05 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75065C061574;
        Wed,  9 Jun 2021 02:39:10 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id v22so35672908lfa.3;
        Wed, 09 Jun 2021 02:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ax/9ZXRt8jPvIYR3WyaxKlwlCl8rJrmIFanUK71DGUE=;
        b=X6rHqBGHl0neiW6X0oPLScDJgrPJJxoVNt0mQZQD/n6vzMsztpKtvFvXsvclDWQqhA
         YX/+69Ug3H1YZPKEGSpGKWrWR3n5D1bLjxT3i0mxUORTTSRW0zfJxGb3N/78fOwD/T0W
         w/7eC2RkDceNFHsXTK9T1ZWXulnXo0UVMMpJMO1xGJhwDCRJWGTmZaMSFWvi41kz4oIR
         RhvtyJieIzlTYhiRhoPJEdY5+cDS+MM9YV00cXtxaYGeOfqLwLOPeEwQU2h+IAnENU8D
         gMDjR+bHNBi3ebpboRhwwJepH/OcW7H7uId8b1X+pVhT2AOFFEzIKCyrdVUF5/dt9kDz
         8PYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ax/9ZXRt8jPvIYR3WyaxKlwlCl8rJrmIFanUK71DGUE=;
        b=oMreUJjd/0aMG5XrNfL1mOn7VxNBD7Tj8w8IPMK0kjG8NxW/o1ZeaBecGlDjJDtaKh
         IroviAQIIp/J2ulbgZiUodaqfuoZioS/iuvnuzI5nFnP3eqSe/u5YV5H8D2x1Mhzrwgj
         AdCvTSk2g5rzykH57RYl986to9h6aygE9N9HyWHjcruqW/xY9h34whonD2RWCZQCKk/c
         G5Ma4PSgUQFEtfJc1GXocLyE+4mZ7c2bjEGzXiKPqdI6LdBawPlSMj95LcrmQmQ/nXeg
         XXYcKLt/4v47owFthMEn6O8Zw6NFd1yjKL6EX6D7F4cw+qzcf1GoDtPSRFRHSCKNCDe8
         qWEA==
X-Gm-Message-State: AOAM531HoL2pv3+e0y6AWULMy82YN8IemKUMxy+aCpSSyWfdXp8HuINk
        sY4vXh1+yFuiWNw+T94rCwY=
X-Google-Smtp-Source: ABdhPJxq76q3wkPsRmgyVfPQxNxN8WB5efZ3bLiF94qOWFlaMDpzUuoQ9CrK37wkwNym1brR2WjvWA==
X-Received: by 2002:ac2:5e64:: with SMTP id a4mr13295486lfr.657.1623231548744;
        Wed, 09 Jun 2021 02:39:08 -0700 (PDT)
Received: from localhost.localdomain ([94.103.224.40])
        by smtp.gmail.com with ESMTPSA id v19sm263341ljh.118.2021.06.09.02.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 02:39:08 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v2] perf: events: make perf_pmu_snapshot_aux static
Date:   Wed,  9 Jun 2021 12:37:50 +0300
Message-Id: <20210609093750.19198-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <YL+mziX+UU4MHQyZ@hirez.programming.kicks-ass.net>
References: <YL+mziX+UU4MHQyZ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Sparse says:
  warning: symbol 'perf_pmu_snapshot_aux' was not declared. Should it be static?

Since perf_pmu_snapshot_aux() is not used outside this file,
it can be made static

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---

Changes in v2:
	Changed subject line
	Fixed alignment of the arguments

---
 kernel/events/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6fee4a7e88d7..9ad01ff5692b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6667,10 +6667,10 @@ static unsigned long perf_prepare_sample_aux(struct perf_event *event,
 	return data->aux_size;
 }
 
-long perf_pmu_snapshot_aux(struct perf_buffer *rb,
-			   struct perf_event *event,
-			   struct perf_output_handle *handle,
-			   unsigned long size)
+static long perf_pmu_snapshot_aux(struct perf_buffer *rb,
+				  struct perf_event *event,
+				  struct perf_output_handle *handle,
+				  unsigned long size)
 {
 	unsigned long flags;
 	long ret;
-- 
2.31.1

