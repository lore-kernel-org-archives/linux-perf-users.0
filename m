Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE3D4334D3
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 17:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784741521; cv=none; b=aAsomDAFkFniv12JeOghwJDea/ULn/v/0LFFdmmz1LXXyS6hMDirVuxuN0Mb2Ts8CM7Ptazz+lTksDBEYYsH6hgYblcwdCUbMKhIIG9Ubwht6ttgVlz1hfM2W87nZqIv+VADDPPiDlmJyT7DgvJHEEJclUAZfmqVpI2+Pks9ucA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784741521; c=relaxed/simple;
	bh=RmiNgHhl4/gTd/JKzR/7AM5zeWlxwdw3HFZKgMxMj+A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=INH4C5s5UfBSezsPyNOaSinuZyOa4b+CUhsxEm+wElOUR0hCVPKz0cbqju8mirL0GmgcUm8wzkveUGZJrTWkKAB3k0dSNpm9ubr3MI3i6qFDVkVRSCCkRKGhoojqW44+yfhAYc6Sh5lG7tGtNunoEit900GKHuoo20NGA7tb8HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b0yuQnE1; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b0yuQnE1"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dbe39ce62so6625056a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 10:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784741510; x=1785346310; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=l18VXGNYcOmQG/0BfithWocT6bT2K2vgr8dII6Ia0aE=;
        b=b0yuQnE1J0M/OB4xI7Y6EEKVf1KXTFUFHM9DL8MtwH6opeYqiNGyErGsOzH4Nmo52q
         yEwY6Tn4Smkn4RTA/XKi7zbIl1qMMKl3BYsTvzVB3Bi6PwOj4zUVBS0jHV3hcFSeEFC0
         bUoNxEAEVxWE3QEErHv9vVskJNs6q02CgScwn1YlNZE9275ChAtepTCZ7OqAIRIg9nQ7
         SkrmdwRDH6ni/qf7qnO/aF1YJJZOQb9UdvQcXQ08LJ/OmUWKIMWuniMZo7dFgi2g/o+x
         onh1nVbPE86lEcx4fU1VAYIYTZPucTBLpEJFs2rtqAS5twIuT7BZfgF8mYk4lJTBA11h
         92Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784741510; x=1785346310;
        h=content-type:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l18VXGNYcOmQG/0BfithWocT6bT2K2vgr8dII6Ia0aE=;
        b=YB2NsgAjRV79RNEpNiIn6GLzbaCwdyMVeFCcjBYQuHXsV6iz7RZ7vOFrQnek406rGf
         i+8/NhtN+sC4I7+brh4uFHD41PDIDgZ3iXz18o2BPn5+sAZAKnQKs2lqty1p8J04BvVO
         I6ReOJP3REk97gMTvGuxlknW8XH07YhlrPdnphgz3CdBbHl40Pm1/s3eguB+ZR3hcbTx
         FpMcwkLAE0q+eKGGIIe61GD2U5d4sN5Cr/02n1yK0p7NCyhARg09fnAEP9+26rjxGR2d
         CejD3iawU+Z70ddX9igtxzbnWLpwqMSLJHrwJD6iQCoztdNuFrlJ17HPYjpsNzyiW1NC
         +QpQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro6DnH+lXJdG4nZ9Xb9av1txgbjnrdZywrL9QPJvzB0wLr41cd3PjCCb/Sr3LaS6x6ZfmfxDM3k6VIeb9oIMbgE@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ld7OGmgGUwYrgwAvVLl5bI3CMvD6W0zgxUuHaVgxZr8J087t
	UlKpb0kfp5KuwLbRiJ8Ma+pEhBPxWo43gw2gju4aWjcOrkySV3CASYh+uqZAfV7/fCOcNjJmMXo
	rNPCtZr/bsQ==
