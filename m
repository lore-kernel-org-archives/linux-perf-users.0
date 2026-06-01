Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFFD363C72
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 06:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294520; cv=none; b=pcddrTyF/cLxJuxh3mCjQiLu42WFitWkY1rxcMYQtclhK2cgvnsidnIVb+wUhH9fYQ2a3QSPmLCGeojlBtTqe8zqHb8QmsxTz2Gxb8VcQho5VHn2GbqY8yGE9xA0HtUTwauLjGE3jNRePXEm8KU3oEOadMCQ4FZVOdLPNufsWNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294520; c=relaxed/simple;
	bh=fceYlMYPSFIBhgKdtj2vldQcRO1z7pGUGyHIbbbwZFg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EWAia9fBJ9sQfmm4SwkWS5N/H8al7fNtoD8KUwPiPbHsbTqqUkKTuyBVgl3EuB6/BXvM7l4B9aunCuiSDtVgOffWPhINmaGQ7y2I03hNlCodsbkGrrM71ECecFa9IR67qHi/FJjy0PEE4r1v1vCjB9KUCm9OBDCk4BJr++Hx/u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jHh4CwEX; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jHh4CwEX"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137e32a2facso2130297c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 23:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780294517; x=1780899317; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5fWSS6pmKaXR3mc2oxOogwkg8pn144sIhxDOKYQ4GWI=;
        b=jHh4CwEXKJZuj/1saQDTTKmRFbCUtaCx2F1fzCB9yVeJijPzlEnecG6dhAf3yWY7kJ
         GhtFjkMP9F282WdRK2s+PaIqquorT+SBC1sxzarOB69zwxgSrpef9Htr81Ly8Ib1aPBy
         0GpTZAoI4nayM+BrwBQ6btRzg2c43GZBAQN7wo/yM9mIFgEfvEGozzE1LpEgojJzhW5H
         42aziTO9lUva46rAkrzD5ZXrfO9K/vCSuBWRBpNlz+FPqlImrRUuy9IqLLfn5S8I/wdh
         /PDHNwYo0sri+QXrOFct5VgjFlGMC1oRva/2qnachSUiAXNz6nDVPziob8NCTsIR1Gau
         ylWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780294517; x=1780899317;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5fWSS6pmKaXR3mc2oxOogwkg8pn144sIhxDOKYQ4GWI=;
        b=SyCwEpFvbbBlGpfzjM6Sbbjf6DCDy6wLJEngGOGas9rEeEFU9qoa3Y4NHAG/sWSQdY
         6wooIAdWn0yN3e6Rmaq+o/BwDb9Z8urNEG7X/kMpUNTSIL0m+upMIC6a6wKfuSahEvej
         wHUI7uzLNlrax/cyZRqhW4zOgrdRl1tvzWhCT/TxnpgzPObrx9VpRfHMQPwtDEjdm7Mm
         7nTzwPIqAg2nCY6bF4Cd0nUi8LVOWZz6+IquoleroGa+FiFjm6ubPZgnBORNtfpsZn5X
         QWCappznm7z5k/o4sjxvRGnSFvfgFJTebY30i/d7nNJt6oFEOMj9dwHQqqzm8OhJNH0V
         wBTA==
X-Forwarded-Encrypted: i=1; AFNElJ/rJS1U90V3WFHnOT8CXwUZOzGp0QOS8P9P/1xST9Qj0Z10YUqGPt4DxSSw5Co6mjcY13+Aj+of3Mj3ofqCk7hx@vger.kernel.org
X-Gm-Message-State: AOJu0YxlhpNpjh+IqF0si/Sz2HcxdPfwLTppwUZozYEVVCI+FoI4C8YL
	qXNV8p3T3++4sp2vir+CqtNWxQaXJK5pMG0YReuATzRNPyyWp5IedVhRilwus+C6+mG/nEWpfAp
	3flm/9yp9YA==
X-Received: from dlbbo37.prod.google.com ([2002:a05:7022:43a5:b0:135:d0cf:93de])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ec0c:b0:12d:ceaf:ffcc
 with SMTP id a92af1059eb24-137d3d096e1mr4063413c88.5.1780294516548; Sun, 31
 May 2026 23:15:16 -0700 (PDT)
Date: Sun, 31 May 2026 23:14:00 -0700
In-Reply-To: <20260601061401.1541457-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601000548.1195604-1-irogers@google.com> <20260601061401.1541457-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601061401.1541457-15-irogers@google.com>
Subject: [PATCH 14/15] perf test: Add shell test to validate JUnit XML
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

