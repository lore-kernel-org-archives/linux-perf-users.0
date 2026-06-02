Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2C93FF8BC
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422152; cv=none; b=tA4AZJIAvZauX8qaKfbhl37rdNWD/NNX2mRQJKfJB0822z2+tzDC6SQyzD10071/KPJvxl1Rqaa4o5+UqnsckyLnOe/30fi4D5QJkK+SK852kUVMbDs2ql91E5moNHq33DfSItu1X9fU/mkeKoCojzGDyPXHNwRfmZBqIFAF3u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422152; c=relaxed/simple;
	bh=RDPpztvQRM3RZ+daGhsg3EoXAZWHqihVYgUsRCU+FAA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BdSK9L0Oy7v1OEcGBgmTpscGJ9MTShTRB6xJlyBUNequCkJfqHobOAUtBgdv7IGryncTHsRu1FSVHuhacRv/vs2uIqCL/van7tRT7CnAacdeabxjEJ1D4Atj8FTC65+S5WrgK6HgmTu9w3J1SNix14/FPVNYIg+K4vMB+8+dnAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uH1dLNHA; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uH1dLNHA"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304f1820babso5567165eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 10:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780422150; x=1781026950; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XUbX/B067uq070YwFDLx4Fbydp30JsyYtkHKJ5q3D4M=;
        b=uH1dLNHAC/A5W3HRqdnNxh2PPPOZLQC45nSZZJ4B/TIALb64jxNfE3rXj9al32IIYn
         P7kg2GMaFpWfo6bUugWehbWUTEbvFI0ySAgWrzS1VoJV66EcG2UZasgh/UOeo223/A3t
         n0Dz90oDptkNKjATbAmfP3llEcnNL1T/14XPzYyZPch70Tyhl9epw8O5dyLC9GewldkZ
         Xz+fuRSj5iFyYqC1n34cMREwtsYrdT9PZ6hb+pxaNo0VbstoJynj9L4xTVVoxbO0+GK4
         iItfS8JSyY+QAEhuI+OmELmcEPrcgk3nxcz6zEqCcTEWGZWZtfYDEL5qBcIkcCBgVnqX
         Wavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780422150; x=1781026950;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XUbX/B067uq070YwFDLx4Fbydp30JsyYtkHKJ5q3D4M=;
        b=kr3mP9EhxG9X1SzbiU3EzOpl0fj6nF3u9k1Yagu9dTAC73y2KCchIqfPO2sFgEverr
         4Hed1n5EEzoRhQOhsTZTKHolk+B+AcXYAOY2kLyfcPVtwlqyCAyqM6XFUmpOQiQ9UVCs
         H6BU3y/IaZZ+MSiFIlfFkquDymasA98TYlY8RTJ15xuyUg1Xtb0d/X9LtnES0A7nrYxg
         giy32v+886Yr3+/UYmdq87IEusCGgtsRvb/yAM3ZxKuIedscEUS30346Txz59RyQQlMl
         S+mNyMnK94auaU7QRue/dWexJqmGC5cEy9QK2SfIf6u7+g9aNo9D95gyYbpwz8yFZF7b
         iugA==
X-Forwarded-Encrypted: i=1; AFNElJ/BtkMtKbZQsH51L/sptxfn7yll4pmZleb/EvGQ2NItKzS5s8j6HBGdfe9eempsydbyEhGwjzDQarykmMxIOfH9@vger.kernel.org
X-Gm-Message-State: AOJu0YyuMiEoMgSnW7yOBKIwniBaA6LbqZQxyt3F8BB1cQK76VvS9BzC
	kBdcwFGZJJvL+a04ZmMTn5IVe3p1hvcP4DdmI/gcPClvsnLd+RUcz4i5RKNeurhQcFq+46nsCZ0
	fNdqAzatpJA==
X-Received: from dlbbz12.prod.google.com ([2002:a05:7022:238c:b0:137:f11d:50db])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e24:b0:135:dd7c:7
 with SMTP id a92af1059eb24-137d4294ec9mr7395080c88.38.1780422149796; Tue, 02
 Jun 2026 10:42:29 -0700 (PDT)
Date: Tue,  2 Jun 2026 10:41:26 -0700
In-Reply-To: <20260602174129.3192312-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602073132.2653307-1-irogers@google.com> <20260602174129.3192312-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602174129.3192312-16-irogers@google.com>
Subject: [PATCH v8 15/18] perf test: Add shell test to validate JUnit XML
 reporting output
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Add a shell test script (test_test_junit_output.sh) to execute perf test
with the -j/--junit option and validate that the generated test report
complies perfectly with standard XML formatting using Python's
ElementTree XML parser.

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
2.54.0.1013.g208068f2d8-goog

