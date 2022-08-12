Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4641AC00140
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Aug 2022 23:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbiHLXKN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 12 Aug 2022 19:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbiHLXKF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 Aug 2022 19:10:05 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D640B9C20F
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Aug 2022 16:10:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 137-20020a250b8f000000b0067a5a14d730so1805580ybl.12
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Aug 2022 16:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=kPWsuFqycsY/yXV7nCgwsjWW6XxROqmLrLkaSuTFd4g=;
        b=rxjmjQpKDzS7G0C+9MAaUX4sdS40WxnORu9wsxkeSrzBbIrDyTkkvDdpH9Q4fDq8rv
         1FOwsDUFhyxtnNTlFm6bk8FTSLFgIBQ165feaBrjBbixMZJwjPDgJ0CJj5Voqz+MkcQS
         OFgBH5grTkKZLqcw2VK454e2fsMWDO0JnCawPq2l1SUWr6xLR5EgVvfwE8fckI/afazp
         eqxmT0m8FcGQhtrYM4PiGWk3w7id6oFmXcUnSOtSY9RELqp668za8mOdYexpauzIhvId
         N/VBFb8oVV+dICkKxaQSjifY+Noxt1g+iTpl/iNknx39MS5junx0m4Esj/91UL3vvegX
         T50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=kPWsuFqycsY/yXV7nCgwsjWW6XxROqmLrLkaSuTFd4g=;
        b=7W/1+9YYJbVEty8muE3cIOuCJjKT2iiTF541HNlqFW3DlMnM7az3t4ECJ5LOaHk7tE
         cEFgH0lytAT7ju7P2Yxh6dSrddca9v0cy4D4ZSuZXs3mXjxzFRrIG4nAgBoQqzIjKSOP
         SB2NOKF0Ny7DRl3F3vkeh2F1akV/A1lCAsxsJ4GKr+lSP7lvD+IHwqZLZua4g9Qu2Auz
         zf48c9eXT2eYXyl+aTxctnLcvDWxEQgxiQWAcEk/UE83B70dX0KJDcmPvlLV+Ema93Bc
         UCoCdqhu4CDGOesmlkqMrnjKVK9EEI+8gdnesJDEOoeKI880o0Ey/rAY4BWulLB1W4l9
         ueww==
X-Gm-Message-State: ACgBeo2Ty12jj4N1J5sReADJDNkpxdK2H3K645cVM27dxpNw+3/4mpGt
        gffmc0+awDHTkNgkZjBgyr/UG4mBlh0K
X-Google-Smtp-Source: AA6agR4VKEloBEmRShMw7+2nW0kl6o1FN+BGq8FKr+/u4UHKzqmgJpZpOlb1g2Fk8WRnCpI/DvA74SydZdIy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:d668:2937:8218:c5ec])
 (user=irogers job=sendgmr) by 2002:a81:1016:0:b0:31e:63f8:483d with SMTP id
 22-20020a811016000000b0031e63f8483dmr5606640ywq.199.1660345802166; Fri, 12
 Aug 2022 16:10:02 -0700 (PDT)
Date:   Fri, 12 Aug 2022 16:09:38 -0700
In-Reply-To: <20220812230949.683239-1-irogers@google.com>
Message-Id: <20220812230949.683239-4-irogers@google.com>
Mime-Version: 1.0
References: <20220812230949.683239-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v5 03/14] perf jevents: Provide path to json file on error
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

If a JSONDecoderError or similar is raised then it is useful to know the
path. Print this and then raise the exception agan.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 8e8462cb359b..31936eafa9ff 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -225,7 +225,12 @@ class JsonEvent:
 
 def read_json_events(path: str) -> Sequence[JsonEvent]:
   """Read json events from the specified file."""
-  return json.load(open(path), object_hook=lambda d: JsonEvent(d))
+
+  try:
+    return json.load(open(path), object_hook=lambda d: JsonEvent(d))
+  except BaseException as err:
+    print(f"Exception processing {path}")
+    raise
 
 
 def preprocess_arch_std_files(archpath: str) -> None:
-- 
2.37.1.595.g718a3a8f04-goog

