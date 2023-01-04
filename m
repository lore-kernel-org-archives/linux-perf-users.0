Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7492C4332F
	for <linux-perf-users@archiver.kernel.org>; Wed,  4 Jan 2023 18:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbjADSXT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 4 Jan 2023 13:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbjADSXR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 4 Jan 2023 13:23:17 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789C71B1DD
        for <linux-perf-users@vger.kernel.org>; Wed,  4 Jan 2023 10:23:16 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id j1-20020aa78001000000b0057d28e11cb6so16163150pfi.11
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Jan 2023 10:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/6gSWZH/V4L9BXpFay4ZvL5sJpJpduz8JVO3laT9niY=;
        b=HVNO+DZbPX858fjsSZfcBnQtKwvK+sazRDKA3G8FPcsF/NcHqJmGDgsjqzoAkbfXCT
         BMsjZAWKxMAZiXB8r4f3xoWNCnMDaDo7mimAG+Mua3zBEk6NZecZ/S9ONhaGP1ltwUTG
         hpi+VrHfMzfHjd8PKvbVZJJBwgLnmWHyXVbbqWj50LoF1aPDB3yuhjhtGZ2trdbmHn30
         qvcGQFl98YyxU0gaDQ3YlZNSFg9UpJeGNgBZkFUq0Ki37LMJBLNmL2hG01zVa7mUzucX
         jn6f9dOUZ8EpZRn9V6hOv1ylol0BR4uoI3IK2xGQiIuYS6BAmbAfqleGdsJibYUGzI0C
         a0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/6gSWZH/V4L9BXpFay4ZvL5sJpJpduz8JVO3laT9niY=;
        b=5OScEk+jFg/RwcN/SnHmFzd+cqAH4kgfHUru0IY23r/Lt58jSYOTAYQhjREWKbeO5L
         abnHSNGxj8OD2WFaVkqPEPTV2PPAMk5D6hHYwnHIVeJJpv5v5IzHDog6wZ4ZrU/+gvry
         K/IPL1QPxSlzzvq62xv2G0z000lBH9j+zH5X8ov0qP0ZkBjoTC8EWfCI0m5PXA8TT3rC
         w1e38fbPHN8GnyyItiKKkShBoDMUiSCFv/Nnfy8sjJ04KyBA+AEQA1Bsh9kgeC1tgCPY
         BbZF0G+A/r62iHpLqh4t2ADxeB44bfgTXWMu52HQpinzfzlflHvQejpskB8t/3hFC/4y
         ReAw==
X-Gm-Message-State: AFqh2kqmbAv7PtuhWXaFt1SQQyEUpGOvylRlTJn/8JxBE0BqG62VM2KQ
        C6J1ckfqbapKacL9UNao4RG+w21D8h9/Xaaz7OAwJVVSbnrUllevBxkEtoFZBlhTmyEhxOSG2PO
        Cb8v7QeSz6i7XWagkqA4QAvlJGPTuTgouXpshMpTe8WvVf/p4eLQC7R6uBPs82avl7ChpuSW1F1
        yum+RKoho=
X-Google-Smtp-Source: AMrXdXuvros/MWUdVxz/GhSEPlyh4EujXXdYhnVNNFaI8S/EulfAVHXaNA+UWO7MqB3yl07M5DDVMfcYy7Dg/Nk=
X-Received: from jesussanp.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5f10])
 (user=jesussanp job=sendgmr) by 2002:a05:6a00:d4e:b0:581:a3e3:13fc with SMTP
 id n14-20020a056a000d4e00b00581a3e313fcmr1603877pfv.42.1672856595837; Wed, 04
 Jan 2023 10:23:15 -0800 (PST)
Date:   Wed,  4 Jan 2023 10:23:13 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230104182313.3164736-1-jesussanp@google.com>
Subject: [PATCH] perf: Add missing sys/types.h include
From:   Jesus Sanchez-Palencia <jesussanp@google.com>
To:     linux-perf-users@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        Jesus Sanchez-Palencia <jesussanp@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Not all libc implementations define ssize_t as part of stdio.h like
glibc does since the standard only requires this type to be defined by
unistd.h and sys/types.h. For this reason the perf build is currently
broken for toolchains based on uClibc, for instance.

Include sys/types.h explicitly to fix that. This is a follow up to
commit 378ef0f5d9d7 ("perf build: Use libtraceevent from the system").

Signed-off-by: Jesus Sanchez-Palencia <jesussanp@google.com>
---
 tools/perf/util/trace-event.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index add6c5d9531c..9b3cd79cca12 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -4,6 +4,7 @@
 
 #include <stdbool.h>
 #include <stdio.h>
+#include <sys/types.h>
 #include <linux/types.h>
 
 struct evlist;
-- 
2.39.0.314.g84b9a713c41-goog

