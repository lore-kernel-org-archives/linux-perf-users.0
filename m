Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D26390205
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185419; cv=none; b=sZpHhqwVbuMmWb20xrLW7yekIKYmmn/PKqre+ezjuXiFqhGfLUCmM3lA0FdG+BlcednhL3DkQHhJlhzfF+LDEypiSRKx4F6b15vpAf8Vj+VL7uvQ88NkP6ZK/PMFhExaaK4SVJIvC8ttrfhjCVkjcB6pg5w/op8Y4bP5sLloRDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185419; c=relaxed/simple;
	bh=eNpfZh1dpIFAekfalGaQk+/eINW92GCphOzZiYJOV5s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bBcejmFILwpg2J95tmnK7PC9gp7z1qrrgZda9kxzC2vNifsLsyWZ1OmFGeEtPg/DmlNvv8IucrraHmKMELnvl+Xj7hf3JGqg4WhyEW3Hs2yCKOp5W9/k3ZmIszt4CsO3cs1a9zpD5qXw9rsJfJQrMJ4gzuQSsz79+kNyFpYatTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SfaWN/f2; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SfaWN/f2"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-38dad28e86eso6740307a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 00:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784185417; x=1784790217; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iU1fZww4Tcrag6lxNEeuKCJy8Y+7g+3ojiLQofYJ2MA=;
        b=SfaWN/f2BGIm/s6tyQeqgNJRMAQlzbzXz4xwyl6jSJxj0QbJJf0Y6qkRkLwD3KQDLh
         cpfSlQa5TewtxJTY+yVY/A2F9XES6cSYIqlQl3wPFX65uIe4pZDvbYC+Rb3UO8DPL3q5
         bl7DzeKMix8Z76ZVnOsnOWCJGNpkDTDP6M72zhS2OqYEHTBES06IKUQhpww2FYg9HOb/
         WDFIdKFwq6J+3cZhKWTWbNmb6xZeeogio2Ej+6Kt80v2gGQjw7+dnCyxXJ7fkjLITKDb
         HlmVdVjPwXnZpqhWyjN3TUuB/s4uHBhRMzEIyLqlWSu34JFfdYu7w+1+KG7JPqzn2X4S
         T51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784185417; x=1784790217;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iU1fZww4Tcrag6lxNEeuKCJy8Y+7g+3ojiLQofYJ2MA=;
        b=AxE+fKIoPSF7NQc0PNcnmmru6T9aSybEOwiVTCx+55ARGeCH/wUus3e2mblYS2rXZT
         x54/06cHG6uZTI6+5yRrcC5M7kDBz6aqQkwKzDAZ23Gkbi9nOtgLkiNxUJDmowgLSTj3
         gENE0UtWeNVOBnzvT+J69qHcFcJ2hc1rL9nT63rgIbWxX2maXDveNPfhORnzZ8wI1A8R
         IAt3zmZ87GUPewHcD/H5+MKGlq45ODsNvVf4UeP1ckpnVCBqFFRqBufclnfr2OfyvLP4
         s6cOCF8Nn/yx4QQdmaE8tS35FCyZvxUum1YSWWaZZ1X/yB8WG3xhHjvWlmS7ODVxzUia
         KsFQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp3oKqJKIRyD2JT8Tg9AThOTQ1d2VlEs60jCJburXclXXfzTN/Ss0foyuUpbxFdHqFqOWqXxYDZPtfrjprqgU8Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwKbiXGvcpOc9hrL0oUL9O3XKgcBRaRu7q/2zo01JjBCJizjDoS
	FWRRnV8+2Vmz4NUswhliYTvZV/HCWkazb+k2DWXzjsl009IOTecMU1NqrWalbjbgQOEQTkwHFUc
	6z0Ws02gyJA==
X-Received: from dyee27.prod.google.com ([2002:a05:693c:629b:b0:30c:83f3:7370])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:38c8:b0:38d:dbc7:5178
 with SMTP id 98e67ed59e1d1-38ddbc75254mr17482013a91.22.1784185417275; Thu, 16
 Jul 2026 00:03:37 -0700 (PDT)
Date: Thu, 16 Jul 2026 00:03:02 -0700
In-Reply-To: <20260716070303.507066-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716043223.388233-1-irogers@google.com> <20260716070303.507066-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716070303.507066-14-irogers@google.com>
Subject: [PATCH v4 13/14] perf stat: Add --new support to PMU metrics Python validator
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, ctshao@google.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch extends the performance metrics value Python validation
script tools/perf/tests/shell/lib/perf_metric_validation.py to support a
new command-line argument `-new`:

  parser.add_argument("-new", help="Use new printing API (--new)", ...)

When set, the Validator class appends the `--new` option flag to its
internally spawned `perf stat` commands:

  command = [tool, 'stat']
  if self.new_print:
      command.append('--new')

This enables validating Intel PMU metric mathematical values generated
specifically by the decoupled, streaming JSON printing callbacks.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash
Acked-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/tests/shell/lib/perf_metric_validation.py | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/lib/perf_metric_validation.py b/tools/perf/tests/shell/lib/perf_metric_validation.py
index 3d52f94f22b9..b8397234eebc 100644
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
@@ -587,6 +591,8 @@ def main() -> None:
     parser.add_argument("-m", help="Metric list to validate", default="")
     parser.add_argument("-cputype", help="Only test metrics for the given CPU/PMU type",
                         default="cpu")
+    parser.add_argument("-new", help="Use new printing API (--new)",
+                        action="store_true", default=False)
     args = parser.parse_args()
     outpath = Path(args.output_dir)
     reportf = Path.joinpath(outpath, 'perf_report.json')
@@ -595,7 +601,7 @@ def main() -> None:
 
     validator = Validator(args.rule, reportf, debug=args.debug,
                           datafname=datafile, fullrulefname=fullrule, workload=args.wl,
-                          metrics=args.m, cputype=args.cputype)
+                          metrics=args.m, cputype=args.cputype, new_print=args.new)
     ret = validator.test()
 
     return ret
-- 
2.55.0.141.g00534a21ce-goog

