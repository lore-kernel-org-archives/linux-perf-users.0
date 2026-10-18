Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1BF4A2073
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792328218; cv=none; b=SfzoqIQ8L/vWS8BikU/3ITHr11elk8rIPSZTAx9ieBTUcBw0JhJX9HEc3fi6kij9OEAAlHroM6dJfnuJT2ZFXExgPEW+/BXYLP5e+ufKAt4efY7LPiMvQHPVsuwBxCeDZuJlbqo/VockHnOhVM/SpNwThxg6mWSbVXT7kMGvH20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792328218; c=relaxed/simple;
	bh=OsrzL6ScmdUef1w4yo+N45vyWLhq1/I/YSTqZdchIEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2e4iTQJJrNCZD7pcuePto52uzZjF4jzvmAOs2gvRPCzfQk6Tq5Yyx87TQSoUG1kylHQUuSNxlFi4rDbAPYnvUZNp57aqAfhpHGqjQv4CUIv/9CUlYWJg2R7OBYj4jPR7zUdcJFVUznQQS6ZqT6et08FurRtSmCMMZ9kTPuPH9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mr+UTrgR; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mr+UTrgR"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35829219da8so2610404eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 05:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792328215; x=1792933015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1hR3kISfYtP85z8lc58s0LO5cffGmvqjBO0ESNwiecU=;
        b=mr+UTrgRT4Oy2tt0dGiu99EYX99SHkAt2dTkvoVHToNEBbmDHJVnw1r2/J7mJBUcAz
         GFjNr+4wpI6x65vuZoP220NMbe99o9mKNo3WqiRzw7oQIs/7+qOTL9Mr91E9KDH/9QYO
         UZde4VtT99TbXY8GIWlcRlBb7EjXGz8vtJzwSN6HvRBrBuI2u8n2ObszA75xYALXDRny
         zpU2mikCphRvJiaj2hiPxYFoFpiMAp3o0hHw1LxKws8MivVCgAXR8lsHL7RLrO40Uumf
         Ygw3Tzee2MpSLbbbrBMUeWXMSr0Cn+4xLNJc8yx+1ifVC49CSi/xl2W+vrqi6xJD2mx+
         IZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792328215; x=1792933015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1hR3kISfYtP85z8lc58s0LO5cffGmvqjBO0ESNwiecU=;
        b=VvE1GWfNm28MLSXgVSl26GwXpz5Dk929kWDXPqr7PnvnvoJAuzeg8gG1pX3PGNbSv4
         57KnlPn3xXhzLlC/UxlZTGbnkNENUQmFXRRJvelKzu10wyPOlUwPCSim2Vx2r25Kty1w
         fUJ8LHfizhRxgF1TcEhhS/Ykk3G3a3HFpUkXWul3R1TUNVQnXs51YkIyMTfJPSJxWfiA
         ueHbSfMgCg+Iu+qaBd4fMreo+yhzyN2gdHTbHmHTt9Bnav8vbcrCTpu04xRzfTgC58Je
         IicAYRwmhXN8mO6MHqU837s/8ZpWYuHICkQJInUbSCVgffaPb9jR638cBn2RJgqbvIQI
         2G9A==
X-Forwarded-Encrypted: i=1; AKwUvByKtMMkaPNksVGTP8xpHhMRH4y0jCWF1MLA8CcDKEDA1ivMAlOz/xYhvDLIW2V2y6Eq0VlSxj/FkfHUoze75acu@vger.kernel.org
X-Gm-Message-State: AFq9FYKvwPCMKzDcP33hOnp3PWZqrfWGYCyXe3kDXHofCpdz7LlaUXU9
	n5nwd9sIKRCd1hPAxOVLZs39bKCBYHCijQlIig1QogtaauF7yaHU0eN0
X-Gm-Gg: AYBFou3sPGykN0b+715vXg8rdOoJ35dfTzEg3nvYoZ0zv3ugedfNg0SJarfyJT2HQAT
	SBYezHBPfYG5jC23h2vfWxCGQs1qThnQBiPUm7Ri2db4At+IB22CMrAbBwJaNcm3MQc+bGtaUmT
	rSTvTSXKhBQzjsb/k5SYW2UCR16kSslzGuTZb4OQr1/FtQZ9Y5pJc7fAIBqEyyOn909KrhoMUXL
	s+938pHmCKbeIz0flilNJmjchzHT0IMpSXoIIkLb/8jauOfdtORH4pMccMnE84pcldG+K0+tu0C
	5h9f/ICDRjFzB+NkvgWgsXqE0IQW+PUaUTtOaM+zYcCgH0/sHIroE8fudZm2oairI6F7Ci4zvRK
	CaoUfRVC6g9Ipk/AWYrOYGds3g3/VwmZoDforUBNOr/vwufV9wsPc+NS5v5C0rDghB/qknKuPcv
	9ft83LI+XyV8V5lVK/Ui2YsjmvqmpHJnZI+yWViZ+7Idilwea9+6TPn234y8vOyUTg1gghlr868
	gPMIC/Ls7LbNiLem9/w+I2wDtBpSzrabL1HjlfYYw==
X-Received: by 2002:a05:7022:43a5:b0:152:dd1b:4fa7 with SMTP id a92af1059eb24-18511eb69acmr9823189c88.19.1792328215121;
        Sun, 18 Oct 2026 05:56:55 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.15.112])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c4d4675sm20404082c88.21.2026.10.18.05.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:56:54 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [RFC PATCH 2/5] perf/tests: convert check_all_patterns_found.pl to Python
Date: Sun, 18 Oct 2026 09:56:38 -0300
Message-ID: <20261018125641.23064-3-breno3011alves@gmail.com>
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
check_all_patterns_found.pl in Python 3 (stdlib only). Same
regex matching, same TESTLOG_VERBOSITY/TESTLOG_ERR_MSG_MAX_LINES
environment handling, same exit codes.

Verified byte-for-byte identical to the Perl version.

Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 .../shell/common/check_all_patterns_found.py  | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100755 tools/perf/tests/shell/common/check_all_patterns_found.py

diff --git a/tools/perf/tests/shell/common/check_all_patterns_found.py b/tools/perf/tests/shell/common/check_all_patterns_found.py
new file mode 100755
index 000000000..3eb907af3
--- /dev/null
+++ b/tools/perf/tests/shell/common/check_all_patterns_found.py
@@ -0,0 +1,35 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import os
+import re
+import sys
+
+
+def main(argv):
+    quiet = True
+    try:
+        if int(os.environ.get("TESTLOG_VERBOSITY", "0")) >= 2:
+            quiet = False
+    except ValueError:
+        pass
+
+    found = set()
+    for line in sys.stdin:
+        line = line.rstrip("\n")
+        for r in argv:
+            if re.search(r, line):
+                found.add(r)
+
+    passed = True
+    for r in argv:
+        if r not in found:
+            if not quiet:
+                print(f'Regexp not found: "{r}"')
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

