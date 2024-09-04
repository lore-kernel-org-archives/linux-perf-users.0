Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B0182486
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Sep 2024 04:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725425038; cv=none; b=BFVu/+QSzsB22/ltjEJ0+kZ9RuNVO1/AvZRm9sEhUH8o2n450X2ye1W2PyDHH45bb3Hxxd/GwlRUAEEsIs3UzMEpZ1K8zcbTKDa4fBeP3z8GlQnoD8bH9PV7WpaDh4rYSUqfjjtG/CbE3b4B1drRI3oJHBJpg7oUthHZ0GEmM1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725425038; c=relaxed/simple;
	bh=YiScnkLeV6Y0vsbzVcMEYsZM3Ohbgu89BmGeM8kdxMk=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=UjW+a02Uorn7niQDFRglpPoh7lma8yh+F/h6A/ACJnmJFDZ83Dlodss7wxrcUlpusOXfDo9gfa0hE5BlB6rOWLPnR1my5eSTm52silNd1FUCU8dXXr8wHrVyMHtsmRfMwn3P0dr4Rxkko7YjnFPMl6VBu6fffhJKaXbiaUGZWAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lRj08oAB; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lRj08oAB"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1a8de19f5fso7202649276.3
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Sep 2024 21:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725425036; x=1726029836; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jmyPZ6e+8VIk38jIk+DCVXGne5twBtcEgWDhg01dIdw=;
        b=lRj08oAB3Z1Xoa/BIwrVK7MBR9BYjq4btz4oOUWuToSrDVQXLkgDnXRXyDReEecJax
         Xby0DC6vYC2FDR9Zou8WD8aZVuo/gUmGvunvFjZyWFqcgWGtP2WG/9Bi7YkOATrGqvA+
         DnbtZU3PMD3GXLStgNQXKIA1f+sfMrcGFbjHU/by8xxWJb7+GgrhI6bjOg88jttZZVjO
         wYybbqp2tJW3gAkx8gaoExlsrQk6adi9yrrtGiKbmcleT7BgkDK1I8NyAOVZf9pSeIBV
         V6+8O2Sng/d5JP0+pxoN+Un+/7w5W89v01l4GeM62NZkhQBe5MHZbozHvPR6ciW0tS//
         eIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725425036; x=1726029836;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jmyPZ6e+8VIk38jIk+DCVXGne5twBtcEgWDhg01dIdw=;
        b=nOlH+hBgi/xMcBUrfFsl+q6SWys9AQRRnR0XQqcIaDbjaArUEYmMx+bBUG5IQiVben
         28cZQK23IjidYnD175qDQvwbjBEYGG9I5HtKTt5QMBSoxCc+BvN6MJBXRTzpsXmtSQOS
         XzJw49ahOYqzjFyeE8YFMAQ4xkKHd6ZV4MnpluxJbDj3nJPTjBdzC2NJXSYXGz22DQ2c
         4YQYpfOxN+Hw8Dr96n3c06v1NhS8xA9FZVYSRGkAB4WOIUzV1vGrqRK8FTyRTd9Kt1sO
         3zQsJ8Jg5TLfpGDj21XDD1w9ZWzXGOwXCBrx3Zbx85avLHe1nxdq2nFdY64HAvgJriQF
         AVbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX48giCfLSDtviegZTnFOVxQa0HLAsxk8aHc6vFQCycxZcAKiKrPuvvebKAvKoWOwYNfJezgW0wqkM/yxJwvwqh@vger.kernel.org
X-Gm-Message-State: AOJu0YzCjBWXAIP3rPg+TORxOuBMdWvxltHhbhgCjyHdJEaMfGOYr54m
	dc0lfRPYGDe2wd6711ZVGfU3lPIi96RdS7xim6T/On0PbBDL0X++YEdQ6utoRzT58IwpvF25pBo
	sODabkw==
