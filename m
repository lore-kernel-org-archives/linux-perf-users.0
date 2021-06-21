Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADD3C4743C
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 23:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11A25611C1
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 23:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbhFUXq0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Jun 2021 19:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbhFUXqZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Jun 2021 19:46:25 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AF8C061574;
        Mon, 21 Jun 2021 16:44:09 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m41-20020a05600c3b29b02901dcd3733f24so539663wms.1;
        Mon, 21 Jun 2021 16:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jAYxfwL2gbszJ1pGS8fkm3E6mP1KQWQLQpDSzvMhqLk=;
        b=o4HHF9bdjK7U4X7Co9lURspMZ28HdE2/vnqAEN8yTSzs+k0m6VmkM21A4LTpHTgr0d
         XiLOWFU6WtnR9JDhInHNW2osapE2jWQ+nhjsY2H1rW7yqUfHAMt1I9TEwy4SB4CEgyN5
         IqNhNnTmBp1FlO6or89WcCNHUSFB4VEu0zpyuKyavRL2KzKLHnvZef0COrn0JNMxA96Q
         jxiPARod7xXh7maiAYXI+dmfN/+hU6VwnhhSk6s6MsGfo+Kn3KXPRRQEOcDGc9y1AsRL
         9fINnzDofdMrck5T4UEUV1zoC5XzHJgM4gF+7ILaZrl7QK/C1/f/aVLhVfiLr321pBVM
         dR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jAYxfwL2gbszJ1pGS8fkm3E6mP1KQWQLQpDSzvMhqLk=;
        b=Wbpvz50EMsyxw7vpdLUMr965XbUyCwB9BMUGhxh6HYaCye/6pgct6J7usPFV/oNmpK
         XGWqSqaYgpmmVNhs3hjNg9EGPoLS6MeYZbMm5gHvU+AWEZiaC8ehUCdcpGO/5LOlzr6N
         QsS47zzD6tITzsy4EZNjqQ1h9m/JObGFowJmqOJ07rDSAuFDwGwxyi2EWElqfCXEdvNV
         MZOj29xzM4nMvcdb7QoBXJ0Vp8iMZpfxzNvN2wy2F2mTJ2EZ19+JTiMc44dSw5vRmjm0
         cN+DUbPLOdQvs6r2R7M87fYfrUvc7ZPqxBi7FuEZNoo8C9qnR8k7wgm6vml82ixHh5hS
         ofDQ==
X-Gm-Message-State: AOAM533RIVblQSmoymvqedltu9YmlJ+w+YJdqOGsG3cQVvmnNBxAYgXC
        N7J+UYcUdd7cMfOqr6S3nh0=
X-Google-Smtp-Source: ABdhPJze+JaeQZTgXmvnJBhJua96s54CRKZkHHSf6UX+DdgCLvzNHq6F3aKIhCo1/xIJ2P4X/3krmA==
X-Received: by 2002:a05:600c:1c8e:: with SMTP id k14mr921191wms.61.1624319048304;
        Mon, 21 Jun 2021 16:44:08 -0700 (PDT)
Received: from honeypot.. ([151.29.45.200])
        by smtp.googlemail.com with ESMTPSA id n18sm473130wmq.41.2021.06.21.16.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 16:44:08 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] perf report: delete evlist when deleting session
Date:   Tue, 22 Jun 2021 01:43:17 +0200
Message-Id: <20210621234317.235545-2-rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210621234317.235545-1-rickyman7@gmail.com>
References: <20210621234317.235545-1-rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reports a memory leak related to session->evlist never being deleted.
The evlist member is not deleted in perf_session__delete, so it should be
deleted separately.
This patch adds the missing deletion in perf-report.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/builtin-report.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 36f9ccfeb38a..07d7693d44b8 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1618,6 +1618,7 @@ int cmd_report(int argc, const char **argv)
 
 	ret = __cmd_report(&report);
 	if (ret == K_SWITCH_INPUT_DATA || ret == K_RELOAD) {
+		evlist__delete(session->evlist);
 		perf_session__delete(session);
 		last_key = K_SWITCH_INPUT_DATA;
 		goto repeat;
@@ -1637,6 +1638,7 @@ int cmd_report(int argc, const char **argv)
 	}
 
 	zstd_fini(&(session->zstd_data));
+	evlist__delete(session->evlist);
 	perf_session__delete(session);
 	return ret;
 }
-- 
2.31.1

