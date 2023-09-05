Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D494CA0FFA
	for <linux-perf-users@archiver.kernel.org>; Tue,  5 Sep 2023 18:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236644AbjIESSw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 5 Sep 2023 14:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbjIESSf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 5 Sep 2023 14:18:35 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B211986
        for <linux-perf-users@vger.kernel.org>; Tue,  5 Sep 2023 11:17:13 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58e4d2b7d16so32075447b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Sep 2023 11:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693937769; x=1694542569; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8XqA+7q5S8GcuFEv94zqkxsospEdyuEhg8U7iQVn4Bg=;
        b=0gK75Xe2qwZoaOCnfybp/uWLsuOVio7NQdVkmSjerjNW0V3TgwKa2cVBwBQu0REegb
         Q0FfVP0sIe3yG1jy+YI7m3cV51XdiRkcdPUtWUb8U6f8kHyX75CE6fiOj5aC1cKsdUdV
         Sk8pLWC7pgRxZdyqcc6ZSt8AVfxKSEY1XRe+BuZH6J+B64NebnjOOjfV1kfecMXLX4jK
         j9e7WCVWxhxCgyeP2y1FtDJD13nqbu90bV5IYmZEL7vjSQWpuCGQZvl4h9tdDMlzAUF9
         WyBtA05liWTpYKFSPhh6CzwWZY1MM7EAT4cEC1yZFVvLq2nmyvanImuZeijGsu6t3GTt
         lMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693937769; x=1694542569;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8XqA+7q5S8GcuFEv94zqkxsospEdyuEhg8U7iQVn4Bg=;
        b=VXnZG2GUuHA8kqWFAgGMcrMxzI5pCR12d6TKBFys4rc7stwL6DKWpnJHo+lNSH/7N+
         6+sL57p78if3CKJ9TR/kpklzoP/WYh4MqDdoXh9PYA64k9lq+XdZXI2I4VWqm/FmO/a2
         VGyUyvM3SDg4duUNr+PUunicigvTmCV3ul8/DWeYQQgWJW5bB3hH3xTGzba5pG5tagCx
         tHSZJykNPg1glcMOUNkCkIu+hboOskIDSaj+RPKsS3FVB09IpilYwXkR48I/in+r/Wnk
         ixHNP0YaVmabWIikQrnUY3s1nTqCWca11K+EP9WlUw1jyrFgWvEs0zhCExJ+hyK/Q0P8
         r6Gg==
X-Gm-Message-State: AOJu0YyuM9mg8XkvTqkjsj63338ZeB68GOrVwaTyKI2JdMUkuIXrY6AT
        sPfpyGSqxCHXhs0zYyauRln49oX4wzOJ
X-Google-Smtp-Source: AGHT+IGg80w1b+ouYPhBbnVvKUQ0/xUemtvB+rChC83tYWEcPTgI+TgyrY14wNh4lQjnwp9XhrOBGFV9Ev0N
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:1e0b:753:60d0:6c22])
 (user=irogers job=sendgmr) by 2002:a81:ef04:0:b0:595:870c:1554 with SMTP id
 o4-20020a81ef04000000b00595870c1554mr431925ywm.5.1693937768958; Tue, 05 Sep
 2023 11:16:08 -0700 (PDT)
Date:   Tue,  5 Sep 2023 11:15:54 -0700
In-Reply-To: <20230905181554.3202873-1-irogers@google.com>
Message-Id: <20230905181554.3202873-3-irogers@google.com>
Mime-Version: 1.0
References: <20230905181554.3202873-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1 3/3] perf completion: Support completion of metrics/metricgroups
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

Allow metrics to expand for -M or --metrics options.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/perf-completion.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/perf-completion.sh b/tools/perf/perf-completion.sh
index 319ad724b97a..f224d79b89e6 100644
--- a/tools/perf/perf-completion.sh
+++ b/tools/perf/perf-completion.sh
@@ -202,6 +202,10 @@ __perf_main ()
 		$prev_skip_opts == @(record|stat|top) ]]; then
 	        local evts=$($cmd list --raw-dump pfm)
 		__perfcomp "$evts" "$cur"
+	elif [[ $prev == @("-M"|"--metrics") &&
+		$prev_skip_opts == @(stat) ]]; then
+	        local metrics=$($cmd list --raw-dump metric metricgroup)
+		__perfcomp "$metrics" "$cur"
 	else
 		# List subcommands for perf commands
 		if [[ $prev_skip_opts == @(kvm|kmem|mem|lock|sched|
-- 
2.42.0.283.g2d96d420d3-goog

