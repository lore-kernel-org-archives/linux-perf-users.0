Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0443F54BF
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 08:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895737; cv=none; b=Rd2WK0bOE7A2fHXn5ZaqufNcyXD08vxUc6F1dlnoLR3TgJlQ4DAUrk9LzO74G2uSugIfr7jd7MwtCd3+qQAhMjW5HcWFsBc2LPk1EG9Lw8xWCgo3Mxeg/dzKLwpufVERFaTAmkfpkLW9A+s98pIzZl6k4RnBHe7h/6kts1EkdLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895737; c=relaxed/simple;
	bh=7+QyHXLZWIIqfYatInR7dyOy9r9Ly8G9bisg+Wx0E3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jyCz18smGf7Oz2197+ZEEqNQoWGXpPZL6QRLk6BRf1SHsMCKikvYwcTSvX63TVdJMmqMYgc2NTs1zvsjztHjYlBbZIgI3mnyM6upAHbpzq2Sy597cfCvwCD8v66kMYEbxtPaqFHMLJIga4oSryVsXN/VyXnPItKK217TSwVMJgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ggCC8TGb; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ggCC8TGb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782895733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AyzKCBN3s9oeO1EVWFT/ClSVjk7GzsdBFf8WMlFESxc=;
	b=ggCC8TGbawNchQkwiPC4S7FSHw7Yu9r6rSQ/WYxEEiDkQGLPE4kWFEMAYuUFS2/j24n0fZ
	pbJ170kNzoDN+jkkkXK4bUTqdXiOIdxs/0QY0Gv0Iyu+S6FWGftMsUN8bPgRRkvDHoQgVR
	WwMuHMVMqg3aca7nBWwPAjXAjsFciI0=
From: Atish Patra <atish.patra@linux.dev>
Date: Wed, 01 Jul 2026 01:47:07 -0700
Subject: [PATCH v8 19/22] tools/perf: Support event code for arch standard
 events
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-counter_delegation-v8-19-7909f863a645@meta.com>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
In-Reply-To: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
To: Jiri Olsa <jolsa@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Namhyung Kim <namhyung@kernel.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Atish Patra <atish.patra@linux.dev>, Ian Rogers <irogers@google.com>, 
 Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Conor Dooley <conor@kernel.org>
X-Migadu-Flow: FLOW_OUT

From: Atish Patra <atishp@rivosinc.com>

RISC-V relies on the event encoding from the json file. That includes
arch standard events. If event code is present, event is already updated
with correct encoding. No need to update it again which results in losing
the event encoding.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 tools/perf/pmu-events/arch/riscv/arch-standard.json | 10 ++++++++++
 tools/perf/pmu-events/jevents.py                    |  9 ++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/riscv/arch-standard.json b/tools/perf/pmu-events/arch/riscv/arch-standard.json
new file mode 100644
index 000000000000..96e21f088558
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/arch-standard.json
@@ -0,0 +1,10 @@
+[
+  {
+    "EventName": "cycles",
+    "BriefDescription": "cycle executed"
+  },
+  {
+    "EventName": "instructions",
+    "BriefDescription": "instruction retired"
+  }
+]
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 3a1bcdcdc685..0cf9d26315b3 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -413,7 +413,14 @@ class JsonEvent:
         self.long_desc = None
     if arch_std:
       if arch_std.lower() in _arch_std_events:
-        event = _arch_std_events[arch_std.lower()].event
+        # Inherit the arch-standard encoding only if this event defines no
+        # explicit encoding of its own. Events with explicit EventCode,
+        # ConfigCode, etc. may carry alternate encodings and appended modifiers
+        # that must survive.
+        if ('EventCode' not in jd and 'ExtSel' not in jd and
+            configcode is None and eventidcode is None and
+            legacy_hw_config is None and legacy_cache_config is None):
+          event = _arch_std_events[arch_std.lower()].event
         # Copy from the architecture standard event to self for undefined fields.
         for attr, value in _arch_std_events[arch_std.lower()].__dict__.items():
           if hasattr(self, attr) and not getattr(self, attr):

-- 
2.53.0-Meta

