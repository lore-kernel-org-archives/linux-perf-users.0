Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FFE3E5A39
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608043; cv=none; b=UysMJvvxizz+W1WrtKKLlhBdc9TvCgsKAy9E1rSIyTBktQUre9UyFHcp4q2J/VUzmswvA+hoTuCzBr53a6fPLI+EtAJeLkkJV2zf267Y8zjpnwKvCZau/dLVTQzPT4WROAnka8XRTW24lkixPVc7IH2GBWcMfsBWhCD05r5JygM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608043; c=relaxed/simple;
	bh=PFrOy//LHqOv9Vz8X99ZJKt7QA5vUi44zRLC/m7ulls=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I/pFgmRsXXmfk78RbLu3VGqSd7BdMQHk9pojJN2fwHftrkJHetaaRnnNTNulQnxmwahta5HxAc91utcJPi/L6kaPqHA64Ed0Ad6zbYqljrJTjswNaA+rXPPBHx/171Ex8jBzfcFqvHDRLrjCrSYT6r1nt10S4MRQmqAuHvprAIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FN7uiou7; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FN7uiou7"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-132c3280e03so139639c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 10:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778608041; x=1779212841; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o5JKeEQpA3f9GP+7lvTdgn4CpHfMwPOs0RU2hawabLQ=;
        b=FN7uiou7zjrTbj3lkHFFGPtCJ/yvHtaEUZicJRQ4qdaezCX2pj/hzx08CGajqzWysH
         lyzzJEDpH4Jrunrxxf1rX1Wg6A7QvSBjcjfqmO2A0hADaF47G9tOGuAHUHw+jf+p/wkq
         7lFBdNz7RtCOGz8ZnaljPSgc2aCqs/z8vfNyDu5AfPR0TF6bdBKB4mmySLo4UqLwCLX9
         lboRGqLFtm1gJ3Q/7cbygjjVzuGKbo8tXfgaX1pc2whawuZQ5lgmfZBqClRtfhuigIz6
         lyEspAZ1Et75DZ00ty4WlVJqQ1pWVlHCkWjfg/MZG1zGkflFhl97HXO07UL/IugvXZbX
         UXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608041; x=1779212841;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o5JKeEQpA3f9GP+7lvTdgn4CpHfMwPOs0RU2hawabLQ=;
        b=VqjIK/PGUcvsdJyNn6qfN6hvE5iAZ56CYHzvmzCf1rkVzKVB6b+Uxj/1tL4GXGMzM1
         7jTcs+k00spZy2rCu4fBxCl3UcSVh3wed46SQuiUh6ifAe5uEG06yPc+tVCo1jOTvpjd
         K2RXoK10SbQzrfJNc3rjErLSEjetW8xgSmEX640v4Goeflm2M0QYZ9g4axdWug/8q7E1
         66u+UanhQcjHP9GtiBhhc8UIsL2tqUW4IVG88lpZoHQDSNjXV1UCt7pNajINqi6DQLND
         zllHSV+3yDdl4Rt9rPc/sJeHCjOhyHzxMXkK3rX9/cezUJexLMK052iN/32Lijrc397P
         x77Q==
X-Forwarded-Encrypted: i=1; AFNElJ+ZyAqdhQYtj5iYz1+pleSpbi1pLTLrI5pHMqGR4C+ndIgzMnO+mctJSAf7E5GhwWqejSLu+L4SYVJneM3axJpc@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn2QSzyJujRXPGsDjDmtHccqxvsil2bSeRlxNK2xU7/uLfvWpG
	0QKeOaeAM9z8ncckum+BTB0Fq/os5sp0Kvq6Va09QnQKc9TABh+eXOVmt0ioFxlVF8q4hs9Ex0O
	N6G+q9K/xWw==
X-Received: from dlae11.prod.google.com ([2002:a05:701b:230b:b0:132:c001:cbab])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:48f:b0:128:d375:f1d4
 with SMTP id a92af1059eb24-132a83fb2a8mr8635469c88.28.1778608040466; Tue, 12
 May 2026 10:47:20 -0700 (PDT)
Date: Tue, 12 May 2026 10:46:35 -0700
In-Reply-To: <20260512174638.120445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-15-irogers@google.com> <20260512174638.120445-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512174638.120445-16-irogers@google.com>
Subject: [PATCH v2 15/18] perf pmu-events: Parallelize JSON and metric
 pre-computation in jevents.py
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, james.clark@linaro.org, 
	namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	mingo@redhat.com, mmayer@broadcom.com, nathan@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me, 
	song@kernel.org, swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
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

Tested-by: James Clark <james.clark@linaro.org>
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

