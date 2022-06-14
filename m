Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A91FCCA47E
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Jun 2022 14:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343667AbiFNOfS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Jun 2022 10:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240964AbiFNOeJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Jun 2022 10:34:09 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F99E369E1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jun 2022 07:34:07 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-30c14765d55so26862467b3.13
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jun 2022 07:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jlLUXMLBK64yscSUpLZfKbiaF8vfOQAkVnrzfyvEsEQ=;
        b=Rq2LH/kH8h16OGkoEDqaZztuc/ZNrRQpln9CWWY2rlmxP6xfWs+uX7GPgsLdw9hhbK
         iI/w0ywcMZ0+Jcuuu7SGFyOEUki/nvJsuSn+8WNytUMuCbFnMMvBIw+3T8hcj0/raMiP
         YV2/fFagV5ebYC8CoBSloDp60zD0BcYN03U6nZ9V8VbHO2TYxC4LMNTO6tjrCIWL2NPT
         l76f05GB8Kp+BKCIPnYqbGTTCEUSKU3VnJT+6nB+nQu8xkcaKfxi39W3k5psa2GNti7w
         lGxaB9Hw0jiBOFVV0tIL+ZqkV8ZRq6j6pcsVGYg7NOFJZskT+ramiaVCIy0bK5FfOc0v
         90lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jlLUXMLBK64yscSUpLZfKbiaF8vfOQAkVnrzfyvEsEQ=;
        b=nj/nW8eqHZtSPozFI0C99lpi8Od3xhlATdIXqgn1VLrCpgjQms6uNneSlGgWy3/Cze
         LmMsW7CGNjVUs6HpZGH73W6IYx0i+JSoUngnhiUFb8TNbj/ueJMy/1r2DtCux7oGekpF
         wYjbGGDviVAeKfDl+xr7faNmNZkZty6NH8ikYo8KEsqEAaHlfgJwPYzXJowohbSe+uag
         cZExlrvnlYHodi9MVsYNuI4kYFR/vRO68YF8Y+yPO/fzK8fKJAPprD7kNTjacf9lADFq
         hsJ0f0qGvKeNNKWAmM2jRAScPjXG6ugWTuoYe5fJNvhjyY4sSczFvZ7Vxn3FyKde5WvG
         rOGQ==
X-Gm-Message-State: AJIora/0JclKWI8tEGpYyzwNS6Q62GFtL1htSoeH8Gynk3Nf1T7nVtuz
        f2m2uUH/iAz8T1T4OgPjYGP3K6OTzz1w
X-Google-Smtp-Source: AGRyM1tFploq+20UVqYMG2V2Ds3SMLs4FHX4Vl/ncalQoNGj9rQow5MxoLBUK3lObTvjj6Lrd91tYger8G4/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:b55a:aaa7:a:1b17])
 (user=irogers job=sendgmr) by 2002:a25:b884:0:b0:664:7ce8:38f0 with SMTP id
 w4-20020a25b884000000b006647ce838f0mr5266397ybj.503.1655217246623; Tue, 14
 Jun 2022 07:34:06 -0700 (PDT)
Date:   Tue, 14 Jun 2022 07:33:50 -0700
In-Reply-To: <20220614143353.1559597-1-irogers@google.com>
Message-Id: <20220614143353.1559597-4-irogers@google.com>
Mime-Version: 1.0
References: <20220614143353.1559597-1-irogers@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v2 3/6] perf cpumap: Compute mask size in constant time
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        German Gomez <german.gomez@arm.com>,
        Colin Ian King <colin.king@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

perf_cpu_map__max computes the cpumap's maximum value, no need to
iterate over all values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index b8a42a096502..0d87df20ec44 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1213,18 +1213,7 @@ static size_t cpus_size(const struct perf_cpu_map *map)
 
 static size_t mask_size(const struct perf_cpu_map *map, int *max)
 {
-	int i;
-
-	*max = 0;
-
-	for (i = 0; i < perf_cpu_map__nr(map); i++) {
-		/* bit position of the cpu is + 1 */
-		int bit = perf_cpu_map__cpu(map, i).cpu + 1;
-
-		if (bit > *max)
-			*max = bit;
-	}
-
+	*max = perf_cpu_map__max(map).cpu;
 	return sizeof(struct perf_record_record_cpu_map) + BITS_TO_LONGS(*max) * sizeof(long);
 }
 
-- 
2.36.1.476.g0c4daa206d-goog

