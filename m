Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290E0C43334
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Jun 2022 18:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiF2SZm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 29 Jun 2022 14:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiF2SZm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 29 Jun 2022 14:25:42 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2802A73F
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jun 2022 11:25:41 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3178996424dso136558427b3.21
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jun 2022 11:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=61y9ZbhNM9aUa2DE015x/wXVvTB/o4yjLiEf1BV500Q=;
        b=baBCA/KhIRIKWbiWArtjOZMGeBZ9usu3nyVsCsSEi2tBwChryTPc6wxkxEBbf7sFdA
         tLTycH/nJxV3GMcVs/3gbn8tXTxSjk+UysCDnEBMCoqjWv9zdj9A/ZHB4IlvQsk1hp93
         ZJaQvDLRU1hClGiTWCZ+JZCt3USJLdkVLI/UgkJDTdePct5USqWQUASkCjZKFIygeNwR
         z2T+MnN9QSCbbNk+spFX3YrxZrdy+X6nBjtf/iyLIMuj4FG1NTQVWORNKtduaKmzwoD7
         Vy+atG6nUAeQ4pw+rX1VJ2nvDX2tBEjv3nQSKedp0TV5blNZ/b57zLpXZfEEdGRmQ2Bs
         UK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=61y9ZbhNM9aUa2DE015x/wXVvTB/o4yjLiEf1BV500Q=;
        b=iycBS2eGCXDfmQFasJAnBfVGofUb/OYzwehVPmUECaB6lrERYEQco8rrzSUwdE04dj
         35sv01iH4v6u/hCOpQIZ60HyDg01oVkTmX0Q/ZirEUywitI6ZDvoYtIHSnhh+vzyvUmX
         vWoxo98PVuhbyqBNA6goOzFLb7R1zEyEkvf2X5/ak82wTpUN/9ZUp5IAzo5/OyB/KmM1
         vGye4pCK1kbgga4s8QJRBz/VndQ0fHU/hITZcmO0AajUMYnvVToRyIN2z4EotAhtp+jm
         LCGRAPRIdDM3oZGobSRgrsBw2savUAmX/0X4GdZ0/RnAcnqgmLYSaKAVnFfjlM+Dc5yu
         KW9w==
X-Gm-Message-State: AJIora+sqqUlHCDqa50x0z5K8+GSfdi2DxBRCGZ6fP2hcZUF/nTPB3jS
        jveiGUZOCD+QEv/27CsqibuZKzfWoLE+
X-Google-Smtp-Source: AGRyM1sMndKMm44rfmDv3hwTaujKL2Kn2c493wD28xDQB+xXXXO4cmtQBUgqGchDWkmDzV9wBzZsuryjd6pr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:f5a1:84fb:df7d:bd89])
 (user=irogers job=sendgmr) by 2002:a25:50c7:0:b0:66c:95d2:c7e5 with SMTP id
 e190-20020a2550c7000000b0066c95d2c7e5mr4976142ybb.156.1656527140474; Wed, 29
 Jun 2022 11:25:40 -0700 (PDT)
Date:   Wed, 29 Jun 2022 11:25:02 -0700
In-Reply-To: <20220629182505.406269-1-irogers@google.com>
Message-Id: <20220629182505.406269-2-irogers@google.com>
Mime-Version: 1.0
References: <20220629182505.406269-1-irogers@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v7 1/4] perf python: Prefer python3
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Felix Fietkau <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <rogers.email@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Ian Rogers <rogers.email@gmail.com>

The PYTHON_AUTO code orders the preference for the PYTHON command to
be python3, python and then python2. python3 makes a more logical
preference as python2 is no longer supported:
https://www.python.org/doc/sunset-python-2/

Reorder the priority of the PYTHON command to be python2, python and
then python3.

Reported-by: John Garry <john.garry@huawei.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Tested-by: John Garry <john.garry@huawei.com>
---
 tools/perf/Makefile.config | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 73e0762092fe..16c1a87444b8 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -241,15 +241,15 @@ endif
 # Try different combinations to accommodate systems that only have
 # python[2][3]-config in weird combinations in the following order of
 # priority from lowest to highest:
-#   * python3-config
-#   * python-config
 #   * python2-config as per pep-0394.
+#   * python-config
+#   * python3-config
 #   * $(PYTHON)-config (If PYTHON is user supplied but PYTHON_CONFIG isn't)
 #
 PYTHON_AUTO := python-config
-PYTHON_AUTO := $(if $(call get-executable,python3-config),python3-config,$(PYTHON_AUTO))
-PYTHON_AUTO := $(if $(call get-executable,python-config),python-config,$(PYTHON_AUTO))
 PYTHON_AUTO := $(if $(call get-executable,python2-config),python2-config,$(PYTHON_AUTO))
+PYTHON_AUTO := $(if $(call get-executable,python-config),python-config,$(PYTHON_AUTO))
+PYTHON_AUTO := $(if $(call get-executable,python3-config),python3-config,$(PYTHON_AUTO))
 
 # If PYTHON is defined but PYTHON_CONFIG isn't, then take $(PYTHON)-config as if it was the user
 # supplied value for PYTHON_CONFIG. Because it's "user supplied", error out if it doesn't exist.
-- 
2.37.0.rc0.161.g10f37bed90-goog

