Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00C64A2E3B
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792328226; cv=none; b=aFSSwyasPgWUrfaElqsn0MN+GWyh81fbkUXStlzezTRVXM6NSYKYHcaYWt+hkeaVxw9n5GuDb62lpF5iM4PZxlVNlKUmH0a8XRVkLo42Y/53W5azhvsOFPGP2nHTHFjTnzI+hT8xxDQPmP0t2x9pJTaFTITEi3hrn969VMEn76s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792328226; c=relaxed/simple;
	bh=/OHTgWtIyUxvFctXB/qCvyKkreuKwl40MwiVh1kN9FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQ/Qc6FGdK/1vPoKXvh+1OsZYyjxRmxqzdKNU2J6iXqC3HQ0/0QbB51Wtn/OsBZAQxRmEPFKdai3B5l+k8JhBtJlHD3Z2+w4exx9bjoKDq2wLNZJJRXsq448kVG6ChuNENRX3fasrydqeCsQEYzjm0xII6Ad00qwOVOpVsnenJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICZ9+lhj; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICZ9+lhj"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3514b90bb89so3244545eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 05:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792328224; x=1792933024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i8lbebB5XU/M10VEV6x/jmAfngG9+J76pSF7+oK02NI=;
        b=ICZ9+lhjwESJNqXchAlrG9bLDyh2FjB/Pa/TobJ8FXyoH4Zp5U31GC6FUc2D7Ai/Uo
         1Eghd2fjQbuWOdkrSeeZle/cQzzoaxHPeH6HWg3o0wcpqKYbhABulnSu3nEAekrks/iZ
         F07/B2N3IKfBb60X2gL1IDN8MYdthz+r+bZs42Dil6KOS9w1ZG44zEzieP7ZzZg3rSHd
         EDc4KVMPAXUU2hvGZ1IMo9ZXnxVx8TU8NtE508G5eK/4I1mvl+b8FUey6jzYvFMOGC7f
         NDfHcr9BiobB8mIb1aZENK9bnMGswVCJwNeuv60seEDYQiQCsNZx4/j+S0+pNlb146hq
         STXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792328224; x=1792933024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i8lbebB5XU/M10VEV6x/jmAfngG9+J76pSF7+oK02NI=;
        b=BHhZ3vdrkJ1MBVTtsQjNj4XV19FoxaWq9VpuJE5ANd2z6rqo2pz3WJwoKGjI524mO5
         qnbETuCB2nk93gUud98qn6DcUbNV3qnmOshVFOSTMg+NHkm/6hv/ATH7rFku45xkBBww
         d1T5o9bHkp2T9SWhczMTKw+crSklC5qEVfWAsJSPp7Mo9H61atf+QIS2BWHyetZkK9Nm
         QQ+b1d/SSQZAFuza37KYIu7GebcqtmmF1QW/24OPWzQF37cGO1VVpTR4X104lfkaJcKO
         Zkx7OeWiYLkKBtcebxeDso+tNya8XF3Wd1dvcpg0pW6qns3N/PR8LQwuACSBRdCqx+f/
         99pA==
X-Forwarded-Encrypted: i=1; AKwUvBz57jCNhRTKfwErOBE26UyrSdpV062butLk9fuHGbPnx9plldzNUXVFXSqinygkppB7z3e+1AodsXKNdnboSFzN@vger.kernel.org
X-Gm-Message-State: AFq9FYKXv5ZQjmT2dAF7ZBo9xxAFm7wlbWx3VGQ1VVCeLj5EwdwjnwQ2
	GAZ603npVEHTTJgBho8+ho7fv6ax/GC0+rJ1IY89g4fhTWjeeXzC/Nkn
