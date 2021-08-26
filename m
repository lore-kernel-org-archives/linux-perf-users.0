Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A347EC432BE
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Aug 2021 12:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A6426108E
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Aug 2021 12:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242514AbhHZMSu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 26 Aug 2021 08:18:50 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:54638
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242404AbhHZMSu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Aug 2021 08:18:50 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 16A633F365;
        Thu, 26 Aug 2021 12:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629980282;
        bh=nC9rYEkv0F53H38e4ipOB1oEOj6nDzS1DVLsnD7SHYQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=H+3E3u1DL6/VN1P0Dp/1JQUC3OZYe0iV69p8BL9025yE5VgTHtS/62rkAJDXfVRaH
         QRUJsd/KgX4BMfQzXYaG5MlAtLhGOSZ3il8zgAED3cgr8LrrspV0lkZzgf9vHdQuE4
         y4f88LJcoy62LeGoRIabdSqgjAd9U0qQpp59eJ70DKLPwNHEqVmXgc9zD2p27DS53Q
         t7ScFO/oild5kHQTVOoK6Z7zr0CAT2b1aR3wbKs2wqX91MkE5WOumHZ7W5ppfiMN5M
         tX/ti3wGpxvdUbzT5dHq+zjqdxxrWXe/6JD9ahJGXxeqL3c81W5y/i4XcMqExQjTLf
         TI6jC4ISxWNBw==
From:   Colin King <colin.king@canonical.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf header: Fix spelling mistake "cant'" -> "can't"
Date:   Thu, 26 Aug 2021 13:18:01 +0100
Message-Id: <20210826121801.13281-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a warning message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 563dec72adeb..9016541c55f9 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1284,7 +1284,7 @@ static int memory_node__read(struct memory_node *n, unsigned long idx)
 
 	dir = opendir(path);
 	if (!dir) {
-		pr_warning("failed: cant' open memory sysfs data\n");
+		pr_warning("failed: can't open memory sysfs data\n");
 		return -1;
 	}
 
-- 
2.32.0

