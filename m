Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B633C108B;
	Thu,  1 Oct 2026 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869960; cv=none; b=tLi7DG65q6VZ8LVhI8r2KIfNwcOh1u+RkwIf0rE4KDeX26pByO42FN52DDzcOr/MS0AFRsYAFfvUznbtf9PzvGp7Iv6xLljg7mcJ9azdc+4fCHmN8HFO+C0hxA8qBipsNhSeGbNbO0aBvTseWNBUn/LxCDWQmq2hV3dremRvb7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869960; c=relaxed/simple;
	bh=iRll88XJRYa0MX5ujQ5942/v8a+o7zU9rcHGD+lG1mY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ew/kThpL8+GfKdq2VyJKPXG+xd7hLPfOdKaCBgNW+lyliBE/jefpbQSxZcs4egmpFkFyAhAxLkkvuiXDmkHmBFMV2w5wqyEEtewodjsJwGDlUlSzWBld0d2uKn2kALWKIgiLiwTeVwmb+f1aqX2XdUhVodP+LOl56B6RSI1Ymck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HN/99gdb; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HN/99gdb"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DBC8497;
	Thu,  1 Oct 2026 08:52:34 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAB1A3F86F;
	Thu,  1 Oct 2026 08:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790869958; bh=iRll88XJRYa0MX5ujQ5942/v8a+o7zU9rcHGD+lG1mY=;
	h=From:Date:Subject:To:Cc:From;
	b=HN/99gdbaVRpIPL7b/5ZCpT0kdlnv1pc0EplrOoRYUpnY85FK4B8i1tF+yBzL7JMK
	 rXUuOLu9JTSFNGXbE7Nketvns6FuZCqJ2MJWdE3JN99IgXvxiMbm3ppsf3Agbn+hwO
	 a5s2ePoYdhFG3ieeNF6Q+9Hv/B/camEUFAl9NUUs=
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 01 Oct 2026 16:52:20 +0100
Subject: [PATCH] perf test: Replace optparse with argparse in attr.py
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-perf_replace_optparse_with_argparse-v1-1-268b604f8e55@arm.com>
X-B4-Tracking: v=1; b=H4sIALOBvmoC/x3NQQqDMBBG4avIrBtIxLa2VyklDOkfHSg6TMQK4
 t0bXH6b93YqMEGhZ7OTYZUi81QRLg2lkacBTj7V1Pr2FrwPTmE5GvTLCXHWRdkK4k+WMbINpxz
 u+Rr67sG+T1RLasiynZfX+zj+2/0CP3UAAAA=
X-Change-ID: 20261001-perf_replace_optparse_with_argparse-e7f51849a08c
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790869956; l=2814;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=iRll88XJRYa0MX5ujQ5942/v8a+o7zU9rcHGD+lG1mY=;
 b=hYqelCieuFMdF30mTEKD33ZM+f6QuKHnVTk7WXrBGlb8jfGcdu4gqb4b4JFkn7HipKPOfaA35
 UKnQCPzIeDrDzXm+leCnYkfmh2kRIZLHnbcAsybMB3M24FtiGIGGqjX
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Depending on the Python and pylint versions, pylint can report that
optparse is deprecated and fail the lint check. Use argparse to avoid
this potential warning.

Preserve the existing options and defaults, and let argparse handle
help and unexpected positional arguments.

Tested with:

  # ./perf test -v 'Perf attribute expectations test'
  78: Perf attribute expectations test              : Ok

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/tests/shell/lib/attr.py | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/lib/attr.py
index 7f3d5b64b00dd7de45baff4f7d9baff89e003147..68f06df9565a081174c788b964a5b051fdedf626 100644
--- a/tools/perf/tests/shell/lib/attr.py
+++ b/tools/perf/tests/shell/lib/attr.py
@@ -4,7 +4,7 @@ import configparser
 import os
 import sys
 import glob
-import optparse
+import argparse
 import platform
 import tempfile
 import logging
@@ -426,29 +426,20 @@ def setup_log(verbose):
     ch.setFormatter(formatter)
     log.addHandler(ch)
 
-USAGE = '''%s [OPTIONS]
-  -d dir  # tests dir
-  -p path # perf binary
-  -t test # single test
-  -v      # verbose level
-''' % sys.argv[0]
-
 def main():
-    parser = optparse.OptionParser(usage=USAGE)
-
-    parser.add_option("-t", "--test",
-                      action="store", type="string", dest="test")
-    parser.add_option("-d", "--test-dir",
-                      action="store", type="string", dest="test_dir")
-    parser.add_option("-p", "--perf",
-                      action="store", type="string", dest="perf")
-    parser.add_option("-v", "--verbose",
-                      default=0, action="count", dest="verbose")
-
-    options, args = parser.parse_args()
-    if args:
-        parser.error('FAILED wrong arguments %s' %  ' '.join(args))
-        return -1
+    parser = argparse.ArgumentParser()
+
+    parser.add_argument("-t", "--test",
+                        action="store", dest="test", help="single test")
+    parser.add_argument("-d", "--test-dir",
+                        action="store", dest="test_dir", help="tests dir")
+    parser.add_argument("-p", "--perf",
+                        action="store", dest="perf", help="perf binary")
+    parser.add_argument("-v", "--verbose",
+                        default=0, action="count", dest="verbose",
+                        help="verbose level")
+
+    options = parser.parse_args()
 
     setup_log(options.verbose)
 

---
base-commit: 705da5b15ab89ba97b11eedbe507c2fd83d31cb9
change-id: 20261001-perf_replace_optparse_with_argparse-e7f51849a08c

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

