Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B63033A9E8
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967244; cv=none; b=F/0CkyLILTJX3+GXigKyQtDs3UILfv/yNNxD1z/dnK0e26lUPFQNi+d8By/TxluE1pBnsl2iyEJauDFwuZiRASu1HJw1L3/GRxh2XFd/QXP/zp6wyP8My7pm2Ect3L8kZ8enCmirah7iHtOljvO17loK7Zj8AlJaioO/FXp+I90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967244; c=relaxed/simple;
	bh=GkmdESfvVw6Bhi5+j9XdWNIprQz32gaz404QEYVpfn8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CnV/7H8mAlSJvedWIkvUO2UiKIAHnBJRZ8yJTwufVDR2gX7NB5+cQp9GFavkTCjZ32/UXwS9WjmHYebFLT7lbQJ8rtBhgUxGxj5zzQ2r0V7n0W/WhYh9cYZw7GofMCMAXjpQ+noXP2yY/UpEgF8Y2SuRYAavb+lkMKCkfvqvxZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Leii7JsG; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Leii7JsG"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f57e31b6eso2495547a91.1
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 22:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789967243; x=1790572043; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s1sYzCcuJgWy+91qkWtU7G0DCPhx+Hi9Vsjhecq4f4U=;
        b=Leii7JsGB+5B5vsNYSutBh9CsIZQJNW+mnTyoIbdckHa1mhFCzZLyG59gJL1bANaYy
         s9Sfe49b4ULOyJSBK4l5NHRrS92hQ8+MxlbILtgJ0kdUxklLTauPXFb2tvjqmAE7BaJY
         XcEuNL0QwfcOYjB+Ifx+yTot3c/q+BckD9MFuNavDbJskGFH8RFSWpSewEqeFq3T5MPK
         WzApZ/fjTgaVFwqxA9FT+Cy1DfZyxfnzyCJis0eCBkNGmHHNusN5NtnHG1kosxFD4O9n
         T9o+/eHXC7Nu+fm94iC+9n9x7c2aSe3DwgEDNl8omjJSma3F1kOx5bd7i+xcbnkmxoLE
         dUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789967243; x=1790572043;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s1sYzCcuJgWy+91qkWtU7G0DCPhx+Hi9Vsjhecq4f4U=;
        b=NSQfVWl58vhQjc6OC9XZD0YC6TBpkM5C0l4oLcIBcSG9kwcONc/VZp0G/0T4mPOW0r
         m51NeKILahmbU/EeFcejbxQ7d4zVJEO7YxSmc3ryHqF7Sjlomy990muOycGrRh4+MqJW
         a+zpXaK4/w9z7otYhb2OK0c+hjekfu9v1mdBbJAHcou0FHiquUX/KrNsdFvyff7O+UKR
         wtxE/aCMwLwgb3JiJOxofY5ZElZ86F97Mq+hX8kaa5kHhIDHa0OsSLyx/XsUT4Vzdlsv
         BcTVhLvF31efXfyV/pjOXjXDKN2S+6NcgE6F8/ELeRJD0rY2VbFsFgysGdMyXBt/iKyi
         TqlQ==
X-Forwarded-Encrypted: i=1; AKwUvBzasBDO3y/xTqA9xnjAJwjFDux23pudnqDHRg0lXVR5wgSxqqcJ9CqJa3egGoHxXYE0BC3vhAv95xo+qkOCcVMG@vger.kernel.org
X-Gm-Message-State: AFuF++kJC7CHON3W+VxEpAhrrKkI4x2d8fFGL8qlFUlr+EPS04JcW/F3
	4IASHi2scTsvULy3n5VXS1VutmHyNKZFiot/1y09P3fNQe2g6xYRtM4n3mp83DG4brYxd8gee1D
	UrVuEqMC2mA==
X-Received: from dldyr17-n1.prod.google.com ([2002:a05:701b:4511:10b0:143:7976:20e7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:54c4:b0:39e:4c7f:7308
 with SMTP id 98e67ed59e1d1-39e55071981mr14570736a91.31.1789967242503; Sun, 20
 Sep 2026 22:07:22 -0700 (PDT)
Date: Sun, 20 Sep 2026 22:06:19 -0700
In-Reply-To: <cover.1789966896.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <f64b7f59e863302bb81c14a3a13af2e116d38b8f.1789966896.git.irogers@google.com>
Subject: [PATCH v2 01/49] perf python: Update syscall format string to
 optional positional
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
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

