Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ED7C00144
	for <linux-perf-users@archiver.kernel.org>; Fri, 29 Jul 2022 07:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbiG2Hom (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 29 Jul 2022 03:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbiG2HoV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 29 Jul 2022 03:44:21 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E762814AE
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jul 2022 00:44:20 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id cu3-20020a056a00448300b0052ae559108fso1643433pfb.9
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jul 2022 00:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3yOwoFZ3Wf3i4mCbDyBSkX0NefzV6upIW3aFDzVLgcY=;
        b=XWlzqABpM6mfUKHqdgs03Q1OMATyLjTsT+obDuGtUoYQ2Suf2CieHkfRGSuBk1qCQK
         Z46IBmlwp0snGR8PF6G3rEx+eyM/ooZGwfJW5c9kwfQJu5Nt70RO1H+DIQB6skalORNq
         bGzIvYaFCAXGHbNgsrUYxVgjSz8OLHmNtmkOoe+6A5YrHwEqFHyi8we11fObjVt6S/C8
         6Zg/qKT7coGx4Fp2xCxAN/Odl7C6L6nOkddiN3Xaju1DvmFhrwnqaPxprBUpOdECobUe
         M3+xJVc0ROzH332G6SyXz+AQhsv9Ulan8vnh/pb3n7tS8CIQ/JGH1gZra1+1IRThykpB
         cauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3yOwoFZ3Wf3i4mCbDyBSkX0NefzV6upIW3aFDzVLgcY=;
        b=o+xafPy0YcsHVOxI/xNphZUWTNcwg4Ly3yVMkqADWF2s34nW70eXNQ03huZkWGdAjc
         QKrIk5m8Xlq0jJTM4/SUM82QI88U4k1h9oj2f5LosbCd7LLPeHWiPmG0qCtgKCW4911h
         UylYYwWxlasiFymbpEeXQCPweos1HmlPopb5nOzsYCT4RWybb4GnRKcoOYKlTQy9+CNO
         hBXW4HaPGxZkTaTUzpNbuWnUtgZDiK1q+WSpat6HdJtYuKQjePKBjRyUNFW4e/7y+CK6
         OoH+QkA+VzvihXaMaJwdyWj2VHi3KeGRgQolwQfrace8UZ/R4ey/L73vzs707GGlI1fD
         fSUw==
X-Gm-Message-State: ACgBeo2cxmYietMMK+I5D5F8uLP7qF1HOnzjp1m3ULEc0SOfwgNW1DWM
        cz2KOApJxVTXKiB3SzQkCxkXhyTBaQZv
X-Google-Smtp-Source: AA6agR4X2OdUFG3Qzn8PCM8EFybFzGARwPe8r1WhL3LwDYzR0P8x9tl8f4DrUGUCiSqSNOhjh2ZjnCQFRyF6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:524b:47b4:2aeb:1b49])
 (user=irogers job=sendgmr) by 2002:a17:90a:94c2:b0:1f3:2590:8693 with SMTP id
 j2-20020a17090a94c200b001f325908693mr3400234pjw.153.1659080659864; Fri, 29
 Jul 2022 00:44:19 -0700 (PDT)
Date:   Fri, 29 Jul 2022 00:43:41 -0700
In-Reply-To: <20220729074351.138260-1-irogers@google.com>
Message-Id: <20220729074351.138260-8-irogers@google.com>
Mime-Version: 1.0
References: <20220729074351.138260-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v3 07/17] perf jevents: Sort json files entries
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

Sort the json files entries on conversion to C. The sort order tries to
replicated cmp_sevent from pmu.c so that the input there is already
sorted except for sysfs events.

Add the topic to JsonEvent on reading to simplify. Remove an unnecessary
lambda in the json reading.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 48 +++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 12d2daf3570c..30e0e792221a 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -18,6 +18,8 @@ _sys_event_tables = []
 _arch_std_events = {}
 # Track whether an events table is currently being defined and needs closing.
 _close_table = False
+# Events to write out when the table is closed
+_pending_events = []
 
 
 def removesuffix(s: str, suffix: str) -> str:
