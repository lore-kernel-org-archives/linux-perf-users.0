Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2393921CC
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489274; cv=none; b=qnW6Pqd/8iVBGS9Nu4dqg/L9OPNLOblEFAcwuNGa4B0lnZFjsEIX63wCtRxavRACof/Q+OURm4IkRiZpj627HkocxMb0lfb+4wiw03lVqzanBjvkWX1jEvHV1g2hXhui1oB0fEYiRHAoPZ5AJNEpilqte4ismedIlKlCPkI1qeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489274; c=relaxed/simple;
	bh=82oRk4SsWFkLEO66xqJJ3QJWj63Uj/yIgFDzEE7VIJY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=lik9U3Vt2z90eYB4xjNtw5DAO0k7jgtRUTd3xIbR1wEODk1c6dIHCJwJBAxk92VHCkou5bl8mQeChDKKGTVrSAwiy0K5XugC96UfpjAWBG27J30CMkNpd8vSKQJ04DjbDtZJwC+X1l8ftJUo3t3hycitsb6oOQWYgNAV0zNDlbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f/nrjuOI; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f/nrjuOI"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ee1da7a13fso9393914eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779489270; x=1780094070; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3CcYRk/hjgf1eQJiKdM92hfT80JcCdgJogs5qRtn8pU=;
        b=f/nrjuOIqiO2pGp8LxXeYM/NZXTxmg2m/hpD1wW8F/UhWjZm7KxW1lgDdeia8/117I
         dOMyI4nNsmDQUOlLHKqdufW2Y7cewkOBYhgEM88sTzzNCzV40EdlzHPKncZUBB6W7EwS
         VCRTG5niOfCdlMXDyMruTrMayWamSjviz9s1hOtlEGta8A4uKgyplE9HNLYQN/f+/AaQ
         a2041m4osClcf8lcrv20sirtxGjrp8wy2lmCr6jVWa+tZkcxI4RUO7Grv+DclLupPfPF
         9l2a74/kOIHZSDppW5wFnLEsPa0k4RRTB1nsGbN6fLQmC9T7Jjc4sLI5PgN4hdfZAiMK
         Qp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779489270; x=1780094070;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3CcYRk/hjgf1eQJiKdM92hfT80JcCdgJogs5qRtn8pU=;
        b=SzdFLl5wg+rFeoZ34JfFOuzJEEuMumRGCTb9bdJBR8Q1NlcgoB4B8y5b7K+J5mIMN3
         2deu+sD44diac3FXrgfH/JmvM1wMjePod9WBqYgEBRxX69fPupan4TMUZsB6o1F4281F
         KG3oOuweX+oPRml+RGCExYS2HBf3AmNgQk3JIWkqZeGaSHE6cIvkYy1uQK/iZLhFC/+Q
         K7HnlyzPrh5+HILVem5gKf1drGK7xHewg95dktu4CC7QwngpWIUt3ZmwK3GdqS2fxivK
         4VUx23+muIkcf9HtPk6UAeNAxG3bARbrmrxtUbY/IwQJCWKhxrdhpF8Em/JHHDzv0/KU
         Odzw==
X-Forwarded-Encrypted: i=1; AFNElJ/v/2tSxiM+xZ2Sie6p3vrc77fqXDgngJ3B1Clt92+DiWAvu/MT7WugsgZNBA0UkixiK49B6djgiLdlaFzvYdt9@vger.kernel.org
X-Gm-Message-State: AOJu0YyqryX5EEXJl02Oi7sQ/8oYyireVIH/WK0bhB4+Q5p58FHL12Oz
	YBw+Dm/L/UcGyJeMOiibbquTRG7t0CapHVwKMP5zdVcWNFQ0I8fxppY9dmcwpAYpIcCoKmsPmUU
	ipPRwgpg+rQ==
X-Received: from dylq22.prod.google.com ([2002:a05:7300:5996:b0:2de:ed01:5510])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:b104:b0:2da:1874:f3bd
 with SMTP id 5a478bee46e88-30449051bd3mr3000405eec.16.1779489269488; Fri, 22
 May 2026 15:34:29 -0700 (PDT)
Date: Fri, 22 May 2026 15:33:41 -0700
In-Reply-To: <20260522223342.2393553-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522223342.2393553-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522223342.2393553-14-irogers@google.com>
Subject: [RFC PATCH v1 13/14] perf stat: Add --new support to PMU metrics
 Python validator
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
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

TAG=agy
CONV=7c33d6a0-70a2-454a-82f7-4de2101a5b9c
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

