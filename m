Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FD8C43334
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Jul 2022 06:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiGOGhr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Jul 2022 02:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiGOGhf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Jul 2022 02:37:35 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E264E858
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Jul 2022 23:37:27 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31c89c753b3so33923127b3.5
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Jul 2022 23:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oNv4/zk1+mjyJIqC7KPNbf+jkGA2kI+7rQYeIFSNhZY=;
        b=Mpd1GjFJ9InS1ooJdyFxyNnJqwScVucDO7ehk16fZYUtOO6hqoqzN/DHXWInmUD1aK
         mGDqogxpxrmTlutbkwRfyGYoCIqUOhhUz4hcw7CiMRDBTFtBxiWaHp4ijjCHfRVC/TrX
         UDTPrUhfylNHbSepVnUZomdkuvy9HCqKGoQ/bSrQFnwdMCBtyzVEnMflByoNccWF+GsR
         CdVmGrTWaPVZI/PuSu/ng6tcVX9SZGx1vzDsJGLnbXuzwEgDYfGPchfz2Aqgn8GDdBX/
         Qoni9TFh7w4lyPt0QnNdmI63icwlKFgpnAwTY7NYfEJc2gL7Ghe7dZh8+q0v18IVoG64
         3Kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oNv4/zk1+mjyJIqC7KPNbf+jkGA2kI+7rQYeIFSNhZY=;
        b=mMayZCqEa2zNCavXI3z1pAva8yUqRR/ohxJF+B/lX96+gz6U3HHTuSfVDRmsBVzZ7N
         9mTf+xXMJU+ueHwInXend+54Z5NFN7c9O1+D6rMsx7UGAlQzAo/nrbIPapI2TitP9oEw
         4D4q0NmswEJ/nlAIX6qqoknYjtOEyT8Eu1lkfxzJEDUyuzMWfql77qA09ALH3o6ekCFx
         msU6SeOoGICf7IgcNFY/8lOdzx67jH0KfDdRNjBRVyrbwlt4PosZuP+VNJghBgjrO9y0
         OfUOa9jUZrHmId8Py/3Y6RHiJT/RwALHoWyLlW+DGL2za10Z/k3KAYilCJUOpOTMIoCn
         I/Eg==
X-Gm-Message-State: AJIora+UqBhstPEXk5TEmK+XPSWvnwV0E3dNRJR5qCIRww5MjkTQil8t
        XAVZM7AMcS02SdKmFmoMerFdnL7HFLoQ
X-Google-Smtp-Source: AGRyM1t7KCgLWCt2hEcOCq4fDH+oYV3WDSVG9zEdbtZELrdsky27kk4fzOhKyzwMgRxo9S+WlVPNS4PjAqu7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e8fe:2a8e:e0f6:318d])
 (user=irogers job=sendgmr) by 2002:a0d:e60d:0:b0:31c:8046:8ff with SMTP id
 p13-20020a0de60d000000b0031c804608ffmr14288131ywe.412.1657867046502; Thu, 14
 Jul 2022 23:37:26 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:36:43 -0700
In-Reply-To: <20220715063653.3203761-1-irogers@google.com>
Message-Id: <20220715063653.3203761-6-irogers@google.com>
Mime-Version: 1.0
References: <20220715063653.3203761-1-irogers@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v1 05/15] perf jevents: Provide path to json file on error
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
index c53c744da56b..7d5110327468 100755
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
2.37.0.170.g444d1eabd0-goog

