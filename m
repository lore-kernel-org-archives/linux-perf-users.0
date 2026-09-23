Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC556448BBE
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187164; cv=none; b=Y6OUuRqzbZrkRx1NcZYrGn/+ZxTB76v3ngrWQSYj4rOJQEMNZtZE3cHl2h80bDuNGNeb5eMnRaP0NHhGZLfWaz5JcLEDWbH4hznujq4D3GiNHCXihH0ZJ6hFWsPfSCkiv1ZpxeADYiGvIIYmQBqbvdw/WWXfIQ4Mrz/4E9igNVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187164; c=relaxed/simple;
	bh=6dZEsE3SRcgJOYw7YhANI/w5SxsPE65Z1WqjWUidHYU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZoLxEyMf4ZI4rY5CfAECAnTVDVTt4D5BVYk7RMaQGIviZNIggCWj59xiZht9OIiZCEncngHdgIpwYTwLMZST48dMmXB2A2iSNyh2fQaVo7ZV+tycqjwZCQpd4KXj7Xa9FdT5/JrPeD1yVnASTP4SYGIm5McPdfFb8FBWoPgv6yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fCU30zP5; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fCU30zP5"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1431ba79941so1401496c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 11:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790187162; x=1790791962; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4l7+rumY9g/hpFQl+HxtRHRoNg1BQjchsbu3u4RYDjQ=;
        b=fCU30zP55gOldAYBiCr94GRO6hu9yvZFnhxRMgUwLdJxCWxEkff3YY5aYz+kBkb9pZ
         MQyCRvIK3fX7dBpy4sFT92TswwcNRqimzYZ7R79/fOkRtYngZANu4Gf+qubYT4tUjfZJ
         QfLMIXPDztQl5geQK/2CYpxZPnc8EDG3k5ofwKr5Lu8ZfXQlo4PbxscdE3mTZLUoB2zl
         Hej8AWSsVAjBd48iKAfy4Ou0S4Okt1sfWSFR+uVcS6GAVG8RpfJwVGAL+NlXyjo7xXzg
         4RHqMYY4S65KZphiXM1GQ0YkITkazC3FgQfXnsLoKmE2r+sgz1mzyygabsuQEEzKZBbj
         5EYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790187162; x=1790791962;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4l7+rumY9g/hpFQl+HxtRHRoNg1BQjchsbu3u4RYDjQ=;
        b=NrBHOYCPVSpdkXcz5KzD0D37eBlyQhXz1zypRFoA9Y/jmZ7wbaPGiovKdieXVVEfk/
         jB5lCJU5+07N7j4jT/9yQ7GTk1Ul8oJJYN/5SVFikKRXpVV/x9m7OVpSVXhd1gRpT4Os
         IqYukIxdkxzmGIfGR2zMuwmGK9Iy0imj1MOuuHZKU0gWFI+I87k1AGmNVvWaqB26NTno
         66xkTpgNI3Jdr9vm1B+FcWVeEmZuhUx3XYkM6FRQAcfBxP0+cOxHe8j9D9VLnd49LLL1
         pEMxgo6M1xCF6rulXDsdDrrQQXTxKtxjae9YbG+wJqHMpZh8Obd7QdF4QOuTWyeJRNR6
         +whw==
X-Forwarded-Encrypted: i=1; AKwUvBxq4VVx1ACOHeke7f80hugOlQ4DzCf/HWaC5dqpmIua/RCIStTGNu8EwahBa3DNHcEsAH0gtQscA8PTLQNi/gTn@vger.kernel.org
X-Gm-Message-State: AFuF++l3csdEuBD/uq6IRngZPLaAEV3wWQEwnqI6enErVd9G7CNKTcb/
	3GZzbHaxa+Dq0I9NAzYetuM5uhQ2dfcvfeOJhGsGxPpS6orN3+SXLybh/UmTOZZTUjyaX5H1Gfi
	YFI2fgONv2g==
X-Received: from dlbem11.prod.google.com ([2002:a05:7022:100b:b0:144:d7d5:5999])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701a:c961:b0:143:824b:5450
 with SMTP id a92af1059eb24-144fa42fa3bmr2964897c88.32.1790187161424; Wed, 23
 Sep 2026 11:12:41 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:11:25 -0700
In-Reply-To: <20260923181213.3032038-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <20260923181213.3032038-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923181213.3032038-3-irogers@google.com>
Subject: [PATCH v3 02/49] perf python: Update callchain stubs and session
 thread lookup
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
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
index 6ff0b4ed0bef..9e5ecc2d9abf 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -3914,26 +3914,29 @@ static PyObject *pyrf_session__find_thread(struct pyrf_session *psession, PyObje
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
2.56.0.rc1.310.g51773c2048-goog

