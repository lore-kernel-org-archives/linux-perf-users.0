Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3497C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Nov 2021 22:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhKWWvl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Nov 2021 17:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239776AbhKWWvi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Nov 2021 17:51:38 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D17C061714
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Nov 2021 14:48:30 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id jx2-20020a17090b46c200b001a62e9db321so357272pjb.7
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Nov 2021 14:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FMQLoym76yTY3cbbWiDyiD1lX2+hK6fXMJaMyVRGwOw=;
        b=Qbe0vA6gXGRBxEWwQZqgRTy/OZEtHuCAGqQ7pNGzYR6IB+q8JCqZOQL/bOjUuAOQsi
         9G7LepeCCyAkTA/zt/8HYjze+pZcQ035u7Peuxtbc7fa9xNOEt8Mz0tiCelgkpR6kqJV
         UVJ5SvOg8gA0GldDP3anDljKbbPj3wtXcjQnsWvML3456LfOGdw2JVcRAHN7AuGYXHYP
         /+JEX7HJ/nlGIjRF53S7R732iyTEYq1m2dkLi/FGdpGlKXSqjGNOz8F77+8jdOupQgUr
         fjLqnIA+2kfVRyYIMePCc73YfrudYzHFvOJnopfnhHX5cCIKkr8BPtUIye/sxTFQSXyc
         D8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FMQLoym76yTY3cbbWiDyiD1lX2+hK6fXMJaMyVRGwOw=;
        b=eKYVlI+yJZ88sdfoGwyRfxTdNhyE0rbhzaYgkzy3R/ajTKgqi+XfNDIPv6W6AQ/Pvx
         4gch9jfAr9nrxf8d2WwyPiLwxnHKdXLgMNj48V9Kvar/HumC54X3fu+dR6Z1CyfC2RLs
         mVWopV60GDNo1WWcMlKbT2ivsi/EZkfyUuTK4SzOcgGdL56osioPI9NfbDBNDeWclD2Z
         NUn2O9Q/bIi68n7krmX0Kljqe4HYMvWcuJnSnXBhSX/Svpp3qzZ4uBPJadWdfmnylBeM
         PkI3XUKQrYlrdzwr7tyFoTzm5qC/L7BupsUK+2NWYNCpA0r94tdjNPkn+CLFUlaO09FI
         BEgA==
X-Gm-Message-State: AOAM530OiwKQg/Xd1hqHpGq4lc20HOruTad2VzZ4ZmRSg8azWn2rHVPL
        gSVfqjHbPZAXpXlinnFU33AkoXDq0Lj7
X-Google-Smtp-Source: ABdhPJys4YEAse8Egj+M2QQAIbNTekARl8nB+PnwPM6IUT1E1yXSQ67yY1azYo+Kxe+hR4KQUT2B58VkJjiw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:dbab:a6fe:1e3a:91fa])
 (user=irogers job=sendgmr) by 2002:a17:903:11cd:b0:143:d220:fdd8 with SMTP id
 q13-20020a17090311cd00b00143d220fdd8mr11605843plh.79.1637707709588; Tue, 23
 Nov 2021 14:48:29 -0800 (PST)
Date:   Tue, 23 Nov 2021 14:48:21 -0800
In-Reply-To: <20211123224821.3258649-1-irogers@google.com>
Message-Id: <20211123224821.3258649-3-irogers@google.com>
Mime-Version: 1.0
References: <20211123224821.3258649-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH 3/3] perf tools: Probe non-deprecated sysfs path 1st
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Following Documentation/ABI/stable/sysfs-devices-system-cpu the
/sys/devices/system/cpu/cpuX/topology/core_cpus is deprecated in favor
of thread_siblings, so probe thread_siblings before falling back on
core_cpus.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/smt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
index 2636be65305a..2b0a36ebf27a 100644
--- a/tools/perf/util/smt.c
+++ b/tools/perf/util/smt.c
@@ -79,11 +79,10 @@ int smt_on(void)
 		char fn[256];
 
 		snprintf(fn, sizeof fn,
-			"devices/system/cpu/cpu%d/topology/core_cpus", cpu);
+			"devices/system/cpu/cpu%d/topology/thread_siblings", cpu);
 		if (sysfs__read_str(fn, &str, &strlen) < 0) {
 			snprintf(fn, sizeof fn,
-				"devices/system/cpu/cpu%d/topology/thread_siblings",
-				cpu);
+				"devices/system/cpu/cpu%d/topology/core_cpus", cpu);
 			if (sysfs__read_str(fn, &str, &strlen) < 0)
 				continue;
 		}
-- 
2.34.0.rc2.393.gf8c9666880-goog

