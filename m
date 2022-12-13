Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27125C4332F
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Dec 2022 05:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbiLMFFy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Dec 2022 00:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbiLMFEy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Dec 2022 00:04:54 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8628B1EAFD
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Dec 2022 21:02:12 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id o31-20020a17090a0a2200b00219a2904952so1271233pjo.0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Dec 2022 21:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=38QYNRsCdXA58zmeiyEnX9qHG+LlKARQrs6L5bFJGmM=;
        b=ZwSzYgPKM3xNmtyHwDzsR/elgCiCTdCA3ZqyzuSeAgvVJ8+7DpbNxaihdfbMFmXeuL
         HgBMwlWo1NWTP2x/YhsXdFhL44+aPs1008/SjG/zaDdJmCW3SWx1RPMeAX0UHhwZ1dB8
         8Fi9t+CWwe0ZuXJKvdi1XZoW1OSqKpJTwXT+hFulAg//PsCAS2G3v+Spu0e+fRY6Z1/A
         LB3QYyxI3UllQI81PS1EMEsjB3q2ZlzGXLtlAMSGY5GYa8U/o9eP1Ep+jfqosc4izNvX
         3JwDAOJ8C1qLadDJiFSBMZ/r8/U9ltYDW0ox8kuE4eByWnJS9EXdMxzIpLw3c4YNzLlZ
         hS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=38QYNRsCdXA58zmeiyEnX9qHG+LlKARQrs6L5bFJGmM=;
        b=Tr2ERj5nKToSQtO5e+W/+14TPWktnyib4Wi0AWBQKd4oNMHkvo770QtUT/BfUz0EQ+
         O4XZNlnTSv8LhNXKW7ZstZAiAx85sOaNLrBxlQrP8bedglG63EYXSSSVk9W/f7DARwTl
         C44zYgObHnOQY7kDqDoQYUCNtExBMDb6mgcNCZSCURDK4ZScKFe36cN7i2Ov+xrwnwIE
         DmkUD5izYdFwCq7WhBldaVUmpUzyjMFcjn6PGRjJe4P6zZ39/je6UbNm+EtV9MypNjqf
         CndHPP+k4Lm0TyJ7ZhGKUNudeGoTpQgJgZS1BZdKWqIhfNU4yJhPoGxML/zHcCL1pfZV
         +QMA==
X-Gm-Message-State: ANoB5pl9DzWTJqNvBjcg6FdYtQW4EGbdmuayFHIGjSWdYqCp5ysCApMl
        eKo67kxMc38A4rSXWcc1NxFb422bxFkA
X-Google-Smtp-Source: AA0mqf5NjYnnJMl8dXHAzoxuTBUvXM+hRAmSW3b/0ORsS37wAy9f+GZghdscMj+Bkc+TpmYtEpMN7vyPtFnq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:6b9f:864c:28da:e99b])
 (user=irogers job=sendgmr) by 2002:a17:90a:684a:b0:219:8d8a:a644 with SMTP id
 e10-20020a17090a684a00b002198d8aa644mr140669pjm.174.1670907731914; Mon, 12
 Dec 2022 21:02:11 -0800 (PST)
Date:   Mon, 12 Dec 2022 21:00:40 -0800
In-Reply-To: <20221213050043.1199380-1-irogers@google.com>
Message-Id: <20221213050043.1199380-7-irogers@google.com>
Mime-Version: 1.0
References: <20221213050043.1199380-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Subject: [PATCH v1 6/9] perf jevents: Combine table prefix and suffix writing
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
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
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Combine into a single function to simplify, in a later change, writing
metrics separately.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 36 +++++++++++++-------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index ee3d4cdf01be..7b9714b25d0a 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -19,10 +19,10 @@ _sys_event_tables = []
 # JsonEvent. Architecture standard events are in json files in the top
 # f'{_args.starting_dir}/{_args.arch}' directory.
 _arch_std_events = {}
-# Track whether an events table is currently being defined and needs closing.
-_close_table = False
 # Events to write out when the table is closed
 _pending_events = []
+# Name of table to be written out
+_pending_events_tblname = None
 # Global BigCString shared by all structures.
 _bcs = None
 # Order specific JsonEvent attributes will be visited.
@@ -376,24 +376,13 @@ def preprocess_arch_std_files(archpath: str) -> None:
           _arch_std_events[event.name.lower()] = event
 
 
-def print_events_table_prefix(tblname: str) -> None:
-  """Called when a new events table is started."""
-  global _close_table
-  if _close_table:
-    raise IOError('Printing table prefix but last table has no suffix')
-  _args.output_file.write(f'static const struct compact_pmu_event {tblname}[] = {{\n')
-  _close_table = True
-
-
 def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
   """Add contents of file to _pending_events table."""
-  if not _close_table:
-    raise IOError('Table entries missing prefix')
   for e in read_json_events(item.path, topic):
     _pending_events.append(e)
 
 
-def print_events_table_suffix() -> None:
+def print_pending_events() -> None:
   """Optionally close events table."""
 
   def event_cmp_key(j: JsonEvent) -> Tuple[bool, str, str, str, str]:
@@ -405,17 +394,19 @@ def print_events_table_suffix() -> None:
     return (j.desc is not None, fix_none(j.topic), fix_none(j.name), fix_none(j.pmu),
             fix_none(j.metric_name))
 
-  global _close_table
-  if not _close_table:
+  global _pending_events
+  if not _pending_events:
     return
 
-  global _pending_events
+  global _pending_events_tblname
+  _args.output_file.write(
+      f'static const struct compact_pmu_event {_pending_events_tblname}[] = {{\n')
+
   for event in sorted(_pending_events, key=event_cmp_key):
     _args.output_file.write(event.to_c_string())
-    _pending_events = []
+  _pending_events = []
 
   _args.output_file.write('};\n\n')
-  _close_table = False
 
 def get_topic(topic: str) -> str:
   if topic.endswith('metrics.json'):
@@ -453,12 +444,13 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
 
   # model directory, reset topic
   if item.is_dir() and is_leaf_dir(item.path):
-    print_events_table_suffix()
+    print_pending_events()
 
     tblname = file_name_to_table_name(parents, item.name)
     if item.name == 'sys':
       _sys_event_tables.append(tblname)
-    print_events_table_prefix(tblname)
+    global _pending_events_tblname
+    _pending_events_tblname = tblname
     return
 
   # base dir or too deep
@@ -802,7 +794,7 @@ struct compact_pmu_event {
   for arch in archs:
     arch_path = f'{_args.starting_dir}/{arch}'
     ftw(arch_path, [], process_one_file)
-    print_events_table_suffix()
+    print_pending_events()
 
   print_mapping_table(archs)
   print_system_mapping_table()
-- 
2.39.0.rc1.256.g54fd8350bd-goog

