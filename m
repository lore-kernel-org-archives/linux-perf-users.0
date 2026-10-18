Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323F04A2617
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792328220; cv=none; b=c1M065E84/r1obsTQp68UxPO3KQO2Cc7ANZH7ImDA502pRqFgz/kajrLtbtql2KpjmAJiucdDX/UKajtXxZnUP6WtjggWehTQE2LIIY3nr5cx+Jx1cQi1vh6ESd9IbwZKKN32PKwpoVZQhUVjyI1We+KGOGKWt716j+9vvJF1Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792328220; c=relaxed/simple;
	bh=fGeuiXoT6xfJG+i1Q7CVs1QkQR99sQEgvsl5cYIXtGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PtleJVQSDUgbrCecZMoYG33PzX+QSvR6IzvEvTrClyc1JCh0qxAIzOCyKcPOPtflABZ0Wz5wQrfHxu5pqZPtP0nYbFSNAON3MqiMoGdVua78/f79OCLna3cvOQr2Ywbl/WBy8kA0DBysnw0QYBGvk+txJrhLl4BkuiM9yCyObfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwTxB8Ib; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwTxB8Ib"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15354aa70e8so867931c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 05:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792328218; x=1792933018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=35zLSPgPljkvq7HeoKghafYVUm5JrdIxwci7K3QcKT8=;
        b=ZwTxB8IbH1a7pRx0svBvrSByCoJLD/UioBRo7HqbSF0/LkXuHhL+gCbBcwnJyDmGbN
         UWXbwB+WEXKr5La+nrh/fKBeO9e/iT3ZRIojcEXEfRNtKqlLr+O7AbApqzLxGDKRwm91
         8QYwhSYU93sZ5tYUPvbf4HL4Wssf7dCIFfUKWcuuDPk4wHc9aIQEZ7IvW0E8z5kUD7zj
         waaeu30/PW34nO8RxpYsmYJMp40Z65AmeyscylJGNp7Uo7N6w2EbO7Mw9snmaZNYmpdf
         Eec3dZnm5LaKd1uyTqgyGbBpri3mIgJqnxJRAzDwjAp+7TbRihAKco5koUSQ/VN8u8wW
         4SQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792328218; x=1792933018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=35zLSPgPljkvq7HeoKghafYVUm5JrdIxwci7K3QcKT8=;
        b=dfPkQqRhAH+3y1IlR2AmWTU9EijWChVDmCkUSjFHsiWJHLpzf4nZgaY5tPyDNnCqn2
         Q6D6vAne25D4qEb/894MXSgpL4Ol7BewK2T0yv5BgHYKd7w7MZTRGqI72qMh/bzzttX+
         FTJ0fMG/4t7v2lmgyxqiqqR4IGlzDngTs370CNIhTT3NZ/GOtZIhIYs39ORULKeOUGFf
         Qnq6EiWkqMjNK/JPcnFtFO9VYm7OJHrYAj8w3rEVLSrfsnbzJkwVmFoIMPuQnQ1idjn0
         i/7r8WXJ9O1aADVxqpGA17syeoYQabUlO5of1pZ+x6aAJpXj/68KQv4gn9KHF5opovYo
         2MqA==
X-Forwarded-Encrypted: i=1; AKwUvBwsK0sT7TPehxbIIaAlv1lkvFVcLAv8rxyH0gjyKtnZ5J5rOU5qYjt/espvZq51MzVnc1wBqgM70ZCxkyagu/G6@vger.kernel.org
X-Gm-Message-State: AFq9FYLgrrdr3xz0eCLi4UDnnNB7nWCt8UqQQOhWBKuMbjCLTrQ9h9lW
	Om32Uf7VuXl6itvJNDDZLoKMsfaInlkU8uVN0aKlozlACUK7TEwz1gs/
X-Gm-Gg: AYBFou2N+3SQfXQrec70toAOIbhtsW1wk+fpWNsou1mtIa1WhrkRJh5EsKpCtXc8GW2
	LSdSONkNV/by47xfEdTXLHEIlFtIlnnPF1f21xjlRMfOUcDRZUY0alNBgeXw6Ozz4KsJLv0/+I1
	A72/hnYaTKox2bOW4QOW6KuaOPeeIMOsp5nM1cYMRA1mQZlYOcDGJ+suiH5OMPtyDbmDGb3y7Aa
	E0dQpjXSOAuotOs525f9pc+2uyXOqRPHJBvujGwcdISlFnrO/mpQOGOYWi3KZoVzfY4LRYYY5S/
	puUWuE7IumiZ5XVbC9Pd0UhI/5hlKLC7DTzpNPyZZ4hmRD8U865IFNIRRzbRheZVa+UeRBrFRJC
	8m0sMZyL3cpv6U6qLh/jR7w5IAiG15sKM43rf8W8NLxigYOdE7cZxRaglr2rKmdoq1z5HWndXlD
	/EzevW9l0ZHx1dVqxCrsbPNfmGeNOXDmINcrB+70T6lEnFV2jCQfmxSW4d25f6OZGvOzvuABlt2
	cIupXDNDRtyax0eFFxASvekX/bP53Ka7O8nmeKW6hB1nR0+TGZziTxyns0uc2pzsyxpp7SfrOa3
	/AhNVKfunGRVlR3Zfm3uZyk=
X-Received: by 2002:a05:701b:424d:10b0:13b:4ab5:41d7 with SMTP id a92af1059eb24-1850c9cf427mr8398805c88.3.1792328218029;
        Sun, 18 Oct 2026 05:56:58 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.15.112])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c4d4675sm20404082c88.21.2026.10.18.05.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:56:57 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [RFC PATCH 3/5] perf/tests: convert check_no_patterns_found.pl to Python
Date: Sun, 18 Oct 2026 09:56:39 -0300
Message-ID: <20261018125641.23064-4-breno3011alves@gmail.com>
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
check_no_patterns_found.pl in Python 3 (stdlib only). Same
regex matching, same environment handling, same exit codes.

Verified byte-for-byte identical to the Perl version.

Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 .../shell/common/check_no_patterns_found.py   | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100755 tools/perf/tests/shell/common/check_no_patterns_found.py

diff --git a/tools/perf/tests/shell/common/check_no_patterns_found.py b/tools/perf/tests/shell/common/check_no_patterns_found.py
new file mode 100755
index 000000000..0e5d931b9
--- /dev/null
+++ b/tools/perf/tests/shell/common/check_no_patterns_found.py
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
+        if r in found:
+            if not quiet:
+                print(f'Regexp found: "{r}"')
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

