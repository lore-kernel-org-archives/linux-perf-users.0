Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B50C761A6
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Apr 2023 17:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbjDDRMO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 4 Apr 2023 13:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbjDDRMK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 Apr 2023 13:12:10 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DD31997
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Apr 2023 10:12:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5419fb7d6c7so328825567b3.11
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Apr 2023 10:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680628328;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LWHvqfz3YxeQD1v/uiV9mdq3g7C5VbDQGJaMWdPaOZs=;
        b=oacv3eLXntq2o9FAHTXIUdSQXy9nkSZPlH4bBsV9G3bDIWS0RQAJn3tk4AWK6DO8mQ
         nWKF4bv1x3kumGkQofYnnAh9nr2Y1KhtHkbjQSzVMlygiy8H7vPJ0Uq3cHbgEsJ8iT1G
         iMStsLk8hmuUZCtmGPT3CxG1w5p1QIEFA68llHTXGt/lMG8XVaw5qNc5gDFYzFEIFeR8
         C+XfmVqM6rp+IlQPxePQo50KXcqAQu7VcoF+ewC9q0gApZRpa/ruFz3cpA35JhHS9o2w
         mu2xn9Nto0VL8PZCd4laW+5xF4BSiRNTdompzMd2cXKj0HE2boqQ9PfaCW0WYyjVd76p
         Ahzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628328;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LWHvqfz3YxeQD1v/uiV9mdq3g7C5VbDQGJaMWdPaOZs=;
        b=g8BDxGvA9bxC1QFXS123QBlDrb/pG+xV2r2LPZDRqOixIHMJX9Fh572y3fJ523YFQT
         KydZdFH5tm+AfXuxCAYqgsxhvQr4Ru0AnJaDsEstTzXtjXVzhLI5g3bgIJLZGksCc3FO
         +qGe6qBdqKQBtrmKvtW4YTTdlIGeOIfcNuKA0N1ZxNQPUYwwp3hh190uNRwxVxtsVLSN
         oqEjT26M4MTgo4F2Sypsb4N3+RWKGbVoS/J7XDtap2IZJa/pBqU9FqXj8rJ26KCqnyHi
         I83fLstE/Cb0P/O7XecnCsqRp8KOxS7c7tTQLd1PRBP7MbsITbL1yONin3vOJFsdGqjS
         s+IA==
X-Gm-Message-State: AAQBX9cBjbJPXQ2z30+yaOxbMDku4GfHfvBxdUXfyvzKCoXf0UzO0AHy
        cKo6WcpyAWC4TWlDxajB+IbPW/LXsnM6
X-Google-Smtp-Source: AKy350Y5GIsO5mGo3nCyF5ZvP0v3U+gNaSAzd6ZQYqJOP/FQmckIs+Y0gIRss/lREdXMVm4t9PSpKkO9UAbo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a051:e074:d6f:dc29])
 (user=irogers job=sendgmr) by 2002:a25:d257:0:b0:b33:531b:3dd4 with SMTP id
 j84-20020a25d257000000b00b33531b3dd4mr2000273ybg.1.1680628328585; Tue, 04 Apr
 2023 10:12:08 -0700 (PDT)
Date:   Tue,  4 Apr 2023 10:11:45 -0700
In-Reply-To: <20230404171146.2018616-1-irogers@google.com>
Message-Id: <20230404171146.2018616-2-irogers@google.com>
Mime-Version: 1.0
References: <20230404171146.2018616-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 2/3] perf stat: Don't write "started on" for json output
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
        Claire Jensen <cjense@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Json files don't support comments. Disable the "started on" comment
when writing json output to file.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7ef565ae7265..330f00497e6e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2272,8 +2272,10 @@ int cmd_stat(int argc, const char **argv)
 			perror("failed to create output file");
 			return -1;
 		}
-		clock_gettime(CLOCK_REALTIME, &tm);
-		fprintf(output, "# started on %s\n", ctime(&tm.tv_sec));
+		if (!stat_config.json_output) {
+			clock_gettime(CLOCK_REALTIME, &tm);
+			fprintf(output, "# started on %s\n", ctime(&tm.tv_sec));
+		}
 	} else if (output_fd > 0) {
 		mode = append_file ? "a" : "w";
 		output = fdopen(output_fd, mode);
-- 
2.40.0.348.gf938b09366-goog

