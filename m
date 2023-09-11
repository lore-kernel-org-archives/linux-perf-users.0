Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64437CA0ECF
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Sep 2023 21:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345333AbjIKV2K (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243341AbjIKRGT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 11 Sep 2023 13:06:19 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB82A123
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Sep 2023 10:06:14 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58d799aa369so55568937b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Sep 2023 10:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694451974; x=1695056774; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jM+dJg6+Q8M1FZ5UU9eubWWeg2o94iYO63nHk29mZE0=;
        b=cqu1njkytaLXL7/8cI1UInw/4EjXigL/8mJ9US1MNLyV/Vv+Ycg3aYCo/UQshw7LmX
         b8WTHsxZDHZw00N0HU4CAt8y+Kolf88o+0YXuuldfrxk9m+GpvZQQu5wchpoGXbYNB52
         GLH2OEoNQExO3S2n0A7M2vK7CWWVNic3LxDI2MqVIKrWYgGoQGJcZBAYAU7Q2WscVdjW
         Kl+V7+k+BWMLaIbgrLYUTqvIdoVnCa0qynoI/azz0JQsHf6QIeroiaRQwhYp0GqRYVd8
         N/JizA7dZm8Oe8K3kiLTqiTyYJqlqVDliue9m5ezeslTFoCpLHANsD/II5OhgfaqEzJg
         VH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694451974; x=1695056774;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jM+dJg6+Q8M1FZ5UU9eubWWeg2o94iYO63nHk29mZE0=;
        b=Dqnsflm2rWZA4Dj0eMkbkvFyp2tiN6BrsyXQLgaT4QYFe8iSRoOKMSzSMLWLcHmErB
         0HzLYfXZn+e5muP1UeQ3bsD2ANdNYzO5hGERhHwQP88TGmzDpIeYaE+xsDXbNQ6gZbCq
         hCNRlThhKw4LoF0bG1eiD9cSPDmLsjL6pSfdW7pGrSZXNP0qxwKZRKFvqFACSrBoCc+f
         mV3RuJnfiZ87l7gpFef3ibsgPrfTEbTP3Wpg8NrAJOMFd1+Yu0tomj5QGesFw4ZPIZZx
         /A8sDL2vKr4JbHWIB9v2lUD8jZIvZ3ONRV8goxGUXrzZCwhnwMSySRx7RQZz4lw2gi6H
         6XbA==
X-Gm-Message-State: AOJu0YxiITu2lI4AkdnYOo+LOeLtANoli9Gmm4caDGxEBHOpy7SfeANt
        EBSj4dU/GO90DKQ1I2Pq/3rSVjwuvXNl
X-Google-Smtp-Source: AGHT+IEf8EOkd7KXi4dLHtAwPVr8ZfIkJi8rUiMAIwb+DURWDmpuxRsLBlZRkx2NkJr+aWBkJOO0mSOsV17o
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6a92:55a:3ba0:c74b])
 (user=irogers job=sendgmr) by 2002:a81:eb12:0:b0:586:b332:8618 with SMTP id
 n18-20020a81eb12000000b00586b3328618mr263769ywm.7.1694451973822; Mon, 11 Sep
 2023 10:06:13 -0700 (PDT)
Date:   Mon, 11 Sep 2023 10:05:58 -0700
In-Reply-To: <20230911170559.4037734-1-irogers@google.com>
Message-Id: <20230911170559.4037734-4-irogers@google.com>
Mime-Version: 1.0
References: <20230911170559.4037734-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1 4/5] perf pmu: Add YYDEBUG
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
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

YYDEBUG enables line numbers and other error helpers in the generated
pmu-bison.c. Conditionally enabled only for debug builds.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.y | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/pmu.y b/tools/perf/util/pmu.y
index 600c8c158c8e..198907a8a48a 100644
--- a/tools/perf/util/pmu.y
+++ b/tools/perf/util/pmu.y
@@ -5,6 +5,10 @@
 
 %{
 
+#ifndef NDEBUG
+#define YYDEBUG 1
+#endif
+
 #include <linux/compiler.h>
 #include <linux/list.h>
 #include <linux/bitmap.h>
-- 
2.42.0.283.g2d96d420d3-goog

