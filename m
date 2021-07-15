Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9057AC12002
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 01:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AF52613D4
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 01:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbhGOBgs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Jul 2021 21:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhGOBgs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Jul 2021 21:36:48 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15FEC061760
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jul 2021 18:33:54 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id w3-20020ac80ec30000b029024e8c2383c1so3101768qti.5
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jul 2021 18:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8vnGhtmp+njtNtIuKwFZim7rfIp3lR+vOjiRHXUJKyQ=;
        b=FtVARWUY3U8/9Tw4oLPAphMR3pXqBM60v7dYlimahcB70OGTYW8bslo/9wNAXlFI46
         y22CdMWEZVZaw/xZpduxvuTcA9WTxKSwMCBvw6xh7vscbm3aZNrVpBOI6yk4DJqPMTSq
         8FsPf9s36iTloS5gBmOUBHtek2X1XFCx/mvCmGlpGeA6pcOnzeY03cU20vakLfX/FfYF
         iATRuajUrB2xiDkEo0OF7eDMjB9+Yh10SFXV87f/Yi02TkB8gWMU4AjV7siy7YcI7Js3
         +OdGfKfe4jC6GvJZ2GJREsSfVFXgNPNVm25oqdgLkyDYNBu3K93Ydza8w4f7IhYQga85
         ZyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8vnGhtmp+njtNtIuKwFZim7rfIp3lR+vOjiRHXUJKyQ=;
        b=V7Col6p4MBbv1rWuctxPCTv3ENrbxd9iNKIlHALmCLvVipqNd6Rxf99kYfnMlZnkHr
         vjefPeL2g9qicT3gtCWWefQV+xlXF4yTdXCRJy9rvyBXWISE1gNmKyR/qqu9dDf3PCvX
         SITXU8pShKAPqZl5aMLDrX6JpxPZNwi1VJI2mxuY8QRkMxl/Jle0DR/V6rR7kPsbr2W3
         lIOlz/a7xZ3rgUOIYa5YLjNpZPx+NMY16Wo4rQd/bdCZ8DlVdMy2KIkIADdsj33YlszY
         qY0MeCDYnkXKfl03oCGS5HxEu82ZVZn+rsdf+NSCh4rCpiamxn2v+xEbzVOsuG7RhfWJ
         KCEQ==
X-Gm-Message-State: AOAM530HCJy/sEp/Z/jyat9npZSMVb+u6R/GEWrywaTRx7R3jzzX+qye
        5CQJp2njDNp8r+c80RxP+Wcy6mP/RCR3
X-Google-Smtp-Source: ABdhPJxUUNr0W3XsmB5xISQcI8yr8AX+7mp+8KI4DxlCKSI8oq0R1FwhPnhrhA7lYo2TKDZ0wgkv/2OtvDyO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:c0a3:e3b0:6b14:de32])
 (user=irogers job=sendgmr) by 2002:a05:6214:13c8:: with SMTP id
 cg8mr1210074qvb.23.1626312833833; Wed, 14 Jul 2021 18:33:53 -0700 (PDT)
Date:   Wed, 14 Jul 2021 18:33:36 -0700
Message-Id: <20210715013343.2286699-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 0/7] Tidy perf Documentation build
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Perf's Documenation Makefile is based off git's, but some parts of it
were never completed. 'make info' also fails. These patches fix 'make
info' and do some related tidy up. Two missing files are added from git.

Ian Rogers (7):
  perf doc: Fix perfman.info build
  perf doc: Fix doc.dep
  perf doc: Remove references to user-manual
  perf doc: Add info pages to all target.
  perf doc: Remove cmd-list.perl references
  perf doc: Remove howto-index.sh related references.
  perf doc: Reorganize ARTICLES variables.

 tools/perf/Documentation/Makefile          | 74 +++-------------------
 tools/perf/Documentation/build-docdep.perl | 46 ++++++++++++++
 tools/perf/Documentation/cat-texi.perl     | 46 ++++++++++++++
 3 files changed, 100 insertions(+), 66 deletions(-)
 create mode 100755 tools/perf/Documentation/build-docdep.perl
 create mode 100755 tools/perf/Documentation/cat-texi.perl

-- 
2.32.0.402.g57bb445576-goog

