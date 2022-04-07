Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0AFC4332F
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Apr 2022 23:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbiDGXHY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Apr 2022 19:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiDGXHX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Apr 2022 19:07:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB03EECB20
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Apr 2022 16:05:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n207-20020a25d6d8000000b0063bd7a74ae4so5249504ybg.21
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Apr 2022 16:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WfvJj1m2gyFhMYgsgYi4914wWZZ5tzxnbwOex5ZNN7c=;
        b=G2lGhIKmig3u+8Ub/UZePe7b5WEYGKMuUAK5QddQmOTd95nRvbGk6CftAlO2mjIBqj
         fPSTJsBbSAHeP0HU+7B2e4hekgOS6WUOmus9G4U8A5BKCccxPMQavp6ueLLXnIqrpp9W
         k48zTkXZ7RDlkF66BC95dDcZ2Wi7Ya8X7ZEoLGq9dis2TED2GK/4KTYERmB/4bka3Vpt
         A+GyNY9K5bb9rV/hMtmX6Li0uXHQiX6LBymKd2xC9/6FiRxau7bU9mnhkwPdullG+1P0
         dnWNY0jWwl30VGEcSl3GzMVqsXYFzxW8rMiHlaWLZA3zi9RAXZ6VLuyDmmBR/YH9wwkp
         OSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WfvJj1m2gyFhMYgsgYi4914wWZZ5tzxnbwOex5ZNN7c=;
        b=GbLwYP52RMn45wkJGx9AeRnc423jWcZFO+wKSl2AV4smKadbZZM7RUSwKRUP76ksQu
         YxZTNpKOhLXgX+iadGFJHDl/4ZidquLJwVIvaKfibbZ0638qkaaz2B48jRHFO81s0dVx
         yM/05qsXVgDWE6uQnOVqOzUg/O0aeCGTW8uuqM3rQX+Rb20k5bieg9jLvStTzIQnu47I
         mlO6JS9H5+H+V7PrvINkw9E42sk1Mqj0CFnI991XdSXOEYRbUT3K0PbE7GVbysZOG2zS
         x2E/u46E9RpVJ9BgLDIPqdwUhsbqhQwAUMsYAbAWUbpoLKIMNBx3oGGjuKqYSGr4+yik
         eU5Q==
X-Gm-Message-State: AOAM531bJEYEUPvFtbFwWeRUHpXSgThxqeRSOiJ8C/AzXWC4+5mGQPku
        ys6bULHR3RtO5OTNQo4uXv0OXZCixwuk
X-Google-Smtp-Source: ABdhPJzHPc5JHRaajp14gJSR1JqmyinEoG5M4+QbCs6ofW0PQZulXHx6/8KCUTfl6DQ+O36TSTdCFPTtU9uk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:560:aa27:649e:a07d])
 (user=irogers job=sendgmr) by 2002:a25:8483:0:b0:63d:9504:8a14 with SMTP id
 v3-20020a258483000000b0063d95048a14mr11903156ybk.183.1649372721877; Thu, 07
 Apr 2022 16:05:21 -0700 (PDT)
Date:   Thu,  7 Apr 2022 16:05:02 -0700
In-Reply-To: <20220407230503.1265036-1-irogers@google.com>
Message-Id: <20220407230503.1265036-5-irogers@google.com>
Mime-Version: 1.0
References: <20220407230503.1265036-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH 4/5] perf symbol: By default only fix zero length symbols
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ian Rogers <irogers@google.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Li Huafei <lihuafei1@huawei.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        William Cohen <wcohen@redhat.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Lexi Shao <shaolexi@huawei.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Denis Nikitin <denik@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

For architectures without a specific end fixup (ie not arm64, powerpc,
s390) only fix up the end of zero length symbols. This reverts the
behavior introduced by:
https://lore.kernel.org/lkml/20220317135536.805-1-mpetlan@redhat.com/
where non-zero length symbols were expanded to the start of the current
symbol.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 087cdf2a58c9..59c562316d75 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -104,7 +104,8 @@ static int prefix_underscores_count(const char *str)
 void __weak arch__symbols__fixup_end(struct symbol *p, struct symbol *c,
 				     bool is_kernel __maybe_unused)
 {
-	if (p->end == p->start || p->end != c->start)
+	/* If the previous symbol is zero length, make its end the start of the current symbol. */
+	if (p->end == p->start)
 		p->end = c->start;
 }
 
-- 
2.35.1.1178.g4f1659d476-goog

