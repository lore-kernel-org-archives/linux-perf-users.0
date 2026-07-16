Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C27137F8C1
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 04:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784176404; cv=none; b=RrBe6qVAhtv5SSJroixMg8JaKZz0crpxZAz5HK1p6apKnsqAww82kKbQotplq7+i97zAahV70XyoyTw5iTHJU5aa/8RnoUeiFvFXlBeqDi1A/QRkIB6OhDnzRYVPIAQ6RjOVXMuI+SFgyPM9zdfRXbj2Ig6y6JnU2Zq7IJ6sui8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784176404; c=relaxed/simple;
	bh=QzphN24cGC7dXeEx102xNKX8MMd2qiq7lJq1PP46ZV4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kv0yVUvxLzmFkyQb8MBqV5Ek5AWBXfhmSy6W6xHAziPPKWL03IKlN0BWfc40+lX66tMT11WiMsZfQKluXNb6R1RsqTa3K/uKLKs8FYA2q2JjhwDcu0gMcEAWU1KBO3fknOPnAbGwZUuQHltd3fqlSSvo8/Zr5vZeziP5E/W9ssU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OpuEGJX3; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OpuEGJX3"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-38dbf293831so6435572a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 21:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784176401; x=1784781201; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k1WhRdEJ7RWHtx42f6OPWFDBvGHlQ0rQIm7rFijMP1Q=;
        b=OpuEGJX37fNPH6uDi5Z0FVyvU7+V4VYpAN83YXwVq2aRRpd8nXn4wHKkxA0cHX5qDh
         NGLD1TN24V8L/pxzFqmZzqvbp/YrAYIOW0pQ4DlxtmgAwmQgPMTV3/vNrZiaA5mALf3y
         kPZbxaKtFV8oK1qds91YcHgK92kI1W8+UQbfOmBbOBOmYihr/rNQSgbFo6FbpStvF2qV
         QZf0amnAq15e0Xs5doEeQvQuQ0we7PNiuXRswpkgGFlCcYzmiCroR6lySxzPjnJruqDr
         vUUSd90vX7MPgn74/TILhylHLCZoIW5WNAwmTtI+4j714vHcCXkWay9jceMS9gZGJ7Ku
         ff8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784176401; x=1784781201;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k1WhRdEJ7RWHtx42f6OPWFDBvGHlQ0rQIm7rFijMP1Q=;
        b=kiObT+KtHc1lixnKY9Oc98z4TlwrydOohEmtin7p4CjiEUTmcj2/tlOFJKHWFhS5x2
         sYNf9rZcgULBBup1zsYZi94qbBChntsbP67K4n7uGqtbEQ5XQMq+9+XWr4VvZ5P+j4cQ
         GtJ1IrozDKeaDAHwzpbRQzB7HBU2keLhYMjItEdbWD4dI8HXQRaEMKljfSvmk5p6MlRR
         W/+ZQ0yK+U4L17vIvkmD81cx9jctvgFHDaJS1TBHYtTB6f1OcAA9f4zJ9GEV0QJbAKPe
         h5Ex33xm79Bm3X3OUyHPOjGdizOIQsANSORWcrcaZ/fCWT1Zmz8qczPltd/FSQEWB/bA
         m5gw==
X-Forwarded-Encrypted: i=1; AHgh+RpoeH82teZD0c8oXWhnNRs2eXDtr3B55Q7D4stoqCXcnqdMDnipOuX35/X3XlVjkJran1fO6Av5CwJ/hcmBDZIe@vger.kernel.org
X-Gm-Message-State: AOJu0YyZn0zL+Rtz4bxDSp0ROULPCj5KlIW72iT+VBf91mVr1D/GBJcx
	ipOGkjnbGaXBLwg82lpDxA/0PHy9vRecZRwgDKIchVZPeD7It/qtCYaBBy2E6n9IkoFQwdu1cRv
	L8NqkqQ/xBQ==
X-Received: from dldyq19-n2.prod.google.com ([2002:a05:701b:4553:20b0:13b:9b4d:358d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1b8a:b0:3b2:924c:567d
 with SMTP id adf61e73a8af0-3c1107747a5mr23563859637.46.1784176401127; Wed, 15
 Jul 2026 21:33:21 -0700 (PDT)
Date: Wed, 15 Jul 2026 21:32:22 -0700
In-Reply-To: <20260716043223.388233-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525231900.3527228-1-irogers@google.com> <20260716043223.388233-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716043223.388233-14-irogers@google.com>
Subject: [PATCH v3 13/14] perf stat: Add --new support to PMU metrics Python validator
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	ctshao@google.com
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

