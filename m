Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60785352009
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967246; cv=none; b=mNda2JsuipA8CMWHNioW9+UC29g2WnIu4MO2r/ecwkPswpytEPu9xpUaP9qpIjKg0aTCXUz0k//Shn+bPLRL9a0dA/pHBkQWGCX09NMQSuC9dkhyqfAGJRQHcH06gUvUp8WVkLVqggojgkl7i3EfQlesddVKYinZTIAFyBtqfIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967246; c=relaxed/simple;
	bh=UEDUijyDKwQHA4IBoutQo2f7jglmv65f6fvnoetNWRs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W22GnkK1wu6aoHYFr9Psw6uTb9VwhBSuZd7ysiUxY87H08MZJfXfJu4e2+epqg/aFxHSITVjiVh87GusGma0Fwzz9ecwlpOR6boPdv5Kg5B6NBtO3pXlGmJOljiN/FZLxGchXdrIWwrdTKe1faOK9AHEkX1QT8tD+HLg0GRm3ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=okFWF32i; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="okFWF32i"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc7361c62b9so1592051a12.3
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 22:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789967244; x=1790572044; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vNtQnLVCRy146T+3xtXFPYE2nmLMOTV4tSP/1bLz73s=;
        b=okFWF32ipa3OJeWcfbtEl9jiDQUhzR1qNH21lD6ZeJ1KgkGppWOPXbS46d5wPJQEaT
         lWOZEzfKnwfWDq9wyw79Kf1u2Jse2OA6+i5Xyo00AHHvqjEyu354xYTMTzkfOVsX6ZeT
         iJUTYVCdFz6GQcXeI7FjrIaciqwGMH6h+uLRhovt1/HMneDJOOvZRn7U2vEcLyMvC3/m
         XaqMjWlnbltqOTYh0BX/qhMKNa1DKnevgIyGZsvglUlMSasnbqYuFDl0GXRna9KSUAlW
         KrQwPw35QVP2K1QwsNo88aJAd7LNJLfVTvUva28LVbBGXaE3xJ8TVQmPgvqUW13q06gC
         195w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789967244; x=1790572044;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vNtQnLVCRy146T+3xtXFPYE2nmLMOTV4tSP/1bLz73s=;
        b=U2CixtGNLghQnX3ssk0OL+7t5HhLCpIq/g0f1vrdo37lgbCCrdq8Xxf1A8yxAkC2+v
         u0av/0hz0Y198Uln9Zn9acmJjM6PC+2PQouFOZWu3/LkWK4WMsg07hgZ0I71ZaeLlef2
         VYOBj1oxgGvzid17B+VCDyxBg1gl0/dsldONucJOLOMpugnKVpxYUp+OSywJ2pnb6hiU
         yGHFO2rPA/4LsbeoL9rgfa+92uo4NshH0qkmkl13q4dbIOMdAV5Ss+HboZsRUMQuu8gu
         3TSzxe1HHb61gzFPjKmoxGI0A7N9ntCZIvNMzSB5HgicGTqjQs94dMneNUCEZRe0XSfT
         vmlA==
X-Forwarded-Encrypted: i=1; AKwUvBz8Tl+kPOPSKiMP5Ygl6Tp7tAnz59USaX3A7deXKRWOZ4R3y/Q47vx436Hlk96LHkLd62HYPp5LUtp3DJJSe5ne@vger.kernel.org
X-Gm-Message-State: AFuF++kE6cErpL+QOvyVXOL6MhEEVR5+t0XlmwMYfMbO0/wOaDH7PuWX
	+6xgOqZTns0ty/BdAnDfcd60155b4qyns0+8UkVJMr5ZjB22B4P2d73djeh0UcEMr4Y7gbdrAUM
	bOY/t8ndn4Q==
X-Received: from dldz1-n2.prod.google.com ([2002:a05:701b:4181:20b0:144:e017:1dfa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a11d:b0:3c4:4272:b400
 with SMTP id adf61e73a8af0-3dd8c53d594mr16238669637.18.1789967244462; Sun, 20
 Sep 2026 22:07:24 -0700 (PDT)
Date: Sun, 20 Sep 2026 22:06:20 -0700
In-Reply-To: <cover.1789966896.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <d438d782c7ffefb4dd3a86496a6e1723b5bc2097.1789966896.git.irogers@google.com>
Subject: [PATCH v2 02/49] perf python: Update callchain stubs and session
 thread lookup
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
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
index e737eb21567c..7217bca05821 100644
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

