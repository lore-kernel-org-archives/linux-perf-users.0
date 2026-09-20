Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81693D47C3
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789881763; cv=none; b=sEFOslZ/kOhOMMb44sGa+JkdnPZDfVTxaRMU15Rd4Gse5MBDXEt6owremh1uLP78zMnYswD0+NCwS/JLC7OfRp1RcA//0hiyKVFz8vIq+cj/UTmi4ALOdyOWDvEMGLIWZCHSoo7awyyGqDnTgUpV1dv+GnwU5ChzIfNOwyqmTyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789881763; c=relaxed/simple;
	bh=b6FTBE2cgcmTkzM7F+IvHRGwoCfgMp6KKaL4A+r9IGI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D21QCoYv40eFITgR560mFv77+TkDFxc1Bb9/Scrp+a0YQ9KxwfaOlKFnWBjnJwKMEjbxACZvQBoM5Plf9DjO+hKCen6U15TmPNpwiBnQ1zlsbgCiqLt4XQ2d4P+j0iV+lqt1gL+EUfUSy1YFdNNfYSgyXYmJBhT2wLB1MzFG8WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gozy75FV; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gozy75FV"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc4922b7c31so2012649a12.1
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 22:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789881761; x=1790486561; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xe997LNMBkLZ3Kgt92IC6PAaRQ4QWxrEwEsrkXtyTR0=;
        b=gozy75FVzcLlD+RhN2zrH9VT/g+LBzLfNxKhUQ+eGjUhE8EHRWrD/sh93PTO2M7sQC
         261d8Qlh5UJjIQGHCp8w5Ly0bFM+cRrLqWsL2tcrFk6lZ/dH+n0iO6q6QbAomZ6d1VtM
         Xa1Q0HuXJIfebv1rqFCY5AWYbm0056lJZNj3FYbbZZA1dQy89pcaUZYeo5iIAgwtSESe
         E0hZcHn8uFBlsnPv4tvBWKLdbg5CxhrWaQTkvtBeTPSr88jKhVDq5CzfpX4T06XU7G6U
         Cs4iJvCU+G68H4VaD9bBOZEV9bSv1LonuBk0YfUViFuTzCWlokaBOMw6xDOhvocLcHBR
         LNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789881761; x=1790486561;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xe997LNMBkLZ3Kgt92IC6PAaRQ4QWxrEwEsrkXtyTR0=;
        b=H2YhEgPcdeCpycP9+eDsFoF/F98WynBziOV+1JKqpLUudNopO0hmIkBXYKkg4Pim1b
         8AZhT9DMAhqsWnN9Dyn+3+v8fl6HaRLfnJx4l1YKIeyLvEku+qqHmUQxgiWy+oTgZRh/
         aWUVpfmUKsmKQud8ZFtSLpjfcFNIh41d4XA+j+Hh7F/+73vXVbbiZJc+DRE85uSR9g39
         wolEVGi6AM0yV3/+32qUAJdy9JFOfM8nhQtP85ne6FLBB70NUjzMY3LzlLHDLKaoVpqY
         uK1VOqKEP4TALaJeLrqoTR+SFVDc5Shd2rBapil/DdE6wtmmCIcSQj7sMnwbqKx+2Gow
         VwUA==
X-Forwarded-Encrypted: i=1; AKwUvBx9COILc9NLWrTa7LdAPwJEf9v/pvpWhXNksQEEqJIzShsnmCYT0Zioq7M4lubM5VZ75YBVh4I2dOBq9E2NjvJJ@vger.kernel.org
X-Gm-Message-State: AFuF++mnok4H5sq5L5UYJN1KoxSt8NyetlUTqmUJqFtekPOhlFH7mDxq
	FAAoUwydZ5JxzaQkojJtcr+ShdAOgNUGJumoK618CTyOrSOf4DMpSRaUpbdJfnk2q2xgMRTXCfr
	GBj2QWKJpgg==
X-Received: from dyhx2.prod.google.com ([2002:a05:7300:6702:b0:33e:446f:2f4b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d70f:b0:3dd:85a8:cacc
 with SMTP id adf61e73a8af0-3dd8c47d05fmr12714878637.35.1789881761250; Sat, 19
 Sep 2026 22:22:41 -0700 (PDT)
Date: Sat, 19 Sep 2026 22:20:54 -0700
In-Reply-To: <cover.1789880842.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789880842.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <621ab9b3227a1845f5c2d8819ad84e4cf494f50a.1789880842.git.irogers@google.com>
Subject: [PATCH v1 02/49] perf python: Update callchain stubs and session
 thread lookup
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	alice.mei.rogers@gmail.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: dapeng1.mi@linux.intel.com, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
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
index e737eb21567c..e5259e9b61dd 100644
--- a/tools/perf/python/perf.pyi
+++ b/tools/perf/python/perf.pyi
@@ -320,13 +320,14 @@ class branch_stack:
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
@@ -441,7 +442,7 @@ class session:
     def process_events(self) -> None:
         """Process all events in the session."""
         ...
-    def find_thread(self, pid: int) -> thread:
+    def find_thread(self, pid: int, tid: int = -1) -> Optional[thread]:
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
index a3ffaf4d0850..fbfa71b1c4b6 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -3912,26 +3912,29 @@ static PyObject *pyrf_session__find_thread(struct pyrf_session *psession, PyObje
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
2.55.0.1082.g2b9226bbc0-goog

