Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ABEC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 May 2022 14:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245490AbiEZOym (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 26 May 2022 10:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbiEZOym (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 May 2022 10:54:42 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F6E2BB36
        for <linux-perf-users@vger.kernel.org>; Thu, 26 May 2022 07:54:40 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y1so1890719pfr.6
        for <linux-perf-users@vger.kernel.org>; Thu, 26 May 2022 07:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/XepXcl3MwknhHJh7/3Lmb3wiRfEwFXmNtfFn6bYrM8=;
        b=er90n3esibIhtB8JkkbPU17C3v/v2Hajk48v6S8Aigmie8lqS3Pcl01ODmzg0I/Y1n
         pqupHzGJsOGBdLzV0ssl85/n6hIfwZCKsl7rx88yxRLfPWp9koSB7BTBQhzKh1ygdLUE
         Ar9QGhhQXuOtYkDpmfwH4xtzXFwiEEh3oT4O8n0o50VGHsb0Z+ACZfgKw3hFUsV4m6FK
         MHdV6uYDQc55kr1nBf0SUnwROL2JNpqSQyAqAxAmcxuPO1Lkkk65ei55GjN/0lm4Rv7f
         sRRMb04jSlj2JY086tzCCvW7955t+YFahnsjfZwlbhiDfP8dzen48aLKOfT7YPLjoGAN
         r67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/XepXcl3MwknhHJh7/3Lmb3wiRfEwFXmNtfFn6bYrM8=;
        b=3H0Wt4NGfdQUikijk6OyXefM8/bt95u2HZIJqgyBLp8q7AMRl281K4ImG/gDNCTB7e
         cdTKFRZJuB2SlqJWGnElP9VPTF5nY5vbUgTZ8yYPIiVG5kpfXDQSrzQcOXHQ36Dg4H4E
         6DN42M75k8qFkW5I+t2gUXJ8tDaqr5qMFXVR+Rxezf2K3hcVZ9MOeRRdalOifTO3ukkt
         GVDxEItdwlZeAvpwW7VyMhGg2EH6jgYocYlZnvHABn2ISjHD5MGogSJleKivPp8i/WTd
         +EtIcFsVz/+FrgkMgkL7qmm1LtaTbHhwwfztBecKQRlTCIlDk3p3R2I0x1S/k9Zhon/M
         hnOg==
X-Gm-Message-State: AOAM533L+fN7/VKPncE/IzuLBFOc8kMV+ihyhRz5dUq3x/hOoZCBovbm
        PoQie7IIcyCneh60Zi9ozNGwKQ==
X-Google-Smtp-Source: ABdhPJxF+lSZPtHpmQB/BJiBujuXz5MuUkwz6PHe/8nysAWfIRWl8xf3CDSZF2a6hrmjG49DgP6kaQ==
X-Received: by 2002:a63:f158:0:b0:3db:8563:e8f5 with SMTP id o24-20020a63f158000000b003db8563e8f5mr33900015pgk.191.1653576880326;
        Thu, 26 May 2022 07:54:40 -0700 (PDT)
Received: from leo-build-box.lan (n058152048107.netvigator.com. [58.152.48.107])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902d4d100b0015e8d4eb28csm1690877plg.214.2022.05.26.07.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 07:54:39 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>, Joe Mario <jmario@redhat.com>
Subject: [PATCH v2] perf c2c: Use stdio interface if slang is not supported
Date:   Thu, 26 May 2022 22:54:00 +0800
Message-Id: <20220526145400.611249-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If slang lib is not installed on the system, perf c2c tool disables
TUI mode and roll back to use stdio mode;  but the flag 'c2c.use_stdio'
is missed to set true and thus it wrongly applies UI quirks in the
function ui_quirks().

This commit forces to use stdio interface if slang is not supported,
and it can avoid to apply the UI quirks and show the correct metric
header.

Before:

=================================================
      Shared Cache Line Distribution Pareto
=================================================
  -------------------------------------------------------------------------------
      0        0        0       99        0        0        0      0xaaaac17d6000
  -------------------------------------------------------------------------------
    0.00%    0.00%    6.06%    0.00%    0.00%    0.00%   0x20   N/A       0      0xaaaac17c25ac         0         0        43       375    18469         2  [.] 0x00000000000025ac  memstress         memstress[25ac]   0
    0.00%    0.00%   93.94%    0.00%    0.00%    0.00%   0x29   N/A       0      0xaaaac17c3e88         0         0       173       180      135         2  [.] 0x0000000000003e88  memstress         memstress[3e88]   0

After:

=================================================
      Shared Cache Line Distribution Pareto
=================================================
  -------------------------------------------------------------------------------
      0        0        0       99        0        0        0      0xaaaac17d6000
  -------------------------------------------------------------------------------
           0.00%    0.00%    6.06%    0.00%    0.00%    0.00%                0x20   N/A       0      0xaaaac17c25ac         0         0        43       375    18469         2  [.] 0x00000000000025ac  memstress         memstress[25ac]   0
           0.00%    0.00%   93.94%    0.00%    0.00%    0.00%                0x29   N/A       0      0xaaaac17c3e88         0         0       173       180      135         2  [.] 0x0000000000003e88  memstress         memstress[3e88]   0

Fixes: 5a1a99cd2e4e ("perf c2c report: Add main TUI browser")
Reported-by: Joe Mario <jmario@redhat.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---

Changes from v1:
* Added fixes tag;
* Added reported tag from Joe.

 tools/perf/builtin-c2c.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index c8230c48125f..80b525c065ed 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2801,9 +2801,7 @@ static int perf_c2c__report(int argc, const char **argv)
 		   "the input file to process"),
 	OPT_INCR('N', "node-info", &c2c.node_info,
 		 "show extra node info in report (repeat for more info)"),
-#ifdef HAVE_SLANG_SUPPORT
 	OPT_BOOLEAN(0, "stdio", &c2c.use_stdio, "Use the stdio interface"),
-#endif
 	OPT_BOOLEAN(0, "stats", &c2c.stats_only,
 		    "Display only statistic tables (implies --stdio)"),
 	OPT_BOOLEAN(0, "full-symbols", &c2c.symbol_full,
@@ -2833,6 +2831,10 @@ static int perf_c2c__report(int argc, const char **argv)
 	if (argc)
 		usage_with_options(report_c2c_usage, options);
 
+#ifndef HAVE_SLANG_SUPPORT
+	c2c.use_stdio = true;
+#endif
+
 	if (c2c.stats_only)
 		c2c.use_stdio = true;
 
-- 
2.25.1

