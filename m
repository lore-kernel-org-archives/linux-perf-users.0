Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409768;
	b=jkEm3OHGU1Z7TBLASikDKlMDHhRu5V+HZBGCyivYmIXIYtUywS9RvdjHYqTXXvkZixmQ
	 pGs7nEkSIv8neKhL4/Lb68LuJXxu+wsa0X9rc0e99+qgSIwtaW5zuTB8uEykEEGvkK8N/
	 5WYUJF3HGRlN+gLVp48uCTcpWXS/R6/rzmCRj2Z5usC3mO1rPwVk2kqcdvYHlTSohOOTb
	 pnV/e1RJZcFyf6CoqZ6VqFFXUNp6bx/sw4vqnzLzaynTAxY5RpMLOyL9Ch5nWOCPQh/rE
	 /96IdGSPYq6raE9rYskCWPGIt3xWlo+SjTmBeyJHsJq1UaKjnFJj9n/WeogciQf5oAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gd8RaVGncElLpDtdkvw4n7+fajQN0/VjTtSychSTN1Q=;
	b=BPz+zeJxwBfFE0cLxUvIfR2xWkIhqFouoYThrQHOupNhzRwtbh52wogPOxIQbtnCBaAF
	 PHVBjSSR/MFF8DU1JaLrPVGxOf3bo7ffsyiZjiEBP/MEPXDtjKtLP6wxHuLr55yOxGPdX
	 qIim8WOAOYfgVgDpvDoQXQc390kwUEI/zfeQCsmd3Yqxzd6rbjOoWbUMMTz/iK0NskC+U
	 FWpIIW8bLfP8JANnRyvv0/KdyBq7eV4tsLYvomq4fNvZ1tF+4+UR/YQwEE9m2PUh7OArr
	 ks5b2ssKZtFnx0Rfx6G0CzL0Sdf2NC6sHHGOLDt3vUg9/LCriS6PHc8RsyJHBgl4YSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HpB6CVE2;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9327F606A887
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 15:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9327F606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HpB6CVE2
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1532587eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 07:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794409767; x=1795014567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gd8RaVGncElLpDtdkvw4n7+fajQN0/VjTtSychSTN1Q=;
        b=HpB6CVE2leDdtii3r20+J+++oEzym+Y/IkeOc+Teue7E/ePwWrOzX2sRcDcbHBRl/U
         MGqtrBFMy0MUz37mLjhzDxGDFbfjqPxhPVivIGMlxFPQKwekFOyXpqgK8hW+Qx7pwrT2
         HQM+e0j9G0dlP2/tcX8AAb81oot4be5y8FjJlGiA5/QMoVMNPQnakTKRuud53BKybpQ4
         nAJLcLu/5n017A871giHWQARaM1cbYH1U6I8BIgnUIJUvsbzj9eczvUsAc5V7jo9wKmt
         ahFN+GLuh7zFHlgA5NAKkwu+hI+N4G9hqitgL2skUKjIcTBgLYAWBKz5gWuAQiA7iKQI
         TAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794409767; x=1795014567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gd8RaVGncElLpDtdkvw4n7+fajQN0/VjTtSychSTN1Q=;
        b=IUO7K6hOCggwaRtwqtlN32EKjxU18pU5ikAwaBltly2iU6ZgU+oI/rZuXe9cLie6tm
         rloe3x7QqickTg+Cd04cOXlJK8hOSCDO6BiOuea50v9b8O6bWtv371HqCjokBVxvf3xD
         /pSu9egsJC34QOZyaKugtwZcFgb0pTdpZBPLv6PpYjP8ifd9/Au684ouapw2G0E6AuhN
         Xg4Po9FXQ0boq45uR6hvV2l2dBsXoFImB8P3C8zv+/eQ6iy0RcWpEF/WBg6+0/p5wSsX
         v5kTWu3V6sirLWRO8zZ+rL4gL5ZNBxXGz0fIv7p7gR8JYjRCvXnmbmkpKdjMdZ28ACtj
         Qclg==
X-Gm-Message-State: APuU4Z+5FfbJGSijHz+pIa+KLj0siFm+gXa+EiJ1yddlKZRyZzE6oo7x
	YZZ5QDOauaPDaGhAymtcMk+lS2VvaTkCb5r8VaQgj6WeqisCxYfpVCvFediWOm/v