X-Received: from dlbtu15.prod.google.com ([2002:a05:7022:3c0f:b0:13d:1bd0:e6cd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d445:b0:38e:7f52:c8a9
 with SMTP id 98e67ed59e1d1-38ea379633dmr5048244a91.15.1784741509451; Wed, 22
 Jul 2026 10:31:49 -0700 (PDT)
Date: Wed, 22 Jul 2026 10:31:38 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260722173138.720586-1-irogers@google.com>
Subject: [PATCH v1] perf pmu-events: Parallelize JSON and metric
 pre-computation in jevents.py
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently, jevents.py parses hundreds of JSON event and metric files
sequentially across all CPU architectures during Kbuild startup,
taking ~3.5 seconds of single-core execution time.

Refactor jevents.py to pre-populate its internal JSON AST cache in
parallel across all available CPU cores using
ProcessPoolExecutor. First gather all the paths with ftw and
collect_json, then spawn _parallel_read_json_events that starts
workers to just read the json events. Define the worker process
initializer _init_worker so that _arch_std_events is available under
spawn multiprocessing semantics.

This accelerates the JSON parsing phase by over 10x (from ~3.0s down
to ~290ms), reducing overall jevents.py execution time by 3.5x (from
~3.56s down to ~1.03s).

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
This change was originally part of a larger set of build speed ups,
but was taken out to focus on more important fixes. Mailing now
separately. The original series at v7 with this change is:
https://lore.kernel.org/lkml/20260518154638.2798789-1-irogers@google.com/

Note, the change assumes Python 3.9 for type annotations. The parallel
execution APIs were added in Python 3.7. This means the python code
should meet the minimum build requirements in:
https://www.kernel.org/doc/Documentation/Changes
---
 tools/perf/pmu-events/jevents.py | 36 ++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 5c15485d695a..860027bb71b2 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -464,8 +464,8 @@ class JsonEvent:
     return f'{make_comment(s)}\t{{ { _bcs.offsets[s] } }},\n'
 
 
-@lru_cache(maxsize=None)
-def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
+_json_cache = {}
+def _read_json_events_impl(path: str, topic: str) -> Sequence[JsonEvent]:
   """Read json events from the specified file."""
   try:
     events = json.load(open(path), object_hook=JsonEvent)
@@ -481,12 +481,16 @@ def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
   if updates:
     for event in events:
       if event.metric_name in updates:
-        # print(f'Updated {event.metric_name} from\n"{event.metric_expr}"\n'
-        #       f'to\n"{updates[event.metric_name]}"')
         event.metric_expr = updates[event.metric_name]
 
   return events
 
+def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
+  key = (path, topic)
+  if key not in _json_cache:
+    _json_cache[key] = _read_json_events_impl(path, topic)
+  return _json_cache[key]
+
 def preprocess_arch_std_files(archpath: str) -> None:
   """Read in all architecture standard events."""
   global _arch_std_events
@@ -1446,6 +1450,14 @@ const char *describe_metricgroup(const char *group)
 }
 """)
 
+def _parallel_read_json_events(task: Tuple[str, str]) -> Tuple[str, str, Sequence[JsonEvent]]:
+  path, topic = task
+  return path, topic, _read_json_events_impl(path, topic)
+
+def _init_worker(std_events: dict) -> None:
+  global _arch_std_events
+  _arch_std_events = std_events
+
 def main() -> None:
   global _args
 
@@ -1524,9 +1536,25 @@ struct pmu_table_entry {
     raise IOError(f'Missing architecture directory \'{_args.arch}\'')
 
   archs.sort()
+  import concurrent.futures
+  tasks = []
+  def collect_json(parents: Sequence[str], item: os.DirEntry) -> None:
+    if len(parents) == 0:
+      return
+    if item.is_file() and item.name.endswith('.json') and not item.name.endswith('metricgroups.json'):
+      tasks.append((item.path, get_topic(item.name)))
+
   for arch in archs:
     arch_path = f'{_args.starting_dir}/{arch}'
     preprocess_arch_std_files(arch_path)
+    ftw(arch_path, [], collect_json)
+
+  with concurrent.futures.ProcessPoolExecutor(initializer=_init_worker, initargs=(_arch_std_events,)) as executor:
+    for path, topic, events in executor.map(_parallel_read_json_events, tasks):
+      _json_cache[(path, topic)] = events
+
+  for arch in archs:
+    arch_path = f'{_args.starting_dir}/{arch}'
     ftw(arch_path, [], preprocess_one_file)
 
   assert _bcs is not None
-- 
2.55.0.229.g6434b31f56-goog

