Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D234A2622
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792328223; cv=none; b=Bod+okDIulj6beA4obWfINPdmUWJ2WTp2GR2LAfiZ9BmSRPZ23szQv5XeI26jcTiFH1THbkotmkZd6EsNwPXwh/aAgmj3cVtSNyEpT/RceQtUGjwcPnYXZEp6yFmSDY8BpqilQlTK57YTLOSW1pMPpshHUDzESy7Vi8NT2Pft7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792328223; c=relaxed/simple;
	bh=3NqF9oFx556ARlbLAjVMnfvI/bYH2vz25WwpKD5JYVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqSg0LzwEhAgFXmYD45AZZ5GYGZPfcdDeJwuQOOOd83PWrSMf3VBoMa0POxId3dOjeBv82B9yUMXehh7tK6okOfRtiJ9LtMd7EZOeewK3rQlizDLbVl0sR/HizcIUbgBYUtL4kxR1AqCFBlPf7zvKmetDEWlVo/cQmOvhXJe3WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6ylTl7I; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6ylTl7I"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3514b90bb89so3244513eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 05:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792328221; x=1792933021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vpCU0lBJpwjrApwyscimeM9CzakmAtWJtSfSGNyY77w=;
        b=d6ylTl7I2Dctsnab5bO0cSr2/qh8TBPcuLl+T/UPSkkeB89cojFkHP5NUmkQHnJdle
         jbEGtfBJJvfbP3FVYYl0pV2rfR03bVopn6BFYCSdLhIr7XyO2ItX44lbHUblFtcfV6Bc
         0ui4+JaD3ZZvacfP83ymmz2m5Ozc03kbXzuGL2C3XcsRBhioxB3M/SI/1p0d6rG+GflT
         pNVU31NJXacvSJ/GVAAUzJen51TlNWqdr2JiaRX51wPqw3T3wVLpKyKC5vo4RFedguNT
         CGPRlkd7VV539tz6lVC4E6vOQKCn+hmL6mr0ZGraINEMEFAEX26mUiuwD9gLaPAqHZp0
         oXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792328221; x=1792933021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vpCU0lBJpwjrApwyscimeM9CzakmAtWJtSfSGNyY77w=;
        b=EJwv9YM/Eztln1EargZKGtrMBkkllgHWL69Hwy7+OtU/ShPtltz1Rm9DYQ40/r8SOg
         nAKFea38Ei4MI553bM8b7UAzKD15oEMQ/8iOxYg6PWxs+/qjtAJBaWLnjuPOBHL0muFX
         XzDQ6DPdl6WgOwFrz9NahOKhi1GZ1xuxnBGvg9a82vbLH07cG9B2rp2UbBtUj3jIIpkS
         XnOgR6fY4BE+tiXVJOZFy2BXyly9S6ox9uWt3fmX44l1vtojgA4t99LEZOjlFZ8EQSJm
         7a06QpKK3WcspfK34ehPAMw7j1v2THCEI+cVsTq2ZILXEkrhlqqOBDfWL6aLGy/qN9Yk
         Uq6g==
X-Forwarded-Encrypted: i=1; AKwUvBw2jnO4EPTagynYnjKHIS7p6lCLNokhIBZwUAbpXrNzlYSO626Aa9Qfh8lDnKru/R+YKKl0htPtRUWeKQCEzwWA@vger.kernel.org
X-Gm-Message-State: AFq9FYJYExf4+gWvkDAQ7ZmLjH7bk3xj37dvvkd26FrkOC6KLjwRJXWg
	bs4rKATdPSB4A1icJCc+aFXC76yoOlSA0Ysmlr2cfGL6WMeLBBog843Z
X-Gm-Gg: AYBFou1N42GHhHNeqsxpFLQvhWnisuixK3hJobDtQHCf/rLteh3P3sLxw0B/Cq63D6+
	YGJGOfvA5IVDeA3jj7aSakNGVMdG0taH7DJvT9pr/NlBckdBi9OCReb47B87tYQpeCHPJmHsrEl
	Asrcvs7BnTgptkQ01NldmzmYMdpDkI+VNvYcehXCFUdcrw6a7MuyW/JykxfyWA6M2gsM0wDRkoY
	/XEmkhLMR6F6DOd5co6ztMlUrLDN/T0aS2ooisl9iMAkX7aTGZaMLXSP1d6smHjqjMVncWA/Zvw
	ZP3PJZEZVhyuiKlUno77Nldtrx+if6yLcbquiKW8tvuUwNKZ289WODrkj4fHOvdL2eUuwsSFa1j
	QFdaXZ7wN7c4fmFr/2TtbfHUaqtbf37/MGfAKY/kIjk6Zg3yG7sfDDbYjJEKnGjQdSIEQRe6vW4
	OACjHyMeP2PhlHwXguKw7nmgtiR8VN97XLiF/LTWDe8braAEtHUL/vT9d1f5Bx1C0fDLDhz7Map
	uBM66s+qKNBgdGYk78h7BbVeJIdtlpDNxbEbIuVrEsSKK0XUB0076cAcrJgZXeCCGbenuDWnjT1
	4MgaBDu2gyixexIWnRxUpA0=
X-Received: by 2002:a05:7022:1709:b0:144:fc5b:2121 with SMTP id a92af1059eb24-1851257915bmr5595386c88.17.1792328220803;
        Sun, 18 Oct 2026 05:57:00 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.15.112])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c4d4675sm20404082c88.21.2026.10.18.05.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:57:00 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [RFC PATCH 4/5] perf/tests: convert check_all_lines_matched.pl to Python
Date: Sun, 18 Oct 2026 09:56:40 -0300
Message-ID: <20261018125641.23064-5-breno3011alves@gmail.com>
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
check_all_lines_matched.pl in Python 3 (stdlib only). Same
regex matching, same environment handling, same exit codes.

Verified byte-for-byte identical to the Perl version.

Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 .../shell/common/check_all_lines_matched.py   | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100755 tools/perf/tests/shell/common/check_all_lines_matched.py

diff --git a/tools/perf/tests/shell/common/check_all_lines_matched.py b/tools/perf/tests/shell/common/check_all_lines_matched.py
new file mode 100755
index 000000000..352a56d8b
--- /dev/null
+++ b/tools/perf/tests/shell/common/check_all_lines_matched.py
@@ -0,0 +1,45 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import os
+import re
+import sys
+
+
+def main(argv):
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
+        for r in argv:
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

