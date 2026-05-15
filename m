Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF4A3F8EC2
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866767; cv=none; b=RQi9nYs42hHvzfVJFLBXh/VDs6vrXG7HVvhW26gCpK1YjFGR3kUleDNMQOPrEXnYk2JXAXWR3vjTczh6hQnxnD6lhwMRpA7aTh6RMjL0VGmH76avBr08FStA8F1F83BIjXSi8+q5LLCyv4tBNBDFlDHK7jkgBNgukQ9rBHMvx3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866767; c=relaxed/simple;
	bh=U58pP/TUmRrk7WCcL0YF9O+OAMrzJoeqkNgvOhKzQbE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ajkZ5QmQIy11fz9Yl0bL+2sMwTqwCw2KY6kPsbv1uECZbkCDXdZkLFAnr3k2bZtSWhSgbtFXCgIQmP2Q0T5rBfEb5xE3OQ8rsDOKtbcfN08cw6hKBbe/gaWo5G1ql0UoBnKAUsNtqp4Rt15b1wO4nx7zCssihK+/HNHt40uqYM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mXHskHyc; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mXHskHyc"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1353bfdbf99so231994c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 10:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778866763; x=1779471563; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=irFN3XgCmY9gu3BjMAXRUYXhqbzy4e2MoZtkaX0rD38=;
        b=mXHskHycjSNQBMoJfXr+qWH908oqwHtMjQ5OnMTvVp+6isuESWDjk9U+/YtXl5ZKMH
         nkuTNO5ODr1hwNLW5ZHW9xv0ts97eZjQOgYAjGpDKMoE3Mhh1hV82x5bLTmAVzjbXpAi
         hycyomXFwIS+SiFeZ7voEyWHedBME0eZcg6SDRpql4T6cFLqiIbKsfvmg5Z9LPqJPunf
         WmHOtOqn92h2vXLY4xydclpfnDTaUMs9T3KPxoMSdXZtlSFSwjRBB3FP/ARrSdC/dnhW
         Vw7Hb947IgnClOAsdmTv2zZloG8X0nh1DXkWS7/pWsUOReuMnaQvqRWoTWOjJ15/MNGx
         V3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866763; x=1779471563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=irFN3XgCmY9gu3BjMAXRUYXhqbzy4e2MoZtkaX0rD38=;
        b=kgPMpok2Ok4rdZmHgsKlLT6zUlnUoSfDD4MYrK+0ycDLcsSsHVV6IkVWnbSss/KtUD
         YQJmkSGx/ZnaJml7r+Vr7JvfZA0nRsxmiIoWM1CESc+NDppa6fc5rqXRp4JQhhEit5kJ
         qNh0xl5pRPREOC2GDLgHwWzxdmqCg7zX4vGjzqTEzYNEcZE6KGmxypEAJGXlbCOt0lAg
         skvDUWBHbL99GLtDECmS79Whl2LQT3lRsnh/R5mp+9gcmPm9mlilu0JfVHwNKYy8mfTO
         YB8FjkTlLuqjC8ysE8VKumbC4ZGsjQg8ajcguwkuiECvCY+w5wSLYM6tZLCuhuEfNSOk
         kpjA==
X-Forwarded-Encrypted: i=1; AFNElJ9cT01QYL822rB8mkgCLkp18bboVaKaU9tNxRrqH1wznGQlzWEOCmydXTdvfKobi6sF+XptiOokQ3kyUxGG4jDj@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/mDe24fzHAI+pShb3wqLICV1BbDGUtAY8mdhqFDl6o8/tFs9x
	z1ZTjGM9g2YQl6vHiewUGHW52j2JgTdi25ZdNvbxK3HqeuwRcq49gwp0sis61CziBNQbLc6Y9an
	EMtnWKfi7Lg==
X-Received: from dlea18-n2.prod.google.com ([2002:a05:701b:4212:20b0:12c:211d:3e86])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2590:b0:130:6936:dcde
 with SMTP id a92af1059eb24-13504625963mr2532796c88.14.1778866762327; Fri, 15
 May 2026 10:39:22 -0700 (PDT)
Date: Fri, 15 May 2026 10:38:48 -0700
In-Reply-To: <20260515173852.1378571-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fWfrGMV4EafqkwQO-R33c_szXcxVLgH0c4k2zt3zj4HdQ@mail.gmail.com>
 <20260515173852.1378571-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515173852.1378571-12-irogers@google.com>
Subject: [PATCH v4 11/14] perf pmu-events: Parallelize JSON and metric
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
index 6adf4b30e1ba..ebacb056524f 100755
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

