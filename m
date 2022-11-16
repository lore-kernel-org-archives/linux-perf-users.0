Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B48C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Nov 2022 07:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiKPHWR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Nov 2022 02:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiKPHWQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Nov 2022 02:22:16 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF7CA193
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Nov 2022 23:22:15 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-360b9418f64so154415397b3.7
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Nov 2022 23:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VVBCM8+4ewIYbqSIURDFLLj3mOBnhhjT5+m4tbboLyQ=;
        b=T2CTy0cXc+GbTTmMdiCb9Zgs01lpkfqGh1mujEL0GETIM00jpRJOTM9isl/57BYYpO
         am7/2xYPhQGL51IQmeSydcgTMgOaCbBe/iWEF/1QaNs4uMmDGOjEvr6tThLTBP3xiTiu
         qHPrsTyARDCHIwmhf8qzvhgHN23WAFC155FXfQcUEMwQV117ZtFFqH+O50YFhgh70Lma
         P1Jyk6OLy9hgpbPJwnr+QQng0IkyDGXVKgZgY8bk5ZQGLHQ6yXAPN9Ft9qPzLO7+v4EV
         GNSDYjSHCj6mSU/5ZwuQxW88YpPNfWX0MEcWIElm4vIJpR4TkovIKaI5bhMOUMYLpEAD
         QKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VVBCM8+4ewIYbqSIURDFLLj3mOBnhhjT5+m4tbboLyQ=;
        b=aP85z9rvjkIa7YQqIimoC1JxQ3RCi9V2vcySHBqnVyDU2zr1ZRMC+W962hZNnumMMA
         hmv6XWvnxh1lCHLgGBpTDbhBxc7uE5UlaXkbAovXHsRcgTSH1ikW1s7ZQGAV46a8wJfq
         TRGEF1ZWXi7Bo5qASqlg0Dwb3ol2UGkAPcsdzTgYRxoXJ3VPAh5IeZq1MQ2ZEZK8dy6o
         0hnfBIplVZMurpiEsfmnh/XGAEH+Apolz1f0mxi6i9NiD413uNOl/tPiUfpaJrEgBCgy
         V3Dq7+6HLrracl31c5+z9IP5uNuWaeZg8mOQ/gp/mm4F4ZM/E+/YVNLP4Vz1YFH6AOad
         OLCA==
X-Gm-Message-State: ANoB5pkPAOHxxAt0YkxEGf6vjkXAT5Q0A5vmqq6K2RrfsAmG8k43L96R
        BvJpPbwPwQzV9OtdEpmb8NvKfxSlbcIG
X-Google-Smtp-Source: AA0mqf4pIXOLejh00a4sx9JINJstuwQskCv32hgKgt29OuWehxer6qcT4BwlWPt2AFedMoyAfDHNiWoMQG9r
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bf0f:58f3:342e:c1ec])
 (user=irogers job=sendgmr) by 2002:a05:6902:10c4:b0:6ca:1f22:2bed with SMTP
 id w4-20020a05690210c400b006ca1f222bedmr19587576ybu.462.1668583335191; Tue,
 15 Nov 2022 23:22:15 -0800 (PST)
Date:   Tue, 15 Nov 2022 23:22:10 -0800
Message-Id: <20221116072211.2837834-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH 0/1] Fix perf tools/lib includes
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch replaces the last on kernel/git/acme/linux.git branch
perf/tools-libs-includes and fixes the race issue by using the prepare
dependency. pmu-events.c needs this dependency too, as the header
files it includes also include libperf - using perpare as a dependency
rather than $(LIBPERF) is more consistent with the rest of the makefile.

Ian Rogers (1):
  perf build: Use tools/lib headers from install path

 tools/perf/Makefile.config |  2 --
 tools/perf/Makefile.perf   | 14 +++++++++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.38.1.431.g37b22c650d-goog

