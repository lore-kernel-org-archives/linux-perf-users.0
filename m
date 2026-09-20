Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A283D45C3
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789881761; cv=none; b=oNm8BzNF/StPtvmhQR+jaD09gwinIg3Z1+lK0Kh/aBRAh2tcftAjco1IReGSnrEqMwtK997BURIHauwSjPs1vvr1dB6rf5tgBGS7TSUF8NJ7H7J67Ok1QhS4TNzIg1bYL/vGzqbrkUP8NENtAQTpuBH9C4rkyH4FCwxn2yvmvIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789881761; c=relaxed/simple;
	bh=GkmdESfvVw6Bhi5+j9XdWNIprQz32gaz404QEYVpfn8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BzOut6V7KOhrnLwIJzKJ0DlXbBzX3BOtmovQGqtrWHb6KR7vAj1YRDiZ3qWMWJv4TOV35clnai1UcqgUznTgDoMFwkpmwuMxrDdQH6wMtTVFf6DUW3uskMcMUy88tAE6DP6C3ZLzRbb6qIjP7szmIBVGOxUjcJT77doV2sRTXlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=acUdqwbJ; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="acUdqwbJ"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-395543dc382so2583635a91.0
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 22:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789881760; x=1790486560; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s1sYzCcuJgWy+91qkWtU7G0DCPhx+Hi9Vsjhecq4f4U=;
        b=acUdqwbJ1IqBlDk/p7AJmUAVs6DlH3MYACyn/StMBKsfB5qB3oPSyfnwKQpTRFfOiw
         AM9N/O+0yl1BMk7rYe0zbpnqh0sLrWKAYozy7vcyPneNwAFYlEOFOf/J+z5yYCNhnJRZ
         tEEDXidcTwiz35WKUbvIyu5HyR3GV8KmEcEN1HjubvdbIAOclPWIyHCaA36fRbTPBr/w
         FTui426JGeXkb4NTWuXxa3KCL+pe3yl2mekVO8x2nAmnNO4FB2SdaSmzCvdVOz2hZFsn
         fZ65r9CKkeZFB1yXziM+JR0ScUA6oh7Wnmw1rwf76Nin1xTEbS0TTPHa17qFKPx09Aw4
         PjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789881760; x=1790486560;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s1sYzCcuJgWy+91qkWtU7G0DCPhx+Hi9Vsjhecq4f4U=;
        b=Y/wUtvbO/vfulVzGQzrI5TpktsRG6dzy1R3Y4K/Asek1CJM6wWcbDgvw2xSJaspxw7
         /jGF+oa3JM0HD9cRA8FDAQIuPS856VCuZfBoYLvmhS86Ku23hoQzW0Me5v42i3yz4p+/
         Jtn+V8IQTYHxSMuuzVjI8EuzjwNPn92YOtUhx3HjQ4sz4z8+yR/5wcmkWDVzapTYCdbz
         XzV5ud5FijrwDy6B1M/op3aULdI6AxzgYtLMOEm3lUU0e0TkAJWmiVljO11+L136e5yf
         LlJIA28/EANWa6sy8BLkxokkEiu+Qg7WIPAdpDjWy2C3P6R+mYxmlTjwgkCLLwnJ7hDw
         8H1Q==
X-Forwarded-Encrypted: i=1; AKwUvBwrF1i9JWtFwzPcaW8er6wQRVBwoFR+JgXHuHrPAewR8vsCeGtEB2HDwHLoRuqvjM6yT7YPvH+eO+mLCWjndBGA@vger.kernel.org
X-Gm-Message-State: AFuF++nP+MzHOoHzSJSWxQn4/PiG91+OjL+g4Pl9xpzBUn/yDZSIIkZw
	NqB+qbOmoR6ouYRRolKOIFSXNZgjRWwFv7jznuunsSN2aLS6A5MmlhuK37pdgdJi1hoYtVhGm5O
	yhPIUeYDurA==
X-Received: from dldyr17-n1.prod.google.com ([2002:a05:701b:4511:10b0:143:7976:20e7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:917:b0:39e:6a81:c922
 with SMTP id 98e67ed59e1d1-39e6a81c9c9mr5032088a91.21.1789881759581; Sat, 19
 Sep 2026 22:22:39 -0700 (PDT)
Date: Sat, 19 Sep 2026 22:20:53 -0700
In-Reply-To: <cover.1789880842.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789880842.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <f64b7f59e863302bb81c14a3a13af2e116d38b8f.1789880842.git.irogers@google.com>
Subject: [PATCH v1 01/49] perf python: Update syscall format string to
 optional positional
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	alice.mei.rogers@gmail.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: dapeng1.mi@linux.intel.com, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Update the PyArg_ParseTupleAndKeywords format string for
pyrf__syscall_name() and pyrf__syscall_id() from "i|$i" to "i|i" (and
"s|$i" to "s|i"), allowing elf_machine to be passed as an optional
positional argument as well as a keyword argument.

Update syscall_id() and syscall_name() in perf.pyi to match, and set the
return type of syscall_name() to Optional[str] as unknown syscall numbers
return None.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/perf.pyi | 4 ++--
 tools/perf/util/python.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
index 58b0b3ed819d..e737eb21567c 100644
--- a/tools/perf/python/perf.pyi
+++ b/tools/perf/python/perf.pyi
@@ -20,7 +20,7 @@ def metrics() -> List[Dict[str, Union[str, List[str]]]]:
     """
     ...
 
-def syscall_name(id: int, *, elf_machine: Optional[int] = None) -> str:
+def syscall_name(id: int, elf_machine: Optional[int] = None) -> Optional[str]:
     """Convert a syscall number to its name.
 
     Args:
@@ -32,7 +32,7 @@ def syscall_name(id: int, *, elf_machine: Optional[int] = None) -> str:
     """
     ...
 
-def syscall_id(name: str, *, elf_machine: Optional[int] = None) -> int:
+def syscall_id(name: str, elf_machine: Optional[int] = None) -> int:
     """Convert a syscall name to its number.
 
     Args:
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index d8a842621cda..a3ffaf4d0850 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -4111,7 +4111,7 @@ static PyObject *pyrf__syscall_name(PyObject *self, PyObject *args, PyObject *kw
 	int elf_machine = EM_HOST;
 	static char *kwlist[] = { "id", "elf_machine", NULL };
 
-	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "i|$i", kwlist, &id, &elf_machine))
+	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "i|i", kwlist, &id, &elf_machine))
 		return NULL;
 
 	name = syscalltbl__name(elf_machine, id);
@@ -4127,7 +4127,7 @@ static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args, PyObject *kwar
 	int elf_machine = EM_HOST;
 	static char *kwlist[] = { "name", "elf_machine", NULL };
 
-	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "s|$i", kwlist, &name, &elf_machine))
+	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "s|i", kwlist, &name, &elf_machine))
 		return NULL;
 
 	id = syscalltbl__id(elf_machine, name);
-- 
2.55.0.1082.g2b9226bbc0-goog

