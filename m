Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C163CEBB0
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 05:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564185; cv=none; b=cL+Emsw8uEg/EX1wZHxGKoyK42F+fB3n3fV9Nno/XfXNlZFkfgpTUaJ/RRtdlPnLhRKg2MQ3J0tL/yVgDtYH8Lbs0nKkK5BJioBHb4xI1VHL0Sco0MWD2CJC7Ub067oSrqaCLXahi5WT7LzTUB/dKvqqdMEHYVkfvxib7z7FZfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564185; c=relaxed/simple;
	bh=Xs0QKg7ZFGHCgpb39xNtKbutgLWpIgoU5BMBYce+utQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HhfUufNz8xYwZz/VPPPJIlGvncdK/zir3l9WqW/nKyJjeR714sBduUaSOGfwBfXnlPdcBT6KD28NUPJZ1nnbIfOnUFVgsmZ3pVX+0vsh55A5pXNJP0/ulg60ApTQ8Rodq6+XjmOqIyrnrJ41vB3myw8HYf7Z2w1YWY+d1YUTPLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wnrzdy0q; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wnrzdy0q"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-132d5ad9c32so10621785c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 22:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778564176; x=1779168976; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sv+fBrgnLHWDPJNXQeJxnE6YmYGegAklGdTMc3S6cgE=;
        b=Wnrzdy0qyc+MQdZmlZ1AwxNNeuSwkYtnEoK5/I7+m9tVjoCuLVkWqHCizvO/xKof2T
         KKy17+vf7uwQu8kEbi9hFBKcRV3pbxnCJrRxmtbg963jHL1cP607RPpxxxMyBmAV5/2a
         F93k0Mp/b0nR72rQqxFg3xo0TSuTAGaRXNaWebixQ3l5okIQhHEAAS6DVbgGrH+jXBa1
         C2EJUTPNAnkjMDaHLx66aCgETkBksJestWSFPcY9W4a1zZxSi5MmPWFjbShHrZ+kpEda
         j7SAJ0pBMMY+wrMrnwJWYWxeClTUKZjVwJOuMNj6vQds2CV0lpXZCbVBNZFUABrFuThY
         CJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778564176; x=1779168976;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sv+fBrgnLHWDPJNXQeJxnE6YmYGegAklGdTMc3S6cgE=;
        b=LejH5xHolmuDeNG8NXikTCXX8d67zwbnroUW4Mq5LYHzgtn6nhKSKQPiBlBtq9icQF
         y5U6CIPXt/NCSq3sdepqHs4ysLmZUtwdKI6r4q/6/h4ikNGKe8lD1WKskyFa569V8H89
         FnaABwZh62Z3PrmJT6E1P7C7VlGHdSA8vi+o9uaupKlngGBWUkfa+zG/PeBicBGsIDyR
         lvlv3f5MPCTAaGP718AT0KzgW/B3kOa591U+1oforKWpDxxs0eumQs/vbS2/BaWyjePn
         viH2KabAVF7zfoE6CcXGDDfiaEmtqE67qJ3Ro0JtuemQPZOFdVnsTKD6J7evhe0Lgx2f
         rkPg==
X-Forwarded-Encrypted: i=1; AFNElJ99KGdAvVjpPhUmgPn3FDD5kEFrorwSPPNZQA9RPlCp7hWOr0iPrXR8bPcnTd2MaaJNMIaFLM2y7oE1uGRHm1+2@vger.kernel.org
X-Gm-Message-State: AOJu0YxfpcDgMMCSokYP6yfIf/Ll1crS6iUHaTAhqSEQ6iOjqRQ3qmKE
	Vzt4wGynBKaYxEntSBF86z6g61JituPJRmX5WHWa6m/dS2I9PwP3QBWC7jgH4ftEjnQeyWluUOX
	U03Tcaho7mQ==
X-Received: from dlbuy7.prod.google.com ([2002:a05:7022:1e07:b0:12d:b319:ccc4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2219:b0:133:1be4:a357
 with SMTP id a92af1059eb24-1331be4a563mr1743979c88.1.1778564175356; Mon, 11
 May 2026 22:36:15 -0700 (PDT)
Date: Mon, 11 May 2026 22:35:38 -0700
In-Reply-To: <20260512053539.3410189-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512053539.3410189-14-irogers@google.com>
Subject: [PATCH v1 13/14] perf pmu-events: Parallelize JSON and metric
 pre-computation in jevents.py
From: Ian Rogers <irogers@google.com>
To: Quentin Monnet <qmo@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, 
	Nathan Chancellor <nathan@kernel.org>, Tomas Glozar <tglozar@redhat.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Leo Yan <leo.yan@arm.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	Markus Mayer <mmayer@broadcom.com>, Collin Funk <collin.funk1@gmail.com>, 
	Howard Chu <howardchu95@gmail.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Ricky Ringler <ricky.ringler@proton.me>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, jevents.py parses hundreds of JSON event and metric files
sequentially across all CPU architectures during Kbuild startup, taking
~3.3 seconds of pure single-core execution time.

Refactor jevents.py to pre-populate its internal JSON AST cache in parallel
across all available CPU cores using ProcessPoolExecutor. Configure worker
process initializers to guarantee standard event mapping inheritance under
spawn multiprocessing semantics, and apply depth filtering to prevent
redundant worker tasks. This accelerates jevents.py execution by over 11x
(from 3.3s down to ~290ms), fully reclaiming multi-core concurrency during
the build generation phase.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 36 ++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 70a45e62f5d1..eb72c154f946 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -457,8 +457,8 @@ class JsonEvent:
     return f'{{ { _bcs.offsets[s] } }}, /* {fix_comment(s)} */\n'
 
 
-@lru_cache(maxsize=None)
-def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
+_json_cache = {}
+def _read_json_events_impl(path: str, topic: str) -> Sequence[JsonEvent]:
   """Read json events from the specified file."""
   try:
     events = json.load(open(path), object_hook=JsonEvent)
@@ -474,12 +474,16 @@ def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
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
@@ -1381,6 +1385,10 @@ const char *describe_metricgroup(const char *group)
 }
 """)
 
+def _parallel_read_json_events(task: Tuple[str, str]) -> Tuple[str, str, Sequence[JsonEvent]]:
+  path, topic = task
+  return path, topic, _read_json_events_impl(path, topic)
+
 def main() -> None:
   global _args
 
@@ -1459,9 +1467,29 @@ struct pmu_table_entry {
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
+  def _init_worker(std_events: dict) -> None:
+    global _arch_std_events
+    _arch_std_events = std_events
+
+  with concurrent.futures.ProcessPoolExecutor(initializer=_init_worker, initargs=(_arch_std_events,)) as executor:
+    for path, topic, events in executor.map(_parallel_read_json_events, tasks):
+      _json_cache[(path, topic)] = events
+
+  for arch in archs:
+    arch_path = f'{_args.starting_dir}/{arch}'
     ftw(arch_path, [], preprocess_one_file)
 
   _bcs.compute()
-- 
2.54.0.563.g4f69b47b94-goog

