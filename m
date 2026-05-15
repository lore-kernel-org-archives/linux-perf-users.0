Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F61389452
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778873633; cv=none; b=gnJxOHmUAmuDGDnwnfCAJJ608NrIHjkIAJtjS3pEMqtMpI5iwmHWqXPpSGSP3xeMnXzdknvev92cdPstjNT55UcZtFkVSF86+edAR2zf6jjqZoqJ8daoOkee66Q01y475wnPbdcObxiP4xMVV7J6njLSeR3RleheXYSPD+SBRAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778873633; c=relaxed/simple;
	bh=IlfNcLm/1qp6YlSfklvR2Tye37Wa784wEgcRPe1o8tw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sbJ7BvJjq2P6CrBcC2J8yeO/viczaE1nB+xrCjvSHAubMfpsmr0kZByspaC2Xe3AYWbCIcGafkMHtzV2QD0AG+Rt+yL1CV/HKtu6CFRWSKcUIkvJIf0gR+QkrO4kUmDdmwRCsoLhOVz0foL8PA+UJamZgvNgNAfHrDPZ8DKSNtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t0tl0nln; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t0tl0nln"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13537722193so1192428c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 12:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778873631; x=1779478431; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b5ypAkDyjquDlwKT1kP2UTnqHxEreUb36HnyA494sAE=;
        b=t0tl0nlniqgH98nKv+I1X5ArbtdIHvlD05pNhkGrhJguI5Cx/X87y0oHejqB5GUS1H
         gf9gAGOicAmfX+WyXPjtJrAr4J2ss6o/peR8oQsowJG2bgHGYl5S+27LknTI066jFIqZ
         GNOgfkwbbfgb+BEktipMoalqaH4kjauIbgAmejGXnAdi6LHR6VKBFU5sq8hnRQQEAv3L
         h9MJs2CFEnBIISa8p1D8qhwW39roV1dzYaCd5bX4Sd6mG/h8P4+wE5pQAxbBtLyy0yXQ
         aIa3QWVnNrCiBbk5EHuNU9tSG6ahnYIW9+ZGIUEDxizDsVtiSjWNbXoyMVmfJJMyd9jR
         Ws4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778873631; x=1779478431;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5ypAkDyjquDlwKT1kP2UTnqHxEreUb36HnyA494sAE=;
        b=dsSL3v6Jj1UWpOR5u885XxyVmw8lpN8DTsbgCz1orkrB77R7rDG3E1pf9GRsvnQWLs
         /08A/Ln03BRPbYqnqE2GQF6zW0QLnvjd2piYyy/CYAq/ClkOKFGpz4tUWB+S6QW8G3AB
         7Wf60J428y1/3P4Q+wiU++Cx26hngUm91ZPnGMA8jhP90pOfnY+Kv7Rt+fbjwdmIBHXB
         X1D+oVXqv+5Oqmt88FsVp3F5YoE7ovkUzazW+3j5Jq++p+7Uh1FdWuZG2eNmGFXIGtUx
         hfxtZyqsJszWUh16XLG3ZKogT3vVlArMsL4zyC9pq/ZKVPbBR0b5WRWef8Ht7gDSQxXL
         ITiw==
X-Forwarded-Encrypted: i=1; AFNElJ/FRrqM1SGAZc3J4/kd//cZYr8QOobWBj1k6HEkcDKuHnrlHJXG/dxBFBmUYQ2K9t01ButN0hxFsMZZ11f5tJAW@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjoy6Hg04aThde8l6A4iBUsrUig0NniW8BNJBfbxpnk64YXjso
	ja7jV4tJ/WoV4QVsvR3vgngAN72jqxzUFq6oVdX2XHlxmeK02ywqxN4yq3l4t39jZAV/Vzh0IPy
	Yw1XOGbEr+w==
X-Received: from dlzz19.prod.google.com ([2002:a05:7022:493:b0:12d:b27b:7405])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:128c:b0:124:9dea:188d
 with SMTP id a92af1059eb24-1350483d04amr2663392c88.30.1778873630815; Fri, 15
 May 2026 12:33:50 -0700 (PDT)
Date: Fri, 15 May 2026 12:33:11 -0700
In-Reply-To: <20260515193314.1593560-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515173852.1378571-1-irogers@google.com> <20260515193314.1593560-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515193314.1593560-12-irogers@google.com>
Subject: [PATCH v5 11/14] perf pmu-events: Parallelize JSON and metric
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
across all available CPU cores using ProcessPoolExecutor. Define the worker
process initializer _init_worker at the top-level module scope to guarantee
flawless pickling and standard event mapping inheritance under spawn
multiprocessing semantics (avoiding AttributeError crashes when spawn is
used instead of fork). This accelerates jevents.py execution by over 11x
(from 3.3s down to ~290ms), fully reclaiming multi-core concurrency during
the build generation phase.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 36 ++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index db5595457979..0f35b558f45d 100755
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
@@ -1381,6 +1385,14 @@ const char *describe_metricgroup(const char *group)
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
 
@@ -1459,9 +1471,25 @@ struct pmu_table_entry {
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
 
   _bcs.compute()
-- 
2.54.0.563.g4f69b47b94-goog