X-Gm-Gg: AYBFou17AE0Xrs8qO5mwjwIOJy0oZ98fbexynHscSDYhB+Q9/4bLIwiwcPeB14eqctq
	Gn7+ko0l6qdn5L13j/f3N6kEtej3/VW1p54WHjPAak/XxYQBreYpQNP0G01fRSC58Tcv4eZpDHZ
	lX4FRKqoF+cNcFnOHBsI3SjYYDPUyUmuO/QsO+kYrJ3y8OJjbj+aujsIaJlJ69NLRV0F8VxF+Sb
	P0V2VKNsT0PQLi7cY5FcvQl8zH77hxappsATA/YWmTRGe9G+I9VKkbM0x9VCxQ8RXwp6vYzGq77
	j+X/tfRqS5pXpcpf4bH6piTzMIEfnF2NsIzVF1goR/tPa9tk/RFd4qgXjqN10WABxv6l2csWe5Z
	7gu51HHgQtQ4k/t/AL68ld/9gdl3ir6jjomaLXV5KK/iHcjKkrXoikrzpKOOWMJxvp+9tpi3AbT
	wu8FX9otNgij5JfnMyat8D7koJuyavjjobwdLcL3LvwV3dEJoLA0qCvisVINYah0wuW+9k2A83Z
	VoWpfdH7fRK1EwKP5su8nDMs3k/oHRcbHpBB/IRs48GqBjQjYZ4IPSS9I1SSSliSUpgHsZkJzxG
	Fa1aIJ2pPm4qv5apGJiP93POK5wgqaht+r4sJYKQlQ==
X-Received: by 2002:a05:7300:dd09:b0:36e:20ee:b288 with SMTP id 5a478bee46e88-37685d717b8mr2973114eec.12.1794409766372;
        Wed, 11 Nov 2026 07:09:26 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375215d8889sm18162507eec.27.2026.11.11.07.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:09:25 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.garry@linux.dev>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v6 1/3] perf jevents: Name the metric and the file when a MetricExpr is missing
Date: Wed, 11 Nov 2026 15:09:18 +0000
Message-ID: <20261111150920.2383157-2-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111150920.2383157-1-takano32@gmail.com>
References: <20261111132622.2349165-1-takano32@gmail.com>
 <20261111150920.2383157-1-takano32@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

jevents.py reads each field it wants out of a JSON object by name, so a
MetricExpr key that is missing or spelled another way leaves the object
with a MetricName and no expression.  Two different failures followed,
neither of which named the metric: the rewrite in _read_json_events_impl()
raised AttributeError on the None, and a metric that got that far reached
print_pending_metrics(), whose assert fired on it.

Raise in the reader instead, naming the metric and the file it came from,
before either of them can happen.  The file matters because the tables are
read through a worker pool in main(), outside the directory walk, so an
exception there loses the name of the table on its way out.  The check is
not inside the '-' test that decides whether a metric takes part in the
rewrite: a name with a dash in it can lose its expression the same way.

Two smaller changes on the same path:

- An architecture standard table that does not parse now carries the
  reason in its message ("Failure processing '<file>' in '<dir>':
  <cause>").  The traceback used to end with the file name alone, and the
  reader already knows the cause.

- The output files are opened after the tables have been read, so a tree
  that fails to parse leaves no half-written table behind.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
v6: patch 1 names the file as well as the metric when a MetricExpr is
    missing (the tables are read through a worker pool, outside the
    walk, so the path was lost).  The perf test's one-line description
    ends in "(no_mlock)" so perf test lists it whole and the test does
    not take a memlock slot.  No other change.

 tools/perf/pmu-events/jevents.py | 79 +++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 27 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 080e04b51b8c..843748915c12 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -460,11 +460,18 @@ def _read_json_events_impl(path: str, topic: str) -> Sequence[JsonEvent]:
     with open(path, encoding='utf-8') as f:
       events = json.load(f, object_hook=JsonEvent)
   except BaseException:
-    print(f"Exception processing {path}")
+    print(f'jevents: error: Exception processing {path}', file=sys.stderr)
     raise
   metrics: list[Tuple[str, str, metric.Expression]] = []
   for event in events:
     event.topic = topic
+    if event.metric_name and event.metric_expr is None:
+      # A MetricName without a MetricExpr leaves nothing to put in the
+      # generated tables, whether or not the name has a dash, so the build
+      # must not go on.  Name the metric instead of letting the table printer
+      # assert on the None.
+      raise RuntimeError(f'{path}: metric {event.metric_name!r} has no '
+                         'MetricExpr')
     if event.metric_name and '-' not in event.metric_name:
       metrics.append((event.pmu, event.metric_name, event.metric_expr))
   updates = metric.RewriteMetricsInTermsOfOthers(metrics)
@@ -493,7 +500,7 @@ def preprocess_arch_std_files(archpath: str) -> None:
         if event.metric_name:
           _arch_std_events[event.metric_name.lower()] = event
     except Exception as e:
-        raise RuntimeError(f'Failure processing \'{item.name}\' in \'{archpath}\'') from e
+      raise RuntimeError(f'Failure processing \'{item.name}\' in \'{archpath}\': {e}') from e
 
 
 def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
@@ -1490,33 +1497,13 @@ such as "arm/cortex-a34".''',
       type=dir_path,
       help='Root of tree containing architecture directories containing json files'
   )
-  ap.add_argument(
-      'output_file', type=argparse.FileType('w', encoding='utf-8'), nargs='?', default=sys.stdout)
-  ap.add_argument(
-      'output_string_file', type=argparse.FileType('w', encoding='utf-8'), nargs='?', default=None)
+  ap.add_argument('output_file', nargs='?', default=None,
+                  help='file to write the tables to, default standard output')
+  ap.add_argument('output_string_file', nargs='?', default=None,
+                  help='file to write big_c_string to when it is to be kept '
+                       'apart from the tables')
   _args = ap.parse_args()
 
-  _args.output_file.write(f"""/* SPDX-License-Identifier: GPL-2.0 */
-/* THIS FILE WAS AUTOGENERATED BY `jevents.py arch={_args.arch} model={_args.model}` ! */
-""")
-  _args.output_file.write("""
-#include <pmu-events/pmu-events.h>
-#include "util/header.h"
-#include "util/pmu.h"
-#include <string.h>
-#include <stddef.h>
-
-struct compact_pmu_event {
-\tint offset;
-};
-
-struct pmu_table_entry {
-\tconst struct compact_pmu_event *entries;
-\tuint32_t num_entries;
-\tstruct compact_pmu_event pmu_name;
-};
-
-""")
   archs = []
   for item in os.scandir(_args.starting_dir):
     if not item.is_dir():
@@ -1553,6 +1540,44 @@ struct pmu_table_entry {
 
   assert _bcs is not None
   _bcs.compute()
+
+  # Every table has been read by now, so opening the output here cannot truncate
+  # a file the caller named when a table turns out not to parse.
+  if _args.output_file in (None, '-'):
+    _args.output_file = sys.stdout
+  else:
+    try:
+      _args.output_file = open(_args.output_file, 'w', encoding='utf-8')
+    except OSError as e:
+      ap.error(f'argument output_file: {e}')
+  if _args.output_string_file == '-':
+    _args.output_string_file = sys.stdout
+  elif _args.output_string_file is not None:
+    try:
+      _args.output_string_file = open(_args.output_string_file, 'w', encoding='utf-8')
+    except OSError as e:
+      ap.error(f'argument output_string_file: {e}')
+  _args.output_file.write(f"""/* SPDX-License-Identifier: GPL-2.0 */
+/* THIS FILE WAS AUTOGENERATED BY `jevents.py arch={_args.arch} model={_args.model}` ! */
+""")
+  _args.output_file.write("""
+#include <pmu-events/pmu-events.h>
+#include "util/header.h"
+#include "util/pmu.h"
+#include <string.h>
+#include <stddef.h>
+
+struct compact_pmu_event {
+\tint offset;
+};
+
+struct pmu_table_entry {
+\tconst struct compact_pmu_event *entries;
+\tuint32_t num_entries;
+\tstruct compact_pmu_event pmu_name;
+};
+
+""")
   _args.output_file.write('/* clang-format off */\n')
   if not _args.output_string_file:
     _args.output_file.write('static const char *const big_c_string =\n')
-- 
2.53.0