X-Gm-Gg: AYBFou1db7ugW11DQGiBNWvH9ocrASoIHs9ApYT1bzo6zdD7QOdfl7Ur7RkdwzZFjOi
	oYpRjRQLmeNH6cQ25jqPEMw72SiC5K5D4y+O2SylRiTrZHxiQ/m5xq17Q5l+aAOimZQWKoFuk5H
	ByHg+1K7hKQM5nrX8wua3R3VsNJpr2ItSEmYEe4ZaLknrGIAQO/325fODhV2FL9IMBhIZz39sHi
	8KVNJjtt7HC+XNcQV+9d1Lmm6g9AqpjInvFZOX5TE/h0GxKwZSrMM0BtBrLAvgUYFLL8gZwBb3m
	kqVotSMNoefmBYbkGhlWNFkmFNlPjdGwsC58YaPf0vZ2f+QtN+VKnZ5sFqmkuNZnLYGIlLVAnV+
	jvrmRf1pIHnBdRR9DtiKARVAVghatGeH2zen6jJGIR+yQER1mBNV+K1IYGP58SrDlVohswHev+f
	BY76SGz8fTUyO0gFwxsRpsMH0ZSpnHamOquuzBBPDyINvicEIgcEyRrks5A0rifU2Lt/TWNFl3H
	4VDN/6G31ijYp/l9DDJx+yG/NEtJG4dzShMzho3cA==
X-Received: by 2002:a05:7022:4185:b0:189:d6bf:7eaa with SMTP id a92af1059eb24-189d6bf8203mr1078088c88.16.1792328223604;
        Sun, 18 Oct 2026 05:57:03 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.15.112])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c4d4675sm20404082c88.21.2026.10.18.05.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:57:03 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [RFC PATCH 5/5] perf/tests: convert check_errors_whitelisted.pl to Python
Date: Sun, 18 Oct 2026 09:56:41 -0300
Message-ID: <20261018125641.23064-6-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261018125641.23064-1-breno3011alves@gmail.com>
References: <20261018125641.23064-1-breno3011alves@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Faithful re-implementation of tools/perf/tests/shell/common/
check_errors_whitelisted.pl in Python 3 (stdlib only). Same
whitelist file handling, same regex matching, same exit codes.

Verified byte-for-byte identical to the Perl version.

Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 .../shell/common/check_errors_whitelisted.py  | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100755 tools/perf/tests/shell/common/check_errors_whitelisted.py

diff --git a/tools/perf/tests/shell/common/check_errors_whitelisted.py b/tools/perf/tests/shell/common/check_errors_whitelisted.py
new file mode 100755
index 000000000..352eb1a9d
--- /dev/null
+++ b/tools/perf/tests/shell/common/check_errors_whitelisted.py
@@ -0,0 +1,55 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import os
+import re
+import sys
+
+
+def main(argv):
+    if argv:
+        whitelist = argv[0]
+        try:
+            with open(whitelist) as f:
+                regexps = [ln.rstrip("\n") for ln in f]
+        except OSError:
+            sys.exit(f"Checker error: Unable to open the whitelist file: {whitelist}")
+    else:
+        regexps = []
+
+    max_printed = 20
+    if "TESTLOG_ERR_MSG_MAX_LINES" in os.environ:
+        try:
+            max_printed = int(os.environ["TESTLOG_ERR_MSG_MAX_LINES"])
+        except ValueError:
+            pass
+
+    quiet = True
+    try:
+        if int(os.environ.get("TESTLOG_VERBOSITY", "0")) >= 2:
+            quiet = False
+    except ValueError:
+        pass
+
+    passed = True
+    lines_printed = 0
+
+    for line in sys.stdin:
+        line = line.rstrip("\n")
+        matched = False
+        for r in regexps:
+            if re.search(r, line):
+                matched = True
+                break
+        if not matched:
+            show = lines_printed < max_printed
+            lines_printed += 1
+            if show and not quiet:
+                print(f'Line did not match any pattern: "{line}"')
+            passed = False
+
+    return 0 if passed else 1
+
+
+if __name__ == "__main__":
+    sys.exit(main(sys.argv[1:]))
\ No newline at end of file
-- 
2.43.0

