Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0103806B4
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403658; cv=none; b=NIXsurM83vcqFJpz3Z7vsoKa6ULEGWpGjtyoSvHx5iIOkz7CfVLybQGiRGmj2kPkioQ3rS6pyakKeHF/O/7MZHtPsEefw36UytdBqSAtN2Ck6PSbMzXmv3Hk6taNH/TcMso/eidG6VmCv2aN7M+nFNPrSZHvF6a7tYYdHo1vqaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403658; c=relaxed/simple;
	bh=bcV4QgDuwA6XRfNgtpQGlkFwjjsX3WJ9XO7qL35F0hw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gB9C+NW9ED6C/TGo0tsHPRmr6Cs5jaix+379AdnicCJ1K10RJhJbWFn4s63MpOVZ4+eojTV1SgAcPbn7EXU3ZgOqlgz4LIAve+hV+gEhRLj58s3F5nroi4Ot/+ucs792uTJd1D5gl8n9Jm5xpu0rBiviZuRT18iEiRLRbG82eTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kmw6aVtj; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kmw6aVtj"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-342b66c0b06so687481eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 23:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790403656; x=1791008456; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vVw7FldzXbc/C5ExMpEZnR6MKQqX8kDLhq0eNyWLzfY=;
        b=Kmw6aVtjnH1y8yOWh3GYR1zdExh5YHRCioPP33dKRy9WQ1ikR2n+VQBdJsjf4HVr/v
         GNL+i4rvFNfP0inVmBKV9CQnoHzt5tg/MAu5zDRPe+lfMm2LNJaFbmIsquTxQPQXwfhs
         oGlB604jo8bmhxWZuukDGKaWRgf4kPWVPiIXsUOZfB9x3FkcxSpYJFQp/ZMMb79/WpCS
         iV/hIedT4KcAm6Kf5BKgJcMaF5caQ05oR+e+LrW1n4FZVkVOXbfx9PAluNUGdkiZ9Vzj
         2ItsAqmrJ8iccS3DeQ9Nkel6MZj2sVs52Q6Qj7lzPvVmbBkfk6Fwc6NrZ3jqXYPGzx/c
         GosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790403656; x=1791008456;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vVw7FldzXbc/C5ExMpEZnR6MKQqX8kDLhq0eNyWLzfY=;
        b=ta8Gjfqw4XhkakVom/ozY7bBfD6TDRLGAqnLcKeUUNhhFvf6IYmgLTdJRAFixCRyW2
         r8hXoCqdHEdKwN27LXozAxKUORaP4dRF5P2RV0m4jIed7BbzLtVLcrs/cAdyy6BSXzTG
         1nSUk0wL3fJufAz+8fHGmFyWNvPqLm5hrQrkfoHtBDQ02maSTBPTql82kVjwzqxrtz80
         9UgrnwS4/S8TPgwCZIUz5X/6YGq6oQyv0YXQkNXOfgUVrlfgZ5RNVh9/lSUeHr5xgy2D
         3g0CtIOs4AKBbNf86Zb7xYKqZpDwNP8vscqtIOjUmR1Lbl6bGC/7DOZph+ihsUG4GCBQ
         IEwQ==
X-Forwarded-Encrypted: i=1; AKwUvBxK5YmAy7GSft2MXVxLQSMcwiZF4i/pyjGemFIEcPyy5Fbu9H2FLyNcEU0ZFOcPq0mzhqYsAgl6fO3vT2YOjNVO@vger.kernel.org
X-Gm-Message-State: AFuF++k3nos/E5eP3zy4/N8/KnCPz7FJkYq2RrhOBLykeUDdF7e2zohp
	MWJQ/tg1Y5qu7F44myyEoU0cfT+dCLX7xWBUnRXqTuhOy8ZD8aue7a4CTHDJNUv6dGuUWBkxxAc
	bweDkTOrNuQ==
X-Received: from dlev28.prod.google.com ([2002:a05:701b:465c:b0:143:9704:de05])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:418c:b0:141:9d33:f1b8
 with SMTP id a92af1059eb24-146cea5df96mr2950536c88.12.1790403655394; Fri, 25
 Sep 2026 23:20:55 -0700 (PDT)
