Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811EF2DAFBE
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697982; cv=none; b=as/4j/kxFvtPdAIga224fxTvUdoEv+atiGqO0XZz8ILrNJ0BVvfmf7MmnJuEu/zPcKJTMkzB/i/NksbCB5Fsy8bxGDQfdN+9D3vdjFXztSDxcBOKeMz/Zl/Cn5DYj3l3p6Fi8wImFJCD5c7ouYxK5DO1Nlzp1de77XdEuaeo8RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697982; c=relaxed/simple;
	bh=r8rpLVrS1WCsfiUVjJPLdiZi/CyfJ0dVjD2Ow5HDNOI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=EXMtXiB5s0fOqAfSx/Pcc/JUL7xQiq3fI+k3fe53RJgKzCT5tMnKaAJnVy3LnKVQQjnREMXUu7oTj40i/klw+RDJ/VfeUiR30Libjg3B9gfcfPTvEL/NiNIjYWsOHrSWcIADccBWHJo2dHSyGOc/r2MNnCm5FgMq9fA2+xYLab8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j4eQZEZ1; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j4eQZEZ1"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-341616a6fb7so5679750a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764697981; x=1765302781; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jUiA3gNMxDf8FZhjNyB3YB22SrGf75zcAkH72eX2LVQ=;
        b=j4eQZEZ17B0Aw8FkwtNTlyKE9AVH69qjZb0nlJnfk/nmkti5uIn5G/Wzf5mZVHetMv
         H77bWNsi0Y+mZE7wXrIDKherFlBGea/hlKJvI4sQ5z4as4Lki79pw4Lb/VTLf2X2cVLQ
         YbvQqEnS9WBkGqtpKKzWGxiaJ/VpfEOSQNi7NFnbOvqfuJn0jbStqueCnC/BOjXJKryh
         0zEfNWCro9IvPsqeUD2ZZUZTrhmedKRZ0j9kX1QCNs61s36HgSwU/Cm45vbVbaXr6QTF
         T6I1ioy9fX5P5iXZj8t/havSGj9J8QXJ/S6SnoncWhflTnsvJ7tkzvtKO5R1rSjRHzZX
         43ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697981; x=1765302781;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jUiA3gNMxDf8FZhjNyB3YB22SrGf75zcAkH72eX2LVQ=;
        b=ruPG0v6iKwdxZo0GQF+Y0lZ1aOP/AzdVu/z8cUHWM2E9P/RbdJYGypkm5SteJqVbIL
         gKIGuk4UoXyVEkFCzh7e1XjAi7sFOJKW/a2nf/z9OB9V7GZ1AIA5xsmUoq537vtky1Bc
         wrWL8Zu8UebGcf5/rrJXWR6rokld9J3/+ZvS3T/XrBM/bPXxFZ3yF3YM7f7t+KiZKLgv
         0yYsJjSrpnpUYdUUqLBU0+ysPOv9PvJYAkF0mttXJK62lJWgvxFDtLUFyj0IUdkNdfcM
         I0Eg+Xpqsuokdm/cHsg7UeQDjDL+eJmYYFR8rg95fbnNbQQSV6mGf8XRvYYWrolvBJl6
         evzA==
X-Forwarded-Encrypted: i=1; AJvYcCUwuP0j4umBCHL9eWqKl0jG5b20wAs6Zy1CrzVcTdIVAOwtpROLhPwBqyW/B4bDkXqqRzzWwWDaih+U0EhpeDyl@vger.kernel.org
X-Gm-Message-State: AOJu0YytM6qmeHzBQZ+HCrWSy4X392/6cAI+yd34xTMHIRvINcnxdh1U
	tSw00cpK8ocsteVif75viggyOpPOKG4oHPAmVTk0ppvUQYnhaBXS8bk/StRGhz0z7YMlrWqCydc
	wNtlYlFjAJA==
X-Google-Smtp-Source: AGHT+IH821OtnWUvyDQo2z23/9Td6JbIrt4k9P+rIq6vafQShO5B9kzYVTIYGmiKaAvO67TUUnToOtgvKoV4
X-Received: from dlbvs12.prod.google.com ([2002:a05:7022:3f0c:b0:119:49ca:6b8c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:429f:b0:11a:51a8:eca
 with SMTP id a92af1059eb24-11defca683amr172723c88.18.1764697980739; Tue, 02
 Dec 2025 09:53:00 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:18 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-24-irogers@google.com>
Subject: [PATCH v9 23/48] perf jevents: Add context switch metrics for AMD
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Samantha Alt <samantha.alt@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Metrics break down context switches for different kinds of
instruction.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
---
 tools/perf/pmu-events/amd_metrics.py | 33 ++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 1611d0e50d03..780e611fe575 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -121,6 +121,38 @@ def AmdBr():
                        description="breakdown of retired branch instructions")
 
 
+def AmdCtxSw() -> MetricGroup:
+    cs = Event("context\\-switches")
+    metrics = [
+        Metric("lpm_cs_rate", "Context switches per second",
+               d_ratio(cs, interval_sec), "ctxsw/s")
+    ]
+
+    ev = Event("instructions")
+    metrics.append(Metric("lpm_cs_instr", "Instructions per context switch",
+                          d_ratio(ev, cs), "instr/cs"))
+
+    ev = Event("cycles")
+    metrics.append(Metric("lpm_cs_cycles", "Cycles per context switch",
+                          d_ratio(ev, cs), "cycles/cs"))
+
+    ev = Event("ls_dispatch.ld_dispatch")
+    metrics.append(Metric("lpm_cs_loads", "Loads per context switch",
+                          d_ratio(ev, cs), "loads/cs"))
+
+    ev = Event("ls_dispatch.store_dispatch")
+    metrics.append(Metric("lpm_cs_stores", "Stores per context switch",
+                          d_ratio(ev, cs), "stores/cs"))
+
+    ev = Event("ex_ret_brn_tkn")
+    metrics.append(Metric("lpm_cs_br_taken", "Branches taken per context switch",
+                          d_ratio(ev, cs), "br_taken/cs"))
+
+    return MetricGroup("lpm_cs", metrics,
+                       description=("Number of context switches per second, instructions "
+                                    "retired & core cycles between context switches"))
+
+
 def AmdDtlb() -> Optional[MetricGroup]:
     global _zen_model
     if _zen_model >= 4:
@@ -437,6 +469,7 @@ def main() -> None:
 
     all_metrics = MetricGroup("", [
         AmdBr(),
+        AmdCtxSw(),
         AmdDtlb(),
         AmdItlb(),
         AmdLdSt(),
-- 
2.52.0.158.g65b55ccf14-goog

