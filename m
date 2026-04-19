Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4602F1C28E
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643561; cv=none; b=KXD9UKZOVTEPiXoixCo4gdv3ecI7ODA7DSeUvhYEoY8+NPaaFjGzGHN0KBWZXlfqPcWDdJAFHw0OkuSEtloDsbPjRNwegqtDE/H9Qa1VRqjnhbl3tloTxMuW3XhrWL59GGOJzOOL8l67sN1/8HyFSsamaggahnSMrZ7FXhNbUT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643561; c=relaxed/simple;
	bh=Yp/VpyJcqD2RPLWZalVa+xixDAFI4lAEMRa/FZFIMb0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=es94I0lVgtCyajrkuuKpafK86fpiQuV0W4Pvb7eXTQaiKS1RmSIyurS6ENk2zHfg9/zQNMNJ0rxQDIVxFt7Smrbbwil4MXBeSBZfUDENCIJVCSoUJnFCpjcYNJPLw/bcxNxJVfiX6635Fa9kMAepL8ESTPrUrziOXXhd58US3VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V8dyu+uv; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V8dyu+uv"
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-41c02dec5c1so3979752fac.2
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 17:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643559; x=1777248359; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7WQ7kcwMxBpCOrBoZ47jd2yOsX0OA41N9Sof9Sy1W94=;
        b=V8dyu+uvvIfzdRHK73SecQzoK22BBMQxi/8d3DIj2ocyaQNE8P3k4Z7Kwfp/DI4qjn
         Na5/JmtMSvC7FQcD+72GgFK1ThI4hpCdlBvl9TMxNnbTosBUPuziuk8gy98RXznmIDu+
         X+XtPISlxZNuNoE8tJd7qIe7ZGk8QgWdz63WV5yMnVuitU7FwsFLHHEgDgloAh97/aHq
         oBZ9PPD0ON6+ulFsmtzq6Wft/CyCVF3eC8j/HYUt2Y4Cc49iYa763LPXvx+t9Tb3ucc2
         AG3tdo6DfVpnve1o0DalqU5BXKloI9tD7mXzWEcOaLoRi6+DPiVb3EeAgNRWcYt/RONf
         Oh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643559; x=1777248359;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WQ7kcwMxBpCOrBoZ47jd2yOsX0OA41N9Sof9Sy1W94=;
        b=qLkFld8DSAC80uF7NwuYb3cXX0K4kEDwl9QxIGQyBZfjIb3wFBTu3Lwi1qDocicOCj
         yfJKTD7ETtrG03kicUFbfaETgpFSgg7p+KK8TTDEfckM+29OH06dHP1IUJAumDeIXUDg
         p2xMIdAnasCg1uiOiHbAe2H/2sZ9jWA7fiRMm58Sz6QugDbG9NM1dLSaGqZay+bWyJMU
         XFEjw24A8kX9JGasKK6KXbXnw9ntK9ogSoBy5cJ3zvN0dGIA4Jbv7Voeqzg0X/CrHj/R
         zhQ/wDA7dWmNYechQf53DM+RpOFCwEgrsQMlZQPXGGMgTitcl7Y0/wYFc9qI1onVklvz
         B4Sg==
X-Forwarded-Encrypted: i=1; AFNElJ+N8yRG3Rqi3nhyc/dQvcwEgM28SQLbk8AIJNE4APygKMUPzcc+6U+M076YHQZHTfx2M8/I2GmhdClAdlBspLwb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy59uU6q3LyK2Mo9iS7lm4/Uxasf/AbAgZVVEPX1sjqvcUgUTux
	3zqvomUglq1y+De7pbx6Baatg4n4mBey+xG8NY0oc7+7wjVXfAsGWasmZkv1qTIrep8/uISc7LH
	SvQPZQqt1Vw==
X-Received: from dlag4.prod.google.com ([2002:a05:701b:2504:b0:12b:e83a:8d31])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:7f13:b0:12c:873f:eba3
 with SMTP id a92af1059eb24-12c873fef0fmr651782c88.8.1776643220753; Sun, 19
 Apr 2026 17:00:20 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:38 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-27-irogers@google.com>
Subject: [PATCH v1 26/58] perf mem-phys-addr: Port mem-phys-addr to use python module
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alice Rogers <alice.mei.rogers@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Blake Jones <blakejones@google.com>, Changbin Du <changbin.du@huawei.com>, 
	Gautam Menghani <gautam@linux.ibm.com>, Wangyang Guo <wangyang.guo@intel.com>, 
	Pan Deng <pan.deng@intel.com>, Zhiguo Zhou <zhiguo.zhou@intel.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Zecheng Li <zli94@ncsu.edu>, tanze <tanze@kylinos.cn>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	"Tycho Andersen (AMD)" <tycho@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Sun Jian <sun.jian.kdev@gmail.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Ricky Ringler <ricky.ringler@proton.me>, Qinxin Xia <xiaqinxin@huawei.com>, 
	Aditya Bodkhe <adityab1@linux.ibm.com>, Chun-Tse Shao <ctshao@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Chen Ni <nichen@iscas.ac.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Give an example of using the perf python session API to load a
