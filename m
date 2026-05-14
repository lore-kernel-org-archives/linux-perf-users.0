Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1966A355F54
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776503; cv=none; b=ExtS3x3ydKwBXDOjx8CZHmgKuzfOb5efDRY6ap00NQU0Lzs/O8RpAsyqDoCT9G0ikSUsx3CSieEFkORmoWmcSfDOzMZqM8Gym3+LCya6hWB6I2HuBEyK7vY7zyrChRLpqHk7bbM8ssYNP8f1GC5Cx4LYDyZSyh6RaFIkpWhJYPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776503; c=relaxed/simple;
	bh=4zVkDbMoBuNB6T+QEmeQbHjKDWqgEgEqBPkRSy/rcSs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OdkeakX3WP3LFYNjUTnGtrB9MQ3jC1LK8I40SKIQkaxGQYsySxHDEh3Y1p9IEuuQqigJc7jujBZNEnLKZEHzCgNNiAiaN4d9rdTZEc4HoNgSWxVIX/PrgNijbn3QvkFnjK1gHtwplBWH3J1nf510ADzaCCL9zBjXb2cTcdabbbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BR2Wtlwp; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BR2Wtlwp"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-132d5ad9c32so7979194c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 09:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778776501; x=1779381301; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D3y8sU0zSqky90c33VE2UOxl6GE2wLZT9h/bbK/MxHA=;
        b=BR2WtlwpOxAFK6koHa7NYulYjc6NIGsfxhib8ry2z2pgJvOVA0zPHEP+PCYEoo2fAp
         VLNOPluc3KC4RJWRMNY7SBIDu9Lqz/2voykQ1DB8er2tDZnvbhIpauUCTu0E1EuVfPD4
         F8H1qS/a3B/AO0edgtJNS7ImeP2Rl3fVxg2fqZf4e0Iogo0OiKQerl3vGyRPgoSCQuLZ
         lORuxVI548ahVWJ4eYsP7U5PqeDBAPCJJxIs6Hq03H0u6oxFepSPDonvUcaifC+LUjzk
         PNOybGm+JDtJD8YBuCLPBPZkce+BAGLgDsTunmcAnvNz3ZOpzTSJixVhoGipdGp5lYU5
         YJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778776501; x=1779381301;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3y8sU0zSqky90c33VE2UOxl6GE2wLZT9h/bbK/MxHA=;
        b=EXn5/fFE7Mf7nwtpE0EkPf+tWdY3PT3Iw6uJoZpX5SKN51eojwLR9TWpIps5YJMD+M
         KIUWIg+yUKX+DpmALO0rYS04zN6grD0irQ0juoxtPPFBoYaWslRpGTqmjUdTqp/3Boii
         Pycvauf5a60aDgwuE1V8ikPYJgbZpVrMcF13D1CFyRlcxeOcEIVjADPFuK7V3U2Vmx15
         bzWVFX0L+na7Kt5cFoqMwGYOD1e+V9JCSPwIo8ix5NRkS12hLm0phNUAfEtKcA++HmgZ
         qmj4J5/hbblFl8GYQxPdmyBxIV9UHge4q48w2kkxMWsZR1HDtY5PAjUkNTzwYR0TuFrH
         iVHQ==
X-Forwarded-Encrypted: i=1; AFNElJ9gki3uEQWAlK/YIQFN/z/gCyC8/PHpnP/cIttsGLPUfzzn4E1iONYgzRknq7kTP06EZZ0u2/qc8CF5cbuKHbwQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzndqSieOxOi50y/3/YLDQJb54wX91/ghwSfb6JKWPEDUese9jB
	nklepqbbGCR/U7nMJv7LoLVM2lnW9tG716Kdpki1wJDVbNcFPWLmUM+knuI31vLL6Z7/MuX4EyA
	P7fwlRB6eXA==
X-Received: from dlber14.prod.google.com ([2002:a05:7022:264e:b0:12d:b65b:1fb3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6997:b0:12d:de3e:86a7
 with SMTP id a92af1059eb24-13436bb1815mr5054005c88.37.1778776500969; Thu, 14
 May 2026 09:35:00 -0700 (PDT)
Date: Thu, 14 May 2026 09:34:06 -0700
In-Reply-To: <20260514163409.927816-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512174638.120445-1-irogers@google.com> <20260514163409.927816-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514163409.927816-15-irogers@google.com>
Subject: [PATCH v3 14/17] perf pmu-events: Parallelize JSON and metric
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
index 70a45e62f5d1..316708e32d74 100755
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