X-Google-Smtp-Source: AGHT+IHS7b8OGdmdUf5p3BqVF5PFVUrI908oWcMt79/HKSneAkTVjvivnNOyoOB8eQ/xnkaU3eebErl6hWUX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c48b:5e3:a63c:2d09])
 (user=irogers job=sendgmr) by 2002:a25:b228:0:b0:dfb:1c1c:abf9 with SMTP id
 3f1490d57ef6-e1a79fe211fmr910213276.2.1725425035783; Tue, 03 Sep 2024
 21:43:55 -0700 (PDT)
Date: Tue,  3 Sep 2024 21:43:51 -0700
Message-Id: <20240904044351.712080-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v1] perf jevents: Add cpuid to model lookup command
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When restricting jevents generated json lookup code with JEVENTS_MODEL
a list of models must be provided. Some builds don't know model names
but know cpuids. Add a command that can convert a cpuid to a model
using mapfile.csv files. This can be used with JEVENTS_MODEL like:

```
$ make JEVENTS_MODEL=`./pmu-events/models.py x86 'GenuineIntel-6-8D-1,AuthenticAMD-26-1' pmu-events/arch/`
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/models.py | 73 +++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100755 tools/perf/pmu-events/models.py

diff --git a/tools/perf/pmu-events/models.py b/tools/perf/pmu-events/models.py
new file mode 100755
index 000000000000..8f727d29c952
--- /dev/null
+++ b/tools/perf/pmu-events/models.py
@@ -0,0 +1,73 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+"""List model names from mapfile.csv files."""
+import argparse
+import csv
+import os
+import re
+from typing import List
+
+def main() -> None:
+    def dir_path(path: str) -> str:
+        """Validate path is a directory for argparse."""
+        if os.path.isdir(path):
+            return path
+        raise argparse.ArgumentTypeError(f'\'{path}\' is not a valid directory')
+
+    def find_archs(start_dir: str, arch: str) -> List[str]:
+        archs = []
+        for item in os.scandir(start_dir):
+            if not item.is_dir():
+                continue
+            if arch in (item.name, 'all'):
+                archs.append(item.name)
+
+        if len(archs) < 1:
+            raise IOError(f'Missing architecture directory \'{arch}\'')
+
+        return archs
+
+    def find_mapfiles(start_dir: str, archs: List[str]) -> List[str]:
+        result = []
+        for arch in archs:
+            for item in os.scandir(f'{start_dir}/{arch}'):
+                if item.is_dir():
+                    continue
+                if item.name == 'mapfile.csv':
+                    result.append(f'{start_dir}/{arch}/mapfile.csv')
+        return result
+
+    def find_cpuids(mapfiles: List[str], cpuids: str) -> List[str]:
+        result = []
+        for mapfile in mapfiles:
+            with open(mapfile, encoding='utf-8') as csvfile:
+                first = False
+                table = csv.reader(csvfile)
+                for row in table:
+                    if not first or len(row) == 0 or row[0].startswith('#'):
+                        first = True
+                        continue
+                    # Python regular expressions don't handle xdigit.
+                    regex = row[0].replace('[[:xdigit:]]', '[0-9a-fA-F]')
+                    for cpuid in cpuids.split(','):
+                        if re.match(regex, cpuid):
+                            result.append(row[2])
+        return result
+
+    ap = argparse.ArgumentParser()
+    ap.add_argument('arch', help='Architecture name like x86')
+    ap.add_argument('cpuid', default='all', help='List of cpuids to convert to model names')
+    ap.add_argument(
+        'starting_dir',
+        type=dir_path,
+        help='Root of tree containing architecture directories containing json files'
+    )
+    args = ap.parse_args()
+
+    archs = find_archs(args.starting_dir, args.arch)
+    mapfiles = find_mapfiles(args.starting_dir, archs)
+    models = find_cpuids(mapfiles, args.cpuid)
+    print(','.join(models))
+
+if __name__ == '__main__':
+    main()
-- 
2.46.0.469.g59c65b2a67-goog

