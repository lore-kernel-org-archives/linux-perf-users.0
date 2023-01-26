Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B044AC27C76
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Jan 2023 01:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbjAZBUk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 25 Jan 2023 20:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjAZBUj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 Jan 2023 20:20:39 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DBF64DA0
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Jan 2023 17:20:10 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4597b0ff5e9so3943997b3.10
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Jan 2023 17:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rOKzY9YOyxiZd0jwhBCOLQV0VT54WWM+lqROihc/Rhw=;
        b=szv/8QdNSp2myZhetiv+HBlEzrYqtH54GGv+4csDy6tkYmSOpnwfgd8SizPlPCYMl7
         BT6unBlOqiizZhkCKtirqUKAZTutPbk+WAeKe7xm3Ow/tYJ14SOscBOib2QVMdyNR6zB
         2xayHzwqsTnWj4IiJgAMl16SvkORUua1H9c/vUE/6NI79psnvhHOqeOzS3HYg3gaMmxF
         ru/Zv+iHMCvLUZka9TjOqZsGj5e6oa6sEttZPrLbZ1hsRpoKwaXVB4k6EPEIa0Q590Og
         rmo9oyt5YAwjFm/Elbc5lfpNIymEOGJkMDdEFC5+t4yLjuRfFwiR4WFccmMnSJTVuf2P
         RVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOKzY9YOyxiZd0jwhBCOLQV0VT54WWM+lqROihc/Rhw=;
        b=4K65vwA0ovEsDelO984y0lmxJxNtbRVsVW7tZAvI5nDG97YdpyzIjzN4v2B5D2vzaX
         DehNa7rDbOe0gFsfepB1glpBCcMbsxgQgCd7uQ2/de6w6euTHjpyJzWmKsE85Np/pm5F
         T6W9Ert+F+Z+w72KY75iDyEh6JlIhytOEdUoDML2MuxcX7+n73Ycpi41IoP3QTEQLaMR
         /CZnUj2KntTF2khqwSXYBFA8cuJbH8aSN8YZQ2033iyawN8him7WjoykdimzkgDTPwwb
         hRwuiMz/+Spy0WG/SJ+fYnqFRr2Msf4zJeYonXYhu8TQ7b8/ZR4uXlPSoIf4B/g4r/2P
         aeNA==
X-Gm-Message-State: AFqh2koAXQ1B7g3DD2BMpqnU92eHt8IRt6RiWyivIE5UiX+zsDFfvf11
        bpE8GtOL5s49kWbK/sTykKbVkhpAkzOQ
X-Google-Smtp-Source: AMrXdXvF8lJSvZWcavK7Q1tHKy9uwBax3i34mr7oaH67rab6/l55Wb54YSMzQO04ft9SdijBc4q9I+5h24Lm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:568d:4d98:b468:b025])
 (user=irogers job=sendgmr) by 2002:a25:8b82:0:b0:75e:ca27:ca65 with SMTP id
 j2-20020a258b82000000b0075eca27ca65mr4100382ybl.464.1674696009789; Wed, 25
 Jan 2023 17:20:09 -0800 (PST)
Date:   Wed, 25 Jan 2023 17:18:50 -0800
In-Reply-To: <20230126011854.198243-1-irogers@google.com>
Message-Id: <20230126011854.198243-9-irogers@google.com>
Mime-Version: 1.0
References: <20230126011854.198243-1-irogers@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v4 08/12] perf jevents: Combine table prefix and suffix writing
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
index 4cdbf34b7298..5f8d490c7269 100755
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
@@ -378,24 +378,13 @@ def preprocess_arch_std_files(archpath: str) -> None:
           _arch_std_events[event.metric_name.lower()] = event
 
 
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
@@ -407,17 +396,19 @@ def print_events_table_suffix() -> None:
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
@@ -455,12 +446,13 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
 
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
@@ -809,7 +801,7 @@ struct compact_pmu_event {
   for arch in archs:
     arch_path = f'{_args.starting_dir}/{arch}'
     ftw(arch_path, [], process_one_file)
-    print_events_table_suffix()
+    print_pending_events()
 
   print_mapping_table(archs)
   print_system_mapping_table()
-- 
2.39.1.456.gfc5497dd1b-goog