perf.data file and perform the behavior of
tools/perf/scripts/python/mem-phys-addr.py.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/mem-phys-addr.py | 116 +++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100755 tools/perf/python/mem-phys-addr.py

diff --git a/tools/perf/python/mem-phys-addr.py b/tools/perf/python/mem-phys-addr.py
new file mode 100755
index 000000000000..17d6fd4f1a2b
--- /dev/null
+++ b/tools/perf/python/mem-phys-addr.py
@@ -0,0 +1,116 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""mem-phys-addr.py: Resolve physical address samples"""
+
+import bisect
+import collections
+import os
+import perf
+import re
+import sys
+from dataclasses import dataclass
+from typing import (Dict, Optional)
+
+@dataclass(frozen=True)
+class IomemEntry:
+    """Read from a line in /proc/iomem"""
+    begin: int
+    end: int
+    indent: int
+    label: str
+
+# Physical memory layout from /proc/iomem. Key is the indent and then
+# a list of ranges.
+iomem: Dict[int, list[IomemEntry]] = collections.defaultdict(list)
+# Child nodes from the iomem parent.
+children: Dict[IomemEntry, set[IomemEntry]] = collections.defaultdict(set)
+# Maximum indent seen before an entry in the iomem file.
+max_indent: int = 0
+# Count for each range of memory.
+load_mem_type_cnt: Dict[IomemEntry, int] = collections.Counter()
+# Perf event name set from the first sample in the data.
+event_name: Optional[str] = None
+
+def parse_iomem():
+    """Populate iomem from /proc/iomem file"""
+    global iomem
+    global max_indent
+    global children
+    with open('/proc/iomem', 'r', encoding='ascii') as f:
+        for line in f:
+            indent = 0
+            while line[indent] == ' ':
+                indent += 1
+            if indent > max_indent:
+                max_indent = indent
+            m = re.split('-|:', line, maxsplit=2)
+            begin = int(m[0], 16)
+            end = int(m[1], 16)
+            label = m[2].strip()
+            entry = IomemEntry(begin, end, indent, label)
+            # Before adding entry, search for a parent node using its begin.
+            if indent > 0:
+                parent = find_memory_type(begin)
+                assert parent, f"Given indent expected a parent for {label}"
+                children[parent].add(entry)
+            iomem[indent].append(entry)
+
+def find_memory_type(phys_addr) -> Optional[IomemEntry]:
+    """Search iomem for the range containing phys_addr with the maximum indent"""
+    for i in range(max_indent, -1, -1):
+        if i not in iomem:
+            continue
+        position = bisect.bisect_right(iomem[i], phys_addr,
+                                       key=lambda entry: entry.begin)
+        if position is None:
+            continue
+        iomem_entry = iomem[i][position-1]
+        if  iomem_entry.begin <= phys_addr <= iomem_entry.end:
+            return iomem_entry
+    print(f"Didn't find {phys_addr}")
+    return None
+
+def print_memory_type():
+    print(f"Event: {event_name}")
+    print(f"{'Memory type':<40}  {'count':>10}  {'percentage':>10}")
+    print(f"{'-' * 40:<40}  {'-' * 10:>10}  {'-' * 10:>10}")
+    total = sum(load_mem_type_cnt.values())
+    # Add count from children into the parent.
+    for i in range(max_indent, -1, -1):
+        if i not in iomem:
+            continue
+        for entry in iomem[i]:
+            global children
+            for child in children[entry]:
+                if load_mem_type_cnt[child] > 0:
+                    load_mem_type_cnt[entry] += load_mem_type_cnt[child]
+
+    def print_entries(entries):
+        """Print counts from parents down to their children"""
+        global children
+        for entry in sorted(entries,
+                            key = lambda entry: load_mem_type_cnt[entry],
+                            reverse = True):
+            count = load_mem_type_cnt[entry]
+            if count > 0:
+                mem_type = ' ' * entry.indent + f"{entry.begin:x}-{entry.end:x} : {entry.label}"
+                percent = 100 * count / total
+                print(f"{mem_type:<40}  {count:>10}  {percent:>10.1f}")
+                print_entries(children[entry])
+
+    print_entries(iomem[0])
+
+if __name__ == "__main__":
+    def process_event(sample):
+        phys_addr  = sample.sample_phys_addr
+        entry = find_memory_type(phys_addr)
+        if entry:
+            load_mem_type_cnt[entry] += 1
+
+            global event_name
+            if event_name is None:
+                event_name  = str(sample.evsel)
+
+    parse_iomem()
+    perf.session(perf.data("perf.data"), sample=process_event).process_events()
+    print_memory_type()
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

