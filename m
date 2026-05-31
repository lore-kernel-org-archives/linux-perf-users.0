Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560BD346A0D
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 06:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780209497; cv=none; b=Q21tFlY7w0cgGAQGFhUtT1lbcHnd712dVMnuDJvLM39n7jdbxV0LKK6ZiUD8bv3AW3EEVfVRTfxrfs7Ii0uEHkwu5HIj/n9EWgs2AWmOzxrQRGR4dDvQE+Y+FlT2mPYHgPoa4wXnyqvpKTc9nwyw/jOEM+3OU8hygXYGixrXMg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780209497; c=relaxed/simple;
	bh=fceYlMYPSFIBhgKdtj2vldQcRO1z7pGUGyHIbbbwZFg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dJVCQllqx8CwENogcAXDNNuh/RKGPWwQPpUhwe9MMsOXXvEq8Iv095XiSzRwUB9lHxycQWI+Bg7/aCqaEf6kf/d4WqQmCx+X5mmXXF2tE9e6YFJeKa5qNYOc8R+0WCD+M6oKtQftMH35XzOm0tMc1jcw6VxvjvX64j1TRO5rArY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l/dx8BZT; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l/dx8BZT"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-135916eefa0so9644570c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 23:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780209496; x=1780814296; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5fWSS6pmKaXR3mc2oxOogwkg8pn144sIhxDOKYQ4GWI=;
        b=l/dx8BZTACeO++P/9cygnTEXbrhcw8rS6c8kukxAQSktum/idRS7bZ24BWm1jbf7xn
         MKw+mrd4yEn0638+O+1yz5YZod5UEtNMmCjxWDDlKRLSR5XM6QS3G6z6IBqSivvWDfcC
         yjG2uHQGMlHpCTNx+h8RLHaWoYCk/hI/Y5vhIdEDqFeEMfeCMHpTeJj3xPv0Exq5HpWQ
         2HOsHy0mJx6fRjh414/S3tCTHIUAFI/WmBGTo9UuUCy12aRDFqsB1yy6JApcWsxcrIKA
         b8IlRwssCBzpRQVgmdZLc+ycM8buuDG3N3/+J0XZP3NlPTh6Hr0vOXvEfXIjVhGhv39x
         030Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780209496; x=1780814296;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5fWSS6pmKaXR3mc2oxOogwkg8pn144sIhxDOKYQ4GWI=;
        b=DuHGHjyUPJzf1FQWx8ONPVxGqT063TKi6bKSTlp8mCy9Rr+rf+1FTpoPNe4cabFD1D
         r9ypCpKsR0TxmLD1ix24CpyNXHj/dyjuEya/ZyzWbL57hLwNZV8nF7FxEqINZOkmQbYq
         I5PUarBXi+8IVnNOcH/l8h/jtzz6gNn5yrFY+nEV9XTHzbW7eoUYrcDzqhx8Qdc9vm6A
         36+TLGxhW7ZAYg+sWapy12sNfoDdEESmFnlNcXfXYYmcAvgEqfYMbNxev8T7QfhKmTBH
         cpp1yf6gCINfh2tpyYJI8ZpCHnw4Q/66k4ppul2SySA/OuzTORjZAT3DmBMnDybEPifX
         28gw==
X-Forwarded-Encrypted: i=1; AFNElJ+X/mEUO79mNNsqvMWg2bFaZaS70yAtIRKlP2yHXUpARxI4nuO+ubv4GPH4UFQevh7jV5fZPTSHyPEVC1VmhXlo@vger.kernel.org
X-Gm-Message-State: AOJu0YzvT2C8p532JSC235jjT/atSQv7hKZVflANJQOIPAkeC2OEg5SO
	xJP2pIj+myzYZFQWPGM1xaabSYp5H3Dxzr/ilx69tX3b9avV06/wnO7/0UtDjw7WNhqYvF9MFjC
	3npP2jBPDtg==
X-Received: from dlan16-n1.prod.google.com ([2002:a05:7022:eb50:10b0:137:c9b:c045])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:981:b0:135:52d3:d9de
 with SMTP id a92af1059eb24-137d3f0cd3emr2865727c88.15.1780209495434; Sat, 30
 May 2026 23:38:15 -0700 (PDT)
Date: Sat, 30 May 2026 23:37:35 -0700
In-Reply-To: <20260531063736.871777-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531052740.796087-1-irogers@google.com> <20260531063736.871777-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531063736.871777-14-irogers@google.com>
Subject: [PATCH v3 13/14] perf test: Add shell test to validate JUnit XML
 reporting output
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Add a shell test script (test_test_junit_output.sh) to execute perf test
with the -j/--junit option and validate that the generated test report
complies perfectly with standard XML formatting using Python's ElementTree
XML parser.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../tests/shell/test_test_junit_output.sh     | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_test_junit_output.sh

diff --git a/tools/perf/tests/shell/test_test_junit_output.sh b/tools/perf/tests/shell/test_test_junit_output.sh
new file mode 100755
index 000000000000..5104ac1e1e6d
--- /dev/null
+++ b/tools/perf/tests/shell/test_test_junit_output.sh
@@ -0,0 +1,63 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# perf test junit XML output validation
+
+set -e
+
+err=0
+
+shelldir=$(dirname "$0")
+# shellcheck source=lib/setup_python.sh
+. "${shelldir}"/lib/setup_python.sh
+
+result=$(mktemp /tmp/__perf_test.output.xml.XXXXX)
+
+cleanup()
+{
+	rm -f "${result}"
+	trap - exit term int
+}
+
+trap_cleanup()
+{
+	echo "Unexpected signal in ${FUNCNAME[1]}"
+	cleanup
+	exit 1
+}
+trap trap_cleanup exit term int
+
+test_junit_output()
+{
+	echo "Testing perf test JUnit XML output command"
+	perf test -v -j"$result" util || true
+	if [ -s "$result" ] ; then
+		echo "perf test JUnit XML output command [SUCCESS]"
+	else
+		echo "perf test JUnit XML output command [FAILED]"
+		err=1
+	fi
+}
+
+validate_xml_format()
+{
+	echo "Validating perf test converted JUnit XML file"
+	if [ -f "$result" ] ; then
+		if $PYTHON -c \
+		    "import xml.etree.ElementTree as ET; ET.parse('$result')" \
+		    >/dev/null 2>&1 ; then
+			echo "The file contains valid XML format [SUCCESS]"
+		else
+			echo "The file does not contain valid XML format [FAILED]"
+			err=1
+		fi
+	else
+		echo "File not found [FAILED]"
+		err=1
+	fi
+}
+
+test_junit_output
+validate_xml_format
+
+cleanup
+exit ${err}
-- 
2.54.0.823.g6e5bcc1fc9-goog