@@ -127,6 +129,7 @@ class JsonEvent:
       eventcode |= int(jd['ExtSel']) << 8
     configcode = int(jd['ConfigCode'], 0) if 'ConfigCode' in jd else None
     self.name = jd['EventName'].lower() if 'EventName' in jd else None
+    self.topic = ''
     self.compat = jd.get('Compat')
     self.desc = fixdesc(jd.get('BriefDescription'))
     self.long_desc = fixdesc(jd.get('PublicDescription'))
@@ -199,7 +202,7 @@ class JsonEvent:
         s += f'\t{attr} = {value},\n'
     return s + '}'
 
-  def to_c_string(self, topic_local: str) -> str:
+  def to_c_string(self) -> str:
     """Representation of the event as a C struct initializer."""
 
     def attr_string(attr: str, value: str) -> str:
@@ -211,25 +214,27 @@ class JsonEvent:
       return attr_string(attr, getattr(self, attr))
 
     s = '{\n'
-    s += f'\t.topic = "{topic_local}",\n'
     for attr in [
         'aggr_mode', 'compat', 'deprecated', 'desc', 'event', 'long_desc',
         'metric_constraint', 'metric_expr', 'metric_group', 'metric_name',
-        'name', 'perpkg', 'pmu', 'unit'
+        'name', 'perpkg', 'pmu', 'topic', 'unit'
     ]:
       s += str_if_present(self, attr)
     s += '},\n'
     return s
 
 
-def read_json_events(path: str) -> Sequence[JsonEvent]:
+def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
   """Read json events from the specified file."""
 
   try:
-    return json.load(open(path), object_hook=lambda d: JsonEvent(d))
+    result = json.load(open(path), object_hook=JsonEvent)
   except BaseException as err:
     print(f"Exception processing {path}")
     raise
+  for event in result:
+    event.topic = topic
+  return result
 
 
 def preprocess_arch_std_files(archpath: str) -> None:
@@ -237,7 +242,7 @@ def preprocess_arch_std_files(archpath: str) -> None:
   global _arch_std_events
   for item in os.scandir(archpath):
     if item.is_file() and item.name.endswith('.json'):
-      for event in read_json_events(item.path):
+      for event in read_json_events(item.path, topic=''):
         if event.name:
           _arch_std_events[event.name.lower()] = event
 
@@ -251,19 +256,36 @@ def print_events_table_prefix(tblname: str) -> None:
   _close_table = True
 
 
-def print_events_table_entries(item: os.DirEntry, topic: str) -> None:
-  """Create contents of an events table."""
+def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
+  """Add contents of file to _pending_events table."""
   if not _close_table:
     raise IOError('Table entries missing prefix')
-  for event in read_json_events(item.path):
-    _args.output_file.write(event.to_c_string(topic))
+  for e in read_json_events(item.path, topic):
+    _pending_events.append(e)
 
 
 def print_events_table_suffix() -> None:
   """Optionally close events table."""
+
+  def event_cmp_key(j: JsonEvent):
+    def fix_none(s: str):
+      if s is None:
+        return ''
+      return s
+
+    return (not j.desc is None, fix_none(j.topic), fix_none(j.name), fix_none(j.pmu),
+            fix_none(j.metric_name))
+
   global _close_table
-  if _close_table:
-    _args.output_file.write("""{
+  if not _close_table:
+    return
+
+  global _pending_events
+  for event in sorted(_pending_events, key=event_cmp_key):
+    _args.output_file.write(event.to_c_string())
+    _pending_events = []
+
+  _args.output_file.write("""{
 \t.name = 0,
 \t.event = 0,
 \t.desc = 0,
@@ -306,7 +328,7 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
   if not item.is_file() or not item.name.endswith('.json'):
     return
 
-  print_events_table_entries(item, get_topic(item.name))
+  add_events_table_entries(item, get_topic(item.name))
 
 
 def print_mapping_table(archs: Sequence[str]) -> None:
-- 
2.37.1.455.g008518b4e5-goog

