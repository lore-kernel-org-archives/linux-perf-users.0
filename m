Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E42C25B06
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Aug 2022 22:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239954AbiHDWTK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Aug 2022 18:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240041AbiHDWSv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Aug 2022 18:18:51 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5B86FA25
        for <linux-perf-users@vger.kernel.org>; Thu,  4 Aug 2022 15:18:40 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31f46b4759bso7696937b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Aug 2022 15:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=jj3QL2VB7yeMKctZCaHc1b4ABIGklkTL3vOmKj4cY9M=;
        b=naXkqYvmoVUVtTztzNIGjOQUWNikWsYOV4jgsyFyUFZsEVsaKf8MXMW+zQer81F4XC
         MiE02JVtmba5DXcB7DEo0SVOrShXwyh+1RvYubTHhKuCLHRZiY6lUCccPNhELDCPm8Vd
         /CTEf/hWXLcMlwY6vw/Ptfm2HOcv2cyC5i6A976rZx1jUi5s7RqHjsAUN0YER66k0dpn
         bbYxMXZWYUuTpnJD4Ln1S98YScsV3aZMxMAQWEG/Ssze9SKPp/I7o6xvEjlHYC6mSkaY
         vCYf59JQoZkWBuNWZqVb1OSW3LguO3UGRLk1uXRHG3QhiBsTITXT21K+IBjFNE/9nAqX
         sdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=jj3QL2VB7yeMKctZCaHc1b4ABIGklkTL3vOmKj4cY9M=;
        b=uiv4za2Je/1mMNrn4fBNeEK1C2wb2APMdUZVpA/R8ZwDNghgXQ77msAZYelakPOH4M
         XT4pkJ0/20If/vpc8e8p+n/jVGtle/mQ8jAyFHeZfK4sfWibiaHs10WhFq2pPIzKsKox
         WHGADVMkFjEhZELt93V57+VMduWs9zmwM8hK+dSxqBXogp5Ot3tVwh82KQjRWbjB+GnI
         cOdkt+HsGt12L+/iBccwMYjZ4ZOR6cvYkhNvWUBx8PUzgKHpMby3EW214gNrBgY89sT1
         7jRGGr2qe5WZZq8Xm4tMtZI0YiL8cP1D/uC0mIZ8PRdXrILb0lyqBxqGx6eTV2pAEliT
         lYzg==
X-Gm-Message-State: ACgBeo0qOo5AQUCbxG6NiQ2Bo1nlxGP6DygTKQ4mawE0mlJGUwzyHIj1
        zem6BFJ0S9sC5CmO8TB4i+3NhYw9JYQE
X-Google-Smtp-Source: AA6agR6rZdiG6AKqT8iby13icVKn/mvs7v0tmX3sdWha8vwGpee+4AOmvaAMXvvm9MSdbSfLPmP8mirEpP+p
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:f5e1:5bc5:7dab:2b7c])
 (user=irogers job=sendgmr) by 2002:a25:604:0:b0:676:c237:ddf0 with SMTP id
 4-20020a250604000000b00676c237ddf0mr3204397ybg.71.1659651519224; Thu, 04 Aug
 2022 15:18:39 -0700 (PDT)
Date:   Thu,  4 Aug 2022 15:18:05 -0700
In-Reply-To: <20220804221816.1802790-1-irogers@google.com>
Message-Id: <20220804221816.1802790-7-irogers@google.com>
Mime-Version: 1.0
References: <20220804221816.1802790-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v4 06/17] perf jevents: Provide path to json file on error
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
index 98d18d5c3830..12d2daf3570c 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -224,7 +224,12 @@ class JsonEvent:
 
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
2.37.1.559.g78731f0fdb-goog

