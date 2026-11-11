Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368620;
	b=d/BLTFLHFdmkCIJdiLNQkkgKEwIRCltd6czHZQGvzgV7j5wD4QBLiSqZmJn1fLaRqTb6
	 Kww030rAWF10Uz7EIt7kd1Vgm0GQ9it8g7KaopkcaXZI7mxhTd520ZdljNOKcOTx2i0+g
	 hGJcpNXRJ0/WMXKcFmMb6CCZ2oGqv2/YP1veneuJfV/Fo+a+H0tWvMnDmt6ACobg+MZwQ
	 lvxSzWPZ9JBPQgN3etHLw4PzuFgXonwREUygnz/AB0e2TxUBhSjJ3YPXE0mSg6kr0Q+XL
	 eDbn+C0s+jB+hcFy/uI71AhlMSb36AgoXcdnoJ4954BzwDX6ZAwfS07OEq9HCcpXi+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368620;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=N1C2L65EJsy8iLRKcwpdaPQ+JaJVZBX4+F/GTokIchw=;
	b=wx42l9ZPrR/3KyefvfHGKhDzWgkoTnUOzbnQXdfHyo0Vz3LEzdTQp5TNkJa54BRfW7i2
	 3BwnoMXgJtsXAEn9gJWd+90ti5zJos13xgEoeRFAfjqESGjbsSGQylzx9g2wNp6DmbTsM
	 47iusyELa/SMeuFB1F5QVqz1POohmqckpnIdMd46isv6+sUca1JvqU0jqKBSc0Uv5wBKn
	 svZJczEHCqTWxkorv889ZP1ZYobjPic3eLeq3UKpOFn9qmNIqjMDtFLCDQbDt8DM+y1It
	 gJgvxiOHiG6yWqEDUeZPC73d+2zYeyDWz9ggOoCTDgrBbHtG61+CHU4OL4yTJ7iqlDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k1bRYU9J;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD872606A334
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 03:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD872606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k1bRYU9J
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso5620515eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 19:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794368619; x=1794973419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N1C2L65EJsy8iLRKcwpdaPQ+JaJVZBX4+F/GTokIchw=;
        b=k1bRYU9JtfajpTwzYveCvWd5U9tgDj9eXMV9EcZJZNKAkIrPW5zQeDquWU6wxV0CgV
         WX4lqZCI+8AWDRL7t6ys9zhV5fYBK0BLlVsMZOZ5VHGYzOoH1ThHWOCnHkeK41zPQVaz
         t1s5GoKoJ4fqzZ4eafkDcGKUE+NhBtIXNxbYBJIArAd/2l3mqw7Pw4UvJym/7UI5O5Ps
         N/W/qyCrd8KHG3Qgpr6z6zIUZVlwI3i18Zi52JuRB9gL8Xg8Tkv2M/XRV4+UGpJiG1Tw
         eZojeY3anAxJjTAAHASNsj8vPmlDsD7jyglz2usJtUtuIpkoporf8seXcbrJL5t+1tQm
         aULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794368619; x=1794973419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N1C2L65EJsy8iLRKcwpdaPQ+JaJVZBX4+F/GTokIchw=;
        b=pZMnD40FCptUPPXB0s2bMbh6//UXVtlENqvGE3t0aCrTE0L/WN7KF27cjS3AKPMTwz
         LGictVaPJ5+qs3TzudJ4+EXLayu7GDIXi0Y/H8cR5Ev8RX5tPGNCl3/f1YqBdY5wgcA6
         5T4lLqwemzCaM0sLS+67pk0iEBtDWbih8yIsrzZL3kaAmvTqJ8nzu37qWthwQE3qumYS
         uoNEKFk7HBfIqXgWHRW7fjOyddjn96j5rXiUApPtIFrrfln+Gm6yXdTjm5jE3dwU/LVm
         M6eaJa6j54P8oeFAIG9e8ddChbc4zmYsfH9zwIfYIjxllupV7P2HvJQK9oS72sBQTmF5
         nNQA==
X-Gm-Message-State: APuU4Z+mVPnSZNJTsOqbNWy0UVZGSoDNzzZ2F4wr4FOJx4oejE79bsrW
	Eg922n4QrLUd5d2Yh9Gj+GLlaN4zHsqAX7nhMu6Vnln0Gudb+P7jqO/gDegkxELF
