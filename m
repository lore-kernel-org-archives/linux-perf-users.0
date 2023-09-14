Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77D7EEAA71
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Sep 2023 21:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjINVUV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 14 Sep 2023 17:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjINVUN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 14 Sep 2023 17:20:13 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353812724
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Sep 2023 14:20:09 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-594e8207103so19873727b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Sep 2023 14:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694726408; x=1695331208; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YO3ZTyHFm+00gT95r949gZji8+XYvbCsq+dhsmDC+Ok=;
        b=E2tqCAxPd3bvCjWpCu1Mdk81qd7sNmUQscYrFGIN4qeq1ugNv5edtqC0V+gUnG2fpl
         OguXR94Cg1gct+QfZy2nG6MO5lGlZiygLIuJ+Wp4R04WhrShZRFyGi4Zz3y3jh34gbnH
         QYyrRBbQp6YRVXaL7cjm28TvkQcTnFk6Qovm6GL7LTEChcgyygRulO0m0AYF/wAAgXL9
         r6xF1iur7uNSFI7cBbSI8qhlDDYkrtXmDH61YJ6sOUdoGuhe8bAvXVStv6UYQHlXoEHN
         P6kUnKPUoAAoOLC4dnauYDG0DpxxB0VSJj/fIEb1z8BbaoN4+t7cfbw5x7+YaJiBpl87
         J2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694726408; x=1695331208;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YO3ZTyHFm+00gT95r949gZji8+XYvbCsq+dhsmDC+Ok=;
        b=ls1ojEZSehWFtbdNec1jxtm3MYqIqAS9PGHH258FM9zg1LtzpIvDUR/ORTbCZjmKB3
         s6rMVYLsXemQ7sSQC1uqEhtxLSjwQu14BQ6fhSelzwOOCb8lgrq6weChjf4Uax3yC3CB
         DFH3AMOs+hqB6jsnE25r0GFpOAlb47XeLmF+FA+b5qjdV3ADDpODAPmJF4TzofhqrEDj
         SlRCc6PKQOaC9Z1pAYm+i+nJLfd2LanmfyAMPVfXyj+FSyLsibHRRKvUXqaDn5Yj+7aE
         nacCdqyZKEWXrdJfSNU05Z26dsP7fkV7VWMpp8Z6iVmFDWyaQQNLaux3oNFLdaLbKUCM
         Nzzg==
X-Gm-Message-State: AOJu0YyCZKYmOTztrMmNWkQSsT2v717/JWOudJe4jkdzvInK3osp78BR
        6MH+VEyW5662QLRTYMy6HBVrGFDTOy2y
X-Google-Smtp-Source: AGHT+IGCEX/KOyc+NQTtFfPYAWgFXG6kDLqyIKgl2lhi89WqTIgea5kl72TnA6Q8vTJoreHIXz9tXTcmvDM3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5357:1d03:3084:aacb])
 (user=irogers job=sendgmr) by 2002:a81:af11:0:b0:589:a5c6:4a8e with SMTP id
 n17-20020a81af11000000b00589a5c64a8emr175716ywh.1.1694726408395; Thu, 14 Sep
 2023 14:20:08 -0700 (PDT)
Date:   Thu, 14 Sep 2023 14:19:48 -0700
In-Reply-To: <20230914211948.814999-1-irogers@google.com>
Message-Id: <20230914211948.814999-6-irogers@google.com>
Mime-Version: 1.0
References: <20230914211948.814999-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Subject: [PATCH v1 5/5] perf test: Detect off-cpu support from build options
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
        Nick Terrell <terrelln@fb.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Patrice Duroux <patrice.duroux@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Use perf version to detect whether BPF skeletons were enabled in a
build rather than a failing perf record.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/record_offcpu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
index a0d14cd0aa79..a1ef8f0d2b5c 100755
--- a/tools/perf/tests/shell/record_offcpu.sh
+++ b/tools/perf/tests/shell/record_offcpu.sh
@@ -28,7 +28,7 @@ test_offcpu_priv() {
     err=2
     return
   fi
-  if perf record --off-cpu -o /dev/null --quiet true 2>&1 | grep BUILD_BPF_SKEL
+  if perf version --build-options 2>&1 | grep HAVE_BPF_SKEL | grep -q OFF
   then
     echo "off-cpu test [Skipped missing BPF support]"
     err=2
-- 
2.42.0.459.ge4e396fd5e-goog

