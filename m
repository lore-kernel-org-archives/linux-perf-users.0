Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E356E36A36C
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 23:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779751181; cv=none; b=PScPL8XzIvgu4QkOghH455YtW9dMTJGf/i7fLoBX5d92KKhccFj7hJfABjUT6R0pqQWBGH+uHzFRypXQd5QygjoDyjhWVFx5qpNecQDM0ZDuogPC+W9sga4GypIPZ+vFlMM3++B9KZxM4HWa4xrL6/49L7ySv5O0lZ9QdlG4Ruw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779751181; c=relaxed/simple;
	bh=gVN5EXaFGx6G0pY9zuHWRUUzy1F1X7z5N0UX6G7LzqI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WfvTfcNnNhwm7vSk/58flF8E4+gmklCxtblFb2pzAKyDXkwIJzK6Gp257Bpt4/7yDARF+R2zIXhI1YY/DS7nuZ1qWf5Nvm+I59VlTRszErNnJ8dKGs+1lPBgTQebx3HbQ20S4TwsDIfXpn3WDY2G6joGxLJFcPyuyCRfVQFjAwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mqc8yihV; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mqc8yihV"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ee5b73c5f2so3167489eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 16:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779751178; x=1780355978; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LSw2EEH4NjktSR5L7b6AUMjjHwCrxvXJAhOFEWfE4Fk=;
        b=mqc8yihV0TIq1slRVnDg4XoohKyNiWyHXinTMAWlCtMp0NAZiEbyA+b89nqnmoNPyd
         tvDGUvU6Ka5MfTeTc6SPB02mKsVeWT7Zzeqly9vir/tdq/7wuwY30wVXS4kRIHzJGNmC
         nbxvyevF8CUglHMxB8ztCS6bk/5o7NtU8MMH+h8yxoMct8ROr6HziiQ6mOmIiGVBClha
         rEtulplgsYSM068EbbzUtquLG1VOGbj9YYl7YCtiq0T1++XCtaExiFCVo5nuOFuzDms9
         XCMtyNZoO3zjx8AE/vLjIeQd+KGu+lhN0DMUTQMprrOX0q0a3NgkLvSndJWu1cuDx9/t
         EoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779751178; x=1780355978;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LSw2EEH4NjktSR5L7b6AUMjjHwCrxvXJAhOFEWfE4Fk=;
        b=OZHkc9y9tgpkTlsIKUkPknk+vMir8WtVu/JeXv+HPtG7XxALfyn0bOs3toKEynaz/p
         ViphxDRmBpUXnV+J4QXQJ7H8uIEI1QNMSYxD0hTxz1tSNR+oVA8etYuMc/y7sOclhzoS
         dtq2PaoeCp4KCf2nIoOV1mdVdR6qfxn8vxyGlLpq69pZOCjO1WcQ8h6cGiYRqEywbVSg
         FN1rVOkHqTIgzymS/3EnnbCNeJ/4KeuXudRsG4skWbwA3QaZsbHp1hDzMEI6ohZJaXmn
         OXMFAPIlt+O7r2Tp0RekfLf/0aBe/fuzOM9T9HsCvsyeoG2io712DR7atKpoHA8ThZKN
         O3tQ==
X-Forwarded-Encrypted: i=1; AFNElJ+0pt/slo3bxFio7HiIXOREcAiJfaHEUmedLZc8xpdB4YMDN+zqWtbx62Uh5OU0gyshFxJGiykAZ335FjplEoVr@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa8NFDjlpKXrub7FjFioaTQa76RLPay3DT4JQ4g9Ho7v8QBEk/
	hKyUYNP/wDhHrlIDO1zQGsNcif67/aa1K6vD2Gj6QKDpetv3F2gMqAY1T7nsTs3awKqHstjMb/I
	5Y7xvG2nGuA==
X-Received: from dycnd20.prod.google.com ([2002:a05:7301:c14:b0:2fd:bdd1:8f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e781:b0:2be:2cfe:68b7
 with SMTP id 5a478bee46e88-30448ffb8a1mr7404196eec.11.1779751177856; Mon, 25
 May 2026 16:19:37 -0700 (PDT)
Date: Mon, 25 May 2026 16:18:59 -0700
In-Reply-To: <20260525231900.3527228-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522223342.2393553-1-irogers@google.com> <20260525231900.3527228-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260525231900.3527228-14-irogers@google.com>
Subject: [RFC PATCH v2 13/14] perf stat: Add --new support to PMU metrics
 Python validator
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch extends the performance metrics value Python validation script
tools/perf/tests/shell/lib/perf_metric_validation.py to support a new
command-line argument `-new`:

  parser.add_argument("-new", help="Use new printing API (--new)", ...)

When set, the Validator class appends the `--new` option flag to its internally
spawned `perf stat` commands:

  command = [tool, 'stat']
  if self.new_print:
      command.append('--new')

This enables validating Intel PMU metric mathematical values generated
specifically by the decoupled, streaming JSON printing callbacks.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash
---
 tools/perf/tests/shell/lib/perf_metric_validation.py | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/lib/perf_metric_validation.py b/tools/perf/tests/shell/lib/perf_metric_validation.py
index dea8ef1977bf..f69cf0e0de57 100644
--- a/tools/perf/tests/shell/lib/perf_metric_validation.py
+++ b/tools/perf/tests/shell/lib/perf_metric_validation.py
@@ -36,7 +36,7 @@ class TestError:
 
 class Validator:
     def __init__(self, rulefname, reportfname='', t=5, debug=False, datafname='', fullrulefname='',
-                 workload='true', metrics='', cputype='cpu'):
+                 workload='true', metrics='', cputype='cpu', new_print=False):
         self.rulefname = rulefname
         self.reportfname = reportfname
         self.rules = None
@@ -68,6 +68,7 @@ class Validator:
         self.datafname = datafname
         self.debug = debug
         self.fullrulefname = fullrulefname
+        self.new_print = new_print
 
     def __set_metrics(self, metrics=''):
         if metrics != '':
@@ -379,7 +380,10 @@ class Validator:
 
     def _run_perf(self, metric, workload: str):
         tool = 'perf'
-        command = [tool, 'stat', '--cputype', self.cputype, '-j', '-M', f"{metric}", "-a"]
+        command = [tool, 'stat']
+        if self.new_print:
+            command.append('--new')
+        command.extend(['--cputype', self.cputype, '-j', '-M', f"{metric}", "-a"])
         wl = workload.split()
         command.extend(wl)
         print(" ".join(command))
@@ -584,6 +588,8 @@ def main() -> None:
     parser.add_argument("-m", help="Metric list to validate", default="")
     parser.add_argument("-cputype", help="Only test metrics for the given CPU/PMU type",
                         default="cpu")
+    parser.add_argument("-new", help="Use new printing API (--new)",
+                        action="store_true", default=False)
     args = parser.parse_args()
     outpath = Path(args.output_dir)
     reportf = Path.joinpath(outpath, 'perf_report.json')
@@ -592,7 +598,7 @@ def main() -> None:
 
     validator = Validator(args.rule, reportf, debug=args.debug,
                           datafname=datafile, fullrulefname=fullrule, workload=args.wl,
-                          metrics=args.m, cputype=args.cputype)
+                          metrics=args.m, cputype=args.cputype, new_print=args.new)
     ret = validator.test()
 
     return ret
-- 
2.54.0.794.g4f17f83d09-goog

