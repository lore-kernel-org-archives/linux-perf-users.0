Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4395C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 30 Mar 2022 03:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242233AbiC3DNm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 29 Mar 2022 23:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242231AbiC3DNl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 29 Mar 2022 23:13:41 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E520939B3
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Mar 2022 20:11:56 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t13so15213368pgn.8
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Mar 2022 20:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qMOSf0Lj5bbF3ZRgfNaPEjG6ItHnHx3OB75c5QOmg9s=;
        b=gmmbgvz/cW0duS4+2ManRgp07CHjwIDzZAkfZkSByTyTV4ZR5a4sLVKXI3CEH5L/wM
         gQttFPLd8XszFetubrHrGP31zyWllQchTkZT5raVbgy/zCy1ziOKW8lVwaYeOIMp4KnN
         fki495+fbWg3RucKrC0ZWPDrMtZdhO9cu7nec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qMOSf0Lj5bbF3ZRgfNaPEjG6ItHnHx3OB75c5QOmg9s=;
        b=gdLTpmgJ7JzVHAHOJMKspwCHUDeEaMC6WMCnTZ3xOPrKqbLiMUt5ZfwuZTYgnWUbh9
         SBNtWNol+hlYFnoPcfoSo0mHhYRthCppfPb8bmzTNxUKY5tTvn+7B9QJfetlELBYy25f
         wIau+/6/y455QcnSMvsrK+7Y2BwHDPYlqb0StGvy9Y0+oMWuFXqnwqpmgPwgbk9a0oye
         +41+WFANpXTSlWPPbhWDJploCXzCnVkFaciEd3YCG3rKXcYEB3RnTvQyQwhwcFcbPz3B
         HGTZye49SdbgbdSLFmXMqhf8AzMW26Hsw7VsZpVH0/QUQOL92XzaE72qNrZ0fTNU2+uI
         8dFQ==
X-Gm-Message-State: AOAM533/BCeS6+hmPGES54eK52xR6cvJPraD26K2yPNGn3f/dXEIqmlS
        RBQ4fodjBw5TzWsNOndV6VLfHw==
X-Google-Smtp-Source: ABdhPJz9xnzAfx0+rKk+9VDqS11tKkwsDcLT9qPhMkpu77OhbGZKzElHD9vg6PRrOn+kozJBYZ7+Mg==
X-Received: by 2002:aa7:8256:0:b0:4e0:78ad:eb81 with SMTP id e22-20020aa78256000000b004e078adeb81mr31206513pfn.30.1648609915762;
        Tue, 29 Mar 2022 20:11:55 -0700 (PDT)
Received: from localhost ([2620:15c:2ce:200:e51b:b2e7:5cb6:c013])
        by smtp.gmail.com with UTF8SMTPSA id u62-20020a638541000000b00382791c89efsm17279743pgd.13.2022.03.29.20.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 20:11:55 -0700 (PDT)
From:   Denis Nikitin <denik@chromium.org>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org
Cc:     jolsa@kernel.org, alexey.budankov@linux.intel.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        james.clark@arm.com, linux-kernel@vger.kernel.org,
        Denis Nikitin <denik@chromium.org>
Subject: [PATCH] perf session: Remap buf if there is no space for event
Date:   Tue, 29 Mar 2022 20:11:30 -0700
Message-Id: <20220330031130.2152327-1-denik@chromium.org>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If a perf event doesn't fit into remaining buffer space return NULL to
remap buf and fetch the event again.
Keep the logic to error out on inadequate input from fuzzing.

This fixes perf failing on ChromeOS (with 32b userspace):

  $ perf report -v -i perf.data
  ...
  prefetch_event: head=0x1fffff8 event->header_size=0x30, mmap_size=0x2000000: fuzzed or compressed perf.data?
  Error:
  failed to process sample

Fixes: 57fc032ad643 ("perf session: Avoid infinite loop when seeing invalid header.size")
Signed-off-by: Denis Nikitin <denik@chromium.org>
---
 tools/perf/util/session.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 3b8dfe603e50..45a30040ec8d 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2095,6 +2095,7 @@ prefetch_event(char *buf, u64 head, size_t mmap_size,
 	       bool needs_swap, union perf_event *error)
 {
 	union perf_event *event;
+	u16 event_size;
 
 	/*
 	 * Ensure we have enough space remaining to read
@@ -2107,15 +2108,23 @@ prefetch_event(char *buf, u64 head, size_t mmap_size,
 	if (needs_swap)
 		perf_event_header__bswap(&event->header);
 
-	if (head + event->header.size <= mmap_size)
+	event_size = event->header.size;
+	if (head + event_size <= mmap_size)
 		return event;
 
 	/* We're not fetching the event so swap back again */
 	if (needs_swap)
 		perf_event_header__bswap(&event->header);
 
-	pr_debug("%s: head=%#" PRIx64 " event->header_size=%#x, mmap_size=%#zx:"
-		 " fuzzed or compressed perf.data?\n",__func__, head, event->header.size, mmap_size);
+	/* Check if the event fits into the next mmapped buf. */
+	if (event_size <= mmap_size - head % page_size) {
+		/* Remap buf and fetch again. */
+		return NULL;
+	}
+
+	/* Invalid input. Event size should never exceed mmap_size. */
+	pr_debug("%s: head=%#" PRIx64 " event->header.size=%#x, mmap_size=%#zx:"
+		 " fuzzed or compressed perf.data?\n", __func__, head, event_size, mmap_size);
 
 	return error;
 }
-- 
2.35.1.1021.g381101b075-goog

