Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9FCEB64DA
	for <linux-perf-users@archiver.kernel.org>; Thu, 20 Jul 2023 14:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjGTOYD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 20 Jul 2023 10:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjGTOYC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 20 Jul 2023 10:24:02 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A9E1B6;
        Thu, 20 Jul 2023 07:24:01 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b9cdef8619so5519855ad.0;
        Thu, 20 Jul 2023 07:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689863041; x=1690467841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=db8g/w+T6FNZ3LBDgyxuQRCSEt2p8ggcXHIRpLXdWUM=;
        b=cyGK9wBYYAi5j2Xt1kfHbzQwMVRjRxitX0Ypq3HmQBapmJR7oKBpw7Cv0wi5gfoWOA
         fDxu0Ri4te7UaTtPscsJn7hrrvAfODvvflMJfkP+lisr8svYIOP/IRkGikrVKKaUoWQd
         K02KBThRDO0KQL60Aql0GGnc1Y5Ka4WO7ll5M7UNKDtJieKFKmqJ6HcUzRt+En6mXRk4
         wmwpLWpCCmRo0H3WAj/+Mjm1ru4LJ4b+iA0RgBvNqtCV9im5TCfLuKEZv/ahmk4/dfRW
         QNwVNakQcNjUTJQuWwXIgN0t4FFeQw7kPtQ+q5tN1dI1Qq1nw0JCswSlnqBGAnb2I9DT
         BoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689863041; x=1690467841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=db8g/w+T6FNZ3LBDgyxuQRCSEt2p8ggcXHIRpLXdWUM=;
        b=XPncLqhV4LjXMIs4cYygPZp0VZgyDuV2g13OSFMP5071/2021fsvqGIVn6+evYlx9p
         1tMWI6E3++ZJl2DB5SL/U6miMIZWoiWw8obVBAwC+qe3a5R2giotfhKnA5bC1wCBhFgx
         41DIlIzaE/JCxzx+6Cu9ZaS/a4ebVsnG+w3r/p+3xrA5JD32iRltPGRG+Z9e7eCQqW58
         q7Ze1IAt7haXL7TDCePnIPVhcpqYCNZ+d4JW98Qd2U6odlYvAWZDZ+7/P2EaAORhKudz
         TTVoFGEqt62FukVy3ltlCxP7WIr6skJoQHlHge9p5kBe2dq68p60Dcth1+CTIIb6C8bT
         R22Q==
X-Gm-Message-State: ABy/qLbiNOp6wPusTiI1KBGp4jXfnUfiwiNWr7cV9qvQRIa0Frj8TehN
        sl6swdBrDuFgNOfteIalTJs=
X-Google-Smtp-Source: APBJJlFo6L3Zpe4P6MJPpzfYxTYnlCBNAE0U26IEgcPKXEE26ntfbOm9QM4Tmki6Dnk+ik2hlzjeTQ==
X-Received: by 2002:a17:902:d3cc:b0:1b8:1e05:ed09 with SMTP id w12-20020a170902d3cc00b001b81e05ed09mr40007plb.36.1689863040781;
        Thu, 20 Jul 2023 07:24:00 -0700 (PDT)
Received: from yoga ([2400:1f00:13:4928:ca70:2ef7:845e:1b9e])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902a5c700b001b8918da8d1sm1435796plq.80.2023.07.20.07.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 07:24:00 -0700 (PDT)
Date:   Thu, 20 Jul 2023 19:53:53 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anup Sharma <anupnewsmail@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] perf scripts python: Add command execution for firefox
 gecko converter script
Message-ID: <c8b61c91991c10f0245548afbb5572e92af5e9dd.1689862609.git.anupnewsmail@gmail.com>
References: <cover.1689862609.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689862609.git.anupnewsmail@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This will enable the execution of firefox-gecko-converter.py script
using record and report commands.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 tools/perf/scripts/python/bin/firefox-gecko-converter-record | 2 ++
 tools/perf/scripts/python/bin/firefox-gecko-converter-report | 3 +++
 2 files changed, 5 insertions(+)
 create mode 100755 tools/perf/scripts/python/bin/firefox-gecko-converter-record
 create mode 100755 tools/perf/scripts/python/bin/firefox-gecko-converter-report

diff --git a/tools/perf/scripts/python/bin/firefox-gecko-converter-record b/tools/perf/scripts/python/bin/firefox-gecko-converter-record
new file mode 100755
index 000000000000..7df5a19c0163
--- /dev/null
+++ b/tools/perf/scripts/python/bin/firefox-gecko-converter-record
@@ -0,0 +1,2 @@
+#!/bin/bash
+perf record -g "$@"
diff --git a/tools/perf/scripts/python/bin/firefox-gecko-converter-report b/tools/perf/scripts/python/bin/firefox-gecko-converter-report
new file mode 100755
index 000000000000..2405c6b26446
--- /dev/null
+++ b/tools/perf/scripts/python/bin/firefox-gecko-converter-report
@@ -0,0 +1,3 @@
+#!/bin/bash
+# description: create firefox gecko profile json format from perf.data
+perf script -s "$PERF_EXEC_PATH"/scripts/python/firefox-gecko-converter.py -- "$@"
-- 
2.34.1

