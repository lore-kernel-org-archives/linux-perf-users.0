Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2940C43334
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Jul 2022 06:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiGOGhX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Jul 2022 02:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiGOGhU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Jul 2022 02:37:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DD339BA8
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Jul 2022 23:37:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k13-20020a056902024d00b0066fa7f50b97so3317584ybs.6
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Jul 2022 23:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7M+GYYtNjRF6j9wlPTn7oQQUyE7jpd1eRRPdaQ7NUb0=;
        b=G8OsOx9NQ5S44AxvV1eJpCSFqDL7WyhFawmnWQt1pl7AmVtgiowr6ISKMfY4j8r/1P
         ckki4/iFRs4CG9NEIx376vxZ+loqvCECslcc9KyPV3/iRMIJun/nesiLtQUzTfODVxPT
         dxcCAHnqRdtkaxrIJrXc3CQF9c6qM9USh1x1ciJy/4CAWpJi6PXo74x+CT3JtvG++2Io
         3gOaD0buaEquSfph1KhrsfodvXeiiILEc+KnJNq+vcjuXhA1MD03r/aCABrc4NJZZ6ru
         MODpbXHXW54ZODRLWyXZC3DLDzMPV97SQB+gNFbjT0QqJ3CqjObdWU28iHLpmpIoFS5s
         lWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7M+GYYtNjRF6j9wlPTn7oQQUyE7jpd1eRRPdaQ7NUb0=;
        b=ioGqqHHWcV9RVH2DwNzQUruy9YFad0gJQP5sq2taMVyuPqZkN8YkQhFDAp1jfmacph
         bRoXNhoQtmazQEkp+JYtdXPdbW9VxkB5l0p/++RONxtpQ0a+1ITDqr3wxu6epHxB77Iq
         Zv4coUj3wVHtMvb0wkT/5Bc35b9rQP1mntUseIasOyc0eoRoW582qQndjkb7Ut55E8WN
         aLBehyrRWcUafb/TZoSswu6Uqid44kEfuWpdC7ZDH5QTc0kRBc28QgwYmtXI1nenaZRr
         5ilxluTItHBTnihhNq/Urm4zRFkqlxWOHbADJEHHXIpsJZCuwe4W+XBsK3HQUr90eXbP
         CczQ==
X-Gm-Message-State: AJIora/5wwxAb7WRL5wIHVmns3+vlep1dcM2wWjTGCd/yEhGUVFiJMhv
        FhzsWRDXgccR9zXCtxFu6dnRzV22Mh8y
X-Google-Smtp-Source: AGRyM1sfq076xPFf7fCPFMLcz7pfQitfffjVWX1mfD0w39Vf5Q+0y+4WjiioFd8z497Furdboc0OdtrVApRe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e8fe:2a8e:e0f6:318d])
 (user=irogers job=sendgmr) by 2002:a25:d7d6:0:b0:66e:47b3:35be with SMTP id
 o205-20020a25d7d6000000b0066e47b335bemr12494781ybg.140.1657867038611; Thu, 14
 Jul 2022 23:37:18 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:36:40 -0700
In-Reply-To: <20220715063653.3203761-1-irogers@google.com>
Message-Id: <20220715063653.3203761-3-irogers@google.com>
Mime-Version: 1.0
References: <20220715063653.3203761-1-irogers@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v1 02/15] perf jevents: Add JEVENTS_ARCH make option
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Allow the architecture built into pmu-events.c to be set on the make
command line with JEVENTS_ARCH.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/Build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 28a9d01b08af..04ef95174660 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -7,6 +7,10 @@ JSON_TEST	=  $(shell [ -d $(JDIR_TEST) ] &&			\
 			find $(JDIR_TEST) -name '*.json')
 JEVENTS_PY	=  pmu-events/jevents.py
 
+ifeq ($(JEVENTS_ARCH),)
+JEVENTS_ARCH=$(SRCARCH)
+endif
+
 #
 # Locate/process JSON files in pmu-events/arch/
 # directory and create tables in pmu-events.c.
@@ -19,5 +23,5 @@ $(OUTPUT)pmu-events/pmu-events.c: pmu-events/empty-pmu-events.c
 else
 $(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JSON_TEST) $(JEVENTS_PY)
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(SRCARCH) pmu-events/arch $@
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) pmu-events/arch $@
 endif
-- 
2.37.0.170.g444d1eabd0-goog

