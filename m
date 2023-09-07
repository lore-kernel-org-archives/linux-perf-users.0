Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FDEEC875C
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Sep 2023 21:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjIGVFo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Sep 2023 17:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjIGVFn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Sep 2023 17:05:43 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8371BCB
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Sep 2023 14:05:38 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58e49935630so25092167b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Sep 2023 14:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694120737; x=1694725537; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dnyMsDgiX5vgIpgNk8THjYlZnq9260AQc9Onv7oS0O8=;
        b=XPD77feUZ4xInmA0jtgTl8BMRlL8A99/aZ42tYalUhBIMur5rr8oGdTfHFrrp+dCOx
         2p+CCrs0/k1eCnPvlH/FrRdi8ViYBG0BAQ7B4PpOsP6ebuuJODJ8EcoPvYLAdyxWPBrO
         pR0F9Jt7zdyTIyL1aabh27GaBamVo/ju+l5fUq/u/8Bm7ReqJopKHQPMHkU3nazyp9AC
         46FK2YCT24mZFaFluhb+acUhgL8OHl9ESGoFE6O3FTB8Cik/4aa13MdbKTDBFycuB/rR
         IZ4DpxpZKGhIl/H8ADA9rCmmuXfBkFvO6RLlJS4+9HSkwIrQc8w4h13CqxUm+MT2SsMg
         khVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694120737; x=1694725537;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dnyMsDgiX5vgIpgNk8THjYlZnq9260AQc9Onv7oS0O8=;
        b=ZzPJ3wpZq1JbGWgyoAAOwZxvvVwkri2/bUcy4kULUXLjICyPPYUQBj7A5dhed4QeGN
         lz2TtzqEAMrmtWU9l8N4AApM+LjT6m9KESBa2etwTMTwqK5goMPX4TBbTcWrRtXaEoFP
         8i0I/cHKBAF98QFkr6WD6U2m/ecJXgX7v2/IRPz6M7BPkWKVZDOdQG9S+6k4C3FuqgNC
         6+Q/s6JyYamYHXyT9KqSd//3sGGP9lbMy4kGKkRY/fd1OKdjX4TbBBVzj/gWUYt89b7E
         X+iaRqC+Tt6WNAD/3+BeTJdRB3T9cwuzaJmFwtWT/l2TSmJG+50IIf72kukI4uKRnWLy
         4I/w==
X-Gm-Message-State: AOJu0Yzh/hs+AQxrrNmfVnTyTPw3te+yHmz4h64pVV5jc+TzksfdWl/Q
        Q7aVIPzZwX/0w9NcoOCUUCKoPLoC8bjI
X-Google-Smtp-Source: AGHT+IGTPbYEN9QntgCC8Qk74o1xFC3ceEtnfcYbnQvG1l9e5gI3/scYqclOQxzhCRBR5VqtB1seyJB6RyI7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e535:39a0:5730:b9dd])
 (user=irogers job=sendgmr) by 2002:a81:e244:0:b0:595:9e93:60c8 with SMTP id
 z4-20020a81e244000000b005959e9360c8mr108471ywl.1.1694120737296; Thu, 07 Sep
 2023 14:05:37 -0700 (PDT)
Date:   Thu,  7 Sep 2023 14:05:33 -0700
Message-Id: <20230907210533.3712979-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1] perf parse-events: Avoid erange from hex numbers
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
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

We specify that a "num_hex" comprises 1 or more digits, however, that
allows strtoull to fail with ERANGE. Limit the number of hex digits to
being between 1 and 16.

Before:
```
$ perf stat -e 'cpu/rE7574c47490475745/' true
perf: util/parse-events.c:215: fix_raw: Assertion `errno == 0' failed.
Aborted (core dumped)
```

After:
```
$ perf stat -e 'cpu/rE7574c47490475745/' true
event syntax error: 'cpu/rE7574c47490475745/'
                         \___ Bad event or PMU

Unable to find PMU or event on a PMU of 'cpu'

Initial error:
event syntax error: 'cpu/rE7574c47490475745/'
                         \___ unknown term 'rE7574c47490475745' for pmu 'cpu'

valid terms: event,pc,edge,offcore_rsp,ldlat,inv,umask,frontend,cmask,config,config1,config2,config3,name,period,percore,metric-id
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
```

Issue found through fuzz testing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.l | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 4ef4b6f171a0..f7df52b22c39 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -156,8 +156,8 @@ event_pmu	[^,{}/]+[/][^/]*[/][^,{}/]*
 event		[^,{}/]+
 
 num_dec		[0-9]+
-num_hex		0x[a-fA-F0-9]+
-num_raw_hex	[a-fA-F0-9]+
+num_hex		0x[a-fA-F0-9]{1,16}
+num_raw_hex	[a-fA-F0-9]{1,16}
 name		[a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]!\-]*
 name_tag	[\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
 name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
-- 
2.42.0.283.g2d96d420d3-goog

