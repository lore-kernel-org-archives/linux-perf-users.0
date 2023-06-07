Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F199C7EE23
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jun 2023 05:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjFGFCA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Jun 2023 01:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjFGFB7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Jun 2023 01:01:59 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B529AE7E
        for <linux-perf-users@vger.kernel.org>; Tue,  6 Jun 2023 22:01:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-569ca440bf0so39821577b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Jun 2023 22:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686114118; x=1688706118;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QvFi009GvUhOjM1RbLEv9NwcPxaGqqvSNJxQoAxRjS0=;
        b=vW/A1GC/wbZqorAlFqZNL8iWKoE4whibGqUyFC0L6jPjX5lhAzhXMA/ADgJBVJ5bHI
         naRwZdeLS1N/D81KP5rkupydoYZgWclSYIJkRo1xvCO+gQ9e53tbA5Vld3nCc+QMngzl
         9nuZQ1xB+HA2jnO9W5Q7fPelFYUF/FXxuo9TZpuNuftN7S17Xfa2UBp9ZdIKvVvQyt3J
         xhMmhkS34U0+eWDie+q84TH03bhox6RH/MoSTv2647hm3o1weyNLncj6U8Yz0Dd4A6O5
         mw4cWOJGgAZMN3lqgySFBg4QqfFliZOKNWuiQVNZlOJnytkFRGATuzwdw43do24L5pmi
         9SYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686114118; x=1688706118;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QvFi009GvUhOjM1RbLEv9NwcPxaGqqvSNJxQoAxRjS0=;
        b=F6a93FbR/JPV1wZopIHUiRQwpAWD9U1RGb/YlUwPWp5XCSNM5EufVsWvARDKCy2YN/
         tPnpJtJIKfZ693wp/cSiwh6Ro1yuAaoOhUrDVk0vUVPWmpHs4YL5yy+Q+xIj5R7XniBh
         i5J7XgTUPFttcdMCZ+XHTlwH6r47D4fDsdFY3sFrcHuSvTRqL5zjG4Q9/eWoBmXBGSmZ
         G7Y18fNxq3DCAUwgmqLu9Va12xOb6mPuGIJAHu7QxsSiUp7VNMvxOGhty1A/qvhfGJej
         bkTEO0otH2dETaTmK7LoIRmOtjwz2KSgseZkY4pAmmZDVKhLqO5+wS0CYTrdSDErMKZL
         Oa7A==
X-Gm-Message-State: AC+VfDzC0I5h0Aayu5gTOFfzNKcC/CisnIuh91STlRT8eS7LCSsWvSP3
        waSdCncgEldK+/S4VNwGXDkQWA6rIhXq
X-Google-Smtp-Source: ACHHUZ6Vptuh7rpIg3guxouK2GwApLkfX1l+4RVrKhqAIHgtz2ACf15XrQZFJx/5uA/BI9L0MNH05zhSVqe2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3c35:209f:5d38:b7a1])
 (user=irogers job=sendgmr) by 2002:a81:ac08:0:b0:552:d924:a304 with SMTP id
 k8-20020a81ac08000000b00552d924a304mr2179004ywh.4.1686114117942; Tue, 06 Jun
 2023 22:01:57 -0700 (PDT)
Date:   Tue,  6 Jun 2023 22:01:45 -0700
Message-Id: <20230607050148.3248353-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 0/2] Fix leak sanitizer warnings in perf top
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andres Freund <andres@anarazel.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

With these two patches perf top/report/script will largely run without
leak sanitizer warnings.

Ian Rogers (2):
  perf annotate: Fix parse_objdump_line memory leak
  perf top: Add exit routine for main thread

 tools/perf/builtin-top.c   | 11 ++++++++++-
 tools/perf/util/annotate.c |  3 ++-
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.41.0.rc0.172.g3f132b7071-goog

