Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59CECA0FF7
	for <linux-perf-users@archiver.kernel.org>; Tue,  5 Sep 2023 18:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238519AbjIESb7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 5 Sep 2023 14:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbjIESb7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 5 Sep 2023 14:31:59 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF1AE72
        for <linux-perf-users@vger.kernel.org>; Tue,  5 Sep 2023 11:31:28 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id af79cd13be357-76dbec0d84eso253469685a.3
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Sep 2023 11:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693938607; x=1694543407; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=klhRss+hz2sCHrma37LRr7SfQt+BwpB8srd4HmiASto=;
        b=IqQ1ZIjNIXtowgAzWSKV1L7bmwCcoQDr4hWmdWsLNrdlIz32uIYyHK9AfRmBY/p3P3
         Oq2inlQQ0Qmm+v68BZE0/LP53VlhkPH9tVVX3jYcgWWTKbtfRcH2ITOasGykb7+2ddpu
         tjiy/+lpfY46bNZd7zi+3SvVVJTwXR9dTWBaahui6JelKdG4r3RJQLUebM0rpT3Yh9Y/
         SCQvuPqtOG+W6Crc4NmFGWgLa91nV229CUA0DZ7Jf1pC4g+O7rVTxp/vthmpTo8tWmH8
         btVGL+K/79lbAkqaCxtSUzoU6lDgDNue6Yo1H7EhFEmnRcEoBC7i0iAKCwXTTY6mMRIf
         4yZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693938607; x=1694543407;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=klhRss+hz2sCHrma37LRr7SfQt+BwpB8srd4HmiASto=;
        b=KFDquaFugxcNzEOu4S1RX2T4ygIcuUG78UTJmYbQA/JLfN0AsNPbCY9Z3iHlopNTFv
         25mU7Gnsg19vEXUsY0oxKUZAAPudm1NM8xY+pKljvlHSlxBlvdHyOUM4fer6/40nZ7in
         iIy9qt0y3obmGv7Rw4qe2JD0uG3tVVHOApnbyn3zWkQF+LZSpM7DI5aAvgBLFiyIrhhP
         77Xt2DQenBnROWBsrSFTbsyx9om1p+JmnNsMw/yp+j3dR5pHJQ8ZVDbkxwggi3pBB8t6
         zR+ztCfN+M1Bi0HtPBB5pBWPwcR6mCy2Ecs8cXuuvoO1MDZ8TrH3DiDnSPDnbxZcLIV6
         HesA==
X-Gm-Message-State: AOJu0Yxv2H1Tmk801KPpgUpKImptC55S1XeBNFXjNDmxO5aJBz5rDj6R
        l06Qox4/1mn+1S89+3eEBH6vUpLhLvcU
X-Google-Smtp-Source: AGHT+IG/AdiLHm5ncrJjTjGm8xs1OtOpUdIbMcfrDR37zr2W9w7e2sotGDs3MfNaiS25vhbdPdTsAgrbBhX1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:1e0b:753:60d0:6c22])
 (user=irogers job=sendgmr) by 2002:a81:eb0a:0:b0:576:8cb6:62a9 with SMTP id
 n10-20020a81eb0a000000b005768cb662a9mr344705ywm.6.1693937766716; Tue, 05 Sep
 2023 11:16:06 -0700 (PDT)
Date:   Tue,  5 Sep 2023 11:15:53 -0700
In-Reply-To: <20230905181554.3202873-1-irogers@google.com>
Message-Id: <20230905181554.3202873-2-irogers@google.com>
Mime-Version: 1.0
References: <20230905181554.3202873-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1 2/3] perf completion: Support completion of libpfm4 events
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Use `perf list --raw-dump pfm` to support completion of libpfm4 events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/perf-completion.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/perf-completion.sh b/tools/perf/perf-completion.sh
index 40cfc30ad7ad..319ad724b97a 100644
--- a/tools/perf/perf-completion.sh
+++ b/tools/perf/perf-completion.sh
@@ -198,6 +198,10 @@ __perf_main ()
 		else
 			__perfcomp_colon "$evts" "$cur1"
 		fi
+	elif [[ $prev == @("--pfm-events") &&
+		$prev_skip_opts == @(record|stat|top) ]]; then
+	        local evts=$($cmd list --raw-dump pfm)
+		__perfcomp "$evts" "$cur"
 	else
 		# List subcommands for perf commands
 		if [[ $prev_skip_opts == @(kvm|kmem|mem|lock|sched|
-- 
2.42.0.283.g2d96d420d3-goog

