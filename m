Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1799C83F2E
	for <linux-perf-users@archiver.kernel.org>; Thu, 31 Aug 2023 07:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbjHaHOu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 31 Aug 2023 03:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjHaHOr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 31 Aug 2023 03:14:47 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA27E1A4
        for <linux-perf-users@vger.kernel.org>; Thu, 31 Aug 2023 00:14:44 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59263889eacso8184827b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 31 Aug 2023 00:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693466084; x=1694070884; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nr41kDdDeJzQNFW3nz+BwVQXTEOQ7IBxm5AfGxJhvdk=;
        b=CDp1t5ekzB1vlkslgmD1Uk/jcoVrl3+7g5PSXl4YozmAl5uDxHIAY9MS+ISesQ3+hc
         iayCQHlsCEVNC4K5sV47w1YI5OBrwhzYmSdPp0QjdFOSonULeV0BNcZmVzX579f7y8sS
         BOYazvFmkN5p1HPfXTFUMUChn/wnAa4a2MYbq8E1HQdLmOSs0FU07nlne0o1Mlv6Wts3
         6+JeDOIjM9UhX6KK1T1GHFLhKQisvuFHD6rHohmuvzFscwP+TAAWXa1LwnTk0Miy+6gO
         gGl1R0kFtswnMEOiC+DMPsJykOOZOFOnc3j7vkxCnxGBPhW16R8o1nqs4Gx9IAr1FLSY
         YsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693466084; x=1694070884;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nr41kDdDeJzQNFW3nz+BwVQXTEOQ7IBxm5AfGxJhvdk=;
        b=bth2Vrh+RO8jlbJPMvUKv5e6yK8l3q8UANNw8Bo4StF+Z8g1tukN2bQChOfhxftDmh
         38KKSNap2wdv3geYW2j1SEXbj4Tv+lA66UP3H6YfQ3sFv2lotatXUezsNK6jfkR77sRt
         KrTQ89WP2bc/vkcFA94ySNkd/aMne3FKLJzkDJnkzYv3WfvXm0Tu2jjE6LmYUu8NTN6O
         X9DDWms/vtkkMijsyn+HS2PDns7piprufytObmfH0V9lbvnxydGorepvpG9xvf0eUgWQ
         6RWJ2fp/lEdAL/DEpkQtBvvD+y3Lr4lwyc3hhdMQLxjItY573ZsJ7w0pbM43z1BBQs52
         2MNA==
X-Gm-Message-State: AOJu0YwFtxrEtgEFD8ligK7LWtOYZ5JJMpN9XZmYH7ns6JijGLYdQAE6
        w7CkAZS914n9qzvR6536DYLe93bG1hB6
X-Google-Smtp-Source: AGHT+IF5RuXo9qTB0bgfsrdHCQZZY+zjteXaXkJaflVMOpRzb34MoLKDR2Dz6HXv+Z6xBHIZ0Y+uYEedugR0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:feef:cd5e:6353:57f0])
 (user=irogers job=sendgmr) by 2002:a81:af07:0:b0:56d:647:664b with SMTP id
 n7-20020a81af07000000b0056d0647664bmr125753ywh.5.1693466083950; Thu, 31 Aug
 2023 00:14:43 -0700 (PDT)
Date:   Thu, 31 Aug 2023 00:14:19 -0700
In-Reply-To: <20230831071421.2201358-1-irogers@google.com>
Message-Id: <20230831071421.2201358-2-irogers@google.com>
Mime-Version: 1.0
References: <20230831071421.2201358-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v1 1/3] perf list: Don't print Unit for default_core
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
        Rob Herring <robh@kernel.org>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

default_core was added as a way to demark json events whose PMU should
be whatever the default core PMU is, previously this had been assumed
to be "cpu" but that fails on s390 and ARM. perf list displays the PMU
in the event description to save storing it in json, but was still
comparing against "cpu" and not "default_core", so update this.

Fixes: d2045f87154b ("perf jevents: Use "default_core" for events with no Unit")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 1ac47db4d66a..a343823c8ddf 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -148,7 +148,7 @@ static void default_print_event(void *ps, const char *pmu_name, const char *topi
 		char *desc_with_unit = NULL;
 		int desc_len = -1;
 
-		if (pmu_name && strcmp(pmu_name, "cpu")) {
+		if (pmu_name && strcmp(pmu_name, "default_core")) {
 			desc_len = strlen(desc);
 			desc_len = asprintf(&desc_with_unit,
 					    desc[desc_len - 1] != '.'
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