X-Gm-Gg: AYBFou1kiKbaY8NY/4erRsD2W7tamDyYm71K2ChVYYL7uJwJGc8QXsZs+XxJGaekhxv
	FKSNNHhqYW5Qk7ZXigwV1+fbUa1sIYOT+qgGuO5xYJGYEVfoe3rVSWUaWL3i1dpshnFaxHRXgHt
	mE+uuJmqVUekeVfy8706qEcZTmYfiaJGoKK3skYWz2Af5lFKUwlU9D10MDvC++yCW0r5FT+YOYs
	RSMfBIa1VZJV/Pn7gHLBad9dk3qtDVfxYV5IamJAiY+CEEeBC7ORPsvtN+o9ecvp7j+4Y3Kt5X+
	6JLBUWt9KzlkbCRNPekYFaA655AY8kPIo1jiqWaEuQRTzV9/eyTyJ+vkqghRqG1eSqklfLfE0l6
	YLkDViqmnsF8jCDukx6kDPsQ/eKfZoMIkhvZsTFKwnoZ2hiRy0dMqh01GlfcR07skXyAl3m0Vpc
	aeindzuPr3AbPVDKP0T7kwSUkS+7JlvD8hf8n7hFhqac9pGeFW7PvPf52a6lu/O0GZAbRwg2M7s
	Nd4r7JytMm5DY0q6ChqLeYrH83qvCt7dSAvKJL34Ea6d2ikFKrYg5TlED3OMr/s90ke/kERl78C
	8o/Lh66qU6x18Zc5mPAK
X-Received: by 2002:a05:693c:68d4:b0:36a:2289:c599 with SMTP id 5a478bee46e88-376862776b3mr2229380eec.29.1794368618554;
        Tue, 10 Nov 2026 19:43:38 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfadsm13498026eec.19.2026.11.10.19.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:43:38 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.garry@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 1/3] perf jevents: Name the metric when a MetricExpr is missing
Date: Wed, 11 Nov 2026 03:43:30 +0000
Message-ID: <20261111034333.2019831-2-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111034333.2019831-1-takano32@gmail.com>
References: <20261111023448.1970467-1-takano32@gmail.com>
 <20261111034333.2019831-1-takano32@gmail.com>
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
with a MetricName and no expression. Two different failures followed,
neither of which named the metric: the rewrite in _read_json_events_impl()
raised AttributeError on the None, and a metric that got that far reached
print_pending_metrics(), whose assert fired on it.

Raise in the reader instead, naming the metric, before either of them can
happen. The check is not inside the '-' test that decides whether a metric
takes part in the rewrite: a name with a dash in it can lose its
expression the same way.

Two smaller changes on the same path:

- An architecture standard table that does not parse now carries the
   reason in its message ("Failure processing '<file>' in '<dir>':
   <cause>").  The traceback used to end with the file name alone, and
   only the chained exception said why.

- A table that does not parse is reported on stderr with a "jevents:
   error:" prefix instead of on stdout, where it was mixed with the
   generated output.

And the output files are opened after every table has been read, and not
by argparse, so a build that fails while reading leaves a file the caller
named as it was instead of truncating it to the header.  "Every table"
includes metricgroups.json, whose first pass runs before this point, and
the string table built from all of them: nothing that parses a file runs
after the output is opened.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
v3: the pass that reads metricgroups.json, and the string table built
    from it, now run before the output files are opened.  Sashiko asked
    whether a failure there still truncates them: with this ordering
    nothing that parses a table runs after the open, and a table that
    does not parse leaves a named output file as it was.

 tools/perf/pmu-events/jevents.py | 78 +++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 27 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 080e04b51b8c..61f778dcc1e5 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -460,11 +460,17 @@ def _read_json_events_impl(path: str, topic: str) -> Sequence[JsonEvent]:
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
+      raise RuntimeError(f'Metric {event.metric_name!r} has no MetricExpr')
     if event.metric_name and '-' not in event.metric_name:
       metrics.append((event.pmu, event.metric_name, event.metric_expr))
   updates = metric.RewriteMetricsInTermsOfOthers(metrics)
@@ -493,7 +499,7 @@ def preprocess_arch_std_files(archpath: str) -> None:
         if event.metric_name:
           _arch_std_events[event.metric_name.lower()] = event
     except Exception as e:
-        raise RuntimeError(f'Failure processing \'{item.name}\' in \'{archpath}\'') from e
+      raise RuntimeError(f'Failure processing \'{item.name}\' in \'{archpath}\': {e}') from e
 
 
 def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
@@ -1490,33 +1496,13 @@ such as "arm/cortex-a34".''',
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
@@ -1553,6 +1539,44 @@ struct pmu_table_entry {
 
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

