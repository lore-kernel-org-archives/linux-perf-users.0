Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695F248BD52
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119242; cv=none; b=eFEkDa2ZlgORFXmrth8+VAn4g5jpZ61f0s10xUd10bneesc4X3QhHmx1wdorci5ZjPfDhwkA3FAE5QmXnjBQ8SuIhTXRurKp+UdugU7nlLV+oXevDECpbUQCnZFrqoSCNVX0zFpHpusbivkAJHP1afV/JDaczarwEpEB/aQ0Se8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119242; c=relaxed/simple;
	bh=L14klLZVHgQZQ5seTQndooWBR1p+rofTHdL1BdJlPEE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fWbOLyEF/OqKSWL1dhngrGQUXIeQy0ADz71fgq/bwvlIvLW8/UeGHAzaxbWvPyS4ZAPazzXcwI7IjCTEQsmHGmKOp19dagPmzdMDRPFk4xdQ2lhtQPOyMLKRzDZ8LDv8xAQXzzylc1z0Ac+bZR0mdZKe+yE5chwNxHWSyFhfBGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H0k/gMd3; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H0k/gMd3"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-135405e4035so10554220c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 08:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779119228; x=1779724028; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/d6+paeaMcTTaPCQt35CLTxbLauWsR41NVkCLRNdE7I=;
        b=H0k/gMd30KAQYok4yNOI0BBiOPDSnBn0MLL82+2G0B9XMQEEwUDwefYukbmHfGPEnm
         RqOyGVwxdqVdQRFNOWUMqpIRYFZ4rTsOtrERCRu+aJ2WRF8lJ4OVGKgi7GqSrOwco5SR
         Ip8ZYwnWkIhapNn4Emd5njwb4ByzZ68TegQWp8f+pUcHAjnqpiRqpHSZqfwTgopJeIZi
         7IzIDQ4m0rj+oxww1dCXhuLtNwQ8Qnw4+pyOuc/f3rcETHQSEX5TL2xqJMd0gyu1IaVN
         u0pjnmdJGRAQ4yBhC/XqWto5xQTWvwO5+tRZ+rLf8mBt+da9/93IEnJ/QV1CCUSq+t+o
         aT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779119228; x=1779724028;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/d6+paeaMcTTaPCQt35CLTxbLauWsR41NVkCLRNdE7I=;
        b=KwW+AKEVHCSWAr9qMP7SdOvFWjTZGv/n9DTBvQ3cCgVtQVXCBpraNIP2w16v2+t4JU
         BhU+ZJcgyj8S8qVd8BAkXBgKEpu7e+UFI7wg02ZFnR+WiYsQbRmpwUoeklJE7CtBLMPd
         EhW+la25Tuy3SY7EHF3CUP4m7KYheFzHU6V9DBReh0+T6/zu5B41oxBfsDnBqrIrxgbf
         vBMS5lJDPLMgDZo6JLXG8CMsvxXATdw9kAmoZB6UvW78A4ewiVD4fxlHVp0ShJI6O6qR
         ujT8F58U/7Vq/TGWUEpm3tz3QaH4C1faiUSC3xzWh1uxx2Z1HcY5N2O7C5XZGgPwp776
         da2g==
X-Forwarded-Encrypted: i=1; AFNElJ9OUcLq0gxy3oIu+HSZeG7Ws3D1jWoL093bGT9ngtjX5rYNgJgZN1SgBNy6OqPWY8sywp0ZoBRAsxDbVm2nhUDm@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4n68s3F5gSRxaGRgZk6Ss5d/JqPQpf5cMY3YOp3bcBcqlKT8v
	tV/illB/uK5ljjAwIo0geKudJXvvUdQxC4Yt6q4Rn/FwkobjzN3Bp5dGE1Vx9eSI41/waxwpzFs
	ryTVhUyE7lQ==
X-Received: from dlbpt3.prod.google.com ([2002:a05:7022:e803:b0:135:3471:e411])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:689d:b0:12d:ca32:5a2
 with SMTP id a92af1059eb24-135044192c9mr6931834c88.6.1779119227537; Mon, 18
 May 2026 08:47:07 -0700 (PDT)
Date: Mon, 18 May 2026 08:46:35 -0700
In-Reply-To: <20260518154638.2798789-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518044740.2526802-1-irogers@google.com> <20260518154638.2798789-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518154638.2798789-12-irogers@google.com>
Subject: [PATCH v7 11/14] perf pmu-events: Parallelize JSON and metric
 pre-computation in jevents.py
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, mingo@redhat.com, mmayer@broadcom.com, 
	nathan@kernel.org, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	qmo@kernel.org, ricky.ringler@proton.me, song@kernel.org, 
	swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
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
index 7344940e776a..807c42edcd33 100755
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

