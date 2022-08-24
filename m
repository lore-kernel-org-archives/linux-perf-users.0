Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE787C3F6B0
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 Aug 2022 15:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239362AbiHXPki (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 Aug 2022 11:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239677AbiHXPkd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 Aug 2022 11:40:33 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE473C8E0
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Aug 2022 08:40:28 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-32a115757b6so299938657b3.13
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Aug 2022 08:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=hI/abfVc/lpVnBGw0/IBypco5YlPGa9tkPSCqJ9uDZQ=;
        b=K4WvIteHQst8sUIrt3X5+g4N8dsRBlJV60qYviWW+eMsHJ+U/ObLuAAap2dexoauAb
         s/UA7XKXWt2EJTsFv88NSfbk5guMt0c5q5JOTx6MfYaYYcf/JzEwWUR2c6H+xVuUl0mi
         LeACmtO26T4rGZeLzGlY9R3O8EtizzsRGrN3nafORfohlOQTfaOhqbujhjdYDOORZzyF
         R0dPZN41uT2mVMwX1fACOC7ci7/hlz95LNTad6coKPZjT+JPrntiM46wRlqqjd4+jJyq
         C+1IuWl04hjzAowCHFH9FYl2KediyaQVj8gybEHlxXAEY763BVn9NSLKYbYOAjzheTEi
         fuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=hI/abfVc/lpVnBGw0/IBypco5YlPGa9tkPSCqJ9uDZQ=;
        b=JH3H/755CIMTBnGHLkwrc3mGjtQjAZ2pKFTXnjYef6tYkN35+akCYJRekH3UmKdNyn
         EFGYd6bnuLeXutDASvouoZoy1gjgACqkDzLqsaOc1AcejnsMmBA086D9PoXJP2odHA7V
         m4m+5cgEqoH+70smQGSpzlBgHPwglFi5Nve99NANLpJcis/wVScJBKflmAfiArPkIN/Q
         fqN9U6dAQPhivHAgzEJxiklHLXgEA4HyMAw/W+dF0Z2Ph3jYD98nsgZflt4uMChb+Ihu
         Y/BQKEOk0DDPjsdC/1obd2e6ti/Itw+q+vMI9GfKi71xlY3ge7KC3OJ8WCYtV4UUh+EA
         QZSQ==
X-Gm-Message-State: ACgBeo1M42/r2D3cShp5d7vp7Rnrfn9ItKdd/nrZ0vfsxi/3ZaaCcngi
        j5WCjWTOHC5+eY5byum6HUTtqueQHew+
X-Google-Smtp-Source: AA6agR5amzTbKyhRl0hgVmQH85dfCOg717/9dh29bBkhIeffqhKeAJVU23zxWfna7TU9km3Q8eUuILFDgFkW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ab82:a348:500d:1fc4])
 (user=irogers job=sendgmr) by 2002:a05:6902:1101:b0:695:ce92:a857 with SMTP
 id o1-20020a056902110100b00695ce92a857mr12311995ybu.337.1661355628312; Wed,
 24 Aug 2022 08:40:28 -0700 (PDT)
Date:   Wed, 24 Aug 2022 08:38:53 -0700
In-Reply-To: <20220824153901.488576-1-irogers@google.com>
Message-Id: <20220824153901.488576-11-irogers@google.com>
Mime-Version: 1.0
References: <20220824153901.488576-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v3 10/18] perf mmap: Remove unnecessary pthread.h include
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Weiguo Li <liwg06@foxmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The comment says it is for cpu_set_t which isn't used in the header.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/mmap.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index cd8b0777473b..cd4ccec7f361 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -9,7 +9,6 @@
 #include <linux/bitops.h>
 #include <perf/cpumap.h>
 #include <stdbool.h>
-#include <pthread.h> // for cpu_set_t
 #ifdef HAVE_AIO_SUPPORT
 #include <aio.h>
 #endif
-- 
2.37.2.609.g9ff673ca1a-goog

