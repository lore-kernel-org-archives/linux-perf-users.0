Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F5EC7619A
	for <linux-perf-users@archiver.kernel.org>; Sat,  8 Apr 2023 05:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjDHFpO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 8 Apr 2023 01:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDHFpN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 8 Apr 2023 01:45:13 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5A0D529
        for <linux-perf-users@vger.kernel.org>; Fri,  7 Apr 2023 22:45:11 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-545dd1a1e31so390097907b3.22
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Apr 2023 22:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680932710;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VZ2958tzyXZgSxo3yLq2xDqV9+9KQu6EdMM+evnLIec=;
        b=d+n8wjIlMEeoa/yiyU1+HUgvOqFhiWMfxu/1qGtVldbbfOc4DHh7RLoppAN2r7w00W
         KNtnGqQf14FaGhR031ikN9YPZ9wLF5sqp1LskkSjohfvwrNzfyut+XxuCqcQZ6hNHzMu
         YKyHmw13fC9p5LjxoCOK4lHD2vBfjdjAplQBminW0vva1uk3BX4+1QTWLiTXqYPRfyBz
         +uXWjyX2sWF3w4VSkGol/qvZxHHq2g6Fh7uMYR2lHrPM/ha9cetjst+n6IuE+OL7BLGV
         fDVBnhOCEOufkZv+R8A6xxjN1MKXthEA43qpOF28nYem5yDV0oDs7fd7pEbqFqaz1Icx
         9jjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680932710;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VZ2958tzyXZgSxo3yLq2xDqV9+9KQu6EdMM+evnLIec=;
        b=fdxL88ZCi74TLvDMW8IOvk3uX2VyBbzL7KVv9ppBZQ46pzfzjuwv0pyiNdu3v4RJLM
         8cXah+vwQoTL3TMZiNnrhF03RLjuIyAomoZb3FmRN4muoSsf4Rs72KHbaNc5jAUvsXbD
         a+z7XY10j1mm4LS+9gCi0LTAPPUiVpJ+OWBbB+AJ2sIjG+j+YO/5/AZzZN0FDKf4dWmf
         wGtcfdOscku4FGMUy9OfXYAKuo7oPs++JQ1Wt1/feQcfen/gL2zkkXBxINj6aVM3TZ64
         KJws1+KSkbK2T2Drucn9aKInRI88zcHsgbv807bB6NIqA4NvP5Fnl/aOIlLa8F5QvJ37
         EMbg==
X-Gm-Message-State: AAQBX9d9RbqX9G+BdCXXXX4o7SDvnA9W9vQQsx+P8jQTIx45Gy88ERFt
        HjwJlPCgmHXXIw0SSJgzi2VMESo1/udJ
X-Google-Smtp-Source: AKy350ZcgkmwnjFXRr3kmG9nuQm6oPJxN3YLd8lZxLXaSZ0BV4q1A/C2X2XEdW/0lmvo/SUM7bNPOw26Nr/N
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b240:9cdf:7861:b23e])
 (user=irogers job=sendgmr) by 2002:a81:a783:0:b0:545:7143:2940 with SMTP id
 e125-20020a81a783000000b0054571432940mr2472904ywh.0.1680932710751; Fri, 07
 Apr 2023 22:45:10 -0700 (PDT)
Date:   Fri,  7 Apr 2023 22:44:53 -0700
Message-Id: <20230408054456.3001367-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v2 0/3] Write json and csv test output to test files
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
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Avoid problems where debug/warning messages would break output
formatting.

v2. move the XXX with mktemp to the end of the template as required.

Ian Rogers (3):
  perf test: Write CSV output to a file
  perf stat: Don't write "started on" for json output
  perf test: Write Json output to a file

 tools/perf/builtin-stat.c                     |  6 +-
 .../tests/shell/lib/perf_json_output_lint.py  |  3 +-
 tools/perf/tests/shell/stat+csv_output.sh     | 58 ++++++++++++++-----
 tools/perf/tests/shell/stat+json_output.sh    | 48 +++++++++++----
 4 files changed, 84 insertions(+), 31 deletions(-)

-- 
2.40.0.577.gac1e443424-goog

