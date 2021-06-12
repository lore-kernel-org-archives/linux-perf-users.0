Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669B1C48BCF
	for <linux-perf-users@archiver.kernel.org>; Sat, 12 Jun 2021 17:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 325E061186
	for <linux-perf-users@archiver.kernel.org>; Sat, 12 Jun 2021 17:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhFLRsQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 12 Jun 2021 13:48:16 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:37422 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhFLRsP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 12 Jun 2021 13:48:15 -0400
Received: by mail-wm1-f43.google.com with SMTP id f16-20020a05600c1550b02901b00c1be4abso10421609wmg.2;
        Sat, 12 Jun 2021 10:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=75mouw3BFiq70jHhBUAkpXJpGq2eH3Umtp3XMvh/izM=;
        b=QNeaRBMlgWsTqyJVbHik85vIm39QVMvDWe2pzmH92pwSCPQsg9sAC1eXoatsz+iorl
         MDaGxjKWEloqO6GYMQdI+SujA+qv2lE509kL6xKKZmzNlvrMBNCwbDGO6EYvy/4H94Sr
         Fy9wopCfHlvNf/l/Fe/99J/65IC+dJveMwypjb6De2G6jG9BZO1Y2rqOQz0OfMyentNT
         gKzettbSYW1F/11jx36sGqfQ0buSMcOTO4SF2dub8VaDegkmloLJlEWZz6F7enGk/2PS
         JZ9pdY4VwlrAa5dUxmyzvHyrcTWVpOSn4+esS6Yoaehyta1FqSfu3WDO99dg+HPqLMv1
         q1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=75mouw3BFiq70jHhBUAkpXJpGq2eH3Umtp3XMvh/izM=;
        b=jH6Se/zNct+/BLt/mjEc4DrW6CuUJkHuPbBTAMphyT9NYWQ4eWOAQIeU6Tj7+LmWBG
         ikjLg8Z3K9EWiaDBF6rG82Darym/KL3ldcGaU+IukuvTfIE5pNNZGPHC8sfXeJL1p501
         PX/0+Blk0q2nP7fjx4VO7sysl2V1YKLNiwxlRiOByvkrUIZ+Z72iZ9mNZxZwvvKjxf6m
         VbBaEfytRG/oLHa/d6g/TakAlxadnRyIPQUNHOjTtmvuvoiW/gZc8CJ6SPpKrIxHcWBv
         JU6vwUI5X4EuWWOARVj5c7eiapVy5wsq9V73nC3wDCSE4Ji8YE7Xs/BxBBHoROf7uonx
         AWNQ==
X-Gm-Message-State: AOAM530XDXVJSoO3j0AjjR0rTPaRB98G/gPNz2wBJ1hk5+uiuC2X+pBa
        ooCX1tERR6y7OAN6ZK7IAKM=
X-Google-Smtp-Source: ABdhPJxA5Vnvc29Cs0erprdLZGKvqa0DkfM6awxCUvixIbm7gxStLfraZ0j6OEKADu549uOQoC9MvA==
X-Received: by 2002:a05:600c:3555:: with SMTP id i21mr11037678wmq.51.1623519900818;
        Sat, 12 Jun 2021 10:45:00 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id z11sm11147366wrs.7.2021.06.12.10.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 10:44:59 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf ksymbol: fix memory leak: decrease refcount of map and dso
Date:   Sat, 12 Jun 2021 19:37:48 +0200
Message-Id: <20210612173751.188582-1-rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <YLpxDf6+YOxYI5z3@kernel.org>
References: <YLpxDf6+YOxYI5z3@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reported a memory leak of BPF-related ksymbols
map and dso. The leak is caused by refount never
reaching 0, due to missing __put calls in the function
machine__process_ksymbol_register.
Once the dso is inserted in the map, dso__put should be
called (map__new2 increases the refcount to 2).
The same thing applies for the map when it's inserted
into maps (maps__insert increases the refcount to 2).

$ sudo ./perf record -- sleep 5
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.025 MB perf.data (8 samples) ]

=================================================================
==297735==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 6992 byte(s) in 19 object(s) allocated from:
    #0 0x4f43c7 in calloc (/home/user/linux/tools/perf/perf+0x4f43c7)
    #1 0x8e4e53 in map__new2 /home/user/linux/tools/perf/util/map.c:216:20
    #2 0x8cf68c in machine__process_ksymbol_register /home/user/linux/tools/perf/util/machine.c:778:10
    [...]

Indirect leak of 8702 byte(s) in 19 object(s) allocated from:
    #0 0x4f43c7 in calloc (/home/user/linux/tools/perf/perf+0x4f43c7)
    #1 0x8728d7 in dso__new_id /home/user/linux/tools/perf/util/dso.c:1256:20
    #2 0x872015 in dso__new /home/user/linux/tools/perf/util/dso.c:1295:9
    #3 0x8cf623 in machine__process_ksymbol_register /home/user/linux/tools/perf/util/machine.c:774:21
    [...]

Indirect leak of 1520 byte(s) in 19 object(s) allocated from:
    #0 0x4f43c7 in calloc (/home/user/linux/tools/perf/perf+0x4f43c7)
    #1 0x87b3da in symbol__new /home/user/linux/tools/perf/util/symbol.c:269:23
    #2 0x888954 in map__process_kallsym_symbol /home/user/linux/tools/perf/util/symbol.c:710:8
    [...]

Indirect leak of 1406 byte(s) in 19 object(s) allocated from:
    #0 0x4f43c7 in calloc (/home/user/linux/tools/perf/perf+0x4f43c7)
    #1 0x87b3da in symbol__new /home/user/linux/tools/perf/util/symbol.c:269:23
    #2 0x8cfbd8 in machine__process_ksymbol_register /home/user/linux/tools/perf/util/machine.c:803:8
    [...]

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 3ff4936a15a4..da19be7da284 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -776,10 +776,10 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		if (dso) {
 			dso->kernel = DSO_SPACE__KERNEL;
 			map = map__new2(0, dso);
+			dso__put(dso);
 		}
 
 		if (!dso || !map) {
-			dso__put(dso);
 			return -ENOMEM;
 		}
 
@@ -792,6 +792,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		map->start = event->ksymbol.addr;
 		map->end = map->start + event->ksymbol.len;
 		maps__insert(&machine->kmaps, map);
+		map__put(map);
 		dso__set_loaded(dso);
 
 		if (is_bpf_image(event->ksymbol.name)) {
-- 
2.23.0

