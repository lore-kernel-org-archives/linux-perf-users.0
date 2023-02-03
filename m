Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFB0C61DA4
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Feb 2023 01:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjBCBkc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Feb 2023 20:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjBCBkb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Feb 2023 20:40:31 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232178715C
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Feb 2023 17:40:30 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-50e79ffba49so36952267b3.9
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Feb 2023 17:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MyChsJPTVsY2fOwG/RI8qO+kUTadsY5ao3Rn6oLubwI=;
        b=q2Lfvwgba5mI01dB8lALvFJm9eJ5L6qh+bqk0DX7YFrZLVCPPEc4ohuNsRgVz/DWoa
         45p4NxjS5Tc1u5rhYtkOxutMSFfev883SPN6LLMTF+pVdMycr5bePuiA4UIRHQz5bmMG
         zRiiSUVv2IaBHwMxrZbglAbdEKlQmmqfuwY5AFdTVPB9cpJ0EZxRn/4K85quJOTCZpi5
         HE78n6XyxSyGucpzxCPCE77mwn66EGwiwRzQEtgwgENOIvH68rrdkfdOIYL+WWSM3dAE
         t4gePGaLe1+Ey+the2P/FX3skvPyNc0yYktf4Ltxq559JXe8PAfMYwDOsSj+u3GdckiS
         ay/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MyChsJPTVsY2fOwG/RI8qO+kUTadsY5ao3Rn6oLubwI=;
        b=weMJokzuRrfTN/qBCfIlTjySTMy0+kVagRmuHxbeptICMjzY5n23P49nyFIE8GUFOi
         1l2BOrHToIu8RyHwRdGblir3KtOAlC9tvY4LgXwDwGIynweqw30Wq2yip8ZqL1PhtfIH
         5YpHNiz8GLWHrYcOxVp9CSm5yQ/typ6LSalE+y5itbLNgx1DruNUSw0X0r4HyJ9QplRx
         WpgWTPgok31MSeMfwut+SslEtVW2kgZoNkbmx0XO1/PKxkbl6riRKCIMwR7Zg+1Ck/3B
         1JptedUzuabNKZTiW9fdlwnis6C271suxMBJFPzVYsz45jxLeAzU1FrK887vgoGtl36F
         nY0Q==
X-Gm-Message-State: AO0yUKWmDQNhmhwlvqXuys4wC2pjsxwZ6gB3vnXkG92Fz5nVkFagBTSV
        fAPQvCcSSmMeFI818niE/WVMmhBdO9Dz
X-Google-Smtp-Source: AK7set+0if6+qdzHg851jcAQ62KbEMrh7klQns415GjdzZzFFKMRMIpJ8w8d4/avuCsLvwLct18dnu+GKXDH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3bb5:4c1f:1143:605])
 (user=irogers job=sendgmr) by 2002:a25:d749:0:b0:833:79ab:566a with SMTP id
 o70-20020a25d749000000b0083379ab566amr906826ybg.27.1675388429315; Thu, 02 Feb
 2023 17:40:29 -0800 (PST)
Date:   Thu,  2 Feb 2023 17:40:14 -0800
Message-Id: <20230203014014.75720-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Subject: [PATCH v1] perf pmu: Fix aarch64 build
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
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
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ARM64 overrides a weak function but a previous change had broken the
build.

Fixes: 8cefeb8bd336 ("perf pmu-events: Introduce pmu_metrics_table")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm64/util/pmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
index 2779840d8896..fa143acb4c8d 100644
--- a/tools/perf/arch/arm64/util/pmu.c
+++ b/tools/perf/arch/arm64/util/pmu.c
@@ -22,6 +22,8 @@ static struct perf_pmu *pmu__find_core_pmu(void)
 			return NULL;
 
 		return pmu;
+	}
+	return NULL;
 }
 
 const struct pmu_metrics_table *pmu_metrics_table__find(void)
-- 
2.39.1.519.gcb327c4b5f-goog

