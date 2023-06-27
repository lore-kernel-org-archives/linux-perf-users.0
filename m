Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF1FEB64D9
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Jun 2023 18:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjF0SKp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 27 Jun 2023 14:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjF0SKo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 27 Jun 2023 14:10:44 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490A22D54
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jun 2023 11:10:42 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-666ecb24eb3so2291366b3a.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jun 2023 11:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687889441; x=1690481441;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2Xopb4bdl/ldlCNcPlk1SBW3U6rHNjvHDq0o2AtiFJI=;
        b=LdeB8wUNlVIVV2gUpS55NLo9+v10Wb9Y0ceqjwzkT1yVBKxdnlhfogJAz+yevuVglS
         p2qYBwVh+8EtpHmOCT/vL8Oi1vglidxQ8F07mByDY+YTsQn18CZ7JM0m792WbQGeEiPh
         +5eiou41/39HNI9eSkKwLKKP8IGe5gRDTjOu7COs0HebGo00V1OePY87Xe/fIW5GCPVv
         B0MPWAWG7lxqKViXNWxhlF6ydOEX0jNxAFqauCpLipTVbm5Nu7Dvi4WXaaRwYmFWFade
         7qaZ2xOogFo1gAzQeuXNuf7Qk00QnDArWjBqzcEAiH7Z2G1BoPO7OaX7Bp8xoSxssXjr
         6bsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889441; x=1690481441;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Xopb4bdl/ldlCNcPlk1SBW3U6rHNjvHDq0o2AtiFJI=;
        b=QZKL1jkCg7+pfRgxDs/EVm0oP9fVEJ/aIJWpLcZG/bASNQMsNUf3VskVd4PJrNJ0wM
         90wHlfEMXM29rAeoMky2oH6hMa408HZZ0/gMSuuof2iB6SoBkvcA19seXw6rT9g3VTQg
         vmDC6GAm5WcpUube27Rn1TKAFDo08wt6OIkmp+UygtOlBOFCsUATpsN1lgFhFWUhTX0h
         5ntwW+BXf6/CQaZ+tzSnV9exZpb5LGQlieiYXdMdLgOYDgyvDlEFppgu34c724xpda5d
         kwGL56ojG8n6ttO+VeW2nThtupMlBKXpOjg/twxsXpQEbHTJx1mWFY55moaZvii4i2mI
         s4WA==
X-Gm-Message-State: AC+VfDxuwzsm3lMUqRHz9MfYQU4Ekjuaz/PH8zX87+THzBAk3IfEP/pp
        C+T5r7qqZvQH1eULcGukvZgDzaqxe0ww
X-Google-Smtp-Source: ACHHUZ6mT7X33BJiMUALcShfZoreYBIp2S3yS1Fc11hkbkfbrYxBsrXZVfgvcRxWjNGVzhcAy+ARaJSHoftN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a518:9a69:cf62:b4d9])
 (user=irogers job=sendgmr) by 2002:a05:6a00:2d9d:b0:668:6eed:7c1f with SMTP
 id fb29-20020a056a002d9d00b006686eed7c1fmr7849031pfb.3.1687889441460; Tue, 27
 Jun 2023 11:10:41 -0700 (PDT)
Date:   Tue, 27 Jun 2023 11:10:17 -0700
Message-Id: <20230627181030.95608-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 00/13] parse-events clean up
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
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Remove some tokens the lexer never produces. Ensure abort paths set an
error. Previously scanning all PMUs meant bad events could fail with
an invalid token, detect this at the point parsing for a PMU fails and
add error strings. Try to be consistent in using YYNOMEM for memory
failures and YYABORT for bad input.

v2. Fix build error when building without libtraceevent.

Ian Rogers (13):
  perf parse-events: Remove unused PE_PMU_EVENT_FAKE token
  perf parse-events: Remove unused PE_KERNEL_PMU_EVENT token
  perf parse-events: Remove two unused tokens
  perf parse-events: Add more comments to parse_events_state
  perf parse-events: Avoid regrouped warning for wild card events
  perf parse-event: Add memory allocation test for name terms
  perf parse-events: Separate YYABORT and YYNOMEM cases
  perf parse-events: Move instances of YYABORT to YYNOMEM
  perf parse-events: Separate ENOMEM memory handling
  perf parse-events: Additional error reporting
  perf parse-events: Populate error column for BPF/tracepoint events
  perf parse-events: Improve location for add pmu
  perf parse-events: Remove ABORT_ON

 tools/perf/tests/bpf.c         |   2 +-
 tools/perf/util/parse-events.c |  98 +++++----
 tools/perf/util/parse-events.h |  20 +-
 tools/perf/util/parse-events.y | 351 +++++++++++++++++----------------
 4 files changed, 258 insertions(+), 213 deletions(-)

-- 
2.41.0.162.gfafddb0af9-goog

