Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A743CAA41
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 23:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713533; cv=none; b=GO69nMfW7fr9yqlU5oDGD+ddQAlCui1AMspp0w9cKA/Op7XmMCQMplYhE/RMpEMPPVkIls5G4OFcMj//wJ2Ou5W+7pFm6+tig15NKVAJPVaQ1TKDQJZjLfzJqjFyPKbi/qR7086bIEDwVKM899BXzYW7+cZ0zeoBEc3oVDUd1Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713533; c=relaxed/simple;
	bh=9OkQDl23bimH1GeJjjYpmxfP1iJdl4iH/3AtMuKdf+8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BjGU8xShfCWSNG3Th+xQ9ISSLgqsgjDE5mTotgzhRUssegBUr6rs6EQ5qBnb3ExPt9YM+QclNr2oWlCtlDW4NUXq2DfjVrhQEUH3IsgmPiVawpz+X64Akr+ZkIjYcyQpzr4fohF4At+ZgxLdH4F9fk6QvUCpoSaWnYLYgREVqvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nZw/alGo; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nZw/alGo"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2f3ec2e8d07so2770329eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 16:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778713531; x=1779318331; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W6EEmQu3f/LCHgjY+5n32kItKMHpsGhtgiKuv28rVd4=;
        b=nZw/alGo6O2uMbRdvRPTG6g3t7M2GTA9hGpzulPqcOdXWg411nz3S4XR2LczYRppAN
         txN94ryHhY49biFRPDYMJDl8gIMhOkrJZIG+PnqJqvRCZaUDai5IgtUVTyS19fXXi0zY
         XBBlohnsdCC5KArZ7y/b4m1Wl1jHJaOzN9dtvtwSf0fuQNVlZ1oiCKpeRwyrfCLDE6TU
         Y8cHFi9bM+bl/5xNAlRtJSilvFFVy+3DENPsvcyBGedIGuV7J/T5kIJ0vNF4Jnap+CcF
         UIcySZiTurGr3VotQZ3sgEPBjDV8ugp0jxoIRkjG1xdOMTSP8V3iXZqjs3PzGevNaqhS
         anaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778713531; x=1779318331;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6EEmQu3f/LCHgjY+5n32kItKMHpsGhtgiKuv28rVd4=;
        b=PKTtOzw5AKIUSIZoYd9lmoZHEgT4sT/ZH/7KokMvqYmn/5QAG0EbAl3m3LzRCgBKqV
         Ejl1e7a2Me8SPioRsgzkh9fD/ScsfCVp/YePKxTmPZYJXi7TOyAUrZ9jg3ELWC/jpH9w
         OyLmOYhEKtK87KuoFO2Aw9xHgCH37DVLUuavq9vhByOGzXJeJ9znlRjHCzVcfMNnx+go
         KycRrhfsGLd3SmyNkRMB9W79W2d+ajkk3MznDHQAjDX7lBnd6FC7o/AH6ofaDNb3CDEQ
         FEP/DkWGwIJ2nICTgDbuoxOUNzTIDq+OfrJpIa/6TeOjJ8NKaJomuxUBEdeeXRKDnHBi
         1XnQ==
X-Forwarded-Encrypted: i=1; AFNElJ9A6diRWIXiMTpswptIi26mH3yE/Vt9fxWAkAV9e4ayh6TUBcAd1XM+HM/XdZpZHmLAjc1JGK0Kpi/0oXvR4H8o@vger.kernel.org
X-Gm-Message-State: AOJu0YwXvT6dYKHGLE6FvgPIDw7e09D9426yW8VB8A+0+I+vF+FAPVEk
	AzmO5tC35qI4fysRaWBzRTLaKanTPajCU5YK65CAYDiDjyTckneHTBXxHSOu3dxrPlNJhFMwhPY
	Uwspm0DNf/g==
X-Received: from dycno7.prod.google.com ([2002:a05:7301:1447:b0:2d9:3c6b:a26b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a986:b0:2c1:6676:5ebd
 with SMTP id 5a478bee46e88-3011758698cmr3269151eec.10.1778713530512; Wed, 13
 May 2026 16:05:30 -0700 (PDT)
Date: Wed, 13 May 2026 16:04:49 -0700
In-Reply-To: <20260513230450.529380-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513230450.529380-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513230450.529380-14-irogers@google.com>
Subject: [PATCH v1 13/14] perf test: Add shell test to validate JUnit XML
 reporting output
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
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
2.54.0.563.g4f69b47b94-goog

