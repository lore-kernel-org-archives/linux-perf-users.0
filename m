Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADAAEE0212
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Sep 2023 02:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbjINCQh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Sep 2023 22:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbjINCQg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Sep 2023 22:16:36 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDD3198
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Sep 2023 19:16:32 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58f9db8bc1dso6776517b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Sep 2023 19:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694657792; x=1695262592; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YPKWPHjjLgKJy2fs1wzoXbOYUhtcDdJLgwEmq5NtHvM=;
        b=fAijsZ7WkIUEPTw63mkQ1ELlBsgin4u3ACUgLY+yyRhRp5u3GKN3QxHBmvfUlPKsLY
         /YwQYP9emhfzuQGtBYk0K+R4g3QcuEtpD7NTbZzIJXeFyhlHlfQLf9qM9LfzZHgVaWVj
         ni2om8qr+ye9mB4MmVBwxtMQ5VLLwcb9gfmzCxGK/94EZFWjFXPzrEcLgmKYcgjWkqfC
         PPCVctWK2emnFxtOmcePWUY64f447PbwOHrjWZqn9G/L7UzzzXd5suNkQygbEfhvdXz5
         IyIwxOTgRdywtCmFMhWRsTLAL/6GjLG682px8xGbpfJY3vukbSHrPbCzNZkxHBQ7p2Jy
         hB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694657792; x=1695262592;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YPKWPHjjLgKJy2fs1wzoXbOYUhtcDdJLgwEmq5NtHvM=;
        b=agyy0nVkeF6F9W2F296EW1ya8uotNU2V+VY9BRRPcfA5Ov3MEHfkCYZEirsWo4Jz3d
         wmWdh/IBPM1Jl9Y7wEn7L4X+QiecbvyHDLmUNVni7t5phMknUmxmTbvncGKFwU98uFOr
         3f93oaOOEo7J76ednR+iLM7PuMbOvptLV+0XdpqDMoHWnMdAyv3DqbPkRXRYTdTcshKW
         C4x8RRArYUV+rsRMqTjw788DHJs4GekF7KstEUFTBVItzpGlqKKTvqlzy9EJPsZC6a9N
         /0dTJLoBz4qCaV1NafKGFXqpne+62MhpmeukKjVOYiNVjGA1ORpJA02VpDeUNVE3KE4e
         EoTw==
X-Gm-Message-State: AOJu0Yyr/UcZh3ZK4sCKaWcQT06EuxZQ+5N4nneY8qwCiczm3o7bIx1Y
        mbOCPUXUlmuJCA+oyS1QyoAy0AfqT9Ip
X-Google-Smtp-Source: AGHT+IHgct12NXo2j/VT5NrnoFte0xgNrJBRPi8H7VZfSRZDlrbNYrNjODsaGwt//fsFVylXssLPAh57Rn5g
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7612:4bb6:bcf1:779c])
 (user=irogers job=sendgmr) by 2002:a05:690c:4683:b0:59b:f3a2:cd79 with SMTP
 id gx3-20020a05690c468300b0059bf3a2cd79mr933ywb.8.1694657791802; Wed, 13 Sep
 2023 19:16:31 -0700 (PDT)
Date:   Wed, 13 Sep 2023 19:16:27 -0700
Message-Id: <20230914021627.1475054-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Subject: [PATCH v1] perf jevents metric: Fix type of strcmp_cpuid_str
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
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The parser wraps all strings as Events, so the input is an
Event. Using a string would be bad as functions like Simplify are
called on the arguments, which wouldn't be present on a string.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 0e9ec65d92ae..3e673f25d5fd 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -413,10 +413,10 @@ def has_event(event: Event) -> Function:
   # pylint: disable=invalid-name
   return Function('has_event', event)
 
-def strcmp_cpuid_str(event: str) -> Function:
+def strcmp_cpuid_str(cpuid: Event) -> Function:
   # pylint: disable=redefined-builtin
   # pylint: disable=invalid-name
-  return Function('strcmp_cpuid_str', event)
+  return Function('strcmp_cpuid_str', cpuid)
 
 class Metric:
   """An individual metric that will specifiable on the perf command line."""
-- 
2.42.0.459.ge4e396fd5e-goog