Date: Fri, 25 Sep 2026 23:19:29 -0700
In-Reply-To: <20260926062029.800743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923181213.3032038-1-irogers@google.com> <20260926062029.800743-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260926062029.800743-3-irogers@google.com>
Subject: [PATCH v4 02/49] perf python: Update callchain stubs and session
 thread lookup
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Update pyrf_session__find_thread() in util/python.c to accept an
optional tid parameter (defaulting to pid) and return None instead of
raising TypeError when a thread is not found in the session machines.

Update perf.pyi to match:
- Set session.find_thread() signature to (pid: int, tid: int = -1) ->
  Optional[thread].
- Update callchain_node.symbol and callchain_node.dso to str (the C
  getters return "[unknown]" fallback strings rather than None) and add
  __iter__() to callchain.

Also update treport.py to handle Optional[thread] returned by
session.find_thread().

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/perf.pyi   |  7 ++++---
 tools/perf/python/treport.py |  2 +-
 tools/perf/util/python.c     | 19 +++++++++++--------
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
index c390e17708b1..92aad84ca542 100644
--- a/tools/perf/python/perf.pyi
+++ b/tools/perf/python/perf.pyi
@@ -332,13 +332,14 @@ class branch_stack:
 class callchain_node:
     """Represents a frame in the callchain."""
     ip: int
-    symbol: Optional[str]
-    dso: Optional[str]
+    symbol: str
+    dso: str
 
 class callchain:
     """Sequence of callchain frames."""
     def __len__(self) -> int: ...
     def __getitem__(self, index: int) -> callchain_node: ...
+    def __iter__(self) -> Iterator[callchain_node]: ...
 
 class stat_event(_sample_members):
     """Represents a stat event from perf."""
@@ -453,7 +454,7 @@ class session:
     def process_events(self) -> None:
         """Process all events in the session."""
         ...
-    def find_thread(self, pid: int) -> thread:
+    def find_thread(self, pid: int, tid: int = -1, /) -> Optional[thread]:
         """Returns the thread associated with a pid."""
         ...
 
diff --git a/tools/perf/python/treport.py b/tools/perf/python/treport.py
index 43542599a884..786b852f471c 100755
--- a/tools/perf/python/treport.py
+++ b/tools/perf/python/treport.py
@@ -92,7 +92,7 @@ class ProfileNode:
         try:
             assert session
             thread = session.find_thread(sample.sample_tid)
-            comm = thread.comm()
+            comm = (thread.comm() if thread else None) or f"unknown ({pid})"
         except Exception:
             comm = f"unknown ({pid})"
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 543312c99c20..40b327801b7d 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -3915,26 +3915,29 @@ static PyObject *pyrf_session__find_thread(struct pyrf_session *psession, PyObje
 	struct machine *machine;
 	struct thread *thread = NULL;
 	PyObject *result;
-	int pid;
+	int pid, tid = -1;
 
 	CHECK_INITIALIZED(psession->session, "session");
 
-	if (!PyArg_ParseTuple(args, "i", &pid))
+	if (!PyArg_ParseTuple(args, "i|i", &pid, &tid))
 		return NULL;
 
+	if (tid == -1)
+		tid = pid;
+
+	/* Look up the thread in the host machine first, then fall back to guest machines. */
 	machine = &psession->session->machines.host;
-	thread = machine__find_thread(machine, pid, pid);
+	thread = machine__find_thread(machine, pid, tid);
 
 	if (!thread) {
 		machine = perf_session__find_machine(psession->session, pid);
 		if (machine)
-			thread = machine__find_thread(machine, pid, pid);
+			thread = machine__find_thread(machine, pid, tid);
 	}
 
-	if (!thread) {
-		PyErr_Format(PyExc_TypeError, "Failed to find thread %d", pid);
-		return NULL;
-	}
+	/* Return None rather than raising TypeError when a PID/TID is not known. */
+	if (!thread)
+		Py_RETURN_NONE;
 	result = pyrf_thread__from_thread(thread);
 	thread__put(thread);
 	return result;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

