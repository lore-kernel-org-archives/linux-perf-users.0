Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F56C4332F
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Oct 2022 02:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJDCUB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 3 Oct 2022 22:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiJDCSK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Oct 2022 22:18:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D6F3ECD7
        for <linux-perf-users@vger.kernel.org>; Mon,  3 Oct 2022 19:17:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p12-20020a259e8c000000b006958480b858so11914912ybq.12
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Oct 2022 19:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=sYSumwi1J3HcBN/q2DeaufGmFH3/CfQMFmLPW058Qnk=;
        b=jZPRb5u3x5JknepsPUO/8uO2rxUbgkvJzuGPTBQFXzV2AFqfwRLehso7tcVWi2VTTD
         lm5y6BgAUTnpUXDIR+SzOV8BNm8NgF6e0qP99SuIY8BF0al52B9Ay/BMkEOpjKUDRmav
         sxAmSEuNdzRS+nY9KDrmjl+j5x5JhkviXLzlQ0QvZKAq7vqb1bAyUBfhvPnOi3Abdb42
         P2PhszFHvPSyiTLW1fD7nyht8EZ0m3v+4Tht/yI8XykoOQSMIA+DyMydPqbgLfutcGAb
         5DlkFxxUuCEcamQ0PBYFUAOGFZtPrS4BnqV5ihWpvCJnCOzqm8KvOjrNTwDfmGigjR9J
         KDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=sYSumwi1J3HcBN/q2DeaufGmFH3/CfQMFmLPW058Qnk=;
        b=Hhk20GtEU3+MndCvffs+DutVlGZo/w5xZ9A6S1KsJ3PEuXGbLqSQkwWxKjYEsIOgSK
         TPbpBelFsapSiSuNxwFfIWTar1+bNGHAoKtoTfRrFu46kXdEr3jU762M7FynQ5/mFsYp
         E9BAxTJnZPeQnqSPRlNAKX3NR+P0MBotDyDbXnm0C7wsW/K14trmXqZhRAw2krEJqlaz
         TvkWVgNkDU7D8DsUlnlAdzDxVqJhS/YTste3p0Am0tAjQyben3XU9shFzrEo/g/CP/G0
         +jUnFK1zHDo348g/r1xYIAMi3pJ0kDvMyzUmh/qkgYtm6h4DYl1NbY9xryFDdFF7/fWE
         8k/A==
X-Gm-Message-State: ACrzQf1apS9XwHFoHpC7pNyW9PZY8k2zlYfEOwkcfufn0JofYQ4+xrb0
        j8kdcE2k2jO+qLn4ojYgxOsVPV6DgY9t
X-Google-Smtp-Source: AMsMyM54A1EQxUVPPpqc9L5YVZ3S//pBH/PkCGo4OmjZIg68Ad/CB38UU3TiQO4ImFIRlwG0nUoTFBeKSQin
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a86d:8afd:70b1:9b0c])
 (user=irogers job=sendgmr) by 2002:a25:888f:0:b0:6a8:f77c:4f96 with SMTP id
 d15-20020a25888f000000b006a8f77c4f96mr22818856ybl.103.1664849834422; Mon, 03
 Oct 2022 19:17:14 -0700 (PDT)
Date:   Mon,  3 Oct 2022 19:16:09 -0700
In-Reply-To: <20221004021612.325521-1-irogers@google.com>
Message-Id: <20221004021612.325521-21-irogers@google.com>
Mime-Version: 1.0
References: <20221004021612.325521-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Subject: [PATCH v3 20/23] perf vendor events: Update silvermont cpuids
From:   Ian Rogers <irogers@google.com>
To:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add cpuid that was added to https://download.01.org/perfmon/mapfile.csv

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index c2354e368586..5e609b876790 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -21,7 +21,7 @@ GenuineIntel-6-1[AEF],v3,nehalemep,core
 GenuineIntel-6-2E,v3,nehalemex,core
 GenuineIntel-6-2A,v17,sandybridge,core
 GenuineIntel-6-8F,v1.06,sapphirerapids,core
-GenuineIntel-6-(37|4C|4D),v14,silvermont,core
+GenuineIntel-6-(37|4A|4C|4D|5A),v14,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v53,skylake,core
 GenuineIntel-6-55-[01234],v1.28,skylakex,core
 GenuineIntel-6-86,v1.20,snowridgex,core
-- 
2.38.0.rc1.362.ged0d419d3c-goog

