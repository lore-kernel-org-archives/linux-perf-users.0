Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49267C43334
	for <linux-perf-users@archiver.kernel.org>; Sat, 18 Jun 2022 00:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbiFRAJg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 17 Jun 2022 20:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237569AbiFRAJc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Jun 2022 20:09:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262F753B4F
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jun 2022 17:09:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e6-20020a259246000000b00668cc122ca7so1088467ybo.9
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jun 2022 17:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aNvZPcZ6zsNSg6KtWndLDA+9lA/85jhiUeKYeiO2xYM=;
        b=tZQhfdUlxkVHdSQ9eygwMrKDUAUz+USW0dvBG64jjkyFXjjI5krOud3NLmWbHll+ZC
         8CR8CA67oBPiEQo+waNiyeEXxDhtIsOETK+IcBfYhTjcdXLtSKLg1hQcoUDiTUBiVS60
         G2rDERffyMU4ZRm1WRM8qdfoJtQWjb2eeV8mbErFbLcThNpAj2WK+i+qY1tS8CgXwqUw
         245iikTNoxswXwUu0Bfs4eDSbiblBbCYeVahKn02+KvpzyP+CRprkqYisli3QBMKQ8rM
         0gY2Haw8FR08d2HqQKo+PxBcxFyRUy6eddPubYEM2YEoFxmHkJXVM+DcdXihcoGjMJT2
         80sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aNvZPcZ6zsNSg6KtWndLDA+9lA/85jhiUeKYeiO2xYM=;
        b=LtNvUG24vI6vwisVEdImu3r599PYZtTdFIc1u1bi+acAlA3EVkWcbL5dbP+3JTy+0n
         fcQRR2Vk5rEncGCml8/rXyQC4x8SdTaQ003DGIIe9H8QaeEsQjDJuzXA4VQfcAksSdTx
         iugXhm98+4W4X5xwgOm97d6FqCtosbNUwRxktje20WLRev3B7CFyzSzTDdoFWEz8RKIA
         pflNcmPyJUS3epE5uswznEwbzHbXOQEsWJZB79siVzGifk+QQX8MBk96P6zBdGldR3Gm
         H7kakMEy7UkIpRLAyFTtAhgGOl7EbC7Iqd+zS1Jy6EY+moNti/E8mzTJXcP/1xGFr+ka
         jDAg==
X-Gm-Message-State: AJIora9uFE15FZvXCmyi2G5sBuVt2UVaXu4JDFGNR9nQCQTk2Y/AVfTo
        7nfHSVkQa+AFGDAPscitRqS+V47YcFdE
X-Google-Smtp-Source: AGRyM1vqc15OOjIzeb0cg6mGMhHwQER/MhM6wLypfLF9/DTXTRXjJbM02U5t2NwIP19amW9V/u+EEHJTpgt+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:c89f:8969:c05d:79b6])
 (user=irogers job=sendgmr) by 2002:a81:1a4b:0:b0:30c:5063:6e67 with SMTP id
 a72-20020a811a4b000000b0030c50636e67mr14664731ywa.158.1655510968724; Fri, 17
 Jun 2022 17:09:28 -0700 (PDT)
Date:   Fri, 17 Jun 2022 17:09:04 -0700
In-Reply-To: <20220618000907.433350-1-irogers@google.com>
Message-Id: <20220618000907.433350-2-irogers@google.com>
Mime-Version: 1.0
References: <20220618000907.433350-1-irogers@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v6 1/4] perf python: Prefer python3
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
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The PYTHON_AUTO code orders the preference for the PYTHON command to
be python3, python and then python2. python3 makes a more logical
preference as python2 is no longer supported:
https://www.python.org/doc/sunset-python-2/

Reorder the priority of the PYTHON command to be python2, python and
then python3.

Reported-by: John Garry <john.garry@huawei.com>
Signed-off-by: Ian Rogers <irogers@google.com>
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
2.36.1.476.g0c4daa206d-goog

